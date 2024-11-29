Return-Path: <linux-kernel+bounces-415007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE039D3074
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 23:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51CD6B22365
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 22:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A760E1D1F63;
	Tue, 19 Nov 2024 22:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xAWGuzad"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E9D1C1F00
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 22:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732055267; cv=none; b=ME5ubdOMHyj3XYNUzsLcuujwoG4Nc36z6gxmsxDyX8tU3/MUHDkZmYGnDCUW/bWLcKi13cQBlIG4AeOOPDxGb4qH0byNLPtk2nBgWm1lOkjruYirZ3ozDqwFBXhXU397DTqLnYSdvgXLt101qPvaLSE/cm/yr3T0oGQZO2HT18E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732055267; c=relaxed/simple;
	bh=l1VapS+6cDBwhVLUp4pFoZ4oP3LXwA7JyHycTEwxoqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=beP3f4Y7qTo1KLxttZpQ2W6QgeC5rpLJerllAMe2L+//v2osHe3jO2dxwT6FJYoNyiGWMh0Fb+hCeuYqzprRD7FCqaZ8+Gnf6J2+McBSJJ7gj+RZwW2V2Fg9KyCzk3AXBoYmlsCKf2SktJkoBSo4GY2Rw5KhskRM2SrhOvhlIB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xAWGuzad; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-29645a83b1bso2610546fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 14:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732055262; x=1732660062; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i+ggx9jSBeVfhen+T0ysJRXhaUXF4spm8ezXLXsU6cs=;
        b=xAWGuzad+izVnjGJ50fhsuVvZhMfBZruP3arW4En2DPIzwyWolzAOByQqnxV/IPmUd
         DcmDmy5nc0inCMzWrlfCEyOcGz4jgIMNh+Y/SwZuA5mb4u74l3G49TeVPa6n5gmXItid
         mxTXmYB0BUXEza3ACWUjR/AqKm+306ZFvOlbUZTwjknB0y0hFZ/A/FzF/fs09doCrMVV
         9ZvTwOarQLahR47WI55Ifo487kPm+BZFDbV9B4j9vClAOurw5lRNmVq07dxHvWZhahPZ
         AS6fdx/3sBFXykAsJnZI+DUelPPN1kh1bSr/kvMGYwC7RHbZVFFYPTLm/VXGyxikZVM9
         68/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732055262; x=1732660062;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i+ggx9jSBeVfhen+T0ysJRXhaUXF4spm8ezXLXsU6cs=;
        b=KXh8BCh8m1qI3RfVKHgpkC/cjhn9AT5fW9iINbRkpdj2Q9fIaP0daXNmL4/1PPPqJ/
         TQltB/QOCGPgyznkKvv6++VmBd6Uno9YOaP2UjLrIfhDP7aYHq2jukoqo+WCeP3K/phG
         c67UbG6M/+eVJSytLJFeOL1hIOMUafHEWUbXRAJsd9F10X3hmuK2wvtSSSMjfAohw5w7
         lXXJB7gh7sJvy+7Bh7nU1rRySrohNKa5aez0QphcdRCXCBnKBh5HOLbvfGd6tMyQoPEl
         i+RXMxRcjrVreFm1lwyzcGRMlXmBUQjK2xGS03jpfQI0N+VgM92XLviJ4O2N1sxahO6h
         7iaA==
X-Forwarded-Encrypted: i=1; AJvYcCWq7ZFckeuHiyLnkA+7hHRPYU75Ka+5sLOB+KOfQP1jUKkOjXRhkLqR5pMlwWMir8AvTC2u02fCgl3skbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwf8E39o4NzjkZu/8EYx2uf90/Yoj2i5pVlBamxkfiElcvI2Ed
	MlM7yo9DlYih2lzp/qpbUynQosMgdrs5lFQZ6pdhgH5/1t+6SanGMxl5YcvDmJQ=
X-Google-Smtp-Source: AGHT+IHefAXVlq3Wb6oCaO5/Tgf08AylbdJ3Vgv64UAycljKQuekq8d4vH9pmdb2TNfsjp3Xne1MHA==
X-Received: by 2002:a05:6870:a408:b0:296:5928:7a42 with SMTP id 586e51a60fabf-296d9bff362mr567505fac.22.1732055262529;
        Tue, 19 Nov 2024 14:27:42 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a78212891sm3613139a34.59.2024.11.19.14.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 14:27:41 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 19 Nov 2024 16:27:40 -0600
Subject: [PATCH v3] Input: mpr121: Use
 devm_regulator_get_enable_read_voltage()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-input-mpr121-regulator-get-enable-read-voltage-v3-1-1d8ee5c22f6c@baylibre.com>
X-B4-Tracking: v=1; b=H4sIANsQPWcC/x2NQQrDIBBFrxJm3YFqpJBepXQxaUYzYFVGEwIhd
 690+T68/06orMIVnsMJyrtUyanDeBvgs1IKjLJ0Bnu3zhgzoaSyNfwWNdagctgitawYuCEnmiP
 3kRbcc2zUbTc6Sw/ys/MW+mlR9nL8g6/3df0AZZbGtIAAAAA=
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

We can reduce boilerplate code by using
devm_regulator_get_enable_read_voltage().

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
This is left over from [1] and never got picked up, so resubmitting.

v3: changes picked up Dmitry's Ack and rebased on linux-next.

[1]: https://lore.kernel.org/all/20240429-regulator-get-enable-get-votlage-v2-7-b1f11ab766c1@baylibre.com/
---
 drivers/input/keyboard/mpr121_touchkey.c | 45 +++-----------------------------
 1 file changed, 3 insertions(+), 42 deletions(-)

diff --git a/drivers/input/keyboard/mpr121_touchkey.c b/drivers/input/keyboard/mpr121_touchkey.c
index 21827d2497fa..bd1a944ded46 100644
--- a/drivers/input/keyboard/mpr121_touchkey.c
+++ b/drivers/input/keyboard/mpr121_touchkey.c
@@ -82,42 +82,6 @@ static const struct mpr121_init_register init_reg_table[] = {
 	{ AUTO_CONFIG_CTRL_ADDR, 0x0b },
 };
 
-static void mpr121_vdd_supply_disable(void *data)
-{
-	struct regulator *vdd_supply = data;
-
-	regulator_disable(vdd_supply);
-}
-
-static struct regulator *mpr121_vdd_supply_init(struct device *dev)
-{
-	struct regulator *vdd_supply;
-	int err;
-
-	vdd_supply = devm_regulator_get(dev, "vdd");
-	if (IS_ERR(vdd_supply)) {
-		dev_err(dev, "failed to get vdd regulator: %ld\n",
-			PTR_ERR(vdd_supply));
-		return vdd_supply;
-	}
-
-	err = regulator_enable(vdd_supply);
-	if (err) {
-		dev_err(dev, "failed to enable vdd regulator: %d\n", err);
-		return ERR_PTR(err);
-	}
-
-	err = devm_add_action_or_reset(dev, mpr121_vdd_supply_disable,
-				       vdd_supply);
-	if (err) {
-		dev_err(dev, "failed to add disable regulator action: %d\n",
-			err);
-		return ERR_PTR(err);
-	}
-
-	return vdd_supply;
-}
-
 static void mpr_touchkey_report(struct input_dev *dev)
 {
 	struct mpr121_touchkey *mpr121 = input_get_drvdata(dev);
@@ -233,7 +197,6 @@ static int mpr121_phys_init(struct mpr121_touchkey *mpr121,
 static int mpr_touchkey_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
-	struct regulator *vdd_supply;
 	int vdd_uv;
 	struct mpr121_touchkey *mpr121;
 	struct input_dev *input_dev;
@@ -241,11 +204,9 @@ static int mpr_touchkey_probe(struct i2c_client *client)
 	int error;
 	int i;
 
-	vdd_supply = mpr121_vdd_supply_init(dev);
-	if (IS_ERR(vdd_supply))
-		return PTR_ERR(vdd_supply);
-
-	vdd_uv = regulator_get_voltage(vdd_supply);
+	vdd_uv = devm_regulator_get_enable_read_voltage(dev, "vdd");
+	if (vdd_uv < 0)
+		return dev_err_probe(dev, vdd_uv, "failed to get vdd voltage\n");
 
 	mpr121 = devm_kzalloc(dev, sizeof(*mpr121), GFP_KERNEL);
 	if (!mpr121)

---
base-commit: 414c97c966b69e4a6ea7b32970fa166b2f9b9ef0
change-id: 20241119-input-mpr121-regulator-get-enable-read-voltage-4342a6afb4f2

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


