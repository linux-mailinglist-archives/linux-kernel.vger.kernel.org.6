Return-Path: <linux-kernel+bounces-406476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA1C9C5F88
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91609285D24
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A678215C68;
	Tue, 12 Nov 2024 17:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lnnh/sKj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C8A2141D6;
	Tue, 12 Nov 2024 17:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731434020; cv=none; b=s7Hq+1n1qpeUSu36H2od1y9ObiiOPUuCMC0jDqEBaDWTuDWjNR3MLTzYzuCUTjodBVifnNZb7rPPGWF4WvpixllFQeVSErL8FAHMLYWM2ajcObd9cySVgQoRCRxw65AVpOdK6F8KClD60+EnXoHs5cAXk0QCEXv2EqbEhsXUmhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731434020; c=relaxed/simple;
	bh=mjaZInMpBAbkCA4E5OU9QfNO4D8qD2vAuWT2Q/jQS5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbjpK/iqLLtcVn5MnDT8n6fMmz5XGH3zqF3dFMcJTHx6liPKCOju/UGeyG681nO47bk91pkqOhUQlVcDkvpf+mU+hLosb8xtO6Hyti3UQiyep1BAJpJ12ey8NClFW+OCWHnfA8HRVVopAlIRbk+5RAg47/CveIXO11oNx7oS2x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lnnh/sKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5973BC4CECD;
	Tue, 12 Nov 2024 17:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731434020;
	bh=mjaZInMpBAbkCA4E5OU9QfNO4D8qD2vAuWT2Q/jQS5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lnnh/sKjKv+RHS6oskPYA9NGkaNCdP4vd0WXfoFlrUDn84S/nQAlO5NzSz3qwh311
	 HTwIG0mEMfVsjmOyEvvE3kdYvg0eHb+bOFvdyJlIeDY4wT0oIKprFKrdZbjYUWXSbA
	 pQUNTWd3v0z9/xNOo4HnvGgxJ9z5QvfKHAR447HGTNI34YnwKJX9cR5UPcNAs94ZXR
	 0jq+IETui39IiQjL2Djq4PauC+9LZWz7Z534CxkTB/Y6vqpPik5yF8kva4PL7TynfZ
	 irQ+QhLcsPcvWpw00lPKZwS1+Cv1gHNjOwSnubFg9CR2SdXyUfZxJDsBoX29B6HPR6
	 ftN8cu6PiN7Hg==
Date: Tue, 12 Nov 2024 17:53:34 +0000
From: Conor Dooley <conor@kernel.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, gregkh@linuxfoundation.org,
	andersson@kernel.org, konradybcio@kernel.org,
	dmitry.baryshkov@linaro.org, mantas@8devices.com,
	quic_rohiagar@quicinc.com, johan+linaro@kernel.org,
	quic_kriskura@quicinc.com, abel.vesa@linaro.org,
	quic_kbajaj@quicinc.com, quic_wcheng@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v1 1/6] dt-bindings: phy: qcom,qusb2: Document IPQ5424
 compatible
Message-ID: <20241112-proud-moisten-13900b835e29@spud>
References: <20241112091355.2028018-1-quic_varada@quicinc.com>
 <20241112091355.2028018-2-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HEptGeQSGxI0F2Id"
Content-Disposition: inline
In-Reply-To: <20241112091355.2028018-2-quic_varada@quicinc.com>


--HEptGeQSGxI0F2Id
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 02:43:50PM +0530, Varadarajan Narayanan wrote:
> Document the compatible string used for the qusb2 phy in IPQ5424.
>=20
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--HEptGeQSGxI0F2Id
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZzOWHgAKCRB4tDGHoIJi
0mTcAQCv3BSj7k0bxTkdDbn6NXaI13elDe2ReD+NRb36KT9RTQEAuViXZO3eWe0i
l/g+guT1pbcTWXO5vT9c0xpTwap0OAU=
=lPxM
-----END PGP SIGNATURE-----

--HEptGeQSGxI0F2Id--

