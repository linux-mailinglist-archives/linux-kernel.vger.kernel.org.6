Return-Path: <linux-kernel+bounces-224846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64969912792
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7FB61F272C5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B494C20335;
	Fri, 21 Jun 2024 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xAjRQ0qf"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18E72031D
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718979818; cv=none; b=uyP+Jls9ac3va2/07dphiHe8IGa5MVBnci7b26fCDpupsmRi/zKZtxuBiauPsJ0HKg8j2UfYN2+e4jDNtYgPX4c6dP4lptL5ChGaKCtlOJjwdoaAl0LE0LvW4o0Wb6UtgUaCQVGCEV9WDkvvci058EiqnTWAUH/SkGaKcXFPZ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718979818; c=relaxed/simple;
	bh=TaXH7pCplav4h8M21Q+xBag3i9Cj23O1agV31TPskGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQ2+yVEIiSKIDVUBZD4lXcC0vm5Xaqken/LvYWqFjpMOTWjGj/Wy9GqDkX7AuuqdvgLvUibo5db3SK8dGwzdXO9JQTUmgqo2ozCYM/+nhFzCj1q/pKSajsQB7VS85+6u/5i6ctKcey5ero6nsCruOdRx6jweGTNU+dkkdKb+nNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xAjRQ0qf; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: yi.sun@unisoc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718979815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7s3nraX3meU88oDt2QxTb0nIt092nRV6YyzqRLfGesw=;
	b=xAjRQ0qfong4mJ7qrVMt9jyf6XGP4CctOHJ/+3A+ta9Fl5fSiVki1lM8bhcMoJKOXf60WO
	90doMTyqBOujiLFcyxoeTk58oHuxEFgejEGsY8QsLTdiTo4fJpPFFRQVnNQgo1JJsT9qkg
	FhfEXj0FMq6xNOQHDsCZJB+uHwjLWw4=
X-Envelope-To: sunyibuaa@gmail.com
X-Envelope-To: tj@kernel.org
X-Envelope-To: jaegeuk@kernel.org
X-Envelope-To: chao@kernel.org
X-Envelope-To: ebiggers@google.com
X-Envelope-To: jiangshanlai@gmail.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-f2fs-devel@lists.sourceforge.net
X-Envelope-To: niuzhiguo84@gmail.com
X-Envelope-To: hao_hao.wang@unisoc.com
X-Envelope-To: yunlongxing23@gmail.com
Date: Fri, 21 Jun 2024 10:23:31 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Yi Sun <yi.sun@unisoc.com>
Cc: sunyibuaa@gmail.com, tj@kernel.org, jaegeuk@kernel.org, 
	chao@kernel.org, ebiggers@google.com, jiangshanlai@gmail.com, 
	linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, niuzhiguo84@gmail.com, 
	Hao_hao.Wang@unisoc.com, yunlongxing23@gmail.com
Subject: Re: [PATCH 1/2] workqueue: add io priority to work_struct
Message-ID: <dst4qsqyrj4mvnpgrgaaqdzazn27xghjaudzdmpdwyb2guklag@ggrdrcpjclhb>
References: <20240621062617.595007-1-yi.sun@unisoc.com>
 <20240621062617.595007-2-yi.sun@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621062617.595007-2-yi.sun@unisoc.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 21, 2024 at 02:26:16PM +0800, Yi Sun wrote:
> Many works will go to submit_bio(), and in many cases the io priority of
> kworker cannot meet the real-time requirements of this work.
> 
> So add the basic attribute ioprio to work_struct, and kworker can adjust
> its io priority according to this attribute.
> 
> Add function set_work_ioprio() to set the io priority of this work.
> Add function may_adjust_work_task_ioprio() to adjust kworker's io priority.
> Add function restore_work_task_ioprio() to restore kworker's io priority.

work_struct!?

there's a lot of task_struct properties we would want work_struct to
inherit if we went this route, but it's just not feasible, work_struct
should be small and thin.

You're always embedding work_struct into your own struct, I would
suggest tracking this yourself - or coming up with a new heavier
standard struct that embeds a work_struct and has io path options,
there's more than just priority.

> 
> Signed-off-by: Yi Sun <yi.sun@unisoc.com>
> ---
>  include/linux/workqueue.h       |  9 ++++++
>  include/linux/workqueue_types.h |  6 ++++
>  kernel/workqueue.c              | 51 +++++++++++++++++++++++++++++++++
>  3 files changed, 66 insertions(+)
> 
> diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
> index fb3993894536..f6191774b730 100644
> --- a/include/linux/workqueue.h
> +++ b/include/linux/workqueue.h
> @@ -286,6 +286,9 @@ static inline unsigned int work_static(struct work_struct *work) { return 0; }
>  		lockdep_init_map(&(_work)->lockdep_map, "(work_completion)"#_work, (_key), 0); \
>  		INIT_LIST_HEAD(&(_work)->entry);			\
>  		(_work)->func = (_func);				\
> +		(_work)->ioprio = 0;					\
> +		(_work)->ori_ioprio = 0;				\
> +		(_work)->ioprio_flag = 0;				\
>  	} while (0)
>  #else
>  #define __INIT_WORK_KEY(_work, _func, _onstack, _key)			\
> @@ -294,6 +297,9 @@ static inline unsigned int work_static(struct work_struct *work) { return 0; }
>  		(_work)->data = (atomic_long_t) WORK_DATA_INIT();	\
>  		INIT_LIST_HEAD(&(_work)->entry);			\
>  		(_work)->func = (_func);				\
> +		(_work)->ioprio = 0;					\
> +		(_work)->ori_ioprio = 0;				\
> +		(_work)->ioprio_flag = 0;				\
>  	} while (0)
>  #endif
>  
> @@ -585,6 +591,9 @@ extern struct work_struct *current_work(void);
>  extern bool current_is_workqueue_rescuer(void);
>  extern bool workqueue_congested(int cpu, struct workqueue_struct *wq);
>  extern unsigned int work_busy(struct work_struct *work);
> +extern void set_work_ioprio(struct work_struct *work, unsigned short ioprio);
> +extern void may_adjust_work_task_ioprio(struct work_struct *work);
> +extern void restore_work_task_ioprio(struct work_struct *work);
>  extern __printf(1, 2) void set_worker_desc(const char *fmt, ...);
>  extern void print_worker_info(const char *log_lvl, struct task_struct *task);
>  extern void show_all_workqueues(void);
> diff --git a/include/linux/workqueue_types.h b/include/linux/workqueue_types.h
> index 4c38824f3ab4..d9969596bbc3 100644
> --- a/include/linux/workqueue_types.h
> +++ b/include/linux/workqueue_types.h
> @@ -17,6 +17,12 @@ struct work_struct {
>  	atomic_long_t data;
>  	struct list_head entry;
>  	work_func_t func;
> +	/* If the work does submit_bio, io priority may be needed. */
> +	unsigned short ioprio;
> +	/* Record kworker's original io priority. */
> +	unsigned short ori_ioprio;
> +	/* Whether the work has set io priority? */
> +	long ioprio_flag;
>  #ifdef CONFIG_LOCKDEP
>  	struct lockdep_map lockdep_map;
>  #endif
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 003474c9a77d..a44a8f92eec2 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -55,6 +55,7 @@
>  #include <linux/kvm_para.h>
>  #include <linux/delay.h>
>  #include <linux/irq_work.h>
> +#include <linux/ioprio.h>
>  
>  #include "workqueue_internal.h"
>  
> @@ -6025,6 +6026,56 @@ unsigned int work_busy(struct work_struct *work)
>  }
>  EXPORT_SYMBOL_GPL(work_busy);
>  
> +/**
> + * set_work_ioprio - set io priority for the current work
> + * @work: the work to be set
> + * @ioprio: desired io priority
> + *
> + * This function can be called after INIT_WORK if the io priority
> + * of the work needs to adjust. And it is recommended to use this
> + * function together with may_adjust_work_task_ioprio() and
> + * restore_work_task_ioprio().
> + */
> +void set_work_ioprio(struct work_struct *work, unsigned short ioprio)
> +{
> +	work->ioprio = ioprio;
> +	work->ioprio_flag = 1;
> +}
> +EXPORT_SYMBOL_GPL(set_work_ioprio);
> +
> +/**
> + * may_adjust_work_task_ioprio - adjust the io priority of kworker
> + * @work: the work that kworker will do
> + *
> + * It is recommended to use this function together with set_work_ioprio()
> + * and restore_work_task_ioprio().
> + */
> +void may_adjust_work_task_ioprio(struct work_struct *work)
> +{
> +	if (work->ioprio_flag) {
> +		work->ori_ioprio = get_current_ioprio();
> +		set_task_ioprio(current, work->ioprio);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(may_adjust_work_task_ioprio);
> +
> +/**
> + * restore_work_task_ioprio - restore the io priority of kworker
> + * @work: the work that kworker just did
> + *
> + * When kworker finishes the work, the original io priority of
> + * kworker should be restored. It is recommended to use this function
> + * together with set_work_ioprio() and may_adjust_work_task_ioprio().
> + */
> +void restore_work_task_ioprio(struct work_struct *work)
> +{
> +	if (work->ioprio_flag) {
> +		set_task_ioprio(current, work->ori_ioprio);
> +		work->ioprio_flag = 0;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(restore_work_task_ioprio);
> +
>  /**
>   * set_worker_desc - set description for the current work item
>   * @fmt: printf-style format string
> -- 
> 2.25.1
> 

