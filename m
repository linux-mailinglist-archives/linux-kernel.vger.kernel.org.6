Return-Path: <linux-kernel+bounces-562044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A98A61B3B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 340511896233
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EC9204582;
	Fri, 14 Mar 2025 19:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jcGifnYG"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919A4204F8E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 19:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741982349; cv=none; b=Ex7ThwRyVmsrqUSIOZpFxtbVRcC0ziNaYjmFpEslUF3HTDG8bVaGnmNX2KOth/UMA6hmU1wAJcd2HWF51whdWSWS92E2yA5/zIrC5xEvNtj4eOLNlFGmHnpuY4b4wcDi6O34EersG3CsyN95WP6LBgHAiP+E+XIt/Fy9YnfBx9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741982349; c=relaxed/simple;
	bh=Hwkj45GsQ9OHF14srkgdISSeftt5jowKt66bwwheVR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCH/CTyBEhUN7sWVVlQfAW42YBQjDC0vaoeMxNeo6c0k9OAgnovyVFMmzra4OMh83XCDI2c4OYOkHGdwODGJT0GHnAfP1a8TIqB86K9eHidLwqeLG0kJMaF/pxGYh5aAtjEf87HDpxerbO+iq4E4fFiy5+MsmeTKKMQYIPYhbDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jcGifnYG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RcppfkPrVdrkS0UE2gK4fde+TL+Z+xNB1kdpI563z6o=; b=jcGifnYGS+dKA8z0Xvq27gC80E
	U2hp6X26ZtAbavONWIG5ju1J0xnaMIQLtt8Cr6FcM2bo1K4sRbIBmvg3Y5Q3FchFHg9LdeY2mgxbe
	1+YrktqcCFFOTsPCoNAnMaByVGQvMeDlb2AcznpXTv1XJS05IkDZY4Rn2FQZIKcl4ViyBNq0bHd5A
	lMwrWsuJVTOxSYi7bwy2BHDLX9IX9LvwdoXx6pAgRGL9gdwG6TnXWHygU94yx9j/oglG6sZjlfrw+
	MnzuqDs08NcvZHJRoqObWrPGNLAVVHU6klmCmf77JLB2OVc29vXOOpafUi9fKVuc4t7oKZIH7UOHA
	EhGoiH8Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1ttBAi-00000005ETO-025I;
	Fri, 14 Mar 2025 19:58:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 17DA9300599; Fri, 14 Mar 2025 20:58:17 +0100 (CET)
Date: Fri, 14 Mar 2025 20:58:16 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 06/13] objtool: Remove --unret dependency on --rethunk
Message-ID: <20250314195816.GF36322@noisy.programming.kicks-ass.net>
References: <cover.1741975349.git.jpoimboe@kernel.org>
 <c6f5635784a28ed4b10ac4307b1858e015e6eff0.1741975349.git.jpoimboe@kernel.org>
 <20250314193848.GE36322@noisy.programming.kicks-ass.net>
 <naxuqdzhtcbtq7jdc3wiee2fawjzozhhfiztldin7bnl2mhk4h@eimhmkrc6kgs>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <naxuqdzhtcbtq7jdc3wiee2fawjzozhhfiztldin7bnl2mhk4h@eimhmkrc6kgs>

On Fri, Mar 14, 2025 at 12:52:32PM -0700, Josh Poimboeuf wrote:
> On Fri, Mar 14, 2025 at 08:38:48PM +0100, Peter Zijlstra wrote:
> > On Fri, Mar 14, 2025 at 12:29:04PM -0700, Josh Poimboeuf wrote:
> > > With unret validation enabled and IBT/LTO disabled, objtool runs on TUs
> > > with --rethunk and on vmlinux.o with --unret.  So this dependency isn't
> > > valid as they don't always run on the same object.
> > > 
> > > This error never triggered before because --unret is always coupled with
> > > --noinstr, so the first conditional in opts_valid() returns early due to
> > > opts.noinstr being true.
> > > 
> > > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > > ---
> > >  tools/objtool/builtin-check.c | 5 -----
> > >  1 file changed, 5 deletions(-)
> > > 
> > > diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
> > > index 387d56a7f5fb..c7275cf7641b 100644
> > > --- a/tools/objtool/builtin-check.c
> > > +++ b/tools/objtool/builtin-check.c
> > > @@ -151,11 +151,6 @@ static bool opts_valid(void)
> > >  		return true;
> > >  	}
> > >  
> > > -	if (opts.unret && !opts.rethunk) {
> > > -		ERROR("--unret requires --rethunk");
> > > -		return false;
> > > -	}
> > 
> > But but but, the whole UNTRAIN_RET stuff relies on return thunks. Even
> > though objtool can do that VALUDATE_UNRET_BEGIN -> VALIDATE_UNRET_END
> > check without there being return thunks, it simply doesn't make sense.
> 
> That's at least enforced by kconfig dependencies as
> MITIGATION_UNRET_ENTRY depends on MITIGATION_RETHUNK.
> 
> If you wanted to enforce it on the objtool level, we might need to do
> some makefile acrobatics to defer --rethunk to vmlinux link time for the
> above mentioned case.

Nah, I suppose it should all work like this. Its just weird seeing this.

