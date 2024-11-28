Return-Path: <linux-kernel+bounces-424962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE259DBBD1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 18:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65542281ACC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 17:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A001C173C;
	Thu, 28 Nov 2024 17:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmdEJ8UX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2898537F8;
	Thu, 28 Nov 2024 17:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732815473; cv=none; b=jrp/KO8DbDQIyyNPWDYz3yVdlf/96o9WljPd/znrEaK4EhZx7AbHL6+LS0JXK8AfYxnMhKmt6U9brtQIHUpV/SXBZe0dMhHT0TgrV0dauYbDH1dj0twynFLulNXiS33uUVIHirMvB0nM570WfUYq2qtoXw/1lEDMYmyPWusg2Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732815473; c=relaxed/simple;
	bh=o0pwC6XMRknJjTBnnyoXbxHTkRylRZacGbA62fKdvIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnqq6yB1ciL/6Rdfz+om2+zztcISKoAMrxPI6VSCVx4qGoo9HH+f4BgElUVlOTYU8QNC/v8n0HvrSBAXyBmEBLZ1mxUfbLQ2jXBZE+Ssz6V0zNw8GsKcwsJVphtUFXsRH45KUGBAf/HsQzsQD29JFSBTaB0RbOaFVHxDNa2ZWco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmdEJ8UX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64A7C4CECE;
	Thu, 28 Nov 2024 17:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732815473;
	bh=o0pwC6XMRknJjTBnnyoXbxHTkRylRZacGbA62fKdvIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SmdEJ8UX+T5rOEd1AGccC/II4MDyux7ErVstPuUFtEywl+C2wRVoMvQcTnYbAh/Wi
	 0iHouiETVr24Ot+mwYvGa72HwsMzKK3m5hZefZYkvwvjOqqYTK2WBput0cGg3QdkfB
	 P0tZrJ8z+1tThSqNz5MNdo242UmpEHeJIVv87orStQweRrfu/ay72EwB6yT3D+EjwF
	 4cGH1oANQizLuL5omgqjbkeO023xM1ajxnv7Yu36qaqRIt2u9Th+S1COWW+MoMVg+X
	 mBItimBVANBM+VjBeGX30rDILMHB3gBwHE37CTTLD1iwusM5TFoNRWc7VW47ZTuJDw
	 PY0oymZCMcvag==
Date: Thu, 28 Nov 2024 17:37:48 +0000
From: Conor Dooley <conor@kernel.org>
To: Frieder Schrempf <frieder@fris.de>
Cc: linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Robin Gong <yibin.gong@nxp.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Joy Zou <joy.zou@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 01/11] Revert "regulator: pca9450: Add sd-vsel GPIO"
Message-ID: <20241128-candle-guzzler-b7ea4e5ce643@spud>
References: <20241127164337.613915-1-frieder@fris.de>
 <20241127164337.613915-2-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="N/ZxYTIhZMLCSiWb"
Content-Disposition: inline
In-Reply-To: <20241127164337.613915-2-frieder@fris.de>


--N/ZxYTIhZMLCSiWb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 05:42:17PM +0100, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>=20
> This reverts commit 27866e3e8a7e93494f8374f48061aa73ee46ceb2.
>=20
> It turned out that this feature was implemented based on
> the wrong assumption that the SD_VSEL signal needs to be
> controlled as GPIO in any case.
>=20
> In fact the straight-forward approach is to mux the signal
> as USDHC_VSELECT and let the USDHC controller do the job.
>=20
> Most users never even used this property and the few who
> did have been or are getting migrated to the alternative
> approach.
>=20
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
> Changes for v2:
> * split revert into separate patch
> ---
>  .../devicetree/bindings/regulator/nxp,pca9450-regulator.yaml | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regu=
lator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regula=
tor.yaml
> index f8057bba747a5..79fc0baf5fa2f 100644
> --- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.y=
aml
> +++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.y=
aml
> @@ -77,11 +77,6 @@ properties:
> =20
>      additionalProperties: false
> =20
> -  sd-vsel-gpios:
> -    description: GPIO that is used to switch LDO5 between being configur=
ed by
> -      LDO5CTRL_L or LDO5CTRL_H register. Use this if the SD_VSEL signal =
is
> -      connected to a host GPIO.

Your driver side of this, that I wasn't sent and cba downloading an
mbox of is not backwards compatible. The code has been there for a few
years, are you sure that there are no out of tree users or other OSes
that use the property?

tbh, I think all 3 of your dt-binding patches should be squashed rather
than drip-feeding the conversion. It makes more sense as a single
change, rather than splitting the rationales across 3 patches.

--N/ZxYTIhZMLCSiWb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ0iqbAAKCRB4tDGHoIJi
0mT0AQCiXTwqFM5+GxJLCoh7WYfKuJN5s4Z/8m1bpp4wS2AK0AEAkpOHLVq34pmH
y8/xAjnEN7qQ1XsI4kWZ/mGj5QtgoA8=
=zhjq
-----END PGP SIGNATURE-----

--N/ZxYTIhZMLCSiWb--

