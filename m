Return-Path: <linux-kernel+bounces-204540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121998FF03F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB071C261AA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FEA198A09;
	Thu,  6 Jun 2024 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwwb5eD+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B7919884A;
	Thu,  6 Jun 2024 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717685905; cv=none; b=agJKYjCLLkvSU6BMLMtU1JlXDo8K7r68JC5UNj64OA0Q3OgPT4Gwgtq16hjCyR9J5oP64AnscAHc5bTYOlb0Untf57oeT17veHXtLLTTgzMw5v07pQhJkbfmoOpfdGMaJISWX1PcVKm4FZB5alpisGKYBKzbC2qt14jio3AexXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717685905; c=relaxed/simple;
	bh=+5bxvf0v2FVyUXIrKPcUNq52cRGrHBpwGeGDJnmbnJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLVKVEqvsccfGlR7cF/+2KMDOVuZO/ZowgeRPwhYM9dudOZ9kf9+TM9FWSoHx4bUBBLfDwsBCsHaQebyvFpGhAngFsh1XX9zTYIb0QBMUmfKIbeJLjDvr8f6EfGhblaUbF4RyQKZGVheVFH6cvH7JIhHXxMONYa+q0QZBW4lXM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwwb5eD+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1547C2BD10;
	Thu,  6 Jun 2024 14:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717685904;
	bh=+5bxvf0v2FVyUXIrKPcUNq52cRGrHBpwGeGDJnmbnJ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jwwb5eD+l+DurInLJxKAXBTR2YMVm4VmopGfGFizR8mXdCKqiPdfloiAOFmPMus8k
	 8G+lVTgL3sV8BQ1N0apW5QU+JMAroRFG33TofmE27PH5wwHeFn4RTmmmGS9jmMDjgW
	 tKLEhVjCV8SuaejQpW9PTq8z4Sqy1x/ID0SHddsXb+TK51bgTj95W5s2I0AQObthSr
	 VAEHKlbwd1B9XbToSFFdk0uWHGvibpOcOPRIZ9ApWAgfG9m2IIrAliyXar18usnfUl
	 TEtZDxJI5RnDH+K5pIW3OotMauefv4GAsJ0kEDGt/RFyVLMtI78DGi1Y5H8/MznmgF
	 AmPA4Cec7BEzw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52b840cfecdso1260527e87.3;
        Thu, 06 Jun 2024 07:58:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWB3m2hWDbFSmGmj2rysP4L5WskpVxVzhLEWQXm55RfbqythuYFZBRqHBD4pA0j3R7SVuKZm8Ver5Fyaa7kFGKWghXOpNiPybjcJEDTrdNHP+mWOeAIKSdh2jkLlxpeUEFGqnjxFW+KKw==
X-Gm-Message-State: AOJu0Yz9TgaIw7onQ+1Un68G0x0ZVpelwtnpDusk9wGa+fxz6V1Cf3pL
	d+W6lJQAOBj5lc9S/Bw2VWAdMiuP5D03ebgZ0jYj7Lu+8HY3TklpqqFeBYpAJMjzCTNyzVoIQAT
	qPwZhFbZiAwdy7QNP/Gz+xAn19w==
X-Google-Smtp-Source: AGHT+IEI/HzrYwCNH+fgv5QUK3X6q1WLoehrFnvaSYS+6bZQTY8kCtZZFy9elFAgM+jtrBoVoTj5yw4L49fT/gXDhws=
X-Received: by 2002:ac2:42cd:0:b0:52b:9c8a:7356 with SMTP id
 2adb3069b0e04-52bab4fb431mr3412448e87.49.1717685903060; Thu, 06 Jun 2024
 07:58:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601-b4-rk3588-bridge-upstream-v1-0-f6203753232b@collabora.com>
 <20240601-b4-rk3588-bridge-upstream-v1-12-f6203753232b@collabora.com>
 <20240605232206.GA3345910-robh@kernel.org> <260aa607-099a-4f65-ae59-c4b6ea2256f1@collabora.com>
In-Reply-To: <260aa607-099a-4f65-ae59-c4b6ea2256f1@collabora.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 6 Jun 2024 08:58:09 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKsVE1VgoYGe7qPaAV82dbs5UMGPG843mz26Opv0Y7Hxg@mail.gmail.com>
Message-ID: <CAL_JsqKsVE1VgoYGe7qPaAV82dbs5UMGPG843mz26Opv0Y7Hxg@mail.gmail.com>
Subject: Re: [PATCH 12/14] dt-bindings: display: rockchip,dw-hdmi: Add
 compatible for RK3588
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	Andy Yan <andy.yan@rock-chips.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Mark Yao <markyao0591@gmail.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	devicetree@vger.kernel.org, kernel@collabora.com, 
	Alexandre ARNOUD <aarnoud@me.com>, Luis de Arquer <ldearquer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 5:51=E2=80=AFAM Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
>
> On 6/6/24 2:22 AM, Rob Herring wrote:
> > On Sat, Jun 01, 2024 at 04:12:34PM +0300, Cristian Ciocaltea wrote:
> >> Document the Synopsys DesignWare HDMI 2.1 Quad-Pixel (QP) TX controlle=
r
> >> found on Rockchip RK3588 SoC family.
> >>
> >> Since RK3588 uses different clocks than previous Rockchip SoCs and als=
o
> >> requires a couple of reset lines and some additional properties, provi=
de
> >> the required changes in the binding to accommodate all variants.
> >>
> >> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> >> ---
> >>  .../display/rockchip/rockchip,dw-hdmi.yaml         | 127 ++++++++++++=
+++------
> >>  1 file changed, 90 insertions(+), 37 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockch=
ip,dw-hdmi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockch=
ip,dw-hdmi.yaml
> >> index 2aac62219ff6..60d6b815227f 100644
> >> --- a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-h=
dmi.yaml
> >> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-h=
dmi.yaml
> >> @@ -10,12 +10,10 @@ maintainers:
> >>    - Mark Yao <markyao0591@gmail.com>
> >>
> >>  description: |
> >> -  The HDMI transmitter is a Synopsys DesignWare HDMI 1.4 TX controlle=
r IP
> >> -  with a companion PHY IP.
> >> -
> >> -allOf:
> >> -  - $ref: ../bridge/synopsys,dw-hdmi.yaml#
> >> -  - $ref: /schemas/sound/dai-common.yaml#
> >> +  For SoCs up to RK3568, the HDMI transmitter is a Synopsys DesignWar=
e
> >> +  HDMI 1.4 TX controller IP with a companion PHY IP.
> >> +  The RK3588 SoC integrates the Synopsys DesignWare HDMI 2.1 Quad-Pix=
el (QP)
> >> +  TX controller IP and a HDMI/eDP TX Combo PHY based on a Samsung IP =
block.
> >>
> >>  properties:
> >>    compatible:
> >> @@ -25,6 +23,7 @@ properties:
> >>        - rockchip,rk3328-dw-hdmi
> >>        - rockchip,rk3399-dw-hdmi
> >>        - rockchip,rk3568-dw-hdmi
> >> +      - rockchip,rk3588-dw-hdmi
> >>
> >>    reg-io-width:
> >>      const: 4
> >> @@ -40,36 +39,6 @@ properties:
> >>        A 1.8V supply that powers up the SoC internal circuitry. The pi=
n name on the
> >>        SoC usually is HDMI_TX_AVDD_1V8.
> >>
> >> -  clocks:
> >> -    minItems: 2
> >> -    items:
> >> -      - {}
> >> -      - {}
> >> -      # The next three clocks are all optional, but shall be specifie=
d in this
> >> -      # order when present.
> >> -      - description: The HDMI CEC controller main clock
> >> -      - description: Power for GRF IO
> >> -      - description: External clock for some HDMI PHY (old clock name=
, deprecated)
> >> -      - description: External clock for some HDMI PHY (new name)
> >> -
> >> -  clock-names:
> >> -    minItems: 2
> >> -    items:
> >> -      - {}
> >> -      - {}
> >> -      - enum:
> >> -          - cec
> >> -          - grf
> >> -          - vpll
> >> -          - ref
> >> -      - enum:
> >> -          - grf
> >> -          - vpll
> >> -          - ref
> >> -      - enum:
> >> -          - vpll
> >> -          - ref
> >> -
> >>    ddc-i2c-bus:
> >>      $ref: /schemas/types.yaml#/definitions/phandle
> >>      description:
> >> @@ -131,13 +100,97 @@ properties:
> >>  required:
> >>    - compatible
> >>    - reg
> >> -  - reg-io-width
> >>    - clocks
> >>    - clock-names
> >>    - interrupts
> >>    - ports
> >>    - rockchip,grf
> >>
> >> +allOf:
> >> +  - $ref: /schemas/sound/dai-common.yaml#
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            enum:
> >> +              - rockchip,rk3588-dw-hdmi
> >> +    then:
> >> +      properties:
> >> +        reg:
> >> +          maxItems: 1
> >> +
> >> +        clocks:
> >> +          minItems: 1
> >> +          items:
> >> +            - description: APB system interface clock
> >> +            # The next clocks are optional, but shall be specified in=
 this
> >> +            # order when present.
> >> +            - description: TMDS/FRL link clock
> >> +            - description: EARC RX biphase clock
> >> +            - description: Reference clock
> >> +            - description: Audio interface clock
> >> +            - description: Video datapath clock
> >> +
> >> +        clock-names:
> >> +          minItems: 1
> >> +          items:
> >> +            - const: pclk
> >> +            - enum: [hdp, earc, ref, aud, hclk_vo1]
> >> +            - enum: [earc, ref, aud, hclk_vo1]
> >> +            - enum: [ref, aud, hclk_vo1]
> >> +            - enum: [aud, hclk_vo1]
> >> +            - const: hclk_vo1
> >> +
> >> +        resets:
> >> +          minItems: 2
> >> +          maxItems: 2
> >> +
> >> +        reset-names:
> >> +          items:
> >> +            - const: ref
> >> +            - const: hdp
> >> +
> >> +        interrupts:
> >> +          minItems: 1
> >> +          maxItems: 5
> >> +
> >> +        rockchip,vo1_grf:
> >> +          $ref: /schemas/types.yaml#/definitions/phandle
> >> +          description: Some QP related data is accessed through VO1 G=
RF regs
> >> +
> >> +      required:
> >> +        - resets
> >> +        - reset-names
> >> +        - rockchip,vo1_grf
> >> +
> >> +    else:
> >> +      $ref: ../bridge/synopsys,dw-hdmi.yaml#
> >
> > This is odd... With this plus the amount of conditional schema, I think
> > this should be a new schema doc. Doesn't have to have a common
> > schema. You can let the 2nd user of this IP block do that.
>
> Yes, v2 is going to be a completely separated driver implementation.

That actually has nothing to do with the decision here. Bindings are
separate from drivers.

Rob

