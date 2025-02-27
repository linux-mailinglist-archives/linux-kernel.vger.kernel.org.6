Return-Path: <linux-kernel+bounces-535447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFB5A47310
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 03:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED5A1889155
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0821CCB4A;
	Thu, 27 Feb 2025 02:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uurGyW6K"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D2E1C8622
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 02:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740623129; cv=none; b=cCK56r5YmeiyBo2oqIgnDkqO1/wxFyBXR8RcSM7Dv2ZjycCOj88T79ee7bYeENqPZlkK0XOgVLI/3It+NKOt84U1kS7KWS5Gsnnz0+JkP0+ZnQyH6LLpqW7wuEGj3rv7Gn9CaiQHgy0jgehVJ4afQBM49a9uNfoA/KChlk6J/4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740623129; c=relaxed/simple;
	bh=RyZRLS8pZm8hoJDU+OVp+AAZeLhFhiibO05/Oz7CvDI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QcUP7spr9JBbRMEoY27dt7Tkfk98FFsc9BIow0IDODCVGd1t9OagwCbkLrvHo3cfVADpnrAlfe+8PwulmHJBsLi6kCgrkTGuSfd1Z7ZH3/02yB36UdiXE8rVpOkHYzqNT9qaDeyzmp9gV4/PSyI5sNF7/EB8l4CqXiE4HFojdmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uurGyW6K; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54843052bcdso356887e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740623124; x=1741227924; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ouKK+P8Bp77QlLVV+lTMqGiv9R+6akFjSocFKtf2Jk=;
        b=uurGyW6KnR+p2Od28nIZoja6NRL02b5Y+fSueVYdKXTgrnV/OgpA7wSMXH4LU1JD+m
         Anntv9hvogvPxNbPALtHQvxIZoI9S8+3SSmliihR4Q3tZRpPAjLcacFjCkB2VxLFkzlJ
         9GewUaLLLurKqEIw55w/gpfnt6avKvynDEY94MqySqf0X8XwKc5fkzMS25/9XQMi2h9J
         q9X0cJbuaFjvWc8NhNcgemI5QC9OGJCLk5JQsN55pU+tnooDk7BV+m/8ZiG0fQn0F7th
         /1aGcOlu8A9KUn5spxDbwNvKYuGxHg4JKC5SnL0zFqEB/7jAAa4HSTyLJhVGMa5wmIHF
         hO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740623124; x=1741227924;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ouKK+P8Bp77QlLVV+lTMqGiv9R+6akFjSocFKtf2Jk=;
        b=be7tGNzAjZ5jBFq0KnM/1q9LvfsjcNdF6MK0NUB9Yh2lADB772BY/fp7ikLE+fTiir
         3pRf4e0so3aIKR00kd+5eCWh7fMrB6y5ZaaHRDwAIbldDrvoDo+nmgSytn85AUzR0S7S
         use8Aauh1JKANDf3QDha+eO3mw8CWC9Rl7n6/dO0yvVP0V6K2FWhDysdwjmQhV4PcGxx
         t+0wBygyRbBisk8V6ljKs4o8lPV8LJxhUGSxSEDLkT6vdcuc0Y1JfFBT2MOCbDtgl+I5
         H7OO5VCwGOzxzUzMbbPJFC7Pv8dhYlLJn0PF96Gydi57egDh2ichGVRri9C7FmcORdT+
         ZsDg==
X-Forwarded-Encrypted: i=1; AJvYcCWosUKL1Spg1F4HLfgxxIZc49405OJCNf0a/WSqu4qVP2Ybj2kHVmqvRU/QCu9DuQprgQ1BInpGGiFSm6I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv/ECpZnq3VfhdS/12m5xbTYGMxNDtYcfz3N5lQqQ3NCWeemmJ
	oqcIDd18jtkU0a8P/jFghyPLSP/ylUdH5zRxwmQUQuBEmbFxnhTNGLaadaswrPo=
X-Gm-Gg: ASbGnctoLIMsygp3lA8JNKWElakyuS7ZTNczTX3PKzSPXtkFsIG4JMGzfAjP3ltb/5m
	T66uIABTSvCXWYbdwp7bi6pEQFvpAKtHrO2JkJa4Q4sQJsSgWQVak2chlOHQ8VVaNWfXhGpOjF0
	ev528CPO+W6Ue/bkxTsIwgaQEr56IyyWFftPdJfuEsAAaY2bSXV0qst/Y2sSuI30vFsxSn4MIMl
	+cQXoJXhdDSy8Qa0mg4JdNIBn2mAdXUgVRELFqSirxaLcHL5RYrc9yObQ3bq8PR+GgOqPfN2/c1
	ufJEngOMXNGQuO25LjYR1v+nIg08JJUGmA==
X-Google-Smtp-Source: AGHT+IGw8901cx7jCW8IdagRI7moWHr/MMfNM5yDe+5tE18iV9njnk83dC4KRsquOX1KAt/AJwgQyg==
X-Received: by 2002:a05:6512:3053:b0:546:2f44:ee99 with SMTP id 2adb3069b0e04-548510d68fbmr6201726e87.17.1740623123953;
        Wed, 26 Feb 2025 18:25:23 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549441742a0sm48067e87.5.2025.02.26.18.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 18:25:22 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 27 Feb 2025 04:25:12 +0200
Subject: [PATCH v3 4/7] drm/msm/mdp4: use parent_data for LVDS PLL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-fd-mdp4-lvds-v3-4-c983788987ae@linaro.org>
References: <20250227-fd-mdp4-lvds-v3-0-c983788987ae@linaro.org>
In-Reply-To: <20250227-fd-mdp4-lvds-v3-0-c983788987ae@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1213;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=RyZRLS8pZm8hoJDU+OVp+AAZeLhFhiibO05/Oz7CvDI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnv80HC1H31A21mg4pym4gsBNuP+Y0XPTOg2WqT
 WP81odVunCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ7/NBwAKCRCLPIo+Aiko
 1bN2B/4+9AgpU9l9qzAXAQxbcg+hLFdSjQXilior66+rMZDVFalCW9/W3knGRJVNzfacf2hDInD
 j9l325E0ZCZR1eVT0PXx9CaGTuKokn/6FTCRGnk/YYWG407FY+wlntoX9fObr7ED8+WHRcafZtx
 k9gjzwnEDAym1/FoHs1XpDh4a/856niPt8lgRzoxEu6bA95Z3ko8DD9iomDdDT2itq++sevwF0N
 1QhipfDTUGvODMu/xumMe54Yup2nSs/dwosAzUGm2krQthWKpXy4RH01jIMhXOSXu81lVlQ4wPg
 VAHGB8kgtUGZ5IVJY7DzCQfDdvTTRU6ydn3L9tQNfMO2Tla4
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Instead of using .parent_names, use .parent_data, which binds parent
clocks by using relative names specified in DT in addition to using global
system clock names.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_pll.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_pll.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_pll.c
index cbd154c72e44c848fa65fe01d848879b9f6735fb..a99bf482ba2c02e27a76341ae454930a13c8dd92 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_pll.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_pll.c
@@ -122,14 +122,14 @@ static const struct clk_ops mpd4_lvds_pll_ops = {
 	.set_rate = mpd4_lvds_pll_set_rate,
 };
 
-static const char *mpd4_lvds_pll_parents[] = {
-	"pxo",
+static const struct clk_parent_data mpd4_lvds_pll_parents[] = {
+	{ .fw_name = "pxo", .name = "pxo", },
 };
 
 static struct clk_init_data pll_init = {
 	.name = "mpd4_lvds_pll",
 	.ops = &mpd4_lvds_pll_ops,
-	.parent_names = mpd4_lvds_pll_parents,
+	.parent_data = mpd4_lvds_pll_parents,
 	.num_parents = ARRAY_SIZE(mpd4_lvds_pll_parents),
 };
 

-- 
2.39.5


