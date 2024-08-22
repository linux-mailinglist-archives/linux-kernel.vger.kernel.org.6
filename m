Return-Path: <linux-kernel+bounces-297118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E6895B363
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 13:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BE191F23EBA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 11:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC59918455B;
	Thu, 22 Aug 2024 11:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="bGGJMN5+"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30AE184532;
	Thu, 22 Aug 2024 11:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724324437; cv=none; b=Ru6/TBMXd+/Rq6NrSgTZxHEWDLOgDY8SP+07UIGIMmjfrro5PdgxGACJVvzs+xhDH6dSUv4Wsxv8FOseBcrVG/DAD4DtuTlKWHdcogtvGWTO7dJrfh846+U2BKF3sLMTUPnaV97CLyMQdeofzUTMkRjn/P93j87FYvAxJMMhvk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724324437; c=relaxed/simple;
	bh=iPpc/Yn2vxrvQVc7R5jdvGjWlJbng8RMD0p1QbAGcvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvZVdDwGUjIFfYvVIqw+CENsFEx3MKDIJSgE+Lbj7EVan/JT+MR5cjnLxtBWbO3mDsVD5w9LxNRojNgZdTiFmCUVf4ov9s50gyyqgUL1s3c1J2ZurPDEMCh+AxuNJWSHy1f4lTaUVK/h842fBfC9/SicuSpSPgNaogkgZQiwV8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=bGGJMN5+; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 5AE841C009C; Thu, 22 Aug 2024 13:00:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1724324425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DbN7xxKejcgonMeotHUK0SRxnMl5EyvNy1IsqTj1/es=;
	b=bGGJMN5+SGZzthtavwSMYsE86HTgzJnpwyZsyq+/sBhPAyLBVMRFjb5mGT7qoY9osjYx29
	iY65twuO4CGc0uw0zKxiPBitbzX+jzFfC+4s2J1p4ltyBYZmu2If7LE5b4qlFAJSOx5Ok7
	RJYFZGbAurXga17EzGNgRwdhDk2eGes=
Date: Thu, 22 Aug 2024 13:00:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Tim Huang <Tim.Huang@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>, Xinhui.Pan@amd.com,
	airlied@gmail.com, daniel@ffwll.ch, lijo.lazar@amd.com,
	Zhigang.Luo@amd.com, Hawking.Zhang@amd.com, Yunxiang.Li@amd.com,
	victor.skvortsov@amd.com, victorchengchi.lu@amd.com,
	Vignesh.Chander@amd.com, surbhi.kakarya@amd.com,
	danijel.slivka@amd.com, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH AUTOSEL 5.10 04/38] drm/amdgpu: fix uninitialized scalar
 variable warning
Message-ID: <ZscaSHwgW5fzy/Z+@duo.ucw.cz>
References: <20240801003643.3938534-1-sashal@kernel.org>
 <20240801003643.3938534-4-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m3M4ZguZpdVcYcTu"
Content-Disposition: inline
In-Reply-To: <20240801003643.3938534-4-sashal@kernel.org>


--m3M4ZguZpdVcYcTu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Tim Huang <Tim.Huang@amd.com>
>=20
> [ Upstream commit 9a5f15d2a29d06ce5bd50919da7221cda92afb69 ]
>=20
> Clear warning that uses uninitialized value fw_size.

This is queued for 5.15 and 6.10, but not 6.1, for example. Mistake?

Best regards,
								Pavel
							=09
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -404,6 +404,8 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_de=
vice *adev,
>  	uint64_t retired_page;
>  	uint32_t bp_idx, bp_cnt;
> =20
> +	memset(&bp, 0, sizeof(bp));
> +
>  	if (bp_block_size) {
>  		bp_cnt =3D bp_block_size / sizeof(uint64_t);
>  		for (bp_idx =3D 0; bp_idx < bp_cnt; bp_idx++) {

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--m3M4ZguZpdVcYcTu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZscaSAAKCRAw5/Bqldv6
8qmWAJ9K4ap3buYYXtSedluoaXWY+f/29QCgq2QwH5AqKX+fw4Vz68CQNy4tCfs=
=AenU
-----END PGP SIGNATURE-----

--m3M4ZguZpdVcYcTu--

