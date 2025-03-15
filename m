Return-Path: <linux-kernel+bounces-562480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D730AA62951
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 09:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEDDC3B6BA5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 08:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBF81E04AC;
	Sat, 15 Mar 2025 08:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVdxdjvs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59114192B8F
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 08:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742028752; cv=none; b=EeDIt4nX3ZCx3XHaMcgDpHAgmoqpEJRxa7QFiChI46807EqUV+XbVHdz1spy25gGxnMIo6Bty9Sfezb+LuAodbIoYzZ+zNXaS+8ogmuVwO0WVhSQ/Cxf3S9EO+Vd67qCqjGBbhhXNRqfpCxheTCOjZnJBY/3jpFmML+OoDoJ7fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742028752; c=relaxed/simple;
	bh=v2aCjcS7m8Yxfge/9AjWsbQWtu//kBpYjcxARrJgsHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRRW5lnuPGe3SU710JnW43N2G+Hlgn+4nHYlwkzv9wP0uzuk18VjhTFoo7boZQkzosgfinTyY90lmzKWWOUTiH2pPuVkSdliXP1iZxSx+VkpWJnSNVdBfSCPXupUmN/1MJrCLmqUOqNXLr4iO/oTLlnTPAtz83xdUaWTCcbJ4gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVdxdjvs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971CEC4CEE5;
	Sat, 15 Mar 2025 08:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742028751;
	bh=v2aCjcS7m8Yxfge/9AjWsbQWtu//kBpYjcxARrJgsHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YVdxdjvsTpOWursYHEkbMPCg/cBgXw1jlyx1j6yr0pbSa1PPZaoDorCteB/SyviBT
	 NKbS8ZaiZ7DtGEwU1v4H3G5BvTTQRWd7+oorjQ8trMU+WE9X5Q+oeTx7zH/YBUQr6w
	 WwI1UAYZ4Qvy86aiB5BBS7VoW4WPK6wINKi3dR++nQXKS39W91BlzXgXA/JFdMb4gM
	 FJzrQgb78kmrT2v13HRbOSwo97zPzmmsk0BVJHASjTQg74kgZ9Gmb9yY+PIk5p9Qzi
	 kUk+gkVPAcNXpgznT8QLDXmnkGjZCjUO553f+qodcRyYARADqQH5clp2PdZVRTA8wN
	 RO5+mHpItaocA==
Date: Sat, 15 Mar 2025 09:52:26 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH 14/20] x86/barrier: Use alternative_io() in 32-bit
 barrier functions
Message-ID: <Z9U_yvs8Cl0IEAQd@gmail.com>
References: <cover.1741988314.git.jpoimboe@kernel.org>
 <1c2fe7f93c4dd8a87c2e1fa8b780a8a2968be445.1741988314.git.jpoimboe@kernel.org>
 <CAHk-=wjtvTPERDdrok2kDrSSFBjqHCCNVff95VVxhvP6wCC6jg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjtvTPERDdrok2kDrSSFBjqHCCNVff95VVxhvP6wCC6jg@mail.gmail.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 14 Mar 2025 at 11:42, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > +#define mb() alternative_io("lock addl $0,-4(%%esp)",                  \
> > +                           "mfence", X86_FEATURE_XMM2,                 \
> > +                           ARG(),                                      \
> > +                           ARG(),                                      \
> > +                           ARG("memory", "cc"))
> 
> So all of these patches look like good cleanups to me, but I do wonder
> if we should
> 
>  (a) not use some naming *quite* as generic as 'ARG()'
> 
>  (b) make the asms use ARG_OUT/ARG_IN/ARG_CLOBBER() to clarify
> 
> because that ARG(), ARG(), ARGC() pattern looks odd to me.
> 
> Maybe it's just me.

Not just you, and I think the ARG_ prefix still looks a bit too 
generic-C to me, it should be something more specific and unambiguously 
asm() related, like:

	ASM_ARGS_IN(),
	ASM_ARGS_OUT(),
	ASM_ARGS_CLOBBER(),

or maybe even:

	ASM_CONSTRAINT_IN(),
	ASM_CONSTRAINT_OUT(),
	ASM_CONSTRAINT_CLOBBER(),

Because these asm()-ish syntactic constructs look better in separate 
lines anyway, and it's not like we are at risk of running out of 
letters in the kernel anytime soon.

Thanks,

	Ingo

