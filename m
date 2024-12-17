Return-Path: <linux-kernel+bounces-449179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2FE9F4B0A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49F4A188C1F2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E93A1F130E;
	Tue, 17 Dec 2024 12:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KT0HcRjg"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55D61D90AD
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 12:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734438947; cv=none; b=FWavqcFzow4ZX4nw8xykkZKNfdJhfLd7ZBDp8FCQKFLMRqDXuhsKJdVxDnxiCC6hjIgQF8jy39v8gJc8XUhkhZ5tVtug5qNK06sHS6Jkz8nsICuhwV8nSq1W0IPK0Ul/uHfIYFmmR4hfgZlalmOxal12hhtTx9nN4xVO/HeyTHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734438947; c=relaxed/simple;
	bh=P72G89o/YCMWCzZLIM5D+qksevbQkKdaRlhBYiPrFaw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EWgcHLFqIXEFwbHgDpVQySIJAaJDqjh0HMUTtlqPPAl4SdYXls5M9/238skoYbVPEgpdFQt4P3Mcxzcf2+zVeOzpppaOPer/i+PrrjxccqaGr0PDBF7Yoa9CRstwTOZKx2zS+i7k7GOo+ZPAkPXewwllV1070D6eC6HWdPUWD5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KT0HcRjg; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5401c52000dso5654296e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 04:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734438944; x=1735043744; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EqFVcsq/1P38IrP8o1pPFwny5Xr5j1nP95SEUyFOxg4=;
        b=KT0HcRjg0/lRZnqfdPDXJywYbz644SaV6pZeTj+rlc6sAEihGi3YxQb1Vt4xR6A6Bn
         07tAbUvYY6VDvryIzhJJZiFFEKYWg0JuKx3eGTu3+NjAkQLKlQ4CwfrqoRqctnTD3HMe
         brO2Abl5/jzCE89DiFuuZe1h2xd7ERatpD42tqypGUO+gi88xhbNX9y+v07sJtk5iCmF
         2Ql1QlNEv3IGIjKCwDrIPPH9yiKtoI8rkPk3D+iEHkqOIi8MCQ725UVW8wHog9OPUOmd
         bJnQLXz7TnGQ+hsd4Fu7f4emsgpkjXS9rqgxUEN6D4ruIkVu1gQAnUj3JG74A0MuaERQ
         xI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734438944; x=1735043744;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EqFVcsq/1P38IrP8o1pPFwny5Xr5j1nP95SEUyFOxg4=;
        b=Dd3jUqWZR0q3d8+4up0GLKSZlwDhWYEUgdOB0ytVHa9mbQ74vGLWlbLn769uKGcIdp
         rKpoAfmLopMpe5TwK9lfTsgrgHfzoviUzVghgx9olxo5IKDJgPzqJHe2tosc4Mjrm9sL
         OZbeTBWNlr07I1FxHhsLVxnwSrETzATxAUac6Xx3zA/9RBavxOtnbDx3gKjQNlgT18i+
         Gy+suIxFeVYhiiqgjMfzjNr/uf6KPRySZPKMKzPnomB7DjfuCf+HfgFrANipNPI1axhc
         oIPSUU9uvNhXGLXy5KcBohJD9g9cPoT0g+x1W0GaXBsZUb0gnSsTxSPy5qqw0LQv/M1e
         gvwg==
X-Forwarded-Encrypted: i=1; AJvYcCUkKsDaYIoFn68mSwqfScMhbcRQD/slAVn6AX6PN1/DIG+UOg9he/OL4VvZLRll8M7nJutp6NIVwFnZmzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8G8dr0JFMcT88W0GmSSk9e3PIjqMYAJhBbB9LaeTDK1Lymbzy
	ZUDEet3zrxsq4aRAW01S8BkzVUIz3upvmAS5xKTiFWRgIBKiugCNFQ8Y3AgksYQ=
X-Gm-Gg: ASbGncuoHoBqtTeFw07R9w+3iQefqbz+VpQLekYlJ0mL0tjrkAqKjLv4TEFd6wDwRu6
	xVDS4vYNfmseF4u134ryUMrhuL5UfmzueH6H7GcYbh5ZTt9VWxNxyeVAVTcYfJMvopAyVH792UK
	5GhoSDMI0Vot29XDayR/RO1gZ2t3KyHV3Vb9X1NFBrWM/oy/KO1LNqJC0p4KzsvZwmhfqiK7uqY
	+DJ1rJkiATouY1GbGYGezVUWQUHlPE9XsAAVqEie/aKXGK12VnLUmbHnO1cX+0s
X-Google-Smtp-Source: AGHT+IGwO6ExXNEcA0R2FoxKWS83ev2naGxk2+ZyD+jgIUG5jEqO7Ox1e2tGWV3q6r+L5CxjhdwD1g==
X-Received: by 2002:a05:6512:158e:b0:540:3566:5397 with SMTP id 2adb3069b0e04-5409054f33fmr4655941e87.22.1734438943729;
        Tue, 17 Dec 2024 04:35:43 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120c164b1sm1137065e87.223.2024.12.17.04.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 04:35:42 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 17 Dec 2024 14:35:40 +0200
Subject: [PATCH v2] drm/msm/dpu: correct LM pairing for SM6150
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-dpu-fix-sm6150-v2-1-9acc8f5addf3@linaro.org>
X-B4-Tracking: v=1; b=H4sIABtwYWcC/3WMQQ6CMBBFr0Jm7ZhO1VZceQ/DgtAZmEQpaZVoC
 He3snf5/s97C2ROyhku1QKJZ80axwJ2V0E3tGPPqKEwWGOPZMlhmF4o+sb8cHQySF6MP9RyFjZ
 QpClxebfgrSk8aH7G9Nn6M/3Wv6mZkLCW4Du2Is64613HNsV9TD0067p+AYimqTetAAAA
X-Change-ID: 20241216-dpu-fix-sm6150-17f0739f8fe0
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Li Liu <quic_lliu6@quicinc.com>, Fange Zhang <quic_fangez@quicinc.com>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1582;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=P72G89o/YCMWCzZLIM5D+qksevbQkKdaRlhBYiPrFaw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnYXAdGjNdaXabT0YqQhED4A+ccplPzuyiib3mB
 0PMvSkpahGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ2FwHQAKCRCLPIo+Aiko
 1ePjCACAduQzUrmv2UvoKsCLEFcnmXD4PjXKpskER7W/cYTmm1XdZPXFmTk5RY0EqzMl5GaIMEW
 VRMx14YUs0iTTFUk9ihEWyZ+bg2+N9wownr+WOw57pwuHLR0/0BWQJ/9rK5oDGsIn0Vvj6ZnpGn
 X+ufNaMY5tVD6tGqy7oX5g7wD3VOQ6Z28aIYIW6bNu3dtC1VCIEs5mmqBsx2TJ2kfF/XHekHG94
 /CzLIy973QNfb2sk7/f4rwsq5LuyOOmMuTBrzu5L4VoPRVYj1CJcwCxjlyHBASAZviWPlTPBkQP
 b+cqywM+uIjO4zlF1MYJMPvdy47FqhyjBc7UFU7g0/8qTOaF
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The SM6150 platform doesn't have 3DMux (MERGE_3D) block, so it can not
split the screen between two LMs. Drop lm_pair fields as they don't make
sense for this platform.

Suggested-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Fixes: cb2f9144693b ("drm/msm/dpu: Add SM6150 support")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v2:
- Dropped lm_pair field as recommended by Abhinav.
- Link to v1: https://lore.kernel.org/r/20241216-dpu-fix-sm6150-v1-1-9fd7ce2ff606@linaro.org
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_3_sm6150.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_3_sm6150.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_3_sm6150.h
index 621a2140f675fa28b3a7fcd8573e59b306cd6832..d761ed705bac30d9ffef3c0c9140e5e8a5e930ad 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_3_sm6150.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_3_sm6150.h
@@ -116,14 +116,12 @@ static const struct dpu_lm_cfg sm6150_lm[] = {
 		.sblk = &sdm845_lm_sblk,
 		.pingpong = PINGPONG_0,
 		.dspp = DSPP_0,
-		.lm_pair = LM_1,
 	}, {
 		.name = "lm_1", .id = LM_1,
 		.base = 0x45000, .len = 0x320,
 		.features = MIXER_QCM2290_MASK,
 		.sblk = &sdm845_lm_sblk,
 		.pingpong = PINGPONG_1,
-		.lm_pair = LM_0,
 	}, {
 		.name = "lm_2", .id = LM_2,
 		.base = 0x46000, .len = 0x320,

---
base-commit: a3d570eace66b4016f2692a6f1045742ee70c6b1
change-id: 20241216-dpu-fix-sm6150-17f0739f8fe0

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


