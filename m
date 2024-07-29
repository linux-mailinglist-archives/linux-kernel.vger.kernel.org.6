Return-Path: <linux-kernel+bounces-266520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D7294010A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 00:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E02A7B217B2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DA618F2CB;
	Mon, 29 Jul 2024 22:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="akdZ3hpP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6248F12EBD6
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 22:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722292083; cv=none; b=fKMt/1BOYxKiVi2wbgVybskdJxNY67mYcZIbPiOenGrMCT3uovUmDBA9IVbEM8x3SUgheOAC89Vnaybe+uiO+oZgwTWY28rIv36XaqEi4H2jsgPd6+2YZb+3LU9tjt+479wRNQxTVh1SULRZME1VDCj2sSg3qCgWmnVL15gFA/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722292083; c=relaxed/simple;
	bh=Q3BQ7BnB6Xwevn0PVjffD6TVPniDHE0DQ5GkF/Df97g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXaK5jTS54NVazAkgDfEyv10kYII7+twXKZ4HT5uZXWiUaqYZ7CF5BbFbftPCXyQpMb0tFTuySwqN9/W9LrusW26V7krUZW9ZswKF7WL26nqhKE1EsAEsaMKyXYkgGw6EbFvDLAm1WMKRWVlIQUPpsBeVFBxi9PHV1avHk0p/Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=akdZ3hpP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722292080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1dh1LJsNavfHIk0SmT2VfaSsPtsucB+yQftwoouaONk=;
	b=akdZ3hpPIYKFPFzgciRtLmgIyMDOtCN0QiXWdZUm3hV2DABL971I+0LkzYhLF+DjHiNqZr
	xJLLwDTjgPlYkgXx6g7oLW7hYY+UVOKtm9bAEoR0gcGZby7WI5VGjvLXJHkdhnPak8WYN4
	WhFHr6VCgIGoAlJtHGu3vqrkCNz1qmc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-CizAE6wRN66ju72-UQYRjw-1; Mon,
 29 Jul 2024 18:27:57 -0400
X-MC-Unique: CizAE6wRN66ju72-UQYRjw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D75431955F3D;
	Mon, 29 Jul 2024 22:27:55 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.10.55])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 07E341955F40;
	Mon, 29 Jul 2024 22:27:51 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Barry Song <baohua@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lance Yang <ioworker0@gmail.com>,
	Peter Xu <peterx@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Rafael Aquini <aquini@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [RFC 2/2] mm: document transparent_hugepage=defer usage
Date: Mon, 29 Jul 2024 16:27:27 -0600
Message-ID: <20240729222727.64319-3-npache@redhat.com>
In-Reply-To: <20240729222727.64319-1-npache@redhat.com>
References: <20240729222727.64319-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The new transparent_hugepage=defer option allows for a more conservative
approach to THPs. Document its usage in the transhuge admin-guide.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Barry Song <baohua@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Lance Yang <ioworker0@gmail.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Rafael Aquini <aquini@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 058485daf186..1946fbb789b2 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -88,8 +88,9 @@ In certain cases when hugepages are enabled system wide, application
 may end up allocating more memory resources. An application may mmap a
 large region but only touch 1 byte of it, in that case a 2M page might
 be allocated instead of a 4k page for no good. This is why it's
-possible to disable hugepages system-wide and to only have them inside
-MADV_HUGEPAGE madvise regions.
+possible to disable hugepages system-wide, only have them inside
+MADV_HUGEPAGE madvise regions, or defer them away from the page fault
+handler to khugepaged.
 
 Embedded systems should enable hugepages only inside madvise regions
 to eliminate any risk of wasting any precious byte of memory and to
@@ -99,6 +100,15 @@ Applications that gets a lot of benefit from hugepages and that don't
 risk to lose memory by using hugepages, should use
 madvise(MADV_HUGEPAGE) on their critical mmapped regions.
 
+Applications that would like to benefit from THPs but would still like a
+more memory conservative approach can choose 'defer'. This avoids
+inserting THPs at the page fault handler unless they are MADV_HUGEPAGE.
+Khugepaged will then scan the mappings for potential collapses into PMD
+sized pages. Admins using this the 'defer' setting should consider
+tweaking khugepaged/max_ptes_none. The current default of 511 may
+aggressively collapse your PTEs into PMDs. Lower this value to conserve
+more memory (ie. max_ptes_none=64).
+
 .. _thp_sysfs:
 
 sysfs
@@ -136,6 +146,7 @@ The top-level setting (for use with "inherit") can be set by issuing
 one of the following commands::
 
 	echo always >/sys/kernel/mm/transparent_hugepage/enabled
+	echo defer >/sys/kernel/mm/transparent_hugepage/enabled
 	echo madvise >/sys/kernel/mm/transparent_hugepage/enabled
 	echo never >/sys/kernel/mm/transparent_hugepage/enabled
 
@@ -264,7 +275,8 @@ of small pages into one large page::
 A higher value leads to use additional memory for programs.
 A lower value leads to gain less thp performance. Value of
 max_ptes_none can waste cpu time very little, you can
-ignore it.
+ignore it. Consider lowering this value when using
+``transparent_hugepage=defer``
 
 ``max_ptes_swap`` specifies how many pages can be brought in from
 swap when collapsing a group of pages into a transparent huge page::
-- 
2.45.2


