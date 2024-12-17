Return-Path: <linux-kernel+bounces-449399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AD59F4E77
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9BA1890E73
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8FA1F869F;
	Tue, 17 Dec 2024 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CpnDPIGO"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B451F76A3
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734447089; cv=none; b=YSTlcvLU9+sJDG/kSPiMYbf4zNzvuYuxJBw/sQXvbnTn5OO4ZxJzPGSQCqAW1Gp23Zpl103MfmyDjJXw5UQWZw3dh9FmaS8NNdITYaNh5DwdDv4mlmzOdSRr2BfHmFWJSBeaqTEqDeR9wyM7Sk1NrVu58ghdEyi29UEz8zUOKBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734447089; c=relaxed/simple;
	bh=yovwygK3S8pu26HzluofMUYGeWNAA5KC7l+8jvZOelI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H1DJnmCQiZOJzWqJLoqx/eUMvVhL+G8vaep1KjU+zVWc/KuAqIwML38hdH3ETGoZufT1xUWoAjYVqerTaFhQ/hFuvOzfJRbuuIM4wBtLQ/d5H6W1vRAGFs+aG1fWjwkP7vI5AiqVK8dHviPRYVUZnh5eE5HJ4DSeIrSkRwka8gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CpnDPIGO; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so3545489f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 06:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734447085; x=1735051885; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lNypXtc4nIg+qb7sUPhcVsJhL4eqdZ8B/Tfk40MaJXk=;
        b=CpnDPIGOTmTcAK3G4gKirqCAEj+VF5NI/kgZust8JYlM2bafoXWtBDuyyBd4vsmiKj
         imaxqvBdHpib0TNZgg5kWpm2aYBZU0hMbnX+EvYMCHqme1N1IT1azQW+76aLMj/eDKX0
         Hm1YKWYXLMXI+JvvCuXMF6ZCOpFeH00H7y/DiV1PdtdpF+4LH5u+yrg2Q6UAT0O6dTGr
         /oK7WWkPQ4BmGa20cFJF4fZtQpGF5up8Pa/Pwodki8lqAoMT18Z4e2aifILSxgWzBcXs
         Rvy9SBjDlNHiDYY4SD7vD/uUbMKNdvUPeC0NB64KVzvp9e6Kn5ykN5ziSP5V8ar2TFSY
         QxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734447085; x=1735051885;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNypXtc4nIg+qb7sUPhcVsJhL4eqdZ8B/Tfk40MaJXk=;
        b=ayWs/8WG68YijWw3HRfehBahzGEDWDEUjf2asHJUhBfPREKnX9ABXkOtxblr9FgsLJ
         dzikJ4irtH4fdxm2Ifm5Jh5BKqix3zKseQwTR7xBr6Z38Xfiz7wlZ8ZtlIqqKKwTiiQb
         h2aZ/96Tvjq6AUJtcYO+YP2yhI9SBDOnrPgtw0KKc6Av1cw7UE+sJFSNwLxoK/SXsDlz
         ego8QjzT/LY/h0gIL2zKSvyl3tNM4VljIjNbnkvI1brHTddrmRJG74gL00c5x/hyjUkN
         gBuiGdAn/JRSt6vl2CwvCWoiUOR2t+Kn4WmAD82EolQUTqzBm+F/g6nBmqRumX87dAtI
         zb8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEM0x/mzE2oMxoqBmerxKPU55zNsgyFWwl2GEtnfA9eKi4fh/HNYELvuh0XUf6bFf95+yLlXlnKQCfpSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjAanoCMXlq5p/nnMDQsxvBznblNzEeZCrNI2UBvnwLaEEwkOe
	rlYKYNHbvom/qlkFTx/W6XbCeJM3Y09AtzRuEoefdYJKGLDi5lYXKfap+7yLhiE=
X-Gm-Gg: ASbGnct1Q4Iz1h7J1gCiwXnI1G3wARHdYa+/yqAdrZMrmd+hu4hHeOYv2CqXNaieV3E
	p9VyRaucJwpDjreHPAwJZz5JZd9+zSqwoHpLyg/kf+1BLOTlb2z34rYu1jx9SGIuMqipgmXzpfq
	gVnTlv7dwDIdqSI8eWtnnL+q9H9F0NY/6diDQWlwGiy6d8i3UWjWt3mpQQspt+escMuDakv/7hx
	WHhLkFYb4/wRo7I2vpNxvi3V+OUuDbOUbxG+ixnfppnGveworbe2QwdLsB6/vfjzgTBoVGSfWo/
	fQ==
X-Google-Smtp-Source: AGHT+IF08CqGEVMJZfbJ7r7qZe8j0gbc+u42o5OD37BNt0zBqfD+ESOHAWpRHvgX9n/HUYO3z7ZyYw==
X-Received: by 2002:a05:6000:186b:b0:385:e986:416f with SMTP id ffacd0b85a97d-388db23d94emr3354627f8f.10.1734447085525;
        Tue, 17 Dec 2024 06:51:25 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43636066f51sm118417375e9.22.2024.12.17.06.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 06:51:24 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 17 Dec 2024 15:51:16 +0100
Subject: [PATCH v6 3/7] drm/msm: adreno: dynamically generate GMU bw table
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-topic-sm8x50-gpu-bw-vote-v6-3-1adaf97e7310@linaro.org>
References: <20241217-topic-sm8x50-gpu-bw-vote-v6-0-1adaf97e7310@linaro.org>
In-Reply-To: <20241217-topic-sm8x50-gpu-bw-vote-v6-0-1adaf97e7310@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnYY/mUIDbjRQ+iZT5JSE6X/+2KtHYBNH8pag3vPUd
 orbGlP+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ2GP5gAKCRB33NvayMhJ0STND/
 0aQZf1zj9prj6KG3kpeRhL+QNj38Aty/ttRl6Mpn6Tq9CdEIlEF1VNrv732vP9Z1iXlCFb+lUUcI59
 sMh21mihHwXVXanwwwy7WaneLGTuMlSpXpkPo+QvOVU5Rv6eI/Ax6SZFuV32fQoz3DORB9vp30sTH3
 xHAXrUc12SrofQItGTcxzr/1rYbx+yj1d/Jw4zQRhsUG0qowPq0QEnrgiy0h4gpLoVOKzQHVGvkvIs
 Qe8WcRUqvek6g6QZSKtZfxrHZohdq8FZZoXUmOEDYYhu9iEbZRdQ0Q//i2G+aHy7ZftYQkq9CQEWrM
 xN+RRk8uJHrjiKdB0kE+ppJnIwMVqGlTR0potzScAQtMs0PmAF78LvEihBGQo9TAFegkx0qDW2pLAg
 9yLBI1/rNSGWZVRtpv86Yxvv6fUpXFxB9CbsbI6b9G5yTatm8HzWWuqAbhpeaQlTXXdV3MvCkr7IL+
 CDasBq2BHRnMN6OcJC0TWGArfkBnoo0MDzzPDx3QbssFwzni3JjeKntNPGd8hHsOPbr4h+E6ZcsFaj
 kH8wBbNlBBeQ/7EMcUt7Qtj06/XY7YPonMPS+OUJdJbo0twWOuz7NhTUN4qBP3bV8hYe3cCIkMWuNo
 A9u7zbXaEfafzdr0+L/H4PF4BeSOsNcW4rMzjxhw2/uZQuLn2PMjd/enLcIw==
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


