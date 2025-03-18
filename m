Return-Path: <linux-kernel+bounces-566734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7676EA67BD4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 641607A4821
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138BF213236;
	Tue, 18 Mar 2025 18:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Un1C3XNB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7252E211A26
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 18:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742322044; cv=none; b=QgTxoaYmMG7gcaNaltLR63T5LMCrLLARazMHrkjAJo/RzN7TKOhasZ8L9NrBT0WeXjtKYx6hElHk5s7SjyA1H/Lk30JSNszyi62QyU6ydG8BfJqSeJZ3+4N7kMiztbbd8ZD3f4s66y4BoasKwQdg25tbOxTkyZz+r/bCkOCPlyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742322044; c=relaxed/simple;
	bh=D4ROG5ncFDjfENJ+SXuTnZme3q1QZimDk3kNy9GmZro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dh0ko6ew3PJG2HwrA+9h3Qg4JCCkdFiIvl6mKmAr9c9M+tfYOn37Ivtk23qe234gB/NkoNdbzAIEEox+Ke8VcwX0U1wjbep+JZ4f61gsWccJTnbNylYVS7ORnoclLlZy5VWH0+jl6s70HFMtn9AshAduBdwBqYyNj4wSgr3Hs1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Un1C3XNB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02605C4CEDD;
	Tue, 18 Mar 2025 18:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742322043;
	bh=D4ROG5ncFDjfENJ+SXuTnZme3q1QZimDk3kNy9GmZro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Un1C3XNBEq5lxejNLuYJyab7vL/YyNj1oCJaC79qqPDxquB2IYFOH6tQerjsSejMd
	 h/apdcGhNb/EcuF+lkzZtZgE+ePIiiSpM8tEU48sTP+F9NsI/3CzXPWdhdkHOZw7bo
	 tPlNzYxO8FBUZ/69iJABi0CrEbI/pGcTGvKjQmuN2SXxdgMVTjR8VpVQI/RoyD+pIh
	 ofhsxfHptiOLlgI4GNy8cVekwCypUNFkzts1igjhHHHc1v/Q+JPO0WLERiNHhSwrEF
	 v23ji+d+aUhVdg9QdyR7uIM6JNJVJGxdFhC7rN0ohh741J5cbV9GTZs1of93Czxopp
	 mmBgnHLyriuHw==
Date: Tue, 18 Mar 2025 19:20:38 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Xin Li <xin@zytor.com>, linux-kernel@vger.kernel.org,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	"Ahmed S . Darwish" <darwi@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 5/5] x86/cpuid: Use u32 in instead of uint32_t in
 <asm/cpuid/api.h>
Message-ID: <Z9m5doW6IBVth-Kz@gmail.com>
References: <20250317221824.3738853-1-mingo@kernel.org>
 <20250317221824.3738853-6-mingo@kernel.org>
 <b7920c2c-1051-4674-994c-d1b681cf7988@zytor.com>
 <Z9kwIYrOwO8nOpAE@gmail.com>
 <20250318093736.GBZ9k-4Fu_CqwhgYt1@fat_crate.local>
 <Z9leoRHkbu8Kgoed@gmail.com>
 <20250318121557.GCZ9lj_UyOqr9Mkaag@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318121557.GCZ9lj_UyOqr9Mkaag@fat_crate.local>


* Borislav Petkov <bp@alien8.de> wrote:

> On Tue, Mar 18, 2025 at 12:53:05PM +0100, Ingo Molnar wrote:
> > How is one more word and saying the same thing in a more circumspect 
> > fashion a liguistic improvement?
> 
> Because it removes the "we" out of the equation. I don't have to 
> wonder who's the "we" the author is talking about: his employer, his 
> private interests in Linux or "we" is actually "us" - the community 
> as a whole.

In practice this is almost never ambiguous - and when it is, it can be 
fixed up.

> I can't give a more honking example about the ambiguity here.

It's a red herring fallacy really. Let's go over the first example 
given in Documentation/process/maintainer-tip.rst:

    x86/intel_rdt/mbm: Fix MBM overflow handler during hot cpu

    When a CPU is dying, we cancel the worker and schedule a new worker on a
    different CPU on the same domain. But if the timer is already about to
    expire (say 0.99s) then we essentially double the interval.

You'd have to be a bumbling idiot to think that the 'we' means an 
employer or the person themselves ...

Put differently: *the very first example given* uses 'we' functionally 
unambiguously so that everyone who can read kernel changelogs will 
understand what it says. Ie. the whole policy is based on a false 
statement...

Very few of the 'we' general pronouns used in kernel changelogs are 
actually ambiguous. This means that any crusade to eliminate 'we' from 
changelogs is not just pointless, but also a waste of resources - it's 
a net negative. At least IMHO. ;-)

> >   The second sentence, "When a CPU is dying, we cancel the worker 
> >   and schedule a new worker on a different CPU on the same domain," 
> >   is easier to understand. It uses simpler language and a more 
> >   direct structure, making it clearer for the reader.
> 
> I disagree with the LLM - it is yet another proof that AI won't 
> replace humans - if anything it'll make them *think* more. Which is 
> good! :-)

Yeah, and in any case, tastes differ, so no strong feelings from me 
either! :-)

Thanks,

	Ingo

