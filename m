Return-Path: <linux-kernel+bounces-275424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A66948572
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 00:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E4C284565
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 22:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2430A42A9F;
	Mon,  5 Aug 2024 22:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WkLb23p5"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE47149C79
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 22:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722897026; cv=none; b=cJpgRmIZU7BNlgXEfJAkQnyx7WnYZPTdg6iHxr3vM4JKBHz6spgg2mx1P/+emzgcn4a0BJKlck1QfaHcYiJjn4O7u0sb6vgI292icRvGtu2g/Qm7mceTIA9eg9Wt+L9xv+W0F+H1ct1ls7z9pK2nZjJgnlKf1R32isC6USoIMVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722897026; c=relaxed/simple;
	bh=0ARNQGqHsG9I4aK9Z/eHQCbSU/itDA0Iny/P5KHFuCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okZVXOl9wRE93uMEKEOxYG9Kf48ABLEkAS3tJSeVPJ8nSejJVDb41P5GGbYhSEe2jdLFYte9QaC9hr7NnH0l2ByYV/DNhc9MJnMFTSd5p6FjG+/srnNSnEXdo2nYkr/utCjUY1zH6tNdUCrQl2ZQAwvMqcfeEY3HWW715VEqQyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WkLb23p5; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 5 Aug 2024 16:30:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722897021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9+xslIh9ZUCjgHn7WqNCtf6wIJItqzB2ESZrMWt5fco=;
	b=WkLb23p5QFMSj0S6onm/Rgoc1L/KexZ6QAuv4UZxrKwlMym4rd9hoJMVXwqWbh/yh858O5
	TFU45s/uIBM7mqqU91vPp+YMNLfvzRobXTWLEwIWtETd2YFyRO3LuBPxtm/X/nWm5KQObs
	eq3IfZJnb761oh6Ifupjkma5BHwehzw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jose Fernandez <jose.fernandez@linux.dev>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Christian Heusel <christian@heusel.eu>, Peter Jung <ptr1337@cachyos.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: control extra pacman packages with
 PACMAN_EXTRAPACKAGES
Message-ID: <g5jex6hwlsjwzryo5umw44uotww54h6ccjzzqk3fao5k3ig7df@yg2vhcxr5t6s>
References: <20240804000130.841636-1-jose.fernandez@linux.dev>
 <c41e3856-29f4-438f-a796-43aa957215d1@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c41e3856-29f4-438f-a796-43aa957215d1@t-8ch.de>
X-Migadu-Flow: FLOW_OUT

On 24/08/05 04:01PM, Thomas Weißschuh wrote:
> > This changes the behavior of the pacman-pkg target to only create the
> > main kernel package by default. The rest of the packages will be opt-in
> > going forward.
> 
> I had the impression that by default all extrapackages should be
> built. The variable can then be used by expert users where needed.
> Other Opinions?

I think switching to defaulting to all packages is a good idea. One concern I 
had was how regular users would discover the customization options. Expert users
will likely look at the Makefile and figure out how to opt out.

I will plan to make this change for v2 unless there are any objections.
 
> > In a previous patch, there was concern that adding a new debug package
> > would increase the package time. To address this concern and provide
> > more flexibility, this change has been added to allow users to decide
> > which extra packages to include before introducing an optional debug
> > package [1].
> 
> This paragraph seems like it shouldn't be part of the final commit.
> If you put it after a line with "---" it will be dropped from the
> commit, like so:
> 
> ---
> 
> In a previous patch, ...

Agreed, I will move this paragraph to below --- for v2.

> 
> > 
> > [1] https://lore.kernel.org/lkml/20240801192008.GA3923315@thelio-3990X/T/
> > 
> > Signed-off-by: Jose Fernandez <jose.fernandez@linux.dev>
> > Reviewed-by: Peter Jung <ptr1337@cachyos.org>
> > ---
> >  scripts/Makefile.package |  5 +++++
> >  scripts/package/PKGBUILD | 11 ++++++++---
> >  2 files changed, 13 insertions(+), 3 deletions(-)
> > 
> > diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> > index 4a80584ec771..146e828cb4f1 100644
> > --- a/scripts/Makefile.package
> > +++ b/scripts/Makefile.package
> > @@ -144,6 +144,10 @@ snap-pkg:
> >  # pacman-pkg
> >  # ---------------------------------------------------------------------------
> >  
> > +# Space-separated list of extra packages to build
> > +# The available extra packages are: headers api-headers
> > +PACMAN_EXTRAPACKAGES ?=
> 
> The assignment doesn't do anything.
> Do we need the documentation if the default enables all subpackages?
> 
> > +
> >  PHONY += pacman-pkg
> >  pacman-pkg:
> >  	@ln -srf $(srctree)/scripts/package/PKGBUILD $(objtree)/PKGBUILD
> > @@ -152,6 +156,7 @@ pacman-pkg:
> >  		CARCH="$(UTS_MACHINE)" \
> >  		KBUILD_MAKEFLAGS="$(MAKEFLAGS)" \
> >  		KBUILD_REVISION="$(shell $(srctree)/scripts/build-version)" \
> > +		PACMAN_EXTRAPACKAGES="$(PACMAN_EXTRAPACKAGES)" \
> 
> This line is superfluous.

Ack.

> >  		makepkg $(MAKEPKGOPTS)
> >  
> >  # dir-pkg tar*-pkg - tarball targets
> > diff --git a/scripts/package/PKGBUILD b/scripts/package/PKGBUILD
> > index 663ce300dd06..41bd0d387f0a 100644
> > --- a/scripts/package/PKGBUILD
> > +++ b/scripts/package/PKGBUILD
> > @@ -3,10 +3,15 @@
> >  # Contributor: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
> >  
> >  pkgbase=${PACMAN_PKGBASE:-linux-upstream}
> > -pkgname=("${pkgbase}" "${pkgbase}-api-headers")
> > -if grep -q CONFIG_MODULES=y include/config/auto.conf; then
> > -	pkgname+=("${pkgbase}-headers")
> > +pkgname=("${pkgbase}")
> > +
> > +_extrapackages=${PACMAN_EXTRAPACKAGES:-}
> > +if [ -n "$_extrapackages" ]; then
> 
> No need for this check. The loop over an empty variable work fine.

Ack. Will update in v2.
 
> > +	for pkg in $_extrapackages; do
> > +		pkgname+=("${pkgbase}-$pkg")
> 
> Use consistent variable references: "${pkgbase}-${pkg}"

Ack. Will update in v2.

> > +	done
> >  fi
> > +
> >  pkgver="${KERNELRELEASE//-/_}"
> >  # The PKGBUILD is evaluated multiple times.
> >  # Running scripts/build-version from here would introduce inconsistencies.
> > -- 
> > 2.46.0
> > 

