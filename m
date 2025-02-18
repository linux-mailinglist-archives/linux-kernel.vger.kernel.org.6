Return-Path: <linux-kernel+bounces-518907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE5CA3960D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F4F63B8A82
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A383A232377;
	Tue, 18 Feb 2025 08:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="oNuJQk6S"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49036232373
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 08:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739868164; cv=none; b=SjzW4inFrMa4mnhY58GtlBQnMyfRv+RAaWlnwG08YVc0LIp4dW0w3i4t7Te4iEPCk2N9bNtn6hku62np1sHs9aMAXrPSy/PPS0fWa3n6MzaEAG24EipUrpfe1lHM6n45v9I/BIaj5infO9euT2JAgUZ/S8jqq/vxOWkDuozdXrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739868164; c=relaxed/simple;
	bh=saVAfgYPKRn89eU0vt0BwT0rMzRndUiMwLipr4oYYbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jmB+Xi0ANEYeviM35vHsFWSHDYa84eEtrnnbHCJYFxqrc9qjhRhY1w6r5P8k9DJ2wXhwhn120hWsuJ4AB5y/NJcwgNMD/1HccdkRi2wPKwG6u6EfE9DWULO4rxxoaoqMK3V6p70y4B4wEw7wGKX1Xg3JhmyDNRGSWSEfwf8CwW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=oNuJQk6S; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab744d5e567so962560766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 00:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1739868160; x=1740472960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ch9WkK3xb+NyXSKj+cn4pbQshkuRqJJ8wERBuOfV3A=;
        b=oNuJQk6Sl0q48eVebF0AmRaNcv32iaaCQ8zKe1AJfxWjlB5caD4iZaiNCtJxGZ7wEa
         vHceWLiKcbOj9TigbC3T/ihrTrQZfu/X4H0+S5a0yQegbaOeb+Sb52JVcdkCsFC8AzOd
         URxIw3srH+0d6DNQMXnRhkJppLNiCiQROIr7if1pfMSqpC3cf0FeTAnnYqGqEHfBkAne
         OElpSvtJqFG4dqMP/4R38+h6sN0gdfUjcfidc7aQgskEhezRFsPDfFlM3+LK33ZAWsbu
         dA0mh/Yy0rlNpH95joK7zWflep7Ggb+rSxCJ3AZypGYijwA8CHD7IO8FLz29NMHRzoWT
         7Nug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739868160; x=1740472960;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ch9WkK3xb+NyXSKj+cn4pbQshkuRqJJ8wERBuOfV3A=;
        b=jTPVidb8IvTDDVTn5pBPv7G3vU+BodVSVfKrwhMduMbVlBRjrTrLqB9uqRxgrcJf6n
         QoppuhATv2XlchvGW1mlQcGu+4nFmTBKDkvLzT55XMYsmt3onCuFGVxq+P3poRiRD810
         EogGvt+sJx6OwO0DIjhdjbqGboL8+YG08j3XNK3cVEZ7/70HA6VD82476JQzpku26vcy
         emNFrXoxuCs31pgkeBJX/webQxL8VRAwceRNC9YtgFA9Xs2xwZZoEqUpVcKad/eJLKeX
         nJp4tbGLYn3oSwHn2PeYhA5E5i49gkei/lPrpSFQfz4zeqT6TDD857T5vl26uvkPNzIq
         Qe+g==
X-Forwarded-Encrypted: i=1; AJvYcCW6OGwfG3u7/CONbPGolpqE9UbxQPs6dB/fO20Ew+mpCmCA4h5ctwVaJGOjheHgT0nGcVBTDA4aagzxADA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ktLkpI30i8yCKlQ82CDsb147uLOA7Ny0X382NXkUFDbW0x1a
	tb8Z7J4N8L/4jGPW9UIXDwW8+W/qhFN8SjYgtyVq1qhopK04SmJ/vXZNRXQs25w=
X-Gm-Gg: ASbGnct/UXrNmdBRMHrD1xVL9XF+11xLJA0B/MGOtzRAKqXySfuZX8sIAIq7if6sO9U
	wHWBM4WM01GOPg85ME8H9tG60s+KWztMT6+26qyxg2jeLSBhBoIzpfK5TZor0xRzQWuW3Lzl+uH
	vYK8WAQRvxeXL7z48nIy3quIcfQUBeTQlNk5OK37w6jhS6z6U4PBTn4UioWNwB4R6kDE6k7tzOV
	GkEb9LMot/dR/NZXcHelkHktNne/RGpUkWVggojUbXO9P2V2bSRGQknl9t4qSkmfGB5u0KhWCbx
	5JNODIOVooYhHHu7cMKyWlQ=
X-Google-Smtp-Source: AGHT+IGhI03tdLg5oc0plVNCSO2LiVnGx57Sn+cYCVSUBsfb7XkEiF5iSWvlCx7bfmCKQKm3J+y6hw==
X-Received: by 2002:a17:906:308f:b0:ab6:504a:4c03 with SMTP id a640c23a62f3a-abb70c7a410mr933973166b.24.1739868159537;
        Tue, 18 Feb 2025 00:42:39 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5337673dsm1007937966b.89.2025.02.18.00.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 00:42:39 -0800 (PST)
Message-ID: <a1ebb518-ff69-4dff-a8b4-7c3b716450a5@tuxon.dev>
Date: Tue, 18 Feb 2025 10:42:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] dt-bindings: watchdog: sama5d4-wdt: Add sama7d65-wdt
To: Ryan.Wanner@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, vkoul@kernel.org, wim@linux-watchdog.org,
 linux@roeck-us.net
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-watchdog@vger.kernel.org
References: <cover.1739555984.git.Ryan.Wanner@microchip.com>
 <3c55e634f2993ac5a49e1b8bfceb2333e175d376.1739555984.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <3c55e634f2993ac5a49e1b8bfceb2333e175d376.1739555984.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14.02.2025 20:08, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add microchip,sama7d65-wdt compatible string to the dt-binding documentation.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  .../devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml        | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml b/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml
> index cdf87db361837..e9c026194d403 100644
> --- a/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml
> @@ -23,6 +23,9 @@ properties:
>            - const: microchip,sam9x7-wdt
>            - const: microchip,sam9x60-wdt
>

You could have keep this new line after the items section that you've added.

> +      - items:
> +          - const: microchip,sama7d65-wdt
> +          - const: microchip,sama7g5-wdt

here.

>    reg:
>      maxItems: 1
>  


