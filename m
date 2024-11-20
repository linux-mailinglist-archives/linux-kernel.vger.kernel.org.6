Return-Path: <linux-kernel+bounces-415336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B9A9D34B2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B9511F213C5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 07:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB6B188721;
	Wed, 20 Nov 2024 07:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fDFDC9C2"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B9D172BA9
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 07:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732088792; cv=none; b=uuLgmwWWbENxA5sQAZ2FQlyTa1O7dD6emMeHSwQKi1Lkk7a6rPzdvt5LNbSc3arug5rTfu5A7Bs2XJxwfkUFBo0snEl//V8YGd4V2hoWsm41ZHeSUMXkdDSi7jNJGGwIvXLwiIs134eW7r7Cr8W6RsfVDq9y1ckBOuQIVWKwgLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732088792; c=relaxed/simple;
	bh=7ffXjx0Ik+eVEI0uzKyRX3vMNdwO8ECAiPgVZgcLjRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjBVVYcwOoqLxOlSoSm0MZhe5UIPcjQK9D4r/lbNgYxbUEK6Y2tiXp5BjWCaYTA+ijQkjKfPwKE3aVmN4pcUaqAKYSWNYty9SnxQY2Rtln7OSBPp6DJavLPbMz4m9e04imiG/iT1yj9EfJTVsmG7b0n3kH4ggPYZcWls8OJF/zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fDFDC9C2; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 20 Nov 2024 07:46:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732088785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KIsoxDDC/xIkUZ9OKR1VL27Mws23rhY0ZxT1YiRdli0=;
	b=fDFDC9C2DqymuzFllq+n19yMNcf+28i/sHmTgmy6MJfcbpAZ3gwJXnhX0eOxufNpPEs3nA
	HtdLctFaUhG4K6TSJD15JPDmM6YxJQKMlDDhJRWLgUL/YBFyScQV4/AFQE+VnyJrHd/U8f
	9iXtXmt2ISTJR7eLTzDqZ3FSrOlfCDs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Jiaqi Yan <jiaqiyan@google.com>
Cc: Marc Zyngier <maz@kernel.org>, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, pbonzini@redhat.com,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	kvm@vger.kernel.org, duenwen@google.com, rananta@google.com,
	James Houghton <jthoughton@google.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1] KVM: arm64: Introduce KVM_CAP_ARM_SIGBUS_ON_SEA
Message-ID: <Zz2TyC9-zNQ3D-KB@linux.dev>
References: <20241031212104.1429609-1-jiaqiyan@google.com>
 <86r07v1g2z.wl-maz@kernel.org>
 <CACw3F51FbzkkX_DcCVCieZ=408oP_Fy3sXYk5AjWRX3RJO2Fzg@mail.gmail.com>
 <878qtou96b.wl-maz@kernel.org>
 <CACw3F50gB40dqQ4CZ7f4X4aRkxHQhjiYunAhqbmVtcGnd5g3bA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACw3F50gB40dqQ4CZ7f4X4aRkxHQhjiYunAhqbmVtcGnd5g3bA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Nov 19, 2024 at 03:57:46PM -0800, Jiaqi Yan wrote:
>
> While continuing the discussion here, I think it may make sense I sent
> out a V2 with 2 major updates:
>   - add documentation for new SIGBUS feature
>   - remove KVM_CAP_ARM_SIGBUS_ON_SEA

Just wanted to add that QEMU already has a functioning "MCE" injection
implemenation based on signals that deals with the sloppy mess of
coordinating w/ vCPU threads [*].

I completely agree with Marc that the UAPI around using signals for this
sort of thing is a giant pile of crap, but it seems to be a semi-understood
pile of crap. And from that perspective, wiring unclaimed SEAs into the
existing infrastructure at least makes the UAPI consistent.

[*]: https://elixir.bootlin.com/qemu/v9.1.1/C/ident/kvm_on_sigbus_vcpu

> On Tue, Nov 12, 2024 at 12:51 AM Marc Zyngier <maz@kernel.org> wrote:
> > > Do you mean a CAP that VMM can tell KVM the VM guest has RAS ability?
> > > I don't know if there is one for arm64. On x86 there is
> > > KVM_X86_SETUP_MCE. KVM_CAP_ARM_INJECT_EXT_DABT maybe a revelant one
> > > but I don't think it is exactly the one for "RAS ability".
> >
> > Having though about this a bit more, I now think this is independent
> > of the guest supporting RAS. This really is about the VMM asking to be
> > made aware of RAS errors affecting the guest, and it is the signalling
> > back to the guest that needs to be gated by ID_AA64PFR0_EL1.RAS.
> 
> Just to make sure I fully catch you. I think ID_AA64PFR0_EL1.RAS
> translates to ARM64_HAS_RAS_EXTN in the kernel. If VMM signals RAS
> error back to the guest with SEA, are you suggesting
> __kvm_arm_vcpu_set_events should check
> cpus_have_final_cap(ARM64_HAS_RAS_EXTN) before it
> kvm_inject_dabt(vcpu)?
> 
> If so, how could __kvm_arm_vcpu_set_events know if the error is about
> RAS (e.g. memory error) vs about accessing memory not in a memslot
> (i.e. KVM_EXIT_ARM_NISV)? I guess KVM needs to look at ESR_EL2 again
> (e.g. kvm_vcpu_abt_issea vs kvm_vcpu_dabt_isvalid)?

Good point. I don't think we can lock down this UAPI after the fact
given the existing use cases. It is ultimately up to the VMM what to do.

I don't see anything that would stop an implementation without FEAT_RAS
from generating an SEA in this situation. The lack of FEAT_RAS (to me at
least) implies:

 - No ESR injection for vSErrors (already enforced in UAPI)
 - No deferral of SErrors / ESBs
 - No error record registers in the PE

Of course, it is very likely you've thought about this more than I have,
Marc.

-- 
Thanks,
Oliver

