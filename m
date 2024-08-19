Return-Path: <linux-kernel+bounces-292763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4CB957402
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 20:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 780871F2232E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B6E188CBC;
	Mon, 19 Aug 2024 18:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="teiGkPjf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038624642D
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 18:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724093663; cv=none; b=RpoVhT93NusKg/VMR+bFDoh8SWGXTbXqoP61B5/kKLgzFGlzG2o1MTktpxi52dn7ZVivpuiluKgMdUZ4r/kkO70PkqImjLE9OOHmGFsev92SOVgyAVoyFTi8htApdqIcJAQNZMaznQIzMynlxkTkguoi4MCUa9WZzApfpAKgpLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724093663; c=relaxed/simple;
	bh=6JC+G78lYQvXrX0p9ZlscZB05JH8UcL3tgbe0KmdkyA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=X+EwEGt+c4tO4bCy1EodVDZl3d3aCM1jfuv8e/seaXMEYIYLhmVsJhSEmJGnMB7XyB2a6nzq3xQj964spvrkwvIqM5fGu3dcOOXqEe4SK7w7c+V3YPSJv9a9rQ8c95B4tLQWZmpqdU0GbmfChG8gg3uB8QixODYPCOY+rVwCYB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=teiGkPjf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A7CFC32782;
	Mon, 19 Aug 2024 18:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724093662;
	bh=6JC+G78lYQvXrX0p9ZlscZB05JH8UcL3tgbe0KmdkyA=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=teiGkPjfLVJq2XeDB7VSm/KfZ/oAfAbZt6lzqryPBr02saviiKQYnfz3os9oNjpG6
	 bpgo3rOXtUYtpM4Y+2D0BxvUlbeLrHIuo25GvpHNgQdgZD7DClylnNSitir/N2n7Eo
	 JjguwxbOJzq6TgmTJsr6fkgLH1ZP+cIA5kD/IBZww+GZa9iaUlsQj+kUMM+ibqJm/u
	 z3Ydxag2qiAMq4YZO6JWaPUAdJaAJoZE6Ua6CH4AZI4CF3QtM21sxUkSgvtrVDUeLZ
	 p4a+VBBqVvuATfRtbhIgNl8gTvL/Wu0wz7xlTsFyaGqWD6SRoOUl4V9fucUzxbnZi4
	 QRnnNNvw6N0cQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6848DC52D7C;
	Mon, 19 Aug 2024 18:54:22 +0000 (UTC)
From: Christoph Lameter via B4 Relay <devnull+cl.gentwo.org@kernel.org>
Date: Mon, 19 Aug 2024 11:54:05 -0700
Subject: [PATCH] Reenable NUMA policy support in the slab allocator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-numa_policy-v1-1-f096cff543ee@gentwo.org>
X-B4-Tracking: v=1; b=H4sIAMyUw2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCwMz3bzS3MT4gvyczORKXVNDC4s0E5OkRIMUCyWgjoKi1LTMCrBp0bG
 1tQCMAoOGXQAAAA==
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Pekka Enberg <penberg@kernel.org>, 
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Yang Shi <shy828301@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@kernel.org, 
 Christoph Lameter <cl@gentwo.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724093662; l=2013;
 i=cl@gentwo.org; s=20240811; h=from:subject:message-id;
 bh=OdcUj5iCsDbP03VJBF3jAH+o1SUhMTMBiGyFaXIVG7g=;
 b=gt+6QhcxVDLtFNAaF7Ic9x8x+uWCYrJj/boApPxkXOD0mMiKbIrYlvMiqR9Sh7PT1It4+B+Eo
 x0tBHn9Rn92DAmzESSk0AYEKhcsKgQLpO4nDXPiEsJ/U2J39Nf8okst
X-Developer-Key: i=cl@gentwo.org; a=ed25519;
 pk=I7gqGwDi9drzCReFIuf2k9de1FI1BGibsshXI0DIvq8=
X-Endpoint-Received: by B4 Relay for cl@gentwo.org/20240811 with
 auth_id=194
X-Original-From: Christoph Lameter <cl@gentwo.org>
Reply-To: cl@gentwo.org

From: Christoph Lameter <cl@gentwo.org>

Revert commit 8014c46ad991 ("slub: use alloc_pages_node() in alloc_slab_page()").

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
on a single numa node.

SLUB does not apply memory policies to individual object allocations.
However, it relies on the page allocators support of memory policies
through alloc_pages() to do the NUMA memory allocations on a per
folio or page level. SLUB also applies memory policies when retrieving
partial allocated slab pages from the partial list.

Fixes: 8014c46ad991 ("slub: use alloc_pages_node() in alloc_slab_page()")
Cc: stable@kernel.org
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
base-commit: b0da640826ba3b6506b4996a6b23a429235e6923
change-id: 20240806-numa_policy-5188f44ba0d8

Best regards,
-- 
Christoph Lameter <cl@gentwo.org>



