Return-Path: <linux-kernel+bounces-391363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3E09B85A1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B70541C21ABB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88001E570F;
	Thu, 31 Oct 2024 21:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vpyZ2df0"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CD71CEE91
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 21:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730411067; cv=none; b=Bq1rwZRb6rid3VoOUCmkYCAQWVYPzKajZGmxvR2VTsvhwzClR/VbVv4UvKmTUUt/l7XT8wKvoU3c/nrZMfUL+2OQv8KBeNZ1ry3KZ1pq1azHVZLzWDqpgprYBkntk2RHUmqTDm3PSVuYTkR2AsedDmLko3C0/l3IXrabVvTiwe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730411067; c=relaxed/simple;
	bh=kwRkgGoOjzZgmKn1Q7SGF0bYYDkMueTmYikFdU7ocIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HtRw36/zLFqxAbVOXjhYJOpap2L2YlG6KwMa2HHvpGUfaDaDt6wTT85K0OxNPApEL+N4rI8DIUIj59CUvRTiXXbm/i4G+BZAmPfGiYbBdXoh91VGi+uGsE++UF5f5MF06V4az22/EV8jXEB4NPxFv+L7Q4SVMiwGTfEwyr865N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vpyZ2df0; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539f2b95775so1557904e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 14:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730411060; x=1731015860; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jw811QvSxkKlTSi13fRKJUYPt91Pu2RmLTiZSYENA0A=;
        b=vpyZ2df0k9sKY5/hWxmK3VPowrV7r3kWo+xbB3ekoSXEqjGEFnsF7aGJWDF2qK9Tea
         CJjNyr5RwS/Qta+IY4BzQCRvTsD2IsUpK/J2l8YkuqcVW2wlYk6f2rXJilULbIBnQSh+
         89IgfkpiF0T2bplH3OmCYLe5prYQYAHCsv+Yd7EjgDpORK/bjSC93U0uvXgzm1BLqPdC
         hNFTjUMApR43YriTZUnoS3lHChLxfMUJA5mOsm7gCvcjd6fttkoTCpMsW22CMZ72qBIg
         lQ7Oi/RAMmioKFPCQc+Q/Iqbr0fCMMHksvdfTpQ2y7aKumhnoDhEppG+jgh9eiJ+efiP
         rM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730411060; x=1731015860;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jw811QvSxkKlTSi13fRKJUYPt91Pu2RmLTiZSYENA0A=;
        b=i454Wc/sx+Xr7uCP4Musy1BGKaj4/TpSdgqLshsW72I/3KH/IwWbnV89Y9Uvs/WSfw
         GYAVd8pBtLXxdvpiSYbrp+I0imtskhGeTUrSZjw/0VK8DTmiLNRadJabCRRfQur16BsO
         NaKL1Th3H3hmr10ZIjIfsoW+1wDnQCp5IUihiaM0Vifk2qXqEEBKq11gilMQ2QYnQJ3C
         snqoo8vK9qhZAXLI3sZG4+Rsj2RwyeMQ8FhKW5xjvpwCg28To91kDsS+CvhLvdVJ8qUW
         dwMQduj3si3wti/+5zeO78KtW+K15s8RKt/HLoc2/dFSPpTlpnQkTp+Q6ThTFyrXbdZg
         OhtA==
X-Forwarded-Encrypted: i=1; AJvYcCX65asMewFyDKPxkTBZ0+F1XT638bI38Ryz0YRQSi1x4FN8q5rviXcn/PpCvRAyJ8t83Pa9hx/L7qheBZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdWNL+aYC0joLX2B4J7LBjTqVRaZt8kZ6E/q+xanrirAzqkVxl
	ClmlaGWLPzqo+RWbjq1G5CeBmhvDdUKY3QKAV7Ca4wm4qQVQQRRbVnPqc4DOHwE=
X-Google-Smtp-Source: AGHT+IHHauso5gw92N1K625tiIBh5li6TkbAZXQxxn6Vk07CDy0EXyPPBPtOf/csQkc5zctsYe1C1g==
X-Received: by 2002:a05:6512:3f09:b0:539:901c:e2e with SMTP id 2adb3069b0e04-53d65e1634fmr1394608e87.58.1730411059664;
        Thu, 31 Oct 2024 14:44:19 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bc9c162sm339567e87.96.2024.10.31.14.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 14:44:18 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 31 Oct 2024 23:44:08 +0200
Subject: [PATCH 3/3] drm/msm: drop MAX_BRIDGES define
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-dpu-move-topology-v1-3-8ffa8122d3b6@linaro.org>
References: <20241031-dpu-move-topology-v1-0-8ffa8122d3b6@linaro.org>
In-Reply-To: <20241031-dpu-move-topology-v1-0-8ffa8122d3b6@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=664;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=kwRkgGoOjzZgmKn1Q7SGF0bYYDkMueTmYikFdU7ocIQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnI/opEO4nZnJKudYd5VJNkM81POL5z8Lk8UCtt
 VL/KX7M452JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZyP6KQAKCRCLPIo+Aiko
 1cprB/sEXHm98G7GhObz4/5yVDFNvTe00LSqFqAxgVssZBeqVE1wpljTMyaLDeW8j1/MuMs5aeI
 qv1qfeR8geOzJDZUsileUt7Hk2uWaLTpYcVAJqY4FCcctOq1LntrRX334wYzenxOFEdrnrGxUMu
 +Ku9Vmho3rB2mxEeBrI/frE5DtUsoC1sYRFlEAtgWjJ4qdE36JcUm7tr4vugAknz94xD4lNbouz
 o8kNdVF0pudl7ZZgrso5LFZSc1AqClTnXcMHceeb0mqMC3g2dKkxkBkfgLUJiHyNlMfh+CPIB/e
 LOfxjc++UkGDLVp0nVea20hvKveOQ4jOjQoue27okFvu/iLh
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The const MAX_BRIDGES is unused after the commit 4d1a1e4686bd ("drm/msm:
remove msm_drm_private::bridges field"), drop it now.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/msm_drv.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 1dc161d9bf51..d8c9a1b19263 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -52,7 +52,6 @@ struct msm_gem_vma;
 struct msm_disp_state;
 
 #define MAX_CRTCS      8
-#define MAX_BRIDGES    8
 
 #define FRAC_16_16(mult, div)    (((mult) << 16) / (div))
 

-- 
2.39.5


