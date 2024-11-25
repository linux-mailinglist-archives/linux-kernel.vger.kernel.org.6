Return-Path: <linux-kernel+bounces-421027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE5D9D85F7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C583AB2BC95
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEBB18D625;
	Mon, 25 Nov 2024 13:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6nRHOTZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D026E944F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 13:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732539818; cv=none; b=qQS3CQ6AH5x3hw9j6ywrhm6J9Vq9/DLCljXIYBd7wDHFS5rTdcAOYfH5DO5IBr68ph6sHBYYERNtN6+88U0KEwj0lKmyvb4Fxk7j0MFXqpwU/U1XSVGmDch2E4TpW3zexlHaCmyJqhajBrNwv7E/6JEy46D1a4TySqo1fhuVmws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732539818; c=relaxed/simple;
	bh=6Zaiawin6pfWkWRIrFvVpjQcdvy8Et+XVajlh07pY3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzW4XmVXa4O6RpMg1G2qGgZhVt7ACJHObdavbIaSehJQpvlQS8WQ1MDSpfjg3t6tDRxqD34oH3s6Narolp1spS5doqjs48VI9ta66hSf9O+sr5XUTYtuXziZ/xhOYz6vMswhG8Gm5zrgEPboeS43JkTEtlH5jAfop7Ctm4BViRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6nRHOTZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9C6C4AF09;
	Mon, 25 Nov 2024 13:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732539818;
	bh=6Zaiawin6pfWkWRIrFvVpjQcdvy8Et+XVajlh07pY3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X6nRHOTZtoTKTwlHbL0+UCz3mBGJ6zPxtQ+ih3rtAdBIf4sg++TaNU88PuKAthBjp
	 Y0tx3rs6kODwoxJoTVImx36sTaAdPfIyfvkZ1afY1Z/CFZSXAdemIuVuM8IQiBLcDW
	 ZWKoy6xp8OKBGhCEpIU+wtbwzcPlAYUdeJajro2pOAF6b6qHGFWBQ7uIBhdEOdv3ut
	 xIuyl7l+mryQ8KBj2u64rTCgbYYhVdnKslQMlwb8mnjky4lxWNujEgW8XoiuRuUQdj
	 D+oLo0ehkJk8Y/8R4iGf3ADR/me4YlvKzLJg2QQeBPEwD46yle5d4PFWSKAaGgVXnW
	 mgmtgsRHn9W+w==
Date: Mon, 25 Nov 2024 14:03:35 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
	Melissa Wen <melissa.srw@gmail.com>, =?utf-8?B?TWHDrXJh?= Canal <mairacanal@riseup.net>, 
	Haneen Mohammed <hamohammed.sa@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Simona Vetter <simona.vetter@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net, linux-kernel@vger.kernel.org, 
	jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
	seanpaul@google.com, nicolejadeyee@google.com
Subject: Re: [PATCH v5 4/5] drm: writeback: Introduce drm managed helpers
Message-ID: <20241125-able-spectacular-weasel-83e955@houat>
References: <20241122-google-vkms-managed-v5-0-1ab60403e960@bootlin.com>
 <20241122-google-vkms-managed-v5-4-1ab60403e960@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="jfnmezvlk6xplaz3"
Content-Disposition: inline
In-Reply-To: <20241122-google-vkms-managed-v5-4-1ab60403e960@bootlin.com>


--jfnmezvlk6xplaz3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 4/5] drm: writeback: Introduce drm managed helpers
MIME-Version: 1.0

On Fri, Nov 22, 2024 at 05:27:59PM +0100, Louis Chauvet wrote:
> Currently drm_writeback_connector are created by
> drm_writeback_connector_init or drm_writeback_connector_init_with_encoder.
> Both of the function uses drm_connector_init and drm_encoder_init, but
> there is no way to properly clean those structure from outside. By using
> drm managed variants, we can ensure that the writeback connector is
> properly cleaned.
>=20
> This patch introduce drmm_writeback_connector_init, an helper to initiali=
ze
> a writeback connector using drm managed helpers. This function allows the
> caller to use its own encoder.
>=20
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>

See https://lore.kernel.org/all/20241024-slim-onyx-emu-3e4869@houat/

Maxime

--jfnmezvlk6xplaz3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ0R1ogAKCRAnX84Zoj2+
dm8NAX4sHCLHMseClxDmuFB0kJcMu/MTvHxXEF9heDnOR9V0dZ5LdSnOuzEakbus
NrjBMAsBgIifXCWrFDsSzyERc48SvRraqLp0BOrMD6HBq9BwFDfs+nweqEaFURJA
s561g218wA==
=h3UH
-----END PGP SIGNATURE-----

--jfnmezvlk6xplaz3--

