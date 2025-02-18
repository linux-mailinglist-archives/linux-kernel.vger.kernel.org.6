Return-Path: <linux-kernel+bounces-520000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ECBA3A491
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DCB716C3AD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39B4270EA0;
	Tue, 18 Feb 2025 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcZl0u26"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE2C26FDA3;
	Tue, 18 Feb 2025 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739900794; cv=none; b=AZca3zoeP2wj+2/0NIPWXrhvMZ7GEqHwGJmMMCWrRHkBFliqFK+Y3Ej3D3sDCNUK3Us+j89J0EEg3Jgf1WoMghSIyAR6QAGuMTxwJ+pRYFhxrYZ7h3/wCd2ZT7RVvAlzJfE3y1thCI0PZmurUJ9zc/IyAjAe345iL5/uj+W/fXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739900794; c=relaxed/simple;
	bh=WtWSTY4KUqUInfseAlQ/D+r84OfJQRXQPKA1eO1u7i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QyXsR+B5suCV3LQpHSOg4wOcwdTOxv5l73eRKKp4HawFfAR4na48siJtpchJAy/N8VKSm9xGfhUtUnrs+ERx+ye3PyfRkasAyB2nk9u4TDVdWCKzwPtOBLPrd8mPv36wLjPsP31kGJlHB+CzM/tbCN0BHZyFUdM2thpx7+CymmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcZl0u26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06C6C4CEE2;
	Tue, 18 Feb 2025 17:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739900793;
	bh=WtWSTY4KUqUInfseAlQ/D+r84OfJQRXQPKA1eO1u7i4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OcZl0u26cGvdvoAQDFz9Vx4rhUfeN4rUmdvqMLlLoW18qSQxYa88QVnWvrgl7uxqj
	 f0l8eMRxNLRJRkAinlBNtSbn42NTX3HUB4skUC7h/1GKSJXmy4gCOKzoPJ7YS59mRT
	 uhtRR/8jD5A8gog0e/Yw372SCdTkrY+MKRYSJWxsNn8vh25VH4yOTRx1p+o/yxA7tP
	 +2iDnv4I8oBU4lDlz7ZaeD8HzUkamaSqEAgMVG6QZEZpOxqNWt9HAqKrKXhXojeyNp
	 vALx1aFSlkkPsLJ2DdxfzLz0BCdgTrHvOBGqoeNvyWSk23fSX3w3FDTgwd4WXZXh+h
	 S3+H//3LpjqoQ==
Date: Tue, 18 Feb 2025 09:46:32 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>,
	Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
	amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/9] Add jump table support for objtool on LoongArch
Message-ID: <20250218174632.gwseuvgezj7eni2j@jpoimboe>
References: <20241217010905.13054-1-yangtiezhu@loongson.cn>
 <ef1e3e7c-0117-175c-5a85-091382696748@loongson.cn>
 <20250115013444.anzoct6gvs56m225@jpoimboe>
 <4612bfd8-442e-fecb-240f-46e735b48540@loongson.cn>
 <20250210212653.oidcl4aqyrcu3yzi@jpoimboe>
 <CAAhV-H7MVDj0CbXfwveb7GDn+D=O4N6oUT6rpGrbGmYPLPpRPg@mail.gmail.com>
 <20250211233056.q47mp5askk7qrxcp@jpoimboe>
 <CAAhV-H563HcK2bck2k+VLTvrf0C7=cEMr8BJpQhFdJNc+dFOUw@mail.gmail.com>
 <20250213025108.svqgj5nzseqs6qox@jpoimboe>
 <CAAhV-H5mYGnxHPxAeXkHo2XBvi-RtPjDQRBnDiDyKVtFv-ZBBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H5mYGnxHPxAeXkHo2XBvi-RtPjDQRBnDiDyKVtFv-ZBBQ@mail.gmail.com>

On Mon, Feb 17, 2025 at 11:13:43AM +0800, Huacai Chen wrote:
> On Thu, Feb 13, 2025 at 10:51 AM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > On Wed, Feb 12, 2025 at 03:22:45PM +0800, Huacai Chen wrote:
> > > > The new series now has 7 patches:
> > > >
> > > > Tiezhu Yang (7):
> > > >   objtool: Handle various symbol types of rodata
> > > >   objtool: Handle different entry size of rodata
> > > >   objtool: Handle PC relative relocation type
> > > >   objtool/LoongArch: Add support for switch table
> > > >   objtool/LoongArch: Add support for goto table
> > > >   LoongArch: Enable jump table for objtool
> > > >   LoongArch: Convert unreachable() to BUG()
> > > >
> > > > I was planning on queueing all 7.
> > > >
> > > > In particular, patch 6 should stay with the objtool patches since
> > > > they're directly related.
> > > >
> > > > But I was also just going to grab 7 as well.
> > > >
> > > > Please let me know if you disagree.
> > > What about you merge the first 5 patches, and then I merge the last 2
> > > to the loongarch tree? (I prefer to merge the whole series to the
> > > loongarch tree with your acked-by, but that may be inconvenient to
> > > you).
> >
> > I want the first 5 patches to go through the -tip tree because we'll
> > have other patches depending on them.
> >
> > I'll go ahead and take the first 5.
> >
> > If you take in patches 6 & 7 separately, that might introduce a lot of
> > warnings.  But it's up to you.
> >
> > For patches 6 & 7:
> >
> > Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
> OK, please take the first 5 patches, I will merge your objtool/core to
> the loongarch tree and then apply the last 2 to avoid build warnings.

Looks like that's not going to work.  Without patch 7 I'm getting a
warning (upgraded to a build error with a pending change to upgrade
objtool warnings to errors):

arch/loongarch/kernel/machine_kexec.o: error: objtool: kexec_reboot() falls through to next function crash_shutdown_secondary()
arch/loongarch/kernel/machine_kexec.o: error: objtool:   kexec_reboot+0x1c: (branch)
arch/loongarch/kernel/machine_kexec.o: error: objtool:   kexec_reboot+0x0: <=== (sym)
arch/loongarch/kernel/machine_kexec.o: error: objtool: 1 warning(s) upgraded to errors

And that would break bisection anyway, so that really needs to come
before the others.

-- 
Josh

