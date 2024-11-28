Return-Path: <linux-kernel+bounces-424540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC879DB59F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997771608D9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32203198E75;
	Thu, 28 Nov 2024 10:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MBIETNHS"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7795119342B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732789554; cv=none; b=Nmr4v6D/ZK9Bh44Ym9vrVUerXadV+TCCKIRrx7kkHWUxDCi5RO608DQEFi2li3vAOMazx2aKW7CvY+eKaoDUCtXzd3VA9bfs3yfSFaguig1C2yzUBALWlUiSaMI0aB9H7XwivGcHrfhR9v5ggKUyXfJIUR7LsFqf8IOz8j+jFEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732789554; c=relaxed/simple;
	bh=m6cl+5dS7Bml6VmAVtYBvyewU2newXJK0Ii2eLN6yeQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KPtK+iA6xwy9diLvaY0ZLxmbqFHKvWBWkeaZkYU+BJLHxXNF1/6RSRHHTIsQtu67J9hVBzMVbrV2Za13fiJ010uUn8p2qGGU0korvkLbOP6TKIbPkQivtcYtS7whv4QhpyiYBQTkp3SWabemDxo44fMw4QYZ3pMFQ9cV9D/ByBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MBIETNHS; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3823f1ed492so1002727f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 02:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732789551; x=1733394351; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SK72k/WQ3xmvOOaJYIdk4hrey4edqK6L3NlBzQcP4y4=;
        b=MBIETNHSz2i724FLTX0HghlS7gXqbg9TiifNcp9AS6wQ4wilDXRncJpr6SZhuo2Zx2
         lIgmMz2jvKmEnS9RCHk/8B/8YdT6fr6wvv7QC1pCY+RYPJZIbeWNBu+7h81Sl15z/q+Y
         1YcrjAXeEWaNuaS4HmqedqszqzUokXCOHFPCmfxZWfNFRUj7LjNjQluI+3EjtspRiojb
         OPMiAU4b/ntTUCXvvpJ8KPoA5NDOGwwkajb6pjiq4MHaknFOVRDXr/9q09jrX/GH3tWw
         Djz4Q6UZyfT1rd8/8DpLU8rrGOEG3Y5pqBzSztBXjgNmluAL/D/cnuPqx1smAvESewHe
         8dSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732789551; x=1733394351;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SK72k/WQ3xmvOOaJYIdk4hrey4edqK6L3NlBzQcP4y4=;
        b=sIpvN0wzfPqzx6JIQMIbz7r6KzxW9mPtbGvIgym0ld34fT4Np102L+HPwWmWMo+V0m
         SQj1DaH7c0DYQWrT0paf9le59sqRE2wJyGWpaXvM5cgXs6kjcajOmKrtVH+u/omWvszJ
         eDQ8yHbrdrbaV4HZeIXdd6txEfXIMN/qBJNwGzwdl43eCXJbeh8xWS/reT1n9/QwBxYD
         enKy3vduQEedDt2I1Cp10W+Agf5saNeO3FOFrv8QaljDtf1XR6WNo5CqGYusVyVxxDWS
         CMxeZ/TKG5dfMt4G80EEb+IPVozUwLYB/CMtnrCXzwknsRpRcir3a0HPSGK8sZqwIMRt
         lObw==
X-Forwarded-Encrypted: i=1; AJvYcCXDvC/VFfrVYG+dGbmJwCTWlaw1qMR/6Hc3JKmqPxZu2Wf7OqFuPtZAjiMRNNDGKy1+6tdfSafXMODPfL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJzV6RxcQg8nHLNFPxc7+/T1pLnnLPxKpSh22M+IaAPMgyKs1a
	GTx3FZHnFkVS9VC8x+jEBuhuH2NmKCRjXiG8zsG9+RnOcGqgAa3u95/nZ9OwYAk=
X-Gm-Gg: ASbGncs7/OE5DuLQmFg8yatwDW8KBdDzxw4N9lPUQiig3VnW2fBQsiQyIMhj6yDCs/J
	v1yqB3znW85DopCtOm3EeDbFF2VavGlcHPufFcxrrvOPvJv4XejPEGmAYfZIeO65AdbfsJd2fK8
	0p8H01GDT6WCtbL3jl2kHZFMmGlMEbk+DN0yqy13pglJ0WxuGSVHK0liG0+vhMD/nbJ8UWaBz/u
	98NUiKZVpEzuqUgklAMN02QvenRSxj7GPK9vUr9mQzvwM+A1qBBsJVSZoOwICBg2e0n9Xw=
X-Google-Smtp-Source: AGHT+IHY+Sjd0bkCvjs7AqBGAYrOFtVHwswzKk+ObAyWflqtjd9aC1HO9xGFLGs13Fc/oCxtCFOpCQ==
X-Received: by 2002:a5d:5f8f:0:b0:37c:fbb7:5082 with SMTP id ffacd0b85a97d-385cbd89a30mr2155992f8f.25.1732789550839;
        Thu, 28 Nov 2024 02:25:50 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd2db59sm1265909f8f.11.2024.11.28.02.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 02:25:50 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 28 Nov 2024 11:25:43 +0100
Subject: [PATCH v3 3/7] drm/msm: adreno: dynamically generate GMU bw table
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-topic-sm8x50-gpu-bw-vote-v3-3-81d60c10fb73@linaro.org>
References: <20241128-topic-sm8x50-gpu-bw-vote-v3-0-81d60c10fb73@linaro.org>
In-Reply-To: <20241128-topic-sm8x50-gpu-bw-vote-v3-0-81d60c10fb73@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3000;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=m6cl+5dS7Bml6VmAVtYBvyewU2newXJK0Ii2eLN6yeQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnSEUo6s9LquaLR+t1nEdRJP/ejIjlnSkwxWLYTtMU
 dqJbcumJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ0hFKAAKCRB33NvayMhJ0WxpD/
 4xaJOWThrZMYAhDcrGpuIeGYdU2zQYPNgiJPV8h1MiEz8m7g+ZbjOHJjRX5Lto+HVhMlKjqhiIfIuZ
 LzMI7RwrC+D6QNFKZiND1klBrhVGXpnkOdqDhO4ZE+lxf5IgF+PtZQi/tWs2k63P2DeAvGzOJxXF2i
 CJJiud6JioVyBbZvCGomMl3SLnfFkQml7agoY6wyHXz7cITxkth4PD2Mptv8U4HbQ1QPksCOgNLhGh
 CMrfwwhD5kCztNVBoNSmT+lAo1MlP5lDvU76wwRYBl0dRo8GwesHreB9qz0VTwvf01/GK7K4ktpHj9
 B6YKc9H1oNfszwrssRp7mWmmCiHYzwP53gzsruiZNGpeyhbaQx2ZohVm+25+8R5VLupzB7565H49hC
 eLZdV8V3Xe3diOICPugaNJ2ajlx3oKYfy2yJPFFicOT2NiL8wzKUc9QXIMqCtDVMm2sCznLhrjvs3W
 9og//JiUKsRQ8R6prBe7OSh/77TcZVOHmwy0vgTZsJPQk65bw0H+h+FTAfFosgqPhbOMndfn4rUuUn
 I6RdaTwoEMTLSGYTaRmeuO4eS265TsNRRJ6Tq2aAJrHCO19I5UDeK2rdsGeS6LoqUr6g8/qi/rX0SA
 JR8RC5oCAqNqEmSC9xXftPesdzwnJtDZIaeLco6R3we3gi3SY1Lf9xrNCaHQ==
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

Those entried will then be used by the GMU when passing the
appropriate bandwidth level while voting for a gpu frequency.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c | 39 ++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
index cb8844ed46b29c4569d05eb7a24f7b27e173190f..fe1946650425b749bad483dad1e630bc8be83abc 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
@@ -621,6 +621,35 @@ static void a740_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)
 	msg->cnoc_cmds_data[1][0] = 0x60000001;
 }
 
+static void a740_generate_bw_table(const struct a6xx_info *info, struct a6xx_gmu *gmu,
+				   struct a6xx_hfi_msg_bw_table *msg)
+{
+	unsigned int i, j;
+
+	msg->ddr_wait_bitmask = 0x7;
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
+	/* TODO also generate CNOC commands */
+
+	msg->cnoc_cmds_num = 1;
+	msg->cnoc_wait_bitmask = 0x1;
+
+	msg->cnoc_cmds_addrs[0] = cmd_db_read_addr("CN0");
+	msg->cnoc_cmds_data[0][0] = 0x40000000;
+	msg->cnoc_cmds_data[1][0] = 0x60000001;
+}
+
 static void a6xx_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)
 {
 	/* Send a single "off" entry since the 630 GMU doesn't do bus scaling */
@@ -664,6 +693,7 @@ static int a6xx_hfi_send_bw_table(struct a6xx_gmu *gmu)
 	struct a6xx_hfi_msg_bw_table *msg;
 	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
+	const struct a6xx_info *info = adreno_gpu->info->a6xx;
 
 	if (gmu->bw_table)
 		goto send;
@@ -690,9 +720,12 @@ static int a6xx_hfi_send_bw_table(struct a6xx_gmu *gmu)
 		a690_build_bw_table(msg);
 	else if (adreno_is_a730(adreno_gpu))
 		a730_build_bw_table(msg);
-	else if (adreno_is_a740_family(adreno_gpu))
-		a740_build_bw_table(msg);
-	else
+	else if (adreno_is_a740_family(adreno_gpu)) {
+		if (info->bcms && gmu->nr_gpu_bws > 1)
+			a740_generate_bw_table(info, gmu, msg);
+		else
+			a740_build_bw_table(msg);
+	} else
 		a6xx_build_bw_table(msg);
 
 	gmu->bw_table = msg;

-- 
2.34.1


