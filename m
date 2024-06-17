Return-Path: <linux-kernel+bounces-217962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8792E90B6F3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B99B1F221CA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E7916A933;
	Mon, 17 Jun 2024 16:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5/Gm9TB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32568169ADA;
	Mon, 17 Jun 2024 16:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718642825; cv=none; b=bSwpWTV/LXjXHmAoGjj4UNuiss5odOwbZDM5Q6CINVGy9CjVN6obkC7FzVSzMz94E5X4SmqMZhhrzIzPr1LQF5/Hz66XzpOb4q+f10mBj19Jqb/OXW7UQesdddz0BxUOWJIu1+gFUGYfLq1SuFKc8ogUgIfs9rtB6rn/awvSxdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718642825; c=relaxed/simple;
	bh=2JAWJpDzmpr0BQoqiQMfikwtE07tNC448jmHVaAC/oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6euw1b5y/UoydvqHP9UAi7mvJElDKA48z5Gwp5+zNTo9gyhXiA+pmPezyRfpVGi2VEmKT4VQwLDTpvGDy7eEUBLEiqS7aihPaiy02Biddi8e7vig1yXjdmY8CP9wc3tXy38kkaaF3nb4ZwHLLmAIZx+tCJ/Vu604b3nRXFpX6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5/Gm9TB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D27DC3277B;
	Mon, 17 Jun 2024 16:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718642824;
	bh=2JAWJpDzmpr0BQoqiQMfikwtE07tNC448jmHVaAC/oQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j5/Gm9TB6EUMMm6OKz0GAexrMi9CBJz/6yDk0Efj0QokaqaljiXEjxphj8oEvAs/+
	 OPHEf2j8A1hc1smGI8IfvBajWdOO1Efb5bLUTcd9uII4S4wpyQv23kYWXmjzhkwQ3h
	 Vs9vHxWkOqupPmdHY33bavNvo+9tTxaG4Zr0ozGYze7Kdi3kunDVPgyHPZ7ABXfG3n
	 bd8qAAny2AoQ7M1xg9Ej6xOCvwhX777+pNqfgNP8JNQAimanG5Fu5UE3kLzfsvdLXG
	 b6ODKSxpIiW9gT+BdVgT7fyE3FYJL8xj7oadXWNNb16m0BCyVHFgzowliLKy7HSedR
	 wI6wst5hHjQhQ==
Date: Mon, 17 Jun 2024 17:46:57 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Orson Zhai <orsonzhai@gmail.com>,
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
Subject: Re: [PATCH v2 3/7] dt-bindings: soc: intel: lgm-syscon: Move to
 dedicated schema
Message-ID: <20240617-multitude-referee-998504c2ca87@spud>
References: <20240616-dt-bindings-mfd-syscon-split-v2-0-571b5850174a@linaro.org>
 <20240616-dt-bindings-mfd-syscon-split-v2-3-571b5850174a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QRkbanEbbdMctthM"
Content-Disposition: inline
In-Reply-To: <20240616-dt-bindings-mfd-syscon-split-v2-3-571b5850174a@linaro.org>


--QRkbanEbbdMctthM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 16, 2024 at 03:19:23PM +0200, Krzysztof Kozlowski wrote:
> intel,lgm-syscon is not a simple syscon device - it has children - thus
> it should be fully documented in its own binding.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--QRkbanEbbdMctthM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnBogQAKCRB4tDGHoIJi
0ggiAP9We2auCjrUjnhLFnKXvxXv8sjQJRX/4KcNbM5fjg1MtwD7BiR7qMm2RWeU
Tk9/riWUz3g8JSUboHqvq9hxmrc/Bg8=
=rN+C
-----END PGP SIGNATURE-----

--QRkbanEbbdMctthM--

