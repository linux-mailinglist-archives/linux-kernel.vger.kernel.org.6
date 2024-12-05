Return-Path: <linux-kernel+bounces-433490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F409E592B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D8D1286A16
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A9421D594;
	Thu,  5 Dec 2024 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KjKKhgYP"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C52C21A440
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733410884; cv=none; b=HmVpU/8wQ1D2wmSO9WScml7CEVnWioOEDuwwZ7HzL4vmv2s62dlGbLcBItgW6vScBPLo1eTw/aTmrb/mZzzRR9C8Ai2UgvNjldgBoCdGddR2jE7CTgwzJcyTvKj8HNLY3FDFmSB7bpbbcN10WcCdLj/BRh1QptTlQPmfPz44ChQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733410884; c=relaxed/simple;
	bh=kKOOTThIk8iPzovAMSJ3CIAP9ALUD9Nh/ftHJ5udojQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o4snGtEI2CGgzzdH0cTCqVQEG2wH1g43sUTC4rXlJ9cKNRodgOiqJia+hsW0aMLoVnbo0j00VytbWg90qA1jOf+2fEqCDJF78MzC2Uk7PWsMVZ5FXLhWLOGsU/EH0HCZdjTVuaJNQAvJkmIbxj5TBVVqivmnTEaDRTsgGrLCkpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KjKKhgYP; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434a752140eso7054775e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 07:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733410881; x=1734015681; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wVDHOHcdQFmM3Y+rOV7NlR5dp4TOlaLEYtlDOJJ7ARk=;
        b=KjKKhgYPgV4Dh9eUTq9crYmjtvNUdAkaUesqVWrKw0U5qYXurOvbd9/W+e/nzM6StI
         2M9SObZOtni8MnLKsfD/34UwpN24FPuV9zj37lCmmHgHjAwkQnazk9sqxEmyhqnY1Vz4
         PHv/P0PYnN4YoIrla72BkbbZv1xd6xACzUdwL6TuJaLFWPsA9PXb072oeGRJUhWliuyG
         ShSyOQ8f4Gea0ucsuSq/XvBZboWPUAkRcLzl4wOMU0ecJMjV2PrtXiQJUByLTeiGPA1j
         kiVoqxv09B/ZMRyzexmgbI0xm1OCuxEFDOZj3Y83OzorxegSzZfe2NoALGiAUE5V4Oaz
         wk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733410881; x=1734015681;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVDHOHcdQFmM3Y+rOV7NlR5dp4TOlaLEYtlDOJJ7ARk=;
        b=oLAQ6VY86tnYL/gnGYC9eUeHuBAR/0Cefl/y+0FCzcpgokdjZ/BMNH7Uar0aMfnARe
         wQZdwZ6SUnMIL7KzEPFRJsNxGYKpKCmBNptmDaR/n2dSaQMqKsLXj3pu5u82VBkYJWhm
         KSQXMUBAIDC0wDkJcYZkxA9Kvt3iKA/762WkwihhpTAzZkItZQCZf8yOAbabH1hQplIo
         55VfNJunEIMw4iSfx0Rv20jpvnHy6XPDQs/HY3aq0cg/KuHeoHX7qhSMhl1urgb2lDVU
         ezyCGNGr99lIEwmWj3F1RVDzGCUHzmGomXWtwKLvsBAOyBauYyb0Mrbx3VHKc0Kg3SVe
         W/xw==
X-Forwarded-Encrypted: i=1; AJvYcCWFvyWfoeHxCUpLJbjw4Fnvzz8WYy60cwWpgQ+jE8CPpAepVohxwVmzoYWVnN8+HLvAQYS0zMu8SJVZVwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXer8RqIxpbY5WJYL8d1njfv6SbDQFOrzzcSr8oBfxh0a2pjPp
	aom9s14qzNOyV00SmpDPs2BbotKcoTuS4xKnEGzGz10P4UJq2Ygz4fLsGpasGgk=
X-Gm-Gg: ASbGncuW49b+wIZr34PDq6qGGhI/2QXrCrJ/C0dL7+D+tTQtw9IDYTjnufUJkr6ZLr9
	6CLGGdtffaynTis/i4qG/1+qTR/a7ZwdDjh/WEF4vKsF8mnbjOdOPhjye00imF/zWhmqk2ETIsI
	viHFMQmwvzl7aI1Ug7sRH0sV3un+97F4ZHJDXVeTRNcMxodqUVK7fNdcTbAIYw4GxHrsnPkKLdn
	iGjRKjxsNzxyguI0Fb2tzCjUXvdmJEOaq+gGyo6Xj5iQNJLLFXj7wdR4Vr9wE0fqSw9w40=
X-Google-Smtp-Source: AGHT+IHUl3mX3zFLLOKzIPmjsomDMmz+8GFN7zIY7QDmDt0FQywuKl8zC4gmZxmQjk+lB0wUQS854g==
X-Received: by 2002:a05:600c:4f52:b0:434:9ef2:f6dc with SMTP id 5b1f17b1804b1-434d09bee8fmr96401865e9.13.1733410880045;
        Thu, 05 Dec 2024 07:01:20 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52c0bc7sm62830795e9.35.2024.12.05.07.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 07:01:19 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 05 Dec 2024 16:01:07 +0100
Subject: [PATCH v4 3/7] drm/msm: adreno: dynamically generate GMU bw table
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-topic-sm8x50-gpu-bw-vote-v4-3-9650d15dd435@linaro.org>
References: <20241205-topic-sm8x50-gpu-bw-vote-v4-0-9650d15dd435@linaro.org>
In-Reply-To: <20241205-topic-sm8x50-gpu-bw-vote-v4-0-9650d15dd435@linaro.org>
To: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3310;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=kKOOTThIk8iPzovAMSJ3CIAP9ALUD9Nh/ftHJ5udojQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnUcA4JDsgcp2rc0Ft4I+luHcAU8M6E9S7ClY/bthP
 zWuNzMWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ1HAOAAKCRB33NvayMhJ0ffyEA
 CKsONbYHtKmFeuonBgULVuJZzLi5rZnO6U7NUT/7iLLm7FximyGOA4kym56YIVhRv5mBKHfIWVQzF9
 dy5hqag96netnbe1ggn1PqmAPMz4Q23un6xYMaDxQOEb11SX+Rar3bVVNRBVPe/B18V8dsXl89Twfs
 NzfCtL5u/xFnHDeqc1+OUdPtcOyT4+v3nNENjSbGeBv1nC/2/ro6vYrZNObcbAWOyz6LGEYvpu736h
 iQWdVx0nNWc5/pGwnZMUYfjX9PLSvYgJDzUlu9PVmKMp6redBw/CJmffbGkva6tLsAyLoj1451YNGQ
 fDr+XmuS0FV3qiDSTV7LOSrfFT4BL0Huj+udIjpKW4JmFxjoFa2yM+VeH1f3oKfpwj7+Ob3IwosqrL
 3WN5BGxb0PBvTV/Dsa0pc0ETUYUyPTYQko5990K9MNfUjgoXGrRT53IR90eLHkUOtYsBzz6OsKl8Z8
 yib8Z9YpVkOlbHtaH5xiuEaEKU/GmZJeLY9rgbWdKuxt4jwkVCGey0UAq/Y79Gggt/CGHGhwOSlpl8
 LrFqkr3xnj7ObRdQH55UytkcXUQ3iqK2PuMnyH+eaduBNrB5GmIrW9vDuAO5cpUcNb/X5/ti3aX8Kw
 03Q9BXNjeOQTE+ofgIezjfYV2tpcHeI8pStf7IMhm7/nQacMyEPEVZWr/I2w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The Adreno GPU Management Unit (GMU) can also scale the ddr
bandwidth along the frequency and power domain level, but for
now we statically fill the bw_table with values from the
downstream driver.

Only the first entry is used, which is a disable vote, so we
currently rely on scaling via the linux interconnect paths.

Let's dynamically generate the bw_table with the vote values
previously calculated from the OPPs.

Those entries will then be used by the GMU when passing the
appropriate bandwidth level while voting for a gpu frequency.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c | 41 ++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
index cb8844ed46b29c4569d05eb7a24f7b27e173190f..fc4bfad51de9a3b6617fbbd03471a5851d43ce88 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
@@ -5,7 +5,10 @@
 #include <linux/circ_buf.h>
 #include <linux/list.h>
 
+#include <dt-bindings/interconnect/qcom,icc.h>
+
 #include <soc/qcom/cmd-db.h>
+#include <soc/qcom/tcs.h>
 
 #include "a6xx_gmu.h"
 #include "a6xx_gmu.xml.h"
@@ -259,6 +262,39 @@ static int a6xx_hfi_send_perf_table(struct a6xx_gmu *gmu)
 		NULL, 0);
 }
 
+static void a6xx_generate_bw_table(const struct a6xx_info *info, struct a6xx_gmu *gmu,
+				   struct a6xx_hfi_msg_bw_table *msg)
+{
+	unsigned int i, j;
+
+	msg->ddr_wait_bitmask = QCOM_ICC_TAG_ALWAYS;
+
+	for (i = 0; i < GMU_MAX_BCMS; i++) {
+		if (!info->bcms[i].name)
+			break;
+		msg->ddr_cmds_addrs[i] = cmd_db_read_addr(info->bcms[i].name);
+	}
+	msg->ddr_cmds_num = i;
+
+	for (i = 0; i < gmu->nr_gpu_bws; ++i)
+		for (j = 0; j < msg->ddr_cmds_num; j++)
+			msg->ddr_cmds_data[i][j] = gmu->gpu_ib_votes[i][j];
+	msg->bw_level_num = gmu->nr_gpu_bws;
+
+	/*
+	 * These are the CX (CNOC) votes - these are used by the GMU
+	 * The 'CN0' BCM is used on all targets, and votes are basically
+	 * 'off' and 'on' states with first bit to enable the path.
+	 */
+
+	msg->cnoc_cmds_num = 1;
+	msg->cnoc_wait_bitmask = QCOM_ICC_TAG_AMC;
+
+	msg->cnoc_cmds_addrs[0] = cmd_db_read_addr("CN0");
+	msg->cnoc_cmds_data[0][0] = BCM_TCS_CMD(true, false, 0, 0);
+	msg->cnoc_cmds_data[1][0] = BCM_TCS_CMD(true, true, 0, BIT(0));
+}
+
 static void a618_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)
 {
 	/* Send a single "off" entry since the 618 GMU doesn't do bus scaling */
@@ -664,6 +700,7 @@ static int a6xx_hfi_send_bw_table(struct a6xx_gmu *gmu)
 	struct a6xx_hfi_msg_bw_table *msg;
 	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
+	const struct a6xx_info *info = adreno_gpu->info->a6xx;
 
 	if (gmu->bw_table)
 		goto send;
@@ -672,7 +709,9 @@ static int a6xx_hfi_send_bw_table(struct a6xx_gmu *gmu)
 	if (!msg)
 		return -ENOMEM;
 
-	if (adreno_is_a618(adreno_gpu))
+	if (info->bcms && gmu->nr_gpu_bws > 1)
+		a6xx_generate_bw_table(info, gmu, msg);
+	else if (adreno_is_a618(adreno_gpu))
 		a618_build_bw_table(msg);
 	else if (adreno_is_a619(adreno_gpu))
 		a619_build_bw_table(msg);

-- 
2.34.1


