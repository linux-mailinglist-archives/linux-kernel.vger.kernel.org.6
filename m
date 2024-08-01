Return-Path: <linux-kernel+bounces-271347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9E4944D22
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A973C1F220D1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7691A2C03;
	Thu,  1 Aug 2024 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KyrYUrFc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EC31A0B08
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722518843; cv=none; b=CWr7uHHzYnVjaS5d/X9V4wZAuVSaCC5PapBfCct7VcRWJZICjT9nL8G1vYnn+rtIEDN98x7ymbgcXOiV9r+vuV/PewmK0++5Ogk8Ea77WwLC/1nvMm/0v9djfnQaYtRtTVWqBflcjEbX2L4XVAZ9Buy9tCIMnwuMfe5PcJzgpsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722518843; c=relaxed/simple;
	bh=EvDNYmR42HE4naSm75Ml2Btl91ytbKt9RUifQ06yHdw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=I+zQqE2QTjuqbD4KHItrTmTw0MkZ1jms1xXz7/D0iigG5HsIEDKTgGexwus5bTbde4i4oi98WZ4c3BjHQHDzPsUUPvP2MEH3d4X0Z9Pdfz/mpwZukyJmow7El9tRWttUFNB4h7grf0O+3/6OjHBvTxxpHQTnyZKhjKzSpM2ZwLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KyrYUrFc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722518841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=c42aj6pyFXcFYL5sQGVA5IzXO4VBmsyOZu9LVbVjv3s=;
	b=KyrYUrFcdTMqLnbku/QbLdtEiUwtXdoIkjGbzRTgNzmcMBAeljvx3FXVIVwHwNY7tyk/Xp
	Lpbex0/c179zblGtS2pvG4rEGFpQx1SPPAEs1R1YFt1O+fuZw8MeRB6RYWJcoOSHx2scFq
	/wBNd/lbqxzJ3sud9cYruawgXgqUKyw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-ia4ygRDdMTOlcEjfeugLvQ-1; Thu,
 01 Aug 2024 09:27:16 -0400
X-MC-Unique: ia4ygRDdMTOlcEjfeugLvQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1FDD51954126;
	Thu,  1 Aug 2024 13:27:14 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.183])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D9F641955E80;
	Thu,  1 Aug 2024 13:27:10 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  1 Aug 2024 15:27:13 +0200 (CEST)
Date: Thu, 1 Aug 2024 15:27:09 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org
Cc: jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 1/9] uprobes: document the usage of mm->mmap_lock
Message-ID: <20240801132709.GA8780@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801132638.GA8759@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The comment above uprobe_write_opcode() is wrong, unapply_uprobe() calls
it under mmap_read_lock() and this is correct.

And it is completely unclear why register_for_each_vma() takes mmap_lock
for writing, add a comment to explain that mmap_write_lock() is needed to
avoid the following race:

	- A task T hits the bp installed by uprobe and calls
	  find_active_uprobe()

	- uprobe_unregister() removes this uprobe/bp

	- T calls find_uprobe() which returns NULL

	- another uprobe_register() installs the bp at the same address

	- T calls is_trap_at_addr() which returns true

	- T returns to handle_swbp() and gets SIGTRAP.

Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/events/uprobes.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 73cc47708679..73dd12b09a7b 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -453,7 +453,7 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
  * @vaddr: the virtual address to store the opcode.
  * @opcode: opcode to be written at @vaddr.
  *
- * Called with mm->mmap_lock held for write.
+ * Called with mm->mmap_lock held for read or write.
  * Return 0 (success) or a negative errno.
  */
 int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
@@ -1046,7 +1046,13 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
 
 		if (err && is_register)
 			goto free;
-
+		/*
+		 * We take mmap_lock for writing to avoid the race with
+		 * find_active_uprobe() which takes mmap_lock for reading.
+		 * Thus this install_breakpoint() can not make
+		 * is_trap_at_addr() true right after find_uprobe()
+		 * returns NULL in find_active_uprobe().
+		 */
 		mmap_write_lock(mm);
 		vma = find_vma(mm, info->vaddr);
 		if (!vma || !valid_vma(vma, is_register) ||
-- 
2.25.1.362.g51ebf55


