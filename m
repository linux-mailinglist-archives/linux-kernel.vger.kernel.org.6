Return-Path: <linux-kernel+bounces-262031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275D293BFBD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 817B4B22059
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856FA198E60;
	Thu, 25 Jul 2024 10:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KCqHpMdK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rft0rds3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="boopKtCl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gw6RwEkF"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74DF1741EF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 10:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721902311; cv=none; b=X/NhELxOQdjXNg5bNuSfOEBiHyczCLt1g/k4O5EVOjHCSf+GRAkyzL71aB6c1O3Ydfeolpqe6lXQmRk1cyTK+OexfVifLi8U6zs4ydqLxwukl3ZNjjTa8t/gjQ/oddk6C3X7jKtZFNbkCW/nRLQztlfGxDQdwDiI800NlznEHeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721902311; c=relaxed/simple;
	bh=E2iYsX2LnEqMOjEnSkb13cML/YnDpG1SP8VqKch8Z78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q5+huS2HmusewaFzXtBLkjdAXS0Lr+Tz5IA+xHjWnridM097bP5+vPDwh1pBtrDRutdE7DeTXQAj4xgVscNEzUkF03IiISvDSTWi9bF2ukEJN5SJ+WgMZzHWI1BRXPJjhyDrDFs7S2e4VZXGR2EkpOZ2Z6a6nm2d5X84gFRpfUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KCqHpMdK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rft0rds3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=boopKtCl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gw6RwEkF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E0F1A218FE;
	Thu, 25 Jul 2024 10:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721902306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=caWbHsFHHCJDEWLAxXgKUaIbe83BkRDPm47kHSMsBEM=;
	b=KCqHpMdKLzEgMks3oVc3EEsu1TFj4pCMJhTxMjau3B0kT+st3s9zMlmsr4LfA+kiahDHrC
	JM4gYN67SjNk2fa0kO2NnTnsf1H3nAh2s8HxVSyNPoxsnpcsKxR220CboZnyHRvk5H8kzq
	ij65IyL03ABVhAEpXX0uQ3U77lavGDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721902306;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=caWbHsFHHCJDEWLAxXgKUaIbe83BkRDPm47kHSMsBEM=;
	b=Rft0rds3lCiKvebBYzd+uSEl+3g1jdE6eRrzFKG/rdRPPfPKz52Z5IP7OnNH/YNxRv3tlP
	EP7F00LfyEI/VnDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=boopKtCl;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gw6RwEkF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721902305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=caWbHsFHHCJDEWLAxXgKUaIbe83BkRDPm47kHSMsBEM=;
	b=boopKtClLIIhpAABqpSCHJio645B2WYa+LODIYXy0I/DwYfslGUVYbjRaQjCffXvOuSnTt
	Bp6GQcHd0Uld6bwx1O5/qf4QHHsHkW6amAA/bKko4BXbrR/y7UPe0hdJEGT2KvU4ot4ymE
	MTCKUEnAIXlC5m9NI9enQreIeP30yQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721902305;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=caWbHsFHHCJDEWLAxXgKUaIbe83BkRDPm47kHSMsBEM=;
	b=gw6RwEkFYjpLiXHHbSfQGIZ6vJnSVJYQgGDxDjpObwbkWUpebG1vdl9GFgq/5C+yQMettw
	qe4cOfMv2wiaZFBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF4491368A;
	Thu, 25 Jul 2024 10:11:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ysxaLuEkomYJRQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 25 Jul 2024 10:11:45 +0000
Message-ID: <a939565a-cdab-4d8b-938e-38e3d837d653@suse.cz>
Date: Thu, 25 Jul 2024 12:11:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [mm/slub] 306c4ac989: stress-ng.seal.ops_per_sec
 5.2% improvement
To: kernel test robot <oliver.sang@intel.com>,
 Hyunmin Lee <hyunminlr@gmail.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Jeungwoo Yoo <casionwoo@gmail.com>, Sangyun Kim <sangyun.kim@snu.ac.kr>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>, Christoph Lameter
 <cl@linux.com>, David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
 ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
References: <202407251553.12f35198-oliver.sang@intel.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <202407251553.12f35198-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.20 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[intel.com,gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,intel.com,vger.kernel.org,gmail.com,snu.ac.kr,linux.com,google.com,kvack.org];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: E0F1A218FE
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: 0.20

On 7/25/24 10:04 AM, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a 5.2% improvement of stress-ng.seal.ops_per_sec on:
> 
> 
> commit: 306c4ac9896b07b8872293eb224058ff83f81fac ("mm/slub: create kmalloc 96 and 192 caches regardless cache size order")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

Well that's great news, but also highly unlikely that the commit would cause
such an improvement, as it only optimizes a once-per-boot operation of
create_kmalloc_caches(). Maybe there are secondary effects in different
order of slab cache creation resulting in some different cpu cache layout,
but such improvement could be machine and compiler specific and overall fragile.

> testcase: stress-ng
> test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
> parameters:
> 
> 	nr_threads: 100%
> 	testtime: 60s
> 	test: seal
> 	cpufreq_governor: performance
> 
> 
> 
> 
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240725/202407251553.12f35198-oliver.sang@intel.com
> 
> =========================================================================================
> compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
>   gcc-13/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-spr-r02/seal/stress-ng/60s
> 
> commit: 
>   844776cb65 ("mm/slub: mark racy access on slab->freelist")
>   306c4ac989 ("mm/slub: create kmalloc 96 and 192 caches regardless cache size order")
> 
> 844776cb65a77ef2 306c4ac9896b07b8872293eb224 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>       2.51 ± 27%      +1.9        4.44 ± 35%  mpstat.cpu.all.idle%
>     975100 ± 19%     +29.5%    1262643 ± 16%  numa-meminfo.node1.AnonPages.max
>     187.06 ±  4%     -11.5%     165.63 ± 10%  sched_debug.cfs_rq:/.runnable_avg.stddev
>       0.05 ± 18%     -40.0%       0.03 ± 58%  vmstat.procs.b
>   58973718            +5.2%   62024061        stress-ng.seal.ops
>     982893            +5.2%    1033732        stress-ng.seal.ops_per_sec
>   59045344            +5.2%   62095668        stress-ng.time.minor_page_faults
>     174957            +1.4%     177400        proc-vmstat.nr_slab_unreclaimable
>   63634761            +5.5%   67148443        proc-vmstat.numa_hit
>   63399995            +5.5%   66914221        proc-vmstat.numa_local
>   73601172            +6.1%   78073549        proc-vmstat.pgalloc_normal
>   59870250            +5.3%   63063514        proc-vmstat.pgfault
>   72718474            +6.0%   77106313        proc-vmstat.pgfree
>  1.983e+10            +1.3%   2.01e+10        perf-stat.i.branch-instructions
>   66023349            +5.6%   69728143        perf-stat.i.cache-misses
>  2.023e+08            +4.7%  2.117e+08        perf-stat.i.cache-references
>       7.22            -1.9%       7.08        perf-stat.i.cpi
>       9738            -5.6%       9196        perf-stat.i.cycles-between-cache-misses
>  8.799e+10            +1.6%  8.939e+10        perf-stat.i.instructions
>       0.14            +1.6%       0.14        perf-stat.i.ipc
>       8.71            +5.1%       9.16        perf-stat.i.metric.K/sec
>     983533            +4.7%    1029816        perf-stat.i.minor-faults
>     983533            +4.7%    1029816        perf-stat.i.page-faults
>       7.30           -18.4%       5.96 ± 44%  perf-stat.overall.cpi
>       9735           -21.3%       7658 ± 44%  perf-stat.overall.cycles-between-cache-misses
>       0.52            +0.1        0.62 ±  7%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.ftruncate64
>       0.56            +0.1        0.67 ±  7%  perf-profile.calltrace.cycles-pp.ftruncate64
>       0.34 ± 70%      +0.3        0.60 ±  7%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.ftruncate64
>      48.29            +0.6       48.86        perf-profile.calltrace.cycles-pp.__close
>      48.27            +0.6       48.84        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
>      48.27            +0.6       48.84        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
>      48.26            +0.6       48.83        perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
>       0.00            +0.6        0.58 ±  7%  perf-profile.calltrace.cycles-pp.__x64_sys_ftruncate.do_syscall_64.entry_SYSCALL_64_after_hwframe.ftruncate64
>      48.21            +0.6       48.80        perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
>      48.03            +0.6       48.68        perf-profile.calltrace.cycles-pp.dput.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      48.02            +0.6       48.66        perf-profile.calltrace.cycles-pp.__dentry_kill.dput.__fput.__x64_sys_close.do_syscall_64
>      47.76            +0.7       48.47        perf-profile.calltrace.cycles-pp.evict.__dentry_kill.dput.__fput.__x64_sys_close
>      47.19            +0.7       47.92        perf-profile.calltrace.cycles-pp._raw_spin_lock.evict.__dentry_kill.dput.__fput
>      47.11            +0.8       47.88        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.evict.__dentry_kill.dput
>       0.74            -0.3        0.48 ±  8%  perf-profile.children.cycles-pp.__munmap
>       0.69            -0.2        0.44 ±  9%  perf-profile.children.cycles-pp.__x64_sys_munmap
>       0.68            -0.2        0.44 ±  9%  perf-profile.children.cycles-pp.__vm_munmap
>       0.68            -0.2        0.45 ±  9%  perf-profile.children.cycles-pp.do_vmi_munmap
>       0.65            -0.2        0.42 ±  8%  perf-profile.children.cycles-pp.do_vmi_align_munmap
>       0.44            -0.2        0.28 ±  7%  perf-profile.children.cycles-pp.unmap_region
>       0.48            -0.1        0.36 ±  7%  perf-profile.children.cycles-pp.asm_exc_page_fault
>       0.42            -0.1        0.32 ±  7%  perf-profile.children.cycles-pp.do_user_addr_fault
>       0.42 ±  2%      -0.1        0.32 ±  7%  perf-profile.children.cycles-pp.exc_page_fault
>       0.38 ±  2%      -0.1        0.29 ±  7%  perf-profile.children.cycles-pp.handle_mm_fault
>       0.35 ±  2%      -0.1        0.27 ±  7%  perf-profile.children.cycles-pp.__handle_mm_fault
>       0.33 ±  2%      -0.1        0.26 ±  6%  perf-profile.children.cycles-pp.do_fault
>       0.21 ±  2%      -0.1        0.14 ±  8%  perf-profile.children.cycles-pp.lru_add_drain
>       0.22            -0.1        0.15 ± 11%  perf-profile.children.cycles-pp.alloc_inode
>       0.21 ±  2%      -0.1        0.15 ±  9%  perf-profile.children.cycles-pp.lru_add_drain_cpu
>       0.18 ±  2%      -0.1        0.12 ±  8%  perf-profile.children.cycles-pp.unmap_vmas
>       0.21 ±  2%      -0.1        0.14 ±  7%  perf-profile.children.cycles-pp.folio_batch_move_lru
>       0.17            -0.1        0.11 ±  8%  perf-profile.children.cycles-pp.unmap_page_range
>       0.16 ±  2%      -0.1        0.10 ±  9%  perf-profile.children.cycles-pp.zap_pte_range
>       0.16 ±  2%      -0.1        0.10 ±  9%  perf-profile.children.cycles-pp.zap_pmd_range
>       0.26 ±  2%      -0.1        0.20 ±  7%  perf-profile.children.cycles-pp.shmem_fault
>       0.50            -0.1        0.45 ±  8%  perf-profile.children.cycles-pp.mmap_region
>       0.26 ±  2%      -0.1        0.20 ±  7%  perf-profile.children.cycles-pp.__do_fault
>       0.26            -0.1        0.21 ±  6%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
>       0.19 ±  2%      -0.1        0.14 ± 14%  perf-profile.children.cycles-pp.write
>       0.22 ±  3%      -0.0        0.18 ±  5%  perf-profile.children.cycles-pp.shmem_alloc_and_add_folio
>       0.11 ±  4%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.mas_store_gfp
>       0.16 ±  2%      -0.0        0.12 ± 11%  perf-profile.children.cycles-pp.mas_wr_store_entry
>       0.14            -0.0        0.10 ± 10%  perf-profile.children.cycles-pp.mas_wr_node_store
>       0.08            -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.msync
>       0.06            -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.mas_find
>       0.12 ±  4%      -0.0        0.08 ± 11%  perf-profile.children.cycles-pp.inode_init_always
>       0.10 ±  3%      -0.0        0.07 ± 11%  perf-profile.children.cycles-pp.shmem_alloc_inode
>       0.16            -0.0        0.13 ±  9%  perf-profile.children.cycles-pp.__x64_sys_fcntl
>       0.11 ±  4%      -0.0        0.08 ± 11%  perf-profile.children.cycles-pp.shmem_file_write_iter
>       0.10 ±  4%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.do_fcntl
>       0.15            -0.0        0.13 ±  8%  perf-profile.children.cycles-pp.destroy_inode
>       0.16 ±  3%      -0.0        0.14 ±  7%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
>       0.22 ±  3%      -0.0        0.20 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>       0.08            -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.___slab_alloc
>       0.15 ±  3%      -0.0        0.12 ±  8%  perf-profile.children.cycles-pp.__destroy_inode
>       0.07 ±  7%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.__call_rcu_common
>       0.13 ±  2%      -0.0        0.11 ±  8%  perf-profile.children.cycles-pp.perf_event_mmap
>       0.09            -0.0        0.07 ±  9%  perf-profile.children.cycles-pp.memfd_fcntl
>       0.06            -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.native_irq_return_iret
>       0.08 ±  6%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.shmem_add_to_page_cache
>       0.12            -0.0        0.10 ±  6%  perf-profile.children.cycles-pp.perf_event_mmap_event
>       0.11 ±  3%      -0.0        0.09 ±  7%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
>       0.10            -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.uncharge_batch
>       0.12 ±  4%      -0.0        0.10 ±  6%  perf-profile.children.cycles-pp.entry_SYSCALL_64
>       0.05            +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.__d_alloc
>       0.05            +0.0        0.07 ± 10%  perf-profile.children.cycles-pp.d_alloc_pseudo
>       0.07            +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.file_init_path
>       0.06 ±  6%      +0.0        0.08 ±  8%  perf-profile.children.cycles-pp.security_file_alloc
>       0.07 ±  7%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.errseq_sample
>       0.04 ± 44%      +0.0        0.07 ± 10%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
>       0.09            +0.0        0.12 ±  5%  perf-profile.children.cycles-pp.init_file
>       0.15            +0.0        0.18 ±  7%  perf-profile.children.cycles-pp.common_perm_cond
>       0.15 ±  3%      +0.0        0.19 ±  8%  perf-profile.children.cycles-pp.security_file_truncate
>       0.20            +0.0        0.24 ±  7%  perf-profile.children.cycles-pp.notify_change
>       0.06            +0.0        0.10 ±  6%  perf-profile.children.cycles-pp.inode_init_owner
>       0.13            +0.0        0.18 ±  5%  perf-profile.children.cycles-pp.alloc_empty_file
>       0.10            +0.1        0.16 ±  7%  perf-profile.children.cycles-pp.clear_nlink
>       0.47            +0.1        0.56 ±  7%  perf-profile.children.cycles-pp.do_ftruncate
>       0.49            +0.1        0.59 ±  7%  perf-profile.children.cycles-pp.__x64_sys_ftruncate
>       0.59            +0.1        0.70 ±  7%  perf-profile.children.cycles-pp.ftruncate64
>       0.28            +0.1        0.40 ±  6%  perf-profile.children.cycles-pp.alloc_file_pseudo
>      98.62            +0.2       98.77        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>      98.58            +0.2       98.74        perf-profile.children.cycles-pp.do_syscall_64
>      48.30            +0.6       48.86        perf-profile.children.cycles-pp.__close
>      48.26            +0.6       48.83        perf-profile.children.cycles-pp.__x64_sys_close
>      48.21            +0.6       48.80        perf-profile.children.cycles-pp.__fput
>      48.04            +0.6       48.68        perf-profile.children.cycles-pp.dput
>      48.02            +0.6       48.67        perf-profile.children.cycles-pp.__dentry_kill
>      47.77            +0.7       48.47        perf-profile.children.cycles-pp.evict
>       0.30            -0.1        0.23 ±  7%  perf-profile.self.cycles-pp._raw_spin_lock
>       0.10 ±  4%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.__fput
>       0.08 ±  6%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.inode_init_always
>       0.06            -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.native_irq_return_iret
>       0.08            -0.0        0.06 ±  7%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>       0.09            -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
>       0.07            +0.0        0.09 ±  7%  perf-profile.self.cycles-pp.__shmem_get_inode
>       0.06 ±  7%      +0.0        0.09 ±  9%  perf-profile.self.cycles-pp.errseq_sample
>       0.15 ±  2%      +0.0        0.18 ±  7%  perf-profile.self.cycles-pp.common_perm_cond
>       0.03 ± 70%      +0.0        0.06 ±  7%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
>       0.06            +0.0        0.10 ±  7%  perf-profile.self.cycles-pp.inode_init_owner
>       0.10            +0.1        0.16 ±  6%  perf-profile.self.cycles-pp.clear_nlink
> 
> 
> 
> 
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
> 
> 


