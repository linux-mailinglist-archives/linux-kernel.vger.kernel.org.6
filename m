Return-Path: <linux-kernel+bounces-390701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4D69B7D85
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C7591C20E12
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642551AA789;
	Thu, 31 Oct 2024 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KTLDirTS"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586121A08B2
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730386843; cv=none; b=WGBBDz//DfKaoIkm2hdTfpsgRaAPn/0LBCw7YlcBU6O1+RfA33uR59vPqj5AnclebTvSY2B9IFKbPBZxjZEfhWHS65DhD6Ylgz4llt0r6xkSHk+K8mq8MjEHNeRAkk50bnFEtbCrmKmLTWvXlXOyYqLLkgpKHRbN3R8rgAfYgNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730386843; c=relaxed/simple;
	bh=qOf4UUPveJd5YdrdUO1pCl79q1awY5ngMelw6WYeoBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSrRQvCHe6xGCRkrPs8xjrQs7gmqymPsFggBqn7Hv2H1XGng7N6g2e6lzQEDjEr1FIFdFMePmhzqztAATk3VRgGOJA46uNgzMMA6j+xIOyaCR2AhXrQd3c+z+bmkYbBqmKaCGUiG8dzDbfWbBqZLnF71fwdMo5mCS+Mfd8BDI6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KTLDirTS; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-431688d5127so8184855e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730386839; x=1730991639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=urpAMkkpNWFIk6PVSyaaYZWs9YFQU6kSEcUKCd3ox2A=;
        b=KTLDirTSM7pyZ9ml9gmOwxp+MX7Xo5/rx/w62uD7d0QypbBs8HZ9d1I8SLLHE81ugP
         yefGAzBBliyI67KOGv41mhKMzyKM2xZZ4V9eej7oRiaEQitPws3LiCMYzbCTI6VT7THe
         L1IC5GKAWoxI6b7bQCOBdu3Zwm33R9YIC03OhS/1H6cS5TdUlcFkM3nd9Owb+p39MA6U
         q3KZft9kMlIacBE7Ji7NREHWkax5+Q1TeYK086pWd8B1QT5U72IHy562DImnP5kO80hV
         DIiJYrIIAx0RdCz2CvP6JDiMx1x9FzwUW/VRdGGgf3KdGftq95C3URKpvT8mx8VS+rNH
         ncuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730386839; x=1730991639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=urpAMkkpNWFIk6PVSyaaYZWs9YFQU6kSEcUKCd3ox2A=;
        b=mZ9eRnggFCUUEoa5e5dEH2/VQzNR6rfcHp9hdqNUEQqFo0NJofFE2OHlUqqxcmLoGr
         OqhX5VIHW8gWKHbZxL5lyF0v8ayXaq0PjzmWEbNWlZ74ipTaatNQAkN0CiRhSpC+qlR1
         Nki64FbDpHTTTuAnUqmlH5jIjVn2NbMi96q3zBNWV81XkYlXlmKNXScaTBU2PYK1GCq2
         +XwaMpNE/fLGhbV1q5YnBXRUe1WIKGmEIlO8OzQBYYvSrjue4jfvoRwQKY9tDF18BRjR
         3M97w6VIyieuwJ4mmQgjw9vawbpzOEjZMevIH6Mz/j7VLFoT295W+0ovBtkMcfpdAuKN
         EDpA==
X-Forwarded-Encrypted: i=1; AJvYcCXGsnjrT6Frxgys5YAEur6oORZzRTOfpsxSK3vEmRpelShULLWsPFNCSEjh5Owh6dHeVDdEyyF/5zhlxgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW7Ejot/ctir8ZxY5z+FfEq4uN0FXTtn0bX4qcXc0AW59ABsLN
	I6zXN4qjeX5vhNb26UIbdw8JT98MB8/ZbHLGmS4gn86PewlmOyBLJqG47PV//KU=
X-Google-Smtp-Source: AGHT+IFTosXWqLxskayZ0wRDzdlL1GztSsFX/UDdCXtOBwG7ObEMDNWxQFLNrN1eK+iWQPCODsvrkQ==
X-Received: by 2002:a05:600c:19c8:b0:430:54a4:5b03 with SMTP id 5b1f17b1804b1-4319ac6fad6mr150296415e9.6.1730386839067;
        Thu, 31 Oct 2024 08:00:39 -0700 (PDT)
Received: from gpeter-l.lan ([145.224.65.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd8e8524sm59163225e9.5.2024.10.31.08.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 08:00:38 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/14] scsi: ufs: exynos: remove superfluous function parameter
Date: Thu, 31 Oct 2024 15:00:21 +0000
Message-ID: <20241031150033.3440894-3-peter.griffin@linaro.org>
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

From: Tudor Ambarus <tudor.ambarus@linaro.org>

The pointer to device can be obtained from ufs->hba->dev,
remove superfluous function parameter.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/ufs/host/ufs-exynos.c | 4 ++--
 drivers/ufs/host/ufs-exynos.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index db89ebe48bcd..7e381ab1011d 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -198,7 +198,7 @@ static inline void exynos_ufs_ungate_clks(struct exynos_ufs *ufs)
 	exynos_ufs_ctrl_clkstop(ufs, false);
 }
 
-static int exynosauto_ufs_drv_init(struct device *dev, struct exynos_ufs *ufs)
+static int exynosauto_ufs_drv_init(struct exynos_ufs *ufs)
 {
 	struct exynos_ufs_uic_attr *attr = ufs->drv_data->uic_attr;
 
@@ -1424,7 +1424,7 @@ static int exynos_ufs_init(struct ufs_hba *hba)
 	exynos_ufs_fmp_init(hba, ufs);
 
 	if (ufs->drv_data->drv_init) {
-		ret = ufs->drv_data->drv_init(dev, ufs);
+		ret = ufs->drv_data->drv_init(ufs);
 		if (ret) {
 			dev_err(dev, "failed to init drv-data\n");
 			goto out;
diff --git a/drivers/ufs/host/ufs-exynos.h b/drivers/ufs/host/ufs-exynos.h
index 1646c4a9bb08..9670dc138d1e 100644
--- a/drivers/ufs/host/ufs-exynos.h
+++ b/drivers/ufs/host/ufs-exynos.h
@@ -182,7 +182,7 @@ struct exynos_ufs_drv_data {
 	unsigned int quirks;
 	unsigned int opts;
 	/* SoC's specific operations */
-	int (*drv_init)(struct device *dev, struct exynos_ufs *ufs);
+	int (*drv_init)(struct exynos_ufs *ufs);
 	int (*pre_link)(struct exynos_ufs *ufs);
 	int (*post_link)(struct exynos_ufs *ufs);
 	int (*pre_pwr_change)(struct exynos_ufs *ufs,
-- 
2.47.0.163.g1226f6d8fa-goog


