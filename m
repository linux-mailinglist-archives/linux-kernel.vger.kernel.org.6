Return-Path: <linux-kernel+bounces-180004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 752E28C68B8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 153E5B22DDC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 14:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF29140374;
	Wed, 15 May 2024 14:31:10 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716CE140378
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715783470; cv=none; b=LdeDONkPR6BJeI9RUQPjW/Om0Xb/ZrSPtUIkfKr/FW01FArryK0rI0skVOseQAoeUoiE5ufvG+tjHFLL7C7navJUXhcxp4Mra/l5cvNpSApErohAi5WWkCHnr/rMy4LHrer1RXafdqE9TET9pOawhTSfvSLUxHBo7p0QkCvbfPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715783470; c=relaxed/simple;
	bh=nz8gc7LRRVeiI46Xu9az2XML2sycPRIUtnPJ3UZcVeE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=r31w9phHSl9vVkF+S/kZWigMIkPHMjyQGoMyFrGu/sArEhpb2pjRp5ekV1OX0atHdfYS2PiNpEpJCQRd0Ni6tdRVI7jeGKtlQ090QoDiM+JpvwtcMSYqFhBtABoML0BZRo0UrOJd3BWmRcCgmcra1HVHgQaauJ8jaslIFsS65h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8674C116B1;
	Wed, 15 May 2024 14:31:08 +0000 (UTC)
Date: Wed, 15 May 2024 10:31:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [for-next][PATCH] ring-buffer: Add cast to unsigned long addr
 passed to virt_to_page()
Message-ID: <20240515103102.08c0fdb9@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ring-buffer/for-next

Head SHA1: b9c6820f029abaabbc37646093866aa730ca0928


Steven Rostedt (Google) (1):
      ring-buffer: Add cast to unsigned long addr passed to virt_to_page()

----
 kernel/trace/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---------------------------
commit b9c6820f029abaabbc37646093866aa730ca0928
Author: Steven Rostedt (Google) <rostedt@goodmis.org>
Date:   Wed May 15 01:05:58 2024 -0400

    ring-buffer: Add cast to unsigned long addr passed to virt_to_page()
    
    The sub-buffer pages are held in an unsigned long array, and when it is
    passed to virt_to_page() a cast is needed.
    
    Link: https://lore.kernel.org/all/20240515124808.06279d04@canb.auug.org.au/
    Link: https://lore.kernel.org/linux-trace-kernel/20240515010558.4abaefdd@rorschach.local.home
    
    Cc: Masami Hiramatsu <mhiramat@kernel.org>
    Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Fixes: 117c39200d9d ("ring-buffer: Introducing ring-buffer mapping functions")
    Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index a02c7a52a0f5..7345a8b625fb 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6283,7 +6283,7 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 	}
 
 	while (p < nr_pages) {
-		struct page *page = virt_to_page(cpu_buffer->subbuf_ids[s]);
+		struct page *page = virt_to_page((void *)cpu_buffer->subbuf_ids[s]);
 		int off = 0;
 
 		if (WARN_ON_ONCE(s >= nr_subbufs)) {

