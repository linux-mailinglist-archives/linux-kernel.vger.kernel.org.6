Return-Path: <linux-kernel+bounces-213035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69739906A30
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D68281398
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F750142629;
	Thu, 13 Jun 2024 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="T+QdX+xw"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14CD13D52C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718275241; cv=none; b=pX5hiwd0y2OWt1mAX0Y7YUDxhlIf0PvncXqWKaS1IKWm7jrQ3h40VQaKGX2NfI0Guje9xJEE6DJQWA3KL1x1Im9aag8hCL8QpG1m87OU6tcZS+r42dj0TPbXVBJLfYvLFCNNI5MWbUHwRp29VYjG/IqdNe/xyltTiMeYmwietcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718275241; c=relaxed/simple;
	bh=Bs89R5sWSYZtkWq46T7sthGT/1Pm15bd/J1IwKhrpmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfYSCemXmh3vOPThdj9E1lcYkDoMng+bQ7pjG7kVkHdC/2BM9Vq3/ipZnGmycx1JNXDYVoSpglsAKGB+irHfrEGC4KF9W/ZIitSgtNAVI5TB40Nb5dzOv/0mO7NB2ijpb30CGsFbGnUxBnfrr8uTdRFlauMdLP+i/Ih1ximJqfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=T+QdX+xw; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 743B41C0082; Thu, 13 Jun 2024 12:40:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1718275236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rdwDKat4rY6vAEhgvXDR7uYooA3dxPXFWsli39Ga3U8=;
	b=T+QdX+xwwvvEaDbnMdKboBRPEtctJZMMzkOry+XCoEUys/nI7Ho7eY2+FlOwxUMXGhNuaC
	XH2ew+tRqmt/yJioJLNP+f9Gt+hY9S30H6aCLbYPks9bgFZgh1FyqtUCQ8F33Ho1reIeSL
	I+wphBzyvqZoWTNTcf0rhSmYwBvurJ8=
Date: Thu, 13 Jun 2024 12:40:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lee Jones <lee@kernel.org>, Michal Hocko <mhocko@suse.com>,
	cve@kernel.org, linux-kernel@vger.kernel.org,
	Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: CVE-2024-26628: drm/amdkfd: Fix lock dependency warning
Message-ID: <ZmrMo6qFbt9/3xoh@duo.ucw.cz>
References: <2024030649-CVE-2024-26628-f6ce@gregkh>
 <Zerheyn-4rB5kySt@tiehlicka>
 <20240314110938.GM1522089@google.com>
 <ZfsBpal_29lihveI@tiehlicka>
 <20240320154734.GU1522089@google.com>
 <Zmq8uSVv0X5f7xx+@duo.ucw.cz>
 <2024061335-wistful-brownnose-28ea@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RCtKJrnph7EDJ8d5"
Content-Disposition: inline
In-Reply-To: <2024061335-wistful-brownnose-28ea@gregkh>


--RCtKJrnph7EDJ8d5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2024-06-13 12:16:50, Greg Kroah-Hartman wrote:
> On Thu, Jun 13, 2024 at 11:32:41AM +0200, Pavel Machek wrote:
> > On Wed 2024-03-20 15:47:34, Lee Jones wrote:
> > > On Wed, 20 Mar 2024, Michal Hocko wrote:
> > >=20
> > > > On Thu 14-03-24 11:09:38, Lee Jones wrote:
> > > > > On Fri, 08 Mar 2024, Michal Hocko wrote:
> > > > >=20
> > > > > > On Wed 06-03-24 06:46:11, Greg KH wrote:
> > > > > > [...]
> > > > > > >  Possible unsafe locking scenario:
> > > > > > >=20
> > > > > > >        CPU0                    CPU1
> > > > > > >        ----                    ----
> > > > > > >   lock(&svms->lock);
> > > > > > >                                lock(&mm->mmap_lock);
> > > > > > >                                lock(&svms->lock);
> > > > > > >   lock((work_completion)(&svm_bo->eviction_work));
> > > > > > >=20
> > > > > > > I believe this cannot really lead to a deadlock in practice, =
because
> > > > > > > svm_range_evict_svm_bo_worker only takes the mmap_read_lock i=
f the BO
> > > > > > > refcount is non-0. That means it's impossible that svm_range_=
bo_release
> > > > > > > is running concurrently. However, there is no good way to ann=
otate this.
> > > > > >=20
> > > > > > OK, so is this even a bug (not to mention a security/weakness)?
> > > > >=20
> > > > > Looks like the patch fixes a warning which can crash some kernels=
=2E  So
> > > > > the CVE appears to be fixing that, rather than the impossible dea=
dlock.
> > > >=20
> > > > Are you talking about lockdep warning or anything else?
> > >=20
> > > Anything that triggers a BUG() or a WARN() (as per the splat in the
> > > commit message).  Many in-field kernels are configured to panic on
> > > BUG()s and WARN()s, thus triggering them are presently considered loc=
al
> > > DoS and attract CVE status.
> >=20
> > So... because it is possible to configure machine to reboot on
> > warning, now every warning is a security issue?
> >=20
> > Lockdep is for debugging, if someone uses it in production with panic
> > on reboot, they are getting exactly what they are asking for.
> >=20
> > Not a security problem.
>=20
> And we agree, I don't know what you are arguing about here, please stop.

So you agree that WARN triggering randomly is not a security problem?

Following communication did not say so.

"The splat in the circular lockdep detection code appears to be generated
using some stacked pr_warn() calls, rather than a WARN()."
									Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--RCtKJrnph7EDJ8d5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iFwEABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZmrMowAKCRAw5/Bqldv6
8lOqAJ9kIJEoValBhzltSz8+HDqLt8HMwwCYki88XtE78uDyhYE6dZhwtsVtoA==
=v6f8
-----END PGP SIGNATURE-----

--RCtKJrnph7EDJ8d5--

