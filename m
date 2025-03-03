Return-Path: <linux-kernel+bounces-542554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C30DA4CB0E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94CB61750BB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE62120FA85;
	Mon,  3 Mar 2025 18:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SJnzwU7Z"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8846C84A3E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 18:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741026932; cv=none; b=OC4d+B59OLz+turK9/swRNgtIzTojUhAW5YbRPn7wE8Kol3GjBIvrxqwiNSzUbi6eN/z8sva0pXxpVuGX+BZfEXV8J2cs8v5o+ypTDMssMafOBEhdYQMkPFIeJYR6rCx0npm7UVv25iLaz/Ysxgm8X0+AU+OLHRDZ4AoLWxeVEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741026932; c=relaxed/simple;
	bh=rU5k13T2Ac3+v0BbPnnLOmB9rtNCiy3ce+lMSrf1jNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6GMZJNnXmYNU/gdeyYlCDLEBdejBuNmphuCiCmUR5mmqtMotX+loGmgynsU2a99/C2hkd+jMI+rmErDXTjFgntG8BpP+c0hHZyRjZl94HJwuTaFqgnMuJcrwoG+i2Hww7jYlbN3pU14uu9iJ5U+w79BG+I5I5obcfMUWTtt3jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SJnzwU7Z; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IG0+ynVNm0jAcQmWmjGgFRxTrHWQSqojbT/C1B/7cF0=; b=SJnzwU7Z1WEzXQT/sfEc8ueRkP
	jRE+YxDr6EmAE+iQnTy1jd3AT9XYE7IqYDvD4jSENN6oK08sZLVoiThExVgrNQ8CAKXNc++MPFdwJ
	2feL8s4a1W5m2/I7hublWCghow3LAqPU508siW2Vp0S9xjT+J2vWuw64PyETA6K3QlAIRpJwPQBzN
	9H+1fBpGW5hZR7/wmav5TbchOYuQB3tZQ95bA9oAqQGD7nV8Dv1Kl4kBAImslE8v6Tz16Mz5tdJMj
	KU0ql+3qJXvIxZtyWbsVotyGO98xcIqep7c8G/I1vqOPTV5CS0G9nXIRMMwg68MBkjAiuK7Em1lm1
	Che+W0Cg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tpAdT-0000000E7JD-0IFM;
	Mon, 03 Mar 2025 18:35:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0CA0A30049D; Mon,  3 Mar 2025 19:35:26 +0100 (CET)
Date: Mon, 3 Mar 2025 19:35:25 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: lkdtm: Annotate do_nothing()
Message-ID: <20250303183525.GA15322@noisy.programming.kicks-ass.net>
References: <20250303093817.GJ5880@noisy.programming.kicks-ass.net>
 <202503030921.2CD851B31D@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202503030921.2CD851B31D@keescook>

On Mon, Mar 03, 2025 at 09:26:57AM -0800, Kees Cook wrote:
> On Mon, Mar 03, 2025 at 10:38:17AM +0100, Peter Zijlstra wrote:
> > Hi Kees,
> > 
> > During my FineIBT testing the other week I stumbled upon the following
> > complaint:
> > 
> >   vmlinux.o: warning: objtool: execute_location+0x4f: relocation to !ENDBR: .text+0x1032008
> > 
> > I finally got around to looking at it and realized we have means of
> > annotating that since 93f16a1ab78c ("x86/boot: Mark start_secondary() with __noendbr")
> > (which might still be in tip only).
> 
> Er, doesn't that mean do_nothing() will lack an ENDBR? Wait, no, that's
> __noendbr. What does this annotation mean if the function _does_ have
> ENDBR?
> 
> Note that these tests are explicitly using __nocfi (via the
> execute_location() function) since they're testing the Execute bit in
> different memory regions. But I would expect BTI to still work (and not
> block execution).
> 

Argh, I had a definite wake-up juice deficit this morning, and the BTF
noise made me miss that the warning wasn't fixed.

For some reason I thought do_nothing() didn't have ENDBR. Looking at the
build now, I see it does have, and the actual location pointed to is
do_nothing+0x18, which is weird.

Ooh, I see, the thing looks to have unrolled and inlined that memcpy()
like:

   156a3:       48 8b 05 00 00 00 00    mov    0x0(%rip),%rax        # 156aa <execute_location+0x2a>    156a6: R_X86_64_PC32    .text+0x1032024
   156aa:       48 89 43 38             mov    %rax,0x38(%rbx)
   156ae:       48 8b 05 00 00 00 00    mov    0x0(%rip),%rax        # 156b5 <execute_location+0x35>    156b1: R_X86_64_PC32    .text+0x103201c
   156b5:       48 89 43 30             mov    %rax,0x30(%rbx)
   156b9:       48 8b 05 00 00 00 00    mov    0x0(%rip),%rax        # 156c0 <execute_location+0x40>    156bc: R_X86_64_PC32    .text+0x1032014
   156c0:       48 89 43 28             mov    %rax,0x28(%rbx)
   156c4:       48 8b 05 00 00 00 00    mov    0x0(%rip),%rax        # 156cb <execute_location+0x4b>    156c7: R_X86_64_PC32    .text+0x103200c
   156cb:       48 89 43 20             mov    %rax,0x20(%rbx)
   156cf:       48 8b 05 00 00 00 00    mov    0x0(%rip),%rax        # 156d6 <execute_location+0x56>    156d2: R_X86_64_PC32    .text+0x1032004
   156d6:       48 89 43 18             mov    %rax,0x18(%rbx)
   156da:       48 8b 05 00 00 00 00    mov    0x0(%rip),%rax        # 156e1 <execute_location+0x61>    156dd: R_X86_64_PC32    .text+0x1031ffc
   156e1:       48 89 43 10             mov    %rax,0x10(%rbx)
   156e5:       48 8b 05 00 00 00 00    mov    0x0(%rip),%rax        # 156ec <execute_location+0x6c>    156e8: R_X86_64_PC32    .text+0x1031ff4
   156ec:       48 89 43 08             mov    %rax,0x8(%rbx)
   156f0:       48 8b 05 00 00 00 00    mov    0x0(%rip),%rax        # 156f7 <execute_location+0x77>    156f3: R_X86_64_PC32    .text+0x1031fec
   156f7:       48 89 03                mov    %rax,(%rbx)

And objtool figures those .text references are an address-taken-of like
thing and expects ENDBR at them.

Lovely stuff...

Anyway, ignore this patch.

