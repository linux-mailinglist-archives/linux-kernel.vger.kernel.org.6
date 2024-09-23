Return-Path: <linux-kernel+bounces-335474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A04E97E637
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 058E01F21554
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 06:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B736429CF0;
	Mon, 23 Sep 2024 06:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rFmVSjPB"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38D51D52B
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 06:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727074444; cv=none; b=SLfc7ODTohm8QVn/VNlekiKcfZNvJ6DhoMUp7xnp2LsNoMTE80aMw8CnCUsQpZNE2vOQ3pvSFa/HYj6t2N6yQbFaqVh0EQX6zQqfWXzlaSoDl3Y/wrEzQWxNOgOy5xVc3lBmXZ8rcT22E3au2JIHqD6MBD+Lv5tUkXMNsFPvRy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727074444; c=relaxed/simple;
	bh=oyQnC0O5oSwQOoAQfAmgv1yjJgkW9AlXx1tPPhQt9m4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LQ0+zicNhKXblLG4RgSxvPRmM409YTc1L9ryzp+KU9Uqg0ccq7eMlfX6IY8c16v7ebL+L7sRHhZTpL7fDnrMYGaVCQKLDM8dqD0DEcgVy1olL2FurOIoA3iwiGkBdQULPqoaXOFXA0S+2W3OO/dwYJ/Q4VR2lyXih+GDET7klfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rFmVSjPB; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-374cacf18b1so2390941f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 23:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727074439; x=1727679239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0IrKYwdcplB4PqG5MUDB7kDHEBg4+7QsR9hwNRsCDwA=;
        b=rFmVSjPBLWJmHwfA3kjpyjKtetPvpInl35FLtXncjtKrI4W86cFk4d/7LkhMZ/9yzA
         +rxnc3UkkYRj0yYdCGNl1gxZZ4YQTF/XMAMxe1lHmoUCkQJjRzo0cCLzbDOXsdTKtDfe
         jgZxg5c/b5bg3lGQTrA8UdYhv1njIJF0juaTZ40d8eYN/zMJoCdrOALWzWqc6SuF+p2N
         ZVlQ3vZAFtbkSNkDdphzhKOHVoSno1JGQc4AyU09bp8BEVGWUWPr7ctQol1Eb2jHVHeL
         raMQN8H8PGKbX5FXy4Xk0i124tGjtZ/GS5uF4NC757avrLEJb70PzCfioy+egY5sSjl/
         TdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727074439; x=1727679239;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0IrKYwdcplB4PqG5MUDB7kDHEBg4+7QsR9hwNRsCDwA=;
        b=cD12Ps3OgWsSL3lihqd59209yerzSx0lt8dsj6GnNiVUyf/4vvy9GfxiVlmaUuyT2s
         Usi7syR7Bk3pPibRUe3BMLwR378/2UyJGRErG9HcoOnG3rxHXYTSzuqYMoPkChySTOd+
         2K2vN2jsXekDaVZIz9i25h9AwFRDeDiBjRO7q3FIB0cri1FlWYZ64NTwWVijIbJKnqq0
         b1k0fK1sXfQHEWc1tovGWpdtCLj85gEo/SqspB5aUMPjZocQT0CcQu16G30ez221qeei
         Dzx57XUYvauVo5tmXxGZcVfgTOBblqGoUtHKmsBEono1D063H4c9S2EvF+wdrYO48uzw
         P5qA==
X-Forwarded-Encrypted: i=1; AJvYcCV3M3JxQWyv2g571GDIz56cmoJLHsmaYyTJb4X34mZW6mhe4kO0fxgJ3iLSWyiS6t7koiasbSGHJN90H+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+WoRLJwsyp5sI0xFCkR9gghjYUHCTcTDXGcd8TjJXzp47o5OA
	PvMzAfPFxlf3VNtSP/w7MYh9o0r8/8SrnBtoYh3tgrUUQIslYrSje/UQ+lD66zAwfMg0YLUQcB9
	O
X-Google-Smtp-Source: AGHT+IEaPMxTl8BZwywGoBhw6tY+/KStLZzFF7wxzFciOYoL1eb6lQA+E2sOa2JobaYCp65dgoUFgA==
X-Received: by 2002:a5d:4f0e:0:b0:374:bf97:ba10 with SMTP id ffacd0b85a97d-37a43154b16mr5364814f8f.25.1727074439272;
        Sun, 22 Sep 2024 23:53:59 -0700 (PDT)
Received: from [10.11.12.107] ([79.115.63.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e72e49bfsm23626562f8f.21.2024.09.22.23.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2024 23:53:58 -0700 (PDT)
Message-ID: <97134efb-398d-4c21-a915-87a5b4f1b29a@linaro.org>
Date: Mon, 23 Sep 2024 07:53:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/6] mtd: spi-nor: add support for Macronix Octal flash
To: AlvinZhou <alvinzhou.tw@gmail.com>, linux-mtd@lists.infradead.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 pratyush@kernel.org, mwalle@kernel.org, miquel.raynal@bootlin.com,
 richard@nod.at, vigneshr@ti.com, broonie@kernel.org
Cc: chengminglin@mxic.com.tw, leoyu@mxic.com.tw,
 AlvinZhou <alvinzhou@mxic.com.tw>, JaimeLiao <jaimeliao@mxic.com.tw>,
 Bough Chen <haibo.chen@nxp.com>
References: <20240718034614.484018-1-alvinzhou.tw@gmail.com>
 <20240718034614.484018-7-alvinzhou.tw@gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240718034614.484018-7-alvinzhou.tw@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Alvin,

I quickly skimmed over the previous 5 patches and they are looking fine.

I don't get this patch however.

On 7/18/24 4:46 AM, AlvinZhou wrote:
> From: AlvinZhou <alvinzhou@mxic.com.tw>
> 
> Adding Manufacture ID 0xC2 in last of ID table because of
> Octal Flash need manufacturer fixup for enabling/disabling
> Octal DTR mode.
> 
> Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>
> Signed-off-by: AlvinZhou <alvinzhou@mxic.com.tw>
> ---
>  drivers/mtd/spi-nor/macronix.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
> index f039819a5252..1a8ccebdfe0e 100644
> --- a/drivers/mtd/spi-nor/macronix.c
> +++ b/drivers/mtd/spi-nor/macronix.c
> @@ -200,7 +200,9 @@ static const struct flash_info macronix_nor_parts[] = {
>  		.name = "mx25l3255e",
>  		.size = SZ_4M,
>  		.no_sfdp_flags = SECT_4K,
> -	}
> +	},
> +	/* Need the manufacturer fixups, Keep this last */
> +	{ .id = SNOR_ID(0xc2) }
>  };
>  

Could you please elaborate why you need just the manufacturer id here? I
would have expected to see a specific flash entry instead.

Thanks,
ta

