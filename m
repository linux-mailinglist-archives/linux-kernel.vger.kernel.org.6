Return-Path: <linux-kernel+bounces-381741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFC79B03A3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B8F81F2170E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D240A20D4F4;
	Fri, 25 Oct 2024 13:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Usum0fAE"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F077B1F7552
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 13:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729862099; cv=none; b=sOQW/NT+qTmno3IVvNGOug9uxRbACGDpRZZySXL8XouNqR3TVY8uW5VRTzwohpTMZZ0cb9jcV48U0TYUV7GB8nIhhbMuaw0ioJR3b/g/MMsV+lKdt/8IQebSVXwyVF5tMMsCs4YK6BSBDS8BgJMPMgJJldES6I0HCgCXWe/aHgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729862099; c=relaxed/simple;
	bh=p3g/8Z+J2ecDwNAbeCRrJL+kfRSjnRzkTSKppiTWOGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/hRRaVkTs7j/qrJteSLL8rgXFPvajEsomggkE8JNDyD4Il6NlsEJjIMHKDYnamaq6FcIE9I8wQqX6NcDFkqpPVnjwr694nLjUEWz13oN6fbAiIhUMRcABZ6+vqu+wTfEV9lmqaEqkn1gHls/9BliuamNltFNUrRzv6yybq/64o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Usum0fAE; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539e5c15fd3so1954858e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 06:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729862094; x=1730466894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdoImO6OFfTM2Lw/aicaT3K93cFHqPSr98CjhrJS+DM=;
        b=Usum0fAEfnAwg3DRH7UdAGsJxPATtqGNJdUYbE4dijh2ZeJf8cDpLpQv+6JWlOSyCQ
         UhDh90QmUyoZ3lp9dmn8m1RkrIo+fsi9Mi3AAHZag24g7vGzTD7TEGl3GIM4BNpklFH2
         QidgeNUrhsFjot4Y9paoZWveLi500zWezYN7pZZgeko2Vst2rK7Htm+FatRFZhHocI/v
         l6TaYsPBGU6EqeO/z8shvLwRyzSJ0ERMqAsEGPFBQ1/qOsgPciwD6dmPut4iSFSDrGKA
         4jl4adjswJ63QyOimLourBwYo3rp8IRd7PlhhKy9gEs9MJkSi9AsJ0nWRfeGh3x6jMty
         nzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729862094; x=1730466894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cdoImO6OFfTM2Lw/aicaT3K93cFHqPSr98CjhrJS+DM=;
        b=DfSloLJ+cE5WBAPQ05HnGtsR0x0tgB6QjckTann8iDt6/EbhMMIY22R8vudg+lO3U9
         qsKc0Gg/VfogngcdanOAlh8wNvRM0J+eZphgrHpA7nyJxv1PfdGJs6krBf55r3ZzPRGH
         ORx4jbJOA81bVBMZijH9FsVJcaq9VT5O8HxQAElgsyB2Saz0ZksEZIUck9oXPgii3899
         GtFQuD7WnWVxgykwMC5zeNO+4khebnw/vQdxKKiXU/M0pqzA7q4GcdGeyctQu0dG4u9m
         eORWSLiK8Id0KJQGX+LY5pED5h8ALcB1yB36zRfP5cLsqOCtNC4QQDzRApYQ74FhphTC
         DcOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKiBobXbx8MsiN6TL1uBryrGGYsZFAA7eEqTNmt9tnfL3/I0l1Tcxyp33bgQ+WZVCPUfNASNIqPGJFFRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfqpYVpp8zZP8XQeOR5DfcVN+PyrnhxG3SzF4XvNKnWf3xEBlK
	j49OKjz2y/kdMzZTbNNyQc090qabglZPYDqos15CV8s+xSKyo3I7JD/+TXKMCRo=
X-Google-Smtp-Source: AGHT+IHBrQGT9pmxc4oL2n1+HSGkoaeL5c5Y5zzjK0zgLQAj/a//GEezqB7iJbnehPJAIoa5TXY2sg==
X-Received: by 2002:a05:6512:1585:b0:52f:d69e:bb38 with SMTP id 2adb3069b0e04-53b23dcd34fmr3409903e87.2.1729862094046;
        Fri, 25 Oct 2024 06:14:54 -0700 (PDT)
Received: from gpeter-l.lan ([145.224.67.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b58b6bdsm47616685e9.45.2024.10.25.06.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 06:14:53 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: alim.akhtar@samsung.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	avri.altman@wdc.com,
	bvanassche@acm.org,
	krzk@kernel.org
Cc: tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	linux-scsi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ebiggers@kernel.org,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v2 04/11] scsi: ufs: exynos: Add EXYNOS_UFS_OPT_SKIP_CONFIG_PHY_ATTR check
Date: Fri, 25 Oct 2024 14:14:35 +0100
Message-ID: <20241025131442.112862-5-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
In-Reply-To: <20241025131442.112862-1-peter.griffin@linaro.org>
References: <20241025131442.112862-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The values calculated in exynos_ufs_specify_phy_time_attr() are only used
in exynos_ufs_config_phy_time_attr() and exynos_ufs_config_phy_cap_attr()
if EXYNOS_UFS_OPT_SKIP_CONFIG_PHY_ATTR flag is not set.

Add a check for this flag to exynos_ufs_specify_phy_time_attr() and
return for platforms that don't set it.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/ufs/host/ufs-exynos.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index d685d3e93ea1..a1a2fdcb8a40 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -546,6 +546,9 @@ static void exynos_ufs_specify_phy_time_attr(struct exynos_ufs *ufs)
 	struct exynos_ufs_uic_attr *attr = ufs->drv_data->uic_attr;
 	struct ufs_phy_time_cfg *t_cfg = &ufs->t_cfg;
 
+	if (ufs->opts & EXYNOS_UFS_OPT_SKIP_CONFIG_PHY_ATTR)
+		return;
+
 	t_cfg->tx_linereset_p =
 		exynos_ufs_calc_time_cntr(ufs, attr->tx_dif_p_nsec);
 	t_cfg->tx_linereset_n =
-- 
2.47.0.163.g1226f6d8fa-goog


