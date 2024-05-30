Return-Path: <linux-kernel+bounces-194966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B97D8D451B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 07:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522EA1F22F2F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 05:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA8714373A;
	Thu, 30 May 2024 05:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OMsrf2Pw"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D630A142E8C
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 05:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717048628; cv=none; b=uDPhlw4yQoUfPF/IjZ4Q2u8/3jU5ViuQ64YJD0dchnnxN/90FB/klJvC+SLDUJmob8Zm9B1b2+o3/QvDdHCUsAoed8q02O6oeawB1byGknAF/3RpPp5G1fuh6Dxk6AoInohDWFhj3VQDmokQ+KPFnIgZV2f1PNO1HVto4jMW+Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717048628; c=relaxed/simple;
	bh=OHNAcN5o/LJmbpUIEbr4VX14s/2cSy3xBsOYCqYDXXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NMwUhFxMiXk8EZ3PvrfVvK0Yh8GwozkQ3kT82dzjgLLdOGU7SHJ82+LR0zg2vuaHfwS03AA6ic2Tmmtjv1ZNuzhHoJV7mQSCBk30PSjlMP9K+Nt/pL4cdgXLNlDTLPnAbSfw7r3UXz8myKGEgvrCeUdIkY3N4TNLFvx3C1hoMzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OMsrf2Pw; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f32a3b9491so3838025ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 22:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717048626; x=1717653426; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y0Xqkh4+NXd6q1efxpu5bKSp5PxV9NZYNMFbg5c3nFo=;
        b=OMsrf2Pw3P5ksDyhtkdzhu/m0SoErWjwwTG62+YPIb8uxSQVFuZSsIZ/Mg6ae80hMv
         xgfX/cAIRIgTdSABu7rPwjvm4a1rc6Aa7MguCVZ8ll0nn29+WEJmZr66oguyvKRuGuar
         gJemMkKA2bhQ2QFyXje/mxHul0e1d+U5XtDGv9ub7G8uqJwh59WdaHro+jZ72YZwZ4Lj
         9CE1TfL+16xW3gyNVLlA3sE4Bx0pNDJPG1zgVeaBoHY0IGk2JmhTEnO8qVaOMhCF/fCi
         eZ/9dhd45IW6Ws0ESqfH/yIbidYwwGzy18LcjrY9mm/27kpaL2UR+BRJr/wfVj+G8Wr5
         eEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717048626; x=1717653426;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0Xqkh4+NXd6q1efxpu5bKSp5PxV9NZYNMFbg5c3nFo=;
        b=fDRTPIWffLlqqpVgBO3Qiv2iTlspgILOECteNqGNLy1GMMZoaNLcPqMy8uyx1pqkUD
         WC8I7KFILXr+sEVzerTDHaNbBbCzIg5nMcIJcXlH834kFIqRZGBnCbv+s1IRX3CLX2+M
         8zCxr8Wi38fxsELTCwy4HNe2Ms49Lv2n8WcGg2gcg3Vi6QqTO78WX243DXByhff8+tSt
         f5S5iVW24l3l1E4XYBxR3Kotvi2kIioG85cHMhbxYSJD3rAWADyE6sdYwTE+RRN04skN
         YR+dF4Gg1V81U5OYSbyN4FWDncPQPQvTQORZx9P1q58i4gj5zmrpJYiHZtDsG9bQPs+H
         Tsvw==
X-Forwarded-Encrypted: i=1; AJvYcCWkL3uGnOb+9iwvhG54RrUef9SPyzdLE4uQQi3DKF02WouaU53Z34zlUrF5bRYm2Skd+xI3JSUArf2rVUwbt3pkdljkDnReMM3PBnls
X-Gm-Message-State: AOJu0YzTxaKiRij7fwgFfSVwDAOaBesbTIssj9jjgvFLUr8yP4ClSgOi
	15cmXbXOAUY4DJlTIXW35wtQz9BD/Z8WAF1WT5mYyS5h93Uhgo0kfJRftho886A=
X-Google-Smtp-Source: AGHT+IGitKpJuWn2uC/Fkq1l7O2dA+3u6AlBtRO2jqrLeHtja/lo/mNqVB7pEmOUo9t/OvrS4Kt1YA==
X-Received: by 2002:a17:902:f545:b0:1f4:7a5c:65bf with SMTP id d9443c01a7336-1f61960c4ccmr14073285ad.38.1717048626082;
        Wed, 29 May 2024 22:57:06 -0700 (PDT)
Received: from [127.0.1.1] ([112.64.61.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c75ffc6sm110006705ad.9.2024.05.29.22.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 22:57:05 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 30 May 2024 13:56:46 +0800
Subject: [PATCH v6 2/6] drm/msm/dpu: adjust data width for widen bus case
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-msm-drm-dsc-dsi-video-upstream-4-v6-2-2ab1d334c657@linaro.org>
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
 Jun Nie <jun.nie@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717048617; l=1362;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=OHNAcN5o/LJmbpUIEbr4VX14s/2cSy3xBsOYCqYDXXs=;
 b=GWWPS3UkIhGISQYgdng1Ghi+C91yCmA4fP4R/VWTpImKe8IVXkBrgo5h9osj1IbqvCnPn33Ok
 F3ae/xA2GZvDFT7qTdU1GZTFyvyOqaKwxDHEufeCcWKrmx/gix8pxAj
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

data is valid for only half the active window if widebus
is enabled

Signed-off-by: Jun Nie <jun.nie@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
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


