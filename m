Return-Path: <linux-kernel+bounces-523065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17437A3D193
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 07:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918283ABD87
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8161E4110;
	Thu, 20 Feb 2025 06:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="05aYelCM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D35D1ADC6F;
	Thu, 20 Feb 2025 06:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740034411; cv=none; b=kpGUfCFTk/hO3aMMnaNIFT5EN2bTO/Bbn8XfrzVRPiy+q77V3kHiguv5+jIgvLDmV4BwMnu65imhjJrVoqA0L1CcEvDwJ4HfTTOg/Y/44/+oP7Cr1r0Q85ai0+UghVSKaSACeSowJ495dw2xbJhF2Jg9R2IREv0wS38v9cAqM/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740034411; c=relaxed/simple;
	bh=badsXN3RHOvj6FkdGc1vKzVV9GzrktXmBd5wfthDY/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXgT1UHQFs7uQR8xOfbufY8Kgw9vZLwRG2oSdlfs06Im5mCx0FS5JXkrTVLy+SHoSqJNo6PcfhxPjoNO83jTTvuES2smnSqs5z8dqx59v7zwUn6PsSbUDz913X1lMTq3B7G88E+Rc3pJPLptUkkk07+nTPYTVAcIfUe8HnJv39g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=05aYelCM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901C5C4CED1;
	Thu, 20 Feb 2025 06:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740034411;
	bh=badsXN3RHOvj6FkdGc1vKzVV9GzrktXmBd5wfthDY/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=05aYelCMcL48DSd3AQUBa6wggT7XkmDL0sfT71U9XxRREiLFUQpaCMeSgVsJJ/LiC
	 i66uz5S9A99wQNsW+hfGEjPKrHPBKkQwTtF3sj8kldVnhcP0WJthXNK9TdPbVnHDuC
	 QF2Tv19axlVLywFjGOolinei4YmHBHj+Ojl3TtbU=
Date: Thu, 20 Feb 2025 07:53:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <2025022007-angelfish-smite-a69d@gregkh>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org>
 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <202502191026.8B6FD47A1@keescook>
 <785A9F60-F687-41DE-A116-34E37F5B407A@zytor.com>
 <f77d549c-b776-4182-b170-571d1e5bb288@p183>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f77d549c-b776-4182-b170-571d1e5bb288@p183>

On Thu, Feb 20, 2025 at 09:32:15AM +0300, Alexey Dobriyan wrote:
> On Wed, Feb 19, 2025 at 11:33:56AM -0800, H. Peter Anvin wrote:
> > b. Can we use existing mature tools, such as C++, to *immediately* improve the quality (not just memory safety!) of our 37-year-old, 35-million line code base and allow for further centralized improvements without the major lag required for compiler extensions to be requested and implemented in gcc (and clang) *and* dealing with the maturity issue?
> 
> We can't and for technical reasons:
> 
> * g++ requires C99 initializers to be in declaration order,
>   even in cases where there is no reason to do so.
> 
> * g++ doesn't support __seg_gs at all:
> 
> 	$ echo -n -e 'int __seg_gs gs;' | g++ -xc++ - -S -o /dev/null
> 	<stdin>:1:14: error: expected initializer before ‘gs’
> 
>   x86 added this to improve codegen quality so this would be step backwards.
> 

And then there's my special addition to the kernel "struct class" :)

Anyway, no sane project should switch to C++ now, ESPECIALLY as many are
starting to move away from it due to the known issues with complexity
and safety in it's use.  Again, see all of the recent issues around the
C++ standard committee recently AND the proposal from Google about
Carbon, a way to evolve a C++ codebase into something else that is
maintainable and better overall.  I recommend reading at least the
introduction here:
	https://docs.carbon-lang.dev/
for details, and there are many other summaries like this one that go
into more:
	https://herecomesthemoon.net/2025/02/carbon-is-not-a-language/

In short, switching to C++ at this stage would be ignoring the lessons
that many others have already learned already, and are working to
resolve.  It would be a step backwards.

thanks,

greg k-h

