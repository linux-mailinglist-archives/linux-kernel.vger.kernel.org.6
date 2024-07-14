Return-Path: <linux-kernel+bounces-251821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EB7930A3F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 15:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B18201F21922
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 13:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B895136982;
	Sun, 14 Jul 2024 13:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="NlLP0Fui"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F5A13210A
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 13:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720964468; cv=none; b=JmuvIio6anepd/A8qMnvr+t1DEi+Nw6VcI9m9qS+ef4j5Egioa8xuvBiYCU6jQXpUxyB9GKyZ13m5ezVclOqFfgCFF6Sg9cKUuHjHfK+slsXtqDaeECt8nrrkpnSjlE2wGwHqPXesedVBSx+fud2psLLlg/qA69t4H+421i0H7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720964468; c=relaxed/simple;
	bh=T4f3W6vNWXcJSkQ144def9JBi0ohKOi2uSxAAwNLzmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NIuVbSqJP4EOWqf+ixqEcK+0ZyGrF/ukPQGpLhuz9U9Us9yd4DBQ05I62bL/e7Xhqv8Fso9wByYgTSokbzNmYsOXWmxfnsnCTrbi7wSlbBHFRfO2aXfacDq0JXL7f5sCAepOeMiTLuZQIj4AAWQrp18OZGbeE3OIp2PnzcrhLzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=NlLP0Fui; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so20165045e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 06:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1720964465; x=1721569265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wkQnz1fsc+wtBdxU8oz4D/ZMkVp9+IUswsryocxsv9w=;
        b=NlLP0Fui4KkwYnX8UtCen7oAn/23wO2d010dSmfKi0EMkiBVlKseYT5aE4QhVEvdGW
         fbsz8N9Ceyr2YCmg20DqGabHOUDA+mx7iQTPutbbYKpcTqmeLsC66+B4pRdD3JrEttKf
         yJp7NfDVdjuTIRlYQMG4u8MHjOIDx2QmIQI3510y11I5cYokTjg4D8MZutG+F2ej+Uj4
         vWcUozylXrvcxCvPwQ2Sizb4dQgdrzKqcHlo+rnp4OolCGs5o7zlU/+JIFo4jrVHRu8F
         SxOTW5qqhwjuOlSN+uJCs0gIvz1iqAHdsZ96seQFeKIbRjZ+YAzjp+q9lhMhEpc54k2q
         KS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720964465; x=1721569265;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wkQnz1fsc+wtBdxU8oz4D/ZMkVp9+IUswsryocxsv9w=;
        b=bf0ioZLZ4On3MTt85uqW5tBuoEkf/ZcqhzSpdhr82k+ss731y02ETTRhPWY/6hUQv9
         wmP3wzHaMP+PkfvSo9iD4ClAxw/Sc1S16nC7hQjGSPEoD05CgehQG+Euzqxi4O82tuLR
         pSz36QeCTrpgxckyPOrYvgdJuDoPMb3XRz1KBwnFvIHlH3eUPyJ0EBjFVoBiAM+vsOxu
         iulMRkr3uOcvzq0MKr5mwGaTl/p8oddrReNVgSoOqZs0A692qGIeOnA7Yh2nhJ7c4usn
         06G9t/wuLNY+UPy4E5XEYT7KknY12prpy9qdLTj8vkIK2G2xZKYnFnCvku2qDG72Xd8E
         O1sA==
X-Forwarded-Encrypted: i=1; AJvYcCW31eU5Ic2vj9qQiArp6ssSn2giqJyqaBJ5ZndvfpmcVJe197HqbsZ9mMAAkDL1CwYUZakBmqEwWeJkTFVQlHDNctYSB4ZriUkzyMhC
X-Gm-Message-State: AOJu0YwPRtBrm7l5dEH5dycpzNfkArl3vczttZhnE7g0QaUmwcUyLFdv
	BC5Z47KnYQQrpK6M4pmgCotWss7EIzMRe7ZhmDWs5IxvEfW0MAnuRPbFBl8zmD4=
X-Google-Smtp-Source: AGHT+IHMoK4ef4Te2vS85qtBTXCotELhrWhwgWbhUmLlQqR1CSAOogUJzzAuK7+Mp8E60lOvA+9zGg==
X-Received: by 2002:a05:600c:524c:b0:426:65b0:3035 with SMTP id 5b1f17b1804b1-4279da3a671mr70583065e9.15.1720964465388;
        Sun, 14 Jul 2024 06:41:05 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafbea9sm3871306f8f.82.2024.07.14.06.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jul 2024 06:41:04 -0700 (PDT)
Message-ID: <e402ad3e-8b3d-47c0-a2e5-997fe14f7445@tuxon.dev>
Date: Sun, 14 Jul 2024 16:41:04 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 26/27] dt-bindings: arm: add sam9x75 curiosity board
Content-Language: en-US
To: Varshini Rajendran <varshini.rajendran@microchip.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, mihai.sain@microchip.com,
 andrei.simion@microchip.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240703102011.193343-1-varshini.rajendran@microchip.com>
 <20240703102936.196606-1-varshini.rajendran@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240703102936.196606-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 03.07.2024 13:29, Varshini Rajendran wrote:
> Add documentation for SAM9X75 Curiosity board.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
> Changes in v5:
> - Updated Acked-by tag.
> ---
>  Documentation/devicetree/bindings/arm/atmel-at91.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> index 82f37328cc69..7160ec80ac1b 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> +++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> @@ -106,6 +106,12 @@ properties:
>            - const: microchip,sam9x60
>            - const: atmel,at91sam9
>  
> +      - description: Microchip SAM9X7 Evaluation Boards
> +        items:
> +          - const: microchip,sam9x75-curiosity
> +          - const: microchip,sam9x7
> +          - const: atmel,at91sam9
> +
>        - description: Nattis v2 board with Natte v2 power board
>          items:
>            - const: axentia,nattis-2

