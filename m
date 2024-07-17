Return-Path: <linux-kernel+bounces-255434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC619340B0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 412BEB209E8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73886181D09;
	Wed, 17 Jul 2024 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNUGGr3x"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BFB2EAE5
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721234664; cv=none; b=gYPbIIJLbLPinuIhn6eeTMh0U5SOzIKCkk6/hhhCXeuk2vl/7CsoNx8FmfD1zHZwpQFyU3RN9IxXZCWFOMgYRYn3Owj8tS/f8l6Bm6kkAcORtbKcdtwGlcS0oUb9E4SUu8CFEoPB+rVs1cmveOOC6RAMLtOSEtQ/pwJM3by5H1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721234664; c=relaxed/simple;
	bh=rLnd0Dh2ASkhFZ8fdn+wJfO1inPn5vFbpYYLT8Mfm+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdk6pmRhoJj5w0APH3gOPaCQkFENm7j0gznUMkAqqH+EPPgJmbVtB1VZxJ5qMGTiPRLVSsB/GFX45H7KLkzkYfjIH6QO+iIS2IuexLA8XjgMyUlfjLmA16pCKH0SdJgvNG+6qpbRZD47oY1R+KTIA/YXl3g/m3q9BBxpIRCyrtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNUGGr3x; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-367921e5f97so528538f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 09:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721234661; x=1721839461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cFfYluthlwA2RVy6qc5qWtiAoAbqX1RAJ5c9inBp4sc=;
        b=mNUGGr3xxD+/L71OMXJlMI/3Cx+TFvfThU1laHseIaW4MbRaCGgFsXbM36lH53KPNr
         +MiHjr8H0u4gif9gw0dvlDi/O/37T12bHAagoVKvAhmCuVZmPjUJlaDVaHmGbUd5qCBh
         WLExqQWUraSMUgVrJDlTuqNNWKHux3EffrdLY8uTegKphQk9uOzVSP9v3217smO44IUj
         rlagii7W7GGEWTgl2VBt94waIvrcMIMh25RIneZ9bXtrHklwbDfPJqPsrSE1/jXXpxCD
         MoEy0JhlQr4DZl+lD2PWZ9VwgNjmZRgf4TRC3cg1++3CuQcNOgswAmhIFPnexkucfGhl
         ndiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721234661; x=1721839461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFfYluthlwA2RVy6qc5qWtiAoAbqX1RAJ5c9inBp4sc=;
        b=dlPOjmAGP2XvHchSZUO8aOoK4Ymj1zjckUsHBb1OafZNta4xs40L9fow2m+Ac7zbHE
         Uc76NndDt4xX6/qbAHxn2jSFFNJ1IaKHIQML2mV8lKGdq2CHa2oH6EwXkN2+2S2DS2Lq
         HiCnJQdFFqwE2tvBQost21MKO65A7Y/yTz42aEa1J3TVC8GBqUt0++vBTjZwnfmGOB/N
         RHxdlHwPa3EFPzeo6QH6L6SdCh65+vJbey8cJGoA1jpmxOkW4qQVzOPPa112lR+VMmL1
         kEhGsmh1vmX6Qx5+BxhQi1VEbd16yh2syN/UwbsBhMQWDN/u5WqYUt2IHJpm0YCz0DJg
         8MWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRsosrl/qjN6qcWG/O2bOm4qph1e5ESmQFPlMi8CLOVP7ndXTOd0xER2Nz6hlBhUnUuDzb47KlA9fqJ0dTC4rDOD+Pt3/uMON1KK1i
X-Gm-Message-State: AOJu0YwtkKoA1S/Jw5nFx9gWDQQ2JHC1EJP6rHhTZ2cj+rDT+2ful1DH
	IQObG61DV+bzOR4eIrSqD5VbDjpKlgCQlo5tn3UmKtCnPK13mNs5
X-Google-Smtp-Source: AGHT+IHM0649GqAgF7poVfYwbNHNNEIpOsttmVLHcOptNhloT99i/92dTKzOliYqvCTpM53GD6fg+w==
X-Received: by 2002:a05:6000:188f:b0:366:e4b4:c055 with SMTP id ffacd0b85a97d-36831735017mr929595f8f.7.1721234661091;
        Wed, 17 Jul 2024 09:44:21 -0700 (PDT)
Received: from ed.ac.uk ([2001:630:3c1:90:1614:6de0:61c7:40b0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368422c0297sm886129f8f.28.2024.07.17.09.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 09:44:20 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:44:18 +0100
From: Karim Manaouil <kmanaouil.dev@gmail.com>
To: Bharata B Rao <bharata@amd.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, nikunj@amd.com,
	"Upadhyay, Neeraj" <Neeraj.Upadhyay@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>, willy@infradead.org,
	yuzhao@google.com, kinseyho@google.com,
	Mel Gorman <mgorman@suse.de>, Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: Hard and soft lockups with FIO and LTP runs on a large system
Message-ID: <Zpf04pRIaEyxl5fo@ed.ac.uk>
References: <d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com>
 <3128c3c0-ede2-4930-a841-a1da56e797d7@suse.cz>
 <ca9b925f-4f14-4749-8f28-83fd21f8ce6a@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca9b925f-4f14-4749-8f28-83fd21f8ce6a@amd.com>

On Wed, Jul 17, 2024 at 04:01:05PM +0530, Bharata B Rao wrote:
> On 17-Jul-24 3:12 PM, Vlastimil Babka wrote:
> > On 7/3/24 5:11 PM, Bharata B Rao wrote:
> > > Many soft and hard lockups are seen with upstream kernel when running a
> > > bunch of tests that include FIO and LTP filesystem test on 10 NVME
> > > disks. The lockups can appear anywhere between 2 to 48 hours. Originally
> > > this was reported on a large customer VM instance with passthrough NVME
> > > disks on older kernels(v5.4 based). However, similar problems were
> > > reproduced when running the tests on bare metal with latest upstream
> > > kernel (v6.10-rc3). Other lockups with different signatures are seen but
> > > in this report, only those related to MM area are being discussed.
> > > Also note that the subsequent description is related to the lockups in
> > > bare metal upstream (and not VM).
> > > 
> > > The general observation is that the problem usually surfaces when the
> > > system free memory goes very low and page cache/buffer consumption hits
> > > the ceiling. Most of the times the two contended locks are lruvec and
> > > inode->i_lock spinlocks.
> > > 
> > > - Could this be a scalability issue in LRU list handling and/or page
> > > cache invalidation typical to a large system configuration?
> > 
> > Seems to me it could be (except that ZONE_DMA corner case) a general
> > scalability issue in that you tweak some part of the kernel and the
> > contention moves elsewhere. At least in MM we have per-node locks so this
> > means 256 CPUs per lock? It used to be that there were not that many
> > (cores/threads) per a physical CPU and its NUMA node, so many cpus would
> > mean also more NUMA nodes where the locks contention would distribute among
> > them. I think you could try fakenuma to create these nodes artificially and
> > see if it helps for the MM part. But if the contention moves to e.g. an
> > inode lock, I'm not sure what to do about that then.
> 
> See below...
> 
> > 
> <SNIP>
> > > 
> > > 3) AMD has a BIOS setting called NPS (Nodes per socket), using which a
> > > socket can be further partitioned into smaller NUMA nodes. With NPS=4,
> > > there will be four NUMA nodes in one socket, and hence 8 NUMA nodes in
> > > the system. This was done to check if having more number of kswapd
> > > threads working on lesser number of folios per node would make a
> > > difference. However here too, multiple  soft lockups were seen (in
> > > clear_shadow_entry() as seen in MGLRU case). No hard lockups were observed.
> 
> These are some softlockups seen with NPS4 mode.
> 
> watchdog: BUG: soft lockup - CPU#315 stuck for 11s! [kworker/315:1H:5153]
> CPU: 315 PID: 5153 Comm: kworker/315:1H Kdump: loaded Not tainted
> 6.10.0-rc3-enbprftw #12
> Workqueue: kblockd blk_mq_run_work_fn
> RIP: 0010:handle_softirqs+0x70/0x2f0
> Call Trace:
>   <IRQ>
>   __irq_exit_rcu+0x68/0x90
>   irq_exit_rcu+0x12/0x20
>   sysvec_apic_timer_interrupt+0x85/0xb0
>   </IRQ>
>   <TASK>
>   asm_sysvec_apic_timer_interrupt+0x1f/0x30
> RIP: 0010:iommu_dma_map_page+0xca/0x2c0
>   dma_map_page_attrs+0x20d/0x2a0
>   nvme_prep_rq.part.0+0x63d/0x940 [nvme]
>   nvme_queue_rq+0x82/0x210 [nvme]
>   blk_mq_dispatch_rq_list+0x289/0x6d0
>   __blk_mq_sched_dispatch_requests+0x142/0x5f0
>   blk_mq_sched_dispatch_requests+0x36/0x70
>   blk_mq_run_work_fn+0x73/0x90
>   process_one_work+0x185/0x3d0
>   worker_thread+0x2ce/0x3e0
>   kthread+0xe5/0x120
>   ret_from_fork+0x3d/0x60
>   ret_from_fork_asm+0x1a/0x30
> 
> 
> watchdog: BUG: soft lockup - CPU#0 stuck for 11s! [fio:19820]
> CPU: 0 PID: 19820 Comm: fio Kdump: loaded Tainted: G             L
> 6.10.0-rc3-enbprftw #12
> RIP: 0010:native_queued_spin_lock_slowpath+0x2b8/0x300
> Call Trace:
>   <IRQ>
>   </IRQ>
>   <TASK>
>   _raw_spin_lock+0x2d/0x40
>   clear_shadow_entry+0x3d/0x100
>   mapping_try_invalidate+0x11b/0x1e0
>   invalidate_mapping_pages+0x14/0x20
>   invalidate_bdev+0x40/0x50
>   blkdev_common_ioctl+0x5f7/0xa90
>   blkdev_ioctl+0x10d/0x270
>   __x64_sys_ioctl+0x99/0xd0
>   x64_sys_call+0x1219/0x20d0
>   do_syscall_64+0x51/0x120
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x7fc92fc3ec6b
>   </TASK>
> 
> The above one (clear_shadow_entry) has since been fixed by Yu Zhao and fix
> is in mm tree.
> 
> We had seen a couple of scenarios with zone lock contention from page free
> and slab free code paths, as reported here: https://lore.kernel.org/linux-mm/b68e43d4-91f2-4481-80a9-d166c0a43584@amd.com/
> 
> Would you have any insights on these?

Have you tried enabling memory interleaving policy for your workload?

Karim
PhD Student
Edinburgh University

