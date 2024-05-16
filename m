Return-Path: <linux-kernel+bounces-181208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B296C8C7902
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C9B4B20FD9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DE914D44F;
	Thu, 16 May 2024 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uiqrYctu"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D8814D6EB
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715872137; cv=none; b=VMcpveOjGU8HqHSt1wes7gd99osv319SyT1geuj3r2N/OJ0QadiuDreP1kgHR+guPOS6ZCgSPRsobUXSTDPJHfBtWF5+OyY08XLmFFLstuYlO5YXzfXQVFnnGCGVrxBS2bTmIcHfFOcyjvZywRLU9DiGykk8Qj2CAp7c3kQPNa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715872137; c=relaxed/simple;
	bh=iaknELToT+8y0KfW1nvtsEVAwfzQue3+xA6phI3OqV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQXGwq6M+FjUIp4+mIOUz2mH/3Myxb5jojsYPk3CL/k4TuN1FS6IPcU8iCCP7mD3iqqeMERiLFR2VnZmyG/ufyIZmYFfZ8g5Kd9RIgaN4rc25Gv04BByI2FdupP6DbAZ+tZhpKmEm64FiHwFapW5FBklzBQBMYel6s8z9Ggc1UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uiqrYctu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-420298ff5b1so9464025e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715872132; x=1716476932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKLxWZMdcIpvnKpiYpSqkgcStnHEt9yT8sCcERiOd18=;
        b=uiqrYctuTsCr0cP46z67CvPT3Av3VYvAodWSJPVzI4bSDfJbHMWx41e6sCxSWmAW2V
         gNvh5WxQUcTUE2R5zFhfMQrP28R8lXZTbvIVwQwdB3akI/909gBnZIxtg/8uZUoTnGTa
         K2oTOgjvKJfwzmSUSYVbDl3LdRPyDiHQsJqlqn23b82PT8fkvvWmYGJAMzynWlFlpq+R
         4cxD/QHcP6qNR+Fl1encudwEu/qdvPgrpfjqMl3BUAYpYsIA7VSyhV3mFsy4/gfEYdmk
         gw2I4hVxMGfyP/kg2KwKUCV6HKtZr9ggM3W0QFnj8fuebAbwnpjoV8STvxdRxhDoJOAK
         AE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715872132; x=1716476932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKLxWZMdcIpvnKpiYpSqkgcStnHEt9yT8sCcERiOd18=;
        b=qOrfxtKJvUWN0c+b7WmfseYVz0Ga0XA8amsJ5meGV/hUWp1v8LjexkC7cnXvbD4r3U
         /mP+jTYy+dexp13M2Oe2oKHVfECqZX+zMgAmZmTF4ivrw2DQ7kLCypfYHal5F/QX2xCl
         zTzFTn4cWzAaONn0jwKITfat37CsO9ZrTyPHWUB2uRhHAlIV3DSDQ4HLdK/IiFkcSJ1r
         CNwE4gCUqCVW6UomP77WHM2sBEf1m/kJjbEQVD7sXbgU4k4NZIVErffOOyY5Ji1NkFOT
         U8ihie/pQr6+/o7Yo5bDtwAAPySUu75SIKklAXW4c/sAhjgw0Yy49FXSZf1pfzYEQeZl
         37gg==
X-Forwarded-Encrypted: i=1; AJvYcCXe8eGJWoE81dDS7+u+1WPom6SoPi+R6FVDmT8JPe7vcHl/HvHGZ3+sP3DHdBpTE5SObq+AglSnjSircUgKzH4EIzdvo8OnVqBym/IW
X-Gm-Message-State: AOJu0YyzaeEs3zckw0qJuv7L2Yn+jvY9zVcuPn1dFCA0sCnvxP9lMvLM
	xOgWQXmXsWAZc+wL5D8NkECjcE7scH9/gOpehWx3FkAX5KNSXp2nqEeHWCk00VQ=
X-Google-Smtp-Source: AGHT+IG/ykFXrbe/CvlsHN4du9qU8bGGEbwc+8VNXOgZYoQoZ5vQI4mqtGU2dnI3Uc7WqDGAtugK6A==
X-Received: by 2002:a05:600c:3594:b0:41f:e10f:88b1 with SMTP id 5b1f17b1804b1-41feac55eccmr187308155e9.27.1715872132571;
        Thu, 16 May 2024 08:08:52 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:1fce:7e5a:e201:edd5])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-41f87c25459sm309351725e9.18.2024.05.16.08.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 08:08:52 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Jan Dakinevich <jan.dakinevich@salutedevices.com>,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [RFC PATCH 5/9] reset: amlogic: add reset status support
Date: Thu, 16 May 2024 17:08:35 +0200
Message-ID: <20240516150842.705844-6-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240516150842.705844-1-jbrunet@baylibre.com>
References: <20240516150842.705844-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

Add the callback to check the status of the level reset, as done in
the reset driver of the audio clock controller.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/reset/reset-meson.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index 3e0447366ba6..65ba9190cb53 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -69,6 +69,23 @@ static int meson_reset_level(struct reset_controller_dev *rcdev,
 				  BIT(bit), assert ? BIT(bit) : 0);
 }
 
+static int meson_reset_status(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	struct meson_reset *data =
+		container_of(rcdev, struct meson_reset, rcdev);
+	unsigned int val, offset, bit;
+
+	meson_reset_offset_and_bit(data, id, &offset, &bit);
+	offset += data->param->level_offset;
+
+	regmap_read(data->map, offset, &val);
+	val = !!(BIT(bit) & val);
+
+
+	return val ^ data->param->level_low_reset;
+}
+
 static int meson_reset_assert(struct reset_controller_dev *rcdev,
 			      unsigned long id)
 {
@@ -85,6 +102,7 @@ static const struct reset_control_ops meson_reset_ops = {
 	.reset		= meson_reset_reset,
 	.assert		= meson_reset_assert,
 	.deassert	= meson_reset_deassert,
+	.status		= meson_reset_status,
 };
 
 static int meson_reset_probe(struct device *dev, struct regmap *map,
-- 
2.43.0


