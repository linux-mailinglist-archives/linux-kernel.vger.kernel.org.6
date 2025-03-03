Return-Path: <linux-kernel+bounces-542012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79672A4C4A6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D4BF189657E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F651214814;
	Mon,  3 Mar 2025 15:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wUmx12f9"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A46721577C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741014912; cv=none; b=aB7ifwhSNESu36LHkmZG2+CR+qIwqfMnkaic4wDFzynQN2ieHeWDNbSmDWg5Dn18mQamHHxK61/8bU1c/LYPCHyTBziUwz2ECyakPW0Fg6Gk6GzhOMSdWBE9/LVBQ3An/9Q2R1HlGN7vyoon+NW1+7MxAkSmTfvWcl0/xNXwSKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741014912; c=relaxed/simple;
	bh=OxydkO597ugBLy/eoQLhIhZIi3C8VBz20HvkW34FMds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CBPcEtbbi0awGnFKqPYyUTPy3KEmrzMMN4AKG0E/oJNjLRiHQb/EyP/YHttAyjE9keLZoHR7swNKIk01AAp0vImhi0JQjjRnRmls8fHvyXuM4psH1e1bzPGYejiUXZb+nCUXBljUsdBrOK+nQqJwY32VliIfWxHTCQuW9MqjzMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wUmx12f9; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22113560c57so86942795ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 07:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741014910; x=1741619710; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ieoJPWE+tVOeqiIoh5GOinrnACdNHE09O5GdzPDKAj8=;
        b=wUmx12f9mKcjeYNoBqX2cdUlyiYhkwwXri1dKZSWgxVeSaVCAvGP3pWmo2rTmiv5lU
         hAVIVAHIdfRh5QY5sYt3IFOWh4EwKCMEBaL/7adcyNtgYcCrq6BnjRmjisJKq4HstI3G
         GMeOrjxVis16wbdjcieL2Iy5BJ4cIkhbhZSOfdS6awu5lyO4v4qd5APQYi5sIJ01ZEDq
         UO5mke3O1oGzD3OksOVwAmJrhIzc+IwT8qUbelyD1169yQEIrPCbGJNM0uG0dqm2PRo9
         /xfjLSaQVmHcpXoPMwgpbZQpo4HMU7eLupiWzflHO1SQALd9iNSYrR+zUgTdnBeMblt6
         KaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741014910; x=1741619710;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ieoJPWE+tVOeqiIoh5GOinrnACdNHE09O5GdzPDKAj8=;
        b=cmuvuPAjDysu3e9BrxvlLB79AxxIjm13dV8r5gLWEhuT/7ExsaCkQnmhsqGrsFLb8h
         VR1wwDqw6ModV065WQzsMUVqCX++pvw4l1Wd6Dmi2UjpGv03UEh+2OS6b53n/+t4kLFF
         JZgzGnrM65mRQEHT40JmJPu4Fm0xVR/k3vEKtr1YAqafAv/yTsphFn1w3KVIsTOOqvu5
         hcFDpNuA1YFezewFlxM1eSu9W5nWuHqBZroSDadjx+bSKMsEauB1HVzA8hNgz1jj4MlD
         uWkbtVaRaLbwJWEHIzU8N9I+lRwwcXogZRSbSQFTMVx2ayS1apv/2OzYnL9r/CKlXd4Q
         +p2w==
X-Forwarded-Encrypted: i=1; AJvYcCX+bW/4YxstYxR2rMa3jmhalUDVey5/JS1d8jwwLH/gruZSVMeJyY3a4L7i7vcg0Vd7R8VfGojY5bc3UAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9U5rx2+zQ5wpY8ngRPrIYRmXdzRnEUHQ+st7LpZWSStyNIgDE
	mFTZELt1/jnOYQCl9+pTZkhcawSg7w6h2lB3ToJUDCklvSmIIiYQU7llWsxQ1g9yI1OgU5o2h7f
	uHrpdrg==
X-Gm-Gg: ASbGncs7S9CPSAPDwVYjtVM97YBE5c26kAR7eTypPKckJPvFd+Z0rdvzbYWxP77wjQq
	Trq9IZ3oT8aX5yRZrk7h7+j7U4w5p5gekKnwXfIJKT4OUo6owHI5/acRlT6eJiTVpjTUx1ZS37p
	0J2FuHzSv3jKHCi8q1NLbuG6Ebq4EpnKUeD2WaeM+mp5jHTM48C8GQepv/LNxhPNOAabqivgQOj
	1KD9SO5yfBB40W+KGQYNWTopG++J0h/kN/AOEer3fO7J/sD12bkiUJJERmZqr4FBQc5f6uerKCa
	GJlx2ZkRNTR35u9LXXRav/Aa2gCo7SSx3YFk2YCpLw==
X-Google-Smtp-Source: AGHT+IFXQFVV2iDx7zy3Vu2t/VrO3jNK2d7/LTTuBESSbmurMHpjbXZYGouAn99h2/O8Evq+lSAPvA==
X-Received: by 2002:a05:6a00:244d:b0:736:5504:e8af with SMTP id d2e1a72fcca58-7365504e9edmr6999431b3a.24.1741014910436;
        Mon, 03 Mar 2025 07:15:10 -0800 (PST)
Received: from [127.0.1.1] ([112.64.60.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736584b3cffsm1851984b3a.4.2025.03.03.07.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:15:09 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
Date: Mon, 03 Mar 2025 23:14:32 +0800
Subject: [PATCH v8 03/15] drm/msm/dpu: configure DSC per number in use
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v8-3-eb5df105c807@linaro.org>
References: <20250303-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v8-0-eb5df105c807@linaro.org>
In-Reply-To: <20250303-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v8-0-eb5df105c807@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jun Nie <jun.nie@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741014878; l=2046;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=OxydkO597ugBLy/eoQLhIhZIi3C8VBz20HvkW34FMds=;
 b=0/rhKu0LON5yZrlYDkf940GcbT6nSV69ScJn5vFP7k5m3Ms11NY5nPo997caC4RruAvKsAnc8
 vIrv6QQczDHBve5G8aFSo3D1SGx0UdO4M9SvMrA0P04XhlYQO87q5Ye
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

Currently if DSC support is requested, the driver only supports using
2 DSC blocks. We need 4 DSC in quad-pipe topology in future. So Only
configure DSC engines in use, instead of the maximum number of DSC
engines.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index c734d2c5790d2a8f5f20c4b5aa1e316062d9b34d..5b98ae96bf5d46872a7af801d4157820d72af01f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -2027,11 +2027,11 @@ static void dpu_encoder_dsc_pipe_cfg(struct dpu_hw_ctl *ctl,
 static void dpu_encoder_prep_dsc(struct dpu_encoder_virt *dpu_enc,
 				 struct drm_dsc_config *dsc)
 {
-	/* coding only for 2LM, 2enc, 1 dsc config */
 	struct dpu_encoder_phys *enc_master = dpu_enc->cur_master;
 	struct dpu_hw_ctl *ctl = enc_master->hw_ctl;
 	struct dpu_hw_dsc *hw_dsc[MAX_CHANNELS_PER_ENC];
 	struct dpu_hw_pingpong *hw_pp[MAX_CHANNELS_PER_ENC];
+	int num_dsc = dpu_enc->num_dscs;
 	int this_frame_slices;
 	int intf_ip_w, enc_ip_w;
 	int dsc_common_mode;
@@ -2039,7 +2039,7 @@ static void dpu_encoder_prep_dsc(struct dpu_encoder_virt *dpu_enc,
 	u32 initial_lines;
 	int i;
 
-	for (i = 0; i < MAX_CHANNELS_PER_ENC; i++) {
+	for (i = 0; i < num_dsc; i++) {
 		hw_pp[i] = dpu_enc->hw_pp[i];
 		hw_dsc[i] = dpu_enc->hw_dsc[i];
 
@@ -2068,7 +2068,7 @@ static void dpu_encoder_prep_dsc(struct dpu_encoder_virt *dpu_enc,
 	enc_ip_w = intf_ip_w / 2;
 	initial_lines = dpu_encoder_dsc_initial_line_calc(dsc, enc_ip_w);
 
-	for (i = 0; i < MAX_CHANNELS_PER_ENC; i++)
+	for (i = 0; i < num_dsc; i++)
 		dpu_encoder_dsc_pipe_cfg(ctl, hw_dsc[i], hw_pp[i],
 					 dsc, dsc_common_mode, initial_lines);
 }

-- 
2.34.1


