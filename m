Return-Path: <linux-kernel+bounces-206884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3CD900F43
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 04:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82689B22DC7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 02:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9348CA40;
	Sat,  8 Jun 2024 02:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yaigSzwL"
Received: from mail-vk1-f202.google.com (mail-vk1-f202.google.com [209.85.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8080C7F
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 02:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717814618; cv=none; b=p+ecvE3UCe5fuiAQw4axRi3uSCSouQLgf/EMbfZVTUOeYP7jkBg6jK4pqB03LkRDZNLcgJiX0NKjeFNTGpq+syWvoJSee1feq7ksf8E/JevDlFYl5jgr/2gmfi6K6402bdaWHNaluTjYEnF8cHGFbV67hBHCiLVCTUoNQorQqpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717814618; c=relaxed/simple;
	bh=kEjngn0PaEK02LFHV87D4smKdu4MTq0gHFlSeqq8wtY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LKeDjkFbmqtOUWQh2V7If3ZinCpR8mNY2ueWE2jJrLzJxssv4T6JFodXocr+VdfzR4pLq2o3u91/f0iovjaUkURaWkBA5AC2iOyoz8sV19v4mJJue4A7a/+Z0dpUKmv5f/W846Vd5/snDiXyPul2o/Z5Nz3vVgkIpWdDVldkUWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yaigSzwL; arc=none smtp.client-ip=209.85.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-vk1-f202.google.com with SMTP id 71dfb90a1353d-4eb14518c4aso3326532e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 19:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717814615; x=1718419415; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RiSTt00lJmIM9pwkdwoE4isrbgVfqbDGpglyPba/Gok=;
        b=yaigSzwLPEQIv5MqeZztwdZd2lhnABE3EQbbS/D0fLc/x23s+Tp7lm1DPTJ8dhZQfE
         uIFo+8seNwc+6czLrm7ZEuHar0otrRsmU2wjN8UnrJSsnj3BS1qU7qOXL0o+CFlfmquM
         X9tXVkWC9glEHRA7+NdD8facn/+0jx+h79m3LHzdgzzFA7thg9081WTEt98224MMCyL1
         espL1hWX/zW1NyaQrKv2AsBJvcUvMnYECAKuGN7mMMYaj8+3/d7r7RjYbx5YXVp+wdG3
         QcA8MRWT9Jcv0f9VyQ8nVOc604dJy6RPMF2APxpOFKESK/0SK51YS6fsZCyPbKYE/z9R
         y3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717814615; x=1718419415;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RiSTt00lJmIM9pwkdwoE4isrbgVfqbDGpglyPba/Gok=;
        b=nMt2dmQE6pEYElRPPJYulCmkqaKHDuamtvr+GgaXCDNVGbk7pORv1ax4/9HeOb1MGG
         YhcMYA4oh4FUcyrACezLgXnnvHpPQ4hje4sBv7DYarCd/iucXgoKM9miLfgVR86ELTSl
         ictn6SARgkpM4uo28B+rsCFkCzdMxeaut47iGoq1xW0L4PhR5pGEXaxF06akHvxZAX4M
         nhfxinNz0DOUUOpRIkrIOjT5xXscGTqQIDR+wvmmriNU8VdMOGX2m30Oo85HpKrbwskn
         0e1gAFJkdTFu0NTGUTH1r92FOIHbPuN6kDTsJxZaOTW3LTyc+SBJi1O84RlVdvSVoMKc
         7cSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjf2XsHFXuXqeau7h/prhGbvIajx4yWZu2hEI5epyFuayaH/gDtP0227RJCGidsA6s52ShptSNlGpu0DoPDB3CTcNet9jQ4C8fye/R
X-Gm-Message-State: AOJu0Yw79gJFDtZ+msDn6sOuQi5/Bqc9ihph+JnsiX6bBI9h5LsrJoRJ
	h3bQ81U3r9aE/VN+cH6+sfEp+/rO+3F588MX8bebUirZ0TWfoY5aVKDpsu3mAD74lyiIrk0ZY47
	b/Z/LEzRyxmpLzN6KtQ==
X-Google-Smtp-Source: AGHT+IFfA8mr9lfhDrLYFZf7Onfx5mpbJHVARhxMTc00b+HD8uEOFfV9ZWXuvMVIppVolBKqBMlIaVD8/YnpJlxT
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a17:90b:30c2:b0:2b2:bc19:61f5 with SMTP
 id 98e67ed59e1d1-2c2b8989ebdmr45265a91.1.1717814223591; Fri, 07 Jun 2024
 19:37:03 -0700 (PDT)
Date: Sat,  8 Jun 2024 02:36:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240608023654.3513385-1-yosryahmed@google.com>
Subject: [PATCH v2] mm: zswap: handle incorrect attempts to load of large folios
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Barry Song <21cnbao@gmail.com>, Chris Li <chrisl@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

Zswap does not support storing or loading large folios. Until proper
support is added, attempts to load large folios from zswap are a bug.

For example, if a swapin fault observes that contiguous PTEs are
pointing to contiguous swap entries and tries to swap them in as a large
folio, swap_read_folio() will pass in a large folio to zswap_load(), but
zswap_load() will only effectively load the first page in the folio. If
the first page is not in zswap, the folio will be read from disk, even
though other pages may be in zswap.

In both cases, this will lead to silent data corruption. Proper support
needs to be added before large folio swapins and zswap can work
together.

Looking at callers of swap_read_folio(), it seems like they are either
allocated from __read_swap_cache_async() or do_swap_page() in the
SWP_SYNCHRONOUS_IO path. Both of which allocate order-0 folios, so
everything is fine for now.

However, there is ongoing work to add to support large folio swapins
[1]. To make sure new development does not break zswap (or get broken by
zswap), add minimal handling of incorrect loads of large folios to
zswap.

First, move the call folio_mark_uptodate() inside zswap_load().

If a large folio load is attempted, and any page in that folio is in
zswap, return 'true' without calling folio_mark_uptodate(). This will
prevent the folio from being read from disk, and will emit an IO error
because the folio is not uptodate (e.g. do_swap_fault() will return
VM_FAULT_SIGBUS). It may not be reliable recovery in all cases, but it
is better than nothing.

This was tested by hacking the allocation in __read_swap_cache_async()
to use order 2 and __GFP_COMP.

In the future, to handle this correctly, the swapin code should:
(a) Fallback to order-0 swapins if zswap was ever used on the machine,
because compressed pages remain in zswap after it is disabled.
(b) Add proper support to swapin large folios from zswap (fully or
partially).

Probably start with (a) then followup with (b).

[1]https://lore.kernel.org/linux-mm/20240304081348.197341-6-21cnbao@gmail.com/

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---

v1: https://lore.kernel.org/lkml/20240606184818.1566920-1-yosryahmed@google.com/

v1 -> v2:
- Instead of using VM_BUG_ON() use WARN_ON_ONCE() and add some recovery
  handling (David Hildenbrand).

---
 mm/page_io.c |  1 -
 mm/zswap.c   | 22 +++++++++++++++++++++-
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index f1a9cfab6e748..8f441dd8e109f 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -517,7 +517,6 @@ void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 	delayacct_swapin_start();
 
 	if (zswap_load(folio)) {
-		folio_mark_uptodate(folio);
 		folio_unlock(folio);
 	} else if (data_race(sis->flags & SWP_FS_OPS)) {
 		swap_read_folio_fs(folio, plug);
diff --git a/mm/zswap.c b/mm/zswap.c
index b9b35ef86d9be..ebb878d3e7865 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1557,6 +1557,26 @@ bool zswap_load(struct folio *folio)
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 
+	/*
+	 * Large folios should not be swapped in while zswap is being used, as
+	 * they are not properly handled. Zswap does not properly load large
+	 * folios, and a large folio may only be partially in zswap.
+	 *
+	 * If any of the subpages are in zswap, reading from disk would result
+	 * in data corruption, so return true without marking the folio uptodate
+	 * so that an IO error is emitted (e.g. do_swap_page() will sigfault).
+	 *
+	 * Otherwise, return false and read the folio from disk.
+	 */
+	if (folio_test_large(folio)) {
+		if (xa_find(tree, &offset,
+			    offset + folio_nr_pages(folio) - 1, XA_PRESENT)) {
+			WARN_ON_ONCE(1);
+			return true;
+		}
+		return false;
+	}
+
 	/*
 	 * When reading into the swapcache, invalidate our entry. The
 	 * swapcache can be the authoritative owner of the page and
@@ -1590,7 +1610,7 @@ bool zswap_load(struct folio *folio)
 		zswap_entry_free(entry);
 		folio_mark_dirty(folio);
 	}
-
+	folio_mark_uptodate(folio);
 	return true;
 }
 
-- 
2.45.2.505.gda0bf45e8d-goog


