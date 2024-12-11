Return-Path: <linux-kernel+bounces-441580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCCF9ED055
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 266771883F1D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB6A1DED5A;
	Wed, 11 Dec 2024 15:46:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998991DE893
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733932018; cv=none; b=Y5OvRwREJ+q1557jeQGkBIn0x4Zvj8DuFcmsry8Rn0Am9sN2uYKiujgLUR2sDAUXkUcud1JSN0XnepjSKqs3f4yVBZGkZhL7dh4iWHikOxEZ7Co9rGsK/RIzHNdtTYTyu0HxzcNCuFNmfdhSXSaYswrsNKmKsnhnpJzxDTd1uqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733932018; c=relaxed/simple;
	bh=WNhpzgsdAKtSd1yhrheXVoze9Qh5uwyI4MdEQXOJRBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=up4Jt/p205rQ3sWgT+pck2hAqjg0yCZzoFnTJqpxdK992IfW45fDWNb8ousIbkJpFOkqQAwb+VvEGvz06Pf9IcpyaU6TgY/CT/okSBNBLRGGXUlGdbZFnilVl+6zgDr5x+9ufnK8PlU7SS4IRUO1GG7QMsJ3Rc2c9nQipkHZFuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79F5DFEC;
	Wed, 11 Dec 2024 07:47:24 -0800 (PST)
Received: from mazurka.cambridge.arm.com (mazurka.cambridge.arm.com [10.1.196.66])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5FD93F5A1;
	Wed, 11 Dec 2024 07:46:54 -0800 (PST)
From: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	corbet@lwn.net,
	maz@kernel.org,
	oliver.upton@linux.dev,
	joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com
Cc: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	liunx-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kvmarm@vger.kernel.org
Subject: [RFC PATCH v1 5/5] arm64/mm: Elide tlbi in contpte_convert() under BBML2
Date: Wed, 11 Dec 2024 15:45:06 +0000
Message-ID: <20241211154611.40395-6-miko.lenczewski@arm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241211154611.40395-1-miko.lenczewski@arm.com>
References: <20241211154611.40395-1-miko.lenczewski@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If we support BBM level 2, we can potentially avoid an intermediate
TLB invalidation, as hardware is capable of managing the TLB itself
in this situation. Hardware will either silently clear out the
offending entry, or will take a TLB Conflict Abort Exception.

Note that such aborts should not occur on Arm hardware and indeed
were not seen on any of the benchmarked systems.

Eliding the invalidation results in a 12% improvement on a
microbenchmark which targeted the worst case of contpte_convert(), which
represents an 80% reduction in the overhead of contpte_convert().

Note also that this patch is pending review to ensure that it is
architecturally valid, and we are working with Arm architects to
validate this patch.

Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
---
 arch/arm64/mm/contpte.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
index fc927be800ee..009690770415 100644
--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -72,9 +72,6 @@ static void contpte_convert(struct mm_struct *mm, unsigned long addr,
 		__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
 
 	__set_ptes(mm, start_addr, start_ptep, pte, CONT_PTES);
-
-	if (system_supports_bbml2())
-		__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
 }
 
 void __contpte_try_fold(struct mm_struct *mm, unsigned long addr,
-- 
2.45.2


