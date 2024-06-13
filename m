Return-Path: <linux-kernel+bounces-212722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7F190654F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A91051F229B5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 07:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6188113C3E2;
	Thu, 13 Jun 2024 07:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luKu3yvT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A922F7F7FB
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 07:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718264251; cv=none; b=o5iYGl7xgI9OUy83yRh+8TiQTrgOwXj/4pEieNVaUFK0oFCLNdHsNdoqpXO9TcxAvJMVjWVZIYVrFxEYXUVVQayziBBSnyv9iV9pbTRxASIgIOQV4D/0h6DeHiMjJBuo9vMEHnApoqpysgAAeSlTag/Xk+sUBp5bHKFEokptnC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718264251; c=relaxed/simple;
	bh=ImQIKeourXR7ChWq71b/VBnDWCOFJA52mX9HCcaGd1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awjfUGHlhZDWqLrxhHI3mpTwsRp7f+TkRE1oPnolYEqpDwPIRq7Gv/Nbkx1ZdLa6AkLQFmIZdgEJpamBdbkim5GyTvYydXXQt7gzqVSuhQMSes4zMpaG3zLuSDBX3l5/nTuYpo1AhNWZATYK0ATtHN4YpBunMOZOs1a/nixMIXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luKu3yvT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D66C2BBFC;
	Thu, 13 Jun 2024 07:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718264250;
	bh=ImQIKeourXR7ChWq71b/VBnDWCOFJA52mX9HCcaGd1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=luKu3yvTIy2XOk2lmMPaECP1FftDpr6pA6SYtsDbJw8zHbyxpEfpy/WnabEI99USF
	 ACFZiEc5/RRQZw8nHw420Id/bTXr9ADTRXUvl80bcWFamra239SH6rRse0Ypiqj3Hp
	 zFK0Lrsi6K3R9peez2wjtrYXL5hmQM3GqXm7oNsMjc9IGvkfEH7/Ov0cymhzmAuT5f
	 7ozb3rdWb/aa4XTsmXQJ0CxHefW6Q6uLTkrId7LoHHkPdmSDPTtNZzNrspskk3bjBH
	 o7CtN3yIBtYb6kVipz+3ggwzE2bpZiBFHxHhpjvgliCRTHJPlqVP7N3nX72jTD6Uxl
	 hIjbOioU1VgQw==
Date: Thu, 13 Jun 2024 09:37:27 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, airlied@gmail.com, daniel@ffwll.ch, 
	rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com, mairacanal@riseup.net, 
	hamohammed.sa@gmail.com, robdclark@gmail.com, maarten.lankhorst@linux.intel.com, 
	tzimmermann@suse.de, daniels@collabora.com, helen.koike@collabora.com, 
	guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] drm/ci: add tests on vkms
Message-ID: <20240613-bipedal-eccentric-locust-91632b@houat>
References: <20240611091037.558969-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cpuibrkaoumlir3j"
Content-Disposition: inline
In-Reply-To: <20240611091037.558969-1-vignesh.raman@collabora.com>


--cpuibrkaoumlir3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Jun 11, 2024 at 02:40:37PM GMT, Vignesh Raman wrote:
> diff --git a/drivers/gpu/drm/ci/xfails/vkms-none-flakes.txt b/drivers/gpu/drm/ci/xfails/vkms-none-flakes.txt
> new file mode 100644
> index 000000000000..56484a30aff5
> --- /dev/null
> +++ b/drivers/gpu/drm/ci/xfails/vkms-none-flakes.txt
> @@ -0,0 +1,15 @@
> +# Board Name: vkms
> +# Bug Report: https://lore.kernel.org/dri-devel/61ed26af-062c-443c-9df2-d1ee319f3fb0@collabora.com/T/#u
> +# Failure Rate: 50
> +# IGT Version: 1.28-g0df7b9b97
> +# Linux Version: 6.9.0-rc7
> +kms_cursor_legacy@long-nonblocking-modeset-vs-cursor-atomic
> +kms_flip@basic-flip-vs-wf_vblank
> +kms_flip@flip-vs-expired-vblank-interruptible
> +kms_flip@flip-vs-wf_vblank-interruptible
> +kms_flip@plain-flip-fb-recreate-interruptible
> +kms_flip@plain-flip-ts-check
> +kms_flip@plain-flip-ts-check-interruptible
> +kms_flip@flip-vs-absolute-wf_vblank
> +kms_flip@flip-vs-absolute-wf_vblank-interruptible
> +kms_flip@flip-vs-blocking-wf-vblank

We should have the header for every line here

Maxime

--cpuibrkaoumlir3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZmqhtwAKCRDj7w1vZxhR
xVWRAQCG+ScbgEMo6+BuqdxIkn+RGcHtaRDZ9dEXREDfww2gPAEA8mPYOf4Ta5YU
fw2ffV8wY75ewIayYsyhkQp4pA14AQs=
=/cnS
-----END PGP SIGNATURE-----

--cpuibrkaoumlir3j--

