Return-Path: <linux-kernel+bounces-539856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43317A4A9FC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 10:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3838C1745EC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 09:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A18E1D5CF2;
	Sat,  1 Mar 2025 09:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KqWkuggm"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94431D5147
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 09:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740821105; cv=none; b=LblBOZ/tpmlXIFwhRPy0F7HSGICbTbnWiyz72Yie21qgwBbwTe8mIjuslfjyHLbREd5motbaFlDgDqXIVusMrN3b5KemTLZlDFPxeTBbgTq38R2CWz/1tPzmA7yBGah7F1iv/L+E+eq+lfn9W85H+YrRwfzxs5bzl0Sgmcr30/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740821105; c=relaxed/simple;
	bh=6iPuaAjsYMeQVkUS24obUEbYrmaOHTnqfR5LGKvkJrI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RKR8uDDzmX0I+cwJJLTh+MxTcKFIeOfxEhR4kZ2F3PC/nRHcmLMvkPh/CkmJe/oEc0XhZ8gIyBCAtUqaIm72xbrEBwMU42IBtQzSo/JPe79lSMK5F6dnnguXzKhmkFcuzyrDVQial0wTFs8WyJR2X0Dr872x+H/cvmqwoUb4u1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KqWkuggm; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5462ea9691cso3225354e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 01:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740821102; x=1741425902; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0JVwBbchrlGfLWd7zeEe09mlkUBfIcbBf0ReoU16PUE=;
        b=KqWkuggm8CoUDhxNCcgRfn4i1ZR6fyU18f5kXaZaac12hId2I7aO3jDjQ9VusDZj2X
         7/vU069FFJqucxtJHvrHG0hPMcksTNz6fwh0Fn4sl/NGFk6kmiEjwfzOywjGax1HNrUE
         TQiz2dSDoksa/hMMCSGWpadvFWlE5uPnQn4Ias4y7uxHZdL5O4T+qTFdbzs/6WeDlyGr
         ygOmOLzpzYzAvygX6KOrbJdXMyI+Andy3x3XRqMfx/LEPAqDqzqd/55qNWhAwEp+uXKu
         +Anb5tgCvKWaWYQLv0boQU7JbQCv5gtmNrsHKWDJpeOkWY+n8sUOFkrhD5c01LYBeT1X
         Bywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740821102; x=1741425902;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0JVwBbchrlGfLWd7zeEe09mlkUBfIcbBf0ReoU16PUE=;
        b=NkuY7Le5rxjrkmR/BfDb8IP6rt6MsERKFxMU9e23F2I5S160lpOMVT7ofi9b2w69j8
         wYg0btIo6p9/6pa+BPVG+A04fFv3jxvD3/APDfVuOhrwAuGcZI/s3rQ99pgjQgdWxKfV
         iuWNBAyZhnYHJ3Xgr1tPIB5QxcQTKC63Ua8RNzVwmdr1EevO/yJ8VWHxEfOMromgsoAw
         gJfut7tuablHNeoweyLa5fcZe6vquI87DW6X8V0BH2Px/R6Fei+UUpn5toopl6KmbYHv
         hkWRu4AR94PHlnACs3Jo1mPBpTAuwSqmZJp55E62j+f9ZJT1g4yG7H6qkqCmlTst6eJo
         T0dg==
X-Forwarded-Encrypted: i=1; AJvYcCUWUQBM6TM3ViyILlyD/8Aw3fCVsmyWquZZDn+NGeYBWdOpPCYzmqsnNRpeT+Al8GyLjnY5E768MNmIrVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZANbW9weenyjRk6i7kq4tncOYN2KmK7ry7JvruFp+K1eq9858
	Js/Igi9SPFlFbBjaGJF0LMQPELU80p6ynEW7+SceDrsV0XK4Z/cfITO64iJVlr4=
X-Gm-Gg: ASbGncukqgUs0DdTulpl6Pdf8AjFilgSQwic7QYYY29SMYLfiVvsNoKZ0brThCma5EK
	BIBlVQDPtGZ37QTTZ4TxkHqcYX21zl/zDujomrhIagEsvpLHXOO6FdHPCqZ2w2fH4ojx13zmyxL
	j6EKlt4JDcsC2dOPLJRUC6+oPRPcO0QERwr4MNISd/3S0wEH8bv7rXHCULH2wrzbsgmM8Dc+0yS
	Ypdl2j0eNDLasQYlhB3Jj/ZIezWnoy4Ywhj3JKA5EY0cn8h6NcoRl2nqwKmxhpR6VEXMJJ0YAEY
	/UaA5TQYOrjuKsKwxoMzHCAuIubBkNH8sG2ubE1QtE1C9WB/yH4K
X-Google-Smtp-Source: AGHT+IFyI4K4ofy4rt283J1E493B2LFgM14L99NpHlb5eH+sLu5qjueAHc56DM5e2fZC/5lr7A1fIQ==
X-Received: by 2002:a05:6512:158f:b0:546:2ea9:6666 with SMTP id 2adb3069b0e04-5494c37d8b1mr2545975e87.34.1740821101846;
        Sat, 01 Mar 2025 01:25:01 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5494417432csm738406e87.52.2025.03.01.01.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 01:25:00 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 01 Mar 2025 11:24:54 +0200
Subject: [PATCH v2 1/5] drm/msm/dpu: remove DSC feature bit for PINGPONG on
 MSM8937
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250301-dpu-fix-catalog-v2-1-498271be8b50@linaro.org>
References: <20250301-dpu-fix-catalog-v2-0-498271be8b50@linaro.org>
In-Reply-To: <20250301-dpu-fix-catalog-v2-0-498271be8b50@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1574;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=6iPuaAjsYMeQVkUS24obUEbYrmaOHTnqfR5LGKvkJrI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnwtJn4QALW4Yp9jHaAiSTff5oWqqXJrWsumAXS
 yBUql9GT86JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ8LSZwAKCRCLPIo+Aiko
 1bKaB/0TSkQtXBypTrGIYYMHCArbLA2WM5wcSRk1VeH/6Oy/jD6i8npth08Pb7n3qqv42TSGdFP
 9Ah5kV7z1VZiMxs16n5Zqq/sUNCXg4gVnuuNUTp/Q0RQGDZdwMyhANgV7PFR//V6/UVDw0BKhub
 t8ehERkXMhY00pPHTnpuTRlqvUkbpsWNx8xy801MR0qAm4NSJ9PFmWbiaa7+zbDlpSxoU3g6kog
 AlLCfhbQ1mQpBiCGvxrFEvOayxMX+Qra03tg/D9jtulkr8Qyn52sfGmKsoMENLpc7PBh5isfGBE
 w1iRAIAElUBfHMniHEFWvPnwro0GxfbQZM5s+GTcwVjZCYk6
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The MSM8937 platform doesn't have DSC blocks nor does have it DSC
registers in the PINGPONG block. Drop the DPU_PINGPONG_DSC feature bit
from the PINGPONG's feature mask and, as it is the only remaining bit,
drop the .features assignment completely.

Fixes: c079680bb0fa ("drm/msm/dpu: Add support for MSM8937")
Reported-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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


