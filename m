Return-Path: <linux-kernel+bounces-422021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 638B89D9377
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 09:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262472839BA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 08:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E886D19D8B2;
	Tue, 26 Nov 2024 08:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5+SU8It"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1D614A85
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 08:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732610525; cv=none; b=qeTvcTCQFS6Si6DwdHNc54VNd3hsM4h1GVU6w56x1zDBwPk3x4vKMqjcKxoPtJHS1w4P39J/ck475k/PpGsob4QY4G9bWW2ikXLmPXDVAM5R94LKMk+aJBaHiLst1jDed06duX/Mu0F+oCN0D4/YJUz0z6wzz6jN43/z+NM16oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732610525; c=relaxed/simple;
	bh=V/yPxtYnSXeUAycUhW+5heG32rTY664RPc7ZwK/MLOg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLJhWteDfBA9IGnNj6L2N2WBMgONgK8M8NNKv3R58/2zZOIeZrnkiayxctqN400rCfdaTO3hqp7DxECk1M4B15gHKBLkyhuiYpeo6sLE2U0OPDp4mSDxgY5LcUXNghJ/PeuDHG+FCjxL8IxuKib6aQ5039cvS1gfD6Ok8n2hZcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5+SU8It; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86160C4CED0;
	Tue, 26 Nov 2024 08:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732610524;
	bh=V/yPxtYnSXeUAycUhW+5heG32rTY664RPc7ZwK/MLOg=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=N5+SU8Itke6cV9eeV1LK6jEDRblhjXUlpBGkqf014uNsxXTKUsXnX0Q3ZLMQylyKX
	 OiEdDw96IrWbvWcibkwA5M1w3zb80e8Uj7QOGsXvHFk6+4Bkkm4zNlukDLD3O/Mo6N
	 QjQeUKZpCR/JcenNB9uNrJC6dVx+yCcWQyU0rXjvqM1g8FM/wJYl/m4otG0EkVvHxh
	 YRYCuU0GS64mIQol9zjA+uUHIug8gXBfAOldsrtkWGXNTb/tJf998P5KrDFbZuMJ1c
	 q7y1hu7n48r8hY2U5RpW7QcXO+9zG47A9Rab0iQNmcTUjggxg0vYWws8iEEvwxG9vr
	 4+YTBD3M3pr3w==
Date: Tue, 26 Nov 2024 09:42:02 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
	Melissa Wen <melissa.srw@gmail.com>, =?utf-8?B?TWHDrXJh?= Canal <mairacanal@riseup.net>, 
	Haneen Mohammed <hamohammed.sa@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Simona Vetter <simona.vetter@ffwll.ch>, 
	jose.exposito89@gmail.com, dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net, 
	linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
	thomas.petazzoni@bootlin.com, seanpaul@google.com, nicolejadeyee@google.com
Subject: Re: [PATCH RFC v2 00/16] drm/vkms: ConfigFS interface
Message-ID: <20241126-overjoyed-knowing-cuttlefish-c8d0f6@houat>
References: <20241122-google-config-fs-v2-0-4b7e6f183320@bootlin.com>
 <Z0DC8nd1ZFN4A82-@louis-chauvet-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="xrwipcbs3gmonqgv"
Content-Disposition: inline
In-Reply-To: <Z0DC8nd1ZFN4A82-@louis-chauvet-laptop>


--xrwipcbs3gmonqgv
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC v2 00/16] drm/vkms: ConfigFS interface
MIME-Version: 1.0

Hi,

On Fri, Nov 22, 2024 at 06:44:18PM +0100, Louis Chauvet wrote:
> On 22/11/24 - 18:38, Louis Chauvet wrote:
> > VKMS is manly used to test userspace program and its behavior. The curr=
ent=20
> > implementation is not very configurable as you can only have one device=
,=20
> > with few specific planes.
> >=20
> > This series aims to introduce a new interface, using ConfigFS, to creat=
e=20
> > and configure more devices. This will introduce:
> > - Device creation
> > - Plane creation
> > - Plane configuration (type, color encoding, color range, rotations)
> > - Encoder creation
> > - CRTC creation
> > - Linking between CRTC and planes/encoders
> >=20
> > The proposition is:
> > /config/vkms
> > 	DEVICE_1
> > 	=E2=94=A3=E2=94=81 enable
> > 	=E2=94=A3=E2=94=81 writeback
> > 	=E2=94=A3=E2=94=81 planes
> > 	=E2=94=83  =E2=94=A3=E2=94=81 PLANE_1
> > 	=E2=94=83  =E2=94=83  =E2=94=A3=E2=94=81 type
> > 	=E2=94=83  =E2=94=83  =E2=94=A3=E2=94=81 supported_rotations
> > 	=E2=94=83  =E2=94=83  =E2=94=A3=E2=94=81 color_range
> > 	=E2=94=83  =E2=94=83  =E2=94=A3=E2=94=81 color_encoding
> > 	=E2=94=83  =E2=94=83  =E2=94=A3=E2=94=81 default_color_encoding
> > 	=E2=94=83  =E2=94=83  =E2=94=A3=E2=94=81 default_rotations
> > 	=E2=94=83  =E2=94=83  =E2=94=A3=E2=94=81 default_color_range
> > 	=E2=94=83  =E2=94=83  =E2=94=97=E2=94=81 possible_crtcs
> > 	=E2=94=83  =E2=94=83     =E2=94=97=E2=94=81 >> /config/vkms/DEVICE_1/c=
rtc/CRTC_1=20
> > 	=E2=94=83  =E2=94=A3=E2=94=81 PLANE_2
> > 	=E2=94=83  =E2=94=83  =E2=94=97=E2=94=81 ditto
> > 	=E2=94=83  =E2=94=97=E2=94=81 PLANE_3
> > 	=E2=94=83     =E2=94=97=E2=94=81 ditto
> > 	=E2=94=83
> > 	=E2=94=A3=E2=94=81 encoders
> > 	=E2=94=83  =E2=94=A3=E2=94=81 ENCODER_1
> > 	=E2=94=83  =E2=94=83  =E2=94=97=E2=94=81 possible_crtcs
> > 	=E2=94=83  =E2=94=83     =E2=94=97=E2=94=81 >> /config/vkms/DEVICE_1/c=
rtc/CRTC_1
> > 	=E2=94=83  =E2=94=97=E2=94=81 ENCODER_2
> > 	=E2=94=83     =E2=94=97=E2=94=81 ditto
> > 	=E2=94=83
> > 	=E2=94=97=E2=94=81 crtc
> > 	   =E2=94=97=E2=94=81 CRTC_1
> > =09
> > This interface aims to be extendable (new property can easly be added i=
n=20
> > objects) and easy to use (objects are created simply by creating folder=
s,=20
> > and configured by writing files).
> >=20
> > This series depends on=20
> > https://lore.kernel.org/all/20241122-google-remove-crtc-index-from-para=
meter-v2-0-81540742535a@bootlin.com
> > but as this is a bit complex to rebase, you can find a working branch=
=20
> > here:
> > https://gitlab.freedesktop.org/louischauvet/kernel/-/tree/b4/vkms-confi=
gfs
> >=20
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
>=20
> Hi all,
>=20
> I am also currently working on MST emulation for VKMS. If someone can rea=
d=20
> what I already did and at tell me if my implementation seems on the right=
=20
> track it could be nice.
>=20
> The current status is not very advanced: I can emulate a mst HUB, but not=
=20
> a screen. I am currently working on properly emulating the HUB by using a=
n=20
> other hub.
>=20
> You can find the branch for this work here:
> https://gitlab.freedesktop.org/louischauvet/kernel/-/tree/b4/vkms-mst

I think this is exactly the kind of things where we'll want eBPF I
think. There's no way you'll be able to model each possible test
scenarios for MST through configfs, even more so with a stable
interface.

Maxime

--xrwipcbs3gmonqgv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ0WJ2QAKCRAnX84Zoj2+
drsbAX98D4pY1sEdKCD7Z8mgxWgEHD3aUX6925/SBQt8pDMZ+HVuSbzMHr2jhyCV
Jjm5t80BfR7PeV64r1jr5sqCEguDw5iLM04n9Zv6ILWCxSrstT0Z0IxuHnZsWLLb
A2nJIVqueA==
=v8th
-----END PGP SIGNATURE-----

--xrwipcbs3gmonqgv--

