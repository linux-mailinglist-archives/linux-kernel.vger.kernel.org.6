Return-Path: <linux-kernel+bounces-273443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CE0946956
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 13:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DF581F21925
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 11:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D48B136338;
	Sat,  3 Aug 2024 11:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eOq/IScy"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF12A13699B
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 11:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722682837; cv=none; b=NwN9LADCLT21OFSZb7cUEorTIqUzJjybCn86PW/IyZ3uRlPX+gfh8QTth7QKZ/aQVAETp8xPQVLuH/ZLfD7wykAcBxsll2jt9ZV6vH97GxT3oHgYEuowWYAd1yPhZvonTe+dHuMRw5YDMjJCg7DHL4KohXBVC8q8maU3eXJrWrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722682837; c=relaxed/simple;
	bh=MFgOs2G+h0wMmI4NbkwqSfooXFKz5XyVkrg1+abZ0kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCx9xyAw1D5K6IqHwd/kykBRWEfLGngWlTtDPA5I5JvMyGRSygpn6HABOAJRUz2NEow3LVG1EtKzhf7Cl8IJkzzt1NcqrEqwZPsN3dVObsN1l0z6yO1GQ2bs0E5q7TlqrUJdg4rXcpCCt++NSvVHqIWupqjPjQ0ElVLvMrIrQaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eOq/IScy; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ef32fea28dso103599721fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2024 04:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722682833; x=1723287633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nNGT5r4BR2JSxtr0hpWaFKlHFXjUN1Qi2sHmX20c4mY=;
        b=eOq/IScyQR9GLi+NWi+xJS64O8vCJED2GaFqC+WCHy5xx8lk5WPCHWjqmstJO7C/O2
         FD7sUVZKZY3pYE1kIvvHpUimeVB+JAlTZzmGQVedBnMFjI6BlIG8N6z7rWS1s0sghU2S
         ocO+1J8MvncI9Ej0ygxAoKHW6IvCjGkTox3Imp+UI9apIDhH8ejoiqIuypS9jvShBseh
         bOyk2LvVXOeLAhZG4lrxf0QaeMLiP2/WYB3lr9uGyBpg9TEFsAHSakFOsxjTDZ3PGJ23
         Rmw8uWUy4rwf8hVUNR1Teh5uMTLhNQp5su4dguFzYAvo/7yYfE2MHGm62/L/FIKDBTY5
         yOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722682833; x=1723287633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNGT5r4BR2JSxtr0hpWaFKlHFXjUN1Qi2sHmX20c4mY=;
        b=v6Qj/aUoMybhmcxCTNfhDB+2v3k9OnRJXMmQSQFbJkMbnGl0kbLi9sV1FxXj7/2zYW
         YWIqOqr7uLISgMhv/eGrRQyCZrAOYRJ4fQgIbHbjbUhEw14/iEBQTgxPly4rfMdqpOCw
         6UlwL0XOYYTEmRnJHrFBWA5n0Vu7g0ohQwX+UYWw5ww0P/zFyh+TXTaVdJMfsJ+1qWvA
         CCWnu9Ytj8Tt77Y1vt4dEJxK5VtcYtsgduv4DGQpqmTRY4CYsvZ1ooMxZX/exBByV5GI
         /04jfijN2ZyHsX6QBYwnMwhRguf3xGptsCHorYtVCSAj8P4hYK+7lh/RgqxX/3VH1ceE
         TLTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXo8ocmasbBl8ywsaDFiPpDwFYDX/wyjUYrEXqubO0PhrN9xgn3q1R4gqv/b6i5ZvKcoTyeW52791LiUS0XZxNYAQ/8Skzm4HIPwW03
X-Gm-Message-State: AOJu0YxCuQh2LMAFFX3NLVvo6N4qHzqOPigRXRMs2SelyIHQwmdSPOYL
	wN2nRKEkSMXeldu5G8AD9r7CCN/EsBGP+OCq7RmEPTg+h98kHNebpDqr56DT880=
X-Google-Smtp-Source: AGHT+IGfVXpFlc9oFqW8lbiOI9PDtvzXyDErrPZE6WU7MV0jlGMNnbtS+ZF9QfuScaUolgfDoSnFQw==
X-Received: by 2002:a05:6512:ba7:b0:52b:c0b1:ab9e with SMTP id 2adb3069b0e04-530bb367101mr4034661e87.5.1722682832568;
        Sat, 03 Aug 2024 04:00:32 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba4a512sm469093e87.300.2024.08.03.04.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 04:00:32 -0700 (PDT)
Date: Sat, 3 Aug 2024 14:00:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	cros-qcom-dts-watchers@chromium.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	andersson@kernel.org, quic_vbadigan@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 1/8] dt-bindings: PCI: Add binding for qps615
Message-ID: <pku3ayi76246jmixuqdylkuqpb3k5z3ykn4hj2rjvcrhqrj3hb@yig6as3cph6p>
References: <20240803-qps615-v2-0-9560b7c71369@quicinc.com>
 <20240803-qps615-v2-1-9560b7c71369@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240803-qps615-v2-1-9560b7c71369@quicinc.com>

On Sat, Aug 03, 2024 at 08:52:47AM GMT, Krishna chaitanya chundru wrote:
> Add binding describing the Qualcomm PCIe switch, QPS615,
> which provides Ethernet MAC integrated to the 3rd downstream port
> and two downstream PCIe ports.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  .../devicetree/bindings/pci/qcom,qps615.yaml       | 191 +++++++++++++++++++++
>  1 file changed, 191 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,qps615.yaml b/Documentation/devicetree/bindings/pci/qcom,qps615.yaml
> new file mode 100644
> index 000000000000..ea0c953ee56f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/qcom,qps615.yaml
> @@ -0,0 +1,191 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/qcom,qps615.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm QPS615 PCIe switch
> +
> +maintainers:
> +  - Krishna chaitanya chundru <quic_krichai@quicinc.com>
> +
> +description: |
> +  Qualcomm QPS615 PCIe switch has one upstream and three downstream
> +  ports. The 3rd downstream port has integrated endpoint device of
> +  Ethernet MAC. Other two downstream ports are supposed to connect
> +  to external device.
> +
> +  The QPS615 PCIe switch can be configured through I2C interface before
> +  PCIe link is established to change FTS, ASPM related entry delays,
> +  tx amplitude etc for better power efficiency and functionality.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - pci1179,0623
> +
> +  reg:
> +    maxItems: 1
> +
> +  qcom,qps615-controller:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Reference to the I2C client used to do configure qps615
> +
> +  vdd18-supply: true
> +
> +  vdd09-supply: true
> +
> +  vddc-supply: true
> +
> +  vddio1-supply: true
> +
> +  vddio2-supply: true
> +
> +  vddio18-supply: true
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO controlling the RESX# pin.
> +
> +  qps615,axi-clk-freq-hz:
> +    description:
> +      AXI clock which internal bus of the switch.

Is it a clock or clock rate?

> +
> +  qcom,l0s-entry-delay-ns:
> +    description: Aspm l0s entry delay in nanoseconds.

I'd say, from the property name it is obvious that it comes in
nanoseconds.

> +
> +  qcom,l1-entry-delay-ns:
> +    description: Aspm l1 entry delay in nanoseconds.
> +
> +  qcom,tx-amplitude-millivolt:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Change Tx Margin setting for low power consumption.
> +
> +  qcom,no-dfe:
> +    type: boolean
> +    description: Disables DFE (Decision Feedback Equalizer).
> +
> +  qcom,nfts:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    description:
> +      Fast Training Sequence (FTS) is the mechanism that
> +      is used for bit and Symbol lock.

Doesn't help to understand what it is and what the value means.

> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: pci1179,0623
> +      required:
> +        - compatible
> +    then:
> +      required:
> +        - vdd18-supply
> +        - vdd09-supply
> +        - vddc-supply
> +        - vddio1-supply
> +        - vddio2-supply
> +        - vddio18-supply
> +        - qcom,qps615-controller
> +        - reset-gpios
> +
> +patternProperties:
> +  "@1?[0-9a-f](,[0-7])?$":
> +    type: object
> +    $ref: qcom,qps615.yaml#
> +    additionalProperties: true
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    pcie {
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +
> +        pcie@0 {
> +            device_type = "pci";
> +            reg = <0x0 0x0 0x0 0x0 0x0>;
> +
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            ranges;
> +
> +            pcie@0,0 {
> +                compatible = "pci1179,0623";
> +                reg = <0x10000 0x0 0x0 0x0 0x0>;
> +                device_type = "pci";
> +                #address-cells = <3>;
> +                #size-cells = <2>;
> +                ranges;
> +
> +                qcom,qps615-controller = <&qps615_controller>;

Where is the corresponding device?

> +
> +                vdd18-supply = <&vdd>;
> +                vdd09-supply = <&vdd>;
> +                vddc-supply = <&vdd>;
> +                vddio1-supply = <&vdd>;
> +                vddio2-supply = <&vdd>;
> +                vddio18-supply = <&vdd>;
> +
> +                reset-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
> +
> +                pcie@1,0 {
> +                    reg = <0x20800 0x0 0x0 0x0 0x0>;
> +                    #address-cells = <3>;
> +                    #size-cells = <2>;
> +                    device_type = "pci";
> +                    ranges;
> +
> +                    qcom,no-dfe;
> +                };
> +
> +                pcie@2,0 {
> +                    reg = <0x21000 0x0 0x0 0x0 0x0>;
> +                    #address-cells = <3>;
> +                    #size-cells = <2>;
> +                    device_type = "pci";
> +                    ranges;
> +
> +                    qcom,nfts = /bits/ 8 <10>;
> +                };
> +
> +                pcie@3,0 {
> +                    reg = <0x21800 0x0 0x0 0x0 0x0>;
> +                    #address-cells = <3>;
> +                    #size-cells = <2>;
> +                    device_type = "pci";
> +                    ranges;
> +
> +                    qcom,tx-amplitude-millivolt = <10>;
> +
> +                         pcie@0,0 {

Wrong indentation.

> +                              reg = <0x40000 0x0 0x0 0x0 0x0>;
> +                              #address-cells = <3>;
> +                              #size-cells = <2>;
> +                              device_type = "pci";
> +                              ranges;
> +
> +                              qcom,l1-entry-delay-ns = <10>;
> +                         };
> +
> +                         pcie@0,1 {
> +                              reg = <0x40100 0x0 0x0 0x0 0x0>;
> +                              #address-cells = <3>;
> +                              #size-cells = <2>;
> +                              device_type = "pci";
> +                              ranges;
> +
> +                              qcom,l0s-entry-delay-ns = <10>;
> +                         };
> +                };
> +            };
> +        };
> +    };
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

