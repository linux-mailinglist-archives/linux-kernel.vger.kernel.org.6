Return-Path: <linux-kernel+bounces-201220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A8F8FBB23
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 20:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 232591F22558
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C490814A0BD;
	Tue,  4 Jun 2024 18:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V84d1WGM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110595F860;
	Tue,  4 Jun 2024 18:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717524102; cv=none; b=B8GXf8Ax6+fDm4dZdRvXCghXCx6QLpr+yAXK15s2iUM6MNHMCTQCn0LXIM6fYQi8Q4VULVUnHz8lFF5M7TXSvftl5wlKo8f/EKTACbJTT61A7EymHTe7PJAOalDl1ju78Ki07hICaxBMLDxrkD1va27XPYL/rpNEYdC5JLp9iik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717524102; c=relaxed/simple;
	bh=jabiq+bYMyaCPbjrmvXHmgWjqwBntkBS9geWzaYRtxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWWPAcsin3bjejICJ1MZW1sGEh8gcKnuMGD1nDZj0bC8y8QcTcqvA4eAE6bmOvplzVOM/dikapT8xVIwMt4CqpmnQq5PE74icMrHXC9H5hpMAhHg7lbVY3r/j9nlljMPendgaZjIyZ5uIVbV0VmPSdt3GyaoaYcvokDripd9znc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V84d1WGM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271B4C2BBFC;
	Tue,  4 Jun 2024 18:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717524101;
	bh=jabiq+bYMyaCPbjrmvXHmgWjqwBntkBS9geWzaYRtxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V84d1WGMp8sA2h5HN7YM2XOzLhxa8/kTKzQhvQjymVCVLUIQU0edB0+s1FKa0gaa6
	 u869oL/m8wTY/WNjBAINAwpproXnlU4TA98Bqk6KjZNSCeJmLObaM/1Httt67vLlVb
	 VaGSL4pvc7kZFo3/d5PiMy3NTvoBMAgroKUEFO7CLvyy+0lsdhNMC7DMowC8Sc/E0l
	 tkGf7HVmvL/74bdAQzFFQxoYfB4KPUWqPtQM2uR+DWfUdKACM6KqjaNFURidPZ5eec
	 lYPNtonmfKkFeIjB3WcPm9tztrNfnt0zI2HT2kniYsIQ6NvT59JXGvbVPgwDvsObfS
	 JY+jER4biK7sw==
Date: Tue, 4 Jun 2024 19:01:37 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: microchip: sparx5_pcb134: move non-MMIO
 nodes out of axi
Message-ID: <20240604-line-vivacious-b21ff81fda41@spud>
References: <20240604114949.165223-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i034ab8piDjbxxiO"
Content-Disposition: inline
In-Reply-To: <20240604114949.165223-1-krzysztof.kozlowski@linaro.org>


--i034ab8piDjbxxiO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2024 at 01:49:48PM +0200, Krzysztof Kozlowski wrote:
> simple-bus nodes, so the "axi" node, should not have non-MMIO children
> as pointed out by simple-bus schema dtbs_check:
>=20
>   sparx5_pcb134.dtb: axi@600000000: i2c-mux-0: {'compatible': ... should =
not be valid under {'type': 'object'}
>     from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
>=20
> Reported-by: Rob Herring <robh@kernel.org>
> Closes: https://lore.kernel.org/all/CAL_Jsq+PtL3HTKkA_gwTjb_i1mFZ+wW+qwin=
34HMYmwW7oNDFw@mail.gmail.com/
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

These two are pure moves, according to my colourMoved settings, so I've
chucked them on microchip-dt64.

Thanks,
Conor.

--i034ab8piDjbxxiO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZl9WgAAKCRB4tDGHoIJi
0sF/AP4tRHwMYWnHbayQBFbdpB1LI5F6qYW3F2fYtHSk9V5CrgEA4GrmFKiV+ofY
kTXsVGfBFaY4HNh7AJKo1zbeu78P1gI=
=+CmJ
-----END PGP SIGNATURE-----

--i034ab8piDjbxxiO--

