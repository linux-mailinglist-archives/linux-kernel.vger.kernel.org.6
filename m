Return-Path: <linux-kernel+bounces-363660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CFA99C55B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B625C1F24855
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D09156C5F;
	Mon, 14 Oct 2024 09:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rfd/Ssfm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E530519D885
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728897148; cv=none; b=ri3slFo7uNiEQjhnjH5EMxEl2ZS4qleho+EIlOVKO7BThaEWwCupHdKNXFEHo2teY7HNqZpZZiJzvjMX9Q1Cdn3Jsvvv8AY0dOr3/7AK5AK5hiXPL/sulyhIaia5pj8AEd2vbQGg/3qvJih6DV6svLBbb7iBgcv769Aj4VZ3njM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728897148; c=relaxed/simple;
	bh=nkSs4ZYs/RlbtRbJnQoFHtVRNGXONx0cS2oxXr+jVCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ii7lunyw9agSgb0zf8b/Q9N1qkR6AgDUkEOiK5lvQ/LdIutBuDMtb/1hnYhyE6OKJOLUnrjRJZiXhnGYrfVW39WDElkDMwhn8Rj4iJhX2A4Dz9a3ncWyFBF4yDsB5HUG3hpaW9TXSfha1jN/4JkWEKZWEMyX2EjGxoYVO1zgPqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rfd/Ssfm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6E1C4CEC7;
	Mon, 14 Oct 2024 09:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728897147;
	bh=nkSs4ZYs/RlbtRbJnQoFHtVRNGXONx0cS2oxXr+jVCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rfd/SsfmGkAexMnnEPRK+L3kmVtDUCJHdJ+BQr85NZJpTX7yfGWHL5+1+fhg2DvLy
	 otCaWW0vDpC7sGSe9l/s+bJ004jYBPfeM3zs9IfOdHJxqnjd7TAeoWAs6Pttl5yv/B
	 EIr+xXZTgo1zS62sHDTRTRLBH4erMSYCWoebhLMZyrISDLiAtcjZht3Fs1Nl6peRBP
	 /IFMzB+tNMvrvrT96ZrA+Mwew+37pNzsvEn9aI9bBAwCRNhq9vnEhOetDicxiXOdCD
	 DtObrIIUh1G1h/HXx1zO/rGN/xo2Ca8ZyIk7awij8CL3ink2KPNi+UmUIqVd+ColYC
	 gjdw1FlqkLKrQ==
Date: Mon, 14 Oct 2024 11:12:24 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, christian.koenig@amd.com, ray.huang@amd.com, 
	dmitry.baryshkov@linaro.org, dave.stevenson@raspberrypi.com, mcanal@igalia.com, 
	quic_jjohnson@quicinc.com, karolina.stolarek@intel.com, Arunpravin.PaneerSelvam@amd.com, 
	thomas.hellstrom@linux.intel.com, asomalap@amd.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] drm/tests: hdmi: Fix memory leaks in
 drm_display_mode_from_cea_vic()
Message-ID: <20241014-translucent-shrew-of-pluck-82abd5@houat>
References: <20241014071632.989108-1-ruanjinjie@huawei.com>
 <20241014071632.989108-4-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="zpuwtj3jjpvxw4oq"
Content-Disposition: inline
In-Reply-To: <20241014071632.989108-4-ruanjinjie@huawei.com>


--zpuwtj3jjpvxw4oq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 03:16:32PM GMT, Jinjie Ruan wrote:
> modprobe drm_hdmi_state_helper_test and then rmmod it, the following
> memory leak occurs.
>=20
> The `mode` allocated in drm_mode_duplicate() called by
> drm_display_mode_from_cea_vic() is not freed, which cause the memory leak:
>=20
> 	unreferenced object 0xffffff80ccd18100 (size 128):
> 	  comm "kunit_try_catch", pid 1851, jiffies 4295059695
> 	  hex dump (first 32 bytes):
> 	    57 62 00 00 80 02 90 02 f0 02 20 03 00 00 e0 01  Wb........ .....
> 	    ea 01 ec 01 0d 02 00 00 0a 00 00 00 00 00 00 00  ................
> 	  backtrace (crc c2f1aa95):
> 	    [<000000000f10b11b>] kmemleak_alloc+0x34/0x40
> 	    [<000000001cd4cf73>] __kmalloc_cache_noprof+0x26c/0x2f4
> 	    [<00000000f1f3cffa>] drm_mode_duplicate+0x44/0x19c
> 	    [<000000008cbeef13>] drm_display_mode_from_cea_vic+0x88/0x98
> 	    [<0000000019daaacf>] 0xffffffedc11ae69c
> 	    [<000000000aad0f85>] kunit_try_run_case+0x13c/0x3ac
> 	    [<00000000a9210bac>] kunit_generic_run_threadfn_adapter+0x80/0xec
> 	    [<000000000a0b2e9e>] kthread+0x2e8/0x374
> 	    [<00000000bd668858>] ret_from_fork+0x10/0x20
> 	......
>=20
> Free `mode` by calling drm_mode_destroy() to fix it.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 4af70f19e559 ("drm/tests: Add RGB Quantization tests")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers=
/gpu/drm/tests/drm_hdmi_state_helper_test.c
> index 34ee95d41f29..70b91e8c8219 100644
> --- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
> +++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
> @@ -466,6 +466,8 @@ static void drm_test_check_broadcast_rgb_auto_cea_mod=
e_vic_1(struct kunit *test)
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
> =20
>  	KUNIT_EXPECT_FALSE(test, conn_state->hdmi.is_limited_range);
> +
> +	drm_mode_destroy(drm, mode);
>  }

Same comment than on patch 1

Maxime

--zpuwtj3jjpvxw4oq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZwzgeAAKCRAnX84Zoj2+
dthhAX95EFCmz4YfB2uFG4r5vFoH+Pw2zFz5wObKVxWkg/ycJBQMzJR1vCCvdTUR
3EruXsoBgN7TtI4aZzl8FSO7hu3Ie1RKiYtx98hknQoGMTSbre5R6j1GcYnduNkC
uKJAHkRnuA==
=v3d6
-----END PGP SIGNATURE-----

--zpuwtj3jjpvxw4oq--

