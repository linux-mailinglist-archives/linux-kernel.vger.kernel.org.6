Return-Path: <linux-kernel+bounces-197650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E028D6D83
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 04:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04A061C2104A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 02:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ABE6FBE;
	Sat,  1 Jun 2024 02:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G2VyM7Q9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121B12914
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 02:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717209272; cv=none; b=D5OeZefhUqOYbR7oAErcIXkw90xS3rIlJkoHEGurS3yV7PXEtvmqJhDDNCyLCn+fdve/uo3kxesPJCkhf+qKiyCXWS15F5FLjtfsHRy1wiNYfZ/PvQr75w2cnvNVsixKYgtI4qDlM2xeim9XmkoFHtiJYgmfYZjzQzG38w9xvTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717209272; c=relaxed/simple;
	bh=VQa0k3H6f5HBMJoDWIzqFeyZtk8Unm224EOTfZugkLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYjnthNfIZLD+GH0H5EI+h/yA9h9yAL4HoDmkBENDO402ZDJG8eeZhEtqv0l1b2udyPkUsykre/ASrFtu8B9lGx1H3ZEOX7/3VjM4ErG3f3i97n+UGbo/qRuaYpgp/d/9gKZ+IroBbmTHEahkI1M05ETdvBhfLeFphbha8VCa9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G2VyM7Q9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717209269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NzTTL+MfzvlfKZfQtB4qseGdRfAHinOsvS8cm5FA5Qs=;
	b=G2VyM7Q9v6F2cRuqUanSOsMIcD7g2Nkq7CeXQDOOg1IJwiDQhKTArSfV2xx9gH0yMDbmp1
	tqIoY06o1dGN+eWsEFDkbLWpp4kZuJUFw9ABxRxZ9iOrLzvX5xdVrwraZTPfWpDaDJmxd3
	dtPMft3LoK0YvGDPXP/1PwEioD9dYVc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-VCSY1c3tOcKlKUnpHLrdyw-1; Fri,
 31 May 2024 22:34:22 -0400
X-MC-Unique: VCSY1c3tOcKlKUnpHLrdyw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A387B1C05129;
	Sat,  1 Jun 2024 02:34:21 +0000 (UTC)
Received: from localhost (unknown [10.72.116.39])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A5663C27;
	Sat,  1 Jun 2024 02:34:18 +0000 (UTC)
Date: Sat, 1 Jun 2024 10:34:15 +0800
From: Baoquan He <bhe@redhat.com>
To: Uladzislau Rezki <urezki@gmail.com>,
	"zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
	hailong liu <hailong.liu@oppo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
Subject: Re: [PATCHv3] mm: fix incorrect vbq reference in
 purge_fragmented_block
Message-ID: <ZlqIp9V1Jknm7axa@MiWiFi-R3L-srv>
References: <20240531030520.1615833-1-zhaoyang.huang@unisoc.com>
 <ZlmEp9nxKiG9gWFj@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlmEp9nxKiG9gWFj@pc636>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 05/31/24 at 10:04am, Uladzislau Rezki wrote:
> On Fri, May 31, 2024 at 11:05:20AM +0800, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > 
> > vmalloc area runs out in our ARM64 system during an erofs test as
> > vm_map_ram failed[1]. By following the debug log, we find that
> > vm_map_ram()->vb_alloc() will allocate new vb->va which corresponding
> > to 4MB vmalloc area as list_for_each_entry_rcu returns immediately
> > when vbq->free->next points to vbq->free. That is to say, 65536 times
> > of page fault after the list's broken will run out of the whole
> > vmalloc area. This should be introduced by one vbq->free->next point to
> > vbq->free which makes list_for_each_entry_rcu can not iterate the list
> > and find the BUG.
> > 
> > [1]
> > PID: 1        TASK: ffffff80802b4e00  CPU: 6    COMMAND: "init"
> >  #0 [ffffffc08006afe0] __switch_to at ffffffc08111d5cc
> >  #1 [ffffffc08006b040] __schedule at ffffffc08111dde0
> >  #2 [ffffffc08006b0a0] schedule at ffffffc08111e294
> >  #3 [ffffffc08006b0d0] schedule_preempt_disabled at ffffffc08111e3f0
> >  #4 [ffffffc08006b140] __mutex_lock at ffffffc08112068c
> >  #5 [ffffffc08006b180] __mutex_lock_slowpath at ffffffc08111f8f8
> >  #6 [ffffffc08006b1a0] mutex_lock at ffffffc08111f834
> >  #7 [ffffffc08006b1d0] reclaim_and_purge_vmap_areas at ffffffc0803ebc3c
> >  #8 [ffffffc08006b290] alloc_vmap_area at ffffffc0803e83fc
> >  #9 [ffffffc08006b300] vm_map_ram at ffffffc0803e78c0
> > 
> > Fixes: fc1e0d980037 ("mm/vmalloc: prevent stale TLBs in fully utilized blocks")
> > 
> > Suggested-by: Hailong.Liu <hailong.liu@oppo.com>
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> Is a problem related to run out of vmalloc space _only_ or it is a problem
> with broken list? From the commit message it is hard to follow the reason.

This should fix the broken list.

Hi Zhaoyang and Hailong,

Could any of you test below patch in your testing environment?

From b56dcc7d98c4dbb7ea197516bd129c30c0e9d1ef Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe@redhat.com>
Date: Fri, 31 May 2024 23:44:57 +0800
Subject: [PATCH] mm/vmalloc.c: add vb into appropriate vbq->free
Content-type: text/plain

The current vbq is organized into per-cpu data structure, including a xa
and list. However, its adding into vba->free list is not handled
correctly. The new vmap_block allocation could be done in one cpu, while
it's actually belong into anohter cpu's percpu vbq. Then the
list_for_each_entry_rcu() on the vbq->free and its deletion could cause
list breakage.

This fix the wrong vb adding to make it be added into expected
vba->free.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/vmalloc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index b921baf0ef8a..47659b41259a 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2547,6 +2547,14 @@ addr_to_vb_xa(unsigned long addr)
 	return &per_cpu(vmap_block_queue, index).vmap_blocks;
 }
 
+static struct vmap_block_queue *
+addr_to_vbq(unsigned long addr)
+{
+	int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
+
+	return &per_cpu(vmap_block_queue, index);
+}
+
 /*
  * We should probably have a fallback mechanism to allocate virtual memory
  * out of partially filled vmap blocks. However vmap block sizing should be
@@ -2626,7 +2634,7 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 		return ERR_PTR(err);
 	}
 
-	vbq = raw_cpu_ptr(&vmap_block_queue);
+	vbq = addr_to_vbq(va->va_start);
 	spin_lock(&vbq->lock);
 	list_add_tail_rcu(&vb->free_list, &vbq->free);
 	spin_unlock(&vbq->lock);
-- 
2.41.0


