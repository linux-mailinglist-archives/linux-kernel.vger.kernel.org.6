Return-Path: <linux-kernel+bounces-219993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5749A90DB42
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F009283689
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE1614D718;
	Tue, 18 Jun 2024 18:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feFRdtCv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2794713C8E5;
	Tue, 18 Jun 2024 18:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718733892; cv=none; b=sWf3OCP7c4KWkU3ufx/Qpo9GKjuf8O2mvUIXO6GCq95W7MweS0MbftyHQ9Nydw+8Wbg1Zdb22LyE/cKstAA1crLF3fiB3qCCHsenwiTkBxJL8n2Ft5d3JNmhGPtHDbgQUeQYydBpkwhKb1mMa0lAIt03h5n4IfRkvxNmoBVa030=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718733892; c=relaxed/simple;
	bh=WhsmaZClS4UFz8GTvpaAyLD2s2XlHPTwx0gfZZTBlm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biyNLDdPRLxVQZOTO+MfaqTo2NX4FdZYFZXMWKKqJq0YdhEc/tchF95xq8AbBueR+fqUHM0uA5t+HqpbyY2lMBsCLEfh3i+KLZX6DrNq7QV+34MGGd+OXQgMAcKYQevd8GEqw3TAof0QuxZc0LZDj2M1v6gnhLXFQmfSwUtFULQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feFRdtCv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18C9C3277B;
	Tue, 18 Jun 2024 18:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718733891;
	bh=WhsmaZClS4UFz8GTvpaAyLD2s2XlHPTwx0gfZZTBlm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=feFRdtCvGTTIAP9lyJbb6CI2LQMs3uQPd5ICY3w2sZHug0Nco8+IRAxSDT9pINJw4
	 vtySzPIjoojNRfLVLMp21Ub0r2/5H4fx2fvmiXlU/EHF+Uiu7NFUyAxHlGQXvimPHJ
	 9fT8wVIsyZl0slxY2KL1KE5lMQTOOeF3tlXZ1BtXAq/as6Pm+JsVR6BXpO8s4QBQk5
	 q8XlRX06skbUrD5nJ4x9UJDFISaj/hRbVvl5Wh2LwS0ZenE2Y5IH0K159HVqEM1lnT
	 HZP5N/mRCDjC5Jte9DkDTy3af+XuOUU2P39n54kwQTIvnunAlpyBMf8dIuJWFTTx6X
	 1XKdQSH73ggDQ==
Date: Tue, 18 Jun 2024 19:04:44 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com, Nishanth Menon <nm@ti.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 6/7] dt-bindings: mfd: syscon: Split and enforce
 documenting MFD children
Message-ID: <20240618-treadmill-acrobat-2c3969605257@spud>
References: <20240616-dt-bindings-mfd-syscon-split-v2-0-571b5850174a@linaro.org>
 <20240616-dt-bindings-mfd-syscon-split-v2-6-571b5850174a@linaro.org>
 <20240617-zoology-silica-2c8c78363b32@spud>
 <20240617-purge-family-c0c62b8e73d8@spud>
 <237035a7-3b71-4245-863b-f905ba97cda1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wjTlRL5JLkeRMMvv"
Content-Disposition: inline
In-Reply-To: <237035a7-3b71-4245-863b-f905ba97cda1@kernel.org>


--wjTlRL5JLkeRMMvv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 07:35:07PM +0200, Krzysztof Kozlowski wrote:
> On 17/06/2024 18:46, Conor Dooley wrote:
> >>> =20
> >>> +# Need a select with all compatibles listed for compatibility with o=
lder
> >>> +# dtschema (<2024.02), so this will not be selected for other schema=
s having
> >>> +# syscon fallback.
> >>>  select:
> >>>    properties:
> >>>      compatible:
> >>>        contains:
> >>>          enum:
> >>> -          - syscon
> >>
> >> Wow, this is noisy. Is it not possible to achieve something similar by
> >> making the select check for not: compatible: contains: simple-mfd? Or
> >> did I misunderstand the intention here?
> >=20
> > Ah, you'd match things then like the intel,lgm-syscon, right?
>=20
> Yes.

With the nits then:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--wjTlRL5JLkeRMMvv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnHMPAAKCRB4tDGHoIJi
0krvAP0aqhQ2KBWtG6LP5XEOMKNZ9IKzejgi9k6qu3Dd2kE78QEAkFCluzr4U+fG
GR52nK/ZYKSX5nHm/SJ6mtLwLXgBMAo=
=OJJk
-----END PGP SIGNATURE-----

--wjTlRL5JLkeRMMvv--

