Return-Path: <linux-kernel+bounces-412161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3BC9D04AF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 17:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BEEB28229F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 16:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F791DA314;
	Sun, 17 Nov 2024 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kiqwWdz7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CyEYIieF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="beepaNc/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IL18o+p1"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EB61D90B4
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 16:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731861750; cv=none; b=FKNFEaAYa01t9xTDtKsBDz3O/5CHWvzme+NtFoPqMxACf2aDJDWebxq+2sAxC8DvrJ4xPwkMUu0/IWC4hupe4OaXcUVasvIOfgp3C+sZ6F7L2AsIj+64kKfL+MBWoki9naWWfw/NTBWPleZRNrCaa4OFubcRTq8sMCQ9tzguidQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731861750; c=relaxed/simple;
	bh=hrKTC9vUngDZpamtnSUS+U/sDaYNdQZQFeqflQVgEkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J+D0w/NDnFI+xR4tZbace3eNxA4KzzsfBnT5pu1wxh9yRCyKRGTg6B4hwSo/Ybj6LA1hgSqVEK9tN2OIgkmPAbyWFXV7y8hTHScffV/GwEQxHUjWVHmJ3yPZz5rNXCj2IJTyurc9Wy8TLfsZPLS8u6sK1v/sTeUE/iq/p5+gZgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kiqwWdz7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CyEYIieF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=beepaNc/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IL18o+p1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 73AE021262;
	Sun, 17 Nov 2024 16:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731861744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fsGGRc2sM/xmwo/RSxKb68Fl8UeCiWFSKc3NrncSX+Q=;
	b=kiqwWdz7HRmOO+KwL5waquLQDCGWfTJYurv7RmqLfXbjOSpTf5RjBx+3wl5GN4kAl1mXYK
	pedVPj9vTnpKCsN6oN7Z6t/3Cm4jdlz3JbWdxERYYYGfH+sZItNh2t4HcFvyW7IaPcjhRT
	StvIYX6C4Ht/824Re551cOlD60cdhc0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731861744;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fsGGRc2sM/xmwo/RSxKb68Fl8UeCiWFSKc3NrncSX+Q=;
	b=CyEYIieFpJbGj1TqLstDuQNeNLNmuJ6Ff3QbU39Ewp1KmXeEVDDjq0p5ab+wCqKK8aWnN8
	1N1EYg2KNkZjlIAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="beepaNc/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IL18o+p1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731861743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fsGGRc2sM/xmwo/RSxKb68Fl8UeCiWFSKc3NrncSX+Q=;
	b=beepaNc//CLLsklQFDqj7VyiEg64oiDIrVKlGo181qK5PJG052kbgVvSqnU8vKu+445Dz+
	QoBFupweNxAFn2Q+MnDX11h/Ddv4UryQVWnTDlaWLSet5tegvY0uF3mw0C1d095lw90Ptv
	VJogXc9JQeKMfpfV4DDGQ5kEHwIRC28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731861743;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fsGGRc2sM/xmwo/RSxKb68Fl8UeCiWFSKc3NrncSX+Q=;
	b=IL18o+p14BMei9vB+HT4VB+wpoCAjETM0oOdlfzNr2WG9sl54UymriuP9JcReVX0rhtxop
	m9alZSWWfiywIeCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 446BD13297;
	Sun, 17 Nov 2024 16:42:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pCTwD+8cOmeQHgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Sun, 17 Nov 2024 16:42:23 +0000
Message-ID: <3b09bf98-9bd4-465b-b9c5-5483a6261dc7@suse.cz>
Date: Sun, 17 Nov 2024 17:42:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [mm, mmap] d4148aeab4:
 will-it-scale.per_process_ops 3888.9% improvement
Content-Language: en-US
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Michael Matz <matz@suse.de>,
 Gabriel Krisman Bertazi <gabriel@krisman.be>,
 Matthias Bodenbinder <matthias@bodenbinder.de>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Yang Shi <yang@os.amperecomputing.com>, Rik van Riel <riel@surriel.com>,
 Jann Horn <jannh@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Petr Tesarik <ptesarik@suse.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>, linux-mm@kvack.org,
 ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com,
 Pedro Falcato <pedro.falcato@gmail.com>
References: <202411072132.a8d2cf0f-oliver.sang@intel.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <202411072132.a8d2cf0f-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 73AE021262
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lists.linux.dev,intel.com,vger.kernel.org,linux-foundation.org,suse.de,krisman.be,bodenbinder.de,oracle.com,os.amperecomputing.com,surriel.com,google.com,suse.com,leemhuis.info,kvack.org,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[plt:email,suse.cz:mid,suse.cz:dkim,01.org:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 11/7/24 15:10, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a 3888.9% improvement of will-it-scale.per_process_ops on:
> 
> 
> commit: d4148aeab412432bf928f311eca8a2ba52bb05df ("mm, mmap: limit THP alignment of anonymous mappings to PMD-aligned sizes")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linux-next/master 5b913f5d7d7fe0f567dea8605f21da6eaa1735fb]
> 
> testcase: will-it-scale
> config: x86_64-rhel-8.3
> compiler: gcc-12
> test machine: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory
> parameters:
> 
> 	nr_task: 100%
> 	mode: process
> 	test: malloc1
> 	cpufreq_governor: performance

Since this report is now linked from youtube videos with 200k views, maybe
someone will appreciate reading about what's actually happening here, in
more detail that would be normally sufficient for linux-mm. Thanks to Pedro
who initially brought up what malloc1 does on IRC.

The test [1] just performs repeatedly a malloc()/free() of a 128MB large buffer.

#define SIZE (128UL * 1024 * 1024)

while(1) {
	void *addr = malloc(SIZE);
	assert(addr != NULL);
	free(addr);
}

We can compile the same code outside of the test, without the iterations,
but printing the addr and pausing the process so we can look at
/proc/$pid/smaps.

Before the commit was applied I get:

addr: 0x7f0f62a00010

And the corresponding area in smaps is:
7f0f62a00000-7f0f6aa01000 rw-p 00000000 00:00 0
Size:             131076 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                2048 kB
Pss:                2048 kB
Pss_Dirty:          2048 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:      2048 kB
Referenced:         2048 kB
Anonymous:          2048 kB
KSM:                   0 kB
LazyFree:              0 kB
AnonHugePages:      2048 kB
ShmemPmdMapped:        0 kB
FilePmdMapped:         0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
THPeligible:           1

We can notice the 128MB become 128MB+4kB and he address returned by malloc()
is offset by 16bytes (0x10) from the mmapped aread.
So we have
7f0f62a00000 - start of mmapped area
7f0f62a00010 - start of malloc()-returned buffer
7f0f6aa00010 - end of malloc()'d buffer (128MB)
7f0f6aa01000 - end of mmapped area

malloc() AFAIK would normally manage some large-ish arena allocated by a
single mmap() and give out addresses to smaller allocations from that, but
any request as large as 128MB is turned directly into a mmap(). But malloc()
has to remember how large the allocation was in order to turn free(addr)
into an appropriate munmap(addr, size), so it prepends the 16 byte header to
store the size, but any mmap() needs to be rounded up to page size so this
16 bytes become 4kB and the mmap() is not exactly 128MB but 4kB larger.

Before commit d4148aeab412, due to commit efa7df3e3bb5 the implementation is
that mmap() >= 2MB will have the start of the area aligned to 2MB, which we
can see from the address 7f0f62a00000 which is divisible by 2MB.
The fields Rss: 2048 kB and AnonHugePages: 2048 kB above also reveal that
when malloc() wrote its 16 byte header, a transparent hugepage (THP) was
allocated for the first 2MB of the area.

After commit d4148aeab412 we get

addr: 0x7fd7b9998010

7fd7b9998000-7fd7c199c000 rw-p 00000000 00:00 0
Size:             131088 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                  12 kB
Pss:                  12 kB
Pss_Dirty:            12 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:        12 kB
Referenced:           12 kB
Anonymous:            12 kB
KSM:                   0 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
FilePmdMapped:         0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
THPeligible:           1

Again mmap() was done with an extra page for the 16byte header, but the area
is no longer aligned to 2MB because the size of the area is not multiple of
2MB. Thus the header cannot be populated with a 2MB THP but only a 4kB base
page.

And that's the whole difference. The test allocates 128MB via malloc() but
doesn't actually touch the memory at all. So only the page with the header
is faulted, and obviously it's much faster to allocate and clear (write with
zeros, as the kernel has to do for userspace pages) a 4kB page instead of
2MB. But it's an artifact of the benchmark - we can assume a program that
allocates memory with malloc() would also use it, and then most of the 128MB
+ 4kB would get backed with THPs and the differences would largely disappear.

Also you might be wondering - if improvement was reported for malloc1 due to
d4148aeab412432, shouldn't have a regression been reported in the past for
efa7df3e3bb5? In fact it was, actually a multiple regressions for various
prior versions of the patch that eventually became commit efa7df3e3bb5, but
this particular one in malloc1 was (rightfully) dismissed as not important
enough [2]

[1] https://github.com/antonblanchard/will-it-scale/blob/master/tests/malloc1.c
[2] https://lore.kernel.org/all/87edv4r2ip.fsf@yhuang6-desk2.ccr.corp.intel.com/

> In addition to that, the commit also has significant impact on the following tests:
> 
> +------------------+---------------------------------------------------------------------------------------------+
> | testcase: change | stress-ng: stress-ng.radixsort.ops_per_sec 9.2% regression                                  |

BTW, nobody seems to have noticed this part, which looks like a regression
report :)

> | test machine     | 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory |
> | test parameters  | cpufreq_governor=performance                                                                |
> |                  | nr_threads=100%                                                                             |
> |                  | test=radixsort                                                                              |
> |                  | testtime=60s                                                                                |
> +------------------+---------------------------------------------------------------------------------------------+
> 
> 
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20241107/202411072132.a8d2cf0f-oliver.sang@intel.com
> 
> =========================================================================================
> compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
>   gcc-12/performance/x86_64-rhel-8.3/process/100%/debian-12-x86_64-20240206.cgz/lkp-cpl-4sp2/malloc1/will-it-scale
> 
> commit: 
>   15e8156713 ("mm: shrinker: avoid memleak in alloc_shrinker_info")
>   d4148aeab4 ("mm, mmap: limit THP alignment of anonymous mappings to PMD-aligned sizes")
> 
> 15e8156713cc3803 d4148aeab412432bf928f311eca 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  

<snip>

>      89.46           -89.3        0.20 ± 22%  perf-profile.children.cycles-pp.clear_page_erms

This confirms we are clearing much less memory (4KB instead of 2MB) because
we spend way less time in the clearing function.

> ***************************************************************************************************
> lkp-spr-r02: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
> =========================================================================================
> compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
>   gcc-12/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-spr-r02/radixsort/stress-ng/60s

And this is the regression report of another benchmark that nobody noticed.

> commit: 
>   15e8156713 ("mm: shrinker: avoid memleak in alloc_shrinker_info")
>   d4148aeab4 ("mm, mmap: limit THP alignment of anonymous mappings to PMD-aligned sizes")
> 
> 15e8156713cc3803 d4148aeab412432bf928f311eca 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>      18.98 ±  5%     +30.5%      24.78 ± 14%  sched_debug.cpu.clock.stddev
>       0.05 ±  7%    +886.3%       0.50 ± 86%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
>       1.14 ± 74%     -55.5%       0.51 ± 37%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
>     265008 ± 13%     -37.2%     166403 ± 22%  meminfo.Active
>     264976 ± 13%     -37.2%     166371 ± 22%  meminfo.Active(anon)
>    1315990           -63.8%     475807 ±  3%  meminfo.AnonHugePages

So we get fewer THPs but unlike the malloc1 test, this one seems to be
benefiting from them, so having fewer of them causes a regression.

Maybe it does mmap()'s of some unfortunate size like 3MB?
Before commit d4148aeab412 such mmap() would be guaranteed a THP for the
first 2MB and no THP's for the other 1MB, i.e.:
| [ 2 MB | 1 MB ]

But now the result can be [ 1.5MB | 1.5 MB ]
(where | is a 2MB boundary) hence no THP backing at all.

This probably just shows that no heuristic can be optimal for every possible
use case.

>     164713            -9.2%     149574        stress-ng.radixsort.ops
>       2745            -9.2%       2492        stress-ng.radixsort.ops_per_sec
>      78925          +289.9%     307739        stress-ng.time.minor_page_faults
>     327.88 ±  3%     -67.1%     107.89 ±  3%  numa-vmstat.node0.nr_anon_transparent_hugepages
>      63711 ± 11%     -40.7%      37791 ± 25%  numa-vmstat.node1.nr_active_anon
>     317.83 ±  3%     -60.5%     125.70 ±  8%  numa-vmstat.node1.nr_anon_transparent_hugepages
>     293623 ± 18%     +35.1%     396637 ± 14%  numa-vmstat.node1.nr_inactive_anon
>      63710 ± 11%     -40.7%      37791 ± 25%  numa-vmstat.node1.nr_zone_active_anon
>     293622 ± 18%     +35.1%     396635 ± 14%  numa-vmstat.node1.nr_zone_inactive_anon
>     668445 ±  3%     -67.1%     220222 ±  3%  numa-meminfo.node0.AnonHugePages
>    1317034 ± 13%     -23.2%    1010970 ± 16%  numa-meminfo.node0.AnonPages.max
>     254241 ± 11%     -40.5%     151233 ± 26%  numa-meminfo.node1.Active
>     254219 ± 11%     -40.5%     151227 ± 26%  numa-meminfo.node1.Active(anon)
>     647491 ±  3%     -60.4%     256719 ±  8%  numa-meminfo.node1.AnonHugePages
>    1170941 ± 18%     +35.3%    1583801 ± 14%  numa-meminfo.node1.Inactive
>    1170783 ± 18%     +35.3%    1583760 ± 14%  numa-meminfo.node1.Inactive(anon)
>      66923 ± 13%     -36.6%      42442 ± 22%  proc-vmstat.nr_active_anon
>     642.60           -63.8%     232.40 ±  3%  proc-vmstat.nr_anon_transparent_hugepages
>     597472 ±  2%      +5.6%     630776        proc-vmstat.nr_inactive_anon
>      66923 ± 13%     -36.6%      42442 ± 22%  proc-vmstat.nr_zone_active_anon
>     597472 ±  2%      +5.6%     630776        proc-vmstat.nr_zone_inactive_anon
>    1188533           +19.2%    1416356        proc-vmstat.numa_hit
>       2502           -63.5%     913.67        proc-vmstat.numa_huge_pte_updates
>     956729           +23.2%    1178316        proc-vmstat.numa_local
>    1495630 ±  2%     -54.0%     687360 ±  6%  proc-vmstat.numa_pte_updates
>     820025           +26.8%    1040066        proc-vmstat.pgfault
>       6.20            +9.6%       6.79        perf-stat.i.MPKI
>  4.203e+10            -6.8%  3.916e+10        perf-stat.i.branch-instructions
>       6.15            +0.2        6.30        perf-stat.i.branch-miss-rate%
>  2.636e+09            -6.2%  2.474e+09        perf-stat.i.branch-misses
>       2.56 ±  2%      +8.5%       2.77        perf-stat.i.cpi
>  2.444e+11            -6.9%  2.276e+11        perf-stat.i.instructions
>       0.40            -9.1%       0.36        perf-stat.i.ipc
>       2.20 ±  2%     +90.0%       4.18 ±  2%  perf-stat.i.metric.K/sec
>      10808           +45.4%      15713 ±  2%  perf-stat.i.minor-faults
>      10809           +45.4%      15713 ±  2%  perf-stat.i.page-faults
>       6.34            +7.9%       6.84        perf-stat.overall.MPKI
>      37.76            -0.6       37.12        perf-stat.overall.cache-miss-rate%
>       2.54            +9.9%       2.80        perf-stat.overall.cpi
>     401.20            +1.8%     408.57        perf-stat.overall.cycles-between-cache-misses
>       0.39            -9.0%       0.36        perf-stat.overall.ipc
>  4.134e+10 ±  2%      -7.4%  3.829e+10        perf-stat.ps.branch-instructions
>  2.592e+09            -6.7%  2.419e+09        perf-stat.ps.branch-misses
>  2.404e+11 ±  2%      -7.4%  2.226e+11        perf-stat.ps.instructions
>      10358           +36.2%      14109 ±  2%  perf-stat.ps.minor-faults
>      10358           +36.2%      14109 ±  2%  perf-stat.ps.page-faults
>  1.525e+13            -9.9%  1.374e+13        perf-stat.total.instructions
>       0.60 ± 10%      -0.3        0.28 ±100%  perf-profile.calltrace.cycles-pp.__perf_mmap__read_init.perf_mmap__read_init.perf_mmap__push.record__mmap_read_evlist.__cmd_record
>       0.71 ±  4%      +0.1        0.77 ±  3%  perf-profile.calltrace.cycles-pp.update_load_avg.task_tick_fair.sched_tick.update_process_times.tick_nohz_handler
>       1.25 ±  9%      +0.3        1.54 ±  4%  perf-profile.calltrace.cycles-pp.update_curr.task_tick_fair.sched_tick.update_process_times.tick_nohz_handler
>       0.26 ±100%      +0.3        0.57 ±  3%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
>       2.64 ±  6%      +0.4        3.09 ±  3%  perf-profile.calltrace.cycles-pp.task_tick_fair.sched_tick.update_process_times.tick_nohz_handler.__hrtimer_run_queues
>       0.08 ±223%      +0.5        0.55 ±  4%  perf-profile.calltrace.cycles-pp.account_user_time.update_process_times.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt
>       5.00 ±  6%      +0.7        5.75 ±  3%  perf-profile.calltrace.cycles-pp.sched_tick.update_process_times.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt
>       7.66 ±  5%      +1.1        8.72 ±  3%  perf-profile.calltrace.cycles-pp.update_process_times.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
>       8.10 ±  5%      +1.1        9.18 ±  3%  perf-profile.calltrace.cycles-pp.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
>       8.38 ±  5%      +1.1        9.51 ±  3%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
>      10.78 ±  5%      +1.3       12.08 ±  3%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
>      11.04 ±  5%      +1.3       12.36 ±  3%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
>      11.77 ±  5%      +1.4       13.19 ±  2%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
>      12.68 ±  5%      +1.6       14.23 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt
>      12.84            -0.4       12.47 ±  2%  perf-profile.children.cycles-pp.strcmp@plt
>       0.65 ± 10%      -0.2        0.50 ± 30%  perf-profile.children.cycles-pp.__perf_mmap__read_init
>       0.12 ±  3%      +0.0        0.14 ±  4%  perf-profile.children.cycles-pp.sched_clock
>       0.05 ±  8%      +0.0        0.08 ±  8%  perf-profile.children.cycles-pp.rb_next
>       0.09 ±  7%      +0.0        0.13 ± 10%  perf-profile.children.cycles-pp.timerqueue_del
>       0.20 ±  4%      +0.0        0.23 ±  4%  perf-profile.children.cycles-pp.lapic_next_deadline
>       0.40 ±  7%      +0.0        0.44 ±  5%  perf-profile.children.cycles-pp.handle_softirqs
>       0.42 ±  4%      +0.0        0.47 ±  5%  perf-profile.children.cycles-pp.native_irq_return_iret
>       0.20 ±  9%      +0.1        0.26 ±  6%  perf-profile.children.cycles-pp.__cgroup_account_cputime_field
>       0.12 ±  4%      +0.1        0.19 ± 10%  perf-profile.children.cycles-pp._raw_spin_lock
>       0.75 ±  4%      +0.1        0.82 ±  3%  perf-profile.children.cycles-pp.update_load_avg
>       0.40 ±  4%      +0.1        0.47 ±  2%  perf-profile.children.cycles-pp.hrtimer_active
>       0.34 ±  9%      +0.1        0.41 ±  5%  perf-profile.children.cycles-pp.irqtime_account_irq
>       0.52 ±  5%      +0.1        0.60 ±  3%  perf-profile.children.cycles-pp.__irq_exit_rcu
>       0.12 ±  9%      +0.1        0.20 ±  6%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
>       0.36 ±  2%      +0.1        0.44 ±  3%  perf-profile.children.cycles-pp.task_mm_cid_work
>       0.50 ±  6%      +0.1        0.58 ±  4%  perf-profile.children.cycles-pp.account_user_time
>       0.38 ±  2%      +0.1        0.48 ±  3%  perf-profile.children.cycles-pp.task_work_run
>       0.46 ±  2%      +0.1        0.56 ±  3%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
>       1.32 ±  9%      +0.3        1.64 ±  4%  perf-profile.children.cycles-pp.update_curr
>       2.76 ±  6%      +0.5        3.25 ±  3%  perf-profile.children.cycles-pp.task_tick_fair
>       5.24 ±  6%      +0.8        6.04 ±  3%  perf-profile.children.cycles-pp.sched_tick
>       7.99 ±  5%      +1.2        9.14 ±  3%  perf-profile.children.cycles-pp.update_process_times
>       8.45 ±  5%      +1.2        9.63 ±  3%  perf-profile.children.cycles-pp.tick_nohz_handler
>       8.75 ±  5%      +1.2        9.99 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
>      11.23 ±  5%      +1.4       12.66 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
>      11.50 ±  5%      +1.4       12.94 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
>      12.26 ±  5%      +1.6       13.82 ±  3%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
>      13.22 ±  5%      +1.7       14.92 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
>       6.12            -0.2        5.92 ±  2%  perf-profile.self.cycles-pp.strcmp@plt
>       0.09 ± 11%      +0.0        0.11 ±  6%  perf-profile.self.cycles-pp.__hrtimer_run_queues
>       0.10 ±  9%      +0.0        0.12 ±  5%  perf-profile.self.cycles-pp.task_tick_fair
>       0.05 ±  8%      +0.0        0.08 ± 10%  perf-profile.self.cycles-pp.rb_next
>       0.20 ±  4%      +0.0        0.23 ±  3%  perf-profile.self.cycles-pp.lapic_next_deadline
>       0.42 ±  4%      +0.0        0.47 ±  5%  perf-profile.self.cycles-pp.native_irq_return_iret
>       0.16 ± 14%      +0.1        0.21 ±  4%  perf-profile.self.cycles-pp.__cgroup_account_cputime_field
>       0.12 ±  4%      +0.1        0.18 ± 10%  perf-profile.self.cycles-pp._raw_spin_lock
>       0.24 ±  9%      +0.1        0.30 ±  7%  perf-profile.self.cycles-pp.irqtime_account_irq
>       0.40 ±  4%      +0.1        0.46 ±  3%  perf-profile.self.cycles-pp.hrtimer_active
>       0.10 ±  3%      +0.1        0.18 ±  8%  perf-profile.self.cycles-pp.hrtimer_interrupt
>       0.11 ± 11%      +0.1        0.20 ±  6%  perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
>       0.33 ±  3%      +0.1        0.42 ±  4%  perf-profile.self.cycles-pp.task_mm_cid_work
>       0.88 ± 11%      +0.2        1.05 ±  5%  perf-profile.self.cycles-pp.update_curr
> 
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


