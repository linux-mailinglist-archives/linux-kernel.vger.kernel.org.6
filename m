Return-Path: <linux-kernel+bounces-510702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0A3A320C6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1E081883969
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237511EE013;
	Wed, 12 Feb 2025 08:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="MzZw8gbu"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9241F9F64
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 08:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739348340; cv=none; b=Bzupji/NCiGpEX4iT3Tiw3sdc792bVkJfn0364ONB8I0SExb6MyG2kRllCPtvNs1J9HgcBeX87MilnJAmYHtheVeKCTxKQn5N0CT8txZLqVP19eVS4P9Pn1FtzZzFJ7LCJjrVnJG+N5pknaNjHQO7NkXCVZPB+X00ZQiYHnio5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739348340; c=relaxed/simple;
	bh=YarSXhMi3MICiWyZ0jRRnUYvv8XeVcnEvxnut2kZOyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F+BBtylIqyTH1jJmExTAXOZGh7RQdJGmMdBK8mP3N7YbKgOZZ9YwF9GXE6u2KEwEf/3t+uzdiVjgpwlVKzgw9IgNQeowexR+qxCKs/PDxuiMcW9p3oDXrcjYNrtroSHMJ8jOQ+LGrT8Q+JFsv4jHSCk/HCd4V9kApjYmo0UYdDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=MzZw8gbu; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaecf50578eso1277172266b.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 00:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1739348337; x=1739953137; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Ca3jOifU6KLMuLCZFV+VlIgaFdG1oVjtxMx89qkKmE=;
        b=MzZw8gbuqLVeL2UHvA5aKLgbE0gIYWGSISDZP8MAJ791yo/wtGJ7+ZTmRXtvZvv/1I
         k9RPd3JtvMfno2uQv1Rn+TaeyJYifJQTkYPu3XPdEdN0ZPTumzW3t7sMioUELOYsPSia
         drXfL8NnWsXSPezSKJ+hOfTZFHkANRAPcHxGxej8nia1kbkBxBlYA+3QrjMnu26tHrQF
         zq1r1B3xazjK86GtNihSzPuatJhGbrq0IMiauK8LrqNxOkYr8O3AbXrGODzwBeMRoZ1l
         DbPqI43fvhDFEs9DmaZdb2eg/SwiKKlZPMWU2ZyFsfN99XsWNqiq/b1i9Rx65RqlH4C+
         h9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739348337; x=1739953137;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Ca3jOifU6KLMuLCZFV+VlIgaFdG1oVjtxMx89qkKmE=;
        b=GN8DsM6PYgIkknxgFq6XlgORQIuxIrBwx6ii1FLLWCMF1IuV+PiN1mZa/3y4skeM8f
         eSUCqOau/NjAL1UAd2NrqBmhp2NvQb4SNeqD+5cbSdfEMticX74aCPk6BOfkho8jeJKG
         iUaVuYjQk/LJMFtfccMqEtooJnIApYCVmQXKmrLxtMPQYGdoe+lXtWjMQ64zjmTQYECH
         LhdlKKurFtrv43Ef5KO20wYrhVaKAcURyYWc6ZfW6lv15X/bwMewScvojAFVo8rHkjms
         AYMO/2MZPFeqeJHPUq8KLLGjX8AiscXpY9xeg3GMIr8nQVO03eXhlMCAW00kN3xWekTK
         RQBQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5uONuveKcQXkp19iWgICCDKRE4ikEWIEHNzbHhlenkvNUGwl3BJsmvgRTSPfCw4Ni5cjCsZBEs7a64vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMaP1rO1SlNFXgGxPPsw3dejvz3nOYEObomZ045zsikgjIHHKa
	lvfcv+DM8EwXeAcLjAJy2/XuwtZzJBu+J4576AYhW6yCb2rMnFKwX92Pp5UPm9g=
X-Gm-Gg: ASbGncsvmHCHZt/+6//+Z+p3SlsRakmLS6zjjyk96Mc94XIef6FuxMijjZLSohY2M7s
	oYFUqp2XardIAKJDSjcy3LlTNuyl9ASDIaSG9/wax++FF0J01g0gXJW4HmfJ4wrvBwszLo+PvEM
	sX49ePQ325H405qKc++uAeYKantCQnBJQZdpWLo1puccV0mb9UT+0jek4JXm8ORKXD+xgvvduB2
	tuWTYRGddjufmJ8Bv0VB9i5mYlDg+tf0hL7N93tAYOMwm+aQRznHufTsrQU3Q82fe4ornIdW9ug
	yqpT46HpaTk6P2/HUBOGuNhV
X-Google-Smtp-Source: AGHT+IHBLSlZ+tK9sv24mLWsqTARUiAJ4W3lRBwdQFx31Cj8hrychh4XqU6wPO/Gzkojw3c5V7eTFA==
X-Received: by 2002:a17:906:6a0b:b0:ab6:b9a6:a9e6 with SMTP id a640c23a62f3a-ab7f34a11a2mr161055766b.46.1739348337071;
        Wed, 12 Feb 2025 00:18:57 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.173])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de5e15c76bsm8231120a12.42.2025.02.12.00.18.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 00:18:56 -0800 (PST)
Message-ID: <b697f8d5-79ca-4d51-b5ac-9dd51713c0ea@tuxon.dev>
Date: Wed, 12 Feb 2025 10:18:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/15] dt-bindings: rtc: at91rm9200: add
 microchip,sama7d65-rtc
To: Ryan.Wanner@microchip.com, lee@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 p.zabel@pengutronix.de
Cc: linux@armlinux.org.uk, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
References: <cover.1739221064.git.Ryan.Wanner@microchip.com>
 <a0338f3d05ed43eeaf2121dd22a9f0dbf25f2fc0.1739221064.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <a0338f3d05ed43eeaf2121dd22a9f0dbf25f2fc0.1739221064.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10.02.2025 23:13, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add SAMA7D65 RTC compatible to DT bindings documentation.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  .../devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml          | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml
> index c8bb2eef442dd..0c878331170b4 100644
> --- a/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml
> @@ -25,6 +25,9 @@ properties:
>        - items:
>            - const: microchip,sam9x7-rtc
>            - const: microchip,sam9x60-rtc
> +      - items:
> +          - const: microchip,sama7d65-rtc
> +          - const: microchip,sam9x60-rtc

Can't these be merged like below?

- items:
    - enum:
        - microchip,sam9x7-rtc
        - microchip,sama7d65-rtc
    - const: microchip,sam9x60-rtc


>  
>    reg:
>      maxItems: 1


