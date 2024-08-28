Return-Path: <linux-kernel+bounces-304783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A62D09624CC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D99871C23CA8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D6216B74B;
	Wed, 28 Aug 2024 10:23:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD14158DCD
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 10:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724840619; cv=none; b=chiGjpHHwJKlRAMo/8ZOd8WEcNafnRxFqMuTopC9lxOLOgZYtAiklNgbDoqjxGdlkgD7aPVHyHPVpvdO56MUV3qsXSTZo+YTgqLTjhIh3yO3Phu2ieugYXhH/KSajKSiWpkuF5I6nSwnQleS0wStRu3yUbBUguuY3KuOMUQsmnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724840619; c=relaxed/simple;
	bh=kPzJM2c0Obm6HprXy0/mVlTdPadhsamBGsBFswu7MYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hu6CYy+oSw5u6fs81JXc+D6YUKDjwGDux61N0CGZEQv/fO5NWKRtJt8iOatkC9KcosdMTp8nXtn3aLx2KdQlCwmbpxe+Nr8btgAifvA+IjmkNDgYcONHnyzLGSBnvcj3zdBmsV6ES0eFaXluX5xo1KjhtTQqiCsAj+n+qAhRFj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8750DA7;
	Wed, 28 Aug 2024 03:24:02 -0700 (PDT)
Received: from [10.57.48.229] (unknown [10.57.48.229])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECCC23F73B;
	Wed, 28 Aug 2024 03:23:34 -0700 (PDT)
Message-ID: <770da6f7-89f6-49b7-b8db-a7318abbd828@arm.com>
Date: Wed, 28 Aug 2024 11:23:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/deadline: fix the hang in dl_task_of
To: Huang Shijie <shijie@os.amperecomputing.com>, mingo@redhat.com
Cc: patches@amperecomputing.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 vineeth@bitbyteword.org, bristot@kernel.org, linux-kernel@vger.kernel.org
References: <20240828091141.12043-1-shijie@os.amperecomputing.com>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <20240828091141.12043-1-shijie@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/08/2024 10:11, Huang Shijie wrote:
> When we enable the schedstats, we will meet an OS hang like this:
>    --------------------------------------------------------
> 	[  134.104253] kernel BUG at kernel/sched/deadline.c:63!
> 	[  134.132013] ------------[ cut here ]------------
> 	[  134.133441]  x27: 0000000000000001
> 	[  134.138048] kernel BUG at kernel/sched/deadline.c:63!
> 	[  134.146478] x26: 0000000000000001 x25: 0000000000000000 x24: 0000000000000001
> 	[  134.153607] x23: 0000000000000001 x22: 0000000000000000 x21: 0000000000000001
> 	[  134.160734] x20: ffff007dbf1b6d00 x19: ffff007dbf1b7610 x18: 0000000000000014
> 	[  134.162027] ------------[ cut here ]------------
> 	[  134.167861] x17: 000000009deab6cd x16: 00000000527c9a1c x15: 00000000000000dc
> 	[  134.172473] kernel BUG at kernel/sched/deadline.c:63!
> 	[  134.179595] x14: 0000000001200011 x13: 0000000040001000 x12: 0000ffffb6df05bc
> 	[  134.191760] x11: ffff007dbf1b6d00 x10: ffff0001062dd2e8 x9 : ffff8000801215ac
> 	[  134.192036] ------------[ cut here ]------------
> 	[  134.198888] x8 : 0000000000000000 x7 : 0000000000000021 x6 : ffff0001764ed280
> 	[  134.203498] kernel BUG at kernel/sched/deadline.c:63!
> 	[  134.210622] x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff807d3dd24000
> 	[  134.222787] x2 : 000000028b77a140 x1 : 0000003400000000 x0 : ffff007dbf1b6c80
> 	[  134.229915] Call trace:
> 	[  134.232353]  dl_task_of.part.0+0x0/0x10
> 	[  134.236182]  dl_server_start+0x54/0x158
> 	[  134.240013]  enqueue_task_fair+0x138/0x420
> 	[  134.244100]  enqueue_task+0x44/0xb0
> 	[  134.247584]  wake_up_new_task+0x1c0/0x3a0
> 	[  134.251584]  kernel_clone+0xe8/0x3e8
> 	[  134.252022] ------------[ cut here ]------------
> 	[  134.255156]  __do_sys_clone+0x70/0xa8
> 	[  134.259764] kernel BUG at kernel/sched/deadline.c:63!
> 	[  134.263412]  __arm64_sys_clone+0x28/0x40
> 	[  134.272360]  invoke_syscall+0x50/0x120
> 	[  134.276101]  el0_svc_common+0x44/0xf8
> 	[  134.279753]  do_el0_svc+0x28/0x40
> 	[  134.283058]  el0_svc+0x40/0x150
> 	[  134.286195]  el0t_64_sync_handler+0x100/0x130
> 	[  134.290546]  el0t_64_sync+0x1a4/0x1a8
> 	[  134.294200] Code: 35ffffa2 17ffffe3 d4210000 17ffffb4 (d4210000)
> 	[  134.300283] ---[ end trace 0000000000000000 ]---
> 	[  134.304890] Kernel panic - not syncing: Oops - BUG: Fatal exception
> 	[  134.311147] SMP: stopping secondary CPUs
> 	[  135.365096] SMP: failed to stop secondary CPUs 8-9,16,30,43,86,88,121,149
> 	[  135.371884] Kernel Offset: disabled
> 	[  135.375361] CPU features: 0x00,00100003,80153d29,d75ffea7
> 	[  135.380749] Memory Limit: none
> 	[  135.383793] ---[ end Kernel panic - not syncing: Oops - BUG: Fatal exception ]
>    --------------------------------------------------------
> 
> In dl_server_start(), we set the dl_se->dl_server with 1. When schedstats
> is enabled, in the following:
>     dl_server_start() --> enqueue_dl_entity() --> update_stats_enqueue_dl()
> 	__schedstats_from_dl_se() -->dl_task_of()
> 
> we will meet the BUG_ON.
> 
> Since the fair task has already had its own schedstats, there is no need
> to track anything for the associated dl_server.
> 
> So add check in enqueue_dl_entity(), skip the update_stats_enqueue_dl()
> for a dl_server dl_se.
> 
> Tested this patch with memcached in Altra.
> 
> Fixes: 5f6bd380c7bd ("sched/rt: Remove default bandwidth control")
> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
> ---
> v1 --> v2:
>     Skip the update_stats_enqueue_dl() for a dl_server dl_se
>     in enqueue_dl_entity().
> 
>     Btw, the update_stats_{wait_start,wait_end}_dl has already had
>     the dl_server() check.
> 
>     The v1 link: https://lore.kernel.org/lkml/20240826021115.9284-1-shijie@os.amperecomputing.com/T/
> ---
>   kernel/sched/deadline.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 0f2df67f710b..cb9bd3a480dd 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2002,7 +2002,8 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
>   {
>   	WARN_ON_ONCE(on_dl_rq(dl_se));
>   
> -	update_stats_enqueue_dl(dl_rq_of_se(dl_se), dl_se, flags);
> +	if (!dl_server(dl_se))
> +		update_stats_enqueue_dl(dl_rq_of_se(dl_se), dl_se, flags);
>   
>   	/*
>   	 * Check if a constrained deadline task was activated

Thanks for the patch. I'm seeing the same crash and your fix looks good 
to me. Now it boots on my Juno board with CONFIG_SCHEDSTATS.

Reviewed- and Tested-by: Hongyan Xia <hongyan.xia2@arm.com>

