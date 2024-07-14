Return-Path: <linux-kernel+bounces-251818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78447930A39
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 15:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02DD71F213B2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 13:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E721311B5;
	Sun, 14 Jul 2024 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="CGp6LVzt"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C67413210A
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 13:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720964396; cv=none; b=kSCXUNixdrOYFNAHA1mX9IRBzYEmwy/PCwGuHE0jglT6LcaKKWeb+PWRRNoB9adhT186BdHW9kVI6EjGVHOri4vQBPGzVFR3i6+2jg+WNEiXEZkeW9RfT7NPSneXp+h2ir0m64YU6MXUp+hhZ8ZpKRaX6JhZmJPS08KJEmWD0PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720964396; c=relaxed/simple;
	bh=ZRPQcaFMU/qRhT0WKNPSFjrNVmy7iseSYLfohdrjFNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Eh7teczPesLztCmy1RpuN2eoeUxUoWfew/ehGRzNSRQVoA0AZc+dfuW1EoFs53sSDQLSLWY/UYKXrMZR6U8f8Z/dPzAoFqeldlWvgWkn/6Mc////hDyuW36LlrH5Oah4hn3oo/WjNPIAGeL4QXvF0XYv7hVZFNiKsS2PR0lLFVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=CGp6LVzt; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-427aeebaecdso842775e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 06:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1720964393; x=1721569193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hXhsgB5kcttJ8ekP07uZnqVAhfWI+txG6dIDu3n/Ejg=;
        b=CGp6LVztg9tFNQmfau66cDC6H9WwjiMQBfjBnNJNDA7IDTT1XxVglxVvHTkvvPDbeP
         2dLdnYuyhdeG31wzzeYSeNvjYdqkgV0kmZICnL182HPE+A/KbCLwd2y/7QeVXC3elVzp
         GzYGZMH5wovMiscatJZQUg8AbDZsRdGKRGjAOnlOQzVwY3lcLEMIl2JZOecwl9eoQroa
         cb0DfvuroAlA36Bn3t27purfCXgRI+Sp1StTVu0rfl4ohhTG88o7tVCeuxCWI8sv/Yxe
         3ZqdIZ0xfTTDnp2hXc+bZZsLeLshA4/aeJdwhaCtvsm7iJ4pc9AJJV+22ZDO53VYolTt
         MQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720964393; x=1721569193;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hXhsgB5kcttJ8ekP07uZnqVAhfWI+txG6dIDu3n/Ejg=;
        b=lPyvt3QdWJIYB4NNlaNRJwmEn422Xkplitkhj2AJsgtE8/hJbS6uwbzzyxieULGPdd
         ASiSZT4wNhstJMA7VnCjuPsV/5ySn+QbRJJ6J6GVt1JvqIcSbk85AwMCRI/C+5vpzuRD
         zy60UOHmOvcYAPiZehRc9YP8iSDa3XPKHnG9MbO9d2GWtslTjUP+xrYdfVRdq2ZkvGMr
         /jVLsCc8zs7Mxodg21LMx1wC7ImAr1PXVc+tRZDEIBMXkf08tg7hsXx2l8XODC0CqnjC
         oD6c1s1Nxq1S0SghklzTCABlDyqDzjC4btGmESbB/8lRjI1YyFjZB6BD+v+gR7N7meFb
         +Wdg==
X-Forwarded-Encrypted: i=1; AJvYcCXDAEcaNCu+xheGCe/0XiQDVgCOhA9JxdDjFZTAeb56517N8EvkEO30UECX+Kq1Sr/Loh1+hCQIM9sMuPJlSkKr1c3wgHYlvgRs0G8j
X-Gm-Message-State: AOJu0Yz1o8vlAm2QhdbCBxzFJ6mC+y4tq1VTWXVlrWimqRbt8tbjAFVZ
	SSI0qqKe/vjaGLdKCbjJQA9F9+rjSo7BTaqq3ZXQJrUVm1DGTPq/d4d6wBS9GH0=
X-Google-Smtp-Source: AGHT+IHZ55PvKzpIXyAWZZwdSfOUuHbPyEFib4pjtaWAvo7Wf8TZY7mQZPs6KJ5I7pPxMEqbAjVjCw==
X-Received: by 2002:a5d:47a9:0:b0:366:e7e2:13c8 with SMTP id ffacd0b85a97d-367cea46a0bmr13958112f8f.11.1720964392929;
        Sun, 14 Jul 2024 06:39:52 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafbea9sm3871306f8f.82.2024.07.14.06.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jul 2024 06:39:52 -0700 (PDT)
Message-ID: <50e216ba-6bb1-4794-806e-75a75d778d4b@tuxon.dev>
Date: Sun, 14 Jul 2024 16:39:51 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/27] clk: at91: sama7g5: move mux table macros to
 header file
Content-Language: en-US
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 mturquette@baylibre.com, sboyd@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240703102011.193343-1-varshini.rajendran@microchip.com>
 <20240703102743.195858-1-varshini.rajendran@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240703102743.195858-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 03.07.2024 13:27, Varshini Rajendran wrote:
> Move the mux table init and fill macro function definitions from the
> sama7g5 pmc driver to the pmc.h header file since they will be used
> by other SoC's pmc drivers as well like sam9x7.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
>  drivers/clk/at91/pmc.h     | 16 ++++++++++++++++
>  drivers/clk/at91/sama7g5.c | 35 ++++++++++-------------------------
>  2 files changed, 26 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
> index 91d1c6305d95..4fb29ca111f7 100644
> --- a/drivers/clk/at91/pmc.h
> +++ b/drivers/clk/at91/pmc.h
> @@ -121,6 +121,22 @@ struct at91_clk_pms {
>  
>  #define ndck(a, s) (a[s - 1].id + 1)
>  #define nck(a) (a[ARRAY_SIZE(a) - 1].id + 1)
> +
> +#define PMC_INIT_TABLE(_table, _count)			\
> +	do {						\
> +		u8 _i;					\
> +		for (_i = 0; _i < (_count); _i++)	\
> +			(_table)[_i] = _i;		\
> +	} while (0)
> +
> +#define PMC_FILL_TABLE(_to, _from, _count)		\
> +	do {						\
> +		u8 _i;					\
> +		for (_i = 0; _i < (_count); _i++) {	\
> +			(_to)[_i] = (_from)[_i];	\
> +		}					\
> +	} while (0)
> +
>  struct pmc_data *pmc_data_allocate(unsigned int ncore, unsigned int nsystem,
>  				   unsigned int nperiph, unsigned int ngck,
>  				   unsigned int npck);
> diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
> index e6eb5afba93d..6706d1305baa 100644
> --- a/drivers/clk/at91/sama7g5.c
> +++ b/drivers/clk/at91/sama7g5.c
> @@ -16,21 +16,6 @@
>  
>  #include "pmc.h"
>  
> -#define SAMA7G5_INIT_TABLE(_table, _count)		\
> -	do {						\
> -		u8 _i;					\
> -		for (_i = 0; _i < (_count); _i++)	\
> -			(_table)[_i] = _i;		\
> -	} while (0)
> -
> -#define SAMA7G5_FILL_TABLE(_to, _from, _count)		\
> -	do {						\
> -		u8 _i;					\
> -		for (_i = 0; _i < (_count); _i++) {	\
> -			(_to)[_i] = (_from)[_i];	\
> -		}					\
> -	} while (0)
> -
>  static DEFINE_SPINLOCK(pmc_pll_lock);
>  static DEFINE_SPINLOCK(pmc_mck0_lock);
>  static DEFINE_SPINLOCK(pmc_mckX_lock);
> @@ -1119,17 +1104,17 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
>  		if (!mux_table)
>  			goto err_free;
>  
> -		SAMA7G5_INIT_TABLE(mux_table, 3);
> -		SAMA7G5_FILL_TABLE(&mux_table[3], sama7g5_mckx[i].ep_mux_table,
> -				   sama7g5_mckx[i].ep_count);
> +		PMC_INIT_TABLE(mux_table, 3);
> +		PMC_FILL_TABLE(&mux_table[3], sama7g5_mckx[i].ep_mux_table,
> +			       sama7g5_mckx[i].ep_count);
>  		for (j = 0; j < sama7g5_mckx[i].ep_count; j++) {
>  			u8 pll_id = sama7g5_mckx[i].ep[j].pll_id;
>  			u8 pll_compid = sama7g5_mckx[i].ep[j].pll_compid;
>  
>  			tmp_parent_hws[j] = sama7g5_plls[pll_id][pll_compid].hw;
>  		}
> -		SAMA7G5_FILL_TABLE(&parent_hws[3], tmp_parent_hws,
> -				   sama7g5_mckx[i].ep_count);
> +		PMC_FILL_TABLE(&parent_hws[3], tmp_parent_hws,
> +			       sama7g5_mckx[i].ep_count);
>  
>  		hw = at91_clk_sama7g5_register_master(regmap, sama7g5_mckx[i].n,
>  				   num_parents, NULL, parent_hws, mux_table,
> @@ -1215,17 +1200,17 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
>  		if (!mux_table)
>  			goto err_free;
>  
> -		SAMA7G5_INIT_TABLE(mux_table, 3);
> -		SAMA7G5_FILL_TABLE(&mux_table[3], sama7g5_gck[i].pp_mux_table,
> -				   sama7g5_gck[i].pp_count);
> +		PMC_INIT_TABLE(mux_table, 3);
> +		PMC_FILL_TABLE(&mux_table[3], sama7g5_gck[i].pp_mux_table,
> +			       sama7g5_gck[i].pp_count);
>  		for (j = 0; j < sama7g5_gck[i].pp_count; j++) {
>  			u8 pll_id = sama7g5_gck[i].pp[j].pll_id;
>  			u8 pll_compid = sama7g5_gck[i].pp[j].pll_compid;
>  
>  			tmp_parent_hws[j] = sama7g5_plls[pll_id][pll_compid].hw;
>  		}
> -		SAMA7G5_FILL_TABLE(&parent_hws[3], tmp_parent_hws,
> -				   sama7g5_gck[i].pp_count);
> +		PMC_FILL_TABLE(&parent_hws[3], tmp_parent_hws,
> +			       sama7g5_gck[i].pp_count);
>  
>  		hw = at91_clk_register_generated(regmap, &pmc_pcr_lock,
>  						 &sama7g5_pcr_layout,

