Return-Path: <linux-kernel+bounces-437129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA0A9E8F6A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34E712837C8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8B121B193;
	Mon,  9 Dec 2024 09:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="esPYALMV"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CE221A92E;
	Mon,  9 Dec 2024 09:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737970; cv=none; b=h74k+1K40C5G9oFR0Rwhe0fdh/Ar+fOqXrMRJjRn4RS1yZey0TDYzcR04UaDkMXkWzHDyERskV44b1hJnnRH44lNiunNKscfpcRhP7zD+vUleijmZzMlDsoPgpxtLr9kiB85Ha0p7NygZAOlImAfCkOlEEjbRZKdGUvqXdT5dQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737970; c=relaxed/simple;
	bh=FmeH/nvjYxMQ9tgd/hUvoWhDnmO7I9JNkvHWVe4JytM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LfAVNifcBjvLNKTZYz9Xx1CUD3lNSa8j3K+RHrT8rwJiQwhzmR24x/bcdJio7VHYNBvgJMl0FYj2BUzya+PXnQB3lbXd1DLkcEKFb6q7xjpPAkPp7C0nYPnprH9SKdfURxWDL+V5se/eXicncfiXPSR7BitI6iLYnnyO7DvMs38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=esPYALMV; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (095160158109.dynamic-2-waw-k-4-2-0.vectranet.pl [95.160.158.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 2849088B64;
	Mon,  9 Dec 2024 10:52:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1733737961;
	bh=2TgYRWKrBT4x2/7OKtG/vlEAcXmGZZN4TsXVm7o2K1I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=esPYALMVjpVOUkI8/CAsguyrUxuh8FMSTTtKqG6U/5ClMnInIoqizAHSulrXFQINm
	 0LKFikzSXg97Ewh8XZeDPRfMOf1UZXKowHDEdSz56ppcKjg18uZT+W3WXWW5y78SZj
	 idtejTcRVdC+vmPWHQaPxOBNTKn1ot4qoZQ0SwcjFixJkS48JVL5Fh0O1ah3BoDoaN
	 67XsivyHEz3MC6fg3TEbe3FDJBTrt9ZFFZgthl9rLDkIAuqDWwwRZDP1kzlBaVsszv
	 yEa9AlpLibVUnYg46AiDZcWoAMo5vqCNGGyAT53rtTbUZfEjtjUzNsY2MDUgv1msgK
	 Q94AmHcP8ivBg==
Date: Mon, 9 Dec 2024 10:52:40 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
 <festevam@gmail.com>, devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Stefan
 Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH v11 1/3] dt-bindings: display: Add
 powertip,{st7272|hx8238a} as DT Schema description
Message-ID: <20241209105240.72d8d84a@wsk>
In-Reply-To: <20241107085705.490940-1-lukma@denx.de>
References: <20241107085705.490940-1-lukma@denx.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//Fyy5bZHZM.GutZmTzQ0v9p";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_//Fyy5bZHZM.GutZmTzQ0v9p
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Dear Community,

> This patch provides the DT Schema description of:
> - powertip,st7272  320 x 240 LCD display
> - powertip,hx8238a 320 x 240 LCD display
>=20
> Used with the different HW revisions of btt3 devices.
>=20
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> Reviewed-by: Rob Herring <robh@kernel.org>

Are there any more comments for this particular patch?

If not - can it be applied as it prevents dts patchs to be pull by
Shawn.

> ---
>=20
> Changes for v9:
> - New patch
>=20
> Changes for v10:
> - None
>=20
> Changes for v11:
> - Combine both separate dt-bindings patches for powertip,st7272 and
>   powertip,hx8238a into one
> - Drop the quotes for in "title" entry of powertip*.yaml files
> ---
>  .../display/panel/powertip,hx8238a.yaml       | 29
> +++++++++++++++++++ .../display/panel/powertip,st7272.yaml        |
> 29 +++++++++++++++++++ 2 files changed, 58 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/display/panel/powertip,hx8238a.yaml
> create mode 100644
> Documentation/devicetree/bindings/display/panel/powertip,st7272.yaml
>=20
> diff --git
> a/Documentation/devicetree/bindings/display/panel/powertip,hx8238a.yaml
> b/Documentation/devicetree/bindings/display/panel/powertip,hx8238a.yaml
> new file mode 100644 index 000000000000..b7d74faeb5d5 --- /dev/null
> +++
> b/Documentation/devicetree/bindings/display/panel/powertip,hx8238a.yaml
> @@ -0,0 +1,29 @@ +# SPDX-License-Identifier: GPL-2.0-only OR
> BSD-2-Clause +%YAML 1.2
> +---
> +$id:
> http://devicetree.org/schemas/display/panel/powertip,hx8238a.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml# +
> +title: Powertip Electronic Technology Co. 320 x 240 LCD panel
> +
> +maintainers:
> +  - Lukasz Majewski <lukma@denx.de>
> +
> +allOf:
> +  - $ref: panel-dpi.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: powertip,hx8238a
> +      - {} # panel-dpi, but not listed here to avoid false select
> +
> +  height-mm: true
> +  panel-timing: true
> +  port: true
> +  power-supply: true
> +  width-mm: true
> +
> +additionalProperties: false
> +
> +...
> diff --git
> a/Documentation/devicetree/bindings/display/panel/powertip,st7272.yaml
> b/Documentation/devicetree/bindings/display/panel/powertip,st7272.yaml
> new file mode 100644 index 000000000000..f3622800f13f --- /dev/null
> +++
> b/Documentation/devicetree/bindings/display/panel/powertip,st7272.yaml
> @@ -0,0 +1,29 @@ +# SPDX-License-Identifier: GPL-2.0-only OR
> BSD-2-Clause +%YAML 1.2
> +---
> +$id:
> http://devicetree.org/schemas/display/panel/powertip,st7272.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml# +
> +title: Powertip Electronic Technology Co. 320 x 240 LCD panel
> +
> +maintainers:
> +  - Lukasz Majewski <lukma@denx.de>
> +
> +allOf:
> +  - $ref: panel-dpi.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: powertip,st7272
> +      - {} # panel-dpi, but not listed here to avoid false select
> +
> +  height-mm: true
> +  panel-timing: true
> +  port: true
> +  power-supply: true
> +  width-mm: true
> +
> +additionalProperties: false
> +
> +...




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_//Fyy5bZHZM.GutZmTzQ0v9p
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmdWvegACgkQAR8vZIA0
zr06jwf/Uki+jPjbdKp28ndQTmn0DS2DhJn04m0+xpfsdAF10D8JInAbJtWlVEQU
B61lINUcP/H/t6mpGMwYFb1QdRbFAzmxEGr4leiMRMQ9A4RxvzzzPWbF1Tu3hfnf
OyPEfvWYHxdUh0qXvO5Cd7wKxxRw1gDF+yEzcu/VxvrniJPUSQIv7brOvmXNNP2d
j4yvvb3p/tWXTjJL+m+lyLkjdJriAdKH+if3wCU++dyPOLq+P48jr9s9peMcFXLI
+j8UUL5T8tKhDWpYfnLjh4uE89J6VSwoLmgMppYQuzYWaNk1DEKSshn1eVdhVS15
suRvKryJhDfKkCi1xfF2wxgHZCUBGw==
=S4ZQ
-----END PGP SIGNATURE-----

--Sig_//Fyy5bZHZM.GutZmTzQ0v9p--

