Return-Path: <linux-kernel+bounces-275641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 458E19487E9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 05:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50901F231AA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 03:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E94E58AD0;
	Tue,  6 Aug 2024 03:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nub6Cn92"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B491A43ABC
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 03:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722914831; cv=none; b=mgNM+DwhL9bWGtYzEwNJ2bv6tG0aaJtlCakU0RSTt+vHpJMIvIVUnfsuTbZ8M3hQJcKhLpS3/iUufy50BNK58lmX8m47Ynpv5Zti952hP/biYSHlWcwP6sbmtcT30s8mDuYftZweUVDTg1KT60NwPV96xx4q6OkXYInp59B4Xns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722914831; c=relaxed/simple;
	bh=OnuEf1n44ynY7vh2ncFDoC9pLo9+YMqsxh8yoxz0U00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJhmGcaAb86z0SgAxT5hg7nuqqYlHtK9HfJbeRUf+PpF6hKSO7c6IDNF9jNgkceCgC6gmHzYGBWY98TOSKvjqAIDz6K9bfad70L5bRF+bma4Ju8Yo7I8J4/1J4HrY+SQXcStMjHC8i2IcQUmvjGBUDxZ2AsByWybPjOVOeT2bTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nub6Cn92; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 5 Aug 2024 21:26:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722914823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vowwqyn+x5QwA/BF09y5QtbCMUxlKjhdNwTKjuKKNDQ=;
	b=nub6Cn92YeGIK/u0ghcrcXaFjjcBJojYaOUzNOZZyOQ+LFGvdG29yhx/Tr+J6hwiN9wd9B
	vZWbVb2OM7qAOjMnMIvfKbUA26z4hzu72bH1oThIo6RPZQuBN6bmULWw2ynPyFLw+hVbrr
	XilwfsOMp3rXu30XvAYcklHomin8Pfk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jose Fernandez <jose.fernandez@linux.dev>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Christian Heusel <christian@heusel.eu>, Peter Jung <ptr1337@cachyos.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: control extra pacman packages with
 PACMAN_EXTRAPACKAGES
Message-ID: <odiitinwxck2dc6jori4iakp6hwqnnguk2ar6dvmbo6ugrt7nz@h65drwkv374s>
References: <20240804000130.841636-1-jose.fernandez@linux.dev>
 <c41e3856-29f4-438f-a796-43aa957215d1@t-8ch.de>
 <g5jex6hwlsjwzryo5umw44uotww54h6ccjzzqk3fao5k3ig7df@yg2vhcxr5t6s>
 <20240806025853.GB1570554@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240806025853.GB1570554@thelio-3990X>
X-Migadu-Flow: FLOW_OUT

On 24/08/05 07:58PM, Nathan Chancellor wrote:
> On Mon, Aug 05, 2024 at 04:30:15PM -0600, Jose Fernandez wrote:
> > On 24/08/05 04:01PM, Thomas Weißschuh wrote:
> > > > This changes the behavior of the pacman-pkg target to only create the
> > > > main kernel package by default. The rest of the packages will be opt-in
> > > > going forward.
> > > 
> > > I had the impression that by default all extrapackages should be
> > > built. The variable can then be used by expert users where needed.
> > > Other Opinions?
> > 
> > I think switching to defaulting to all packages is a good idea. One concern I 
> > had was how regular users would discover the customization options. Expert users
> > will likely look at the Makefile and figure out how to opt out.
> 
> I think that most users will likely want all of the packages built by
> default. I think leaving this to be discovered by power users in the
> Makefile is reasonable.

Sounds good!

> > > > In a previous patch, there was concern that adding a new debug package
> > > > would increase t.he package time. To address this concern and provide
> > > > more flexibility, this change has been added to allow users to decide
> > > > which extra packages to include before introducing an optional debug
> > > > package [1].
> > > 
> > > This paragraph seems like it shouldn't be part of the final commit.
> > > If you put it after a line with "---" it will be dropped from the
> > > commit, like so:
> > > 
> > > ---
> > > 
> > > In a previous patch, ...
> > 
> > Agreed, I will move this paragraph to below --- for v2.
> > 
> > > 
> > > > 
> > > > [1] https://lore.kernel.org/lkml/20240801192008.GA3923315@thelio-3990X/T/
> > > > 
> > > > Signed-off-by: Jose Fernandez <jose.fernandez@linux.dev>
> > > > Reviewed-by: Peter Jung <ptr1337@cachyos.org>
> > > > ---
> > > >  scripts/Makefile.package |  5 +++++
> > > >  scripts/package/PKGBUILD | 11 ++++++++---
> > > >  2 files changed, 13 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> > > > index 4a80584ec771..146e828cb4f1 100644
> > > > --- a/scripts/Makefile.package
> > > > +++ b/scripts/Makefile.package
> > > > @@ -144,6 +144,10 @@ snap-pkg:
> > > >  # pacman-pkg
> > > >  # ---------------------------------------------------------------------------
> > > >  
> > > > +# Space-separated list of extra packages to build
> > > > +# The available extra packages are: headers api-headers
> > > > +PACMAN_EXTRAPACKAGES ?=
> > > 
> > > The assignment doesn't do anything.
> > > Do we need the documentation if the default enables all subpackages?
> > > 
> > > > +
> > > >  PHONY += pacman-pkg
> > > >  pacman-pkg:
> > > >  	@ln -srf $(srctree)/scripts/package/PKGBUILD $(objtree)/PKGBUILD
> > > > @@ -152,6 +156,7 @@ pacman-pkg:
> > > >  		CARCH="$(UTS_MACHINE)" \
> > > >  		KBUILD_MAKEFLAGS="$(MAKEFLAGS)" \
> > > >  		KBUILD_REVISION="$(shell $(srctree)/scripts/build-version)" \
> > > > +		PACMAN_EXTRAPACKAGES="$(PACMAN_EXTRAPACKAGES)" \
> > > 
> > > This line is superfluous.
> > 
> > Ack.
> 
> Is it superfluous if PACMAN_EXTRAPACKAGES is not exported to makepkg? If
> I remove this while changing the default of PACMAN_EXTRAPACKAGES in
> scripts/Makefile.package, its value is not visible in makepkg, so only
> the default package gets built. I think
> 
>   export PACMAN_EXTRAPACKAGES
> 
> is needed after the '?=' assignment line.

Nathan, I removed the line and it appears to work as expected.

If I set the default packages to:

PACMAN_EXTRAPACKAGES ?= headers api-headers

Then any of these commands builds only the main kernel package:

make pacman-pkg PACMAN_EXTRAPACKAGES=
make pacman-pkg PACMAN_EXTRAPACKAGES=""

This command builds the main package + headers package:

make pacman-pkg PACMAN_EXTRAPACKAGES="headers"

I'm not quite sure how PACMAN_EXTRAPACKAGES makes it to makepkg without that
line. But it appears like it does.

> 
> > > >  		makepkg $(MAKEPKGOPTS)
> > > >  
> > > >  # dir-pkg tar*-pkg - tarball targets
> > > > diff --git a/scripts/package/PKGBUILD b/scripts/package/PKGBUILD
> > > > index 663ce300dd06..41bd0d387f0a 100644
> > > > --- a/scripts/package/PKGBUILD
> > > > +++ b/scripts/package/PKGBUILD
> > > > @@ -3,10 +3,15 @@
> > > >  # Contributor: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
> > > >  
> > > >  pkgbase=${PACMAN_PKGBASE:-linux-upstream}
> > > > -pkgname=("${pkgbase}" "${pkgbase}-api-headers")
> > > > -if grep -q CONFIG_MODULES=y include/config/auto.conf; then
> > > > -	pkgname+=("${pkgbase}-headers")
> > > > +pkgname=("${pkgbase}")
> > > > +
> > > > +_extrapackages=${PACMAN_EXTRAPACKAGES:-}
> > > > +if [ -n "$_extrapackages" ]; then
> > > 
> > > No need for this check. The loop over an empty variable work fine.
> > 
> > Ack. Will update in v2.
> >  
> > > > +	for pkg in $_extrapackages; do
> > > > +		pkgname+=("${pkgbase}-$pkg")
> > > 
> > > Use consistent variable references: "${pkgbase}-${pkg}"
> > 
> > Ack. Will update in v2.
> > 
> > > > +	done
> > > >  fi
> > > > +
> > > >  pkgver="${KERNELRELEASE//-/_}"
> > > >  # The PKGBUILD is evaluated multiple times.
> > > >  # Running scripts/build-version from here would introduce inconsistencies.
> > > > -- 
> > > > 2.46.0
> > > > 

