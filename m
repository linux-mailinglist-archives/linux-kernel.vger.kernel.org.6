Return-Path: <linux-kernel+bounces-514697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A1FA35A66
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40B3916AEEC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA7D23A9AA;
	Fri, 14 Feb 2025 09:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWRWgyrX"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C22424292B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739525439; cv=none; b=H5OkUHm/7Ng5lSsf/FHNoTFZgagQycAgbnPCC9k/VRXlUHpMQZ1qsP8lEeuyhwKaRbEiDK4KbdYc8BjTJhSz722BHjyHCj6tkV3QI+zwrP3lbf5gnQ431A4KVzxYDzVDPTCZqMOhhPne6ZvNNOBD6agWF96mTF3Y/9Ky/aoeOH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739525439; c=relaxed/simple;
	bh=O8k3G9Q0K9kuLaCpcS/NxpUG2Ce9e1j/pdFjz/AQZJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DPvYwGEoKYxr5ACOh8JxzCD/74kjjMQpDSTZjqoOkh8fWabaM7n4mRoJ7zydsew8A5L9ycK6l8M54feji51NwqqmWGHC45WD1QAj7+kSzKYkadzipEbOpHwHC2TvABBqHEwD6hwGC4qLB/Tdl6yLhQiLKjrVcrRiMp7pZK0bgIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWRWgyrX; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21f818a980cso27906165ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 01:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739525437; x=1740130237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYd38P/88z4Le/gu2ZsWRGcpuaJyiGCRxbJw4vPtU7w=;
        b=QWRWgyrX5GDh091pcxuYeZHfesMiOO4UjExtp79cmUDXmxqxbHpvKAPhDcV2iVltPE
         wFcTg4QLh8e4FwbMKo2xAdrf01XDox+5KkRyeStbkBvVCewfmuRyMYhtLOV7u0Va01yc
         2j9H3heBHrN4fqy+5ldNpP7Xdv6l2fAAgspqJ9fpD57iMbmjs1lxeqJ/bw1vrB8zv6j6
         caPMz4zKRyCDWR4rf9QIkI7levXOGarSPYiM5wXnFB9PAtvH4Dt9R3EkrpcJ/lrfBCk6
         1SJTJFuQ842CLyPW8eAUa8BIEtwNnJuoCdawveDPgU1I+VB8qekwkQTvG25rnYDaR9i5
         wrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739525437; x=1740130237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MYd38P/88z4Le/gu2ZsWRGcpuaJyiGCRxbJw4vPtU7w=;
        b=FJRtOTaOnFL27D0XHxmT7U5WCZ7L3GxZ/IR0GS7N6MeVRdBXOho9dNPF+u5cspz3Hd
         ZBplbTMakLvz0tZUtK+GcHBye3UBWsOgkg5sfnYOfeg8t19sRv+I89oFKOigeHSyS5WG
         7Oj/AyCgzZhInNkrtvetBjUU9N8t9C/4kOqznvbVglmqtqvSlApGDjEFAU6H96N6D0oJ
         uJlOZc4uZol7EFUpeMncLuoX5aPK5pgJV9qSUal5K+dUR79x40veQyaOjg4BcXGhfquR
         IKLnmePozsG2sZWLbCt4h7EP7rKU4YeGMJHBNNfCY+2QKyIcbucwiQxzftPYlc3bsYdM
         0UUA==
X-Forwarded-Encrypted: i=1; AJvYcCUwXj9//D9WIybbnt8Gv8gcW94DdcLa85WKJqnkG25vsAZIUHDFcDRUDLxQFt+TGbPb5JKvjuzGO65HwyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxrhmeXdFMD7QK7ousWTOseaKb4wWia/5iT+Z6SgkkKoJKrlsQ
	UpCnJ9j/C5/NuAX2JHg/2PZbytodhG0JuSethAQyrEIjVWJbIuwF
X-Gm-Gg: ASbGncsuaoUjgqub4lv7f27vKgEqRjX/xNxirTww0PV7LZdbFyc/WF3PwsqD8EWlNSy
	jGtLdtUIMh6l0ZIoFZS23k3YOjoYxj2HoW2Z4Z1gsAcym5hlqmTFbsnwFBbe3JukxHoDWX95BXt
	hrBUh/phidQZjEKP8GOU2QZee6yMUfe/e2oBdn5Bm1qQBbXBpcNzWnnKRNWPopGVot6wveKsw3Y
	GKSYFdTqDsIEB7WeYVucqufwNLTbtvtx0zQfpajJ1GFOoJ7WHgV5F2DVjN1tRUA1u1pqe6uoBw8
	i5K47QNaMc4tlgkyBNIIJtzE9Grag7k=
X-Google-Smtp-Source: AGHT+IF3R6sEv2yv6agqEs7T8nVlI0vjyVGMx4hRl93qDBPx5Nld8wdX+5D8keuWm8hulHGB8fPZdw==
X-Received: by 2002:a17:902:ecc2:b0:220:d6be:5bba with SMTP id d9443c01a7336-220d6be5e03mr81713945ad.33.1739525437158;
        Fri, 14 Feb 2025 01:30:37 -0800 (PST)
Received: from Barrys-MBP.hub ([118.92.30.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545c814sm25440515ad.148.2025.02.14.01.30.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Feb 2025 01:30:36 -0800 (PST)
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
	zhengtangquan@oppo.com,
	Mauricio Faria de Oliveira <mfo@canonical.com>
Subject: [PATCH v4 1/4] mm: Set folio swapbacked iff folios are dirty in try_to_unmap_one
Date: Fri, 14 Feb 2025 22:30:12 +1300
Message-Id: <20250214093015.51024-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250214093015.51024-1-21cnbao@gmail.com>
References: <20250214093015.51024-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

The refcount may be temporarily or long-term increased, but this does
not change the fundamental nature of the folio already being lazy-
freed. Therefore, we only reset 'swapbacked' when we are certain the
folio is dirty and not droppable.

Fixes: 6c8e2a256915 ("mm: fix race between MADV_FREE reclaim and blkdev direct IO read")
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Cc: Mauricio Faria de Oliveira <mfo@canonical.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Lance Yang <ioworker0@gmail.com>
---
 mm/rmap.c | 49 ++++++++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 25a8a127f689..1320527e90cd 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2022,34 +2022,29 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				 */
 				smp_rmb();
 
-				/*
-				 * The only page refs must be one from isolation
-				 * plus the rmap(s) (dropped by discard:).
-				 */
-				if (ref_count == 1 + map_count &&
-				    (!folio_test_dirty(folio) ||
-				     /*
-				      * Unlike MADV_FREE mappings, VM_DROPPABLE
-				      * ones can be dropped even if they've
-				      * been dirtied.
-				      */
-				     (vma->vm_flags & VM_DROPPABLE))) {
-					dec_mm_counter(mm, MM_ANONPAGES);
-					goto discard;
-				}
-
-				/*
-				 * If the folio was redirtied, it cannot be
-				 * discarded. Remap the page to page table.
-				 */
-				set_pte_at(mm, address, pvmw.pte, pteval);
-				/*
-				 * Unlike MADV_FREE mappings, VM_DROPPABLE ones
-				 * never get swap backed on failure to drop.
-				 */
-				if (!(vma->vm_flags & VM_DROPPABLE))
+				if (folio_test_dirty(folio) && !(vma->vm_flags & VM_DROPPABLE)) {
+					/*
+					 * redirtied either using the page table or a previously
+					 * obtained GUP reference.
+					 */
+					set_pte_at(mm, address, pvmw.pte, pteval);
 					folio_set_swapbacked(folio);
-				goto walk_abort;
+					goto walk_abort;
+				} else if (ref_count != 1 + map_count) {
+					/*
+					 * Additional reference. Could be a GUP reference or any
+					 * speculative reference. GUP users must mark the folio
+					 * dirty if there was a modification. This folio cannot be
+					 * reclaimed right now either way, so act just like nothing
+					 * happened.
+					 * We'll come back here later and detect if the folio was
+					 * dirtied when the additional reference is gone.
+					 */
+					set_pte_at(mm, address, pvmw.pte, pteval);
+					goto walk_abort;
+				}
+				dec_mm_counter(mm, MM_ANONPAGES);
+				goto discard;
 			}
 
 			if (swap_duplicate(entry) < 0) {
-- 
2.39.3 (Apple Git-146)


