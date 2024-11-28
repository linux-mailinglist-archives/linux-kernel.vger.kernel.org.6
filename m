Return-Path: <linux-kernel+bounces-424565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5729DB5EE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B2BFB21354
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B9F1917E4;
	Thu, 28 Nov 2024 10:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vQG4CnAE"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9F11369BC
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 10:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732790771; cv=none; b=GkZX0bNtnOd1JgfhU6BWAb7CPFPcWDvkoobiH688qf2UMyu86cbR4bW4w6v5o8gUY4NzFqa76T8FJ9s4yqMq9vtp3eNgzdyuU8cuWoOHUC++B7y63tV2fA5dhkhzmFCljo2LCrTewX6lHCpBIP5uEMQl6DfpBjB1zGMquO/wtDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732790771; c=relaxed/simple;
	bh=1WRTiOrXdwygQLhQVpGNSfyvH4I9sX6aXBTEbmso+ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tW6YXDeGHTpVm0lDqw+49k94sJTGspO81ky/4/akj7kOu7MKt0lWQ7EDsDwYhbTjswVWXldicaxQ2j0CMXMswnyjMugvrajfVMz0VgNWb0gp/17OdMNE5A1Grh4hRt7S5eOGxUWoIz1a6+NhgcElMrAduEcIOZhQ90+KB/jMDdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vQG4CnAE; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732790764; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=GjZqfXphkHEiAyFbB3F2H8TyMIo/09iGJvnvAtph6I8=;
	b=vQG4CnAERub5vcqSgyaUj0YzZfp8HhHNhGRuPs07g7t+er9T38TAh+LiSb0pYYfjPkpyNSfAVdjNGlU8baC0OjfoXVZuyT+ddSyjxMxIYBxCRqno1DGiXD01uGwVe845mvgs60JMMPdnjHU97v/eyUcWvzwI783KJ4GUra6z/DQ=
Received: from 30.221.131.87(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WKPnVX5_1732790762 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 28 Nov 2024 18:46:03 +0800
Message-ID: <c6a9091e-8244-401b-9aac-f46dd1f5e464@linux.alibaba.com>
Date: Thu, 28 Nov 2024 18:46:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bad psi_group_cpu.tasks[NR_MEMSTALL] counter
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Christoph Hellwig <hch@lst.de>, Suren Baghdasaryan <surenb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org
References: <CAKPOu+8cD2CBcaerhwC0i7e0O4LU9oQg1w3J5RsV6qcZMEr2Uw@mail.gmail.com>
 <CAJuCfpGa55gpKHBE_0mwRPsf0f1Wp5UK7+w6N7yZi-7v31vNzw@mail.gmail.com>
 <CAKPOu+-DdwTCFDjW+ykKM5Da5wmLW3gSx5=x+fsSdaMEwUuvJw@mail.gmail.com>
 <CAJuCfpGDw7LLs2dTa+9F4J8ZaSV2YMq=-LPgOmNgrgL4P84V_Q@mail.gmail.com>
 <CAKPOu+8tvSowiJADW2RuKyofL_CSkm_SuyZA7ME5vMLWmL6pqw@mail.gmail.com>
 <CAJuCfpEBs3R8C910eiaXcSMPPrtbMjFLNYzYdPGJG+gw4WHM8A@mail.gmail.com>
 <20241121045109.GA20615@lst.de>
 <CAKPOu+-_X9cc723v_f_BW4CwfHJe_mi=+cbUBP2tZO-kEcyoMA@mail.gmail.com>
 <b8681f80-f2c5-44a0-b306-9f566dad65a6@linux.alibaba.com>
 <CAKPOu+9i69YEnSNJpeFffh6_+nONWnFRMk=SS4sBJP9-3nLD0g@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAKPOu+9i69YEnSNJpeFffh6_+nONWnFRMk=SS4sBJP9-3nLD0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/11/28 18:00, Max Kellermann wrote:
> On Thu, Nov 21, 2024 at 2:18 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>> Just saw this. I guess your _recent_ 6.11.9 bug is actually
>> related to EROFS since EROFS uses readahead_expand().  I think
>> your recent report was introduced by a recent backport fix
>> commit 9e2f9d34dd12 ("erofs: handle overlapped pclusters out of crafted images properly")
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.11.9&id=9cfa199bcbbbba31cbf97b2786f44f4464f3f29a
>>
>> bio can be NULL after this patch and causes
>> unbalanced psi_memstall_{enter,leave}().  It can be fixed as
>> (the diff below could be damaged due to my email client):
> 
> With your patch, the PSI warning (from Suren's debugging patch) fired
> again last night. Which means there may be other instances of this bug
> left.

Ok, but honestly that is somewhat strange, on the
EROFS side readahead_expand() can only be used in
.readahead() context and with the original
readahead_control.

I don't have more clues without more understanding
of psi memstall.  From my limited POV, the callers
of psi_memstall_{enter,leave}() all seem good.

Thanks,
Gao Xiang

> 
>   ------------[ cut here ]------------
>   Stall from readahead_expand+0xca/0x1d0 was never cleared
>   WARNING: CPU: 133 PID: 91645 at kernel/sched/psi.c:989
> psi_task_switch+0x126/0x230
>   Modules linked in:
>   CPU: 133 UID: 3221274747 PID: 91645 Comm: php-cgi8.1 Tainted: G
>   W          6.11.10-cm4all2-es+ #267
>   Tainted: [W]=WARN
>   Hardware name: Dell Inc. PowerEdge R7615/0G9DHV, BIOS 1.6.10 12/08/2023
>   RIP: 0010:psi_task_switch+0x126/0x230
>   Code: f6 75 e6 41 f6 44 24 18 80 74 36 41 f6 84 24 d0 08 00 00 02 74
> 2b 49 8b b4 24 d8 08 00 00 48 c7 c7 20 c8 8d a8 e8 fa 1f f9 ff <0f> 0b
> 41 f6 44 24 18 80 74 0d 41 f6 84 24 d0 08 00 00 02 74 02 0f
>   RSP: 0018:ffff96be9c28b9a8 EFLAGS: 00010086
>   RAX: 0000000000000000 RBX: 0000000000000085 RCX: 0000000000000027
>   RDX: ffff8997b995c8c8 RSI: 0000000000000001 RDI: ffff8997b995c8c0
>   RBP: 000000000000001c R08: 00000000ffff7fff R09: 0000000000000058
>   R10: 00000000ffff7fff R11: ffff899abd2a1000 R12: ffff891db3b85c00
>   R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>   FS:  0000000000000000(0000) GS:ffff8997b9940000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 00007f26d7aba480 CR3: 000000c07c61a006 CR4: 0000000000770ef0
>   PKRU: 55555554
>   Call Trace:
>    <TASK>
>    ? __warn+0x93/0x140
>    ? psi_task_switch+0x126/0x230
>    ? report_bug+0x174/0x1a0
>    ? handle_bug+0x53/0x90
>    ? exc_invalid_op+0x17/0x70
>    ? asm_exc_invalid_op+0x16/0x20
>    ? psi_task_switch+0x126/0x230
>    ? psi_task_switch+0x126/0x230
>    __schedule+0x980/0x10f0
>    do_task_dead+0x3e/0x40
>    do_exit+0x6ed/0x970
>    do_group_exit+0x2c/0x80
>    __x64_sys_exit_group+0x14/0x20
>    x64_sys_call+0x15aa/0x17b0
>    do_syscall_64+0x64/0x100
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    ? get_page_from_freelist+0x60e/0x1140
>    ? cgroup_rstat_updated+0x88/0x210
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    ? __mod_memcg_lruvec_state+0x91/0x140
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    ? __lruvec_stat_mod_folio+0x80/0xd0
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    ? folio_add_file_rmap_ptes+0x37/0xb0
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    ? set_pte_range+0xb7/0x280
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    ? next_uptodate_folio+0x83/0x270
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    ? filemap_map_pages+0x4a2/0x590
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    ? do_fault+0x291/0x4d0
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    ? __handle_mm_fault+0x31c/0x1060
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    ? __count_memcg_events+0x53/0xf0
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    ? handle_mm_fault+0xb6/0x280
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    ? do_user_addr_fault+0x386/0x610
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    ? exc_page_fault+0x6f/0x120
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   RIP: 0033:0x7f26dad48349
>   Code: Unable to access opcode bytes at 0x7f26dad4831f.
>   RSP: 002b:00007ffcd05a7848 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
>   RAX: ffffffffffffffda RBX: 00007f26dae429e0 RCX: 00007f26dad48349
>   RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
>   RBP: 0000000000000000 R08: fffffffffffffd48 R09: 000055c238e82190
>   R10: 00007f26d8a781a8 R11: 0000000000000246 R12: 00007f26dae429e0
>   R13: 00007f26dae482e0 R14: 000000000000001e R15: 00007f26dae482c8
>    </TASK>
>   ---[ end trace 0000000000000000 ]---


