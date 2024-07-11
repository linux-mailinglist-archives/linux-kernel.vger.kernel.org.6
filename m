Return-Path: <linux-kernel+bounces-249244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 239CC92E8C9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D309E281A3B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E9116DC27;
	Thu, 11 Jul 2024 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfGTR2c0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161B21649C6;
	Thu, 11 Jul 2024 13:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720702892; cv=none; b=NioTWPW9Z346Yl6Mm3a638s00Bnz4PplQ3ElFq2Ctkol8vzoFPO8siIuVHgzlfuxwcfUkQnvsZvQaaZ7e7w8lPb/RzvdoFu+O+eH37ax81lZ9271lztHCjE19WF3KyMGTE9xFHL7KoojiYkD/BmghHfdHnpybqCLRjW9aYHPpuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720702892; c=relaxed/simple;
	bh=uOUBrc14CXQROg0GmbJ1hvQ4vG6llgBZHgjoFUnDoIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DYMS/6FaGuKSZD1IShmHLzIUMbN/CgArc2y3GlREGk4cmUrFZL2LijDIT9rw2lf9Wf01SmDdalbgqG6PFl2oPCe4oKKzyQDSLsVyqU83nVFLiZ9E9ElnWBdkT2Lz/W4RFhXFX2lihoLQTSxSMW5cmsJ+2DIW6+51tqKqEUz4EZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfGTR2c0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD038C4AF14;
	Thu, 11 Jul 2024 13:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720702891;
	bh=uOUBrc14CXQROg0GmbJ1hvQ4vG6llgBZHgjoFUnDoIc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UfGTR2c0mb//LCl3P2O7CNxYS1jq+meVCxiysI/c4yHoxBpImL0G4Zc1lDs1aEKtu
	 ayTJUZxhDgzWxfLnK0K0CoXJBFo1t4yhC03lX7V7mhWyqhPn30XvwruWZYj1aVIO2t
	 Jj4QoAcDScH7LPYEhmyF9mD+hluVDCvmw5JF2OxE8Q3n3Z4THl6V5MhoUJAi0dWggL
	 s+qAhMBCd4dIiHyoTBQlqfXACicIu9bDDeT5ngTxrItTlaMNOVpi+3YqN8V5zibydW
	 oiiur5BzW+l3thUSd3proM6atufNgYcmwEad1olycZlUiM9bJH8kc+L3s/9p5htPbL
	 S+qn2fHqXAw6g==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52ea5dc3c79so1224466e87.1;
        Thu, 11 Jul 2024 06:01:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUxia98FvhooGmZAo9PIcd+wDxSR+R3Tl/+dowccy95LHTMgZfh75zcjG9FUn+SDjZTFeQfmhSmGmLHPpESj7edsNQ4yPlfUIkmBpiSmPmgBs/Z4Sc38xtnB27f5C/3Nf09TMs+P6V3PQ==
X-Gm-Message-State: AOJu0Yy5yK4Bf+y0QYnEPKC8FCc8hERjH+P1JNedjvuTaiXy11te3+pf
	d7IppgYUdEdCIAjY/zSw4BX9VtZpP+Cc4QqAME/41nRiREY9Zho+xgvwymsSL0JnuAF0ySRKgiW
	RB0ZR70IiKmh3QnWHP3u2OEZ1iA==
X-Google-Smtp-Source: AGHT+IFn0UuPbLvZfuVkRjfz8hCTYlGIAhdqofeNdcUZdjAmcJ5XNVj6CqaiTspw90VZm4f4AaYPBn/93x7fwhljHWI=
X-Received: by 2002:a05:6512:3e19:b0:52c:e17c:3753 with SMTP id
 2adb3069b0e04-52eb9991919mr6197731e87.5.1720702889933; Thu, 11 Jul 2024
 06:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711085930.26252-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240711085930.26252-1-krzysztof.kozlowski@linaro.org>
From: Rob Herring <robh@kernel.org>
Date: Thu, 11 Jul 2024 07:01:15 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+WdctoTMNoakiY5kh4nDoNx5h522s76LoHyD_yKYvvSg@mail.gmail.com>
Message-ID: <CAL_Jsq+WdctoTMNoakiY5kh4nDoNx5h522s76LoHyD_yKYvvSg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: incomplete-devices: document devices
 without bindings
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>, 
	Jonathan Cameron <jic23@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 2:59=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> There are devices in the wild with non-updatable firmware coming with
> ACPI tables with rejected compatibles, e.g. "ltr,ltrf216a".  Linux
> kernel still supports this device via ACPI PRP0001, however the
> compatible was never accepted to bindings.
>
> There are also several early PowerPC or SPARC platforms using
> compatibles for their OpenFirmware, but without in-tree DTS.  Often the
> compatible is not correct in terms of Devicetree specification,
> e.g. missing vendor prefix.
>
> Finally there are also Linux-specific tools and test code with
> compatibles.
>
> Add a schema covering above cases purely to satisfy the DT schema and
> scripts/checkpatch.pl checks for undocumented compatibles.  For
> ltr,ltrf216a this also documents the consensus: compatible is allowed
> only via ACPI PRP0001, but not bindings.
>
> Link: https://lore.kernel.org/all/20240705095047.90558-1-marex@denx.de/
> Link: https://lore.kernel.org/lkml/20220731173446.7400bfa8@jic23-huawei/T=
/#me55be502302d70424a85368c2645c89f860b7b40
> Cc: Marek Vasut <marex@denx.de>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Changes in v2:
> 1. Rename to incomplete-devices.yaml
> 2. Add many compatibles based on Rob's feedback, rewrite descriptions in
>    the schema.
> ---
>  .../bindings/incomplete-devices.yaml          | 139 ++++++++++++++++++
>  1 file changed, 139 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/incomplete-devices.=
yaml
>
> diff --git a/Documentation/devicetree/bindings/incomplete-devices.yaml b/=
Documentation/devicetree/bindings/incomplete-devices.yaml
> new file mode 100644
> index 000000000000..d690d44560fd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/incomplete-devices.yaml
> @@ -0,0 +1,139 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/incomplete-devices.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rejected or Incomplete Devices
> +
> +maintainers:
> +  - Rob Herring <robh@kernel.org>
> +
> +description:
> +  Some devices will not or should not get a proper Devicetree bindings, =
but
> +  their compatibles are present in Linux drivers for various reasons.
> +
> +  Examples are devices using ACPI PRP0001 with non-updatable firmware/AC=
PI
> +  tables or old PowerPC platforms without in-tree DTS.
> +
> +  Following list of devices is an incomplete schema with a goal to pass =
DT schema
> +  checks on undocumented compatibles but also reject any DTS file using =
such
> +  un-approved compatible.
> +
> +  Usage of any of following compatibles is not allowed in Devicetree sou=
rces,
> +  even if they come from immutable firmware.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description:
> +          Rejected compatibles in Devicetree, but used in ACPI-based dev=
ices
> +          with non-updatable firmware/ACPI tables (via ACPI PRP0001)
> +        enum:
> +          - broadcom,bcm5241
> +          - ltr,ltrf216a
> +
> +      - description: Incorrect compatibles used on Macintosh devices

They were correct at the time. Rules/standards evolve though. I would
just say 'Legacy" rather than "Incorrect".

> +        enum:
> +          - adm1030
> +          - bmac+
> +          - heathrow-media-bay
> +          - keylargo-media-bay
> +          - lm87cimt
> +          - MAC,adm1030
> +          - MAC,ds1775
> +          - max6690
> +          - ohare-media-bay
> +          - ohare-swim3
> +          - smu-sat
> +          - swim3
> +
> +      - description: Incorrect compatibles used on other PowerPC devices
> +        enum:
> +          - 1682m-rng
> +          - IBM,lhca
> +          - IBM,lhea
> +          - IBM,lhea-ethernet

> +          - mpc5200b-fec-phy
> +          - mpc5200-serial
> +          - mpc5200-sram

Tell Grant he needs to document these. ;) JK

> +          - ohci-bigendian
> +          - ohci-le
> +          - ohci-littledian

Given the typo, I think we can just drop this one from the driver.

> +
> +      - description: Incorrect compatibles used on SPARC devices
> +        enum:
> +          - bq4802
> +          - ds1287
> +          - isa-m5819p
> +          - isa-m5823p
> +          - m5819
> +          - sab82532
> +          - SUNW,bbc-beep
> +          - SUNW,bbc-i2c
> +          - SUNW,CS4231
> +          - SUNW,ebus-pic16f747-env
> +          - SUNW,kt-cwq
> +          - SUNW,kt-mau
> +          - SUNW,n2-cwq
> +          - SUNW,n2-mau
> +          - SUNW,niusl
> +          - SUNW,smbus-beep
> +          - SUNW,sun4v-console
> +          - SUNW,sun4v-pci
> +          - SUNW,vf-cwq
> +          - SUNW,vf-mau
> +
> +      - description: Incomplete and incorrect compatibles for unknown de=
vices
> +        enum:
> +          - electra-cf
> +          - i2cpcf,8584
> +          - virtio,uml
> +
> +      - description: Linux kernel unit tests and sample code
> +        enum:
> +          - audio-graph-card2-custom-sample
> +          - compat1
> +          - compat2
> +          - compat3
> +          - linux,spi-loopback-test
> +          - mailbox-test
> +          - regulator-virtual-consumer
> +          - unittest-gpio
> +          - unittest-pci

We recently added "test" as a vendor prefix and don't complain if
"test,.*" compatible is not documented. It's on my todo to change
these. So I'd drop the unittest ones.

> +
> +      - description:
> +          Devices on MIPS platform, without any DTS users.  These are
> +          unlikely to get converted to DT schema.
> +        enum:
> +          - mti,ranchu
> +
> +      - description:
> +          Devices on PowerPC platform, without any DTS users.  These are
> +          unlikely to get converted to DT schema.
> +        enum:
> +          - fujitsu,coral
> +          - fujitsu,lime
> +          - fujitsu,MB86276
> +          - fujitsu,MB86277
> +          - fujitsu,MB86293
> +          - fujitsu,MB86294
> +          - fujitsu,mint
> +          - ibm,axon-msic
> +          - ibm,pmemory
> +          - ibm,pmemory-v2
> +          - ibm,power-rng
> +          - ibm,ppc4xx-spi
> +          - ibm,sdram-4xx-ddr2
> +          - ibm,secureboot
> +          - ibm,secureboot-v1
> +          - ibm,secureboot-v2
> +          - ibm,secvar-backend
> +          - sgy,gpio-halt
> +          - wrs,epld-localbus
> +
> +required:
> +  - compatible
> +  - broken-usage-of-incorrect-compatible
> +
> +additionalProperties: false
> --
> 2.43.0
>
>

