Return-Path: <linux-kernel+bounces-447001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 994469F2BDF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5661162975
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EB6202C23;
	Mon, 16 Dec 2024 08:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rAQdI8rd"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5C920125F
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734337666; cv=none; b=F2VjQRp9SxTnJygzG79G9+nj5/JSyiWfUYULb1nLK3QuMyO54i4uRaDuVwpcVRdnLgdg2xFYO6y26WSZBMbCZn3bZYUCFToa6IMePt3YBnX6PcriDL6TPAAlIN0umI9J8LTG7S/JpZon/KhQNNm115P7MW6H5H9DxrMelyDz1vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734337666; c=relaxed/simple;
	bh=0d6Vl9uKHPMWNXj1THwSQ8KfCjRZZOIXlKFBufG6ric=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T+wmBJkUtJ+MRCG+ha60bSScKtn5x8jSvPcbxHycALy8cVKOERMZuOukWpI3JPPWzX/4fZye5pGysfyCWzsjG6ed9QD03IeW7l2jXBD7Q1CsYWaEy08Qnkj7WTc1kZOO94s9JVuIPtkpkiHFG3iTMBuatmu8RDxhTfiRBKNtpBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rAQdI8rd; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3003c82c95cso31943561fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 00:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734337663; x=1734942463; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w6iaR4XhdKUYvlNFXFyoX/pNn4cHsyDnjyLqjwDAVN4=;
        b=rAQdI8rduPVNRA0cjgdrZFOfqPhjypFg6KTdTC9zHU2cAIHJUROC5FlrsXeBr/5aCp
         QaWbggsCIpkuRqwREmFcVccTxVtZdwqSQkL2KG7Ens8mfmU8dCg21fSiY56MfSqUXGtt
         qhotPPlja41bYFodhQ8U8sPZjk1ZlqqrEpt2hAej48x7HBzUSDlNXEq0JsPJ2Cv648IA
         gqYI2rfbWSvohxcGkMde3473iqI/iGzebxrLW6r9/ntlAgBdFfzCQVZf2UiM7KycfyyZ
         YIsZstJzV5QXtHEviNthWOmVUod+tiE1pYHStpyXt+S4O7F9sgZTzXYO6CS6YVL4dCFw
         Oi7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734337663; x=1734942463;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6iaR4XhdKUYvlNFXFyoX/pNn4cHsyDnjyLqjwDAVN4=;
        b=PwBh2Mgwwp0elk/TDVde356+D7Th0nnYVMRJi3OqgOZodo2YSv+Qv/8ylaEfdoKIsR
         guxn6kllnBVfTwKHCBlwp+lMEvzzDM+Ra+A9x74rZWSAUYcgZU08u00REx9Ok8iys2Ai
         LRJdR5fudQMczZ4FU1NUAX2sDgXrgzMQ2Ct04qXjRYUBh0lZVJ/7qK5NriXS23bHSqlT
         EHZ+49SB3HN0DbsNFinPnZ1LCXY/hs/A7x/6ffwoBzMTApKsJUT9xPmCSjNPsROH5Lgb
         86NVWtHzLrZUApirorG1biSMBtT0TKuZB9uKW41jgQ/AA45QGkP1rflHsb4gXLdAgOfI
         K57Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHr0iENVMzdvEMkaQ37dNN/nIeOHuH7V2MM04vytAH4F82CsKUjUDatVu4mYC+FmvjMBnngpiQlcfuxjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYboXQwj791AZiDeoedq2OctUu11YiByMR8W0sOznfrpnLg9vn
	e0MJC2j5MgM1kDo661gQMC2mJvR+RSh49a2/jZBNkVz81HJ1l+wI6j66votYFXI=
X-Gm-Gg: ASbGncvB+gkSnq/OhsKvdtSztyd6wlH0/zFplOyfuN53o2L1UCO5FxnJqoUt3rG76LQ
	Xz/SIVlapGVcgIYRPEeqVANvZt6D7TKhzksoOhuCkiOVCXOMuR/yLc6BIOjoX4Rz1DOSJs29mCT
	FsDmwimmChZjizpy/di7xZBbG4HZEutUt71yfP9sxiL+lTpRyFZqVSIT3LeJVwSA1h/vMTp93Eq
	JUPUfwazz2wVXH0SznUSOKlNiFPvafSJrdb1amAA6Iab915Wb6OMPn7txE++UfL
X-Google-Smtp-Source: AGHT+IEy+x7o2Lt7ybsRZe8ZBGCz8wMHfuQe/9Ykj81HF+ZPyzLz0xLLyDsY3vkjOuNJg6AH3N2zDg==
X-Received: by 2002:a2e:a9a8:0:b0:2ff:8e69:77ef with SMTP id 38308e7fff4ca-302544230e1mr42812991fa.1.1734337663008;
        Mon, 16 Dec 2024 00:27:43 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30344045342sm8543371fa.33.2024.12.16.00.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 00:27:41 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 16 Dec 2024 10:27:28 +0200
Subject: [PATCH 7/8] drm/msm/dpu: link DSPP_2/_3 blocks on X1E80100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-dpu-fix-catalog-v1-7-15bf0807dba1@linaro.org>
References: <20241216-dpu-fix-catalog-v1-0-15bf0807dba1@linaro.org>
In-Reply-To: <20241216-dpu-fix-catalog-v1-0-15bf0807dba1@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Robert Foss <rfoss@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Abel Vesa <abel.vesa@linaro.org>, Richard Acayan <mailingradian@gmail.com>
Cc: Rob Clark <robdclark@chromium.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=0d6Vl9uKHPMWNXj1THwSQ8KfCjRZZOIXlKFBufG6ric=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnX+RsCE00L5+s73vnKOb6ulTZZZO35mal3hBlU
 0p3uqpReEmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1/kbAAKCRCLPIo+Aiko
 1V5+B/9pAJg0ZCTSwEwVzazpw8iop9xUL9QAUMhs88Vnbw7eF+Ky0nqKgZQOPcnp9duJ2KZd6ui
 Gy5oSC8vg5ghOaf6MZeZO4c56G2GEH7P5mrLyc0NWGhX7oetzAUeTeGbmicgRLBMrzpynqDEGu/
 eDOJlyhNHdK94yeSjnwIEcve+5ZfFJZmaR/XywGLfDAoXizxGb5vLBwyfRnnnnfdk8qau3JNXUB
 HdcxyIvCCQg1HyU94uG0rGw5r/qUo+xYWM4BQzWu3xF1K6g4EKe0QTptys5QOkzJNzJ/MGSUzbR
 9+xDb3ElV4sLX0QpcniZNzoD55SwhZzlv5M4vizm1nlTCp09
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Link DSPP_2 to the LM_2 and DSPP_3 to the LM_3 mixer blocks.

Fixes: e3b1f369db5a ("drm/msm/dpu: Add X1E80100 support")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h
index d61895bb396fb4287e9b41807a3bb0cdb25d4e25..4f110be6b750d30e158d517aaa507c7b4eda0af4 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h
@@ -159,6 +159,7 @@ static const struct dpu_lm_cfg x1e80100_lm[] = {
 		.sblk = &sdm845_lm_sblk,
 		.lm_pair = LM_3,
 		.pingpong = PINGPONG_2,
+		.dspp = DSPP_2,
 	}, {
 		.name = "lm_3", .id = LM_3,
 		.base = 0x47000, .len = 0x320,
@@ -166,6 +167,7 @@ static const struct dpu_lm_cfg x1e80100_lm[] = {
 		.sblk = &sdm845_lm_sblk,
 		.lm_pair = LM_2,
 		.pingpong = PINGPONG_3,
+		.dspp = DSPP_3,
 	}, {
 		.name = "lm_4", .id = LM_4,
 		.base = 0x48000, .len = 0x320,

-- 
2.39.5


