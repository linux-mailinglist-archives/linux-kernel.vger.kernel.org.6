Return-Path: <linux-kernel+bounces-421930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D6A9D9218
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 08:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63CFC2832D9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 07:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA731917E4;
	Tue, 26 Nov 2024 07:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgKKqNtU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD1617BB6;
	Tue, 26 Nov 2024 07:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732604682; cv=none; b=jse14COtZqOBLbSvASQonLrQKr+6H3cRdm/+OT3CKtHbKQDy19dHsIx+Qcp4flBwgMnB1haQOi3IXW2IAMdBDXZ9uvfyW2XSPDNgnzR55QbclG+Ki70g+cG1zJCsKcKBXTFCwy7TjwDjFxKmMhrTRhpb8zFTSbpIhaeJXWsvUfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732604682; c=relaxed/simple;
	bh=voobZvFOKHIKy07K+o67oMbj3HBO1YNq1ZZaUA6x7yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ayi8bAk3HOJBwTmdrrqdpthZIpagX9DV+pUJpNFQ41EpYbBQ0QJa81/GWajKhbUE0VAezYZY5EcFh1wOVgmX7cG5tffZrM19P1CFsTiIAvqTLPWGj+QR8m2KZ/LyY76X6UHhi57QugwBpm0iYFNPWmw/+z+K4pEXTCkk4jqKAGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgKKqNtU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4C9C4CECF;
	Tue, 26 Nov 2024 07:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732604682;
	bh=voobZvFOKHIKy07K+o67oMbj3HBO1YNq1ZZaUA6x7yU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sgKKqNtUJpMkLzhW63gPRZvh+cM4TimwRu/6bqgDXcgaRm3FtrGfbYyNQkHhi47sb
	 PG+NVS3xqBq1lSLwbS1vBctwJ5vVN27ntOHC/UqX++igQBGB/BnN2fQY7XCfixVS38
	 dC1gmkeVsuEnYQJel1U6KpkscXoe4+jP26iNXaZcp8DZaoZL1BTZ56RBpSmK4YigeS
	 V3w5Hyw/07YWMNRR1v4LAEk9JOgpfGK3kXr3Dt2kPzsq+gjNwTF87Se2XAxyARDEfk
	 RgSAPYh6xnzKxlTeIa1glZFrSksX2wiGVEYJt/u9PseSM7mX+OhALQf+P2u77qZsPn
	 SyEFyoOIXhHwQ==
Date: Tue, 26 Nov 2024 08:04:38 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	ycliang@andestech.com, prabhakar.mahadev-lad.rj@bp.renesas.com, peterlin@andestech.com, 
	samuel.holland@sifive.com, conor.dooley@microchip.com, alexghiti@rivosinc.com, 
	ruanjinjie@huawei.com, takakura@valinux.co.jp, conor+dt@kernel.org, 
	jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/4] dt-bindings: mailbox: add binding for Microchip
 IPC mailbox controller
Message-ID: <vkw7o25szfn2upi5776xdojg5n5fxxaxwynth5kynjwjqzrgua@5lwrjqgzlxzi>
References: <20241125175818.213108-1-valentina.fernandezalanis@microchip.com>
 <20241125175818.213108-4-valentina.fernandezalanis@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241125175818.213108-4-valentina.fernandezalanis@microchip.com>

On Mon, Nov 25, 2024 at 05:58:17PM +0000, Valentina Fernandez wrote:
> Add a dt-binding for the Microchip Inter-Processor Communication (IPC)
> mailbox controller.
>=20
> Signed-off-by: Valentina Fernandez <valentina.fernandezalanis@microchip.c=
om>
> ---
>  .../bindings/mailbox/microchip,sbi-ipc.yaml   | 111 ++++++++++++++++++
>  1 file changed, 111 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/microchip,s=
bi-ipc.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/mailbox/microchip,sbi-ipc.=
yaml b/Documentation/devicetree/bindings/mailbox/microchip,sbi-ipc.yaml
> new file mode 100644
> index 000000000000..b69af85ec608
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/microchip,sbi-ipc.yaml
> @@ -0,0 +1,111 @@
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
> +        const: microchip,sbi-ipc
> +
> +      - description:
> +          Intended for use by the SBI implementation in machine mode
> +          (m-mode), this compatible string is for the MIV_IHC Soft-IP.
> +        const: microchip,miv-ihc-rtl-v2
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

Why hart-0 and hart-5555 are allowed? I thought you have only 5
interrupts. List them instead of pattern, five is small enough still.

> +
> +  "#mbox-cells":
> +    description: >
> +      For "microchip,sbi-ipc", the cell represents the global "logical"
> +      channel IDs. The meaning of channel IDs are platform firmware depe=
ndent.
> +
> +      For "microchip,miv-ihc-rtl-v2", the cell represents the physical
> +      channel and does not vary based on the platform firmware.
> +    const: 1
> +
> +  microchip,ihc-chan-disabled-mask:
> +    description: >
> +      Represents the enable/disable state of the bi-directional IHC
> +      channels within the MIV-IHC IP configuration.
> +
> +      A bit set to '1' indicates that the corresponding channel is disab=
led,
> +      and any read or write operations to that channel will return zero.
> +
> +      A bit set to '0' indicates that the corresponding channel is enabl=
ed
> +      and will be accessible through its dedicated address range registe=
rs.
> +
> +      The actual enable/disable state of each channel is determined by t=
he
> +      IP block=E2=80=99s configuration.
> +    $ref: /schemas/types.yaml#/definitions/uint16
> +    maximum: 0x7fff
> +    default: 0
> +
> +required:
> +  - compatible
> +  - interrupts
> +  - interrupt-names
> +  - "#mbox-cells"
> +
> +additionalProperties: false

This goes after allOf: block

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

What does this mean in reality? Device does not have IO address space?
Then it is completely different programming model, isn't it?

> +        microchip,ihc-chan-disabled-mask: false
> +    else:
> +      required:
> +        - reg
> +        - microchip,ihc-chan-disabled-mask
> +
> +examples:
> +  - |
> +    mailbox {
> +      compatible =3D "microchip,sbi-ipc";
> +      interrupt-parent =3D <&plic>;
> +      interrupts =3D <180>, <179>, <178>;
> +      interrupt-names =3D "hart-1", "hart-2", "hart-3";
> +      #mbox-cells =3D <1>;
> +    };
> +  - |
> +    mailbox@50000000 {
> +      compatible =3D "microchip,miv-ihc-rtl-v2";
> +      microchip,ihc-chan-disabled-mask =3D /bits/ 16 <0>;
> +      reg =3D <0x50000000 0x1C000>;

Lowercase hex.

> +      interrupt-parent =3D <&plic>;
> +      interrupts =3D <180>, <179>, <178>;
> +      interrupt-names =3D "hart-1", "hart-2", "hart-3";
> +      #mbox-cells =3D <1>;
> +    };
> --=20
> 2.34.1
>=20

