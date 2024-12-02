Return-Path: <linux-kernel+bounces-427530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 676219E026B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2785A2825CD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A631FECC2;
	Mon,  2 Dec 2024 12:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqzQXC9Q"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1431FE46A;
	Mon,  2 Dec 2024 12:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733143671; cv=none; b=QkTjLCjc7A/t0fYOlxgJljiuF3m6/Dwd1d05QgniGUDOjpnd7VkpwjBwSswWo6MG2imVYO/jA0ug6hzErz4cXV85Rg/Wq4glfUVM/glwmY+xC52lqf7a6SA+ABeOyLp9bXXck/nasKKmCkrM9jkAhPxxpBPEFHLu0iPszPEEBIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733143671; c=relaxed/simple;
	bh=HrV9/dOauQfeTMRpIiHhEPmlWD1hR9B/XAaKHgGtO00=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MEu2t52lQRwDzYIdTFZZYAwgnPCp3KsurRhVEnkAbHcDWNhWc2lLJooJFm3X1X42CUl8X2RQ76W2jjgcRopl2Vo0YQzOMmmssv8dzXKPfjvEyMsMtUHJa9/h1BOpopT9za8tyf/MHuAk09k8DxgUSZ0olxPQcKXX1jJjMR7Sv8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqzQXC9Q; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-724f1004c79so2744508b3a.2;
        Mon, 02 Dec 2024 04:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733143669; x=1733748469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qCzMoMCswwZtYXZlSm324faiWhRkG3dwRJTSsFPFn9M=;
        b=OqzQXC9QPrUl4ToRlrvdV+yHO1T/a71W35WNwu0K3h7rIASiZGDPrRbSl3S6J4P8t4
         uLKfnW5u0C1sF8OUbYDTtZUtRXpsDTEgLRIi/5Theav8JpDsHMH4+bQXPq119E8x3r//
         gdzG9/DKbbKwacZHpXYhiPI0Qyivw79hGXcsSgjiM/QI6ZxRJjKjOat733P0ajI5Yni9
         fYqdcLOPwGKzC6/1j+kWC6VVPKxdki9La8YBwHLVH+STUrmQs64WVmWrETp6YGZUnpeq
         aKFZuZgz5Pf8qqxDX/EdPec6LXoSxV2NrUI9Vu4N6iaScdnaD9mxZNbNWGBwilbkNk6+
         VEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733143669; x=1733748469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qCzMoMCswwZtYXZlSm324faiWhRkG3dwRJTSsFPFn9M=;
        b=SrQyceIYpICW1A4aUgSBZ/g//qpYt0Vkx6kVibtU3zUlvIxiOtEXGedarBc3hh5S3J
         +9O1pTcXWNLxU8pH+2ft9qWRlMg/b2WxbjxJchw+M63L87VU4AxhdbAMAYydUoRhm/B/
         LpU1d+UtuB0QOh4D//slEjbjzeSBnp9ub0pb8dEji3CE/Irc//N7cEndPm/Aec2Hesqk
         vBAr8PxMvPdZS4kC867Ax4bMPRQ3xH6ZamgtrN7wDLgVoLM5+1rvNKeh4dXl+An53JgV
         Px4AEkmQJ23Gcul36qKkPnTQHqxiZzT2aqspBGOjC/O1vOqgwHiXvuWovO1oCiDgomTo
         Q42A==
X-Forwarded-Encrypted: i=1; AJvYcCV4nj0Jxl61IWR3+YH2rJ9XEYOjlYNWxUzrsQhO/jccva0uh4z1oVQ8fKvCTq03mUKiD5r01PPXOIo=@vger.kernel.org, AJvYcCWEVJtZLVgWvPQuPqvpExRIMw9+As1m5kZs33M/XGclunSFIA+SfaqPJy6JN7pafLOQJtEE16sJ3EdwPTHi@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5nV9jCemh6UM1KM8HSd6mtQa+DR69nEv4t+t2+ObECzY8jd7C
	r+1lIjdxMpm+miSFrn+lpPXmXPmQDpVcQ/5NMMy6JUjm5pffga20
X-Gm-Gg: ASbGncs1JG0+6BkXiFlOLBJ+AJWwTGslm1XvuXPYdwX/t2sk/vEo0iWwStIEsQA645F
	lSlrCX/eX6akKg/FnHl5HuHAaP2xzbK0vnVFTabwjb1zx06u3/HNWAvQiW6m8DwyPgxWBEjp5qa
	cHFw1eT4tpjCIa9KRiCQi3/omuw9vXleveSEeWMs4iJjDk9+YFkiAxRpTeafWLVBOu16W16jMFW
	W675uVbG4f8x+MH0oJ/2mEILxKhIW84jL2K4qpCihlUdfYpNeqy6kZjnLSHXVE=
X-Google-Smtp-Source: AGHT+IGhTGeEW3OAHtQJ3zwilcLHoZEoDFMHHB9GCJ19gCSLGgHx3RTLysE7YXX4PPyCOI/CS1zTAA==
X-Received: by 2002:a17:903:1c3:b0:215:8ca3:3bac with SMTP id d9443c01a7336-2158ca33e29mr68764465ad.16.1733143669041;
        Mon, 02 Dec 2024 04:47:49 -0800 (PST)
Received: from ubuntu.mioffice.cn ([43.224.245.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215218f22cdsm76041275ad.36.2024.12.02.04.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 04:47:48 -0800 (PST)
From: Wenchao Hao <haowenchao22@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Usama Arif <usamaarif642@gmail.com>,
	Lance Yang <ioworker0@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Xu <peterx@redhat.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Wenchao Hao <haowenchao22@gmail.com>
Subject: [PATCH v3] mm: add per-order mTHP swap-in fallback/fallback_charge counters
Date: Mon,  2 Dec 2024 20:47:30 +0800
Message-ID: <20241202124730.2407037-1-haowenchao22@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, large folio swap-in is supported, but we lack a method to
analyze their success ratio. Similar to anon_fault_fallback, we introduce
per-order mTHP swpin_fallback and swpin_fallback_charge counters for
calculating their success ratio. The new counters are located at:

/sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats/
	swpin_fallback
	swpin_fallback_charge

Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
---
V3:
 Update description about swpin_fallback and swpin_fallback_charge

V2:
 Introduce swapin_fallback_charge, which increments if it fails to
 charge a huge page to memory despite successful allocation.

 Documentation/admin-guide/mm/transhuge.rst | 10 ++++++++++
 include/linux/huge_mm.h                    |  2 ++
 mm/huge_memory.c                           |  6 ++++++
 mm/memory.c                                |  2 ++
 4 files changed, 20 insertions(+)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 333958ef0d5f..156a03af0a88 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -591,6 +591,16 @@ swpin
 	is incremented every time a huge page is swapped in from a non-zswap
 	swap device in one piece.
 
+swpin_fallback
+	is incremented if swapin fails to allocate or charge a huge page
+	and instead falls back to using huge pages with lower orders or
+	small pages.
+
+swpin_fallback_charge
+	is incremented if swapin fails to charge a huge page and instead
+	falls back to using  huge pages with lower orders or small pages
+	even though the allocation was successful.
+
 swpout
 	is incremented every time a huge page is swapped out to a non-zswap
 	swap device in one piece without splitting.
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index b94c2e8ee918..93e509b6c00e 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -121,6 +121,8 @@ enum mthp_stat_item {
 	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
 	MTHP_STAT_ZSWPOUT,
 	MTHP_STAT_SWPIN,
+	MTHP_STAT_SWPIN_FALLBACK,
+	MTHP_STAT_SWPIN_FALLBACK_CHARGE,
 	MTHP_STAT_SWPOUT,
 	MTHP_STAT_SWPOUT_FALLBACK,
 	MTHP_STAT_SHMEM_ALLOC,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ab46ef718b44..d062b257376d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -617,6 +617,8 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
 DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
 DEFINE_MTHP_STAT_ATTR(zswpout, MTHP_STAT_ZSWPOUT);
 DEFINE_MTHP_STAT_ATTR(swpin, MTHP_STAT_SWPIN);
+DEFINE_MTHP_STAT_ATTR(swpin_fallback, MTHP_STAT_SWPIN_FALLBACK);
+DEFINE_MTHP_STAT_ATTR(swpin_fallback_charge, MTHP_STAT_SWPIN_FALLBACK_CHARGE);
 DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
 DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
 #ifdef CONFIG_SHMEM
@@ -637,6 +639,8 @@ static struct attribute *anon_stats_attrs[] = {
 #ifndef CONFIG_SHMEM
 	&zswpout_attr.attr,
 	&swpin_attr.attr,
+	&swpin_fallback_attr.attr,
+	&swpin_fallback_charge_attr.attr,
 	&swpout_attr.attr,
 	&swpout_fallback_attr.attr,
 #endif
@@ -669,6 +673,8 @@ static struct attribute *any_stats_attrs[] = {
 #ifdef CONFIG_SHMEM
 	&zswpout_attr.attr,
 	&swpin_attr.attr,
+	&swpin_fallback_attr.attr,
+	&swpin_fallback_charge_attr.attr,
 	&swpout_attr.attr,
 	&swpout_fallback_attr.attr,
 #endif
diff --git a/mm/memory.c b/mm/memory.c
index d5a1b0a6bf1f..a44547600c02 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4189,8 +4189,10 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 			if (!mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
 							    gfp, entry))
 				return folio;
+			count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK_CHARGE);
 			folio_put(folio);
 		}
+		count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK);
 		order = next_order(&orders, order);
 	}
 
-- 
2.45.0


