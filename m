Return-Path: <linux-kernel+bounces-547466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CD8A5096F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15383160F47
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0275B257AFA;
	Wed,  5 Mar 2025 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjwJEMeK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FDD257ADE
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 18:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198598; cv=none; b=psz9PQIskrK2UlrNYX3EcCNaqLoH0Z+WbHLphiEY8a17dnK54ZAQO6oe7Knils3HRsMPtJZrfTvj4M8OyExC8v85AAMhF2wWiy/LMoX/ElDjotkue3cnfo43u2BRhjf/mk87deui/CbfT5fYiK9hX9pEH1SPEFcxwhvK1Yyc3Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198598; c=relaxed/simple;
	bh=iyzH21UhzYqd7Tqlxj4XxNbXqpQgjQqkRv0b1OdLlb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VYMSGZB2dBbmVlKwyQ0LkZTTHM/0L2agAJzGbFSw3Bpj861xHeM3noK/Y2Vxcie+DNYMsZJNmeE1vrMlEIdSMm5t9TJq/l7dPgtTg1lPIDd604hzvdxAiVlyEftEh8XVmSjmON2JLXCEqaZ4EZ8jpy2/LTQvPdxtT2Cp9ylHO70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjwJEMeK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F21FC4CED1;
	Wed,  5 Mar 2025 18:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741198598;
	bh=iyzH21UhzYqd7Tqlxj4XxNbXqpQgjQqkRv0b1OdLlb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WjwJEMeKovsett4/AR6x8oSEwzZnyBpsSPqAC5hvWjTXEPikGH4plKyr4a5j+irB2
	 kMkvzQV4rLf8MeNCGskmt4fnZSi0E/+ukl9CWU9VR7MNLtGGRPtIp4pC8DV7O99qUs
	 ckSaJybTfvS50qC8CluLpozQzSUdtxe7VwJns/gpyd/WSidVLXrZ2je9ZuPfHzDdPY
	 vQnD/QTFu2Wk+G5Oa01nPcfR3tl1uZt4Da93DPNVG4+5cmfGgrpgDV18EGv9E5xKzF
	 ctBPkLmdrMp/kdrWE5sIUtOPiLvuAGSUpjwMFy9BZNiWihXtc+nEUWp2v71GSjP3Zj
	 C+ErJUXLmDFcA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <howlett@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 16/16] mm/madvise: remove !caller_tlb case of madvise_free_single_vma()
Date: Wed,  5 Mar 2025 10:16:11 -0800
Message-Id: <20250305181611.54484-17-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250305181611.54484-1-sj@kernel.org>
References: <20250305181611.54484-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

madvise_free_single_vma() supports both batched tlb flushes and
unbatched tlb flushes use cases depending on received tlb parameter's
value.  Both were supported for safe and fine transition of the usages
from the unbatched flushed to the batched ones.  Now the transition is
done, and therefore there is no real unbatched tlb flushes use case.
Remove the code for supporting the no more being used input case.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/madvise.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 1dd2c25c83d8..03ba5ff0cf9b 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -795,18 +795,11 @@ static const struct mm_walk_ops madvise_free_walk_ops = {
 };
 
 static int madvise_free_single_vma(
-		struct mmu_gather *caller_tlb, struct vm_area_struct *vma,
+		struct mmu_gather *tlb, struct vm_area_struct *vma,
 		unsigned long start_addr, unsigned long end_addr)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct mmu_notifier_range range;
-	struct mmu_gather self_tlb;
-	struct mmu_gather *tlb;
-
-	if (caller_tlb)
-		tlb = caller_tlb;
-	else
-		tlb = &self_tlb;
 
 	/* MADV_FREE works for only anon vma at the moment */
 	if (!vma_is_anonymous(vma))
@@ -822,8 +815,6 @@ static int madvise_free_single_vma(
 				range.start, range.end);
 
 	lru_add_drain();
-	if (!caller_tlb)
-		tlb_gather_mmu(tlb, mm);
 	update_hiwater_rss(mm);
 
 	mmu_notifier_invalidate_range_start(&range);
@@ -832,9 +823,6 @@ static int madvise_free_single_vma(
 			&madvise_free_walk_ops, tlb);
 	tlb_end_vma(tlb, vma);
 	mmu_notifier_invalidate_range_end(&range);
-	if (!caller_tlb)
-		tlb_finish_mmu(tlb);
-
 	return 0;
 }
 
-- 
2.39.5

