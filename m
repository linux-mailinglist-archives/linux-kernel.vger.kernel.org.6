Return-Path: <linux-kernel+bounces-241999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E88292825E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CB121F238F8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 06:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427EB143C49;
	Fri,  5 Jul 2024 06:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QZKpIZlV"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF6761FFA
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 06:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720162517; cv=none; b=YfyXti4BWJr/w0oQ1VIHban2m0p9eN9Y6Vg58REwAjxw2RPgi5hfioIrmH5KinXzndyr0wrktKpgAm/E/jC2jK2zVypfKt2Ugvsi1MrwVMl46sfHKxHxWddQkGShZr74xPnoiJa+OoRhX3pWUsOEQ05F0EJJguNRYUd4WkGk5U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720162517; c=relaxed/simple;
	bh=k1NZLgovLl/0F+8XiZk3oivKTQVUQA8vInhwXDP5jTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ppNfesrr9B75xyKxMUpRNH5NVNat0dlkPtdLS/kCVIIn0WaaeotCMwNi/qbO8zL25nG13FSB8Yl4JwXHzEU9+NUMTCb/CCMAkcIATKj5u5B7JZQ8Nz5ZmvAA3Niv2/uXAGKV9YlHVtqDetlG1Nw7QsWjQ3u4QZFka0/vgVLFsHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QZKpIZlV; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3678aa359b7so1506022f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 23:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720162513; x=1720767313; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OAmRb1uAuEAN7hA/+tiYf8M3NwFNbkYNSWLhVUPe0Xs=;
        b=QZKpIZlVAjDk2Q3DB2jG1YSyU1FB6slrnZxMLyV4tZccNzhd+YBiKzRVf745j+08ej
         lhnFjazinV8LPztJ18zfM7JtubXQbTxFPeeKNwnv0sSsHu/6VX+keqlfZv5HIfXxygY4
         i5nBrKZScPwrJBttzqNcKyvjoS/avrPLniXct0kd5m/75167lH/gWgJDETzXsKtK1Dei
         hJZq9A39lvMB0qF1re7QPrIAdlt9fx8qFca+Tzlg4qbK7a5BiuMkfaWkJxvZzFZVagCM
         +LBaK2TH7GVxes8YCBnc1cZifjGqMT+bFnhLZOFYbJDHOnRvrNzm/gNIfMy5Ra9Z7Rxu
         W+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720162513; x=1720767313;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OAmRb1uAuEAN7hA/+tiYf8M3NwFNbkYNSWLhVUPe0Xs=;
        b=NaZ5VD2qg9TzlfDlAu477ss2lgeQ1ryhqz8DJPqz6frmaugufJrEAe94ek9P/lgAhw
         sfjCzwehFPdB7LccC8bCvA3duaunA0VLAa00KuBAinSA5dy5IHBxKo3ylwNz/i0UQdv/
         fnXN4sOMoi5t6a4M8GA5CMoFevLq2tnbgkjz/JToVgX4cCgv0vT1WDuKDXQfBX7CjHki
         g32d8Bf4Zbww/0lHP9/xFgoElToOoQpKWOucVT0RkcdVx5Of2FSV1wJ+LjLAqzKqLGXW
         apcU4WRacsgR5nv++34UMwD6IV5M3RonX9wRWd3liMJdxnskF3SSX5bD3p9r7Ua+6t/f
         S9yA==
X-Forwarded-Encrypted: i=1; AJvYcCVEOU2l+BtUZfuQp0rUB1veN+j9LCUgTMt4/5zArgFyRjyFvS7aakn2ir5zRF+zi+N5RP9fp5/8lJoujZ1hoQYh8QKORdhBvl/7m3OZ
X-Gm-Message-State: AOJu0Yzx5ygF2VyirkOcmdKpxG8vjM5zGatwmEV0K/DgzQEgfEA3QJLz
	X6y1/2b6llYFFRWOJ50YACtAgXRRTotxroIU08a1E8ITBjsyZkJbeKtxSGMezcY=
X-Google-Smtp-Source: AGHT+IGK7z9chhYagD9KHGxmtlMwhGQiE37n8F+C8lLsywpTCqBTbFpRnoD4zxLycqN+AzVMMTirTw==
X-Received: by 2002:a05:6000:bc5:b0:367:8fd9:db6b with SMTP id ffacd0b85a97d-3679f6ef565mr3246514f8f.9.1720162513077;
        Thu, 04 Jul 2024 23:55:13 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679814a276sm4442740f8f.84.2024.07.04.23.55.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 23:55:12 -0700 (PDT)
Message-ID: <03e96fa4-b916-4121-a9bd-bfcd40fb10b3@linaro.org>
Date: Fri, 5 Jul 2024 08:55:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] dt-bindings: interconnect: qcom: Add Qualcomm
 MSM8976 NoC
To: Adam Skladowski <a39.skl@gmail.com>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Georgi Djakov <djakov@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240704200327.8583-1-a39.skl@gmail.com>
 <20240704200327.8583-2-a39.skl@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240704200327.8583-2-a39.skl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/07/2024 22:02, Adam Skladowski wrote:
> Add bindings for Qualcomm MSM8976 Network-On-Chip interconnect devices.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  .../bindings/interconnect/qcom,msm8976.yaml   | 63 ++++++++++++
>  .../dt-bindings/interconnect/qcom,msm8976.h   | 97 +++++++++++++++++++
>  2 files changed, 160 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8976.yaml
>  create mode 100644 include/dt-bindings/interconnect/qcom,msm8976.h
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8976.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8976.yaml
> new file mode 100644
> index 000000000000..fcb50f60dce3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8976.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,msm8976.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm MSM8976 Network-On-Chip interconnect
> +
> +maintainers:
> +  - Konrad Dybcio <konradybcio@kernel.org>
> +
> +description: |
> +  The Qualcomm MSM8976 interconnect providers support adjusting the
> +  bandwidth requirements between the various NoC fabrics.
> +
> +  See also:
> +  - dt-bindings/interconnect/qcom,msm8976.h

This is not a valid path. Please correct it, otherwise tools cannot
validate it.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,msm8976-bimc
> +      - qcom,msm8976-pcnoc
> +      - qcom,msm8976-snoc
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#interconnect-cells':
> +    const: 2
> +

I don't know what and why happened here. I asked for different order of
properties and properties are gone. Provide detailed changelog.

> +patternProperties:
> +  '^interconnect-[a-z0-9\-]+$':
> +    type: object
> +    $ref: qcom,rpm-common.yaml#
> +    unevaluatedProperties: false
> +    description:
> +      The interconnect providers do not have a separate QoS register space,
> +      but share parent's space.
> +
> +    properties:
> +      compatible:
> +        const: qcom,msm8976-snoc-mm
> +
> +    required:
> +      - compatible
> +      - '#interconnect-cells'
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#interconnect-cells'
> +


So no schema? Sorry, this is very confusing.

I am not going to review the rest. You implemented some odd changes, not
what was asked. At least not entirely. With no changelog explaining
this, you basically expect me to do review from scratch like there was
no previous review.

That's not how it works.

Best regards,
Krzysztof


