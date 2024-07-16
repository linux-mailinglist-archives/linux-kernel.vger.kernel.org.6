Return-Path: <linux-kernel+bounces-254157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE53932F9C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F6981C222CC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A840A1A01A2;
	Tue, 16 Jul 2024 18:03:05 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C771F171
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 18:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721152985; cv=none; b=e93b249UEM7agglkkN4Ds85UiA/pz5kEnoBpon/3cR3UapTHkeS+4x43h1bpQYHn2FFFoslJ5/Xisrd/cAqNvvS21UZY8jYyJjePxPEkpVPalv5Xe0lFtIMD06QdQgnpOIZCJoujGV3GZ9qW/gO7vCIwl93OwWJBWx+FB8p2IMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721152985; c=relaxed/simple;
	bh=7186V2TRd+OaiPmU8Xg5fvW4L5o7oZ6hBTVZpAjqFuk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ApNFNeCdBZwrMECQo8WQGxYLjpAVMW9VwSZGKW8nHh8dOQiAuicbO3/20s54oLyKRY4adXXzoMogWsmX4TSCTCpD3rmM3Uz04Uks2X9neABJ3DFCczQnAMyYXUj9kUK9hr3rZBnkxbZKUzKzqXPvRUEEw+afv40dBVknjQeqv5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D42C116B1;
	Tue, 16 Jul 2024 18:03:04 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1sTmW0-000000006uo-3zov;
	Tue, 16 Jul 2024 14:03:04 -0400
Message-ID: <20240716180304.814359868@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 16 Jul 2024 14:02:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thorsten Blum <thorsten.blum@toblux.com>
Subject: [for-next][PATCH 2/2] ring-buffer: Use vma_pages() helper function
References: <20240716180223.593493907@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Thorsten Blum <thorsten.blum@toblux.com>

Use the vma_pages() helper function and fix the following
Coccinelle/coccicheck warning reported by vma_pages.cocci:

  WARNING: Consider using vma_pages helper on vma

Rename the local variable vma_pages accordingly.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
Link: https://lore.kernel.org/20240709215657.322071-2-thorsten.blum@toblux.com
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index f3d772461a60..d59cf0023e38 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6920,7 +6920,7 @@ static int __rb_inc_dec_mapped(struct ring_buffer_per_cpu *cpu_buffer,
 static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 			struct vm_area_struct *vma)
 {
-	unsigned long nr_subbufs, nr_pages, vma_pages, pgoff = vma->vm_pgoff;
+	unsigned long nr_subbufs, nr_pages, nr_vma_pages, pgoff = vma->vm_pgoff;
 	unsigned int subbuf_pages, subbuf_order;
 	struct page **pages;
 	int p = 0, s = 0;
@@ -6946,11 +6946,11 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 	nr_subbufs = cpu_buffer->nr_pages + 1; /* + reader-subbuf */
 	nr_pages = ((nr_subbufs) << subbuf_order) - pgoff + 1; /* + meta-page */
 
-	vma_pages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
-	if (!vma_pages || vma_pages > nr_pages)
+	nr_vma_pages = vma_pages(vma);
+	if (!nr_vma_pages || nr_vma_pages > nr_pages)
 		return -EINVAL;
 
-	nr_pages = vma_pages;
+	nr_pages = nr_vma_pages;
 
 	pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
 	if (!pages)
-- 
2.43.0



