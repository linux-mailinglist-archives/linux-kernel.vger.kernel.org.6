Return-Path: <linux-kernel+bounces-173374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085878BFF9B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B268B26A4F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84EB84D30;
	Wed,  8 May 2024 13:58:01 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E9947A5C
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 13:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715176681; cv=none; b=XQLSNTsNd+YGrlMAoTim29SFmmVFKEXLDdCJNVDFoLYRyhA/g5BJWmbF9/eRIran2T4K4h+K1e5KZrIjZ7xQCebc7VLhX7OFIaw+opMu0rpAa2o6CdeTwAbocKWReYrGf3nShlosQegUJxpcb8M53Lfyt/a6PwDKxTB4npuTvjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715176681; c=relaxed/simple;
	bh=WkGKWaDMg+oxjke1haJBfipdxFIztlUQio/y+Mte9vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNArsAqGEDmyNZ0O22JMKvCFXsjkfnAAF5TCPkpnnS5wl7bMjyc0HPWb8GXsGC9xF3pZiU1A3AqBpkHFIXM48qPQwRSFntVfSipGM6w+HPa+Wyd8BXsOUgwLjy5vUG4y6yI5Z4XE/dYTOq+lwNMvIuKnICVCBNxYoZn+iIC+5W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1s4hnw-0005z2-Eo; Wed, 08 May 2024 15:57:56 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1s4hnv-000Hjx-U3; Wed, 08 May 2024 15:57:55 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1s4hnv-000Zj0-2l;
	Wed, 08 May 2024 15:57:55 +0200
Date: Wed, 8 May 2024 15:57:55 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: linuxpps@ml.enneenne.com, linux-kernel@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH] pps: clients: gpio: Convert to platform remove callback
 returning void
Message-ID: <v7sefhmq42ro2dfpxgipxxajxpuh3xy46c77uibmypyp34duqs@5vw5ava4ns7d>
References: <f4b9402af72e5f285c8b0f068076a76418f653f5.1709886922.git.u.kleine-koenig@pengutronix.de>
 <6d73b0a4-34e6-44ce-8757-4f4931c3da85@enneenne.com>
 <4iii7uxyfovs6ntm7hs2w546k3upbhkepgzxarjk4wnlqmeern@sh6gkyuiqpjs>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l2exd44x4zpgzyxq"
Content-Disposition: inline
In-Reply-To: <4iii7uxyfovs6ntm7hs2w546k3upbhkepgzxarjk4wnlqmeern@sh6gkyuiqpjs>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--l2exd44x4zpgzyxq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 02:26:48PM +0200, Uwe Kleine-K=F6nig wrote:
> [Cc: +=3D linuxpps@ml.enneenne.com]
>=20
> On Fri, Mar 08, 2024 at 09:57:29AM +0100, Rodolfo Giometti wrote:
> > On 08/03/24 09:51, Uwe Kleine-K=F6nig wrote:
> > > The .remove() callback for a platform driver returns an int which mak=
es
> > > many driver authors wrongly assume it's possible to do error handling=
 by
> > > returning an error code. However the value returned is ignored (apart
> > > from emitting a warning) and this typically results in resource leaks.
> > >=20
> > > To improve here there is a quest to make the remove callback return
> > > void. In the first step of this quest all drivers are converted to
> > > .remove_new(), which already returns void. Eventually after all drive=
rs
> > > are converted, .remove_new() will be renamed to .remove().
> > >=20
> > > Trivially convert this driver from always returning zero in the remove
> > > callback to the void returning variant.
> > >=20
> > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >=20
> > Acked-by: Rodolfo Giometti <giometti@enneenne.com>
>=20
> The MAINTAINERS entry for drivers/pps lists you as single maintainer.
> Who is expected to pick up this patch given that you "only" send an ack
> but didn't pick up the patch? (Or only picked it up in a tree not
> included in next.)

In the meantime you sent an Ack to my patch. Does that mean I can/should
include this patch in the series changing struct platform_driver that I
intend to send to Greg after the upcoming merge window closes?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--l2exd44x4zpgzyxq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmY7hOIACgkQj4D7WH0S
/k76Egf+LXTa3JOc5moyPTsiH03oXITiy/C2BSfJL0T1V6NP6vcbp4iOv/KK0NuY
WRrokUjCmTCi+K3YIZmtbkUOyk5XrI2K02Su16J86RCU+XJksoKRTAdGo3m+PTqr
ESJfPkPqkLJ4kwSJpLGPxrRJMVLKCWhgmvBYppCYucSxGxfxZcMleBrTnFFMdCPc
udupzK8vaprPVNKbAFfyOY7OazzsbopSaYGYPLBgrJVfUiJJmp1c3TffesEVZYKy
nFxZkD5Vo39w7s6sts1digxHTtCCVcx5fULfk1EhHIdbeolybYFkqEZiZE4sm9vC
tnxTQSblEBTkNNbRwBEuBiFnHpMlaQ==
=r0Au
-----END PGP SIGNATURE-----

--l2exd44x4zpgzyxq--

