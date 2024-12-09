Return-Path: <linux-kernel+bounces-437978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD009E9B30
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 839B0280BE7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8131369AA;
	Mon,  9 Dec 2024 16:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nKcrOlRO"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB1884D29
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 16:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733760307; cv=none; b=CJ1TzAFi1WLpXw3s5IWBKGUC5oaVHJCeMMMc8ob52oMgSp6NtAgThiwCb0mEYlN/GQQ7oKzS14W+dxZQMU8CeHwtaueTKoRKc9/ktMIE6MaMrfTtICmbTjDzlxY7rvfSFuzKnuJVLzpk7s5ecQszCVHop5iZvgDc+er+XZ9PDFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733760307; c=relaxed/simple;
	bh=GIzXS2CMipBruUg013x80hnunrhkIkK1Hy8qrpszX8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lvrjDb9+8lv0SSloilXnSSF+83k7yPYMLA+H70R9w6J6GGUnu+K2Kp+4gHnuyX37Xwo/fTmdzoZvrAz+FWCtwoxGZ6b9jgDWqB8CfKjor0ZUjuWvCTs9gMxrKSKbBS7ij3nN+1U3ptVmnBYrpVwNnOFGAN5TMXb1DvYiSLDi4zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nKcrOlRO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4349f160d62so30416025e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 08:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733760303; x=1734365103; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=idjswr3CZVaGYQninP+vbzfJuDUomFBTKvCN0oZEZio=;
        b=nKcrOlRO2DA/TrVXmxLcDR2AubyhASN90gogsHsPukEGqSUwmT+10lq2kTGC9047G1
         hh0qtVXzgma+0301fvfGWweCyJFI5RWs7/iLXhGcfiklnVtK26S9D8DXFzYWC7p2AdP0
         Lu7vOa47BrpIRBVS8GGTDa/k3c2vwfVcoGB4vyTG1J4lgE7tKcbxXcRsfdbDTAXvdmeG
         3fjavh+E8TcO541bzJtQmFRe1nglHAYC0voozNiyb4iG6GR4oHAbELZrt8AMlqqKtmb2
         YxFE7So3TnFBsXyDXwWkb+ka9jVUwRMnbqFwEVOqXSGcAw2Q8dW9unRdIYREH8HrHJZx
         U2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733760303; x=1734365103;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=idjswr3CZVaGYQninP+vbzfJuDUomFBTKvCN0oZEZio=;
        b=nTBZKxONNaqBA0NLalo/XLRMlO0xVR1zk973k/BEYfHD6L4sQUF0WrABfJRqV4sbUw
         ux/c3e1+loORtyJRC+NN9bg9SwLNVAQROFJn/RaKTbXDhsVUZRUzU5j33R4kTZpRvd8e
         lOHphN9zS2PTJaM6lf1Bf9uyU/gBHMvfQJsug0RisGjBTGiE5iisU5piKVwZTnxl3HDW
         Np11HEi5bAQXKQAXyINM8c9kSHnkvfXwdwxCs57p+czIGqulpq+do1PQkj10GqCivEoc
         4TC284O78sPpPW3CRagm9cefbAy6jlyo4aUO3OeR9iWeQK2cVPzojyzwtBTEiL4iMx4K
         LC7A==
X-Forwarded-Encrypted: i=1; AJvYcCWRX+QTPUVwsvAsVX/bmV6ObPhSS+UYXfe4Jt/th00XLYevmhEdVOWIS5HBYy0+oxjNJXe7P19c5qk3MLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS8YIn3TE3NH//pg2Nz6F7i8L45+QvzA2mMlzCYKNHmGMIJRKb
	9Lk040XO2yU6XZbBa0fgcVKhmzZQUYEZW1fMpgH+Go8vYsIKYi4soE6dRktOUb4=
X-Gm-Gg: ASbGncvSNxYOnb2vGIayJNQPpTvNubGqxxnPZ6eGr7jGXZfuguf8K/f5Mn00hxidpNV
	4ilJ1YBsU9tChxWRg0wtkihJThLUVzd0oL/lkIDW3o8mSX3dKt0PJebR07BpM7vy3m9Gfu0KZTY
	Or4jXH6MhBYfWea9zPPVcoNtYEmimtdqFOBYx7+XnwJMiBGagRPLukVl3wf1Z4NhvnUR9exGI/U
	kgZjgsRWWozAerCV+fZjm8eYpOsSJcaOQxueVlqnXckxvowN8/sMZPoThJ+Nwpm
X-Google-Smtp-Source: AGHT+IFxmJwOIZdSDCITBs7oFnEjBxY6Amfn6FoL8IA0PX5snnp8jJg+2IGwONPosv/ODGNfFL0F5w==
X-Received: by 2002:a05:600c:1d12:b0:432:d797:404a with SMTP id 5b1f17b1804b1-434fffa2ad1mr8902035e9.22.1733760303044;
        Mon, 09 Dec 2024 08:05:03 -0800 (PST)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:432b:3c3e:b17a:687a])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434f3d89b75sm61459015e9.15.2024.12.09.08.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 08:05:02 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 09 Dec 2024 17:04:34 +0100
Subject: [PATCH 1/2] reset: amlogic: aux: get regmap through parent device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-meson-rst-aux-rework-v1-1-d2afb69cc72e@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2997; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=GIzXS2CMipBruUg013x80hnunrhkIkK1Hy8qrpszX8M=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBnVxUrYW638WrIiCr42AH4JqorjA4A+TLUZqfdJ
 0cE5/fWf0iJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZ1cVKwAKCRDm/A8cN/La
 hT1WD/wJ6B/JrH/0Q+H6hMUfb52yQg381BFefDiZ+hYlFFSL2G/5ELCs7skolU4LuewUJ4kYYlO
 73Lgt1ujDqW6CJhhdzDCeqqMXrPuXjX5OHdcP9uB78toj45dBkSJPwSiALZORP4IMCg1gehyy1E
 6sBd0VUvAjT1b3abHb/tDmDrdY5O381LR7/eQvWquiXl1Q9YoamWtXsnoQO4BO6oHzXXtUxNjs7
 d8g3SFiIUSkz/tB+ruYtiOhYJeOAeUA/uaAp4ViGHyIgHvE/U8a2wX4C6wpWRfuHgce0Q6IxQSA
 nWGCU5bWf5oAQ/GNrEC/0EPKPWzgrqwIcq0Wbxj/W+FgAL9ckUa/USHn+xtYLRcGpFGCN/2DAlL
 IoCifTNiA5iVmZVveeFhRqvLpzN30iRltEkRI+Oqf9Rtn5v3uyU7mCUPbmMkiTaTuMTyLxB3YPu
 IHTFzpqaH8FxnEDAkUsA6TKPO6lfL9Rucz5qm55Nw7Hs36IzonVAwwoVjwYwfgQUkibZ9EJYkvQ
 C2PhkeHy+5dM5CDNfRpaIaGCDBE/ISd8HMpJiYJdsoZ19Ln+bGCGZa8MeX2fAY1mr/wqjghxnJ5
 TVLHtTxaXfyFoPDzbllL9HKjCAdU+64YDXCeDPxh53FLzWyWkGsQ48kVQ+WTRIp4Art0Z6r9kN2
 IAt5sbbUECe72WQ==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

Get regmap directly from the parent device registering the
auxiliary reset driver, instead of using device data attached
to the auxiliary device.

This simplifies the registration a bit.

Suggested-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/reset/amlogic/reset-meson-aux.c | 36 +++++++++++----------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/reset/amlogic/reset-meson-aux.c b/drivers/reset/amlogic/reset-meson-aux.c
index 4b422ae5fcd209e1041e9a793d980627203d00b0..0fc1788eb7a83810ac524facfe09b5fa032573c3 100644
--- a/drivers/reset/amlogic/reset-meson-aux.c
+++ b/drivers/reset/amlogic/reset-meson-aux.c
@@ -18,14 +18,6 @@
 
 static DEFINE_IDA(meson_rst_aux_ida);
 
-struct meson_reset_adev {
-	struct auxiliary_device adev;
-	struct regmap *map;
-};
-
-#define to_meson_reset_adev(_adev) \
-	container_of((_adev), struct meson_reset_adev, adev)
-
 static const struct meson_reset_param meson_a1_audio_param = {
 	.reset_ops	= &meson_reset_toggle_ops,
 	.reset_num	= 32,
@@ -72,10 +64,13 @@ static int meson_reset_aux_probe(struct auxiliary_device *adev,
 {
 	const struct meson_reset_param *param =
 		(const struct meson_reset_param *)(id->driver_data);
-	struct meson_reset_adev *raux =
-		to_meson_reset_adev(adev);
+	struct regmap *map;
+
+	map = dev_get_regmap(adev->dev.parent, NULL);
+	if (!map)
+		return -EINVAL;
 
-	return meson_reset_controller_register(&adev->dev, raux->map, param);
+	return meson_reset_controller_register(&adev->dev, map, param);
 }
 
 static struct auxiliary_driver meson_reset_aux_driver = {
@@ -87,11 +82,9 @@ module_auxiliary_driver(meson_reset_aux_driver);
 static void meson_rst_aux_release(struct device *dev)
 {
 	struct auxiliary_device *adev = to_auxiliary_dev(dev);
-	struct meson_reset_adev *raux =
-		to_meson_reset_adev(adev);
 
 	ida_free(&meson_rst_aux_ida, adev->id);
-	kfree(raux);
+	kfree(adev);
 }
 
 static void meson_rst_aux_unregister_adev(void *_adev)
@@ -103,24 +96,19 @@ static void meson_rst_aux_unregister_adev(void *_adev)
 }
 
 int devm_meson_rst_aux_register(struct device *dev,
-				struct regmap *map,
 				const char *adev_name)
 {
-	struct meson_reset_adev *raux;
 	struct auxiliary_device *adev;
 	int ret;
 
-	raux = kzalloc(sizeof(*raux), GFP_KERNEL);
-	if (!raux)
+	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
+	if (!adev)
 		return -ENOMEM;
 
 	ret = ida_alloc(&meson_rst_aux_ida, GFP_KERNEL);
 	if (ret < 0)
-		goto raux_free;
-
-	raux->map = map;
+		goto adev_free;
 
-	adev = &raux->adev;
 	adev->id = ret;
 	adev->name = adev_name;
 	adev->dev.parent = dev;
@@ -142,8 +130,8 @@ int devm_meson_rst_aux_register(struct device *dev,
 
 ida_free:
 	ida_free(&meson_rst_aux_ida, adev->id);
-raux_free:
-	kfree(raux);
+adev_free:
+	kfree(adev);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(devm_meson_rst_aux_register);

-- 
2.45.2


