Return-Path: <linux-kernel+bounces-327042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E9397701B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A84E21F2552A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 18:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99591BFDE8;
	Thu, 12 Sep 2024 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cl+JHoUw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491E1156F3C
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 18:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726164493; cv=none; b=WHcFDGYrqu+6AroyhP5p45IGqCu+bcpEFF5DClCiC4U6jk8+Zof4JmYac5QhnfGCqkxfFp1NIfgLbZdiBaK1z3GBahwYR8n1SG7qyjidNg3n9kcTnyC6wISo/jbZUo5rS6tWYnKml5cOubENsHtwV/RfdH54YOPY9ujwWq5q26E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726164493; c=relaxed/simple;
	bh=pHVKUgc037QIkkMyjr0klM/vGrCs08KRmgG5kkq2IOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jrhlrwql1mcAAXl1kxuhUYlgRqwDG/O5Ej/Jm5WTvBxqmNd6GwJLxVuxvSogfeVlbePlREAN0dsR+gWwBbdS8FTj7dg4dIK5Llbe/qV/O0h3V6UrHM9WfrJ0pKSanDf/rYXV0aELiSQpkymwM7C7JAuGQnkvJrGHZXH9pZKnxPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cl+JHoUw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F99C4CEC3;
	Thu, 12 Sep 2024 18:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726164492;
	bh=pHVKUgc037QIkkMyjr0klM/vGrCs08KRmgG5kkq2IOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cl+JHoUwBpwclc34hmilJ/q47jZx/83/7BecIXcqQ3i15eaMvyUyvDkyVtBH+ljVU
	 Y/LW00U/BVdjCbRovmFC8jfzPl4q9HAY810zAT6QHoSIAoyvTk4pFWpmh0z/UgG1JK
	 ao3oKXxWsX09TLncKVI9LNfi5i8zS9c/cEWMwt+wNEd3RRggwgSwrJUTGu5Z/dBj+9
	 OSMz4SXe7Tr23uIjUpzTMaDFzTlXwUTAsUshPNVLrLQTmNdxf5gol1iBLPhlAcCVSP
	 R17Rnhgn/dqXTW4AM99THV2x7s7ASK5nTwX31PfGQNAY2iztkH1k+DySqKQcXYPaAX
	 w2+/LLy82OclQ==
Date: Thu, 12 Sep 2024 20:08:10 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Devarsh Thakkar <devarsht@ti.com>
Cc: ahalaney@redhat.com, airlied@gmail.com, cai.huoqing@linux.dev, 
	caihuoqing@baidu.com, colin.i.king@gmail.com, dakr@redhat.com, daniel@ffwll.ch, 
	dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org, geert+renesas@glider.be, 
	grandmaster@al2klimov.de, j-choudhary@ti.com, javierm@redhat.com, jyri.sarha@iki.fi, 
	laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, 
	nm@ti.com, praneeth@ti.com, r-ravikumar@ti.com, robh@kernel.org, 
	sam@ravnborg.org, simona.vetter@ffwll.ch, tomi.valkeinen@ideasonboard.com, 
	tzimmermann@suse.de, u.kleine-koenig@pengutronix.de, vigneshr@ti.com, 
	ville.syrjala@linux.intel.com, wangxiaojun11@huawei.com, yuanjilin@cdjrlc.com, 
	yuehaibing@huawei.com
Subject: Re: [PATCH] drm/tidss: Add MIT license along with GPL-2.0
Message-ID: <20240912-unyielding-mottled-bumblebee-6bb69f@houat>
References: <20240912171142.3241719-1-devarsht@ti.com>
 <993bbe0a1b503505dd2e9b33b94e2b83@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="7xixjsp4uufbegwa"
Content-Disposition: inline
In-Reply-To: <993bbe0a1b503505dd2e9b33b94e2b83@kernel.org>


--7xixjsp4uufbegwa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 06:04:11PM GMT, Maxime Ripard wrote:
> On Thu, 12 Sep 2024 22:41:42 +0530, Devarsh Thakkar wrote:
> > Modify license to include dual licensing as GPL-2.0-only OR MIT license=
 for
> > tidss display driver. This allows other operating system ecosystems suc=
h as
> > Zephyr and also the commercial firmwares to refer and derive code from =
this
> > display driver in a more permissive manner.
> >=20
> >=20
> > [ ... ]
>=20
> Acked-by: Maxime Ripard <mripard@kernel.org>

Also, we need the ack of all contributors to that driver, so my ack
isn't enough to merge that patch.

Maxime

--7xixjsp4uufbegwa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZuMuAgAKCRAnX84Zoj2+
dv6eAYCi4jOdtVoIy60SAAMJCLFrI4wf7YQQruU/aVFo0Pb9/tge5AFz3X5pYtjc
Rf7vB2YBgOnnpVUNtwn8u0Jvfq0gpOx4oc+XmD1jRbINJ2ZTY7fRtiv0TLKB1DBI
IzF2KlDEWA==
=8muI
-----END PGP SIGNATURE-----

--7xixjsp4uufbegwa--

