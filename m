Return-Path: <linux-kernel+bounces-190951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 861CD8D04CE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E3CB1F21992
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2128216088F;
	Mon, 27 May 2024 14:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yQix86qx"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A761607B8
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819820; cv=none; b=q2qzrdb3ixfgZ8DOkS2BtVfCBNwYbk7HGm77aSP+XQMW1Yc6coPDoL6jfEqxjTyvezm3iQmfACMrkSKcH2Mmm2LvKtCg1S3r+kaFm4RzmluYqU5kFYsUk1uK20Q1qK1myup32nzXoHsbGGxAK3GPwjyGNUxcGl0ncjiCGStgdnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819820; c=relaxed/simple;
	bh=jIW+hVQ5X0Zur669tpB4Gs4vZvbIu7XObZH+l6jhkHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nv5S5W1WqOWXA9EBnd/vzeWvOh9e76eTT9SyQUecbLjIHTiVGAO+IdMpcMyekNjiRZCB7AI/MVl9w9aP4racnhpyYtyE0aHoD9XSr04q7fhdJvVRNaIPzzDRofe1DBqSBIg3TC/JedWuThV1uWBL/z/rkfxcPhAhv4VZAzlYZdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yQix86qx; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f8e98784b3so2441038b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716819818; x=1717424618; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=or9AvWwVuKmZ+9fVlUmm74FcJvOEhh8SwrrrpYlBRos=;
        b=yQix86qxiVtPxGDzRKbEokVryIUDdEhmRh5a/sWE1NXsaLS/ZDBut/pc9T++4y2uxC
         bgclVofE25MRih1kA5E9egivfhOTcGa1Gg45/MR0TYkMmd80prPzoxs0KFenSPMypOT9
         QHrKA/rulQi7/QGLGFEopZAP+R8PapBmxzYA2RYIXjkEq8TMaaFwUc61UeoWLUD1v9TV
         S/bjilVf8c1ehJbk8SEjOIZHeWjybBItOlJbspqd/vBYihRDyf8ODcBm+l4UBeV3wALn
         /noFqavdxk82A3IOQW62tkPEOcI9Ru0ZHM/BGl6wTw+jPf6FOQBKZetIoyPfqI5PSh0y
         NgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716819818; x=1717424618;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=or9AvWwVuKmZ+9fVlUmm74FcJvOEhh8SwrrrpYlBRos=;
        b=RZcQoKr2pOV/DjtxtVuRTOmUW7+6yw8adAIn1aTWywZs9EYw4xVH5/3SBwYZgndrC6
         Fr7uEa7CUMQk45Z4vKT4GDl5vyl1rykOSkO1QHKs5gDoHSzI9fkpHv7cHB8FUslt1NLk
         XrbyIcP3o8cjEuvzVNPEomqUSTm3SJJsNMge9axjiw8rikFVNcRZiKHEad4d0hcxe3u3
         /G2IHcFC4gt69/e+obMDLTMzmQWhdN1sDrS3C45y9uUURJS/9eztomgUP6wRhIcnD4Ay
         TMbQkhs7y7VZe9E4Oe0C59WLzDp9iM7o0JgFau8VPSWxnSOG0VoXsSBEEFvzfCsG5A4L
         QFjw==
X-Forwarded-Encrypted: i=1; AJvYcCXurb0G+1sQjep8tkhG+pGrmJXsnsHHiv9+/hez4nKDAk0pLOhL77fElqodXd0iI6KCODb3U92tBUluk+55yzCS8Sifyj5BC4N51AIP
X-Gm-Message-State: AOJu0Yzl9///L8UTfA4hA9tlZE8JKRBLa3Fp/2srLgVfGoYpUPR+PZxG
	br3XS+33xRRn/zLF092UZKjOgXPViNOQSeyaUfrEL8URfukfaIiTV9T/X2Z/RA4=
X-Google-Smtp-Source: AGHT+IG5s0Nx0z1cNOvoX29tySD1dcKs02n2sVztOhjJ9jVpF8k3LNAXLHRmrH7DYpDq8Rlpg8Kfdw==
X-Received: by 2002:a05:6a00:1f0f:b0:6f8:c476:4a7c with SMTP id d2e1a72fcca58-6f8f2d6ad6amr9840061b3a.9.1716819818292;
        Mon, 27 May 2024 07:23:38 -0700 (PDT)
Received: from [127.0.1.1] ([112.64.61.67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fbd3eb67sm5109895b3a.19.2024.05.27.07.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 07:23:37 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Mon, 27 May 2024 22:21:48 +0800
Subject: [PATCH v5 2/6] drm/msm/dpu: adjust data width for widen bus case
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-msm-drm-dsc-dsi-video-upstream-4-v5-2-f797ffba4682@linaro.org>
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
 Jun Nie <jun.nie@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716819804; l=1032;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=jIW+hVQ5X0Zur669tpB4Gs4vZvbIu7XObZH+l6jhkHM=;
 b=ZW/KEuf6tsdQf0Sk0wk5BACoDmI2+DpY51Q4pwE0OKKXu364y9sAhtTGrFFKHEQ79OwXPuh2F
 xX2RHPQo34GDpKQvAZ4eNpMtIVTlQepkOvcKf8rkEpVIRCgHs6R/TDt
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

data is valid for only half the active window if widebus
is enabled

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
index 225c1c7768ff..f97221423249 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
@@ -168,6 +168,15 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *intf,
 
 	data_width = p->width;
 
+	/*
+	 * If widebus is enabled, data is valid for only half the active window
+	 * since the data rate is doubled in this mode. But for the compression
+	 * mode in DP case, the p->width is already adjusted in
+	 * drm_mode_to_intf_timing_params()
+	 */
+	if (p->wide_bus_en && !dp_intf)
+		data_width = p->width >> 1;
+
 	hsync_data_start_x = hsync_start_x;
 	hsync_data_end_x =  hsync_start_x + data_width - 1;
 

-- 
2.34.1


