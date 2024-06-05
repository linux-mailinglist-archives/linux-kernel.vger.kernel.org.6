Return-Path: <linux-kernel+bounces-202144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B998FC84E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FFAB283F30
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD4C190490;
	Wed,  5 Jun 2024 09:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BERZumqA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736B5190481
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 09:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717580904; cv=none; b=IlIFennBYHEKUvaUx9twvPjt+z9MvHPMZUlyiwbG/r5/9wzPdiV5001/kUkeDp66P+n4aMUw59XDavjYrHXjKZIjpQmQ31OleTEFzTn4rKw/1qFCpJgOZCdKeJVFpt1ROZS0P1l2YMcY92PzxaCRAT/b+HXjUQB23JZtBpWXfKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717580904; c=relaxed/simple;
	bh=l4kI/Eqa/s3yp9ntZCNg8OdmGCzV7tDDQHa1fg1fi84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKMBkcDMTKBQ/x27h2H21ALlh1R4C/XkfzqIX77v9fG7AwXghF1O8av+17R8IKQkTbFswOZpTdB9L6d813j1dNExwzEsYhXSv/p7zktzv6jTHzJBkmMKpVSpZsOvnfBKy5QLNV1hNW8SQcONp5ytnjk+vlSKW0xmMvMjByCZ2n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BERZumqA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA735C32781;
	Wed,  5 Jun 2024 09:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717580904;
	bh=l4kI/Eqa/s3yp9ntZCNg8OdmGCzV7tDDQHa1fg1fi84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BERZumqA2vlBVurZbqf3ltU4dd++VsLve3ArCLFM5cVVJE9xR7Wf/usLMZOgMaoPH
	 MkjMktd7aVDlimP8qcGYJzOZo4QPKr58biZZF3aZF3i4PBQ7smQ+uy7baIJZE5EIio
	 +BpT2b5kvjzZFcE5C2U6WAUeYLVoOeXuVeOoguYB3YAOOU6HTdtq5Vi2HJ1LHUAsUD
	 6gJv+IbIiHtdqJhOhmck8hkjIi8BWxHkgB2MOHtLL/07/Ked6czniRUmR4EyI64gfr
	 /NlMkMKCgEedzMMvz6IrPV+FTqewyJ1lwDcgcrXvUUqf/5pUuXFZ4nMnPs+WvRaPYb
	 zLg/T9ccxC/AA==
From: alexs@kernel.org
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	izik.eidus@ravellosystems.com,
	willy@infradead.org,
	aarcange@redhat.com,
	chrisw@sous-sol.org,
	hughd@google.com,
	david@redhat.com
Cc: "Alex Shi (tencent)" <alexs@kernel.org>
Subject: [RFC 3/3] mm/ksm: move flush_anon_page before checksum calculation
Date: Wed,  5 Jun 2024 17:53:03 +0800
Message-ID: <20240605095304.66389-3-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605095304.66389-1-alexs@kernel.org>
References: <20240605095304.66389-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alex Shi (tencent)" <alexs@kernel.org>

commit 6020dff09252 ("[ARM] Resolve fuse and direct-IO failures due to missing cache flushes")
explain that the aim of flush_anon_page() is to keep the cache and memory
content synced. Also as David Hildenbrand pointed, flush page without
the page contents reading here is meaningless, so let's move the flush action
just before page contents reading, like calc_checksum(), not
just find a page, flush it, w/o clear purpose. This should save some flush
actions why keep page content safely synced.

BTW, write_protect_page() do another type flush actions before pages_identical().

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
---
 mm/ksm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index ef335ee508d3..77e8c1ded9bb 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -784,10 +784,7 @@ static struct page *get_mergeable_page(struct ksm_rmap_item *rmap_item)
 		goto out;
 	if (is_zone_device_page(page))
 		goto out_putpage;
-	if (PageAnon(page)) {
-		flush_anon_page(vma, page, addr);
-		flush_dcache_page(page);
-	} else {
+	if (!PageAnon(page)) {
 out_putpage:
 		put_page(page);
 out:
@@ -2378,7 +2375,12 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 		mmap_read_unlock(mm);
 		return;
 	}
+
+	/* flush page contents before calculate checksum */
+	flush_anon_page(vma, page, rmap_item->address);
+	flush_dcache_page(page);
 	checksum = calc_checksum(page);
+
 	if (rmap_item->oldchecksum != checksum) {
 		rmap_item->oldchecksum = checksum;
 		mmap_read_unlock(mm);
@@ -2662,8 +2664,6 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 			if (is_zone_device_page(*page))
 				goto next_page;
 			if (PageAnon(*page)) {
-				flush_anon_page(vma, *page, ksm_scan.address);
-				flush_dcache_page(*page);
 				rmap_item = get_next_rmap_item(mm_slot,
 					ksm_scan.rmap_list, ksm_scan.address);
 				if (rmap_item) {
-- 
2.43.0


