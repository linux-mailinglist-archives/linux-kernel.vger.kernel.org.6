Return-Path: <linux-kernel+bounces-310032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 660A9967375
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 00:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 836461F2203A
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 22:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8EB17DFE4;
	Sat, 31 Aug 2024 22:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b="NaPVYIjE"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8287D282FC;
	Sat, 31 Aug 2024 22:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725141722; cv=pass; b=PRklpEorpB2AfyNqWnUTbZehNfzoPNdNpGpy+e9B8G5ZbfSSoaHp0Ma92wZqLbHmhKDIOD42MCZg7d2HkR0KI79VUpdcA4peNP6H2jzi/xiRasuBCLvMKcc3MZvyGY815MTQApWOPtoB9FPWY6G2MY5DwB7p+SxF/MJUYslXhuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725141722; c=relaxed/simple;
	bh=hkXzGQ10UgKWu6otW9vfefmqBmxPVtuDRkLsuQ6eXNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wmf0ZbWyL7VFh+f0qVsZu+HHDckdibQZosnhfiX1nxvCEiB4DulrPaXNl4kHMMTjZtFe8vRy6PnOw4g7n4tHWvmHq7kkl6PAjpB72QuPthiYC7wnnMeZ4yxdCiKF6ZWxc7Fs/LVujdUw5guT31+WNU8P/cRnnW2BOaz+l2vQDKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b=NaPVYIjE; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1725141681; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YJC0IM6EDgPDzLvDckxoIcBqgR6n30kKdUjUbcFtokSlhJFzItzX4Wmf72rI22YX+ViXmBz1fYdRgAG7UmB2jhcHcQD/DnOv9Sco88+T3K1+tXzfOiRAp3DbMhOhuEnC49g5bEPmutShormVudN6APQKFwmlrPmQoRFn2CGU3ms=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1725141681; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5HcjGo3CfrQc/zNUykd6XyQdr0Oc6HLR18XH+J1x8Zo=; 
	b=mwQbKkVwc5ftc/FnMAb4KLCMN13Z1YQZVE+aICgdqUC7lFFGXzm2DPkLPpcN8fcqfjKYjUPXNP4Zu+pjyO9UPCfc5UmC5SR6oDrL8iZS1yfIHCvQK95q89dH2qAb98W4dWQGuA++eFJxu3ce90/HpziJb6fxYfuxk8Osus2mr6o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=cristian.ciocaltea@collabora.com;
	dmarc=pass header.from=<cristian.ciocaltea@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1725141681;
	s=zohomail; d=collabora.com; i=cristian.ciocaltea@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=5HcjGo3CfrQc/zNUykd6XyQdr0Oc6HLR18XH+J1x8Zo=;
	b=NaPVYIjENLO2r9rKWk2pCDmB7GVZYvZY4HeilwXSUDXO0cfsc96VdXN60608E8wu
	t4AnRSFdula4ct5mgfjix5QyIHgmPogVAG8LBuMUcTDEOC75BIrC4pyJYP8hRu/rCQ5
	/a9pA+FJUeagea1A+tF59BMhyZQz/Kf2Lc1ubyJw=
Received: by mx.zohomail.com with SMTPS id 1725141679538558.0126608579487;
	Sat, 31 Aug 2024 15:01:19 -0700 (PDT)
Message-ID: <5ea24ad3-7faa-4a59-ba10-d43b32b3b40e@collabora.com>
Date: Sun, 1 Sep 2024 01:01:12 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] dt-bindings: display: rockchip: Add schema for
 RK3588 HDMI TX Controller
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Mark Yao <markyao0591@gmail.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 kernel@collabora.com, Alexandre ARNOUD <aarnoud@me.com>,
 Luis de Arquer <ldearquer@gmail.com>
References: <20240831-b4-rk3588-bridge-upstream-v5-0-9503bece0136@collabora.com>
 <20240831-b4-rk3588-bridge-upstream-v5-3-9503bece0136@collabora.com>
 <myiu2nmyzysjnuvy4jnahket2go5kq4qs7pdhb7rznrp5pwilj@d55nh7qdenhj>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Content-Language: en-US
In-Reply-To: <myiu2nmyzysjnuvy4jnahket2go5kq4qs7pdhb7rznrp5pwilj@d55nh7qdenhj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 8/31/24 9:13 AM, Krzysztof Kozlowski wrote:
> On Sat, Aug 31, 2024 at 12:55:31AM +0300, Cristian Ciocaltea wrote:
>> Rockchip RK3588 SoC integrates the Synopsys DesignWare HDMI 2.1
>> Quad-Pixel (QP) TX controller IP.
>>
>> Since this is a new IP block, quite different from those used in the
>> previous generations of Rockchip SoCs, add a dedicated binding file.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  .../rockchip/rockchip,rk3588-dw-hdmi-qp.yaml       | 166 +++++++++++++++++++++
>>  1 file changed, 166 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-dw-hdmi-qp.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-dw-hdmi-qp.yaml
>> new file mode 100644
>> index 000000000000..d2919ff6aa23
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-dw-hdmi-qp.yaml
>> @@ -0,0 +1,166 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/rockchip/rockchip,rk3588-dw-hdmi-qp.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Rockchip DW HDMI QP TX Encoder
>> +
>> +maintainers:
>> +  - Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> +
>> +description:
>> +  Rockchip RK3588 SoC integrates the Synopsys DesignWare HDMI QP TX controller
>> +  IP and a HDMI/eDP TX Combo PHY based on a Samsung IP block.
>> +
>> +allOf:
>> +  - $ref: /schemas/display/bridge/synopsys,dw-hdmi-qp.yaml#
>> +  - $ref: /schemas/sound/dai-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - rockchip,rk3588-dw-hdmi-qp
>> +
>> +  clocks:
>> +    items:
>> +      - {}
>> +      - {}
>> +      - {}
>> +      - {}
>> +      - description: TMDS/FRL link clock
>> +      - description: Video datapath clock
> 
> Please define all clocks.

The other clocks are defined in the common binding, should we reiterate
them?

>> +
>> +  clock-names:
>> +    items:
>> +      - {}
>> +      - {}
>> +      - {}
>> +      - {}
>> +      - enum: [hdp, hclk_vo1]
>> +      - const: hclk_vo1
>> +
>> +  interrupts:
>> +    items:
>> +      - {}
>> +      - {}
>> +      - {}
>> +      - {}
>> +      - description: HPD interrupt
>> +
>> +  interrupt-names:
>> +    items:
>> +      - {}
>> +      - {}
>> +      - {}
>> +      - {}
>> +      - const: hpd
>> +
>> +  phys:
>> +    maxItems: 1
>> +    description: The HDMI/eDP PHY.
>> +
>> +  phy-names:
>> +    const: hdmi
> 
> Drop phy-names, not really useful if it copies the name of the block.

Sure, will drop it.

>> +
>> +  power-domains:
>> +    maxItems: 1
>> +
>> +  resets:
>> +    minItems: 2
>> +    maxItems: 2
>> +
>> +  reset-names:
>> +    items:
>> +      - const: ref
>> +      - const: hdp
>> +
>> +  "#sound-dai-cells":
>> +    const: 0
>> +
>> +  rockchip,grf:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      Some HDMI QP related data is accessed through SYS GRF regs.
>> +
>> +  rockchip,vo-grf:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      Additional HDMI QP related data is accessed through VO GRF regs.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - interrupts
>> +  - interrupt-names
>> +  - phys
>> +  - phy-names
>> +  - ports
>> +  - resets
>> +  - reset-names
>> +  - rockchip,grf
>> +  - rockchip,vo-grf
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/rockchip,rk3588-cru.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    #include <dt-bindings/power/rk3588-power.h>
>> +    #include <dt-bindings/reset/rockchip,rk3588-cru.h>
>> +
>> +    soc {
>> +      #address-cells = <2>;
>> +      #size-cells = <2>;
>> +
>> +      hdmi@fde80000 {
>> +        compatible = "rockchip,rk3588-dw-hdmi-qp";
>> +        reg = <0x0 0xfde80000 0x0 0x20000>;
>> +        clocks = <&cru PCLK_HDMITX0>,
>> +                 <&cru CLK_HDMITX0_EARC>,
>> +                 <&cru CLK_HDMITX0_REF>,
>> +                 <&cru MCLK_I2S5_8CH_TX>,
>> +                 <&cru CLK_HDMIHDP0>,
>> +                 <&cru HCLK_VO1>;
>> +        clock-names = "pclk", "earc", "ref", "aud", "hdp", "hclk_vo1";
>> +        interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH 0>,
>> +                     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>,
>> +                     <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH 0>,
>> +                     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH 0>,
>> +                     <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH 0>;
>> +        interrupt-names = "avp", "cec", "earc", "main", "hpd";
>> +        phys = <&hdptxphy_hdmi0>;
>> +        phy-names = "hdmi";
>> +        power-domains = <&power RK3588_PD_VO1>;
>> +        resets = <&cru SRST_HDMITX0_REF>, <&cru SRST_HDMIHDP0>;
>> +        reset-names = "ref", "hdp";
>> +        rockchip,grf = <&sys_grf>;
>> +        rockchip,vo-grf = <&vo1_grf>;
>> +        #sound-dai-cells = <0>;
>> +
>> +        ports {
>> +          #address-cells = <1>;
>> +          #size-cells = <0>;
>> +
>> +          port@0 {
>> +            reg = <0>;
>> +
>> +            hdmi0_in_vp0: endpoint {
>> +                remote-endpoint = <&vp0_out_hdmi0>;
> 
> Messed indentation.

Ups, somehow I missed this..

Thanks for reviewing,
Cristian

