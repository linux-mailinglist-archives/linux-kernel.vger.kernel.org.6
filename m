Return-Path: <linux-kernel+bounces-276944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 547B8949A3E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7B1AB22FD2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CDC16B75B;
	Tue,  6 Aug 2024 21:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCWPOEmc"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6C016190C
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 21:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722980063; cv=none; b=ayKTrUGmZn4Egcm55DKMNS378PvdRKbMIoO0tptgOnZvW28cm+YMd7BK4CnMX9CPml1z7HrsJiPnHoj3VTSPJsCXFp2g9GKC9Q/u6aHI1TuBZnS8b3r1FXDRYWnn8KZ3A/FfS75jYdv1aM+yd94xef1I3XVGBfKu+i19D19uIBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722980063; c=relaxed/simple;
	bh=y+WPBRcP2UUkmoo1X6b1On/m7xI6hXa7A87BB06rY5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Plgl0TiKQosvZJGDvRt5SgA2iBieUbJwDfaXpCnR413JuVS0umak2ssDb26VNYrjOAddbAEArqNQF7iS5mJltrRQeoYcfyTXPAopTFzZamzMnTHFSCji2lGBSBnfA/oSWACiKdpe5fAYc4ePNEJNlGucnqEQ2/A+U7cGBNU7HqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCWPOEmc; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2cb4b6ecb3dso919591a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 14:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722980061; x=1723584861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QOQuy+CBC2lxToAhwqJ1r238GNCITA2gO3WQsUAlD2Y=;
        b=YCWPOEmcpI5fzThg7O+fZwitRQcJAvOl2Svn4zwhcDwcJijZTgPjwCdSrBuXSD9LLY
         CorosBZs3J7jCZC2AYdECiq6CT4AduoMzkq2Jb4AMdftOvhhDv0IoS8h0FEVomndPEdF
         nta85t4qkI0zkpAMpJPXmr6mmS7rNPFKFImXZz/gtI2mERLtspKEd7EWGP35ae75qzpv
         TQX7wddrj/J5kuirbnaWMYEnFnktVZ/SbtfkPBke8S3E6ZGz2L/UFF2ubSbVYB3ERv0C
         9o0eT24zD6wzK5gvY70oObMSq185gbEE0KNoGHJZQi06XzrpU5wKclWMMDijB4omDrjC
         HC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722980061; x=1723584861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOQuy+CBC2lxToAhwqJ1r238GNCITA2gO3WQsUAlD2Y=;
        b=FYLbaHP06aH3ffJmkSM/UxllLmfbwHdQfYibz+nssZPVeN44phZ3eUP2A0yuaiDC16
         XZAj38Qzi6A1nV3YPycgxhUEKuEMtJt1FRN1mB0SvV0wIKSJM1ZXMaA+vrzvWLo+G467
         IJ2gJ91KhdjB66EJxTJygbseWz7IiVnwb8a18jH3v8BYcy1P3Jt3jFhFi+tEpm/7J5cx
         A4lzT7xvITlXm6a9gztcGaT+BweiUEL4tmn5inBe1zRR3tvDEerKmxojmQb3++ulQ8zj
         Xcl4P4nNFjZTyTpZ0oH7cxa+TLMeeheCn2zMvlJZQ5PTkD48mNA61zlYNR2h95EQv+O9
         Wr9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMun27QLObkgSVSNYhXKeJY9HGPXw8DqSnQ5tamRcBQNEa7guasi2sja/5jiqsk7i//8qWYFC9TCJ27XIXiDg2bC9fMjE7z/by54N2
X-Gm-Message-State: AOJu0YyVdMl9/HnRPSs2h3DwQzaqFUGL01xigEfTuoiZBOkvxTuwpRUR
	VnS4aGyKR+eUl27BtKDiU7h5/F5fMB1w1w74OzwFdZB0DMXNn1fT
X-Google-Smtp-Source: AGHT+IHEI3ELvoumHxz09rfUnzEJLqvH383+eci7go1Lny9bXfK6g9YunLCBD7n2NuJYOyGNjTSRUg==
X-Received: by 2002:a17:90a:4585:b0:2c9:888a:7a7b with SMTP id 98e67ed59e1d1-2cff945a894mr16090920a91.25.1722980061252;
        Tue, 06 Aug 2024 14:34:21 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1b2b677bdsm55394a91.36.2024.08.06.14.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 14:34:20 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 6 Aug 2024 11:34:19 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Ingo Molnar <mingo@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] sched_ext: Initial pull request for v6.11
Message-ID: <ZrKW2wZTT3myBI0d@slm.duckdns.org>
References: <ZpWjbCQPtuUcvo8r@slm.duckdns.org>
 <20240723163358.GM26750@noisy.programming.kicks-ass.net>
 <ZqAFtfSijJ-KMVHo@slm.duckdns.org>
 <20240724085221.GO26750@noisy.programming.kicks-ass.net>
 <ZqmVG9ZiktN6bnm0@slm.duckdns.org>
 <20240806211002.GA37996@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806211002.GA37996@noisy.programming.kicks-ass.net>

Hello, Peter.

On Tue, Aug 06, 2024 at 11:10:02PM +0200, Peter Zijlstra wrote:
...
> > Right, I don't think it affects SCX in any significant way. Either way
> > should be fine.
> 
> So I just looked at things. And considering we currently want to have:
> 
>   pick_next_task := pick_task() + set_next_task(.first = true)
> 
> and want to, with those other patches moving put_prev_task() around, get
> to fully making pick_next_task() optional, it looks to me you're not
> quite there yet. Notably:

Oh yes, the code definitely needs updating. I just meant that the needed
changes are unlikely to be invasive.

...
> > +	p = first_local_task(rq);
> > +	if (!p)
> > +		return NULL;
> > +
> > +	set_next_task_scx(rq, p, true);
> > +
> > +	if (unlikely(!p->scx.slice)) {
> > +		if (!scx_ops_bypassing() && !scx_warned_zero_slice) {
> > +			printk_deferred(KERN_WARNING "sched_ext: %s[%d] has zero slice in pick_next_task_scx()\n",
> > +					p->comm, p->pid);
> > +			scx_warned_zero_slice = true;
> > +		}
> > +		p->scx.slice = SCX_SLICE_DFL;
> > +	}
> 
> This condition should probably move to set_next_task_scx(.first = true).

Sure.

...
> > +static struct task_struct *pick_task_scx(struct rq *rq)
> > +{
> > +	struct task_struct *curr = rq->curr;
> > +	struct task_struct *first = first_local_task(rq);
> > +
> > +	if (curr->scx.flags & SCX_TASK_QUEUED) {
> > +		/* is curr the only runnable task? */
> > +		if (!first)
> > +			return curr;
> > +
> > +		/*
> > +		 * Does curr trump first? We can always go by core_sched_at for
> > +		 * this comparison as it represents global FIFO ordering when
> > +		 * the default core-sched ordering is used and local-DSQ FIFO
> > +		 * ordering otherwise.
> > +		 *
> > +		 * We can have a task with an earlier timestamp on the DSQ. For
> > +		 * example, when a current task is preempted by a sibling
> > +		 * picking a different cookie, the task would be requeued at the
> > +		 * head of the local DSQ with an earlier timestamp than the
> > +		 * core-sched picked next task. Besides, the BPF scheduler may
> > +		 * dispatch any tasks to the local DSQ anytime.
> > +		 */
> > +		if (curr->scx.slice && time_before64(curr->scx.core_sched_at,
> > +						     first->scx.core_sched_at))
> > +			return curr;
> > +	}
> 
> And the above condition seems a little core_sched specific. Is that
> suitable for the primary pick function?

Would there be any distinction between pick_task() being called for regular
and core sched paths?

Thanks.

-- 
tejun

