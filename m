Return-Path: <linux-kernel+bounces-437979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F259E9B32
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44B8D162A04
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377E5143890;
	Mon,  9 Dec 2024 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yRWiI76Y"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4433913790B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 16:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733760309; cv=none; b=BVkCUGRf6tSXQl6EjFNw3kEnTv4dmLE88SAftPbI6rn5Jm4sDGbuWJAwwlL97WkD3c2OPW5s6JBZ2Ez1IFEldXorPNmsUZxUM46njZbDL0lrqsNXafVLb0QrzYevquJeWpk5nxXWeQkZPuFun6Naf8+9Q/lM9rOYrxFc/uFFrt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733760309; c=relaxed/simple;
	bh=rBR5NXgnww06Sh65Qy/7Azyi2Gb2xpN2qKRXGKxDmUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lXgYxRBH1T8vYusOxO+5cdcVkYafSlCf29LLsYEyglLvssaScJ3V3EDPlWB3tKZr/+f3Tb1es4HAWiZS1eO6uzzQqpP2kJanu5CjwTeIBOkB+sgKhAoK//k8IGQrITnkwwjfEcAp434Smn48RgBCghbKWOls2Dvwy22pCi2xaeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yRWiI76Y; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434a1833367so26815685e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 08:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733760305; x=1734365105; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6gQvn01SCFaYf85wm7wZA4AxrI1YMc0NMUI8LVKIi7Q=;
        b=yRWiI76Y+7z17ROxkMTmxCak6nxEQ9yyM4w5+2zhAvWV81EzI8Mxk8jio7xgXpa3OT
         8wpYck0Pd3XOzfRWAsr+Z/iglNmvJlAmlw3v7zzGvqpM4xOoWEU8jO3wJ0To4My6Vy9H
         xNVbZu5uexo2IbnYCVmTsm8lx0tbpVf+Kd2EVotg66KwZAiHGsC0FGuUCqctycQA/t46
         hKDZmhOWfpk9hkWozF/vF3cydQoSXbYqtvRueQe5iGSdl0XeS/WE5maiVzbRG8OHMzad
         4zKzXgvklIPbXqJ7JcTXEWCox3EXVhhcDj3X0s1edbJSX7s1DVKg7CBKRFQq3pxo9RuN
         QErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733760305; x=1734365105;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6gQvn01SCFaYf85wm7wZA4AxrI1YMc0NMUI8LVKIi7Q=;
        b=O2EYZfxICKaMB6+y0QO0dY2e7RO0xMiw/yDgoFHWRRqgsDeCfWERLUdCgYgtzFs/vk
         Oxivy0QmnfPK5K1gdg8k7W+/P//AJjpZg6r09dhK9Cdm0SiSzVQ56gipLInsRPabxzVJ
         CXRo/ZO7LW2Fr/Jgwq21PgSULFnTRUJMMAw6LynyLmOTxBD4iI7OQdhzXQTKJ6fUMLHZ
         Ceov+3SGBL0Hzs7oPaCxjqVz/8qeJght0+Rw9lpagy07sFdx+lQR35aQGMvxzaOlOQkt
         i2eUwR0CD49LbPLvpnMkXUrSpf8cZMGOO3/R06ARm8K9B0zZlhlUmRY2zJfyLUF3P77l
         xALg==
X-Forwarded-Encrypted: i=1; AJvYcCUCXZwTL+avlw4YGykFPIpPcG4azg8zUCX9Zv3FDGFYCrvP0sfPBUX7YfLRGhuNWdcoWllGIu3cr8jl+b4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFPGsWc8HdFlW94+ChFemu1SiTr5PFT0+n0glxiYCvY1KIkN6E
	XxtqFm0TpjJUluBLK8DhUxFtzzsDf32IApLJxesCq6N9aDl+kIaz1nDkuHEJyD8=
X-Gm-Gg: ASbGncvqZfAPHaHD8ssqYx1rIMrE0ydbsiSHZkt1S2+ki3XNVduuSwRSpz2AaLvldEF
	JdV+7/IlTII1gmKpriVgL5PDmZJs5wOpUbTHZc4VI9QXKd6FEapkYoPIl8YoqrjCaCtgJK9ZXN/
	olrjUxyaPLTVHjPaSlI9sU3DZZuEzlsIYa8MC+fiIXRWc8Bxy+q86Z8h6EBMxz0Aznv3fCK8Gm7
	tBewAm68XFR8CbtkC/CnDiSbn6X5XH6y/LkX59FzuDGV1EvBTlsrVt8MNvr2NAx
X-Google-Smtp-Source: AGHT+IFLgrvvJ4ZbcU5oZ15CP6sGt89w7sS5cZEiwVmnaeCinGDbdxMMBd+lkWhnwgPAIvZ9epw2HA==
X-Received: by 2002:a05:600c:3659:b0:434:e65e:457b with SMTP id 5b1f17b1804b1-434e65e47cbmr71087645e9.3.1733760303838;
        Mon, 09 Dec 2024 08:05:03 -0800 (PST)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:432b:3c3e:b17a:687a])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434f3d89b75sm61459015e9.15.2024.12.09.08.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 08:05:03 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 09 Dec 2024 17:04:35 +0100
Subject: [PATCH 2/2] reset: amlogic: aux: drop aux registration helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-meson-rst-aux-rework-v1-2-d2afb69cc72e@baylibre.com>
References: <20241209-meson-rst-aux-rework-v1-0-d2afb69cc72e@baylibre.com>
In-Reply-To: <20241209-meson-rst-aux-rework-v1-0-d2afb69cc72e@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jiucheng Xu <jiucheng.xu@amlogic.com>, Stephen Boyd <sboyd@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3766; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=rBR5NXgnww06Sh65Qy/7Azyi2Gb2xpN2qKRXGKxDmUQ=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBnVxUsYkSkA4Qwt3VALxgGbnvIVc8tf8kC27Tdj
 dF6gxpmN7iJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZ1cVLAAKCRDm/A8cN/La
 hYLDEACeLDq6gapWnzc/DY38UK33183muDLmS35DUORGdkyly9YR8SSsNCdgUThmQj7ZGrECxOr
 VACnCXVFGcdnQk+SJhg/x2a/y5Bvh/kJYH5RNDcLWYAlXyCsYKw6GAnPc1q8cZ+0oEiRiQTvF4O
 eVRLt8oFMXOpgSzceSZ/AXAEaPRsUa1yVGih6LQp802v+sp6x2SJK7kvpkyIL8AHKhuoAbLz8uH
 mxYYi3OajcQM4B/Z0secKuabppMS1DfMB4JsKpbRDRGlaa4oa0MWjiULPBbXd5lAsPxDk6WFx3d
 PhpbjYQCF9wXXCAJtPXcDWKidypQ6D56IfoP+OfGNw/4Idw3of+1fSebpIUrL4lcReeCNWNU7A+
 nctX/aQ4/FSHYW8aPvKP1yj/1u6gVl5o0Z2tdPyTktiGYncfHhSuk7KYRlsAPzADVKOJ41zFRYD
 yPhUJU0YZFwbYh6AK3l9/1a8PgEC5gWWJpTw7laTHX3QIBMQuUcBCKNADgz39Y0BmGBnCrHd0T0
 6TxWvh+RG7mHc+3uAgpv7kcqt6UDYuwJYGf8kwCW5wB2rcfo+mPaaDHHH/lcOvmSdMR11ORdf8L
 IYVtcVu0rMsV7LJWl4snnxIw97Vnyf1hda505G5SAVkM3q2AR/XRU/UsSfs9JyMVMz6k0VyBp6j
 +h15x7Daa+PgfKg==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

Having the aux registration helper along with the registered driver is not
great dependency wise. It does not allow the registering driver to be
properly decoupled from the registered auxiliary driver.

Drop the registration helper from the amlogic auxiliary reset driver.
This will be handled in the registering clock driver to start with while
a more generic solution is worked on.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/reset/amlogic/reset-meson-aux.c | 61 ---------------------------------
 include/soc/amlogic/reset-meson-aux.h   | 23 -------------
 2 files changed, 84 deletions(-)

diff --git a/drivers/reset/amlogic/reset-meson-aux.c b/drivers/reset/amlogic/reset-meson-aux.c
index 0fc1788eb7a83810ac524facfe09b5fa032573c3..1a2024afa056ea4d9404f6444476e48265ac8da4 100644
--- a/drivers/reset/amlogic/reset-meson-aux.c
+++ b/drivers/reset/amlogic/reset-meson-aux.c
@@ -11,12 +11,8 @@
 #include <linux/auxiliary_bus.h>
 #include <linux/regmap.h>
 #include <linux/reset-controller.h>
-#include <linux/slab.h>
 
 #include "reset-meson.h"
-#include <soc/amlogic/reset-meson-aux.h>
-
-static DEFINE_IDA(meson_rst_aux_ida);
 
 static const struct meson_reset_param meson_a1_audio_param = {
 	.reset_ops	= &meson_reset_toggle_ops,
@@ -79,63 +75,6 @@ static struct auxiliary_driver meson_reset_aux_driver = {
 };
 module_auxiliary_driver(meson_reset_aux_driver);
 
-static void meson_rst_aux_release(struct device *dev)
-{
-	struct auxiliary_device *adev = to_auxiliary_dev(dev);
-
-	ida_free(&meson_rst_aux_ida, adev->id);
-	kfree(adev);
-}
-
-static void meson_rst_aux_unregister_adev(void *_adev)
-{
-	struct auxiliary_device *adev = _adev;
-
-	auxiliary_device_delete(adev);
-	auxiliary_device_uninit(adev);
-}
-
-int devm_meson_rst_aux_register(struct device *dev,
-				const char *adev_name)
-{
-	struct auxiliary_device *adev;
-	int ret;
-
-	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
-	if (!adev)
-		return -ENOMEM;
-
-	ret = ida_alloc(&meson_rst_aux_ida, GFP_KERNEL);
-	if (ret < 0)
-		goto adev_free;
-
-	adev->id = ret;
-	adev->name = adev_name;
-	adev->dev.parent = dev;
-	adev->dev.release = meson_rst_aux_release;
-	device_set_of_node_from_dev(&adev->dev, dev);
-
-	ret = auxiliary_device_init(adev);
-	if (ret)
-		goto ida_free;
-
-	ret = __auxiliary_device_add(adev, dev->driver->name);
-	if (ret) {
-		auxiliary_device_uninit(adev);
-		return ret;
-	}
-
-	return devm_add_action_or_reset(dev, meson_rst_aux_unregister_adev,
-					adev);
-
-ida_free:
-	ida_free(&meson_rst_aux_ida, adev->id);
-adev_free:
-	kfree(adev);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(devm_meson_rst_aux_register);
-
 MODULE_DESCRIPTION("Amlogic Meson Reset Auxiliary driver");
 MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/include/soc/amlogic/reset-meson-aux.h b/include/soc/amlogic/reset-meson-aux.h
deleted file mode 100644
index d8a15d48c98494c45c6e3d7e88fa714f770f12e3..0000000000000000000000000000000000000000
--- a/include/soc/amlogic/reset-meson-aux.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __SOC_RESET_MESON_AUX_H
-#define __SOC_RESET_MESON_AUX_H
-
-#include <linux/err.h>
-
-struct device;
-struct regmap;
-
-#if IS_ENABLED(CONFIG_RESET_MESON_AUX)
-int devm_meson_rst_aux_register(struct device *dev,
-				struct regmap *map,
-				const char *adev_name);
-#else
-static inline int devm_meson_rst_aux_register(struct device *dev,
-					      struct regmap *map,
-					      const char *adev_name)
-{
-	return 0;
-}
-#endif
-
-#endif /* __SOC_RESET_MESON_AUX_H */

-- 
2.45.2


