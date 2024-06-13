Return-Path: <linux-kernel+bounces-212954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DC29068C7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7786B1C241C8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D25D13E04D;
	Thu, 13 Jun 2024 09:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="lRDkYfM+"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A165B84D03
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718271172; cv=none; b=FTgbPEWzMzFuhNh/abcgneKJetQusFCtZTDPzH1lDA7+mwstzBaZ0EysFis7tumayGcU4D1qJWJ5qVddwDNHdInEc+tJ6s9aI7Wn7XenpJqISWsnFspoE0ZtdDBR+10eqnD2h/8WVgQJF26AS3friRl8G+KVKS0UCOQnm9X3LyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718271172; c=relaxed/simple;
	bh=B5Cd3cqeecn0eaJdHT1dMZ1sD5+PK9hGkwmcXGO58Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYOj4XMnxQ7KgKT3uV6ed3sm+jwGz0m6/koeOmz9owUe4ooj9Eh1XBqJx9LJmc5Hrf4Y+xrmV3sJxJwTlpRfIuKIUiwKxWngOgdtl5ufuYebT7cgR9WCCTQP9hvVsAtd6Sb7znkkpETOd2jIPYsMz2ZOibQf7A85tA3BTZkHBIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=lRDkYfM+; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id CE7971C0082; Thu, 13 Jun 2024 11:32:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1718271161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oHev/tDi4ksrZ+3x6gweRbnBPsXj/+4uyOtcGRfRTXc=;
	b=lRDkYfM+U019hPwcPPvOVfIt498rMdJnLWNyH1gpHZpfRbLTyV/Lctm11bExNjlPgTOOzr
	sbJxPMUopVJFzbmUlyoxkbGQ39GfiInsQBken8eiSjl6SvMmlmHv/vC5he6/5ZW32LEr/N
	WuPZ4OAhunwhTJOrtOtcU9uWIIx9Zqs=
Date: Thu, 13 Jun 2024 11:32:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Lee Jones <lee@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>, cve@kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: CVE-2024-26628: drm/amdkfd: Fix lock dependency warning
Message-ID: <Zmq8uSVv0X5f7xx+@duo.ucw.cz>
References: <2024030649-CVE-2024-26628-f6ce@gregkh>
 <Zerheyn-4rB5kySt@tiehlicka>
 <20240314110938.GM1522089@google.com>
 <ZfsBpal_29lihveI@tiehlicka>
 <20240320154734.GU1522089@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="210OJhfsyvcl1VHN"
Content-Disposition: inline
In-Reply-To: <20240320154734.GU1522089@google.com>


--210OJhfsyvcl1VHN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2024-03-20 15:47:34, Lee Jones wrote:
> On Wed, 20 Mar 2024, Michal Hocko wrote:
>=20
> > On Thu 14-03-24 11:09:38, Lee Jones wrote:
> > > On Fri, 08 Mar 2024, Michal Hocko wrote:
> > >=20
> > > > On Wed 06-03-24 06:46:11, Greg KH wrote:
> > > > [...]
> > > > >  Possible unsafe locking scenario:
> > > > >=20
> > > > >        CPU0                    CPU1
> > > > >        ----                    ----
> > > > >   lock(&svms->lock);
> > > > >                                lock(&mm->mmap_lock);
> > > > >                                lock(&svms->lock);
> > > > >   lock((work_completion)(&svm_bo->eviction_work));
> > > > >=20
> > > > > I believe this cannot really lead to a deadlock in practice, beca=
use
> > > > > svm_range_evict_svm_bo_worker only takes the mmap_read_lock if th=
e BO
> > > > > refcount is non-0. That means it's impossible that svm_range_bo_r=
elease
> > > > > is running concurrently. However, there is no good way to annotat=
e this.
> > > >=20
> > > > OK, so is this even a bug (not to mention a security/weakness)?
> > >=20
> > > Looks like the patch fixes a warning which can crash some kernels.  So
> > > the CVE appears to be fixing that, rather than the impossible deadloc=
k.
> >=20
> > Are you talking about lockdep warning or anything else?
>=20
> Anything that triggers a BUG() or a WARN() (as per the splat in the
> commit message).  Many in-field kernels are configured to panic on
> BUG()s and WARN()s, thus triggering them are presently considered local
> DoS and attract CVE status.

So... because it is possible to configure machine to reboot on
warning, now every warning is a security issue?

Lockdep is for debugging, if someone uses it in production with panic
on reboot, they are getting exactly what they are asking for.

Not a security problem.
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--210OJhfsyvcl1VHN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZmq8uQAKCRAw5/Bqldv6
8gdkAJwMHfejOxf/mcV1y4L8XZCmnaDjPQCgrsTdi2mc2irA3ssncwxpSA+R7KI=
=6oKV
-----END PGP SIGNATURE-----

--210OJhfsyvcl1VHN--

