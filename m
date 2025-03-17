Return-Path: <linux-kernel+bounces-563870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F800A649F4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D9D3B2669
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BE322CBE3;
	Mon, 17 Mar 2025 10:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsT8zkEM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F14F238144
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207058; cv=none; b=NE69utlL8sUlbcFjngohLiY2z2RAEIdlJjvjOpeZ7WLV96KM09sreQn6q920bt/jwYwgMVku8NQ7Zed4j9YNHjZlwd9vs5inlYIs8lJinqqoZUuG76HhWHJ2hU11rFPAyyYFOmXDllma9mAI9hCkiXCeVBz6D/KcXBS4EY5sINc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207058; c=relaxed/simple;
	bh=tlarjgiZzL9OE0iLqijT1bK5V/tP6SZTIlUfQURn3UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2TEERqrIurrNVoFcRxrHsyW6U8GwKTVEkgJxg7UTwU5LDWo8AF1qJfiKwHv8ipDd4TYQarI5I1gyPy/Si7QY/ipn4l9xFF8dKACtVumdPBOTy+jupfi5rgHAA4TonbcfvaHAJP0jWogkM0N+2xsdZ4O1KPAkO3RARy7+j1IUlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsT8zkEM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC87C4CEE9;
	Mon, 17 Mar 2025 10:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742207056;
	bh=tlarjgiZzL9OE0iLqijT1bK5V/tP6SZTIlUfQURn3UE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bsT8zkEMnO0+CDtBl13VefztpEflaKYcUQ/jmLtmpD3wdBL2cst46YCx9qh3tdT+5
	 FqfNLrv7CY9S0i+e4CpZwlVq4pf/sNv0aNsUED3IkRbQ0lJdLZwNRcTmLjwAAtT47P
	 qVn/lIeFEehS5iWMmUyX3wtIOqWu3TLWStOkdIr+kTGHQl5AtcfbxtVxsAuO+Y1QL4
	 d2Av5TURH57f/pLqm2KlZcqsuhlEMYERvgeh+ayLZjOhMak3PnbHZdixRCPqN1Ad/U
	 mC0HAWCsvAzA8/u/nh+HRsgj7B0wgspXvHHvR8sXWET3OriLuMy6G3i31INskUxHe5
	 DPOgE4OVlelmg==
Date: Mon, 17 Mar 2025 10:24:11 +0000
From: Mark Brown <broonie@kernel.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 9/9] regulator: dummy: convert to use the faux device
 interface
Message-ID: <e35ccf12-3959-4ff6-b0fd-ae9374c90de9@sirena.org.uk>
References: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com>
 <20250317-plat2faux_dev-v1-9-5fe67c085ad5@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rqsauJmOOJ0bBl8N"
Content-Disposition: inline
In-Reply-To: <20250317-plat2faux_dev-v1-9-5fe67c085ad5@arm.com>
X-Cookie: I know how to do SPECIAL EFFECTS!!


--rqsauJmOOJ0bBl8N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 10:13:21AM +0000, Sudeep Holla wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>=20
> The dummy regulator driver does not need to create a platform device, it
> only did so because it was simple to do.  Change it over to use the
> faux bus instead as this is NOT a real platform device, and it makes
> the code even smaller than before.

This is already in Greg's tree isn't it, what's going on here? =20

--rqsauJmOOJ0bBl8N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfX+EoACgkQJNaLcl1U
h9Ci0Qf9HZr3+TgS1lZyhWwVv+Z/poPmwUVbjWF/p7Ol2JLoMlAv35TFaAA6SWLp
lwfTxt7Mlb6zHWFqgFWdY+oE+zDzkEITJsyuHinw5Sie5k5Lmp/rmzqNB0tFvu4N
Oo6ISivRRBgSCMLbQ36pzInqFIEAIEfQGBnZAIcJm8MOYs6OV3MiHdTjRajOejhz
drFoJyIAqceAwt7LLb2rIrODgVt/8p5QNej0F+lZXNnaUbq+Ev8gyynqJC7ekjCP
wTWlRDkbj9xCgX1Gp/hEonmVeHZ7xT7du/u8Jp540OjyTXdoLtYtCnkjI6wFZIW4
X87m3byc9E6DyxExi8D94+j74DAnFg==
=nxlN
-----END PGP SIGNATURE-----

--rqsauJmOOJ0bBl8N--

