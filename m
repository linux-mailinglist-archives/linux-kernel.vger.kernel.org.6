Return-Path: <linux-kernel+bounces-188731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBB88CE60B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 15:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F2981F24E73
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 13:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792A612AAE6;
	Fri, 24 May 2024 13:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W8cWa98F"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D6E128383
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 13:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716556807; cv=none; b=Z/r1IqLfXbNt6vn28RCmuXQ3dsLBK5lrMYVp+axlH9Ot/7bVMiUHaiWqlO/R/FPNP2oWiXmMi3AGf3IhO3HPlu0EubhWyfhGrWO017kAU55J3KPRzs9UKlY6DawxvLYlADDqRrmvVP7ZKstT6wcv7z0t2qD7xwge/hNGXHb6oYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716556807; c=relaxed/simple;
	bh=G4jmD+K/fkmFufgBXjmnjPbCcQzArsr/IXqIKSDtt2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XeZ9ZEu1m4NHUEdb6GErVwVYAqVHqUs2ctugU/Ueubm6ThBZr8gnw/w1IeCi4HqFIusnykJaXKCwjuOfWicgW0CtqntEVfoYj8xde9pNaS6H2gdp7xjS0vrlViXA3zW2NJ24hBKVs/sFn+C6JKwi7hxMp6WTMocGkdimogVOsLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W8cWa98F; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f8ecafd28cso739159b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 06:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716556805; x=1717161605; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O7X6X7Xg0a7P3rLwok0YLujXGrmUyMxWDQ/9AezaVG8=;
        b=W8cWa98Ff/IeWHa0mOodnah/aWgRcIE9brrHirbPnr46oY8Y3l7rwNvvuTN8qGoQ+3
         SAgBUyVupkODlMj+LYLUsDE6n/Bwg03eHiHT4YOTLQEtLpl5ppfdRfpS9Ke3Na8WcBWt
         XvWKFeanO6FKj8UIGgqRXJPA8RSMcxj6l/v1CEfl9TEvknUKobfs6kJMxgOfXdCwJMOF
         RjOAeVIB0+bmtn/0LbinS6UZLVqcN8yN9lsvl5sYWV95tbOl8UNomfFwILuUQ+fD0FRm
         yi1ZfBLwbHhta+Pe0maIlk3OaKy08B0IXbWhiYtI7f905W1aDNI5h1RWpq7QuXoXi0AW
         JlSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716556805; x=1717161605;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7X6X7Xg0a7P3rLwok0YLujXGrmUyMxWDQ/9AezaVG8=;
        b=WCpHAfUeUFbjgCu3oUebb8cLyIeWjJPzxSXGpkXdJXxPetEPryGPQcXcFAQXU8kOEy
         CFigZRJBBGjZb80A9KxF3UpMQMEYmCooihkyYYIVeEdCUvshzK16F4pay2boj3UZnjH4
         hcAMVLC9nB1Re8IEQDJqa4l6JW4RY9FuDTrtkwohaFNO2G9SI2/F8jSi35nSyziwtCNg
         AtAHdpc07QelnS0q9x3RDRYXfACJdl1qpPfllG6gHnkem3Zu1z0+UBaQaMZWNRQBTa4E
         plh+KmmqtXBZv5tkn9uM/aRXxJBPphU8OYrlCaoW1iVBmqk7UiyDJCYdCh1CXsciOcM8
         KMZg==
X-Forwarded-Encrypted: i=1; AJvYcCW1bI2QGo5duih+5JUHGaXGztJiETb0e1w+YDFXc22iwfJLhzZF8uyzYvA/d/G0vpAKD6Zfk7pxSIAmH2d9GQHlYEIgduLxFJRJLu+s
X-Gm-Message-State: AOJu0YzoE8PWdMBVzoUHQKh4kIHGZu/JLvOBh/nrmDD/Y/xiLZHif8Av
	W1pFupzPpXO9Ppu04bo0y7+fDcjYnYaQ49QhCAf7W07bSJlzjK3VwZijx6QnLpE=
X-Google-Smtp-Source: AGHT+IEaF2Y5Q7PpzxWxDlSpCPw29IB00sbmr5EJBez/e+fhZLJRTYl/6p9AjxbjhfA7ASd7c8riaw==
X-Received: by 2002:a05:6a00:1c83:b0:6ea:f392:bce9 with SMTP id d2e1a72fcca58-6f8f3185033mr2206294b3a.15.1716556805523;
        Fri, 24 May 2024 06:20:05 -0700 (PDT)
Received: from [127.0.1.1] ([112.64.61.67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fd2d492csm1117852b3a.179.2024.05.24.06.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 06:20:04 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Fri, 24 May 2024 21:18:23 +0800
Subject: [PATCH v4 3/5] drm/msm/dsi: set video mode widebus enable bit when
 widebus is enabled
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-msm-drm-dsc-dsi-video-upstream-4-v4-3-e61c05b403df@linaro.org>
References: <20240524-msm-drm-dsc-dsi-video-upstream-4-v4-0-e61c05b403df@linaro.org>
In-Reply-To: <20240524-msm-drm-dsc-dsi-video-upstream-4-v4-0-e61c05b403df@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Vinod Koul <vkoul@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jun Nie <jun.nie@linaro.org>, Jonathan Marek <jonathan@marek.ca>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716556778; l=1644;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=myYBVxgRS2I/E3QUdyhnLOjWSeM7jzrWqz2ABozlocE=;
 b=acTSUbISIJX/UiCq8kqoDO4+D8/1oY7QOyQNkEU/pl4GyuyGinhAF/uix6W7YgXHJteo4QthI
 m0ghV/Ena4ODZ7iitRZjSs3qclPIVQxtybpusCBTC4rAOs/QHAWOOs5
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


