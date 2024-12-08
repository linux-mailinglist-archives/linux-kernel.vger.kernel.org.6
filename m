Return-Path: <linux-kernel+bounces-436230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 154129E82EE
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 01:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8101164E46
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 00:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0C19461;
	Sun,  8 Dec 2024 00:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clOVccUG"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED7817E0;
	Sun,  8 Dec 2024 00:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733617748; cv=none; b=VgbzL8Fs17IDunSqL0GYxHmKF0cZ2yCBv3GX3qOMSZGiOvzsfRkbURYF1l5Iup1QlBHWMy1PbY7pNkpfScMwPanJIFLDjMarNLM4yuM5+GyuyVICnMftiLEMqdO80+FfPUPR0lGp8jOnCCpcgY3qVa50mLy/nAqnF7HXue3eg1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733617748; c=relaxed/simple;
	bh=Scd+9AdoKpcxpcjCzDqtEiMeYyMaRNzM9h+zhAllZlo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tp6kBAAzBDQ4kLL68WZlHqVxp55XaQ2WG7+w1MRlQ+bZqyBUXL5VE0ipLP9dKn4wifAWGv3RNaQiZ2ik5g9b5VYTSWhxxDqFiHINe4NU/v9/W92FjS68qb0ljkVqnFJzzO0KrPdWpCkRTldNnZoI68G06qkX+89Q2s90quSbuSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clOVccUG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-215a7e487bfso27583385ad.2;
        Sat, 07 Dec 2024 16:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733617745; x=1734222545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUvcwGZUAhJ/Qv6jLvno/oIrk5VGqb/XMZYkBUQMUUM=;
        b=clOVccUG9Cr17WHX8pNLZMQS+a8y2e3bgRbXGmXeykSg3ROgD02sNBxQMBdoKwziRC
         QbDvRKvpinOymvusUDZh8BstL7CF71NAva0IoneKD29XGlFsPOZfzZmAIiDIzsrtHQwl
         f8P7rzVHmAeQ78wMTJvRk1dkk4AzhNntlkxv/Sv6w6oJRTp8O88PoC1tC2bj4Wh3XHPp
         UGcI+l4BFKQcbc1s5c5ju9DOuSGqcMeDhSViDW+U6pVT3pswYST5yzyCMiKNVflvUVi0
         CEGVLSW5QkaIVqm7fbZUUAUEILy+mw86tHAaDXFHi12qTmVfyaAY0TaRReaPEinX6330
         iusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733617745; x=1734222545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZUvcwGZUAhJ/Qv6jLvno/oIrk5VGqb/XMZYkBUQMUUM=;
        b=dMJlhAPS3PMwmThMtDUa09X+8wns3ErK0v15pmrXsignw/vcKpQKIMTM1O5DTzl34V
         g9JEp9DP0lAwyYkf6DqE6DM9qwQpt82x3aeRmEHi4KDqHJCslAd1uES22+nl/qgM6P0Y
         1CqjcQJxCtbCrCzfcOYtEIZ1c2zH80vqcTPvSk7E3xU0yoiWsRzwApvg6heAVbIt7Fah
         9Np32Voq3KILLBT/xlDrKbJu6EjN6Dt95vAQiP5CLES+tIQekK8vdvizyUX7en3hu2oC
         Tb82sfN/esoQWCuA4yV/P14tVYxi7ejHR6cCCow8JVTup/t/czCVFR8IIteHmRDLM/0A
         PVug==
X-Forwarded-Encrypted: i=1; AJvYcCUMQ9Oylor4O07Rqf/ZgyAnyCLTxTSdzGYIENoUzKmYILuB1K8T5AkeCkiR+Mag2GqxCpgZcj+OiW3O31s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhUu9ceZszukuSp/0v7/fetyMCPlUFIbnfTaDTph5Uu6Xj6BiM
	fg+DtU5WUVWrUov52mAm6Nql3L+WEXZEFRDoyvvsdAlb20gItMl03uskoA==
X-Gm-Gg: ASbGnctUGrGcS3mHAc9tS6Xj01gnM3jWu3djwuh9jnpLCe1vQHXXoKaV8By0wmw58ki
	AoiL9na+a4D715hmM2Xif8KjPrl8nslhglAvxCmv/HHWdls/N8iagp5n73n9YffdOkxoRF1OYJG
	xEas8QZY0wTbcR0iviFUGf34fTywiB5SlSbwIUEojyBGfIUs/2TEP0YSFGrS0pJOivH4dPT+uAO
	E9/j7RH80yMQHhulQm+cvUxUITwTIdDYsr+isfDVLSL+Xk0ooq7k7r+FiFROyRahU/1uxbG4/QG
	ZRqTpwv72BrUL6fU0Sg=
X-Google-Smtp-Source: AGHT+IG1DnAmS3J5IeWgv7/5a9rrRkM51YdBDHhWsDR8q1er+kGuDrIu7RlUWHkdpkLkq9UIxxlsrQ==
X-Received: by 2002:a17:902:d507:b0:216:19a4:dbcb with SMTP id d9443c01a7336-21619b41fb7mr100103285ad.45.1733617745468;
        Sat, 07 Dec 2024 16:29:05 -0800 (PST)
Received: from localhost.localdomain (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21631d718acsm13035145ad.36.2024.12.07.16.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 16:29:05 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: ilpo.jarvinen@linux.intel.com,
	Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	linux-kernel@vger.kernel.org,
	Kurt Borja <kuurtb@gmail.com>,
	Armin Wolf <W_Armin@gmx.de>
Subject: [PATCH v2 1/2] alienware-wmi: Fix X Series and G Series quirks
Date: Sat,  7 Dec 2024 21:26:55 -0300
Message-ID: <20241208002652.5885-4-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Devices that are known to support the WMI thermal interface do not
support the legacy LED control interface. Make `.num_zones = 0` and
avoid calling alienware_zone_init() if that's the case.

Fixes: 9f6c43041552 ("alienware-wmi: added platform profile support")
Fixes: 1c1eb70e7d23 ("alienware-wmi: extends the list of supported models")
Suggested-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
Suggested here:

[1] https://lore.kernel.org/platform-driver-x86/38399b6a-e31c-4b99-a10e-01dc20649c24@gmx.de/

v2:
 - Remove extra line from commit message
---
 drivers/platform/x86/dell/alienware-wmi.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 77465ed9b449..e69bf9a7b6c8 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -190,7 +190,7 @@ static struct quirk_entry quirk_asm201 = {
 };
 
 static struct quirk_entry quirk_g_series = {
-	.num_zones = 2,
+	.num_zones = 0,
 	.hdmi_mux = 0,
 	.amplifier = 0,
 	.deepslp = 0,
@@ -199,7 +199,7 @@ static struct quirk_entry quirk_g_series = {
 };
 
 static struct quirk_entry quirk_x_series = {
-	.num_zones = 2,
+	.num_zones = 0,
 	.hdmi_mux = 0,
 	.amplifier = 0,
 	.deepslp = 0,
@@ -687,6 +687,9 @@ static void alienware_zone_exit(struct platform_device *dev)
 {
 	u8 zone;
 
+	if (!quirks->num_zones)
+		return;
+
 	sysfs_remove_group(&dev->dev.kobj, &zone_attribute_group);
 	led_classdev_unregister(&global_led);
 	if (zone_dev_attrs) {
@@ -1229,9 +1232,11 @@ static int __init alienware_wmi_init(void)
 			goto fail_prep_thermal_profile;
 	}
 
-	ret = alienware_zone_init(platform_device);
-	if (ret)
-		goto fail_prep_zones;
+	if (quirks->num_zones > 0) {
+		ret = alienware_zone_init(platform_device);
+		if (ret)
+			goto fail_prep_zones;
+	}
 
 	return 0;
 
-- 
2.47.1


