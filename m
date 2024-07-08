Return-Path: <linux-kernel+bounces-244130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DD9929F8E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A31151C23159
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46495757F2;
	Mon,  8 Jul 2024 09:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2iY9uhX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF9F7404B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 09:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720432273; cv=none; b=JYImJVstSbgOqo0jwi/dmtuvIR4mMd6M2frDCz0hKMLl9NwcrANQDgbB9A8nalByLRDs8FUm4O8YaqTq7dUqWXFXZAwsyObO1cfpoR9blmOWGkw5Ps/4vRuALwP3NQ85HyRH0ZjcAb6zvdKc/CETt8om9828wJRNO+r/CqD892Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720432273; c=relaxed/simple;
	bh=+bbtocJ2OgfBGTOC9VVI14ZzymKokzGF4y9DKFmT4Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOe0NT6XsUXfr8lJS8m9d5rikqULwqYlt4D4M7nWaAH0d5WiOSMPJoNTfjypAA7h+emRlUR8C/+PC9ms3D2EAh8ev2+YCtImNIo01xHRD180IadAa+tuhvHEyc8fz0IXN11QSvvGLt2qky5uh5IBY3rXMrcM0rp6s6qIae/3s1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2iY9uhX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8264C4AF0A;
	Mon,  8 Jul 2024 09:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720432273;
	bh=+bbtocJ2OgfBGTOC9VVI14ZzymKokzGF4y9DKFmT4Xo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W2iY9uhXsYYDMv0PGVSP4LX7RLMVo0ISk+EErLwKg7+VgLNwFMJYqBh+12P2rCODm
	 nGt+RdCi/PFM0Z0QUIt/3a/ea68Ga145nQlnpl/vkrc5hxZwhoJgSVMGso1+UE1v8q
	 0OYjIObzq2CGcZkYL0LSQ2Bwil/Wb2+og6wtNY44aLAzCET4Ik9uTsq4xbOgQnOjn5
	 rzR1Mi6k7+9n3kU7eHs4Sd2vEULq1rE+AS2EAb44ORjAtRhyH8kpC8r/Q3hp/zb3/j
	 bpoUTkFqriQwm+bmqLczAn1xg5UG6Hf1bR6fjCHAlo5UvX1iXstC7dCYqcQ3/vYNKn
	 r5vPpSYCcezkg==
Date: Mon, 8 Jul 2024 11:51:10 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Andy Yan <andyshrk@163.com>
Cc: Dragan Simic <dsimic@manjaro.org>, linux-rockchip@lists.infradead.org, 
	dri-devel@lists.freedesktop.org, heiko@sntech.de, hjc@rock-chips.com, andy.yan@rock-chips.com, 
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, javierm@redhat.com
Subject: Re: [PATCH] drm/rockchip: cdn-dp: Remove redundant workarounds for
 firmware loading
Message-ID: <20240708-catfish-of-holistic-attack-5ea61e@houat>
References: <9b7a9e9b88ad8c7489ee1b4c70b8751eeb5cf6f9.1720049413.git.dsimic@manjaro.org>
 <109c6f19.2559.1907b817a99.Coremail.andyshrk@163.com>
 <0bf4701d98833609b917983718c610aa@manjaro.org>
 <2fd3aabd.785b.190914ec1a6.Coremail.andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="ci5qbz6tem4b4xue"
Content-Disposition: inline
In-Reply-To: <2fd3aabd.785b.190914ec1a6.Coremail.andyshrk@163.com>


--ci5qbz6tem4b4xue
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 08, 2024 at 03:46:16PM GMT, Andy Yan wrote:
>=20
> Hi Dragan=EF=BC=8C
> At 2024-07-04 18:35:42, "Dragan Simic" <dsimic@manjaro.org> wrote:
> >Hello Andy,
> >
> >On 2024-07-04 04:10, Andy Yan wrote:
> >> At 2024-07-04 07:32:02, "Dragan Simic" <dsimic@manjaro.org> wrote:
> >>> After the additional firmware-related module information was=20
> >>> introduced by
> >>> the commit c0677e41a47f ("drm/rockchip: cdn-dp-core: add=20
> >>> MODULE_FIRMWARE
> >>> macro"), there's no longer need for the firmware-loading workarounds=
=20
> >>> whose
> >>> sole purpose was to prevent the missing firmware blob in an initial=
=20
> >>> ramdisk
> >>> from causing driver initialization to fail.  Thus, delete the=20
> >>> workarounds,
> >>> which removes a sizable chunk of redundant code.
> >>=20
> >> What would happen if there was no ramdisk? And the firmware is in=20
> >> rootfs =EF=BC=9F
> >>=20
> >> For example=EF=BC=9A A buildroot based tiny embedded system=E3=80=82
> >
> >Good point, let me explain, please.
> >
> >In general, if a driver is built into the kernel, there should also be
> >an initial ramdisk that contains the related firmware blobs, because=20
> >it's
> >unknown is the root filesystem available when the driver is probed.  If
> >a driver is built as a module and there's no initial ramdisk, having
> >the related firmware blobs on the root filesystem should be fine,=20
> >because
> >the firmware blobs and the kernel module become available at the same
> >time, through the root filesystem. [1]
> >
> >Another option for a driver built statically into the kernel, when=20
> >there's
> >no initial ramdisk, is to build the required firmware blobs into the=20
> >kernel
> >image. [2]  Of course, that's feasible only when a kernel image is built
> >specificially for some device, because otherwise it would become too=20
> >large
> >because of too many drivers and their firmware blobs becoming included,
> >but that seems to fit the Buildroot-based example.
> >
> >To sum it up, mechanisms already exist in the kernel for various=20
> >scenarios
> >when it comes to loading firmware blobs.  Even if the deleted workaround
> >attempts to solve some issue specific to some environment, that isn't=20
> >the
> >right place or the right way for solving any issues of that kind.
> >
> >While preparing this patch, I even tried to find another kernel driver=
=20
> >that
> >also implements some similar workarounds for firmware loading, to=20
> >justify
> >the existence of such workarounds and to possibly move them into the=20
> >kernel's
> >firmware-loading interface.  Alas, I was unable to find such workarounds=
=20
> >in
> >other drivers, which solidified my reasoning behind classifying the=20
> >removed
> >code as out-of-place and redundant.
>
> For some tiny embedded system=EF=BC=8Cthere is no such ramdisk=EF=BC=8Cfo=
r example=EF=BC=9A
> a buildroot based rootfs=EF=BC=8Cthe buildroot only generate rootfs=E3=80=
=82

I'm not sure why you think ramdisks are an issue. Modules and firmwares
work just the same with or without ramdisks, so Buildroot can work just
fine too.

Maxime

--ci5qbz6tem4b4xue
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZou2iAAKCRAnX84Zoj2+
dsmPAYCZJGLhenooONeYP8afPlj+pVdEjg7//jhR+O5k9/W8nr2A64KhfLGFnrr8
Rky7+08BfijxYcx6VkUyY5IzEZWlDia+egXkkN5oDrn5pQOFSft7DdccmIzWs+eJ
+5GfyVhSQw==
=/d+L
-----END PGP SIGNATURE-----

--ci5qbz6tem4b4xue--

