Return-Path: <linux-kernel+bounces-514988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97425A35E46
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E5813B2BAB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7972673A4;
	Fri, 14 Feb 2025 12:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDnSVwqf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADBD267397
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 12:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537945; cv=none; b=qRZBq+itrSk7MU0sfyxt4ur1wt4x8EBScA+kRYtiViygki33Jnvu7qS/E6Dg9BWBS7RGgyj5kXDBuQkE1NunlDi+uW1RANyqwQ46Ke+rvOTJTCtDqj3DKS69VOmC+oJd/rhpfTpb9TWEl1kMpJxpBM1KboPKHQFd8AdAMjSyA1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537945; c=relaxed/simple;
	bh=xnL5roeRyaUK5/UTEapgfClZfOGKu54LwE3xY8RZjwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaiMxn7BLtmMO84+O9LxRPW5MgirRxc58o0Ht/31WJ/rUIvyiOCzNNTv95Ev9/qL0sfFjlC1udAmtJzqapbhtdkI5FfDbWK8q22JY73wmmuCZMIo0At91RYs2xXxd0T21dI/iA59E81nesKo/QhTkk0hk20yk0DfJEK8hX3XOXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDnSVwqf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5DAC4CEE6;
	Fri, 14 Feb 2025 12:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739537944;
	bh=xnL5roeRyaUK5/UTEapgfClZfOGKu54LwE3xY8RZjwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PDnSVwqf2bT+JVes18OBSs9+X8bW4sk1MXFracTGyBEM0W+6qGxyYOp+T+LHlNaQg
	 gGZge+yKfKwnRnFlbe61b80MzImGqkwgvZLtCfQ+p7+k10cjx+OGH+QfeakGjK8ruI
	 WEjKrV/fYOAvsdBaNX0gvJJYa1fsopROQT0bwpmJ3rxoCdrrXZhOYkKe0cQTEnT/Wr
	 EF6lgMDDwO2wHDlwI4Kx4iZ2K0OG1dIES0KGGhiBoaq+GHrRI0Hl85lFQIiDvNBBnJ
	 7Ms9IIs5WMa4IsOxmupgNGJZZQ/HeTY1EhjLdMoXqNW8mr3wY3AeQVqFalChpMWnt0
	 H2yOlhoYzBFCA==
Date: Fri, 14 Feb 2025 13:59:01 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 30/37] drm/bridge: Assume that a bridge is atomic if
 it has atomic_reset
Message-ID: <20250214-icy-earthworm-of-happiness-6bca70@houat>
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
 <20250213-bridge-connector-v3-30-e71598f49c8f@kernel.org>
 <vjdpctck2afcjrt2rlgjtzmrkf4a5bg5ihymc53vuw6md576wd@kbb5y27a5woi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="7xu255utmz4lugjt"
Content-Disposition: inline
In-Reply-To: <vjdpctck2afcjrt2rlgjtzmrkf4a5bg5ihymc53vuw6md576wd@kbb5y27a5woi>


--7xu255utmz4lugjt
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 30/37] drm/bridge: Assume that a bridge is atomic if
 it has atomic_reset
MIME-Version: 1.0

On Thu, Feb 13, 2025 at 06:29:46PM +0200, Dmitry Baryshkov wrote:
> On Thu, Feb 13, 2025 at 03:43:49PM +0100, Maxime Ripard wrote:
> > The drm_atomic_bridge_check() runs the atomic_check callback if needed,
> > or falls back to mode_fixup if it's not there.
> >=20
> > Going forward, we'll need to setup the bridge atomic state even though
> > drivers might not be implementing atomic_check at all.
> >=20
> > We can thus switch to using drm_bridge_is_atomic() to take the atomic
> > path, and do additional things there in the future, or go the mode_fixup
> > route.
>=20
> This will break bridges like tc358768, rcar_lvds and mtk_hdmi: they
> implement atomic_reset() and mode_fixup().

What is your suggestion then? I kind of did what you were suggesting on
patch 1, but it wasn't working. Then you want me to roll back to that,
or something else?

Maxime

--7xu255utmz4lugjt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ68+EAAKCRAnX84Zoj2+
duVPAX9RWiQ9+jWgdM6ESAMNwaYpcNcURXyxAsSygsXExJ5yfs3sA+eRSXUdufcw
tyFdbfEBgKNPYZt3cWfztBz3p4+/y2bAl+25qcUw/nZaffsxmlGDMoiHBqq5jsff
sba18eOz8Q==
=CRpZ
-----END PGP SIGNATURE-----

--7xu255utmz4lugjt--

