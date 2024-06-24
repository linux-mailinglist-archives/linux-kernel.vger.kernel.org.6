Return-Path: <linux-kernel+bounces-226643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC95914189
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 06:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B16283D1B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 04:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5C212B71;
	Mon, 24 Jun 2024 04:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="BxXvXiZ2"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EE3175AD
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 04:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719205048; cv=none; b=XfaZlmINuZcez1+t22LDj3/dJWpZoMOuSAUmVKcoK2u+cYRmPClcaTDol7o1lllFeVOm01wCaxRq3otKnodhRwCwoEsorcMiXwE1Wpglen3GGyWTyr2Zsr3qC+1m0BgGmCWC7+Rm2Hurt/NFVF8BOkOMVl5KAwc1B33i5WSJFD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719205048; c=relaxed/simple;
	bh=phiJ6SmQt4PGVhxlzteKdz4Tx9PzcGXSswl3QDBWW2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bxMzJufEOxRQbZH1XJ+OhDjG4A7ISTQMqqKQA2lc0u6PsIksnS9OrnC4fVcVTwq1f1Rmgw+FgFa4UcobpCz1Atfi7M67Aas8oRCYgHhwtLFPw3vsLje1mnJuONZ4bP6pAZggWHeqBy08wacv8la88Mz0wSH60ljdueJbVvdvFVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=BxXvXiZ2; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57d20d89748so3528270a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 21:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1719205045; x=1719809845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n81hC2mURHX4tBeWsNYtjmTYadrSB2qqFxnJH1xgsRQ=;
        b=BxXvXiZ2Po9/j4eL7OwoucTQTwk1hr8PHkXjiJUMVCVOwbTJ9fy0dwuOpwSJZrvT1V
         eabirO7G4cOg7ydZoCVL2fdpS8B/2MX2ZH5UliXcXJsI67x4I6oKKxA1F/uXOMrIVPzK
         diYrbqd5JRmNwKHkDIdIpZij65qj+F2X97JQ4uCJH0NZRupWYAVylWB5DhehXWfWAt3F
         68USNEEruixoy+euD4ZBaZbsEnG5NE8+gFoO0JxULOCJahsbmS5ofv9+in5/i9O59deq
         hcSZqRgXw7H85x15lj75qWvOiA2HOEQHGIKPCOUCKllcnEtiM0Nv+VwoY02m5EyzNtaW
         0kGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719205045; x=1719809845;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n81hC2mURHX4tBeWsNYtjmTYadrSB2qqFxnJH1xgsRQ=;
        b=httIIVOYQfH18AzAinYdrna8hQjaUJSHCe6+H1WN2dmAGW7pFtslNru1s6AlI1wZGX
         UGKrsw9PomY4uAsmdA7UO+IbXwRh7lGoB1oPynDRyiigSF0QylRZ/FUhuWhd4cZ0YS+U
         4VwyrrXAi/MFJf45GNYQaY6OMeVHTZpqpZLOsnnhfn63tXJqZPac1+LXF5MtayJTit5d
         Gl1YHZXmFZKaklm7E1FhOiyf93HrfpwAn6TAK/NxX052fDftF+ODjKblvR72HsAJqsom
         GGM5Nk897L2SXLhEsHBlp8vgyIDFaOg/NkOkd036a7+qta3UkyENjbo1Ej5HhnEnya3j
         CsWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV77ctdSF63P+UCvoP2DUwknWFSv7Y6PycLUJwXt+JEdjX6UkG9kr9EtmLTY2cU4LiDEPJNVUkP7MHr+5bRbGOMC8oyFjHgGBeTIleu
X-Gm-Message-State: AOJu0Yw1WQmoIishn4qtSXQ+1xNXMWv2pFHVMQRUHW64wDIvh1dD5yyw
	ZWLfPVXHO7ZobQYJ8Mquwu9Sggkef8J3IYGQ8u9zoevSuxlmTst5FY0lO6Zs9MU=
X-Google-Smtp-Source: AGHT+IH29Wte+fcyhuRsKCPqSiaTew5pLfA8h8FdKKj6z0S4WRk8AFcfmziFTtXwiLY7lgiU/PX/XQ==
X-Received: by 2002:a50:d504:0:b0:57c:749f:f5ef with SMTP id 4fb4d7f45d1cf-57d4a020170mr2321012a12.34.1719205045172;
        Sun, 23 Jun 2024 21:57:25 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.70])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d303d7aecsm4209761a12.20.2024.06.23.21.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jun 2024 21:57:24 -0700 (PDT)
Message-ID: <e66c9670-f7cb-4f3c-9e10-ef210bf73719@tuxon.dev>
Date: Mon, 24 Jun 2024 07:57:23 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] pinctrl: renesas: rzg2l: Move RZG2L_SINGLE_PIN
 definition to top of the file
Content-Language: en-US
To: Prabhakar <prabhakar.csengg@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240618174831.415583-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240618174831.415583-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240618174831.415583-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 18.06.2024 20:48, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Define `RZG2L_SINGLE_PIN` at the top of the file to clarify its use for
> dedicated pins for improved readability.
> 
> While at it update the comment for `RZG2L_SINGLE_PIN_PACK` macro and place
> it just above the macro for clarity.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>


> ---
>  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> index b79dd1ea2616..37a99d33400d 100644
> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -64,6 +64,8 @@
>  #define PIN_CFG_ELC			BIT(20)
>  #define PIN_CFG_IOLH_RZV2H		BIT(21)
>  
> +#define RZG2L_SINGLE_PIN		BIT_ULL(63)	/* Dedicated pin */
> +
>  #define RZG2L_MPXED_COMMON_PIN_FUNCS(group) \
>  					(PIN_CFG_IOLH_##group | \
>  					 PIN_CFG_PUPD | \
> @@ -105,15 +107,13 @@
>   */
>  #define RZG2L_GPIO_PORT_PACK(n, a, f)	RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
>  
> -/*
> - * BIT(63) indicates dedicated pin, p is the register index while
> - * referencing to SR/IEN/IOLH/FILxx registers, b is the register bits
> - * (b * 8) and f is the pin configuration capabilities supported.
> - */
> -#define RZG2L_SINGLE_PIN		BIT_ULL(63)
>  #define RZG2L_SINGLE_PIN_INDEX_MASK	GENMASK_ULL(62, 56)
>  #define RZG2L_SINGLE_PIN_BITS_MASK	GENMASK_ULL(55, 53)
> -
> +/*
> + * p is the register index while referencing to SR/IEN/IOLH/FILxx
> + * registers, b is the register bits (b * 8) and f is the pin
> + * configuration capabilities supported.
> + */
>  #define RZG2L_SINGLE_PIN_PACK(p, b, f)	(RZG2L_SINGLE_PIN | \
>  					 FIELD_PREP_CONST(RZG2L_SINGLE_PIN_INDEX_MASK, (p)) | \
>  					 FIELD_PREP_CONST(RZG2L_SINGLE_PIN_BITS_MASK, (b)) | \

