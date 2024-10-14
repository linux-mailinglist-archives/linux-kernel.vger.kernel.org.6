Return-Path: <linux-kernel+bounces-363658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1051599C5AC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15C6FB2E9CD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466E815665C;
	Mon, 14 Oct 2024 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDF0E9D0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A2028E3F
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728897089; cv=none; b=t2SYnV4fw/tH3aSBYGyUfBS017iv/Hl9svgkU9JN4d+QMSesLxMrOGKIlAeDbqKWebPro38g/0R8DZULW/P/ZDqLo32NykLoWKkUOnMKbjE64yHbLe3BAxC7mll9k11x2M4MU/sQX6cTtYsz+dtirld/EADN9H0Tco4lbaqRMW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728897089; c=relaxed/simple;
	bh=SlaebBS2ppBrYdGnnlU+AGBrj7EoGmHJWqIrxyVn5lY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7AjygMmZSNAYY+HbYBlTSw0O0kYU+copH1WLTPnUGjrEK/v/UDA07H9XxcX0C0vFY5B3BJPcAV6R8/7hD12zqfraBb89MUjVMT31onOrdurjGWW4OJV6/I+P2/yH2jfj9iy/NlFowUxERSt2ohDppyXYIkTSg7U7tz+2Db9nrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDF0E9D0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BF6C4CEC3;
	Mon, 14 Oct 2024 09:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728897089;
	bh=SlaebBS2ppBrYdGnnlU+AGBrj7EoGmHJWqIrxyVn5lY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oDF0E9D07vUn6KfLxMTUuW6oR3VlXybRsE9MIzx0HwJJcc5sBW+m1yuAGCPuzAuVI
	 jvPYDCbbf2DzQUWnhWGNmC8dO4e0H1E6yaUdoaHhkLSx8MM20VYstjscXNm43RSwfa
	 k9ebzWVfj7VF5AOIoJejafGAtpA6uRvKsx9ZAJSpBZjc2sdREiaO06bHsq0GKe7QQk
	 Sb4uoW+IQw5MdiGcMEPsPVUBIMQUsHDMX0BxJkEihmNLt+uI/reZ64VN5mUraJpVE7
	 1xRXkpWvkFhM2rOz0I6/UehfXHniAEGtVBktZe6ENy34sArCZSzJS1spB/v4HsSfyh
	 dksa1zpHV/9TA==
Date: Mon, 14 Oct 2024 11:11:26 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, christian.koenig@amd.com, ray.huang@amd.com, 
	dmitry.baryshkov@linaro.org, dave.stevenson@raspberrypi.com, mcanal@igalia.com, 
	quic_jjohnson@quicinc.com, karolina.stolarek@intel.com, Arunpravin.PaneerSelvam@amd.com, 
	thomas.hellstrom@linux.intel.com, asomalap@amd.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drm/connector: hdmi: Fix memory leak in
 drm_display_mode_from_cea_vic()
Message-ID: <20241014-fervent-whimsical-oyster-b0926d@houat>
References: <20241014071632.989108-1-ruanjinjie@huawei.com>
 <20241014071632.989108-2-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="djulfyohgymknlbz"
Content-Disposition: inline
In-Reply-To: <20241014071632.989108-2-ruanjinjie@huawei.com>


--djulfyohgymknlbz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 03:16:30PM GMT, Jinjie Ruan wrote:
> modprobe drm_connector_test and then rmmod drm_connector_test,
> the following memory leak occurs.
>=20
> The `mode` allocated in drm_mode_duplicate() called by
> drm_display_mode_from_cea_vic() is not freed, which cause the memory leak:
>=20
> 	unreferenced object 0xffffff80cb0ee400 (size 128):
> 	  comm "kunit_try_catch", pid 1948, jiffies 4294950339
> 	  hex dump (first 32 bytes):
> 	    14 44 02 00 80 07 d8 07 04 08 98 08 00 00 38 04  .D............8.
> 	    3c 04 41 04 65 04 00 00 05 00 00 00 00 00 00 00  <.A.e...........
> 	  backtrace (crc 90e9585c):
> 	    [<00000000ec42e3d7>] kmemleak_alloc+0x34/0x40
> 	    [<00000000d0ef055a>] __kmalloc_cache_noprof+0x26c/0x2f4
> 	    [<00000000c2062161>] drm_mode_duplicate+0x44/0x19c
> 	    [<00000000f96c74aa>] drm_display_mode_from_cea_vic+0x88/0x98
> 	    [<00000000d8f2c8b4>] 0xffffffdc982a4868
> 	    [<000000005d164dbc>] kunit_try_run_case+0x13c/0x3ac
> 	    [<000000006fb23398>] kunit_generic_run_threadfn_adapter+0x80/0xec
> 	    [<000000006ea56ca0>] kthread+0x2e8/0x374
> 	    [<000000000676063f>] ret_from_fork+0x10/0x20
> 	......
>=20
> Free `mode` by calling drm_mode_destroy() to fix it.
>=20
> Cc: stable@vger.kernel.org
> Fixes: abb6f74973e2 ("drm/tests: Add HDMI TDMS character rate tests")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/gpu/drm/tests/drm_connector_test.c | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm=
/tests/drm_connector_test.c
> index 15e36a8db685..9c94d26b3486 100644
> --- a/drivers/gpu/drm/tests/drm_connector_test.c
> +++ b/drivers/gpu/drm/tests/drm_connector_test.c
> @@ -1004,6 +1004,8 @@ static void drm_test_drm_hdmi_compute_mode_clock_rg=
b(struct kunit *test)
>  	rate =3D drm_hdmi_compute_mode_clock(mode, 8, HDMI_COLORSPACE_RGB);
>  	KUNIT_ASSERT_GT(test, rate, 0);
>  	KUNIT_EXPECT_EQ(test, mode->clock * 1000ULL, rate);
> +
> +	drm_mode_destroy(drm, mode);
>  }

If KUNIT_ASSERT_GT triggers, then we would end up leaking the mode as well.

I think we should create a kunit_drm_display_mode_from_cea_vic()
function that registers a kunit action to free the mode when the test is
done.

Maxime

--djulfyohgymknlbz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZwzgPgAKCRAnX84Zoj2+
dteBAX9sZC/yS8WOODm2wDyaXfjYOgqVF69VSbh4LDQnHqKFPbOpF0pD8QeumUjs
jAHAFdsBgIGEMTbjs1RdQl0X+E5YvMxs7+ne7Y+v92mgY/wghTGznn7IYKkjTtne
O350WS17qg==
=s+qI
-----END PGP SIGNATURE-----

--djulfyohgymknlbz--

