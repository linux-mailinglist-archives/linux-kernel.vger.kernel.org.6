Return-Path: <linux-kernel+bounces-423551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 848969DA99B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44792281D56
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6921FDE1D;
	Wed, 27 Nov 2024 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VOYlmv8r"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D931FDE00
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732716294; cv=none; b=I3G0Xu+zn3tzgce2kdvJtJFsExBVNNe4+uiY/ctvuQ/IZxTY1b4OEMCJWwO25ZmHqszt+s9olpQN2Ubr44iTCnnLjoFo9zFwMZTS5gfzPhz3SXE9z1ZpMgfKbkoKjgtRwLNdEUD5MWEyzTNseNOmXvKH0hT0nIk6EtHncq55rpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732716294; c=relaxed/simple;
	bh=ErNLlV3VyQUaeuBrJa+IVJY8nm3FUxVk1dHk6f1cd6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LKfLR2NtiXlmUW/mFZYmf5qLqREyIm4xwg9KgsBwEsuW2ZQpAp2sWjfpGLxQ9OvxMlaLpIn0idL+Ty5Im6wzZXBiKwKLkMooSoutIVvugjuaaLyn8dNgzDgdMFP/B3LBUVCCw3Cvv42hc38lxqHTiBqolpz5Nv+UZeaF5GGMiqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VOYlmv8r; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53df1d1b726so596821e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 06:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732716291; x=1733321091; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rzfmmxXcC5nfkCV4gc5yUHDuhltopU/HIPPIiYJqWlY=;
        b=VOYlmv8rflYPVxhVXHH9/uvm4bJ0Ak1BmmrtHrv6iWNJvzNbCEf+4RX28fy3OWAy/i
         osw+xWf1KcGvKFefLZ72MgR8CqI8vqa0F8rqOzviHKCGlRh4wlk6MFGqSH9p/SwiM8Cg
         LY00SZ8P04vE7fug6dyDuzXapC1STCQnZKGC1xP2zwKCTuzY4Ps7ZrTM9J0TDpn8Ze+l
         9xar4OL3jH0wCp9owDm8Z5CHeaUaYwAICWHKoXeOhqv73FcRUfAwkXnK0N0BZ4FnK+5N
         daT5BT888cLJ4Ck7/ZboMNqVCVy3WfDqIp3YpOYwA+mYbP0vBvQh4HoGIlFOCGVghN4L
         97ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732716291; x=1733321091;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rzfmmxXcC5nfkCV4gc5yUHDuhltopU/HIPPIiYJqWlY=;
        b=ZlArfG+q2DbiCelAkjEZJ2s14W/a3wdm6NO9A+E2JtIJ2yab/PP0BSGGf3w8ApWONu
         MziTSziXVlwFwBuT0RD90Wdg7lqN5F+XqCTowCEODdpg8GwNfOnt5ZVlj0paJdbAW5gi
         GZbwlSKoHS8jOoBTConR2wLtzZ2igv+XBL+AaFAJF/+gO8gCtpSHyY8OxLvkm0oqCFqp
         t0P5ZjzEbfADN480fOO39AKmeiRGCk/eH00RHNtT3XI5bNgcMZIM4qELciupcC5cA4ah
         Kdj1pLZwV/AGt3fwcnb6T4v9i43Meee7bsRfcDNY7VN2mTJBCwExQs0VorTipia44+dA
         filQ==
X-Gm-Message-State: AOJu0YwHFqCu10WJ8LRtwy9Fc+KFo0c9MXTLpjuCGMJjH3MQiQJx+LJY
	G+JFiD2spHye7/axkfJzn1FdxIoDKuVXGgYDk2B0KyICxEG0GxJ4uQa0LSBZeq69zBmCMxKHwd7
	o
X-Gm-Gg: ASbGncsCcKesyiACXFb7fzJ+o7NPnD8TnJD65WLnCdPQZx8ZnttygouFxGHq6azGZBh
	IEiuGpRI82uZdpocGKECykKlktJXbGBUA8sHxoxnkfKVP2NdCbbKY7RW+F2nZ5d6343C4oyEJop
	GmJEsVXxo8pFvYUkKYMt5WQgUqfXO0fGPUWxETO+H4it/h3OnghRhP/bhos/OY7PdPLRueWN4Fc
	WwkY6FH2ir3Umd0cCei1vBNvN+tGjdfChV7dE4n4W1uFrVV89Eez9Q5fw==
X-Google-Smtp-Source: AGHT+IE2Yz6mOY37264WsE3DpCDAykgqJRgeSNe3trAvSeoBcV7ImxZGXM35npt/8X7BY4n/kF3gwA==
X-Received: by 2002:a05:6512:ba6:b0:53d:e5fd:a44a with SMTP id 2adb3069b0e04-53df0112217mr1863531e87.54.1732716290684;
        Wed, 27 Nov 2024 06:04:50 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd44cb7c5sm2157291e87.122.2024.11.27.06.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 06:04:50 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 27 Nov 2024 16:04:34 +0200
Subject: [PATCH v3 3/3] drm/msm/mdss: use boolean values for macrotile_mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-msm-mdss-ubwc-v3-3-9782a7c2b023@linaro.org>
References: <20241127-msm-mdss-ubwc-v3-0-9782a7c2b023@linaro.org>
In-Reply-To: <20241127-msm-mdss-ubwc-v3-0-9782a7c2b023@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Connor Abbott <cwabbott0@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3073;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=ErNLlV3VyQUaeuBrJa+IVJY8nm3FUxVk1dHk6f1cd6s=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnRybz5EfeQNFPp88Ula96PZeIRf/rzwux4YPIF
 4srT6SRd8eJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0cm8wAKCRCLPIo+Aiko
 1c/GB/4mwY3uWvHXGyq/FbPpZu83Lz4gH8Aux84nF/nOP7nQF3NArHkTbPL2B3q+8GXtGQj78EK
 qp7oH7AJiyd93pxBlsc1KdkNxOL9QGZnYxnZsk/iCYPXzGsdnqVY+Xj47Gb9NAtX/5tNRbwX+HP
 nQaABEz0l44nD6C8RPgzdx/Lufo9hx6tf4+x2m/LR6CaDZOpyD1mJPQA917YlqkpuhXBnE4XvZA
 c3zy3IfY/01wXEzbMBNBcM/gstwVu/tN/J17OHIy8qy/wKiYU+20JBK521KzalJWM1JHqQyOHFu
 AGuV/fzcBvSjXKwogKpufaDGitf2gu9xGh5fuhQGHoW6KiBL
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The macrotile_mode is a flag, not a bit value. Use true/false values to
set it rather than 1/0.

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/msm_mdss.c | 16 ++++++++--------
 drivers/gpu/drm/msm/msm_mdss.h |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 87ada64133924d712810c644a5ff660a082c2abd..6dbeea860abfa1cad8e1da926c66b825938933a0 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -588,7 +588,7 @@ static const struct msm_mdss_data sa8775p_data = {
 	.ubwc_swizzle = 4,
 	.ubwc_bank_spread = true,
 	.highest_bank_bit = 0,
-	.macrotile_mode = 1,
+	.macrotile_mode = true,
 	.reg_bus_bw = 74000,
 };
 
@@ -607,7 +607,7 @@ static const struct msm_mdss_data sc7280_data = {
 	.ubwc_swizzle = 6,
 	.ubwc_bank_spread = true,
 	.highest_bank_bit = 1,
-	.macrotile_mode = 1,
+	.macrotile_mode = true,
 	.reg_bus_bw = 74000,
 };
 
@@ -615,7 +615,7 @@ static const struct msm_mdss_data sc8180x_data = {
 	.ubwc_enc_version = UBWC_3_0,
 	.ubwc_dec_version = UBWC_3_0,
 	.highest_bank_bit = 3,
-	.macrotile_mode = 1,
+	.macrotile_mode = true,
 	.reg_bus_bw = 76800,
 };
 
@@ -625,7 +625,7 @@ static const struct msm_mdss_data sc8280xp_data = {
 	.ubwc_swizzle = 6,
 	.ubwc_bank_spread = true,
 	.highest_bank_bit = 3,
-	.macrotile_mode = 1,
+	.macrotile_mode = true,
 	.reg_bus_bw = 76800,
 };
 
@@ -689,7 +689,7 @@ static const struct msm_mdss_data sm8250_data = {
 	.ubwc_bank_spread = true,
 	/* TODO: highest_bank_bit = 2 for LP_DDR4 */
 	.highest_bank_bit = 3,
-	.macrotile_mode = 1,
+	.macrotile_mode = true,
 	.reg_bus_bw = 76800,
 };
 
@@ -700,7 +700,7 @@ static const struct msm_mdss_data sm8350_data = {
 	.ubwc_bank_spread = true,
 	/* TODO: highest_bank_bit = 2 for LP_DDR4 */
 	.highest_bank_bit = 3,
-	.macrotile_mode = 1,
+	.macrotile_mode = true,
 	.reg_bus_bw = 74000,
 };
 
@@ -711,7 +711,7 @@ static const struct msm_mdss_data sm8550_data = {
 	.ubwc_bank_spread = true,
 	/* TODO: highest_bank_bit = 2 for LP_DDR4 */
 	.highest_bank_bit = 3,
-	.macrotile_mode = 1,
+	.macrotile_mode = true,
 	.reg_bus_bw = 57000,
 };
 
@@ -722,7 +722,7 @@ static const struct msm_mdss_data x1e80100_data = {
 	.ubwc_bank_spread = true,
 	/* TODO: highest_bank_bit = 2 for LP_DDR4 */
 	.highest_bank_bit = 3,
-	.macrotile_mode = 1,
+	.macrotile_mode = true,
 	/* TODO: Add reg_bus_bw with real value */
 };
 
diff --git a/drivers/gpu/drm/msm/msm_mdss.h b/drivers/gpu/drm/msm/msm_mdss.h
index 1714bb41b838c33f3da19d93c5c1f5c53cfbdbab..14dc53704314558841ee1fe08d93309fd2233812 100644
--- a/drivers/gpu/drm/msm/msm_mdss.h
+++ b/drivers/gpu/drm/msm/msm_mdss.h
@@ -13,7 +13,7 @@ struct msm_mdss_data {
 	u32 ubwc_swizzle;
 	u32 highest_bank_bit;
 	bool ubwc_bank_spread;
-	u32 macrotile_mode;
+	bool macrotile_mode;
 	u32 reg_bus_bw;
 };
 

-- 
2.39.5


