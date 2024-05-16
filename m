Return-Path: <linux-kernel+bounces-180723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C238C724B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 09:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AC391F22548
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 07:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F38604D5;
	Thu, 16 May 2024 07:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQdQplp/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847A3282EF
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 07:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715846266; cv=none; b=Egf+IhUDcNss0zWqbjBNIxOtaWmVcb3618okzo92SOEyNvgK4TJjAQO8nZkZJqbfvu6HMEDBrmdhEvGavRSqzlFMDtiGN+zCIBS3TE3twJjGL/SJPY/SbKMzPdbYnZCY761Sb5eiBBiUT6DfpvePd11xWz+iF7PEVgMHrulYytk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715846266; c=relaxed/simple;
	bh=6nEVeR2xHqL+xtbx4QyEOB31XerRon6nHmu9UdguhZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4Gqw6Wwmj1DozF/alY07/ChOerEXkDPUfAb6BvSI1Lov0r/XHYu2SXHUU3HOQI8b8Qc/xDd08ZBjVJLa2TLbsRclArsi3VB5T9vXa56CeLhL4N/Dcbyyw6L4SG98J/pYdFIANuSt0X00PRvPGIVkH9N9soUXraM3bZTwM8Uoe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQdQplp/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC21FC113CC;
	Thu, 16 May 2024 07:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715846265;
	bh=6nEVeR2xHqL+xtbx4QyEOB31XerRon6nHmu9UdguhZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HQdQplp/8vX86ut/jbMDglepohWQgHpTSGUBJw5PCnN2bj1KN+lWktM6Ew8WDG8n5
	 GLYZuRwTXCu+d0aBeKS6AZSaF2+j7+yoHCeApnvQPGkmgsDc+BpbvxqiA5inLuy/Yj
	 Kd+ZpV0QUCXgUhRKLdKNhE+cONsjuF5oqNwOHNdE4HaDxy06gOHkSSruALVq7MgMBH
	 ctSWmpNnk1KJ402LE3GmAZlfQJtbbd2IT0kiblJ5PVYspbW+2I/w+dTWdKB7mweMIg
	 In0kmbucUq4iXpyEPee1LFAv6mOPze8wfo8EJnAwYgcpbdKPjOQvtN15B8+3fSq59J
	 WFc1z8GjKwpvw==
Date: Thu, 16 May 2024 09:57:31 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Yannick FERTRE <yannick.fertre@foss.st.com>, 
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, Philippe Cornu <philippe.cornu@foss.st.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Robert Foss <rfoss@kernel.org>, Antonio Borneo <antonio.borneo@foss.st.com>, 
	dri-devel@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/stm: dsi: relax mode_valid clock tolerance
Message-ID: <20240516-astonishing-tasteful-tuatara-7d29bd@penduick>
References: <20240322104732.2327060-1-sean@geanix.com>
 <lkrxoqhcitmvjvzslhx6mrdjaa6lpxtpmdjt7wwollm6z4h65q@jk5esjje6ppy>
 <b58c9073-02c6-4b5e-9082-fb11f388842d@foss.st.com>
 <44grbp56thhsbxf3i3yicsxgftbuhzebetioxfuibrpw6vbc6l@qqphfke5vgl5>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="35odebnap6x5sjhe"
Content-Disposition: inline
In-Reply-To: <44grbp56thhsbxf3i3yicsxgftbuhzebetioxfuibrpw6vbc6l@qqphfke5vgl5>


--35odebnap6x5sjhe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 15, 2024 at 09:42:34AM +0200, Sean Nyekjaer wrote:
> On Wed, May 15, 2024 at 08:39:49AM UTC, Yannick FERTRE wrote:
> > Hi Sean,
> >=20
> > thanks for your patch.
> >=20
> > Tested-by: Yannick Fertre <yannick.fertre@foss.st.com>
> >=20
> > I think that a helper could be useful in simplifying this part.
> > This might be reworked when a new helper will be implemented.
> >=20
> > Best regards
>=20
> Hi Yannick,
>=20
> Will this mean that this will patch will go in?
>=20
> I still have plans to do the helper, but I'm limited on time :)

I still think we should work on the helper and merge that directly. It's
been broken for a while anyway so it's not like it's a regression anyway.

Maxime

--35odebnap6x5sjhe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZkW8XwAKCRAnX84Zoj2+
dunqAYDKPCmEKxonPhhitWf97oBPBxfeBTdrMIqsZGA8qieRjVX6swAQk63a86xv
MGEjr/ABgKUizwvYzV/yf1DXkDoX8hAGZLW2VxvK4KC9FZNWg2EQXreBaig7iA9r
2Te1Kbufww==
=TSXP
-----END PGP SIGNATURE-----

--35odebnap6x5sjhe--

