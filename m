Return-Path: <linux-kernel+bounces-227074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A250E9147F8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5A101C220FF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB69E137772;
	Mon, 24 Jun 2024 11:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="MOL3yUBk"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A405545025
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719226893; cv=none; b=Xxf4xsdDwqa2H8kQ2vZ+qJw4AjMHK3L9c1Sq/E0zNFbXBbeE9Yg+s6Qio4vb+WxlVk4yNzJaLEdf3A5KaHhmUnbgfAQ+cEsZrUzVaiS7U09VWgj7IYvexgum97G9Hvh4eY4WpGqywREwHbKECvFc7qrEiIkhpjlDr7GfWU+Lba8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719226893; c=relaxed/simple;
	bh=yh93ux9568/xRXncDiVY0WH9XfZA5PUqbJUFCtvPJRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WYlAiVBCHH1WQdxcspMa5FW+kNgUF7BRoudBVdSrmCGaY4PAyhTFq1IbAIXnsklQbxahScvLGgvVywFB3vMkaGXZawKVYRB0tquN3MZ4dL7ZVYU34d+B4clxfY17OWd6tzF703v6JMPLlwpkg934eFM2lblHNj6htIuomJf1TeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=MOL3yUBk; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-63174692a02so38198867b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 04:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1719226890; x=1719831690; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tg+MQDtcXtc7me8fx44+5SQkNDdqGH9rGly1pgCEhtQ=;
        b=MOL3yUBk6VegIsmFG3wtnAXSZ1Ne5FD63dp6JYJ7qWpZKtbUN9SCFSGT5zIBxJoEGQ
         PPLHuXSOyylRGC9ulRNhS3Gs0KypYRoXlChLchk8gPZpHa8Yw1NNZB1G/pB/J6hwoW7X
         b2gtgsNe9PdGBjZ1bZaGBsxEBB7mWTt3eq/RRf/t3JGiKROT2w3yH/omDoSM91jvV7QX
         q6cxM+LwpTKCtQvM73fEBr2U8rd+2YlsMf3aRKq+yweMZDfYoWLhPYuDoe4GCsr/axFs
         SSJYYovpkk8Kgh9cxpaK7A9mEER5L91WrSLPFEy3MYClECpYSG3cTjYKfxz7jYEa92S+
         D56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719226890; x=1719831690;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tg+MQDtcXtc7me8fx44+5SQkNDdqGH9rGly1pgCEhtQ=;
        b=N7qDr52km7d5I3oWusVbBXaweY4ocPux2/xDOqOKosnmAF0kR+8BUSIbwnB2KcQnZq
         jo4SI+rhv9ELNhihnVXxQ/zFO1C6yD9bIDg3gHDQsOZKfOKoIV3c43wHVg8m6NAIi+jC
         yg/DWasX6u6fbgDJkT4YuP17YQodQEJeVOBFin5SGjRAx4a/7UuMiCssHFKZrwj/ACiG
         DLmMT8vKwtFPFG9RSuty10UAFRaEvdHhxqcJbGjb0WsN2HO1mgIQdPZk2xBcHBmShEz7
         Ug1Aa36RquHoEC2BlgKxksydbkdxCVlhgYb/0jVS+75dOeAeKbFq7/4WNGalqIlVXS4n
         lMZg==
X-Forwarded-Encrypted: i=1; AJvYcCVi+npxXxv5C6lbCFexF5wYexSblxMEZRU/dBdQmEnBZu3fIGTxwglwLKAx4X5gU97Nf4Do0/XT338FpaL1tui5uHyDxfMzU37um2oD
X-Gm-Message-State: AOJu0Yy9LlLubNa5LGR+bqz6MVfDNbpScG9re7wY15Qjez4V3hOBcgaq
	2v6xAQ9SvWSqid+SgP4PWEm1DHIBeItq7XuqSWu+Y6iUgnE1ZhY1mXg5OJd2svjFW97NivMnL1n
	RD2xzGzGBYUbO5EVlGUV0Mwa6TTPjo8mSzz8vLQ==
X-Google-Smtp-Source: AGHT+IErPbfXJ7WhkSYULvCc7UtsNXJZ8KJdFnL6+TvBpLMP2FgcGOywVtEcj73rROF6Yz+s9oaJearEXz0d74ShVcY=
X-Received: by 2002:a0d:f103:0:b0:62c:c5f2:18a5 with SMTP id
 00721157ae682-64340ea5275mr41044527b3.40.1719226890328; Mon, 24 Jun 2024
 04:01:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403140116.3002809-1-vineeth@bitbyteword.org>
 <ZjJf27yn-vkdB32X@google.com> <CAO7JXPgbtFJO6fMdGv3jf=DfiCNzcfi4Hgfn3hfotWH=FuD3zQ@mail.gmail.com>
In-Reply-To: <CAO7JXPgbtFJO6fMdGv3jf=DfiCNzcfi4Hgfn3hfotWH=FuD3zQ@mail.gmail.com>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Mon, 24 Jun 2024 07:01:19 -0400
Message-ID: <CAO7JXPhMfibNsX6Nx902PRo7_A2b4Rnc3UP=bpKYeOuQnHvtrw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] Paravirt Scheduling (Dynamic vcpu priority management)
To: Sean Christopherson <seanjc@google.com>
Cc: Ben Segall <bsegall@google.com>, Borislav Petkov <bp@alien8.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Suleiman Souhlal <suleiman@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, himadrics@inria.fr, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	graf@amazon.com, drjunior.org@gmail.com
Content-Type: text/plain; charset="UTF-8"

> > Roughly summarazing an off-list discussion.
> >
> >  - Discovery schedulers should be handled outside of KVM and the kernel, e.g.
> >    similar to how userspace uses PCI, VMBUS, etc. to enumerate devices to the guest.
> >
> >  - "Negotiating" features/hooks should also be handled outside of the kernel,
> >    e.g. similar to how VirtIO devices negotiate features between host and guest.
> >
> >  - Pushing PV scheduler entities to KVM should either be done through an exported
> >    API, e.g. if the scheduler is provided by a separate kernel module, or by a
> >    KVM or VM ioctl() (especially if the desire is to have per-VM schedulers).
> >
> > I think those were the main takeaways?  Vineeth and Joel, please chime in on
> > anything I've missed or misremembered.
> >
> Thanks for the brief about the offlist discussion, all the points are
> captured, just some minor additions. v2 implementation removed the
> scheduling policies outside of kvm to a separate entity called pvsched
> driver and could be implemented as a kernel module or bpf program. But
> the handshake between guest and host to decide on what pvsched driver
> to attach was still going through kvm. So it was suggested to move
> this handshake(discovery and negotiation) outside of kvm. The idea is
> to have a virtual device exposed by the VMM which would take care of
> the handshake. Guest driver for this device would talk to the device
> to understand the pvsched details on the host and pass the shared
> memory details. Once the handshake is completed, the device is
> responsible for loading the pvsched driver(bpf program or kernel
> module responsible for implementing the policies). The pvsched driver
> will register to the trace points exported by kvm and handle the
> callbacks from then on. The scheduling will be taken care of by the
> host scheduler, pvsched driver on host is responsible only for setting
> the policies(placement, priorities etc).
>
> With the above approach, the only change in kvm would be the internal
> tracepoints for pvsched. Host kernel will also be unchanged and all
> the complexities move to the VMM and the pvsched driver. Guest kernel
> will have a new driver to talk to the virtual pvsched device and this
> driver would hook into the guest kernel for passing scheduling
> information to the host(via tracepoints).
>
Noting down the recent offlist discussion and details of our response.

Based on the previous discussions, we had come up with a modified
design focusing on minimum kvm changes. The design is as follows:
- Guest and host share scheduling information via shared memory
region. Details of the layout of the memory region, information shared
and actions and policies are defined by the pvsched protocol. And this
protocol is implemented by a BPF program or a kernel module.
- Host exposes a virtual device(pvsched device to the guest). This
device is the mechanism for host and guest for handshake and
negotiation to reach a decision on the pvsched protocol to use. The
virtual device is implemented in the VMM in userland as it doesn't
come in the performance critical path.
- Guest loads a pvsched driver during device enumeration. the driver
initiates the protocol handshake and negotiation with the host and
decides on the protocol. This driver creates a per-cpu shared memory
region and shares the GFN with the device in the host. Guest also
loads the BPF program that implements the protocol in the guest.
- Once the VMM has all the information needed(per-cpu shared memory
GFN, vcpu task pids etc), it loads the BPF program which implements
the protocol on the host.
- BPF program on the host registers the trace points in kvm to get
callbacks on interested events like VMENTER, VMEXIT, interrupt
injection etc. Similarly, the guest BPF program registers tracepoints
in the guest kernel for interested events like sched wakeup, sched
switch, enqueue, dequeue, irq entry/exit etc.

The above design is minimally invasive to the kvm and core kernel and
implements the protocol as loadable programs and protocol handshake
and negotiation through the virtual device framework. Protocol
implementation takes care of information sharing and policy
enforcements and scheduler handles the actual scheduling decisions.
Sample policy implementation(boosting for latency sensitive workloads
as an example) could be included in the kernel for reference.

We had an offlist discussion about the above design and a couple of
ideas were suggested as an alternative. We had taken an action item to
study the alternatives for the feasibility. Rest of the mail lists the
use cases(not conclusive) and our feasibility investigations.

Existing use cases
-------------------------

- A latency sensitive workload on the guest might need more than one
time slice to complete, but should not block any higher priority task
in the host. In our design, the latency sensitive workload shares its
priority requirements to host(RT priority, cfs nice value etc). Host
implementation of the protocol sets the priority of the vcpu task
accordingly so that the host scheduler can make an educated decision
on the next task to run. This makes sure that host processes and vcpu
tasks compete fairly for the cpu resource.
- Guest should be able to notify the host that it is running a lower
priority task so that the host can reschedule it if needed. As
mentioned before, the guest shares the priority with the host and the
host takes a better scheduling decision.
- Proactive vcpu boosting for events like interrupt injection.
Depending on the guest for boost request might be too late as the vcpu
might not be scheduled to run even after interrupt injection. Host
implementation of the protocol boosts the vcpu tasks priority so that
it gets a better chance of immediately being scheduled and guest can
handle the interrupt with minimal latency. Once the guest is done
handling the interrupt, it can notify the host and lower the priority
of the vcpu task.
- Guests which assign specialized tasks to specific vcpus can share
that information with the host so that host can try to avoid
colocation of those cpus in a single physical cpu. for eg: there are
interrupt pinning use cases where specific cpus are chosen to handle
critical interrupts and passing this information to the host could be
useful.
- Another use case is the sharing of cpu capacity details between
guest and host. Sharing the host cpu's load with the guest will enable
the guest to schedule latency sensitive tasks on the best possible
vcpu. This could be partially achievable by steal time, but steal time
is more apparent on busy vcpus. There are workloads which are mostly
sleepers, but wake up intermittently to serve short latency sensitive
workloads. input event handlers in chrome is one such example.

Data from the prototype implementation shows promising improvement in
reducing latencies. Data was shared in the v1 cover letter. We have
not implemented the capacity based placement policies yet, but plan to
do that soon and have some real numbers to share.

Ideas brought up during offlist discussion
-------------------------------------------------------

1. rseq based timeslice extension mechanism[1]

While the rseq based mechanism helps in giving the vcpu task one more
time slice, it will not help in the other use cases. We had a chat
with Steve and the rseq mechanism was mainly for improving lock
contention and would not work best with vcpu boosting considering all
the use cases above. RT or high priority tasks in the VM would often
need more than one time slice to complete its work and at the same,
should not be hurting the host workloads. The goal for the above use
cases is not requesting an extra slice, but to modify the priority in
such a way that host processes and guest processes get a fair way to
compete for cpu resources. This also means that vcpu task can request
a lower priority when it is running lower priority tasks in the VM.

2. vDSO approach
Regarding the vDSO approach, we had a look at that and feel that
without a major redesign of vDSO, it might be difficult to achieve the
requirements. vDSO is currently implemented as a shared read-only
memory region with the processes. For this to work with
virtualization, we would need to map a similar region to the guest and
it has to be read-write. This is more or less what we are also
proposing, but with minimal changes in the core kernel. With the
current design, the shared memory region would be the responsibility
of the virtual pvsched device framework.

Sorry for the long mail. Please have a look and let us know your thoughts :-)

Thanks,

[1]: https://lore.kernel.org/all/20231025235413.597287e1@gandalf.local.home/

