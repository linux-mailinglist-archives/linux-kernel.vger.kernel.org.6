Return-Path: <linux-kernel+bounces-251824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 500FA930A44
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 15:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA525B213BD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 13:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD5A132139;
	Sun, 14 Jul 2024 13:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="d4cK+Fec"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F47A132106
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 13:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720964600; cv=none; b=WFlHXw2Xi8nh3rrHAHO229Au4eML3+APqtwtOHjevliDMwLuWbzvWxhb3te0+VM4bWt5ALZ1/LWVZhuDO87P0hEyJcn7DYVDnTrKaOpul5G3AQh6VxyUS5ebxgpsS28Hz/sOrtFaqELB7M/rctoa2DaNjsszqudi9ZOCDr9yArU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720964600; c=relaxed/simple;
	bh=d0s/zMtcbXqKbjm+PTDHIkkTuoQHHY0SwUp1819qYCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FHZGnWv/KJtLf+IVVoHc9/YdZfXoyPBPldCpgAnSMwbRGdg8Ff+ssvmkDj5uei7QGZjFFaxVSwV9vXd3lGXjWIVarPPehIzW2z4ErH0BhnkJ1GFMTlKaMuF8DT6tMMfnOKrInoy3a7NszpKtS1tashen5xLhsMf5sfKb48UdhT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=d4cK+Fec; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-367a183df54so2306370f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 06:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1720964597; x=1721569397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EvSuLSrlkmzSzCoULnFgeWbxd4c5w63GtLJ2aZJHjXg=;
        b=d4cK+FecjRwi+mhkp4CbvT6URTfxKiFqydRNnhOVVvuWSo9fxsJ7egdRo9Er4hoydB
         Tgo4reBdCBxPr7m/TapAWw8i26u8qp0/FFfrgpr9UGNXyAu+k26r8fs4LmUQv1Ffvn+D
         KmZi8LAGpw1kya0k3wKUyLuPxIpWDpQLXcPMooPmr0EVT7mrGWqtMGbe4F0cr7rAWQqN
         +S/d9FqnCapFGCo1qUEg2YlS58xRIjOzWO0h6sd2/S/4aXdg1wCPZJ38uzhftiDf3mis
         YQ9piRvB+0rU6kUYKEy38DQOpnfmAzvVaQ0WgG5TE0HtLhwTFstYh37uEwLBa3oEq04R
         HbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720964597; x=1721569397;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EvSuLSrlkmzSzCoULnFgeWbxd4c5w63GtLJ2aZJHjXg=;
        b=PQ1vJqrZFTJr1CmumzRlTjqqrAj35z+bPtvOjE1LDRPMvIWoqOBnW/eNsfQRKENJzR
         cPo+Cg+f8EUVjS0uGwkOU+4iOSi18LlWPfxdRI1Sw9rOyGs8AAg1imvAhz6sV70wiJ9J
         PymnEO1G4tQOZ4D9binWCw0xBPZswFc1yWXyvYY9hVjWzhSUCyI+s/ZIzhzi7SOD2dbb
         SFj9ilfx2chZLJ9/j7sfMW6NO/pvQGMPVe8Tu1fhVGn475KmeB1OHBHyblELmKjo9HO/
         AuSry+5kPPNbIebmYwfMR/eMoKQ0zm0XE3PxHsR67Y96OubMHsd2yexfjukxo6ZwpJKK
         CRPw==
X-Forwarded-Encrypted: i=1; AJvYcCWnL5vgLflgZVParg4tHEOoICm4DoVC/4sdQaktYvlOPJItraXOOqBapaUNgcOHeFIoz4+iF943FoqTSC6VWk/bYhJQ7DCAh0k/wzKq
X-Gm-Message-State: AOJu0YzBmbUhVGbTk4Ja5HZbGsSMDycZ/NzAT+WX6iwNSKlYA54laABP
	FR/8nyYOtTYQVETghAIyQ1s0RM1uNMLQzIDsVIR4ktakIjAq0wx22zgvjogm+nk=
X-Google-Smtp-Source: AGHT+IEQxkyCtk4AlpqAOX3++cn+4yoILvrLmQnY0iu7KCTAhGY0WUMDKaX0U675LyC+lMnwfqbTkg==
X-Received: by 2002:a05:6000:10c7:b0:360:791c:aff2 with SMTP id ffacd0b85a97d-367ceacb569mr10431102f8f.47.1720964596714;
        Sun, 14 Jul 2024 06:43:16 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368119970e7sm3158677f8f.21.2024.07.14.06.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jul 2024 06:43:16 -0700 (PDT)
Message-ID: <c3c319eb-abe9-46ba-870b-828d619a4acd@tuxon.dev>
Date: Sun, 14 Jul 2024 16:43:15 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/27] ARM: at91: pm: add support for sam9x7 SoC family
Content-Language: en-US
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 linux@armlinux.org.uk, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
References: <20240703102011.193343-1-varshini.rajendran@microchip.com>
 <20240703102653.195483-1-varshini.rajendran@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240703102653.195483-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 03.07.2024 13:26, Varshini Rajendran wrote:
>  static int at91_pm_config_ws(unsigned int pm_mode, bool set)
>  {
>  	const struct wakeup_source_info *wsi;
> @@ -1362,6 +1369,7 @@ static const struct of_device_id atmel_pmc_ids[] __initconst = {
>  	{ .compatible = "atmel,sama5d2-pmc", .data = &pmc_infos[1] },
>  	{ .compatible = "microchip,sam9x60-pmc", .data = &pmc_infos[4] },
>  	{ .compatible = "microchip,sama7g5-pmc", .data = &pmc_infos[5] },
> +	{ .compatible = "microchip,sam9x7-pmc", .data = &pmc_infos[4] },
>  	{ /* sentinel */ },

I would keep this sorted alphanumerically. No need to resent this, I'll
adjust when applying (and send a patch to adjust it for sama5d2, d3, d4).

