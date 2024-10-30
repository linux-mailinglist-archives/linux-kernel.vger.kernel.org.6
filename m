Return-Path: <linux-kernel+bounces-389667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E52A59B6F85
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 478F1B25B3F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A083D217678;
	Wed, 30 Oct 2024 21:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="G19eUbNI"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDCE218593
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324529; cv=none; b=GAajAVuThhIl0s6Dm32nooixZwB+WTR/vy1S3/ZzuRt6gmbO8KUbb76B9e3/9hF3c7ljOX8aE8AKsaHXaXdDAXfGjr1GGrYO7euInOs0UU6sa0dV1bOUmr3ft0HPnOjtiuQzwCzdxPWHBPxaOOgZ05kIfEJnakZu6BbBa1tSH3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324529; c=relaxed/simple;
	bh=3IF75E+Ltb7Wl2+HT/FBTCEnpt0zNNY2aCBPxy6ySGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e3tbLfJmVx6r0+dgQowr970d6W3kFTHkts/RGeQU2O/QhS2PMAaNw9KL4iuBrlEAMoXdaC2/EIasLbIq4PNXCZVuQByo7KxLLsScJCyO7DlYH8G8l2TNlu2tQKhi7Kl76zpxqA2F/p9f1OiGGP1WopD7opWfm5NCq42OvFvEQwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=G19eUbNI; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-460d1145cd8so2037941cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730324526; x=1730929326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eMX/BaaHOgpc5GJXv4RiRPj9cA2BEokb25Zs5fuxKps=;
        b=G19eUbNIh7UJD4HLeMvc4a6IgAxfhHNMj/4eSrScRIlJ/yNmB0ZzYmRHgnPCNiYTVQ
         /HjFx4wQ5GoE1Gr+E6yCiTbrQQx1YmIjJQ07vtAAEMj4tJyPRr7AaGaEIb7m0bgqMpMy
         phTHFn4/yFmg1pr/VAm4VDE+AxcsoDeunchWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730324526; x=1730929326;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMX/BaaHOgpc5GJXv4RiRPj9cA2BEokb25Zs5fuxKps=;
        b=KpsuzcdQu27UM0POpePtdFqdVeHm5SUocFnqQd/+Q3TacBLJ59LbRu+w4lG7DVM5Uo
         xoqv2nKHvzPdIPVRVwmOR/d03sBtVLA+mq/cqx6IKT5bt5uzVH6syr74XylX4sau/qpS
         eqeQntCaJPUzOREKVwQ1DA8uwnnArj/87y2uZXZAXMTNXWvG9I3dFScXr2ZrphuBTdz5
         6SCDALOSVib7irjdwChsX/xFAm88tESmiIPEbdntDC94lDP6L+FJZXoOX28qjxiAO+ti
         gJ9gF0sZW6JmT6lSxVk9LQzRMfJPQoxY5fx7HCP6XllBfrLMU2xY3yyqnwMFcBZIYSeb
         izug==
X-Forwarded-Encrypted: i=1; AJvYcCVM8ilegUdefFVLwSfEiACRbW7BAa8DPCrh111hPByaY+QD5xQxrKUQ41ocfASOwj/KZM97YRHoK7Y5dJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4p53RjjqmowU5wmPSmkowxktqUa8bfuhc4g1l7jEk9bja3VzJ
	bY3N+FadBBrZInskjB/5Ka3QlXb629HOa4tX5kWxS/0j94rA2vwSBkKU3n8GVA==
X-Google-Smtp-Source: AGHT+IGgIL/Wr4pD9zqKpaIZ4WFgT1qOmn0vY5i/bzox7eTgF+mN7MYgIlavELrlKhdDlTMFZ4DlMw==
X-Received: by 2002:a05:622a:189b:b0:460:90e3:249c with SMTP id d75a77b69052e-4613bfcfc24mr251145581cf.9.1730324526035;
        Wed, 30 Oct 2024 14:42:06 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ad086e55sm672551cf.7.2024.10.30.14.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 14:42:05 -0700 (PDT)
Message-ID: <c5476931-9784-4ebc-980b-7371e6a2457a@broadcom.com>
Date: Wed, 30 Oct 2024 14:42:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: rng: add binding for BCM74110 RNG
To: Markus Mayer <mmayer@broadcom.com>, Olivia Mackall <olivia@selenic.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Aurelien Jarno <aurelien@aurel32.net>, Conor Dooley <conor+dt@kernel.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh@kernel.org>
Cc: Device Tree Mailing List <devicetree@vger.kernel.org>,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20241030213400.802264-1-mmayer@broadcom.com>
 <20241030213400.802264-2-mmayer@broadcom.com>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20241030213400.802264-2-mmayer@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/24 14:33, Markus Mayer wrote:
> Add a binding for the random number generator used on the BCM74110.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
>   .../bindings/rng/brcm,bcm74110.yaml           | 35 +++++++++++++++++++
>   1 file changed, 35 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/rng/brcm,bcm74110.yaml

This file should be named, brcm,bcm74110-rng.yaml, I believe.
--
Florian

