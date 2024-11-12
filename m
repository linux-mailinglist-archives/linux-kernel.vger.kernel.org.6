Return-Path: <linux-kernel+bounces-406219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EF19C5CC5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6240B370BA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7E920263E;
	Tue, 12 Nov 2024 15:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czW7ScnC"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4C52022E2;
	Tue, 12 Nov 2024 15:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731426506; cv=none; b=emmoSEmwjs1tzd5TKRxt49aBBT0S9EX8wyQhA5lZA4hyMAoHoUena6RPR02Pn59znQVrt9W9FnaxDxf5dPyEAW2YReTS5f83S/zcWJ3FFdFaRLZy8A7wFTw/121KoOC2bjruGUuCol94XyLH90oYbPF8hRgqPwbt0vPe/0J4A4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731426506; c=relaxed/simple;
	bh=sofabjbV5hbD1jGxo7ToLfuWm78lBTWXYMqZ+ZuRwNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XBfPIzDqiL+fOGdHrF2aRqMO8ryF/vCSOtSv38L/rzMgEEiD5kM30bkNf+BOGDRBxtfB1VfvFu8vU74S5Wvt/uT/mvWQBSi17ay2ixI79Q/0+obo5pqEGtMK/BgTXuk9YKeCzGCnluU9vO2VfYBq5hdl09q5tY9azgFz3xqiLCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czW7ScnC; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c941623a5aso12089816a12.0;
        Tue, 12 Nov 2024 07:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731426503; x=1732031303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J4vvY1hPm4dTwPOX+kLodHdGH7RV8ksGGnHOHxIfjP0=;
        b=czW7ScnCPGZU87qGM2UYF411QcQ/7Ch+CaAshh4bvOpo7pY0bdTfc8gClQf1EAGeTp
         QW9dr2J6Yutqi5EyFwbD3lEuwFJrxcCP2blsHDI2JGh+KZ3jmjabs+126YByHYiZE+th
         Teyi/tRrnODE99QUugIaMscGikc1/QITv2at163KAQtYlv3B48XA3b2/TlsV/+oJyvQw
         uxQ6P4X42sW5noRhJmOMy31y/lD8PTiv2VC2YMrHLG8UilsGSDs07buQOyWhMmzESOjk
         o8lf3uYjaGXmbk+EwbMM9q9HXLMfD0YgbWRxYCBZKairu8uX00h1DU6RWdoo95n/+N8O
         pDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731426503; x=1732031303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4vvY1hPm4dTwPOX+kLodHdGH7RV8ksGGnHOHxIfjP0=;
        b=MrjK4EgJBxGGVx3DyE3prPSA/oy9M87S/aPMsZm5LkOfHHfwFlQd8/5mK/n4VfYyMH
         nLNAbfOBYJEGnw/wQWt+grnUndljKfvk0E+095NRVXbM2mx2FRoePUbgMe1Oedq2QbER
         qO/gCPu3li7NSEhxdK5OJ//HN8Q/0lge66fuTpX5ho9YLhCwWal3MZmblOywKXI+Ln5I
         S9teOyyerlJInTxNpJg2z0wNaixdZ7PjmXlydzyu60Oh/7CCOXAZ72qCHeJ/D4adafQG
         mWU8KQOXQux8CI1VqZuftU1aZKIFE2aHX28Mnw0oqKoIB73kKHnXxTKbypcywdVYkEia
         1Alg==
X-Forwarded-Encrypted: i=1; AJvYcCWP5SuXPxZ1qMW4jF3Y527ziqsC5y2VGV063H3QbfUo93TjLZoHIAEPm8S2CiQ58SMbBWute/HxGfA/RQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3GZvdtLOLCE/UY5T+LZIgHRWoNam/2OQ0++GKw8cPeWDKH+jp
	yUzEo7lhTQp3cJ9s1Z1DQMQcF+oglrfUHmjRMpOppPwTuCThLjyf
X-Google-Smtp-Source: AGHT+IFCboTgk0QbJIGUebZF7ryW3W8srgnHP7WiKEUIOeSpExG9/0LHG4R9watdjNxl9l3QJ9+omA==
X-Received: by 2002:a05:6402:2410:b0:5cf:4523:4b9c with SMTP id 4fb4d7f45d1cf-5cf45234ceemr6863160a12.3.1731426502622;
        Tue, 12 Nov 2024 07:48:22 -0800 (PST)
Received: from max-laptop.. ([93.175.195.113])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c9e36csm6397256a12.66.2024.11.12.07.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 07:48:22 -0800 (PST)
From: Maksym Glubokiy <maxgl.kernel@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maksym Glubokiy <maxgl.kernel@gmail.com>
Subject: [PATCH] ALSA: hda/realtek: fix mute/micmute LEDs for a HP EliteBook 645 G10
Date: Tue, 12 Nov 2024 17:48:15 +0200
Message-ID: <20241112154815.10888-1-maxgl.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HP EliteBook 645 G10 uses ALC236 codec and need the
ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF quirk to make mute LED and
micmute LED work.

Signed-off-by: Maksym Glubokiy <maxgl.kernel@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 571fa8a6c9e1..4b17a20e5b4f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10496,6 +10496,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8b59, "HP Elite mt645 G7 Mobile Thin Client U89", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8b5d, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8b5e, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8b5f, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8b63, "HP Elite Dragonfly 13.5 inch G4", ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b65, "HP ProBook 455 15.6 inch G10 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8b66, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
-- 
2.43.0


