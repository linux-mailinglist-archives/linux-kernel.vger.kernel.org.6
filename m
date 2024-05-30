Return-Path: <linux-kernel+bounces-194969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAC58D452A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 07:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8326285BF5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 05:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4BB1442E8;
	Thu, 30 May 2024 05:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IEdHGD+2"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA82143725
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 05:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717048649; cv=none; b=nd+dqUzppd6sQeaZR11WkS06btwvC9wN1sPWtzdC1H+tf7cCvRa4f//KR5K1lBUTN9wnj4//mLbQqdXtvHwiJld/2KZuErvkCkdWGg12u291rBgAn8dvmAVaKA4FjhydQxAYpK8KRz45AxMh0mk2cTm0psH9OTCbqz9EYU3eMqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717048649; c=relaxed/simple;
	bh=fsj0LfGmZGrMirh5/lmyws+9O9/Swv/loQwtSsYXUP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TOk6LxfjpZY0tLtZrA1x8BNN5pOgejvBGoMKL74HfvHVY7Ys7n2Xa146+1Mxqi6c4tY2Fw2ir1tT3fVgW235aSGgVirO/cD0x5IaAHo5+IAPrt4u4k8zn9UjRjoj9HFO2ItuPZ1spDX76DvFTQVq+DxhuZPr/8nM0vlX2tfSmRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IEdHGD+2; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-68194ee2174so424402a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 22:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717048646; x=1717653446; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pxS9ek92+KO+qEWEmGFZ/YwqXrV35uXXPCm3VPv7hfQ=;
        b=IEdHGD+2L9wudvynetjTHAvO4eMAMX3+vylzZAVPjMsTB24OZJQEZe/w4m0B6sctlv
         ahnpdxkRR7DGlsXfsyQGTHUfJ4qk54CAbPhrqdOCs6QxZnrNMCzJY1r/90lMoAdSlQb0
         qzj1WQ+5vKMvCdAOdopsevSk6dlU/9Sf5s2olsvPm1eqWrlkjIOVEjjhRaGAa1svi5FO
         l/Thry1F1fNKhwxUC+J5amZsghuuswwHrHghLem9AiH65c41GC0Op1DkIp5DA5+dboPK
         ZPJpCJ9Ch3OwXyJXXKFQG7G42BmHoBvAEwpXV+tRvY9NJaytT6WBJCWxuQyqUBOWHwfU
         5HPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717048646; x=1717653446;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxS9ek92+KO+qEWEmGFZ/YwqXrV35uXXPCm3VPv7hfQ=;
        b=qyEhUH+JDy8ZVWko8DDUcbU3J9kJW32BzSozzWJkYRbVoaLQMlFdlIHpRjCeOK8sqZ
         tDjQEosNV9bfExAdkZNQ1QKuNOmaVDZDGVML7ThISYDGkUua0kdgDOA71F0k+6YWKGp2
         wATFj+v4PaiZn7NNEIssMVseh9zTjEkFgDBnrL7IKTMLHkHZUDvFECl/+JYgXg21LR9Z
         6auoUBDZKCPt52smiV+Y1StKZ1wMMCxXuxkR7Z2qk9RSdiRI00fshfOCwOhWNJnA8SlH
         lgYL+27q8z0d8XhSrMW6mORpBfU8fdLGzbZM2liUdCLwv5pK4JRbJo6go103VNznSaDm
         4qhA==
X-Forwarded-Encrypted: i=1; AJvYcCViwvRhQqYUBSsrHwKjQRY6S15fg4nNdaUyEbY0nQRqTIqOQbomqvZVxinHTWSycA6y2eJ6PJ4iAEBJu4ajB9912uMx0G+5VanNDTTa
X-Gm-Message-State: AOJu0YzPpCJq+QC/G1GOV+RmS41OFqCHDdbxLTgFprmGATz0iru/LaS7
	U6Wm0C3crQLOaDsYv/6rHYNNBUjeSqq72ZbnxS1mf4rDVXTIwz3Ga24zSu7th6I=
X-Google-Smtp-Source: AGHT+IFufGvvP62MCAdjZ2K0L1xe/kz4yKxYfx73uVVqFuErqy87bIy2B4aFq+uHFwpqST5ep/1qOw==
X-Received: by 2002:a05:6a20:7293:b0:1b2:c64:7b3c with SMTP id adf61e73a8af0-1b26451647bmr1370632637.7.1717048646289;
        Wed, 29 May 2024 22:57:26 -0700 (PDT)
Received: from [127.0.1.1] ([112.64.61.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c75ffc6sm110006705ad.9.2024.05.29.22.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 22:57:25 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 30 May 2024 13:56:48 +0800
Subject: [PATCH v6 4/6] drm/msm/dsi: set video mode widebus enable bit when
 widebus is enabled
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-msm-drm-dsc-dsi-video-upstream-4-v6-4-2ab1d334c657@linaro.org>
References: <20240530-msm-drm-dsc-dsi-video-upstream-4-v6-0-2ab1d334c657@linaro.org>
In-Reply-To: <20240530-msm-drm-dsc-dsi-video-upstream-4-v6-0-2ab1d334c657@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Vinod Koul <vkoul@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jun Nie <jun.nie@linaro.org>, Jonathan Marek <jonathan@marek.ca>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717048617; l=1857;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=eBWvrCJe+PE1pKdk//cdtjIjLgQlT+4h+UpZHIX1w78=;
 b=0YTnx58R0AaK23OPv7vnpJGxBdEo6QluOSapKQTN6Ffufhsa6eDy3jbKLRAgwvoQupXLNKimb
 HbZtLiak/hNBAwpnA8l0pboHc0ma5rXkuax+ifOKbNoDqRwS5MAX/7o
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

From: Jonathan Marek <jonathan@marek.ca>

The value returned by msm_dsi_wide_bus_enabled() doesn't match what the
driver is doing in video mode. Fix that by actually enabling widebus for
video mode.

Fixes: efcbd6f9cdeb ("drm/msm/dsi: Enable widebus for DSI")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
Signed-off-by: Jun Nie <jun.nie@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index a50f4dda5941..47f5858334f6 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -754,6 +754,8 @@ static void dsi_ctrl_enable(struct msm_dsi_host *msm_host,
 		data |= DSI_VID_CFG0_TRAFFIC_MODE(dsi_get_traffic_mode(flags));
 		data |= DSI_VID_CFG0_DST_FORMAT(dsi_get_vid_fmt(mipi_fmt));
 		data |= DSI_VID_CFG0_VIRT_CHANNEL(msm_host->channel);
+		if (msm_dsi_host_is_wide_bus_enabled(&msm_host->base))
+			data |= DSI_VID_CFG0_DATABUS_WIDEN;
 		dsi_write(msm_host, REG_DSI_VID_CFG0, data);
 
 		/* Do not swap RGB colors */
@@ -778,7 +780,6 @@ static void dsi_ctrl_enable(struct msm_dsi_host *msm_host,
 			if (cfg_hnd->minor >= MSM_DSI_6G_VER_MINOR_V1_3)
 				data |= DSI_CMD_MODE_MDP_CTRL2_BURST_MODE;
 
-			/* TODO: Allow for video-mode support once tested/fixed */
 			if (msm_dsi_host_is_wide_bus_enabled(&msm_host->base))
 				data |= DSI_CMD_MODE_MDP_CTRL2_DATABUS_WIDEN;
 

-- 
2.34.1


