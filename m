Return-Path: <linux-kernel+bounces-342465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD77988F5C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 15:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8885E1F21903
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 13:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4E938DDB;
	Sat, 28 Sep 2024 13:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I4HuwARZ"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2384CF9CB
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 13:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727529375; cv=none; b=nIKEoBDqETN1t4YlnMFE2jkR8AAHN+e/OzBDuwuK/N89I/41V+XNLFCUixyyTYSVSd7o0o+1+sSf/DYMgNSs7H/v6f4WOOLK6CpGyw8j9WLWLkF2uYMOrzvaOP1uhEW05edvyqYsHbgXu8j1EWXTbHmZHShrcXBef2gDIwdQoMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727529375; c=relaxed/simple;
	bh=PlS1FkVCP0oTd5VGmUzLYAWOvAbiKvZT9pEUET4Wyjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbmmTSiCkWMYVCjOFbJMdUiEmQ0XdvrjOU5gp2nMQddzWG2CFp2yHCE7l5x9pfjZCPa8IVwPNXdvmKTz1A8hR/OOgcMfhswwzSR3Xdn68Ka3ulqRasDawIzGwaWJlKqOCOrPT6lmToVw7fjntT5gT0Pnjo7VtiU96XOmPmrbv7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=I4HuwARZ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZCQwUkoAEM4g+Tinl96KRZS7Tgj4kpM1Jom8jyVmJdA=; b=I4HuwARZEVPoqsThZhvCZAqW+E
	WlnZHbuIRKE7DQFEw7Rj9V0OlQtipjotyiMm2fa5jEJuLVNqXxD3m6jx6TlkYpBVvJKZi2gikdFgB
	tnGhTgIml2OSos/M9qQ6AlxxyeWXD1M4ttumcquQJbqrDkF0laXYVjssbU1wSMzSjHAJU4gMLGHeS
	it06KHU6S4V6nZCO1IbN/h0RKMkXOH9NI/GqUHDbfpJACen3LXgE6SaVOhI6jGN43fe/hiTjdDud3
	wME6Q77bb6HiB11lV/Ci0kgWzYNVWyyISAkplK1fFX+r2ixLEDafxpmmtPXcDs0OFmufhpo8M+Lm0
	MKbwjRMw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1suXIp-00000002VsU-3u9a;
	Sat, 28 Sep 2024 13:16:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 71B52300848; Sat, 28 Sep 2024 15:16:02 +0200 (CEST)
Date: Sat, 28 Sep 2024 15:16:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jose.marchesi@oracle.com,
	hjl.tools@gmail.com, ndesaulniers@google.com,
	samitolvanen@google.com, nathan@kernel.org, ojeda@kernel.org,
	kees@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH 14/14] x86/fineibt: Add FineIBT+BHI mitigation
Message-ID: <20240928131602.GC19439@noisy.programming.kicks-ass.net>
References: <20240927194856.096003183@infradead.org>
 <20240927194925.808912874@infradead.org>
 <20240928015006.agymb4decrujal37@treble>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240928015006.agymb4decrujal37@treble>

On Fri, Sep 27, 2024 at 06:50:06PM -0700, Josh Poimboeuf wrote:
> On Fri, Sep 27, 2024 at 09:49:10PM +0200, Peter Zijlstra wrote:
> > @@ -1190,6 +1214,8 @@ static __init int cfi_parse_cmdline(char
> >  			cfi_mode = CFI_KCFI;
> >  		} else if (!strcmp(str, "fineibt")) {
> >  			cfi_mode = CFI_FINEIBT;
> > +		} else if (IS_ENABLED(CONFIG_X86_KERNEL_IBT_PLUS) && !strcmp(str, "fineibt+bhi")) {
> > +			cfi_mode = CFI_FINEIBT_BHI;
> >  		} else if (!strcmp(str, "norand")) {
> >  			cfi_rand = false;
> >  		} else {
> 
> Do we need to hook this in with bugs.c somehow so it skips the other BHI
> mitigations?

Yeah.. those didn't exist when I started this code :-) But yeah, once we
get to the point of doing this patch for real -- the compiler(s) have
the required features implemented properly and everyrhing, this should
be hooked up better.

