Return-Path: <linux-kernel+bounces-562506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C32DA62A02
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 10:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62BEC19C01B4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 09:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AC21F4630;
	Sat, 15 Mar 2025 09:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7V1M2N/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659821F5EA
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 09:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742030721; cv=none; b=XcEs0L11E6sohSGiDyC7x38XsyIceJg3s62UBLoTDGFQPv7bZ5YnFTNbxFcHK45QEOex1KGehcUtBkQ2b+vuMD4F9IEJWU64W79M8WB4NqyXXCTDOrKapoOvqjHwtLGrGH3x9zaqL5l3HY4qwiceLykWrM8Zw+2zbTRHyyosseQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742030721; c=relaxed/simple;
	bh=vTyME1WUm+wNeyigKlXitlNH1r9TNajHpIPbEO7S818=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0Ih5sYe+earnlV2ADfSNkS2evkxAegI7Nzy7LXj1tG986hK1VbJ4ItX0Cf9dptXWGUFh8GJ27n9L32EorbnseDEnxAT5ZC3+QmIjWZ45cwojny8yAkEev/bo7uFz5sZmQ0XK+cHKz3+kJ1riqVnsH8JQbw7Dli0mp3IzcQl72g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7V1M2N/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39B8C4CEE5;
	Sat, 15 Mar 2025 09:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742030720;
	bh=vTyME1WUm+wNeyigKlXitlNH1r9TNajHpIPbEO7S818=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o7V1M2N/HC5Xde4lfNSbfQUZuhgkjguL7sO1PXXfTdUDAUavJ6ylLhocEHQxh8QEV
	 /CBgxHFQceGiRL139g3GlGWJ5Dn/osxwwyU5ITFJVghjfY88tD0M5dy8Pc5AcD1V0k
	 dHWdPfDSK604LB9CjkxYC4/mXIC+QlsI8xNVx571vpOzraisD3ND22Co1vZIZ00jn8
	 l4f/3dHCCyySWnANWg0jbdOoiXbQAXNd0MjEdlY3dSsyyLUWeT6TZN2C/Ch6vPzF4d
	 hMvYglAHXFKwruILti1SUNFDQReWn9coVSQGF+kFOjnJ24o7/beKSBhSTIKIsUDcHy
	 pmXnIQRQeOe+g==
Date: Sat, 15 Mar 2025 10:25:15 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH 04/20] x86/cpu: Use named asm operands in clflushopt()
Message-ID: <Z9VHe7RSeFAyZfLR@gmail.com>
References: <cover.1741988314.git.jpoimboe@kernel.org>
 <c007f4ddbfdfe92777a7df35bc121cf9bf0d0682.1741988314.git.jpoimboe@kernel.org>
 <CAHk-=wjBjq6u+r9KGTHQ5nOA1L2TDhz0JPL_+eE07un9y9Qm-w@mail.gmail.com>
 <gor6hi6lzohdo6hfcffmxdzc4fiqdn2itncxatw4zkhouzmm6l@obz43xcfcl2i>
 <Z9U9fAUr3O-pr9QT@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9U9fAUr3O-pr9QT@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> 
> > On Fri, Mar 14, 2025 at 01:46:00PM -1000, Linus Torvalds wrote:
> > > On Fri, 14 Mar 2025 at 11:42, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > > >
> > > > +       alternative_io(".byte 0x3e; clflush %[val]",
> > > > +                      ".byte 0x66; clflush %[val]", X86_FEATURE_CLFLUSHOPT,
> > > > +                      [val] "+m" (*(volatile char __force *)__p));
> > > 
> > > Hmm. I think we could just use 'clflushopt', it looks like it exists
> > > in binutils-2.25, which is our minimal version requirement.
> > > 
> > > But maybe that's a separate cleanup.
> > 
> > You appear to be correct, I'll add a patch for that.
> 
> Please base your series on tip:master or tip:x86/asm, we already 
> cleaned this up recently:
> 
>    cc2e9e09d1a3 ("x86/asm: Use CLFLUSHOPT and CLWB mnemonics in <asm/special_insns.h>")

Also, as a general principle I'd prefer to have .byte conversion to 
mnemonics and named-operands conversions to be separate patches - not 
all named-operands conversions are an improvement, especially very 
short and simple asm() templates are just fine using numeric operands.

Thanks,

	Ingo

