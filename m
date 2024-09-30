Return-Path: <linux-kernel+bounces-343453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C81989B19
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7509EB21126
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7EF14A09A;
	Mon, 30 Sep 2024 07:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8mrf0qD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D3421373;
	Mon, 30 Sep 2024 07:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727680292; cv=none; b=HuMBtgJkRomgM72c9Bg5gRB0DfElTXBVx620b+z8g9EkNQMFJb5oJ2Qh9hYa2wDwRmOqAxscdzQFIOH9CSZEt8p+QyWAmKLtw/xodLPmBidzLNIF5pzqD9AH0Xq9vlX3XoEfJm0BCSIFU5evc+2LYaWMgRn6F3fou2l5NOnbSL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727680292; c=relaxed/simple;
	bh=5gE0eQKarbBdG/N8GRdrx4HzsypjvkZF3NLxrW3tOmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aqtlw+hbraBmXludP/gXi6SlKT1wvGZTmhp7fipFBtNfaqsxAPZlcTqQAXu9hKIwhKpB3zxLMsI144+/mWg1iz3IBKu16ltbmBajY/iMjaVol2E8FHGHqeyrWO9XJvXpGcAwRt3//HHFrXLB+7QAqFg1qu6RLHmcSMw77s3IVs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8mrf0qD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55D8C4CEC7;
	Mon, 30 Sep 2024 07:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727680292;
	bh=5gE0eQKarbBdG/N8GRdrx4HzsypjvkZF3NLxrW3tOmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z8mrf0qDpI6U0qWT5Xfe9bVz8sdg1jtc/JHj+pPmNUuhDqlnsLLtTJTgyqPHihJFC
	 m/YXnawC2F0f6Rp9PaYScRfFB6ZBPFnPyhZFgLCgCBBzLSNf1oVxvTlwbGqYzYEFyX
	 yLIhJfOGQUw++9vAnxYz2B9PcsSCwNG+0wLABCKOxv3G7oFMvCOdDELAR2whw9nmik
	 NDHX1y2Hhi4s017dEkutuu2uEouiNpZq+XKrp//ue5WZTnrHfJ6M1fIF4ICpd7OVLV
	 GyfO1PZIlVLJfAwSUgJ1C7c9TlCsb3Iuji62zY81d2ZRHIRM4m7VwLpr+N5otLUOgH
	 aF9qtK+q1eEBw==
Date: Mon, 30 Sep 2024 09:11:29 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	catalin.marinas@arm.com, will@kernel.org, quic_bjorande@quicinc.com, 
	geert+renesas@glider.be, dmitry.baryshkov@linaro.org, arnd@arndb.de, 
	nfraprado@collabora.com, o.rempel@pengutronix.de, y.moog@phytec.de
Subject: Re: [PATCH 6/8] drm/bridge: Add ITE IT6263 LVDS to HDMI converter
Message-ID: <y4ala34bejzmw5wt3vw5ncoxdzpzda2cwi7bdzve5bn4udmr3b@eiguckpaui6d>
References: <20240930052903.168881-1-victor.liu@nxp.com>
 <20240930052903.168881-7-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="4pawbxwfkwm2rvaf"
Content-Disposition: inline
In-Reply-To: <20240930052903.168881-7-victor.liu@nxp.com>


--4pawbxwfkwm2rvaf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 30, 2024 at 01:29:01PM GMT, Liu Ying wrote:
> Add basic HDMI video output support. Currently, only RGB888 output
> pixel format is supported.  At the LVDS input side, the driver
> supports single LVDS link and dual LVDS links with "jeida-24" LVDS
> mapping.
>=20
> Product link:
> https://www.ite.com.tw/en/product/cate1/IT6263
>=20
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Generally speaking, you need to use the new HDMI bridge infrastructure.
There's a lot of required things you're not dealing with here (such as
infoframes)

Also, you should add a MAINTAINERS entry

Maxime

--4pawbxwfkwm2rvaf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZvpPIQAKCRAnX84Zoj2+
dqvYAX9I87/HqBwOqoEON9kE2R3ppakKzN3DPMpFyFZKLJIZTnQ8dLGTfO+tDhvd
QKRxnf8Bf31b3DAkdSxRy3s14jonZ+JPFhY1hLAPEkg6Ra3YPDeKIHMJ5NMPiUz6
/mTkSjEfPw==
=AjJ2
-----END PGP SIGNATURE-----

--4pawbxwfkwm2rvaf--

