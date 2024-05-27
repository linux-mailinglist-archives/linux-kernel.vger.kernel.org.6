Return-Path: <linux-kernel+bounces-190954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30298D04D3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C619829274C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E866B16F83F;
	Mon, 27 May 2024 14:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L3bm/2hS"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B1D16F82C
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819834; cv=none; b=a4nSdlcwcweEo0clZ1394dGRALwCwe4fn/ybOlY1KEsECI965WVz3lQYYSSHBPjqqSTAdPbyY8CeRMwlB7sB/ylTfnOq79GhaPqqIWEVJIs02rA0TIOif9P+vQUyS1+fOAhtTvqvGyJQLR1e1hY1YAmoi4YIcVjD5EHnDF23BAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819834; c=relaxed/simple;
	bh=G4jmD+K/fkmFufgBXjmnjPbCcQzArsr/IXqIKSDtt2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PE2RJMI5BbBkG/OHBTs6YicAloEYbdGyrLgEAKpGwGeXCSUXfk/bk/TH4JbH1dbPGj7fcmqcR/NKfsdAr8lTN1tdp22cZeQzcs8JNDC24+Z0P3cXZcwz+dzBdk8Dqy/+X2TD+uPftqk2xhGryS7z8QyAl5OM5di1A28uQ1Rn4sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L3bm/2hS; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f8eaa14512so2591445b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716819832; x=1717424632; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O7X6X7Xg0a7P3rLwok0YLujXGrmUyMxWDQ/9AezaVG8=;
        b=L3bm/2hSZFyoQ6N3aybetsRc6AaauTaN9MciBwqzUbaFPtcdjE/7nGFKQ/kDzfF9+L
         qMX7aKUQBbhqD7CFGe6qkzaMRLCUy2eHG1tNsCZiDvB4m/ibGLe7qHXSz/y7bRW+sZ4j
         3Aiv1QsCQEhKt4fgddwMwj2wOMlgchY4H0ORpphmsZQ/0Nryn+2G0MLL+kvQYEdLiyJz
         E5aCafrMQDSUQzC+QBj5rav1XT5LKpmnAmMb+MKSejIIHbPBYQ05mx9C0iNIX7ifI20J
         sSCD/B036QxzhVzVPlseHjCBvmTUZnPwiP+7t9Bd4HNccVje2trEhwKtkdHgq5G9syb2
         Qarg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716819832; x=1717424632;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7X6X7Xg0a7P3rLwok0YLujXGrmUyMxWDQ/9AezaVG8=;
        b=M6bNHku2EnNqIUsUug1djAGXWOYTuFVVXXOStmByaFoVjGswpllFA5uW8Hj0RBreFY
         mmdpvOAC5pXrdzMr0KGtzhqPH4zvQ7oMjBMZ/SlbTp9i6Ac4g0kvHROC64kKnrTkR5U4
         Ee7txxfhsU+z5pcmITL7g7L0ul1vo0Evtpn+NKhFMH4X+WuGUYm0PLdcnuMp0x2Bzlk+
         MKMNY5+hLQNo0DSYSRgezIlS2QVuqC/1/5gV9KHYblrBK9iVB8kWEuOfQVpW9PeBjwbP
         WdHV1r/1g/Mn/royoH9b4UpwwmxO0KEzHIP/H5RHEmdNZ+moiZn/be9zR161cWh0pcEu
         TiPg==
X-Forwarded-Encrypted: i=1; AJvYcCXtiztwvrI3MemDkW2VSW6vFuhaUnwEVagwlglq4mlIoS2HXciMpgbfRbIXGA4a2sJ1PEmXRw5wOhhekPctCVsPhYfH1ofE8Dpjmc+P
X-Gm-Message-State: AOJu0YzM9pXSOgSJMB6vYFRw+Le/efe3elasgZhRa09HRlgsQA35OS6G
	j/iJyDYh+JtawvirXIdKhWkJ/CA3FSM9tO8d3nVl+1iqKZWCDkSpx35RcqjHZ4A=
X-Google-Smtp-Source: AGHT+IG27XneYYlxfnsTtGUnnHHJLVJw3XpHBmvzPjELzZgM4IPaUCPSYuo23gRJ69ondE1sRJxjlg==
X-Received: by 2002:a05:6a00:2c94:b0:6ec:ebf4:3e8a with SMTP id d2e1a72fcca58-6f8f34ca63dmr10771339b3a.15.1716819832148;
        Mon, 27 May 2024 07:23:52 -0700 (PDT)
Received: from [127.0.1.1] ([112.64.61.67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fbd3eb67sm5109895b3a.19.2024.05.27.07.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 07:23:51 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Mon, 27 May 2024 22:21:50 +0800
Subject: [PATCH v5 4/6] drm/msm/dsi: set video mode widebus enable bit when
 widebus is enabled
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-msm-drm-dsc-dsi-video-upstream-4-v5-4-f797ffba4682@linaro.org>
References: <20240527-msm-drm-dsc-dsi-video-upstream-4-v5-0-f797ffba4682@linaro.org>
In-Reply-To: <20240527-msm-drm-dsc-dsi-video-upstream-4-v5-0-f797ffba4682@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716819804; l=1644;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=myYBVxgRS2I/E3QUdyhnLOjWSeM7jzrWqz2ABozlocE=;
 b=KGkFKxznrl2L4qx7rg8Wv+F+s40+BieN1hHXytdmrRqouAatjjpJr4uDP8ac42S540r7BBQDB
 GPbVAfPkobRDtEz1BKE+9Ztglw7OwGo5V0hA5R+RnlgrZDYLNb5gAbT
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


