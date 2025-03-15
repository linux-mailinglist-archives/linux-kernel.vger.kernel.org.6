Return-Path: <linux-kernel+bounces-562474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F7DA6292F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 09:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA1013B1B0F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 08:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E8B1EA7C5;
	Sat, 15 Mar 2025 08:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3GjbRMF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304AD178CF8
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 08:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742028163; cv=none; b=IA+wI1Jg/uBEtv5eagDPvErV6KWEo8fPEOfM92pR5vHmFz8sj/F3ngc3EE1jXFxaV44LjHlL/WPPRVjr/0cngdmsDuN8mlMZyiDjwCUuJ2vP0tRUsKt83yX8bznRh0U/kT+A1BCm6Dl8vENsfnmmmjZTC/9EM+8bzW7NGdJjIH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742028163; c=relaxed/simple;
	bh=hhrXCzurGah/jPHhVsTGdVJGG6pYNJnQK3jHmKSM8l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9GPAsan33ok+6QQsX2ji9SSn+jfRJgc6QpfIfnYVbqNt3oDnti3rdDzmwGSPVa4wVye9sD2okC64JFQCOVwbyAvLLogrA+ypHsnVN3m4PQetEUusiQK9TFPIsUDSnMCn7FkN6sgKeg3m7c8j6ugHTAJidrbFJ4jPXB5kamOBB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3GjbRMF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E3BC4CEE5;
	Sat, 15 Mar 2025 08:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742028161;
	bh=hhrXCzurGah/jPHhVsTGdVJGG6pYNJnQK3jHmKSM8l0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u3GjbRMF71hYXxj2HtXnXx17CdPFtplkoDfPL68fEgoGiDkRrjTWhzF4RLk3m2FSE
	 sGpqAZdmwU6GPXXgJMSFosHARLX+J6ankon2wNz5rR3XVKTC8aC4jTsHT31elwJ0mb
	 N5xpPxfoHld6WW4pDpGGqah7Qn6Bd8P24h+4Pgm7zeVYFVxf7GrnaI4nGpUsi3CX21
	 uiyIjPkzC8w83DLiKg4wgCg0Xk2ZiLY6VmJ8rkXA4faTdfvV7kvdapYKqB6FjMrwVb
	 LczZ+HNIz+0rFLIZIlIxPIqatbZoXFn0x0R8GepM17S3bsGH2/FdBTjJko7tUKpd6K
	 eNu2W5yFxGe0g==
Date: Sat, 15 Mar 2025 09:42:36 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH 04/20] x86/cpu: Use named asm operands in clflushopt()
Message-ID: <Z9U9fAUr3O-pr9QT@gmail.com>
References: <cover.1741988314.git.jpoimboe@kernel.org>
 <c007f4ddbfdfe92777a7df35bc121cf9bf0d0682.1741988314.git.jpoimboe@kernel.org>
 <CAHk-=wjBjq6u+r9KGTHQ5nOA1L2TDhz0JPL_+eE07un9y9Qm-w@mail.gmail.com>
 <gor6hi6lzohdo6hfcffmxdzc4fiqdn2itncxatw4zkhouzmm6l@obz43xcfcl2i>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gor6hi6lzohdo6hfcffmxdzc4fiqdn2itncxatw4zkhouzmm6l@obz43xcfcl2i>


* Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> On Fri, Mar 14, 2025 at 01:46:00PM -1000, Linus Torvalds wrote:
> > On Fri, 14 Mar 2025 at 11:42, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > >
> > > +       alternative_io(".byte 0x3e; clflush %[val]",
> > > +                      ".byte 0x66; clflush %[val]", X86_FEATURE_CLFLUSHOPT,
> > > +                      [val] "+m" (*(volatile char __force *)__p));
> > 
> > Hmm. I think we could just use 'clflushopt', it looks like it exists
> > in binutils-2.25, which is our minimal version requirement.
> > 
> > But maybe that's a separate cleanup.
> 
> You appear to be correct, I'll add a patch for that.

Please base your series on tip:master or tip:x86/asm, we already 
cleaned this up recently:

   cc2e9e09d1a3 ("x86/asm: Use CLFLUSHOPT and CLWB mnemonics in <asm/special_insns.h>")

Thanks,

	Ingo

