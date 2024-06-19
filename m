Return-Path: <linux-kernel+bounces-221560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCF990F57B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 19:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663391F225A0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 17:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF20156669;
	Wed, 19 Jun 2024 17:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lq75alNZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DD820DCB;
	Wed, 19 Jun 2024 17:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718819399; cv=none; b=q677Et0JMhC5YaYiE8HSeG/vfRqbSHzk94gh5MuZR1/vVw46Z9Nv+LCswgyLheeH6VZXwuWJwjiQgWA9xSd0O5eochDVCsIZIvl/gSiyiejFuZ7ehmzyBYVh4Ayo95RlF86MFElJbzxLLGL7orwyPt6xBM3/hJHgFu887oFYH00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718819399; c=relaxed/simple;
	bh=kfvIYYYXhENfQB2lgd26zgh9v3EDCNJsSZYFyuR+SBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9xfi9Hn5X/UerrpkNpJoO5lZLUU3dplLQGkjvOX6lPa3zs2ELAZd48zok+LiJTPNmuUwTwx8fnjyoh4PJV7YUy1zlsyFNoGI7jBdfW1RIi06XWiYkq/hriPfYadGK6BLbf3omY5u/JxMTFuU9G/Tl3nghnWctreH91ZeEfltY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lq75alNZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2542C2BBFC;
	Wed, 19 Jun 2024 17:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718819399;
	bh=kfvIYYYXhENfQB2lgd26zgh9v3EDCNJsSZYFyuR+SBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lq75alNZQe0ZVzjGWgF9iCE3BtO2VXcDoyEYBDRjg74Hv+mLSeaHQDUDCE9Y/8Pnt
	 ukJfIhxMLSEVfsIKELp6ElCVKI44Fdv7p2jhEqAFiHy2QTYsvSRcNo49LCizREWu0B
	 DCXZG3/ICRNoynOhWCl+OfCvBwcIHEtiku1elw7dtdX4TKTwqNapHzPuWAfsf882Rr
	 pdP/03Hj6f+mlTudw1BgBtxCaPACZOA7WCGsXwUFc++eHnp4T1MSMFMXgrDGBYQU1l
	 A++L7ZmMVLgsNd9hpztW68SWwh3vyCRCsVsTEcBvg5E2zRvnfVGOcy6kxSLfebk3P/
	 VLRy2kM2lO2dw==
Date: Wed, 19 Jun 2024 18:49:53 +0100
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: krzk+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
	robh@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
	jassisinghbrar@gmail.com, garmin.chang@mediatek.com,
	houlong.wei@mediatek.com, Jason-ch.Chen@mediatek.com,
	amergnat@baylibre.com, Elvis.Wang@mediatek.com,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH 3/3] dt-bindings: mailbox: mediatek: Avoid clock-names on
 MT8188 GCE
Message-ID: <20240619-sleeve-citable-a3dc10e5cd4f@spud>
References: <20240619085322.66716-1-angelogioacchino.delregno@collabora.com>
 <20240619085322.66716-3-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cyPzD5ebqalhMMLd"
Content-Disposition: inline
In-Reply-To: <20240619085322.66716-3-angelogioacchino.delregno@collabora.com>


--cyPzD5ebqalhMMLd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 10:53:22AM +0200, AngeloGioacchino Del Regno wrote:
> Add mediatek,mt8188-gce to the list of compatibles for which the
> clock-names property is not required.

Because, I assume, it has some internal clock? Why do either of these
things have no clock? Doesn't the internal logic require one?

>=20
> Fixes: f2b53c295620 ("dt-bindings: mailbox: mediatek,gce-mailbox: add mt8=
188 compatible name")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  .../devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml     | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailb=
ox.yaml b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.ya=
ml
> index cef9d7601398..55d4c34aa4b4 100644
> --- a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
> @@ -62,7 +62,9 @@ allOf:
>          properties:
>            compatible:
>              contains:
> -              const: mediatek,mt8195-gce
> +              enum:
> +                - mediatek,mt8188-gce
> +                - mediatek,mt8195-gce
>      then:
>        required:
>          - clock-names
> --=20
> 2.45.2
>=20

--cyPzD5ebqalhMMLd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnMaQQAKCRB4tDGHoIJi
0qzoAQCbPlRk5egc83ziM5jXYPCmJMaADhzH2l5S9aOOvAPhAQEA/qWFFnhAnsFU
k4cpnxAR7PDqgTBWGHNsR9LvHRcEywg=
=/di+
-----END PGP SIGNATURE-----

--cyPzD5ebqalhMMLd--

