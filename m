Return-Path: <linux-kernel+bounces-180757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2C98C72B8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8785FB2212A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 08:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AF384D2C;
	Thu, 16 May 2024 08:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EO1cHYgc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F3127269
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715847911; cv=none; b=KVzHJyKXKmjFQhUeXQCHuXJaza/4C7UQG0bb1QLLJ4ATMgN0NrA9SojGl2iyj6AH/Enp/+curP2Kpxc5h38/QgBuEn8zUHQ1P4/mASyM0h9qSzqq33VZgQygeabXrmuXSJQUqiRmSa6R/oQCXScQxJNzHc89cPTWe4qlxqEa2+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715847911; c=relaxed/simple;
	bh=wQSeNVyD2+LGMI1KSxHgOvUM6yNAJ+OyWsiLwLfXdGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzBtVkTGCyrneOXPHN7lTx+vapf6cuNplElkRtShrSHlngCnnxR+1uT0EeGcT7bMk5aAgJNBg5CpclfMk3HVnD+TC9V1FzMryGIbIIbPOPqoOOETjabgHGbM/u9yEpvn01C850sSJSPLtBDTq6PgBHRXLk7wcU6x3N+fr+uOjfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EO1cHYgc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454F1C113CC;
	Thu, 16 May 2024 08:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715847910;
	bh=wQSeNVyD2+LGMI1KSxHgOvUM6yNAJ+OyWsiLwLfXdGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EO1cHYgcSiyEgzOkCWNMhSk9JWysjcFy/0GEKirdIi1YG5LvOa9YIyrOSEjV8FQfh
	 6QJdIrd4qD24cJQwdh3xVJ98gOd+lM8VXkLD5xMqY6dP44hbN79W87RoJtjjxWhkjK
	 +EJZ9/yoZSARSObIcjh9HIYRmp0s+bruSbiUP/HikocggfO+2bSgrdVlbrxth1kltf
	 0RxHcmkiOevML+ju4hsLjuIUU6QtE5mwmnSMNd2Dg2ScM06zJuo6YvAB725psvuyyE
	 1/7E/5oO/LqIC87zin8OT1s2sX6o3ob57vgfV8zFFHkxqUSLnkKGWCFIGqKc07CChl
	 jhAqfI+RxTpiQ==
Date: Thu, 16 May 2024 10:25:07 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] drm/bridge: Add 'struct device *' field to the
 drm_bridge structure
Message-ID: <20240516-intrepid-uptight-tench-0df95e@penduick>
References: <20240514154045.309925-1-sui.jingfeng@linux.dev>
 <20240514-scarlet-corgi-of-efficiency-faf2bb@penduick>
 <c44480ab-8d6b-4334-8eba-83db9b30ff1a@linux.dev>
 <20240515-fair-satisfied-myna-480dea@penduick>
 <d394ee32-4fa4-41a8-a5ca-c1c7f77f44d2@linux.dev>
 <20240515-copper-chimpanzee-of-fortitude-ff3dab@penduick>
 <2c15c859-6b2b-4979-8317-698bf6cc430c@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="toq7dtu3l53x2mb5"
Content-Disposition: inline
In-Reply-To: <2c15c859-6b2b-4979-8317-698bf6cc430c@linux.dev>


--toq7dtu3l53x2mb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 11:19:58PM +0800, Sui Jingfeng wrote:
> Hi,
>=20
>=20
> On 5/15/24 22:58, Maxime Ripard wrote:
> > On Wed, May 15, 2024 at 10:53:00PM +0800, Sui Jingfeng wrote:
> > > On 5/15/24 22:30, Maxime Ripard wrote:
> > > > On Wed, May 15, 2024 at 12:53:33AM +0800, Sui Jingfeng wrote:
> > > > > On 2024/5/15 00:22, Maxime Ripard wrote:
> > > > > > Hi,
> > > > > >=20
> > > > > > On Tue, May 14, 2024 at 11:40:43PM +0800, Sui Jingfeng wrote:
> > > > > > > Because a lot of implementations has already added it into th=
eir drived
> > > > > > > class, promote it into drm_bridge core may benifits a lot. dr=
m bridge is
> > > > > > > a driver, it should know the underlying hardware entity.
> > > > > > Is there some actual benefits, or is it theoretical at this poi=
nt?
> > > > >=20
> > > > >=20
> > > > > I think, DRM bridge drivers could remove the 'struct device *dev'
> > > > > member from their derived structure. Rely on the drm bridge core
> > > > > when they need the 'struct device *' pointer.
> > > >=20
> > > > Sure, but why do we need to do so?
> > > >=20
> > > > The other thread you had with Jani points out that it turns out that
> > > > things are more complicated than "every bridge driver has a struct
> > > > device anyway", it creates inconsistency in the API (bridges would =
have
> > > > a struct device, but not other entities), and it looks like there's=
 no
> > > > use for it anyway.
> > > >=20
> > > > None of these things are deal-breaker by themselves, but if there's=
 only
> > > > downsides and no upside, it's not clear to me why we should do it a=
t all.
> > >=20
> > > It can reduce boilerplate.
> >=20
> > You're still using a conditional here.
>
> It's for safety reason, prevent NULL pointer dereference.
> drm bridge can be seen as either a software entity or a device driver.
>=20
> It's fine to pass NULL if specific KMS drivers intend to see
> drm bridge as a pure software entity, and for internal use only.
> Both use cases are valid.

Sorry, I don't follow you. We can't NULL dereference a pointer that
doesn't exist.

Please state why we should merge this series: what does it fix or
improve, aside from the potential gain of making bridges declare one
less pointer in their private structure.

Maxime

--toq7dtu3l53x2mb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZkXC4wAKCRAnX84Zoj2+
duwLAYDJLwwZxC6nv2o6co5SHZA890EEJ4sBl7/6pKRAdMofidpb1VuuXsFJ6wuy
1mwpPikBfjwAVJvlg/Adew0kmxARdh6BhgjhM8/XpUlkME8b39Me89obXMSOJ3U7
iPUlp/ORmQ==
=JFrx
-----END PGP SIGNATURE-----

--toq7dtu3l53x2mb5--

