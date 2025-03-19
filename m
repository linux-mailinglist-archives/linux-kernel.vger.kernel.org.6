Return-Path: <linux-kernel+bounces-568904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B715EA69BE1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 140AC188D542
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E485721ADB9;
	Wed, 19 Mar 2025 22:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mm5kf1Kj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDEF2144C8;
	Wed, 19 Mar 2025 22:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742422618; cv=none; b=ruMu69rvqY8O4AB1zxMWjwQiaCO5ilg6s2sJ+5LV82CCpWacK+obizYqYTE92a2z56LqFCQrTBLCiBXnNcJwUEuU1+HGqFVl6MintsAAggn4dT16lwSIv7tFf+AIH0C1DeHJUA+5tCK6fPLxATipTaEGkPLH7JeydsOBjD5vtxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742422618; c=relaxed/simple;
	bh=GbwW/zlLCQR00yHt07WJu3qEtHgJuBP3WynBMHBjFA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9i6qYgphPy7llwARKmM5NzFQYnUF2T4/O8ZiiXx/vfNLehRBAQyOxdhrKLuAK03vSuv/nx2Y0dg5jTlsA0ogY3wV+q5yIWAMF37seSEB7sxr3yTejEce3Hb8Yx41Ji7HWHCMUSpRzbAt0mvLx+kYGGY3y/sqS7k6/PgScF8rhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mm5kf1Kj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C3FC4CEE4;
	Wed, 19 Mar 2025 22:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742422617;
	bh=GbwW/zlLCQR00yHt07WJu3qEtHgJuBP3WynBMHBjFA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mm5kf1Kjno4u8Znnv7Pez1AG3ctSIaoisMz7tYMFnKCFsuKZIFjGQ39Ba7D+8GCMk
	 7ekBNgqsrZvwzCk18MvXHEGNACvdDz2MY71rBMJqHXF9OMoNVAvbD5MVp8LrwGTI7I
	 cdbTvZ2qHnT+lqvfy302Qc2YR9JizILVjNVM8RTHFh5JIqZEyhqg/3t6GB1U1MxikQ
	 np/Fem5CqFDoaDl7pLjECtjMJtlxvNtv3eQPO3xHW2kI1nbhu3JO4v5qjjUFoIauxh
	 7VLvb/L/ZPUn5rVaFc8G+HN9WjEmA2OUDORPEG1xyALZ2Us1KQ4frEdniRzuviHvVK
	 CI5MRwWE5XnXg==
Date: Wed, 19 Mar 2025 23:16:52 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Denis Mukhin <dmkhn@proton.me>
Cc: dmukhin@ford.com, Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/early_printk: add MMIO-based UARTs
Message-ID: <Z9tCVIPTZr10WnNq@gmail.com>
References: <20250314-earlyprintk-v2-1-2bcbe05290b8@ford.com>
 <Z9fWMaX25c8GIaQK@gmail.com>
 <wlidpR0nAfMoUkVTrtOogcSBeZ8pEKU32ZCubunTj3-kDUj4hKY0fJAAQD11aFA5xkGAH9qV2tNee7yB5qJof_lq9zxdXAfzR0Fm6mf5cqI=@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wlidpR0nAfMoUkVTrtOogcSBeZ8pEKU32ZCubunTj3-kDUj4hKY0fJAAQD11aFA5xkGAH9qV2tNee7yB5qJof_lq9zxdXAfzR0Fm6mf5cqI=@proton.me>


* Denis Mukhin <dmkhn@proton.me> wrote:

> Hi,
> 
> Thanks for taking a look!
> 
> On Monday, March 17th, 2025 at 12:58 AM, Ingo Molnar <mingo@kernel.org> wrote:
> 
> >
> >
> >
> > * Denis Mukhin via B4 Relay devnull+dmukhin.ford.com@kernel.org wrote:
> >
> > > + if (!strncmp(s, "nocfg", 5))
> > > + baudrate = 0;
> > > + else {
> > > + baudrate = simple_strtoul(s, &e, 0);
> > > + if (baudrate == 0 || s == e)
> > > + baudrate = DEFAULT_BAUD;
> > > + }
> >
> >
> > In standard kernel coding style we always balance curly braces and
> > don't skip them in the single-statement case. Ie. the above should be:
> >
> > if (!strncmp(s, "nocfg", 5)) {
> > baudrate = 0;
> > } else {
> >
> > > + if (baudrate)
> > > + early_serial_hw_init(115200 / baudrate);
> >
> >
> > Hm, I think that division will go poorly if 'baudrate' ends up being 0
> > in the 'nocfg' case ... ;-)
> 
> This patch has a guardrail:
>   early_serial_hw_init(115200 / baudrate);
> will not be called in case of baudrate is 0.

Ugh, I must have had very limited reading comprehension that day :-/

> I can re-write code to avoid confusion.

No need to rewrite, the code is clear enough, it's my fault. :-)

But please do send -v3 with the curly braces fix, and merged against 
the latest x86 tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master

because there's a pending commit that creates a conflict:

  306859de59e5 ("x86/early_printk: Harden early_serial")

... while the conflict looks simple enough, it would be best to also 
test it, etc.

Thanks,

	Ingo

