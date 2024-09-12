Return-Path: <linux-kernel+bounces-327292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F7F97738E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 23:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 206AF283BA8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C791C2332;
	Thu, 12 Sep 2024 21:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="cMWdsA1K"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A1F18BB8A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 21:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726176230; cv=none; b=EAKoqTY2e0w1yC7KPkFrM7m5FzHaAd+RWO6f8ov3ZwDi4t4Tv0dLXhzn7fHOe8hgokNStE7FUII8caRBBiXdqa5EqPCkliz5ovNm3WVXhuzttOKnfU/r1aO0QMk0kOYeV2a2yR6wWe8q3EkFQ3Ztb9Wdb/f2ZdS7fTo6+IQg/7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726176230; c=relaxed/simple;
	bh=k7Aa77smeh+Klqcv5HZk8DhYqOhjrnHLWwk6+Zw9j8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G6pxI38hUf0RNpKHPD00wuYawF7UahM/HBO6ln0/ojU8gGAbN+ib44mM6pu/21gFP/Sx8GlqIfnBrWeCXU7ae1PbpP+4kY8fvKQoKDTHbzf2St1n8o/b21HoFMaxCaHwEsq3TOqPazPRQyQqF0XS2xlpYC+mFpQLvpfLXkoaTR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=cMWdsA1K; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-39d30f0f831so1449815ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1726176227; x=1726781027; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cRBGtOuc/d2snZdpwSiAnIV7rHRa11MPF2f8u+9dU+0=;
        b=cMWdsA1KCPDE7CS45Aw3pQx6snGbih8YnPJNM/ao37lhA198hYUoLXmjPHHlAlsUpf
         XDex3Ikl9dFKGohqd6Wytef3G6eGZI50xcDuWkDgeyy4QknHZ9MBWdariGtR4d2WZvGk
         8Ug6gtDSYd/3xgbjS0SDZlwc135iyHibJsAXRnZSL84uhQ4h7uG76g3Qk+mljz1Y3TBJ
         HJdhT+vRo9tKWy7lJUYcOKwtqiLMKbJkoVJdrmOu+XvXv3z7wF1HN+2LMe7LhEOB7M9M
         GdQxJpQBQKBfAdqvJDNnwFjf0rEX+A2AhM8N3qhquJedPn2dv3uRjojuMEXJzf6kiDOv
         uvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726176227; x=1726781027;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cRBGtOuc/d2snZdpwSiAnIV7rHRa11MPF2f8u+9dU+0=;
        b=eD00Zg6y04ZwvxtnFdcX5p7pwrD4fjaR+jCXyqbVuwCtTn1cU4n/ClvLWSfXuTPZuc
         SFvHErbpIrX50ZCNJA5l8/eZJryA21B/q6tRaSBoEkkrEjmlygQ8ii6fBrc3dkRgvePQ
         3IlR29XYsxAko4SSSWzd9ZU9qxgHCyD9LK4xd1b5IZFZCNE0KI5w+CKoNJvwgcIA74Iu
         ngqo+qqxU+Swt1adWG8gfh7KOYRS+zgI2mTsybyHXcgfiIhv/21BVYXtCTMR9F9eg7p8
         tH9vMs9uM0+wOM6AjKJug5lG8DbXnVYmP+KdVoIGL4yZagZ2DHBcx2/2yAubJB7BRs6u
         kWPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTQdQImzQ15/iGvsNfgnPBRQwdvrRehuLlUQhvCCRH0ahO4WoFwAqMyX5exvwYNNpgOQkbNmjqbR9Ca44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/g0W1kNyIsvEb4ojhPShoVZU6oi/fAgpv1Bf9iMMzIZgDJEcM
	ZPMsOojtB3DUVMk9Q6kfiBbLmuVZ8aLz+Cp+LXYPWJHvKSLRdOcVhjMOLEOlKFc=
X-Google-Smtp-Source: AGHT+IFaS4zkwnkNa1ce/QUNVKsECyunuGyCa52gZYcGRtm6HZ4hFf3rIXLzwBxv9bvQwEqPk/66pQ==
X-Received: by 2002:a05:6e02:1a81:b0:39d:637f:97bc with SMTP id e9e14a558f8ab-3a08b66273amr7178575ab.0.1726176227093;
        Thu, 12 Sep 2024 14:23:47 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d35f89137bsm814719173.104.2024.09.12.14.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 14:23:46 -0700 (PDT)
Message-ID: <b4acc0a7-b7da-4947-904d-8406aa5ba95b@sifive.com>
Date: Thu, 12 Sep 2024 16:23:44 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/5] dt-bindings: mailbox: add binding for Microchip
 IPC mailbox driver
To: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 peterlin@andestech.com, dminus@andestech.com, ycliang@andestech.com,
 jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 andersson@kernel.org, mathieu.poirier@linaro.org, conor+dt@kernel.org,
 conor.dooley@microchip.com
References: <20240912170025.455167-1-valentina.fernandezalanis@microchip.com>
 <20240912170025.455167-3-valentina.fernandezalanis@microchip.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20240912170025.455167-3-valentina.fernandezalanis@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Valentina,

On 2024-09-12 12:00 PM, Valentina Fernandez wrote:
> Add a dt-binding for the Microchip Inter-Processor Communication (IPC)
> mailbox controller.
> 
> Signed-off-by: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
> ---
>  .../bindings/mailbox/microchip,sbi-ipc.yaml   | 115 ++++++++++++++++++
>  1 file changed, 115 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/microchip,sbi-ipc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/microchip,sbi-ipc.yaml b/Documentation/devicetree/bindings/mailbox/microchip,sbi-ipc.yaml
> new file mode 100644
> index 000000000000..dc2cbd5eb28f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/microchip,sbi-ipc.yaml
> @@ -0,0 +1,115 @@
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
> +  This SBI interface is compatible with the Mi-V Inter-hart
> +  Communication (IHC) IP.
> +  The microchip,sbi-ipc compatible string is inteded for use by software
> +  running in supervisor privileged mode (s-mode). The SoC-specific
> +  compatibles are inteded for use by the SBI implementation in machine
> +  mode (m-mode).

There is a lot of conditional logic in this binding for how small it is. Would
it make sense to split this into two separate bindings? For example, with the
current binding microchip,ihc-chan-disabled-mask is allowed for the SBI
interface, but doesn't look like it belongs there.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,sbi-ipc
> +      - microchip,miv-ihc-rtl-v2
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
> +
> +  "#mbox-cells":
> +    description:
> +      For the SBI "device", the cell represents the global "logical" channel IDs.
> +      The meaning of channel IDs are platform firmware dependent. The
> +      SoC-specific compatibles are intended for use by the SBI implementation,
> +      rather than s-mode software. There the cell would represent the physical
> +      channel and do not vary depending on platform firmware.
> +    const: 1
> +
> +  microchip,ihc-chan-disabled-mask:
> +    description:
> +      Represents the enable/disable state of the bi-directional IHC channels
> +      within the MIV-IHC IP configuration. The mask is a 16-bit value, but only
> +      the first 15 bits are utilized.Each of the bits corresponds to
> +      one of the 15 IHC channels.
> +      A bit set to '1' indicates that the corresponding channel is disabled,
> +      and any read or write operations to that channel will return zero.
> +      A bit set to '0' indicates that the corresponding channel is enabled
> +      and will be accessible through its dedicated address range registers.
> +      The remaining bit of the 16-bit mask is reserved and should be ignored.
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
> +    else:
> +      required:
> +        - reg
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: microchip,miv-ihc-rtl-v2
> +    then:
> +      properties:
> +        interrupt-names:
> +          items:
> +            pattern: "^hart-[0-5]+$"

The driver in patch 3 uses this pattern for the SBI interface, so should it
apply there as well?

Regards,
Samuel

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
> +      microchip,ihc-chan-disabled-mask=  /bits/ 16 <0>;
> +      reg = <0x50000000 0x1C000>;
> +      interrupt-parent = <&plic>;
> +      interrupts = <180>, <179>, <178>;
> +      interrupt-names = "hart-1", "hart-2", "hart-3";
> +      #mbox-cells = <1>;
> +    };


