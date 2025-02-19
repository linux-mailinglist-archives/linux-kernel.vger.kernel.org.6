Return-Path: <linux-kernel+bounces-521989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF35A3C49F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BABB117371B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8F71FDA85;
	Wed, 19 Feb 2025 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czoqeHeA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B251EB195
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981548; cv=none; b=d4IPEPUXBnSwB8o3+tat4QeaYkwjLV21wK41y8Z+ujz+5PQM1ZuhTNKZuLW/YMRREshg3yvEqNCrQeswiTLLJ6Tty2gXKioRFuMCVbNduoZrbhI8wX13eIqELLQMq9kuAMbr+MdUz4O6FhPuWVjDfB6gQtnlZgAG5S2ewiHYeCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981548; c=relaxed/simple;
	bh=nh8cFNIeObOKXMAGYxjgXKUcHk+AS/4DcT+B0swB+os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAcY21N6B0fixX5iwec6+gOYjyYrUTwZXKaCs7UgkQuabNKcTVp9UpGyNvryc8WwrRQMVRoP1YdOuA1HTL3IaT6ihiXlfSyrvNAOo5SL0Xi1zNNuUhBDf3O/GO2g9YXLjj3/hpPu0hANV310NjBw+jFTaE86091fdNX1FGVRBWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czoqeHeA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA83C4CED1;
	Wed, 19 Feb 2025 16:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739981547;
	bh=nh8cFNIeObOKXMAGYxjgXKUcHk+AS/4DcT+B0swB+os=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=czoqeHeAxnbycojOPrrWy3+oXBvIIi9Orz3CkAygwfY56mCSLoV+oHx8Cmv2+0Kl7
	 684DoqQAjdXF2FVMnxqHmISs8xfcs+lk+tOw/ox42lNVlrlvC9eN/jc+eRQW1H8xrm
	 Hw2WBlTH201JBSfMHq4XzrqioSVMbnej/cmYAR/iFRJI/TpUr8zwmMri8hQUWyOl6q
	 qKoYmXU1hcxVteA2xp8bG1FsKZUYfcfVmYnf4jXCuqpFSbI9JCno9YjIYI/VjZF2a2
	 vj3qb6et7U8xEMQ26cbxbkR7ApyGeaMHSoYFg3cLE1uLcEVfXo48Wn2pCba2MjKbXT
	 tQJRInpdep96A==
Date: Wed, 19 Feb 2025 17:12:24 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Simona Vetter <simona.vetter@ffwll.ch>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v3 00/37] drm/bridge: Various quality of life improvements
Message-ID: <20250219-thick-clam-of-inspiration-bc38ab@houat>
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="ql5avbhszhighkaj"
Content-Disposition: inline
In-Reply-To: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>


--ql5avbhszhighkaj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 00/37] drm/bridge: Various quality of life improvements
MIME-Version: 1.0

On Thu, Feb 13, 2025 at 03:43:19PM +0100, Maxime Ripard wrote:
> Hi,
>=20
> Here's a series of changes after to the KMS helpers and bridge API
> following a bunch of reviews I did.
>=20
> It's mostly centered across providing an easier time to deal with bridge
> states, and a somewhat consistent with the other entities API.
>=20
> It's build tested only, with arm64 allmodconfig.
>=20
> Maxime
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Merged patches 1-26 into drm-misc-next

Maxime

--ql5avbhszhighkaj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ7YC6AAKCRAnX84Zoj2+
dos5AYCBZky3Iv31zMJc4Zrs0DW4pcEa0gFpGEnZurclpyA90vWWKeiji3RsCbqh
CNM1TvgBgKIDyscugMLeMNN/XJFPjf/qBkxqAy5lFaekl+CstTbNxPQyKRSLgFop
WrPnv4dOPw==
=OyNX
-----END PGP SIGNATURE-----

--ql5avbhszhighkaj--

