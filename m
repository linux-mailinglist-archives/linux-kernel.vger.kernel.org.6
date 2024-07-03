Return-Path: <linux-kernel+bounces-239477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8789A9260AA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F111282EA8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF77176FBD;
	Wed,  3 Jul 2024 12:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGnHv6pR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103F018EB8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 12:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010512; cv=none; b=MoCrJc5iy0D1EwDFdY/QiBhmxkbIuz6ReMwh3VhtB+/pK2kAqd06jQzSWugpzZ2GwwGVhleeyyB0lOh3g6ZvuT0K3Rb6tOyVrYA6xvauPf0/9E2l9iSU18H85KAfoPdZXn+7db/IQkjaRYjVzE8XsFeo6g/yj9YfIfKr11YQuT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010512; c=relaxed/simple;
	bh=Rphn4XrAKl9jF1UHTTpZUG5XRdoNsFvlH6AHeG3SVOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dl8BINpbBs3fdiNwu27ZApbAKjNPtKBKmVycfCT+EVqRwLff/DrUCSI13df8NokKCRuYsEgQeCxT8+vmbd2JVxKixatfOWHlAmtOIROqXY8uMSXBR+nVn5vfRaaUUBJVbnKU8RI5+c991/vqE6OOI7z41/VgAVj6e6iJLneh584=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGnHv6pR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F39C2BD10;
	Wed,  3 Jul 2024 12:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720010511;
	bh=Rphn4XrAKl9jF1UHTTpZUG5XRdoNsFvlH6AHeG3SVOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lGnHv6pRk6b4KCU4DoL58Fn2Vhip88wlBTPAONmuHkoAUEhR/b+RsMTZhOGdqtE5B
	 4ha/c1u3SNj55nlR5hpbWQiHDIzTPxqHr+PEVguyOyXBxmcKFgBJgqpra6kY/02V2H
	 q0inT2skI3KOVIEnJq+bIDLoeKJbml9T6PYhBo1b3MSAhcRSmchJKgyMtyhmmTenHJ
	 rjz1DxQOcMaVBtHH+GlwelmWXquT8+dupA2QkXBVHZPReyzuvZMlw/qvQGsfMqtiZx
	 +blVYC8yMZEvHnV9M2JuWu74gOje0zlTNTNjiSYHdP7mQXengn6/5tkX2D9hg3vVdf
	 3C4xSIUqhKaqA==
Date: Wed, 3 Jul 2024 14:41:48 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 1/6] task_work: Provide means to check if a work is
 queued
Message-ID: <ZoVHDHQkGU2ajUCH@localhost.localdomain>
References: <20240625135244.20227-1-frederic@kernel.org>
 <20240625135244.20227-2-frederic@kernel.org>
 <20240625141539.GA14254@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240625141539.GA14254@redhat.com>

Le Tue, Jun 25, 2024 at 04:15:39PM +0200, Oleg Nesterov a écrit :
> On 06/25, Frederic Weisbecker wrote:
> >
> > --- a/kernel/task_work.c
> > +++ b/kernel/task_work.c
> > @@ -177,6 +177,7 @@ void task_work_run(void)
> >
> >  		do {
> >  			next = work->next;
> > +			work->next = TASK_WORK_DEQUEUED;
> 
> OK, but then the additional change below makes sense too?
> 
> Oleg.
> ---
> 
> --- x/kernel/task_work.c
> +++ x/kernel/task_work.c
> @@ -106,8 +106,10 @@ task_work_cancel_match(struct task_struc
>  		if (!match(work, data)) {
>  			pprev = &work->next;
>  			work = READ_ONCE(*pprev);
> -		} else if (try_cmpxchg(pprev, &work, work->next))
> +		} else if (try_cmpxchg(pprev, &work, work->next)) {
> +			work->next = TASK_WORK_DEQUEUED;
>  			break;
> +		}
>  	}
>  	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
>  
> 

Yes it does!

Thanks.

