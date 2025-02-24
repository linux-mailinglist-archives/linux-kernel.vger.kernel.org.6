Return-Path: <linux-kernel+bounces-529423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85799A42609
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 502553AD614
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236DB17C21C;
	Mon, 24 Feb 2025 15:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRJA0yzC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B271624F8
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740409952; cv=none; b=fCC9T3JSf/56eSKkIf6QtoL0mNqLm0CO0pdHz6KD5ulgJV6vMmkenSRQckYahqMkgzj4D9R2pQNtd5xh9ux8xMoNvN1BEKmF1PIyI/51AJ/MMQxDm4zXr7mvsNS4aAAUsdoE9felKS/7Xc6mc4w8hc5ng2FVPdL4QhiEx3oUukc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740409952; c=relaxed/simple;
	bh=QOXTNbclUJQiLSqfGNlJQuuPZknq5UFrWgldy6ueUKE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j/F7NbN1zwc1wE8Gb1TwyG0Y8k9zWn8sfmVsuT74b72gu/6i37HnESVtEhs9pnFMFPJkv/MCIzFLLDtkDOJrnqsp05SfGn5qltLZCraylKbv01Q6KaQbIj127w8USAW8YInhNvY7zxOCokG4Yi9SoyuRNjI7zcPtOMhTnNB7akA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRJA0yzC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5094FC4CED6;
	Mon, 24 Feb 2025 15:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740409950;
	bh=QOXTNbclUJQiLSqfGNlJQuuPZknq5UFrWgldy6ueUKE=;
	h=From:To:Cc:Subject:Date:From;
	b=uRJA0yzCNnI6P44jCX7BHj5JkZSAV+28+swusa/E90doZzREjCo3EZo8fQz8/8P7S
	 9LUseBelDaix555oTQ8JpEc6E6q1hlwYYRAd/6AmWCWA9FBdMbbr6ZYSDaifp+LSwB
	 ZVndzQMpJ5DDtaaobXM9mYgj/fAVcSemHcgJPiqlqVHPIaKdCcjDNXm3v1re6Bim4I
	 ngmqRS1fqxnADMGSEKaqvBo0c5gdugbXM0np/D6Nm9UBkWwY6pJKXPN7c9imJA65gm
	 9uZ+A9BC9w7ylF8CfYhhl5ZjYXsdN4S2emOUMoFgRyn6wigjx8UsrndtOrLzugTNBJ
	 LkVgvJ6Rgj5Pw==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Brian Mak <makb@juniper.net>
Cc: Arnd Bergmann <arnd@arndb.de>,
	David Hildenbrand <david@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	Steve Sistare <steven.sistare@oracle.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: unhide get_dump_page() function
Date: Mon, 24 Feb 2025 16:12:21 +0100
Message-Id: <20250224151225.3637934-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The definition of get_dump_page() is guarded by CONFIG_ELF_CORE, but
the caller has now moved into a function that is built based on
CONFIG_COREDUMP, which leads to a possible link failure:

ld.lld-21: error: undefined symbol: get_dump_page
>>> referenced by coredump.c
>>>               fs/coredump.o:(dump_vma_snapshot) in archive vmlinux.a

Change the #ifdef block around the definition to match the caller.
In practice there is very little difference, as setting COREDUMP
but not ELF_CORE is not useful.

Fixes: ff41385709f0 ("coredump: Only sort VMAs when truncating or core_sort_vma sysctl is set")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/gup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index d846c0ce41d6..15d6d7b5df1d 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2266,7 +2266,7 @@ EXPORT_SYMBOL(fault_in_readable);
  *
  * Called without mmap_lock (takes and releases the mmap_lock by itself).
  */
-#ifdef CONFIG_ELF_CORE
+#ifdef CONFIG_COREDUMP
 struct page *get_dump_page(unsigned long addr, int *locked)
 {
 	struct page *page;
@@ -2276,7 +2276,7 @@ struct page *get_dump_page(unsigned long addr, int *locked)
 				      FOLL_FORCE | FOLL_DUMP | FOLL_GET);
 	return (ret == 1) ? page : NULL;
 }
-#endif /* CONFIG_ELF_CORE */
+#endif /* CONFIG_COREDUMP */
 
 #ifdef CONFIG_MIGRATION
 
-- 
2.39.5


