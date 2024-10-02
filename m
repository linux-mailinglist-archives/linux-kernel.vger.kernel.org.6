Return-Path: <linux-kernel+bounces-347483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7BB98D347
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B02151F22EC7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511171CF2BF;
	Wed,  2 Oct 2024 12:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tlm2r/d1"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88461CEEA7;
	Wed,  2 Oct 2024 12:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727872221; cv=none; b=YRUNt+UC6EZV0VGS9gYfkCWpjYOBMqRrHHb1GX4yEybQok0ZWua4m4PaIJ3Jw0u2xfpgTaQZG8rDvyPqEFkwUufiD0NaJ5aW9eghb+sbjLX+H1PiblZXmadh53svdrUW4zAoZ3/fxoOW9wqITu/Llu+9xcIeB8XGwR731U46jnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727872221; c=relaxed/simple;
	bh=79zx927LlijyEzz4SKUqBlH2oef8zYox6OWl6kxh6rU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cYildQ28hdU3Tg4BGcV+TZNgdHkPSKDJFFRnSzZes5QoIbsZ8q2WBpAlpayJxD8iUaQP8dofDNQIDN/+9VSAwo8/q72LamdB+c0kr9lVqbPrAMrMXPoz1OgtBJxh/XaMUeJ3uyAnQnyBY/9VYzve98ttUFjt38inP85ZWC8VOQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tlm2r/d1; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c89f3f28b6so3294497a12.2;
        Wed, 02 Oct 2024 05:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727872218; x=1728477018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l8H1qZqWLGCKxS3P4CcVPz8f/wGj7qAObb/kvtfFOhM=;
        b=Tlm2r/d1VasNF1Pr5Rl8xmjrV4KIE7M2h/J99eT5TQpUHoSo1koscfODJAijZuMJ4h
         tLBplCOYhwgS7h8az2apSGZCfMXfmz6foR2d/pXOWvnXbUx60DWHddsZ/Edzb/aP8uPe
         CS+p6kLIoKhPfFeE4ynEHlTe7BfDjF3AnTknSyQrE8S/LYQnasefL4HYu4YT6vKIBYQ8
         RZIKaCq5I+7LONHNC7CX9F7sGcaF5I+FuNZdT3QvFALji+QxfmDy87FjuTFKvSABwciA
         e7rXXm6BNJ/6wEsmkxMV3mDGEA64SyoSdJU8omnwBWWtuffM/Q0YzNSjKLEBzwb2cZ5D
         mWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727872218; x=1728477018;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8H1qZqWLGCKxS3P4CcVPz8f/wGj7qAObb/kvtfFOhM=;
        b=n04PPE9Qkb0rTaMhsfnPLm5M3ScAcpPRUzBZv8uSIsD6q/0IjxACXBXI4XfXJPxL5U
         Cln01rawA9LRghNirmMCE4G7H5Dle7SmHVOU+nJtv3UywVyEnX1kFHcrZ/KYJaFEo78o
         KnBFZWEE7FXSPs/lHJsMRhxyn6UYBuhMlOHvQ+RfyvlLx2uzas8aIUC86Rn1nAzrTYoB
         YmODcGO+1pEhXmw39T3UqLPaMT7lcOO3T9lh2yUJ9M6OYVvx4yICHHVnYMq2ANgRg3mX
         4JndsrjZmRAzFA3jNhjb00tYmmJySWBudaOPlJ6ApeM7tXUTyvAqt2M4PSqJEMpS7RoG
         26ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWBRnlJ722zGsNPkF81MxfiTvV51YpvzuStcjeMMy/DK0wRxjicMYt3YrQpWpakgesjFSgrCFIlaIRL@vger.kernel.org, AJvYcCWpXJI5T/65sQAFUbmzNTva324U2Pt9/V0ep418hp+OwhJvOBE1AEj2uM4nlAdLZuiCQ+VrS0029hrgRuFP@vger.kernel.org
X-Gm-Message-State: AOJu0YxhpWvTjTQXOWPjdtju3wfeEGDifHbtBRnXr2tgaQbXiKmOswGC
	+5tNkxvb+vcAybNiCDqHXDG2e/QV46951AFSvkF2kHIEnDcwoV6H
X-Google-Smtp-Source: AGHT+IEZkn/hs4ylJ1sCqAWBMgmileHhDrVVQqRQ9dL1VUXC1/pU/3bGn8QhARJyoQ7mQEh244B4Pg==
X-Received: by 2002:a05:6402:43ce:b0:5c0:ac1d:b970 with SMTP id 4fb4d7f45d1cf-5c8b1b8255fmr2407271a12.32.1727872217923;
        Wed, 02 Oct 2024 05:30:17 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.162.240])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88245ea57sm7514730a12.55.2024.10.02.05.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 05:30:16 -0700 (PDT)
Message-ID: <e651ac20-eeb4-45c4-ad76-54e5e2481411@gmail.com>
Date: Wed, 2 Oct 2024 14:30:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] dt-bindings: arm: mediatek: Add MT8186 Ponyta
 Chromebook
To: Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>,
 angelogioacchino.delregno@collabora.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, knoxchiou@google.com,
 hsinyi@google.com
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240914063122.1622196-1-cengjianeng@huaqin.corp-partner.google.com>
 <20240914063122.1622196-2-cengjianeng@huaqin.corp-partner.google.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <20240914063122.1622196-2-cengjianeng@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/09/2024 08:31, Jianeng Ceng wrote:
> Ponyta is a custom label Chromebook based on MT8186. It is a
> self-developed project of Huaqin and has no fixed OEM.
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>


> ---
> Changes in v8:
> - PATCH 1/2: Remove custom label.
> - Link to v7:https://lore.kernel.org/all/01020191ea98a643-2d0be5d1-e00b-48e0-b823-bfe2c65b0d00-000000@eu-west-1.amazonses.com/
> 
> Chage since V6:
> - No change.
> 
> Changes in v5:
> - PATCH 1/2: Remove sku2147483647.
> - Link to v4:https://lore.kernel.org/all/20240906085739.1322676-2-cengjianeng@huaqin.corp-partner.google.com/
> 
> Changes in v4:
> - PATCH 1/2: Add more info for Ponyta custom label in commit.
> - Link to v3:https://lore.kernel.org/all/20240904081501.2060933-1-cengjianeng@huaqin.corp-partner.google.com/
> 
> Changes in v3:
> - PATCH 1/2: Modify lable to label.
> - Link to v2:https://lore.kernel.org/all/20240903061603.3007289-1-cengjianeng@huaqin.corp-partner.google.com/
> 
> Chage since V2:
> - No change.
> 
> ---
>   Documentation/devicetree/bindings/arm/mediatek.yaml | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index 1d4bb50fcd8d..88f50989ba3f 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -257,6 +257,16 @@ properties:
>             - const: google,steelix-sku393218
>             - const: google,steelix
>             - const: mediatek,mt8186
> +      - description: Google Ponyta
> +        items:
> +          - const: google,ponyta-sku0
> +          - const: google,ponyta
> +          - const: mediatek,mt8186
> +      - description: Google Ponyta
> +        items:
> +          - const: google,ponyta-sku1
> +          - const: google,ponyta
> +          - const: mediatek,mt8186
>         - description: Google Rusty (Lenovo 100e Chromebook Gen 4)
>           items:
>             - const: google,steelix-sku196609

