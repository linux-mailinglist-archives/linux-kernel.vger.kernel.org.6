Return-Path: <linux-kernel+bounces-418685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DCD9D6450
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 19:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C7C282B71
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F821DF26F;
	Fri, 22 Nov 2024 18:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="DWMis2OR"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E82929A5;
	Fri, 22 Nov 2024 18:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732301380; cv=pass; b=n0YjcWvsMYfz60U43TJCE2+Dd0M0/Kuf5X3TNu27hofmUfjVLq/uMYTbgAALM72WH9T+Dp8d09JJRv/9qfDJ9AttzpWmlSRJBKke3ltR7mqwvznjttocZNoAEaqgKxy48K5l/e4MU0JbEnvaby89zhvyCFJE3Md/jckCLemBL9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732301380; c=relaxed/simple;
	bh=hZyFPS8FYY66jn/F78yssTBCwvGUCQxX/b9/iit191k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5Q8hXNfPXMEa50you61Ht0xd5BB7ujWj6fhlXpg4zYNV4tGkgdLGDNrs9vlIeiM3lpNQ5EHryBuUiAG9btnLReK9tQMpGSgbGLthtNc/d6tIjVrKmeWH15mlxZM0vuqvXVixwbX7BlO4/WDlusw9hlfS9bPE8psgzUcuqmFyEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=DWMis2OR; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1732301366; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=moKpI0Y1wfyp0zDTN+J7fb0RabdMywL/MPTswotmSA+KTZJOEPvVZBYQ6zlN8apO60/z20bkDuHLQxJubWsP7jRoV4xsV7QNCqg+80jltLdjdDda0kTAIZL3vDMQHPlV2WFnDD2LWuBbRhsVCShsnpHUtN2VdzQEjpbu7m2hVTI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732301366; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pXXGQ+H4K+o+xkKJh/Eib8vedMAVJhzcT61sVNMDK18=; 
	b=etErkPXOgA/o2PY0rmoNMNz5lETz28KLwWLF5s/Rw1o3luzgxPET4Dgn0jEHziDzE6ttWFJ6o8r3A3xNMwPA8kO3k4Wqc9Y2wGyjfxEo6t0sGz7UYHdKLEB0q5q4o67kD2mOD512rFtdfWGPIPcONMXpEKkZ8+2HtLBPtgVL7Nc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732301366;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=pXXGQ+H4K+o+xkKJh/Eib8vedMAVJhzcT61sVNMDK18=;
	b=DWMis2ORyFa/Pf0JrjQCTPO8S503ZcLD+FfkCKMKyij0evInMtsSAmy5fdKNNYGL
	iNdrxoVmBcowkrEe4U6TW1J044EnZKsdr4spTFkzL6Co2fTJU7vLCgHY059ZVFpB5mq
	Qmq3JANa/lN+q8A4wTGp9SCU5s62xvQeokqdYkCM=
Received: by mx.zohomail.com with SMTPS id 1732301365255675.6070960311865;
	Fri, 22 Nov 2024 10:49:25 -0800 (PST)
Received: by mercury (Postfix, from userid 1000)
	id BF04A10604B0; Fri, 22 Nov 2024 19:49:20 +0100 (CET)
Date: Fri, 22 Nov 2024 19:49:20 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, quentin.schulz@cherry.de, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Heiko Stuebner <heiko.stuebner@cherry.de>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: phy: Add Rockchip MIPI CSI/DSI PHY
 schema
Message-ID: <udad4qf3o7kt45nuz6gxsvsmprh4rnyfxfogopmih6ucznizih@7oj2jrnlfonz>
References: <20241113221018.62150-1-heiko@sntech.de>
 <20241113221018.62150-2-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ziaozgegtmqy67sl"
Content-Disposition: inline
In-Reply-To: <20241113221018.62150-2-heiko@sntech.de>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/232.230.92
X-ZohoMailClient: External


--ziaozgegtmqy67sl
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/2] dt-bindings: phy: Add Rockchip MIPI CSI/DSI PHY
 schema
MIME-Version: 1.0

Hi,

On Wed, Nov 13, 2024 at 11:10:17PM +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
>=20
> Add dt-binding schema for the MIPI CSI/DSI PHY found on
> Rockchip RK3588 SoCs.
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> ---
>  .../phy/rockchip,rk3588-mipi-dcphy.yaml       | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/rockchip,rk3588=
-mipi-dcphy.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-d=
cphy.yaml b/Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-dcph=
y.yaml
> new file mode 100644
> index 000000000000..5ee8d7246fa0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-dcphy.ya=
ml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/rockchip,rk3588-mipi-dcphy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip MIPI CSI/DSI PHY with Samsung IP block
> +
> +maintainers:
> +  - Guochun Huang <hero.huang@rock-chips.com>
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,rk3576-mipi-dcphy
> +      - rockchip,rk3588-mipi-dcphy
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#phy-cells":
> +    const: 0

I would expect an argument to select between D-PHY and C-PHY mode,
so that the binding is ready for it even when the driver does not
yet support it. E.g. something like

  '#phy-cells':
    const: 1
    description: |
      Supported modes are:
        - PHY_TYPE_DPHY
        - PHY_TYPE_CPHY
      See include/dt-bindings/phy/phy.h for constants.

This would match how it works for the naneng Combo PHY to switch
between PCIe/SATA/USB3. Also Mediatek CSI DC-PHY handles it that
way upstream (with just D-PHY being supported). I see that the
driver stack you send upstream expects, that the PHY user (e.g.
the DSI controller) instead manually calls phy_set_mode(phy, <mode>).
To me it seems more sensible to just get this automaically from DT.

Otherwise the whole series LGTM.

Greetings,

-- Sebastian

> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: pclk
> +      - const: ref
> +
> +  resets:
> +    maxItems: 4
> +
> +  reset-names:
> +    items:
> +      - const: m_phy
> +      - const: apb
> +      - const: grf
> +      - const: s_phy
> +
> +  rockchip,grf:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the syscon managing the 'mipi dcphy general register fi=
les'.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rockchip,rk3588-cru.h>
> +    #include <dt-bindings/reset/rockchip,rk3588-cru.h>
> +
> +    soc {
> +      #address-cells =3D <2>;
> +      #size-cells =3D <2>;
> +
> +      phy@feda0000 {
> +        compatible =3D "rockchip,rk3588-mipi-dcphy";
> +        reg =3D <0x0 0xfeda0000 0x0 0x10000>;
> +        clocks =3D <&cru PCLK_MIPI_DCPHY0>,
> +                 <&cru CLK_USBDPPHY_MIPIDCPPHY_REF>;
> +        clock-names =3D "pclk", "ref";
> +        resets =3D <&cru SRST_M_MIPI_DCPHY0>,
> +                 <&cru SRST_P_MIPI_DCPHY0>,
> +                 <&cru SRST_P_MIPI_DCPHY0_GRF>,
> +                 <&cru SRST_S_MIPI_DCPHY0>;
> +        reset-names =3D "m_phy", "apb", "grf", "s_phy";
> +        rockchip,grf =3D <&mipidcphy0_grf>;
> +        #phy-cells =3D <0>;
> +      };
> +    };
> --=20
> 2.45.2
>=20
>=20

--ziaozgegtmqy67sl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmdA0iYACgkQ2O7X88g7
+pqCVxAAjfX56csgOp+pRFu/Lzsmgy2PJnA+ahOcXVFpjer1P7y6mePQgwN4QfRt
njnHJ9CdSLqwpOoBH3igShSlZ7Udd1gXzgigk3LsjpLOLqOe66L7Yzq/pS9LDPM0
O6o5sAlvkDCMBwZx+NFzBK3FsVZ8w+yHPFw6pcIqBATAMsT5iC+7L6v1+VKbJ0Hj
Rc9btYfxmUfUPGUvM/fDTEoAxK3b/R6hrrIzbp6mh+IFmU0Jg8pzCxdBbAJvHclP
CTAFeXzNZ7t2mO20zp/ErvhR71e1zKsqVhddQWg5FkEb2hVAh6QqmdYaJmhzDSqN
/7VC0nRX9Ck9Uj/XMAOo+u/QaVSrJp8uSfygtt8xjKac4KSbi8I1K8zUcPBhnESr
LlsbjLKOYiXL9mDOcWcsNRwQCjofWviPUz571uchvhUNnDmZAS5tgD5AmI2Bfpor
bfF63gY1/i+eAghsyIua091anZGpZfpUhghHHz9WP7Kr3ZrhIhe3fww29H0Z0gLa
+pIS0BLCXjlzx/OYEV6JPou2zuFrMHIX4N4XaCx4oAi7S9Fh4c05yt4VljWMB0mr
Kn4FHuM9Hf6z6ZrR70IeCtElmK/gXPXag5olucUIKy/x/cso++EDu05tXX7Rys6e
USpG+9j6rfzZh49dTkgNU2ijnwpovTblFjae10YAMBVNlGturPk=
=D23f
-----END PGP SIGNATURE-----

--ziaozgegtmqy67sl--

