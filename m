Return-Path: <linux-kernel+bounces-510701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4717A320C2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27679188909A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5BF1E9B3B;
	Wed, 12 Feb 2025 08:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="I1308Cii"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2723C13C9B3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 08:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739348304; cv=none; b=P0z8Rf5TU/HgUkPfYrdFacMBU0YIqWELj3KLXkuwe+mi+OsnYDt+ZKQwsZ8H6l9mwV9a/fnPfZo4X0SA/WWUcPb3RyHKKa2GCg2ZrBbCgA39dNoaDssz379SAnC0JXHhsbI4hpg4yvi2YXBFwDwg6+8tlP+wOyBn5ENBhKciAxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739348304; c=relaxed/simple;
	bh=pe1GAinqTXmMtWLyQJVPYf2smmZnVgMAETxekYxmBgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jqkxTMstsuVwdeqVh+AaI7ddviBoEhJ3DZHPPMFEMcuqiWCEAQiMPKlVnE3FeJFo/62gjgiL/q4soRqHysvlQnaaLvKMbNi11rpk8JQosQ247JKMMOqbF4cpEegMSXjr/emcpIcQFnHeLdiGwF9kiZvs39Z1WVPEKrSYPtvi79E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=I1308Cii; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5de3c29ebaeso7997422a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 00:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1739348301; x=1739953101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DUWX2C7v/npw1BHngSXdIYBv3kYifI6qQFt5lUSdhNY=;
        b=I1308CiiauivOZLl7wCUkbBwv7xmfnxCfMYEpciY7ws78/QoPsGiuedOVhZKHM4z3Z
         a7jtLEXUVLYTVALfyY9TIpf25LEuMUukYwBiA0AmH2zvynLgi0RYaTYjs2WjJpc34vEH
         alBObgjsd7OEBJ+oRAVL13NoSByqWeE3Ph9oDWDF5cqnZPfvPErq0NoSwHOdWXMSTj9p
         gmTQ7IWvJ4yn688PXLni2RK0gjsRVQ2QT8bQ9nqoLfoN4wEk30EBLTCYkv/Xdw/7+okB
         VIt3eZfW9UZ5DdQkCd4pBZCUz2qy+3nm65w3mqMYiISyvy8FPE//5IOvdI20DxAnNbkd
         VjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739348301; x=1739953101;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DUWX2C7v/npw1BHngSXdIYBv3kYifI6qQFt5lUSdhNY=;
        b=T4k0TLtndKqY0iQ06GjUYwDARhAUo7YoMnEyY6e3IZVunCn8caIu3RTH+IXXxY7j5W
         ZUAwNakSdcDNqS0SOYRCVQ/oSFqs0k9Ro+LIVmFkAvqrQSnIw5oix46upten9OSj1og5
         7TjGtq808n/avUkQa6cfTGL04366MHANT8mXEbkA8BwFKxg5/RFkeFzXm5Ibz3tjaBdy
         CuVA3+I5Nuh9kz8wwFux73ITv1QY5+MXE9xT19dgTlRW+3e6ibi20fGB9TUBl30hKMKZ
         YIQGW9a7qb1OtRWQxYP7Q0Kwy3GxKYPeh8ngwftFoXOxq75NNvbruZwHucsm21DGGwSp
         qHlA==
X-Forwarded-Encrypted: i=1; AJvYcCWoWj5gxiu9HCXb8FVw27MiluqGTEGRxin0ar8Tk0W5YKzW3q5OMp3kNgpfUJRTYT3W36k3hF6PpnpNtY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPqt8K15Y0Fr9C1KVDKmO2Rgv0e2YvYjdrp4GEcrWd3gvMUTxz
	9iw+GMMcBdiZrdU9CvqQEe5IjHkbN25vrdjtUn9yh6Uhlp5tA+Nu/eMTUUx2MT0=
X-Gm-Gg: ASbGncsTeQGG6uKoqd4HsZyJ/TlqaHbl2j+nTiMqbtvq5XfPP1t/r9TwYW7R23wgp9N
	8R0hkakGJFD1CA8em92d9sgZgiNVMYJfnDaFi71RFr4N6XkrYY6dDpWI5qxXMLlw/RSc+46/xlh
	VEQYr70OSGA0ryo0h13IavullOpUIEL2tDhvl7twzH8a3djP8R3+2IWa8vNcohgmerYg9yjThRN
	gRSDL73XGcdjUuUeIGE/jCYSxUO92huKPCL1qwvt8zYy+AWfPHjuiLdr1GSrO+fqoI0U6YI1c18
	d7H06YykrvyUqNsOQWb4oXLG
X-Google-Smtp-Source: AGHT+IEwjSS+zOVDgDiChTpc71avmO2oV3vQhPuCatbzyoXLnyMKNa1d3LFoa9iHYB9Jc1QHZRsUnw==
X-Received: by 2002:a05:6402:1ed6:b0:5dc:8fcb:b224 with SMTP id 4fb4d7f45d1cf-5deadd829cbmr1660137a12.8.1739348301352;
        Wed, 12 Feb 2025 00:18:21 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.173])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de5a2fc79esm8071036a12.10.2025.02.12.00.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 00:18:20 -0800 (PST)
Message-ID: <9baea17b-fb8e-48a5-b12f-7eebee406ee6@tuxon.dev>
Date: Wed, 12 Feb 2025 10:18:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/15] dt-bindings: at91rm9260-rtt: add
 microchip,sama7d65-rtt
To: Ryan.Wanner@microchip.com, lee@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 p.zabel@pengutronix.de
Cc: linux@armlinux.org.uk, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
References: <cover.1739221064.git.Ryan.Wanner@microchip.com>
 <b437898b518910a2f94f7d827608db35e82c5828.1739221064.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <b437898b518910a2f94f7d827608db35e82c5828.1739221064.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10.02.2025 23:13, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add SAMA7D65 RTT compatible to DT bindings documentation.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  .../devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml         | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml b/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
> index a7f6c1d1a08ab..48a2e013a6b24 100644
> --- a/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
> +++ b/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
> @@ -23,6 +23,9 @@ properties:
>                - microchip,sam9x60-rtt
>                - microchip,sam9x7-rtt
>            - const: atmel,at91sam9260-rtt
> +      - items:
> +          - const: microchip,sama7d65-rtt

Can't this be added in the above enum?

> +          - const: atmel,at91sam9260-rtt
>        - items:
>            - const: microchip,sama7g5-rtt
>            - const: microchip,sam9x60-rtt


