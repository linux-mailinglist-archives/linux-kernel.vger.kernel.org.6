Return-Path: <linux-kernel+bounces-247733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7999892D3BF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2CCB1F21664
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90539193453;
	Wed, 10 Jul 2024 14:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dfqx2H44"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B12193479
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 14:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720620153; cv=none; b=cKAlfOvDkpegwQt3kPJXE5c8IGgWsP0H+dATI9JlFGMWMHvLZdbtNQVAuCNmy/Tkwu574T5cZgxLXHtqAxrCyKP94IWp+nnAqzg/ce89xkZvFLutOa/Rc197nuEcQXLHBu9yQ7tUQtibB9/YAinDUp3Cubg5trbXiyfuY6hNTEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720620153; c=relaxed/simple;
	bh=3fFgDE4OsqEl0CR4v/BXkTgh23Wwzi2tM4TX4jOQH3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWAhrEJeFBqbUEra3M8fCzGmOytsECOVwNKHx9mmjDrED2o88RdrNoRxPymLPJ8XWfo0ttHkibKHxckivbkLLgm3BxNK42ILPWJCtesQvEG0RK69E+be0z63he8hjQ4ts0hO5XXQLuXtLoQZRgxDKl5HdF0gqtY9GaiKWlTiSCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dfqx2H44; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720620151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M2d3fQHOAvDigG9uiTalKtqbAMril6sAQN4aXRekhWQ=;
	b=Dfqx2H44jKVxcTwXctz26MIqoaZqhbz8veeN+Xtgi6cI20STyehELqIfwLV9IgWKuncxjC
	I/u6RLOBKVoqCWJ/6NUNIP4oi8jb6uE8COrQNYeADRMbPRJuPOnMMSFszHSEeBPP2t85DL
	dVRcYbpxQbIiEn8560AlGRX1cGGyQ6I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-14z2meJRPBCO_NDEQ5NO9Q-1; Wed,
 10 Jul 2024 10:02:28 -0400
X-MC-Unique: 14z2meJRPBCO_NDEQ5NO9Q-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C6FB019560B4;
	Wed, 10 Jul 2024 14:02:26 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.169])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A7CE11955F40;
	Wed, 10 Jul 2024 14:02:23 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 10 Jul 2024 16:00:50 +0200 (CEST)
Date: Wed, 10 Jul 2024 16:00:45 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org
Cc: clm@meta.com, jolsa@kernel.org, mingo@kernel.org, paulmck@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] uprobes: document the usage of mm->mmap_lock
Message-ID: <20240710140045.GA1084@redhat.com>
References: <20240710140017.GA1074@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710140017.GA1074@redhat.com>
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
---
 kernel/events/uprobes.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2c83ba776fc7..d52b624a50fa 100644
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
@@ -1046,7 +1046,12 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
 
 		if (err && is_register)
 			goto free;
-
+		/*
+		 * We take mmap_lock for writing to avoid the race with
+		 * find_active_uprobe(), install_breakpoint() must not
+		 * make is_trap_at_addr() true right after find_uprobe()
+		 * returns NULL.
+		 */
 		mmap_write_lock(mm);
 		vma = find_vma(mm, info->vaddr);
 		if (!vma || !valid_vma(vma, is_register) ||
-- 
2.25.1.362.g51ebf55



