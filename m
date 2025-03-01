Return-Path: <linux-kernel+bounces-539860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5203DA4AA04
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 10:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B42257A9832
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 09:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2751DDC11;
	Sat,  1 Mar 2025 09:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rHxHPpTC"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B68E1D90B6
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 09:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740821115; cv=none; b=tXOBcM12knrSIHZQsI9dfAZsu8pJ7cVonTcgx4S4hnoh/ixBFFyySSYWnzfwL2twP7DOJYA9eBDzQwRZFeJHhTK2w5sjyYAv5tofNBCwrgQ2uuWY+cy9XYIjF8/mMN1H7keIu5/PBfkG1ajnMXQpq7lJBdIt+ChUIpxbZFusWt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740821115; c=relaxed/simple;
	bh=xfJndy0LJ6tSYaPs6OPWvlHfde8Gt+RzIdnKqXQJW2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tKvGbdmMoyTX2cfMJg/WkV5JGVotAG2ikHCTsvqlbs0Sab8au/yA6S69i8BmL1dSyGZ5yuJmRb6XsErVLFBGQ7xo0oQXJLYA07dvrEp0CvV/3qVop00cphoT3dLi4+bi2DJVfTUh4qp0OGTPm2mSr9RXAbt0gO4jafR+de6WDC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rHxHPpTC; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54954fa61c8so1290797e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 01:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740821112; x=1741425912; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=URwOcNjnz6PkMJ2QDjvaSLAsGLbSDP+kGsc1C7zaZt0=;
        b=rHxHPpTClM80Lh9L6ITu3fEew97kuaagqOFH1oAZQRx/t9pY7/wdphPV7e3DxySAd6
         O2LDHa/akoZRVYnhQlOXhZAhxIFiiQExr1W+im8FNNFoFDimvFZewLrDKeJST497w6VN
         0ouWAJU2KCeC4JToHPLxEdXsrnd6v3wRvtB4yagN9bEf3Dg8HC8Y8rDDCuoMWfP4YP5l
         XCO7GESFcqgLkfHrorBHxTnVD+dEomOIKLJ2a/DE1mlixs8OSRPF8O+VE6sFJuVnX0T1
         EKkdxid9pKzO+gnqbfwGAtFo8YClInodsGos4SZJeb2LZ+/AmDDUUxqm4Wpeh2VzBe0u
         TLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740821112; x=1741425912;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=URwOcNjnz6PkMJ2QDjvaSLAsGLbSDP+kGsc1C7zaZt0=;
        b=eRze12dKCePJ5V78J2edbcu3P4p4F33tZ4RkCM9WB4DPmWA00vYLTp/0QftVS6dWxQ
         z34+qtYycDuTjJ41OaXaVxdlvYRhWnP20l2zYEHYTFEC24tBiTmCDhM4D+1njq3ARsyi
         X+Mn5Ld72wVMGC82rWIeDSWu/YFsH7jEha9cSmpYt+XVTIxaQJ+ChYti/FLIBfXwM3Jz
         tpWfZkitiTnj1eCr/ZTGbR5Fy25v1HmJurkwPCD/kCyQduvh/OP+iZlkkOTambt2zMrh
         RztQFYMC1UzgqjVrWjFGOD4czJKtOmQzuIRSKz8TqAiPnjnkNkffCRnXtlfZBEKW772l
         cBOg==
X-Forwarded-Encrypted: i=1; AJvYcCUbS3iJiu7qxznTtH8zKyMBNUEPKW/wZhjmXQUQlsuO7WbC/Gb5V4ywmELscRWQSrg0c3GDzM4Rg7hnqeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPc2dJvS3GY2wEqrNWgDBcejJwrysUD52xtF6Zeyybp2I/5gx6
	CV79nvobl/aSznqIrfKutm6m91Hrlyq+ucuD1YF/35CHuK2rRf1NBubHuiTssAc=
X-Gm-Gg: ASbGnct3B2dvdAqTYr1AW1U5/CBBVJev2WGxDfjDhslKG8c9GwdFL9d6wdFj2UTG/7f
	BnKskcGufzTq1BuRsmCufJOfEIILtOtx+zkjsogR8ftPDUZfBT/orbwtkQhvgj7umVVMdMzetWT
	zjWEUJ8NKv6VFySv6XWAvZKzhzTnnDBWBiJ/yUm0DeW2OX0JFfwFN051aEGQVzb5sxJH/DhUUal
	SlZ9X4T/B6tMQ75z90kIQhsC/HJVUoKStlwgJ4CJdnk3UM+USR/en5VAsiUwNfcBHiwkMW3XXje
	O+TpcsC3jvi9w4UzqWC+G1GP/a41zj2RtmxqrKzYiiXqlQZ792/l
X-Google-Smtp-Source: AGHT+IEh8A2sl1pAlOlMCHBvb8v6txd7ryhkeXioo/K+sIwr784pk95XMok+4SarSyMfmUmdP9cUsw==
X-Received: by 2002:a05:6512:128e:b0:545:9e4:ca91 with SMTP id 2adb3069b0e04-5494c38072bmr2929372e87.39.1740821111736;
        Sat, 01 Mar 2025 01:25:11 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5494417432csm738406e87.52.2025.03.01.01.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 01:25:10 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 01 Mar 2025 11:24:58 +0200
Subject: [PATCH v2 5/5] drm/msm/dpu: remove DSC feature bit for PINGPONG on
 SDM630
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250301-dpu-fix-catalog-v2-5-498271be8b50@linaro.org>
References: <20250301-dpu-fix-catalog-v2-0-498271be8b50@linaro.org>
In-Reply-To: <20250301-dpu-fix-catalog-v2-0-498271be8b50@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1811;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=xfJndy0LJ6tSYaPs6OPWvlHfde8Gt+RzIdnKqXQJW2A=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnwtJouDh1p63euLoMf/eO1Aa1kaVi4m9jHe64K
 bORUvpxw0GJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ8LSaAAKCRCLPIo+Aiko
 1Q2wB/9+J8HcIzLcD4Z54mCSlyjwkQ3C2RZjJ0uAwHKstzXjx0uAq015I1fXZN787warvOm3j3L
 ig0302evj00WTzKaZrN10rzDnrgNK02AHwxv8GzoFst4YwaX6cEHT+KdUdURGSwS9ZTrJiTxTLw
 mxpz/opigMTdni3hSRSAGrPYop6rS3y8nVJ4FaFfXPptbG/RBr0iOlIfL8rgqK6DWb0bw7vYMJm
 xlMPF66WvRaTDGCudXLahAGjGqT4ggHR+p03OVjhQdOyCGRscvTvI7Q3JwqN09qFwJSKR/+y78n
 vU7sLNkNz1VHMK+BKtoWqHFza6tec6uBRWhHiKh9KtHSCX/W
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The SDM630 platform doesn't have DSC blocks nor does have it DSC
registers in the PINGPONG block. Drop the DPU_PINGPONG_DSC feature bit
from the PINGPONG's feature mask, replacing PINGPONG_SDM845_MASK with
BIT(DPU_PINGPONG_DITHER).

Fixes: 7204df5e7e68 ("drm/msm/dpu: add support for SDM660 and SDM630 platforms")
Reported-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

---
Note, Konrad pointed out that vendor DT doesn't define DIPTHER support
for this platform, however I believe this is because support for this
platform predates DITHER support in the vendor kernels.
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_3_sdm630.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_3_sdm630.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_3_sdm630.h
index 3aed9aa4c533f167ece7b4a5eb84fe49c4929df5..99c0f824d8f00474812bde12e7d83ba3de1834f1 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_3_sdm630.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_3_sdm630.h
@@ -115,14 +115,14 @@ static const struct dpu_pingpong_cfg sdm630_pp[] = {
 	{
 		.name = "pingpong_0", .id = PINGPONG_0,
 		.base = 0x70000, .len = 0xd4,
-		.features = PINGPONG_SDM845_MASK,
+		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sdm845_pp_sblk,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
 		.intr_rdptr = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 12),
 	}, {
 		.name = "pingpong_2", .id = PINGPONG_2,
 		.base = 0x71000, .len = 0xd4,
-		.features = PINGPONG_SDM845_MASK,
+		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sdm845_pp_sblk,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
 		.intr_rdptr = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 14),

-- 
2.39.5


