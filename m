Return-Path: <linux-kernel+bounces-283898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121FA94FA17
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 01:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEEF62821E2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 23:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2157194AD6;
	Mon, 12 Aug 2024 23:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RP0qZZyH"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F73116B39F;
	Mon, 12 Aug 2024 23:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723503609; cv=none; b=iScMll58G9Tw0uXU/2ypdY74YCyXBzT/FshisP5AQsoCqvITUuHtw4/Bz9q36KARrFdwPnCs8SyjO/Xp8mP7XI35jt1FlAjaHNcmMcjDmGf82nAmaUWYq0UTVGSAVhXeTm3l6C8qaoStRY23hGzo9hfg2LxBgyui43A/6oivnAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723503609; c=relaxed/simple;
	bh=6rvVT3g8PMFlULyNgTXkS+21xtqlNqEdKiOf00PNAtQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iJP5tVZMO7lOJrFbgBPagAxddZ7+36b8BSbTr6dGakHnfsom7oprGZYO1Zb2Or4pMd2qAr+rXCEuiT4bwCLbFF6FNBu5juffjrObsCM6ZsdB0d9jIgZ0/irYou/97UGdv66bfGb/vfLmfIu6KDDPKvkMq1k3hU/v4G1WzwFcjLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RP0qZZyH; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-36ba3b06186so2629224f8f.2;
        Mon, 12 Aug 2024 16:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723503606; x=1724108406; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V7JUF/TPnGtlf/M2nkRGL+e/Djk5IUojalKzK15LptQ=;
        b=RP0qZZyHHzKpzj7Ffn5c5bje4+wCCGFb04yhqHJUnlHrW9UrBo51bBBEehr2zlIABY
         xXucgoC3YZ7lWCo2xQg2uXcTXZjZDssYLydKFYPQGlFimpmYHbx/ZWqgZ52MjrLrr1fC
         aE4n+Gds4t+XyoYFOZ/Vo9C7AsSwx5W2xcj5R/Wy41g62TdmIdEkQAel55KAHKSlLdOG
         SK62l4DMhvS9VnzuFp5foDu4kkz+sr8J7KbtPoE55Xqggm1wv0sFTRZHL4xoHfWahjbm
         defN01cG1sPyNXCRGdDEbaSdP4XP7yWh764QkWJidJUcg1W6AEFnf84i2MfKBtJBSnCJ
         kHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723503606; x=1724108406;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V7JUF/TPnGtlf/M2nkRGL+e/Djk5IUojalKzK15LptQ=;
        b=MB++vvSFLPnHIlnYjgybNlhgdNkEhUHaLqa+JNgCBctgZa4wfy/3Uf5pZTIZbDI3fA
         c+OpKt2gGzcdK7Z0E9PSL8qpaPgRm+ZEYRBeYBXgN6h4BQJTP2zQ43z01greJbl5+Q7F
         MI2AhilHFwE1Of2UrEOXmT0Dj2aJoSlFQMo1jOA+3bkE1c4S7Km7eJYemt+ar2WycGv7
         TWdqFYlDBm+hWK7Yl50YKJ+aloW8joySq/rLC97l02Wxd/8HOEXv5PkxsNDQLqcEhGjw
         HCvaz55QvIQEC/uO9emvBu6dY1tHpayn/Ftw9B2CKb2jvsulMjJE1KbVZsDCeGnmXhBj
         pmEw==
X-Forwarded-Encrypted: i=1; AJvYcCW5WomnLGYkUekUgHpvb92vNg/gP//4/R4G9CA1KUoP670AZ8mrfF+b/455s/fsqn8JPWdhchsyJ4g9Wk23WReI/4ydXjMz+ESBHPdq
X-Gm-Message-State: AOJu0YxLC3+OlrC2EdaDNUzSPwv09r8JsudrDxzboybF2GfjTQTLKSC9
	Sl//H7QRYjPNZM2OXNcfS1k8l0qYYWHi8GWfdwq6+2bDoS0qcupmuJ+XoQ==
X-Google-Smtp-Source: AGHT+IGp/3psuYDM81I5PsrD96jw8gvGaVmdphyy2IogDLIHejWAEz5ZL5lA9/pWC4R2r/wjcvwhXQ==
X-Received: by 2002:a5d:5d85:0:b0:371:6fb7:41af with SMTP id ffacd0b85a97d-3716fb7428emr256682f8f.34.1723503605253;
        Mon, 12 Aug 2024 16:00:05 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c36bcaasm8643183f8f.7.2024.08.12.16.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 16:00:04 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 13 Aug 2024 00:59:53 +0200
Subject: [PATCH v2] hwmon: chipcap2: drop cc2_disable() in the probe and
 return dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-chipcap2-probe-improvements-v2-1-e9a2932a8a00@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOiTumYC/42NQQqDMBBFryKzbooTg9WuvEdxYZOJDjQmJBJax
 Ls39QRdfd7/8P4OiSJTgnu1Q6TMif1aQF4q0Mu0ziTYFAZZS1V3KIVeOOgpSBGif5bVlczkaN2
 S0L0yqBq0SBaKIUSy/D7tj7Hwwmnz8XOeZfy1/3kzilo02ljbGmy7/jbMbuLXVXsH43EcX0ocE
 njGAAAA
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723503604; l=2588;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=6rvVT3g8PMFlULyNgTXkS+21xtqlNqEdKiOf00PNAtQ=;
 b=LbCrikNkvHR3rdcTB1GwdmGVqwlT0dIed49p/9UNK+k/82mdIwriuQm/ywt1leH+Lyv+Wm+OI
 P3SmyDYjqDrAK7lJ7XVpYpAKSefBE3ulI1JqqjYvmeuRH3fij299ZLH
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

There is no need to actively disable a regulator that has not been
enabled by the driver, which makes the call to cc2_disable() in the
probe function meaningless, because the probe function never enables
the device's dedicated regulator.

Once the call to cc2_disable() is dropped, the error paths can directly
return dev_err_probe() in all cases.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v2:
- Drop cc2_disable() in the probe function.
- Return dev_err_probe() in the error paths.
- Link to v1: https://lore.kernel.org/r/20240812-chipcap2-probe-improvements-v1-0-3cdff6d16897@gmail.com
---
 drivers/hwmon/chipcap2.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/hwmon/chipcap2.c b/drivers/hwmon/chipcap2.c
index 6ccceae21f70..edf454474f11 100644
--- a/drivers/hwmon/chipcap2.c
+++ b/drivers/hwmon/chipcap2.c
@@ -740,37 +740,26 @@ static int cc2_probe(struct i2c_client *client)
 	data->client = client;
 
 	data->regulator = devm_regulator_get_exclusive(dev, "vdd");
-	if (IS_ERR(data->regulator)) {
-		dev_err_probe(dev, PTR_ERR(data->regulator),
-			      "Failed to get regulator\n");
-		return PTR_ERR(data->regulator);
-	}
+	if (IS_ERR(data->regulator))
+		return dev_err_probe(dev, PTR_ERR(data->regulator),
+				     "Failed to get regulator\n");
 
 	ret = cc2_request_ready_irq(data, dev);
-	if (ret) {
-		dev_err_probe(dev, ret, "Failed to request ready irq\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request ready irq\n");
 
 	ret = cc2_request_alarm_irqs(data, dev);
-	if (ret) {
-		dev_err_probe(dev, ret, "Failed to request alarm irqs\n");
-		goto disable;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request alarm irqs\n");
 
 	data->hwmon = devm_hwmon_device_register_with_info(dev, client->name,
 							   data, &cc2_chip_info,
 							   NULL);
-	if (IS_ERR(data->hwmon)) {
-		dev_err_probe(dev, PTR_ERR(data->hwmon),
-			      "Failed to register hwmon device\n");
-		ret = PTR_ERR(data->hwmon);
-	}
-
-disable:
-	cc2_disable(data);
+	if (IS_ERR(data->hwmon))
+		return dev_err_probe(dev, PTR_ERR(data->hwmon),
+				     "Failed to register hwmon device\n");
 
-	return ret;
+	return 0;
 }
 
 static void cc2_remove(struct i2c_client *client)

---
base-commit: 9e6869691724b12e1f43655eeedc35fade38120c
change-id: 20240812-chipcap2-probe-improvements-c94d1431f1ef

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


