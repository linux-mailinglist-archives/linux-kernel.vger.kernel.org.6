Return-Path: <linux-kernel+bounces-556691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC310A5CD6D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAAE817CBFF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEC22641C9;
	Tue, 11 Mar 2025 18:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8gOrxnv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C11263C8B;
	Tue, 11 Mar 2025 18:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741716743; cv=none; b=fdAK10G99tjOMXkEn5gN29EZTso2kqpFyMYS9Z+4nw8OI4g+kYmrjZ6pEHg4FGF7Ahar0ToMxwcJSPj4r55OmKSEc5qUWWQjbZkjAd1Sol5siaWO2oa1jG5rNxlHH/AB8/SnxKNPEWeBY3J5pBc8LGdamxZ2FZkSGxFaXpmSoBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741716743; c=relaxed/simple;
	bh=3H5O6bWO/yhhqtga12cTBlakPqsT0CqcPydgL8g9Xeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJGtwKc2N0XO9kl794U5VIqEKa0ELjGd6kJm0H430MQalbSD5Y7zF90k+1F3K1uLz/lTymW37q4K174+/jSmzJ+UUkTK6sMkF1UIbABv/HmR/tZqWK0O25hKBZNGt33HFTKibuG/8B13nDLB4jHP8NHM/a7hVwV1IA9ZZPbDiN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8gOrxnv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A918C4CEE9;
	Tue, 11 Mar 2025 18:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741716742;
	bh=3H5O6bWO/yhhqtga12cTBlakPqsT0CqcPydgL8g9Xeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B8gOrxnvhqd7g5q2G+7udUnkNP0oImP6iG9oOu18TP8KImBZJdYGGeBqtmyA94Pok
	 bdYtg4YhaB1dVfdGzpCs2FFVOPt4t6lG8ycFg4b6Q/wEA1PQeh7I0uj4ZfvrvtYbDK
	 LhuZYHMcJwVz5wPNkw/ImDq+1pqKFEnuaDud+Oxp6lIuaPhthxvdcUxWMvmWYiEZou
	 zMqT/8YOo0l2bqYYttA4hGhcPki4Gwn4uvItSVu2NrnMKO+nPmKPJg/gaw147eTTW/
	 +ihLgsw3X2OLZ2Aq84/Qyp0gsqwoBApxwNWCO1geeSkQQgUIatLWmvKelcW4UXQzOX
	 q//kQsiKQnnFw==
Date: Tue, 11 Mar 2025 18:12:16 +0000
From: Conor Dooley <conor@kernel.org>
To: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Min Lin <linmin@eswincomputing.com>,
	Pritesh Patel <pritesh.patel@einfochips.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Yu Chien Peter Lin <peterlin@andestech.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Kanak Shilledar <kanakshilledar@gmail.com>,
	Darshan Prajapati <darshan.prajapati@einfochips.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>, Aradhya Bhatia <a-bhatia1@ti.com>,
	rafal@milecki.pl, Anup Patel <anup@brainfault.org>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] dt-bindings: interrupt-controller: Add ESWIN
 EIC7700 PLIC
Message-ID: <20250311-stitch-revisit-9f24ef006dca@spud>
References: <20250311073432.4068512-1-pinkesh.vaghela@einfochips.com>
 <20250311073432.4068512-8-pinkesh.vaghela@einfochips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YTSoY6KxqwAVELjH"
Content-Disposition: inline
In-Reply-To: <20250311073432.4068512-8-pinkesh.vaghela@einfochips.com>


--YTSoY6KxqwAVELjH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 01:04:29PM +0530, Pinkesh Vaghela wrote:
> From: Darshan Prajapati <darshan.prajapati@einfochips.com>
>=20
> Add compatible string for ESWIN EIC7700 PLIC.
>=20
> Signed-off-by: Darshan Prajapati <darshan.prajapati@einfochips.com>
> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml         | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifiv=
e,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/=
sifive,plic-1.0.0.yaml
> index 3dfe425909d1..ea7093fde060 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-=
1.0.0.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-=
1.0.0.yaml
> @@ -58,6 +58,7 @@ properties:
>        - items:
>            - enum:
>                - canaan,k210-plic
> +              - eswin,eic7700-plic
>                - sifive,fu540-c000-plic
>                - spacemit,k1-plic
>                - starfive,jh7100-plic
> --=20
> 2.25.1
>=20

--YTSoY6KxqwAVELjH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ9B8/wAKCRB4tDGHoIJi
0p6EAQDifbJmeyNsMj+bYCpjnv1K/o1pQIdyzSatN7nK3XfckQEAqy0UUe1dgpw9
HgV3/eXX2X+SVhYeCCMy5KEoMW8lWQg=
=dAbH
-----END PGP SIGNATURE-----

--YTSoY6KxqwAVELjH--

