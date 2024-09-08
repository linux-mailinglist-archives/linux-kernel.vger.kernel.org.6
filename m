Return-Path: <linux-kernel+bounces-320263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD1297081F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 16:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1115B215DA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 14:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33889173357;
	Sun,  8 Sep 2024 14:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lYbs9B4s"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E915F172BA8
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725805316; cv=none; b=hidEhUbMsgIVi3+jA2/zmT9uAVph5aCSCKbJM6SYLOazN4C+K+e2t2rIbwzVpt2mLbQwC3MVXREPl4bZFheP699ONfXIQ60kCs7XufhWlDAtw/V+hrhCWT3rwONreGRezKcJ3KLHZSFONXzHc7PKBktgzOiuu/Rs2/2taKMiBYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725805316; c=relaxed/simple;
	bh=fRgUGDqaRoZtIl+WHmIGQHM80N5JZYutQfaDHkXDk08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WZVzcoe/DqE77WsQb37MczyZ+jnWVovsbwWgoWiteXgQ03z/wI3wihT2Z+BJQ5R7onjoYa/vdVgPJWHmca39pdNXnxXRvJH1N+YJ0DSIiK7+oOtiqawl9+/bGFFjQS+fhpddyYUx3470D/TewNmU+5iRyyntfa1uoKREq+4vEzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lYbs9B4s; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cae563348so1906185e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 07:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725805313; x=1726410113; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=opqWrHh+Ch6fI6vTB63ZLyRaFP0rdq6mZByygqOLt7w=;
        b=lYbs9B4spmGFgSBI8WBXc65V+nbJzSJAtajb1xtFOK38ffvMDe4nJtAqUAPSzeU463
         jxohy+/IS+MNUtOWiIIuDbOqeztQ6Upj3HwRP2tHOrz9wAuoijkRM1bSVG/+2FTa9vgc
         tDXCPb+f6yqxGKPX9hX/BrekeMD3IN7ecrqY8uTxOsvfcyPUqITDeT6RV0ILfwemJQSL
         B9NMuNU/H6yR/M3RY4wNhaL8mt+9vpND39CEDIhiqpdiBuQopo15Ooi034yJj8mL69cR
         ud3mKUppoU5KPHw8GnxawR/f8HnMhlQaXRoMu+fTG7/+Nu92vbEgdHNN+M2qJIK/mX9+
         nx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725805313; x=1726410113;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opqWrHh+Ch6fI6vTB63ZLyRaFP0rdq6mZByygqOLt7w=;
        b=buTn9CNsv52Tk1j8PvzG//nCA6aO3CH4w09Fm707UC9oxi/2ZMRBXUOtlKVYYQ1S4H
         nRpJpgn9x32ggAcEYaHJ/u6rTxVI8VfMd6a1A//Tu85TRGij3WPgxSYPfVjy+s/v8llf
         rT0rYm1UfQZsTNglvNrF8HY6XIOagpzA9pu3zdhC35ZKM25/cmGJ/kBkDpTnVdKlmDmR
         0N/QmHJKVw/xTO6ExHsiOCVVtxUvgzLMTZ301zKGsrhqfTKvWwUjZSj7zeesUsi62wWF
         jY8ygBtK6iiD2XLNErh8ahvt2EP2ID/Bo3Rwd74AsjPwB5zWBFLwgaRWlQcB/8Gaztiy
         gL0A==
X-Forwarded-Encrypted: i=1; AJvYcCUL5nBYd3WupzjSTfcY0ShA8cX4Ssh1sDCcPkBtSdyqMDlrZPUKHewjvcbgVnJKjJ9mFCUQmExOHgldVqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ0ZSUU6aPRxPHExBHtbAP6PoYK5NkNnrDJI+X8BrrAtzq69i6
	v/qkXKb//c1Bb8m1TYzh7W7DKbTfQ3kstl4hU/nKwidZ+8idM3LTcJ3AnhcLPxA=
X-Google-Smtp-Source: AGHT+IHk8lX+IYMMyPu1J/51I1ma3xgJuFFXQvGLe9njZslD8gy0z/8eNeprhovuMvXcy51jKG/AEQ==
X-Received: by 2002:a05:6000:4012:b0:374:cef0:fd3b with SMTP id ffacd0b85a97d-378896d9cb1mr2543013f8f.7.1725805312996;
        Sun, 08 Sep 2024 07:21:52 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675bc9sm3465092f8f.56.2024.09.08.07.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 07:21:52 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 08 Sep 2024 16:21:33 +0200
Subject: [PATCH 3/5] drm/fsl-dcu: constify regmap_config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240908-regmap-config-const-v1-3-28f349004811@linaro.org>
References: <20240908-regmap-config-const-v1-0-28f349004811@linaro.org>
In-Reply-To: <20240908-regmap-config-const-v1-0-28f349004811@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=773;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=fRgUGDqaRoZtIl+WHmIGQHM80N5JZYutQfaDHkXDk08=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBm3bL1Qv6Igmg4XEMVNhOLdsVdTsUR1ueqJ3Ovb
 bpFAYP2+5SJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZt2y9QAKCRDBN2bmhouD
 120OD/0T8cOrR9KrPkxGh35sFSSSYkDyfJm+7NO4H+CL5+6LxsJSQE32qyrJBthu/NHaSb0FOrS
 DuOXs0fccV7E2KOD0uWG1qqTFo1p+lRlt6xYtbe5JNCxa2Nb5Zyjj76X5BGxhnjHZwU7E/lVJDz
 UAKQC97zY7Lg5q0ipatllnHQtpXMxb9HzSbRpUO8nYrjKkFwTw9630C8UK7u7SG2+F3A+gEE27T
 R296FzEoWCTMK2XNdVIzoa8ReBXqqbA5OtA0FwjYu1NeORxZdfMyZoxVrOK6sj0K8C5PZOdiXAh
 KiGP8jZg+v/cZMqyGmMbyHn5upctXKk+zGRag4ntk3BZJILn30VGw0bEppoaWeDkmQ6QlsQlkBu
 Ez5xrnnarhQjKlcyUQ+p238dxH68dhDA3QPQ7i8U+hf7rAnNicPIYmbbPkpKE3vXrWD23XrxBZX
 1WNEXsc/idRNn+1RHHO7CsZuehyZL0TZJjbTAU1ZNWa9Mm2BbUwM+MaQxqRZr1w2tNWnk6A9UAQ
 TRSOKKX1sUFNsHOymhvkvG2J7It1/eYgYu3LKmvikixTnT7OwugUQdVVLAog52PVjM1Jojj5mHK
 cM88yx9IKD5tes6N9i5SWjkR2X7Ri5/9EOI0naJm452GPgBcBh2YQZFUC2VhKNQ3rWRWc1+ZhtU
 00CRDz+hXylwv1Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Mark local static 'struct regmap_config' as const for safer and more
obvious code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/fsl-dcu/fsl_tcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_tcon.c b/drivers/gpu/drm/fsl-dcu/fsl_tcon.c
index 9eb5abaf7d66..49bbd00c77ae 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_tcon.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_tcon.c
@@ -29,7 +29,7 @@ void fsl_tcon_bypass_enable(struct fsl_tcon *tcon)
 			   FSL_TCON_CTRL1_TCON_BYPASS);
 }
 
-static struct regmap_config fsl_tcon_regmap_config = {
+static const struct regmap_config fsl_tcon_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,

-- 
2.43.0


