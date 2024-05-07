Return-Path: <linux-kernel+bounces-170843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAE78BDCCE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAAE61F24CEE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 07:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC30613C91A;
	Tue,  7 May 2024 07:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BygZ6Mnl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B22213C900
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 07:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715068712; cv=none; b=ilJqsdlNQ30u1HyXkH6C5eLJyuIB7hECGZujh4I5QanhwLJjO3B98ELNsXCXQah4YPxID9/qlTNnnmte0jR4PW/6ZiTjMmASNIVdPexVsvkDkv6UHQHfNvTemNfZH1MHKeS19F9Qex/I5LI0SrEtLdacqIOyGRUGa/p64TceOGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715068712; c=relaxed/simple;
	bh=89t9B5VtRJzNfp6Wda6X2h6J58Yiwx7TQOCpbZd8Iu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjhxf48ikjayABm3/j3E8KViL3euubVgn/6IOJB8bncsKO6y9Da2nVY4wcU62N/Z32pLon0M3UZl3IqIvc7vunMP19ogvje/6WubyBScU/tQPAi2qVNcfSoufUxTDA6SiIkvBHEzPseJsQ71QmlfwHBN25TxVzrVK7QPGCP440E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BygZ6Mnl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5447AC4AF63;
	Tue,  7 May 2024 07:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715068711;
	bh=89t9B5VtRJzNfp6Wda6X2h6J58Yiwx7TQOCpbZd8Iu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BygZ6Mnl8LUBUOC0U0HyPNQ4qRDxoGM3qPH2R+ejDkRM3cBW88z5gVKCk0E/JcVE0
	 d4PZQQmhV6iWOR0xAT5gUVEXZB553khNpiLpHtl8aRl30G39M0zySiT5koWYH7aX8Q
	 E+ngcLyNg0lAVjttos/kNMyxcRrFRlfj6V/vTF1sk3VkmLBEIdp55uGvVBy+/G7eB5
	 9sffzofGRbfxw/72ttntxOnV0GjldoUc8i/ItJ9lCs+EXAyOL/wnaeaA7RslA97NSz
	 KL17gfTXiW60Yp5QqfU9nrj6Edvy16th/Fil0CDZ5u1WJ/3Wzr8qu/+sxw+q4h/e3e
	 UT5h4HK/u9Peg==
Date: Tue, 7 May 2024 09:58:25 +0200
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
Message-ID: <20240507-shiny-sophisticated-mustang-bf2d2e@houat>
References: <4d8f4c9b-2efb-4774-9a37-2f257f79b2c9@linux.dev>
 <20240504122118.GB24548@pendragon.ideasonboard.com>
 <20240506-charcoal-griffin-of-tact-174dde@houat>
 <20240506073531.GA10260@pendragon.ideasonboard.com>
 <97811bfe-a1fb-419c-a148-74e3d84aa0e2@linux.dev>
 <20240506165057.GD29108@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="b3imapilpypz3bfe"
Content-Disposition: inline
In-Reply-To: <20240506165057.GD29108@pendragon.ideasonboard.com>


--b3imapilpypz3bfe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2024 at 07:50:57PM GMT, Laurent Pinchart wrote:
> On Mon, May 06, 2024 at 10:57:17AM -0400, Sean Anderson wrote:
> > On 5/6/24 03:35, Laurent Pinchart wrote:
> > > On Mon, May 06, 2024 at 09:29:36AM +0200, Maxime Ripard wrote:
> > >> Hi Laurent, Sean,
> > >>=20
> > >> On Sat, May 04, 2024 at 03:21:18PM GMT, Laurent Pinchart wrote:
> > >> > On Fri, May 03, 2024 at 05:54:32PM -0400, Sean Anderson wrote:
> > >> > > I have discovered a bug in the displayport driver on drm-misc-ne=
xt. To
> > >> > > trigger it, run
> > >> > >=20
> > >> > > echo fd4a0000.display > /sys/bus/platform/drivers/zynqmp-dpsub/u=
nbind
> > >> > >=20
> > >> > > The system will become unresponsive and (after a bit) splat with=
 a hard
> > >> > > LOCKUP. One core will be unresponsive at the first zynqmp_dp_rea=
d in
> > >> > > zynqmp_dp_bridge_detect.
> > >> > >=20
> > >> > > I believe the issue is due the registers being unmapped and the =
block
> > >> > > put into reset in zynqmp_dp_remove instead of zynqmp_dpsub_relea=
se.
> > >> >=20
> > >> > That is on purpose. Drivers are not allowed to access the device a=
t all
> > >> > after .remove() returns.
> > >>=20
> > >> It's not "on purpose" no. Drivers indeed are not allowed to access t=
he
> > >> device after remove, but the kernel shouldn't crash. This is exactly
> > >> why we have drm_dev_enter / drm_dev_exit.
> > >=20
> > > I didn't mean the crash was on purpose :-) It's the registers being
> > > unmapped that is, as nothing should touch those registers after
> > > .remove() returns.
> >=20
> > OK, so then we need to have some kind of flag in the driver or in the d=
rm
> > subsystem so we know not to access those registers.
>=20
> To avoid race conditions, the .remove() function should mark the device
> as removed, wait for all ongoing access from userspace to be complete,
> and then proceed to unmapping registers and doing other cleanups.
> Userspace may still have open file descriptors to the device at that
> point. Any new userspace access should be disallowed (by checking the
> removed flag), with the only userspace-initiated operations that still
> need to run being the release-related operations (unmapping memory,
> closing file descriptors, ...).

And for the record, this is exactly what drm_dev_unplug and
drm_dev_enter/drm_dev_exit does.

Maxime

--b3imapilpypz3bfe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZjnfHAAKCRAnX84Zoj2+
dt4DAX99RTnsezwYkS/RSibP1NcxpL4CCKZoY9wdmzD1LxPobMHewTlZzvejJrXZ
QgpabNMBgLzWSoWR5Wi5zbucVnQobQJp7d2zppixk1EbwNiUsNOS+Z9XcAL4Dkfe
DWQ6ip9F1w==
=oZkN
-----END PGP SIGNATURE-----

--b3imapilpypz3bfe--

