Return-Path: <linux-kernel+bounces-571118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A19A6B95F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E6107A8444
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7482206A3;
	Fri, 21 Mar 2025 10:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ini8lail"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC511DE3CE;
	Fri, 21 Mar 2025 10:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742554791; cv=none; b=MrpLIg9TBfSxfEAFou5rMsgBZObJCe8s3a/D3GEzCFQEIe8DxAto83o95eNKGsXwX2RKdNOG5uGJ8VQ6WJb5kx7DNtRte21r8JfO76F4xW0IKAl2rOzeQcTV2Nfs8O5b0rqpDeJpjq8IDpWYTD0dN9s5gHMTme1PYv7g9D2bcOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742554791; c=relaxed/simple;
	bh=N1mkHZgQgs9watC9uMZmyEw67VpYPwl0Cw1Zn6tkn3A=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YS1AuFUzmELlZgD44rR1gk1jpVtHKLmGVZhONcty6ITPfiu+d6G+nhDh9MZkfWYE0XglM4SmVwSDopPVp29Pg7JOxjIfxPUF6A8WrqtwjWVI4NIy3FQH8j63kalK5DmFj970dZG/NVVij+khwiM+nhpx92mQB0HYt4Ux6FhQXYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ini8lail; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0834C4CEE3;
	Fri, 21 Mar 2025 10:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742554790;
	bh=N1mkHZgQgs9watC9uMZmyEw67VpYPwl0Cw1Zn6tkn3A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ini8lailN+6YRG6tZ+F+cevI8q2ZhAzAzqTzW2a8gbFZJD45IdYRXzzXLeBsueOOn
	 i7i/pPofZz79dObPgyVHpNfjvd7jddLRJb13rmn0xoNYle8le8U2q+LKWfsyDcELYi
	 KJ3JKs1Q2xrgVvdLDK+FgShY1Qnj7Tce/QZhFzlz2L0mi8dtKMLyJLVmGOzCHTS+CE
	 SpmXXJoNi+U62xPiFg8TNfyG4HaN2tnsauPkHJ+ig1v9DClkzl+c4zvGxV75uLZ4dI
	 xqFY+IOl+7EgVa8PVBO+5wHQRW2GF+28gY+6am9GL3wFwQMVQZPyvcdFB14WcdFae5
	 UeLAd5WvAXZKg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tva6O-00Fkzp-6N;
	Fri, 21 Mar 2025 10:59:48 +0000
Date: Fri, 21 Mar 2025 10:59:47 +0000
Message-ID: <86a59emyxo.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose
 <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	devel@daynix.com
Subject: Re: [PATCH RFC] KVM: arm64: PMU: Use multiple host PMUs
In-Reply-To: <54cb5388-e278-41de-be29-d578cc5c37c5@daynix.com>
References: <20250319-hybrid-v1-1-4d1ada10e705@daynix.com>
	<Z9pze3J2_zrTk_yC@linux.dev>
	<e8324d9d-3756-41cf-a102-28572e302368@daynix.com>
	<86plidmjwh.wl-maz@kernel.org>
	<bd681ec6-0b4c-47d9-8a4a-b7324c0883a6@daynix.com>
	<86o6xxmg87.wl-maz@kernel.org>
	<aabd71eb-286b-475c-a30e-d5cf5c4f2769@daynix.com>
	<86msdhmemw.wl-maz@kernel.org>
	<cd7b4528-34a3-4d87-9711-acc2c2e6f6e1@daynix.com>
	<86ldt0n9w1.wl-maz@kernel.org>
	<Z9sSMJAlf7cQ5viu@linux.dev>
	<0d84bc94-1c65-4737-a2eb-aa7f96a7d1e0@daynix.com>
	<86iko4m5i4.wl-maz@kernel.org>
	<ba9cd6d2-1ee5-478a-8102-42b4dac411ce@daynix.com>
	<86cyebmxo7.wl-maz@kernel.org>
	<54cb5388-e278-41de-be29-d578cc5c37c5@daynix.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.4
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: akihiko.odaki@daynix.com, oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, kees@kernel.org, gustavoars@kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, devel@daynix.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Fri, 21 Mar 2025 06:20:49 +0000,
Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> 
> On 2025/03/21 2:14, Marc Zyngier wrote:
> > On Thu, 20 Mar 2025 09:52:59 +0000,
> > Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> >> 
> >> On 2025/03/20 18:10, Marc Zyngier wrote:
> >>> On Thu, 20 Mar 2025 06:03:35 +0000,
> >>> Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> >>>> 
> >>>> On 2025/03/20 3:51, Oliver Upton wrote:
> >>>>> On Wed, Mar 19, 2025 at 06:38:38PM +0000, Marc Zyngier wrote:
> >>>>>> On Wed, 19 Mar 2025 11:51:21 +0000, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> >>>>>>> What about setting the flag automatically when a user fails to pin
> >>>>>>> vCPUs to CPUs that are covered by one PMU? There would be no change if
> >>>>>>> a user correctly pins vCPUs as it is. Otherwise, they will see a
> >>>>>>> correct feature set advertised to the guest and the cycle counter
> >>>>>>> working.
> >>>>>> 
> >>>>>> How do you know that the affinity is "correct"? VCPU affinity can be
> >>>>>> changed at any time. I, for one, do not want my VMs to change
> >>>>>> behaviour because I let the vcpus bounce around as the scheduler sees
> >>>>>> fit.
> >>>> 
> >>>> Checking the affinity when picking the default PMU; the vCPU affinity
> >>>> is the only thing that rules the choice of the default PMU even now.
> >>>> 
> >>>> Perhaps we may model the API as follows: introduce another "composite"
> >>>> PMU that works on any core but only exposes the cycle counter. Robust
> >>>> VMMs will choose it or one of hardware PMUs with
> >>>> KVM_ARM_VCPU_PMU_V3_SET_PMU. KVM will choose the default PMU according
> >>>> to the vCPU affinity at the point of KVM_ARM_VCPU_INIT otherwise. If
> >>>> the affinity is covered by one hardware PMU, that PMU will be chosen
> >>>> as the default. The "composite" PMU will be the default otherwise.
> >>> 
> >>> This makes no sense to me. A VCPU is always affine to a PMU, because
> >>> we do not support configurations where only some CPUs have a PMU. This
> >>> is an all-or-nothing situation.
> >> 
> >> At least isn't it fine to have the composite PMU with a new value for
> >> KVM_ARM_VCPU_PMU_V3_SET_PMU?
> > 
> > Not sure KVM_ARM_VCPU_PMU_V3_SET_PMU is the right hook (it takes a PMU
> > 'type', which is under control of the perf subsystem). But if we can
> > find a value that is guaranteed to be unique, why not.
> > 
> >>> More importantly, you keep suggesting the same "new default", and I
> >>> keep saying NO.
> >>> 
> >>> My position is clear: if you want a *new* behaviour, you *must* add a
> >>> new flag that the VMM explicitly provides to enable this CC-only PMU.
> >>> No change in default behaviour at all.
> >>> 
> >>> I'm not going to move from that.
> >> 
> >> Why not? It will not break anything guaranteed to work in the past.
> > 
> > It doesn't have to be guaranteed. It just has to *exist*. That's the
> > Linux ABI for you.
> > 
> >> Currently KVM only guarantees that the emulated PMU correctly counts
> >> only when
> >> 1) the vCPU affinity is contained by one PMU and
> >> 2) it will not expand
> >> 
> >> Breaking these conditions will make the behavior of the emulated PMU
> >> undefined. Now I'm proposing to remove 1).
> > 
> > And I'm saying no to that. I'm also getting tired of arguing the same
> > point on and on.
> > 
> > We currently have two different behaviours:
> > 
> > - either you explicitly set a PMU, and the affinity of this PMU
> >    constraints the affinity of the vcpus. The vcpus are not allowed to
> >    run outside of this affinity. Everything counts all the time.
> > 
> > - or you don't explicitly set a PMU, and a default PMU will be picked
> >    from the current affinity of the first vcpu. Your vcpus will be able
> >    to run anywhere, but the virtual PMU will *only* count when the
> >    vcpus are affine to the default PMU. When the vcpus are not affine
> >    to default PMU, *nothing* counts.
> > 
> > These two behaviours are ABI. They are not changing. They don't get
> > relaxed, they don't get tightened, they stay just as they are,
> > forever.
> 
> Is the latter one is really ABI? I see it as part of behaviors that
> are undefined and not included in ABI for the following reasons:
> 
> 1) It depends on the scheduler behavior, which cannot be ABI.

You're wrong. The task affinity is under complete control of
userspace. sched_setaffinity(2) is your friend.

> 2) It provides a broken PMU so the proposed behavioral change is
> similar a bug fix though I call it a undefined behavior instead of a
> bug as it is explicitly told that there is no assurance that the PMU
> works in such a scenario.

Call it undefined behaviour if you want, I call it ABI. This is how
the PMU has been handled on KVM/arm64 for the past 10 years, and the
fact that you (and I) don't like it doesn't make it less of an
existing behaviour that must be preserved.

> 3) The userspace could not have relied on it so the "no regressions"
> rule cannot be applied here; how can anyone have a userspace that
> relies on a kernel behavior that depends on scheduling?

Of course it has. Read the above.

Even more, I contend that your approach is just wrong. You want to
make random events count at random times, which is even worse. We can
at least pretend that the PMU hasn't recorded anything (which is true)
rather than saying "oh look, the cycle counter has ticked but we
didn't execute any instruction -- WTF were we doing?".

That approach is far worse than what we have today.

Let me give you an example:

- I have an asymmetric system with two types of CPUs (any odd
  big-little nonsense)

- I statically place my vcpus on physical CPUs so that only some vcpus
  are effectively generating events by using my knowledge of the
  "default PMU" behaviour.

- I perform system-wide profiling inside the guest with the full
  knowledge that only the vcpus I'm interested in will affect the
  event counts. This is deterministic.

- I can move vcpus around as I see fit to capture new counter sets
  with the same guarantees.

Your "count random stuff at random times on random CPUs" breaks this.

Is this a contrived example? Of course it is. Do we know for sure that
nobody in their right mind would do this? No, because we don't have a
mandate to decide what people can or cannot do with a behaviour that
has been established for that long.

> But for 3), Oliver raised a concern for the guest compatibility so I'd
> like to hear an explanation for that concern.

I've given it above, and in my reply to Oliver as well.

> > You want a *third* behaviour, go ahead. Define it the way you want.
> > But the behaviours described above will stay unchanged.
> > I'm looking forward to your patches implementing it, but I am also
> > done arguing on it.
> 
> I understand the discussion is tiring but I want to know the reasoning
> behind such a design decision before sending an RFC patch to a VMM
> (QEMU) so that I can explain them why it is necessary in turn.

But that's *again* where you got things completely wrong:

<allcaps>
  This is not a design decision, this is how things have always worked
  and we cannot break previous behaviours. This is unfortunate, but
  that's how the Linux kernel works.
</allcaps>

The only "design decision" is that we don't change established
behaviours, explicit or implicit. If you want to implement something
that matches this requirement, go ahead and post patches. I'll gladly
review them. If you cannot abide by this rule, then please stop
wasting your time (and mine).

Feel free to relay this to the QEMU folks who, in my experience, very
much value the notion of ABI and the preservation of existing
behaviours.

Now, that's my last email on this thread. Do no bother replying.

	M. (pretty annoyed)

-- 
Without deviation from the norm, progress is not possible.

