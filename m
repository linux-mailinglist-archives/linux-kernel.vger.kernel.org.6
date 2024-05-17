Return-Path: <linux-kernel+bounces-182043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BEC8C857D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 13:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E74D1F22E79
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 11:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3D73D541;
	Fri, 17 May 2024 11:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfGgUZnf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7397D3A8EF
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 11:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715944908; cv=none; b=KaGCIYav3FRwMVWXl5G2F/F2r3AZRi0ORlGFCFtL+sVN4LKI2rlvOmhjz1So9p9e6C3K5Zn1Wx0VYv3FsaHyBNZYOQi8vqjbO9qMO3i/XYq/cCMSNCfShoam8Ar87BN/g25P1UhbWaXVfkFYL+wIbnQqZ/kNTxalo8eLvzDnSq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715944908; c=relaxed/simple;
	bh=b0lV1xNI1sGMBf3SxQ8We4qaXsv8KcwIYCN+H6yYwCA=;
	h=Content-Type:Date:Message-Id:To:Subject:Cc:From:References:
	 In-Reply-To; b=g3xz+urWiOTlPahVqZSYCWuSnIaw8ubbjGCCxO6Wfx8k/I6SIyoNK7fzftSNCVVPQC85V33XBCDmFjsAt7M1yhwjKm7rmMTtJlRKd17Wakc+9fqG+zLyNORMhNdVLv8vF+1Sh3q1hfoUMdcH0xvRTviVlPcTDgRTffiyxNaR1Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfGgUZnf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FC5C2BD10;
	Fri, 17 May 2024 11:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715944908;
	bh=b0lV1xNI1sGMBf3SxQ8We4qaXsv8KcwIYCN+H6yYwCA=;
	h=Date:To:Subject:Cc:From:References:In-Reply-To:From;
	b=RfGgUZnfV+RGuV6hr5/G3C67JOijfH9uijgkLEMsLQVOfu3La5R10DegzfYxjapKT
	 +/U+4raQqcGW5LyUFrSiay9Au8VjYKSN4mt0UzJD9fNlAXKe7hL65Vlz5LfGW1d/pB
	 jZDlOOA4nxaDVfbKTw3VVjbizFTAkVt+B55TFoJit54XVSjOzWjl0XIb9KW4zRYkLh
	 Mj2J2lf5pbF4KoupzlN85n9qpcxvrxw0My2qXyExjJZQuybZVTDbV3/Oc3dx5cUvjt
	 nZRhvAO2lWD3MFvqU/af/Mucx6f7Bf9WSKSYIhuuwVzh8RdG7KGaonxRpIkn7QLDEN
	 +I90Ji3Nr9V3Q==
Content-Type: multipart/signed;
 boundary=f27161c941001cd0bbbbc62b61244dbaa44f7ccf8dabf629896d85fb65df;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Fri, 17 May 2024 13:21:43 +0200
Message-Id: <D1BVPABXTSPH.22ML1GLOMHEJR@kernel.org>
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
 "Chun-Kuang Hu" <chunkuang.hu@kernel.org>, "Philipp Zabel"
 <p.zabel@pengutronix.de>, "David Airlie" <airlied@gmail.com>, "Daniel
 Vetter" <daniel@ffwll.ch>, "Matthias Brugger" <matthias.bgg@gmail.com>
Subject: Re: [PATCH] drm/mediatek/dp: fix spurious kfree()
Cc: "Jani Nikula" <jani.nikula@intel.com>, "Chen-Yu Tsai"
 <wenst@chromium.org>, <linux-mediatek@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
From: "Michael Walle" <mwalle@kernel.org>
X-Mailer: aerc 0.16.0
References: <20240517093024.1702750-1-mwalle@kernel.org>
 <de0191f3-271b-4f0e-aa73-910543587c9d@collabora.com>
 <D1BVE3G40OVL.3KX13LU75M122@kernel.org>
 <0d8f89d4-e16e-4c8d-b983-38df8fcc387e@collabora.com>
In-Reply-To: <0d8f89d4-e16e-4c8d-b983-38df8fcc387e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--f27161c941001cd0bbbbc62b61244dbaa44f7ccf8dabf629896d85fb65df
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri May 17, 2024 at 1:09 PM CEST, AngeloGioacchino Del Regno wrote:
> Il 17/05/24 13:07, Michael Walle ha scritto:
> > On Fri May 17, 2024 at 12:35 PM CEST, AngeloGioacchino Del Regno wrote:
> >> Il 17/05/24 11:30, Michael Walle ha scritto:
> >>> drm_edid_to_sad() might return an error or just zero. If that is the
> >>> case, we must not free the SADs because there was no allocation in
> >>> the first place.
> >>>
> >>> Fixes: dab12fa8d2bd ("drm/mediatek/dp: fix memory leak on ->get_edid =
callback audio detection")
> >>> Signed-off-by: Michael Walle <mwalle@kernel.org>
> >>> ---
> >>>    drivers/gpu/drm/mediatek/mtk_dp.c | 10 ++++++++--
> >>>    1 file changed, 8 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/medi=
atek/mtk_dp.c
> >>> index 536366956447..ada12927bbac 100644
> >>> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> >>> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
> >>> @@ -2073,9 +2073,15 @@ static const struct drm_edid *mtk_dp_edid_read=
(struct drm_bridge *bridge,
> >>>    		 */
> >>>    		const struct edid *edid =3D drm_edid_raw(drm_edid);
> >>>    		struct cea_sad *sads;
> >>> +		int ret;
> >>>   =20
> >>> -		audio_caps->sad_count =3D drm_edid_to_sad(edid, &sads);
> >>> -		kfree(sads);
> >>> +		ret =3D drm_edid_to_sad(edid, &sads);
> >>> +		/* Ignore any errors */
> >>> +		if (ret < 0)
> >>> +			ret =3D 0;
> >>> +		if (ret)
> >>
> >> Eh, this will never work, because you're clearing the error before che=
cking
> >> if there's any error here?!?! :-P
> >=20
> > Don't get what you mean? Yes, I'm ignoring the error. Thus, in case
> > of an error ret will be zero and there will be no free. If ret was
> > zero, there won't be a free either. So you're left with the "normal"
> > case, where you have to free the sads. Just like before.
> >=20
> >> Anyway in reality, it returns -ENOMEM if the allocation was not succes=
sful...
> >> in the event that any future update adds any other error we'd be back =
with the same
> >> issue, but I'm not sure how much should we worry about that.
> >>
> >> To be extremely safe, we could do...
> >>
> >> if (ret !=3D -ENOMEM)
> >> 	kfree(sads)
> >>
> >> audio_caps->sad_count =3D ret < 0 ? 0 : ret;
> >=20
> > Which is the same as above, but you only check for ENOMEM?
> >=20
>
> Yes, the point is to avoid kfree(sads) for -ENOMEM only, as other errors =
that may
> be introduced later might still allocate it and leave it allocated.

Honestly, I doubt that any sane function will allocate memory, then
return an error and expect the caller to free it.

-michael

--f27161c941001cd0bbbbc62b61244dbaa44f7ccf8dabf629896d85fb65df
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZkc9yBIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hZRgGA3L/dMBtHlbW7ZOV5nIDapRev3O4bmq6g
8ONEpwEM2TT1gUSVO++inHv0WwdC/5P5AX45dE/OEijkk2jcFlW7qjVKOYztnjwz
6Augvm2E5aMYSW9zE3gdpGOeijQL7myf92w=
=7cyw
-----END PGP SIGNATURE-----

--f27161c941001cd0bbbbc62b61244dbaa44f7ccf8dabf629896d85fb65df--

