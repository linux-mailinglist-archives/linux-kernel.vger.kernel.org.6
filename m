Return-Path: <linux-kernel+bounces-359741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88612998FD1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 246BD28679C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A2C1CDFD3;
	Thu, 10 Oct 2024 18:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s0JwQEt2"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F74D17BB32
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584637; cv=none; b=IpsfQAqrxnrxMoSmVjFaMlvw/+8HYod35jVSWPFsTIm4i6b6Pox9PRN2k9kbpBqZ8Q51Fz+4Qsj7wuZv7+8sxGJ3asjZjq4NDVSKO2qo436v4SyVYlTDoU3iXtL3EVWD+MK1v5Szh5ufR76n/VObVPqNKhHGCfInUKaq73Zciik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584637; c=relaxed/simple;
	bh=Wmg0PWvt3WloQSDzy40kPeWutCLR/9gx0+GwUl5x7Rc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FoFUK+ry6a0ifudSRAFQaV5GB9AscPPRy0hVfiwg1fgBIXpvNjnLvp1wrojAgos4oCPCL/9kPwbDXn7Wh2NrZ8Yb7U9eqF98YvB5ozsUznycRrjo6ohc5S1qlQta6tSY0d6mBvzd1OdU7Hm3zh94vqElN+HhjDxArOBRCvd5SFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s0JwQEt2; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e28eea1074dso1977826276.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728584634; x=1729189434; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OqewRWhuvMwo0Bco6jB7T6q+2ZKwD2xyzgsyOWDZbow=;
        b=s0JwQEt2ps+OyXU5RZG6JiilD0HFAADPnWVy+nKLZTSvB+/WQCf4U7nJn6YXj3cnkk
         Yf4mTlUQeoqm2EUY/zkccOJX+yY505wIDEUggufsXKty5o7WKfIgiR70ZEe1zwxFIjkp
         WWaXXLI8gKkX9RYhB/Pfgz7OOdA4/nfmNYAgkt1gs45Oo8eg8XT04ZgZDvYHvm83pZnz
         aiGJxQRZsdylzO4TZot35N+yy8e6cuezGCOxogvPgSHIAMD9lJzqNVomzm1cNNCfjbWM
         VGmROtDMzP3Uq4aLXR58y37nTGOGzDFyo56OSy6Ulw/bZrn3KyjXmsJbV96KuW2sA8i5
         b3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728584634; x=1729189434;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OqewRWhuvMwo0Bco6jB7T6q+2ZKwD2xyzgsyOWDZbow=;
        b=E0Jk9p2Ol+BuqGjHayZzRhVP7wtxyfm5osfrXWx4NpmWhgMAzi1ArygZ8ef7sD2Yml
         rerwIU6QmoJ/E5rmDlFxor6ku0OZEdzZPrfQr+z0NLqn41VhqDrT4UrsFO5+BiMKbj0q
         JkySUMYxPQf5LZZUKgMrnxJJYR4ZW4bFCphTdvVUgkyh1vSXDLkP/e0MPm0qXHjpwd/6
         G2VzoogTmgSDnWjiFqtbDAMyEf54Jtj81pE95DYahj504UUmP1W1sk5uB0PeTUpZie80
         C3he+KYguURnkMJFHrwldOCn+dtYhoQkeV+/0twNd8EeMqtsfcN4qzHzWHZT+TYRPR+Z
         Vjug==
X-Forwarded-Encrypted: i=1; AJvYcCXCeZrjvxyrF0HSUEvAr5HBnUmY/Ti8SarHybdLJZR81MdrRrIBapttPm45y0ZLVorLRPBSXq9UAASXcls=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfQUIkYWJOZniDyJl8p7IfWEN94pGf4M0fkkrM1z4RLvIthEA/
	JZnxllTOD1dnvcEKGT2pMmEdPG9kvC2sfre7eiWDPMkBzuHPk+nj6sv0JXFEVf97WiaS2aLvZ/h
	CZw==
X-Google-Smtp-Source: AGHT+IH9ywuf6nxC3oZt4wl64os4x2Nl/eKP0XQEvyFMCWMOfF9Ka8reJJL/xMnlzP7eGHO8qjM9XEpQziI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:6902:b19:b0:e28:f19d:ed45 with SMTP id
 3f1490d57ef6-e28fe348675mr93685276.4.1728584634284; Thu, 10 Oct 2024 11:23:54
 -0700 (PDT)
Date: Thu, 10 Oct 2024 11:23:52 -0700
In-Reply-To: <20241010091843.GK33184@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240727102732.960974693@infradead.org> <20240727105030.226163742@infradead.org>
 <CGME20240828223802eucas1p16755f4531ed0611dc4871649746ea774@eucas1p1.samsung.com>
 <5618d029-769a-4690-a581-2df8939f26a9@samsung.com> <ZwdA0sbA2tJA3IKh@google.com>
 <20241010081940.GC17263@noisy.programming.kicks-ass.net> <20241010091843.GK33184@noisy.programming.kicks-ass.net>
Message-ID: <ZwgbuA5rggErT7ev@google.com>
Subject: Re: [PATCH 17/24] sched/fair: Implement delayed dequeue
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, mingo@redhat.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, kprateek.nayak@amd.com, 
	wuyun.abel@bytedance.com, youssefesmat@chromium.org, tglx@linutronix.de, 
	efault@gmx.de, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Oct 10, 2024, Peter Zijlstra wrote:
> On Thu, Oct 10, 2024 at 10:19:40AM +0200, Peter Zijlstra wrote:
> > On Wed, Oct 09, 2024 at 07:49:54PM -0700, Sean Christopherson wrote:
> > 
> > > TL;DR: Code that checks task_struct.on_rq may be broken by this commit.
> > 
> > Correct, and while I did look at quite a few, I did miss KVM used it,
> > damn.
> > 
> > > Peter,
> > > 
> > > Any thoughts on how best to handle this?  The below hack-a-fix resolves the issue,
> > > but it's obviously not appropriate.  KVM uses vcpu->preempted for more than just
> > > posted interrupts, so KVM needs equivalent functionality to current->on-rq as it
> > > was before this commit.
> > > 
> > > @@ -6387,7 +6390,7 @@ static void kvm_sched_out(struct preempt_notifier *pn,
> > >  
> > >         WRITE_ONCE(vcpu->scheduled_out, true);
> > >  
> > > -       if (current->on_rq && vcpu->wants_to_run) {
> > > +       if (se_runnable(&current->se) && vcpu->wants_to_run) {
> > >                 WRITE_ONCE(vcpu->preempted, true);
> > >                 WRITE_ONCE(vcpu->ready, true);
> > >         }
> > 
> > se_runnable() isn't quite right, but yes, a helper along those lines is
> > probably best. Let me try and grep more to see if there's others I
> > missed as well :/
> 
> How's the below? I remember looking at the freezer thing before and
> deciding it isn't a correctness thing, but given I added the helper, I
> changed it anyway. I've added a bunch of comments and the perf thing is
> similar to KVM, it wants to know about preemptions so that had to change
> too.

Fixes KVM's woes!  Thanks!

