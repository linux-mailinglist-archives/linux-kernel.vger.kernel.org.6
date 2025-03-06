Return-Path: <linux-kernel+bounces-549145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F27A54E07
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A79B189710C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060DB170A23;
	Thu,  6 Mar 2025 14:43:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264E314E2C2
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 14:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741272207; cv=none; b=N49CMrXd1V5xn3zqZ4pqnVpDpk5kJquha9TrV6K+KgtivD+xbGtEBvWZ40Tqq1Kl/g8GkNNowr0LhwOfkDqEjTRzmRirJtltxg5kSSBurSEC1ySSh/c57NvJQUmMbM2lexnC8dsGROrJXArJlslm7dXt5vgJkUo/8tTWdP9LZ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741272207; c=relaxed/simple;
	bh=ILufMqgLSyTTngGbGoAEDfWP1P1NsLYFhxht7EcYbDY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mkE5l6DLHpoOMJaMdJ2VkT51j2Pqnm/HmO9sF3tt0k8SjK4rc9dVnC8MctSN01PnKywRwXmHNyRIXvU7J0V7iXus6r6Rm2cjsbePgEWinreVrTCls3nZ8pdcP16nH6MvuyvziihTCDhse/ZOXvlWUMKZAHeIpitKMX1pIADuCto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F3AC1007;
	Thu,  6 Mar 2025 06:43:38 -0800 (PST)
Received: from K4MQJ0H1H2.arm.com (unknown [10.174.36.159])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A410B3F66E;
	Thu,  6 Mar 2025 06:43:22 -0800 (PST)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: ryan.roberts@arm.com,
	david@redhat.com,
	willy@infradead.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH] mm: Remove redundant return in set_huge_zero_folio()
Date: Thu,  6 Mar 2025 20:13:15 +0530
Message-Id: <20250306144315.21907-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is the responsibility of the caller to check pmd_none(); in any case,
we are not achieving anything by returning since there is no return value
to tell the caller that we succeeded or not. So remove this check.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/huge_memory.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3d3ebdc002d5..f64212d674fd 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1309,8 +1309,6 @@ static void set_huge_zero_folio(pgtable_t pgtable, struct mm_struct *mm,
 		struct folio *zero_folio)
 {
 	pmd_t entry;
-	if (!pmd_none(*pmd))
-		return;
 	entry = mk_pmd(&zero_folio->page, vma->vm_page_prot);
 	entry = pmd_mkhuge(entry);
 	pgtable_trans_huge_deposit(mm, pmd, pgtable);
-- 
2.30.2


