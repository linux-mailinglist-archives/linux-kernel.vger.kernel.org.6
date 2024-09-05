Return-Path: <linux-kernel+bounces-316264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C5196CD39
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C87D286166
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CFE14B07E;
	Thu,  5 Sep 2024 03:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hcz7ahpt"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7B214601F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 03:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725506781; cv=none; b=TH2RdARXIRgE1bZayYZ0P+xHxVo+JE3Gr9IYdgDXkf/vCdUM7x3RsQl00VtQH1JodNKmHTcDIY8FCK/J0WhpjfOa94f9YJj81scIZ4Tk8bf3iken7EhahEtVMFiV3G7fRGAFJYInvTshLZx/cqFppgtx3HEm0VGKOrkxjYlCh8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725506781; c=relaxed/simple;
	bh=y3ucrmUxDNZOI4nUsv8gjzz+ts2FHFe8wotadhtRUnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QRXNbV0HUj/6ndbQfQU90T+as5jTdPNDI0MrcWGJM+lkSEFvwPb84IQCjlw8mHcGMHpS0Nb7VNqmHZUW/w9dZMKBjZxIpQ5eXF3hdfTKc9p/7Yktuttv2+rfQiND+dXEalmr9knHvsGmA3+IdJWlj++a5DXs0BmS9BONddLI4TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hcz7ahpt; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53567b4c3f4so207571e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 20:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725506777; x=1726111577; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HXkbUeL6IBm1wfBjjD3+Jqzr9VFTIqcKeiflyied+rY=;
        b=hcz7ahptxa6eD3Fz2duRCUvKgRjaXKaHecNue7jFfhTgqwSa1un+qgJfgKzdwUMMd+
         M0DfeuEgolF0p3M2S4/11jOiuymUWfPgY+Tnnhl5ojOqM1Ls1qmrXaVaWhLZR78pfnWe
         BUsxX5+JF7iZYwfN4uyHPI3MbcWAvWS2ssLUZVv/LW1tO3DNPeco3qlOpNna9LFhT/gZ
         13YXLUldQSKGN1oYYbPmsyDB5CWgV8I7qf0ECtG5uj4AjyZcAwXXbzh/Ug96coeK55VJ
         wxyzlXOfc/IdSjELsxCPl4VDjoXsnK13AsLI6VHOC2J+ARZ1RFZhAMsKbpTQTmzjr+Vj
         8KuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725506777; x=1726111577;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXkbUeL6IBm1wfBjjD3+Jqzr9VFTIqcKeiflyied+rY=;
        b=teEFUt7Heg/OzZC7APrMLWMUvaIcnY87cgUt/ux/mRueDXMlvpLR9m0JUenq3n+Rh4
         8sdB7Cxxl78WFMqAB7/Ekuz0N7RsyRRFwl2hRT7zfnG3FqcKcl6MuwC+x7c7FWvN8US5
         XCJL5HhKDxtXFJWDWhF2+w1X4vdI0nkFEjGTre3HihL75UNfNmvWvjqbdyJXeKauRMW7
         TyHPijy8hmBin8u0wnsQpWEw8XI7ZQC5MIXidp875JDC2Uq5+e6u3YIoAVQFCGUjoKwf
         xWQbY5g5sukBB24SgoFCTJ3eRu99I7A6LoCZAFI7tWAabypvX9OCbDV54lH6kG8h8kgi
         AUQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYz6zfqc/LWFx8NCe3m/18wsxdlXmgK4/tNg2r9IO8OiYadXFDIrr798O3IQfK4VpXO2ZCtVqobWHrDVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJxya+3lXkVNh+2R6QiGsnRfwPTB1uhGGN3xo1Y3/VgFBTVyYO
	c3GmwkkAX6iB1fxBsjbDXm5qxyltjBTEirjZGbWHQ5tCLkslHkUAvMuG/NhOcxE=
X-Google-Smtp-Source: AGHT+IFMkHsMnMLWdT1fhzzdQZpoQBpRVkz8r8+V5KRN0VXmkFhO+BW4y2FQh7cEClInnZi740RvbA==
X-Received: by 2002:a05:6512:1395:b0:52e:74f5:d13 with SMTP id 2adb3069b0e04-53546b33317mr13331248e87.30.1725506777322;
        Wed, 04 Sep 2024 20:26:17 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53540841a3csm2533860e87.226.2024.09.04.20.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 20:26:16 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 05 Sep 2024 06:26:14 +0300
Subject: [PATCH 2/3] drm/msm/dpu: drop LM_3 / LM_4 on SDM845
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-dpu-fix-sdm845-catalog-v1-2-3363d03998bd@linaro.org>
References: <20240905-dpu-fix-sdm845-catalog-v1-0-3363d03998bd@linaro.org>
In-Reply-To: <20240905-dpu-fix-sdm845-catalog-v1-0-3363d03998bd@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Sravanthi Kollukuduru <skolluku@codeaurora.org>, 
 Rajesh Yadav <ryadav@codeaurora.org>, 
 Archit Taneja <architt@codeaurora.org>, 
 Jami Kettunen <jami.kettunen@somainline.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jeykumar Sankaran <jsanka@codeaurora.org>, 
 Chandan Uddaraju <chandanu@codeaurora.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1183;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=y3ucrmUxDNZOI4nUsv8gjzz+ts2FHFe8wotadhtRUnQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBm2STW20N3JEPm4IfZde4z+mefw49r+VBcRWLuR
 d3caRDz19uJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZtkk1gAKCRCLPIo+Aiko
 1amSCACy4WnuagqHhLhtVUcRjFzx4e6xhzfd0pzurnwJcXaBkI+erzRSKHqlcjdYP/agBGblehI
 yxt4Ecpq9NZRFIO2ZwD0K9EhoBhUQmjYNO+XtEX677quTRV3v5Phh1RJk/+PajLYo+XWCO1fP8T
 JjcwNJdezEZ58bFMoObKhzx8jp4Gx0Y99gv6nL+amo2dxPsAHPT9yuDHVK+jR85QNio3TGNG/yl
 WNWE8BgOc1FstLs6qYjnYms+JBmNfwMqmxp8F0jHReXkSLvmZs9rvLdbrH2tVxuh2IcnIf9Cp07
 c12CP36gN8p+pWot/Ca0cNGE11l71XHwNMxzeBaN79F1qZ5F
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

On the SDM845 platform ther are no LM_3 and LM_4 blocks. Drop them from
the SDM845 catalog.

Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h
index 59eeea3dd2e9..72bd4f7e9e50 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h
@@ -155,18 +155,6 @@ static const struct dpu_lm_cfg sdm845_lm[] = {
 		.lm_pair = LM_5,
 		.pingpong = PINGPONG_2,
 		.dspp = DSPP_2,
-	}, {
-		.name = "lm_3", .id = LM_3,
-		.base = 0x0, .len = 0x320,
-		.features = MIXER_SDM845_MASK,
-		.sblk = &sdm845_lm_sblk,
-		.pingpong = PINGPONG_NONE,
-	}, {
-		.name = "lm_4", .id = LM_4,
-		.base = 0x0, .len = 0x320,
-		.features = MIXER_SDM845_MASK,
-		.sblk = &sdm845_lm_sblk,
-		.pingpong = PINGPONG_NONE,
 	}, {
 		.name = "lm_5", .id = LM_5,
 		.base = 0x49000, .len = 0x320,

-- 
2.39.2


