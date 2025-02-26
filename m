Return-Path: <linux-kernel+bounces-532887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D460A4536C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A311882AC0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC35218C03D;
	Wed, 26 Feb 2025 02:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t/XbdwNs"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B02219B3EC
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 02:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740538200; cv=none; b=Rhc6qmHDvc2m3nH1KqrrV7baCAQsYDbbhhxq133EcJ1VqhtKdx10Otxpdw/aPsh/k5Vp8hSlP0pBIsrCnzGW/ROa3ezVtxctNDTjlM+dkFDXfuIhiavnlKg6J9WKjv4yL144f29GmMKm8SOeCmLvxdeoGKZvffAoNLTilzV03O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740538200; c=relaxed/simple;
	bh=A+buSwEHGfuGx+FpQK7+F4UvVj6wPw68M3QFPRMcYmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Prf+EnvETTV/G1Wvq45Q2eZlZ+2qLEAbSlgs8mHCuPpccs4A1J/BFuTJkQrIhid/lbpgCvz+vDS4v7TJt8F0kvRe9XQf4TIbxvv4cM+NtgM7bmF/avtfyL/v6WIImgc8IA+VabK3+LYR+oZ4BH2kYeK28ngMb9Y9a/EZTso7YQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t/XbdwNs; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 26 Feb 2025 02:49:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740538196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KIU++UQD9AndQyw/guhCvt1enFdEPqXDMUluqxIkAt8=;
	b=t/XbdwNshzRjGOE9VTmLMnUVFLr3OjN6paCMnAMbXCdUpq8rPjEkDrstn9VvebEctEqOxw
	OJAAyDyy9HlogVodxypRTMy+upbsxvOx/aKshwSwmSs7CFpnwVotqp5n+rO8PLBfxlEgsH
	hdsPw/po58euj1JxhPoXIBBBAmozZTU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] x86/bugs: Use a static branch to guard IBPB on vCPU
 load
Message-ID: <Z76BTqmAJPV7lBbA@google.com>
References: <20250219220826.2453186-1-yosry.ahmed@linux.dev>
 <20250219220826.2453186-5-yosry.ahmed@linux.dev>
 <Z74exImxJpQI9iyA@google.com>
 <59ea1984b2893be8a3a72855b022d16c67b857e9@linux.dev>
 <Z75G2L6N1vR3DslT@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z75G2L6N1vR3DslT@google.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 25, 2025 at 02:40:24PM -0800, Sean Christopherson wrote:
> On Tue, Feb 25, 2025, Yosry Ahmed wrote:
> > February 25, 2025 at 11:49 AM, "Sean Christopherson" <seanjc@google.com> wrote:
> > >
> > > On Wed, Feb 19, 2025, Yosry Ahmed wrote:
> > > > 
> > > > Instead of using X86_FEATURE_USE_IBPB to guard the IBPB execution in the
> > > >  vCPU load path, introduce a static branch, similar to switch_mm_*_ibpb. 
> > > > 
> > > >  This makes it obvious in spectre_v2_user_select_mitigation() what
> > > >  exactly is being toggled, instead of the unclear X86_FEATURE_USE_IBPB
> > > >  (which will be shortly removed). It also provides more fine-grained
> > > >  control, making it simpler to change/add paths that control the IBPB in
> > > >  the vCPU load path without affecting other IBPBs.
> > > > 
> > > >  Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> > > > 
> > > >  ---
> > > > 
> > > >  arch/x86/include/asm/nospec-branch.h | 2 ++
> > > >  arch/x86/kernel/cpu/bugs.c | 5 +++++
> > > >  arch/x86/kvm/svm/svm.c | 2 +-
> > > >  arch/x86/kvm/vmx/vmx.c | 2 +-
> > > >  4 files changed, 9 insertions(+), 2 deletions(-)
> > > > 
> > > >  diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> > > >  index 7cbb76a2434b9..a22836c5fb338 100644
> > > >  --- a/arch/x86/include/asm/nospec-branch.h
> > > >  +++ b/arch/x86/include/asm/nospec-branch.h
> > > >  @@ -552,6 +552,8 @@ DECLARE_STATIC_KEY_FALSE(switch_to_cond_stibp);
> > > >  DECLARE_STATIC_KEY_FALSE(switch_mm_cond_ibpb);
> > > > 
> > DECLARE_STATIC_KEY_FALSE(switch_mm_always_ibpb);
> > > >  
> > +DECLARE_STATIC_KEY_FALSE(vcpu_load_ibpb);
> > > > 
> > > 
> > > How about ibpb_on_vcpu_load? To make it easy for readers to understand exactly
> > > what the knob controls.
> > 
> > I was trying to remain consistent with the existing static branches' names,
> > but I am fine with ibpb_on_vcpu_load if others don't object.
> 
> I assumed as much :-)  I'm ok with vcpu_load_ibpb if that's what others prefer.

To be honest looking at this again I think I prefer consistency, so if
you don't mind and others don't chime in I'd rather keep it as-is.

Alternatively I can rename all the static branches (e.g.
ibpb_always_on_switch_mm) :P

