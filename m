Return-Path: <linux-kernel+bounces-356915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CB29968A8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 228131C22B7F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E3C193086;
	Wed,  9 Oct 2024 11:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oxNBtmbj"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6544D194C86
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 11:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728472924; cv=none; b=i5vrWc0oida+c2tRGxQ86dS2DYiAvTWAvj/RxZKepjxYgt93Arij5i6b2eRSZRLHXs/XFFSnz+i3U27u+XsQVT/LW5CO/gyJEI9TAvMoZk3p1owS384DqrgqDt8QqiKrSlY2HF4gLwxqLGHR3eNt5ia6kpFbCAP8YOu5sWeGZxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728472924; c=relaxed/simple;
	bh=9hGmvhSuxE/y9EVLKnI2683ms8TQVTCHDHwmHY9N2cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thuze0Hiy8JHBa+aM4Z/AjO4vFE+rYwrc+0qMAiS5wi52AkCGbc+CVUdtKl2DwXU8DJUS2SK2B0xDj7H5zs5t/1okwKu5AqxeaUhD209nRJ2nHVICreSy+LoFlxG8lyBNRrj4bn2FFAw6VZlO4b6m9kaL0d2ih0u++vLSjIzPd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oxNBtmbj; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4305413aec9so16234415e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 04:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728472921; x=1729077721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1Fwj3/79g+NY6+faRKtNgwsGaf+fSmMjnCj8KQUGTo=;
        b=oxNBtmbjtjUdTD2TyW4q7YlYkvbTt8TKhL6jvGhck22U+ByMZ85HlGZ/jECGgkPzt7
         ysoUpWXVAKKIF4+YwBfoerZnze5xuHPA9IbgGpeaot91dmMfoa1md0KcfnszbyM0VdV2
         KxcIeEgz9rJANYdI5OupdoXQ4my0sY0CPUueDcSmpjI3EBXU2mRK/YaGLgdyM4utNL9i
         mNwml9B4RFoTFW+uhtkBSCCFte1dPK+HV5UmV8wu6PqRgbsoNM0Dybmdj8X6X0xVGk7I
         ZRV8GioDAOSW8mMMEETe3eZorQbk/XGbX/G8PUdkLSHE73QVjkBfuH0nV4u2NSGme3fT
         eY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728472921; x=1729077721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1Fwj3/79g+NY6+faRKtNgwsGaf+fSmMjnCj8KQUGTo=;
        b=DjjnVcQTo/Ay8o+iZd3YET7AKs7av+zSyH7g/tAvOij1erpcl2VypHwCxHJNiNvCUz
         Ij8VfjPIf2C8on1WFLebyoEkdxlAJOF3rdAtvchSja3UQtnLEUSVo9bmLnS4sF+RUdKC
         flB1F6Orf8td8ygIzY4wsAu79hl2CeFT7BdxnFJswwjDEoje5QLwkBNuwGynvyAHN3n/
         Gs/0YA7DIsX32fq+6apDKYZF+vFWnl8bOnR6dI25k8vK3RbWOYGULJMqVaaqi5JyNU1Z
         X3YuXcc+DQW4bfB5+VMDxqE3HGlu6dQnk0uFQOItW0JTrGBFviLuBTMx9Wpy9EviIuZN
         P4LA==
X-Forwarded-Encrypted: i=1; AJvYcCWqWrMHYmsfBP+O1KcVFBUh6ewX+NXoYYnbG0w5T2gbbN9Pr7BtLf0UD/BdCrZyM1CDtD5eqFAIO0EdeVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX26AdFMWuWA17AvKbQRvoVL7tFgINi6KHVl9ATgKBFY9ch2AP
	97ipvPoV8zKe3OXb2HOHAF/BsJ/KKoABDCa/E79YZnaWbBMDT1zFCkp/iT1NkR8=
X-Google-Smtp-Source: AGHT+IGhYNO9ZBnMSQoh0ZgHAq4d+L9zcAuCJO5c+hulGqbv+vwl+vbBiaHCglEGvUH+mq9MA+vOBw==
X-Received: by 2002:a05:600c:4ec7:b0:42c:d74b:eb26 with SMTP id 5b1f17b1804b1-430ccf48471mr16078145e9.21.1728472920765;
        Wed, 09 Oct 2024 04:22:00 -0700 (PDT)
Received: from gpeter-l.lan ([145.224.65.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4310c3dcdcbsm12331445e9.0.2024.10.09.04.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 04:22:00 -0700 (PDT)
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
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH 7/7] scsi: ufs: exynos: add gs101_ufs_drv_init() hook and enable WriteBooster
Date: Wed,  9 Oct 2024 12:21:41 +0100
Message-ID: <20241009112141.1771087-8-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
In-Reply-To: <20241009112141.1771087-1-peter.griffin@linaro.org>
References: <20241009112141.1771087-1-peter.griffin@linaro.org>
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
---
 drivers/ufs/host/ufs-exynos.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index d4e786afbbbc..b0ccff7ca3fb 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -203,7 +203,7 @@ static int exynos7_ufs_drv_init(struct device *dev, struct exynos_ufs *ufs)
 	return 0;
 }
 
-static int exynosauto_ufs_drv_init(struct device *dev, struct exynos_ufs *ufs)
+static int exynos_ufs_shareability(struct device *dev, struct exynos_ufs *ufs)
 {
 	/* IO Coherency setting */
 	if (ufs->sysreg) {
@@ -215,6 +215,21 @@ static int exynosauto_ufs_drv_init(struct device *dev, struct exynos_ufs *ufs)
 	return 0;
 }
 
+static int gs101_ufs_drv_init(struct device *dev, struct exynos_ufs *ufs)
+{
+	struct ufs_hba *hba = ufs->hba;
+
+	/* Enable WriteBooster */
+	hba->caps |= UFSHCD_CAP_WB_EN;
+
+	return exynos_ufs_shareability(dev, ufs);
+}
+
+static int exynosauto_ufs_drv_init(struct device *dev, struct exynos_ufs *ufs)
+{
+	return exynos_ufs_shareability(dev, ufs);
+}
+
 static int exynosauto_ufs_post_hce_enable(struct exynos_ufs *ufs)
 {
 	struct ufs_hba *hba = ufs->hba;
@@ -2124,7 +2139,7 @@ static const struct exynos_ufs_drv_data gs101_ufs_drvs = {
 	.opts			= EXYNOS_UFS_OPT_SKIP_CONFIG_PHY_ATTR |
 				  EXYNOS_UFS_OPT_UFSPR_SECURE |
 				  EXYNOS_UFS_OPT_TIMER_TICK_SELECT,
-	.drv_init		= exynosauto_ufs_drv_init,
+	.drv_init		= gs101_ufs_drv_init,
 	.pre_link		= gs101_ufs_pre_link,
 	.post_link		= gs101_ufs_post_link,
 	.pre_pwr_change		= gs101_ufs_pre_pwr_change,
-- 
2.47.0.rc0.187.ge670bccf7e-goog


