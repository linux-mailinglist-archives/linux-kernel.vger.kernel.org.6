Return-Path: <linux-kernel+bounces-522933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F0AA3D03F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 207E93B82C6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 04:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB571E3DF2;
	Thu, 20 Feb 2025 03:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PzmL/MpS"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C811E3DE8
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 03:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740023983; cv=none; b=jI2+Pc8NmyN2UA+Rx0ulL9i0+L2BItANBQXCLAcUofcNdhNaFq/sIq43Fy5BpucZ8tMbQG7412Q+MNkg2J/mVYGruE79GxSUa7l1RY+7sws8tMgXeSeRtAf+dukWYN3fDs+2delLOcqZPRZIQdlY/DdDyHFEoZXJ9WRVXEq2LaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740023983; c=relaxed/simple;
	bh=Q0AAoFwflM5C/JzoUWd/DlT7FRIKp6S0uiQ3bl9uOHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HVmlrqTuxj4IVuflYGxnpvAP03NWxxdR2+0FDPvZYf6rqxDn3Tx4w8Pfgm3iTFhTKEg84lOIRuCQ5C7Sy0qkcfAfaoiLoV549wjojsUCB6QuAAMN3GtUkMGado1nV7oz247ghPAFNdpkiQi00X5u2r0bnWVcEuj0wI0vrwZZ1xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PzmL/MpS; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30a317e4c27so4275171fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 19:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740023979; x=1740628779; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9GONTdbG86yZro8yaESxJ4TpZYRnEloO1TeuZMx3gBM=;
        b=PzmL/MpSQKiEybsVotJ24UVN9eY5gHIXTpwPCW8w5CLptDKz1HkHB4zLK7BL5XcTdm
         1baIHyWZS1Ew6RAogMz0WkOif5+ASIJ26ftGgsOmYDDURQNZwLounOA7YxscnvsPAG2o
         yrFes0BGtOHoaWWsD8hgdusqoKNhRnBjaWrtxn4rJy9nyp9F/ZZ3MIhsqLy3qL0ed0Ca
         tD6DI7oimm2H4Vf9/aCZcN5y7ukdo9n8iZ3QWVdWFLjWasV+apTq15TocYI+zfYpnAOF
         FSLIYFBWKo/qfB9Ia3y7/yp/Xg8w/e2PL2nz1BoaSS0K9Ns77V+kJpsfTrReKypRbxuP
         08AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740023979; x=1740628779;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9GONTdbG86yZro8yaESxJ4TpZYRnEloO1TeuZMx3gBM=;
        b=Uq4sRKBEydH33DvjYRMqt+FHwNeLGgfoHD7extkMhWLZILKFsdxqireOMfIQDek0oc
         JfzkH3jyT2pv5wNhCEKwqo/gJsiZSs3puY3d3oKC36/2l7dKuC39hzlpSW+mAbPrZFA1
         7dwoDbZZl823W2DgnXhR+nMnHgTGWUmh7lFPYoja53Nxczuo64bWk6F3sx7NP1foqkE6
         qKKjHp/wZbPjJ9KRV0vkwQi1NPfb8nE96Hmoy7eByQfuHJbCCXRfAduOlQNbtdgfc5bk
         rZd4WbjmflvgddnqzipgpD26WblsjDtRWc/h8JhLLe8IAla0tD4HhTtBuyW3rolC+1dC
         KvSg==
X-Forwarded-Encrypted: i=1; AJvYcCU1hI11SMssDMPd/mAxMGg8qD0w+3dfZIPZRv6aTYNEzYaIEeip6W176KYsWHOsMi8ChJEtHeoqaNxUoUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlsMdIs9K6OnqGkbkJD49aquO4j8Qcwg5W5OljYFyQuRXNeK+Q
	wvppXF27Bzlab50hliDQdToYNeEifr1LyN0PDACT8ui7qQThX9g3e0CavmfEUWE=
X-Gm-Gg: ASbGncsfoncmP9hCM61jUbXTB3dHIfsv2LHMgG2rtrHeEDPiKesnhRl/+9mRIB65JLk
	6l085ErwxLj+kfiptdfCip4X63qA1FV6rCZWN6wWgTFbiQJ9FKO9FQmE59Y+j6LtKP9VX8CmBV2
	MWz/YJFwEoT0luEGYcDLXBgQ66cTo7XUyAQrlxtwxz5SJr276Bk5el2jWa8ek6U/v+oqp9j0T1M
	2ojcT7XS7qFC6GwsGHV3f3i1APfmICDaytnSLMP1+qGdes9ca6+lwmkV0SR2T+MPvcLyni+BAf7
	CLzgCMBW2h69uy9ymhyOPbY=
X-Google-Smtp-Source: AGHT+IEhhy/z8VtOIqW4qjL7UAytFR0EnzQu+f+Os3W5yJxEdSUFdt89d6o9y72QFALZRA2LauuJNw==
X-Received: by 2002:ac2:430b:0:b0:545:3032:91fd with SMTP id 2adb3069b0e04-54530329210mr6349493e87.16.1740023979295;
        Wed, 19 Feb 2025 19:59:39 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-545225f22ebsm2143909e87.16.2025.02.19.19.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 19:59:37 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 20 Feb 2025 05:59:26 +0200
Subject: [PATCH v2 5/5] drm/msm/dpu: enable CDM_0 for X Elite platform
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-dpu-add-cdm-v2-5-77f5f0df3d9a@linaro.org>
References: <20250220-dpu-add-cdm-v2-0-77f5f0df3d9a@linaro.org>
In-Reply-To: <20250220-dpu-add-cdm-v2-0-77f5f0df3d9a@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=974;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Q0AAoFwflM5C/JzoUWd/DlT7FRIKp6S0uiQ3bl9uOHU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBntqiduKMlpqumEmY5OPFLoCuQXyc2gb70SXzyJ
 mywbLuvK72JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ7aonQAKCRCLPIo+Aiko
 1b3MB/wPJEdUn5qcCCIEys0QHQbx0quVb/3EjLjFhCH3MdRYOPBQH1q31C0F4p7f+e+OVF7/QZH
 xS9SxWgd+TAv9ruf2lZt6fOkC1V+laRCZUz0pQsU0dZPi0DArTjuC8YfZxoWN1oSpHfqwriv5Xg
 tBS4RgB5isOHZnrA0R6xjA7DTCyKsAqSJPsj7+5I10eTetG/ZJ4EJ+K2gBmxZ2oKshysEgPCunS
 NQOiT7IognnfI77uzPrw3cTJah8MCWi9ngQp86N3Pm9bBxS19eetcS4UWbDb+hboVDZncBa7rQR
 aM92Cs9GyUESrpBUh37NHHYmUIJpkiONB88BNUMij4JM4ucZ
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Enable CDM on the X Elite platform, allowing RGB to YUV conversion for
the output.

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h
index 6b112e3d17da6a4423851525262b66aa6c8622e3..8977fa48926b40d486110424f70344c4d29abe80 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h
@@ -453,6 +453,7 @@ const struct dpu_mdss_cfg dpu_x1e80100_cfg = {
 	.mdss_ver = &x1e80100_mdss_ver,
 	.caps = &x1e80100_dpu_caps,
 	.mdp = &x1e80100_mdp,
+	.cdm = &dpu_cdm_5_x,
 	.ctl_count = ARRAY_SIZE(x1e80100_ctl),
 	.ctl = x1e80100_ctl,
 	.sspp_count = ARRAY_SIZE(x1e80100_sspp),

-- 
2.39.5


