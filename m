Return-Path: <linux-kernel+bounces-526010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBA2A3F8B4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C27A19E0BDF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0292116FE;
	Fri, 21 Feb 2025 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b9kjbxHT"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DBE218AAA
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740151518; cv=none; b=Q2oLU2oxDgU9WCu0wFIsAx/YZNiRbcrcsLkYZ4PKkXm6i8ne3fhkGU/E35g8fv594lKLXEtrQI0H+FOSsAVLMTLyRGbJWa0LyiEuWklojWiklpK/iXhix0gJRyssGBrhuglpHA6vbqa1qqIZsx+OxKAhbo1f1TZKCcvS+0oM8tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740151518; c=relaxed/simple;
	bh=bzuzeNkiJscH5kTRUkk1PKDv/alOIE9Ky2ZYSPCt8E4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RazOdKnEbONVPDG5BcdNRjCCYOwgime/t5qiF6AGc54K5da6joqZhuRKyZpgEZnsYct6bZZYAGuVfqHFelkQDGZLptElobtxj65SRKqjWEu8Hs+mN88rEESnIGx2hu4A14qbDaZQS9ziHlu4rami/3B4f8eYqKCu0qESuPMnVYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b9kjbxHT; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5debb4aef2eso332857a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 07:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740151515; x=1740756315; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=weMt86XyDp4W/QQGY55D9HolbDoqGFQ02eGoOnDXEFI=;
        b=b9kjbxHTMujd4DGnz1e/l3nHYyesAYLt5y/dbIJeHOX5oVsoDXyqd9608W9Ef237+A
         xaWUs1RxIPKD4uamHmvkmxuLXvnbno6bpcdP91+1R9gbV8Z5UaH2yNpK/CqC7RugDxPh
         +UqmoqjRphCtWJon/W0XJBBTev8FlRyPTpBJXDAQ2I0Zr9GjEA6wzPTnljwGO1fCxeyG
         9AkPlfFw+Dyu+Md0loy4v59qOML3xLuAM3dMTXFKJvOpEk0sY+/bYPkGH0BFXAjs4QF7
         /R0RASIpqzwCd5DCrl0ICdTHTkVgnN1HFN+DzovURw47vqkGnm/1OO5Exiku1odoheje
         Kw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740151515; x=1740756315;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=weMt86XyDp4W/QQGY55D9HolbDoqGFQ02eGoOnDXEFI=;
        b=t+Xi8K749JgcAN5d81OCPZ0rBAh0PDWtIxZks+A8EpHa/rY8KhYLDKzYtoIOcfPm20
         qtNL0w8O5O1jx7jbjjmGLHKkr9jybzNJV2wvaTHHq3ABPCAL5NQckjc+39joc2s5NJPI
         yHs/F6I0atCoFTRQ3+4UZKlYTWANO9oLsRMI0Nj6w+uctOxsLMgx3MloZ1eOWejUDdSs
         J4vxqK+8Mb+P5H7aI+SSIhoOh55od2J0RtN9kcgfMT2fgfKNB9sbnZmadPwNRPUCdYBj
         HY5dC3HanV9SwU/v+EsAR2eO4frZwmjKOiS3KenQyTqY3QHw8jzKpNFhNziqRgPpLb4b
         ck9w==
X-Forwarded-Encrypted: i=1; AJvYcCUifCdWbuc7iTHgJYakT7KC3K+dYI88840tiiIUfe3oDrZezA/MxtnKDnpMNrt9GXJXNdSCLGupt/FnxCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ8jJTCTRDzPHmUPeBCdRuxth0Kx43+gNMEKOyJB/vstRvzlL1
	ecBR2DzRW4JJbr7BZPcKU6T6TjG3LZSe+23FfRVNYGJw54Q+a1d1EBXcaKDbFWg=
X-Gm-Gg: ASbGncuxxl47C9+N8i49jYJJeU1WLH6uS5x2SWhCdZFVaXJB0TOp73wIGRgOSDYkaTp
	MVo91khGfRQhowpfG44bZft+1ryL0H3MqyJOYpEzPtDLUbjzwR+vEK0ee4iNS7Slxc+VSh1R1nr
	JoolC1u6Q0jq4wB4suItpvma7OqrO6ZwTsx5/OBM1QlZ8EhWRpRCWqsIRUd5EPen+7fnQH1IHVj
	VF1+GuhWaLB8TzM4oZuZLT0pyiprI2KIFBNMXH2R+ccUWPfulRV4a6dZiCbvw+zHblB7TPHsR0m
	lNAOwMr+Gs5saNXNRKwe2yqC8GSn4AXLAengcr6nMAD/An95tp8NWMgVNvF9JcF8mP67Xm023Ad
	G
X-Google-Smtp-Source: AGHT+IFDyjSHRea4rX/7Aeq6JLyEZ6cRyPnq/BCnoQABDafqn4KFEHkg2SYMLI4eyTXsMPzgd2+BrQ==
X-Received: by 2002:a17:906:6a11:b0:ab6:6176:9dff with SMTP id a640c23a62f3a-abc096d0bf8mr152564766b.0.1740151515441;
        Fri, 21 Feb 2025 07:25:15 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbaa56026fsm865456666b.113.2025.02.21.07.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 07:25:14 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 21 Feb 2025 16:24:23 +0100
Subject: [PATCH v3 13/21] drm/msm/dpu: Add LM_7, DSC_[67], PP_[67] and
 MERGE_3D_5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-b4-sm8750-display-v3-13-3ea95b1630ea@linaro.org>
References: <20250221-b4-sm8750-display-v3-0-3ea95b1630ea@linaro.org>
In-Reply-To: <20250221-b4-sm8750-display-v3-0-3ea95b1630ea@linaro.org>
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
 Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
 Rob Clark <robdclark@chromium.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1188;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=bzuzeNkiJscH5kTRUkk1PKDv/alOIE9Ky2ZYSPCt8E4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnuJq3m3ZkqVOTreV+MsrI2OTc2gJvjgKQJixbL
 bD4+889hfuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ7iatwAKCRDBN2bmhouD
 1+KCD/9AEgC8Y2kI3mCVg4krUXQriXGKDj7FbnnOR/Xj00wZDIzf/C1ZtiWso+kSH4H9LFr31O/
 B1drd70pD/tY20Xpm+FbvMkCPhAMw+VMdfrV+krHDDn4WM47qRj8UOUGtqXnddoDAu0lHkLjXFa
 91cxumGK7PYPXF0oli8gCk6tlWJ8/6FNisXwhUq1DBg1hQNd3g+I9uW6FvXq5MBqHoFjd0+OAHc
 Pwj7rFkqziPkcaekbgvhFwevCMcbiM7TQtUDmNmuIllJRyV7q6Wudn+rfvxfJZj7USQ2Sy7WGi5
 SKBMIFcWFy91XAw/OiDRkEF6X71SRHtyW2V70BC1kPeYDLp+laaD99M3eq0+VpI94WkKirRUBL9
 /mjCE60r6pUBRgF6lgdELJKTLFm631x0nSQdyzGMzTvuRc3ErfjntAZeNDKl4XpDxAn0pc2CsLu
 QBQMBJO/sqjXU71ZwpPK/iKmYtP/HZkkB8zta/9C4t5kjRAZYTovVqqQY7VXZjan9gs0OoTwL5/
 FnthwgNN7iyJvOEqf4/vK48ZblofSIR0Akb09ySjV/uGV6tC5sOat5jqas5lvFYZibSzO8X7cdU
 hg1gQOj4Ywhjy4IAM2BeWyg8M6nkdWemkq/cbbjcLEUbtYSjceQpgXWw/9lgiC+j0VipAcmcgj0
 x52+WOStLyzQ9Sw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add IDs for new blocks present in MDSS/MDP v12 for LM, DSC, PINGPONG and
MERGE_3D blocks.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
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


