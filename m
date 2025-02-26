Return-Path: <linux-kernel+bounces-533750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D34B1A45E32
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E63165133
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592FC2288C6;
	Wed, 26 Feb 2025 12:03:56 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A93121E0BC
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571435; cv=none; b=D6w1eFYVkBeDKwLf4urtlWUPQ8tiTQNJERCLvQuTAYjZjDhYbXNRL2CzWoFIfsd9uMftMBlxfcgmFMFWsyVoWcacAbVSWwftilzXel6oYxe5PcJQ9b8ttufM4UkGhRD0A9EtHT4dTJAn9mjsPPzQW1bKfBWoohj8hUXp91SknEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571435; c=relaxed/simple;
	bh=Vwp99XxRJBTsY2i28F+NTszaztRN+RM2Xhxj+1WZcz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=VxuaPuQ6/+BZ9rYzNT2wLJVdGnNe+fxZqiI70Q9cKGBCnAWHraXW0HtPjGfTcYiCGI7FdeBGmzkr2o6Q41QWdC1LHldJ8c9Bl8VhYBNdJILstf36wPjSwfDOLUkX3Kx4pYkr2Gnymr4/v+0HOwraNAWk/Gw5EPC0DE1X+fflfVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-38-67bf0322651c
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	vernhao@tencent.com,
	mgorman@techsingularity.net,
	hughd@google.com,
	willy@infradead.org,
	david@redhat.com,
	peterz@infradead.org,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	rjgolo@gmail.com
Subject: [RFC PATCH v12 based on v6.14-rc4 14/25] mm/rmap: recognize read-only tlb entries during batched tlb flush
Date: Wed, 26 Feb 2025 21:03:25 +0900
Message-Id: <20250226120336.29565-14-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120336.29565-1-byungchul@sk.com>
References: <20250226113024.GA1935@system.software.com>
 <20250226120336.29565-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsXC9ZZnoa4y8/50g0OiFnPWr2Gz+LzhH5vF
	1/W/mC2efupjsbi8aw6bxb01/1ktzu9ay2qxY+k+JotLBxYwWRzvPcBkMf/eZzaLzZumMlsc
	nzKV0eL3jzlsDnwe31v7WDx2zrrL7rFgU6nH5hVaHptWdbJ5bPo0id3j3blz7B4nZvxm8Xi/
	7yqbx9Zfdh6NU6+xeXzeJBfAE8Vlk5Kak1mWWqRvl8CV8WThU5aCk2IV2z+3szcwvhDqYuTk
	kBAwkZj0pI8Fxr73vY8dxGYTUJe4ceMnM4gtImAmcbD1D1Cci4NZYBmTxN4TDWwgCWGBYomL
	PxrAmlkEVCWarrxm6mLk4OAFavj90Q5iprzE6g0HwOZwAoU/TTsG1iokkCyx8/cfJpCZEgK3
	2SRW9k5ih2iQlDi44gbLBEbeBYwMqxiFMvPKchMzc0z0MirzMiv0kvNzNzECQ3pZ7Z/oHYyf
	LgQfYhTgYFTi4X1wZm+6EGtiWXFl7iFGCQ5mJRFezsw96UK8KYmVValF+fFFpTmpxYcYpTlY
	lMR5jb6VpwgJpCeWpGanphakFsFkmTg4pRoYk3snaE1vrrgZpbz4y7S/uTJhisf/sywqC756
	Onvdua8rZZ+K5jbE+7NMO5BcPunh+tjXG+0li+caKLe8cdnzonlaBaP+y82l55YfvKTOu/Ew
	32qPa5emBW//w3f2QJbDzxBT+baXqxabRiuFzygN7zd93sY/609Q9vdPbXtFlp+w3eXfWM7V
	osRSnJFoqMVcVJwIAG1cVZtlAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsXC5WfdrKvEvD/dYO8VE4s569ewWXze8I/N
	4uv6X8wWTz/1sVgcnnuS1eLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHG89wCTxfx7n9ks
	Nm+aymxxfMpURovfP+awOfB7fG/tY/HYOesuu8eCTaUem1doeWxa1cnmsenTJHaPd+fOsXuc
	mPGbxeP9vqtsHotffGDy2PrLzqNx6jU2j8+b5AJ4o7hsUlJzMstSi/TtErgynix8ylJwUqxi
	++d29gbGF0JdjJwcEgImEve+97GD2GwC6hI3bvxkBrFFBMwkDrb+AYpzcTALLGOS2HuigQ0k
	ISxQLHHxRwMLiM0ioCrRdOU1UxcjBwcvUMPvj3YQM+UlVm84ADaHEyj8adoxsFYhgWSJnb//
	ME1g5FrAyLCKUSQzryw3MTPHVK84O6MyL7NCLzk/dxMjMESX1f6ZuIPxy2X3Q4wCHIxKPLwP
	zuxNF2JNLCuuzD3EKMHBrCTCy5m5J12INyWxsiq1KD++qDQntfgQozQHi5I4r1d4aoKQQHpi
	SWp2ampBahFMlomDU6qBkeHtTas1d5snJTxrF8r+1NFylKNxrvaSF8zMYTy2a67s3xTJvS6v
	0TDY0fDB+iClZJ+CKfMvcRxvu2Izz+VazBrl3WaX1hff5y+fefxDwJ03S1XyH00oeZ/u5NHM
	zcAgsS9toiWXKOvarjn+W7d2t5+Me+Nwycnp3QeR67Kx/v/4dI6cMZz8V4mlOCPRUIu5qDgR
	AGTi/ZhNAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Functionally, no change.  This is a preparation for luf mechanism that
requires to recognize read-only tlb entries and handle them in a
different way.  The newly introduced API in this patch, fold_ubc(), will
be used by luf mechanism.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/sched.h |  1 +
 mm/rmap.c             | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index a3049ea5b3ad3..d1a3c97491ff2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1407,6 +1407,7 @@ struct task_struct {
 
 	struct tlbflush_unmap_batch	tlb_ubc;
 	struct tlbflush_unmap_batch	tlb_ubc_takeoff;
+	struct tlbflush_unmap_batch	tlb_ubc_ro;
 
 	/* Cache last used pipe for splice(): */
 	struct pipe_inode_info		*splice_pipe;
diff --git a/mm/rmap.c b/mm/rmap.c
index 1581b1a00f974..3ed6234dd777e 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -775,6 +775,7 @@ void fold_luf_batch(struct luf_batch *dst, struct luf_batch *src)
 void try_to_unmap_flush_takeoff(void)
 {
 	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	struct tlbflush_unmap_batch *tlb_ubc_ro = &current->tlb_ubc_ro;
 	struct tlbflush_unmap_batch *tlb_ubc_takeoff = &current->tlb_ubc_takeoff;
 
 	if (!tlb_ubc_takeoff->flush_required)
@@ -789,6 +790,9 @@ void try_to_unmap_flush_takeoff(void)
 	if (arch_tlbbatch_done(&tlb_ubc->arch, &tlb_ubc_takeoff->arch))
 		reset_batch(tlb_ubc);
 
+	if (arch_tlbbatch_done(&tlb_ubc_ro->arch, &tlb_ubc_takeoff->arch))
+		reset_batch(tlb_ubc_ro);
+
 	reset_batch(tlb_ubc_takeoff);
 }
 
@@ -801,7 +805,9 @@ void try_to_unmap_flush_takeoff(void)
 void try_to_unmap_flush(void)
 {
 	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	struct tlbflush_unmap_batch *tlb_ubc_ro = &current->tlb_ubc_ro;
 
+	fold_batch(tlb_ubc, tlb_ubc_ro, true);
 	if (!tlb_ubc->flush_required)
 		return;
 
@@ -813,8 +819,9 @@ void try_to_unmap_flush(void)
 void try_to_unmap_flush_dirty(void)
 {
 	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	struct tlbflush_unmap_batch *tlb_ubc_ro = &current->tlb_ubc_ro;
 
-	if (tlb_ubc->writable)
+	if (tlb_ubc->writable || tlb_ubc_ro->writable)
 		try_to_unmap_flush();
 }
 
@@ -831,13 +838,18 @@ void try_to_unmap_flush_dirty(void)
 static void set_tlb_ubc_flush_pending(struct mm_struct *mm, pte_t pteval,
 				      unsigned long uaddr)
 {
-	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	struct tlbflush_unmap_batch *tlb_ubc;
 	int batch;
 	bool writable = pte_dirty(pteval);
 
 	if (!pte_accessible(mm, pteval))
 		return;
 
+	if (pte_write(pteval))
+		tlb_ubc = &current->tlb_ubc;
+	else
+		tlb_ubc = &current->tlb_ubc_ro;
+
 	arch_tlbbatch_add_pending(&tlb_ubc->arch, mm, uaddr);
 	tlb_ubc->flush_required = true;
 
-- 
2.17.1


