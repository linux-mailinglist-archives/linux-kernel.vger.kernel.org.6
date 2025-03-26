Return-Path: <linux-kernel+bounces-576760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 423AEA71416
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 571CD3B3A6D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB971A7262;
	Wed, 26 Mar 2025 09:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Os6QRL5+"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6BB189919
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742982556; cv=none; b=e8R1SsjNJCIvrKJrgnrrDcV45Yn8a8ai6OKTCssRDjZMTKgOIXD/BaOZPybPZU9Byl0EGkYoeZSmpWQ4OTD5PeZQ9KZL62NRSEpgnX0AV8js9dIjWpo2FjwWt73GYJ7afqG4iELyQxmd4GtO4cbBfOxJ01762Mn/lFg4jBSKbOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742982556; c=relaxed/simple;
	bh=blgLyvcFFzX3lL2NYcAaYVnF+2egtRAqz36Nl4gpGqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFAvHOv8JFngSUC2cdD8AafdOFP2Ji3xZKzcShIDGyFqNjSqaCosUzY2UYnrCN3dhfysZgC5rSpL9NgMy1koFnmmZkAKpfR3+fUCslYAGghyD8Gmcx6olijFv+SS5lle+UNWrv+LlpY1CTSueFqrKmNXH7beAYSXFPVipng6Ksg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Os6QRL5+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso44584935e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 02:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742982552; x=1743587352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AMf8LZah20pBW0IGNKJCh7GjeqLh0QSKun39aHvg0gk=;
        b=Os6QRL5+gdIuPCGaNWS4H+v4ko4JUHImORsYKgMf/LG+q+UXaleWXEe9Er2HEnAfv/
         pUM9JRKnDQLZGOf8zpFU3M8if7gPeTy1fxOFqlfAGz/S2Dkgyh5U4Q311UFFcBtBToMK
         YquaEi0nRNJI+e3uHSFsOMgk9oGgkIxZiXeGoScbDZOF060Sat7zlx01sLL5XEDlqkGY
         Wg5d6zULGnBb/9HMWkL+RsOBlC8QSJcbeSuWCiCTSamnS1QJrOJ+IauMqXVNxLQADfM7
         6vjD51SzaPMEL+B+MqRnOgSql2gPhOo/ggD3wkB9IeoYJ368PO2A2WjwZp0g4RoaEk5p
         52ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742982552; x=1743587352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMf8LZah20pBW0IGNKJCh7GjeqLh0QSKun39aHvg0gk=;
        b=vfwdhqfEpCUUUvmvzKytytySSsyrhLTnDWVcjBbKYX4dAp8yU46FhyyJlMoItldUir
         44Cl6yHye7znsz+t6ig4WmTdwrZyP0NkTYGjSpe15VKmi95vOpo1UNWZEV74l648TIeH
         inOX9V8MkuObACwP9Jzdk1wwuGBN3/gDEkDZUHj80rruDZ3ybW5e0yVNXmk4J0uDhpR0
         2VbMktoAL/sxXeLqew9gGWt4l9iiIR46hsp6NIHURrgaGBmR1sN6ZmJ0WxssdA12uKky
         PkGGQFLHPPAcSpPBelFTCUz/FDXg1+SwRtAFbttMkfXyXMS3l+rNwgiBy6ydYUZH0YGL
         UXWw==
X-Forwarded-Encrypted: i=1; AJvYcCUSte68fePeNGQWFKXzlv1Ix3ckQ3YhOL92Y3Sq8WapzQbfPK1aLeAQgSQbvQeDXoiCuqVQvmcnCsPHchc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfKSUfh1w2ouhNGWnaF7J1aUZ+wWwbHwKcRR7J2zeJP3IB2gVR
	BMOjagjauBwS3+ssopfQGuQ2oWTHDGghwG/4lFJ1yOLgOnmyeIzIudYUr/Mbhfc=
X-Gm-Gg: ASbGncsAMjSrGbyiyaTzSLNSnAShPBIzbKwBZNkzFKPuRamIwLimOaMdebEVmzBkP3y
	RXTfbo5llHgOq/jQgchipKd0YNcS5FPr57zmGGEVHSH/3qeyOPZfbEFLol6buA8Qy1w1qgxZKH/
	PRaCG+TfxBBOvpxes4vo6np49Q7MXvdpX/MQfK+5eDUKIs+nlDalQibTo9Y85gd1NMV7kaYlOsk
	bJ9R053QpYkp2lw3aZlGEXmjS4vmx0eU05+24GnVOhXDybvxgrFmWF1YLH5QjFDhnkCy4dIUlep
	XjWszkpPn/XgyVYkoYk6YmLFqBbjP8ay7T9Uf3/DmMy6WxQ6Nl4NcTUSpA==
X-Google-Smtp-Source: AGHT+IGRViDMKK6wKXb6OhyBa/rHykXthCXSj7KFfLD1Z+8vJvxSt4VQhKgttI4B1gO+tM6LXwgGbw==
X-Received: by 2002:a05:600c:1d81:b0:43d:10a:1b90 with SMTP id 5b1f17b1804b1-43d509f8691mr195871375e9.16.1742982552228;
        Wed, 26 Mar 2025 02:49:12 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd27b59sm176543075e9.23.2025.03.26.02.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 02:49:11 -0700 (PDT)
Date: Wed, 26 Mar 2025 10:49:10 +0100
From: Petr Mladek <pmladek@suse.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, mingo@kernel.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, jpoimboe@kernel.org,
	jikos@kernel.org, mbenes@suse.cz, joe.lawrence@redhat.com,
	linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC][PATCH] sched,livepatch: Untangle cond_resched() and
 live-patching
Message-ID: <Z-PNll7fJQzCDH35@pathway.suse.cz>
References: <20250324134909.GA14718@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324134909.GA14718@noisy.programming.kicks-ass.net>

On Mon 2025-03-24 14:49:09, Peter Zijlstra wrote:
> 
> With the goal of deprecating / removing VOLUNTARY preempt, live-patch
> needs to stop relying on cond_resched() to make forward progress.
> 
> Instead, rely on schedule() with TASK_FREEZABLE set. Just like
> live-patching, the freezer needs to be able to stop tasks in a safe /
> known state.

> Compile tested only.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/livepatch_sched.h | 15 +++++--------
>  include/linux/sched.h           |  6 -----
>  kernel/livepatch/transition.c   | 30 ++++++-------------------
>  kernel/sched/core.c             | 50 +++++++----------------------------------
>  4 files changed, 21 insertions(+), 80 deletions(-)
> 
> diff --git a/include/linux/livepatch_sched.h b/include/linux/livepatch_sched.h
> index 013794fb5da0..7e8171226dd7 100644
> --- a/include/linux/livepatch_sched.h
> +++ b/include/linux/livepatch_sched.h
> @@ -3,27 +3,24 @@
>  #define _LINUX_LIVEPATCH_SCHED_H_
>  
>  #include <linux/jump_label.h>
> -#include <linux/static_call_types.h>
> +#include <linux/sched.h>
> +
>  
>  #ifdef CONFIG_LIVEPATCH
>  
>  void __klp_sched_try_switch(void);
>  
> -#if !defined(CONFIG_PREEMPT_DYNAMIC) || !defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
> -
>  DECLARE_STATIC_KEY_FALSE(klp_sched_try_switch_key);
>  
> -static __always_inline void klp_sched_try_switch(void)
> +static __always_inline void klp_sched_try_switch(struct task_struct *curr)
>  {
> -	if (static_branch_unlikely(&klp_sched_try_switch_key))
> +	if (static_branch_unlikely(&klp_sched_try_switch_key) &&
> +	    READ_ONCE(curr->__state) & TASK_FREEZABLE)
>  		__klp_sched_try_switch();
>  }

Do we really need to check the TASK_FREEZABLE state, please?

My understanding is that TASK_FREEZABLE is set when kernel kthreads go into
a "freezable" sleep, e.g. wait_event_freezable().

But __klp_sched_try_switch() should be safe when the task is not
running and the stack is reliable. IMHO, it should be safe anytime
it is being scheduled out.

Note that wait_event_freezable() is a good location. It is usually called in
the main loop of the kthread where the stack is small. So that the chance
that it is not running a livepatched function is higher than on
another random schedulable location.

But we actually wanted to have it in cond_resched() because
it might take a long time to reach the main loop, and sleep there.

Best Regards,
Petr

