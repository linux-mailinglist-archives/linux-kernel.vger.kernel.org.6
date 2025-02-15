Return-Path: <linux-kernel+bounces-516144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC167A36D60
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 11:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FDFD1894E64
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 10:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A426C1A23BD;
	Sat, 15 Feb 2025 10:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OKQvFvd8"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9553748F
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739616052; cv=none; b=c/ZfjEStFciz/8dtObagMVehV2npo3YMYl2q56jbWZLBI5vVNxjf3ZytirBCStFp1zgpmXMGF2T2lk3DOiWSaCJ5p0OiRwpDPIEQ2RvrvgqQ1KLiyDwB+0Nqp7J0HB0Pmj1YhoP6Da/Xi/x7Zb4mE4luoktv9RkFYN7/hSqUa30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739616052; c=relaxed/simple;
	bh=hpMSzi65tTjTUBP05Em0a97bQoBMfXspWfoExnUKChc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzkEj8e3wUKRQjAOHr8bHkag6a7CbFK1x30CIOznKvfSuVOBMlyPt4mmEZ8rDRU+WvFyOLdYSCYC1njxA6+KLrl+W7r3+FFbgPruvINGGtAYo1SAJc1tSKMbBbv3LCgg4EOiGZKbPP5fGz2qW7TmJ7GBcawtllEAI0xpsY6zK4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OKQvFvd8; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mxyN+4hCtBG/3jzR75AJsxPzMyqex/DzNB7m0uiF4qI=; b=OKQvFvd8Rki5ZoVLCjIin0LTkY
	6AoBfKcrp4EDTOVXJK/QTBt66i6teK6uBvckePsyVOZik2IRJuT3I4q3TbFAoqcf7fkDQVvi0NhHr
	Ywg7t6evtrGkQZ3/C1UERfveznD/66UQtUGPZjw9Wc/rrMZLsNi+YdLUaAAKKqJPvyQDQ1Cjls59S
	bx+HecLbYAyCqxHKyXZ0fkFbx55VZXYRd8EnYkOlOC+GZWV4KELet0OzHiXkMq+Xj5YUp9maTLx3R
	ut3wD1+9/OCzCVma9jkQoc8FtmTaPuTGJh394Ip5xmtK3MdBia0xEZ7NCVranKVymfVq6oLwPdy4T
	KcLaqOuQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tjFbA-00000001Qnr-0jjq;
	Sat, 15 Feb 2025 10:40:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BD0D0300318; Sat, 15 Feb 2025 11:40:35 +0100 (CET)
Date: Sat, 15 Feb 2025 11:40:35 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, samitolvanen@google.com, nathan@kernel.org,
	ojeda@kernel.org, alexei.starovoitov@gmail.com, mhiramat@kernel.org
Subject: Re: [PATCH 11/11] x86/fineibt: Add FineIBT+BHI mitigation
Message-ID: <20250215104035.GA13198@noisy.programming.kicks-ass.net>
References: <20250207121529.222723073@infradead.org>
 <20250207122547.124276834@infradead.org>
 <202502140957.FE93863F@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202502140957.FE93863F@keescook>

On Fri, Feb 14, 2025 at 10:02:12AM -0800, Kees Cook wrote:
> On Fri, Feb 07, 2025 at 01:15:40PM +0100, Peter Zijlstra wrote:
> > Due to FineIBT weakness, add an additional mitigation for BHI.
> > [...]
> > @@ -1020,6 +1036,8 @@ static __init int cfi_parse_cmdline(char
> >  			cfi_mode = CFI_KCFI;
> >  		} else if (!strcmp(str, "fineibt")) {
> >  			cfi_mode = CFI_FINEIBT;
> > +		} else if (IS_ENABLED(CONFIG_FINEIBT_BHI) && !strcmp(str, "fineibt+bhi")) {
> > +			cfi_mode = CFI_FINEIBT_BHI;
> >  		} else if (!strcmp(str, "norand")) {
> >  			cfi_rand = false;
> >  		} else {
> 
> While looking at FineIBT vs entry, I noticed that FineIBT+BHI must be
> explicitly selected at boot. Did you want it to be enabled automatically
> when the compiler supports it and FineIBT is enabled? Does there need to
> be a check for BHI added?

Yes, it needs to be tied in with the whole speculation mitigation crap.
Didn't want to bother with all that just yet though.

