Return-Path: <linux-kernel+bounces-522238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B88CDA3C7C0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2A953B0578
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99458214A6E;
	Wed, 19 Feb 2025 18:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QpsU7O56"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783621F2B90
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 18:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739990019; cv=none; b=qXc0tmcRLDG1jR9rzU/b4OWFtigo3j1b4AEHwBly6kkzeSi0Q3PqoEzPlpcczw3bVs6Ds/aLooeCRaXPrp43Wb0GH+oZXF9f/YT4ns7OCjJltPxezXvye0SOl+ccwVbLpS8E3neQ62mcOK0Yh/wmveNgmzpzUf4Yq4SI4ks/jL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739990019; c=relaxed/simple;
	bh=EbFxu9kg9SFvZErcQzeWPOnj22/5M19b8kPelw2TMck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maYfxg1GCw/WtQQY6tDEP34O7ZSOMk4LEVv+PAdiUgbssWiGeVtBQNDWFfFp8Rrx1bBMyP6JwrE2U40087Z3IncEu6m3wbxnWJiMTQT3ZBmvE4Xjq2k6VKEpq9Nr01gnzCcSM8Rt1v9eJrF3z7XaVzsULnCja2vliyeHpkNkiwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QpsU7O56; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9DoWqhQoXeetmL5De53u1+NINb5oRJLPj/qSvMJSdfA=; b=QpsU7O56muoBl+DDajhEj5xdbZ
	orq/YN7tvBYZhoo+w6VWWOIGEBMYT0up5kiAgSv6nnNEQzdnn1CRWnELJjE7NRNgMLCUzL2+plSsO
	f70ai8JYFrOHMC6dG4mQvcADChh41jKl4IjFIIyJIgU8bEhJvlBQKL/xXQkc+rR/HUBRh0UqzkUE0
	hTD45SFm1j5WfPYZwNHypSDs7wucOm0JbNlWGr4L4zkrV7tR5LaQZmjYl1vwfDuBKoHA4WjKgt7eh
	ChEo7k5B5LpwSZhlTtVJaCfZfiPGwRxAF061B00NrtB6ZBpDl6piZdaDA2wYqfZ+RIdeATUOiJlPM
	ZeE9Rl5Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tkot0-00000006pH3-1yxo;
	Wed, 19 Feb 2025 18:33:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 102CE300783; Wed, 19 Feb 2025 19:33:30 +0100 (CET)
Date: Wed, 19 Feb 2025 19:33:29 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, samitolvanen@google.com, nathan@kernel.org,
	ojeda@kernel.org, alexei.starovoitov@gmail.com, mhiramat@kernel.org,
	jmill@asu.edu
Subject: Re: [PATCH v3 06/10] x86/traps: Decode LOCK Jcc.d8 #UD
Message-ID: <20250219183329.GE23004@noisy.programming.kicks-ass.net>
References: <20250219162107.880673196@infradead.org>
 <20250219163514.928125334@infradead.org>
 <202502191013.72E4EFFF0@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202502191013.72E4EFFF0@keescook>

On Wed, Feb 19, 2025 at 10:20:25AM -0800, Kees Cook wrote:

> I realize these are misplaced chunks, but passing ud_type into the
> handler feels like a layering violation to me. I struggled with this
> when making recommendations for the UBSAN handler too, so I'm not sure
> I have any better idea. It feels like there should be a way to separate
> this logic more cleanly. The handlers are all doing very similar things:
> 
> 1- find the address where a bad thing happened
> 2- report about it
> 3- whether to continue execution
> 4- where to continue execution
> 
> The variability happens with 1 and 4, where it depends on the instruction
> sequences. Meh, I dunno. I can't see anything cleaner, so passing down
> ud_type does seem best.

Yeah, agreed. I couldn't get rid of relying on ud_type entirely (it was
worse), I'll see if I can come up something.


