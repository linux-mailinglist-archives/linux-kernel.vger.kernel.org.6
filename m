Return-Path: <linux-kernel+bounces-211934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BA7905916
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C7131F23200
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAAA181B9B;
	Wed, 12 Jun 2024 16:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDzuo8wO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1852816C84F;
	Wed, 12 Jun 2024 16:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718210752; cv=none; b=kC3lk9SoaR/Zv41b359tNiiNOi5rjRnAurhNgIrHtnlPcbTS4Njh0la7JJIHbQXl+HGl8EvpRP22a60IrCZHg+HwDoeR29TEqUONsb4Z1CF0qhFXBnorBpSZ9AAn+DiYjHW1k7/cfUYKwC08UhgNIN8ep7DcO/dYWiHhl6WxJo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718210752; c=relaxed/simple;
	bh=8w9ShgPS5TN17Vgq4/FFJj6VXTdhI8xmQ63ahvkxhdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fod95XWW4RsaxhSlwYRZ4Wsc4oaI9fCA2dmcGI+rmdg9d94LBb4MbL54u7sKj+HZKxRTTBlMLxaQgITmWtqgGI5OXG5CohTuqqnFNTD5zzJgG9hmYQj3E0Ly2BIX66I9RlbNmTZJu2XrV1PVKsZC9Z/7heXxU5ZF4/h22IS0ifc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDzuo8wO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DA3C116B1;
	Wed, 12 Jun 2024 16:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718210751;
	bh=8w9ShgPS5TN17Vgq4/FFJj6VXTdhI8xmQ63ahvkxhdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KDzuo8wObD64mZR2bYEWIGnEbTIH8wewjHs/Iag6eiIv+NpxYmgjJLz1q9iXW3lSn
	 mharen142TxgEJQvoYAjlIA8KjpT681ujrWkKaT4WPLz4FwT833LNS6lENvvlUzrbY
	 m6GlctBFzmSjJeIturTITA67dUMa+aAWxMokbxaky6VKcTPTwi5dFBPFneGYQ2hNNL
	 FsdxKBL1vFbDO3jOMIr1BhaizDPo1/pWdN8LD0/SzXV9DuKSPUgdm7zj25wDa+dsjf
	 eDJbtk6hEYvP1L8KJoWZDyhaM4XFyXyw36EGYyzvgI1iyTugK3V4YRVZQ40DByZhi2
	 yaD9D+z/rD8XQ==
Date: Wed, 12 Jun 2024 17:45:45 +0100
From: Conor Dooley <conor@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
Subject: Re: [PATCH v2 2/6] dt-bindings: interrupt-controller: Add SOPHGO
 SG2002 plic
Message-ID: <20240612-dripping-ligament-df108345e61a@spud>
References: <20240612-sg2002-v2-0-19a585af6846@bootlin.com>
 <20240612-sg2002-v2-2-19a585af6846@bootlin.com>
 <20240612153051.GA2633500-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vP3fUDhDzW4Xnwx4"
Content-Disposition: inline
In-Reply-To: <20240612153051.GA2633500-robh@kernel.org>


--vP3fUDhDzW4Xnwx4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 09:30:51AM -0600, Rob Herring wrote:
> On Wed, Jun 12, 2024 at 10:02:32AM +0200, Thomas Bonnefille wrote:
> > Add compatible string for SOPHGO SG2002 Platform-Level Interruter
> > Controller.
> >=20
> > Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
>=20
> Missing Conor's ack. When sending new versions, it is your=20
> responsibility to add tags.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--vP3fUDhDzW4Xnwx4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmnQuQAKCRB4tDGHoIJi
0oGXAP9jq4hT6rwjb+4Rzk+jSXSxZtKrvLO+xrJjdgNSa0VHvAEAu3e4/SedACde
/k8mLIpxN0vOBrZWA4GSTPUkPkfyDA8=
=gfD1
-----END PGP SIGNATURE-----

--vP3fUDhDzW4Xnwx4--

