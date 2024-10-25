Return-Path: <linux-kernel+bounces-381888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D07B69B05E5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E57481C209D1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC641FB8A1;
	Fri, 25 Oct 2024 14:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWuXdZGF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C0E21219A
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866797; cv=none; b=oJJjvrK6lBAdSsJIvads42eBiL4UVZ5GYD8yacB0QnLl5O3bfnd6AW+cir0HtskCy/7CELpeF+ejuU+q7Gu7WIcJxHzEJv8W8pYejBkY6eWBQmpQb3JmCS6wSHLXqWy42oxBgde4BOmPrpAmhIe7djHPKOyZg84yfKkwfU8i1bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866797; c=relaxed/simple;
	bh=Fot4mbrkSUk9Tft+x74a5ztFO1CiXvQ02g6A0wq9mEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VA53oEvhGYVFbYwo8KZJvskv9oLATivt0DA3Tv/jqc4m8kPuV+qIDngZPH/htbx4qByQC8KnR4PC3A2xHdVh/FD59igV0kINyyZAIV4ExZ3RucImvICvmYP8bOeh7RqheHXOZkP1P5kywOwAg0gi6cD5UnEbTYjl1gLC/wJOLOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWuXdZGF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496C7C4CEC3;
	Fri, 25 Oct 2024 14:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729866796;
	bh=Fot4mbrkSUk9Tft+x74a5ztFO1CiXvQ02g6A0wq9mEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WWuXdZGFFOP1AJDTXdW4oMpWsVsEbGkK89Z/pqrTeLq43y/1dqrbFmDvG77iM9aUV
	 ksQS/OO7jOu1FdZ3NuCvqDR1GXt1PDm/148Zevl3uYBGq/vJ6JF7M6QziW1pEQ9njH
	 xFp0W8wqdcDHGCg5LASbwACYOZ5/tktpCAPRMzC50RvmgEZYMKKQ3jeFpDMFbhVlJ0
	 aIliNDo1JL+rAygwZHFUidfPSr3QK1dVMp6903N59VdmIGHfwJfEA3J9/DLnDstfux
	 j/Yfp4HvdJWW+oVgnNIpVv05KNZZLtZTSF/herTBf0zZAaCIfR1SsPbDVtPSRtOZMB
	 2hxoiG6DTns6g==
Date: Fri, 25 Oct 2024 16:33:13 +0200
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
Message-ID: <20241025-bold-light-vicugna-c30ecf@houat>
References: <20241017063125.3080347-1-ruanjinjie@huawei.com>
 <20241018-gigantic-meticulous-pug-06ec1b@houat>
 <f7519595-8080-44c5-0477-e1281266b80b@huawei.com>
 <80114de7-19c0-d860-c888-35e535915f78@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="5ue4enxlgmjc635d"
Content-Disposition: inline
In-Reply-To: <80114de7-19c0-d860-c888-35e535915f78@huawei.com>


--5ue4enxlgmjc635d
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 0/4] drm/tests: Fix some memory leaks
MIME-Version: 1.0

On Wed, Oct 23, 2024 at 09:35:59AM +0800, Jinjie Ruan wrote:
>=20
>=20
> On 2024/10/18 16:12, Jinjie Ruan wrote:
> >=20
> >=20
> > On 2024/10/18 15:55, Maxime Ripard wrote:
> >> Hi,
> >>
> >> On Thu, Oct 17, 2024 at 02:31:21PM GMT, Jinjie Ruan wrote:
> >>> Fix some memory leaks in drm tests.
> >>>
> >>> Changes in v3:
> >>> - Adjust drm/drm_edid.h header to drm_kunit_helpers.c.
> >>> - Drop the "helper" in the helper name.
> >>> - s/fllowing/following/
> >>> - Add Acked-by.
> >>
> >> This creates build failures since drm_display_mode were const before,
> >> and can't anymore.
> >=20
> > It seems it came from bellowing v1, and this v3 has not reported the
> > issue yet.
> >=20
> > https://lore.kernel.org/all/202410180830.oitxTsOv-lkp@intel.com/
>=20
> Hi, Maxime,
>=20
> Should this series send again? The issue seems not related to this versio=
n.

As far as I know, the issues reported still apply there, so yes

Maxime

--5ue4enxlgmjc635d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZxusIQAKCRAnX84Zoj2+
dif2AYCFv3s14Iv+Eh/yGMeO60Js+HXqQ6Z76YpyULOmtFTGRF0Im/XWIbuxI65t
UahKIV4BgMviSMlgiXbldN/GRdHb1VRFwdKek8Bde/JwhZIUOotseWUcti2Ohs6Z
g+JTYIcF+A==
=7kUl
-----END PGP SIGNATURE-----

--5ue4enxlgmjc635d--

