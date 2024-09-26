Return-Path: <linux-kernel+bounces-340758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE4898777D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 18:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08BEF1C227BC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6333158DCC;
	Thu, 26 Sep 2024 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="og4sylJb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C632F510;
	Thu, 26 Sep 2024 16:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727367923; cv=none; b=sWZZEYFU/i+8ryQRuXoAuWQb2uFWlOUh43Izf7E8u8li4kU6GDEtVP4VgsEL1TegNbVdUSYWMsww9KuiucuF+DSm/YSVRRC7ztvAuGUNrFG2pTG8IpWjyFinEBAytcIMiDAYpCnZKhnV4mu0EM+3TlCv9e0qTfsofGQyHmOXSqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727367923; c=relaxed/simple;
	bh=B8iLCJEN9rehuLkyemSP/P0mW8WiYBdBMfgJGeUjnWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTZ2jXYg9o7RN3iQnytE/PEryEudff7lA5jevZ2ASN6RGOlC/mRQ+6X2rKwluwVebJ8YasCLbNkc2rcooxnIr5ZudBKahR486u6weB4fQAKAizpKQD9nhRkOni87e4OXHZbzbbZ04lqJYz29lMkPFv3ONxmAqLsMCE1cVQxvP0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=og4sylJb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB22C4CEC5;
	Thu, 26 Sep 2024 16:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727367922;
	bh=B8iLCJEN9rehuLkyemSP/P0mW8WiYBdBMfgJGeUjnWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=og4sylJbjpQArFQWkV0WlbDkKWm5S/6OIp5xqEim/YHTSRlIRxqagCoFCJkHEF/7h
	 8fuNRyBDLfqBXLXzZw7xao5Dn8roveccwUeNDitiF/jDERq4cRKlXK9di9+Ga3hu4x
	 7voxgZewV890lp+47MOpuXekGsFRIGWir0xg4K6Hox3yxhUfOKq778YhhKYhiXlbCX
	 xgxi3uQRVIZ58B0qAhbUVB3J801qiiGsnwCe+FEEaLfKWoO/+hee6BV1UE+c9a06d0
	 4QSaa5guU5Mva/qHKSUQKMPfz4t6NcxgI04cqiqwpE6SSyRNIhIBNOEZLbG/W1U3oI
	 3bBRY7c1IqihQ==
Date: Thu, 26 Sep 2024 17:25:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Bear Wang <bear.wang@mediatek.com>,
	Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>,
	Sen Chu <sen.chu@mediatek.com>,
	Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH] dt-bindings: phy: mediatek: tphy: add a property for
 power-domains
Message-ID: <20240926-treadmill-purr-b2e3279a14a4@spud>
References: <20240926101804.22471-1-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w3rN3Cezyqcq/8tm"
Content-Disposition: inline
In-Reply-To: <20240926101804.22471-1-macpaul.lin@mediatek.com>


--w3rN3Cezyqcq/8tm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 06:18:04PM +0800, Macpaul Lin wrote:
> Some platforms requires a dependency for power-domains.

Some, so not all? Why isn't this restricted on a per compatible basis?

> So we add property 'power-domains' and set 'maxItems: 1' in the
> DT Schema.
>=20
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  Documentation/devicetree/bindings/phy/mediatek,tphy.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml b/D=
ocumentation/devicetree/bindings/phy/mediatek,tphy.yaml
> index 423b7c4e62f2..c77fe43c224a 100644
> --- a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> +++ b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> @@ -125,6 +125,9 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      default: 28
> =20
> +  power-domains:
> +    maxItems: 1
> +
>  # Required child node:
>  patternProperties:
>    "^(usb|pcie|sata)-phy@[0-9a-f]+$":
> --=20
> 2.45.2
>=20

--w3rN3Cezyqcq/8tm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvWK7AAKCRB4tDGHoIJi
0n83AQDmlf3s79564V1ZUYmAOBOtHb3MjKIx+OlxbtvzS1/hPwD/d3J9i90sPxTf
lSL+nqfbpB2W2qroRWWrLyD2axXVpQw=
=2EfV
-----END PGP SIGNATURE-----

--w3rN3Cezyqcq/8tm--

