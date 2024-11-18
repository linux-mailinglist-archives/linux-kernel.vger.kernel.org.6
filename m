Return-Path: <linux-kernel+bounces-413435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8319D1902
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422E4282D9F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B0B1E261B;
	Mon, 18 Nov 2024 19:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ZJWU0pTs"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E9F14F9CF
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 19:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731958495; cv=none; b=lwjA0LQnxggH8jazHPbPVsOk0k7vZXF3Km+WsHYWKif1BZpABOPTLRH8z759L/+YYx3v0gYajlGTAWbRM91HW3YaZzfapc/+Xt8RbNSik/PpOqSqrvTphTnDl1cqwpK8mCYASsU0OBskk9pEnTvCxPgHjcExulJui2SW3JAt9T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731958495; c=relaxed/simple;
	bh=4IQ+/qlAPIVtK5c7UjGrT6bzGc6QP7fuCo5yCioqtvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JuTob/3UMKQQ/NkYc8xaI/wdZ2BWZVvs78P9R4/aySdORtBmWSd62H6xwyLzLzSR1tQW6nPHYixA8EM1OYNbLmyMmkMW1CH5223r69Rk2eP3n9sjtSudzyS+aP5KWfSW5uLG2RTPp0PIewIUsPZO6FmTFaJz1/q3k8Jemd7WfbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ZJWU0pTs; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=4IQ+
	/qlAPIVtK5c7UjGrT6bzGc6QP7fuCo5yCioqtvA=; b=ZJWU0pTsUmezyoO4QRFD
	ksMkot+jJiGIlXObDkvBnyK5AKBRDtoUalHtoVVqTCuuK7roE93EuoikoAUgV0MV
	GDhFoF9RswTk+f+bRYrXq3R8Jn1J/ky9yiYt3i0jq8G7Nx8bUzl5KSPba4mc783B
	jpALQMKrUTYSBbTJoqifzjqNiMQApvYN6Ql0DDFbXuJy5GZNH6WlFgiHNXoKzhsa
	puMblOHBgIFuz+csH+LOYOZ7gXrGpHje6pl2MgMr3W+6H2mm0GtRYwB2sbdhs6LB
	DO4+ZwZD8jTCCPs1YktaaZeMioDVoaPflm6m0PoGBPIZ/TlKUPNUTtsXcXH5aZQq
	hg==
Received: (qmail 320855 invoked from network); 18 Nov 2024 20:34:45 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Nov 2024 20:34:45 +0100
X-UD-Smtp-Session: l3s3148p1@zKZMAjUngr4ujntT
Date: Mon, 18 Nov 2024 20:34:44 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-kernel@vger.kernel.org, Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 04/15] coresight: etm4x: don't include 'pm_wakeup.h'
 directly
Message-ID: <ZzuW1Gh8ULYurUKH@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	linux-kernel@vger.kernel.org, Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
References: <20241118072917.3853-1-wsa+renesas@sang-engineering.com>
 <20241118072917.3853-5-wsa+renesas@sang-engineering.com>
 <ea311a21-959d-4985-9364-7c85d256ab09@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WVupqj1J1l+LAVq0"
Content-Disposition: inline
In-Reply-To: <ea311a21-959d-4985-9364-7c85d256ab09@arm.com>


--WVupqj1J1l+LAVq0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> If you plan to take this as a collection outside of CoreSight tree,
>=20
> Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>=20
> Otherwise, I can pick this up.

As stated in the cover letter, please pick it up. There are no
dependencies.


--WVupqj1J1l+LAVq0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmc7ltAACgkQFA3kzBSg
KbajBw/+Iw5lYdddTN921JDSBexKi7CMET5BgZ+xmLzXHFZG94SwxZazKIKgLGRj
jKdD91uGgFgxZo+W092wF+rMcA1AhCzwFhwIeJbf+yOXJuDUKtlqsD/PypPyWZkK
2OhNgbM+czo6FLrBGpwYdRjmmhRwkGJVzpNxJiK6EEK14e5ih5h0u9cbri2YZxe/
XU2cQ7KrbMenAum5xy/t3dBIWBQRNbaAVWVuf25vGta0dKC1+MrAd4vxvz0sQlVc
r9m+uC05Y8rzvOvi33KijYkwF2Tv6/S0onG5zE9ODUAMT5VqCAht+DBwbIEwc+D6
uUvzcGxnfYv5x77JnCgnf5oPeoJGe6u4xSq7xZ9NsdL+SN9TumpBrlA6wp3Ue/te
Fy0mFcKOfkrfuDRYFrfczsew5KJ4Gj5CBVxgbw1/860Fs/gKZ4uu5cU5Pgl0+GbX
92nXHFMAoIYQ/XOFH6AdxbEfloI42kbDxTeIZ+AmanY1eCMcAZ2l3eQxMCX9gMTM
dRRAZPkO7PtJwRCCcsbxR9Wq0VXKQ4dvaRB6NOl/C53IiI/lJTzw96jlYG70ne6c
MQp6lbm7xbUA2VrdZayFbE/A5Ym9rMG1XNCaFPcNU+c5HjqZB93EB8SRmYjlj7SS
2j9RkQP9YoyIn2sBcc+fInrTH71/V3koiAMKOQdT2kZh2PKjWcw=
=madr
-----END PGP SIGNATURE-----

--WVupqj1J1l+LAVq0--

