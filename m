Return-Path: <linux-kernel+bounces-539857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E60A4A9FE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 10:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28FD9189B0E7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 09:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C797C1D5CF9;
	Sat,  1 Mar 2025 09:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MP/oQIyq"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692D91D5CF8
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 09:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740821108; cv=none; b=jMiRv/tqQHFPQ/gRGGjhyU+wdRhHnLK3ss2JEBeKwzRa9QEEhYxMP9foZteCoc28lrhTSwMh5xz5Wqk0ESA16aJNPcJkVZBPcnU7LUr7eRpD267bnlxy7w48QyGqenKBiVm695DDyhVdPYWyaUVw/dV30zLOvlzXCDv4m1wbzKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740821108; c=relaxed/simple;
	bh=MfIfb1GLue9MerIIR2rhWjY6rmZBoFPVe5vbiAysvVc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dxNXnabo/RANTVuEoP8ob5trY660y5M41LQS1Oc/8t0f0gngXrUM4PTjBsE20d1aEx6Vl5Q8qVqEpe4nmEgw2nGGGkCQejwVBBiTWjvG/pPi5Mm02ggqYDChDEi64A9BtIZEaClZIe+virPXCByInNYtJT11gR+KAMgCw7vdMe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MP/oQIyq; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30613802a59so32836931fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 01:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740821104; x=1741425904; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h5L/pucqd7w1XEPp1X1sTPz+Fsqhsm/pl7T20lV9Gm8=;
        b=MP/oQIyquOx26Q21G81qpr+vaZGzVIX+MQ4sXIZjY3L6JjhzZiXQDID5dXLjP4h5mS
         mfQ/BaC7lcVm9DD2SR0cLHbo45FlMYnDulKravts6Oslzr4LvCzrhThIuvHXwlkLaEXC
         EN8U/Nr3YDowkHz+5oyAGEMMQ+uPiYQ/tFGKxiXtEijN4mAAvp5DoccbMqaRRqy023Bl
         bib4GI/iCJNniG6WyfROPrNRUtdYHCplv1oS0F8upMFigPQ5FOsXv4Hz7vbolbNaK2AU
         1MRBOnvk2KyXwEykpIoUNTvpUcVxxk8M/wh79R9T079/v8XrMPhJzXoLD4Q+Xg+d5yok
         nMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740821104; x=1741425904;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5L/pucqd7w1XEPp1X1sTPz+Fsqhsm/pl7T20lV9Gm8=;
        b=l41C5bhF2aTmZzLqP1mXPnoLZ1eBlRDZcAOrZrqHaFJQSCWneQepWChkuLoSpLpaJj
         Tef/3VosIgkX187mh/EBkUq5db8NH/N4VuDWnsJhyqlfv81RJr3tKKGMdQK7Pr7es0fS
         E8LYZf48l+Ur4uoN2UMBr8zVUisji7vboJEuTJF+w1oG6NpYKz1Xx1+1VhvHw7n0efDU
         FckLQAX9SycOFy611NaPWvFeH3G4HxybOOVyz/vlRzx0wBXZGmD/qI3AeikeYZg6eha8
         rBKvSGuv+u68JRGkbbWv0VtWMmHdjwYNgkG+faiNU8C29bAI1kTDp9XaKKt5F2C/gowL
         tWoA==
X-Forwarded-Encrypted: i=1; AJvYcCVz9Mnc+14dnMnrGpQJ3tw++a6xqD2c/5bIXUsixF2OwcIwBpHOD3hPJaO3Tfqc31fFWHMFm8YxGjCLA2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmcEonWC0eTUrCXx7FRr59s3yGZIIitP0d8OCIH6lIPVH0csqo
	C6QOFuNnUG3JrqraQMFZi8k1XNCOcZWeK7Vo/YsR2u17g6sal9LfMYLinRMIu3M=
X-Gm-Gg: ASbGncss6YuY6h5NL6AVlq6TyAyJGRzpcdN2TonV1ZVUw3ZuqF4P1D+I8puZc4fAGwU
	TWqBtg0ddk2HkABC6TuFvXcZAWtYwg1C7H3rE9Uq5Y63kVNIxoe8q/cNJnmI800U0qAfLiObBNK
	RMarZH6GUX1ZrnWZ/tS/Fq9v0/aJHhCTawkDzqKwQmfT2ecRvd/nh3dwSCadtgDXim9BBuDU3Ff
	pAILcoAcxOWS7ggtCEqTdCyeO4LjJUo0Mo/Jt0V6Nni8irnUDvNacwZovCA0yBpejgeqjQTrW2a
	WjhKoAZDWQQ5RclhLaInS8PUtXCFXOmMcMHyVyPLAGGYfsWXrYd9
X-Google-Smtp-Source: AGHT+IF6bPkXh6K3Q11IgVbCAEx/raWQukTULWZwW0cWZdP4xoy62YD1VO5brez04BzTxzWt6zMIbA==
X-Received: by 2002:a2e:9d16:0:b0:308:eb58:6591 with SMTP id 38308e7fff4ca-30b93310978mr18756901fa.25.1740821104442;
        Sat, 01 Mar 2025 01:25:04 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5494417432csm738406e87.52.2025.03.01.01.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 01:25:03 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 01 Mar 2025 11:24:55 +0200
Subject: [PATCH v2 2/5] drm/msm/dpu: remove DSC feature bit for PINGPONG on
 MSM8917
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250301-dpu-fix-catalog-v2-2-498271be8b50@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1305;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=MfIfb1GLue9MerIIR2rhWjY6rmZBoFPVe5vbiAysvVc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnwtJobSugy0kB0JIsHODpjBT4yZPMEcMtlazNt
 TTJpig19bCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ8LSaAAKCRCLPIo+Aiko
 1VQ0B/9QjGsUEpb+DwWLNz/fIYKFPwXC7E2uGmZ4Yredir90cNDR1OI3lNMPAxYFaM6qoQOcRjk
 WHdMYESn1aXu0fSNpX0hxt3d7J29pPQL7AsmolGiYRLsx7b4ioytiHfzQPqpveYeIp3UHcjrfSo
 fghL+fxJZ755HA3xa/g4tia4Djz6aKIp5opjOkNZXxi9oy3y6DUDoimd4GFk071lq3uxox9vmqI
 XDqnMFtuQ0Igx3CHoEOCW5cJLpu+sDu+Xa0gy+pMis6++f/Vz+F5GFANsvu7KxEDzTe0A8pLOm9
 AkvmZBtxY/piGB36iX2mR/pJTxjinj661+YqhnTvu+St/Kv1
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The MSM8917 platform doesn't have DSC blocks nor does have it DSC
registers in the PINGPONG block. Drop the DPU_PINGPONG_DSC feature bit
from the PINGPONG's feature mask and, as it is the only remaining bit,
drop the .features assignment completely.

Fixes: 62af6e1cb596 ("drm/msm/dpu: Add support for MSM8917")
Reported-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_15_msm8917.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_15_msm8917.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_15_msm8917.h
index 6bdaecca676144f9162ab1839d99f3e2e3386dc7..6f2c40b303e2b017fc3f913563a1a251779a9124 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_15_msm8917.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_15_msm8917.h
@@ -93,7 +93,6 @@ static const struct dpu_pingpong_cfg msm8917_pp[] = {
 	{
 		.name = "pingpong_0", .id = PINGPONG_0,
 		.base = 0x70000, .len = 0xd4,
-		.features = PINGPONG_MSM8996_MASK,
 		.sblk = &msm8996_pp_sblk,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
 		.intr_rdptr = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 12),

-- 
2.39.5


