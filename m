Return-Path: <linux-kernel+bounces-537754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3392DA49032
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 05:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7C5B7A2A83
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2D31C174E;
	Fri, 28 Feb 2025 04:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MCf3lpz8"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0E41BDABE
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 04:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740716069; cv=none; b=L+nUAtYrmiBoQobVBDgl3EdiDPHOgm1qvW7Dyv6QWGRDh6Hp5AJx32iA3v1lMXftjLZRyimN8hl6Dd68h6U13uyKwX4saWg3iH53+ganPLz8H2O+VXOl0a7EyZ59K6Fx6YBZ+oyOrd/cCsApGTa5O6fKisqnhXgW795KbWf+Mnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740716069; c=relaxed/simple;
	bh=9ME/m1J0a8xy6pkwPYSmuv8Gj0s9JDUVh/PU+W77WMM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jjc4l/kzMvzrwtP9DRUWVd6BcaeaN/6+hzmYD8x8ppUcc3a1LH3bpjEvgf4WkXKXXrveFWGktMAWEqgLjOeSoYuai4ROpkOOuwH9M9agk9RhxNIFLczIzHZua3HqsmD3jmL8I7TuyjGGCeFRSBP94w2Rg8AgDXljhl3D9RoQbIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MCf3lpz8; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5452efeb87aso1675002e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740716065; x=1741320865; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wKmEhSMCDJBoOlvCmALSOOybeelc7567Ow0tL2ku5rA=;
        b=MCf3lpz8BDqh7VmVrlJ74ej2jAjPsWZ+G3OXUgQTioXLjBh9r1pgIBouXC8SCLR59h
         2iU7sg5pbN5LhtamriOsSWa6gvG3p6M8w/T2rOFWkWIxNcFQqcFRmG1g2gPvy4BEAeI6
         H288Fcztq6eK27fH7lpz99P+n/qomFoSarxtPCCTIBBtD8tB7cKH7o3HrW/m3O1R6N7W
         TX2AEntqfDtvFWZEm55HtKYUjxcS4/WwAgC7gveCbe+T+ConCwuZCDAnY4n3Gz8tUr5M
         IHKSL9cKEGU+m16GecP4nZkW77/Hxiv1xEzJuJZec2eXifaI4byWvJtMcAp8RszDECtD
         z0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740716065; x=1741320865;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKmEhSMCDJBoOlvCmALSOOybeelc7567Ow0tL2ku5rA=;
        b=wp2+g0qBi4kogWLF1W9ko/jtMPVWkpjsPjNjQZyNx/xp73Z81QmfpXHY1CzJWOMxpS
         HNdysXYmuFLNWDojgN7U9NR/HqVTkRpRKQVoDPbSbtnrDFH2c6YYlnrurTb9wBzSvEPD
         UBHpcFh4fxuzdItMTyZ68SBzdOcqVbiaHD6iumPkezoBqaip2S6BacBAWBFSOD1zb6XZ
         q220m7Q1mQDdr3uJQHw8bLzWlHHoMxu5M6n8wGXA53C2rJtugMZf6ZB9MNpuIjGcyN8h
         7sYHrasFLL5yl7ZNBbJVDO6Vs5RcEnvbnBDLB8H2ZpykxM7iiKu5ZHoiFDnq3iUVqaBO
         6+dA==
X-Forwarded-Encrypted: i=1; AJvYcCUlPuIDqdGj7jzkrC0uWAbNFHDo5jkERvBBvb6X10ZD64xOvjQKa/X64VIkvcDGH2Aat0e8x6m7lK5fKC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOmZp54tX2HdvXAN7Pi52uCNYa7ulGsf7wUyttEY2fcVEItTdF
	6v5spp1gGEEmwVtpZcSCgL36sdl8qAd+rblSrEnfXTc9ZYnCR4RzT0jxsuz6tHY=
X-Gm-Gg: ASbGncuQVTbVvSldOw3i/KK8ybrdXlVwHp50rmkPZmTyuyDDZV/Xk1MmEnZxpCN23jY
	ZPYGySuBixgNUbaq5OtmC+pAuWVE4Vhr2dQd5wsTlqohpXhIK1YmbXWyLdeFExsm8SMWu2rcqYz
	mbh33KZM/s0wi6UyNxmZhkoqaaNqxisMc/2MV8QxiecOxDagxrbsIc8YSQomhsL/eJEn1kXUsvz
	qKo+4+H01+Iww+RW2XN5VMX6ezwVP5o5JkOLwJJ/wCnMm3WoqNwZyiQglIy+CaAzfYnXZbphgKV
	a/ShE6RTTT/AAGEE0Ats6hFV0LIEbwEbdQ==
X-Google-Smtp-Source: AGHT+IFrTPCwHoGYny5G5ckuZI9C77r7UCSKuEcNlsrjyiXZzEXpDmSCPxAlcfpE49ug1V57noOTpw==
X-Received: by 2002:a05:6512:281d:b0:53e:3a7c:c0b5 with SMTP id 2adb3069b0e04-5494c129c16mr531065e87.10.1740716065030;
        Thu, 27 Feb 2025 20:14:25 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549441262b9sm361101e87.0.2025.02.27.20.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 20:14:23 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 28 Feb 2025 06:14:10 +0200
Subject: [PATCH v2 6/8] drm/msm/dpu: allocate single CTL for DPU >= 5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-dpu-active-ctl-v2-6-9a9df2ee5193@linaro.org>
References: <20250228-dpu-active-ctl-v2-0-9a9df2ee5193@linaro.org>
In-Reply-To: <20250228-dpu-active-ctl-v2-0-9a9df2ee5193@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2950;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=9ME/m1J0a8xy6pkwPYSmuv8Gj0s9JDUVh/PU+W77WMM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnwTgPW1XbcApwPVKDVEeAb03bL+wmkGORnOawA
 uH15T8hTtGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ8E4DwAKCRCLPIo+Aiko
 1e9OB/9D4+zlNGC1yj7F8c0RRfwqJqfV6I3eZX/gkilovYH5z/qUEgL4iDR5UHJToEYT9jih8N5
 vw5J2AqH2CDEhPbTizrPvX3j3/inVKMqWYVYjoLNpB7iJoiCJPv7v1yXN6e3DYuuuRdgh7+hfoa
 3Hp5ahV7CNuJonfRI0RIXQ62eadvSDgEmTA552kowBP/MaHzLAMuAdrch+v0FANs2bPI6u2zYE8
 zrXe9dacEQQ+7IFFHchXWk/dHNkwt7ayZ5HYJ3YZiSlS8gEgC34U+sAGo3VZAl1XogSJJsIUWFY
 J1GuLCirv3jYxmdpvlncb1RdAaHRAyF/GuGl5Xz8KhFpeSe8
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Unlike previous generation, since DPU 5.0 it is possible to use just one
CTL to handle all INTF and WB blocks for a single output. And one has to
use single CTL to support bonded DSI config. Allocate single CTL for
these DPU versions.

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 17 +++++++++++++----
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h |  2 ++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
index 5baf9df702b84b74ba00e703ad3cc12afb0e94a4..4dbc9bc7eb4f151f83055220665ee5fd238ae7ba 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
@@ -53,6 +53,8 @@ int dpu_rm_init(struct drm_device *dev,
 	/* Clear, setup lists */
 	memset(rm, 0, sizeof(*rm));
 
+	rm->has_legacy_ctls = (cat->mdss_ver->core_major_ver < 5);
+
 	/* Interrogate HW catalog and create tracking items for hw blocks */
 	for (i = 0; i < cat->mixer_count; i++) {
 		struct dpu_hw_mixer *hw;
@@ -381,10 +383,16 @@ static int _dpu_rm_reserve_ctls(
 	int i = 0, j, num_ctls;
 	bool needs_split_display;
 
-	/* each hw_intf needs its own hw_ctrl to program its control path */
-	num_ctls = top->num_intf;
+	if (rm->has_legacy_ctls) {
+		/* each hw_intf needs its own hw_ctrl to program its control path */
+		num_ctls = top->num_intf;
 
-	needs_split_display = _dpu_rm_needs_split_display(top);
+		needs_split_display = _dpu_rm_needs_split_display(top);
+	} else {
+		/* use single CTL */
+		num_ctls = 1;
+		needs_split_display = false;
+	}
 
 	for (j = 0; j < ARRAY_SIZE(rm->ctl_blks); j++) {
 		const struct dpu_hw_ctl *ctl;
@@ -402,7 +410,8 @@ static int _dpu_rm_reserve_ctls(
 
 		DPU_DEBUG("ctl %d caps 0x%lX\n", j + CTL_0, features);
 
-		if (needs_split_display != has_split_display)
+		if (rm->has_legacy_ctls &&
+		    needs_split_display != has_split_display)
 			continue;
 
 		ctl_idx[i] = j;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
index 99bd594ee0d1995eca5a1f661b15e24fdf6acf39..130f753c36338544e84a305b266c3b47fa028d84 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
@@ -24,6 +24,7 @@ struct dpu_global_state;
  * @dspp_blks: array of dspp hardware resources
  * @hw_sspp: array of sspp hardware resources
  * @cdm_blk: cdm hardware resource
+ * @has_legacy_ctls: DPU uses pre-ACTIVE CTL blocks.
  */
 struct dpu_rm {
 	struct dpu_hw_blk *pingpong_blks[PINGPONG_MAX - PINGPONG_0];
@@ -37,6 +38,7 @@ struct dpu_rm {
 	struct dpu_hw_blk *dsc_blks[DSC_MAX - DSC_0];
 	struct dpu_hw_sspp *hw_sspp[SSPP_MAX - SSPP_NONE];
 	struct dpu_hw_blk *cdm_blk;
+	bool has_legacy_ctls;
 };
 
 struct dpu_rm_sspp_requirements {

-- 
2.39.5


