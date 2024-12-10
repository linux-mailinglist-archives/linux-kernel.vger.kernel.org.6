Return-Path: <linux-kernel+bounces-439383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9E29EAE97
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC185168935
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE15228CA2;
	Tue, 10 Dec 2024 10:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UYr2IZbG"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729EF212D74
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733827613; cv=none; b=BgsOidgLEhmZhxfEw1iVPzyhgqtm55NgpP55idPR9NK3UiFn6s+zj+Q7zpQWW+BUOLPL3jOhQNNi18XVlXSzvZtpQliAPCFzHSY9Ev0jhhJ/Optw0BhcPOhsDw/sk9rT16FpaYtd2AZYbKQOxWGlxi6zxIF18LDvg5SGkZjO/x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733827613; c=relaxed/simple;
	bh=K0BvGK4oOeIidGmW8aWUPR+jB9kYewVqKo7IDNPdqLw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U2OSlMe0RBbE+h/Zghu3giOCjSFykOK7+mVMl6wbztDm64vK+4pIalCq+pKOBwK2qGNrqzLxPLJOC1nXbpH91wooRlqwmUYGGq/bNgbw9cnZEXWvmhgugRrPSmqvEeRO7QUXzPhDubCFjHE/I0EevGdePKslOKzRIor/Jc+1BbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UYr2IZbG; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434a852bb6eso52030135e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 02:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733827609; x=1734432409; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0F/PaPCmemiFgieAJmds1srxQ0DrRbfktCNGrwXYWA=;
        b=UYr2IZbGY5xcuhCPpCq1wKJUcwtzb2yKzZsHzH0q9kbg+DuywIjz1vvkukC0R3eaiN
         AF6Tl75pfex7tvrCgARP03yN8DS3XfkEmpTwZpLVE+zYH12Uc0vYt+A0qJwYGN5u66k0
         0fM7NMDUkJVg33WkNW6ZfmuWc6jDBJAlbPh7r9of6Ub1ps+18KLFCFpjCV+99oHP5IUI
         QQWlnpV+8MlyebIPljLaad4toXU+eFfPYV9ebrMXQjRMmwhuNyjP8xwqQiDsx+hUbRIN
         7+uggLU7B+EZ00Gd/Oy+G1V1MkKty1dirNJP8a3gH3EjSC0Dhl22RYVwBR7lUc3HEkCI
         gOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733827609; x=1734432409;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0F/PaPCmemiFgieAJmds1srxQ0DrRbfktCNGrwXYWA=;
        b=k3oMdndDYnXOdpH58Y8vv2BJo5CIAFDFf7Hx5pOLUxeKEnAYjcVn2aRBGVUnZcyaQ7
         q27TZKzPDP+52/HlaJaj8b/mFrB6DH9I0G4PSOi+Ru1HjxXPjfRL1b6KH0a5ONMmadhH
         QQOyabQiV3MqXiSJUbqNnksRZarxfjXDuMpnp32xldC61e3FRje/AHARo9VYuNJmVY37
         S/bXBFhddtNkYOTGCSQ0MBmQsrxU7VEx+nLxqlo4DgU5iEjx/QC/K3n+GoLv9Glq1cd1
         ud4EtysKj2+YdJl14BioCzzjVSwcBnVd6NbpyiMX9aIWNW1BVX9oGV5Yjrnv84kizI+N
         9eMA==
X-Forwarded-Encrypted: i=1; AJvYcCWle8nY8iGkzcXi1mVVLc7sgGSKixXnoD0dY5eqU1Lkz5U2+oPOCl/HbC3okP4BRVVclX9HFbxpDig6Uq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzZdvcMVm3ba3E8zshq7td9JYYMAmnajs5NHKmcv/51t+/br0d
	plTTAJokJaabtNd/+nq5NfBPuUl/FdPyMuDaSJCCO50AYlq2S+IiJj4tiFxqpl4=
X-Gm-Gg: ASbGncuCoXHGy6NX2ePtWcLh8I9VkF+gtV2uksHr1LKbfun20grwI7lNAiGkyH/ezgk
	4wIO2+3c7W4SK+/M8p1cuYB0GKjjrAHmM7h6uwy9iIHESWeXsj0m4XStkDJq+czXkjiQiwSfvbz
	AGEXKE8oviCIXwrlQi0oE+xNk4zz0aOsMFv091ZtDpxFw6iHSwGMHBZWVTyerBS0pyk3cLl8/QW
	AV6vkoWeuCHZjoDuW5T4/IHCOeQckcbVadeQZAOfVuLPt5RfVH+nNOTwq1llV69MwjZtaE48/qt
	Yg==
X-Google-Smtp-Source: AGHT+IEjvvkVPGCQ4q4RgZA4PhkuYbvY9MlZVkehC9Ab60KIvM9AxWyfKNE3bO1mbffmlAVgIlitgg==
X-Received: by 2002:a05:600c:3550:b0:434:e9ee:c2d with SMTP id 5b1f17b1804b1-434fff9c1femr29024255e9.26.1733827608472;
        Tue, 10 Dec 2024 02:46:48 -0800 (PST)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f2d08564sm94543645e9.12.2024.12.10.02.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 02:46:48 -0800 (PST)
From: Guillaume Stols <gstols@baylibre.com>
Date: Tue, 10 Dec 2024 10:46:45 +0000
Subject: [PATCH v2 5/9] iio: adc: adi-axi-adc: Add platform children
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-ad7606_add_iio_backend_software_mode-v2-5-6619c3e50d81@baylibre.com>
References: <20241210-ad7606_add_iio_backend_software_mode-v2-0-6619c3e50d81@baylibre.com>
In-Reply-To: <20241210-ad7606_add_iio_backend_software_mode-v2-0-6619c3e50d81@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, dlechner@baylibre.com, jstephan@baylibre.com, 
 aardelean@baylibre.com, adureghello@baylibre.com, 
 Guillaume Stols <gstols@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733827603; l=4154;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=K0BvGK4oOeIidGmW8aWUPR+jB9kYewVqKo7IDNPdqLw=;
 b=QvXIoMpjAs3QFvOmcJLXDrJoy19P239MzZoKZ/6dDHf31sx/QoIun+q5eaFSt37jjNUhpp2Dy
 519K9hJbc84CW3gLgWTOogPrX6iDvyaddjtg8ZKryCiLGGHD44LDzf9
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

This is a preparation for the next commit adding support for register
read and write functions on AD7606.
Since sometimes a bus will be used, it has been agreed during ad3552's
driver implementation that the device's driver bus is the backend, whose
device node will be a child node.
To provide the special callbacks for setting the register, axi-adc needs
to pass them to the child device's driver through platform data.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/adi-axi-adc.c | 75 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 72 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index c7357601f0f8..7ff636643e56 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -80,7 +80,18 @@
 	 ADI_AXI_REG_CHAN_CTRL_FMT_EN |		\
 	 ADI_AXI_REG_CHAN_CTRL_ENABLE)
 
+struct axi_adc_info {
+	unsigned int version;
+	const struct iio_backend_info *backend_info;
+	bool bus_controller;
+	const void *pdata;
+	unsigned int pdata_sz;
+};
+
 struct adi_axi_adc_state {
+	/* Target ADC platform device */
+	struct platform_device *adc_pdev;
+	const struct axi_adc_info *info;
 	struct regmap *regmap;
 	struct device *dev;
 	/* lock to protect multiple accesses to the device registers */
@@ -325,6 +336,40 @@ static const struct regmap_config axi_adc_regmap_config = {
 	.reg_stride = 4,
 };
 
+static void axi_adc_child_remove(void *data)
+{
+	struct adi_axi_adc_state *st = data;
+
+	platform_device_unregister(st->adc_pdev);
+}
+
+static int axi_adc_create_platform_device(struct adi_axi_adc_state *st,
+					  struct fwnode_handle *child)
+{
+	struct platform_device_info pi = {
+		.parent = st->dev,
+		.name = fwnode_get_name(child),
+		.id = PLATFORM_DEVID_AUTO,
+		.fwnode = child,
+		.data = st->info->pdata,
+		.size_data = st->info->pdata_sz,
+	};
+	struct platform_device *pdev;
+	int ret;
+
+	pdev = platform_device_register_full(&pi);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	st->adc_pdev = pdev;
+
+	ret = devm_add_action_or_reset(st->dev, axi_adc_child_remove, st);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static const struct iio_backend_ops adi_axi_adc_ops = {
 	.enable = axi_adc_enable,
 	.disable = axi_adc_disable,
@@ -370,7 +415,9 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(st->regmap),
 				     "failed to init register map\n");
 
-	expected_ver = device_get_match_data(&pdev->dev);
+	st->info = device_get_match_data(&pdev->dev);
+
+	expected_ver = &st->info->version;
 	if (!expected_ver)
 		return -ENODEV;
 
@@ -408,6 +455,25 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, ret,
 				     "failed to register iio backend\n");
 
+	if (st->info->bus_controller) {
+		device_for_each_child_node_scoped(&pdev->dev, child) {
+			int val;
+
+			/* Processing only reg 0 node */
+			ret = fwnode_property_read_u32(child, "reg", &val);
+			if (ret || val != 0)
+				continue;
+			ret = fwnode_property_read_u32(child, "io-backends",
+						       &val);
+			if (ret)
+				continue;
+
+			ret = axi_adc_create_platform_device(st, child);
+			if (ret)
+				continue;
+		}
+	}
+
 	dev_info(&pdev->dev, "AXI ADC IP core (%d.%.2d.%c) probed\n",
 		 ADI_AXI_PCORE_VER_MAJOR(ver),
 		 ADI_AXI_PCORE_VER_MINOR(ver),
@@ -416,11 +482,14 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static unsigned int adi_axi_adc_10_0_a_info = ADI_AXI_PCORE_VER(10, 0, 'a');
+static const struct axi_adc_info adc_generic = {
+	.version = ADI_AXI_PCORE_VER(10, 0, 'a'),
+	.backend_info = &adi_axi_adc_generic,
+};
 
 /* Match table for of_platform binding */
 static const struct of_device_id adi_axi_adc_of_match[] = {
-	{ .compatible = "adi,axi-adc-10.0.a", .data = &adi_axi_adc_10_0_a_info },
+	{ .compatible = "adi,axi-adc-10.0.a", .data = &adc_generic },
 	{ /* end of list */ }
 };
 MODULE_DEVICE_TABLE(of, adi_axi_adc_of_match);

-- 
2.34.1


