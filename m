Return-Path: <linux-kernel+bounces-518089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 551FFA389D5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72E0E7A3CE7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628C4227583;
	Mon, 17 Feb 2025 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mm7MyRk1"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5329227589
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739810524; cv=none; b=oVngJrc4ba4CJiSAYjKvZzP/v80861cwlPeFNoMWdB9cHKG+Zs+NiqLgL9Wq1fNcA5rdBTqhBf56RMGrl1NAT8c+xmPSXo4SkMidwAxgmxcI8XdMKH3fjJ7lSp3HVgNinWhteFjGaDDJG9MiJ2ZgH57sC98GXKyzdlY5E+S9oTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739810524; c=relaxed/simple;
	bh=GT04k1mFiJ+qnvaMmIwvNVTsraccfdG4M0v2LnZow7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cRB7ezy7dwpuC/dSbTaeHMLiIehrNQnTSesCj+M8Yzboe1roflND4wooTpDezYj3hD1l8YGzVIPo+q/Nzu7htFvvjKC0NtoQ70ZhAkZkzM3DmPA2ZJXs+q+qW0Frbivso19DpBv+ipirTn4y0c3sEjp2tCTFbiH03rxwzU5JSjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mm7MyRk1; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abb76cc6108so21340666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739810521; x=1740415321; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xFipMKdumZp/ytSDr8+PyLocBgLdcXYBb9dko7M0NwQ=;
        b=Mm7MyRk13v0FV7I7mfVkOkaBalMxpWCHVEbMIBz1cn2BwUnjlNn/G+w671sARUM+Ec
         T/RIeiVE1bwO1mVIxsNVK/4O7dJqZjMp9/V82G8A99RFGpfII/Up9xbBSNDJJ+2SGgIb
         zG6TmpZGDi8qEt2AqREFzt65qV3OhN9grXU+w2UUkdtiqYn0dV0qgNuSpN0uN37/j9SK
         uwaPNr6+4CHfrp5gz4xEA2B/e/6mVtgqIQHF29x5Nd2yiRz1pdmz/KvJ6z3OQt9goV8a
         sq0blT66Ammpj8/b2+JzrSSCAchg95M8+pYVXnJps8UGMi/aBno/Rbi+PemQikXOmQYo
         zlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739810521; x=1740415321;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFipMKdumZp/ytSDr8+PyLocBgLdcXYBb9dko7M0NwQ=;
        b=tKjCB1cqPDjMaup/2aM3Y2rYO9VAjNxe8xkZ41rsfAILz5QUl5PxeHwxbyyA7ROWrC
         sEVHb7dwYZLfWOj/blDCSyu/19O6ulRTcUg1TTgI0c3YF5RyMyvEKqU/QHN/8uHpRVo8
         H56aEaZZ/35zMDlydeDP11zfVTy3EnjaQGHL32aKopGoUUaJ6e4aez16VY2rvoLON/qN
         PJwxrnQxVsi7G/BUYP0Vz4k0nYHETDm2X0dxbKFdt6LVhnq2Ni99r1kTHCOhYptWdpQa
         Ub/Ksv9p7Nzz1mMH3D4BM/0uCQnihD0uAKhIHTrbDgwvoyPveoyGXjeqZe3pOtSIF+y5
         ec2A==
X-Forwarded-Encrypted: i=1; AJvYcCV69J4/ilJ2rixXKU9kP06ulzk515Db5l7homeo/1D2wFVky4iGnWJD7u6VKqNGiv1mseBizZNfMtbPeDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG3JulD9N+pWXCr/V8RZV31rQlRDM0Kk7dnEuxVaPnZvdfTC6L
	vooU0lypSjSZCyn9EyLRhTKeTfpdxV4yx5Lck4H+ALZVGf/6fEXi9iAfjZcyohs=
X-Gm-Gg: ASbGncv0QMe2s67ajfcn/pRobhHzxGP1AcjAb5IbK1d/9oakghrzv/XWJVh2QeysbnG
	6cSs8hdSY2NoFArcqbe/y+sYeHl3cfBhLrdtZQAueoXjW9PbHepx98sMWNfsJdqjCJR8hCjRL62
	nLLov3UUYivjswg/dx9GUY1t51kXHoNr2XIai9CScEQgIdDJLPNecLU4Ql5SJe/qBnYFVlTeg9u
	y/Nxg1Y7Jlzol2BLe4UJij5nGuCQliTwEKq3Elh6DvLyqffzyCJKq07PsHasPEsW5k+y1eIIh1r
	9dFdjG9yffSRp5MNTs81DOOgYVcc3og=
X-Google-Smtp-Source: AGHT+IH8X9Zg1clEmj/6r4mBE5gyMkbWVF3xBhqOvCd2zyGKE+fqYvp1/PXMHF0iPCM/T5BzreHRBw==
X-Received: by 2002:a17:907:9716:b0:ab3:8bcc:3d97 with SMTP id a640c23a62f3a-abb70ab8c13mr434167966b.5.1739810521088;
        Mon, 17 Feb 2025 08:42:01 -0800 (PST)
Received: from [127.0.1.1] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbac781b78sm82647966b.60.2025.02.17.08.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 08:42:00 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 17 Feb 2025 17:41:30 +0100
Subject: [PATCH v2 09/16] drm/msm/dpu: Add LM_7, DSC_[67], PP_[67] and
 MERGE_3D_5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-b4-sm8750-display-v2-9-d201dcdda6a4@linaro.org>
References: <20250217-b4-sm8750-display-v2-0-d201dcdda6a4@linaro.org>
In-Reply-To: <20250217-b4-sm8750-display-v2-0-d201dcdda6a4@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Jonathan Marek <jonathan@marek.ca>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Srini Kandagatla <srinivas.kandagatla@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1071;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=GT04k1mFiJ+qnvaMmIwvNVTsraccfdG4M0v2LnZow7o=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBns2a+MLwpsMNZdF7tUH90tpc2TJHTAFzK6warf
 UvcllLmaTyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ7NmvgAKCRDBN2bmhouD
 16chEACNIt2xqlhdWhrXc389+E83+h4BLRDazFXIiYNVaD9JcaFEyuQM6kY7DgZTV8VRl3y5qkn
 tVwtqRTfxtoN3Fld8M05ovL5vhjPfcQ4yoCwyNl9UNKPUstKe1d9jssKqPfJJhLV90CKNVA+ZFe
 UFCpL8LeceVXDcpeXlu4H3U7bKW7SVMQUEQO/lbwHnt5j3FSeBiiohB9neiP3Uuj3fi6hjzy/pi
 zLlY38SYUj6oLBkSfWFQO5PeYC3hEne/dX9Q6FDcQBb2ZRJgCj10SAhljWlOTLnw311BgPX0bkb
 1l5Yz20WmBtAt7Gs1DU1OwWw/pG/dwcbuG+Xdjr+wMvaZUbNRkJeHnSjrUIZXHbKON5O0QAgnD1
 cphzsYKOTibuiX3qzbGPvaaZ6ycDFgFDJ/bh6ienOrlhVqb0fFbY2Ov+bbuMPqWy9BiKRgE8PH4
 MMWjdY2fdQPImRCfztUDejLW/mRe/JEM1dGFSemCgIIBKChYEHw6MpVjzH/OSPGbuKVwMUhg7Ei
 4QeMvfrrtFaD8FdSkjxdh0tveR6pfztUkTqV7fESRK3ULxFQX1LftoOluU/dUrZJYz3sCCAsHDS
 7if/Ocxk7pRav9Rk8t0a/QDSCFZyQOONdASnz5TNH651HWn2wW0AHttdKIerqAxbtgE3wI7jgqV
 nhDLtV0OLBRE7Yw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add IDs for new blocks present in MDSS/MDP v12 for LM, DSC, PINGPONG and
MERGE_3D blocks.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
index ba7bb05efe9b8cac01a908e53121117e130f91ec..440a327c64eb83a944289c6ce9ef9a5bfacc25f3 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
@@ -123,6 +123,7 @@ enum dpu_lm {
 	LM_4,
 	LM_5,
 	LM_6,
+	LM_7,
 	LM_MAX
 };
 
@@ -167,6 +168,8 @@ enum dpu_dsc {
 	DSC_3,
 	DSC_4,
 	DSC_5,
+	DSC_6,
+	DSC_7,
 	DSC_MAX
 };
 
@@ -183,6 +186,8 @@ enum dpu_pingpong {
 	PINGPONG_3,
 	PINGPONG_4,
 	PINGPONG_5,
+	PINGPONG_6,
+	PINGPONG_7,
 	PINGPONG_CWB_0,
 	PINGPONG_CWB_1,
 	PINGPONG_CWB_2,
@@ -197,6 +202,7 @@ enum dpu_merge_3d {
 	MERGE_3D_2,
 	MERGE_3D_3,
 	MERGE_3D_4,
+	MERGE_3D_5,
 	MERGE_3D_MAX
 };
 

-- 
2.43.0


