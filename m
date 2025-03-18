Return-Path: <linux-kernel+bounces-565686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90118A66D68
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F6D17A4221
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F68E1E5209;
	Tue, 18 Mar 2025 08:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JtyrRaJe"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E4A1F872B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 08:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742285265; cv=none; b=iK+uni0o8VmCaiMtonOcjjPuBU2mvlsLKcIzU5iJCHNnp+QDmLVDUJ1LL9xy+24W9FKFMHgePpvLIgbJ1Yi8Ova2c20Afd2CRJDLgK1Aad5KFJ29ENNd7YbbszVsJ9vK6uMypG8C64B9ihdRjX9SJ4KNDz86ZAZFrRFhNAiHkcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742285265; c=relaxed/simple;
	bh=7/FQC0qr3nzncJkItFemzTYwa35i0ePuQ3ObQpFFzZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rItOSGmo3zxN6u5PaMp2ZK7mbL0+Hdxe+E1J+lgAfeZ9aE/dz5OH4+4ximqPVDKKp/rAnbTbHsyaq6YeI026JGyAYC7OolPSrT77XHuoy/EWSBJBPX4/h0SE+67sVo4YtmcyCoeixHq6qbWT+GB25TBcZSX56tVtfDmIcP3d+H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JtyrRaJe; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43935d1321aso1651115e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 01:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742285262; x=1742890062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sNXHg+fYs2vYclPphu41jtGXveshr859Ah2cwXoi544=;
        b=JtyrRaJejDTBHUOJNoo2A1UT97AHU3WWFMwhltS3euFDX5AO1OS3SbJHNThd02IcrM
         DNhAX/Ndi+sAVEZSpayKpshM7wvtjWZUJhtPLUNUirjti+yZdE9s9gJPKuY+8N+R8B/X
         cveA/nB0poDRLfrz27GFGp5Qz/XzYEdaYThMUfrs6maZ8IntnVo4RM5jiUC9W3120+YT
         tolUrwlvy8C5zZZiMh8Ll2O0Z/4xsu15+AvXhSFrz/VbeG6aP9dwmskh2MU9lpJWgfTy
         pPNLbDrm28m6MxYoZxtKQ11Jv86h4Jb+N5iz8DZB5WZLkbP2B0O6YB2yWupSPNI97Fd8
         CjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742285262; x=1742890062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sNXHg+fYs2vYclPphu41jtGXveshr859Ah2cwXoi544=;
        b=AAyuefNBaVAGn/y5BgELxrrSWL7w4TUkPMYs2s6N9hvD9x7e6QnyGh6qu58lbzYd4g
         WE7BrXdVsloqbAo9N2KJhPIRW3S63ZQ26GXZtuZ138enIlbmxKFG2B9/V4lo2wtaNKk6
         JbldGZyCYH/NtSkhK6N+tg/r7472Q5RArBXnOmcE8EqLKRflJh9G6oeu9B9UjUwYvHi/
         7Sxu+WuomwJeNZO5MakR/Ayn0U21tjHErffyYN6G/f8n6hEZNhuir+X24DkAIVQdf4Go
         FuTLByVNxj6SH9A+ovvOJUw+DC+apwIW0MbVxAPUlzEHyrSpsoGVVY5LGN0X7D+pGxR0
         0DTw==
X-Forwarded-Encrypted: i=1; AJvYcCUbL9Z1do2NC1wrZF9dzm6F41xaXt1sGMTwAhhE9UVxgNW48Lcm6YR2UaNVpXEcHy8b49GIRjMwgvRUoAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgMKqw+JFGLwgZZBpAefztbyGmUHZ1DT/uoONEN9M8R5qwHBKi
	GqeabgxjLH+OUbgUfhexLfE/slc8Q4kTAjHzHMsqkXjz8XdKovUUzmuect1B9WA=
X-Gm-Gg: ASbGncunjRiLB94ub6Su155Hhc8kQ73PRC7Hxd9Lnfn97uBaCtAMChQ9+VF4eqcrveh
	8bYc32EHCjCaQ1RQHkQBCpxe2gO55hmdu/kcJel/+LJ+yGkr4skM0864PB5kOoI3up3fhIYnzqN
	mz2wfx9ukO5xusu7ZKPkXmsOC9AB+25XW0hnu/0sXEHVPnjmcS//BdMKKVTjHiH4rVuCc2P5VAe
	ekOJhzrCiTXaJucGKb+YPnKUQ3h+Xt4uzRrcqQGul7NRqtRc4qhkEl/rS4BL/NUcgfZPNpBpk2h
	F/3CSoQYcapsBWvxPImJMfJq66phfHf2ktxF5ARHXPX2pZQEuy6hSocizA==
X-Google-Smtp-Source: AGHT+IFwlyR0auz4mcdACDhys146VQDwS7zQVk+tqjA/y7Na6v0bxrpeypR8IICKSK0Vi8hm17Mb1w==
X-Received: by 2002:a05:600c:871b:b0:43b:c962:ad29 with SMTP id 5b1f17b1804b1-43d1ec6544fmr65619435e9.1.1742285261948;
        Tue, 18 Mar 2025 01:07:41 -0700 (PDT)
Received: from krzk-bin.. ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c4f9d59dsm17389527f8f.0.2025.03.18.01.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 01:07:41 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Inki Dae <inki.dae@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] drm/exynos: exynos7_drm_decon: Consstify struct decon_data
Date: Tue, 18 Mar 2025 09:07:38 +0100
Message-ID: <20250318080738.29292-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

static 'struct decon_data' is only read, so it can be const for code
safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/exynos/exynos7_drm_decon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos7_drm_decon.c b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
index 5170f72b0830..f91daefa9d2b 100644
--- a/drivers/gpu/drm/exynos/exynos7_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
@@ -43,13 +43,13 @@ struct decon_data {
 	unsigned int wincon_burstlen_shift;
 };
 
-static struct decon_data exynos7_decon_data = {
+static const struct decon_data exynos7_decon_data = {
 	.vidw_buf_start_base = 0x80,
 	.shadowcon_win_protect_shift = 10,
 	.wincon_burstlen_shift = 11,
 };
 
-static struct decon_data exynos7870_decon_data = {
+static const struct decon_data exynos7870_decon_data = {
 	.vidw_buf_start_base = 0x880,
 	.shadowcon_win_protect_shift = 8,
 	.wincon_burstlen_shift = 10,
-- 
2.43.0


