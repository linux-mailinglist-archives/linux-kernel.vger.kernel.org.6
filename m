Return-Path: <linux-kernel+bounces-253588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DA1932374
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C74D1C209A7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98DD198857;
	Tue, 16 Jul 2024 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tjwpr15a"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B28C197A6E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 09:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721123759; cv=none; b=XJV9+cRe3KrI2Sl3oxtkmsMER9P8CsVNELJ1Ppb7BvtMqFKZv4PPZfIz50oVGjM+Nbj8FlDrvl+28SyscF+WMPvG2t1gNBzSViAhrJcxGXhpMxhEV3PJZtbzE1LBxvnO8Pf2x6zQaics2R3ZEYXg6dT6Q8ovaMxflxKQt70oGyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721123759; c=relaxed/simple;
	bh=IKDf3UkdBuH38DCvAMMD13kRXL5GatuQLI8hucyLu1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qNNTswx6fR/Y9n2B6gC9a4eiftBPLsH+C09alfBKlqFCpNp/3segmJCKdbi+zc0VWIl6U02Kpuro+UoIYrZ0lSvS2zkMqhIzWYB409Ljpe7MQUp2x5LTbejRR9yT8LZejDknDmyYCclNjwuTlDa9esOJ0cJgbeLkq+UEY5cDxyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tjwpr15a; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-367ab50a07aso3337414f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 02:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721123755; x=1721728555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G/olg4pPYowonDS6iIauF1CvyhTPcwwFOxr3z5IbHdQ=;
        b=Tjwpr15aqA/BPW5EsRRH1WyLWFVW3t1BaebucYxjqNgKHS9oan1m53JtjgbE9u65I8
         D8VESrgKYfxATFEngmUH3xyPCOKHm9DgmyK4yi5z7kCE2dKlXSlhC/u/yJNfFSyWSelv
         72kLaODb4+yhNoDIQLqDSNgfpZSqgrwlBu+5ED2weyapFkSG2/w3vJN7UjYyQ7Xks1Fj
         nRcCG9igAIYWOzGY04OpPF4R0gY4Gly72rH4z1IwGjJFX8wedK5xuA6NRoXkWKfllIbO
         MRZJMZkXfzQ/aT+M5ptbyUiwk76Eb5MtaC3L0TYUqmYwOTy/1v7ZNEvi+BFcrP/Ysqqi
         LSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721123755; x=1721728555;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G/olg4pPYowonDS6iIauF1CvyhTPcwwFOxr3z5IbHdQ=;
        b=exhkX/hC/5/rw3kMUEyC9slOpaoyBLxynAN3IYsYtkdX1/qb68pyoHLFgBwDQbTjCg
         C89Xi3MtqUiHjMt+6V6dZLz+pKe9xH71WPYfkjPFT+dMchIIYtGONEYBGAqrkA/UYDSc
         xVzqrMNcj+TD8UZ9APVyQOq94niHYQOHTO6myQm8fHN04Z1Qg0bOpNXX/gEQI3doUUa/
         6hb0y4KkYvCrs6P+sXZoQJTK8Ax4PKSArwpvMhX4Z+YerzLViomM4wArh/j9uMmU2yRp
         e1lejw2+Uee2UsSZuR7BTGfF4H51JBxR6Pv1Vd8VGUr9CBcYMLzPENlJK0V7BxvNWFom
         ho1w==
X-Forwarded-Encrypted: i=1; AJvYcCXVgYWHsnmFpr4tDMLppb83BHtBskM/zeHNmX+UlIUb0Xs6Prmcc/r2Josd0pPJi+fJZurWskwMDaiHq9poZIg2BPeLFRRO0SlpJBBf
X-Gm-Message-State: AOJu0YzYZ5Z7RkOyj1hObAy6E0RygVTG5dpUTWVIWCBfwoM3hhNHW70J
	mAK0nU4wRVyz8tq9nrL+tuzSjJDOokTozskqlnZ0NOu4SnrdpyVsyJM0g96X8K4=
X-Google-Smtp-Source: AGHT+IECqv+IwV2EF4YBefvX50x3d6wJMth6y3D794pvAsND2gF8a9+T8Ehd1tNE3M+gP+6dLAKEDg==
X-Received: by 2002:a5d:5f4d:0:b0:367:991d:8b76 with SMTP id ffacd0b85a97d-3682609e9a7mr1188873f8f.15.1721123755574;
        Tue, 16 Jul 2024 02:55:55 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafbf29sm8570878f8f.70.2024.07.16.02.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 02:55:55 -0700 (PDT)
Message-ID: <60b0de98-e3c9-467b-98fb-ba7da7208be8@linaro.org>
Date: Tue, 16 Jul 2024 11:55:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: net: wireless: add ath12k pcie bindings
To: Patrick Wildt <patrick@blueri.se>, Kalle Valo <kvalo@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Andy Gross <agross@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Steev Klimaszewski <steev@kali.org>, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Johan Hovold <johan+linaro@kernel.org>
References: <ZpV6o8JUJWg9lZFE@windev.fritz.box>
 <ZpV7B9uGVpeTSCzp@windev.fritz.box>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZpV7B9uGVpeTSCzp@windev.fritz.box>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/07/2024 21:39, Patrick Wildt wrote:
> Add devicetree bindings for Qualcomm ath12k PCIe devices such as WCN7850
> for which the calibration data variant may need to be described.
> 
> Signed-off-by: Patrick Wildt <patrick@blueri.se>
> ---
>  .../net/wireless/qcom,ath12k-pci.yaml         | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-pci.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-pci.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-pci.yaml
> new file mode 100644
> index 000000000000..8f18868ee726
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-pci.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2024 Linaro Limited
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/wireless/qcom,ath12k-pci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies ath12k wireless devices (PCIe)
> +
> +maintainers:
> +  - Kalle Valo <kvalo@kernel.org>
> +  - Jeff Johnson <jjohnson@kernel.org>
> +
> +description: |
> +  Qualcomm Technologies IEEE 802.11ax PCIe devices
> +
> +properties:
> +  compatible:
> +    enum:
> +      - pci17cb,1107  # WCN7850

That's a duplicate of:
https://lore.kernel.org/all/20240605122106.23818-1-brgl@bgdev.pl/

AFAIK, this was already merged. I don't get why after ~1 month it is not
in the linux-next.

Best regards,
Krzysztof


