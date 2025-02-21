Return-Path: <linux-kernel+bounces-525167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA11AA3EBEE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 05:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5BB13AA71E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 04:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC3E1FBE8C;
	Fri, 21 Feb 2025 04:42:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7801E5739
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 04:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740112967; cv=none; b=kdnU7P4Galkn5mRm2mPwfunms/RztuC9m6cHFpE+5S3AM3tfN+c+/ZE1zdB4vfVXxsGBxGx19KV1iUbm4F3j79wvXxamwhpReU83Ubc+r5TBxE4WZ5zXpW3Fbd5gIbPtCW6R0miIvTiDGsyymHr2y0HIQZMZSb/y/IJDyhVDoZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740112967; c=relaxed/simple;
	bh=IMsivwxnTz2kUJzB7ajupk7X90MRaRxC9txhEy2nBng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j58T/ip7hj+BNCtHT7noSr0RkDCkDdEw3YOAHBglG+CLJoUt2l+2cFpgqdhF6dCa5TuI68yRLKMsnQYn61PfhM03giB+AY5rtnBLcmjx9QoHVcdHF3fY8HiH9peySwXPy9CQ4YHqefVMYG6vm/BAXFaoattknYnzHGlg3o5MWz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48B7D1C01;
	Thu, 20 Feb 2025 20:43:03 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.40.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D29CF3F6A8;
	Thu, 20 Feb 2025 20:42:40 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/8] KVM: arm64: ptdump: Test PMD_TYPE_MASK for block mapping
Date: Fri, 21 Feb 2025 10:12:20 +0530
Message-Id: <20250221044227.1145393-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250221044227.1145393-1-anshuman.khandual@arm.com>
References: <20250221044227.1145393-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test given page table entries against PMD_TYPE_SECT on PMD_TYPE_MASK mask
bits for identifying block mappings in stage 2 page tables.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: James Morse <james.morse@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/kvm/ptdump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
index e4a342e903e2..098416d7e5c2 100644
--- a/arch/arm64/kvm/ptdump.c
+++ b/arch/arm64/kvm/ptdump.c
@@ -52,8 +52,8 @@ static const struct ptdump_prot_bits stage2_pte_bits[] = {
 		.set	= "AF",
 		.clear	= "  ",
 	}, {
-		.mask	= PTE_TABLE_BIT | PTE_VALID,
-		.val	= PTE_VALID,
+		.mask	= PMD_TYPE_MASK,
+		.val	= PMD_TYPE_SECT,
 		.set	= "BLK",
 		.clear	= "   ",
 	},
-- 
2.25.1


