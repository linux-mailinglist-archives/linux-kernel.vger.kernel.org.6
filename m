Return-Path: <linux-kernel+bounces-211936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF48E90591A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 558F92825F7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5969A181BA1;
	Wed, 12 Jun 2024 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0xJupUw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C01517FAB2;
	Wed, 12 Jun 2024 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718210792; cv=none; b=jtAalGpSQ6FfD9TSRyzGWCpczETt/Ed2G0MH9LaVDEruZ1/YLoBFECeJt3rn/HMERPZOIUGH46/xhm7DE23DzqucWYuNAExDrJJOlZuwC3h3CCnjWflTd/qskrwd3EdKZvxXWy0iZbaDepDwg6wXns3+HT21u8XKQU0QOmmDLW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718210792; c=relaxed/simple;
	bh=q4OYz17flZuLgbGuuOwxi5CCitZmXBx2iQmSgXo/YpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SjfOoUJo8h8rOoMIU/eqVcOGJ7jEM5jb/I9Bg/vPt9iYsgOBiWf0dUh2PeleDxAvwiS5qQ2XMWEL7HZgnC1Ri5IqZFx3T1h68XQy8g5dizqsfG5KLZMiwudfqQL+GNXOPBxpd2x7iTN66Rr+nRVkjDi9GFZzkbI+IKwwsr1twZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0xJupUw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49B9C116B1;
	Wed, 12 Jun 2024 16:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718210792;
	bh=q4OYz17flZuLgbGuuOwxi5CCitZmXBx2iQmSgXo/YpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A0xJupUwYeVC+FXlzIcpVp6Yz+UZu9cGDWHfG5bjKDs6oY8ysl0pgRwo368TZTPrO
	 j5zpNMycbZ+7WFL6N4QyUmMJ7V4SnXpO3uEx/vR7amDfjg39+tupcWIIVAtCilEog+
	 yUVmhYUgpYuoTv8li8kEWC4SUSYcHhxyHwlLQO42Qces2KvNcTSb2zDXnzDAv0FhIL
	 gj4jwnoDQkZVua5tNEmrbglvK7CiAh/MrzEkt27vFIgL89S00nHbZPqjbyWL5vr70p
	 bTfukH0n1Xnd7NXB05qb98WSHvzkJbg3r7WyVBqklQ2ztLb9iy4i+tvW72y/vgEOM8
	 rUqIfQU4WTEng==
Date: Wed, 12 Jun 2024 17:46:26 +0100
From: Conor Dooley <conor@kernel.org>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Chao Wei <chao.wei@sophgo.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 3/6] dt-bindings: timer: Add SOPHGO SG2002 clint
Message-ID: <20240612-violate-unmade-a310d133e5b8@spud>
References: <20240612-sg2002-v2-0-19a585af6846@bootlin.com>
 <20240612-sg2002-v2-3-19a585af6846@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2p0/8tFuzhCfJUHx"
Content-Disposition: inline
In-Reply-To: <20240612-sg2002-v2-3-19a585af6846@bootlin.com>


--2p0/8tFuzhCfJUHx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 10:02:33AM +0200, Thomas Bonnefille wrote:
> Add compatible string for SOPHGO SG2002 Core-Local Interrupt Controller.
>=20
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--2p0/8tFuzhCfJUHx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmnQ4gAKCRB4tDGHoIJi
0p6lAP9a1NLKF9juqOF+2O0g28e9Wi9JHHkMJ3CRhpeD6kRSbwD+I9GNNisFVzIm
RgDqcyrsNSVUeMcthTqV9O/fgdVH+gQ=
=dDND
-----END PGP SIGNATURE-----

--2p0/8tFuzhCfJUHx--

