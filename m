Return-Path: <linux-kernel+bounces-221167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F48B90EFB1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E259B2852A9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7494B1482EE;
	Wed, 19 Jun 2024 14:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qmT/gVfi"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18A514E2E1
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 14:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806072; cv=none; b=ihQRdBTFiTy7CKcjBqo+vd717JG4KyqyOt925uXef8qW+t60kGrRpNhauIOkB7Sn63dxPm5eWHOM1Q9Pd5AaNpvZuq2e8qYnKJTa/845Ck7Zm1cU7dOnyX9tLrfczRsnWvkU7Dm5NguWvILX2vVcgfiKPv0GVwY8iFQmh5V6Jdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806072; c=relaxed/simple;
	bh=NskM5qPT555Ql1COjl6+UHMiK19TGoFxO0ITlFhhsns=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bDKCXoYmhkyWg0zVKuPbTSq7dvC2066zuFVT1ZQo4G595rF1VLzih6TG5x3jiESTRw+lfTPMX3Y2sv7kpnfqwrXpBiYlStYB/9qf2kKHBjk2RY5/W0S/IAk2BdYztCwdNJc+Unnkm0HlzV5glR8qIlNqbDtC4UMjGU1whPF525g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qmT/gVfi; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42189d3c7efso68203155e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718806069; x=1719410869; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oaHpZkhtsCD0QOvH/vKXjwNRlG0Co1gFy4lGKzP41Tg=;
        b=qmT/gVfiAxu5s6sALVYdA40NpKAupnx0jAjHmP029mZLgDN67Pm3dWzzq+zokYQirA
         SCgp1FK4IbEbSCi+7TlQ+Wgl0kL66+Ig/Bws6yZXPIgRKcwBRm8EvUTkVvSZaqH1WCB/
         uf1WAviAERT7ANYpoaPlYQpCoKZapjfn/2t14si0mL5Gtq77C0eo7K96hQpj0pGO5sqT
         PtQxlecvw4kS2fS42IB7qGmbpUz8n9duENQ7zLzIsHsDKZAFRYeo8DwwbYwX1E7QVksT
         FYzvmQ2CGloeFz110GXxaH1R4lpy7+4ZM5hUykYk7DCpqcueK5bgdHiq7N127gOzVMv9
         jxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718806069; x=1719410869;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oaHpZkhtsCD0QOvH/vKXjwNRlG0Co1gFy4lGKzP41Tg=;
        b=uklXpp9lYwpMApvPn8Vqjhs+FZnFFjcaqrYHqNQESs2hCtZR4sA6eCaFdffx8hSXyH
         s72IaXV6NDZWeVtQCySHj4gFjz/D3TAKm6nCREGlw+EpAt831a6N4nrbwSFammtXAZZR
         vxg3chIaSbig/LYGt6TtKUFOChZzIxQtnjw7luLMQzzExo7b/b6tSG6VZbLSgAYGntyD
         j+FGc5cQI4M/1gkN9+4HURVpkrQlqSmAnJyOFqaAxEkh3anBKK6SuhBo+oDOMmgswtmm
         HC2yaLI88hcJILIdncsEym3n3Ot7TtpCsU1/QWgYpiILECrEec3WBzZRyv0UV84FGLJy
         V88g==
X-Forwarded-Encrypted: i=1; AJvYcCXjV5RWro7Z4v3zccno2zYKCXtAZ+peBMzstIc4lLWyuQFLUJwTnOjb8urtXg72yrrMjaHAMKPg+dPRjC4hQ7pZUHyFDzPDuJ0OYVOx
X-Gm-Message-State: AOJu0YwIxeXDtEv7NLvEh74u/gtvQj87B67DaIvWVZ3KtKn4qiopkVpl
	FwZ7uenTNqB5qWJBC7k+WDcaHs6llR9qefA3/WHmo6cNFjZIDU8rOLLXHNk6NxI=
X-Google-Smtp-Source: AGHT+IHo7ROd9VC2MG/pYYKawjby+gSyr7EL3WZrsbdKydWpIAWwCr6OO3qBZgIZLwY28lFn/p0CKA==
X-Received: by 2002:adf:fe0b:0:b0:362:4f55:6c43 with SMTP id ffacd0b85a97d-36313fd3a75mr2331475f8f.0.1718806069080;
        Wed, 19 Jun 2024 07:07:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ed45:cb25:b4fd:b1fa? ([2a01:e0a:982:cbb0:ed45:cb25:b4fd:b1fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075104a8fsm17190307f8f.110.2024.06.19.07.07.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 07:07:48 -0700 (PDT)
Message-ID: <78724eab-9dbf-4231-821f-3bf47c92124e@linaro.org>
Date: Wed, 19 Jun 2024 16:07:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] dt-bindings: nvmem: amlogic,meson-gx-efuse: add optional
 power-domains
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240605-topic-amlogic-upstream-bindings-fixes-power-domains-nvmem-v1-1-ef6f10c86a63@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20240605-topic-amlogic-upstream-bindings-fixes-power-domains-nvmem-v1-1-ef6f10c86a63@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Srini,

On 05/06/2024 11:35, Neil Armstrong wrote:
> On newer SoCs, the eFuse hardware can require a power-domain to operate,
> add it as optional.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   Documentation/devicetree/bindings/nvmem/amlogic,meson-gxbb-efuse.yaml | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/amlogic,meson-gxbb-efuse.yaml b/Documentation/devicetree/bindings/nvmem/amlogic,meson-gxbb-efuse.yaml
> index 9801fe6f91b5..99ddc9a4af05 100644
> --- a/Documentation/devicetree/bindings/nvmem/amlogic,meson-gxbb-efuse.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/amlogic,meson-gxbb-efuse.yaml
> @@ -28,6 +28,9 @@ properties:
>       description: phandle to the secure-monitor node
>       $ref: /schemas/types.yaml#/definitions/phandle
>   
> +  power-domains:
> +    maxItems: 1
> +
>   required:
>     - compatible
>     - clocks
> 
> ---
> base-commit: c3f38fa61af77b49866b006939479069cd451173
> change-id: 20240605-topic-amlogic-upstream-bindings-fixes-power-domains-nvmem-7df0dd48b1a3
> 
> Best regards,


Gentle ping!

Thanks,
Neil

