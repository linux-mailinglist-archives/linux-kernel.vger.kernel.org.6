Return-Path: <linux-kernel+bounces-386476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 912389B43F5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 564E8283889
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0222022E6;
	Tue, 29 Oct 2024 08:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W79BwF2z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EBB18A95A
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 08:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730189734; cv=none; b=iAHyieRsFqhcYd8aHVimald26yMx+L/xg/LcoSX5iIU1mDNnWQw333/GzDPPu2UYvTqa/h5/D72IbPMRlKuRep6O7E7iE2yzkxSMt7eQSsZq7iBEbSb39lTKn+LAQwaU1ku0JLvficL49vG2V+0RqLLkv8oEbcERsnIlqPAxTds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730189734; c=relaxed/simple;
	bh=Re+MDXtcVE8bjwH91xYXXaAonR+wVRYRG/DIzrjk0b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4Il6o5U6UtvO96wV1UWaDgRStkAJzEEHkll5wTOySQed6hMN2dVxHdnf5yhaAkxNz3BuC/dWm6efptI3k1WMXsZ0O6ZD6kD9IRPx2AWdDPwOKUitg+fYb8PD4i5KXMGl1BwUPgnhelbeKTxNABoTRCJxdP8vG2MPPeVCdEerFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W79BwF2z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB81C4CECD;
	Tue, 29 Oct 2024 08:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730189734;
	bh=Re+MDXtcVE8bjwH91xYXXaAonR+wVRYRG/DIzrjk0b0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W79BwF2zUWa8O5pH1qu/q+K7UkCg1cL4w25XMvvGaJWFBCDXzc23uJ53wi7d4+Vhi
	 bOdQsAIoa/ML4A//LzLch7KsVXpnC70XO26Pm1NbFaLUmNBHm9bkPQiFv6AmOEQIfX
	 fmMMGnN+eyDUvDEeJzJg1EUsoexxqSCuK7zv1tQn+vgYbh4jiRix310uvLyE5LsCd7
	 eMNgF5l/27ZlohWnTJphlEU7vwdvLePECnw+b3CbVE1MXn9PosSji1rDyhBryUjukK
	 2AYuOghKKyLnGvUkdSpUsUtAN+4QWjLYWyOHt8uskj0ORYO6BkKysE8rKzMH5MaWFE
	 412fPjiPImGSw==
Date: Tue, 29 Oct 2024 09:15:31 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, christian.koenig@amd.com, ray.huang@amd.com, 
	dmitry.baryshkov@linaro.org, dave.stevenson@raspberrypi.com, quic_jjohnson@quicinc.com, 
	mcanal@igalia.com, davidgow@google.com, skhan@linuxfoundation.org, 
	karolina.stolarek@intel.com, Arunpravin.PaneerSelvam@amd.com, 
	thomas.hellstrom@linux.intel.com, asomalap@amd.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] drm/tests: Fix some memory leaks
Message-ID: <20241029-heavy-scallop-of-jest-1fcfd4@houat>
References: <20241017063125.3080347-1-ruanjinjie@huawei.com>
 <20241018-gigantic-meticulous-pug-06ec1b@houat>
 <f7519595-8080-44c5-0477-e1281266b80b@huawei.com>
 <80114de7-19c0-d860-c888-35e535915f78@huawei.com>
 <20241025-bold-light-vicugna-c30ecf@houat>
 <fb6c6e6d-18ad-344d-c8ad-a9b90c6c2f28@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="ddtzjmtot4x35duc"
Content-Disposition: inline
In-Reply-To: <fb6c6e6d-18ad-344d-c8ad-a9b90c6c2f28@huawei.com>


--ddtzjmtot4x35duc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 0/4] drm/tests: Fix some memory leaks
MIME-Version: 1.0

On Sat, Oct 26, 2024 at 10:02:51AM +0800, Jinjie Ruan wrote:
>=20
>=20
> On 2024/10/25 22:33, Maxime Ripard wrote:
> > On Wed, Oct 23, 2024 at 09:35:59AM +0800, Jinjie Ruan wrote:
> >>
> >>
> >> On 2024/10/18 16:12, Jinjie Ruan wrote:
> >>>
> >>>
> >>> On 2024/10/18 15:55, Maxime Ripard wrote:
> >>>> Hi,
> >>>>
> >>>> On Thu, Oct 17, 2024 at 02:31:21PM GMT, Jinjie Ruan wrote:
> >>>>> Fix some memory leaks in drm tests.
> >>>>>
> >>>>> Changes in v3:
> >>>>> - Adjust drm/drm_edid.h header to drm_kunit_helpers.c.
> >>>>> - Drop the "helper" in the helper name.
> >>>>> - s/fllowing/following/
> >>>>> - Add Acked-by.
> >>>>
> >>>> This creates build failures since drm_display_mode were const before,
> >>>> and can't anymore.
> >>>
> >>> It seems it came from bellowing v1, and this v3 has not reported the
> >>> issue yet.
> >>>
> >>> https://lore.kernel.org/all/202410180830.oitxTsOv-lkp@intel.com/
> >>
> >> Hi, Maxime,
> >>
> >> Should this series send again? The issue seems not related to this ver=
sion.
> >=20
> > As far as I know, the issues reported still apply there, so yes
>
> I make this version code with "C=3D2", there is no these build failures.

Sorry, you're right. I still have a comment on the first patch

Maxime

--ddtzjmtot4x35duc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZyCZngAKCRAnX84Zoj2+
dq32AYCl7QmrfN3pfj027QXZ8TGQ+8c8LyDuRgYyH8YTib+XzneLzB4O7/yMzsQC
6vZy91oBgIRpmNU1EOPfVKJjjgqZnAu0Gze+3rUqf0oN+HYU3T3WBoH/l52/9KsM
9psGrWsF7A==
=5jYc
-----END PGP SIGNATURE-----

--ddtzjmtot4x35duc--

