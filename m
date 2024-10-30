Return-Path: <linux-kernel+bounces-389471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EA49B6D76
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 642B61F227F2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 20:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5BA1D12F1;
	Wed, 30 Oct 2024 20:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmioHDUv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A66F1CF7BB
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 20:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319538; cv=none; b=AjWMMwYlB/tyk65FwWkHwz5duc/IRs/Jn4Y8OEX8phouCYP0yDZ3iJKfnAPDboVSEZgObvWZMN6RJbupgY39qwBccV5yvEuDj6M7Veku5tKhVroPnG84KRSB35rgOYffn1n2S2AOupsVAq4Z+O3vLQ9gc9c3Holt0/NCjsnfx4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319538; c=relaxed/simple;
	bh=+T/dC0hr1xj/RibAC47FdhmsKEe3jJW4igVaqrsYq30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZsmndSRe5EjUupsJjVNfNdThlHR42pHLX2sMkRJ8qZhL2cOtlHZw7jzkL2R+m7HnOGelY5msk0P7pQgBlrKDDqGcuE4uIo76vbRWTcFc3IMLmUl2+OoNGrJPmwPh1LEotcydItD8s4oBGnoz0WD2jNfkqp5P6mkQFDlNtYcmfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmioHDUv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8354C4CECE;
	Wed, 30 Oct 2024 20:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730319538;
	bh=+T/dC0hr1xj/RibAC47FdhmsKEe3jJW4igVaqrsYq30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BmioHDUvuVoTf9e9QSUaDAT34BwVQmTY73fld6VrI79lZjzSJSN45NMkmgadUmkRo
	 ftc7oyrDiletULbTYOBrRfXMGv4xG8mcrKVjzMK/nMrSslz94V8g+DFEvo9ALRdQmA
	 OKRBFg+e52RH2EB7b3qQF4YbBLbM1ppZrif1PcR6I6T+7N0tNj/wwdhSgtZRHTOLPx
	 FL2/KWNYDMafpf+pABtPRv+8a9qktay19Vpn1Wt7eEOel4dzFbfSL83jNkv4PpQoVr
	 8eLPBLnbeAxaAoE0OU5I3ijz1xK6PvbnO6O8HWAD4UfvQbRyEscg4n1u19pI35Vf87
	 IvoUouyrRRyMg==
Date: Wed, 30 Oct 2024 10:18:56 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	sched-ext@meta.com
Subject: Re: [RFC PATCH sched/urgent] sched: Task still delay-dequeued after
 switched from fair
Message-ID: <ZyKUsBIXHu3NIcUb@slm.duckdns.org>
References: <ZyF4rw_nvfpHfouv@slm.duckdns.org>
 <20241030104934.GK14555@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030104934.GK14555@noisy.programming.kicks-ass.net>

Hello,

On Wed, Oct 30, 2024 at 11:49:34AM +0100, Peter Zijlstra wrote:
...
> > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > index 65334c13ffa5..601aad1a2625 100644
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -5205,8 +5205,12 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
> >  	while ((p = scx_task_iter_next_locked(&sti))) {
> >  		const struct sched_class *old_class = p->sched_class;
> >  		struct sched_enq_and_set_ctx ctx;
> > +		int deq_flags = DEQUEUE_SAVE | DEQUEUE_MOVE;
> >  
> > -		sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
> > +		if (p->se.sched_delayed)
> > +			deq_flags |= DEQUEUE_SLEEP | DEQUEUE_DELAYED;
> > +
> > +		sched_deq_and_put_task(p, deq_flags, &ctx);
> 
> I don't think this is quite right, the problem is that in this case
> ctx.queued is reporting true, even though you want it false.
> 
> This is why 98442f0ccd82 ("sched: Fix delayed_dequeue vs switched_from_fair()")
> adds a second dequeue.

I see. Yeah, ctx.queued would be set incorrectly.

> Also, you seem to have a second instance of all that.

The disable path doesn't really need it because the transition direction is
always scx -> fair but yeah keeping the two loops in sync is fine too.

> Does the below work for you? I suppose I might as well go work on that
> TODO item now.

Yeap, it works. Will ack on the other thread.

Thanks.

-- 
tejun

