Return-Path: <linux-kernel+bounces-530781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CED0A43848
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93747167DCC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 08:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA17F266EE7;
	Tue, 25 Feb 2025 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vn2BTqZc"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDCA2661A1
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473543; cv=none; b=OJzHW/pw1qEVbPoqB1+q1N2XtU1Z70dM8k9w3KarKbKoW2x/BbTTtESrQGstmlqrZVTQMahfH4IyyL60NuQEyoUNTPrSUHo0saqowdZgHvs8W1EHs0RSLVaejF7iPzB2LU46RQkB4Vw+H3iQ3h3rJdrHAZvQIgFSwfMUhM92P7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473543; c=relaxed/simple;
	bh=TFS5c7Hw8S7kYNDm6NDM0PtIESiz36L/3d/oTL6sCVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzBKyjuY4AfiXMVGUmtCe6ZF2yNhbh4mZaR8mkuIS1bEbLMiOW/7odYPZWPaGkOIkZNERZya2wcrU2LIte9xHPa0O2+KrKk9xq53ypPwFcpc2xD9ReuSLVB97I+81SXnhuwSUT2bqDQbCBCAEn/WkvIC9uc147xHBF11sZR3rpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vn2BTqZc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=waxx8jkYb4epO0AOIan6JidES5QwzU8MPa4isEonxmg=; b=vn2BTqZcsr1KCg9fcx11ENayPq
	Z93+esfUloxQM3QGGGLtIzdLYX4/IMKAZ/FLernC9NooavuiWo3PM7o7vPJnqZto/2Xsu5lCaLhVH
	SteE5eMCRzAaN5KKjDjvam908ucf16pJCLRU5sa9NprxQ6m2z2MB9Qx9YlU5BzBImBTlMDG0MqqL4
	DJZsWAdBhs0tUEPQbpqCKFq2ZpXkZd6fQfxAx3trawgYvcHrceH2XTsAqKIvhQMsIQY5AkGzyxzce
	UWhBXwCmVVKAKrGENQDgVGIxpxH2iIFybitg85JKiBDN4pd1hpQgk3diKukX1ipYRE9f1f5NKYq4r
	W1H2oPEA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tmqfk-0000000Ae4n-3ki6;
	Tue, 25 Feb 2025 08:52:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7AF7E300472; Tue, 25 Feb 2025 09:52:12 +0100 (CET)
Date: Tue, 25 Feb 2025 09:52:12 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, samitolvanen@google.com, nathan@kernel.org,
	ojeda@kernel.org, alexei.starovoitov@gmail.com, mhiramat@kernel.org,
	jmill@asu.edu
Subject: Re: [PATCH v4 08/10] x86: BHI stubs
Message-ID: <20250225085212.GG11590@noisy.programming.kicks-ass.net>
References: <20250224123703.843199044@infradead.org>
 <20250224124200.717378681@infradead.org>
 <202502241100.9B62173958@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202502241100.9B62173958@keescook>

On Mon, Feb 24, 2025 at 11:01:02AM -0800, Kees Cook wrote:

> On Mon, Feb 24, 2025 at 01:37:11PM +0100, Peter Zijlstra wrote:
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Did this commit log go missing?

Nah, it never had one.

How does this sound?

---

Add an array of code thunks, to be called from the FineIBT preamble,
clobbering the first 'n' argument registers for speculative execution.

Notably the 0th entry will clobber no argument registers and will never
be used, it exists so the array can be naturally indexed, while the 7th
entry will clobber all the 6 argument registers and also RSP in order to
mess up stack based arguments.


