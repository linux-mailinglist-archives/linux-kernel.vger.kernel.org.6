Return-Path: <linux-kernel+bounces-524650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FBDA3E571
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3102119C5710
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB17821480E;
	Thu, 20 Feb 2025 20:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FsjAwAeq"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434EC1E9B02
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 20:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740081615; cv=none; b=BwyoqKxShvLREGd8PEL+ev1FuxudPf2kQRvICe5d6fBT1eHc0Qn08iLx/I9djJG+5Df5jlJx61rmElwcJo210wA3bcWcodRDtSgZ+WRCqgzI4lXWCB/Q9OC/EZgZsayuCnvAuPqcwTUkdeJiFAOO12qDckizF86PNaJ51qp6js8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740081615; c=relaxed/simple;
	bh=X1dOvUBSb0amtyG00ac5tkbkLcroNDvwYGdeglQKxoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNn1/VpDQSyL9pjfz7fSm+VLzb3y72uhI3Mvuvu3LTYxofDeQ8q+Hq4tImQMCFl11A5oZiKwk+O4cfhGQPipYWSZw81QqXn+gAqexGpBdMvNwCI0jOz/0lIxvoHKn2lBNONawPQehQynE45oPxtVFY1V3LJuUgVzZ2nWN/VeGkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FsjAwAeq; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 20 Feb 2025 19:59:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740081601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EJD8+e7EsZbN5YvJtfEPLBE/ojA0ViggvDiLD6CrdRg=;
	b=FsjAwAeqBXGJ7xkCI3IgyzgIMYF7jDJ02tAFb77ff+7KUizr4fl1G/BxqVkhSPA0kYO01x
	i9u3pOZrHfTBl++rH6qkLFIWAYR6su+vPxgVfYtifmyLGU3XAg+4TXsuddLDdXn2883S6N
	aRc745LimdeiUcpqlUos1WLsCwZ74Xc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] IBPB cleanups and a fixup
Message-ID: <Z7eJurYbxS2kAzvk@google.com>
References: <20250219220826.2453186-1-yosry.ahmed@linux.dev>
 <20250220190444.7ytrua37fszvuouy@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220190444.7ytrua37fszvuouy@jpoimboe>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 20, 2025 at 11:04:44AM -0800, Josh Poimboeuf wrote:
> On Wed, Feb 19, 2025 at 10:08:20PM +0000, Yosry Ahmed wrote:
> > This series removes X86_FEATURE_USE_IBPB, and fixes a KVM nVMX bug in
> > the process. The motivation is mostly the confusing name of
> > X86_FEATURE_USE_IBPB, which sounds like it controls IBPBs in general,
> > but it only controls IBPBs for spectre_v2_mitigation. A side effect of
> > this confusion is the nVMX bug, where virtualizing IBRS correctly
> > depends on the spectre_v2_user mitigation.
> > 
> > The feature bit is mostly redundant, except in controlling the IBPB in
> > the vCPU load path. For that, a separate static branch is introduced,
> > similar to switch_mm_*_ibpb.
> 
> Thanks for doing this.  A few months ago I was working on patches to fix
> the same thing but I got preempted multiple times over.
> 
> > I wanted to do more, but decided to stay conservative. I was mainly
> > hoping to merge indirect_branch_prediction_barrier() with entry_ibpb()
> > to have a single IBPB primitive that always stuffs the RSB if the IBPB
> > doesn't, but this would add some overhead in paths that currently use
> > indirect_branch_prediction_barrier(), and I was not sure if that's
> > acceptable.
> 
> We always rely on IBPB clearing RSB, so yes, I'd say that's definitely
> needed.  In fact I had a patch to do exactly that, with it ending up
> like this:

I was mainly concerned about the overhead this adds, but if it's a
requirement then yes we should do it.

> 
> static inline void indirect_branch_prediction_barrier(void)
> {
> 	asm volatile(ALTERNATIVE("", "call write_ibpb", X86_FEATURE_IBPB)
> 		     : ASM_CALL_CONSTRAINT
> 		     : : "rax", "rcx", "rdx", "memory");
> }
> 
> I also renamed "entry_ibpb" -> "write_ibpb" since it's no longer just
> for entry code.

Do you want me to add this in this series or do you want to do it on top
of it? If you have a patch lying around I can also include it as-is.

