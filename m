Return-Path: <linux-kernel+bounces-245950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C3792BBC8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 753071F218A2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F07518413F;
	Tue,  9 Jul 2024 13:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kSAQ4u4I"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B3B17F38E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 13:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720532914; cv=none; b=DofxhK0PuCwdogCaWTqawpLWLypAux+xnbe8xevzll3h/GA2zkftgBuvQsmd4+fOdFAdb1wNEqC54PMdpmkZ+a8iRds5AnJ4LdUIirp2FrT69lREIgbvRvsvqoZbVHV4h6DOlzzAz5gGZt5uEdZJmjHKL034Eh0+OfpZwB31mb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720532914; c=relaxed/simple;
	bh=bL6t+kZFucDajd7H3MVoLbxP4QMw5AdDFCkBISCWBK4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hw2seAZkLbETx+83jcCYSwMzlbUwEl8rnpYNgI1C1zJSG3Rht2TtzpaNOwWjto5jWCHrNi0cSDSWcCTLEDIp6knp4dwT+Xls9dqGIIcYUg4q9ogGXwmgWnVw7n1cHS02/4+thek9+f6j58UIURFcgoT+TeRF/tDfxBBlF+t0NLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kSAQ4u4I; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52e9b9fb3dcso6181048e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 06:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720532907; x=1721137707; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KhHYU7UmK4dnD7/sjmuMOOwDgcdEgKtZKNrTen8zuww=;
        b=kSAQ4u4I1hdFNSV2+rDfN1CbuZVj+kBI4C2mPJajE2RDvnUVScSTSkws//dQN147q+
         BLKTpJCd1MBIeQtaT0G2IK8LPnWknAGhdHcWKJEhq669p0XiF++t3zQZrS4Ijr73+hYf
         Zp45v5Vn+NSyR9p/ww3Qp/uPCkq9368qlpky9AH1VyDNC+GFuahSyiRjZE0LIGLCDM75
         DsuxxCl1TAiu10AU51nGR0s4d2l642I6f3S85IlQW+S3Ipctkp7YsSnc5/Aypjz1pd7u
         cJBoZ1vvOQ77tzfjPoElojVmLDLRnH8/lSa5+ad8kUosE15uWEdKrab+OX7zK9QNIX3e
         /pPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720532907; x=1721137707;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KhHYU7UmK4dnD7/sjmuMOOwDgcdEgKtZKNrTen8zuww=;
        b=byQb1dRpJL/E8dCgg5Ao1h0pdiNvBOa8/hDCUYRfMOgLIiV+hHRd1sCo/svB5Tx33W
         RagCTCu/LGRZVfIKHA9d8WvXsdRDTjDvYaByk7goIzniRc9VzbQdbN4Q9pdHl99dZbGu
         ZFxZepXwztqxCRoQt9HUnMle4LPozlk4wiaAvm5fpKHeCtsJEs36MKygxQ8hF2s1lDbE
         Em5hqChDPiUS2UOs1VhlvdXSBlvfus7BT7HKlEMJ83adKT8vmR6Egsgl6H9dCnhdohLJ
         NNfRehsLDb+yO1Sd2uYGx7QtiW+v0TaNNTsQGmeiQK6F899/h/Vye6pyWbXQzZcJxHg9
         gp4A==
X-Forwarded-Encrypted: i=1; AJvYcCX4zg/k1oQtzUFGtoOQZn9Os1quF+XK/4JPJo0Cjq9zeQq7a4aLDHKEiRQI26dFkgNd2Yrbtpnbni/cAw+GljNumU10EKB8+AcrPuOe
X-Gm-Message-State: AOJu0YwlYn8jdmLlDydYwv6NbnZkIfQaQFkCRhQCkX7Nyi06nqaWENed
	PvnOXllbHu1EsJWLxIZI+3AXQQM1NyFPjKceCiGO76nhmwx+/hxYS5RraJR0Ywo=
X-Google-Smtp-Source: AGHT+IH+4DaePyXmIoNWLgjS79EsnJAzPqo0nKjSdovFNAcILKuskj9yBxxbOKOqicxdvrhvMII+KQ==
X-Received: by 2002:a05:6512:2349:b0:52e:6d71:e8f1 with SMTP id 2adb3069b0e04-52eb99d20f1mr1872812e87.53.1720532905946;
        Tue, 09 Jul 2024 06:48:25 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52eb8e4959csm250297e87.82.2024.07.09.06.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 06:48:25 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 0/2] drm/msm/dpu: two fixes targeting 6.11
Date: Tue, 09 Jul 2024 16:48:21 +0300
Message-Id: <20240709-dpu-fix-wb-v1-0-448348bfd4cb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKU/jWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcwNL3ZSCUt20zArd8iRds+QUU/NU49QkQwsjJaCGgqJUoAzYsOjY2lo
 A++nUC1wAAAA=
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Jordan Crouse <jordan@cosmicpenguin.net>, 
 Chandan Uddaraju <chandanu@codeaurora.org>, 
 Rajesh Yadav <ryadav@codeaurora.org>, 
 Sravanthi Kollukuduru <skolluku@codeaurora.org>, 
 Archit Taneja <architt@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jeykumar Sankaran <jsanka@codeaurora.org>, stable@vger.kernel.org, 
 Leonard Lausen <leonard@lausen.nl>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=853;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=bL6t+kZFucDajd7H3MVoLbxP4QMw5AdDFCkBISCWBK4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmjT+o18HQEGU/sh2XXVi9PeuAXwCOvz/3KnFsm
 9WZwmhMseaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZo0/qAAKCRCLPIo+Aiko
 1ZpGCACE6gn9tmgMaVRmpBa4xTQljPegAbZFYn+ABYfIs31WEBWo/P9UqeL5ARG15SGCRyVcseT
 RxgOeDmBPXxGP9LOov67wJGBAUEvKJB0Pq8IOyegyKoLn4b+7H4TWdlpa2UOGSphHy1ZvoyX712
 MmV3f8r3HcL+p2HV6ZPJGfJW34MCMF7qVCDf3kcpWqSTPJZKW+kImOdbV90u7JaoKFX39eg8BbV
 G2rDiW3BCyta8sfiSHe4kMlk3AGfOPvh+L598PeQlQ0SJ9FkULJin5ywg8bPqpEr3REZg0Fs7PB
 Mz3sfn2D35c0aZgurVDkT2dQCqH2DaxaplNesO9HYYjA8y5t
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Leonard Lausen reported an issue with suspend/resume of the sc7180
devices. Fix the WB atomic check, which caused the issue. Also make sure
that DPU debugging logs are always directed to the drm_debug / DRIVER so
that usual drm.debug masks work in an expected way.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (2):
      drm/msm/dpu1: don't choke on disabling the writeback connector
      drm/msm/dpu: don't play tricks with debug macros

 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h       | 14 ++------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c | 14 +++++++-------
 2 files changed, 9 insertions(+), 19 deletions(-)
---
base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
change-id: 20240709-dpu-fix-wb-6cd57e3eb182

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


