Return-Path: <linux-kernel+bounces-537656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DD7A48EC6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93F027A7F22
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 02:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617C418C011;
	Fri, 28 Feb 2025 02:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kk5uozrD"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E8E16ABC6
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740710451; cv=none; b=I0+4RQ2QydTbELy1Plca7oFRYzFgFGtkD/GJdoaO03ps4VV4shADC1gG/mkF9e5GYHmRvTVNg/qk3XyNpCj9lIgE1X+nouh52xXND9gia78Y2KTjkFMWffYXE2CRXHSdeR12r6rv++cXuMa6ZhaaOl0zPOjzU/nN30KMlXGVRdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740710451; c=relaxed/simple;
	bh=AHlIDMaamS4Q911Ji55qeGiDjSSjpx7O5PqZx+FIb8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ukmqsiPGzvhJab1wrackKINpJYIAfQbnA1c12pTpIXZAByNuw0PVlE6OLRWpGkCcbYd1evh1RbI4gQ6HHrPBVe4e49nJSzpAqt91DkJbKOJJ7LkxIVV1CzgoQtPJcGx43SbV4+OnyADmsLRLP5dplLBVqsiS8cddyriOlGJ9xOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kk5uozrD; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30a29f4bd43so16390601fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740710448; x=1741315248; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vOGs6Fa6zuHrhwyPIl+nFTAKnbOoAu0XxgAk7bsGnFo=;
        b=Kk5uozrDnNCrzJh8Jiw16Lp3b9vl6rWv2PQ+0ZYkg9jU8SMRElVWyfrYzJgVMsxXnP
         UbfQ4g50ixzCZctCnsD0xOLsNL6Mu6zIXHoHgzYvlGvzuDclacsKx424EikaQUQ8stH0
         5ctRpSXhfrC3JgOA5oVt0kX7PsaF2cvs4kNQhMt2pecHfcuPPKfMSBC4zflZ7UH9odp3
         1BHf/Qqy16PTq98ioX/ahHENQVmLtUS6C1JVenksY4NjJBErJRy7CdBc9HNkIBz8qyWG
         /l3Rb+2hPgiLSz2b4Db+8gXT4guY4+uJ0qju/7v12/lyw5nVRlSzNcHrWfOyg6wWuxWf
         vr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740710448; x=1741315248;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vOGs6Fa6zuHrhwyPIl+nFTAKnbOoAu0XxgAk7bsGnFo=;
        b=a7G5BL3Wa1QkgEtqRsHf3DLJQDqlFvGlkvloU+oJ7YJolPBrfQC2Pps6d9tgi3ZTtw
         TlA7jfX57V7RO0f5SZjw/JlVHjCRcsQ4J04NBWBoMqCNamgra92gfJ7RP4fJx+EvEDza
         NU3AsWoFBvOw0cpekp8XVBvLR6cJ5xhrtU/9EbmqbV7ZxkWznqFiHBnvGzSWpjbDnj4r
         E+KMQF4NLSgDoxkaANE24ZdeG2Y9x+XKbt2wfzifKq3bUt9+4dTnlD77wbgC1PtIgewW
         DObJgMgUbl0BRDCIFK6x+Xwo50Rc/y8WJyABfIuBhYyzkCVZiO0qu8Vj972+R8VfU/YO
         AsOg==
X-Forwarded-Encrypted: i=1; AJvYcCU8xP6/B6p/ic4XUCwTAcTtzONRl4u7UQsSN6koe8K64+S8MVRQOrhUyQrDA0AQlNeVUy0QOvyQFkJqXgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpYTR3g4rjqUZaYoyij54L3JjzrdvBL7d9GKj/wy6CVSJuRVMr
	eAbS8dsvy4DFskrkkefb4POVLPjGqi3NOCN+mVHzBgOwC5Hjb6f9xYvz9B/6DVhFu8bb3KTQXJZ
	IIkI=
X-Gm-Gg: ASbGncuBSRBIOIb4an1+700bQfUoUfQQXT68QGu5Eui5FrI2otKG4W5yWoEy/Qge1Yh
	HZyrxg92jwEPmrezq1QSbnkyazS2zksuLZHtUV1b38bSY/7aCaS79ThJHzCqyqPTdxXFKpcH6Wj
	YDhP5UMpmvwAtfGzK2h8MpP27rYRo72RjIfSpfq/GWiohILzZZI+AoeHnHTloP9lAzBtNpxqKuv
	yzUaImj65K0QulnhU3/0xEbnztLL4hCFpoFSuaTGtl1d1gJ+2z0P0jhY3fQBE3ElDGXG9MndC4/
	6q4j2sgj3MqFbaOm2VuUIFWe3wKdcN+lsA==
X-Google-Smtp-Source: AGHT+IEB4jROCc8fnBy3MSZrW9RzrxCaLFObuJxsi615v2WW4DWyQ2y9erjQd2zzlfZt4HWqNT73Xw==
X-Received: by 2002:a05:651c:e07:b0:30b:9813:afe1 with SMTP id 38308e7fff4ca-30b9813b4eemr801181fa.25.1740710447809;
        Thu, 27 Feb 2025 18:40:47 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30b867a7403sm3493881fa.17.2025.02.27.18.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 18:40:46 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 28 Feb 2025 04:40:39 +0200
Subject: [PATCH 2/4] drm/msm/dpu: remove DSC feature bit for PINGPONG on
 MSM8917
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-dpu-fix-catalog-v1-2-b05d22fbc2b4@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1244;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=AHlIDMaamS4Q911Ji55qeGiDjSSjpx7O5PqZx+FIb8k=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnwSIo7NuSbAFeNFO1NY+RizSOKgHJrrMgQz/BM
 XWFEbzrn0CJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ8EiKAAKCRCLPIo+Aiko
 1Q9yB/9Isl5/jVjtfyVK1130CUffh72E0EfipCMgeU8T2V/cUd/oht19i47Bklr9nLRGpZgr0QF
 nhI5oaX2BJowBZ7XVBBL46P6bSfq7TwhGC0DrGEvNK3B9LHLnQOAdgv7wYlUqjVhqK29uQEwE5/
 JJi/sefWmvVpPkWxytK+0EhNUbmF5UyfG0ADicerAHsoIy1s5QIBWruB3KdrnqsC5r/qU2j6R4m
 OdJs/X0VWXZRxsHn7psLQ9Q+H4INkAUvLxYhtHMHRQt0uwlxtkDVFzs2iBcWmIv6w9LROVF+Jq8
 C/JtiYINhX+7199v3tqxSZaCU1G2USuXFqjGQffzH+WkMPGY
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The MSM8937 platform doesn't have DSC blocks nor does have it DSC
registers in the PINGPONG block. Drop the DPU_PINGPONG_DSC feature bit
from the PINGPONG's feature mask and, as it is the only remaining bit,
drop the .features assignment completely.

Fixes: 62af6e1cb596 ("drm/msm/dpu: Add support for MSM8917")
Reported-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
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


