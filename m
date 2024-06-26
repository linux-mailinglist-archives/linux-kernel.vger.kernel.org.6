Return-Path: <linux-kernel+bounces-230825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4787918259
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AAEF1C2325A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EBF181BA3;
	Wed, 26 Jun 2024 13:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JO+3v60r";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jMKbEP2w";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vx4/Or2v";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fkRukvxz"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFC1181B80
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719408483; cv=none; b=MdaOKzl8WqCGUCtYwQrQ4UixvU18zXYmWERoa5GIBNNUW8tPB9BNkP2yad1k0hTyoZV8CfKdMztuxGJ/lAju2w2F5fCk+P6Lw/zICMLZLfSd1/5of4VXjlQGSHRCiaX825R/KVG1R2a8lB+zMGIPRLsC8INgCz2xlLGbhAXfHGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719408483; c=relaxed/simple;
	bh=bfHQtv4jWoAzy/lNNieBh8btbEcWqldVNSEgkEkM34A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hHtY3guH9aN9ls8jebDlT0+cloCih/iHaEKl6cZ7FtVMBs5O4o2IbDqeOefzJM9t52cIaiGNPLSGZo7DUPNs3e8IYPFxWYrWCM0RAJXKSRzCWaoyd/fK2vVtWMVe64e7EKXc7QyNchTwaeoHhLRbs4piSbX8iQ6TZ5LYIvQKSB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JO+3v60r; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jMKbEP2w; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vx4/Or2v; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fkRukvxz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B3DD621ACB;
	Wed, 26 Jun 2024 13:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719408480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YzdBapO/fnF0TH4tT0xHHurilWcYCqFKZsrDPEFV1wU=;
	b=JO+3v60rIh0WTGVap/JFdBDbFPIiFd/gnkeWxZEQ6H9Wkzv1fDAJHbIs7GpF9dyR++FFr5
	PhvPQo4hWaAtPKZ4BfCrYQQaZbKqyIlYwjF8omnX/O2lqdMvHE8jHGZ36HUaBf967m3+Rb
	vXkg9W1Kwro5x3SxaqtZjE66wtlYgWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719408480;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YzdBapO/fnF0TH4tT0xHHurilWcYCqFKZsrDPEFV1wU=;
	b=jMKbEP2wz2J/O4BPhwnYCiXt0RIbrbAiBQsCAf4v2ua+wiEew4m8YTVUVUDnojwraP3vvp
	LgNtg74gjLpHtmDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719408479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YzdBapO/fnF0TH4tT0xHHurilWcYCqFKZsrDPEFV1wU=;
	b=Vx4/Or2vpdIdZo7kHabv4tkEl2UvlmgICJyrH6ZVRiT/gg5aeY4QmnNJN86iMIAk/+Jmmh
	wfMusRxzBmaVbMX8UIRbGLe/tM8gqop/5rIMz+tdMmQtL7ixqjUGbSCYT8sz33VFB+Z/YZ
	5waymjPuMT36X2rKmdoIbp+U6E4CNew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719408479;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YzdBapO/fnF0TH4tT0xHHurilWcYCqFKZsrDPEFV1wU=;
	b=fkRukvxzQGwK8Rfa/0Yt+6bccthYqqQu4+o8ppHakNgrZqlxWzkzwOE8z6FkoeiSi6SeQH
	abPisBGopN0Z6mCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BB7C13AAD;
	Wed, 26 Jun 2024 13:27:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k5qtJV8XfGZaPwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 26 Jun 2024 13:27:59 +0000
Message-ID: <672db961-6056-426d-bf62-5688344be304@suse.cz>
Date: Wed, 26 Jun 2024 15:27:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/6] sched/isolation: Introduce isolated task work
Content-Language: en-US
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Oleg Nesterov <oleg@redhat.com>
References: <20240625135244.20227-1-frederic@kernel.org>
 <20240625135244.20227-6-frederic@kernel.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240625135244.20227-6-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.29
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On 6/25/24 3:52 PM, Frederic Weisbecker wrote:
> Some asynchronous kernel work may be pending upon resume to userspace
> and execute later on. On isolated workload this becomes problematic once
> the process is done with preparatory work involving syscalls and wants
> to run in userspace without being interrupted.
> 
> Provide an infrastructure to queue a work to be executed from the current
> isolated task context right before resuming to userspace. This goes with
> the assumption that isolated tasks are pinned to a single nohz_full CPU.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  include/linux/sched.h           |  1 +
>  include/linux/sched/isolation.h | 17 +++++++++++++++++
>  kernel/sched/core.c             |  1 +
>  kernel/sched/isolation.c        | 31 +++++++++++++++++++++++++++++++
>  kernel/sched/sched.h            |  1 +
>  5 files changed, 51 insertions(+)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index d531b610c410..f6df21866055 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1349,6 +1349,7 @@ struct task_struct {
>  #endif
>  
>  #ifdef CONFIG_NO_HZ_FULL
> +	struct callback_head		nohz_full_work;
>  	atomic_t			tick_dep_mask;
>  #endif
>  
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index 2b461129d1fa..e69ec5ed1d70 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -72,4 +72,21 @@ static inline bool cpu_is_isolated(int cpu)
>  	       cpuset_cpu_is_isolated(cpu);
>  }
>  
> +#if defined(CONFIG_NO_HZ_FULL)
> +extern int __isolated_task_work_queue(void);
> +
> +static inline int isolated_task_work_queue(void)
> +{
> +	if (!housekeeping_test_cpu(raw_smp_processor_id(), HK_TYPE_TICK))

This is an unconditional call to a function defined in
kernel/sched/isolation.c, and only there a static_branch_unlikely() test
happens, but the call overhead is always paid, and the next patch adds that
to folio_add_lru().

I notice a housekeeping_cpu() function above that does the static branch
inline, which is great, except it defaults to return true so not directly
applicable, but this function could be done the same way to keep the static
branch inline.

> +		return -ENOTSUPP;
> +
> +	return __isolated_task_work_queue();
> +}
> +
> +extern void isolated_task_work_init(struct task_struct *tsk);
> +#else
> +static inline int isolated_task_work_queue(void) { }
> +static inline void isolated_task_work_init(struct task_struct *tsk) { }
> +#endif /* CONFIG_NO_HZ_FULL */
> +
>  #endif /* _LINUX_SCHED_ISOLATION_H */
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f01979b600e8..01960434dbfd 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4566,6 +4566,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
>  	p->migration_pending = NULL;
>  #endif
>  	init_sched_mm_cid(p);
> +	isolated_task_work_init(p);
>  }
>  
>  DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 5891e715f00d..410df1fedc9d 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -253,3 +253,34 @@ static int __init housekeeping_isolcpus_setup(char *str)
>  	return housekeeping_setup(str, flags);
>  }
>  __setup("isolcpus=", housekeeping_isolcpus_setup);
> +
> +#if defined(CONFIG_NO_HZ_FULL)
> +static void isolated_task_work(struct callback_head *head)
> +{
> +}
> +
> +int __isolated_task_work_queue(void)
> +{
> +	unsigned long flags;
> +	int ret;
> +
> +	if (current->flags & PF_KTHREAD)
> +		return 0;
> +
> +	local_irq_save(flags);
> +	if (task_work_queued(&current->nohz_full_work)) {
> +		ret = 0;
> +		goto out;
> +	}
> +
> +	ret = task_work_add(current, &current->nohz_full_work, TWA_RESUME);
> +out:
> +	local_irq_restore(flags);
> +	return ret;
> +}
> +
> +void isolated_task_work_init(struct task_struct *tsk)
> +{
> +	init_task_work(&tsk->nohz_full_work, isolated_task_work);
> +}
> +#endif /* CONFIG_NO_HZ_FULL */
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index a831af102070..24653f5879cc 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -60,6 +60,7 @@
>  #include <linux/stop_machine.h>
>  #include <linux/syscalls_api.h>
>  #include <linux/syscalls.h>
> +#include <linux/task_work.h>
>  #include <linux/tick.h>
>  #include <linux/topology.h>
>  #include <linux/types.h>


