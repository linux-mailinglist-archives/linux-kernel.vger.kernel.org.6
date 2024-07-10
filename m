Return-Path: <linux-kernel+bounces-248429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B128192DD12
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3F611C20C0D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F4715ADA7;
	Wed, 10 Jul 2024 23:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGUwBh/6"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACA9158D94
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 23:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720654997; cv=none; b=nT8blKgWc5nOWe80pLK65LHNSmqzWfJRA53hRtuEqZIGIhE2DGeVhYZvePUdqeo/iuAKpW9UJRXQN6MEW9DwaAR+sGp4sTsraAa1tkRNQLkHM4VwAqOQZ1uVtgT18c2sEEBoItd8inmTCFV4T5331K8xxFYQB41gsF197RWy6hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720654997; c=relaxed/simple;
	bh=rLWyiONiXsMyHhXZVdfsJf3MzKaOeJ/zEkEyJfLmQag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llF6qQ+Zu0ZGKY5C5u1yrS7zcAbv8mmK4BNwDP39BS0xNDNIYnmjDLL1/Py4IzkMWKEBEmXrsW8pcbx+EL/DfymzSjSlk87LUVoyHU/3uUbci1Ut7X+fNrDMI6G3MczVYP4B7zJMVsg+z6/QKFhsOWW3Kp6ys8w58+oPwGaGdes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGUwBh/6; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70b1207bc22so279920b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720654996; x=1721259796; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V937Ohl2yHpC/FQv3dDksb628dsRh/2jGeE2+HyQvUE=;
        b=XGUwBh/6+8mYTP8fYMuFmsLn+26ZbuUorPQ0qbaL28J9tFruYt2zr17VXPju1q9Wk0
         y/8QfboyNX5vWvv3EhhDP3Lehv1/5+vcwsX5JWeFIKavB1LqedoREnjLiYlBhWdOYu71
         8iUgySenAVghtL80zNGUP7z2EKZ/y+sgFydnczyTyMpJFds1dnf/sanCpK47y8p+IU0R
         DyCgdhf3xOlk2zIpM0uTrSlA/1+IWyK/8XQ27fbfmxjNTeVaFkT6kmPVs6hd1vN/zXQp
         WzbEG2IHMJCxGkORtHFkK6CP4FLGBNTVNbjBIfpgQdb22lSYq/Tw6+ketv0zCi4xifel
         a4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720654996; x=1721259796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V937Ohl2yHpC/FQv3dDksb628dsRh/2jGeE2+HyQvUE=;
        b=AsuRALqdb/072Pq9/q4FwQTHYWzrv/DLQinz1c/MJktk5Bbyliv2KKGgTfEjJNVvbO
         puXS0UZe+BuAf3LC3VPlF8ljZCaXBRzCz5wZ/S5iqh8AxC+r/FagUFNKZzlBCJiupPxA
         whZKUUKo69eNW0bKWHGTcEMAjG77pAJiz5pjyLYPTrQ+DLhwt1VSdZGHFx4f6toKm8wo
         yIZYoPnANqINVu3f95NLwlgZNPCmxzQ0ScIlCjtR+ld7kjYLqG0fQ/HI8wrLPWec8sW2
         eEmtqKKtA2qaIg/OMF56toFzp84WmB8eNnkgl6PG4MzJYTOPqQEO/Wr9JE34+NEYB7dN
         Cztw==
X-Gm-Message-State: AOJu0YykydLOOImYxP6aGU6qsn6D3u6YqZfIY7jbmLlH0bOoYKoaj/SU
	MW3R1tgEwreCNOc0gO2QXlKMogUQlpYf8yQlJjH5bmJsZVCFgQSxLN/8iw==
X-Google-Smtp-Source: AGHT+IFRnfTEpxkShExrB/TVDIpX4pgf9+o10C8XzCrstXwBmB9/sNzzeokMG2PlFTNwQIebDtTx2A==
X-Received: by 2002:a05:6a00:4653:b0:70b:2531:1359 with SMTP id d2e1a72fcca58-70b4353aa65mr8437176b3a.10.1720654995558;
        Wed, 10 Jul 2024 16:43:15 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b4397bf2asm4522504b3a.142.2024.07.10.16.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 16:43:15 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 10 Jul 2024 13:43:14 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	schatzberg.dan@gmail.com, mingo@redhat.com, peterz@infradead.org,
	changwoo@igalia.com, righi.andrea@gmail.com
Subject: Re: [PATCH 5/6] sched_ext: Allow SCX_DSQ_LOCAL_ON for direct
 dispatches
Message-ID: <Zo8ckk3MFygpEZbL@slm.duckdns.org>
References: <20240709212137.1199269-1-tj@kernel.org>
 <20240709212137.1199269-6-tj@kernel.org>
 <20240710185135.GB317151@maniforge>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710185135.GB317151@maniforge>

Hello,

On Wed, Jul 10, 2024 at 01:51:35PM -0500, David Vernet wrote:
...
> > +	/*
> > +	 * If in balance, the balance callbacks will be called before rq lock is
> > +	 * released. Schedule one.
> > +	 */
> > +	if (rq->scx.flags & SCX_RQ_IN_BALANCE)
> > +		queue_balance_callback(rq, &rq->scx.deferred_bal_cb,
> > +				       deferred_bal_cb_workfn);
> 
> Should we be returning above if we're able to use a balance cb?

Oh yeah, it definitely should.

> Also, should we maybe add a WARN_ON_ONCE(rq->balance_callback ==
> &balance_push_callback)? I could see that being unnecessary given that we
> should never be hitting this path when the CPU is deactivated anyways, but the
> push callback thing is a kindn extraneous implementation detail so might be
> worth guarding against it just in case.

I'm not sure about that. It feels like a sched core detail which is better
left within sched core code rather than pushing to queue_balance_callback()
users. The deferred execution mechanism itself doesn't really care about how
the callback is run or the state of the CPU.

...
> > +static void process_ddsp_deferred_locals(struct rq *rq)
> > +{
> > +	struct task_struct *p, *tmp;
> > +
> > +	lockdep_assert_rq_held(rq);
> > +
> > +	/*
> > +	 * Now that @rq can be unlocked, execute the deferred enqueueing of
> > +	 * tasks directly dispatched to the local DSQs of other CPUs. See
> > +	 * direct_dispatch().
> > +	 */
> > +	list_for_each_entry_safe(p, tmp, &rq->scx.ddsp_deferred_locals,
> > +				 scx.dsq_list.node) {
> > +		s32 ret;
> > +
> > +		list_del_init(&p->scx.dsq_list.node);
> > +
> > +		ret = dispatch_to_local_dsq(rq, NULL, p->scx.ddsp_dsq_id, p,
> > +					    p->scx.ddsp_enq_flags);
> > +		WARN_ON_ONCE(ret == DTL_NOT_LOCAL);
> > +	}
> 
> As mentioned in the other thread, it might be simplest to just pin and unpin
> around this loop here to keep the logic simpler in the callee.

Yeah, I'm moving unpinning/repinning to outer balance function.

> > @@ -3589,6 +3714,7 @@ DEFINE_SCHED_CLASS(ext) = {
> >  #ifdef CONFIG_SMP
> >  	.balance		= balance_scx,
> >  	.select_task_rq		= select_task_rq_scx,
> > +	.task_woken		= task_woken_scx,
> 
> Should we update the comment in the caller in core.c given that rq is no longer
> only used for statistics tracking?

task_woken_rt() is already doing push_rt_task() which is kinda similar to
what scx is doing, so the comment was already stale. Yeah, please go ahead
and send a patch.

Thanks.

-- 
tejun

