Return-Path: <linux-kernel+bounces-520252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F78DA3A78C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294FD189014E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9771F5836;
	Tue, 18 Feb 2025 19:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="p5/h4UiC"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191A01EFFA3
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 19:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739907052; cv=none; b=mUQBT/Vu1Met8xhL+p+6tqDZ9YXSFX9Y5w906JQeeBuH05bRev5fPcKEq51Zkr0TlXIWpJnjxhNPDAmiDoMWeYguIYwgstnUq+v340vCVJRswUXMVIouc1QD2u8fupvDTqkLbqBDsg2l1SDSet5roSRPCPxo1SIl8SR+A3XYv0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739907052; c=relaxed/simple;
	bh=911xKOJApKviZC+11zfPOxyXIb2TukqSX6c3EVx5nkQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hEmjfoQqg4YQemd3NH0NNaht1HZAL6YguAo2TzaefXCdUG6ZZk+sckyY5XvorWZ9+DkzW2rxxz+DdAIBjW4RcEaHNW+5MLC4Dy/lHOY8xg6f+H+jYIV8KAtfsNfceA6lN2jiTo3Nn6MI37S8u1eMeM5yEpU+qqNmBv5EgPa8gSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=p5/h4UiC; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e058ca6806so1288135a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 11:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739907047; x=1740511847; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q1Cool/KkGodX8Z3AKXl7cQge0BzoVtk/glY1zU+OpQ=;
        b=p5/h4UiCr1zAnhMHW3F7rfIE4q1O2u4ZVekRRvk4d49K7z1KMfaS3njvYRtN0gul14
         HBw5DXsaQZiichaw7BQRHsGrVcTN108xx7f+pWewHuM1q+N9fQYlEpk78y28HCl/e4wt
         OqJ3VX8scP7o5H1WogEPYiUS6/9WTR8Gd/spvCb7XYj3sY10+YHGPsxcCF5Agi0G5LEs
         /jDPUEbFSVjPGbxidAbJzcJ8ZFtCR15lreBy0PDGn1e4JbR53Tamz20jp8yZlb68xZjo
         6/bAmMPmroV5C7YgW/ZQ/K4DFqmbBj2EInxq7xhLDDbhVQT212kXa/CC59UAqL8hOlbg
         XNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739907047; x=1740511847;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1Cool/KkGodX8Z3AKXl7cQge0BzoVtk/glY1zU+OpQ=;
        b=Tv4+KEFvSWVw6l/8HvIxGCTOZEabPsDKGmqZCEol+7w62KgjpYM6cdSx5UU+d0eBVy
         qggpnYP9ElL2J4zonubcDWt7C8sAkOezI7EZJsRsg1NPgVDoDo9VL7K3T4tPpCU+srYZ
         qCTkc+j5LNjtE9w7tWs+AaWy6z2NSUStxYdoQUJvuwkU0bkJxcQsnk8hwITfwHUY8SQZ
         MoODwACCGmHeGHuzUIUZP/l/M3BdKdrsQQFQzdV8s+9uv8BObzrnvsBoEZZa1UutXLDJ
         GN8+0yxTWrGLAONC0IuxjKWC5p4zr/pznf/rMQObmYSsCm/tlmNC1nP/N6j9fcooyxKN
         usoQ==
X-Gm-Message-State: AOJu0Yy0p2THFxjvvlKA4yC3etm7bUCpJbCV7Cb/OzZ+9AvWNHX10J+D
	YhmrY9A6Jjsoa9dEaYZVolqGkHEbm6fJiOqvDwCKvBr54DerBk2rLiLlyHg5h84=
X-Gm-Gg: ASbGncuW/KKj+RLtThO0uM/iqemN6k88TQ1EbwSieZvo9tGcgYuKqCz4ffbsObtCDxQ
	/dFGCXwulBhw5u5FJkRFtQaHE4lJrj+R0ikrEW3TlKhVXN6X6S8d2S0txmU9ap1YmM6IGX9a7ES
	SpvLBaEUtnnp22hDgpBSo7k8Sf1+33MRSRR6TEdUMJmo03tvyOOBr8SfTYnEpL6ljBBOWqB+xxO
	t7XXzW3T6ht9/h5YeFPddXmIIA0jg5m0hMg8F+nyY9tE9/utKEG5tkX2Gg5rTm/nJXgv7RNt5rc
	+LPDF7L9cw3PCMWav+1YKKHAhceZ
X-Google-Smtp-Source: AGHT+IFuCiWjYik1tkYGoQgh4ZsFo8lmztzxBCjOpVHi8VmVD4pqRZa3rFXJofCtONyce7E+IyRCXQ==
X-Received: by 2002:a05:6402:4609:b0:5de:525c:53cb with SMTP id 4fb4d7f45d1cf-5e036043d74mr14749201a12.6.1739907047405;
        Tue, 18 Feb 2025 11:30:47 -0800 (PST)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:cbaf:af0:839d:fb4a])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1c3ce5sm9338985a12.17.2025.02.18.11.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 11:30:46 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 18 Feb 2025 20:29:50 +0100
Subject: [PATCH v4 5/8] clk: eyeq: use the auxiliary device creation helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250218-aux-device-create-helper-v4-5-c3d7dfdea2e6@baylibre.com>
References: <20250218-aux-device-create-helper-v4-0-c3d7dfdea2e6@baylibre.com>
In-Reply-To: <20250218-aux-device-create-helper-v4-0-c3d7dfdea2e6@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Danilo Krummrich <dakr@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Douglas Anderson <dianders@chromium.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3080; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=911xKOJApKviZC+11zfPOxyXIb2TukqSX6c3EVx5nkQ=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBntN/TCjdli34EttLxXtExpNQaPhDVC9bRlZCzA
 Z9Pj+ToqrKJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZ7Tf0wAKCRDm/A8cN/La
 halfD/4t/Q1MfjlL6VZuSiHTSQPRAa2QAwtLrhbOZWIEknOslrn3QFObs5s6ZPqryvP12HbeHpB
 ZqtOFjUqe/ieQB3ITOsZJaewTPwytAAIwK3CgywZ6JOUxa+9g7HGTKvG3uOOJmkRIffzZmr3L8R
 NZ5pFyDvvdDjI5pECZrNMk4VPJkwSAIgH5iZfiqrRun1haUOJoglpQY8Y8EADKhayv8tRAynR4l
 qDsiwIJrdtBE25fKHWyOZDOE8tpQxMsEt2TrH5ebbZtAEtr/gH6YfiiTUbuz37DxeauQ6mj6ehD
 XTEhxGJYCgV8aSKkCalZcuRKharsqxXA2evtvPHKpQvKOyIZ8EgbBeEOQ7dOeXKjzhWOM5XtsqE
 aMUycH4kRdaTgn4jHRICD4dLzYS3dXyYx3r7rGFlO7duZ/8KxdlzdluJ5loozQhR7O5ANEzTyHJ
 oRWP1Otit21XBW620IoAkxL8DF+P4i2UVjNzAOmtxgzut6dBQb1gzAm06Dpb4EJtFyAnO8mdI/H
 TIGsc8Ti47aBOluK+kO9s5wUA2fZ3WFLXDsN2BGvN4+teT6is420M3bHdw3I0/vCDlh1nH3plyg
 XifkLcQIVqvbW2dYXxE/b7rFiZ7Tza9okUXIhyKDFxmZAvQJKCF+0Z0Tgq8zioD1LftOLwSybaY
 ndwZJujpyaFfb8g==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

The auxiliary device creation of this driver is simple enough to
use the available auxiliary device creation helper.

Use it and remove some boilerplate code.

Tested-by: Théo Lebrun <theo.lebrun@bootlin.com>  # On Mobileye EyeQ5
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/clk-eyeq.c | 57 +++++++++++---------------------------------------
 1 file changed, 12 insertions(+), 45 deletions(-)

diff --git a/drivers/clk/clk-eyeq.c b/drivers/clk/clk-eyeq.c
index 640c25788487f8cf6fb4431ed6fb612cf099f114..4094f34af05b488545cc87043fb3352968515a78 100644
--- a/drivers/clk/clk-eyeq.c
+++ b/drivers/clk/clk-eyeq.c
@@ -322,38 +322,18 @@ static void eqc_probe_init_fixed_factors(struct device *dev,
 	}
 }
 
-static void eqc_auxdev_release(struct device *dev)
-{
-	struct auxiliary_device *adev = to_auxiliary_dev(dev);
-
-	kfree(adev);
-}
-
-static int eqc_auxdev_create(struct device *dev, void __iomem *base,
-			     const char *name, u32 id)
+static void eqc_auxdev_create_optional(struct device *dev, void __iomem *base,
+				       const char *name)
 {
 	struct auxiliary_device *adev;
-	int ret;
-
-	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
-	if (!adev)
-		return -ENOMEM;
-
-	adev->name = name;
-	adev->dev.parent = dev;
-	adev->dev.platform_data = (void __force *)base;
-	adev->dev.release = eqc_auxdev_release;
-	adev->id = id;
 
-	ret = auxiliary_device_init(adev);
-	if (ret)
-		return ret;
-
-	ret = auxiliary_device_add(adev);
-	if (ret)
-		auxiliary_device_uninit(adev);
-
-	return ret;
+	if (name) {
+		adev = devm_auxiliary_device_create(dev, name,
+						    (void __force *)base);
+		if (!adev)
+			dev_warn(dev, "failed creating auxiliary device %s.%s\n",
+				 KBUILD_MODNAME, name);
+	}
 }
 
 static int eqc_probe(struct platform_device *pdev)
@@ -365,7 +345,6 @@ static int eqc_probe(struct platform_device *pdev)
 	unsigned int i, clk_count;
 	struct resource *res;
 	void __iomem *base;
-	int ret;
 
 	data = device_get_match_data(dev);
 	if (!data)
@@ -379,21 +358,9 @@ static int eqc_probe(struct platform_device *pdev)
 	if (!base)
 		return -ENOMEM;
 
-	/* Init optional reset auxiliary device. */
-	if (data->reset_auxdev_name) {
-		ret = eqc_auxdev_create(dev, base, data->reset_auxdev_name, 0);
-		if (ret)
-			dev_warn(dev, "failed creating auxiliary device %s.%s: %d\n",
-				 KBUILD_MODNAME, data->reset_auxdev_name, ret);
-	}
-
-	/* Init optional pinctrl auxiliary device. */
-	if (data->pinctrl_auxdev_name) {
-		ret = eqc_auxdev_create(dev, base, data->pinctrl_auxdev_name, 0);
-		if (ret)
-			dev_warn(dev, "failed creating auxiliary device %s.%s: %d\n",
-				 KBUILD_MODNAME, data->pinctrl_auxdev_name, ret);
-	}
+	/* Init optional auxiliary devices. */
+	eqc_auxdev_create_optional(dev, base, data->reset_auxdev_name);
+	eqc_auxdev_create_optional(dev, base, data->pinctrl_auxdev_name);
 
 	if (data->pll_count + data->div_count + data->fixed_factor_count == 0)
 		return 0; /* Zero clocks, we are done. */

-- 
2.47.2


