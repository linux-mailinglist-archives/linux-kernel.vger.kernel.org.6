Return-Path: <linux-kernel+bounces-208072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0386A902042
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 189EE1C21C14
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E3A7CF1A;
	Mon, 10 Jun 2024 11:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvzWOaXu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D247C081
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 11:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718018561; cv=none; b=d1k85YCiWoV/YsUeDZSRtcYh6QiccPAt6zrxtLW01giKu6mAn2K5XBXk7FiCyR3gF8LrZG1qDuryy33fC8emTGzDhZ+qVTYZfbFg+PtE2E7EU/3onV62EKiqR8NJA97BQbyXDxrmAo8PpKniGCkH+8PfYKE1JM+pyiRfhMTY7O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718018561; c=relaxed/simple;
	bh=EkV8eFeIlMbRYuFLi5bacADDZkcGFLP/Ep/Wj8zW2yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiIp7kfAZ/Pql5/I0KJRN+qwvTHcj+04JaLobg996u6k9rN4bqy04b8z03aybZwCNN6zYhFFxhh+Lv4sUfo14aBQA9EJE0eBw1i9txHuA9flnsjnxGo8jLePjt1KZ40fJPXDPxBWcy+yEuM0ERwxRIf1Xivsi9Z4oOVQq09ylvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvzWOaXu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD434C4AF1D;
	Mon, 10 Jun 2024 11:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718018561;
	bh=EkV8eFeIlMbRYuFLi5bacADDZkcGFLP/Ep/Wj8zW2yA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OvzWOaXuhoEJJ3cuyXabQhTXJTGE73mdTgRnf6/ya0baKS8JHV9er7EVFjZhs9BBA
	 0zOkWdVNlStK2qmSVnHwP4oJcARw+KlYjGgE+Yv/uVRbQJ/EoZNzIJtI9qgoCTBX8o
	 cyO0kiw6uQJG0mKKPNbEcuv+Z7PyGHdrnVDI3Qk6xrNsRjJ8U56SnCMzAxrFDobO32
	 5bwlnHM0qZWRm28kseB6Nw3x91246R+KwGOMYujqPUdhk1fsqeBjDHC8Vh7iShgXFE
	 uI+AdXZ7G//AXJYvs5aiDNCFkKwzUch7oj9IG3JQ9buAjKvDGo1lFBgkvOR3arNllm
	 xc0DZ3L+IcyBw==
Date: Mon, 10 Jun 2024 13:22:37 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Amjad Ouled-Ameur <amjad.ouled-ameur@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Smitha T Murthy <smitha.tmurthy@arm.com>, 
	Deepak Pandey <deepak.pandey@arm.com>
Subject: Re: [PATCH] drm/komeda: check for error-valued pointer
Message-ID: <20240610-classy-walrus-of-abundance-e8acff@houat>
References: <20240610102056.40406-1-amjad.ouled-ameur@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v2hia7wsvzddoorn"
Content-Disposition: inline
In-Reply-To: <20240610102056.40406-1-amjad.ouled-ameur@arm.com>


--v2hia7wsvzddoorn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 11:20:56AM GMT, Amjad Ouled-Ameur wrote:
> komeda_pipeline_get_state() may return an error-valued pointer, thus
> check the pointer for negative or null value before dereferencing.
>=20
> Signed-off-by: Amjad Ouled-Ameur <amjad.ouled-ameur@arm.com>

I've added a Fixes tag and applied to drm-misc-fixes, thanks!
Maxime

--v2hia7wsvzddoorn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZmbh/AAKCRDj7w1vZxhR
xahgAQD23Qma6aL0sKtPduWTr7Di9Ar8cyqpLFFSYhO3huhalQEAuesXQa/px8G7
8pThjlEwd6jsLC0kUTk2AnhtJPcQiws=
=c3Zi
-----END PGP SIGNATURE-----

--v2hia7wsvzddoorn--

