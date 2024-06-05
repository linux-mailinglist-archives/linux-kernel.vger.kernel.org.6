Return-Path: <linux-kernel+bounces-202240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 713D98FC9E7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DD751F26414
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5378192B6C;
	Wed,  5 Jun 2024 11:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MI84b9tH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0964E192B60;
	Wed,  5 Jun 2024 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717585815; cv=none; b=XF42IJtIRGkI4bvr2vlYllKSy3BPsCRsNCo/S1KXdMp056DoKGDERwUrA0LqVjN/mMUBTUw5/thDSWg2BQuUonSIxhNHGPWbB3/V+0naoJ6vH6F7ISXHPPs8O+TWBIIgp3kKgtX2iEmuDnMCyk70phbsJ2/SMrjgqxTPSDlkVPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717585815; c=relaxed/simple;
	bh=WAf92JcWL9zU29AnQHI1Uxy5BLjHqcBVKQhaoL07mZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHMSlyOix1x89IkP/Uq+LdJq7GM0/f/DsEjSD86E5oZTQ8Z7zszg/Tz7iqL0nG7wMJBFCUTGFrgQ+VaoIvcUsbmv5ovkt/wTiZ/3pxRh0qgiRpjiFf+9l1ZFgYOB+OvNSVQg5Prd8n/YpJgykiFtDvsQ02m+GScllIrZK1OKilQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MI84b9tH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4080C3277B;
	Wed,  5 Jun 2024 11:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717585814;
	bh=WAf92JcWL9zU29AnQHI1Uxy5BLjHqcBVKQhaoL07mZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MI84b9tHI/I/sI/UDJ9M4y7Lj6bLx5Ikk7ZrtqjcSUBrsuNUMcJzK/4edVNt4XHDS
	 7cQdHEakeG7uzAFKUq8Zn6s+1Lp2GVE8Ntt9w1dhMal1gC8umbQrXuPy3A+KRFEINS
	 mQdY8WJ9UcH8IDHu08sl15ouTSGl1P5n/hv9FN1vma8nbbeGPB1SOKS9nRQEaPjABm
	 1MQK44Km9MYB21F3Y/O//jHmrXsuWegqeS9IGRtt5cSZcsUnu4AezVpiwFr27fgAeM
	 IuzIIU3yodrb+wxiXGBU2AC2wGvnantTYkSqVh2UW9UCmediLMY0uIUIDYKM5bdwIB
	 6G30OlwlVSjWw==
Date: Wed, 5 Jun 2024 12:10:08 +0100
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Baoquan He <bhe@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] [v3] arm64/io: add constant-argument check
Message-ID: <20240605111008.GA21651@willie-the-truck>
References: <20240604210006.668912-1-arnd@kernel.org>
 <ZmAsutGzL5_Kx8Pn@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmAsutGzL5_Kx8Pn@J2N7QTR9R3>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Jun 05, 2024 at 10:15:38AM +0100, Mark Rutland wrote:
> On Tue, Jun 04, 2024 at 10:59:57PM +0200, Arnd Bergmann wrote:
> > Move the check for constant arguments into the inline function to ensure
> > it is still constant if the compiler decides against inlining it, and
> > mark them as __always_inline to override the logic that sometimes leads
> > to the compiler not producing the simplified output.
> > 
> > Note that either the __always_inline annotation or the check for a
> > constant value are sufficient here, but combining the two looks cleaner
> > as it also avoids the macro. With clang-8 and older, the macro was still
> > needed, but all versions of gcc and clang can reliably perform constant
> > folding here.
> > 
> > Fixes: ead79118dae6 ("arm64/io: Provide a WC friendly __iowriteXX_copy()")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> I have a trivial nit below, but either way this looks good to me, so
> regardless of that:
> 
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> 
> > +static __always_inline void
> > +__iowrite32_copy(void __iomem *to, const void *from, size_t count)
> >  {
> > -	if (count == 8 || count == 4 || count == 2 || count == 1) {
> > +	if (__builtin_constant_p(count) &&
> > +	    (count == 8 || count == 4 || count == 2 || count == 1)) {
> >  		__const_memcpy_toio_aligned32(to, from, count);
> >  		dgh();
> >  	} else {
> >  		__iowrite32_copy_full(to, from, count);
> >  	}
> >  }
> > +#define __iowrite32_copy(to, from, count) __iowrite32_copy(to, from, count)
> 
> Normally we'd make this:
> 
> #define __iowrite32_copy __iowrite32_copy
> 
> ... so that it's clear it's just providing the preprocessor symbol, and
> doesn't have to be updated if the prototype changes.
> 
> [...]
> 
> > +#define __iowrite64_copy(to, from, count) __iowrite64_copy(to, from, count)
> 
> Likewise here.

I can fold these two changes in.

Will

