Return-Path: <linux-kernel+bounces-213748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 272629079D6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A466FB24441
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51F714A0B6;
	Thu, 13 Jun 2024 17:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6HZE6tS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DA314A0A8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 17:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718299710; cv=none; b=CWqGAKKqmMSk13ZpmBzh8Osldq8VP+0sZuQR7bH7y3pD0bIicqnXBWfcO5QnCrXd3aQ09U4aopqbaBbAkhaEa1/aiaJ1gOU2AOlBKclCulkC/3i4mj7q4bU62nO1sUAXMaEKWnZjIRMDqdsTEPF2FPqYpqQO6QrpzvXNp7su6sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718299710; c=relaxed/simple;
	bh=QDAVq3HvuBQigwxCCl2Vy0xixFerZ7QHysFs+R596bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvHmRB2Ib4JOeqRx6V/fr8U+UUVOr8dcsU0O1UBWxHi2zzZ4myvrAfPY+ZxCQnbRbc7pUtqesZdiOYPbSazGJiOeKXeG00abrjqFkmNmDdr5Gsy8smQasop0qsEcqJEM5aTOgPFvUdosZkPxAblQxexnObp7cj3FzM0W8axxI1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6HZE6tS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B83C2BBFC;
	Thu, 13 Jun 2024 17:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718299709;
	bh=QDAVq3HvuBQigwxCCl2Vy0xixFerZ7QHysFs+R596bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N6HZE6tSlcqrQhJyQ6962jv0w9Xk9FjcjJ3a1bmD4Dhd9yWyGYqA05vWrRvPiqLVg
	 ekMVlrK6jcrEVbJE3gb4Oc3ldV30Y7l5uyMyMTDqSQahnGnfcEWV7DFy/INJrt3c77
	 5R0ivi0EWojkyyUxxX2TADmKH5CQRWohRrC9BMOLA2P0L7QW7xEad1rym4bIFdTi+2
	 AeDvYGyYL8gBuJS81ETZWaW82zrsWzuMBbs8iAqVaowFhnAVe9+nEgW4hYUK3nLQxY
	 vMGtQHqT28s6J+sioji184j92x602uNqV7iEujdowMi7vszTliw+T29M3j0WHR5b5i
	 zRKWQNiAbgufA==
Date: Thu, 13 Jun 2024 19:28:26 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, airlied@gmail.com, daniel@ffwll.ch, 
	rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com, mairacanal@riseup.net, 
	hamohammed.sa@gmail.com, robdclark@gmail.com, maarten.lankhorst@linux.intel.com, 
	tzimmermann@suse.de, daniels@collabora.com, helen.koike@collabora.com, 
	guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] drm/ci: add tests on vkms
Message-ID: <20240613-swine-of-abstract-flowers-c8d171@houat>
References: <20240611091037.558969-1-vignesh.raman@collabora.com>
 <20240613-bipedal-eccentric-locust-91632b@houat>
 <bd430442-6074-44b1-ba62-d3fa9e7bf28e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wrwuwca5fybozgrz"
Content-Disposition: inline
In-Reply-To: <bd430442-6074-44b1-ba62-d3fa9e7bf28e@collabora.com>


--wrwuwca5fybozgrz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 13, 2024 at 01:56:10PM GMT, Vignesh Raman wrote:
> On 13/06/24 13:07, Maxime Ripard wrote:
> > Hi,
> >=20
> > On Tue, Jun 11, 2024 at 02:40:37PM GMT, Vignesh Raman wrote:
> > > diff --git a/drivers/gpu/drm/ci/xfails/vkms-none-flakes.txt b/drivers=
/gpu/drm/ci/xfails/vkms-none-flakes.txt
> > > new file mode 100644
> > > index 000000000000..56484a30aff5
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/ci/xfails/vkms-none-flakes.txt
> > > @@ -0,0 +1,15 @@
> > > +# Board Name: vkms
> > > +# Bug Report: https://lore.kernel.org/dri-devel/61ed26af-062c-443c-9=
df2-d1ee319f3fb0@collabora.com/T/#u
> > > +# Failure Rate: 50
> > > +# IGT Version: 1.28-g0df7b9b97
> > > +# Linux Version: 6.9.0-rc7
> > > +kms_cursor_legacy@long-nonblocking-modeset-vs-cursor-atomic
> > > +kms_flip@basic-flip-vs-wf_vblank
> > > +kms_flip@flip-vs-expired-vblank-interruptible
> > > +kms_flip@flip-vs-wf_vblank-interruptible
> > > +kms_flip@plain-flip-fb-recreate-interruptible
> > > +kms_flip@plain-flip-ts-check
> > > +kms_flip@plain-flip-ts-check-interruptible
> > > +kms_flip@flip-vs-absolute-wf_vblank
> > > +kms_flip@flip-vs-absolute-wf_vblank-interruptible
> > > +kms_flip@flip-vs-blocking-wf-vblank
> >=20
> > We should have the header for every line here
>=20
> All the flakes in these tests were observed with version
> 6.9.0-rc7/1.28-g0df7b9b97. So can we group them together?
>=20
> If we update this file for different IGT/kernel version, we can add a
> separate header for each test.

If we don't however, we have no way to tell in a couple months whether
those flakes were there before we were adding those metadata, or if the
metadata applies to everything, or only a subset.

Maxime

--wrwuwca5fybozgrz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZmssOgAKCRDj7w1vZxhR
xZXFAQDs7TmILk6jOoCj9+p6Lqv0MVTBsGyty3bGr7SjLRmmrwEAkvxi7aXVgAQh
mqM/wt5a7+S1t3VY6hhZBtVAz/AgOw4=
=UG46
-----END PGP SIGNATURE-----

--wrwuwca5fybozgrz--

