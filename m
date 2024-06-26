Return-Path: <linux-kernel+bounces-231179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6097491872E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 18:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A55F1F22244
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA97818EFE4;
	Wed, 26 Jun 2024 16:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBTbTprP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1544D1849EF;
	Wed, 26 Jun 2024 16:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719418791; cv=none; b=eKuYkVwRzBKHnd1ZcEO/eZjUAA4487gHB6Cd5TIJ4FDrRP03QELCAQXqieu6fappMl3b3+q0fe5sBfnq4ccaf8OAinyV839/RRae840THzC7mvwt9qnjQ4re3mpWnCxV77NWNRF8ScF+hP89pLj9tXy6kR5PDAXZKvUCct1TdBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719418791; c=relaxed/simple;
	bh=BUh3Ifno2dFKujCDeYuJWfZRRg+3vWHuLYdKNNNbz/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RgE4RbHGC7goLwWf5AIZPNdDpEmP9E/FqghSUDUEES4wuKf89MhuCSkrF4vRvhX+jj0cUXC5dOpySD4me1sCLEthXcqmVeddQ26DyV/LOGP1d8z2jZhdXQ9ltT9SXryBRIrgVR+64i7QlEqB/JZ6Qo0aTXcskp0+NV9t9cbWRSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBTbTprP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C643C116B1;
	Wed, 26 Jun 2024 16:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719418790;
	bh=BUh3Ifno2dFKujCDeYuJWfZRRg+3vWHuLYdKNNNbz/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bBTbTprPD0N7cG1vof5PeK8t/e/6l98FsFMZpzBnqytLVamav5mq0sJ7/0GG5zq/R
	 r9A5JRlqGR8WgqN+ON3cJEgihK6ossxggV9gA1y3EbOw948C875mig51mUE2Exlb2w
	 i6elRNwgTVQC7c0RXbe5LnuxXi8Z14hpwT0O0iNsptFl+O+WklsMn3ZdUQeyUATMAP
	 5/8Zi1Ge9viEX/y1ALMs8xOaZ719GdWfIZWHDufeAFbojKgPiyIFHixkMN7sKzQoQK
	 luRW2CkllVkSCqOgCyLcYKjgBzQO6BjCsf0cg1Low61AFIhy3CzhAuhSmt/j7Qcwi0
	 gxwEaczpmALWg==
Date: Wed, 26 Jun 2024 17:19:45 +0100
From: Conor Dooley <conor@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Chris Zhong <zyw@rock-chips.com>,
	Zhang Qing <zhangqing@rock-chips.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Furkan Kardame <f.kardame@manjaro.org>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	kernel@collabora.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: mfd: rk817: Fixup clocks and
 reference dai-common
Message-ID: <20240626-prozac-wrongness-3f432b67468e@spud>
References: <20240622-rk809-fixes-v2-0-c0db420d3639@collabora.com>
 <20240622-rk809-fixes-v2-1-c0db420d3639@collabora.com>
 <20240622-exquisite-absently-e35b2cf335e3@spud>
 <20240626154446.GD2504017@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ViRgtctp4xtl5K9D"
Content-Disposition: inline
In-Reply-To: <20240626154446.GD2504017@google.com>


--ViRgtctp4xtl5K9D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 04:44:46PM +0100, Lee Jones wrote:
> On Sat, 22 Jun 2024, Conor Dooley wrote:
>=20
> > On Sat, Jun 22, 2024 at 12:57:18AM +0300, Cristian Ciocaltea wrote:
> > > Ensure 'clocks' property does not allow more than one item and add the
> > > missing reference to dai-common schema.
> > >=20
> > > While at it, move 'clocks*' and '#sound-dai-cells' properties to keep
> > > the list ordered alphabetically.
> > >=20
> > > Additionally, drop all useless/redundant descriptions.
> > >=20
> > > Fixes: 6c38ca03406e ("dt-bindings: mfd: rk808: Convert bindings to ya=
ml")
> > > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> >=20
> > I'd argue that these should not all be the same commit, but w/e.
>=20
> Are you arguing that, or not? :)

I said w/e and acked it, you can apply it!

>=20
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>

--ViRgtctp4xtl5K9D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnw/oQAKCRB4tDGHoIJi
0gm7AP0f9bOQyJ6SVNBWC7D2GOSMWzC2XNP53cujm8o0SojWcwEA6L4vjn8dcnWK
BiK/C/J6XQrOCndjkBTNhoVL9nRi2go=
=i8sf
-----END PGP SIGNATURE-----

--ViRgtctp4xtl5K9D--

