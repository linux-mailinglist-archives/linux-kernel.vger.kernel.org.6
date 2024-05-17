Return-Path: <linux-kernel+bounces-182344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D708C89F1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 18:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3362B221BE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 16:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EE312FB36;
	Fri, 17 May 2024 16:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExOhwA4/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACF23D9E;
	Fri, 17 May 2024 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715962899; cv=none; b=Rmp10eGwn/zBANl4Mg5vauplHXs2WOlEvGnnC04jX3B9dU8Ua6EIyRJ6dpr1GMdEExqYTTfn36du/e8jr9pjfTJkrlewrvhHfFUMoaSdRddZZIcHhXXJB4wo6310r6sgtZYqyiVKWnDGffIQkKnMUSUOmH3DaiQ6trY5mRCX/Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715962899; c=relaxed/simple;
	bh=ev4iq0Wee83dklHI+OARRnVpV0x2gsj2uuRc45D2WZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uG4opFzTSExstBxQVwkPiaWy083z8ytG55UqgRUcapJQiZgBJAwzWg3W+PMTTUiDvw5h9PyTuPMhFjCgVCYRnIZ3YupOSQVo1DOtzjMy+NYqPUrYrTjmauf1jZlnsot46Fx4/MqCxCEyDup9dkmVFBYApxh2LL9ehvqpmyA+/Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExOhwA4/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA85C2BD10;
	Fri, 17 May 2024 16:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715962898;
	bh=ev4iq0Wee83dklHI+OARRnVpV0x2gsj2uuRc45D2WZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ExOhwA4/ipTySjT0ECd1wWMW5Kl3Pcyuq5QrppMjN3DvW5Fn4NUMhCywmBrhKZ3Hs
	 BsUu1wWti+XNrDVa7af5bpLsVi5tRPXr5+cW2CRMpZ7yLQBahwWHZ5tDkiue3EbZ4N
	 DznDUsvQvrMemqHNFIFh025x2Hk/hHDZ1H890T17ANQP0MZ90JT7d4G1N9JqoRDE40
	 YSZMcl/cr+zQ6qgz7TWSpF30POu+9RJ4phasKo0jU3LOtui5FSkSNpUgsGcv976i3U
	 x1scDCIp3sJQJ5HsQ4sVlI4uT5jMrPGdvsfEqRvL8k2IJbBBRkEnsb3WI0SnncWX/V
	 YtauH1OnC/gSg==
Date: Fri, 17 May 2024 17:21:32 +0100
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org,
	peng.fan@nxp.com, mturquette@baylibre.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	marex@denx.de, linux-clk@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, p.zabel@pengutronix.de
Subject: Re: [PATCH v3 3/6] dt-bindings: clock: imx8mp: Add reset-controller
 sub-node
Message-ID: <20240517-gristle-dealt-56b5299b9cb8@spud>
References: <1715679210-9588-1-git-send-email-shengjiu.wang@nxp.com>
 <1715679210-9588-4-git-send-email-shengjiu.wang@nxp.com>
 <20240514-campus-sibling-21cdf4c78366@spud>
 <b86c83a520f0c45a60249468fa92b1de.sboyd@kernel.org>
 <CAA+D8ANTdvQJVtniyMtqjnJdT4qX+LDGjVuFO6H0RSO+GDw+ng@mail.gmail.com>
 <20240515-unbundle-bubble-8623b495a4f1@spud>
 <ZkT+4yUgcUdB/i2t@lizhi-Precision-Tower-5810>
 <20240516-reversing-demeanor-def651bc82ac@spud>
 <ZkbVa5KvvbnH/tNQ@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4Mu3zHPEQUMLHGbO"
Content-Disposition: inline
In-Reply-To: <ZkbVa5KvvbnH/tNQ@lizhi-Precision-Tower-5810>


--4Mu3zHPEQUMLHGbO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 11:56:27PM -0400, Frank Li wrote:

> Look like it is easy to register auxdev "reset" devices. But I have a
> problem. How to use it by DT phandle?  "reset" devices is service provide=
r.
> Some client will use it.
>=20
> Generally, reset node will used by other devices nodes. like
>=20
> ABC: reset {
> 	compatible=3D"simple-reset";
> 	...
> }
>=20
> other node will use "reset =3D <&ABC 0>".  If use auxdev, how to get &ABC
> in dts file.

Whether or not you use auxdev or any other method etc, does not matter
in a DT system, the consumer will always have a phandle to the provider
node:

ABC: whatever {
	compatible =3D "whatever";
	#clock-cells =3D <...>;
	#reset-cells =3D <...>;
}

something-else {
	clocks =3D <&ABC ...>;
	resets =3D <&ABC ...>;
}

--4Mu3zHPEQUMLHGbO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkeEDAAKCRB4tDGHoIJi
0v3KAQCtuCid5sZZRxVDSl1pghCdok/Ij++faKx/8/xcdIVx4QEAkSXxvCVqt5ZY
2QTIu2jbkFxOScBwUQAQ57aJiG/iKQg=
=riPG
-----END PGP SIGNATURE-----

--4Mu3zHPEQUMLHGbO--

