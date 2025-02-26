Return-Path: <linux-kernel+bounces-535037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFCCA46E0E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 900371680FC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13B326E155;
	Wed, 26 Feb 2025 22:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YuRAUNYq"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F5C26AA9E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 22:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740607464; cv=none; b=I1PmPLiIhY+2Qpc7PshWBpbfZD8b4J1w0wcb0H5M0qxhJ+IDE9T5vNn8E2rfM+XcYcEuWXX61X3C+OqzJYSldTcY6xBaqjjPnvAdtAbO+1RRH00DKeCG7KkBY/KFra35/vdywjGPIf42Zxe6aU40fE44mJ1sjqCAbDfcIj16M7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740607464; c=relaxed/simple;
	bh=zzCHAyEKqRP94Nq6sEsgHMP78zfxlBlURkm2ZCY7I5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0X0K5DbhgxbGJz5WNwzJwyoWy3xp7Cb6sSPd1WYs/ESgSJlrCXvInM7zfrq/x32cWvx7MF0nSnvO0ZGk3/1iIpYJkTA1pBLpGDUWuhXREz2ITWlRkORij3Q1RgYFdKSy94nQ6BT1XydLbX+6HyPGzcA31O1H8nHEWTEIZredj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YuRAUNYq; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2234daaf269so4648235ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740607462; x=1741212262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTcDz5+Yk2Rd6PndDa6YwrNqhNuGseEibA7R+3Q+jN0=;
        b=YuRAUNYqgVfywzeYfW+j0Lp4zAb+InAsfYR8RJnEnAryAHhuar6Gi9cdhjViJs8soL
         p+XTqU03rL3YUinttkeuwhvYDBYndftcQ1lb6JrayJWYaz767kT/7uSSqq4z3wDgWKw+
         tCNTZSbGkmHX0fdlTrrajQTQQ+ehAOD3ixMlGtJOJZMGY3XhMabTvcLIbIQa4rkvjvSJ
         fF9QmOj1dIRwAygKMwVXWm7oCmSnhZ3H4xNrRzbzfngxmnrYSIJAjlQScDmvXgIpDU55
         q9P5MI6BOq/HOO6RjNFwOhFij/cUQzMCamgQLxaDNE0Va6Uhysi7kn5GAc/x2beLnm5s
         Fytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740607462; x=1741212262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTcDz5+Yk2Rd6PndDa6YwrNqhNuGseEibA7R+3Q+jN0=;
        b=h186CyIv07iFn3zWOXD0LeoYGLWFRqs0tMXn69GQZeg2rv1bbEO6a14oYEam8osOOw
         HYPraTY2sRKQR7IeE/MV7oc6eeJs+tyWSM0lkuWnFV8XIpCEZTzQvxC3VWaSYyJjJ8JF
         2VcL7Pcwxd40aNZKufZmx/UmjZ8v+p1oHDeqeU4Fl1IeNOQEIw9k8Bbfw6SXldnCPMvR
         3HSgZxSSKpgX53cqZbvqQhqiMenp/xjBkM35T8XlImIUjC46jpnoxzGZLFbGqfcdXcRE
         70+JwLkAUQlxmU2Mmbi9wMu+Yk2vdQS0/Tu2TpsfqC/zMBnjWCwcMsnL+GVnWRydJKuc
         O+Rg==
X-Forwarded-Encrypted: i=1; AJvYcCVUStNIcZYyfTk5L31fhsYazpqNKsbCEKCwplwvaR3Of7Kip6PwrfH92/b4qtwQLZ9IgTtS7xXmFIrVBJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNw2FoO4UtGGS79lsWfFHR1yanpQet+ZwS8mVb2oMKdMNNy2V+
	EE/NoXe/SvaPgAxf56ImaSJWsMga/6hkgV84gorW/lZineqGKdhAcbu51Bzdm3o=
X-Gm-Gg: ASbGncvChol1ASYMKi8+MIhYgl15N0JuIN9Z6Zx+BCmb9ZleHOSE+uMVAcH8VZ7gK7h
	/dpAQsphgn2HvJdCwrApQ3W05IBTd5JwD4zQVVtQwIN5iENwPlQ2TRzrJs1CJXb5gZR93QcUSiy
	uQbejHiokOzhgIlwH6MeimUDRA8hUwG6kSipwX1HgVsdeptDLeWn31Zg9TuZN9OSRVco1eotXwB
	15BYuNaSOfWcMZ763IIRvUL80Seviozvv3MMAJg5zVI96+LdO3G/F9TF9HI0gkmJ4/p1RjFzUZL
	m6N+QrN6T4q7birVK/SBCa8MW9a2pb1y7xswi5jSQ70+m+PWahruu3GO
X-Google-Smtp-Source: AGHT+IGveFL5jaPvmaU/Mebx9uyRVH5JU7x/sn/aSccHmWkURMmnvFmqMMw5M5iqYS+8/nz1Dtqa6w==
X-Received: by 2002:a17:902:dac3:b0:221:133:fcfb with SMTP id d9443c01a7336-22307b4bbcemr129932265ad.20.1740607462686;
        Wed, 26 Feb 2025 14:04:22 -0800 (PST)
Received: from gpeter-l.roam.corp.google.com ([104.134.203.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22350534004sm1044145ad.252.2025.02.26.14.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 14:04:22 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
To: alim.akhtar@samsung.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	krzk@kernel.org
Cc: linux-scsi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	willmcvicker@google.com,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	ebiggers@kernel.org,
	bvanassche@acm.org,
	kernel-team@android.com,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH 1/6] scsi: ufs: exynos: ensure pre_link() executes before exynos_ufs_phy_init()
Date: Wed, 26 Feb 2025 22:04:09 +0000
Message-ID: <20250226220414.343659-2-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To: <20250226220414.343659-1-peter.griffin@linaro.org>
References: <20250226220414.343659-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure clocks are enabled before configuring unipro. Additionally move the
pre_link() hook before the exynos_ufs_phy_init() calls. This means the
register write sequence  more closely resembles the ordering of the
downstream driver.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/ufs/host/ufs-exynos.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index 13dd5dfc03eb..cd750786187c 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -1049,9 +1049,14 @@ static int exynos_ufs_pre_link(struct ufs_hba *hba)
 	exynos_ufs_config_intr(ufs, DFES_DEF_L4_ERRS, UNIPRO_L4);
 	exynos_ufs_set_unipro_pclk_div(ufs);
 
+	exynos_ufs_setup_clocks(hba, true, PRE_CHANGE);
+
 	/* unipro */
 	exynos_ufs_config_unipro(ufs);
 
+	if (ufs->drv_data->pre_link)
+		ufs->drv_data->pre_link(ufs);
+
 	/* m-phy */
 	exynos_ufs_phy_init(ufs);
 	if (!(ufs->opts & EXYNOS_UFS_OPT_SKIP_CONFIG_PHY_ATTR)) {
@@ -1059,11 +1064,6 @@ static int exynos_ufs_pre_link(struct ufs_hba *hba)
 		exynos_ufs_config_phy_cap_attr(ufs);
 	}
 
-	exynos_ufs_setup_clocks(hba, true, PRE_CHANGE);
-
-	if (ufs->drv_data->pre_link)
-		ufs->drv_data->pre_link(ufs);
-
 	return 0;
 }
 
-- 
2.48.1.658.g4767266eb4-goog


