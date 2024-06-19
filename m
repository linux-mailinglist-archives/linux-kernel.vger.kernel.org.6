Return-Path: <linux-kernel+bounces-220976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C5390EA06
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6971F2275F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B196213D63B;
	Wed, 19 Jun 2024 11:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNBe9kqa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FF44D8B2;
	Wed, 19 Jun 2024 11:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718797720; cv=none; b=M0mfhKAKFStbZg+O//Uulobp1v1oUQkKOiEgmjRHBjYaeN7EIJbdPsjguacrtDaHn3C8ZuzQJxNpnnbEc3iLSJ7H1FxdH/sAxpKj4xQuBFBs9SfmRTYVmHBz3ZDau7GGrFetKcMe0ylccbkiaTA0Bi7YAo/omRSai//GRpgff24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718797720; c=relaxed/simple;
	bh=w5cAoAASm64T8m5tiTn2cbQG1dthfwLRAJsS/gRwIq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0TCMKO60bKPgKpSx2UTDNMgO0OaFVslzD6PYngTmxL/oKDBdAY4otxO7n+1QLsPN1zNNxeluuqQnWTUr1R6GhcN8krrTSg/T5LUqrvw8EqpPU3yUbqgIWi+c7x/di8WxrfYU1crd0EJ+c+LmaCBMI9Ukn35oHsYziSYxwpnpNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNBe9kqa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B867C2BBFC;
	Wed, 19 Jun 2024 11:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718797719;
	bh=w5cAoAASm64T8m5tiTn2cbQG1dthfwLRAJsS/gRwIq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XNBe9kqaZNNPx71tIPgLgXf/cuAJXpwV+qaC7uKM/aRgcTBYeBVvyZ5I6BHBpUIcN
	 H61cQcb8bYYpVHIGUcL24i8Jw5lO1CbV4huegFSRDfakfH3AYswsQwJyhZujvZdtwn
	 Rnvm+L67r9hNDlE+/wV7b/1ijIJLXMX0aTa6Y3fXO/B3gzCZXaDxMhNm01JwP8lfVJ
	 kNSsmJPcmK6PFAJUxP8ZQ8mZTK/2GXpMEVLfWX8ePAmNn4Rim0L6GUbt4/tw+TG6Y9
	 9ZJU6zHN130/bKYvDVOzzNFUBgoY+iiK3ydS/Xte0a+R0zWNB8fPWgh242UNeOI4Aq
	 PFEtr0VhHWjKA==
Date: Wed, 19 Jun 2024 12:48:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Simon Trimmer <simont@opensource.cirrus.com>,
	linux-sound@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] ASoC: cs35l56: Accept values greater than 0 as IRQ
 numbers
Message-ID: <3abde78c-aae9-445a-b8a0-a09e4079006b@sirena.org.uk>
References: <20240617135338.82006-1-simont@opensource.cirrus.com>
 <fe9dd613-8909-4c7d-a7d7-9094b75fe8fb@opensource.cirrus.com>
 <941d2b8a-18b5-43ad-9aec-6785f841dfaa@sirena.org.uk>
 <97da8398-599e-45cb-abb2-97cc66567628@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VR6AEZOBN5xY1cCZ"
Content-Disposition: inline
In-Reply-To: <97da8398-599e-45cb-abb2-97cc66567628@opensource.cirrus.com>
X-Cookie: Don't I know you?


--VR6AEZOBN5xY1cCZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 19, 2024 at 11:24:06AM +0100, Richard Fitzgerald wrote:

> Ah, ok. Sorry, I assumed you were objecting not just overloaded.

There's a latency between me deciding to apply a patch and the patch
actually ending up in my tree - I test everything which takes time.

--VR6AEZOBN5xY1cCZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZyxZIACgkQJNaLcl1U
h9DGqAf+Jz/okBoNBuqi6pOSDONLdBYzCM2CCX1nO3m7rt43q1WNnDyHMJ/E5sEK
Gf7KEey66EwZOp7ozj0bDUhViwBT9NTuSPgXLcf3FjdBhdn0pxXkjz3IOLQl+rcL
2E/+9WCOfy4WxUq+5Q7EhGeGvF4Iu3e5OfSYN/jbMCb6O8+2frVt4zlpbU4ZTOCO
tDZIctNPH125ATIdP9E1fSFSyLnOuBda8hGwpyCAUjUluwFbTvI8z6u/PLbLUXzq
I81HRGieVpedOzVtVT8vWb6ZkmB1d9HkQT0xtWJkV3AFfdpddjd0Mhm3QWf3SPqx
qroTq2Ew+Mq1/EPA8ouW87vzE09LlQ==
=DIGY
-----END PGP SIGNATURE-----

--VR6AEZOBN5xY1cCZ--

