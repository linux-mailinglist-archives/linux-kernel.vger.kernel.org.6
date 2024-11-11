Return-Path: <linux-kernel+bounces-404367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3719C42E9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 048641F23869
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0901A3BDA;
	Mon, 11 Nov 2024 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mu0BBmkn"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3D01A3020;
	Mon, 11 Nov 2024 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731343589; cv=none; b=Aqn/HPcDayEJKzybTBr/e/MHv5sRVMY/NstcTkwU5YoabueLTgggGScL9Gi/yvZnbjL6Nn1h6RCojk3TLmvuIw6vdBbpS2KTM9Dd92JXynwHWYN1WwwEz7OTa22qhxY3nXv3xjKXqQ9F1S7+TCm/RFkZMp8ifMVL8BQm7AIYprs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731343589; c=relaxed/simple;
	bh=9EPi3XijBpqH4W1IfrMVIREiWuiI6+Jc+I7ZH8wPkYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DH5Au1VIwcGqPEUmoBhKsIzqrXeT4kwWCctJZSGrSa+1J+e7VvehhQdwTeROq0idgpgeTeBx5u9TsCH0wMo1OWlZ9qBSO5nR2KllxvdvA0FFpPHtkWcv9Um5n5Hnu7X8HONjn+dSnOvDP8blRYMLODJ78rI9y68ARgWPIaIFyrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mu0BBmkn; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6cbd1ae26a6so34839186d6.1;
        Mon, 11 Nov 2024 08:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731343586; x=1731948386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gSEyXzHuQnJ2v6aB4N51WJ4Cwj088/JQkZOXGtq6l3M=;
        b=mu0BBmknlC8iMkmgABCacleflnOWzIdsiJuH8B0LaFb+NzrfIUpKK9fRoDTc5cdrwi
         bDqs4807XzEpeWa3e+gXNINwWYJlAwLa2F2McRlk/9brPn6re31lop8uwz/mr4fCtqDY
         bsgaKnN/MwVOPCpW3NY7WBkyC+Qa8fAsopfcFLcJjpjlMJbXyVbfbVjCsb8jMpOCBWVQ
         LJBu8Tx8r9sI3nI/qmxNwNY96PxdBUyQcMgYa0mdz/saF8MYbDN8MVMTu/vqk4o41X46
         qXPR5Jv2GMOk+LtcPrKxZGvvJ+BIaPTZny6wwJAaRAAhaNyFLWOypSkTVlN+iENtasnR
         tP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731343586; x=1731948386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gSEyXzHuQnJ2v6aB4N51WJ4Cwj088/JQkZOXGtq6l3M=;
        b=nWn4B2nfW4G4FuV2ioMAddQJUE6ht9khCW7mdMAbJ2LMhhUFPnA+19YNRqypjt+A9V
         6HjHcnhstBSp/5KnBH/hOOJDujOtJhnwoMqi5kO570xdIPU4luS/WoVaIthJ2nt5pglU
         AqOO0BCsB9BpkJZWn4ehvYw5Ru3JTF/yngPOkhiE7cDL/e+THIEzBQkb4s2lDhixhz70
         AwjR0/87LsUObFmoMY0jqDTzJU5hMvZRMtin9UkETI5d7g8EfL4JSiDp7AlYVJhPcIHh
         twLMKcV3q4xvEjjmCIn0+gPPxtkaMtGpjfAoqnq8hCJklMs+IldQa//31aO00CT4aCX7
         NWKg==
X-Forwarded-Encrypted: i=1; AJvYcCUP6/q6G1PM4zhl8YM3Wj6SUAI77qp9BqjVp2p8tCQ3iJSYbzTregu+/6w8E8YIpctc5ti9mNryle1F7qk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUp2zDJV6y/lB6/mwAdB9bjDfHMR2D/jjKrDEY0Key0meFwOsu
	QwaAhR/UErNDFltara6gmLstbzsViC7AWDSN8a6BwRvcIGXRmfavZeA9p0D5
X-Google-Smtp-Source: AGHT+IFABpYpARiQ/rHIj9A6PhnoCzhB8oFaDClsCHkRkzXcI9LguImbkjyq+DAsgldkQIi/5uAAWg==
X-Received: by 2002:a05:6214:3d05:b0:6cc:42c:feb with SMTP id 6a1803df08f44-6d39e109443mr193404066d6.2.1731343586300;
        Mon, 11 Nov 2024 08:46:26 -0800 (PST)
Received: from eryk-arch.local (217-180-201-42.lxtnkyaa.metronetinc.net. [217.180.201.42])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6d39643b9a3sm61749126d6.93.2024.11.11.08.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 08:46:25 -0800 (PST)
From: Eryk Zagorski <erykzagorski@gmail.com>
To: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tiwai@suse.com,
	soyjuanarbol@gmail.com,
	erykzagorski@gmail.com
Subject: [PATCH] ALSA: usb-audio: Fix Yamaha P-125 Quirk Entry
Date: Mon, 11 Nov 2024 11:45:21 -0500
Message-ID: <20241111164520.9079-2-erykzagorski@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch switches the P-125 quirk entry to use a composite quirk as the
P-125 supplies both MIDI and Audio like many of the other Yamaha
keyboards

Signed-off-by: Eryk Zagorski <erykzagorski@gmail.com>
---
 sound/usb/quirks-table.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 24c981c9b240..199d0603cf8e 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -324,7 +324,6 @@ YAMAHA_DEVICE(0x105a, NULL),
 YAMAHA_DEVICE(0x105b, NULL),
 YAMAHA_DEVICE(0x105c, NULL),
 YAMAHA_DEVICE(0x105d, NULL),
-YAMAHA_DEVICE(0x1718, "P-125"),
 {
 	USB_DEVICE(0x0499, 0x1503),
 	QUIRK_DRIVER_INFO {
@@ -391,6 +390,19 @@ YAMAHA_DEVICE(0x1718, "P-125"),
 		}
 	}
 },
+{
+	USB_DEVICE(0x0499, 0x1718),
+	QUIRK_DRIVER_INFO {
+		/* .vendor_name = "Yamaha", */
+		/* .product_name = "P-125", */
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_STANDARD_AUDIO(1) },
+			{ QUIRK_DATA_STANDARD_AUDIO(2) },
+			{ QUIRK_DATA_MIDI_YAMAHA(3) },
+			QUIRK_COMPOSITE_END
+		}
+	}
+},
 YAMAHA_DEVICE(0x2000, "DGP-7"),
 YAMAHA_DEVICE(0x2001, "DGP-5"),
 YAMAHA_DEVICE(0x2002, NULL),
-- 
2.47.0


