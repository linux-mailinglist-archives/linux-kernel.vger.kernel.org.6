Return-Path: <linux-kernel+bounces-440969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6449EC750
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18678281165
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890641DE3C3;
	Wed, 11 Dec 2024 08:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PnWFqNjc"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0C21DC9AB
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733905807; cv=none; b=N2aHDm7Cguxo/YV7OwrRm1ukzBCyOUTt/OErv35wgxfdwURhReZPq+MYXkV2S8OiXXj+8555ZsbF0Fzm4yM/unjSoiAaAAbB3lLFvlcVgRb5gsQkCcnH/MqlyTOe+ee+L5F5PhCLF5NZNRMhgYK1JwYtCUL/rrS3iKLA45hXG44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733905807; c=relaxed/simple;
	bh=yovwygK3S8pu26HzluofMUYGeWNAA5KC7l+8jvZOelI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LFtIT2r+sBIvQ871REKm7RmFfsKgl/ONsst6nhVogE1R1UOJOFgQ2GYnEjPi2Y8gFOLEzwDFrIkKdNTZx6RzzaYoSYfPC04tGwcRRLpqbcli4Lvs/mzFiz4HbwiiWUI2MkjEN9TQ00G7xO5/21ylGJpqA9A9PpdLeR5k9pR1ek8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PnWFqNjc; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4361f664af5so2183815e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 00:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733905803; x=1734510603; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lNypXtc4nIg+qb7sUPhcVsJhL4eqdZ8B/Tfk40MaJXk=;
        b=PnWFqNjcSyAzV+/3Wo5juToy41Wej9C7Hm/xY8G05FeaBMtW8dP3o7/JHG5OFfJEE+
         hj83Ld3E30z5IP72dhXG1Lwf5qpesWq7fDurhmTLTgJt26KYbzdaFfdieCFj3sfChM8I
         9SbY1MEmx2dJHSbmEQSIev4tpg4uBJObQUN99bIkg2gkxz2mMK+3A0beme4JsYLwdM8O
         GA+Rse8Ic2oEuZ6OqMOpVe0jStDYpuSaiCxvCNYGO6xbIa8Kbg4uPQmgbqoMHmZvU2jE
         QQ28CkEFzP74XX1CCW3u9dkJ/Rp7H8gFNAhQfyUdUQN/X8+UbCXEX2Gq6VXJFEj3/n/N
         Efbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733905803; x=1734510603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNypXtc4nIg+qb7sUPhcVsJhL4eqdZ8B/Tfk40MaJXk=;
        b=KzgqCPHo8ooIV1sTNzl5ys7lWxyNfo+e5ySO2ivzPFgaiLCuBHB+bC3DKEfcWHehB0
         VIoYVcM/urUM9vntTNVZBt3ckBQzOjyjOs7AulN91Kwd+x17HCBLqh/72Uz+4ppwoxCA
         3T1pZq68uc5LvUR/VtYhgax1IoOeUhBm5osatKXUeKKbxTwheY5QP62km5aqpHFO/8j5
         EGCYOmBo7U/8FS7sUVuu1LJR5svoC6HggXII7tFdZT7i7+Gk0ycijth/UTRoT9e8VOfD
         uLrDmWhVy7xW7RiCMIUmt7zuS9pOJjsKL4a03gUX9J2O3DKoE6/SBp+rgSDE915/fxx5
         WMSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9+jKFSezZt3D6uHpRinyTY+HT5N8L5PlcKP0M9LU94uC902HrNQq+QYbR40NDukaHcGf/oxOu0QbcMko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/cSD5ge5OslgMPUMm/ePTU7EcCzO60m5RdVjJfi4pm37VfCFW
	T7pjHr8cifPt0foDCaO/2VSFqLmCiKXv+pVQan7IX8bbGl47M2zE/xY+m+jC62Q=
X-Gm-Gg: ASbGncuvTn8EpKwhHC/f3iTmBguxUxOyvGzRgoaUwHbRpmqoOsT/H+liixBAifc8IVV
	G4cRaMhKWy+D2PPNPLoobR4M9+L+2kco6XUi1wpypjAM/UNC0eIX87klQBAxhMvZl1uWXZil6EH
	iO/yorajA8t5pksvH2lXTcDlNvccATi5+U9SjI3B8Ru3dj0W6Xuh4OeXxnpunCii4ByTfHpSLtj
	VetcKntOCBi/yXBxPPg/UU1aMN8dCxfVikGTeXA56/1G7hbAN3yB3uoo0IuEET5Ep6Z547Pem0=
X-Google-Smtp-Source: AGHT+IH6+vEX2WfNXNJ2nAc7kKUYdmLrBTuQoYVlYpfObom8aKcXHzrfp+P4XyYInweEJtk1gSrx/w==
X-Received: by 2002:a05:600c:c11:b0:434:f7ea:fb44 with SMTP id 5b1f17b1804b1-4361c3acb65mr13968775e9.14.1733905802821;
        Wed, 11 Dec 2024 00:30:02 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824a3e38sm735687f8f.23.2024.12.11.00.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 00:30:02 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 11 Dec 2024 09:29:53 +0100
Subject: [PATCH v5 3/7] drm/msm: adreno: dynamically generate GMU bw table
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-topic-sm8x50-gpu-bw-vote-v5-3-6112f9f785ec@linaro.org>
References: <20241211-topic-sm8x50-gpu-bw-vote-v5-0-6112f9f785ec@linaro.org>
In-Reply-To: <20241211-topic-sm8x50-gpu-bw-vote-v5-0-6112f9f785ec@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3622;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=yovwygK3S8pu26HzluofMUYGeWNAA5KC7l+8jvZOelI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnWU2D/mNj+S561qPZ/Vd9Rzw1cSUKaTGzvfXwgVkA
 QS3aNyqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ1lNgwAKCRB33NvayMhJ0agxEA
 C+A9ezN6FpehfMIejE/kwgdHMeDDhFA6t0KwsN/26Mi/YL0grjbDM5ahRuQ89HQ2nu9RXW/A3s7hkC
 ABtUbGsL5+ltQ7s+OSVAO8AOcSDEig5sNc6TuUTybS39C31rnVVdJtOCpVak5rw2dFWvBSAGX46fJG
 HMu4/UprRHYitqxhGOIhnA6O8OOWb/dff3ZbJ879AhsRnt/SSZK99ZrUjALeSBP50RcLgT0ulmm5tm
 586MuPgiAWTlol9VL1vovc+4dIz9NMnHywnqSBEme1ZUEUD1fw1JDUPaVlL5CBZ3n4KEIwDpnbPCEd
 /rNlt30YQ9ZLFxCEwEWIf/1rgMUhAB/V86RIFJX3UaH8jFkGTaXvFSt7vyFLw4gZ0QmRtWcCPghY1K
 6UtX59fg1BEBY0CyUMZ0VffC1kriWkCvYp3E9FWkRbMaf7Ij1s/d1/OJ+koJXOHr2ugy36ApYpYY+H
 B84m2/sFreBaRYe0ZzyiHWyO8NqaLVK2XafTNzQzcgKkArR65IYyjcVr+xKOQb/lr/c4qvgLN/qvX5
 wnuLhoapLyKY5Q/hRg9+PHmtcDt8ltdyZBu85AEKsX0QfZIqIClvD5z4c6G/uGhyBSKTPLnuocUeD+
 8g+dTvwRLe6WvTOGmfHKS5hyPOH9Nz9p98KbfvfcFnRBUxOqdhZWuQ71xPUQ==
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
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c | 48 ++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
index cb8844ed46b29c4569d05eb7a24f7b27e173190f..995526620d678cd05020315f771213e4a6943bec 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
@@ -6,6 +6,7 @@
 #include <linux/list.h>
 
 #include <soc/qcom/cmd-db.h>
+#include <soc/qcom/tcs.h>
 
 #include "a6xx_gmu.h"
 #include "a6xx_gmu.xml.h"
@@ -259,6 +260,48 @@ static int a6xx_hfi_send_perf_table(struct a6xx_gmu *gmu)
 		NULL, 0);
 }
 
+static void a6xx_generate_bw_table(const struct a6xx_info *info, struct a6xx_gmu *gmu,
+				   struct a6xx_hfi_msg_bw_table *msg)
+{
+	unsigned int i, j;
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
+	/* Compute the wait bitmask with each BCM having the commit bit */
+	msg->ddr_wait_bitmask = 0;
+	for (j = 0; j < msg->ddr_cmds_num; j++)
+		if (msg->ddr_cmds_data[0][j] & BCM_TCS_CMD_COMMIT_MASK)
+			msg->ddr_wait_bitmask |= BIT(j);
+
+	/*
+	 * These are the CX (CNOC) votes - these are used by the GMU
+	 * The 'CN0' BCM is used on all targets, and votes are basically
+	 * 'off' and 'on' states with first bit to enable the path.
+	 */
+
+	msg->cnoc_cmds_addrs[0] = cmd_db_read_addr("CN0");
+	msg->cnoc_cmds_num = 1;
+
+	msg->cnoc_cmds_data[0][0] = BCM_TCS_CMD(true, false, 0, 0);
+	msg->cnoc_cmds_data[1][0] = BCM_TCS_CMD(true, true, 0, BIT(0));
+
+	/* Compute the wait bitmask with each BCM having the commit bit */
+	msg->cnoc_wait_bitmask = 0;
+	for (j = 0; j < msg->cnoc_cmds_num; j++)
+		if (msg->cnoc_cmds_data[0][j] & BCM_TCS_CMD_COMMIT_MASK)
+			msg->cnoc_wait_bitmask |= BIT(j);
+}
+
 static void a618_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)
 {
 	/* Send a single "off" entry since the 618 GMU doesn't do bus scaling */
@@ -664,6 +707,7 @@ static int a6xx_hfi_send_bw_table(struct a6xx_gmu *gmu)
 	struct a6xx_hfi_msg_bw_table *msg;
 	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
+	const struct a6xx_info *info = adreno_gpu->info->a6xx;
 
 	if (gmu->bw_table)
 		goto send;
@@ -672,7 +716,9 @@ static int a6xx_hfi_send_bw_table(struct a6xx_gmu *gmu)
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


