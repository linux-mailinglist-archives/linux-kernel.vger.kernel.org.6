Return-Path: <linux-kernel+bounces-184658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D49B8CAA25
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 10:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E31C1F223C8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 08:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704F055E53;
	Tue, 21 May 2024 08:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FY/wedjo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87363DB89
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 08:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716280680; cv=none; b=R8k20mMTSnDTWdSEyIHSKCZhnIIehnw0hOTiCCoQlUKkITl7ZFFNzbsbWevbN4/5NKihYV8IhkDRoOmLdyrxs5q1sHCTE7hulFQJ9LZrHa9XA4iqEDQox9gSHri+KVBiBndoMj7fky8XgRtXGN3TnqOPa/0jNFpqpSv4xTiHWCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716280680; c=relaxed/simple;
	bh=+eCL9LUGmDlBHd7IqTmjfK/OIkg768Tq3dp2ih3bza4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCOzUEGZlNOOsUESPKwAA0RfAR9ItUUzIExct9p2BJO6WzJuFqjuMQNvMnJLdq/CFVkhiAKQUjJibgsZ2lp6L1uGmqS3Xmab9eyDmHcmVMQx5f+jWr9ZISle3YzN1llRZhv95PZUyzATEuAMtDfvgHp08yRJDn49Q7wZIIq7H+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FY/wedjo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA51FC2BD11;
	Tue, 21 May 2024 08:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716280680;
	bh=+eCL9LUGmDlBHd7IqTmjfK/OIkg768Tq3dp2ih3bza4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FY/wedjoCp4X2DFnwkpWwC94Zd1Sa6zKfl+hpbczNJ14iojaOzWiqgKUSmjqBrdlR
	 sXEHpFnProHnB4skpcmgGRYgT78+D8UWVimfyUT+wDvLE4ffpEF+nQ0aTngr/BsZsN
	 OR1LF5rSCyx9nrwP3O/icjzrCZiGIMF16SlxR/yZYg9mbe479CDfsA2QVoT6KH5Iuq
	 +sVmo+qnb4R4RLLDCbMKm5/kgXLBQg+4zsZUJM/uWgNggHvF6AuB+4K/k6cj8GWxK0
	 0we5dMx2MCVMkSOO+VRAbsN4j5UfLbVryP36SI3rQ5fQOLW69ZUAPpSvhar1QDMiTP
	 HLGMV1L9HTQEw==
Date: Tue, 21 May 2024 10:37:57 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] drm/bridge: Add 'struct device *' field to the
 drm_bridge structure
Message-ID: <20240521-uptight-toucan-of-assurance-edbaa3@houat>
References: <20240514154045.309925-1-sui.jingfeng@linux.dev>
 <20240514-scarlet-corgi-of-efficiency-faf2bb@penduick>
 <c44480ab-8d6b-4334-8eba-83db9b30ff1a@linux.dev>
 <20240515-fair-satisfied-myna-480dea@penduick>
 <d394ee32-4fa4-41a8-a5ca-c1c7f77f44d2@linux.dev>
 <20240515-copper-chimpanzee-of-fortitude-ff3dab@penduick>
 <2c15c859-6b2b-4979-8317-698bf6cc430c@linux.dev>
 <20240516-intrepid-uptight-tench-0df95e@penduick>
 <e955b706-04dd-479f-8327-32771d94f70f@linux.dev>
 <07b931d9-b11f-4829-a6c4-d5025fc071b5@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="54xi4xmokt3wuyve"
Content-Disposition: inline
In-Reply-To: <07b931d9-b11f-4829-a6c4-d5025fc071b5@linux.dev>


--54xi4xmokt3wuyve
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 08:04:59PM GMT, Sui Jingfeng wrote:
>=20
>=20
> On 5/16/24 18:40, Sui Jingfeng wrote:
> > use 'to_i2c_client(bridge->dev)' to retrieve the pointer
>=20
> to_i2c_client(bridge->kdev).
>=20
> Besides, this also means that we don't need to add the fwnode
> pointer into struct drm_bridge as member. Relief the conflicts
> with other reviewers if the work of switching to fwnode is still
> needed. As for majorities cases (1 to 1), of_node and fwnode can
> be retrieved with 'struct device *' easily. The aux-bridge.c and
> aux-hdp-bridge.c can also be converted too easily.

So that's what you're going for.

> of_node, fwnode, swnode and device properties are all belong to
> the backing device structure itself. It can be more natural to use
> device_proterty_read_xxx() APIs after init time, Which in turn
> avoid the need to acquire and duplicate all properties another
> time in the driver private structure.
>=20
> We could do the programming around the 'struct device *.', remove
> a batch of boilerplate.

Please make that happen once the device_property_read_* API is there,
and we can get rid of of_node, swnode, and fwnode then.

Maxime

--54xi4xmokt3wuyve
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZkxdZQAKCRAnX84Zoj2+
dpVVAX0X1N/fhcX18zV5rkgPcOjx1AaUM52FK7mndoOc3g6lJbQHjZ694bhbNBk6
tvPoagYBf3aOMiFWvLNDrCZQl7cNNAqNTFkj2HEExUvF80lgvJ4btMhpcv6ZH3Jq
vWct8dPwbQ==
=tfik
-----END PGP SIGNATURE-----

--54xi4xmokt3wuyve--

