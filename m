Return-Path: <linux-kernel+bounces-247137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4281592CBB7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E138D1F22A80
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876C8823B8;
	Wed, 10 Jul 2024 07:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKk429Xf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D127980C0C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 07:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720595600; cv=none; b=rt/FpYTrFVGbX6N8HXtT+O9I3TbDKN+9fGQdZ6Lp4b8haWcu/QSTYpMwjlOe1w3AS1NXRuz7bp65BjYvMM6mBe55RHihEUXMKBm2KU+DKvBFkAfl2SoWApiz9stx+PkI24vbC/oOkjDFBOln6C9PW4fnlqjZbZlt6wE712sCcOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720595600; c=relaxed/simple;
	bh=x4Iv2ujiTEenjVrms5+vXH7xG9UcavnTmM2LhQnOcG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWN7rE9buinSawgpBQo3NoUVyhNz2zU370qMO5KLr03vXbvYwww0PVXjA4lF/BVKhGu68+CB6NBWIRrJmNZf9hhPv2l5S06lv2RONpsySJycn71qfnlt8ijFP7rDTXaA+kbTTcwSILVVFg58CD802elIGbDkW10uV56YVaL4eEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKk429Xf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13EEDC32781;
	Wed, 10 Jul 2024 07:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720595600;
	bh=x4Iv2ujiTEenjVrms5+vXH7xG9UcavnTmM2LhQnOcG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dKk429XfmzcO+XAYY1Ls+tIh/Nc4eZ5CFHGB69JLNECEFWVpEDLi2fhEWaTr2sy8W
	 QGvNZhI8DxXcbfworB2a1nBKZ41ch90fto3uv6xsK8eZKyWeFdRM5eQgfq0AtYzh/V
	 Ue4KvNf8E7gjEvYQIy/vgzToAixTg0VBnaE2ZLy6A2IpQ783eboosUp5E9DrZjf+8K
	 Wdp/I3LW8l109sjNDOxTD5QnKfY43I32WkYsHrueC2hDF769gPJad35SAt8/26gsbC
	 Coh2T30E5L1v72W0M/u0sc6JvVeHvQcQdFI5WaGL1KP+XX9EjmOJqEAG+OrwrRenTr
	 NdT/zFCeapjEA==
Date: Wed, 10 Jul 2024 09:13:17 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Andy Yan <andyshrk@163.com>, linux-rockchip@lists.infradead.org, 
	dri-devel@lists.freedesktop.org, heiko@sntech.de, hjc@rock-chips.com, andy.yan@rock-chips.com, 
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, javierm@redhat.com
Subject: Re: [PATCH] drm/rockchip: cdn-dp: Remove redundant workarounds for
 firmware loading
Message-ID: <20240710-smooth-hypnotic-raccoon-b91fba@houat>
References: <9b7a9e9b88ad8c7489ee1b4c70b8751eeb5cf6f9.1720049413.git.dsimic@manjaro.org>
 <109c6f19.2559.1907b817a99.Coremail.andyshrk@163.com>
 <0bf4701d98833609b917983718c610aa@manjaro.org>
 <2fd3aabd.785b.190914ec1a6.Coremail.andyshrk@163.com>
 <f0fb9feed2d9262bb4d7c8ade836af62@manjaro.org>
 <909d072.9028.19096c2429a.Coremail.andyshrk@163.com>
 <31062b80d3f9e11c339c400a70464f43@manjaro.org>
 <20240709-exuberant-tentacled-oxpecker-bd1ea0@houat>
 <b6d630447e6c69e913b76650d910f895@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="hmozv7bd2sxugxlk"
Content-Disposition: inline
In-Reply-To: <b6d630447e6c69e913b76650d910f895@manjaro.org>


--hmozv7bd2sxugxlk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 09, 2024 at 06:36:08PM GMT, Dragan Simic wrote:
> > > > > As I already wrote earlier, and as the above-linked discussions
> > > > > conclude, solving these issues doesn't belong to any specific dri=
ver.
> > > > > It should be resolved within the kernel's firmware loading mechan=
ism
> > > > > instead, and no driver should be specific in that regard.
> > > >
> > > > IT would be good if it can be resolved within the kernel's  firmware
> > > > loading mechanism.
> > >=20
> > > ... we'll need this as a systemic solution.
> >=20
> > The general policy has been to put drivers that need a firmware as a
> > module, and just never build them statically.
>=20
> I totally agree, but if Buildroot builds them statically and provides
> no initial ramdisk, we need a better solution than having various drivers
> attempt to implement their own workarounds.

Buildroot typically allows custom kernel configurations, so it's not
really "enforcing" anything like another distro does.

It is definitely targetted towards very stripped down systems, so I
guess building the drivers statically is a natural choice, but it works
fine with modules too.

Maxime

--hmozv7bd2sxugxlk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZo40jAAKCRAnX84Zoj2+
dk7wAXsGnTzsBpAO71ZkHwlPTy/hfj7mkqJs1dxvs1EHsvTY5R9jsiA0xksKCqAb
ofSC7f0BgLqiZnp5G+2MV0POlp4hoq7m1l/IoTg44FTB0PjPx8MSeR1++MfMdKAk
ugJA0QtGyg==
=v2r+
-----END PGP SIGNATURE-----

--hmozv7bd2sxugxlk--

