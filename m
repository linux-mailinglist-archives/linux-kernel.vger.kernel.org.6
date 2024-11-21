Return-Path: <linux-kernel+bounces-416580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF109D4727
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 06:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F1BC1F227E0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 05:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE5D14C59C;
	Thu, 21 Nov 2024 05:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cuNj9h2O"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE1E13665B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 05:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732166312; cv=none; b=UaJUph/95jWKRvxJhF/to5d87EUR7D4CRQ3owLQYyrLC9HQiOZwWoQaMbloghIy+SfoZjCfX1iVfpu2Ce//Yv2txb8AQrrvSRiSSkKAeCUR743uZbXmuBx2yy8CZ+xFHq5bCCXVKacFpV0V8elb10dJnNdotpGUtpTLZsuwxe7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732166312; c=relaxed/simple;
	bh=3iNiMAaXuyRoPF8/xoY8wdLm6PfEbp5C9kJFn1jG7HY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sVzBvRqZCtj39Oq6q+j/5+lB+mjz8ewTm6O1AavK8egw7f59LuyK+vVbgBV6BOFO+74jOD4fuVTXjHHTYsRBB4E/TCtQXBVovVsLURj8STOPGlSFiNpjDYIP7yiLFPugQushjsQgBNJTQpVHRZ1wdh+DAwQyRhOfcE2gb5IO1Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cuNj9h2O; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21262a191a5so4325725ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 21:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732166310; x=1732771110; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gRRi5SKhoizpTYQ3Ei2ujEmx27mAv2VTQ/FPrSwu6V4=;
        b=cuNj9h2OlzcMLa2lEVyAivsdwnn94AYN1lMS9i1Ml/EkwMEvuHLQFys8uMk8bz7FgM
         U3uavUoicQkYHHPfn2zy3PGuB1FS4cKPRSeISSVKT7klpdJaQROcKMlJELuHcNPvySIy
         xRxfvmMT/A5TwcRJzzT4zhSS5cqKF32lTNunE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732166310; x=1732771110;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gRRi5SKhoizpTYQ3Ei2ujEmx27mAv2VTQ/FPrSwu6V4=;
        b=ZNw+5EAdSOgWCzG3bUDf3r/pvgAgk/X4W8UzSQKuCIeMdU8tl18Xyj6YmAVIEbMLNI
         CoTYeUwYOWUsyvKe0le85wdx4JQO5R0R76OIO7iYxeferZ3hZXQVKGpqXMiCVKe75gO0
         Ba/h+IbzvuNL8b1JdVmMBURAwbzzz4EjG5G0BNwtVcMcfQ6GcLlY1jq8rhp77zx4ZEUK
         YCIT9pfNqIkP3pU+6tZ1YnVLGXt73Ym0MjkOGK8HX1wJTDJl3lZ8niQMEgUUzUO9vZDu
         rO2L9x2rTvlYpMn/AD85x/KPnCadJkXjRsCb4JnDb4YPpuXZ1T6Lwex26fom1pT9saLX
         KQ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKt3LHey5AcHIAbOV44cELvye0Y92SSb4NzXPUgtaPn+FsjKq+2O316I6sA/Kx9gZxPWipp0eC0Wbx/Ks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxge3yu2L4Xq29RO3vU95rie9iAOa1JvqACYo7Ubn8fKLXntBmF
	oyTFOsjMiE10Tace+MmY5pRR30ZAqZ9RFNZzeWJpEblRBBzsi81vTVjyJIzv08tLPz2aCejvSr4
	=
X-Google-Smtp-Source: AGHT+IEcYjVTkLz1aNR2Rs+b1/26fkT8XZws7jDLf+IzBe8rUwmQgktERWQyKYkQGUrBjuGfJRAwMA==
X-Received: by 2002:a17:902:ce8c:b0:20c:9d9e:9049 with SMTP id d9443c01a7336-2126c130e74mr62613895ad.22.1732166309868;
        Wed, 20 Nov 2024 21:18:29 -0800 (PST)
Received: from lschyi-p920.tpe.corp.google.com ([2401:fa00:1:10:2c14:fcb:b86c:e723])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-212883e45c4sm4648955ad.218.2024.11.20.21.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 21:18:29 -0800 (PST)
From: Sung-Chi Li <lschyi@chromium.org>
Date: Thu, 21 Nov 2024 13:18:26 +0800
Subject: [PATCH] power:supply: cros_usbpd-charger: update command version
 to set limit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-fix_power_limit_ec_cmd_version-v1-1-2f15dcf32084@chromium.org>
X-B4-Tracking: v=1; b=H4sIAKHCPmcC/x2NSQqAMAwAvyI5W7DFDb8iErSNGnAjFRXEv1s9z
 mFmbvAkTB6q6Aahgz2vSwAdR2DHdhlIsQsMJjGp1karni/c1pMEJ555R7JoZ4cHyaeqvDeuyFp
 Xpl0GIbIJBeMf1M3zvLEKxLpwAAAA
To: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sung-Chi Li <lschyi@chromium.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732166308; l=1543;
 i=lschyi@chromium.org; s=20241113; h=from:subject:message-id;
 bh=3iNiMAaXuyRoPF8/xoY8wdLm6PfEbp5C9kJFn1jG7HY=;
 b=wiyA9RmRAL+z2Xb4sx2KiPSsmD8rPIGptfjrdwpzGCLziP+0NGFIMFXJuWuABi8UlZoTVd2bM
 HY64Bc6uCQ4Cs8s4b6esQTyCOQz8ayDYRVb6lM96SqS9fAkk0Q2qOjQ
X-Developer-Key: i=lschyi@chromium.org; a=ed25519;
 pk=nE3PJlqSK35GdWfB4oVLOwi4njfaUZRhM66HGos9P6o=

The request that sets the power limit on the ChromeOS Embedded
Controller (EC) requires the command version to be 1, so update the
command version used in the driver.

Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
---
The ChromeOS Embedded Controller (EC) exposes a set of commands (host
commands) for communicating with it, and the kernel driver
cros_usbpd-charger uses host commands to get and set power settings on
EC.

The host command needs to specify the version in the sent request. The
set external power command (EC_CMD_EXTERNAL_POWER_LIMIT) requires the
command version to be 1, so update that setting in the driver.
---
 drivers/power/supply/cros_usbpd-charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
index 47d3f58aa15c..c496c7c4dd2c 100644
--- a/drivers/power/supply/cros_usbpd-charger.c
+++ b/drivers/power/supply/cros_usbpd-charger.c
@@ -325,7 +325,7 @@ static int cros_usbpd_charger_set_ext_power_limit(struct charger_data *charger,
 	req.current_lim = current_lim;
 	req.voltage_lim = voltage_lim;
 
-	ret = cros_usbpd_charger_ec_command(charger, 0,
+	ret = cros_usbpd_charger_ec_command(charger, 1,
 					    EC_CMD_EXTERNAL_POWER_LIMIT,
 					    &req, sizeof(req), NULL, 0);
 	if (ret < 0)

---
base-commit: ac24e26aa08fe026804f678599f805eb13374a5d
change-id: 20241121-fix_power_limit_ec_cmd_version-6f2d75ad84b5

Best regards,
-- 
Sung-Chi Li <lschyi@chromium.org>


