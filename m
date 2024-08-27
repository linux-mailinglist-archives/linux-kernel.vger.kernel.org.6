Return-Path: <linux-kernel+bounces-302959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FF1960588
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8B61F236C1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B889319DFB6;
	Tue, 27 Aug 2024 09:27:04 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD6E19D880
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724750824; cv=none; b=d9DUsAwjp6PFzH44SMAV+G92CNFjDm/kb82Lp7tF+/PsE7Z6udBIQZxYJkJS2+i8MJ2Z84ugH5PuuUmP7aqudDfr3HInokV4F/n2DEeQla7mB0RN9oFD2ArMJCxXDV6qAJXJ/uKaWz9doNF3vp1WRnmB0vjV4kdm9aJE7helefI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724750824; c=relaxed/simple;
	bh=jUK1kJgfhcwf8nhkQ4JSyJF9SwO8DOZ1x0fWmhdFtvw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=QdzSXD+hOzgsYvjsloeuLjDjdKsyKKLc7bzW5UbHZUwR3xU8W5XQSALE23yvsTkpCcz7vrdida0vvH8TPSIo5IwX9Laz2SiZK/GBYBUwPw4WoV7scDcy/5hLujv9u+s6b34hnnFA2RoaXQuUXZ7yRvV9sZNU5Pa199PWPU2EWGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5BE3C8B7B7;
	Tue, 27 Aug 2024 09:27:03 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1sisUM-00000004SLF-244v;
	Tue, 27 Aug 2024 05:27:46 -0400
Message-ID: <20240827092746.359657809@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 27 Aug 2024 05:27:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [for-next][PATCH 2/8] ring-buffer: Add magic and struct size to boot up meta data
References: <20240827092716.515115830@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Add a magic number as well as save the struct size of the ring_buffer_meta
structure in the meta data to also use as validation. Updating the magic
number could be used to force a invalidation between kernel versions, and
saving the structure size is also a good method to make sure the content
is what is expected.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Vincent Donnefort <vdonnefort@google.com>
Link: https://lore.kernel.org/20240815115032.0c197b32@rorschach.local.home
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index b16f301b8a93..c3a5e6cbb940 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -44,7 +44,11 @@
 
 static void update_pages_handler(struct work_struct *work);
 
+#define RING_BUFFER_META_MAGIC	0xBADFEED
+
 struct ring_buffer_meta {
+	int		magic;
+	int		struct_size;
 	unsigned long	text_addr;
 	unsigned long	data_addr;
 	unsigned long	first_buffer;
@@ -1627,6 +1631,13 @@ static bool rb_meta_valid(struct ring_buffer_meta *meta, int cpu,
 	unsigned long buffers_end;
 	int i;
 
+	/* Check the meta magic and meta struct size */
+	if (meta->magic != RING_BUFFER_META_MAGIC ||
+	    meta->struct_size != sizeof(*meta)) {
+		pr_info("Ring buffer boot meta[%d] mismatch of magic or struct size\n", cpu);
+		return false;
+	}
+
 	/* The subbuffer's size and number of subbuffers must match */
 	if (meta->subbuf_size != subbuf_size ||
 	    meta->nr_subbufs != nr_pages + 1) {
@@ -1858,6 +1869,9 @@ static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
 
 		memset(meta, 0, next_meta - (void *)meta);
 
+		meta->magic = RING_BUFFER_META_MAGIC;
+		meta->struct_size = sizeof(*meta);
+
 		meta->nr_subbufs = nr_pages + 1;
 		meta->subbuf_size = PAGE_SIZE;
 
-- 
2.43.0



