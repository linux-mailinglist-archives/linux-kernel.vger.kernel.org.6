Return-Path: <linux-kernel+bounces-421749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1434A9D8F86
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 01:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46600B2246B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 00:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE86E4431;
	Tue, 26 Nov 2024 00:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C2BxWhab"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D900B366
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 00:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732580722; cv=none; b=NZ8heKRaEtMOYJCMSyJlqA8caH5GxkSfFk0aCgSQZHtAWrM+al3Bajr6MP5hB+tuAcEYWsTu07anB/GK3OzfBGpm39nXb+Jann5Ov7hL56pJmcsMLihSrNn40OwNQFn43q+nn+Hcw5AYzMNMZ9Li/cvC8PN0wg4CNuDBXdVm9p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732580722; c=relaxed/simple;
	bh=n+11RRM7aa4Qig8gaoj5CrapDLhCyDb2Ov5YvEdUPrg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pc3aUCjbXU/OOLeKAdzroOQkfeBokPrkGdPJ8oS+URYpgwbce4qm5M5IUTQrJCZ3oFM85aI2vnB+4nkmlc9MIIr/FFZSbueAkT5mZpOV/9HdvMQIivIbqEFPAOu9X+0srfr8xcNeZU9o0u+YZ5AOyUfp3BrOES5qA5ac56Hg/LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C2BxWhab; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-72467cd273dso4895756b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 16:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732580720; x=1733185520; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tN//AiS7h/bI7r5dwoIJd0p2pyQjhXkKgeTuVgcAQiU=;
        b=C2BxWhabBI/h8gO+OTDX5iCWjAllV1B+13Y0TIuy1v4yKS5A/HvdnQRQA9qP9T1ewW
         04QctI9l49b6eSW2xzAub1kPRcROZzcO1KTjkXIohZyahY4umPu2N/8rEBcOZEPmTnQE
         0Yt79ReDxF4agZ1OHS1PjkWRkwJRpESirGreT1/m9zRAK0Z0eJPu7FJMto6eq9ib56WY
         cmGIz+pOfi92I1MKd3nuIThWEHx8ngW+49a7kcnxqYdaRiz6eip93glY+8ArpwxjpwVa
         bQSvS6/c9Yhp7rPVcO8h4IJGsj/vgQnS448cBj4Hs/xMw4UXxL9tNo/Hpbfq4DpSMf85
         2T3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732580720; x=1733185520;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tN//AiS7h/bI7r5dwoIJd0p2pyQjhXkKgeTuVgcAQiU=;
        b=pO7ogzhgzoKukX0wKT96DnO1Psswi734jH9CutagYUzG73hWKJC5fgTAvEyEL1FN8P
         SpOfILBG6pXLo8hHwY95G7gcQEQy2tMQo7SsV7osaRFJBR3gMCrX4fJ1sG8j/xmOOn9s
         0UF/TkA7PrlQgWcNp/KILXSzVcf2AGxEfG84XNgawnBnlh4Qn52SZXEOOAjU3IRR1LWM
         gGmJ3lgV4H+FuLJ6fvOfi8XjKbdB7UqBme2JdJU+64OY0OAWCdokYNK4Jtz1VVI+zHyc
         5Pa+FxFJW2N9xKaxK/xtbNItt9KSZPYiR4mNMgXr9oN0jOcN+tpD+zbvL8D8lazLoc5u
         n4Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUbWrM0mRCLhE+5FGVRxXbMoBQ8V0Npn4N+gUmpYtnrBrIK2pdf3cq2kAU9op2UmIZ26JFGUxQKryZ2YJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlANiR63Y8w39iwVEZTI+tRlHsq2G1zSvPf1xo07aBUdrsmAp0
	TjuKWOYXxGpPGbJeSSqIXq7mF4ZMgoNKOearDp+dfqR+G9eCPyI0/ObgrKE0FycffeU9kYH+krg
	LTg==
X-Google-Smtp-Source: AGHT+IELkS/KOIpSHXkL5x3MCn6HBT67YNDmLF6NPvb/kF/3OThrSOrfEV0+bjyAP4qMRYc4kQ7DL5+h9vE=
X-Received: from pjc7.prod.google.com ([2002:a17:90b:2f47:b0:2e2:9021:cf53])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d04:b0:2ea:a9ac:eeec
 with SMTP id 98e67ed59e1d1-2edebe10c8amr2050990a91.18.1732580720150; Mon, 25
 Nov 2024 16:25:20 -0800 (PST)
Date: Mon, 25 Nov 2024 16:25:18 -0800
In-Reply-To: <8d7e0d0391df4efc7cb28557297eb2ec9904f1e5.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231002115723.175344-1-mlevitsk@redhat.com> <ZRsYNnYEEaY1gMo5@google.com>
 <1d6044e0d71cd95c477e319d7e47819eee61a8fc.camel@redhat.com>
 <Zxb4D_JCC-L7OQDT@google.com> <Zxf2ZK7HS7jL7TQk@google.com> <8d7e0d0391df4efc7cb28557297eb2ec9904f1e5.camel@redhat.com>
Message-ID: <Z0UVbpcYJIbsRxp2@google.com>
Subject: Re: [PATCH v3 0/4] Allow AVIC's IPI virtualization to be optional
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 21, 2024, Maxim Levitsky wrote:
> On Tue, 2024-10-22 at 12:00 -0700, Sean Christopherson wrote:
> > On Mon, Oct 21, 2024, Sean Christopherson wrote:
> > > On Wed, Oct 04, 2023, Maxim Levitsky wrote:
> > > > About the added 'vcpu->loaded' variable, I added it also because it is
> > > > something that is long overdue to be added, I remember that in IPIv code
> > > > there was also a need for this, and probalby more places in KVM can be
> > > > refactored to take advantage of it, instead of various hacks.
> > > 
> > > I don't view using the information from the Physical ID table as a hack.  It very
> > > explicitly uses the ir_list_lock to ensure that the pCPU that's programmed into
> > > the IRTE is the pCPU on which the vCPU is loaded, and provides rather strict
> > > ordering between task migration and device assignment.  It's not a super hot path,
> > > so I don't think lockless programming is justified.
> 
> If you strongly prefer this I won't argue. KVM does read back its SPTE entries,
> which is also something I can't say that I like that much.

Heh, ignoring the conundrum with SPTEs being writable by hardware for A/D assists,
not reading SPTEs would add an almost absurd amount of complexity due to the need
to manage mappings in a separate data structure.  E.g. see TDX's S-EPT implementation
for how messy things get.

> > > I also think we should keep IsRunning=1 when the vCPU is unloaded.  That approach
> > > won't run afoul of your concern with signaling the wrong pCPU, because KVM can
> > > still keep the ID up-to-date, e.g. if the task is migrated when a pCPU is being
> > > offlined.
> > > 
> > > The motiviation for keeping IsRunning=1 is to avoid unnecessary VM-Exits and GA
> > > log IRQs.  E.g. if a vCPU exits to userspace, there's zero reason to force IPI
> > > senders to exit, because KVM can't/won't notify userspace, and the pending virtual
> > > interrupt will be processed on the next VMRUN.
> > 
> > My only hesitation to keeping IsRunning=1 is that there could, in theory, be a
> > noisy neighbor problem.  E.g. if there is meaningful overhead when the CPU responds
> > to the doorbell. 
> 
> I once measured this by bombarding a regular CPU, which is not running any
> guests, with AVIC doorbells. It was like 60% reduction of its performance if
> I remember correctly.

Ah, right, I keep forgetting the Intel's posted interrupts limits the spam to a
single IRQ thanks to the PID.ON behavior, which is why it's ok-ish to keep posted
interrupts active when a vCPU is put.

> So physical id table entries of a VM can't point to a CPU which doesn't run
> the VM's vCPU thread, because only in this case this doesn't pose a DOS risk.
> 
> Same with IOMMU (malicious guest can in theory make an assigned device
> generate an interrupt storm, and then this storm can get redirected to a
> doorbell of a CPU which doesn't belong to a VM).

