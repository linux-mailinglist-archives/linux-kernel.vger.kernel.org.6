Return-Path: <linux-kernel+bounces-422281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C62B9D9712
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 13:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19298B2BA6D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 12:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941D91CEE97;
	Tue, 26 Nov 2024 12:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJYxmWMr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB209193408;
	Tue, 26 Nov 2024 12:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732623003; cv=none; b=idHt1QhpqtiV317+fMpQwA2zYGNuUDSHqHVvYUtg3Dfu4qS08A0RlyVEKeclgkc/Wf5HsJt/n4yHEzXMhnnuY8FeK544SfyD5nw3jUp3ZF4sxk+TsuW2I3gfVZUbWf9dsd20lHdaNi+F+uHRnZVs0uHjAcppa5F7fqhrjRR+Df4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732623003; c=relaxed/simple;
	bh=X1ZW6fAmw9BsbKNLM84F8Yh9PGsgTv9DvBZGDJRKcPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QG0DhnRKi6aaOl/hRoGfLH28AOi4NlKCm/B0Gi/Nn1aNekA4CijsA/MkXKGjg1yfFVNMxAHlhI+mB5s8MyUnr4yhvbpNF2c21qswfHy4PZGIo6JT7pjgtTo6j6e7lCQQzuYEZcFDfpOrwrOtSunikd/MYqNlIc+0/cQHw8TFJhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJYxmWMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4227AC4CECF;
	Tue, 26 Nov 2024 12:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732623002;
	bh=X1ZW6fAmw9BsbKNLM84F8Yh9PGsgTv9DvBZGDJRKcPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZJYxmWMrgHFfFMx4SZZpmRSPoxZkpZdW9Fzl0DNJVl9iZcJ9LACkFNimQ/Zl9Ggy3
	 SYCmCDCBy3wYS/4BAHyvqBSpdevfR2A8+Cl0poDBsaqFAiVPtYI4ZQNn2Ms/nXmQS5
	 B/UrH8sh1oOZZQLERhS2NMh5SThIcY98v8FukZxyJm5VP1r2O666m32kVPiCbDWwMI
	 NeeMi+iCzohnE5XpteEv/7Om1Ca0sbx5DmiPYy2VCMROZDM0dKBJnbXfWeQXAyW6i1
	 GaqOFZ7w3KO5d/7R8FWJR/goyXglI4rOOwcqF6zVI3DKQH1O1UjUQx+UM9YEv1s9DQ
	 YGDLHXsFjAikA==
Date: Tue, 26 Nov 2024 13:09:59 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Sean Nyekjaer <sean@geanix.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Yannick Fertre <yannick.fertre@foss.st.com>, Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
	Philippe Cornu <philippe.cornu@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 1/3] drm/modes: introduce drm_mode_validate_mode()
 helper function
Message-ID: <20241126-spry-wildebeest-of-cubism-da0a9e@houat>
References: <20241125-dsi-relax-v2-0-9113419f4a40@geanix.com>
 <20241125-dsi-relax-v2-1-9113419f4a40@geanix.com>
 <20241125-gleaming-anteater-of-perfection-42bd2b@houat>
 <874j3uxptp.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="qwww7zw5ccyu53nk"
Content-Disposition: inline
In-Reply-To: <874j3uxptp.fsf@intel.com>


--qwww7zw5ccyu53nk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/3] drm/modes: introduce drm_mode_validate_mode()
 helper function
MIME-Version: 1.0

On Tue, Nov 26, 2024 at 12:16:34PM +0200, Jani Nikula wrote:
> On Mon, 25 Nov 2024, Maxime Ripard <mripard@kernel.org> wrote:
> > I wonder about the naming though (and prototype). I doesn't really
> > validates a mode, but rather makes sure that a given rate is a good
> > approximation of a pixel clock. So maybe something like
> > drm_mode_check_pixel_clock?
>=20
> Quoting myself from a few weeks back:
>=20
> """
> Random programming thought of the day: "check" is generally a terrible
> word in a function name.
>=20
> Checking stuff is great, but what do you expect to happen if the check
> passes/fails? Do you expect the function to return on fail, or throw an
> exception? Or just log about it? If you return a value, what should the
> return value mean? It's hard to know without looking it up.
>=20
> Prefer predicates instead, is_stuff_okay() is better than
> check_stuff(). Or assert_stuff() if you don't return on failures.
> """

Both is_stuff_okay() or assert_stuff() return a boolean in my mind. If
you want to return a mode status enum, I don't think they are better
names.

Maxime

--qwww7zw5ccyu53nk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ0W6lwAKCRAnX84Zoj2+
dpfkAX9rQ95STenTbFaPTqzNs0f3hXHKnVKDzQwlwme3v/FEzAw3GEWZWO1BNFdE
ChoLbYwBf06ASgUEBRxVk52nFUsJogUobfhi2/VS/xGu8+SOUnSsG50ueId2dS+n
zeEpgo7ogA==
=OHka
-----END PGP SIGNATURE-----

--qwww7zw5ccyu53nk--

