Return-Path: <linux-kernel+bounces-254990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDDE933A34
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66816284333
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173EE14AD2B;
	Wed, 17 Jul 2024 09:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="icJJFF2s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/rdaItQA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KhxnLywC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GdFS0XDc"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA15E6F30C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 09:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721209356; cv=none; b=pBhH5Vvkf4s5rHnyvuQrKWQVhSddZPEMHKKdnqc8RkholcaHnGpfN8jCKCf3hcfCOCdcglOBh15CTP3BJPKB/c23TuRqlFe8wWmQ06u6MtSH3jCmuPTcg4ENsqI4fC6lDBmQSbgzPUxVdY6KVutu0U7G3znRdDfWAtOg1p+yMsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721209356; c=relaxed/simple;
	bh=sspJyK8TFHwmAFGvikmuCeyiJ9eRQYuqZRG+r/on2ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OobwXgZVtmQQyRiyOCQg88oPjRMewtnLLwMaoWoAnGoUm0DBhvIIpyfBkyy4IRyotyX5ciuCJHLPsysf2BWiH94FKomMTldG29GqnvCUh6Y2ESGAUwzuhjOO0nNtvVQ+CUYUIUO5aCcI0uvmxVvrUTAKRBp2k7BSLT2GQcO1cmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=icJJFF2s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/rdaItQA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KhxnLywC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GdFS0XDc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 66B331FB6B;
	Wed, 17 Jul 2024 09:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721209352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9XVwJi7kfw0rrgNbS0JDololCohcEdoMyzR8pUMrjfg=;
	b=icJJFF2scbWerqyyNazmPACgPWhxhM9zFILikyFeZ84EWjqqJpA/D50rNfuBkGwswMTZ31
	qFdBuryDWvHATVySg1G2WUKik9XxLTD3FnGbivs4JyasVZEQ4K/yjBWAiYlhbMkpqOJSmB
	4ZNtQ2NqHOIFgoh4+e6VHp1i3aC3E3M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721209352;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9XVwJi7kfw0rrgNbS0JDololCohcEdoMyzR8pUMrjfg=;
	b=/rdaItQA0HIWTt91ZU2qov4g5SiCYX5yNXDFqJ70YUpm1XpiD3+n8ikC4k8R8F1nKprayx
	7G5ljQjoq4MabsAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KhxnLywC;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GdFS0XDc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721209351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9XVwJi7kfw0rrgNbS0JDololCohcEdoMyzR8pUMrjfg=;
	b=KhxnLywCy1//+ZCCRkcoQZtCbN+xPwKLZ3suPAMPWmWKuWv349vuOcrY5GSIRiCLYOYbfX
	K4q4MJxdHVX9C8AYTn2G3altJ4215x+hPy4yrBHP25qAhjpv2zMmiBYw34CHylehSIZUZc
	g0pUP5/W/8EYkEJl7DdaKnOQkBnaC/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721209351;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9XVwJi7kfw0rrgNbS0JDololCohcEdoMyzR8pUMrjfg=;
	b=GdFS0XDcdUlvB7AK4yLvUXqOARYwC3xHmByPfZV7i7pOU1T0m4WGN7RoFCdGMYIP/vh+EK
	qKxLNoCuNZQrSKDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B307136E5;
	Wed, 17 Jul 2024 09:42:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ve4JEgeSl2YOKwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 17 Jul 2024 09:42:31 +0000
Message-ID: <3128c3c0-ede2-4930-a841-a1da56e797d7@suse.cz>
Date: Wed, 17 Jul 2024 11:42:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Hard and soft lockups with FIO and LTP runs on a large system
Content-Language: en-US
To: Bharata B Rao <bharata@amd.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, nikunj@amd.com,
 "Upadhyay, Neeraj" <Neeraj.Upadhyay@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, willy@infradead.org,
 yuzhao@google.com, kinseyho@google.com, Mel Gorman <mgorman@suse.de>,
 Mateusz Guzik <mjguzik@gmail.com>
References: <d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 66B331FB6B
X-Spam-Flag: NO
X-Spam-Score: -0.50
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.50 / 50.00];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,amd.com,linux-foundation.org,redhat.com,infradead.org,google.com,suse.de,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: 
X-Spamd-Bar: /

On 7/3/24 5:11 PM, Bharata B Rao wrote:
> Many soft and hard lockups are seen with upstream kernel when running a 
> bunch of tests that include FIO and LTP filesystem test on 10 NVME 
> disks. The lockups can appear anywhere between 2 to 48 hours. Originally 
> this was reported on a large customer VM instance with passthrough NVME 
> disks on older kernels(v5.4 based). However, similar problems were 
> reproduced when running the tests on bare metal with latest upstream 
> kernel (v6.10-rc3). Other lockups with different signatures are seen but 
> in this report, only those related to MM area are being discussed.
> Also note that the subsequent description is related to the lockups in 
> bare metal upstream (and not VM).
> 
> The general observation is that the problem usually surfaces when the 
> system free memory goes very low and page cache/buffer consumption hits 
> the ceiling. Most of the times the two contended locks are lruvec and 
> inode->i_lock spinlocks.
> 
> - Could this be a scalability issue in LRU list handling and/or page 
> cache invalidation typical to a large system configuration?

Seems to me it could be (except that ZONE_DMA corner case) a general
scalability issue in that you tweak some part of the kernel and the
contention moves elsewhere. At least in MM we have per-node locks so this
means 256 CPUs per lock? It used to be that there were not that many
(cores/threads) per a physical CPU and its NUMA node, so many cpus would
mean also more NUMA nodes where the locks contention would distribute among
them. I think you could try fakenuma to create these nodes artificially and
see if it helps for the MM part. But if the contention moves to e.g. an
inode lock, I'm not sure what to do about that then.

> - Are there any MM/FS tunables that could help here?
> 
> Hardware configuration
> ======================
> Dual socket  AMD EPYC 128 Core processor (256 cores, 512 threads)
> Memory: 1.5 TB
> 10 NVME - 3.5TB each
> available: 2 nodes (0-1)
> node 0 cpus: 0-127,256-383
> node 0 size: 773727 MB
> node 1 cpus: 128-255,384-511
> node 1 size: 773966 MB
> 
> Workload details
> ================
> Workload includes concurrent runs of FIO and a few FS tests from LTP.
> 
> FIO is run with a size of 1TB on each NVME partition with different 
> combinations of ioengine/blocksize/mode parameters and buffered-IO. 
> Selected FS tests from LTP are run on 256GB partitions of all NVME 
> disks. This is the typical NVME partition layout.
> 
> nvme2n1      259:4   0   3.5T  0 disk
> ├─nvme2n1p1  259:6   0   256G  0 part /data_nvme2n1p1
> └─nvme2n1p2  259:7   0   3.2T  0 part
> 
> Though many different runs exist in the workload, the combination that 
> results in the problem is buffered-IO run with sync engine.
> 
> fio -filename=/dev/nvme1n1p2 -direct=0 -thread -size=1024G \
> -rwmixwrite=30  --norandommap --randrepeat=0 -ioengine=sync -bs=4k \
> -numjobs=400 -runtime=25000 --time_based -group_reporting -name=mytest
> 
> Watchdog threshold was reduced to 5s to reproduce the problem early and 
> all CPU backtrace enabled.
> 
> Problem details and analysis
> ============================
> One of the hard lockups which was observed and analyzed in detail is this:
> 
> kernel: watchdog: Watchdog detected hard LOCKUP on cpu 284
> kernel: CPU: 284 PID: 924096 Comm: cat Not tainted 6.10.0-rc3-lruvec #9
> kernel: RIP: 0010:native_queued_spin_lock_slowpath+0x2b4/0x300
> kernel: Call Trace:
> kernel:  <NMI>
> kernel:  ? show_regs+0x69/0x80
> kernel:  ? watchdog_hardlockup_check+0x19e/0x360
> <SNIP>
> kernel:  ? native_queued_spin_lock_slowpath+0x2b4/0x300
> kernel:  </NMI>
> kernel:  <TASK>
> kernel:  ? __pfx_lru_add_fn+0x10/0x10
> kernel: _raw_spin_lock_irqsave+0x42/0x50
> kernel: folio_lruvec_lock_irqsave+0x62/0xb0
> kernel: folio_batch_move_lru+0x79/0x2a0
> kernel: folio_add_lru+0x6d/0xf0
> kernel: filemap_add_folio+0xba/0xe0
> kernel: __filemap_get_folio+0x137/0x2e0
> kernel: ext4_da_write_begin+0x12c/0x270
> kernel: generic_perform_write+0xbf/0x200
> kernel: ext4_buffered_write_iter+0x67/0xf0
> kernel: ext4_file_write_iter+0x70/0x780
> kernel: vfs_write+0x301/0x420
> kernel: ksys_write+0x67/0xf0
> kernel: __x64_sys_write+0x19/0x20
> kernel: x64_sys_call+0x1689/0x20d0
> kernel: do_syscall_64+0x6b/0x110
> kernel: entry_SYSCALL_64_after_hwframe+0x76/0x7e	kernel: RIP: 
> 0033:0x7fe21c314887
> 
> With all CPU backtraces enabled, many CPUs are waiting for lruvec_lock 
> acquisition. We measured the lruvec spinlock start, end and hold 
> time(htime) using sched_clock(), along with a BUG() if the hold time was 
> more than 10s. The below case shows that lruvec spin lock was held for ~25s.
> 
> kernel: vmscan: unlock_page_lruvec_irq: stime 27963327514341, etime 
> 27963324369895, htime 25889317166
> kernel: ------------[ cut here ]------------
> kernel: kernel BUG at include/linux/memcontrol.h:1677!
> kernel: Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> kernel: CPU: 21 PID: 3211 Comm: kswapd0 Tainted: G        W 
> 6.10.0-rc3-qspindbg #10
> kernel: RIP: 0010:shrink_active_list+0x40a/0x520
> 
> And the corresponding trace point for the above:
> kswapd0-3211    [021] dN.1. 27963.324332: mm_vmscan_lru_isolate: 
> classzone=0 order=0 nr_requested=1 nr_scanned=156946361 
> nr_skipped=156946360 nr_taken=1 lru=active_file
> 
> This shows that isolate_lru_folios() is scanning through a huge number 
> (~150million) of folios (order=0) with lruvec spinlock held. This is 
> happening because a large number of folios are being skipped to isolate 
> a few ZONE_DMA folios. Though the number of folios to be scanned is 
> bounded (32), there exists a genuine case where this can become 
> unbounded, i.e. in case where folios are skipped.
> 
> Meminfo output shows that the free memory is around ~2% and page/buffer 
> cache grows very high when the lockup happens.
> 
> MemTotal:       1584835956 kB
> MemFree:        27805664 kB
> MemAvailable:   1568099004 kB
> Buffers:        1386120792 kB
> Cached:         151894528 kB
> SwapCached:        30620 kB
> Active:         1043678892 kB
> Inactive:       494456452 kB
> 
> Often times, the perf output at the time of the problem shows heavy 
> contention on lruvec spin lock. Similar contention is also observed with 
> inode i_lock (in clear_shadow_entry path)
> 
> 98.98%  fio    [kernel.kallsyms]   [k] native_queued_spin_lock_slowpath
>     |
>      --98.96%--native_queued_spin_lock_slowpath
>         |
>          --98.96%--_raw_spin_lock_irqsave
>                    folio_lruvec_lock_irqsave
>                    |
>                     --98.78%--folio_batch_move_lru
>                         |
>                          --98.63%--deactivate_file_folio
>                                    mapping_try_invalidate
>                                    invalidate_mapping_pages
>                                    invalidate_bdev
>                                    blkdev_common_ioctl
>                                    blkdev_ioctl
>                                    __x64_sys_ioctl
>                                    x64_sys_call
>                                    do_syscall_64
>                                    entry_SYSCALL_64_after_hwframe
> 
> Some experiments tried
> ======================
> 1) When MGLRU was enabled many soft lockups were observed, no hard 
> lockups were seen for 48 hours run. Below is once such soft lockup.
> 
> kernel: watchdog: BUG: soft lockup - CPU#29 stuck for 11s! [fio:2701649]
> kernel: CPU: 29 PID: 2701649 Comm: fio Tainted: G             L 
> 6.10.0-rc3-mglru-irqstrc #24
> kernel: RIP: 0010:native_queued_spin_lock_slowpath+0x2b4/0x300
> kernel: Call Trace:
> kernel:  <IRQ>
> kernel:  ? show_regs+0x69/0x80
> kernel:  ? watchdog_timer_fn+0x223/0x2b0
> kernel:  ? __pfx_watchdog_timer_fn+0x10/0x10
> <SNIP>
> kernel:  </IRQ>
> kernel:  <TASK>
> kernel:  ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
> kernel:  ? native_queued_spin_lock_slowpath+0x2b4/0x300
> kernel:  _raw_spin_lock+0x38/0x50
> kernel:  clear_shadow_entry+0x3d/0x100
> kernel:  ? __pfx_workingset_update_node+0x10/0x10
> kernel:  mapping_try_invalidate+0x117/0x1d0
> kernel:  invalidate_mapping_pages+0x10/0x20
> kernel:  invalidate_bdev+0x3c/0x50
> kernel:  blkdev_common_ioctl+0x5f7/0xa90
> kernel:  blkdev_ioctl+0x109/0x270
> kernel:  x64_sys_call+0x1215/0x20d0
> kernel:  do_syscall_64+0x7e/0x130
> 
> This happens to be contending on inode i_lock spinlock.
> 
> Below preemptirqsoff trace points to preemption being disabled for more 
> than 10s and the lock in picture is lruvec spinlock.
> 
>      # tracer: preemptirqsoff
>      #
>      # preemptirqsoff latency trace v1.1.5 on 6.10.0-rc3-mglru-irqstrc
>      # --------------------------------------------------------------------
>      # latency: 10382682 us, #4/4, CPU#128 | (M:desktop VP:0, KP:0, SP:0 
> HP:0 #P:512)
>      #    -----------------
>      #    | task: fio-2701523 (uid:0 nice:0 policy:0 rt_prio:0)
>      #    -----------------
>      #  => started at: deactivate_file_folio
>      #  => ended at:   deactivate_file_folio
>      #
>      #
>      #                    _------=> CPU#
>      #                   / _-----=> irqs-off/BH-disabled
>      #                  | / _----=> need-resched
>      #                  || / _---=> hardirq/softirq
>      #                  ||| / _--=> preempt-depth
>      #                  |||| / _-=> migrate-disable
>      #                  ||||| /     delay
>      #  cmd     pid     |||||| time  |   caller
>      #     \   /        ||||||  \    |    /
>           fio-2701523 128...1.    0us$: deactivate_file_folio 
> <-deactivate_file_folio
>           fio-2701523 128.N.1. 10382681us : deactivate_file_folio 
> <-deactivate_file_folio
>           fio-2701523 128.N.1. 10382683us : tracer_preempt_on 
> <-deactivate_file_folio
>           fio-2701523 128.N.1. 10382691us : <stack trace>
>       => deactivate_file_folio
>       => mapping_try_invalidate
>       => invalidate_mapping_pages
>       => invalidate_bdev
>       => blkdev_common_ioctl
>       => blkdev_ioctl
>       => __x64_sys_ioctl
>       => x64_sys_call
>       => do_syscall_64
>       => entry_SYSCALL_64_after_hwframe
> 
> 2) Increased low_watermark_threshold to 10% to prevent system from 
> entering into extremely low memory situation. Although hard lockups 
> weren't seen, but soft lockups (clear_shadow_entry()) were still seen.
> 
> 3) AMD has a BIOS setting called NPS (Nodes per socket), using which a 
> socket can be further partitioned into smaller NUMA nodes. With NPS=4, 
> there will be four NUMA nodes in one socket, and hence 8 NUMA nodes in 
> the system. This was done to check if having more number of kswapd 
> threads working on lesser number of folios per node would make a 
> difference. However here too, multiple  soft lockups were seen (in 
> clear_shadow_entry() as seen in MGLRU case). No hard lockups were observed.
> 
> Any insights/suggestion into these lockups and suggestions are welcome!
> 
> Regards,
> Bharata.
> 


