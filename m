Return-Path: <linux-kernel+bounces-414419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FB99D27B4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00A31283FED
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11021CDA35;
	Tue, 19 Nov 2024 14:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFAUn4uK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6A3E57D;
	Tue, 19 Nov 2024 14:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732025559; cv=none; b=lU9cdmMQUSrZzxK0TcDiGcwvRJMqGd6Ao4mBk3cBTA3eF6mtfd8Q08nroN7JPCO4pzxXnPzkngOwPncJsw4PkTP3XuCaSsfPSluzMS58ozuOAZ8uamja+Yy8DmfnivYGEF9ZQm7SsiKeB8p3YYhY7qXOj6nd67IeFif1U+/LeV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732025559; c=relaxed/simple;
	bh=rXCnaTBFJsUj4p87piDnz1IdGPw72XgEh5Shigy8KTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVlie10RLnCYA/LfNHTRU/YySyAHwZ6UdF2d0uxT1f1VTyjkE5vLJqaylH0q2pd7HP6y+LnMctdDGbQsjpddUePIUZDy9Zs1d7ZHsLicYE0kOiTOOdKAm9yDaIESZGAF199GUYW+a/iYwz8TOPCbizqzA81SOaOTK/3A310T8EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFAUn4uK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A0EC4CECF;
	Tue, 19 Nov 2024 14:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732025558;
	bh=rXCnaTBFJsUj4p87piDnz1IdGPw72XgEh5Shigy8KTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iFAUn4uKil31Xr8W5g4SPX+hS+fvldjhduKvdrXkoXHhE13OEyUSgmb1974VH/i72
	 Cak01s9lh62m8cdiZEWbgWbcQhBFAI04GKllE4IdS2TSY8E1Kf7Ctl9QUShvWOpo/g
	 Tvlkz4XpybiTRcRrRLONPsXXPjGid6TrlxDf4P4XuyYtBeybdR2RRkzZhtsJwheWzF
	 2bkwMd3VG7NWSQIenWnM994CPxLsyuVQagiqkciL/JkGRHTP9WoaYtcycaMy0tx4C3
	 unkerhhRZfAnJQGjRxD0rixUNCSCZTFky67Ommv+0TE6kJMXC3QlW2ZrSY+jrDflUE
	 3JdIaIV6sExww==
Date: Tue, 19 Nov 2024 08:12:36 -0600
From: Rob Herring <robh@kernel.org>
To: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	ycliang@andestech.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	peterlin@andestech.com, samuel.holland@sifive.com,
	conor.dooley@microchip.com, alexghiti@rivosinc.com,
	ruanjinjie@huawei.com, takakura@valinux.co.jp, conor+dt@kernel.org,
	jassisinghbrar@gmail.com, krzk+dt@kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/4] dt-bindings: mailbox: add binding for Microchip
 IPC mailbox controller
Message-ID: <20241119141236.GA1099946-robh@kernel.org>
References: <20241105183513.1358736-1-valentina.fernandezalanis@microchip.com>
 <20241105183513.1358736-4-valentina.fernandezalanis@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241105183513.1358736-4-valentina.fernandezalanis@microchip.com>

On Tue, Nov 05, 2024 at 06:35:12PM +0000, Valentina Fernandez wrote:
> Add a dt-binding for the Microchip Inter-Processor Communication (IPC)
> mailbox controller.
> 
> Signed-off-by: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
> ---
>  .../bindings/mailbox/microchip,sbi-ipc.yaml   | 117 ++++++++++++++++++
>  1 file changed, 117 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/microchip,sbi-ipc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/microchip,sbi-ipc.yaml b/Documentation/devicetree/bindings/mailbox/microchip,sbi-ipc.yaml
> new file mode 100644
> index 000000000000..9e67c09e4bea
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/microchip,sbi-ipc.yaml
> @@ -0,0 +1,117 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/microchip,sbi-ipc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip Inter-processor communication (IPC) mailbox controller
> +
> +maintainers:
> +  - Valentina Fernandez <valentina.fernandezalanis@microchip.com>
> +
> +description:
> +  The Microchip Inter-processor Communication (IPC) facilitates
> +  message passing between processors using an interrupt signaling
> +  mechanism.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description:
> +          Intended for use by software running in supervisor privileged
> +          mode (s-mode). This SBI interface is compatible with the Mi-V
> +          Inter-hart Communication (IHC) IP.
> +        items:
> +          - const: microchip,sbi-ipc
> +
> +      - description:
> +          SoC-specific compatible, intended for use by the SBI
> +          implementation in machine mode (m-mode).
> +        items:
> +          - const: microchip,miv-ihc-rtl-v2

Usually SoC specific compatibles don't have version numbers. And all 
hardware in an SoC is RTL at some point. So microchip,miv-ihc should be 
sufficient if 'miv' is an SoC.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 5
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 5
> +    items:
> +      pattern: "^hart-[0-5]+$"
> +
> +  "#mbox-cells":
> +    description: >
> +      For the SBI "device", the cell represents the global "logical" channel IDs.
> +      The meaning of channel IDs are platform firmware dependent.
> +
> +      For the SoC-specific compatible string, the cell represents the physical
> +      channel and does not vary based on the platform firmware.
> +    const: 1
> +
> +  microchip,ihc-chan-disabled-mask:
> +    description: >
> +      Represents the enable/disable state of the bi-directional IHC
> +      channels within the MIV-IHC IP configuration.
> +
> +      The mask is a 16-bit value, but only the first 15 bits are utilized.
> +      Each of the bits corresponds to one of the 15 IHC channels.

That can be expressed as a constraint:

maximum: 0x7fff

Then you can drop this paragraph.

> +
> +      A bit set to '1' indicates that the corresponding channel is disabled,
> +      and any read or write operations to that channel will return zero.
> +
> +      A bit set to '0' indicates that the corresponding channel is enabled
> +      and will be accessible through its dedicated address range registers.
> +
> +      The remaining bit of the 16-bit mask is reserved and should be ignored.

And drop this one.

> +
> +      The actual enable/disable state of each channel is determined by the
> +      IP block’s configuration.
> +    $ref: /schemas/types.yaml#/definitions/uint16
> +    default: 0
> +
> +required:
> +  - compatible
> +  - interrupts
> +  - interrupt-names
> +  - "#mbox-cells"
> +
> +additionalProperties: false
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: microchip,sbi-ipc
> +    then:
> +      properties:
> +        reg: false
> +        microchip,ihc-chan-disabled-mask: false
> +    else:
> +      required:
> +        - reg
> +        - microchip,ihc-chan-disabled-mask
> +
> +examples:
> +  - |
> +    mailbox {
> +      compatible = "microchip,sbi-ipc";
> +      interrupt-parent = <&plic>;
> +      interrupts = <180>, <179>, <178>;
> +      interrupt-names = "hart-1", "hart-2", "hart-3";
> +      #mbox-cells = <1>;
> +    };
> +  - |
> +    mailbox@50000000 {
> +      compatible = "microchip,miv-ihc-rtl-v2";
> +      microchip,ihc-chan-disabled-mask = /bits/ 16 <0>;
> +      reg = <0x50000000 0x1C000>;
> +      interrupt-parent = <&plic>;
> +      interrupts = <180>, <179>, <178>;
> +      interrupt-names = "hart-1", "hart-2", "hart-3";
> +      #mbox-cells = <1>;
> +    };
> -- 
> 2.34.1
> 

