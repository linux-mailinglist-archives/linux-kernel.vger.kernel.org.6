Return-Path: <linux-kernel+bounces-169414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B65CA8BC85D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78271C21412
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 07:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771D47D412;
	Mon,  6 May 2024 07:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTT6vfcv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7FD3E462
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 07:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714980579; cv=none; b=nTfqhNBjfUfMSoNBbfqN4iwOTrpaf4UG7A604kXtTQgR1nQkuvIUr5AuFxUa7Hfpm6sucnfEQNLAX3dkiXYj4F3qiDZ+leWtGBOx1u6zeSeOIe5fKKnb0kxIWraDbSUEYrTMPCFDwrDm07SHIgChIro4KX+VCkuHpnnMebr7nuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714980579; c=relaxed/simple;
	bh=6EAfDReBTGm2/618iI3K5J9zc5rNJX39dIPTNS7/tC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VESx3Yjxe/HYwFnvCGJvBhhkNCBcbRqdE9vpBIP+mEMxmWHVfMdXtflFBaI51n4TG62vXmLQq8Xenuw1dsO0Upz6HeDnpvecDcB9sXuksFKAFQZnFRXDbGNxfKZh0ZZZtZabs6vuLIw1p/7auC08Fi1pB5A3p57ii3Hgf2/oBDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTT6vfcv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDF3C116B1;
	Mon,  6 May 2024 07:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714980579;
	bh=6EAfDReBTGm2/618iI3K5J9zc5rNJX39dIPTNS7/tC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LTT6vfcvkv+HM+jrI2Ok6j4+eJlWYmbJn2/gUqM4HBexny+ZPOtF3kTZ7bla4jK9f
	 NoyyXaR6xdUl7F8hPvO63U5xyg28jtKJmAORVdzwL5lYHrGBu5t8bAKih3aAu9frYI
	 0gDlAz9fp8Bzc09RCv/Ei4+F3oPBKcXU4JeOlMaEnfmFfinRMiw3YLVp8/AiFYjxAz
	 jUL+BuUNplEfy/8S6WKjIylgkGqdkwPqRHI283ob1XYdgBdcnOfA021042v77EAdx0
	 B5iXaAm0LRAjr+PqEszgHpTWuE3BfKRgRKHYmLvj31BMeqgUK5eE333c/+lxQmYSP2
	 pGJHumzUzEY5w==
Date: Mon, 6 May 2024 09:29:36 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sean Anderson <sean.anderson@linux.dev>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Michal Simek <michal.simek@amd.com>, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] drm: zynqmp_dp: Lockup in zynqmp_dp_bridge_detect when
 device is unbound
Message-ID: <20240506-charcoal-griffin-of-tact-174dde@houat>
References: <4d8f4c9b-2efb-4774-9a37-2f257f79b2c9@linux.dev>
 <20240504122118.GB24548@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="ocucrrp6xgvwroku"
Content-Disposition: inline
In-Reply-To: <20240504122118.GB24548@pendragon.ideasonboard.com>


--ocucrrp6xgvwroku
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Laurent, Sean,

On Sat, May 04, 2024 at 03:21:18PM GMT, Laurent Pinchart wrote:
> On Fri, May 03, 2024 at 05:54:32PM -0400, Sean Anderson wrote:
> > I have discovered a bug in the displayport driver on drm-misc-next. To
> > trigger it, run
> >=20
> > echo fd4a0000.display > /sys/bus/platform/drivers/zynqmp-dpsub/unbind
> >=20
> > The system will become unresponsive and (after a bit) splat with a hard
> > LOCKUP. One core will be unresponsive at the first zynqmp_dp_read in
> > zynqmp_dp_bridge_detect.
> >=20
> > I believe the issue is due the registers being unmapped and the block
> > put into reset in zynqmp_dp_remove instead of zynqmp_dpsub_release.
>=20
> That is on purpose. Drivers are not allowed to access the device at all
> after .remove() returns.

It's not "on purpose" no. Drivers indeed are not allowed to access the
device after remove, but the kernel shouldn't crash. This is exactly
why we have drm_dev_enter / drm_dev_exit.

Maxime

--ocucrrp6xgvwroku
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZjiG4AAKCRAnX84Zoj2+
dgeOAX9MWR6b74vbLNz7k9jf5IToCNO+03AZ7DaUKMEY6avOZ4UMCs5HJXcFnAR+
/TeAmFIBgJyNn/OtniP2Hp5Bfq8TvJKZl8ZZ6WzuVaWny/ME4+2poozKoG2ZNm0K
70BmtsE9YA==
=rd0O
-----END PGP SIGNATURE-----

--ocucrrp6xgvwroku--

