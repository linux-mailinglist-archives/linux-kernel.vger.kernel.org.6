Return-Path: <linux-kernel+bounces-287867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DCD952D67
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 688EA1F25F48
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 11:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59FD7DA9F;
	Thu, 15 Aug 2024 11:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UUIfyvYr"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FD37DA7F
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 11:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723721112; cv=none; b=PZJMOXfvmhmmxGjUwRvw6KcRH2tcskl6hC3vcxIH0ZPZNGq8wa5dbq8IBNKdyrNrFq1siXe4ZVdh/WokEPPf4IbtpKTnQHqBb6eojQe58oIRkGIloBNlCHJ17L8/opE1aGydJ394VJorCQY05rfPDWHqzvjEtWHaD227/+KcdEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723721112; c=relaxed/simple;
	bh=lFo5gIFDvq0nCBY9vqftpLu+gTHD6YABYYNyYZUhWPg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=unVVdHKvG9sPEhyDekvFmpR8MmI8ttRwMlHOwTWDsQv9TOeFN6mfaTOJr0zxOz0CzDlK6dNOyM3b766Y0ipu9JB5XMqJ6cxSD4s6bdX8Alw5UCAJORa/P9bTOLSPyJ60f3CnQE+btfqSsufHgBT5liFNnt5CP89H2+Hu75uj0lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UUIfyvYr; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso1267179a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 04:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723721108; x=1724325908; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sJgccsMLKlvTr7kW7rYfi0K+07lJJOFz1A3IB6P2Qqs=;
        b=UUIfyvYrsE6q+q7OtagMyPLfJcAWaELhx+at2X0k+00LmoCsU4raacO+uj9L6nwtMB
         ENi7JCTaQ5lZahVNxn1bsg1xQeA1JC9czjzys3ZG479YcYQQKiECxYCdhEZLOcILHCTl
         zLq/9aYKJPFCEvRkabPo5K+lWJkh3Ei6uKYnEggBSQWiN02xAFANr8BnyBJj3rrb3/rR
         XBDMKt13ArvR+WrCAyR61kcqUI1YEL/uBp2/AALVTWNjRKbi9shsqHIq/t6P/FzfIinn
         irWfJhlsDV0bG8g1OEnEmnpoefyqjFypyV+WFZh8QkkML4j8o8AYOswEcRhws6t3wdEJ
         tXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723721108; x=1724325908;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJgccsMLKlvTr7kW7rYfi0K+07lJJOFz1A3IB6P2Qqs=;
        b=N13Y2CzAAhBFSK+BIlGMsFCj7JjH2Qy8LTQcf16JE9xEDl+0sB8W+ugZFK31TDeeEe
         0lo7gFI4RvBCfD38YB1h28mlYoJYa0yfa5hUQ6J0Zh50uUYabAeZUTASYZwsyxwM9HOV
         c83O+S/rGI0O0zlr/ZAZMIWow+e96XuKPAkOHm4jNURkfiETienOKVqj1lIzKwCewqMS
         CcoUb3Ravk5RAgicd4Aot7h7rAvRMY7zKgbIgdJx3S2DqEut9ak6dK87DCb1IRYogCc5
         r97/MjBhZzBmY+Te1nlcm9I3abWu3HmGI4RoPcubzFHcjvaETwBqy2lrC49zrIVbmkME
         y4AQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9bUtCmV+KJBBHHCu7yVnGGhSVVlEcdc+aJAjhq+s8t+DX2UheDI6dsJMvKHYkLD5ISKZdlYD13RqjbZqid7pL2hrhGOZeFhSxivs6
X-Gm-Message-State: AOJu0YwjMRG9V0tXyn0tG24+aMrlUiF3dj3bhFO9Ili3U4BoboTlo3zq
	GPf4X0GwPIm8onfjxQdV/scp8+f3n3TpBZkH3OYI2jx62lDrUJ0YSTHQOXP2bWg=
X-Google-Smtp-Source: AGHT+IHwCYaVWrDMM/XxSAgRaGSfa25IQdFx+8Hr+PoYjdMN7joZtfNCMY3zxeI7foru5gpy24rJbQ==
X-Received: by 2002:a05:6402:3227:b0:5be:bd48:e4ca with SMTP id 4fb4d7f45d1cf-5bebd48e74bmr1231063a12.26.1723721107693;
        Thu, 15 Aug 2024 04:25:07 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbde48fdsm769217a12.28.2024.08.15.04.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 04:25:07 -0700 (PDT)
Date: Thu, 15 Aug 2024 14:25:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Michael Shavit <mshavit@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iommu/arm-smmu-v3: Fix a NULL vs IS_ERR() check
Message-ID: <9208cd0d-8105-40df-93e9-bdcdf0d55eec@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The arm_smmu_domain_alloc() function returns error pointers on error.  It
doesn't return NULL.  Update the error checking to match.

Fixes: 52acd7d8a413 ("iommu/arm-smmu-v3: Add support for domain_alloc_user fn")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9bc50bded5af..cf21d7d2e737 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3062,8 +3062,8 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
 		return ERR_PTR(-EOPNOTSUPP);
 
 	smmu_domain = arm_smmu_domain_alloc();
-	if (!smmu_domain)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(smmu_domain))
+		return ERR_CAST(smmu_domain);
 
 	smmu_domain->domain.type = IOMMU_DOMAIN_UNMANAGED;
 	smmu_domain->domain.ops = arm_smmu_ops.default_domain_ops;
-- 
2.43.0


