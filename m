Return-Path: <linux-kernel+bounces-250789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8528E92FCD7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0355B1F23E49
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02804172BAA;
	Fri, 12 Jul 2024 14:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4sJBUnPP"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19AC1428E5
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720795694; cv=none; b=lefSxu2pJL8ctf0R1L1JdN6HlMeWFYZ48OIPBH8h7NJoPHV2dJQwEBltKx43jZ9sABUfmqvu26LkyQDg8CRoCUktf7tptOcXAcuwR30ou8/GhHJApfkuChtu7u/TEsvqTLNGtuHMAKhXXVWESZIpW1Phi5hGDmi2a3fIkewd64k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720795694; c=relaxed/simple;
	bh=80rcJMfWh81tg4yYUsIxsrVss197EKgxznoWXn6nA2U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qQgrQeUCRRs9DViBfEI38M0AJJITI5838YqJMds5cWSNZdfUzvzpSH1NsUFzUwMuU03uQb1AAOan0bwW4JL0gEw6teIZnRui6CVzWrRZeSleF/ngG1THwXGYPdDzZuHxcpRsmHWPUh74QNh9XAUCWRie8T/Ev2mpJxZ+3HhFYi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4sJBUnPP; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2c96a0c27fcso1853099a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 07:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720795692; x=1721400492; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uZsqMw09jqxGLOzroUJQUOORh6B+OaGFknZXtQVFLK8=;
        b=4sJBUnPPoSaY6Ra/RxEiyr1lmlwh0yEx7Tbjzzw7Ze+8kPBn2M6Ou/MnQa+4h1gIEM
         pGgF9ZnNgtIGf6pbD8ww+BnsqZF+S9H9pgvqVB+MTrVGwBMEcwHS28MlhiXe16i0K4MY
         Ia2rv9HKAf/iwZCzNkNjsoU7OWCxm3BktBTF7c8SNpXdHXurgdaNuyAYxjTyOUCqII5S
         MzQkdtvIFLmV2CtYSdsy5mJTj/VMNQ18EWtP5MSf+xOTXIMYF14Q47t5mFAVRBe1m4Bs
         d/2p6SPlOhE4bFywcXILDc7D3ARKcpzSLJk1MzjeDwWXtKlqg5geNT3xstj/DXMLZS/Y
         /2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720795692; x=1721400492;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uZsqMw09jqxGLOzroUJQUOORh6B+OaGFknZXtQVFLK8=;
        b=HFiIYlyqIlLh8NC/xSTp2J6adClKmulcET0/84GvJhhEmySzrHZzd2svPktzaQtG43
         xLCLOwfY0wM6vkGeNNCweg+C9HXDlt8O5b4sHsDK8tBBJjXEI0TGkDlpf3XQYJtG6SCl
         qzS+bPgHpkb+d3L2TWixEpbm7gFOlEVJD1iEqLsMlqMquJQg7vs4CmUGAucweENf5vKM
         E4XeqK30NFdU/SxOPKRwW7ZixoTIA0twsRG5kknb+qS4UE0J0816J7gONownyMr3jveQ
         Q1DOFNSurxOMpW2MgxxY993T/9s7T+k05wwlvQt7rk65GBqBqAhyMLJpJMeI5x4mKLl9
         OEuw==
X-Forwarded-Encrypted: i=1; AJvYcCVYLqYXaY4W8ltZbr8m5IxcKdSH8qH3kbinWnTqf+WrLBD1wubQ4g4zdA9BfCPb0GZjQ2KCYRuq0o6e1YUQh0/MkRXhjq5wIiWso/VO
X-Gm-Message-State: AOJu0YxY/zL5ZEmFFxn6OYRby/v7Qkz1iUE6/UEz9xy4s3EejrCe5cqX
	anQNJXoYF/56Hc3IkCf2i0uMqMmYAAtwO21feMnj3xe1GV9hcf4JC0cs2+wAHDlgz1ZhWcIIGjz
	8GA==
X-Google-Smtp-Source: AGHT+IFluPogLhVxKc6h87CEUfyEI/dFcQcRiTFW+Xaf4GzF5S7AOO2yuhtcbygmcEwqy4s9eyQS8X+SVQ0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:cc0d:b0:2c9:9232:75e3 with SMTP id
 98e67ed59e1d1-2ca35d38532mr25446a91.4.1720795691618; Fri, 12 Jul 2024
 07:48:11 -0700 (PDT)
Date: Fri, 12 Jul 2024 07:48:10 -0700
In-Reply-To: <19ecf8c8-d5ac-4cfb-a650-cf072ced81ce@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240403140116.3002809-1-vineeth@bitbyteword.org>
 <ZjJf27yn-vkdB32X@google.com> <CAO7JXPgbtFJO6fMdGv3jf=DfiCNzcfi4Hgfn3hfotWH=FuD3zQ@mail.gmail.com>
 <CAO7JXPhMfibNsX6Nx902PRo7_A2b4Rnc3UP=bpKYeOuQnHvtrw@mail.gmail.com>
 <66912820.050a0220.15d64.10f5@mx.google.com> <19ecf8c8-d5ac-4cfb-a650-cf072ced81ce@efficios.com>
Message-ID: <ZpFCKrRKluacu58x@google.com>
Subject: Re: [RFC PATCH v2 0/5] Paravirt Scheduling (Dynamic vcpu priority management)
From: Sean Christopherson <seanjc@google.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Joel Fernandes <joel@joelfernandes.org>, 
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>, Ben Segall <bsegall@google.com>, 
	Borislav Petkov <bp@alien8.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Mel Gorman <mgorman@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Suleiman Souhlal <suleiman@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, himadrics@inria.fr, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, graf@amazon.com, 
	drjunior.org@gmail.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 12, 2024, Mathieu Desnoyers wrote:
> On 2024-07-12 08:57, Joel Fernandes wrote:
> > On Mon, Jun 24, 2024 at 07:01:19AM -0400, Vineeth Remanan Pillai wrote:
> [...]
> > > Existing use cases
> > > -------------------------
> > > 
> > > - A latency sensitive workload on the guest might need more than one
> > > time slice to complete, but should not block any higher priority task
> > > in the host. In our design, the latency sensitive workload shares its
> > > priority requirements to host(RT priority, cfs nice value etc). Host
> > > implementation of the protocol sets the priority of the vcpu task
> > > accordingly so that the host scheduler can make an educated decision
> > > on the next task to run. This makes sure that host processes and vcpu
> > > tasks compete fairly for the cpu resource.
> 
> AFAIU, the information you need to convey to achieve this is the priority
> of the task within the guest. This information need to reach the host
> scheduler to make informed decision.
> 
> One thing that is unclear about this is what is the acceptable
> overhead/latency to push this information from guest to host ?
> Is an hypercall OK or does it need to be exchanged over a memory
> mapping shared between guest and host ?
> 
> Hypercalls provide simple ABIs across guest/host, and they allow
> the guest to immediately notify the host (similar to an interrupt).

Hypercalls have myriad problems.  They require a VM-Exit, which largely defeats
the purpose of boosting the vCPU priority for performance reasons.  They don't
allow for delegation as there's no way for the hypervisor to know if a hypercall
from guest userspace should be allowed, versus anything memory based where the
ability for guest userspace to access the memory demonstrates permission (else
the guest kernel wouldn't have mapped the memory into userspace).

> > > Ideas brought up during offlist discussion
> > > -------------------------------------------------------
> > > 
> > > 1. rseq based timeslice extension mechanism[1]
> > > 
> > > While the rseq based mechanism helps in giving the vcpu task one more
> > > time slice, it will not help in the other use cases. We had a chat
> > > with Steve and the rseq mechanism was mainly for improving lock
> > > contention and would not work best with vcpu boosting considering all
> > > the use cases above. RT or high priority tasks in the VM would often
> > > need more than one time slice to complete its work and at the same,
> > > should not be hurting the host workloads. The goal for the above use
> > > cases is not requesting an extra slice, but to modify the priority in
> > > such a way that host processes and guest processes get a fair way to
> > > compete for cpu resources. This also means that vcpu task can request
> > > a lower priority when it is running lower priority tasks in the VM.

Then figure out a way to let userspace boot a task's priority without needing a
syscall.  vCPUs are not directly schedulable entities, the task doing KVM_RUN
on the vCPU fd is what the scheduler sees.  Any scheduling enhancement that
benefits vCPUs by definition can benefit userspace tasks.

> > I was looking at the rseq on request from the KVM call, however it does not
> > make sense to me yet how to expose the rseq area via the Guest VA to the host
> > kernel.  rseq is for userspace to kernel, not VM to kernel.

Any memory that is exposed to host userspace can be exposed to the guest.  Things
like this are implemented via "overlay" pages, where the guest asks host userspace
to map the magic page (rseq in this case) at GPA 'x'.  Userspace then creates a
memslot that overlays guest RAM to map GPA 'x' to host VA 'y', where 'y' is the
address of the page containing the rseq structure associated with the vCPU (in
pretty much every modern VMM, each vCPU has a dedicated task/thread).

A that point, the vCPU can read/write the rseq structure directly.

The reason us KVM folks are pushing y'all towards something like rseq is that
(again, in any modern VMM) vCPUs are just tasks, i.e. priority boosting a vCPU
is actually just priority boosting a task.  So rather than invent something
virtualization specific, invent a mechanism for priority boosting from userspace
without a syscall, and then extend it to the virtualization use case.

> > Steven Rostedt said as much as well, thoughts? Add Mathieu as well.
> 
> I'm not sure that rseq would help at all here, but I think we may want to
> borrow concepts of data sitting in shared memory across privilege levels
> and apply them to VMs.
> 
> If some of the ideas end up being useful *outside* of the context of VMs,

Modulo the assertion above that this is is about boosting priority instead of
requesting an extended time slice, this is essentially the same thing as the
"delay resched" discussion[*].  The only difference is that the vCPU is in a
critical section, e.q. IRQ handler, versus the userspace task being in a critical
section.

[*] https://lore.kernel.org/all/20231025054219.1acaa3dd@gandalf.local.home

> then I'd be willing to consider adding fields to rseq. But as long as it is
> VM-specific, I suspect you'd be better with dedicated per-vcpu pages which
> you can safely share across host/guest kernels.

