Return-Path: <linux-kernel+bounces-201256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A798FBBE4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 20:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4791282F78
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D497114A4FC;
	Tue,  4 Jun 2024 18:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DqGE2Mcu"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25874A11
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 18:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717527144; cv=none; b=Ug4cMpyqHDUrJa8GAFlAJelfYpyDRnpQa4g6ntTb3qEHMlq/nGeRqTptj4MrBhHd7ptG2Di2sqprALs7RMmRpeOW9F8mc9Mu5nNaBCmF8sPgJbIZV6BKqERGxeZ/bIxhQtPhuqaKqghBT0WT9L5DJEq+H+Z6uxII67o7hoHqmY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717527144; c=relaxed/simple;
	bh=diY4ZIMY6aWi1bFAy/EtmF9RZKTt4zuEne9BTdbHYFQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=H1lW7wz4JqKFaSl7kMKNHhEFi4QgM29Oem0B4TQ3C5HacGELffTCj1UXJ3UfEG5RTtFh6NjxPw5RsvlQ43GCDyk8tVecm5Jprt5//oaG8yqR2h6jY0rfIVtbpzKSu8smRWcpa5JFrvOcTjcznpTY3P4e4nSrT2jMNkYwVLjoRfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DqGE2Mcu; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62a3dec382eso1919037b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 11:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717527142; x=1718131942; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QinZc84Ac+qY0luma+PGFDFARquLnMN+4RLVb93myYU=;
        b=DqGE2McuS0Zyn7gcJjesuunR9hTiSZcPrFoPTAFvR8UBALaAfqXbV8Xh0SKwZgmt3f
         lIsSogSVK+7iwczOPGtx6xepjE8AjD4RonYTA+ZxMTyB57wPXX7vP05XKZudK0wdq+fS
         M2tg04Ptkr1sYHYXmDkZWW5Pgt4nNoeHAWOzSGppIN4qpOeAIhD/U8CeK0PuZaalUP95
         UUROmrVnREual0Y9HNo1BD8NYNydEaY7vmpGb8LZKoIkwBvPNgavRlvJ28yFJkTv2Vfw
         5U+MZONj5/Z0BQ8XlzgA0DlFyzprILnmgjwe4vge4o8GJVPz8i98cHPRSRa2Pt/izmYf
         8qcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717527142; x=1718131942;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QinZc84Ac+qY0luma+PGFDFARquLnMN+4RLVb93myYU=;
        b=LU7A4vLRuKhUL43iUKS2wcb29oR4qBSUfuhlvsS1r5fZ1ESTAj/wo9k84RKa6Uc1vS
         zgLSf4kM1ddfh1uJvK78STVL4dGbJnzclbM+QnTmtg1D2I7ISoNkEiZ4IrSKCs6oY6kk
         fzaGuVfVKVc9Vp6CFzfPssgFGU4FNEDLxsy2he2kdwOlR05rKIRbkE/rRNVDTYGfo5X1
         XEdwyXQC856yvTBivDD+jxANc824HOXFUoVBOibodU8LeZ3AKAfFpnfSIU5RzJx+yJRW
         hFaaU/H7sbJ+pRHYCG47hhVEXp4nmpn3wNfLA4RYOXe6tJSuCD3sxp60HnjxBICzstNj
         I1/g==
X-Gm-Message-State: AOJu0YwumGsnsLhEi4q6kWFWs1N3pwiKnvZsT/wOIpybw0/RP512H4jp
	NovOT3et1KtHLewKc3tw2l54PKTEimC69PXIwYm2icG/oSAZnFjx9ZHK7dIinBSyJ7JRkGLBQGX
	+vfIcrEmo1g==
X-Google-Smtp-Source: AGHT+IFBDAGlNKpuJe3KrEo6TBkztIdrl3oKDL7VgzxoduDyeuFK/R22rAhIGO60kwUm3nKcI1m8ohqSfRf3gg==
X-Received: from mostafa.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a81:4014:0:b0:627:de82:8077 with SMTP id
 00721157ae682-62cabc78cd1mr7092087b3.2.1717527141788; Tue, 04 Jun 2024
 11:52:21 -0700 (PDT)
Date: Tue,  4 Jun 2024 18:52:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240604185218.2602058-1-smostafa@google.com>
Subject: [PATCH] iommu/arm-smmu-v3: Avoid uninitialized asid in case of error
From: Mostafa Saleh <smostafa@google.com>
To: will@kernel.org, robin.murphy@arm.com, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, joro@8bytes.org, jgg@nvidia.com, 
	nicolinc@nvidia.com, mshavit@google.com, Mostafa Saleh <smostafa@google.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Static checker is complaining about the ASID possibly set uninitialized.
This only happens in case of error and this value would be ignored anyway.

A simple fix would be just to initialize the local variable to zero,
this path will only be reached on the first attach to a domain where
the CD is already initialized to zero.
This avoids having to bloat the function with an error path.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes:https://lore.kernel.org/linux-iommu/849e3d77-0a3c-43c4-878d-a0e061c8cd61@moroto.mountain/T/#u
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ab415e107054..f456bcf1890b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2302,7 +2302,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_device *smmu,
 				       struct arm_smmu_domain *smmu_domain)
 {
 	int ret;
-	u32 asid;
+	u32 asid = 0;
 	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
 
 	refcount_set(&cd->refs, 1);
-- 
2.45.1.288.g0e0cd299f1-goog


