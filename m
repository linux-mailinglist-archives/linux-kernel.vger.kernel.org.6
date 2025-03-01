Return-Path: <linux-kernel+bounces-539858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A5DA4AA00
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 10:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B84A7AA955
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 09:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12DA1D7E30;
	Sat,  1 Mar 2025 09:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WyBRttQr"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0F01D63F9
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 09:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740821110; cv=none; b=QE7g3Tgyo+dJRRyajeU4YlK3Bx/35HEix5zIZ4XNOoFgdqhrEFEUzEqWqmikX4Assfa6otXl/GBVKcXZG/khgPcgs6GF764cPO5LrhfbNihJicvGKeeZRQe17HZHRwkSxa3aCL5friWDaEZJ5oo8MKLEXUGEfqlcPhKTC1+tJ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740821110; c=relaxed/simple;
	bh=3KiS1JFwz6siEC5WVugc4OTInSpbOeJ8pCpFDBbI8EA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aobbliKVMkZCvvqIHGA+pFsK3/P8M+9G6beQqePQ8MKZnwMqgeHH83AD49sRYu7CWZqArcLU2xGUJqGnNWNvM4zZt4lCnvazLkSz8AktwQp66rGBm8/rAlilmM5KasBGEv3ewY/yA9ZWrQ7iMO628vKSuDIm6rpEO9+FfVf2AMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WyBRttQr; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5495c63bdc0so275969e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 01:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740821107; x=1741425907; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ofpBUooPWWaBC1Mgfyuj8wcWUv2U0LtD4mwNGBXHw8=;
        b=WyBRttQr+2EGE5q0DYGdam3HLywMIQdpe43N9Mtt36hq2JQS61AyVLZs2P9QOleU/I
         Srg4AKi9bxGVzIpemaOHnNxIx2T1Ct7SgxoZo4Th9ain0v4vZj0yRRE5t1NtQlkvCuoQ
         ojs/mkYGKmkVl+a8sZHiC2GpNvVi40QbMEEF55/SUpnRfwU2yEWHttunZBnBemNLA3ME
         3h5wRqLNvvWRYNXOcTPAY2xxxpiMmAs7TJYiw1A+cj7+UKxyCJLrQFDBwDtcj9e5k/PW
         IYe+7Yjwvtmp726tw2JoK2QfpGi31DFDeyOVb9soFGwK7ODHY1IDRlfPzffD8wqWng2U
         JObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740821107; x=1741425907;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ofpBUooPWWaBC1Mgfyuj8wcWUv2U0LtD4mwNGBXHw8=;
        b=hMJ1vEpPawiF2S0FutQNUthaIKfEx0DRfSzVTKlyfBGlhNZgpi9Z9F3IlCB5VGpT9i
         dzY9Wi3YiJv2iqFd1K0+ZXoHcmAqc2z1k9IiEWFYNCJ6k72ZrukXBnAbc99hHIJxegX3
         KpygV94qFqvmiaAWceP8IAluQyAYpy4gKJuYRXMNX0Ri+V7zk2b+MMtdCoGfvjfj/GNK
         DCr9f6zd7BKl7rZ3P+aJUQj54bs7jY3Gkxa8KBPaCc5FsWkn5+Fmc0vJMupQlrsnYFGA
         ubSkm8EMHIf4qRU4SZQQiLZu4uE23EbPh7u2GHtKMw5rmPKQHGO9xIFh0CBPHqqwSc3Q
         IkuA==
X-Forwarded-Encrypted: i=1; AJvYcCXOkK3F5x7Orc//RS0bMnz7bL5EFYSlJu7fGvIHuiMyd1UhQarpdWEoI1+Qb4LvLH0JWmdCPnH4T3qhuwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTccKpoFsGdARW89kY9UUoG+fNWP8ERSoxjGb63BR+IvcFWv9h
	vs5vFXLZdwffkT0w4sYfaBrE1yglTrEM1eBqQnykmOhO64/3pjygwP8il6sj7qOHcwwf6w8Z9WB
	Xssg=
X-Gm-Gg: ASbGnctjq2t+cXUPUVORbZmP+D+Rlzknh3VsQvb4kq9h13JRSVjkd2nkztKlEq0RT8u
	SOI1fzTJymLGEWz0HgatiZ5aao+GWgHcxdHiqvhrFSzJLw+l+DBxcCCD/3amTjLZh/tm7DH8/G2
	RQMnDo0iqpQrWLRZzBNEwIEUwogGy6CCKH99O4iyTjfZ7X+0FOYxrsbvSJwdNs4fu/UIXXNRsjr
	pk+scaTKkYfojITf7c6D/jJRmCCeEhzSr205HUT8u7znhTC5lGeZ/G88KDDq+p8NusECpn6qVF+
	hdfQyFSQtAAk9K2igF+mT88vrPrtND5TjPa0yKyZxb/S9xvU01wr
X-Google-Smtp-Source: AGHT+IFTUhe/p95CZNKJGAqG1p7sHLGDOvpr/WdekUKr6EplX6n/Lb/C1JadtiI3JNxmPIfMMazmMw==
X-Received: by 2002:a05:6512:398e:b0:542:28b4:23ad with SMTP id 2adb3069b0e04-5494c11b5a4mr3148909e87.16.1740821106875;
        Sat, 01 Mar 2025 01:25:06 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5494417432csm738406e87.52.2025.03.01.01.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 01:25:05 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 01 Mar 2025 11:24:56 +0200
Subject: [PATCH v2 3/5] drm/msm/dpu: remove DSC feature bit for PINGPONG on
 MSM8953
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250301-dpu-fix-catalog-v2-3-498271be8b50@linaro.org>
References: <20250301-dpu-fix-catalog-v2-0-498271be8b50@linaro.org>
In-Reply-To: <20250301-dpu-fix-catalog-v2-0-498271be8b50@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1574;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=3KiS1JFwz6siEC5WVugc4OTInSpbOeJ8pCpFDBbI8EA=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ/qhSxlfJgT2tZu2nzENWHi/au3+z5m5nxaGzpnq4P/Ne
 +WEhAKhTkZjFgZGLgZZMUUWn4KWqTGbksM+7JhaDzOIlQlkCgMXpwBMZK0cB8Pkny1u1dbz98w3
 jqnft7fvUZfdeRapjeq/K1zXCGwv+vQ5OyG287DkzhQThQ+v/q+/8fnkqYtWp3fMv2IRVqj3pWO
 /bnH/D3bTz8fuaeSapm81eBdUtT9AxPpnfFa/cuua0A7VyutlBVqXq+IP852//86N5bzHhf1X4z
 RbfgpM4Wn95bpEbabUKh3JPgURhfqQhtOhrh3yi9M3bF+4adsKE18Zl4QVlTpeD0O/qyrHyhz2F
 YhYXZh4e9/OzvjS1FldamaTroWLb89O8zlS9qU+eG0Xt49wLwePs27vhckxhZYPLU44bo7XTPHb
 NuthlVZG7Jz0I36mhz4Ksjea75xTLDPNZoWSVtGxWQavAA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The MSM8953 platform doesn't have DSC blocks nor does have it DSC
registers in the PINGPONG block. Drop the DPU_PINGPONG_DSC feature bit
from the PINGPONG's feature mask and, as it is the only remaining bit,
drop the .features assignment completely.

Fixes: 7a6109ce1c2c ("drm/msm/dpu: Add support for MSM8953")
Reported-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h
index 14f36ea6ad0eb61e87f043437a8cd78bb1bde49c..04f2021a7bef1bdefee77ab34074c06713f80487 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h
@@ -100,14 +100,12 @@ static const struct dpu_pingpong_cfg msm8953_pp[] = {
 	{
 		.name = "pingpong_0", .id = PINGPONG_0,
 		.base = 0x70000, .len = 0xd4,
-		.features = PINGPONG_MSM8996_MASK,
 		.sblk = &msm8996_pp_sblk,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
 		.intr_rdptr = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 12),
 	}, {
 		.name = "pingpong_1", .id = PINGPONG_1,
 		.base = 0x70800, .len = 0xd4,
-		.features = PINGPONG_MSM8996_MASK,
 		.sblk = &msm8996_pp_sblk,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
 		.intr_rdptr = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 13),

-- 
2.39.5


