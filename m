Return-Path: <linux-kernel+bounces-346915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F151498CB00
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 03:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AD6228609D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 01:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA1D1FBA;
	Wed,  2 Oct 2024 01:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JJTrTPLr"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630F823AD
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 01:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727834042; cv=none; b=QwbNnU9qQB0uDmY3G6tYaayUp/urK/ad3FM7aG+1sx8Ms2rtUteywOq7bStToIrBSN6tXiGlT2taDUH4AS1zTClmIJ/4LL+6ekvbUT1MJ+Pzf2EW6FgrxI0vG8gSAdStAIpq8Mu6AecLpsc03lZiM+VfIfmEn5FIJ0B79tELUSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727834042; c=relaxed/simple;
	bh=iPmQ53/8uwlzl108KEIavw7gfZhKpeC9rw9spHywT/M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GfPPo0L4afLaVMSbvNgDvy4+ip+E4qIB1EcG/jRWL+EGCuqYP3huLDQbvRH9GGI0rQ94s5p0D6FFEBwSD9ZKlKJbMldC7UANycGiyiSkB+TRCHNzzPuSQdVkSlNNvNvXba2egyWso8ZuFyZl6UWYTCFqA/hCtmrzhsTWRZtnhjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--danielmentz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JJTrTPLr; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--danielmentz.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e28b624fc6so38063397b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 18:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727834040; x=1728438840; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xwNwLD5VPrrbmrHEO02rJObyH9FboBGpkB8LL0CUjZ4=;
        b=JJTrTPLrTj3RBB1fRhxsEtGd2w3T6RhOofkcZTgHSO3tVk/RdhxdG9HAq1hPtYPet/
         Dh8MOEeAxgO3+lEGzBvqZMsI5QodpdpvKg/VH98JMb2pEKOocl6v4v7YbCp7HBxLTgO0
         0bCkXr1h3643g6xXoLMDt7aZ91ddNtf0m+eC+kckS/+2ZuOHS2Hbwb7vqIt8t0+39vZJ
         9pAr7V9g2cojJfo81pL2nnknuxtvPxx3VgRTHghN0uzHwwWdu9iM2JOvd8jxSaNyrESp
         wdZxhaIJl2IhsvLTwKcAS2K4IEr/uvSaGGyFAxeMYv/agtLWJEf8KqCEyt3MsR85TsW5
         Sy7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727834040; x=1728438840;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xwNwLD5VPrrbmrHEO02rJObyH9FboBGpkB8LL0CUjZ4=;
        b=ivecjvv9u1lo+bPngw3G0ylHVTLliJCDvVUQkiMAFoc+KA2Ftz8pWdSv6L7cPEpu5Z
         4spQ71IfO0WPCRMXCM82EU7s+IPbTomM1PObmkbnlxArmH21lrsQ3qo4nP0p/4+QSR/Z
         KU6DrDGZAWG7eoO8eQIF05nCIjCT8dADKgkmi6HV6BmN6r2Rcjae7OS/Hxql+wOoR6yb
         Ifboxg4g8HPW1MdN8uDL6X6djwVGkgTpgqonPCNc/u2siIa5BrgTb9BzAIZBA2IWhxMr
         u6mYgSSFm4cSYZlsiW4VfcZtur8MFCKho6mCpypCypDGFDWIuJvIbvJJYLPwrHZySqbV
         kRqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIikuQI//921XXGA2VtegSEkLIu2K0dMZXHAdFEw5KEPR5Iyp6vaKoPO93k60HRizAup4ihNit1SQSzM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn5chQGfbOCoxfG8JAgkMdRyeS2GiMt+GI+OvFswWrf9OlJ13x
	SpzGH0JWk0XH+WPZzXhS5iwPNU2NdGmgoVOSnoNOQ66hdTf3r/j7ZdiAp3+KHzt9kmE+grSgLcj
	D990VdIlUjy063PenTCjnQw==
X-Google-Smtp-Source: AGHT+IEreRxj3UJ+eyKPDi6Sf4q3fIvXsjlvsCIK555j7t8s/9KSqq6Ritz7lEozWnEFR990rByVwRgkzbJfngDmfw==
X-Received: from danielmentz2.mtv.corp.google.com ([2620:15c:72:202:bd57:7475:38c3:b469])
 (user=danielmentz job=sendgmr) by 2002:a05:690c:7090:b0:6e2:1ab6:699a with
 SMTP id 00721157ae682-6e2a3064928mr211467b3.7.1727834040420; Tue, 01 Oct 2024
 18:54:00 -0700 (PDT)
Date: Tue,  1 Oct 2024 18:53:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20241002015357.1766934-1-danielmentz@google.com>
Subject: [PATCH] iommu/arm-smmu-v3: Fix last_sid_idx calculation for sid_bits==32
From: Daniel Mentz <danielmentz@google.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, Ryan Huang <tzukui@google.com>, 
	Will Deacon <will@kernel.org>, Mostafa Saleh <smostafa@google.com>, 
	Daniel Mentz <danielmentz@google.com>
Content-Type: text/plain; charset="UTF-8"

The function arm_smmu_init_strtab_2lvl uses the expression

((1 << smmu->sid_bits) - 1)

to calculate the largest StreamID value. However, this fails for the
maximum allowed value of SMMU_IDR1.SIDSIZE which is 32. The C standard
states:

"If the value of the right operand is negative or is greater than or
equal to the width of the promoted left operand, the behavior is
undefined."

With smmu->sid_bits being 32, the prerequisites for undefined behavior
are met.  We observed that the value of (1 << 32) is 1 and not 0 as we
initially expected.

Similar bit shift operations in arm_smmu_init_strtab_linear seem to not
be affected, because it appears to be unlikely for an SMMU to have
SMMU_IDR1.SIDSIZE set to 32 but then not support 2-level Stream tables

This issue was found by Ryan Huang <tzukui@google.com> on our team.

Fixes: ce410410f1a7 ("iommu/arm-smmu-v3: Add arm_smmu_strtab_l1/2_idx()")
Signed-off-by: Daniel Mentz <danielmentz@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 737c5b882355..b55327d6058e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3625,7 +3625,7 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
 	u32 l1size;
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
 	unsigned int last_sid_idx =
-		arm_smmu_strtab_l1_idx((1 << smmu->sid_bits) - 1);
+		arm_smmu_strtab_l1_idx((1ULL << smmu->sid_bits) - 1);
 
 	/* Calculate the L1 size, capped to the SIDSIZE. */
 	cfg->l2.num_l1_ents = min(last_sid_idx + 1, STRTAB_MAX_L1_ENTRIES);
-- 
2.46.1.824.gd892dcdcdd-goog


