Return-Path: <linux-kernel+bounces-212980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF61C906944
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DE8F1F220DD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C09314037E;
	Thu, 13 Jun 2024 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.com header.i=@yandex.com header.b="Lz7ebCIu"
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B0713E024;
	Thu, 13 Jun 2024 09:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718272223; cv=none; b=Kt5bMobxVPTcwNvU8/HEI0LuMrzEKtq6/oGjp67bCDs5yYwYH08cvqUtbwcgxpiN9ddwJ3V3yOURQwAjKfh/wLii5MPfAibJINNai2RnodeMqOyBPNfJyvf6/pzdtPhCO3d2yGa8bjU/4rg/SwEJiUs2TholFDyRzCTg+9nedlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718272223; c=relaxed/simple;
	bh=CiS/vwgvhI96k1n3BHULEcR1iEwkD4iIpW9CfsgBXrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tL0kU7foUjd1EkYK0Hdj7AuqeExguI2nElb5jpRmk4G5uLH8cJji3cz0R6lbRfdCL+QZHpFf4MjsHIbqIbZ0tmbahzLXqqfdMHh8Qgxls8LtVxGxf1iSaHwfrpPkDiB4EcG2G0TnMZV1a5w4CgVGtwufRdM1L3Mjn2hyR0dvODw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.com; spf=pass smtp.mailfrom=yandex.com; dkim=pass (1024-bit key) header.d=yandex.com header.i=@yandex.com header.b=Lz7ebCIu; arc=none smtp.client-ip=178.154.239.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.com
Received: from mail-nwsmtp-smtp-production-main-37.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-37.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:298c:0:640:7729:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTPS id 326E861317;
	Thu, 13 Jun 2024 12:44:35 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-37.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id Vicprp1Oca60-NKeaeh3H;
	Thu, 13 Jun 2024 12:44:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.com; s=mail;
	t=1718271874; bh=rXDnmJ5ZQOUO+9FQYV87xXfZpc46R3cPAarAmqFfOiA=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=Lz7ebCIu5oUOLBGf+eWcXQ5AFXnNvRxLl6ZQnVz9AUfKAP28kEEi1tE1S0i5AaWFc
	 m5ri4Y5j79nsndV76J15Y4Gs6PE76abROtAXGJ222vO+PVUzo3htJ30mH7XXqPVxRe
	 Z9JQvUcYgzr5EQ1sfY95eHQX5PhyroLRur5AFFQo=
Authentication-Results: mail-nwsmtp-smtp-production-main-37.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.com
Message-ID: <cc66cca1-33db-4f30-afcf-d256a959896b@yandex.com>
Date: Thu, 13 Jun 2024 11:44:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: phy: rockchip-emmc-phy: Convert to
 dtschema
To: Shresth Prasad <shresthprasad7@gmail.com>, vkoul@kernel.org,
 kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 heiko@sntech.de, sebastian.reichel@collabora.com, s.hauer@pengutronix.de,
 cristian.ciocaltea@collabora.com, andy.yan@rock-chips.com
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 javier.carrasco.cruz@gmail.com
References: <20240613085812.4020-2-shresthprasad7@gmail.com>
Content-Language: en-US
From: Johan Jonker <jbx6244@yandex.com>
In-Reply-To: <20240613085812.4020-2-shresthprasad7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/13/24 10:58, Shresth Prasad wrote:
> Convert txt bindings of Rockchip EMMC PHY to dtschema to allow
> for validation.
> 
> Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>
> ---

Add ack request from phy maintainer here.

> Changes in v3:
>     - fix `reg` in example being too long
> 
> Tested against `rockchip/rk3399-firefly.dtb`, `rockchip/rk3399-orangepi.dtb`
> and `rockchip/rk3399-pinebook-pro.dtb`.
> 
>  .../bindings/phy/rockchip,emmc-phy.yaml       | 79 +++++++++++++++++++
>  .../bindings/phy/rockchip-emmc-phy.txt        | 43 ----------
>  .../devicetree/bindings/soc/rockchip/grf.yaml |  2 +-
>  3 files changed, 80 insertions(+), 44 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/rockchip,emmc-phy.yaml
>  delete mode 100644 Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/rockchip,emmc-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,emmc-phy.yaml
> new file mode 100644
> index 000000000000..85d74b343991
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/rockchip,emmc-phy.yaml
> @@ -0,0 +1,79 @@

> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)

You are converting an existing document, so GPL 2 only.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/rockchip,emmc-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip EMMC PHY
> +
> +maintainers:

> +  - Shresth Prasad <shresthprasad7@gmail.com>

Prefer to add someone that can immediately respond if Rob H. wants to delete something.
Use the Rockchip DT maintainer here:
  - Heiko Stuebner <heiko@sntech.de>

> +
> +properties:

> +  "#phy-cells":
> +    const: 0

Move this to the bottom of this list.

> +
> +  compatible:
> +    const: rockchip,rk3399-emmc-phy
> +
> +  reg:

> +    description:
> +      PHY register address offset and length in "general register files"

remove

> +    maxItems: 1
> +
> +  clock-names:

> +    description: |
> +      Although this is not a required property (because most boards can get
> +      basic functionality without having access to it), it is strongly
> +      suggested.

remove
No need for descriptions if there's just 1 clock.

> +    const: emmcclk
> +
> +  clocks:

> +    description:
> +      Should have a phandle to the card clock exported by the SDHCI driver.

remove 

> +    maxItems: 1
> +
> +  drive-impedance-ohm:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Specifies the drive impedance in Ohm.
> +    enum: [33, 40, 50, 66, 100]
> +    default: 50
> +
> +  rockchip,enable-strobe-pulldown:
> +    type: boolean
> +    description: |
> +      Enable internal pull-down for the strobe
> +      line.  If not set, pull-down is not used.
> +
> +  rockchip,output-tapdelay-select:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Specifies the phyctrl_otapdlysec register.
> +    default: 0x4
> +    maximum: 0xf
> +
> +required:

> +  - "#phy-cells"

Move at the bottom of this list.

> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    grf: syscon@ff770000 {
> +      compatible = "rockchip,rk3399-grf", "syscon", "simple-mfd";
> +      reg = <0xff770000 0x10000>;
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +
> +      emmcphy: phy@f780 {

> +        #phy-cells = <0>;

Move at the bottom of this list.
Order of Properties in Device Node:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n112

> +        compatible = "rockchip,rk3399-emmc-phy";
> +        reg = <0xf780 0x20>;
> +        clocks = <&sdhci>;
> +        clock-names = "emmcclk";
> +        drive-impedance-ohm = <50>;
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt b/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
> deleted file mode 100644
> index 57d28c0d5696..000000000000
> --- a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
> +++ /dev/null
> @@ -1,43 +0,0 @@
> -Rockchip EMMC PHY
> ------------------------
> -
> -Required properties:
> - - compatible: rockchip,rk3399-emmc-phy
> - - #phy-cells: must be 0
> - - reg: PHY register address offset and length in "general
> -   register files"
> -
> -Optional properties:
> - - clock-names: Should contain "emmcclk".  Although this is listed as optional
> -		(because most boards can get basic functionality without having
> -		access to it), it is strongly suggested.
> -		See ../clock/clock-bindings.txt for details.
> - - clocks: Should have a phandle to the card clock exported by the SDHCI driver.
> - - drive-impedance-ohm: Specifies the drive impedance in Ohm.
> -                        Possible values are 33, 40, 50, 66 and 100.
> -                        If not set, the default value of 50 will be applied.
> - - rockchip,enable-strobe-pulldown: Enable internal pull-down for the strobe
> -                                    line.  If not set, pull-down is not used.
> - - rockchip,output-tapdelay-select: Specifies the phyctrl_otapdlysec register.
> -                                    If not set, the register defaults to 0x4.
> -                                    Maximum value 0xf.
> -
> -Example:
> -
> -
> -grf: syscon@ff770000 {
> -	compatible = "rockchip,rk3399-grf", "syscon", "simple-mfd";
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -
> -...
> -
> -	emmcphy: phy@f780 {
> -		compatible = "rockchip,rk3399-emmc-phy";
> -		reg = <0xf780 0x20>;
> -		clocks = <&sdhci>;
> -		clock-names = "emmcclk";
> -		drive-impedance-ohm = <50>;
> -		#phy-cells = <0>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> index 79798c747476..1f88416657cc 100644

> --- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> +++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml

grf.yaml can be busy at times. Let Heiko take care of the merge order.
Ask for an ack from the phy maintainers in your commit message below a "---"

> @@ -178,7 +178,7 @@ allOf:
>        patternProperties:
>          "phy@[0-9a-f]+$":

>            description:
> -            Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
> +            Documentation/devicetree/bindings/phy/rockchip,emmc-phy.yaml

Integrate rockchip,emmc-phy.yaml with grf.yaml with $ref.
Remove above, use/test below:

          $ref: /schemas/phy/rockchip,emmc-phy.yaml#

          unevaluatedProperties: false


>  
>    - if:
>        properties:

