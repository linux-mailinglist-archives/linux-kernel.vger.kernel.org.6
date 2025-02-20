Return-Path: <linux-kernel+bounces-523323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C992AA3D511
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 243DD18998C9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B901F0E31;
	Thu, 20 Feb 2025 09:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4blYxCr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F15A1F03DE
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044607; cv=none; b=oLBUwYwG/ZqGV3cEAZDR5TrKcLsAI+MRYCf8+hAPQ5ao+VDS3wpAXcPqrgnNvDfu+v+E3ubdJYGHTOpoyX2PJJ0lPsqhLERpFGnbwWqtUZX3X5QqOamaNjTu0/xs+AvJGftFeGqYuUFBkge8QSU8YIbbztsjZYicmFoeERWY/bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044607; c=relaxed/simple;
	bh=Rervc4K6IK6z3wDlFY4lh0T75HvSwycQ75TaiQNg8AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUN207o12ZxR5cwgW+BqcLX5wDVSlB5F5zq/y7szsB0Gv0VrSAFMj4nFFAr7Rj/VZlb8b4qraWh89a6iUVdFy41N7wrR23MtTsc3PUY0NlZwfLPJ9recT0cgyQMuTWdrE/4NLTiYLpt8XYMTMh8UqJ+5dEPu8DO0rr8XtpIYX6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4blYxCr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405DAC4CED1;
	Thu, 20 Feb 2025 09:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740044606;
	bh=Rervc4K6IK6z3wDlFY4lh0T75HvSwycQ75TaiQNg8AE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C4blYxCr+s9ZMpboatq3WcW8OV1FXLirXFmumOvmvfJfwgc+tbjCOA1U75DvvyWk8
	 a5Hg9GT7SCNwZPqlfOaqwZQX1i+v4AnVmTdvLisRRUOoA0zwgnyDiQ9GHgdn3GLAVg
	 eYWIn49roZPbksy8fhngURrn4iKGDVg7AGxYjMItY5aLC6L0I9U5UZNOqLS8M+FlRi
	 9BQGiqtkR8CxrlglFkST9ZNzr9G7K3dc7eJoBLbiWX6n1yDX87Wkb8Zf9Fd2A0bxzq
	 3q35rnHDqgFX0IDq6L7q85dz/OeHgfIEregchdxXfy1qT6IOnMUlx2rtwMDdw4aw3r
	 EcyoKaC7T36Wg==
Date: Thu, 20 Feb 2025 10:43:23 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Shixiong Ou <oushixiong1025@163.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
Subject: Re: [PATCH] drm/arm/komeda: Add a condition check before removing
 sysfs attribute
Message-ID: <20250220-spiked-quirky-nightingale-6ad2ed@houat>
References: <20250220085358.232883-1-oushixiong1025@163.com>
 <20250220-tiny-pragmatic-pug-5addfc@houat>
 <c3b340a6-04fe-adc2-d9e5-be95135aa0ab@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="dfzhoh7bq5tokgfb"
Content-Disposition: inline
In-Reply-To: <c3b340a6-04fe-adc2-d9e5-be95135aa0ab@163.com>


--dfzhoh7bq5tokgfb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/arm/komeda: Add a condition check before removing
 sysfs attribute
MIME-Version: 1.0

On Thu, Feb 20, 2025 at 05:20:48PM +0800, Shixiong Ou wrote:
>=20
> =E5=9C=A8 2025/2/20 17:12, Maxime Ripard =E5=86=99=E9=81=93:
> > On Thu, Feb 20, 2025 at 04:53:58PM +0800,oushixiong1025@163.com  wrote:
> > > From: Shixiong Ou<oushixiong@kylinos.cn>
> > >=20
> > > [WHY] If the call to sysfs_create_group() fails, there is
> > >        no need to call function sysfs_remove_group().
> > >=20
> > > [HOW] Add a condition check before removing sysfs attribute.
> > >=20
> > > Signed-off-by: Shixiong Ou<oushixiong@kylinos.cn>
> > What are you trying to fix exactly? AFAIK, there's no code path that
> > calls komeda_dev_destroy() after komeda_dev_create() has failed.
>
> |if calling |||sysfs_create_group() fails, it will go to lable
> 'err_cleanup:', and it will call |komeda_dev_destroy() laterly.

Ah, right. Then that's what you should fix.

Maxime

--dfzhoh7bq5tokgfb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ7b5NwAKCRAnX84Zoj2+
dhEsAYDGy/OEZUIBXjEWZz2IvJT25BidrqUoLDbizs7KqicTq0LkJ7lid+iu0i/n
PszTkeIBfAmbu9/3RnueHcnt2+beEl9IbIwkRunrNMr4YtvjA8rVm5yqZ03niU60
9n7SXNRTew==
=Pkhr
-----END PGP SIGNATURE-----

--dfzhoh7bq5tokgfb--

