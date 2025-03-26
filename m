Return-Path: <linux-kernel+bounces-577246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7820A71A47
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82E5E16D076
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CF31F3BBB;
	Wed, 26 Mar 2025 15:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaP+Kg4J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C8D13B7A3
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 15:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743003015; cv=none; b=kL2/fJV7PgMHmk8oox+C5tsGY0Fad42+4YrmOJqiOr6ebsDuO0PAceNMlU4eo1BLJWuZFJPG990FtmOEKBApTZeEb0ziclaqqorNMwmdR2gxXPsG3gbdxSQF57Q5cAI/UQ9T3Ef1MIm9eyFubuCBvzvclXGp8xMwxbnCRqEjXNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743003015; c=relaxed/simple;
	bh=TeB6D6AmiWYlcJujHXlvdqSxpcIN79E+17sC10w3lzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmSBnOD/kaBa5sBwLcApAwHiIwUdShbCOJsm37YEBZu7+lZ916pUQx5W8mQXyYeLrcov4R779bm2LQ3FpD4Cj5gqIsZixMX0YJIKRyfcwEJHS3LAKAUYUISsPRbFg5ccDIu5jowa2I8TwHlcsU6UCwRAsEeXI6iejYidoCUF9fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaP+Kg4J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C5AC4CEE2;
	Wed, 26 Mar 2025 15:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743003015;
	bh=TeB6D6AmiWYlcJujHXlvdqSxpcIN79E+17sC10w3lzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MaP+Kg4Jm+Lbs9xo6HPLVa7Uafk/BUH8+5nA0H2RfrBZTevyA8tQf6PK84q0vmJk9
	 n5R2AHp9Wy36yl6cbZrdb8XsjMoxS7aMnDHOb4MRO67roMi1nlACTgmqH+AcBF/UQd
	 ps/9WvuDWwUOxNE1xTW8ILz+rGAsRhzBslP8ENVP1wI8Uri9pasbW+iL1jrVoJ64jg
	 ymVy2S1cJO39B3lDFG7ypfRZNt+xf8G8x02YpFzrXFKCvdg3yXyvcWHK6g2sytoJG2
	 yFh/AffrH1SZALBkErcWMxJ85uh/JrZEKBxuZFgu+4nm6Oq7ZO6J1D21XcsbuM8nTw
	 DTF4OLcfw3fCg==
Date: Wed, 26 Mar 2025 16:30:12 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Anusha Srivatsa <asrivats@redhat.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] drm/panel: Add refcount support
Message-ID: <20250326-crazy-brilliant-lyrebird-4658a0@houat>
References: <20250325-b4-panel-refcounting-v1-0-4e2bf5d19c5d@redhat.com>
 <20250325-b4-panel-refcounting-v1-2-4e2bf5d19c5d@redhat.com>
 <20250326102304.49510630@booty>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="im2pz5whtdrkkr4p"
Content-Disposition: inline
In-Reply-To: <20250326102304.49510630@booty>


--im2pz5whtdrkkr4p
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/5] drm/panel: Add refcount support
MIME-Version: 1.0

On Wed, Mar 26, 2025 at 10:23:04AM +0100, Luca Ceresoli wrote:
> On Tue, 25 Mar 2025 13:24:09 -0400
> Anusha Srivatsa <asrivats@redhat.com> wrote:
>=20
> > Allocate panel via reference counting.
> > Add _get() and _put() helper functions
> > to ensure panel allocations are refcounted.
> > Avoid use after free by ensuring panel is
> > valid and can be usable till the last reference
> > is put. This avoids use-after-free
>=20
> "panel is valid and can be usable" is not totally correct. When there
> are still references held, you ensure the panel struct is still
> _allocated_, not necessarily valid and usable.

I guess "panel pointer is valid" is a better wording indeed.

> > +/**
> > + * drm_panel_put - Release a panel reference
> > + * @panel: DRM panel
> > + *
> > + * This function decrements the panel's reference count and frees the
> > + * object if the reference count drops to zero.
> > + */
> > +struct drm_panel *drm_panel_put(struct drm_panel *panel)
> > +{
> > +	if (!panel)
> > +		return panel;
> > +
> > +	kref_put(&panel->refcount, __drm_panel_free);
> > +
> > +	return panel;
>=20
> While this is using the same structure as my bridge work, I now realize
> the _put() should probably not return the panel (or bridge) pointer, it
> should just be a void function. The reason is the pointer might have
> been freed when _put() returns (depending on the refcount) so that
> pointer value might be dangling and whoever calls _put() must not use
> that pointer anymore.
>=20
> Other get/put APIs do this, e.g. of_node_get/put().
>=20
> So I'm going to change drm_bridge_put() to return void, unless there
> are good reasons to keep it and that I'm missing.

Oh, right, definitely.

Maxime

--im2pz5whtdrkkr4p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZ+QdhAAKCRDj7w1vZxhR
xac3AP4v6vCSJmHzeBPGjiw3ELrWvb4fWG8OFdEqXe3xei+ynwEA9peid70Pg1ZG
7QMf6BMoUbn5Lw5aMWwgwBzO1EstwAg=
=LMsb
-----END PGP SIGNATURE-----

--im2pz5whtdrkkr4p--

