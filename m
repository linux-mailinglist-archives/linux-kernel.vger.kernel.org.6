Return-Path: <linux-kernel+bounces-187088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 645DD8CCCF7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6973F1C21BD0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 07:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA6713CA87;
	Thu, 23 May 2024 07:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Gw3UHFgn"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B3C3CF51;
	Thu, 23 May 2024 07:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716449064; cv=none; b=T/f00Rl37qWaLGKqBM5wNXqhhU4wrCUdPXD6kjuCxKlhK84fV0P8l/ekoHCmhrx14r+lRoLzULSybJtotx21PAPSgUIK9ZgIVfyt0Bxb/fAOxk89teFSV9NOmw8hdCM0MOlKhqJYovjgOg8lZgRXtT3OzGeHap4rqlb1nOB7vW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716449064; c=relaxed/simple;
	bh=quICu62D43k69goYAzJ786xXbgVdCuVtKje/qBcaq7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bZhNjvP6vwcNukDvXRBYcFCyvTowp5l5nUJzvRF4xPUKkUe3WtN5VAbLL8szCm8haziljNuVG2fa3en3flN0+/Wmq4mEnhLWmpfgdDC+IGZQlmLw2+oWOOStiGY5TmDoYjAOMb2yTPJyDcCljw947EAAS/Y8/y5yIQRXYQTTI5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Gw3UHFgn; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1716449045; x=1717053845; i=wahrenst@gmx.net;
	bh=3ewq43Fy7KxVWBn6uVYPi8Gd3oGUm4UZeASUASFFE7I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Gw3UHFgneGv5EdEHoD8RrdPrg9wcnaSx5LF5JDukXYmB0kKSd3HsyFgn9F/utbLP
	 K8RdXfMKa9WDQg3uXfevRM32ozHlQ1M2hpE8PRUqxTTHPUd65dAwffRkmCsZLALxD
	 jeo/my5/vcvLMqpEBdUsAkm4sTn9Bo0LwjnVbdKNGRaNFe03q8wOjlCCz8RG/0ClH
	 kHG3BYKBZWZHwxGYWLf1Rd63YfwGpo1TUwyejuQ5BZTIJKYlq9OMdFZc4F8mdTaxc
	 sUtg9EkpdatXl4hM0I60wvT3fqA/9xfhCaj/DEI0l9AK61BML0t5M4/OhX76hC+e1
	 VyNywiyvCIMgq/BPsg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.126] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOzOm-1rtTtB0zgy-00MOO0; Thu, 23
 May 2024 09:24:05 +0200
Message-ID: <be9cc413-6780-45f9-913c-056238be2451@gmx.net>
Date: Thu, 23 May 2024 09:24:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: soc: bcm: document brcm,bcm2711-avs-monitor
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240517125138.53441-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240517125138.53441-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lpEl9pH82QtZCaEEQBU+SlhJdTRsqw/TzdYu/1R7pCIxgvKQhDq
 ZtDqozaHVbGQE8lV7/iJCXhHV+l+ZOQrNfr5FmKBH5lGyGMssqhxVnEYsDfx+XeafnVeIvp
 5/0xWEog7gvflqIzFfKwufvmtDy8TdC9xsNb+d+jmy7OXL48VOR88Zk6JzeNcF20Lj/kHYH
 DZdcq+/aaaREJeR3yQD0Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FF5cBb4Tl4w=;a25RE8LFwJUsg79MzEK46cPjfe+
 6+HDs3EwkjhXECGycMIVClBLvAMkvqCXr3fm8IqEx5PVnlno5Rx09xOy0fKWQxcP6NaRfHZEa
 zpJBp8TexRA4s6vajGW4VxmlvvB15+KyJxhmy9/kt1F9TblcwwtYs40nsoG3BLHH+LBjmXO+C
 el8OWqAgrY1CseQ/OTq897TbJ2+pnzERtpVjPtF4nerjRCP9sJgKLlqrBbsZkGe5jhJbCZhda
 qrn3vjzqOFp/njbdIt/MmQArGRLIyWVkA/vMz20sRRS5aTYLITlB5eSXTqdt0xe+SCZwOFKU5
 g+dJlzSNmC7e6tq1EnPLBMYTNAA8pNhl+y8nU3UVv3At2713L8H/PHkkgwJ3mbMXoNuJbChFM
 dz2aw/cZ0uyAjNTHHqPXbHS4NzBBZqF1gzGbRmaNdb4TBSkEfO9Q1MqF1S96w12x6xxl5Vx0Z
 KETPVe6H8vZ6+P9ioCed0kFmpN5CEr9pql79H4ipAtjHHP0AQJVM7XXXphoNOr8JnXowD6UDN
 NruOq/E3U9sjo9K1sQw+O112Uky47vTS8uYGQhUVXe74mhHeYOhoM/2s2l/LCr/3TjzR3V6PY
 yrNnl1rZZxyrgeE/XObbaD2M/+yDhjv+pkjNICKI6Hyn0/knnOEeZHMyLjbH1aaYJiPaXt4TF
 qip1SwbBpfeMbYq0J7rL92rPBoQxdZsbjatrnUv8rQeLfhajpDGkTnqVViU9p1fLKjUPwS8MA
 FOxCfgl4wt1tqUu/q5b8kP6Eq1EOnhl91vdbnUTz/Lf9sc6xJ+MKFsBZSu/GKIgNVPCg16Sia
 w6uVPy3w0iJ4V9DFf/MmVaJeTBCL33HNKSS071vWWmvm8=

Hi,

Am 17.05.24 um 14:51 schrieb Krzysztof Kozlowski:
> Document alreasdy used binding for Syscon / AVS monitor:
s/alreasdy/already excepted of that: Reviewed-by: Stefan Wahren
<wahrenst@gmx.net> Thanks
> brcm,bcm2711-avs-monitor to fix dt_binding_check and dtbs_check warnings
> like:
>
>    brcm,avs-ro-thermal.example.dtb: /example-0/avs-monitor@7d5d2000: fai=
led to match any schema with compatible: ['brcm,bcm2711-avs-monitor', 'sys=
con', 'simple-mfd']
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../soc/bcm/brcm,bcm2711-avs-monitor.yaml     | 44 +++++++++++++++++++
>   1 file changed, 44 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2=
711-avs-monitor.yaml
>
> diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2711-avs-=
monitor.yaml b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2711-avs-=
monitor.yaml
> new file mode 100644
> index 000000000000..e02d9d7e7d9a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2711-avs-monitor=
yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/bcm/brcm,bcm2711-avs-monitor.yam=
l#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom AVS Monitor
> +
> +maintainers:
> +  - Stefan Wahren <wahrenst@gmx.net>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: brcm,bcm2711-avs-monitor
> +      - const: syscon
> +      - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  thermal:
> +    $ref: /schemas/thermal/brcm,avs-ro-thermal.yaml
> +    description: Broadcom AVS ring oscillator thermal
> +
> +required:
> +  - compatible
> +  - reg
> +  - thermal
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    avs-monitor@7d5d2000 {
> +        compatible =3D "brcm,bcm2711-avs-monitor", "syscon", "simple-mf=
d";
> +        reg =3D <0x7d5d2000 0xf00>;
> +
> +        thermal: thermal {
> +            compatible =3D "brcm,bcm2711-thermal";
> +            #thermal-sensor-cells =3D <0>;
> +        };
> +    };
> +...


