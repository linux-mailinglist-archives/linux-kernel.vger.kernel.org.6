Return-Path: <linux-kernel+bounces-230090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3A3917838
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB7E61F22BEA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 05:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFE914601F;
	Wed, 26 Jun 2024 05:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hmXD50qC"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A84F13A88A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 05:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719380260; cv=none; b=j2UQeL8RPaD1jQxtJh6QWzhxBLvd+Iv7zAr3W6/E36VVwgPnEk6o6qp8MZ2FL/UnJ9Vtowxme6pwdUPorRBDNLPBBU6urlPM2FUyDq01nbC3DKiFC3xZ0RDLwDhW4BXKMpQgm+XfoiQ9pgciL09pVQ8zTRd9xt6PyjpRd3WQBUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719380260; c=relaxed/simple;
	bh=RTY/yvfyMQ5o179tVWeIp9p0ViSsWmHpI7C91AkxT1k=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NCSQVi/d/7VH2UWowqWpNuxxriFryXi/KruTzZrr7cKhKHzsI/YmYQOqNhaaWcgHLz1BW3LTWkEgJDt94bTUKG1qFv/FeK0ie6m+WNRcBj5hXc/zPALB8LuSod6Q+9uf0K1e5ulJFCvaSFVTyMYy4fWz6trqsPxqqcRSr55vybw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hmXD50qC; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-700d083b65bso216101a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 22:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719380258; x=1719985058; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y4aTud5LWrq6VGyg6i9gcG7sOZFpvQsDUArnq/2QbZw=;
        b=hmXD50qCo2YWUFtVz23VmNfUTm06roflHPBSl+goFOXnydUA4g3A3XV0Sj/lqH+hUy
         1GId3ikvzEGbMupgV8mjaUmOuBDJ2zsfa/9MgQhwk9OuiKWE2kKbC2vMDlgCWS10nise
         QWRX2o8VW7YneklJg3C2xanv8nGfkWo9de/uvRcqiyvSi1+7TfAJN2IgTa88/gkrjkSy
         GiSVlr/ezNzVJHO9M56xKRAu3ALfsCKNp7d6YZ0hhCgU4s9NyVhmFU4wOuNF+dr3crmF
         jlnWC8fXQKKZ0KuVsA6bhVRW44SfTwpPrPlRzoAB0OsoXDvARU6EERkJPWxcsIcSXr49
         u9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719380258; x=1719985058;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y4aTud5LWrq6VGyg6i9gcG7sOZFpvQsDUArnq/2QbZw=;
        b=NVwzWvBANw5f7phsc/C/9VLr/wjPLsxZikFZ9xhcOA/g3AbN4t5ppWU/nkK5UHcsrx
         PTHUfPZpf740gRfqmD3ptWPMwuqWX3Ff05ZI7OtHSIfel1IKRbSBh281xkkLliII8Wq5
         iRpl2CgG2Dcqi0jZ3BGb8qNCLRlmcfoRLddLPojvOa+Iy36m2sG0fnXOD0T0NCeGxo7j
         J7EmPOWEZkK/0k5ZWToOkN4HqzKucLFYRQsErYlze5GY2b4vb4mhVvaRpyHIj0m5pWoe
         SrJcjKN9s/nYGyOQySJQptM0toAXa07k5Ml8GuJxAbGn+bMLp7+bnidT+ASyVNBD+rU3
         iVIQ==
X-Gm-Message-State: AOJu0YxPxWdDbqd3WZCzpKt2Bkjh8eZr9oPccveyHaBO9WcGzP45sNgy
	pRFVnXp1Q1lFzdQFw91qw7BXLtK4J3DwKmtIIE3Bm5unKkaWtswenv7YDvuA7JZZ9xZ40H+pjRU
	W9Q==
X-Google-Smtp-Source: AGHT+IGzu28gP7RE3kh8nzWSReLvlaZjQZy9RuiTduOJQEB1Gnm3oBpqOYZ3JRLji80/43EeKU4AoA==
X-Received: by 2002:a9d:638f:0:b0:700:ce1b:9107 with SMTP id 46e09a7af769-700ce1b9273mr2225784a34.25.1719380257914;
        Tue, 25 Jun 2024 22:37:37 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-700cb95fce1sm296979a34.19.2024.06.25.22.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 22:37:36 -0700 (PDT)
Date: Tue, 25 Jun 2024 22:37:25 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
    linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com, 
    willy@infradead.org, chuck.lever@oracle.com, hughd@google.com
Subject: Re: [PATCH v3 00/16] Introduce a store type enum for the Maple
 tree
In-Reply-To: <20240618204750.79512-1-sidhartha.kumar@oracle.com>
Message-ID: <80926b22-a8d2-9992-eb5e-27e2c99cf460@google.com>
References: <20240618204750.79512-1-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 18 Jun 2024, Sidhartha Kumar wrote:

> This series is rebased on top of mm-unstable + the patch:
> maple_tree: modified return type of mas_wr_store_entry()[1]. Andrew could
> you add that patch to mm-unstable before merging this series.
> 
> v2[2] -> v3:
>   - fix new line issues throughout the series
>   - remove use of helper function in patch 13 

Please give tmpfs a try on the latest mm-unstable, with
CONFIG_DEBUG_ATOMIC_SLEEP=y (maybe some of the messages below come from
other config options like PROVE_LOCKING, but ATOMIC_SLEEP the main one).

To the un-maple-trained eye, this series simply replaces a working maple
tree preallocation scheme by a broken one, doing GFP_KERNEL allocations
while holding spinlock.  But I doubt that was the intention: maybe a line
of code has gone missing or something, and you can quickly unbreak it.

 BUG: sleeping function called from invalid context at include/linux/sched/mm.h:337
 in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 63, name: kdevtmpfs
 preempt_count: 1, expected: 0
 RCU nest depth: 0, expected: 0
 3 locks held by kdevtmpfs/63:
  #0: ffff8880008473f0 (sb_writers){.+.+}-{0:0}, at: mnt_want_write+0x19/0x40
  #1: ffff8880008a0888 (&type->i_mutex_dir_key/1){+.+.}-{3:3}, at: filename_create+0x8a/0x120
  #2: ffff8880008a0650 (&simple_offset_lock_class){+.+.}-{2:2}, at: mtree_alloc_cyclic+0x72/0xb0
 Preemption disabled at:
 [<ffffffff81138b94>] preempt_count_add+0x54/0x60
 CPU: 4 UID: 0 PID: 63 Comm: kdevtmpfs Not tainted 6.10.0-rc5-m25 #2
 Hardware name: LENOVO 20XXS3LA00/20XXS3LA00, BIOS N32ET91W (1.67 ) 02/02/2024
 Call Trace:
  <TASK>
  dump_stack_lvl+0x5d/0x80
  ? preempt_count_add+0x54/0x60
  dump_stack+0x10/0x20
  __might_resched+0x23b/0x260
  ? mas_alloc_nodes+0x71/0x160
  __might_sleep+0x56/0x60
  might_alloc+0x2a/0x40
  kmem_cache_alloc_noprof+0x28/0x190
  mas_alloc_nodes+0x71/0x160
  ? lock_is_held+0xc/0x10
  mas_node_count_gfp+0x2e/0x30
  mas_wr_preallocate+0x43/0x60
  mas_insert.isra.0+0x49/0xa0
  mas_alloc_cyclic+0x9c/0x100
  mtree_alloc_cyclic+0x92/0xb0
  simple_offset_add+0x3c/0x60
  shmem_mknod+0x55/0xb0
  vfs_mknod+0x9c/0xc0
  devtmpfs_work_loop+0x1c4/0x2a0
  ? trace_hardirqs_on+0x37/0x40
  ? _raw_spin_unlock_irqrestore+0x39/0x50
  ? complete_with_flags+0x40/0x50
  ? dmar_validate_one_drhd+0xa0/0xa0
  devtmpfsd+0x25/0x30
  kthread+0x100/0x110
  ? list_del_init+0x30/0x30
  ret_from_fork+0x22/0x40
  ? list_del_init+0x30/0x30
  ret_from_fork_asm+0x11/0x20

and lots more like that.

Thanks,
Hugh

