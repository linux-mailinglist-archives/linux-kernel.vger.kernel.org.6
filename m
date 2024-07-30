Return-Path: <linux-kernel+bounces-266864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920E39408DA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C432A1C224A1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 06:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DBF161939;
	Tue, 30 Jul 2024 06:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nB8GEkGX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9342563
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 06:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722322058; cv=none; b=r7ZFTF8kiHjyYmO+OxkpIwjpd7Qz0LDDcNPS+vl/JGK9r0Ogx9kDk+7HH5NLJkngxQbqOoYT2PPsUxz6QwkWubBhliGwzuUNvr0sivuB276svp4yd3F/co10nUutgBImhjYj0CsX8k5EGuiKYsLTh66cyW/ejF+GoAoZeOYyrH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722322058; c=relaxed/simple;
	bh=+NfQecz0SKCsPSuZEXvhRx0AI9TiQXhzPWEVevRaWWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otm3vPvaWq/LFllZ6KklszjN/13y4rODFj97vBckJomXcp0PlKQ07CETftBSBNZg2SImcqmEIn9NGb8ywKXWzEJ8zLAhjb9ly0sDZXpIF/vGHUKNTMspwbhUlLkoNz5xMgXWSAyDx5LfgLz5/PgZUTzwnl89C15XHlaCDkVwquM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nB8GEkGX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 968DFC32782;
	Tue, 30 Jul 2024 06:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722322058;
	bh=+NfQecz0SKCsPSuZEXvhRx0AI9TiQXhzPWEVevRaWWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nB8GEkGXOvqs9QvxBs9tqvUvgsQV6wNAmcoiZf/okaRcZ+tOfhiwiGWlYaqLS/rKn
	 6XASAa1zWSsqZA1qB3M6GxvWGg0GpI61WgZ6GIkW5nbSw9HyAwDnEYHx9XiEAJ6X1i
	 AX4yLlwx7Ro6XETzcKp7kD5Ku2a5ocgLdm5Hn6PoaMA3307xX1l6ZQ/dtLDqn6Sid1
	 67etyhkDgwnDdGT1fZ73g6Pl+QQ7QhSPMx89xFXPavpRBrzTR3/DAg2MRIswgUGqWH
	 wsskoMCEf6hRUcB0NHIj/ZMxHhd3kBM+PInQEt1qcvF3OJMdw/RquUduXpJxF4qCJ0
	 WcCH9j5pWG9Jw==
Date: Tue, 30 Jul 2024 08:47:35 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, dianders@chromium.org, 
	airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drm/mipi-dsi: add more multi functions for better
 error handling
Message-ID: <20240730-winged-terrestrial-sheep-a3ba24@houat>
References: <20240730060659.455953-1-tejasvipin76@gmail.com>
 <20240730060659.455953-2-tejasvipin76@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="oouif7llugnahlev"
Content-Disposition: inline
In-Reply-To: <20240730060659.455953-2-tejasvipin76@gmail.com>


--oouif7llugnahlev
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 11:36:58AM GMT, Tejas Vipin wrote:
> Add more functions that can benefit from being multi style and mark
> older variants as deprecated to eventually convert all mipi_dsi functions
> to multi style.
>=20
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

We should also add a TODO note to convert existing drivers to the _multi
variant and get rid of the !multi one when it's done.

Maxime

--oouif7llugnahlev
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZqiMggAKCRAnX84Zoj2+
dsX3AX4sEJBP+AahNaviyuM2GXc+wzF/sWaiCLh6oHVkx83Vr9SEEvg0FGBXcvir
Ataw6AABfj5cZd6uHXG2GNXWt0MV3oQceIRff7o3ubI37qvClIbyHFtyZ5eLMoIN
SQNYlMlFuw==
=gWfl
-----END PGP SIGNATURE-----

--oouif7llugnahlev--

