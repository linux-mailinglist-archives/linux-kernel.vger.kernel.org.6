Return-Path: <linux-kernel+bounces-577240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A9FA71A54
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E15D3A5025
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500F91F2B8B;
	Wed, 26 Mar 2025 15:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibhRk9N+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C1A1E8349
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 15:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743002810; cv=none; b=YmZnn3Kws3qPeMv6PUgWcDLO5ksdvqaCpdLTsI4q/m0ua49wcjitLa4Ropn3FpdOZl7nKHiA3YskpdVoj+W0QdQz1PphHtP6rg3za2JG86OsM8Yu0aTI5+K4L6i3YwpLCDd+OLMOSHRdgItlTJoR1nNh7hjgR8OT3Bf/yj+pnso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743002810; c=relaxed/simple;
	bh=E3LVCXLoRzbhs4MzPU/33YNPn5UAO0vP8mj3ilyU6MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLtjr7iTPuEb00R54mXm1U+QjiTPEp/rI/fm6nGTHaPfXi8mAFxeTG5c+8h6n44YeugVOnGkjKuHAigUc5k/ianyyqxWlxANmD0MbMcgUzH8e1LXxSDjK91sivnjsv+0hnTJbFgEZWZEVY5ZQYX16+ooduXOoIWDaSVUoYWDFZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibhRk9N+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD585C4CEE2;
	Wed, 26 Mar 2025 15:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743002810;
	bh=E3LVCXLoRzbhs4MzPU/33YNPn5UAO0vP8mj3ilyU6MU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ibhRk9N+8JE80IkNKOMMxpqqoMdJJsAZ7apRKKEOTN17yaiQBtdMMPI8Qnu4WlT9e
	 p02y4Op1o8uWoq2qdPHVjYsjl/O+CUFdMIcLF4CU6YT1efrGgfEUkeKmAPpcvW3Wuy
	 hrtsVDWnjiFPemqHMG7LEGmlvHmFWwPo2LJG4+Nq88zffW6Tib0SzqhuXxHZSh87M3
	 E5GcfkttsX/C3G3yk3zFkDM0RO3O/tPutcaa1REMUfemtCfdu1TRCae5APvbGj0S+Z
	 MhABIa2aq+dfzWBb7PicBNq94fMySf4sTALjbFVaGnJMEnM0GCutN/9lpsQQvHk0z6
	 VeYzPfk7jn7aQ==
Date: Wed, 26 Mar 2025 16:26:47 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Anusha Srivatsa <asrivats@redhat.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] drm/panel: Add new helpers for refcounted panel
 allocatons
Message-ID: <20250326-camouflaged-satisfied-quokka-8d5afc@houat>
References: <20250325-b4-panel-refcounting-v1-0-4e2bf5d19c5d@redhat.com>
 <20250325-b4-panel-refcounting-v1-1-4e2bf5d19c5d@redhat.com>
 <20250326102259.3bdbc22d@booty>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kx76iyfxdbnxqini"
Content-Disposition: inline
In-Reply-To: <20250326102259.3bdbc22d@booty>


--kx76iyfxdbnxqini
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/5] drm/panel: Add new helpers for refcounted panel
 allocatons
MIME-Version: 1.0

On Wed, Mar 26, 2025 at 10:22:59AM +0100, Luca Ceresoli wrote:
> Hello Anusha,
>=20
> On Tue, 25 Mar 2025 13:24:08 -0400
> Anusha Srivatsa <asrivats@redhat.com> wrote:
>=20
> > Introduce reference counted allocations for panels to avoid
> > use-after-free. The patch adds the macro devm_drm_bridge_alloc()
> > to allocate a new refcounted panel. Followed the documentation for
> > drmm_encoder_alloc() and devm_drm_dev_alloc and other similar
> > implementations for this purpose.
> >=20
> > Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
>=20
> [...]
>=20
> > +void *__devm_drm_panel_alloc(struct device *dev, size_t size, size_t o=
ffset,
> > +			     const struct drm_panel_funcs *funcs,
> > +			     int connector_type);
> > +
> > +/**
> > + * devm_drm_panel_alloc - Allocate and initialize an refcounted panel
>                                                      ^^
> "a refcounted panel"
>=20
> > + * @dev: struct device of the panel device
> > + * @type: the type of the struct which contains struct &drm_panel
> > + * @member: the name of the &drm_panel within @type
> > + * @funcs: callbacks for this panel
> > + * @connector_type: connector type of the driver
>=20
> I'd say it's the connector type in the hardware, rather than of the
> driver (the driver follows what is in the hardware. Maybe you can just
> copy the description present in the drm_panel_init kdoc:
>=20
>  * @connector_type: the connector type (DRM_MODE_CONNECTOR_*) correspondi=
ng to
>  *      the panel interface (must NOT be DRM_MODE_CONNECTOR_Unknown)
>=20
> Other than that it looks good!

Heh, Unknown is fine, but you're right for the rest. I'd use the
drm_panel_init doc for that field actually.

Maxime

--kx76iyfxdbnxqini
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZ+QctgAKCRDj7w1vZxhR
xW8DAQD40+ulGnIJEDIE/lvd8rfwdrKdgFym/9bSB9uZ01XXHAEA5MNcCIEyKhj4
MGIvSR/D/1GUWfEkNBH4dz32KHIupgA=
=9uMY
-----END PGP SIGNATURE-----

--kx76iyfxdbnxqini--

