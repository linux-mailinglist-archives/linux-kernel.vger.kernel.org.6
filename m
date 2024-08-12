Return-Path: <linux-kernel+bounces-283544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCD294F61F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A2EBB21F30
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A0E1898E4;
	Mon, 12 Aug 2024 17:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPUhlG75"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E465218952C
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 17:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723485317; cv=none; b=XfN78HNRmkC2rKtnR54OWUCJZ1itmABtzay3EZZCK/R0S/CbWHmhpO6rMRUYl97ZcgGg/ELuzAQ1+DymrKpH/4oBkWozcspVz0LscquUl9GGLjfZO37G8f/xHqUlFkQf5jrf3/zKr9NyaBB2alhcSeT2ekNF/FPiH9MtGVbOY60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723485317; c=relaxed/simple;
	bh=Ay8VaO4Jv/lXv+JmnPgO0eWEOIHNdWaHckuTwRmJZk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=clkHiOJCPNJ7EXKN/JpsLR620G4G5ZJTTCpZrXt7WYBFUE3N0oEk2oXlK6nnuvWQ6YK2d98aaY0xpUV4Y75PlnF8RXTK9HGjKpqRR9QbEk+rMyQO2lOklVewhy2C7nhD0z8JrXKhVAPHf2kbmjXU/0aXH1ZlYYTeaKir4uM81ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPUhlG75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54836C4AF1B;
	Mon, 12 Aug 2024 17:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723485316;
	bh=Ay8VaO4Jv/lXv+JmnPgO0eWEOIHNdWaHckuTwRmJZk8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=WPUhlG756UwmloX/ZNx6WVIG3Gz7KgFAkSwPL8PIfLsv/XnJsPd7S8xowSMYh4luW
	 lcc0KfrTiC3kgPzN9OZTvsdapHW2pemGRt/l3F9OEGSqs9JTN9EArcYPgxJ9GSX0iE
	 N74gb4dfbZnK45nPSxPGpri2dG8Vw3FQ12MjL7ZyYCI0X2xtlIs0HY1AAKrzTWgwFU
	 WrSuXSuLig0hU9sSwDZRHf+gZP42P3CJ8QNcSmZHttnv0CYANF0YMeNdhslCzQEfiJ
	 doG3CBqubwgL0dNsX8tnsgfU1qc+BM/mjUzL/s5fXptgpU41qFJcIsa5TuSfxodOXy
	 tA/Mz29d0mPCg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4871AC52D7C;
	Mon, 12 Aug 2024 17:55:16 +0000 (UTC)
From: Christoph Lameter via B4 Relay <devnull+cl.gentwo.org@kernel.org>
Date: Mon, 12 Aug 2024 10:55:06 -0700
Subject: [PATCH] Reenable NUMA policy support in the slab allocator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240812-numa_policy-v1-1-1732602b976c@gentwo.org>
X-B4-Tracking: v=1; b=H4sIAHlMumYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCwMz3bzS3MT4gvyczORKXVNDC4s0E5OkRIMUCyWgjoKi1LTMCrBp0bG
 1tQCMAoOGXQAAAA==
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Pekka Enberg <penberg@kernel.org>, 
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Christoph Lameter <cl@gentwo.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723485315; l=2030;
 i=cl@gentwo.org; s=20240811; h=from:subject:message-id;
 bh=oIsOUj+s52JxQUrLe0TMZXCQFfAgTyXqoXTDzKem1MA=;
 b=Z286VwSdQVPVNRMc582ozWP7NFSxGLmQwBaCtj9kzM80sRwA6XOkZDFrPl4wKma09vPviLxBh
 p5zaM/WaXQaCAi00LCfffQoEJ69rjA3c7EcHqnOIkayhvpRYMQaRcRQ
X-Developer-Key: i=cl@gentwo.org; a=ed25519;
 pk=I7gqGwDi9drzCReFIuf2k9de1FI1BGibsshXI0DIvq8=
X-Endpoint-Received: by B4 Relay for cl@gentwo.org/20240811 with
 auth_id=194
X-Original-From: Christoph Lameter <cl@gentwo.org>
Reply-To: cl@gentwo.org

From: Christoph Lameter <cl@gentwo.org>

Revert commit 8014c46ad991f05b15ffbc0c6ae130bdf911187b
("slub: use alloc_pages_node() in alloc_slab_page()").

The patch disabled the numa policy support in the slab allocator. It
did not consider that alloc_pages() uses memory policies but
alloc_pages_node() does not.

As a result of this patch slab memory allocations are no longer spread via
interleave policy across all available NUMA nodes on bootup. Instead
all slab memory is allocated close to the boot processor. This leads to
an imbalance of memory accesses on NUMA systems.

Also applications using MPOL_INTERLEAVE as a memory policy will no longer
spread slab allocations over all nodes in the interleave set but allocate
memory locally. This may also result in unbalanced allocations
on a single node if f.e. a certain process does the memory allocation on
behalf of all the other processes.

SLUB does not apply memory policies to individual object allocations.
However, it relies on the page allocators support of memory policies
through alloc_pages() to do the NUMA memory allocations on a per
folio or page level. SLUB also applies memory policies when retrieving
partial allocated slab pages from the partial list.

Signed-off-by: Christoph Lameter <cl@gentwo.org>
---
 mm/slub.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index c9d8a2497fd6..4dea3c7df5ad 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2318,7 +2318,11 @@ static inline struct slab *alloc_slab_page(gfp_t flags, int node,
 	struct slab *slab;
 	unsigned int order = oo_order(oo);
 
-	folio = (struct folio *)alloc_pages_node(node, flags, order);
+	if (node == NUMA_NO_NODE)
+		folio = (struct folio *)alloc_pages(flags, order);
+	else
+		folio = (struct folio *)__alloc_pages_node(node, flags, order);
+
 	if (!folio)
 		return NULL;
 

---
base-commit: d74da846046aeec9333e802f5918bd3261fb5509
change-id: 20240806-numa_policy-5188f44ba0d8

Best regards,
-- 
Christoph Lameter <cl@gentwo.org>



