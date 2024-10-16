Return-Path: <linux-kernel+bounces-367707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF439A05A7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E571C24F4F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B97206064;
	Wed, 16 Oct 2024 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrXlXzD+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D656A206056
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 09:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729071416; cv=none; b=kidDvlKJR0bQcnyQP8IQ3TXdAwE3Dfdf72nOIHdskFyRj8xLDjgpLN5nQvouFQ0Y93HYsRl+R67w+gtmznfbunUrEcXnXb5CN5kcS95dqnCZarAIjF69sxrgPKlhVfn3FbsxKlrmJoYUiTirSSDfHd46U5otRcwLu4lvAgUc2PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729071416; c=relaxed/simple;
	bh=84f3LLPF+ZPdxvA7GufhUOFiW1dUptErGeW5em/QV8o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+w6jkYlOvA+Mg1+jrqH9NxElOldb3FkDoFhzPkyMKhDMEfhDP03VUXx32nM5qL134nshnjRF6wCx8hnQItAdDooZKNSDf7DrGP/+JxL44zXkf/lE2GlNqV0WobHvao77B6S3v079Kk0u7iHcTEFZTJPs2BhcXzB1QtDiL4Ympc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrXlXzD+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201ADC4CECE;
	Wed, 16 Oct 2024 09:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729071416;
	bh=84f3LLPF+ZPdxvA7GufhUOFiW1dUptErGeW5em/QV8o=;
	h=From:Date:To:Cc:Subject:References:In-Reply-To:From;
	b=LrXlXzD+J9YnAqfBSFtH4jtMN4tdBuU+VV3RIgrcWomrpgnnPmaKP7wB9b0hdkrSh
	 IAdEXoLxzp2gNZSwHdYl3kiq6C23L8NUda5ErOWj2FsNHzSlOTqw5LyGJo5DU3pyln
	 skcfKAIOUC8CUENM316Gj5VKnqNlupHMMsXPY78Ddc2ktmswPqFf/kGXzmV01poAY2
	 GRmcjWKUhDV28kliAZuH+l3GJwRW860YPt3vINiYjIMbQteXTartUp3XYxBva/tI7A
	 Hc68KEzuX843JeEcIU25BfCY86hJPrp3LaDJF4jXo6TYWW8rglEn9PjY+j5SFD+hln
	 TMVWJResG1Uzg==
From: mripard@kernel.org
Date: Wed, 16 Oct 2024 11:36:54 +0200
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, christian.koenig@amd.com, ray.huang@amd.com, 
	dmitry.baryshkov@linaro.org, dave.stevenson@raspberrypi.com, mcanal@igalia.com, 
	quic_jjohnson@quicinc.com, skhan@linuxfoundation.org, davidgow@google.com, 
	karolina.stolarek@intel.com, Arunpravin.PaneerSelvam@amd.com, 
	thomas.hellstrom@linux.intel.com, asomalap@amd.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] drm/connector: hdmi: Fix memory leak in
 drm_display_mode_from_cea_vic()
Message-ID: <20241016-functional-funky-boar-0ccadc@houat>
11;rgb: fdfd/f6f6/e3e3From: Maxime Ripard <mripard@kernel.org>
References: <20241014125204.1294934-1-ruanjinjie@huawei.com>
 <20241014125204.1294934-3-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="jl4st6wg6rlmq6k5"
Content-Disposition: inline
In-Reply-To: <20241014125204.1294934-3-ruanjinjie@huawei.com>


--jl4st6wg6rlmq6k5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 08:52:02PM GMT, Jinjie Ruan wrote:
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
> Free `mode` by using drm_kunit_helper_display_mode_from_cea_vic()
> to fix it.
>=20
> Cc: stable@vger.kernel.org
> Fixes: abb6f74973e2 ("drm/tests: Add HDMI TDMS character rate tests")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--jl4st6wg6rlmq6k5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZw+JNQAKCRAnX84Zoj2+
dgK2AYCRsSc6ndNGSPAQ/S21KMUOc1enoTDDkvD5YoQObLrE8z2HLp+c6klZEsJG
ppRNohoBf1UOWDAYB0ZdljST28kAuJLTWxZOSDTx2jDsOfYcQMY6XOmUOumICNBd
b3+KMcsJkg==
=CBRS
-----END PGP SIGNATURE-----

--jl4st6wg6rlmq6k5--

