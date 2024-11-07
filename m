Return-Path: <linux-kernel+bounces-400337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F0B9C0C0B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA7622833A1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4D2216446;
	Thu,  7 Nov 2024 16:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESwG9v9k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B883E1DF273;
	Thu,  7 Nov 2024 16:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730998599; cv=none; b=G1lrCr+xsWi6ygPVRK4XVzLV7lNQhxb6/0pAkFwA8SKbriyMqNc4fzpHSZ2IEhmW4ncv1vCXI5D72/DOrKjOmdwh97EHB5oeJzE/jRCGe5JO5OZhTuIA5h5IN5PIhj6iHfV4I7y5piZUW5WAbKBroYCMTclETkXO9/2DraAfn7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730998599; c=relaxed/simple;
	bh=d4CFpVNMwGPMLHkiKn9CxHazr1rQaQ1DQ5YmH8gbPaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ky5/ZaNx+Ffi+e9lnEMd9+SH+VGTCnp31DLWUEyzmaW+vKEwc5AN78nycueoBFYYGP6V+WMeLftO7ZHGODgyIM6Rn/ERQ0Ks51kJ8iHbQsGJUDEWBbJ1/DVNvkWWfue0mpipHQRC3iJfv/Fzc68l6jQ6cUaFRZHFZsLoMmbJVfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESwG9v9k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC68C4CECC;
	Thu,  7 Nov 2024 16:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730998599;
	bh=d4CFpVNMwGPMLHkiKn9CxHazr1rQaQ1DQ5YmH8gbPaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ESwG9v9k/PbQRXcfACcR7LEy9hKW+uGDQwbaPrIMU1yCDnh8qajuBDdTUw4tTKZ30
	 h5Azc2zR8L61YpaM2gvAtX012+vIj8M+1bYTvDFi9HwD65Y4h7MzdigGOZM77TaiYP
	 POOGfY++Glr6rwSfBvDWrur+p1yWDsC/Vis9HHAFtJ1xavxtZL/345JIPOjHOLoYZI
	 h0EEWGFxf8hnMdQhEwql3FzRG/1SojWeQ3Ord2buB65d68c/+vPiegoanmuKR/FTXj
	 eS/1lEo6a6CUCtJYrysCjTHtQLRLOgSn+kmi308z0bXdA6p+peKtxAfGpivJSSHdoN
	 ElVql11NtCCOw==
Date: Thu, 7 Nov 2024 16:56:32 +0000
From: Conor Dooley <conor@kernel.org>
To: Pengfei Li <pengfei.li_1@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, joao.goncalves@toradex.com,
	frieder.schrempf@kontron.de, marex@denx.de,
	hvilleneuve@dimonoff.com, peng.fan@nxp.com,
	alexander.stein@ew.tq-group.com, m.othacehe@gmail.com,
	mwalle@kernel.org, Max.Merchel@ew.tq-group.com,
	hiago.franco@toradex.com, tharvey@gateworks.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	ping.bai@nxp.com, ye.li@nxp.com, aisheng.dong@nxp.com,
	frank.li@nxp.com
Subject: Re: [PATCH 1/3] dt-bindings: arm: fsl: Add i.MX91 11x11 evk board
Message-ID: <20241107-halved-playing-d36d4ff339eb@spud>
References: <20241108022703.1877171-1-pengfei.li_1@nxp.com>
 <20241108022703.1877171-2-pengfei.li_1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="j5cmay0eqb/03zTR"
Content-Disposition: inline
In-Reply-To: <20241108022703.1877171-2-pengfei.li_1@nxp.com>


--j5cmay0eqb/03zTR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 07, 2024 at 06:27:01PM -0800, Pengfei Li wrote:
> Add the board imx91-11x11-evk in the binding docuemnt.
>=20
> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--j5cmay0eqb/03zTR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZyzxQAAKCRB4tDGHoIJi
0tl6AQCH53zKDA+LzcstqvCZfZB5CD4le7oKsRX5iV5KuHtR5gD/XIgui2iXLoF5
1t615YPpUGK/CWiO8w8Kg/oNwPOSJQo=
=oG0s
-----END PGP SIGNATURE-----

--j5cmay0eqb/03zTR--

