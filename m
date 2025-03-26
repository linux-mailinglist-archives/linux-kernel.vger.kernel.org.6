Return-Path: <linux-kernel+bounces-577249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BDDA71A76
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEF893A4517
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9395E1F3BB2;
	Wed, 26 Mar 2025 15:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RriZcuFo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ED414A4C6
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 15:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743003152; cv=none; b=m9IKb2y5d0G4U/8yCxX5I0D1+mfwdMCfI4lVPVva9kBuCvdkLl3D2xp/oweyXbVjY0rsxViXzYt1oPzNG8WPKg8qV5ejkAmxePvqsMyslbw43DGVwU74gzPS2Gkf3ydzWNi9Z31jFhyTVK4LfgIL8S/Xj3haSemac9A4AEcL8E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743003152; c=relaxed/simple;
	bh=SPxu0Io7cx5liXuAr8Xi+OAnanZNKgiFPCAgw/m0XBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aE5HQ0n/qIV8G3W47BqMOo5qIks4xi6YXWe2l00dHCMs8u38sGLghp/3pMa6vCNGzo8YNImqmzUn3IXZY6NNG7LICw+brJLos6Q3owLWMdXYtTqQuggZ0L7TOS9UTzvlY9Jt0m4HgKoVyA8bVt2uwq+3Q00ERMuY2zSIlSQ1jqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RriZcuFo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2593DC4CEE2;
	Wed, 26 Mar 2025 15:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743003151;
	bh=SPxu0Io7cx5liXuAr8Xi+OAnanZNKgiFPCAgw/m0XBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RriZcuFozA+6QY0rYZQajMOGCFMyzsBT1xUrHVw7tHBRWOhu+WqmKx15XlXLodKOt
	 i3++BC6wcOmNRYZ2kf1sbJ3UgWQl4d6Wvxi0CN9NIXCtollhGB7urmdNqyAdQkAr+Z
	 359fT6wBxBUldjuwdHtyVWtNUELDSUmyEHhuInCL/dKWik1wR0ClMfwSubZIAzYp4p
	 2x8eoIpPOlRON/2fVGfAQnU/8nRaGqOqzPEdVrGKolvD9fwUz1GHSP6YpM+MsRiPsf
	 dpvJk33x8erFxRgGLD2II05q4E0htyzvJrjL6VLwtNcSuiNh09sdW4STOLed+8UIUB
	 huKnne7Z68ytg==
Date: Wed, 26 Mar 2025 16:32:29 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Anusha Srivatsa <asrivats@redhat.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 4/5] drm/panel: deprecate old-style panel allocation
Message-ID: <20250326-deft-vegan-stoat-ff14ff@houat>
References: <20250325-b4-panel-refcounting-v1-0-4e2bf5d19c5d@redhat.com>
 <20250325-b4-panel-refcounting-v1-4-4e2bf5d19c5d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5ozty4m4m7wvakqd"
Content-Disposition: inline
In-Reply-To: <20250325-b4-panel-refcounting-v1-4-4e2bf5d19c5d@redhat.com>


--5ozty4m4m7wvakqd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/5] drm/panel: deprecate old-style panel allocation
MIME-Version: 1.0

On Tue, Mar 25, 2025 at 01:24:11PM -0400, Anusha Srivatsa wrote:
> Start moving to the new refcounted allocations using
> the new API devm_drm_panel_alloc(). Deprecate any other
> allocation.
>=20
> Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
> ---
>  drivers/gpu/drm/drm_panel.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index 11a0415bc61f59190ef5eb378d1583c493265e6a..5793011f4938a2d4fb9d84a70=
0817bda317af305 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c
> @@ -74,8 +74,10 @@ EXPORT_SYMBOL(drm_panel_init);
>   * drm_panel_add - add a panel to the global registry
>   * @panel: panel to add
>   *
> - * Add a panel to the global registry so that it can be looked up by dis=
play
> - * drivers.
> + * Add a panel to the global registry so that it can be looked
> + * up by display drivers. The panel to be added must have been
> + * allocated by devm_drm_panel_alloc(). Old-style allocation by
> + * kzalloc(), devm_kzalloc() and similar is deprecated.

It's not that it's deprecated, it's that it's unsafe. Since you already
said that the allocation must be done through devm_drm_panel_alloc(),
there's not much use to mention the old style stuff, I'd just drop the
last sentence.

Maxime

--5ozty4m4m7wvakqd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZ+QeDAAKCRDj7w1vZxhR
xXTHAQCc+DC/5rdeBP/uekSpO7skP6d+j8o6RjjWhw/KxNkDSwEApCzCZMZTIZ5e
yLjpLaIpTIXpA3IMrUaV2mCS5wP5Hw0=
=mCCS
-----END PGP SIGNATURE-----

--5ozty4m4m7wvakqd--

