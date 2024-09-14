Return-Path: <linux-kernel+bounces-329232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CC4978EF6
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 09:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6753E1F240EE
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 07:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E13913A888;
	Sat, 14 Sep 2024 07:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="inCsllv3"
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4D638B
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 07:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726299830; cv=pass; b=SRTTbJdjd3xstIcXof5zsWEIJUsQN/icgQwMki8TECnFzYsNgFpY81qtdHqPE2BdBQ8iYQnoUq7EVrzrRzfU5MZChfNwe7YedB4cbJwF0S1IYjKxM/OzY/pmX4sMpbpcelkhcte7pHdo5BF29aJNWVvaNbJq/XXnxxPGyda45kI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726299830; c=relaxed/simple;
	bh=fi4cZchvgvSn5MoH3VB5JWtAVo0kFpjrgsKbZcJ2RAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9ttq5AD5OQSPmOHpjN/AHOnUzoYWplSnkVAPb3YmQX2bJiCYXPTHPhWAHhbK1t45FSE2OTYADMwHKSWMB1ZHb/d+ZlCI61Cq0xOISRoOLfE+MuUpMdDp58GNvE5h+zCDeBfR/UEKLZDBnnCkVu7grbpYbdAOLNFm9qeyy9A2ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=inCsllv3; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726299810; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RbnwAjEucXAKzNeT8OSRgFyVTfJqTiNV1SPybCL8HFrpn3cfwaUHlG6q4wteMAQhVbeD111Xkr+hWuYayvI9nD6ohp9DUjN9RhAKdVttQqlmZswlLEDC1xsWRodjUO2gjgCz0v2wPcmxu5ivWJKvo9vFSbsSe6IQF3oNp53ERFk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726299810; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9s6xbgvRK66eWsct5dwCUnVpO4nqDb+N6HYnzutOOR4=; 
	b=Us3Eit+cTSmh7lDAwTyHD2I8Z54xM5bK0ZlCk6g+TNt5pDkZceUW3g0hk0vuwCa/vZllB5RO+ytgxh4znYVoTShjh6Ammz7FPOkXM2RZsQZ2oYqgiXZ8eUpWxCcQjl9+3BIMKU8n4Iru6AimuDxt+VUijelEN9FztkayAhJ8/Lk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726299810;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=9s6xbgvRK66eWsct5dwCUnVpO4nqDb+N6HYnzutOOR4=;
	b=inCsllv3x9n7C2tlssmPf/tMvrPWt9e3mLm60cAKlcsL6P7/Mny4uzdiM8TtUqJ9
	zXyDR1I8sZv6zMOq4egzE2rXWSDfnPaR5Dqfthbp7O5ynv5UK/HRfhJiytTQMPERiZZ
	j8EPRzwEsb8F5UyNHWxv1sBqaqzExKqmFEkkSfYw=
Received: by mx.zohomail.com with SMTPS id 172629980865397.08858448934461;
	Sat, 14 Sep 2024 00:43:28 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
	id 18B7A1060578; Sat, 14 Sep 2024 09:43:18 +0200 (CEST)
Date: Sat, 14 Sep 2024 09:43:18 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>, Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH 0/3] drm/omap: Minor fixes
Message-ID: <p63avbtt3vovvmcjpz5xywpneuegb2yasvfllo6leskldbac7p@rkfhsgvjusrf>
References: <20240806-omapdrm-misc-fixes-v1-0-15d31aea0831@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ecfymshjkc7m26ry"
Content-Disposition: inline
In-Reply-To: <20240806-omapdrm-misc-fixes-v1-0-15d31aea0831@ideasonboard.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/223.982.64
X-ZohoMailClient: External


--ecfymshjkc7m26ry
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 06, 2024 at 04:50:26PM GMT, Tomi Valkeinen wrote:
> A few minor fixes to omapdrm, mostly to remove sparse or other checker
> warnings.
>=20
>  Tomi
>=20
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

For the series:

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Greetings,

-- Sebastian

> ---
> Tomi Valkeinen (3):
>       drm/omap: Fix possible NULL dereference
>       drm/omap: Hide sparse warnings
>       drm/omap: Fix locking in omap_gem_new_dmabuf()
>=20
>  drivers/gpu/drm/omapdrm/dss/base.c       | 25 ++++++-------------------
>  drivers/gpu/drm/omapdrm/dss/omapdss.h    |  3 +--
>  drivers/gpu/drm/omapdrm/omap_dmm_tiler.c |  6 +++---
>  drivers/gpu/drm/omapdrm/omap_drv.c       |  4 ++--
>  drivers/gpu/drm/omapdrm/omap_gem.c       | 10 ++--------
>  5 files changed, 14 insertions(+), 34 deletions(-)
> ---
> base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
> change-id: 20240806-omapdrm-misc-fixes-2ea920193dde
>=20
> Best regards,
> --=20
> Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>=20

--ecfymshjkc7m26ry
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmblPpIACgkQ2O7X88g7
+prUWg/9EdoySBxDqVDFjyZIU8WKrTZK2WPiQUn4aJsTugo8jA1jQrX+c4CNUO8h
8fa6s9RjZMqpP0EKEmyp3I3801cJmN8cZwdS5YjkiWIjFTlsrWPIlf4Ve+ukMINX
k3qizRuWLSOTiJgdu0u3vaKjh4uhjWzlPyl/uKFx5N3pSVxw1OQQBXFSYsqY5AFj
hHN14+j4hmomtDHRB+OicWVV4+KBsvvCcFhknGSbVvs4je2CKn9Fn83JNY6WJz9r
sAMFAHN9jsJWX0L6OQNFbutoW9p+ym+8YLoaNO4OKgBJyIeVNVHb9h5bjASLusI4
XXjrHOTpaRL8cJGrqnJJ65fzX7+4dif5ZNUUt13MvQO+hSlM6nXLRzhYzGskBpJn
rxnmfVhrGMD+X1tmBqShwutklogpFjYgFGX2TwmJDpZOU2chViNbDvDsuz5pZmOf
n1K2OF4wDMaG/wZ9XkeahbSbjNkObRHehkRIBocGPcjppiRDiGCgPZX9x1RzyTGi
P0uOG3sjjPA4pAhrfZVaVMZoX68lngd5wMot2PtcMBiSe1v7maEnLtNgjd7pACgv
dlz6h0QAk2u0ZpCmx6POKatzakP0QoBgHAaqqVJKgbWTzo5/y3cZoiWfOzJuvygj
C6m06J0AK7lvaAo/8bixuT+w85IJfn9MyqerjCc1zrKifyrgSVA=
=Tzmd
-----END PGP SIGNATURE-----

--ecfymshjkc7m26ry--

