Return-Path: <linux-kernel+bounces-351846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E859916D1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 14:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69A81C20E60
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 12:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B8414C5AF;
	Sat,  5 Oct 2024 12:38:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E341547FF
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728131925; cv=none; b=G798jhrbM5IGRaY4oPGxToSH18CfTRo/2ftSFD+N9RZa7EebBCisxfP0MQ+s9vuDOHYG8bLxNVSB+dUQqIxp734kNYjD+mXw3l65a1AS3OgBb/7d2j9CJ6OEdrUIpTQNSbiW26hrbwEYROW5ZVsxLiq2hXk4jUNQD4TDL50Rlps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728131925; c=relaxed/simple;
	bh=feAzXXC1edxnHlLjdNG5JUQhZRVL7SQv8APzcDLiaAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BxiEwcjSC/T1t1sOqmT1q7gCJ661+YraZwZNnliKUsVgEqMTYp9OJeRcCoyeYPcxeCqnh78kzfVs/CT+3Bx/Te92YEMOCSPnF7O4vBJqG66E8bzPpq7VRaC+UekHaHhLadZW997mn3IP5edgsUadRrNT0PEj0+h9PB0X/olNJHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B5071007;
	Sat,  5 Oct 2024 05:39:12 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.39.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 444DB3F64C;
	Sat,  5 Oct 2024 05:38:39 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] arm64/ptdump: Test PMD_TYPE_MASK for block mapping
Date: Sat,  5 Oct 2024 18:08:22 +0530
Message-Id: <20241005123824.1366397-4-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241005123824.1366397-1-anshuman.khandual@arm.com>
References: <20241005123824.1366397-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arm64 block mapping requires given page table entry's bits[1:0] to be "01".
But now only bit[1] is checked to be clear, while also implicitly assuming
bit[0] to be set. This modifies ptdump to check both the relevant bits via
the mask PMD_TYPE_MASK and check the resultant value against PMD_TYPE_MASK.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/ptdump.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 264c5f9b97d8..8cec0da4cff2 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -80,10 +80,10 @@ static const struct ptdump_prot_bits pte_bits[] = {
 		.set	= "CON",
 		.clear	= "   ",
 	}, {
-		.mask	= PTE_TABLE_BIT,
-		.val	= PTE_TABLE_BIT,
-		.set	= "   ",
-		.clear	= "BLK",
+		.mask	= PMD_TYPE_MASK,
+		.val	= PMD_TYPE_SECT,
+		.set	= "BLK",
+		.clear	= "   ",
 	}, {
 		.mask	= PTE_UXN,
 		.val	= PTE_UXN,
-- 
2.25.1


