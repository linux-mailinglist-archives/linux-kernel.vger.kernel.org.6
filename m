Return-Path: <linux-kernel+bounces-316073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB3A96CACF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 01:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FF14286F08
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 23:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A40516F824;
	Wed,  4 Sep 2024 23:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TP4ETILS"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55561146D5A
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 23:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725492727; cv=none; b=FPtOQh1J5Aj0YumKzTqpsZE+JRQPJ3uViV4/TPyrYd9hvjJiACxDZmi+quJaFJ7xwoEKyxZEudhq0M3lwVm9r50m55NcIJrvulJZxW2HU/UU2ZZ4kHJYixjEQjQNlHXQK3dQ+Ev9MsBDk0MX0/DINlwRjtx7uGrSwteAxloTOD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725492727; c=relaxed/simple;
	bh=Si1G+FCGXAPi+VPAx3jSjoLwCFQnbafftP1hcgktcuM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ABT1qdqhTtOFJEgyS3u52Ynmk5260E2j3/hANpIoXcd36bUGOPBtWVaJu7rx6hyhQLDXIsck9n50RDLCV3VDriBiCcEOue3LjV9iu5pvz74pGFhpmtm/t0av/0YXy01lUrvh5Nx7UtFB1wgCa6YvaBiopZhOY2hNSLXzqM+9dLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=TP4ETILS; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1725492715;
	bh=8WHRGJ8hQ2fXLzdlkSohDSuFlM8Wsmqz6AWEsBuEhLU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TP4ETILSqDGJ03mmN7GKdIK7N+4XKxEEA7gwvAzSyqJBBRfOBDXinZ4eGKpi+UKt0
	 4/3ty55U/YZ1yt87g625o3+cOtR6ZqThDfZwJeD8bopsYcLMFYdZWetC0MxGCwae4a
	 elbtLvYjPJMeVSOGHJpRcmgtnEUL7BMxw9e3UvtyjNMLKHdExePUbOCz9LcF9RUGfB
	 R37WQkhzsqrdtpqq2nvbQL51tCUXi9OTSSzAfFjnrBnx+na2E/h7wh47ANaEgWnW4r
	 SgfJnbnVbTjZaUuh1tUbtxbzozkzsGjQHf/jTX0hiFR6w6yi/0lHKxuFC32buiLuzv
	 fH2vg1Uw6eedg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Wzf0B5fndz4wb0;
	Thu,  5 Sep 2024 09:31:54 +1000 (AEST)
Date: Thu, 5 Sep 2024 09:31:54 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: chanwoo@kernel.org
Cc: linux-kernel@vger.kernel.org, cw00.choi@samsung.com,
 myungjoo.ham@samsung.com, hdegoede@redhat.com
Subject: Re: [PATCH v2] extcon: lc824206xa: Fix build error of
 POWER_SUPPLY_PROP_USB_TYPE
Message-ID: <20240905093154.6626f47a@canb.auug.org.au>
In-Reply-To: <20240904164325.48386-1-chanwoo@kernel.org>
References: <20240904164325.48386-1-chanwoo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xJOuU1V6mZt480PJwiMuZ1/";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/xJOuU1V6mZt480PJwiMuZ1/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu,  5 Sep 2024 01:43:25 +0900 chanwoo@kernel.org wrote:
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
>=20
> commit 364ea7ccaef9("power: supply: Change usb_types from an array into a
> bitmask") changes usb_types from an array into a bitmask. Fix the build e=
rror of
> usb_types variables.
>=20
> Link: https://lore.kernel.org/lkml/20240831142039.28830-7-hdegoede@redhat=
.com/
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
> Changes from v1
> - Update patch description with correct commit
>=20
>  drivers/extcon/extcon-lc824206xa.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/extcon/extcon-lc824206xa.c b/drivers/extcon/extcon-l=
c824206xa.c
> index d58a2c369018..56938748aea8 100644
> --- a/drivers/extcon/extcon-lc824206xa.c
> +++ b/drivers/extcon/extcon-lc824206xa.c
> @@ -393,14 +393,6 @@ static int lc824206xa_psy_get_prop(struct power_supp=
ly *psy,
>  	return 0;
>  }
> =20
> -static const enum power_supply_usb_type lc824206xa_psy_usb_types[] =3D {
> -	POWER_SUPPLY_USB_TYPE_SDP,
> -	POWER_SUPPLY_USB_TYPE_CDP,
> -	POWER_SUPPLY_USB_TYPE_DCP,
> -	POWER_SUPPLY_USB_TYPE_ACA,
> -	POWER_SUPPLY_USB_TYPE_UNKNOWN,
> -};
> -
>  static const enum power_supply_property lc824206xa_psy_props[] =3D {
>  	POWER_SUPPLY_PROP_ONLINE,
>  	POWER_SUPPLY_PROP_USB_TYPE,
> @@ -410,8 +402,11 @@ static const enum power_supply_property lc824206xa_p=
sy_props[] =3D {
>  static const struct power_supply_desc lc824206xa_psy_desc =3D {
>  	.name =3D "lc824206xa-charger-detect",
>  	.type =3D POWER_SUPPLY_TYPE_USB,
> -	.usb_types =3D lc824206xa_psy_usb_types,
> -	.num_usb_types =3D ARRAY_SIZE(lc824206xa_psy_usb_types),
> +	.usb_types =3D BIT(POWER_SUPPLY_USB_TYPE_SDP) |
> +		     BIT(POWER_SUPPLY_USB_TYPE_CDP) |
> +		     BIT(POWER_SUPPLY_USB_TYPE_DCP) |
> +		     BIT(POWER_SUPPLY_USB_TYPE_ACA) |
> +		     BIT(POWER_SUPPLY_USB_TYPE_UNKNOWN),
>  	.properties =3D lc824206xa_psy_props,
>  	.num_properties =3D ARRAY_SIZE(lc824206xa_psy_props),
>  	.get_property =3D lc824206xa_psy_get_prop,
> --=20
> 2.25.1
>=20

To preserve bisectablility, this fix up should have been applied to the
actual merge commit where you merged Hans immutable branch.

--=20
Cheers,
Stephen Rothwell

--Sig_/xJOuU1V6mZt480PJwiMuZ1/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmbY7eoACgkQAVBC80lX
0Gy3oAgAjb5/yX/i6kz9DXscwI8YBW2ryGcl+dFNq3pjYSSXoBXVe9q0nnlX2mhQ
0grSqVNZzkR6oPeNDc435Ve4bX+UA4ZDzkwv0QVxRwuuvRmhYkUGl9nm+yw4gffY
5IKKa9Ninb44HGHL1b+b7Tr0keL6eBS/ICyUkF8kurq0F2UXeGBFkgTGQX5Vw2oj
5jcB7sq7TLgvg7bJgKMa7z6B84t+hMEvqxQK+ADmxQa5/XV3yWwJLzXswm7cf0cj
fx0HP2oaD03uwFMkzzHpG0ZN3+9+5iAyoMyWOLfXbpwKjKP4pWKZhujlVNIoAu6p
WkN5D7RRBXHwuLuj/qEO6ik9nq7ZIw==
=OvK2
-----END PGP SIGNATURE-----

--Sig_/xJOuU1V6mZt480PJwiMuZ1/--

