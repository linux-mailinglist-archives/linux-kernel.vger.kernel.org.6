Return-Path: <linux-kernel+bounces-272803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 574B9946162
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D75C71F226E2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F7D1A34B1;
	Fri,  2 Aug 2024 16:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfR48HQd"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5251A34AB
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 16:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722614947; cv=none; b=BvOpknoOvbEnUwgLmtlaUhfXYg7V+Xs2BOnreVG2iYmNjpPPS0THx/g6bushAYsvYr/KuINY4vQMMOxOguVg86GUhrSdqfmETffGfnxmClT1XQpeAcRr3444cLy14tWa+86HH+Vz4QoxWVarY3cZ9aLjYkmG8rLKKPm4c4M28jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722614947; c=relaxed/simple;
	bh=ZpPUwu/zovi0xwnWJLZwiVxHl6ARyMDxhRtxH3+ZzGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNAbhWYAF3wHYD3Nwud9Vb67woOUxJVu1u3S6CVArzXV9Gy6MESPYYNbAiStyfgrye/YdLk4szaAKkcihqK0fSqxxim5ZdUBvpQ7lquuojme7FfNuGwl553MzDtmrjubNvGrTIreQ6REkt7ToP3oPJqMae6D+xelgJxU92GrO1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfR48HQd; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc692abba4so63598225ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 09:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722614946; x=1723219746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJ4C0704Ln0GXHR23yu+tvYj4ZuVcKGNSTnHBXO2Wcs=;
        b=YfR48HQdMMxJ9MD2tJbxo1X6oRLPuxWrO17ol7NDNi+I7pPQHQAQ/z+tx21TwUU+E/
         WDZ/Yu3Zv+UtgZ/o6+NbMzf4UhlV3Db17DIK/zc3xuY2+oPMx6JE+VMBo35VIpx3RFrR
         bETwGi7/XW85us7MFYv3/QmkFcbDCQh2c0A2JoemLK6WFIikrcGJqI0BWc5Laoz7gD6h
         Hyth+U+tBKcLtsquE8bA+BzW1WG+eqRCQ7+VbRnaNKiCp3cONsKdngwctJjVuJTxNuur
         TA4eVPW5OoYlhFqKUYBE+jHWnbmu2Q5YAaw5/s9p0fD0CAgLYTKJwBGOCEVBmdi6pTc+
         uGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722614946; x=1723219746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJ4C0704Ln0GXHR23yu+tvYj4ZuVcKGNSTnHBXO2Wcs=;
        b=bOsB4f4BzvdUDfwuJBIYODdKlWcdhRmAQdL3cw6IlzwhqlbdFbHJa+tPld5eguVTFe
         nZYuK6DGcfAGLiwF5YCim3UMVU0nscw2TaetmQbdsKUwA9kT7YcJDfCVgvSzVvdIhzt0
         7HeM+2YlnHrnbvRD43kKSbHxez+8/dbBRf9+m0/b68dP6HOs1dq3qH3ZKUpjc+1e46D0
         cvA5h2P8QVsCy6itMogF35YaS1hF9FmAy7Qe/v3WORqPo4+EWfHghQoJAZROaTHUnCaQ
         8yRCVoc7NRgNshflcXJ0Q9ZCKc+ZgwKvW1+1mAPlrtYJoVzz5JGikwQ6ZIiyxxtffX36
         zx7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9WVbzkcu5+l/1vLSbWOa6cyVRNEXkzj4fhnOl5GMYFqzQ2f/AasXeYgrYcnJRhJx7kV8WMZ9e5qg3gGM2RzaDJlJuoRclnC5n3Iex
X-Gm-Message-State: AOJu0YzH9kTreevzmr2ZsK8miqo3b+VDL4mnYAX86eRereo90BDuvo6L
	M2IxmLPv13tYfXVNZ6jb7fBH19nsaHSx4jH+qnU3T1Lq8AbJygVe
X-Google-Smtp-Source: AGHT+IHmYysL8xtvAvtsvtuBar36XwIVA7FnX3TnDYDTapmTpcD7B7EPQLbnbMXAW3Dg7Z7AYSenbQ==
X-Received: by 2002:a17:902:f54b:b0:1fd:927e:7d1e with SMTP id d9443c01a7336-1ff572c0659mr54495825ad.26.1722614945684;
        Fri, 02 Aug 2024 09:09:05 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59059fa5sm18810485ad.125.2024.08.02.09.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 09:09:05 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 2 Aug 2024 06:09:03 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Ingo Molnar <mingo@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] sched_ext: Initial pull request for v6.11
Message-ID: <Zq0En8pFfgzH0HMH@slm.duckdns.org>
References: <ZpWjbCQPtuUcvo8r@slm.duckdns.org>
 <20240723163358.GM26750@noisy.programming.kicks-ass.net>
 <ZqAFtfSijJ-KMVHo@slm.duckdns.org>
 <20240724085221.GO26750@noisy.programming.kicks-ass.net>
 <ZqmVG9ZiktN6bnm0@slm.duckdns.org>
 <20240802111018.GI39708@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802111018.GI39708@noisy.programming.kicks-ass.net>

Hello,

On Fri, Aug 02, 2024 at 01:10:18PM +0200, Peter Zijlstra wrote:
> On Tue, Jul 30, 2024 at 03:36:27PM -1000, Tejun Heo wrote:
...
> > Maybe, but at the same time, it's also just some isolated cruft that enables
> > UP support, so both sides of the scale seem similarly light-weight? I lean
> > towards "why not support it?" but don't feel particularly strongly about it.
> 
> So you're basically looking for something like this?
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a9f655025607..69ec02a28117 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5772,7 +5772,6 @@ static inline void schedule_debug(struct task_struct *prev, bool preempt)
>  static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
>  				  struct rq_flags *rf)
>  {
> -#ifdef CONFIG_SMP
>  	const struct sched_class *class;
>  	/*
>  	 * We must do the balancing pass before put_prev_task(), such
> @@ -5783,10 +5782,9 @@ static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
>  	 * a runnable task of @class priority or higher.
>  	 */
>  	for_class_range(class, prev->sched_class, &idle_sched_class) {
> -		if (class->balance(rq, prev, rf))
> +		if (class->balance && class->balance(rq, prev, rf))
>  			break;
>  	}
> -#endif
>  
>  	put_prev_task(rq, prev);
>  }
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 4c36cc680361..40f3dc436f4f 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2296,8 +2296,8 @@ struct sched_class {
>  	void (*put_prev_task)(struct rq *rq, struct task_struct *p);
>  	void (*set_next_task)(struct rq *rq, struct task_struct *p, bool first);
>  
> -#ifdef CONFIG_SMP
>  	int (*balance)(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
> +#ifdef CONFIG_SMP
>  	int  (*select_task_rq)(struct task_struct *p, int task_cpu, int flags);
>  
>  	struct task_struct * (*pick_task)(struct rq *rq);

Yes, exactly. This is how it was implemented in the first RFC patchset. If
you're okay with the above, I'd love to go back to it.

Thanks.

-- 
tejun

