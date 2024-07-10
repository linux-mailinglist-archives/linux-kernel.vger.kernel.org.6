Return-Path: <linux-kernel+bounces-247734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5C992D3C2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 858E3287892
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BB31946C3;
	Wed, 10 Jul 2024 14:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzoODdDS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22198193479
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 14:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720620177; cv=none; b=O6IKgEHdNP5rjqNaj4Fy+07E7Q1gDiC5ebXR0W4uQbLXJRubwD9d5WMLEiiJDYyqy2EdxByfOVaRR3vN11eZe7Ctqr/k8Uvhbx3ZKTIMzQK2lZdJh9pMxpnLrDLUT4e9tlasUGI/CGmwbUF2sasjx2EMho2N5zWMRc1ubCfPAWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720620177; c=relaxed/simple;
	bh=qQ79RzLBTWxB6Auh/T2Kou6a+uEjkroibsTjepEuM1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Al9T2klgCt1stnwXIRn/g85z2QuvIXeab/6om4qVhY4QZ7qHpcURph6Y3DkrcNmeqcR+Za2R9nJKbuuy3oyvmEDVqMC0rFIZuJ0oafVcf8qkzcVlJhBXaqj7rPVyZxUZW+fcRqOS18Zl47NReePGvgeDYCBE5WQFLe5hTFp3M7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gzoODdDS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720620175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5yFh0y+ODzvRZigdpubheI7oPQ5BzZkZLBnUPJoaMxI=;
	b=gzoODdDSc9742FV6I5XHe8AjCm3sO38Gw5MCD7E/n6cWuygGfojlRLynG0H9PjJF5eLU27
	tzIMjJm27BI+vyUwVF/LvnjUVE7mjIPtqX70zU19Lfos6llkbncsRZXxrMMImbZ8AXl14u
	R1jtiYQrGkLkWtz1X5dt+GU3X16DZ40=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-gYxavUMBMLOoLtjXA_AV_w-1; Wed,
 10 Jul 2024 10:02:50 -0400
X-MC-Unique: gYxavUMBMLOoLtjXA_AV_w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E38B41956048;
	Wed, 10 Jul 2024 14:02:48 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.169])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C28EA1955F6E;
	Wed, 10 Jul 2024 14:02:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 10 Jul 2024 16:01:12 +0200 (CEST)
Date: Wed, 10 Jul 2024 16:01:08 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org
Cc: clm@meta.com, jolsa@kernel.org, mingo@kernel.org, paulmck@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] uprobes: is_trap_at_addr: don't use
 get_user_pages_remote()
Message-ID: <20240710140108.GB1084@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

get_user_pages_remote() and the comment above it make no sense.

There is no task_struct passed into get_user_pages_remote() anymore, and
nowadays mm_account_fault() increments the current->min/maj_flt counters
regardless of FAULT_FLAG_REMOTE.

Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/events/uprobes.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index d52b624a50fa..1bdf386485d4 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -453,7 +453,7 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
  * @vaddr: the virtual address to store the opcode.
  * @opcode: opcode to be written at @vaddr.
  *
- * Called with mm->mmap_lock held for read or write.
+ * Called with mm->mmap_lock held.
  * Return 0 (success) or a negative errno.
  */
 int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
@@ -2024,13 +2024,7 @@ static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
 	if (likely(result == 0))
 		goto out;
 
-	/*
-	 * The NULL 'tsk' here ensures that any faults that occur here
-	 * will not be accounted to the task.  'mm' *is* current->mm,
-	 * but we treat this as a 'remote' access since it is
-	 * essentially a kernel access to the memory.
-	 */
-	result = get_user_pages_remote(mm, vaddr, 1, FOLL_FORCE, &page, NULL);
+	result = get_user_pages(vaddr, 1, FOLL_FORCE, &page);
 	if (result < 0)
 		return result;
 
-- 
2.25.1.362.g51ebf55



