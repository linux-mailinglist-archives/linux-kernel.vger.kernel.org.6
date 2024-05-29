Return-Path: <linux-kernel+bounces-194330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 342018D3A4A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 17:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD1B81F2494E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEDD17BB33;
	Wed, 29 May 2024 15:08:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E211B17BB09
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716995287; cv=none; b=D389yJleu2FoCRfcYta+kuNTZ5R437ovbRk2DHQhU1aqWm7zjO391tRSp/u2Sdh/j4ZSI3uAI7sDzKw/y6tIZgCP6Go6eHm6Lelcl4DUhcVACNVby68NBYD8Dlotzl/nTlHAmtkN3kAcVm8mljIhsICi9BoNTpBt/Wj0ncUc1qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716995287; c=relaxed/simple;
	bh=2VbtYq5JfdkzMFR2Qv2gU2BDULTHXEIM7RnVLfX02G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rb34IAdbS9nVj2iSuKpV/iNu3MW/aeZKzu0Pk6TgSMjrtTZrdmWpM8+9HVhqth00C6lqtZk99QZZbLt+fJ1axp/OoFD2cyVsuH51IGT2iLP5kEB3CF5zISx65CJ1QPrHmSDpmTWhLb4p/ptFF1QKCNo6ddtqZAHKv9GhuD9YSKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E5A8339;
	Wed, 29 May 2024 08:08:29 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D858F3F762;
	Wed, 29 May 2024 08:08:03 -0700 (PDT)
Date: Wed, 29 May 2024 16:08:01 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Valentin Schneider <vschneid@redhat.com>,
	Baoquan He <bhe@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/io: add constant-argument check
Message-ID: <ZldE0dp7cBpZl4JY@J2N7QTR9R3.cambridge.arm.com>
References: <20240528120844.3523915-1-arnd@kernel.org>
 <ZlcODqVXTDh6n0h-@J2N7QTR9R3>
 <8ff9bc52-bf2f-4856-9335-14bf659e7e4c@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ff9bc52-bf2f-4856-9335-14bf659e7e4c@app.fastmail.com>

On Wed, May 29, 2024 at 02:29:37PM +0200, Arnd Bergmann wrote:
> On Wed, May 29, 2024, at 13:14, Mark Rutland wrote:
> >>  {
> >> -	if (count == 8 || count == 4 || count == 2 || count == 1) {
> >> +	if (__builtin_constant_p(count) &&
> >> +	    (count == 8 || count == 4 || count == 2 || count == 1)) {
> >>  		__const_memcpy_toio_aligned32(to, from, count);
> >>  		dgh();
> >>  	} else {
> >
> > I don't think this is the right fix.
> >
> > The idea was that this was checked in __iowrite32_copy(), which does:
> >
> > 	#define __iowrite32_copy(to, from, count)                  \
> > 	        (__builtin_constant_p(count) ?                     \
> > 	                 __const_iowrite32_copy(to, from, count) : \
> > 	                 __iowrite32_copy_full(to, from, count))
> >
> > ... and so __const_iowrite32_copy() should really be marked as __always_inline,
> > and the same for __const_memcpy_toio_aligned32(), to guarantee that both get
> > inlined and such that __const_memcpy_toio_aligned32() sees a constant.
> >
> > The same reasoning applies to __const_iowrite64_copy() and
> > __const_memcpy_toio_aligned64().
> >
> > Checking for a constant in __const_iowrite32_copy() doesn't guarantee
> > that __const_memcpy_toio_aligned32() is inlined and will actually see a
> > constant.
> >
> > Does diff the below you for you?
> 
> Yes, your version addresses both failures I ran into, and
> I think all other theoretical cases.
> 
> I would prefer to combine both though, using __always_inline
> to force the compiler to pick the inline version over
> __iowrite32_copy_full() even when it is optimizing for size
> and it decides the inline version is larger, but removing
> the extra complexity from the macro.

Sorry, I'm not sure what you mean here. I don't see anything handling
optimizing for size today so I'm not sure what change your suggesting to
force the use of the inline version; AFAICT that'd always be forced for
a suitable constant size.

What change are you suggesting?

> According to Jason, he used a macro here to be sure
> that the compiler can detect an inline function argument
> as constant when the value is known but it is not
> a constant value according to the C standard.
> 
> This was indeed a problem in older versions of clang
> that missed a lot of optimizations in the kernel, but
> clang-8 and higher were changed to have the same behavior
> as gcc here, so it is no longer necessary now that the
> older versions are unable to build kernels.

Getting rid of the macro is fine by me.

Mark.

