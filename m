Return-Path: <linux-kernel+bounces-219766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 530EE90D78A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4C66285CE6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B0245BF0;
	Tue, 18 Jun 2024 15:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddDwqEe2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A431CD29;
	Tue, 18 Jun 2024 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725250; cv=none; b=uZJ5VYMsayoUCBLNVVprdwcZvZsnm30s1dRG73xxnpZ0cUZitFsghaTbh+RyV4oWUHWB4Ma3S1J8ZDAX7TQ1iHGIQPdxQlH3MycJ35e0slfzL+sccP0yhT/mdfe/GVuHg/eG5YgYHB3VFU9vDS2L21crqPk7ktvCyS0xK5ys43o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725250; c=relaxed/simple;
	bh=PBBvM5f39oe5lUF+K9oON8xgoBZj4J0hB6vuUXqrQLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNTgEGGRGFFcfGNhj4loYRMdndy/0kfP2zqZF8m3ATeKDdcm57eQkIpFYWIxzf/UtxCbtfMa8vRc75pcxiZ9Poi+1ldt1RdcQ72FbGei77JxLcGZcF3ZNUuiSQAA1Z2cNSKjbQ+XsxcI0vn4GlE21x2QAjGFbqUw+yKMlOzWk/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddDwqEe2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D49DC3277B;
	Tue, 18 Jun 2024 15:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718725250;
	bh=PBBvM5f39oe5lUF+K9oON8xgoBZj4J0hB6vuUXqrQLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ddDwqEe2gkFMjXA4MyFBt1yGVnOByf9vxk0E0rkQ4fd0jWXlTvzDHbxGhlLl7Xw9D
	 EEUjsP1Prjoz8f4Xc+yWjzhMgkslAaTNUX2poZCVpUrTJySXSqa/ZUOd7R/QS83ZLF
	 BNzGt2QeemNKNVg45Q5jwawe4HoJpeAFOp8GXioveszJYbR0ZrSyIgpkfIIf3GEsy+
	 jxmORm3j8U5PUtrc4Ff+N8WlH0a7FezZ4bzTabZxVHUHms9jE0bLiBPg2HbvmdDteV
	 BcFFK3Pa1r0a2KXqpA+D9fSyDJmUx7qnAzF6vn7S5vRR3iHvu9xFtMC5OqGulmbcKS
	 qu2fJLklgyXpA==
Date: Tue, 18 Jun 2024 16:40:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup.patel@wdc.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/9] dt-bindings: timer: Add SpacemiT K1 CLINT
Message-ID: <20240618-backlands-flaring-f8b8b603868c@spud>
References: <tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com>
 <tencent_2A51312A21F88DDB7C7D82A2DA8E8EE7B808@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5X0OydBZoMElPKXW"
Content-Disposition: inline
In-Reply-To: <tencent_2A51312A21F88DDB7C7D82A2DA8E8EE7B808@qq.com>


--5X0OydBZoMElPKXW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 01:20:49AM +0800, Yangyu Chen wrote:
> Add compatible string for SpacemiT K1 CLINT.
>=20
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--5X0OydBZoMElPKXW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnGqfQAKCRB4tDGHoIJi
0pgEAQDITBy4C94fWL4Zq9cGY4dK9mpYG6qHmYAJRQiGswCVSgEAi0g3XPr0hKbi
Cv1izHT7Bm+ZfLed0aUww0mLqrERMQo=
=Ua7v
-----END PGP SIGNATURE-----

--5X0OydBZoMElPKXW--

