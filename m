Return-Path: <linux-kernel+bounces-194481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 614018D3CF2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 18:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F06CF1F24F90
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506BA19069F;
	Wed, 29 May 2024 16:36:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0D4190683
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 16:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000601; cv=none; b=R/EmlxoOVps5Y0eKW7bEAEMQt2y23b14WEry4xt8LW5cJGjEN8dbLep7Dwa+ADlnR/vxkgowTFKezG4FdbzmwIcWLNipngOGKeNJFHt4V2LW7lFzUnSoz3cdr42F6671R02vX5axqn+0/9GwYLe/ZwsNuiQWPOCjBgJJoR8j6FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000601; c=relaxed/simple;
	bh=N9WrYbSatpSG3LGiA7yCIjFuPYdHg8AWHSKNnwTQGrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rp39Qbd9vh57fB4e96Zqa2dxNxj1ybiD7UEPMMCN0RRyi6PMpdziw43QApIya0ZdG0WFxmuf0mTzXyRy2KlWrYUiTW+yFJblKSVmEJUNgxvKi0YfJG9wa2nCO2gLiHb9JVpnCQZF8gT06cFFyQuJqbYBwxipYZM5HfjUJIicWHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7645D339;
	Wed, 29 May 2024 09:37:03 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D270E3F792;
	Wed, 29 May 2024 09:36:37 -0700 (PDT)
Date: Wed, 29 May 2024 17:36:34 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Valentin Schneider <vschneid@redhat.com>,
	Baoquan He <bhe@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/io: add constant-argument check
Message-ID: <ZldZkm_bqDSZ1oS5@J2N7QTR9R3.cambridge.arm.com>
References: <20240528120844.3523915-1-arnd@kernel.org>
 <ZlcODqVXTDh6n0h-@J2N7QTR9R3>
 <8ff9bc52-bf2f-4856-9335-14bf659e7e4c@app.fastmail.com>
 <ZldE0dp7cBpZl4JY@J2N7QTR9R3.cambridge.arm.com>
 <c63093a6-6787-49ba-ac23-8e27b4861560@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c63093a6-6787-49ba-ac23-8e27b4861560@app.fastmail.com>

On Wed, May 29, 2024 at 06:15:57PM +0200, Arnd Bergmann wrote:
> On Wed, May 29, 2024, at 17:08, Mark Rutland wrote:
> > On Wed, May 29, 2024 at 02:29:37PM +0200, Arnd Bergmann wrote:
> >> On Wed, May 29, 2024, at 13:14, Mark Rutland wrote:
> 
> >> 
> >> Yes, your version addresses both failures I ran into, and
> >> I think all other theoretical cases.
> >> 
> >> I would prefer to combine both though, using __always_inline
> >> to force the compiler to pick the inline version over
> >> __iowrite32_copy_full() even when it is optimizing for size
> >> and it decides the inline version is larger, but removing
> >> the extra complexity from the macro.
> >
> > Sorry, I'm not sure what you mean here. I don't see anything handling
> > optimizing for size today so I'm not sure what change your suggesting to
> > force the use of the inline version; AFAICT that'd always be forced for
> > a suitable constant size.
> >
> > What change are you suggesting?
> 
> What I meant is that reason gcc chooses to not inline
> the macro is when we build with CONFIG_CC_OPTIMIZE_FOR_SIZE.
> 
> Since it doesn't know that __const_memcpy_toio_aligned64()
> is intended to be small after inlining, it sometimes
> decides against it, which (with just my patch) would
> fall back to the out-of-line __iowrite32_copy_full()
> while trying to generate smaller code.
> 
> The __always_inline annotation just overrides the
> calculation.

Ah, ok.

I think what you're suggesting is:

* Add the __always_inline annotations, as in my patch.

* Move the __builtin_constant_p check into __const_iowrite32_copy(), as in your
  patch.

* Remove the __iowrite32_copy() macro and rename __const_iowrite32_copy() to
  __iowrite32_copy(), removing the redundant logic.

Assuming so, that makes total sense to me.

Mark.

