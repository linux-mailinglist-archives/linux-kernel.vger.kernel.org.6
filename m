Return-Path: <linux-kernel+bounces-196683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D538D5FDD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E9552889ED
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5A3156991;
	Fri, 31 May 2024 10:44:57 +0000 (UTC)
Received: from mail114-241.sinamail.sina.com.cn (mail114-241.sinamail.sina.com.cn [218.30.114.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A41713D63E
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 10:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717152296; cv=none; b=R2fEgbwSZrF8pYEJURW8xqMJIslcUqpLgHvVYRZWGjt+7vUMAtQ42U++bfB4metNkJMPHyRA6KfymyzPabNltNUB2IDKAxa5ckG8+h0Kb+s+vSBGAtg5HZKSz5N/AFtvW/sjJSCF0DyWAxCcF/sfs50wW7paDJysbmPSp7WQH/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717152296; c=relaxed/simple;
	bh=3koc1TsF2J7SGYHMkOo/f+8pN7RVEMmECowqVJA3/Qw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b48lGG67wXuTc+m/jMFldwiYj9RVdKjFfAyVctE7a4oq3PXXjWRNwKoSX8qHGyfmt/hl5O6GrR3KBW7xkHJE2OpsFQ91sZU/T5gnyBZ9pvMnCBnriifmsh1rcB53GBMH8qRY2g/fmvwAq2ikjGBGKNfmJdctMjwu9m9qWBy2o4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.65.235])
	by sina.com (172.16.235.24) with ESMTP
	id 6659AA1200007FB7; Fri, 31 May 2024 18:44:37 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4469045089358
X-SMAIL-UIID: 76A9980702114039A99F5F596098C318-20240531-184437-1
From: Hillf Danton <hdanton@sina.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: "zhaoyang . huang" <zhaoyang.huang@unisoc.com>,
	hailong liu <hailong.liu@oppo.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3] mm: fix incorrect vbq reference in purge_fragmented_block
Date: Fri, 31 May 2024 18:44:25 +0800
Message-Id: <20240531104425.3262-1-hdanton@sina.com>
In-Reply-To: <ZlmEp9nxKiG9gWFj@pc636>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 31. May 10:04, Uladzislau Rezki wrote:
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
>
> Could you please post a full trace or panic?

What they proposed looks correct IIUC

--- l/mm/vmalloc.c
+++ v/mm/vmalloc.c
@@ -2067,7 +2067,7 @@ static void *new_vmap_block(unsigned int
 		return ERR_PTR(err);
 	}
 
-	vbq = raw_cpu_ptr(&vmap_block_queue);
+	vbq = container_of(xa, struct vmap_block_queue, vmap_blocks);
 	spin_lock(&vbq->lock);
 	list_add_tail_rcu(&vb->free_list, &vbq->free);
 	spin_unlock(&vbq->lock);

