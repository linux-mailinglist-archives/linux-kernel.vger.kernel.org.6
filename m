Return-Path: <linux-kernel+bounces-255270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA92933E3B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68F742837D6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD6F18131E;
	Wed, 17 Jul 2024 14:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZnXAoNP7"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F96B18130C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 14:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721225703; cv=none; b=MCmXDYIT0PpaxbEaX3HdkpPCHLDgiUYqnXbp2LuJqxZZzajg/+lPO6W2vtO+MwMIhaOMsCCA49zV/nYNJIWEq7DKKeYpTNvBgKSY+L2zunyw0A+s5jzp79cIolHxtWw/tsMhXbNngVJtEJnnFt2Z1omoefFn1hKVDrJFzrJ/hkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721225703; c=relaxed/simple;
	bh=+mNL3SMgOOdYptPNdpuhLuZrQ6eKZUvUI2Io7zuGatE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L2/4KSu4clpSz9pq5/aQDboCaweEVDRqPVAA2n6CdeR53uAqmbX1ZtsrB2ooynIvKAIgCVpU6gE5halgrfTInFJyP2WJlu7wVad/3hljVa9FIXWvuYV+Df7sGEOw5iTdRtzY7oi6J3bhDa2HQbidUiFXymvEjd4XQETUWhDjpz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZnXAoNP7; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e03623b24ddso13015984276.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721225701; x=1721830501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yfOwLepSJ5Yy5OSl359lPsDoTvmGyUvqzWSdLdogSHo=;
        b=ZnXAoNP7aBop6pJ9BsQBqSixcDxreP4tSFKeOsz9IBhBoxmXU7DniMY2aqUeJeEHna
         epaF34X1zafmpATmbKCmZvIZ6W/kG8sKC9e42jPoX5PX9gf6fDkE4FMNMxyIQPP0O4S+
         0O6dcg27APLgNqahIoU53Pd4aVeTNEd+RhHSMOS4kI1jm8jTQN1vmajYyuvy/wc3XX6s
         HFJGILi7jFzhvrMz/PjE30E5V2Z2g8HHAPtlhig6I8SXmscEiZi7vG+SkOPkXVNYzuV+
         yrs8WGkQ6aWrJ6zdlHAdjukNt3cZJu53Ru+oe65Zn0etGOvztPeU6MGOd2NfJ3bVJSn7
         EMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721225701; x=1721830501;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yfOwLepSJ5Yy5OSl359lPsDoTvmGyUvqzWSdLdogSHo=;
        b=c/wnpl21YitdfCDZZtq/Wz9kn204jBKZMbhDOri253WSoiUaCspgbM0gqIYg5/KuFY
         vQLCnhUbUTDMs53aWB/FG4Y4tsnN3OmHW+aKgHFPn1doTua4Q/ucmVaSupJUF9og+Z05
         qqsHjbholIwOET8YdEHIo6VzGOrVIgQRRxiHJCqu0s2LmiM6lVc6fFrBPBa43AyFTpcg
         f1E5W9Rdc2QWPTiVFSyg87gVR2RA/iCT39OM7W2svU5H4r2EMrU1HZZ/wcPmamFLQLr8
         i6pXqpJOSO4OAs8pEN+1xYzDtNdO34CGXq1g/FSx+K9fxRTSRc97XaZ0jR1ru8OqeCB8
         MJJg==
X-Forwarded-Encrypted: i=1; AJvYcCXfw+kRDCBLUqxvP5xjfe4WFsI8NDj34kH0yUlP58ev6VIob1CV2IsmedV3HYPJzZIkCXzQrWpYFQHdTQTbBHH6zRRg97o2eh4AMlIl
X-Gm-Message-State: AOJu0YzHYgfKrngcj8vWbFjlsKV1wnP+2WpyxCxc8ruLnx2zpSiOZ11e
	nyIRFcBsmvFuCImk2Q1zhTmhC3FsInh3alIQHN9dj0E9uMrvimnjhIeCTLp57Es/1pay0tQOoJe
	VqQ==
X-Google-Smtp-Source: AGHT+IHAgL65SrsUap9oLk8sgkDEhEl7hhfaitDvekS6/QgatWemDsFxo+e9KMYoAtW+baVNukp3gB4q8uI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:c0b:b0:e05:a890:5abb with SMTP id
 3f1490d57ef6-e05ed69e706mr11325276.1.1721225701169; Wed, 17 Jul 2024 07:15:01
 -0700 (PDT)
Date: Wed, 17 Jul 2024 07:14:59 -0700
In-Reply-To: <CAEXW_YS+8VKjUZ8cnkZxCfEcjcW=z52uGYzrfYj+peLfgHL75Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ZjJf27yn-vkdB32X@google.com> <CAO7JXPgbtFJO6fMdGv3jf=DfiCNzcfi4Hgfn3hfotWH=FuD3zQ@mail.gmail.com>
 <CAO7JXPhMfibNsX6Nx902PRo7_A2b4Rnc3UP=bpKYeOuQnHvtrw@mail.gmail.com>
 <66912820.050a0220.15d64.10f5@mx.google.com> <19ecf8c8-d5ac-4cfb-a650-cf072ced81ce@efficios.com>
 <20240712122408.3f434cc5@rorschach.local.home> <ZpFdYFNfWcnq5yJM@google.com>
 <20240712131232.6d77947b@rorschach.local.home> <ZpcFxd_oyInfggXJ@google.com> <CAEXW_YS+8VKjUZ8cnkZxCfEcjcW=z52uGYzrfYj+peLfgHL75Q@mail.gmail.com>
Message-ID: <ZpfR49IcXNLS9qbu@google.com>
Subject: Re: [RFC PATCH v2 0/5] Paravirt Scheduling (Dynamic vcpu priority management)
From: Sean Christopherson <seanjc@google.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>, Ben Segall <bsegall@google.com>, 
	Borislav Petkov <bp@alien8.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Mel Gorman <mgorman@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, 
	Suleiman Souhlal <suleiman@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, himadrics@inria.fr, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	graf@amazon.com, drjunior.org@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024, Joel Fernandes wrote:
> On Tue, Jul 16, 2024 at 7:44=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Fri, Jul 12, 2024, Steven Rostedt wrote:
> > > On Fri, 12 Jul 2024 09:44:16 -0700
> > > Sean Christopherson <seanjc@google.com> wrote:
> > >
> > > > > All we need is a notifier that gets called at every VMEXIT.
> > > >
> > > > Why?  The only argument I've seen for needing to hook VM-Exit is so=
 that the
> > > > host can speculatively boost the priority of the vCPU when delivery=
ing an IRQ,
> > > > but (a) I'm unconvinced that is necessary, i.e. that the vCPU needs=
 to be boosted
> > > > _before_ the guest IRQ handler is invoked and (b) it has almost no =
benefit on
> > > > modern hardware that supports posted interrupts and IPI virtualizat=
ion, i.e. for
> > > > which there will be no VM-Exit.
> > >
> > > No. The speculatively boost was for something else, but slightly
> > > related. I guess the ideal there was to have the interrupt coming in
> > > boost the vCPU because the interrupt could be waking an RT task. It m=
ay
> > > still be something needed, but that's not what I'm talking about here=
.
> > >
> > > The idea here is when an RT task is scheduled in on the guest, we wan=
t
> > > to lazily boost it. As long as the vCPU is running on the CPU, we do
> > > not need to do anything. If the RT task is scheduled for a very short
> > > time, it should not need to call any hypercall. It would set the shar=
ed
> > > memory to the new priority when the RT task is scheduled, and then pu=
t
> > > back the lower priority when it is scheduled out and a SCHED_OTHER ta=
sk
> > > is scheduled in.
> > >
> > > Now if the vCPU gets preempted, it is this moment that we need the ho=
st
> > > kernel to look at the current priority of the task thread running on
> > > the vCPU. If it is an RT task, we need to boost the vCPU to that
> > > priority, so that a lower priority host thread does not interrupt it.
> >
> > I got all that, but I still don't see any need to hook VM-Exit.  If the=
 vCPU gets
> > preempted, the host scheduler is already getting "notified", otherwise =
the vCPU
> > would still be scheduled in, i.e. wouldn't have been preempted.
>=20
> What you're saying is the scheduler should change the priority of the
> vCPU thread dynamically. That's really not the job of the scheduler.
> The user of the scheduler is what changes the priority of threads, not
> the scheduler itself.

No.  If we go the proposed route[*] of adding a data structure that lets us=
erspace
and/or the guest express/adjust the task's priority, then the scheduler sim=
ply
checks that data structure when querying the priority of a task.

[*] https://lore.kernel.org/all/ZpFWfInsXQdPJC0V@google.com

