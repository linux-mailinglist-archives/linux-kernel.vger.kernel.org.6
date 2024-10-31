Return-Path: <linux-kernel+bounces-390708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCB19B7D9C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFDBB1C20E2D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC99F1C243D;
	Thu, 31 Oct 2024 15:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q/rFZrhS"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E451BD008
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730386854; cv=none; b=nyHuRIL6QeRcyMsSa+TzCJtqxINddt9bNjM5mGEBv9q5BoGFhssLIdptVShyJoLnVqBesIByHQ2jjqIjai9ovppraLBoADjJjYBuXMbeEY8zxpWSn+hE9xuBEZPffDwQhyiSJlgaeYqa1gN10kGsgE/ibcYNpSHX9GUq6c7OQCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730386854; c=relaxed/simple;
	bh=cgC00Z84GRqTAZwgtEtqtGHvbN1Ns7uMwFdz59+HA28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LAQFGo/nPykugmbiKADFXEwqYV9MZleBGWfq3DcA+U3xyNuFPYBW8deEpgfj816QLiFokltIGBnz99q7njic95+lOILa8GUfjlaBl3sk0Wm4qPmwssBpdl56VQwe9G04+ITol/r6YNXtchvM7LU6xyfhuvTtQJN37Vspg5TPWLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q/rFZrhS; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4314b316495so9022515e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730386849; x=1730991649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+843px0rCbg1sKJc99pP4x3dOG1mc5oHs0HJIyYuQ44=;
        b=q/rFZrhSfcwcuHKJtAz4QMBdRxnNFvdnxVCVuQjDCGHhYf7/urQQNvPLSeQkXzoI5N
         B4gBFcmDIKX2Es299zhIgnXySaNaRO4M4MCU6QqCT/iCzSjcWugD/orFTHLLX9p0Ygrv
         Dy94Fy5dDpvfWNscJw7EDGV1zfGjDdVbhl4s0C9bMtMTegRS+xKxfvWu7KhH4fRHAMzc
         TJJe2iZLaPWTeuz6SuNGVTyxp6zF2MF5rJSoDnWYNe2S1rX4Dx7ME+ngONWrdJOFddqB
         AHavRboyX8vtqYMsbK2tIsHlFyUtZWr9YiOLcggYEC4Ewq+sgFxDaBPflaJRk/ytgT/I
         bsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730386849; x=1730991649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+843px0rCbg1sKJc99pP4x3dOG1mc5oHs0HJIyYuQ44=;
        b=Ihg4fEH4CuiXQUKJk0X196/LEnAoFWcbO+rBhpqaveppv54mEVH8T87eScc37TqPR1
         ZiawEOWw5Ov//Ifzq01LAKScG/dDkThGVfGHAKtQyrpTOAsP4ZYMRWR6l3fJMAuGgcAX
         /Y1PuhP0SNzaFE6chZu5lan+CoJIDEbLQJX5yg5oHC2LiAqi0hSzEjxgiI/rp0Jqg9db
         tR/5904S93+u3xBjn08PHeQD13rJJjCSMl4D1wW14SNEtVglV77o4PWXESBU1GEQJv8g
         3fgoEnWSYgCXZ0s0Iwbt+qn/uUqadZKkQ9Hpqq952I1uuJ+FBMAlcSVaM2quGpHof7c3
         PXMA==
X-Forwarded-Encrypted: i=1; AJvYcCVCCWWblexOivZKk0/HvNYeMy3FxVHlYL5OORj7Pfn2Czp5QTUYiEPf0AWehOWu7UXy63ScYglirvr92Lo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+LoOchRq0cH4zQ981weBbP1iJmreRZWJqLU80ta7EuVLI2cMt
	8iETp47vsKe/i/etOuDVjyY+byQ4FXyd7PVbkUORi1TuaGEZNoOHf5cTB/JVJno=
X-Google-Smtp-Source: AGHT+IFz1+UYr4hSStn9sPc2pavAOWRlpkPtO9pHTEtEu9q/PXw/hM8RRdJlrb371+ewLtzLK5Lt6Q==
X-Received: by 2002:a05:600c:3587:b0:42c:c401:6d67 with SMTP id 5b1f17b1804b1-4327b6f464amr27709765e9.6.1730386848476;
        Thu, 31 Oct 2024 08:00:48 -0700 (PDT)
Received: from gpeter-l.lan ([145.224.65.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd8e8524sm59163225e9.5.2024.10.31.08.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 08:00:48 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: alim.akhtar@samsung.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	avri.altman@wdc.com,
	bvanassche@acm.org,
	krzk@kernel.org
Cc: tudor.ambarus@linaro.org,
	ebiggers@kernel.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	linux-scsi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v3 09/14] scsi: ufs: exynos: add gs101_ufs_drv_init() hook and enable WriteBooster
Date: Thu, 31 Oct 2024 15:00:28 +0000
Message-ID: <20241031150033.3440894-10-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
In-Reply-To: <20241031150033.3440894-1-peter.griffin@linaro.org>
References: <20241031150033.3440894-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor out the common code into a new exynos_ufs_shareability() function
and provide a dedicated gs101_drv_init() hook.

This allows us to enable WriteBooster capability (UFSHCD_CAP_WB_EN) in a
way that doesn't effect other SoCs supported in this driver.

WriteBooster improves write speeds by enabling a pseudo SLC cache. Using
the `fio seqwrite` test we can achieve speeds of 945MB/s with this feature
enabled (until the cache is exhausted) before dropping back to ~260MB/s
(which are the speeds we see without the WriteBooster feature enabled).

Assuming the UFSHCD_CAP_WB_EN capability is set by the host then
WriteBooster can also be enabled and disabled via sysfs so it is possible
for the system to only enable it when extra write performance is required.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
v3: update to new drv_init() protoype
---
 drivers/ufs/host/ufs-exynos.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index 378c16d905c1..d59e1933b64e 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -198,7 +198,7 @@ static inline void exynos_ufs_ungate_clks(struct exynos_ufs *ufs)
 	exynos_ufs_ctrl_clkstop(ufs, false);
 }
 
-static int exynosauto_ufs_drv_init(struct exynos_ufs *ufs)
+static int exynos_ufs_shareability(struct exynos_ufs *ufs)
 {
 	/* IO Coherency setting */
 	if (ufs->sysreg) {
@@ -210,6 +210,21 @@ static int exynosauto_ufs_drv_init(struct exynos_ufs *ufs)
 	return 0;
 }
 
+static int gs101_ufs_drv_init(struct exynos_ufs *ufs)
+{
+	struct ufs_hba *hba = ufs->hba;
+
+	/* Enable WriteBooster */
+	hba->caps |= UFSHCD_CAP_WB_EN;
+
+	return exynos_ufs_shareability(ufs);
+}
+
+static int exynosauto_ufs_drv_init(struct exynos_ufs *ufs)
+{
+	return exynos_ufs_shareability(ufs);
+}
+
 static int exynosauto_ufs_post_hce_enable(struct exynos_ufs *ufs)
 {
 	struct ufs_hba *hba = ufs->hba;
@@ -2120,7 +2135,7 @@ static const struct exynos_ufs_drv_data gs101_ufs_drvs = {
 	.opts			= EXYNOS_UFS_OPT_SKIP_CONFIG_PHY_ATTR |
 				  EXYNOS_UFS_OPT_UFSPR_SECURE |
 				  EXYNOS_UFS_OPT_TIMER_TICK_SELECT,
-	.drv_init		= exynosauto_ufs_drv_init,
+	.drv_init		= gs101_ufs_drv_init,
 	.pre_link		= gs101_ufs_pre_link,
 	.post_link		= gs101_ufs_post_link,
 	.pre_pwr_change		= gs101_ufs_pre_pwr_change,
-- 
2.47.0.163.g1226f6d8fa-goog


