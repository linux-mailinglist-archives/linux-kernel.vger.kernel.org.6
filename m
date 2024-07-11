Return-Path: <linux-kernel+bounces-249017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB4C92E515
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D921F229F8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F08315886C;
	Thu, 11 Jul 2024 10:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vG1Cvh4U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6158B29CF0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 10:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720695101; cv=none; b=LaPGuVti5WeOTnLON4brqJtaIJPEn0JMwp0SQ8wyWncI5PdRxnAaliVuDw403AH1bzQO/9CpFGQCbJv3Ps1t7mil0aEh7D5uxuctkN9SYqnKl8ydQI6wCiudXc6pO7N+diP2qBUcQbeThjMRuWMaWNqAs7cFbpIZdhdAQTwNIKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720695101; c=relaxed/simple;
	bh=jC+MUII/VUDTpAXbhDbSMtm7zmMjOZiHeuaNeYbo7uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a270JQ+rUDuhF5kuP+m8azc04zdpXXULE/dQ2hC0diAcKxVd6KA/vYIh/2NYDpkxuznGWNtZqYtHke3iNf4snf3f0YYync609X//oPm1t28zdWsmRdzksYkb/ZNySSEZZ1sX/qT+cLKyyArkFg0XN5qr8jUYxVy9Jt2YXLzeHp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vG1Cvh4U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9B2C116B1;
	Thu, 11 Jul 2024 10:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720695101;
	bh=jC+MUII/VUDTpAXbhDbSMtm7zmMjOZiHeuaNeYbo7uQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vG1Cvh4UThE+31U4IPJNPKGKyVZyd5g9xYKaiEaYwqzEey+IsiC1atQ9w0N/1nPrp
	 +BUayBEDx6eC0OykLJlfe55FXrTBe+1QNaorEHGyu/8fnc06xhNSCf+fwied2zBtli
	 T3UqS9TI3ZI1m/AR8JRW+H+TSMk1z/tk2T4YBPdj/TFFlp0gK6Y65V7ZpchlH+l9xa
	 Mnukv2NufgPYlF0VpEw58ZB6YZZhJgF8VgScTuF2Cm0IiMnlXf/soEVxCcGWLHowkT
	 f6ZxLV7q5Qvqc/AprabTo/5tafVj5eJy8UulZeqZuPEVRY0g1is2jDsDvpn1jgZEWa
	 OxLClsFrmv3Lw==
Date: Thu, 11 Jul 2024 12:51:38 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Andy Yan <andyshrk@163.com>, linux-rockchip@lists.infradead.org, 
	dri-devel@lists.freedesktop.org, heiko@sntech.de, hjc@rock-chips.com, andy.yan@rock-chips.com, 
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, javierm@redhat.com
Subject: Re: [PATCH] drm/rockchip: cdn-dp: Remove redundant workarounds for
 firmware loading
Message-ID: <20240711-therapeutic-space-bonobo-b4fed8@houat>
References: <109c6f19.2559.1907b817a99.Coremail.andyshrk@163.com>
 <0bf4701d98833609b917983718c610aa@manjaro.org>
 <2fd3aabd.785b.190914ec1a6.Coremail.andyshrk@163.com>
 <f0fb9feed2d9262bb4d7c8ade836af62@manjaro.org>
 <909d072.9028.19096c2429a.Coremail.andyshrk@163.com>
 <31062b80d3f9e11c339c400a70464f43@manjaro.org>
 <20240709-exuberant-tentacled-oxpecker-bd1ea0@houat>
 <b6d630447e6c69e913b76650d910f895@manjaro.org>
 <20240710-smooth-hypnotic-raccoon-b91fba@houat>
 <a30067db11e586d8eb2c124abe32052a@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="xsbqjcnrsppws4gq"
Content-Disposition: inline
In-Reply-To: <a30067db11e586d8eb2c124abe32052a@manjaro.org>


--xsbqjcnrsppws4gq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 04:22:12PM GMT, Dragan Simic wrote:
> Hello Maxime,
>=20
> On 2024-07-10 09:13, Maxime Ripard wrote:
> > On Tue, Jul 09, 2024 at 06:36:08PM GMT, Dragan Simic wrote:
> > > > > > > As I already wrote earlier, and as the above-linked discussio=
ns
> > > > > > > conclude, solving these issues doesn't belong to any specific=
 driver.
> > > > > > > It should be resolved within the kernel's firmware loading me=
chanism
> > > > > > > instead, and no driver should be specific in that regard.
> > > > > >
> > > > > > IT would be good if it can be resolved within the kernel's  fir=
mware
> > > > > > loading mechanism.
> > > > >
> > > > > ... we'll need this as a systemic solution.
> > > >
> > > > The general policy has been to put drivers that need a firmware as a
> > > > module, and just never build them statically.
> > >=20
> > > I totally agree, but if Buildroot builds them statically and provides
> > > no initial ramdisk, we need a better solution than having various
> > > drivers
> > > attempt to implement their own workarounds.
> >=20
> > Buildroot typically allows custom kernel configurations, so it's not
> > really "enforcing" anything like another distro does.
> >=20
> > It is definitely targetted towards very stripped down systems, so I
> > guess building the drivers statically is a natural choice, but it works
> > fine with modules too.
>=20
> It all leads to a conclusion that we need better in-kernel support
> for delayed firmware loading, instead of drivers implementing various
> workarounds, for the layouts in which drivers are built statically
> into the kernel image, but the required firmware blobs reside on the
> root filesystem.
>=20
> I'll start working on it, hopefully today. :)

I don't want to prevent you from trying, but be aware that similar
attempts have been shut down repeatedly in the past.

Maxime

--xsbqjcnrsppws4gq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZo+5NAAKCRAnX84Zoj2+
du2GAYCtFTc7CaphEQgCfqWHKMmGzxp6MqPjwU1kfoPddNDxF8VaZ3EI58nrUdUi
BytnnJcBf1UldJ4yRFP4F+3O6STBxwc38kR/ZT90xF0JtcAZz52j3JN7AUqtkBkm
3G+Ypgthcw==
=9HPF
-----END PGP SIGNATURE-----

--xsbqjcnrsppws4gq--

