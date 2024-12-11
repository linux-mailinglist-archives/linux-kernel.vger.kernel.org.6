Return-Path: <linux-kernel+bounces-441741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA7A9ED354
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF592820CC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F561FECBD;
	Wed, 11 Dec 2024 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6uH2B+d"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5DF1FECBB;
	Wed, 11 Dec 2024 17:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733937839; cv=none; b=YYQd9c2O+xlAHDz/NP9HIA/kRGa9WGKhd0dUSJP9WWYAODx8GfrOwQf/RFZd/ZziCNFUsXtIoG2U4I10V24eU5keocOUQhlqDu5vtGxRI+nwQU/slbmUsYRlsU4ZmaxMDyBexEUkHs1Sozr/Oyp7sXPtMZC0Koa4k1dD8OzapW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733937839; c=relaxed/simple;
	bh=r+0SQ5DaZWtMTNOBe4D9P1bu9mQ3k2WFITiTQexdaIk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LF2WtpykS/rlwznWKyBiXauuPR/K6xB+N4lIr0a+GzQG2gxWLis1jCfTcFdj62xZsxqeGG1AJZDu3XHSEYOX3bACcgQplN7qD4kGBUL61IZp53Nj7TSjzVnoAZMbfMmhA07pm+gWijQHlZEC9rcOOgc6VPPJHTEO0VQ5dgDFfkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6uH2B+d; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d3d479b1e6so6422828a12.2;
        Wed, 11 Dec 2024 09:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733937835; x=1734542635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xImzGzANXk5DxjlwcfseHJU01hxo/jjlwQJDD52qyl0=;
        b=j6uH2B+d3MsaSxXrOshm+yMd5bIBhzSYLFybK50AM8UEdLAwHaWpfDCTsYBD0xKZoA
         Eqvw744TH6JjOO405l2uCwMEFFUhYv7tWIk2pHX4A4hZQESRWc+dbasH8y6uBZMqxzY2
         286VeY0kn5/waYRD9n+ipcKqPHCe8uWlq+zZcq2g3pGvpaUbMHy38QXj3fT2iyJU4E4v
         KyK5b7DjS4v9mFOrntqwrYuGHLyCp15JJ/I1So4GhwyIagJHQuLQApZX71Ct/pkvRFzH
         95M1lpSVEoveygFRUTBLrrID4UPb/DAsiIhkBql8r2znaJwVKB7HWgGdedRTTikVnj4p
         5y3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733937835; x=1734542635;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xImzGzANXk5DxjlwcfseHJU01hxo/jjlwQJDD52qyl0=;
        b=nyV4Le8VxaSNkxQvq8G0nvfsWXDfLgHUF7Sktblr/SLhciMO+Fj0mVt1p6XZundsS9
         sbwv5bbKKp1S75l2DkF2oADacBS1KMtieChVU7VUCdLjy6hAnz7IIY+LXKJSNUNmRpja
         1zkV0qVA53g5mW8p7psWXyRGK5FG95CSn/KJH7ix+rar88T8bNQ/rEhd6JRQx6uSYGLQ
         QtVwuOHqWZKBhe1esDWuSc69ixhtvulGzghaEbybFi5TeLobceCf7Sztx4N+zoNKtDpq
         5mk0PL4PeH6kvQj7+e9Cwx006DwT49zgZkrxdHAoXRDUIBsdqohXnocfhKPLb9C3jAMF
         LJWg==
X-Forwarded-Encrypted: i=1; AJvYcCU++viNaA+00oLnTJpsfPcdYtT6QLxAu8ILREr2S6ro3QGv+LloYjD512d83pU42g3B3Ev+1XWD9RDlSG1j@vger.kernel.org, AJvYcCWXZl+WJTIsPVc/2BZKLtAW0ttwRP9Q9oojqcfvjpEFH4RevV8Oq6HHPIuHOinIopP5Sp0jM+396E2G@vger.kernel.org
X-Gm-Message-State: AOJu0YyS3TTYfdsJMutARZzMhlOqH9m2upfF/NWvWR5NWlHinH/4fAH+
	I2pC7G264PUwxVgpvFPMIk4uNtdV5GFxWMQxffoqejPm/SjUXs2j+s/kCety
X-Gm-Gg: ASbGnctrS8aJc90rKSntCNxL7QXnxeGt9U9N2bNBHnSrFGntgEFN5F2Fx1XuW7E6P7z
	L2l6ubQOcRk+4E7NN72WViOn5u1XOnfW9jd3LciDACbJtwp96EI7JwKGnQJeZBGncgUcHDmwakh
	VKCKdNqgGzgUUaguF4BlW7Tl5QxfzgGtOcQe6RGNDeYqntLg0qjnbCYu1hFsw3phTEkLPoABhU/
	/HBBfgF2Xw5o1WN2By4r5pBX7Wdd2h8LwxOsxwgDhnCcSJ8UZAgT+V3I80kAQmJ4/lXigY0UgVB
	GlHoUAavDmXqV67pPr8sEpNvsw+YfUVI
X-Google-Smtp-Source: AGHT+IH0RIu4uq5umvRtCi0hsAZI3eC3FhPsXctvlNPCuDi9NspA8MfTgjbIzEfgLbI6zohVlTLE5A==
X-Received: by 2002:a05:6402:5207:b0:5d0:c697:1f02 with SMTP id 4fb4d7f45d1cf-5d4330a49f1mr7965722a12.17.1733937835207;
        Wed, 11 Dec 2024 09:23:55 -0800 (PST)
Received: from [192.168.1.107] (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6a3537ea9sm285032666b.58.2024.12.11.09.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 09:23:54 -0800 (PST)
Message-ID: <f395a019-800f-49a4-a3cc-28efafc4faa9@gmail.com>
Date: Wed, 11 Dec 2024 19:23:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: power: actions,owl-sps: convert to YAML
Content-Language: en-US
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Andreas_F=C3=A4rber?=
 <afaerber@suse.de>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241103123917.2890436-1-ivo.ivanov.ivanov1@gmail.com>
In-Reply-To: <20241103123917.2890436-1-ivo.ivanov.ivanov1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/3/24 14:39, Ivaylo Ivanov wrote:
> Convert the Actions Semi Owl Smart Power System (SPS) bindings to DT
> schema.
>
> Changes during conversion:
>  - Add a description
>
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
> v2: add r-b tag from Krzysztof Kozlowski <krzk@kernel.org>
> v2: update commit message to be accurate (Krzysztof)
> v2: don't preserve formatting in the description (Krzysztof)
> v2: add a blank line after additionalProperties (Krzysztof)
> ---
>  .../bindings/power/actions,owl-sps.txt        | 21 --------
>  .../bindings/power/actions,owl-sps.yaml       | 51 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 52 insertions(+), 22 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/actions,owl-sps.txt
>  create mode 100644 Documentation/devicetree/bindings/power/actions,owl-sps.yaml
>
> diff --git a/Documentation/devicetree/bindings/power/actions,owl-sps.txt b/Documentation/devicetree/bindings/power/actions,owl-sps.txt

BUMP - what happened with the patch? Been a month now and
all the other ones have been applied.

Best regards, Ivo.

> deleted file mode 100644
> index a3571937b..000000000
> --- a/Documentation/devicetree/bindings/power/actions,owl-sps.txt
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -Actions Semi Owl Smart Power System (SPS)
> -
> -Required properties:
> -- compatible          :  "actions,s500-sps" for S500
> -                         "actions,s700-sps" for S700
> -                         "actions,s900-sps" for S900
> -- reg                 :  Offset and length of the register set for the device.
> -- #power-domain-cells :  Must be 1.
> -                         See macros in:
> -                          include/dt-bindings/power/owl-s500-powergate.h for S500
> -                          include/dt-bindings/power/owl-s700-powergate.h for S700
> -                          include/dt-bindings/power/owl-s900-powergate.h for S900
> -
> -
> -Example:
> -
> -		sps: power-controller@b01b0100 {
> -			compatible = "actions,s500-sps";
> -			reg = <0xb01b0100 0x100>;
> -			#power-domain-cells = <1>;
> -		};
> diff --git a/Documentation/devicetree/bindings/power/actions,owl-sps.yaml b/Documentation/devicetree/bindings/power/actions,owl-sps.yaml
> new file mode 100644
> index 000000000..0855d82f3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/actions,owl-sps.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/actions,owl-sps.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Actions Semi Owl Smart Power System (SPS)
> +
> +maintainers:
> +  - Andreas Färber <afaerber@suse.de>
> +
> +description:
> +  Actions Semi Owl SoCs feature a Smart Power System (SPS) that manages power
> +  domains to optimize power usage across various hardware blocks. Each power
> +  domain corresponds to a specific hardware block and is represented by a bit
> +  in the power control register and an acknowledgment bit, which is then
> +  translated into a corresponding voltage on a rail.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - actions,s500-sps
> +      - actions,s700-sps
> +      - actions,s900-sps
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#power-domain-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#power-domain-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/power/owl-s500-powergate.h>
> +    soc {
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      sps: power-controller@b01b0100 {
> +        compatible = "actions,s500-sps";
> +        reg = <0xb01b0100 0x100>;
> +        #power-domain-cells = <1>;
> +      };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 76ea65128..420d06d37 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2023,7 +2023,7 @@ F:	Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
>  F:	Documentation/devicetree/bindings/mmc/owl-mmc.yaml
>  F:	Documentation/devicetree/bindings/net/actions,owl-emac.yaml
>  F:	Documentation/devicetree/bindings/pinctrl/actions,*
> -F:	Documentation/devicetree/bindings/power/actions,owl-sps.txt
> +F:	Documentation/devicetree/bindings/power/actions,owl-sps.yaml
>  F:	Documentation/devicetree/bindings/timer/actions,owl-timer.yaml
>  F:	arch/arm/boot/dts/actions/
>  F:	arch/arm/mach-actions/


