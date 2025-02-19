Return-Path: <linux-kernel+bounces-522178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7B2A3C708
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7CEC3AA6B6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867C7214817;
	Wed, 19 Feb 2025 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M0KsTQ44"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0E82147EF
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 18:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739988492; cv=none; b=r99FCBN829LnWCwNdM8Bg686DYaLXUmIW7Cua4z2pKWk0wW3wwL3MoX+cdB/D+b8KlstR9lmucxPu6Y+TOc2E8vx+Tm4b5GBogNWwAecp8gA8HRdX1tfZHVOHRRxK9PcVwrzwrzIWoYfzdqxid/bE/fnQd/VpiDBEiq8yZTMxCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739988492; c=relaxed/simple;
	bh=UAgvcat4lnZqVVekDNOeB2pqjhJhx9FB2J+P7mc+cI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0u/5ovB4UWSA80F0r5RDd7My+w/rERZ+RZP80sgYI6WtSGUnmIi8w22auEPwJeMDqkTwV2TcI5WRzXbMWcUvzwkVxi/3PXfzxnrTE6OZRkwSR9jynWL4ZZPg+hOGsKug8S386tqTbnYk2oJv9aC0zIahhBnUkBr4lyeY11vI4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M0KsTQ44; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HO+ciV3/8IIL9I5Ob0abjCFVe/TxQMKgtDHcsVDjvr0=; b=M0KsTQ44nAcnFhWSPqE0JVVuLR
	WTG/3qnxVDcAwLnnRKQPKE/KCc6qLafA8wdFPUidcyejn+IhyX5oiSGdhBbFZX+/gjzEi1QQ0Oc59
	gJK8mGSmqZLz7XqRYWAX7PcVpRfBei5hF+46hckC/w3a7YLUhsfVVZw7Rae3xo+0iWxz8IBjnVpT1
	iBSdHD8UBfmTUmZZdEWyTC1+Xq5tK8/54P1bRJJDc1kR3w9GmuyR9LylIa+Lxwb7U/FsATdZqYSLr
	TeuUyiVHkUgNnBnnlWQvkQnjg9a8fzUH/ITFHDdnttOHJkQmP0fXpYsVFxg4zumVMDSX2zsM63Awb
	MyS/nx2Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tkoUI-00000002Ieg-2s7g;
	Wed, 19 Feb 2025 18:07:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 45948300787; Wed, 19 Feb 2025 19:07:58 +0100 (CET)
Date: Wed, 19 Feb 2025 19:07:58 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, samitolvanen@google.com, nathan@kernel.org,
	ojeda@kernel.org, alexei.starovoitov@gmail.com, mhiramat@kernel.org,
	jmill@asu.edu
Subject: Re: [PATCH v3 08/10] x86: BHI stubs
Message-ID: <20250219180758.GB23004@noisy.programming.kicks-ass.net>
References: <20250219162107.880673196@infradead.org>
 <20250219163515.150619755@infradead.org>
 <202502191006.923E600C3@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202502191006.923E600C3@keescook>

On Wed, Feb 19, 2025 at 10:07:04AM -0800, Kees Cook wrote:
> On Wed, Feb 19, 2025 at 05:21:15PM +0100, Peter Zijlstra wrote:
> > --- a/arch/x86/lib/Makefile
> > +++ b/arch/x86/lib/Makefile
> > @@ -66,5 +66,6 @@ endif
> >          lib-y += clear_page_64.o copy_page_64.o
> >          lib-y += memmove_64.o memset_64.o
> >          lib-y += copy_user_64.o copy_user_uncached_64.o
> > -	lib-y += cmpxchg16b_emu.o
> > +        lib-y += cmpxchg16b_emu.o
> > +        lib-y += bhi.o
> >  endif
> 
> Unrelated whitespace fix?

Yes, I could not leave the cmpxchg16b thing mis-aligned :-)

