Return-Path: <linux-kernel+bounces-394809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0056E9BB434
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A63E1C2119D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C221B5336;
	Mon,  4 Nov 2024 12:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDO3E/mO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3667C0BE;
	Mon,  4 Nov 2024 12:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730722137; cv=none; b=NYDcb1zazBJepLaclp5KujOdamxy27xsTMlIcUMt5MfaK3nr+EUMayTXkfEWaGHPuGx/BeTYMcEa9lbJIn85xYkkm1Yq6fAo2Yzxx0NhzQ3IYNSGfqI2NK3TyRqK0DXOJo+IyZYoojL8WOxTm/ND56mdpGvreDWWbWWlEq+HF+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730722137; c=relaxed/simple;
	bh=SXIvHTd084348Ke5hjT7V7ym8x/naf+cJdPZdoJW6Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmTr3VNhzlQVrCD/JOZjgvKX9YxMPZc8ijFZyy1XL4DYD3L/6YCfw4iwjtz/DUlURcJfNdbD9v8OqqNA3zWMY19kuzq88oD53qHtSTjKbB/S411ElSlFzVLdxGnDwRg0HKs3Ih190IrUpPTYXB30IjlZeJsZGCBfzjb7wuOnts0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDO3E/mO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D23DC4CECE;
	Mon,  4 Nov 2024 12:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730722136;
	bh=SXIvHTd084348Ke5hjT7V7ym8x/naf+cJdPZdoJW6Pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DDO3E/mOiAY0758tF5tnLUHufD1GRhv9AYEu6ZOgOJMVl/Z9sT/9aAecuWawlLAw/
	 aoCdYv/rP2yWtq8edvyWN9n8P2E/WBAd3bFcz02dvkcbQrpjh9WPfseqjwJmWX4Ilx
	 /5uzJ0QMbZRy6c9zQCGMIFIJ2wVm6ew5LHNzLl2QTpXJYWBgiECnbxjtRhIip8F6fu
	 gHAg4WBkOq/FyPqSciLh2MlHTIaufVD1QRdJTBgs9WiJpAp2KuVMSVdavDKwRFThan
	 kP+wTniL7qDjWE7vVNfuYmpCTJpoVinLpsCmhe3yt/kPZa8wfbIk4a/SNRjAblFLvo
	 XEC7F/l9vsJFw==
Date: Mon, 4 Nov 2024 12:08:51 +0000
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Chiu <andybnac@gmail.com>, Xiao Wang <xiao.w.wang@intel.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: riscv: add bfloat16 ISA extension
 description
Message-ID: <20241104-clean-osmosis-680d64616712@spud>
References: <20241103074959.1135240-1-inochiama@gmail.com>
 <20241103074959.1135240-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="chiq5kZJ1B12zV8S"
Content-Disposition: inline
In-Reply-To: <20241103074959.1135240-2-inochiama@gmail.com>


--chiq5kZJ1B12zV8S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 03, 2024 at 03:49:55PM +0800, Inochi Amaoto wrote:
> @@ -605,6 +623,33 @@ properties:
>          then:
>            contains:
>              const: zca
> +      # Zfbfmin depends on F
> +      - if:
> +          contains:
> +            const: zfbfmin
> +        then:
> +          contains:
> +            const: f
> +      # Zvfbfmin depends on V or Zve32f
> +      - if:
> +          contains:
> +            const: zvfbfmin
> +        then:
> +          oneOf:
> +            - contains:
> +                const: v
> +            - contains:
> +                const: zve32f
> +      # Zvfbfwma depends on Zfbfmin and Zvfbfmin

IMO these contents are statements of the obvious and not needed, but I
wouldn't bother respinning for that alone.

Acked-by: Conor Dooley <conor.dooley@microchip.com>


> +      - if:
> +          contains:
> +            const: zvfbfwma
> +        then:
> +          allOf:
> +            - contains:
> +                const: zfbfmin
> +            - contains:
> +                const: zvfbfmin


--chiq5kZJ1B12zV8S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZyi5UwAKCRB4tDGHoIJi
0lKHAQDEI0kOz+OHaroUU4xjzlawxX4O6ZtbtSJqYh5MNgmuPgD/YnypDRlmGdwJ
65/KZHetJzgdli/qMjrnTBAk5HF8pAs=
=SPCS
-----END PGP SIGNATURE-----

--chiq5kZJ1B12zV8S--

