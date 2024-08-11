Return-Path: <linux-kernel+bounces-282376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D929A94E300
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 22:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94E10281A60
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 20:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85669157A4D;
	Sun, 11 Aug 2024 20:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dbmA9461"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288791798C
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 20:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723409210; cv=none; b=lLaGbqxs65a5xPpxQ2OaKBLEhvPa1vZVZJw1FVKK+BokNKSb7NgEQloDzNzo3hLdTdm1pKM2MLfasYbaE8pYfl+LBEbny3kZJJToxm2hjCvdLQRpRRf8UfriSO+OIHzoJ/FeokaKU3OcC8RJTDnGK55n5EZ+xSY0fxTTLfRJoDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723409210; c=relaxed/simple;
	bh=8HOrcd3rmFhcJWXKJhZg0i7YnSBkyGwC4lfXgvOunj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOOcDlIwXfHQTbYPmCP0YBK6I+mz8U+UGccX01bV4dcYNMuxAktRda9ZJg48YFIevj6zs/AN10qdIfOWQletfi7UUZjPP4DKVx3ERziQSf8NwDTvzchV12yv2A8ql0KnTQTN086d6udmGzIn4Sh50C8J/dzvE+jbrCYnW3zjlrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dbmA9461; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 11 Aug 2024 14:46:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723409204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E3sZQz6AplYxGQjfc6fNqrCt2rn+D5lHIxZl2vw26Rk=;
	b=dbmA9461kiRz14cOI8QWprzfhj2avuKniqc2h9Z+S7zH61pGypfioMODJIMqDBgLrm25VW
	wBvgARWMORO8vo7bavsPunJ91AaKdC/aFLgrIS0k2ZoTCCSIaMcCFn8hz7VlWU6RRBo9HR
	mm97yMDWkUU8k/mmIbB+otBEUZeV7fA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jose Fernandez <jose.fernandez@linux.dev>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Christian Heusel <christian@heusel.eu>, Peter Jung <ptr1337@cachyos.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kbuild: control extra pacman packages with
 PACMAN_EXTRAPACKAGES
Message-ID: <un2bi7rsfa7nwrqqtgbzd2nefhohuvglup6lpd5ncdklndisl3@vdo2nkgmuyoq>
References: <20240807022718.24838-2-jose.fernandez@linux.dev>
 <CAK7LNAS4t_naRxdxFTaj9zrdf2Hjjoaq+cBO4Gx7=PhCJk9+4w@mail.gmail.com>
 <f65f1d49-8c6f-45e9-a4b2-30d4cfff10b1@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f65f1d49-8c6f-45e9-a4b2-30d4cfff10b1@t-8ch.de>
X-Migadu-Flow: FLOW_OUT

On 24/08/07 06:40PM, Thomas Weiﬂschuh wrote:
<snip>
> > > +
> > >  PHONY += pacman-pkg
> > >  pacman-pkg:
> > >         @ln -srf $(srctree)/scripts/package/PKGBUILD $(objtree)/PKGBUILD
> > > diff --git a/scripts/package/PKGBUILD b/scripts/package/PKGBUILD
> > > index 663ce300dd06..8de869f9b1d4 100644
> > > --- a/scripts/package/PKGBUILD
> > > +++ b/scripts/package/PKGBUILD
> > > @@ -3,10 +3,13 @@
> > >  # Contributor: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
> > >
> > >  pkgbase=${PACMAN_PKGBASE:-linux-upstream}
> > > -pkgname=("${pkgbase}" "${pkgbase}-api-headers")
> > > -if grep -q CONFIG_MODULES=y include/config/auto.conf; then
> > > -       pkgname+=("${pkgbase}-headers")
> > > -fi
> > > +pkgname=("${pkgbase}")
> > > +
> > > +_extrapackages=${PACMAN_EXTRAPACKAGES:-}
> > 
> > 
> > Instead of adding inconsistent defaults in two places,
> > I would write like this:
> > 
> > _extrapackages=${PACMAN_EXTRAPACKAGES-headers api-headers}
> 
> Agreed.
> 

Closing the loop on this topic. I removed all changes made to Makefile.package
and set the default in PKGBUILD as suggested:

 _extrapackages=${PACMAN_EXTRAPACKAGES-headers api-headers}

Running the pacman-pkg target without setting PACMAN_EXTRAPACKAGES will build
all packages:

make pacman-pkg
...
==> Creating package "linux-upstream"...
...
==> Creating package "linux-upstream-headers"...
...
==> Creating package "linux-upstream-api-headers"...

Setting PACMAN_EXTRAPACKAGES to an empty value will build only the kernel
package:

make pacman-pkg PACMAN_EXTRAPACKAGES=""
objtree="/home/jose/Code/linux/linux" \
	BUILDDIR="/home/jose/Code/linux/linux/pacman" \
	CARCH="i386" \
	KBUILD_MAKEFLAGS="rR --no-print-directory -- PACMAN_EXTRAPACKAGES=" \
	KBUILD_REVISION="46" \
	makepkg 
...
==> Creating package "linux-upstream"...
  -> Generating .PKGINFO file...
  -> Generating .BUILDINFO file...
  -> Generating .MTREE file...
  -> Compressing package...
==> Leaving fakeroot environment.
==> Finished making: linux-upstream 6.11.0_rc2+-46 (Sun 11 Aug 2024 01:13:45 PM MDT)

Make exports command line arguments as env variables to sub-processes and this
is how the PACMAN_EXTRAPACKAGES is passed to makepg without an explicit export
with this change. V3 will include this change.

