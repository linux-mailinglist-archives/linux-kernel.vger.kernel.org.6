Return-Path: <linux-kernel+bounces-433224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82E09E5550
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84623286CFB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9813121858D;
	Thu,  5 Dec 2024 12:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UNQZ7pCj"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9E21C3C03
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 12:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733401488; cv=none; b=Jh9fVSR41xIeuWJwe7tu38tz/herPfROtqwIqE7lFGKm1SdxrTiRLt1a86VNos7VEFernFNVByh8yL//73avrEYZPp1w78/OxGAi+Q7lNRNGo88/6BOuVj5OojGv2guo5nG/MUte3U1meOVJNeCCCNG9kf1MoUwLihLt5LGojoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733401488; c=relaxed/simple;
	bh=qkqNRYAejTKgGZLM9SrdmLNOwjcL6JMSXw1ILpXD17c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9omo4j1IgsZ93Fd6MVHr/yQcHNPqEXnWXrubue5/nSUIaUbU3d+jQwjLL+KV6LwBoJ23DRekThRzF/wxzzVHCIblZUwGEDuBY8QlL0kpym7m/Con6/GdhTKPFb3dBUS3EEE+MzGMdQryzNcSAdzwWPIzz7ZiBVYezvAXj6zdeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UNQZ7pCj; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ffc81cee68so6245761fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 04:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733401485; x=1734006285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dYReieGTQt3l1nUrvWhpt/c0KveQuNyocwyNLg51+v0=;
        b=UNQZ7pCjnkpKQYKK5Y00dZp5mbwKEWs/hZLT3H3zrBQg2G8IA42EHS5zurwmagVe7o
         EIuHdX9Zqti9Eo0Sj0C+h9+7VjdzKeTk9pvnvaEWDrzHsFUJyeESdZscB/DZOy/fURel
         1s8tXuBLS41zltU0JEg0Ql8aG/KqL5xUJqBQSW0+AoYJvH3GtSyB1GEURRkgiG4JVFLf
         Xdx/r7EmgRDKkJFh19ZB3yXGXWg7qqPiJs268qs7vKh4xNIH1t1sQsEm6yg33ppVcKD/
         kXAPaoMWwZd8vXGNbnET/WAMwonz92GJQE+EPOfUtaDVHk7ev96A5aqRWGWGmHi48dI/
         8KOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733401485; x=1734006285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYReieGTQt3l1nUrvWhpt/c0KveQuNyocwyNLg51+v0=;
        b=fqqbRZudeDGMIxmOw+SJnG8OMQFfBIGVQuXkNV7idoGKmi+zWGDW1jJjzQhBvT2Lsz
         4AXB/0BReApQZT/gi4sMq5EoiAVVZqFj+S8fslBzBkKuLWiyxjl/gMQOOBKCrLMZktV4
         3fLXpeRbOy/h9PdvXSJ4G0hJTV6k5e3dSHQqrxeXa6G+aUdJFozwFKiV0E20OfoX//Ts
         ZtvHySIHYerFgXg5nvghfRKkY6KA0KNSUEHJR0v7Q61B9NrZJF1BY44JXqKecoC7caj8
         vmb53tixZQojThSNGaE3ZeaVuVmWMh8FSYQXrR3Nx4bKD8+vzTomeEc5Kl1ODa3dSf8L
         XzXA==
X-Forwarded-Encrypted: i=1; AJvYcCV4Nm5HeGR7+t4e35PhUHRlvsK5C2YTt/U3Sns4AKvO8NhcZ9qUaA7xckXwtZSv4blawLVzFsDliE1b7tg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0kYuvC3qtVJ3vAaNL99ykj8wNXprNkWttIbq+ndlH3oVTCsA1
	yK8Bhot52NzPBiaIqzKdCvGvp35MVO1ZLbt2Nr9pEG6Zd27s1K+JTpyutUyoJVQGxAIypWxzbYB
	M
X-Gm-Gg: ASbGncsmYFJh9gHQmiAhgttw3kRYBx6V8M5DmW74f3+F4nMHkgAyKyNVr2qyWfYMXnj
	2nrudAu+jww1DwilKiirLmMKHN3Q8xUZ5miSoeEDksItEKjEyLDe5QZ6xxxy1a0dWETfJonAUCI
	O25IlAUSntcjkuuiGoauENvhLOY2CHPc1MfX2oyr98DkSW0uORepG/EoJc4gAKp9hSyI3bPMNmN
	P05KKuksibFLdg6l4iuAsRYALGDwhMuaTxQpdZJLVX48F2p0nXceNnOFqdXC3Im3lRzmZqi/oCn
	dxeUfFde1rw+xdV3rYpVPiSHv+ObAA==
X-Google-Smtp-Source: AGHT+IGPbrvsb6W4cgWiuwY1v2qElO/w0kM9l6PDiFSrYRDQlNxLDTp9Gz1GUpkNHkGt+SKJ1/VEiA==
X-Received: by 2002:a05:651c:b1f:b0:2ff:ef38:6d66 with SMTP id 38308e7fff4ca-30009c0cac3mr58636301fa.2.1733401484881;
        Thu, 05 Dec 2024 04:24:44 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020e209c5sm2040271fa.93.2024.12.05.04.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 04:24:43 -0800 (PST)
Date: Thu, 5 Dec 2024 14:24:41 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sricharan R <quic_srichara@quicinc.com>
Cc: jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] dt-bindings: mailbox: qcom: Document
 qcom,tmelite-qmp
Message-ID: <h5franuhsumreqz2l6l2lq3lyfzqtzjvz5py6q3smuds46j7rr@kcexrs5qn4be>
References: <20241205080633.2623142-1-quic_srichara@quicinc.com>
 <20241205080633.2623142-2-quic_srichara@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205080633.2623142-2-quic_srichara@quicinc.com>

On Thu, Dec 05, 2024 at 01:36:32PM +0530, Sricharan R wrote:
> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> 
> This binding describes the component responsible for communication
> between the TME-L server based subsystems (Q6) and the TME-L client

This should start by explaining what is TME-L.

> (APPSS/BTSS/AUDIOSS), used for security services like secure image
> authentication, enable/disable efuses, crypto services. Each client
> in the   SoC has its own block of message RAM and IRQ for communication
> with the TME-L SS. The protocol used to communicate in the message RAM
> is known as Qualcomm Messaging Protocol (QMP).
> 
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>  .../bindings/mailbox/qcom,tmelite-qmp.yaml    | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/qcom,tmelite-qmp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/qcom,tmelite-qmp.yaml b/Documentation/devicetree/bindings/mailbox/qcom,tmelite-qmp.yaml
> new file mode 100644
> index 000000000000..1f2b3e02b894
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/qcom,tmelite-qmp.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/qcom,tmelite-qmp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm TMELITE IPCC channel

So, TME-L or TMELITE or TME-LITE?

> +
> +maintainers:
> +  - Sricharan Ramabadhran <quic_srichara@quicinc.com>
> +
> +description:
> +  This binding describes the component responsible for communication

It's already a description of the binding, no need to repeat the obvious.

> +  between the TME-L server based subsystems (Q6) and the TME-L client
> +  (APPSS/BTSS/AUDIOSS), used for security services like secure image
> +  authentication, enable/disable efuses, crypto services. Each client
> +  in the   SoC has its own block of message RAM and IRQ for communication
> +  with the TME-L SS. The protocol used to communicate in the message RAM
> +  is known as Qualcomm Messaging Protocol (QMP).
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - qcom,ipq5424-tmelite-qmp
> +      - const: qcom,tmelite-qmp
> +
> +  reg:
> +    maxItems: 1
> +    description:
> +      The base address and size of the message RAM for this client's
> +      communication with the TMELITE core
> +
> +  interrupts:
> +    maxItems: 1
> +    description:
> +      Should specify the TMELITE message IRQ for this client

Just should? This is a very relaxed constraint. Just "the message IRQ
for the client" sounds better.

> +
> +  mboxes:
> +    maxItems: 1
> +    description:
> +      Reference to the mailbox representing the outgoing doorbell in APCS for
> +      this client, as described in mailbox/mailbox.txt
> +
> +  "#mbox-cells":
> +    const: 2
> +    description:
> +      The first cell is the client-id, and the second cell is the signal-id.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - mboxes
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    tmel_qmp: qmp@32090000 {
> +           compatible = "qcom,ipq5424-tmelite-qmp", "qcom,tmelite-qmp";
> +           reg = <0x32090000 0x2000>;
> +           interrupts = <GIC_SPI 126 IRQ_TYPE_EDGE_RISING>;
> +           mboxes = <&apcs_glb 20>;
> +           #mbox-cells = <2>;
> +    };
> +
> +...
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

