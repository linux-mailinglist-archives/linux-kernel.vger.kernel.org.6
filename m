Return-Path: <linux-kernel+bounces-390703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB15B9B7D8B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154521C20A4C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19C91BB6B5;
	Thu, 31 Oct 2024 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RwsHdhjI"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D152C1A7065
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730386846; cv=none; b=j5dYzLYPKDqXyHXtyqDAIqvY65AX0i98yhJ6ed6OYLVZKu8/FdwkuO2SLRsr8gBeYMvHl8zwjzDgpaBVUEnLUvz99vMzzH0EIs6wujK5wdvb823C/sN4/V3k4cnJlcyHAdIzHsLO6KGKmVYdVNk2wXYcC4jf5xrvc6Cj2Lo6GVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730386846; c=relaxed/simple;
	bh=xDtKwqvnqxZAQP4VrzospgjmeLcn8uf+9e8SZLyCgpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxbuLEkiNvtN36xfT+zK6nHjoEHKJ+EHST5XEGpZ/xJgvdKANqRnlBwvD6q2xINYmMwI+6Hm3F8DVYp7H5HfZs6nePdvQc3v8UiM3t6vh6HSA2unlE2tjcbtRcgPaOWJmSI8j9ueNwi8M3N4Jz0KL+EAIze7jMm/2mtxCbRbs/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RwsHdhjI; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4315e62afe0so9071195e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730386842; x=1730991642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usrOkYEIhJMHpNEH11NB+5bvhSO9JoP7forJzaG92bc=;
        b=RwsHdhjIExPULOr8gokrXIL6m3DfiFvnZ/FHMDuA7Z3LVFvC/7zrMMeVVViBi8ieoK
         9UcN7MsodWT0pitCRrwixcwafmaVdBFeN3OAj8CMvueOI62BF/32KUoyVM312Y6A+dH4
         7jkTLib2OkQV15e894FzYUdqpfx9fF799RPdKQJ/gK3ZTl824CdGiJoM3dnCvYnj3L1D
         TKuw4CCmzsfSw/Riw55VZBRhQxN92Dr1LzJ9JxnHwsfZLpz6r4GcwE1A3a6szUoUxPDv
         dhhcMjs0HBgZUpcpRKWV6A4n99uFnfFt2ofLu7NC0Z4O+62zlUYVbjrCLb9T9bXXl5Md
         9RSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730386842; x=1730991642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=usrOkYEIhJMHpNEH11NB+5bvhSO9JoP7forJzaG92bc=;
        b=iiHJX6t/ZYVYEUThtZkBSXLjvEENaQRulty6mvOT6wBCIOAwQwj5nHh45LaJ/sZDcn
         GFb5mJbGwVsBMSnM6EumR/IRhlWUHSFUiwmGWhSMSTUJEBIpcw92ihLKcMXgaxjNMLBT
         E+lGqEicE0tz4NRq6AKzcqwWxqrfATaIebYMoj6Lwv5kX8T4LRCz0+Yh7che/RjjhcSr
         lYLJ956gfnicYzvv+tc+Cw619DuhYve7WNrnN7V1GURyndf35xuOpOHNrN87qKLbtN7X
         3nFOuY8guvdItjlg2SkNRFljNarmlE0fdPH2GjcNlRO9a+ElX+oefB1iraEGeq8oxjC8
         5mxw==
X-Forwarded-Encrypted: i=1; AJvYcCWUnBGmAIgY2jhXCpfTn4nvwkkraxqyKYyYf3j7jWLkgpEBjD013nwSiK1hLSfuRsAddzKfBSF04SuHyY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpKYpYMUMewZJJ48gLLcUtPOBEw3kpe8kobrNsXnSBocfGogz8
	qa9oxh9R4HXfgMFlcnP9KhxAHAy8dCkhjngZ3g9hgwSw2MLHJjOdhtNYzWpH6RPmyBvW7h3ESCr
	8mEw=
X-Google-Smtp-Source: AGHT+IE2nRqDWcprFbqsyiRnRrZSmdUyGUKgVh+UN0C5kREuaiIMyson1wnaLb7mms/VbQSk1nr2fA==
X-Received: by 2002:a05:600c:4a88:b0:431:9397:9ac9 with SMTP id 5b1f17b1804b1-431aa292eb4mr115733635e9.15.1730386842144;
        Thu, 31 Oct 2024 08:00:42 -0700 (PDT)
Received: from gpeter-l.lan ([145.224.65.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd8e8524sm59163225e9.5.2024.10.31.08.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 08:00:41 -0700 (PDT)
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
	Peter Griffin <peter.griffin@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 04/14] scsi: ufs: exynos: add check inside exynos_ufs_config_smu()
Date: Thu, 31 Oct 2024 15:00:23 +0000
Message-ID: <20241031150033.3440894-5-peter.griffin@linaro.org>
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

Move the EXYNOS_UFS_OPT_UFSPR_SECURE check inside exynos_ufs_config_smu().

This way all call sites will benefit from the check. This fixes a bug
currently in the exynos_ufs_resume() path on gs101 as it calls
exynos_ufs_config_smu() and we end up accessing registers that can only
be accessed from secure world which results in a serror.

Fixes: d11e0a318df8 ("scsi: ufs: exynos: Add support for Tensor gs101 SoC")
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: stable@vger.kernel.org
---
v3: CC stable and be more verbose in commit message (Tudor)
---
 drivers/ufs/host/ufs-exynos.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index 33de7ff747a2..f4454e89040f 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -719,6 +719,9 @@ static void exynos_ufs_config_smu(struct exynos_ufs *ufs)
 {
 	u32 reg, val;
 
+	if (ufs->opts & EXYNOS_UFS_OPT_UFSPR_SECURE)
+		return;
+
 	exynos_ufs_disable_auto_ctrl_hcc_save(ufs, &val);
 
 	/* make encryption disabled by default */
@@ -1454,8 +1457,8 @@ static int exynos_ufs_init(struct ufs_hba *hba)
 	if (ret)
 		goto out;
 	exynos_ufs_specify_phy_time_attr(ufs);
-	if (!(ufs->opts & EXYNOS_UFS_OPT_UFSPR_SECURE))
-		exynos_ufs_config_smu(ufs);
+
+	exynos_ufs_config_smu(ufs);
 
 	hba->host->dma_alignment = DATA_UNIT_SIZE - 1;
 	return 0;
-- 
2.47.0.163.g1226f6d8fa-goog


