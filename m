Return-Path: <linux-kernel+bounces-527194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D017AA4084E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 13:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9F66420B94
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 12:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EB820A5E8;
	Sat, 22 Feb 2025 12:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BErU0CRg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458EE2063E8
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 12:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740227151; cv=none; b=W7wkTQXXbEbW7YatXE4pwvsFEcawP16U1iF5iQ5mjb631VoLPvNXun/8QwhprTNARwDqBkQTwV5qr+qK7fPtmwNfmHyoO2B1FzjSLdCf7Dz3QoM4mReehjqJCf1K+upA3iUeOGV/B7GKgGQWfESABEOaw7CuAZWZz6aRyojErj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740227151; c=relaxed/simple;
	bh=wFPOZGTzQtXqzaUsuG5YhWC9eGVsW6AClawQBeA9UEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nln5X5JKk8NAjS4V7AJcqSuNi8Vqmtu21seqn3ZgBbnTCV9V4YCnzp2cBiLTCx3JS3GRsa62UCkJRO+smAgD8fuAR0SF1lyQ21m2Xojvd0ge9ckWCO53thUscE9S+O71YXoGHNddxJR5zJrPzZO/XMGUaWGCbEB6x8zDTC29P2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BErU0CRg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1F9C4CED1;
	Sat, 22 Feb 2025 12:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740227150;
	bh=wFPOZGTzQtXqzaUsuG5YhWC9eGVsW6AClawQBeA9UEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BErU0CRgEYCV5hl0SNKFbr9+gfHXGtHCdQqgiPZ1hHi+tTDTXjab8KKw9y8FMaodl
	 ohtHcpGO1M8cFedTMKT7t0eXo/qXsD7zLnwjk2sJ+tVe5DONTmZY1PgARHNBnS5BdZ
	 i9bQqNYXs1JRMBwof0UAjgEPaRcIhCoBojk+kGGINWcW3nFsruXjBVg49ZPGrJZH28
	 IIP0zNT2ZaxA5cFPio/jdxNK8oWgkhcO7dJsjxQsx/zx1+KUDgIAyLS3PqBkXRrNmR
	 RI5eunM1ACDAGz2FE17QO2qvF1Ywvy1GqKRSX7Zbm7Juccvk/Jye+TyAMq5kOxwmcU
	 zpEfGoBGEXBrA==
Date: Sat, 22 Feb 2025 13:25:40 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Brian Gerst <brgerst@gmail.com>
Cc: Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v6 00/15] x86-64: Stack protector and percpu improvements
Message-ID: <Z7nCRFh5L9x40X5L@gmail.com>
References: <20250123190747.745588-1-brgerst@gmail.com>
 <Z7RRZ0jdqsrADMm0@gmail.com>
 <CAFULd4Z_QoOLKCOawyeFtRe6V4+oaaGxfQxav9dS-Di-Ne7tfw@mail.gmail.com>
 <Z7XE0P6ZFHxtlYXw@gmail.com>
 <CAMzpN2gyhEnYsimxLhLNPc4HTpVdRGTiBfm9pXiFTL6_3-O=sg@mail.gmail.com>
 <Z7ctmL3HDGxzyX0g@gmail.com>
 <CAMzpN2iwtA2fuNgBU2rrQzuUUD57_=fVzngn7AaJo-UAnJvVoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMzpN2iwtA2fuNgBU2rrQzuUUD57_=fVzngn7AaJo-UAnJvVoA@mail.gmail.com>


* Brian Gerst <brgerst@gmail.com> wrote:

> On Thu, Feb 20, 2025 at 8:26 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Brian Gerst <brgerst@gmail.com> wrote:
> >
> > > On Wed, Feb 19, 2025 at 6:47 AM Ingo Molnar <mingo@kernel.org> wrote:
> > > >
> > > >
> > > > * Uros Bizjak <ubizjak@gmail.com> wrote:
> > > >
> > > > > > Thank you for doing this series - it all looks pretty good from my
> > > > > > side and I've applied it experimentally to tip:x86/asm. I fixed up
> > > > > > the trivial details other reviewers and me noticed.
> > > > > >
> > > > > > Note that the merge is tentative, it might still need a rebase if
> > > > > > some fundamental problem comes up - but let's see how testing goes
> > > > > > in -next.
> > > > >
> > > > > I wonder if there would be any benefit if stack canary is put into
> > > > > struct pcpu_hot?
> > > >
> > > > It should definitely be one of the hottest data structures on x86, so
> > > > moving it there makes sense even if it cannot be measured explicitly.
> > > >
> > >
> > > It would have to be done with linker tricks, since you can't make the
> > > compiler use a struct member directly.
> >
> > Probably not worth it then?
> 
> Actually it wasn't so bad since we already had the hack for 
> __ref_stack_chk_guard.  Do you want the patches now or when the dust 
> settles on the original series?

We can add it now I suppose, while memories are fresh and all that.

Thanks,

	Ingo

