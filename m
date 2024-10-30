Return-Path: <linux-kernel+bounces-388759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FD69B640A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718871F243A9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E48D1EABD5;
	Wed, 30 Oct 2024 13:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IRuyzutJ"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F191E47B6
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 13:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730294816; cv=none; b=bxZZ5Wx/b+jx2tvzHcgHRmTI+S+pxystsnH/G0CjysZ6I39garSUmODi+GDvLyPG8lyFcRP9A/RaCocS+0X7yyEtlu6NlFuFvOOO/h2WCjlKN/cqX6Tysw2G8ecI/SjO+LNt8mom0b1SP6J5+Sz1UZrQVUq1EvS7mVmn5h02eyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730294816; c=relaxed/simple;
	bh=ainmGEAe2nvxsKE3uvQszP5Qu9isSkOhSEr9wHzge2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0KeCI5JMYixvFRCcKFYqBnoR+DCPHDdRTqii5rviBx0bE5BpdpBB/XESE0W8mkxuRNgHIEkkP8pa9oY9GnU2BrWcXW6hHALijuGtoVpxdNCo0StQBQBzixAj/PiDU75pvypJq0u7m9pNkMe4igyVJM1O/BbXUrDt3hMQK6VGp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IRuyzutJ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315baa51d8so63603135e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 06:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730294813; x=1730899613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzoMFJwewUJr88TLCzmafGB2re8jMyauaVwVQzw6WY0=;
        b=IRuyzutJOpgHKPIc8F65+3Dzj4F6QsXdLYsnARRL74s8AtI6/2f6OYsLb9AymF/BZy
         chd1ahZFl4PDtsH0S4UdOfe/5AEHkRpAYkpxKt8LTdUmT5I4jh1lw4daGdZgmgtzIJpH
         uGLWH8Z9o7qsij9BHEgvVSy/T4pZ688MSz6/A4c4YaKXlJDqwoyl+Qo+t1ZTKyPc8cVe
         TUxKCLfh2zWhE2qe33Kwul+vsUzFjd24STvHmi0r11hRc2IHqnAeZJio9WUQTN1qROJr
         4PgUN1pyBQ50Iqg2MHUVQOnDBkXKqalZJsfr3uEm9/07ADLNKSlpfWa7enNGC5RzeRR7
         5d5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730294813; x=1730899613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzoMFJwewUJr88TLCzmafGB2re8jMyauaVwVQzw6WY0=;
        b=gsp5pyaToysBiyzR8aRsMH1GBJjMMYreIck2f1CgoEZ4aNeQWDgzcQmjN9d5AniNQG
         ynJbqr6rprx/K5Mjvcv52uLUhSgCa3QCSDwAN1lULvhNqWCXwK0vSYXZ9Mcbql6WLNCw
         OHqPenda9ExxChjygoYQG/IqAt9X3X9SDrcShUTd2ezk924KvnoTyVsior7+Fu4l9pNU
         UgpF81YsO8CLZGP25kE17ftRCAoHve5TwNFnfhsriYdA+R9eipwwNL2OfNEavLwnwNS4
         ssyXG8+89TrBzZtNwJt0meMN5D9xvWuTORowBTu7xLPnMIblAwRizWaiINF3BaD7UXMf
         KMHA==
X-Forwarded-Encrypted: i=1; AJvYcCUnpfZsLcR6Ui82kxwwdETJgPB4oF+A2ZZoL9Yo6a5atf5c0SI6vBnwaDg/vmAy2gTB8sdXbyXeaTHIgE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrbG6JgHD+68q+fWg/Q3rIvrK66+0Czb7FLHpmQxAirdyS9Vqb
	cXL30RKJxbdp01pzGYnbNJfc9UNqd2nyfOB6PTSrq048EaQ4CeVYsy9XjgYJEJQ=
X-Google-Smtp-Source: AGHT+IHvCVDH97OPRIU78dk2sv1dUkZXYpRkqnVZcPXDtJpr/JmOXd9IkvC3KGa6t702TR8hj0iMNQ==
X-Received: by 2002:a05:600c:4f06:b0:431:5021:32 with SMTP id 5b1f17b1804b1-4319ac74308mr110456545e9.6.1730294813080;
        Wed, 30 Oct 2024 06:26:53 -0700 (PDT)
Received: from ta2.c.googlers.com.com (32.134.38.34.bc.googleusercontent.com. [34.38.134.32])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3bdafsm15356836f8f.30.2024.10.30.06.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 06:26:52 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: alim.akhtar@samsung.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com
Cc: krzk@kernel.org,
	linux-scsi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 2/2] scsi: ufs: exynos: remove unused rx_hibern8_wait(_nsec) fields
Date: Wed, 30 Oct 2024 13:26:49 +0000
Message-ID: <20241030132649.3575865-2-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
In-Reply-To: <20241030132649.3575865-1-tudor.ambarus@linaro.org>
References: <20241030132649.3575865-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rx_hibern8_wait_nsec was used to compute rx_hibern8_wait, but the later
is not used afterwards. Remove both.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/ufs/host/ufs-exynos.c | 5 -----
 drivers/ufs/host/ufs-exynos.h | 2 --
 2 files changed, 7 deletions(-)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index 91c09309c1c1..fd86252ab2ba 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -559,8 +559,6 @@ static void exynos_ufs_specify_phy_time_attr(struct exynos_ufs *ufs)
 
 	t_cfg->rx_linereset =
 		exynos_ufs_calc_time_cntr(ufs, attr->rx_dif_p_nsec);
-	t_cfg->rx_hibern8_wait =
-		exynos_ufs_calc_time_cntr(ufs, attr->rx_hibern8_wait_nsec);
 	t_cfg->rx_base_n_val =
 		exynos_ufs_calc_time_cntr(ufs, attr->rx_base_unit_nsec);
 	t_cfg->rx_gran_n_val =
@@ -1975,7 +1973,6 @@ static struct exynos_ufs_uic_attr exynos7_uic_attr = {
 	.tx_min_activatetime		= 0xa,
 	.rx_filler_enable		= 0x2,
 	.rx_dif_p_nsec			= 1000000,	/* unit: ns */
-	.rx_hibern8_wait_nsec		= 4000000,	/* unit: ns */
 	.rx_base_unit_nsec		= 100000,	/* unit: ns */
 	.rx_gran_unit_nsec		= 4000,		/* unit: ns */
 	.rx_sleep_cnt			= 1280,		/* unit: ns */
@@ -2050,7 +2047,6 @@ static struct exynos_ufs_uic_attr gs101_uic_attr = {
 	.tx_min_activatetime		= 0xa,
 	.rx_filler_enable		= 0x2,
 	.rx_dif_p_nsec			= 1000000,	/* unit: ns */
-	.rx_hibern8_wait_nsec		= 4000000,	/* unit: ns */
 	.rx_base_unit_nsec		= 100000,	/* unit: ns */
 	.rx_gran_unit_nsec		= 4000,		/* unit: ns */
 	.rx_sleep_cnt			= 1280,		/* unit: ns */
@@ -2077,7 +2073,6 @@ static struct exynos_ufs_uic_attr fsd_uic_attr = {
 	.tx_min_activatetime		= 0xa,
 	.rx_filler_enable		= 0x2,
 	.rx_dif_p_nsec			= 1000000,	/* unit: ns */
-	.rx_hibern8_wait_nsec		= 4000000,	/* unit: ns */
 	.rx_base_unit_nsec		= 100000,	/* unit: ns */
 	.rx_gran_unit_nsec		= 4000,		/* unit: ns */
 	.rx_sleep_cnt			= 1280,		/* unit: ns */
diff --git a/drivers/ufs/host/ufs-exynos.h b/drivers/ufs/host/ufs-exynos.h
index e64fe20d50c1..b7fe725c7f8e 100644
--- a/drivers/ufs/host/ufs-exynos.h
+++ b/drivers/ufs/host/ufs-exynos.h
@@ -144,7 +144,6 @@ struct exynos_ufs_uic_attr {
 	/* RX Attributes */
 	unsigned int rx_filler_enable;
 	unsigned int rx_dif_p_nsec;
-	unsigned int rx_hibern8_wait_nsec;
 	unsigned int rx_base_unit_nsec;
 	unsigned int rx_gran_unit_nsec;
 	unsigned int rx_sleep_cnt;
@@ -199,7 +198,6 @@ struct ufs_phy_time_cfg {
 	u32 tx_gran_n_val;
 	u32 tx_sleep_cnt;
 	u32 rx_linereset;
-	u32 rx_hibern8_wait;
 	u32 rx_base_n_val;
 	u32 rx_gran_n_val;
 	u32 rx_sleep_cnt;
-- 
2.47.0.199.ga7371fff76-goog


