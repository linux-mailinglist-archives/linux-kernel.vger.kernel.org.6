Return-Path: <linux-kernel+bounces-411893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4B39D00D4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 21:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA8F4B2445A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 20:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C261991A9;
	Sat, 16 Nov 2024 20:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MROowqOo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wF73bzLY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MROowqOo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wF73bzLY"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C836C194C7A
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 20:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731789792; cv=none; b=ShFylF53W9+kSqCzhBipTOo3O1gpMv1IybTDVs8zeJPcztK8YseB7dDlNyCJ/A/H9EmiBVfWHHVkTX0hW+f2Jzeir0iiAAAwB6FOo3Xyy4k2kNIhKEEpx1JmNxlCG6MfyaOeTCxXaHPca1Ct8I/+KbIkl6gawJOTAi5tN9IN5DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731789792; c=relaxed/simple;
	bh=2EahUJJOrOkfFIR3e5ANYtbNPvpeojxSt0Xi35Sr2pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zs8J3grjjiqBV1MXmqzJlvP0X/vN0oLfQLI0hhZ3aqCCPfXTzVZkeP7+17pTC7TDm/AYG7MdntHwlsceqAtBAMjUSYGu8iNbk56mkvE1SnvzBySuh0TDKIeg5gWsXGhRvbSWBdiZ2X7/qY0VztAGozYt0ZdD4kmNp46zT+Cd2C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MROowqOo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wF73bzLY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MROowqOo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wF73bzLY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A020C1F7B5;
	Sat, 16 Nov 2024 20:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731789787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=l3Uo1DgVtUh5bUZgCCKsqx5cD/CVXDA1iUsbDZqVZjo=;
	b=MROowqOomWlSQ/aAPyddd3BUi3AwHPaZWQKT2hki6gOJT7GWdbqBaiFMqNmm5MXm7rcyG2
	d7jIIfOq1tQiPYWzmo87CXzClw35vgK8w9vnuYs8vqhoyCjq9xLbM2Y2tlB4UI+WxQfJgJ
	pB6kBQ1pCmtMa9WkEOuUk/gMh0ih8pc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731789787;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=l3Uo1DgVtUh5bUZgCCKsqx5cD/CVXDA1iUsbDZqVZjo=;
	b=wF73bzLYIZXenesyWELQYhs5JU02kKFbrdFzF1RbDUurr/uzy1vU4J/tvB7W9htnABM9Zz
	ek9zbqv1CLnecXBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MROowqOo;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wF73bzLY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731789787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=l3Uo1DgVtUh5bUZgCCKsqx5cD/CVXDA1iUsbDZqVZjo=;
	b=MROowqOomWlSQ/aAPyddd3BUi3AwHPaZWQKT2hki6gOJT7GWdbqBaiFMqNmm5MXm7rcyG2
	d7jIIfOq1tQiPYWzmo87CXzClw35vgK8w9vnuYs8vqhoyCjq9xLbM2Y2tlB4UI+WxQfJgJ
	pB6kBQ1pCmtMa9WkEOuUk/gMh0ih8pc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731789787;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=l3Uo1DgVtUh5bUZgCCKsqx5cD/CVXDA1iUsbDZqVZjo=;
	b=wF73bzLYIZXenesyWELQYhs5JU02kKFbrdFzF1RbDUurr/uzy1vU4J/tvB7W9htnABM9Zz
	ek9zbqv1CLnecXBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 803C0136D9;
	Sat, 16 Nov 2024 20:43:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pRORHtsDOWdcfgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Sat, 16 Nov 2024 20:43:07 +0000
Message-ID: <52be272d-009b-477b-9929-564f75208168@suse.cz>
Date: Sat, 16 Nov 2024 21:43:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] slab updates for 6.13
To: Sasha Levin <sashal@kernel.org>, brauner@kernel.org,
 viro@zeniv.linux.org.uk
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <03ec75a9-aade-4457-ac21-5649116afa98@suse.cz>
 <Zzi7BxJASrR_wbAQ@sashalap> <Zzi7zR0maqdCC3ME@sashalap>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <Zzi7zR0maqdCC3ME@sashalap>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A020C1F7B5
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,google.com,linux.com,kvack.org,vger.kernel.org,linux.dev,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 11/16/24 16:35, Sasha Levin wrote:
> [ Obviously I fat-fingered it and didn't add Christian or Al ]

I have found the problem and looks like I managed to force push an older
broken version of a branch, possibly due to switching between two computers.
Serves me well for amending in some last minute R-b tags. Doing git diff
@{u} to check for unexpected suprirses before pushing the result didn't help
this time, either I forgot or was blind.

I have deleted the slab-for-6.13 signed tag and pushed the fixed branch only
to -next. Thanks a lot Sasha for catching this early and please drop the
merge from the for-linus tree.

Thanks,
Vlastimil

> On Sat, Nov 16, 2024 at 10:32:23AM -0500, Sasha Levin wrote:
>>[ Adding Christian and Al ]
>>
>>On Fri, Nov 15, 2024 at 03:22:30PM +0100, Vlastimil Babka wrote:
>>>Hi Linus,
>>>
>>>please pull the latest slab updates from:
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.13
>>>
>>>One new feature and non-critical fixes (mostly related to debugging).
>>>No conflicts to be expected, AFAIK.
>>
>>After merging the last batch of pull requests which included VFS and
>>SLAB into my linus-next[1] tree I've started seeing consistent boot and
>>runtime failures both on LKFT[2] and KernelCI[3]. I'm going to start
>>bisection, but given the amount of content that went in it might take a
>>day or two.
>>
>>It seems that this is something in the interaction between VFS and SLAB:
>>
>>Boot failures:
>>
>>[    4.600870] __kmem_cache_create_args(ext4_groupinfo_4k) failed with error -22
>>[    4.602001] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-rc7 #1
>>[    4.602644] Hardware name: linux,dummy-virt (DT)
>>[    4.603346] Call trace:
>>[    4.603594]  dump_backtrace+0x108/0x190
>>[    4.604831]  show_stack+0x24/0x38
>>[    4.605104]  dump_stack_lvl+0x40/0xa0
>>[    4.605472]  dump_stack+0x18/0x28
>>[    4.605842]  __kmem_cache_create_args+0x21c/0x248
>>[    4.606235]  ext4_mb_init+0x118/0x720
>>[    4.606572]  ext4_fill_super+0x1550/0x17d8
>>[    4.606890]  get_tree_bdev_flags+0x138/0x1d8
>>[    4.607279]  get_tree_bdev+0x20/0x38
>>[    4.607643]  ext4_get_tree+0x24/0x38
>>[    4.608013]  vfs_get_tree+0x3c/0x108
>>[    4.608260]  do_new_mount+0x154/0x398
>>[    4.608622]  path_mount+0x258/0x4d0
>>[    4.609030]  init_mount+0x78/0xc8
>>[    4.609434]  do_mount_root+0xd4/0x1b0
>>[    4.609887]  mount_root_generic+0x110/0x308
>>[    4.610177]  mount_block_root+0x5c/0x78
>>[    4.610428]  mount_root+0x74/0xa8
>>[    4.610662]  prepare_namespace+0x8c/0xd8
>>[    4.610922]  kernel_init_freeable+0x10c/0x160
>>[    4.611197]  kernel_init+0x2c/0x1c0
>>[    4.611437]  ret_from_fork+0x10/0x20
>>[    4.612106] EXT4-fs: no memory for groupinfo slab cache
>>[    4.612757] EXT4-fs (vda): failed to initialize mballoc (-12)
>>
>>Runtime failures:
>>
>>__kmem_cache_create_args(ext4_groupinfo_1k) failed with error -22
>>CPU: 0 UID: 0 PID: 76 Comm: kunit_try_catch Tainted: G                 N 6.12.0-rc7 #1
>>Tainted: [N]=TEST
>>Hardware name: ARM-Versatile (Device Tree Support)
>>Call trace:
>> unwind_backtrace from show_stack+0x10/0x14
>> show_stack from dump_stack_lvl+0x34/0x3c
>> dump_stack_lvl from __kmem_cache_create_args+0x24c/0x2c4
>> __kmem_cache_create_args from ext4_mb_init+0xf4/0x690
>> ext4_mb_init from mbt_kunit_init+0x394/0x474
>> mbt_kunit_init from kunit_try_run_case+0x40/0x1d4
>> kunit_try_run_case from kunit_generic_run_threadfn_adapter+0x1c/0x34
>> kunit_generic_run_threadfn_adapter from kthread+0xe0/0x10c
>> kthread from ret_from_fork+0x14/0x28
>>Exception stack(0xd0981fb0 to 0xd0981ff8)
>>1fa0:                                     00000000 00000000 00000000 00000000
>>1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>>1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>>EXT4-fs: no memory for groupinfo slab cache
>>    # test_new_blocks_simple: failed to initialize: -12
>>------------[ cut here ]------------
>>kernel BUG at fs/ext4/mballoc.c:3283!
>>Internal error: Oops - BUG: 0 [#1] PREEMPT ARM
>>Modules linked in:
>>CPU: 0 UID: 0 PID: 77 Comm: kunit_try_catch Tainted: G                 N 6.12.0-rc7 #1
>>Tainted: [N]=TEST
>>Hardware name: ARM-Versatile (Device Tree Support)
>>PC is at ext4_mb_release+0x2f4/0x31c
>>LR is at mbt_kunit_exit+0x10/0x80
>>pc : [<c02239d4>]    lr : [<c022e758>]    psr: 60000113
>>sp : d0985f18  ip : d0985f30  fp : 00000000
>>r10: 00000000  r9 : d0811d50  r8 : c17cc000
>>r7 : c17cc000  r6 : c16be240  r5 : c1c761c0  r4 : d0811d44
>>r3 : ffff0fff  r2 : 00000000  r1 : c12d3fc0  r0 : 00000000
>>Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
>>Control: 00093177  Table: 00004000  DAC: 00000053
>>Register r0 information: NULL pointer
>>Register r1 information: non-slab/vmalloc memory
>>Register r2 information: NULL pointer
>>Register r3 information: non-paged memory
>>Register r4 information: 2-page vmalloc region starting at 0xd0810000 allocated at copy_process+0x170/0xdd4
>>Register r5 information: slab task_struct start c1c761c0 pointer offset 0 size 1728
>>Register r6 information: slab kmalloc-64 start c16be240 pointer offset 0 size 64
>>Register r7 information: slab kmalloc-1k start c17cc000 pointer offset 0 size 1024
>>Register r8 information: slab kmalloc-1k start c17cc000 pointer offset 0 size 1024
>>Register r9 information: 2-page vmalloc region starting at 0xd0810000 allocated at copy_process+0x170/0xdd4
>>Register r10 information: NULL pointer
>>Register r11 information: NULL pointer
>>Register r12 information: 2-page vmalloc region starting at 0xd0984000 allocated at copy_process+0x170/0xdd4
>>Process kunit_try_catch (pid: 77, stack limit = 0x(ptrval))
>>Stack: (0xd0985f18 to 0xd0986000)
>>5f00:                                                       c1440000 00000000
>>5f20: c102e680 c1c76638 d0985f68 c0c21734 00000003 00000000 00000004 d0811d44
>>5f40: c1c761c0 c16be240 d0811c88 c17cc000 d0811d50 00000000 00000000 c022e758
>>5f60: d0811d44 c1c761c0 c16be240 d0811c88 c039be9c d0811d50 00000000 c0399c0c
>>5f80: d0811d50 c039beb8 c16bf160 c0044a4c c16bf160 c004496c 00000000 00000000
>>5fa0: 00000000 00000000 00000000 c000854c 00000000 00000000 00000000 00000000
>>5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>>5fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
>>Call trace:
>> ext4_mb_release from mbt_kunit_exit+0x10/0x80
>> mbt_kunit_exit from kunit_try_run_case_cleanup+0x30/0x3c
>> kunit_try_run_case_cleanup from kunit_generic_run_threadfn_adapter+0x1c/0x34
>> kunit_generic_run_threadfn_adapter from kthread+0xe0/0x10c
>> kthread from ret_from_fork+0x14/0x28
>>Exception stack(0xd0985fb0 to 0xd0985ff8)
>>5fa0:                                     00000000 00000000 00000000 00000000
>>5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>>5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>>Code: e3a010c9 e3811c0e eb278c81 eaffff5d (e7f001f2)
>>---[ end trace 0000000000000000 ]---
>>
>>
>>[1] https://git.kernel.org/pub/scm/linux/kernel/git/sashal/linus-next.git/log/?h=linus-next
>>[2] https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.11-15430-gc12cd257292c/testrun/25849362/suite/boot/test/clang-19-lkftconfig/log
>>[3] https://kciapistagingstorage1.file.core.windows.net/early-access/baseline-x86-kcidebug-amd-6738b3dc1a48e7821930a51b/log.txt.gz?sv=2022-11-02&ss=f&srt=sco&sp=r&se=2026-10-18T13:36:18Z&st=2024-10-17T05:36:18Z&spr=https&sig=xFxYOOh5uXJWeN9I3YKAUvpGGQivo89HKZbD78gcxvc%3D
>>
>>-- 
>>Thanks,
>>Sasha
>>
> 


