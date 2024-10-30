Return-Path: <linux-kernel+bounces-388758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 286C19B6407
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CD761C20EE0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7EB1EABB0;
	Wed, 30 Oct 2024 13:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bja6eSGr"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8F61E32B7
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730294816; cv=none; b=hyeDECJS8nKSFlSn31MXHHSjVtDcdQowbg8+XC0+pbn5LfRosKBEfiYONvTtwXun0jTnLmfkVC2NGWujjIpXP/3dkCB1MQjFavYALy9lshvjnjmmNauiQ9hLEdTdMvf8pIl2DDlhSBprKlb0WnlW2C4Pil6yAl55nXCA0ZkLjj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730294816; c=relaxed/simple;
	bh=AKIM1SvGVyzI+MQKD5g8HL9Q2VVl2NspIGwsd6hNljI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LIuZaZUEj/3UqR56VSuQXbdEHSvEmxt17AVzsQC5Gop4mPf3mB7T/g9kUsK/TmUaozRgPfeMPmhmOkkVSJKmstGmg8SDVheCn6T25uTCcQy26590kViSy6vvmcOmc0Gx215J0+TpAqVnbRniY/RfUadxOyOzZ3uuNkNTHbvh/po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bja6eSGr; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d462c91a9so4696941f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 06:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730294812; x=1730899612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YUH2BZzthzEXo7hEUioBbWsSt3qoc+SC22xhMIafrmU=;
        b=bja6eSGreaWxeDaw5B0/liSG8bTmaG1CFEHXlm6kgcNdIH1xrBTZJ+XYCOX7uh8P5P
         e5y6wMmPXmNXjlN8mzz9APIDWFHhoKSXA0f7pvVPYhtk0ZylzTgVmqYXxQp9Wq1uct8H
         zm/ENm5K8fKF7r+7ntbWITZZyvOcNtCRgcULff6yLgfafIyfJNdqj6W+rg10rAH+ybp3
         yloizhviHDRDK6JsdfRUz1hvRlS7DAxsQtI7IQH5doOJxSrNqIGWAaJeV+vZhS2qNqmV
         5+ibDSUx4/HbwOh2E6y1H8lDjr97FzOWULzd3Dh+j7eGkNixsPNRKyNS5jrnKzXH0OHS
         zzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730294812; x=1730899612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YUH2BZzthzEXo7hEUioBbWsSt3qoc+SC22xhMIafrmU=;
        b=N0zED6P7aTxz+5zycTbXGuSjAHnSUiSFyxYbWfDDhkrU5/CboOhqF2pEwqpGjSH02f
         QC/7OI8tJbWrAVouYEB4iIWfZ9MxzwAbZo95qzs4K+Ok+ddSmP41as7rzvYCE7Y3pTiA
         mHmlGxllnWcjND+UBL4iMkvv7ARkzVcYm4nxhgbRJIUeVJf+d3WfYmv6Q4amrLNeLg/i
         jIDc+CaT03VLwmW2EV/rcgPfzzQAjKjuC97oqA2Vyo3k2ttNS+dHfgdcfYDcWR2W5Ebn
         R0ybQYImPB/YfNaTM5k3+6lsnTEEcWp1YlHsDiVT0KFlub5ohDnjuBBNawvotSGrHoN2
         ZjjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx3uT4L+HfKImo+p9vmLjepNudSyL+0Sktc8k4lRVmCCnWpHWGMkzrNE9lrmDAckJMm7Y5NAsl92/KvPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbTQNltUlBIe6ppeCHX4ZLmKbZVW/1g2LsKMw81qQaytm+LfoY
	bpYE8/kTqrytkPBLxa8TO+gRA/1i+iY7OSbJgwjBR37u8SHSi7syW6vEJaDDU4Q=
X-Google-Smtp-Source: AGHT+IHIMdJDEaCeqIXymbskBOdadZaANy4sAJ7qeopzQzAgJpTpoJyPxtp9v9pMK+6XU1FesTsuxQ==
X-Received: by 2002:a5d:4602:0:b0:374:baeb:2ec with SMTP id ffacd0b85a97d-381b7076530mr2335207f8f.19.1730294812459;
        Wed, 30 Oct 2024 06:26:52 -0700 (PDT)
Received: from ta2.c.googlers.com.com (32.134.38.34.bc.googleusercontent.com. [34.38.134.32])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3bdafsm15356836f8f.30.2024.10.30.06.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 06:26:51 -0700 (PDT)
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
Subject: [PATCH 1/2] scsi: ufs: exynos: remove unused tx_linereset_n/tx_dif_n_nsec fields
Date: Wed, 30 Oct 2024 13:26:48 +0000
Message-ID: <20241030132649.3575865-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tx_dif_n_nsec was used to compute tx_linereset_n, but the later is not
used afterwards. Remove both.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/ufs/host/ufs-exynos.c | 5 -----
 drivers/ufs/host/ufs-exynos.h | 2 --
 2 files changed, 7 deletions(-)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index 9ec318ef52bf..91c09309c1c1 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -548,8 +548,6 @@ static void exynos_ufs_specify_phy_time_attr(struct exynos_ufs *ufs)
 
 	t_cfg->tx_linereset_p =
 		exynos_ufs_calc_time_cntr(ufs, attr->tx_dif_p_nsec);
-	t_cfg->tx_linereset_n =
-		exynos_ufs_calc_time_cntr(ufs, attr->tx_dif_n_nsec);
 	t_cfg->tx_high_z_cnt =
 		exynos_ufs_calc_time_cntr(ufs, attr->tx_high_z_cnt_nsec);
 	t_cfg->tx_base_n_val =
@@ -1970,7 +1968,6 @@ static void exynos_ufs_remove(struct platform_device *pdev)
 static struct exynos_ufs_uic_attr exynos7_uic_attr = {
 	.tx_trailingclks		= 0x10,
 	.tx_dif_p_nsec			= 3000000,	/* unit: ns */
-	.tx_dif_n_nsec			= 1000000,	/* unit: ns */
 	.tx_high_z_cnt_nsec		= 20000,	/* unit: ns */
 	.tx_base_unit_nsec		= 100000,	/* unit: ns */
 	.tx_gran_unit_nsec		= 4000,		/* unit: ns */
@@ -2046,7 +2043,6 @@ static const struct exynos_ufs_drv_data exynos_ufs_drvs = {
 static struct exynos_ufs_uic_attr gs101_uic_attr = {
 	.tx_trailingclks		= 0xff,
 	.tx_dif_p_nsec			= 3000000,	/* unit: ns */
-	.tx_dif_n_nsec			= 1000000,	/* unit: ns */
 	.tx_high_z_cnt_nsec		= 20000,	/* unit: ns */
 	.tx_base_unit_nsec		= 100000,	/* unit: ns */
 	.tx_gran_unit_nsec		= 4000,		/* unit: ns */
@@ -2074,7 +2070,6 @@ static struct exynos_ufs_uic_attr gs101_uic_attr = {
 static struct exynos_ufs_uic_attr fsd_uic_attr = {
 	.tx_trailingclks		= 0x10,
 	.tx_dif_p_nsec			= 3000000,	/* unit: ns */
-	.tx_dif_n_nsec			= 1000000,	/* unit: ns */
 	.tx_high_z_cnt_nsec		= 20000,	/* unit: ns */
 	.tx_base_unit_nsec		= 100000,	/* unit: ns */
 	.tx_gran_unit_nsec		= 4000,		/* unit: ns */
diff --git a/drivers/ufs/host/ufs-exynos.h b/drivers/ufs/host/ufs-exynos.h
index 1646c4a9bb08..e64fe20d50c1 100644
--- a/drivers/ufs/host/ufs-exynos.h
+++ b/drivers/ufs/host/ufs-exynos.h
@@ -136,7 +136,6 @@ struct exynos_ufs_uic_attr {
 	/* TX Attributes */
 	unsigned int tx_trailingclks;
 	unsigned int tx_dif_p_nsec;
-	unsigned int tx_dif_n_nsec;
 	unsigned int tx_high_z_cnt_nsec;
 	unsigned int tx_base_unit_nsec;
 	unsigned int tx_gran_unit_nsec;
@@ -195,7 +194,6 @@ struct exynos_ufs_drv_data {
 
 struct ufs_phy_time_cfg {
 	u32 tx_linereset_p;
-	u32 tx_linereset_n;
 	u32 tx_high_z_cnt;
 	u32 tx_base_n_val;
 	u32 tx_gran_n_val;
-- 
2.47.0.199.ga7371fff76-goog


