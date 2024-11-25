Return-Path: <linux-kernel+bounces-420809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508CE9D8337
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E526E162A3E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A09191F91;
	Mon, 25 Nov 2024 10:14:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7052E191F7A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 10:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732529675; cv=none; b=fGW527yXcPcbyY5LCl26iNAM0cy2ELhrepw/+QzIS/we6o5IYjpGZ6Fk+N4xb7AW2f7auUat1Q4SSn0K9sSpzUuYwDBcT1OclHgd58XAIsJAypY5ZQvI3Z5tQNL3QZTarxbMnRFQhJxwlKevz0Zl2lf7Id3b3cGWw7Hq0muPE2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732529675; c=relaxed/simple;
	bh=Y4/XLbsaScdiBxglFuyvK84aAmSs6kUP33eKszZbNag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LftnLA5/bexNlDBuYy9598gEb0V3AuMu4TpRfwkS4WihDI7QkzWS0CN5hHgiES+4IDn7Ry2PEAxNeNmjMCfxkt5TywGTvKVDruk+gGsHRXgIhLl4er/ZiOmqw5FM5MXnLdMw6ZlIvI8fBxKXDCdxpwhp9N+r0A34GXmfK31h8yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D49BB1692;
	Mon, 25 Nov 2024 02:15:02 -0800 (PST)
Received: from [10.1.31.25] (e127648.arm.com [10.1.31.25])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F34343F5A1;
	Mon, 25 Nov 2024 02:14:29 -0800 (PST)
Message-ID: <40c9de6d-4a51-4623-bb8f-86d8faedca32@arm.com>
Date: Mon, 25 Nov 2024 10:14:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched/fair: Fix panic if NEXT_BUDDY enabled
To: Adam Li <adamli@os.amperecomputing.com>, peterz@infradead.org,
 mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
 patches@amperecomputing.com, cl@linux.com
References: <20241125021222.356881-1-adamli@os.amperecomputing.com>
 <20241125021222.356881-2-adamli@os.amperecomputing.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20241125021222.356881-2-adamli@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/24 02:12, Adam Li wrote:
> Enabling NEXT_BUDDY may trigger warning and kernel panic:
> 
> [  124.977300] cfs_rq->next->sched_delayed
> [  124.977310] WARNING: CPU: 51 PID: 2150 at kernel/sched/fair.c:5621 pick_task_fair+0x130/0x150
> <snip>
> [  297.371198] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000051
> [  297.406112] CPU: 116 UID: 0 PID: 10328 Comm: Grizzly-worker( Tainted: G        W   E      6.12.0.adam+ #1
> [  297.597362] Call trace:
> [  297.599795]  pick_task_fair+0x50/0x150 (P)
> [  297.603879]  pick_task_fair+0x50/0x150 (L)
> [  297.607963]  pick_next_task_fair+0x30/0x3c0
> [  297.612134]  __pick_next_task+0x4c/0x220
> [  297.616045]  pick_next_task+0x44/0x980
> [  297.619782]  __schedule+0x3d0/0x628
> [  297.623259]  do_task_dead+0x50/0x60
> [  297.626736]  do_exit+0x28c/0x410
> [  297.629955]  do_group_exit+0x3c/0xa0
> [  297.633518]  get_signal+0x8c4/0x8d0
> [  297.636996]  do_signal+0x9c/0x270
> [  297.640299]  do_notify_resume+0xe0/0x198
> [  297.644212]  el0_svc+0xf4/0x170
> [  297.647342]  el0t_64_sync_handler+0x10c/0x138
> [  297.651687]  el0t_64_sync+0x1ac/0x1b0
> [  297.655339] Code: d503201f 1400002a aa1403e0 97ffda0b (39414401)
> [  297.661439] ---[ end trace 0000000000000000 ]---
> [  297.726593] Kernel panic - not syncing: Oops: Fatal exception
> 
> Do not set next buddy if sched_delayed is set.
> 
> Signed-off-by: Adam Li <adamli@os.amperecomputing.com>

Should have a
Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
I assume.

> ---
>  kernel/sched/fair.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index fbdca89c677f..cd1188b7f3df 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8748,6 +8748,8 @@ static void set_next_buddy(struct sched_entity *se)
>  			return;
>  		if (se_is_idle(se))
>  			return;
> +		if (se->sched_delayed)
> +			return;
>  		cfs_rq_of(se)->next = se;
>  	}
>  }


