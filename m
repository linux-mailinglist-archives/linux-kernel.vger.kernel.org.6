Return-Path: <linux-kernel+bounces-335185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD3997E259
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 17:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2EED280FC7
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 15:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAD914A85;
	Sun, 22 Sep 2024 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNk+MrNL"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFABB64A
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727020589; cv=none; b=fHUcg78sjERjc6gN7hJo81bcWwEvodyEHT1QcqAocww3t19tANKBWQwNVoAhe10IWJPzTVcxgAdnGbawHbdoecPCwas6cjf5nVhDTYUFYYOCj403Yhw+r9gQt15L1w7jZXt+cKPQpkwewJjU36JLvUlg34VpzgcKBQI48qoLrEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727020589; c=relaxed/simple;
	bh=6rAG2HbdPWUawnusuplf/qRvlrBiXGqt6AAJlCc1uOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oVtXNQnFw/uUSv77ZV5xIlw1mwDKkE5bFItrQKhVTmCmp8bcnE+0306SUbugT+yfxlIE8Bn6IIL/csgrePbMFYnB4IIgLE9JhV0l/+fDb8ArQnZ1ucTilzMufLrLFfvXVLIuoOeuTtm3z+9EVmqWVSeQZEJZF/A4Fxq7vHfis0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNk+MrNL; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2053f6b8201so31558345ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 08:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727020587; x=1727625387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/F7XfLo3ysA+PssKb5XpZBCohyL+HFkAA0NOY3jzaDw=;
        b=iNk+MrNLfL/k3D4vIR5J6DAKC/QTvtMdfNUBd2c8LnWdsRWrX8VKGgSrLbzBvO1dsu
         V6As7HmnuYjCOZ4Uk8iCD+SweaprFuI2nzbnwj44oMlnQ6Zd0cBbBZp38yMTdSviMXwl
         s/76NiYJyuSubfPVWY5m1RVyMW/7mZc2OhNYrttXVMwZyBa77ZAbZK2Nof9ylpyaNVFs
         Hw/Mg7inBcIlxFM0oBEkKsV8IgZbqgYXNBmriASQ560+dtv1AM7/9rjZeBObyKupWkG1
         nzqPwbVB4zCV5cv8XdvM7dNGi4CCnCC7JtEk5Vuu1roo5K6r/9jc1pkWQDgusbyFEiCb
         vyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727020587; x=1727625387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/F7XfLo3ysA+PssKb5XpZBCohyL+HFkAA0NOY3jzaDw=;
        b=Hj/2WNYYyf+IPFMpAGlGczZDX7ymD/B/zIdx+q4+RNSmtfhomk4k6NSbiWOHM7dVsF
         cYj9PvUk8Pe9RPBX6Yr2YewtrvhioQEe6Rx6tfz9J6bs94qUUTPAt2zL2JvldreTPK72
         2gsmK4GYWjVZkh6EZWZb3NgBimgECjW8X80xSFqwomSTBCEw/t7bZsCkJEzI3p0/MA6K
         /DrDHA8rYT/O9BcMaKa85csVNDYZR/U4dOU/11adRxM91mPXMexY08MOgtQveTCOkjl2
         YSxw0OLcewps5WvF8hALXdg181cH/XxAhe8zYZAHxxmLJSlCmSM7EjR/bFEcwt9hKRUx
         7SYw==
X-Forwarded-Encrypted: i=1; AJvYcCWSx5SH5DIY/R8TT7Cv4EkxGm0qSlQcs5HMsF2EZZAxX73s9KG+FhVqLXxZsTgmW34OJE9+xs3xOlW5/xQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu9kykHnLMPXfu06rA2kBQY47/KeBvALD/24XjdIYXCSf+McmV
	vnlqMl42omRtobXgT/BSFjYcPmLs5/TP9YwXL2bJvemeXw5sf5ZG
X-Google-Smtp-Source: AGHT+IFeIPn9oJi+TDTigduD/EWiuab7BSrpCBCtPwJUidQwjLEgVyoTM/MHjjnZYICgIzdFCb2Upw==
X-Received: by 2002:a17:902:e54c:b0:203:a046:c666 with SMTP id d9443c01a7336-208d97e4047mr111443625ad.3.1727020587317;
        Sun, 22 Sep 2024 08:56:27 -0700 (PDT)
Received: from ubuntu.worldlink.com.np ([27.34.65.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207947356d5sm120603445ad.273.2024.09.22.08.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 08:56:26 -0700 (PDT)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: will@kernel.org,
	robin.murphy@arm.com,
	joro@8bytes.org,
	baolu.lu@linux.intel.com
Cc: Dipendra Khadka <kdipendra88@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: iommu:  Replace null pointer check with IS_ERR in arm_smmu_domain_alloc_user()
Date: Sun, 22 Sep 2024 15:56:20 +0000
Message-ID: <20240922155621.49432-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The smatch reported following:
'''
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3065 arm_smmu_domain_alloc_user() warn: 'smmu_domain' is an error pointer or valid
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3068 arm_smmu_domain_alloc_user() error: 'smmu_domain' dereferencing possible ERR_PTR()
'''

The function arm_smmu_domain_alloc() handles the null pointer after
kzalloc and returns ERR_PTR(-ENOMEM).

Replacing condition check !smmu_domain with IS_ERR(smmu_domain) and
returning smmu_domain.

Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a31460f9f3d4..19c53c6f7578 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3062,8 +3062,8 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
 		return ERR_PTR(-EOPNOTSUPP);
 
 	smmu_domain = arm_smmu_domain_alloc();
-	if (!smmu_domain)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(smmu_domain))
+		return smmu_domain;
 
 	smmu_domain->domain.type = IOMMU_DOMAIN_UNMANAGED;
 	smmu_domain->domain.ops = arm_smmu_ops.default_domain_ops;
-- 
2.43.0


