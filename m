Return-Path: <linux-kernel+bounces-388316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED369B5DCA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 09:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A424F1C2138C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 08:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555FC1E1C1B;
	Wed, 30 Oct 2024 08:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vo/Yi9UH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B440D1E1C04
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 08:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730276754; cv=none; b=bQo67tHpO+oE1a01uPLB92Ul9BtHRai3S4EMqSfdgjUmRqXeGk8faEK/uKjyZu39HIL+8qajuYo3xcv7ll3jL6H9xGnMNoMU/mq+GlqpijG9utCdy4qOY7mL5g/9xivXtB1f8tyx7uNeIX3326GJD5bdc9Ap5/KfbWG1GFFuEUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730276754; c=relaxed/simple;
	bh=m+vPqbj0th9XDhYG7rHSXkRc5GYX5cnIWjH54alg/vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNPtXTWX8Ko6LO4oHpx/UEplEYfUiFqzCodbnBKno3FYOfqHHHhs5HauWXhiqvGq5IsWttlf0Dz8FUyp8EpK07A9yc2j+72uNRCPM47BX6cZ4bF3lw6aRiaGpUQlxgUPOQOI3SO+eWqYGdaJT3Smw02kIZVSGA5SZXx1zL1RS2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vo/Yi9UH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50F7C4CEE6;
	Wed, 30 Oct 2024 08:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730276754;
	bh=m+vPqbj0th9XDhYG7rHSXkRc5GYX5cnIWjH54alg/vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vo/Yi9UHyRqKbCan9ZBlQcbdEBggvr93kfm59xyiATBKwr09WuqKZM2PVSG1UWfzr
	 PH/blxtM+XAIGD16DssnR2TWDZ6rRLfeeWk7Snt7jY48BNc+IOayDiPrYVbfaW5AWA
	 QcNowf8yS6J6XmC9wZE1SJXVgf3tugTUP7HZOzh/aB8FQStfCiK1wjLGylQSsZaodU
	 7+l+pr6n+WChPNRsAucU6jlPaGHkZqmTk0WP2DUzirjF+mYy+HJjgndG5rUVyOaYN/
	 UX5/WwX8Pzz4HeSPkCV6zM1pYyuM7m2Z4lxq5xmSs+bDelmsTEuMgUW9wG07ov/1xB
	 QM3eYlQTQeFJg==
Date: Wed, 30 Oct 2024 09:25:51 +0100
From: "mripard@kernel.org" <mripard@kernel.org>
To: CK Hu =?utf-8?B?KOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
Cc: "wenst@chromium.org" <wenst@chromium.org>, 
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>, 
	"simona@ffwll.ch" <simona@ffwll.ch>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, 
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>, "airlied@gmail.com" <airlied@gmail.com>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH] drm/mediatek: Drop dependency on ARM
Message-ID: <20241030-hot-peridot-falcon-57bdbb@houat>
References: <20241029111309.737263-1-wenst@chromium.org>
 <d9177ba80fc78b1f74dc54260c0c43440ec5a804.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="huqxlu2kfajx2pij"
Content-Disposition: inline
In-Reply-To: <d9177ba80fc78b1f74dc54260c0c43440ec5a804.camel@mediatek.com>


--huqxlu2kfajx2pij
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/mediatek: Drop dependency on ARM
MIME-Version: 1.0

On Wed, Oct 30, 2024 at 03:30:34AM +0000, CK Hu (=E8=83=A1=E4=BF=8A=E5=85=
=89) wrote:
> Hi, Chen-yu:
>=20
> On Tue, 2024-10-29 at 19:13 +0800, Chen-Yu Tsai wrote:
> > External email : Please do not click links or open attachments until yo=
u have verified the sender or the content.
> >=20
> >=20
> > The recent attempt to make the MediaTek DRM driver build for non-ARM
> > compile tests made the driver unbuildable for arm64 platforms. Since
> > this is used on both ARM and arm64 platforms, just drop the dependency
> > on ARM.
>=20
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
>=20
> I find this days ago, but I don't know there is someone who apply it.
> Let this patch go through drm-misc tree which already has the bug patch.

If you are ok with this patch, why didn't you apply it yourself?

I think that's very much the expectation, so it's probably took a while to =
merge.

Maxime

--huqxlu2kfajx2pij
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZyHthwAKCRAnX84Zoj2+
dtNoAYCMCDvgwF9nHrinZfKHHWOLsicaXYf5ccom78linosyV9X/egXygJ4ryUPd
QqoQWFgBgO5FCorpFXFLZu6SVQg/ShD2DSGHjXQTFLgEBKuW8acqguqnMdlfW1n3
lCVPJCfolw==
=OfXZ
-----END PGP SIGNATURE-----

--huqxlu2kfajx2pij--

