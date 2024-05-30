Return-Path: <linux-kernel+bounces-194970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C9E8D452C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 07:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED35A1F21E13
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 05:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7C214431C;
	Thu, 30 May 2024 05:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uyn4DV3F"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3A9143736
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 05:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717048657; cv=none; b=XCJ1dx7m6Ng8LpnrXyfziOtzRbJVs/49dawRJWkmpnc5unZi118Ap+lasN9VO3StDGH7LXhHhW8bOlKQ9jcSvOqOYfgj5EreTJC5Jl6qunrflYmsKt3KdBUL33ZlfvQ6+oO3ptrZhhvlV0t/oNBzHLumPF/WtML8Ha3eQhHQVwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717048657; c=relaxed/simple;
	bh=9r9051he48dMMGiOxhg4O5ukg1u5/febN95BmY0jngg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=afjPUCsf20iUeN7DonzHPN3kBvE2P2QyCVqSD+v9NgBhM6HIPPs4w2grprI9mGCxl0eevzvBQUxkfEyW/ZqU91RNJ6pdv0JMIuq94uO61UdzPB+eQfVKFsYlexeiNlfOxwVR0TF+/qRyYEhrrp1KkqXdr2pQEttBunORNWP47eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uyn4DV3F; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7022e0cd0aeso565666b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 22:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717048656; x=1717653456; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zjKQvSlima36VVtlXXnQSyQLE9jYR8Z2VbliVMpmoi8=;
        b=uyn4DV3Fh0CzmkFvbSLMR6Ru4X7dxx8EclsOt7PLSKCnVlsavK83cerv8yukHbMbRM
         emAhHaw8uqKvDaoGRIq/rEahAk68V+KUb+pHcn4DaIp8pJkfTRhA+7e43BMkH+lcTN3C
         GvLpZjxFWGRpLRKcQkWxNMM71qSeqI0IE/HFTYrDS3N0yFYfCBhIrXyAJ3t80JEkLFwJ
         SKIzlwROibkZOIIE+53yqHmZ9RHSPOwzHF/98YoSZfKXtVgeXbwm6qJsn6031u7IxvGh
         g/g+xjZh2Kabw/63Zd3yKEPlzI09eHWyyYkw9OZDJhBW86eL8q9DrPlPHY90yWXCLuM2
         EIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717048656; x=1717653456;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zjKQvSlima36VVtlXXnQSyQLE9jYR8Z2VbliVMpmoi8=;
        b=MA+gZTMrP84ZeBZsVQLtPHnso28vEIZtP4qXr/JMjYv483kVQeWlaGgCEoG6/KSGFc
         TiA7gHoE+QIoZaEaK39JqieQKwgcO95/mjccqRskzYNq4OKDr22H0O3VAODKqClc8JFg
         R1FCI8JzVcizUD7uC5S9jajXgaip7UWJU9momBYlwKQhNt9o0wuWr1uw5cc/NQftAEeI
         nrd5Bg3nymqfBGo/sSWgislnWp/IxBZURUvHohwaqMwQyl8ZialIfYAg60X6XbzDn5aq
         vERGoWh9Ap1UWiD1pUHiLmaa8Oojs5VjVRb8zmCnjfNYG2CR6MT7AWGCQj2XAtYlL5Et
         nZ4w==
X-Forwarded-Encrypted: i=1; AJvYcCU89rN+1WCjpEAuWoUY5x+kuzhTxJns2buecL1KN9b0Eafztzz2N7hO4zy93P3bN4AUQXuqWdZGS+QGs43uDZZQMmFQer9/T0gFKb/1
X-Gm-Message-State: AOJu0Ywr02EXvN8+4ulLWtB14ZBRB20zycFusd4O4oqm11C2e2dVD6fp
	LappU1JiSt2tCaq1hg8RBUQ0x6obE1AZYdjLcO4CnkMcR7MSNdPGwcwFq5kQEbU=
X-Google-Smtp-Source: AGHT+IEMH4mGQk2hbgj+JzWLlOWWaCC+qs7OK3TaxNAbxcOjuE9hv94mUwGDeFx1EZkiuVv1gPQ5rg==
X-Received: by 2002:a05:6a21:19d:b0:1b2:4834:7a24 with SMTP id adf61e73a8af0-1b264721ce0mr1190275637.45.1717048655803;
        Wed, 29 May 2024 22:57:35 -0700 (PDT)
Received: from [127.0.1.1] ([112.64.61.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c75ffc6sm110006705ad.9.2024.05.29.22.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 22:57:35 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 30 May 2024 13:56:49 +0800
Subject: [PATCH v6 5/6] drm/msm/dsi: set VIDEO_COMPRESSION_MODE_CTRL_WC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-msm-drm-dsc-dsi-video-upstream-4-v6-5-2ab1d334c657@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717048617; l=1994;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=wYa7Wt+9FNkutbQfF1qd8yI9pCbHRJOEVcRy20d6px0=;
 b=g1HxXUGamd1S1+baoVF3C1PVSVxSrhmzRlQx4qfHnCqOmNGTSB9axEdRP98TE05H6leIP/t1u
 ZL+HaI2+8WsBJ28CpN6rClatB8UXm5Ir9vyIlQ7EbVW8a/Wln2VnK3G
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

From: Jonathan Marek <jonathan@marek.ca>

Video mode DSC won't work if this field is not set correctly. Set it to fix
video mode DSC (for slice_per_pkt==1 cases at least).

Fixes: 08802f515c3c ("drm/msm/dsi: Add support for DSC configuration")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Jun Nie <jun.nie@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 47f5858334f6..7252d36687e6 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -857,6 +857,7 @@ static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mod
 	u32 slice_per_intf, total_bytes_per_intf;
 	u32 pkt_per_line;
 	u32 eol_byte_num;
+	u32 bytes_per_pkt;
 
 	/* first calculate dsc parameters and then program
 	 * compress mode registers
@@ -864,6 +865,7 @@ static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mod
 	slice_per_intf = msm_dsc_get_slices_per_intf(dsc, hdisplay);
 
 	total_bytes_per_intf = dsc->slice_chunk_size * slice_per_intf;
+	bytes_per_pkt = dsc->slice_chunk_size; /* * slice_per_pkt; */
 
 	eol_byte_num = total_bytes_per_intf % 3;
 
@@ -901,6 +903,7 @@ static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mod
 		dsi_write(msm_host, REG_DSI_COMMAND_COMPRESSION_MODE_CTRL, reg_ctrl);
 		dsi_write(msm_host, REG_DSI_COMMAND_COMPRESSION_MODE_CTRL2, reg_ctrl2);
 	} else {
+		reg |= DSI_VIDEO_COMPRESSION_MODE_CTRL_WC(bytes_per_pkt);
 		dsi_write(msm_host, REG_DSI_VIDEO_COMPRESSION_MODE_CTRL, reg);
 	}
 }

-- 
2.34.1


