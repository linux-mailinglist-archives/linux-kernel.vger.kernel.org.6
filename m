Return-Path: <linux-kernel+bounces-566765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9D9A67C38
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EAD33B4EC5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3BC1DD88D;
	Tue, 18 Mar 2025 18:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2W+5lVm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E059A1EEE6
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 18:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742323607; cv=none; b=EycaYNXhjIsX3ACdKfA8byP3yRlz+zewqBtpL4uDfAPJhbHVrEmpTnBgmErpLrnk/c9kl/tsbcobHUy5Gla/SeboAdHANnCQliSD7vdw2I56D+w2VRXjg+xvlck0PY+C7FHbUIlZdYw7+N+pV8el8L54j/2yM6KNbQHXmUu3Mxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742323607; c=relaxed/simple;
	bh=5nR6IDi72tpye7LQE1M4WoGl2e+WFeX+ZovVdMPt3Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvZ3nhkgO9pI1T+MtKs7xgOSkIKTIb1gznJaVKpmDLLETJKjqKwdoC4slb+gxrfkeEoLlFS1zCuRO6gerdQ6uBHNz6v21GToCF/PcDZ7Sm7kW/xKNvbJcGLLZTg/3KznKTagZLQhFql1UG2OSv84si4yFI0A++OLtDx9oKvqYyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2W+5lVm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9949CC4CEDD;
	Tue, 18 Mar 2025 18:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742323606;
	bh=5nR6IDi72tpye7LQE1M4WoGl2e+WFeX+ZovVdMPt3Hw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G2W+5lVm3Fmv49Fy6nzw4OliUjNB1o+lnmppEgOGWtfLU2tBVhqssdetegopEjudH
	 LWEo2TAF4iFSl9/oBst2bZVeMGy5pntpT3bTnGjGF+ApDug24h5d15ONKnXhrnMkoC
	 m/GQx+qau1XWRfer7heIDbehiyOVx0QgYN7whF4CynBwRQILMPClWBGpl4qF3tne76
	 T2qcbesc+q90mlOJVGjn9vEhiO5LX7VrGI1R12ScaQHoLnB1Nd02Kf47ktV40XjhzC
	 FrL/X4NNlGWl87yTJg1+o2WdlXc9pMv/OOjN1E+/Az6DlOPJ8K5l4ZQBQcwNoqk3Wm
	 7GIQJ1rPfTf1Q==
Date: Tue, 18 Mar 2025 19:46:41 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	"Ahmed S . Darwish" <darwi@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	John Ogness <john.ogness@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/5] x86/cpu: Introduce <asm/cpuid/types.h> and
 <asm/cpuid/api.h> and clean them up
Message-ID: <Z9m_kUqxqMPfU8Fl@gmail.com>
References: <20250317221824.3738853-1-mingo@kernel.org>
 <5A417EE0-8DF3-4C6E-A7E9-9EE6705282F1@zytor.com>
 <Z9m1rtmlk1PxGIQA@gmail.com>
 <CAHk-=whAUHyXM29_9w_T26=15D1KZnuR3R+f4MT9f-C89oukvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whAUHyXM29_9w_T26=15D1KZnuR3R+f4MT9f-C89oukvA@mail.gmail.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, 18 Mar 2025 at 11:04, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > plus we could implement the main CPUID call as:
> >
> >  static inline void native_cpuid(struct cpuid_regs *cregs)
> >  {
> >         /* ecx is often an input as well as an output. */
> >         asm volatile("cpuid"
> 
> So this really needs "asm inline" now. Because if it's not inlined, it
> generates horrific code.
> 
> Anyway, I agree with whoever (hpa?) said we should probably just
> unconditionally make all "asm" be "__asm__ __inline__" .

Yeah, it was hpa, and I was thinking about that approach today, and was 
about to write a "don't want to do such a big binary change without 
Linus's buy-in" reply ...

... and problem solved. ;-)

> And then *if* there are any places that want to out-line the asm (why 
> would you do that? At that point you'd be better off just writing 
> assembler!), they could use an explicit __asm__ instead with a 
> comment.
> 
> Sadly, I think doing just a mindless
> 
>     #define asm(...) __asm__ __inline__(__VA_ARGS__)
> 
> doesn't work, because we also have
> 
>         register void *tos asm("r11");
> 
> kind of patterns.
> 
> So first we'd have to change those to use __asm__(), and *then* we
> could do the "asm() is always __asm__ __inline__()" thing.

Yeah, I'll try this out. Should this be done for all architectures, or 
just for x86 for the time being?

I'm not sure an arch opt-in is worth it, it will only end up in the 
active architectures picking it, but none of the others, and we'll live 
with the duality forever.

Thanks,

	Ingo

