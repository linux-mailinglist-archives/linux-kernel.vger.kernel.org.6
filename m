Return-Path: <linux-kernel+bounces-349864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3F598FC67
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 04:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D25861F21FE4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 02:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DFD24B5B;
	Fri,  4 Oct 2024 02:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xd+sNfr4"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F180D3E49D;
	Fri,  4 Oct 2024 02:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728009842; cv=none; b=XYKN0Yn+4GKgHdG3XGaMohmuO1MgTPYnuckQ12AngYpMhdHw8ztYmHISO6FTH9IBxgZNZmoreMhBEN6c+lgcGDdXZA9Mu5sOzh+thqBIW3Lhr98JnTXHuSc3bOb1Zmi1TO2AKKWphaS6+pbnSzHlQnWV4VR+rZ7VZG8usbKxCTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728009842; c=relaxed/simple;
	bh=e4520YRF8lMNfwE/puQ6KyyARUAOUMuL9iolVZGGxzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNx/W7U2/OVY8jdJM3yIm3f8jqj4TkFIydUAu09FnYdomtWG+SjrYwi8nE7qNMzp/Lm4bzApeyCBXhrLQgn+Ugd2o3ZqmdMIEYgbHpTodZ19Cwjx49gB9BYTRpGLFhvmyXufCLw99Jv91xFqcaWN0v3ITLdfJ7QMhyhJI9xWOk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xd+sNfr4; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20b0c5895aaso1610625ad.1;
        Thu, 03 Oct 2024 19:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728009840; x=1728614640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QIERSpX3isiK+S3se7J2und2rQzim7nmtzOZD3XM1s=;
        b=Xd+sNfr4SEZ9AmQL1IpzBJaGEgoKqE30YIPVvZ7UykbPERGz5N9XLckFW9ZimG5oLK
         pNLDcYK5sEmGR+It5q13vy+Ld8NtJ+/5Ld5WlMZdbA7Y58k3HNlhR5u7m+b2T3k4V96F
         R7YpzeBVSarwBWIUSAqrAvBKgYcJd6SqyRhkxfZn3y3U9K3BXDTWoy0LPDGbfRmvYB2m
         vrhA8d1oO7BIV7yMZ3JTLL41GLkxTTgYxHCQmvU7OfQKfAzaVWWyijtW42EVmHnnne6X
         6WkwRGdtVVC9VpW98xeaAZg3L+NnVC0ILZVnnnwQ/dOJMMtk/KO57jLQpXYHlEGY9pj6
         jgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728009840; x=1728614640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8QIERSpX3isiK+S3se7J2und2rQzim7nmtzOZD3XM1s=;
        b=KobVStG8c9v6MFuPqlNzICxqoawDMeTtLKZb6eZEp9gSDKI6MlkZI/XMGTvquibend
         eP19jZdNMHzhRgfAuVeNLbbc3h+9Hh3REn4Yg7sRXTuBF9QDLEDV42vKV2BmGCeojFks
         QGdENAoU9/tNXOpINfRUzKimzoy5lRKWfJUep2pTEmR8rAuu3c7n+/99LwTFw9g8Jt6H
         utwVl/JegFL6IEqekmKobs2LRoIwhkHc/nLSlQ4glU1HjOnTQiTUKm/4LzQzpu1zE3ZR
         qOZ+bLP1ep2BXu1B0TDp+GdfFL4c0bN8Tk++PmOrJYRZGgSdSpQ/MA76ypB4pFVu2QEI
         zxdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe6w+aYWn7FOcFYeh0fphNhskPg2Ce+lVaa+TdG+SyoNl/24Fiflgn+Agy4sLAaMh6PvUeOdZucxVYObA=@vger.kernel.org, AJvYcCWfkHX51pcaNSQM3n8KtVuYSl+g8yfwvzA7R+1tT9qNIFsAfzid+dAHtluO+bC/sTdz0YB9YtLwbmouqHT4F4gK8iXVfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXUK0g8c1JPR9wDyDzq142F1d0bEsXsuEyQnJtaPFv6lGgYvDA
	t9njOrV+r0aPRmcwrY6gXQ1VuG9ksxFBOomIPDKiC1zBUEleA4gh
X-Google-Smtp-Source: AGHT+IFrTKlf4qq+s3xIaMEwEDMYKCghYvQDTTeOeuliD6OyBOT4oXdqSFf1OAQPeGx/khBB1ojknw==
X-Received: by 2002:a17:902:ecc4:b0:20b:65d6:d27c with SMTP id d9443c01a7336-20bff179ec3mr7500365ad.13.1728009840181;
        Thu, 03 Oct 2024 19:44:00 -0700 (PDT)
Received: from crabo-Latitude-7350.. (1-34-73-169.hinet-ip.hinet.net. [1.34.73.169])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20bef706e09sm15366945ad.248.2024.10.03.19.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 19:43:59 -0700 (PDT)
From: Crag Wang <crag0715@gmail.com>
X-Google-Original-From: Crag Wang <crag_wang@dell.com>
To: mario.limonciello@amd.com,
	Prasanth Ksr <prasanth.ksr@dell.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: crag.wang@dell.com,
	Crag Wang <crag_wang@dell.com>,
	Dell.Client.Kernel@dell.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv3 2/2] platform/x86: dell-sysman: add support for alienware products
Date: Fri,  4 Oct 2024 10:41:49 +0800
Message-ID: <20241004024209.201244-2-crag_wang@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004024209.201244-1-crag_wang@dell.com>
References: <20241004024209.201244-1-crag_wang@dell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alienware supports firmware-attributes and has its own OEM string.

Signed-off-by: Crag Wang <crag_wang@dell.com>
---
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
index c05474f1ed70..68c63e1fbd27 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
@@ -520,7 +520,8 @@ static int __init sysman_init(void)
 {
 	int ret = 0;
 
-	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL)) {
+	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL) &&
+	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Alienware", NULL)) {
 		pr_err("Unable to run on non-Dell system\n");
 		return -ENODEV;
 	}
-- 
2.43.0


