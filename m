Return-Path: <linux-kernel+bounces-288408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B019539D3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 20:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE4C81F21592
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA125B1FB;
	Thu, 15 Aug 2024 18:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YUMt4KDG"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1193383A3
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723745955; cv=none; b=fQld8iBv9bJdaiAb5SH/z6IqSIwrNNPMdsXCHBTpI8U8nu6mK2w6PL0Mh/QD0qZYMu+2vjar2GcuzNYAYdjAicqJvM8tuu4j52GDTH5tlyKJCeE6pw5fePyptH6OdKD9+3FYxpOp1wlcODVx6NfuPVfb37EOkoKrBkDVnJjl6nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723745955; c=relaxed/simple;
	bh=qTGWnus/xajntiXwLNkQjMMlbBirJmOcpWKDV/rMMbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOALi239a1QULOep8JcGaVrOGyE02In7XtQLBPJKWGiVotpk91QQ56OU+fc9fJz+VT6i90N4QxERjDQiEmVfbrjhP5HXgKvcmhy4HheIYgxrg+fHoSLYz8v1W7cjpkJHAt6/SRAKRBqJzWReXtNOkZ53Y57IcptBQ2quB+I1wdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YUMt4KDG; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc56fd4de1so9256035ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 11:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723745953; x=1724350753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=obzmhQk8Xy3e9sDQPYIq1Np9pZwsRDfrPqw0CyAFY8k=;
        b=YUMt4KDG6nt8v1MaXKPAlHNfORdPo6l9bWilyKipn9u8hE5ciGlGaiF05DXtVJFnl/
         /wA/VgM3gvQ3XCDNE9nvHg2EV8FynbA2H3zdADA9OoPltkcFIveyj7RCZwyJJdlrZyEd
         fYS9NsPGrJt82Hcnk5E6aqMk6G/l/WAAOYf3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723745953; x=1724350753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obzmhQk8Xy3e9sDQPYIq1Np9pZwsRDfrPqw0CyAFY8k=;
        b=VXMkO4CDeX79/TdzFtMPHkbu7QhJA42fSwM/EZxSRlGQ4SeGxN6k0BlmDDz9eTh4cu
         a9RaTj+GlXw9Q0H/Fnrn7YPRDfsO/Daddc6a4yvX/QPnIMZe2agMKFR04GxG+Q7E9kNk
         XvlSSl2yKoFPCN5ruA6L80rYE75bXWRBlhP500lMbfMEzhF42uLPGMS0hpznLeWDH0Uu
         UKc5//E5a/Zzop2wWrW0HiWRdbpIQJw/dLHpQ528xJuteHzuEbW5ylowkcXN6wuDXRF+
         rkcKLIKikKaGRrJ9OBBTLqu12LlpZjJ1h07zW4jSm5raVGvLhEzC9eldk3LlGTeYtc7L
         MpEw==
X-Forwarded-Encrypted: i=1; AJvYcCX5mykPhrOEdhrlm/ShZ2nza0sVW11GEDOqxp6Jg+WSeYyyeYipOpxh4cewBctdPaWntqMNTP164ORTagXiZGyqvrdqXkkVqgqHwxDE
X-Gm-Message-State: AOJu0Yz5bBL86CZWyZ88BQ7m7N/amyYcdOWV2L4OG498JnstXGBFblHC
	p50qaj3FHdm5XMfpT3yepYG7EJyA1eepv2hwPVrxFSHYyg1fHdpD6EAg7Moh0Q==
X-Google-Smtp-Source: AGHT+IHCeenSQW5v809RWxm5k6tr6zFciMM4rFQNhw44zAMjp7OcNEYeeVpImhSYQ7cFYyL7U2umfg==
X-Received: by 2002:a17:903:35c4:b0:201:eb46:1be5 with SMTP id d9443c01a7336-20206162588mr1821665ad.3.1723745953087;
        Thu, 15 Aug 2024 11:19:13 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:5afb:2a2e:f5be:2aed])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-201f0375725sm12853415ad.132.2024.08.15.11.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 11:19:12 -0700 (PDT)
Date: Thu, 15 Aug 2024 11:19:10 -0700
From: Brian Norris <briannorris@chromium.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:NETWORKING DRIVERS (WIRELESS)" <linux-wireless@vger.kernel.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v1 1/1] dt-bindings: net: wireless: convert
 marvel-8xxx.txt to yaml format
Message-ID: <Zr5GnhNm0lSQNBwa@google.com>
References: <20240812194441.3826789-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812194441.3826789-1-Frank.Li@nxp.com>

Hi Frank,

On Mon, Aug 12, 2024 at 03:44:40PM -0400, Frank Li wrote:
> Convert binding doc marvel-8xxx.txt to yaml format.
> Additional change:
> - Remove marvell,caldata_00_txpwrlimit_2g_cfg_set in example.
> - Remove mmc related property in example.
> 
> Fix below warning:
> arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dtb: /soc@0/bus@30800000/mmc@30b40000/wifi@1:
> failed to match any schema with compatible: ['marvell,sd8997']

Can you make sure to run through `make dtbs_check` and handle any new
issues? For one, I think you might want to include 'wakeup-source'?

arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dtb: wifi@0,0: 'wakeup-source' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/net/wireless/marvell,8xxx.yaml#


> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/net/wireless/marvell,8xxx.yaml   | 96 +++++++++++++++++++
>  .../bindings/net/wireless/marvell-8xxx.txt    | 70 --------------
>  2 files changed, 96 insertions(+), 70 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/marvell,8xxx.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/marvell,8xxx.yaml b/Documentation/devicetree/bindings/net/wireless/marvell,8xxx.yaml
> new file mode 100644
> index 0000000000000..7b4927cdb7a01
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/wireless/marvell,8xxx.yaml
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/wireless/marvell,8xxx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell 8787/8897/8978/8997 (sd8787/sd8897/sd8978/sd8997/pcie8997) SDIO/PCIE devices
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>

I wouldn't mind adding:

  - Brian Norris <briannorris@chromium.org>

> +
> +description:
> +  This node provides properties for controlling the Marvell SDIO/PCIE wireless device.

Since we're essentially rewriting this doc, might as well tweak a few
things:
Please replace "controlling" with "describing". These bindings are for
hardware description, not for software control (even though they seem
like it sometimes and can be abused for that).

> +  The node is expected to be specified as a child node to the SDIO/PCIE controller that
> +  connects the device to the system.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - marvell,sd8787
> +      - marvell,sd8897
> +      - marvell,sd8978
> +      - marvell,sd8997
> +      - nxp,iw416
> +      - pci11ab,2b42
> +      - pci1b4b,2b42
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  marvell,caldata-txpwrlimit-2g:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description: calibration data

Capitalize the first letter ("Calibration"). Same on all your
descriptions.

And maybe expand a little on what this means? Same on the other caldata
properties.

For example, "Calibration data for the 2GHz band."

> +    maxItems: 566

Non-critical question: are these numbers actually correct? The only
instance I see in the upstream tree is
arch/arm/boot/dts/rockchip/rk3288-veyron-jerry.dts, with 526 items. Yes,
that still fits in this "max", but I just wonder whether this is an
actually-correct specification, or an off-by-40 specification. Or, maybe
the structure varies a lot by chip or firmware, and this max just isn't
very meaningful.

Like I said, it's non-critical, so maybe we leave it as-is, if it
doesn't matter much.

> +  marvell,caldata-txpwrlimit-5g-sub0:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description: calibration data

Possibly, "Calibration data for sub-band 0 in the 5GHz band."? And even
better if you can describe what sub-band 0 is (e.g., 5.xxx MHz - 5.yyy
MHz). But I'm not familiar.

> +    maxItems: 502
> +
> +  marvell,caldata-txpwrlimit-5g-sub1:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description: calibration data
> +    maxItems: 688
> +
> +  marvell,caldata-txpwrlimit-5g-sub2:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description: calibration data
> +    maxItems: 750
> +
> +  marvell,caldata-txpwrlimit-5g-sub3:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description: calibration data
> +    maxItems: 502
> +
> +  marvell,wakeup-pin:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      a wakeup pin number of wifi chip which will be configured
> +      to firmware. Firmware will wakeup the host using this pin
> +      during suspend/resume.

Optional: this could use a bit of a rewrite to describe the hardware
instead of the software. For example, "Provides the pin number for the
wakeup pin from the device's point of view. The wakeup pin is used for
the device to wake the host system from sleep. This property is only
necessary if the wakeup pin is wired in a non-standard way, such that
the default pin assignments are invalid."

> +
> +  vmmc-supply:
> +    description: a phandle of a regulator, supplying VCC to the card

I believe this vmmc-supply property is actually misplaced. I don't see
any in-tree users, and OTOH all in-tree users specify this in the parent
(e.g., the MMC controller), where it's already properly documented.

> +  mmc-pwrseq:
> +    description:
> +      phandle to the MMC power sequence node. See "mmc-pwrseq-*"
> +      for documentation of MMC power sequence bindings.

Similarly, I think this is misplaced. See its introduction here,
commit e3fffc1f0b47 ("devicetree: document new marvell-8xxx and
pwrseq-sd8787 options"), but the controller docs
(Documentation/devicetree/bindings/mmc/mmc-controller.yaml) specify
these properties for the controller, not the endpoint/card. And
Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.yaml is vague,
but in practice, again, I think everyone uses this only in the
controller.

I'd consider dropping this and vmmc-supply, unless `make dtbs_check`
complains.

Brian

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    mmc {
> +         #address-cells = <1>;
> +         #size-cells = <0>;
> +
> +         wifi@1 {
> +             compatible = "marvell,sd8897";
> +             reg = <1>;
> +             interrupt-parent = <&pio>;
> +             interrupts = <38 IRQ_TYPE_LEVEL_LOW>;
> +             marvell,wakeup-pin = <3>;
> +        };
> +    };
> +

