Return-Path: <linux-kernel+bounces-361275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA5599A60F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 166A8B27005
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5992194AD;
	Fri, 11 Oct 2024 14:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkKWf7c7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB914218D68;
	Fri, 11 Oct 2024 14:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728656068; cv=none; b=OxCva+9DsX+l/g0X/k8xHlze7j7kBsFoWggmQqBmD084ZJ/lXfkyUs4FiIR9NkNh2KsUmizdBJHlOJpYDf6KU+xTOZz385fJEHtnJ63yc9IETLjMgXsbwmHlTtCpnVWu0sE06bB7T25qQUCNbTbykn7w24bCAK3e8WKCQ4d24T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728656068; c=relaxed/simple;
	bh=S2kpBhzA9CT2tk67op8T4/X6KIP8Ece09QFxSl24cf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEoCwqVAKuKioEcx5pGiA6JYzSWGgeFZTRSNfI7MwsPikDBmpMwzRFtWNHNC7eylHK6XFXEf1aQ1Yi0KQUmX6DXoPjGgBW3m45BL9CDdb1TaU4j56gLZv1MSJ1I/OjYboIe8g3x1w2GCEqSeTGkoHhw/7/vLDO/G29b1cd3ok5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkKWf7c7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7E9C4CEC3;
	Fri, 11 Oct 2024 14:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728656067;
	bh=S2kpBhzA9CT2tk67op8T4/X6KIP8Ece09QFxSl24cf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mkKWf7c7cL5WE1JLcPA5P6+KJ6hRJq+ZtKvd4oUHWuDiKE2gQk6EiAqZV487QgV/0
	 5fv95z+lKMlyA5zi0bUHmF7elNYetorKf3Xx0ueHZSrYyJsbLyXZyi8K9qp0fThEQm
	 8QduGft4fkhdIup4in0AThMs7vPZ2x6OreAYPRL4RLVFHwcXoKhEw+qO/KYD609Uv7
	 kEIpmHSk6N9To8w/0KJh/+KVNKr+a7/T8ZcH8rarQJc7LbiQfJQ6Rub0doJ+b4qBPU
	 GkJYHQfuY3cAlHnSaHlOIEC9D1UzaqNQpWkRKRUVeDXQeLgB/EGFYeiOOmA41W/zhe
	 hFLKOhnXu+GXg==
Date: Fri, 11 Oct 2024 16:14:24 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Maira Canal <mairacanal@riseup.net>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
	Melissa Wen <melissa.srw@gmail.com>, Haneen Mohammed <hamohammed.sa@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Simona Vetter <simona@ffwll.ch>, rdunlap@infradead.org, arthurgrillo@riseup.net, 
	pekka.paalanen@haloniitty.fi, Simona Vetter <simona.vetter@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	thomas.petazzoni@bootlin.com, jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com
Subject: Re: [PATCH v12 09/15] drm/vkms: Remove useless drm_rotation_simplify
Message-ID: <20241011-lyrical-rebel-orca-52a60a@houat>
References: <20241007-yuv-v12-0-01c1ada6fec8@bootlin.com>
 <20241007-yuv-v12-9-01c1ada6fec8@bootlin.com>
 <Zwjxo2TEAR3PelO9@louis-chauvet-laptop>
 <608074ed-567c-4e6d-b1c2-9e0ecf1d102b@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="mh3evp5i7kodpuvy"
Content-Disposition: inline
In-Reply-To: <608074ed-567c-4e6d-b1c2-9e0ecf1d102b@riseup.net>


--mh3evp5i7kodpuvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 10:53:52AM GMT, Maira Canal wrote:
> Hi Louis,
>=20
> On 10/11/24 06:36, Louis Chauvet wrote:
> >=20
> > Hi all,
> >=20
> > Until this point, this series has not received any major comments since
> > v9. I will commit patches 1-9 next week if there are no further comment=
s.
> >=20
>=20
> Although we are maintainers of VKMS, it isn't recommended that we push
> our own changes without even the Ack of another person. Please, read the
> "drm-misc Committer Guidelines" [1].

It's not that it's not recommended, it's that you shouldn't, really.

Maxime

--mh3evp5i7kodpuvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZwkyuwAKCRAnX84Zoj2+
dtJiAYDYtRU8bOHWuM4htXQzC9QzV5j+6JizmH9edB8kva4xwLN/cpf/iK0j82ov
rdS6u24BgPVlpyT9nYkZN48z0BkjXKcyTetT773goNf/UwDBrMkdymaobdd+NzGM
ab60NUleEQ==
=lGK5
-----END PGP SIGNATURE-----

--mh3evp5i7kodpuvy--

