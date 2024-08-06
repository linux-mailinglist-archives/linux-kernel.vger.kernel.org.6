Return-Path: <linux-kernel+bounces-276282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DCF9491B0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8083EB2411F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1321D27A8;
	Tue,  6 Aug 2024 13:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c7Lhrcb9"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CC71D1F52
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951250; cv=none; b=S6v4YwR2+ob7rLV9bCD6dREAThDF6+RhyE2jUODaYU+zQAIUdZQexr/y83gW5lsENBk0TtzYMm0BzV6W6MZ+ZstK2cRSlspMTTrwX1/mOTmhxbztpJL2S8pwW+oPHGbEJrICrBmw6Aujelgxua8tQrJHuyOQimT44sMK5t2+P+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951250; c=relaxed/simple;
	bh=CpabGOclz794me9vC08yCT0e3R0jqdi1QnOp5EOFKj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IzlcfylqcoBHsepv04vsuDgzHoEmTu8U/mvD7GhWKjYJjboSCfp+Z5T0L3pWafmU+uhXUnu9jz6eAYPIHN1YHSEmg5zcLd354AmJZXdakpNdW/VF+pvbEcNrrT8kM5vIgEdQGWrLrpwksvpnACyQZLyOXTUqp8KQRmDKS/9IVBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c7Lhrcb9; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7d2a9a23d9so76617666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 06:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722951247; x=1723556047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QSVsrvoCjLEz79FZLSkIkAUDkNILg/deIm1Ot+npm6g=;
        b=c7Lhrcb94gsfesUO0mkmDeWQjnfylo9FFc77xlaa//XEmTgdbBIxbRbLlHn4RhBdNv
         6tK/la5zIWRuiNZl/RFOyO3nsR1ScrzkuoEBUKiKFSiKgD5vlHUTDYdrn8cw/HumTaJs
         FZIovdMk9efDHRgRveUkFcanFW7WY/0ln0ZZiUn3ZybeEhC2pcjlWFYPg4NvTO5yi9gR
         +HI5PfFIqinWWFaoEsYvmn8cWvE0gMwxX6hQez2EL+om6BO2lkRIRSfqCPVaxGM60OcZ
         uU4fWip4UfhIULK+AQYipD9p3OQG1ymtRJfFYz/IpJQEyx/OftkzEiALUR0D/SLxI+jN
         RcOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722951247; x=1723556047;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QSVsrvoCjLEz79FZLSkIkAUDkNILg/deIm1Ot+npm6g=;
        b=dCOIleETn1+Q6VAdAgrPVnfPzxQ+VvPHBiEvydVM6yLPgE1QuEBvE4mr1FFcSgVQ7x
         h4XJFCvzBfi6+csRmIhIfuGy/jyaX5iBWDqQWVJIRB5D7YxliMkpRD23IReO8C72NU2r
         ud6YGItAVAPAqtoWkkn9lnsZ3qNJc1i1UnCuwk2v2ZP6zeSYk4uWHL7cfUdqPIol/Uvh
         ocuLJ/kNs+JgYuVHZSTk2+9vNxU8XEBs2tqF05z00fP9/KAX9muYciUdulFeLkO8IgNN
         5sjzuY7y9ZFXxVCEXKzXLf44X6Hz/f+rTZ29fPMW3u0tmiom91oYxsvJa/3qYCms8TEo
         OI+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUGbSsQzHybhdVtdtifTy+OuBPFQ1NhTVs2iQ/9TsCu+hl71ZOTdXxUwnnDK3G6PImf/MikLSP8KXzc98w3YTgL6wJuFa4npP3G4MRF
X-Gm-Message-State: AOJu0Yw+oqeBlj+q8ZkhF4ET2HCkelvntKfI6L9VGcicnsgoQa/zoFBv
	4k8aCvY5W5OSmUtMgNV0SKgT/69L0vj8oPshpXCif9nKNAip6apL7090sS7xR90=
X-Google-Smtp-Source: AGHT+IFtxfYsxqeHRFGhjRraM802x/+pdBz2ozIVLH2lYKttiOc8ks9vmu30QNOTjyqJ/uaAaKZuVQ==
X-Received: by 2002:a17:907:1c93:b0:a72:7736:9e03 with SMTP id a640c23a62f3a-a7dc509f7f9mr1047606166b.52.1722951240448;
        Tue, 06 Aug 2024 06:34:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c12a79sm549512166b.60.2024.08.06.06.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 06:33:59 -0700 (PDT)
Message-ID: <9dda725f-71f6-4f64-87a7-f7151fa1690c@linaro.org>
Date: Tue, 6 Aug 2024 15:33:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/11] ARM: nvidia: tf701t: add Bluetooth node
To: Svyatoslav Ryhel <clamor95@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240806123906.161218-1-clamor95@gmail.com>
 <20240806123906.161218-6-clamor95@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240806123906.161218-6-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/08/2024 14:39, Svyatoslav Ryhel wrote:
> Add serial node along with bluetooth node to ASUS TF701T device-tree.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../boot/dts/nvidia/tegra114-asus-tf701t.dts  | 28 ++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/nvidia/tegra114-asus-tf701t.dts b/arch/arm/boot/dts/nvidia/tegra114-asus-tf701t.dts
> index fe1772250a85..00c3325878b9 100644
> --- a/arch/arm/boot/dts/nvidia/tegra114-asus-tf701t.dts
> +++ b/arch/arm/boot/dts/nvidia/tegra114-asus-tf701t.dts
> @@ -1111,7 +1111,33 @@ serial@70006040 {
>  	};
>  
>  	serial@70006200 {
> -		/* Bluetooth */
> +		compatible = "nvidia,tegra114-hsuart", "nvidia,tegra30-hsuart";

Why do you override compatible? Boards do not come with different SoCs,
do they?

Best regards,
Krzysztof


