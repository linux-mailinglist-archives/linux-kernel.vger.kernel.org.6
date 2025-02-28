Return-Path: <linux-kernel+bounces-537749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 517D1A49027
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 05:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E76767A150C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665C81B3937;
	Fri, 28 Feb 2025 04:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IYmhA+KC"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6311AC42B
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 04:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740716057; cv=none; b=U285k2avk11QpkreZ6th5YYlL75B6mFYKPPVWa9o66u2Tw1r77KZtarn8jyJmvpaXIWnfMUnfahhDT53aBOKMH9nP3gXIZEXOQZvPLiSDpvv9O6JPrZKIAYMEYaeYOzAFAywIj1wBELvqy9l3pvEl2hoaxrStYKJf+0UhBvDKwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740716057; c=relaxed/simple;
	bh=Db28RCeq/Z1F9VUkba+d3OjHCuLcQ1RUKoNZ2nefo0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZnHBg4ImbpztpuFZonchYcH661OiEZ5c5oFR/LqwFh2WWt+Z0Wlthhe7xiNvJ5Omf866hkpOZCTE6NMO/d67Whd9Hope/RVYHZUVdg8Dm2Kc52jzmBbMExmKCIkWbls39Yqi09BhpOaYuOHykQ9VXiqsTqSvDXAXIcaZSx0Em/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IYmhA+KC; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5452e6f2999so1623722e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740716053; x=1741320853; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BV2g354nchRnBXWZVfbxLCtDMmHT1sLILUGtzSkps/s=;
        b=IYmhA+KCbcFlapPEdgwOd0OJI+elTi0gycDdwG6j9RjbZWSHJHUxftCvkt3yt0j3Ok
         BaDqirFAcTTTOEMaqf3GKO4O7Mbq4hddRVrnRWR+DCmFplcD23SSUnRi2xEKvcFc0Hnp
         uk6giDaXWG9RjpqQkb57TgGatL3cbtXoWrtSxAvZ1Fx/k+CRRsB4xXhO+1k1N/Y6KWzR
         41Q0VMw+zm+z6FexCBfKUoxBJKiy4wH5TVrdE3V/3kscbUaEpl183Iwmv2TY7fgLKLwh
         rl9RP3dcRR2VZ2pZgn8vWIiAG+HvQ+7FBkuzRzIKFIS0K6CJHuQ66vSxCiJ7na57fjVz
         uJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740716053; x=1741320853;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BV2g354nchRnBXWZVfbxLCtDMmHT1sLILUGtzSkps/s=;
        b=LOEftTwNrAylM7nA+99ldoHRxzNoszew+utCV+vxckb2TPcf8qsGG0jLoeAQnEBZTh
         0PE/0uNUwRWSY6/lFgupydhZ+mXjy7ZWiDIwHQFSr7+GQKDsaeRF5WXRCjL1ZGFk2TZa
         qgjHZsvrfyd5mBc4DQ/XoZ5amkgdQsTaUmaL2iRlQU9kbnmXQ1Tbg2GhDHHR3S3QE5b2
         5zg0gTX5xbEuOBqTJuUJNnK9XghyYLpwTHTknLq+HEVJbgD11ZATg4t005dU4a8GGJfo
         B+x7jvVfWyUQtfhb1F2B7dHORffwmFIcRDInHPta0py9PtcHbIvvJhaVBIc743xaKdRc
         vUQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDeB5KnwfQ8Sp3+x3VQPSZtFPU1ItQZ7Xp4MdnUPoT7rGyqmlxKulOrDVwa8rhgHHPxQQHlsNsAVvuJFE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypx+GGsxEfNIWOCeGdH5qyt/HZm80daxSSaEkco+LosmbAwZtz
	7VqEFPxFKOZuEbt9A7vvrvm6BKSOHsCOhm00LCFjMelSmn3e9QIp++8RE4cUR4w=
X-Gm-Gg: ASbGncvLaYaiDBSuzrnVsC5UaU4Sq/3nD0BzmSWV4Xcn/ZsZBQtQujluN1eC9vhGVl1
	4VWPcDOLIFtFnh4SYy7qL9n+x5mAF32GS6L8xREjj0xw9/LSnBPPTWdemFpxkyXEcq7q8wh2t6G
	uK7VQ8oljtYzfdTCjahWvy8Sx9TbcMjqUEzzjOkVZeR1L6kj8DVYHsvRHTJCPl1ZXeUkH2KyA2t
	f+l0kQciy+/desFLI+UUEWAM9m5CiEcWUXmroJAIKnEcNVhpePJo48Lo6WzYw49jIvdgfl4xAnf
	ol28FwQqEvRsufvtMpcERXmrC9+9mYXGjg==
X-Google-Smtp-Source: AGHT+IE9YBTQR0iV6z+4YepiNFtTYxrWpO2RsdsEJMdQ2gFeW5S0vYwMjTGDZ3kcFTQ5S0SfoKkU5A==
X-Received: by 2002:a05:6512:281d:b0:545:2950:5361 with SMTP id 2adb3069b0e04-5494c129f93mr735078e87.5.1740716052705;
        Thu, 27 Feb 2025 20:14:12 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549441262b9sm361101e87.0.2025.02.27.20.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 20:14:11 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 28 Feb 2025 06:14:05 +0200
Subject: [PATCH v2 1/8] drm/msm/dpu: don't overwrite CTL_MERGE_3D_ACTIVE
 register
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-dpu-active-ctl-v2-1-9a9df2ee5193@linaro.org>
References: <20250228-dpu-active-ctl-v2-0-9a9df2ee5193@linaro.org>
In-Reply-To: <20250228-dpu-active-ctl-v2-0-9a9df2ee5193@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2182;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Db28RCeq/Z1F9VUkba+d3OjHCuLcQ1RUKoNZ2nefo0Y=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnwTgOusw857TkyTSoMiWxrvJMdo3LAJUISc0/L
 9jFAe2cySKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ8E4DgAKCRCLPIo+Aiko
 1QK1B/4gSzJoznIbF6hHlsqXJji1ggjQMu8PWaU29vFYaqaUN4wmnphk65OGL0wrF5300/u+ew8
 20fdZGfbJWN3TgnO/90hH51YuE9eOMeV6ruKTZoBRQyBYZ9zqrUt/67hXw2UU+0QGxVgmdpFLH2
 D5Q/wskOJ1NCiP8ETGMlaeR0cR1ONr5k+RVvNJjIIl2/Dvo/WWMqqoHQNkj5iISwTkSXGfk/PlP
 HlHh33TKB66Ei5fTrP/bfWJYe6HlgMUkOUrFHqzGgd1UyeYB5NmEFlE239EseEewJO6huzdljB3
 dgiizUDrhoXlICW5r0hgeLgqR6WQD7Ec2KhEPdZ0y8Z75QR6
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

In case of complex pipelines (e.g. the forthcoming quad-pipe) the DPU
might use more that one MERGE_3D block for a single output.  Follow the
pattern and extend the CTL_MERGE_3D_ACTIVE active register instead of
simply writing new value there. Currently at most one MERGE_3D block is
being used, so this has no impact on existing targets.

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
index 4893f10d6a5832521808c0f4d8b231c356dbdc41..32ab33b314fc44e12ccb935c1695d2eea5c7d9b2 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
@@ -548,6 +548,7 @@ static void dpu_hw_ctl_intf_cfg_v1(struct dpu_hw_ctl *ctx,
 	u32 dsc_active = 0;
 	u32 wb_active = 0;
 	u32 mode_sel = 0;
+	u32 merge_3d_active = 0;
 
 	/* CTL_TOP[31:28] carries group_id to collate CTL paths
 	 * per VM. Explicitly disable it until VM support is
@@ -562,6 +563,7 @@ static void dpu_hw_ctl_intf_cfg_v1(struct dpu_hw_ctl *ctx,
 	intf_active = DPU_REG_READ(c, CTL_INTF_ACTIVE);
 	wb_active = DPU_REG_READ(c, CTL_WB_ACTIVE);
 	dsc_active = DPU_REG_READ(c, CTL_DSC_ACTIVE);
+	merge_3d_active = DPU_REG_READ(c, CTL_MERGE_3D_ACTIVE);
 
 	if (cfg->intf)
 		intf_active |= BIT(cfg->intf - INTF_0);
@@ -572,14 +574,14 @@ static void dpu_hw_ctl_intf_cfg_v1(struct dpu_hw_ctl *ctx,
 	if (cfg->dsc)
 		dsc_active |= cfg->dsc;
 
+	if (cfg->merge_3d)
+		merge_3d_active |= BIT(cfg->merge_3d - MERGE_3D_0);
+
 	DPU_REG_WRITE(c, CTL_TOP, mode_sel);
 	DPU_REG_WRITE(c, CTL_INTF_ACTIVE, intf_active);
 	DPU_REG_WRITE(c, CTL_WB_ACTIVE, wb_active);
 	DPU_REG_WRITE(c, CTL_DSC_ACTIVE, dsc_active);
-
-	if (cfg->merge_3d)
-		DPU_REG_WRITE(c, CTL_MERGE_3D_ACTIVE,
-			      BIT(cfg->merge_3d - MERGE_3D_0));
+	DPU_REG_WRITE(c, CTL_MERGE_3D_ACTIVE, merge_3d_active);
 
 	if (cfg->cdm)
 		DPU_REG_WRITE(c, CTL_CDM_ACTIVE, cfg->cdm);

-- 
2.39.5


