Return-Path: <linux-kernel+bounces-352529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF6299205E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 20:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB472282012
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 18:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1B118A920;
	Sun,  6 Oct 2024 18:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5bTd64W"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1621A189F56;
	Sun,  6 Oct 2024 18:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728238869; cv=none; b=XCeHHlWD+E5e93pUgZlGZO+I5r9PQy0kdKWSSC2a9jj5beTIV8BPr9GjzhXyntU4GoVbOkfD09BCqLsAye7iyrvcWgXrY3nXHJF/scBIOmYUqsf/jrxIZQSDIGzGVYDemAkNfnpHWpXG5WxLEr59xSHW7wYS54B9e6w37sDjO1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728238869; c=relaxed/simple;
	bh=6b1p0XluODvkmpa21j4OVA1qaLtfm9IKDiiyUx6XmBE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HSXL0YebQVMyauKr1+UW78j4UIUW7NSmRwnJT7uVOh9+tbXlti7exisakyA8P9flfL41QI7NtTAKbHHBZOuGjV1PWQGLK5zhFVX8U/ChgUDTIi0JFLvZnFq9ssDbkshuisqvRPKIwDjuG7g+FJ2mjziHszfc0DINNaJAeaqJMDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5bTd64W; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a86e9db75b9so565457166b.1;
        Sun, 06 Oct 2024 11:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728238866; x=1728843666; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0lAbK3XSMtWaPGPtD0E9P9CrTXsVrlCnkPMgMQ8xgX8=;
        b=R5bTd64Wlz+I827zgvqFlOrkodoHFQdpmLQp99ffS9ysv3PuUrJvLZwjClTwnRxN6s
         N7wZ7aiPvOQHQlX65IOZZ9N3fbqpJ367f2qqpNv2wefeiXmC7DspYdfdEfu6PUGUqz8z
         CF9kDhrGHIZWyIoMM34dL+zU29aXcI8wkuQ/QqWDECmGxbPB10Ibv9YNOLfQ1rbGvzWd
         xX4wgT9Oiq0QJsBg85GriaYQLDeo7KohcQ9gH6yNjgp0LvaS5IHGH/+nZkSYgpT7lPxZ
         jyxvdp3mtTz7xWTgcyw9YL+HW/jdxxjNWgfXwlcU/PTdJC0AMnr5mu19Zd6ifw6XV8vG
         X4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728238866; x=1728843666;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lAbK3XSMtWaPGPtD0E9P9CrTXsVrlCnkPMgMQ8xgX8=;
        b=lq2OGjExOLcukuyJyYQuxiObTVuHjU0D4hn0m3b3qKdzxfvC1AZmCfh8bSGIx/JAfe
         SNwO9nHqNOJPPRhdWEIoEp1pY3MWq5190n70K+/wDF8g6KArjS2lWTkkYISwyV0cWsoz
         z+dS0qrREY/JpmyNS6TC254P0+BqMWz6mCKOMlg+TkMl/da91A2yvTx/RwslMMPSDyUJ
         0Q7fNYp+/8nfQFK7qE2NQHjDHhr/KbV5RNuIm7AgjtTb0KJGHiYmmzqmH7UP3rNzq3Wj
         0T3IJ7vOmUxebfYMRH4fyQ0GCgAWR1u3ltcAsOqg2YNsEVlSu9lsJxeKEbbmjDBqYz9J
         OqDA==
X-Forwarded-Encrypted: i=1; AJvYcCVLRROY2jN3M2JeuNANbRtu9fCTOW4b+yapQEG3UY/G9eJKHCiZ/QushfbdjTEzDwhTtQD+QS4gynEPSlO4@vger.kernel.org, AJvYcCWbQ3IEpXLnmJV7MIvSBBbVF0isUfCaKM4eIoIP1ndWegxmThAWxIV5fzW/9SQKNOex3YNI3qPv/zTQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyjGaGbpTbv39pMfefF4TyehPuolrwucy7mcGgJq8BXex7F0bvc
	LSXUQcAgWM0vrKYPFRcdUhTbXcHq7b82g/jgiHTOq0JbydKhsbWj
X-Google-Smtp-Source: AGHT+IG4xL38eaERTSDCvCZoFEEh0wO4U73qoc9yIyvpWQBwHD0rpPJ2DnXvrWw23iuwsXFy2w/0OA==
X-Received: by 2002:a17:907:e260:b0:a86:9776:ef40 with SMTP id a640c23a62f3a-a991bd46213mr885089266b.36.1728238866063;
        Sun, 06 Oct 2024 11:21:06 -0700 (PDT)
Received: from [127.0.1.1] ([109.126.148.51])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a992e5ba407sm294080866b.14.2024.10.06.11.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 11:21:05 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Sun, 06 Oct 2024 21:18:19 +0300
Subject: [PATCH v6 1/3] drm/mipi-dsi: add mipi_dsi_compression_mode_multi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241006-starqltechn_integration_upstream-v6-1-8336b9cd6c34@gmail.com>
References: <20241006-starqltechn_integration_upstream-v6-0-8336b9cd6c34@gmail.com>
In-Reply-To: <20241006-starqltechn_integration_upstream-v6-0-8336b9cd6c34@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728238859; l=1942;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=6b1p0XluODvkmpa21j4OVA1qaLtfm9IKDiiyUx6XmBE=;
 b=XAnDW0by1ALFI00WOPyrjqaPYUbVAeqcn0AekhHNvwv07u+NG+W917AUol2wP6F0ldlrNSxmM
 DbuNtRoe8I4AuxEBZascZV9F5p3UJ3rosAHCFrnJy79n+ZBDRB8fdJO
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

mipi_dsi_compression_mode_multi can help with
error handling.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 16 ++++++++++++++++
 include/drm/drm_mipi_dsi.h     |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 2bc3973d35a1..d8ee74701f1e 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -1520,6 +1520,22 @@ void mipi_dsi_compression_mode_ext_multi(struct mipi_dsi_multi_context *ctx,
 }
 EXPORT_SYMBOL(mipi_dsi_compression_mode_ext_multi);
 
+/**
+ * mipi_dsi_compression_mode_multi() - enable/disable DSC on the peripheral
+ * @dsi: DSI peripheral device
+ * @enable: Whether to enable or disable the DSC
+ *
+ * Enable or disable Display Stream Compression on the peripheral using the
+ * default Picture Parameter Set and VESA DSC 1.1 algorithm.
+ */
+void mipi_dsi_compression_mode_multi(struct mipi_dsi_multi_context *ctx,
+				     bool enable)
+{
+	return mipi_dsi_compression_mode_ext_multi(ctx, enable,
+						   MIPI_DSI_COMPRESSION_DSC, 0);
+}
+EXPORT_SYMBOL(mipi_dsi_compression_mode_multi);
+
 /**
  * mipi_dsi_dcs_nop_multi() - send DCS NOP packet
  * @ctx: Context for multiple DSI transactions
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index f725f8654611..94400a78031f 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -280,6 +280,8 @@ void mipi_dsi_compression_mode_ext_multi(struct mipi_dsi_multi_context *ctx,
 					 bool enable,
 					 enum mipi_dsi_compression_algo algo,
 					 unsigned int pps_selector);
+void mipi_dsi_compression_mode_multi(struct mipi_dsi_multi_context *ctx,
+				     bool enable);
 void mipi_dsi_picture_parameter_set_multi(struct mipi_dsi_multi_context *ctx,
 					  const struct drm_dsc_picture_parameter_set *pps);
 

-- 
2.39.2


