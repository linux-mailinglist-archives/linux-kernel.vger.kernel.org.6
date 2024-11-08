Return-Path: <linux-kernel+bounces-401949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5849C216D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1ADB1C23BEA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B298E1946CC;
	Fri,  8 Nov 2024 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Cw7Kfq2p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lwkyX4zU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Cw7Kfq2p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lwkyX4zU"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF86192593
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081618; cv=none; b=fBqOnUfkkTR9UsXqvi4qtb7LV+c8JW6ngxDMe7xI9cQ6Z7MG3OsbgZP16rElXJCMuBRb7X28wDw5PPtpiBjRbcvwwZY0Agk89bu6Z/eMIu24LAstbXkmPSNqVc+ybYGyf1cvyIYukXDGkpDOnTshDwP1fPfWbtWtVZqvzors2as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081618; c=relaxed/simple;
	bh=wVgJMYLPzIFiSbqF1BpF3NeKF3domlqgvkLQJqgye9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jKcSSRILGZR3r3UBcT8q3U2E7DfG2vSApt9eK8RtQ93QmkktTK9sYiwbY+pTorKxvSZ1PZo7guvdf6Emjt3uuuECgEN4ZwBG2siHuxtW3e+uHbqIl47w5eOTbJz/mvIUxHoEMMhcCIyPHz3qDlnnx2eb06agDKHHS7YuLp2l6BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Cw7Kfq2p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lwkyX4zU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Cw7Kfq2p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lwkyX4zU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9169021CCC;
	Fri,  8 Nov 2024 16:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731081611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v3jnqR1uH7//51ZGQAIg7SNFQ0QCOmeA+yva2hZHnZI=;
	b=Cw7Kfq2p43wQAKXjjUJM8EUkYWi9cxU5cdRiYD3SlCh7hAiUklMoGuUUO8+wpl2wasmfYr
	3dQVs1Ef0Jbrzg8zc98fcuBABS5uSkkiueysgiImQZR5bqx7GVIq2kxkJgXG2HVXAPTvvN
	fWWpwqR+bRHwzMm6tw+NpSxQMcwG6Ks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731081611;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v3jnqR1uH7//51ZGQAIg7SNFQ0QCOmeA+yva2hZHnZI=;
	b=lwkyX4zU1bVupNGBGUsJuh4XUsfS0RVvTjgOIdaQvL3CTR7bnC9TQc77SbkNdMtEcVcvHw
	LV6M+HWQJsUHtnBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731081611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v3jnqR1uH7//51ZGQAIg7SNFQ0QCOmeA+yva2hZHnZI=;
	b=Cw7Kfq2p43wQAKXjjUJM8EUkYWi9cxU5cdRiYD3SlCh7hAiUklMoGuUUO8+wpl2wasmfYr
	3dQVs1Ef0Jbrzg8zc98fcuBABS5uSkkiueysgiImQZR5bqx7GVIq2kxkJgXG2HVXAPTvvN
	fWWpwqR+bRHwzMm6tw+NpSxQMcwG6Ks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731081611;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v3jnqR1uH7//51ZGQAIg7SNFQ0QCOmeA+yva2hZHnZI=;
	b=lwkyX4zU1bVupNGBGUsJuh4XUsfS0RVvTjgOIdaQvL3CTR7bnC9TQc77SbkNdMtEcVcvHw
	LV6M+HWQJsUHtnBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6171113967;
	Fri,  8 Nov 2024 16:00:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D/sUF4s1LmemIwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 08 Nov 2024 16:00:11 +0000
Message-ID: <d09fb32e-ca76-4453-9f27-670ba1557da6@suse.cz>
Date: Fri, 8 Nov 2024 17:00:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] sched/numa: Fix memory leak due to the overwritten
 vma->numab_state
Content-Language: en-US
To: Adrian Huang <adrianhuang0701@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Raghavendra K T <raghavendra.kt@amd.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Adrian Huang <ahuang12@lenovo.com>,
 Jiwei Sun <sunjw10@lenovo.com>
References: <20241108133139.25326-1-ahuang12@lenovo.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20241108133139.25326-1-ahuang12@lenovo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.26 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.16)[-0.811];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,infradead.org,linaro.org,linux-foundation.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -4.26
X-Spam-Flag: NO

On 11/8/24 14:31, Adrian Huang wrote:
> From: Adrian Huang <ahuang12@lenovo.com>
> 
> [Problem Description]
> When running the hackbench program of LTP, the following memory leak is
> reported by kmemleak.
> 
>   # /opt/ltp/testcases/bin/hackbench 20 thread 1000
>   Running with 20*40 (== 800) tasks.
> 
>   # dmesg | grep kmemleak
>   ...
>   kmemleak: 480 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
>   kmemleak: 665 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
> 
>   # cat /sys/kernel/debug/kmemleak
>   unreferenced object 0xffff888cd8ca2c40 (size 64):
>     comm "hackbench", pid 17142, jiffies 4299780315
>     hex dump (first 32 bytes):
>       ac 74 49 00 01 00 00 00 4c 84 49 00 01 00 00 00  .tI.....L.I.....
>       00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     backtrace (crc bff18fd4):
>       [<ffffffff81419a89>] __kmalloc_cache_noprof+0x2f9/0x3f0
>       [<ffffffff8113f715>] task_numa_work+0x725/0xa00
>       [<ffffffff8110f878>] task_work_run+0x58/0x90
>       [<ffffffff81ddd9f8>] syscall_exit_to_user_mode+0x1c8/0x1e0
>       [<ffffffff81dd78d5>] do_syscall_64+0x85/0x150
>       [<ffffffff81e0012b>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   ...
> 
>   This issue can be consistently reproduced on three different servers:
>     * a 448-core server
>     * a 256-core server
>     * a 192-core server
> 
> [Root Cause]
> Since multiple threads are created by the hackbench program (along with
> the command argument 'thread'), a shared vma might be accessed by two or
> more cores simultaneously. When two or more cores observe that
> vma->numab_state is NULL at the same time, vma->numab_state will be
> overwritten.
> 
> Note that the command `/opt/ltp/testcases/bin/hackbench 50 process 1000`
> cannot the reproduce the issue because of the fork() and COW. It is
> verified with 200+ test runs.
> 
> [Solution]
> Introduce a lock to make sure the atomic operation of the vma->numab_state
> access.
> 
> Fixes: ef6a22b70f6d ("sched/numa: apply the scan delay to every new vma")
> Reported-by: Jiwei Sun <sunjw10@lenovo.com>
> Signed-off-by: Adrian Huang <ahuang12@lenovo.com>

Could this be achieved without the new lock, by a cmpxchg attempt to install
 vma->numab_state that will free the allocated vma_numab_state if it fails?

Thanks,
Vlastimil

> ---
>  include/linux/mm.h       |  1 +
>  include/linux/mm_types.h |  1 +
>  kernel/sched/fair.c      | 17 ++++++++++++++++-
>  3 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 61fff5d34ed5..a08e31ac53de 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -673,6 +673,7 @@ struct vm_operations_struct {
>  static inline void vma_numab_state_init(struct vm_area_struct *vma)
>  {
>  	vma->numab_state = NULL;
> +	mutex_init(&vma->numab_state_lock);
>  }
>  static inline void vma_numab_state_free(struct vm_area_struct *vma)
>  {
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 6e3bdf8e38bc..77eee89a89f5 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -768,6 +768,7 @@ struct vm_area_struct {
>  #endif
>  #ifdef CONFIG_NUMA_BALANCING
>  	struct vma_numab_state *numab_state;	/* NUMA Balancing state */
> +	struct mutex numab_state_lock;		/* NUMA Balancing state lock */
>  #endif
>  	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
>  } __randomize_layout;
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c157d4860a3b..53e6383cd94e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3397,12 +3397,24 @@ static void task_numa_work(struct callback_head *work)
>  			continue;
>  		}
>  
> +		/*
> +		 * In case of the shared vma, the vma->numab_state will be
> +		 * overwritten if two or more cores observe vma->numab_state
> +		 * is NULL at the same time. Make sure that only one core
> +		 * allocates memory for vma->numab_state. This can prevent
> +		 * the memory leak.
> +		 */
> +		if (!mutex_trylock(&vma->numab_state_lock))
> +			continue;
> +
>  		/* Initialise new per-VMA NUMAB state. */
>  		if (!vma->numab_state) {
>  			vma->numab_state = kzalloc(sizeof(struct vma_numab_state),
>  				GFP_KERNEL);
> -			if (!vma->numab_state)
> +			if (!vma->numab_state) {
> +				mutex_unlock(&vma->numab_state_lock);
>  				continue;
> +			}
>  
>  			vma->numab_state->start_scan_seq = mm->numa_scan_seq;
>  
> @@ -3428,6 +3440,7 @@ static void task_numa_work(struct callback_head *work)
>  		if (mm->numa_scan_seq && time_before(jiffies,
>  						vma->numab_state->next_scan)) {
>  			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_SCAN_DELAY);
> +			mutex_unlock(&vma->numab_state_lock);
>  			continue;
>  		}
>  
> @@ -3440,6 +3453,8 @@ static void task_numa_work(struct callback_head *work)
>  			vma->numab_state->pids_active[1] = 0;
>  		}
>  
> +		mutex_unlock(&vma->numab_state_lock);
> +
>  		/* Do not rescan VMAs twice within the same sequence. */
>  		if (vma->numab_state->prev_scan_seq == mm->numa_scan_seq) {
>  			mm->numa_scan_offset = vma->vm_end;


