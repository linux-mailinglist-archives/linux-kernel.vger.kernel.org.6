Return-Path: <linux-kernel+bounces-350693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF3799081A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 210CE1F23754
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6680A2225DF;
	Fri,  4 Oct 2024 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLQGg7Vh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A282225D0;
	Fri,  4 Oct 2024 15:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056668; cv=none; b=b6ubyyVAQhhjTKSjTw+iCnOsqjeHgaBwy04Vofmv3xgrOG4px/1h9CJlX/NnIbkQgxPsV2WfPKMwwZFsAklR3IMSJ+Rdq+HRQws6G8dp171dPf+lsE0G7iA7IRl5ZzVmAhMjqcxfPFiz0md83N+/sZg6WJfCakTKXDi7Uot24Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056668; c=relaxed/simple;
	bh=g6L2Bd0g3xO/JW7h06BpQ1vhxFqlkDGXgOvZlFB2GyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeX+eh4xDdpepgZnfern3yzySj87mHheStqUR61uiDj4A1vQGxGPeqfm3ParXCS9RgS/fVKu3bkwG37n6sVpCfdJWeAG8WXq6L/wOWCh4b4a44JiCtKnUJZWfBCYjF9dfoLGGXrPpLovvgUjeqCE3x/TFxlgBZDZTSS4S8g3bd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLQGg7Vh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1052C4CEC6;
	Fri,  4 Oct 2024 15:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728056668;
	bh=g6L2Bd0g3xO/JW7h06BpQ1vhxFqlkDGXgOvZlFB2GyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nLQGg7Vh/tn2IRTrAxIRn5V40dXDv/GMXOCygwdLW5/hW6DtL+FS5wfMJdHCbwPes
	 nKxn5p+kX8zYVVkYo9WQyoxISewuFRoNMlqNW4fvEfUD9ExEci9F/ee2tldOKxijZc
	 2rojaZkJNDEnm28gLd9yZWlG9aFBiau9vfboG/9y8Hvq1NpJ1zXt9d3SMaKYEGHwW0
	 7yY5tX3omTBSxHnFhLSOWG6Mbf5TcS7Ikj0ZzjCP3GkFEG1ecxRi8ebpD5dwHFcZfM
	 LxldqVTk36BxwGVn3sCo6v0bakIUVo395jOte76YwrajrY4GD2s/Q4kMtPioe0rSxS
	 QUf9yaldb85/g==
Date: Fri, 4 Oct 2024 16:44:22 +0100
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Chen Wang <unicorn_wang@outlook.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Inochi Amaoto <inochiama@outlook.com>, Guo Ren <guoren@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yixun Lan <dlan@gentoo.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: interrupt-controller: Add Sophgo SG2044
 ACLINT SSWI
Message-ID: <20241004-patronize-doily-8406fa214347@spud>
References: <20241004080557.2262872-1-inochiama@gmail.com>
 <20241004080557.2262872-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wpxj4kbF4P50H8T+"
Content-Disposition: inline
In-Reply-To: <20241004080557.2262872-2-inochiama@gmail.com>


--wpxj4kbF4P50H8T+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 04, 2024 at 04:05:55PM +0800, Inochi Amaoto wrote:
> Sophgo SG2044 has a new version of T-HEAD C920, which implement
> a fully featured ACLINT device. This ACLINT has an extra SSWI
> field to support fast S-mode IPI.
>=20
> Add necessary compatible string for the T-HEAD ACLINT sswi device.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  .../thead,c900-aclint-sswi.yaml               | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controlle=
r/thead,c900-aclint-sswi.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/thead=
,c900-aclint-sswi.yaml b/Documentation/devicetree/bindings/interrupt-contro=
ller/thead,c900-aclint-sswi.yaml
> new file mode 100644
> index 000000000000..0106fbf3ea1f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/thead,c900-a=
clint-sswi.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/thead,c900-aclin=
t-sswi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sophgo sg2044 ACLINT Supervisor-level Software Interrupt Device
> +
> +maintainers:
> +  - Inochi Amaoto <inochiama@outlook.com>
> +
> +description:
> +  The SSWI device is a part of the riscv ACLINT device. It provides
> +  supervisor-level IPI functionality for a set of HARTs on a RISC-V
> +  platform. It provides a register to set an IPI (SETSSIP) for each
> +  HART connected to the SSWI device.

If it is part of the aclint, why should it have a separate node, rather
than be part of the existing aclint node as a third reg property?

--wpxj4kbF4P50H8T+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZwANVgAKCRB4tDGHoIJi
0l7VAQCcJwp5mlLQUBYVUFyXHgPf8BzF8Or/9vxp2k5AEk6RwQEA3f2kGou1G/QT
TF05IWT4y9eslPEerl0gzCYGAYvw5Ao=
=55Uy
-----END PGP SIGNATURE-----

--wpxj4kbF4P50H8T+--

