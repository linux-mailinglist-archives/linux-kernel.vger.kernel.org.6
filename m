Return-Path: <linux-kernel+bounces-371200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B039A37BE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 622BAB257F0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA5E18C902;
	Fri, 18 Oct 2024 07:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVkay7Uf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCB218C031
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 07:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729238128; cv=none; b=A1W0GUpCMVN+YAISuhvVhrFni2ymvfw4WPr+sIUjdQ+9hR5HNCDs9mx/LLC/Ghw89UbUtgX/0d5r5D7s4ywsaOjyrjcKW2wtCcW0j8ewZmtEqHkdx8tgAChvHIJi9v22zN7X3T6oNOWPYmbMak/HybLT7rr0Afsmq4Pgj7FKKXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729238128; c=relaxed/simple;
	bh=2d/t0Nqc9fQZ9CXdtr2T4TRU96qACbfENGxnN17LDwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NN5vJZOWNetTFmNKtiLrZWvRIctxdt8g4HhD11lV+gNRZyACl/vgfnJhfqABEsahD7na8R1y0FyLFSj11gdfbmF6xFW/XFEY6YbocxvhDfuYwqxLuev/0kJc6m43YQNEWgdrbFXMrjtCrttMDmFwAISxy0Q9i57bo7WjhKu4Yck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVkay7Uf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6E9C4CEC5;
	Fri, 18 Oct 2024 07:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729238128;
	bh=2d/t0Nqc9fQZ9CXdtr2T4TRU96qACbfENGxnN17LDwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZVkay7UfUOTGvsIsJpYUNZIiro524TDifhG+oE0EI/URDUKo8hUMu1Ms2X/6nEZbD
	 YOfrMn10gIg9Xvt9mzLk5pPtaFG3kOkjnkH67i/Pd9ZKWJbLfVY5uLlXqiOt3O73M7
	 s8uHW71Ln7kba6vBl9ktEBXK/mD1AG0YNh7bezLLSVfATpbp+jTusbsPtTAVzVzcok
	 uWLcA+EwRPw8rXg6k1nqXOOGIAOw0PC+wwB1yUmonZ9rmw5azb6i/p4nJ61x3iDQ9v
	 LPxO0jFww0wYAac/KyLfc3wYkq1Asj6+mIlW/V5JboVY0fcvUuGkvbSTWA1ENII/lx
	 c0wG0wq9iAFnQ==
Date: Fri, 18 Oct 2024 09:55:22 +0200
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
Message-ID: <20241018-gigantic-meticulous-pug-06ec1b@houat>
References: <20241017063125.3080347-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="u44pcnvp3al5wfxk"
Content-Disposition: inline
In-Reply-To: <20241017063125.3080347-1-ruanjinjie@huawei.com>


--u44pcnvp3al5wfxk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 17, 2024 at 02:31:21PM GMT, Jinjie Ruan wrote:
> Fix some memory leaks in drm tests.
>=20
> Changes in v3:
> - Adjust drm/drm_edid.h header to drm_kunit_helpers.c.
> - Drop the "helper" in the helper name.
> - s/fllowing/following/
> - Add Acked-by.

This creates build failures since drm_display_mode were const before,
and can't anymore.

Maxime

--u44pcnvp3al5wfxk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZxIUZQAKCRAnX84Zoj2+
dhnrAXwMx3Wn3MEl5WkrmjldVEV1oIryd15E1vPjm/zDPwt1crTCjmnZq4Gb0RPe
txdNf4YBf06Dsz057RiliLhQvZjpdUSkddlwrvH8GekiAPF1jWk13UVpQuwMdWjV
1Zg+noXCtw==
=yjY3
-----END PGP SIGNATURE-----

--u44pcnvp3al5wfxk--

