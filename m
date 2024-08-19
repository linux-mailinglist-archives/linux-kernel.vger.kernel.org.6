Return-Path: <linux-kernel+bounces-292032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9BC956A5A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56B751C2388A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B006116A94A;
	Mon, 19 Aug 2024 12:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mI/j+Mt1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13E816A945
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 12:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724069074; cv=none; b=StglYBjBJlKfwvyaMSxz34hDy4hhlX6S0airk12rQsEL/xsIQXpCjyJkeHJCi/o3kfQT4BGuvyPcVaBjj7Sq9cE8SkyapYEfT/bHKmfXJLOmQFC84Iu29+j5nPOQt4RawN7yppziAtauCq7KmYmGvqbxw9jjTyftVihRaScJPSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724069074; c=relaxed/simple;
	bh=SsjO+MHpJemunwhEQxZru+/fv1kHC5YTFwrZhper4ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLrJPQD+0VUgcbGWXedCxb+frUYXxdedS8ZKUrb5UOQY+dPT94Jq1Ahby4l7EoycaeGcDrIggbyag7EyKS65PaPdMgK3bqiVy2Wfpnp6tW9Tf9Bh4sTAkdtbz511ichdcq8pzoG+3lQApkDpIG6mP0L9LKM1s+7Ysm9deayQs0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mI/j+Mt1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF711C4AF0E;
	Mon, 19 Aug 2024 12:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724069073;
	bh=SsjO+MHpJemunwhEQxZru+/fv1kHC5YTFwrZhper4ck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mI/j+Mt1HxJqUOluHjwz4MiixVv1yjspokyjsR0oaFWhWTVXpWPBTqbLAVxUCtDgJ
	 b7ETe9lQW+22y+uOk/wEAOvi1R6hE1U7bRChRWAQYmT2g+bSLrERK5ogEw3sU/zjuF
	 +VYDVdC+ciRjijRM0njNTZuuPe8AHKMwtuQ6byKPi9aetrk/PvKGTEsaTx5wV/f0BM
	 xNQ56UzcGfsuoY54QzF0rm4kymdYr3oi3/eY395e1XcyMkBYc6294fYmaYvpSNfKwa
	 oKt2UeCwtJFabhbDamd2ykV6RKqAmW63nGg+zDJjw0hgbqQeTpzM/nNnvPMkC6QovP
	 f8UunMweZ838Q==
Date: Mon, 19 Aug 2024 13:04:22 +0100
From: Mark Brown <broonie@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
	tony.luck@intel.com, bp@alien8.de, dan.j.williams@intel.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com,
	neil.armstrong@linaro.org, quic_jesszhan@quicinc.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	jgg@ziepe.ca, kevin.tian@intel.com, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, marcan@marcan.st, sven@svenpeter.dev,
	alyssa@rosenzweig.io, ulf.hansson@linaro.org,
	gregkh@linuxfoundation.org, jirislaby@kernel.org,
	michal.simek@amd.com, p.zabel@pengutronix.de, ira.weiny@intel.com,
	Jonathan.Cameron@huawei.com, shiju.jose@huawei.com,
	xueshuai@linux.alibaba.com, manikanta.guntupalli@amd.com,
	u.kleine-koenig@pengutronix.de, tglx@linutronix.de,
	julien.malik@unseenlabs.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 0/8] drivers: Fix some compile warnings
Message-ID: <9091a674-6489-4dac-8028-649ae0ca5d81@sirena.org.uk>
References: <20240819115913.3884804-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h/ND11TuP53BfgY+"
Content-Disposition: inline
In-Reply-To: <20240819115913.3884804-1-ruanjinjie@huawei.com>
X-Cookie: Interchangeable parts won't.


--h/ND11TuP53BfgY+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 07:59:13PM +0800, Jinjie Ruan wrote:
> Fix some sparse warnings.
>=20
> Jinjie Ruan (8):
>   dax/bus.c: Make dax_region_rwsem and dax_dev_rwsem static
>   pmdomain: Make apple_pmgr_reset_ops static
>   iommufd/selftest: Make dirty_ops static
>   nvmet: Make nvmet_debugfs static
>   spi: cadence: Make cdns_mrvl_xspi_clk_div_list static
>   drm/panel: khadas-ts050: Make ts050_panel_data and ts050v2_panel_data
>     static
>   acpi/ghes: Make cxl_cper_fifo and cxl_cper_work static
>   serial: xilinx_uartps: Make cdns_rs485_supported static

Please don't group patches for unrelated subsystems into a series when
there's no interrelationship between the patches.  It makes it a bit
less clear how things should be handled and can confuse tooling, as well
as making for massive CC lists.  Just send the relevant patches to each
subsystem separately.

--h/ND11TuP53BfgY+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbDNMYACgkQJNaLcl1U
h9CgKQf8DK5AwmGisxZzXqa6jUgC6Z6LHtN8wG5l5VimmTL2EECM6XPgimfemHR7
n5XY7Zi70HYeHJy9/++91/ippdAaCKV0Vfa0Wt93/Da091Strd4B6s7I6H4yoAxU
crKwKRNp1W2kcVBeXTu+ttb1fLMHbGkv6CWb6y8N3if7gacgMc6TVfzgQLhD1NHN
WLBoAVIbi4PW+ZQE5pm2zCBkeRCjliYifS7i4ik4haY6sswaw27sY0FmdKolqPfX
QNDb2riA2tXc6ksUed+2JiPFqD1bjxXDn4jw8XsAxaPTFwsaaVdVwY5U2A/hzYc5
benoonSS8ivnpkWLNKz1H2J0FKeWFA==
=zgii
-----END PGP SIGNATURE-----

--h/ND11TuP53BfgY+--

