Return-Path: <linux-kernel+bounces-169705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BA48BCC5C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD6911C22285
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65E2142E79;
	Mon,  6 May 2024 10:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vIDCwKQl"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73133757FC
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 10:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714992544; cv=none; b=fMqFHW5Rzb91wQaPGXG7z2nYACKD/DYOJQ7QlrTX/kvCc2bhe+S9fCO9R9LgRUeE1JGK8c0vdzdvBdGyt31cW+Ff/LmsN+x7Gs/6rECNIQTH2PB9U5d0LW3ZNV32NbkRwtDqoj8WFqfYN5NDUKjBgdl+ePhz8u0WOYtPDu5jrNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714992544; c=relaxed/simple;
	bh=H/1dXeGa+S/WszKkJ9U2rzrhZOqBJT60+sswnoCwfg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ggGppSAJ4mmQVD+aWFSQSc1UInc+T2nZpHUIeuG/ow+A0EQi3BLDbmSO8COhdsbxN0j0VfbuXJAB6SLIapGVZhNArQZ34XJbRkUBb5ovyC8gdN+c/CUhk19vSb5k33gfo+bSX7ibX2ytZqSzrNJj+2aUtLydaPgopVSPzOA/lsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vIDCwKQl; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59a0168c75so437207566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 03:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714992542; x=1715597342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RC+U1B6hdMDqB+QXKRhouVYc1BVEZrqbXLyz0D38xTU=;
        b=vIDCwKQlreNZm/8d2w52IJDZqkfKI8gSdjH2F9UMM2H8uz1HYG2Gd0IYuUvpPHMF9E
         nUJTOQEmoK+2j11usVhzl/clf5jf72VV5wbMbnUjCwZ/zFrRcPgp1tFTo2FTmsolTZeg
         m4uytMCGHHiUUloTdm+3RkZDbcLLjtm/CKxxk02hehq17uCKPXU9Y+Di6JGiZw5HvqCF
         MLZk01SNz5vNKTIpGkXKcNgq4e9YN7uy8WX9sfFznokDFmjZ3ysX04mpPnGPHqRMRQS7
         CIL6U/MOULa6pIKVTZ9qNTslE8W0W3UH+B06Wk1yDlld/jiLDLrkazcw+Qb+Ohmh42bc
         SrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714992542; x=1715597342;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RC+U1B6hdMDqB+QXKRhouVYc1BVEZrqbXLyz0D38xTU=;
        b=MzvBZvyEOBTYaDy7qRatxrrLuuPXYHxyjvlCNAM5WAvChhdp4lwXwjlzeAwUe0gWqH
         JCOWMh/Oo8s0eM47oQybMdsEB/KZ6Zlg75MBKyJb9uv24d7JSicS3VJgQ8ZW3dg11jh2
         N0ggRc2slrVEO8bL0FTfhrlm36eOg9rcddnJvc7dpEWOjN/iu0g2Z7W8UED14gRyvi84
         W4HrakO0dEDjIWUqVUHGD/NDujY/l7kiJxEYBKPxHvVKXqQt2UUHx6+bObsmmlJjJBSr
         O/gXfchFKnYNDv0Ld+ye8zFZAgpb/xKbWrEucltBwvYv9s2HRkxEUoUfGB6HS3gNWvN2
         xiNg==
X-Forwarded-Encrypted: i=1; AJvYcCWoLCTBbH804/Mh5pcTEPJEXbDz3IQG1rnxPA6x98vQjjyew780gzOEC/lljpjQHnKINQ4tKZmMHY7g5/Bqc98X9RCiS397kpGRdo5d
X-Gm-Message-State: AOJu0YzZQXOaxI7WiOfDjQpw0y0KCjmrlheKuCNAaE83ZjUVDo4jY/OP
	imP8xQLxKFGTSaItplTdj5UcWhTzJVAOvVbq6bwOwHWT/CAxgFODnieXJeLY9+Q=
X-Google-Smtp-Source: AGHT+IGPODrYuhvfKLW9To07UGREThaB1iuMQWDlOXXb7hEvKqY+AScyPJpIzdl9Kwwom2eFtFbklw==
X-Received: by 2002:a17:907:3f9b:b0:a59:db0f:6bd7 with SMTP id hr27-20020a1709073f9b00b00a59db0f6bd7mr959267ejc.71.1714992541724;
        Mon, 06 May 2024 03:49:01 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id cd22-20020a170906b35600b00a59b4e490d9sm2326978ejb.193.2024.05.06.03.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 03:49:01 -0700 (PDT)
Message-ID: <ade304a1-ea43-46cb-b425-b08055db49dc@linaro.org>
Date: Mon, 6 May 2024 12:48:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] dt-bindings: arm: rockchip: Add Radxa ROCK 3B
To: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240505134120.2828885-1-jonas@kwiboo.se>
 <20240505134120.2828885-4-jonas@kwiboo.se>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240505134120.2828885-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/05/2024 15:41, Jonas Karlman wrote:
> Add devicetree binding documentation for the Radxa ROCK 3B board.
> 
> The Radxa ROCK 3B is a single-board computer based on the Pico-ITX form
> factor (100mm x 75mm). Two versions of the ROCK 3B exists, a community
> version based on the RK3568 SoC and an industrial version based on the
> RK3568J SoC.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index 51cdaabaf0d9..41f2ab79e612 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -799,6 +799,11 @@ properties:
>            - const: radxa,rock3a
>            - const: rockchip,rk3568
>  
> +      - description: Radxa ROCK 3B

Does not look like it matches recent fixups for names.

Best regards,
Krzysztof


