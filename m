Return-Path: <linux-kernel+bounces-514700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00148A35A67
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0433A3AE0F6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0062724292B;
	Fri, 14 Feb 2025 09:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNoogOXb"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B42224503F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739525464; cv=none; b=m5Cr5ndPQiWlwb9+l1f6gmltEaup09w42WnffnT1CbEBK/UwakDGF/NpMMDfP5hj5Iz4PEqCdQvRy1ZzFgvP7qk1FqOR6q5eGh7NSvTfT7MfUlXIHjEPCMHP7Q3SMi31jmLnPgwIKASObPFq1y3NojToE9p0wxeAKj8B5uUj010=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739525464; c=relaxed/simple;
	bh=YCRxXNAYe3DfJds7stjMdX3OFgw4jtcQCjleCgsPRPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZK2GFuPJwhcP2IQkSq9ihbdOxtNs7ssLnKnvNsAEgVpx8l3bAzAy7bpwzpDL1q6T386T8wpxRan4tHlUfcei+pShF4AOJylbuSwvpH9K4Q7EWCwY5zCsPK+V86IcHqk2UKi+5CScW6G2X47neI6z7sl9HlfxwnwDoai290ZDQDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNoogOXb; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220d132f16dso26439175ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 01:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739525462; x=1740130262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYdDqavtq9jUGmr9BTt10VNZtJWCJbWghGFQiFP0UEc=;
        b=UNoogOXbyZrLqkOPKUAL7iRT/gOBX56QQVbSEpGlt2f9lvRP8hOH6SC80vdTH0HFY+
         +v/coDeAfpyXZtzSirznXAKIt+PDkVoGAc4WuNZBdzm5ckmNiTR7Rcfgzwvbqjv1abxr
         02AryOYHyq0sNMTT4pDPrtjxNn1yrvJJS1lFCidv1/ya8NzTjmcCxS9Ughbz9vNnyHI3
         lK2xEGj/8g4VjPuUrSedEniOLLD06ADH/AW/U45u07ItJmDsaNN4Lcfix2lJCiaQQ4ST
         1vJ5i/+6Qw+c/oFS19CGsVbCJucemz7shBFnKjBUYY2ftzYKbY0K7UN7NFBng6Tqe4YL
         7mOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739525462; x=1740130262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OYdDqavtq9jUGmr9BTt10VNZtJWCJbWghGFQiFP0UEc=;
        b=XCngdWM2TGLZyOI8lVT4/D1eJPmOpzg73je/C4H/Zh0AAnwl3PvD50DRNCHuRNYclw
         bBZdY5yx/BG6ZjX+FJq1gR340zWpqgDpvu9W88SikCR16GskhOtH5O7S8gP//TbZmmSx
         MeTGffM37tNI0zHok8AKd5j7RwAvJ87traWN7LLCdcft4l0QdAUnyNnZXjJZS7EmG9OW
         c6CuP7X/0VulCsXA282cAm7CNYkbPAwuQtKQBwpbvfbJHWRMx/nRbo2PNTEhQ0Qm3j4G
         of4cvJfjuMBBVhaWDT6rkOxpLgSQFv19ARRPSFpxc8L3mDLBmfTnPSCr2oOTSoHgRBnL
         DhhA==
X-Forwarded-Encrypted: i=1; AJvYcCUZJYGYHs+ynwgVkM8I5WQnI3cIHWNqyY3/cca8mNF3zYPqNrerUXeCSpv2zc3bU/x/lvCHS3dXJMdHGb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+H+5d5VzptemAw/7Kn3mzXOLxrG/VYj8zYHkrjm2/gsQHX+XZ
	pZkpgIL3EUF7igENygu7VDX1XMtROsbe6zdq83/Hg0Y44PC3YmHy
X-Gm-Gg: ASbGnctfZD6CSbt/BgsV30ujogL4OYpvJoI5ibeiZNA17FADkYwmVtJrzqCO9BbSlra
	f9bnoPt8p9bVca9fxbqO0k6K/lZMF8xqbOLyKpA4BrTXXk5fl80MY5WgeoGNhRyYpj3kRTH6Rmj
	8vrjtwE+1YHuNoYe1rPJfzNZAsZ8xpQ/M3jWjf85xYaVMFnBThstumJV7nlE2NEQgIGJPK0NrZ3
	mjUOqJNwJkiKCGqvcfqx0otpGnstoHRHGlBpmLQKSvgIiXQbp+jvqkE7KL6b+iNn+irDuXxvVnN
	bMCustRqBlPe0apU2Wlu5u/nm5a6WS4=
X-Google-Smtp-Source: AGHT+IHG1ACAyCVdNpdCj3QS2lybJkeXxN0YXvZYc6Wbp6cHggvocX10uqRNnZxi4u23qNKsTl+Yhw==
X-Received: by 2002:a17:902:e5cc:b0:21f:3e2d:7d58 with SMTP id d9443c01a7336-220bbad65b4mr153804995ad.13.1739525461729;
        Fri, 14 Feb 2025 01:31:01 -0800 (PST)
Received: from Barrys-MBP.hub ([118.92.30.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545c814sm25440515ad.148.2025.02.14.01.30.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Feb 2025 01:31:01 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: 21cnbao@gmail.com,
	baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	ioworker0@gmail.com,
	kasong@tencent.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	lorenzo.stoakes@oracle.com,
	ryan.roberts@arm.com,
	v-songbaohua@oppo.com,
	x86@kernel.org,
	ying.huang@intel.com,
	zhengtangquan@oppo.com
Subject: [PATCH v4 4/4] mm: Avoid splitting pmd for lazyfree pmd-mapped THP in try_to_unmap
Date: Fri, 14 Feb 2025 22:30:15 +1300
Message-Id: <20250214093015.51024-5-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250214093015.51024-1-21cnbao@gmail.com>
References: <20250214093015.51024-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

The try_to_unmap_one() function currently handles PMD-mapped THPs
inefficiently. It first splits the PMD into PTEs, copies the dirty
state from the PMD to the PTEs, iterates over the PTEs to locate
the dirty state, and then marks the THP as swap-backed. This process
involves unnecessary PMD splitting and redundant iteration. Instead,
this functionality can be efficiently managed in
__discard_anon_folio_pmd_locked(), avoiding the extra steps and
improving performance.

The following microbenchmark redirties folios after invoking MADV_FREE,
then measures the time taken to perform memory reclamation (actually
set those folios swapbacked again) on the redirtied folios.

 #include <stdio.h>
 #include <sys/mman.h>
 #include <string.h>
 #include <time.h>

 #define SIZE 128*1024*1024  // 128 MB

 int main(int argc, char *argv[])
 {
 	while(1) {
 		volatile int *p = mmap(0, SIZE, PROT_READ | PROT_WRITE,
 				MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

 		memset((void *)p, 1, SIZE);
 		madvise((void *)p, SIZE, MADV_FREE);
 		/* redirty after MADV_FREE */
 		memset((void *)p, 1, SIZE);

		clock_t start_time = clock();
 		madvise((void *)p, SIZE, MADV_PAGEOUT);
 		clock_t end_time = clock();

 		double elapsed_time = (double)(end_time - start_time) / CLOCKS_PER_SEC;
 		printf("Time taken by reclamation: %f seconds\n", elapsed_time);

 		munmap((void *)p, SIZE);
 	}
 	return 0;
 }

Testing results are as below,
w/o patch:
~ # ./a.out
Time taken by reclamation: 0.007300 seconds
Time taken by reclamation: 0.007226 seconds
Time taken by reclamation: 0.007295 seconds
Time taken by reclamation: 0.007731 seconds
Time taken by reclamation: 0.007134 seconds
Time taken by reclamation: 0.007285 seconds
Time taken by reclamation: 0.007720 seconds
Time taken by reclamation: 0.007128 seconds
Time taken by reclamation: 0.007710 seconds
Time taken by reclamation: 0.007712 seconds
Time taken by reclamation: 0.007236 seconds
Time taken by reclamation: 0.007690 seconds
Time taken by reclamation: 0.007174 seconds
Time taken by reclamation: 0.007670 seconds
Time taken by reclamation: 0.007169 seconds
Time taken by reclamation: 0.007305 seconds
Time taken by reclamation: 0.007432 seconds
Time taken by reclamation: 0.007158 seconds
Time taken by reclamation: 0.007133 seconds
…

w/ patch

~ # ./a.out
Time taken by reclamation: 0.002124 seconds
Time taken by reclamation: 0.002116 seconds
Time taken by reclamation: 0.002150 seconds
Time taken by reclamation: 0.002261 seconds
Time taken by reclamation: 0.002137 seconds
Time taken by reclamation: 0.002173 seconds
Time taken by reclamation: 0.002063 seconds
Time taken by reclamation: 0.002088 seconds
Time taken by reclamation: 0.002169 seconds
Time taken by reclamation: 0.002124 seconds
Time taken by reclamation: 0.002111 seconds
Time taken by reclamation: 0.002224 seconds
Time taken by reclamation: 0.002297 seconds
Time taken by reclamation: 0.002260 seconds
Time taken by reclamation: 0.002246 seconds
Time taken by reclamation: 0.002272 seconds
Time taken by reclamation: 0.002277 seconds
Time taken by reclamation: 0.002462 seconds
…

This patch significantly speeds up try_to_unmap_one() by allowing it
to skip redirtied THPs without splitting the PMD.

Suggested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Suggested-by: Lance Yang <ioworker0@gmail.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Lance Yang <ioworker0@gmail.com>
---
 mm/huge_memory.c | 24 +++++++++++++++++-------
 mm/rmap.c        | 13 ++++++++++---
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2eda2a9ec8fc..ab80348f33dd 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3176,8 +3176,12 @@ static bool __discard_anon_folio_pmd_locked(struct vm_area_struct *vma,
 	int ref_count, map_count;
 	pmd_t orig_pmd = *pmdp;
 
-	if (folio_test_dirty(folio) || pmd_dirty(orig_pmd))
+	if (pmd_dirty(orig_pmd))
+		folio_set_dirty(folio);
+	if (folio_test_dirty(folio) && !(vma->vm_flags & VM_DROPPABLE)) {
+		folio_set_swapbacked(folio);
 		return false;
+	}
 
 	orig_pmd = pmdp_huge_clear_flush(vma, addr, pmdp);
 
@@ -3204,8 +3208,15 @@ static bool __discard_anon_folio_pmd_locked(struct vm_area_struct *vma,
 	 *
 	 * The only folio refs must be one from isolation plus the rmap(s).
 	 */
-	if (folio_test_dirty(folio) || pmd_dirty(orig_pmd) ||
-	    ref_count != map_count + 1) {
+	if (pmd_dirty(orig_pmd))
+		folio_set_dirty(folio);
+	if (folio_test_dirty(folio) && !(vma->vm_flags & VM_DROPPABLE)) {
+		folio_set_swapbacked(folio);
+		set_pmd_at(mm, addr, pmdp, orig_pmd);
+		return false;
+	}
+
+	if (ref_count != map_count + 1) {
 		set_pmd_at(mm, addr, pmdp, orig_pmd);
 		return false;
 	}
@@ -3225,12 +3236,11 @@ bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long addr,
 {
 	VM_WARN_ON_FOLIO(!folio_test_pmd_mappable(folio), folio);
 	VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
+	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
+	VM_WARN_ON_FOLIO(folio_test_swapbacked(folio), folio);
 	VM_WARN_ON_ONCE(!IS_ALIGNED(addr, HPAGE_PMD_SIZE));
 
-	if (folio_test_anon(folio) && !folio_test_swapbacked(folio))
-		return __discard_anon_folio_pmd_locked(vma, addr, pmdp, folio);
-
-	return false;
+	return __discard_anon_folio_pmd_locked(vma, addr, pmdp, folio);
 }
 
 static void remap_page(struct folio *folio, unsigned long nr, int flags)
diff --git a/mm/rmap.c b/mm/rmap.c
index 8786704bd466..bcec8677f68d 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1863,9 +1863,16 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		}
 
 		if (!pvmw.pte) {
-			if (unmap_huge_pmd_locked(vma, pvmw.address, pvmw.pmd,
-						  folio))
-				goto walk_done;
+			if (folio_test_anon(folio) && !folio_test_swapbacked(folio)) {
+				if (unmap_huge_pmd_locked(vma, pvmw.address, pvmw.pmd, folio))
+					goto walk_done;
+				/*
+				 * unmap_huge_pmd_locked has either already marked
+				 * the folio as swap-backed or decided to retain it
+				 * due to GUP or speculative references.
+				 */
+				goto walk_abort;
+			}
 
 			if (flags & TTU_SPLIT_HUGE_PMD) {
 				/*
-- 
2.39.3 (Apple Git-146)


