Return-Path: <linux-kernel+bounces-537655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD34A48EC5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8DF23B6D5E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 02:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418D717AE11;
	Fri, 28 Feb 2025 02:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ky1v8DAY"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F8013CA8A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740710450; cv=none; b=mjG1cCD6Qz5S3blaWfEwNyXKAoENL6OVXV5Xjg2bZNYd6+UrrV2CZPWlYLfTj6dtiBDnwZQIRElUvP25vXaNWO7AbTSS+4t8aO6tjniYvId12UW7tfmAGwZaPLSM6+1Lj9BuqRCVMkv8Dk0qeaqXJYfdDldHepe5AprQDO04jLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740710450; c=relaxed/simple;
	bh=7BzZsMBnZu1h07UISleUgszbH3T6+OpRP/jWCT7kc0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rtA3+37zNcnUHqd1LjlXw1h9+sKBHSv40RSicpBRoJl+SXVysFHGIfTuQxWAKMCKZbCd1ottkCBsRX+6i4m3200LOw/FtS0hkcl3rOiD7otKDMleRvItiXJMQrYEIHi2EJTuIoCIeKaXapsBiD9o60ysCzGmUY5DQPAyo7JKf+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ky1v8DAY; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30a28bf1baaso15906881fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740710445; x=1741315245; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=21TVA0G0gojITtd03fcIP3wwFgnkOgv1z7AmIqkOOEg=;
        b=Ky1v8DAYh/0ExZga0A9yqHc8DKIbSgZpuudnnNuJIDzDJ4d1NkP51g0UBoPaeaAojX
         JLdibqAIUg99akohjEU/FnADJnP3icywxfjRshVMpju1y1TCLEPlzB/C070fqvkVGcpg
         v4ZDVG0Kv9PX4EM9sKcyu3c2PjPjXG2sG7gjiyJvP196Rbh2QGke0uk5z0nIWdJSkEXH
         rExSjPn5zkeXYFOqhqSmCoLTf92oIL/21yKV4m3ay+6o437R3J7tyhNXXXggaUnxYy1u
         wqqqdBCfoAqCIDYNu42mWlLvQl4lGuQQFXIE4bwl1lMpu2Tsozr+BdYMk/YQCQriowog
         8mbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740710445; x=1741315245;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21TVA0G0gojITtd03fcIP3wwFgnkOgv1z7AmIqkOOEg=;
        b=ed158OXlXiVlYA+2R1XkQZc4b+ssRcMFeocSSxkowvRVF8E2Q/r10yRX6/IvhzJj9f
         +W3XCZYBYGtQ3p+1lF+9DJtWXib0bNlTNXByHME8c2VTVU1xTmiMCh0rmn44dWsWtDCj
         U8YQYmoW3fNMB6nPTk3LwRDY+OUP74G/GmaA0q5IeAkiDpHKRRrZ3xw9kY56/bJboTkW
         zTuiHfFB4CEj9b9DZVO9GXinBywqe4yiNV3qV8g0K2IFClJkVoiHh5fnCoNhy3ypch9v
         RcNqaHHxEFoxw81Rly7zLE03FtErjoHvzau8giW2+VFCQBPIusrq9nU4+o78p8JsXCMj
         iaKw==
X-Forwarded-Encrypted: i=1; AJvYcCVBRgwXehhvsigfxq144KOD1m2iHC+aqxRsH1hhiCWZe4jFtAqdE00sXkzLbNkNHZ+OlM3g0FIvNFz4KWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgikU+Puy8yrET10jkYHvJr2je79kQIRtKmzPUTSolDWO/H/Pa
	yuZFwZRYLZ4p7ZuUILAmQxVQLWvdkCxgFv1/R+4nsm9LuKJD4LvlprHw00+EFCc=
X-Gm-Gg: ASbGnctN1mrtR8SVtHLZw+h9XVnuSsMxykAQtfS3RNtJ2GS7KIdac1wog0M104WzEv5
	UY4Q9WzMU+Dvj3uTSYlr0LcqH2Y28t7iP9icE1RlLoDmcMNOgdd622+KXi6rklxnqUtbI1DDDLV
	MsRwVVInc22uhjsT9FOpaVGxm5POBu60pDc35nE7lh80WRFzPG8lifgNN0P0qYQahp8aC4EUiFe
	NknrAlUZyZGZqIbGznvLytFGm5tFsLk8ielAxEMQmUSIlW7iA/JEvhjQRF79u2O/CY6dBq8d5By
	BQKkUo2LySjpIuM2klxMrcFXHaQT4gYV4w==
X-Google-Smtp-Source: AGHT+IE7Mky/M2fDSKSULiY34EQmUiMxEjS62GBJfX2zcyCayPQhXRzgX2IA/oB8JS7VImdstOeq7Q==
X-Received: by 2002:a2e:be9e:0:b0:2ff:d3c6:9cf4 with SMTP id 38308e7fff4ca-30b93200529mr4213001fa.1.1740710445348;
        Thu, 27 Feb 2025 18:40:45 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30b867a7403sm3493881fa.17.2025.02.27.18.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 18:40:44 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 28 Feb 2025 04:40:38 +0200
Subject: [PATCH 1/4] drm/msm/dpu: remove DSC feature bit for PINGPONG on
 MSM8937
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-dpu-fix-catalog-v1-1-b05d22fbc2b4@linaro.org>
References: <20250228-dpu-fix-catalog-v1-0-b05d22fbc2b4@linaro.org>
In-Reply-To: <20250228-dpu-fix-catalog-v1-0-b05d22fbc2b4@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1513;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=7BzZsMBnZu1h07UISleUgszbH3T6+OpRP/jWCT7kc0s=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnwSIouiJGhGOZyYTg9iPINN+LzRYzfnPSJR5m8
 KuNAd1pze+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ8EiKAAKCRCLPIo+Aiko
 1cATB/9IAWUW3l3iAA5pqb5DkZfeWKaw/TMntlcwc4Bb6aqNPNgO66bOsVK00C5ogk6vFwOFct4
 PnmRtKjTfFCYwEzwXiNDfOq+Ua7F1PmHEuAlCwH5nZGx0H7/N9tuCYrPSA9hmqEbEroie1zHG0s
 kTnOeXsw9p9puyTdXaGzHOrU/nizHJsXuCuBX3aSAGQmXCeAYXPy7k7HCb3aRqQrSeAsSfg6rYy
 Td0GRICCFRhTJJ6mQWHO+0IXlXfE5B3fu141VPJ5vs5doAJMkBIq67op4EGTsg7ehQCQB4iTZ9i
 MIiT1DyLeWTiMoh8f27DcnrTEMaQpbsqCxCxiiVZcih9G4fa
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The MSM8937 platform doesn't have DSC blocks nor does have it DSC
registers in the PINGPONG block. Drop the DPU_PINGPONG_DSC feature bit
from the PINGPONG's feature mask and, as it is the only remaining bit,
drop the .features assignment completely.

Fixes: c079680bb0fa ("drm/msm/dpu: Add support for MSM8937")
Reported-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_14_msm8937.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_14_msm8937.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_14_msm8937.h
index ab3dfb0b374ead36c7f07b0a77c703fb2c09ff8a..a848f825c5948c5819758e131af60b83b543b15a 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_14_msm8937.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_14_msm8937.h
@@ -100,14 +100,12 @@ static const struct dpu_pingpong_cfg msm8937_pp[] = {
 	{
 		.name = "pingpong_0", .id = PINGPONG_0,
 		.base = 0x70000, .len = 0xd4,
-		.features = PINGPONG_MSM8996_MASK,
 		.sblk = &msm8996_pp_sblk,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
 		.intr_rdptr = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 12),
 	}, {
 		.name = "pingpong_1", .id = PINGPONG_1,
 		.base = 0x70800, .len = 0xd4,
-		.features = PINGPONG_MSM8996_MASK,
 		.sblk = &msm8996_pp_sblk,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
 		.intr_rdptr = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 13),

-- 
2.39.5


