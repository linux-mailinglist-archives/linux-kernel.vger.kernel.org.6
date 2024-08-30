Return-Path: <linux-kernel+bounces-308237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A4296591A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A94A1C235A7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 07:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021C515CD4D;
	Fri, 30 Aug 2024 07:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="McXKdrvi"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0295158539
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 07:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725004275; cv=none; b=RXzd4m8T0r9UK54Uzzt6x4Yj4RGCdnz1F91iN86EsxWxtPThll39FPmgc7jRecrKtTFmR5jn+qZXXXa7PjniXiBS1wzr/WKUPom8QEEl/g4alHgIt7ELrMx/gkVy0JWSCZpAtxxJEJvLCe6hcYvExUhyB9UaDCn75/MiOVd365Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725004275; c=relaxed/simple;
	bh=o8CRy5N/QP0vv90BvpY0TE1SD1145ZLfu4J9UgiIu1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hUjOeEiAi8l5Pmhtf3EUvxIAbCIN4B1VXxcjXTNDrASsTJOtypFGYjuVt9P9GRX6mq74YK/D0kSZBGm8/uyMtTAIGfn7oClr/esVbX3+fvjdBxfNsaVx40ug1Jpro/iwFmLZzv9clNKc+9K9naVS2ZLjVEBO61S7n+pOCOcPFs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=McXKdrvi; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3719896b7c8so898176f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 00:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1725004271; x=1725609071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QLLFPhG/9ujRCh5Id3LnvAfy27Hvm1ve5EnAKTVni/g=;
        b=McXKdrviWxCp+vRLlESSQXwa35vFGmhhWNsUwRJfQZU0r55ZLSs0nKZ1aw9FZ8aCdW
         iN07Wn0d7HAvd6bGHh/0GO57k0+S2eXF+FK91DjrRl0uFLy3+j1UB3oGrLuAsGaa1AQq
         lm4R2ZMvdvHEUn/LfDBD2hZC2Gt2grY9/0GhuMQfGdmrpn2hFL/go7RGeCUh1te0biDV
         cTgOqrrfKWue37d7FqPoaSV0vROl67V8d2ZZ/PlI7uFExB8VyowPmhZZzukQsLqmrtwN
         UiJIdhlKNBfGUsxoKX3mgzrm8xhmXljFNKOhBEUEbiWM49uCtdyGymrDua7391iEVmSW
         oN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725004271; x=1725609071;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QLLFPhG/9ujRCh5Id3LnvAfy27Hvm1ve5EnAKTVni/g=;
        b=jI8HDX7pcO9UwCWA7Cy/QDDPpfmWVyhKfHivsTLKWG2l1nXgbRWH8MosCMvyrNhAS8
         CfrfJ1pIkoCAPHkRDdhw4uDtlU9Jau1HZOWNdGOrkvWbvA2ub5u84LFhjB/PSABZ0FjO
         cUyq0Kn0bu+QOYKG7/WhdaMCQpJxFtTWLK9543EEM07dDjo5dP8Umvnq+arFkpY0/Cco
         0qpJHTi2k/KJkiffg4VELRJu4SxkKVAS5nEz4ahgnd5f3TFELfErlB4sHuidzJVqEEA4
         zQf98TA5G7JjvcfrSNV9y7sD/WXNnEoPH+3V7V+QsfMg0HrPQ5nXq8K6uuspJPS2c8El
         UCRw==
X-Forwarded-Encrypted: i=1; AJvYcCVvJyjmGtUKzMVzc9ViPtlYxa1lv4KMxTQNl1ot/m18Q09PK82kwGSpudZ4x40l6zhsGAGXUxWHH4TRLFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6fqw4VIviMj2MJlukz3Tz97SZRazLhRuGcqRD6aKa/IRBCjFT
	0KW+4Fy1zX94WVrXoNtJfwfc06n45+7+yqGs+M0cUKW4CkrMVdH3M5ED4mF08o8=
X-Google-Smtp-Source: AGHT+IHDX9/slgT7/GdTZaLJCStso5CFJJOwulNYGKNVh415YS6OSuMHAUYkJOcO8PCpOKwoXIevOA==
X-Received: by 2002:a05:6000:1b0d:b0:371:8bc9:167c with SMTP id ffacd0b85a97d-3749b581bcbmr3787062f8f.41.1725004270786;
        Fri, 30 Aug 2024 00:51:10 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374b67ff88dsm190333f8f.26.2024.08.30.00.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 00:51:10 -0700 (PDT)
Message-ID: <1ced21cf-9e67-41dd-8ee3-7f8d138d4fac@tuxon.dev>
Date: Fri, 30 Aug 2024 10:51:08 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] clk: renesas: r9a08g045: Mark the watchdog and
 always-on PM domains as IRQ safe
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, wim@linux-watchdog.org,
 linux@roeck-us.net, ulf.hansson@linaro.org,
 linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-pm@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240828140602.1006438-1-claudiu.beznea.uj@bp.renesas.com>
 <20240828140602.1006438-3-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdUcstyRDfaQ0Y=1NHgBYuRWjC0vuJj2j8USCTsEE1qKVA@mail.gmail.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdUcstyRDfaQ0Y=1NHgBYuRWjC0vuJj2j8USCTsEE1qKVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Geert,

On 29.08.2024 15:45, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Wed, Aug 28, 2024 at 4:06 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> If the watchdog is part of a dedicated power domain (as it may be on
>> RZ/G3S) the watchdog PM domain need to be powered on in the watchdog
>> restart handler. Currently, only the clocks are enabled in the watchdog
>> restart handler. To be able to also power on the PM domain we need to
>> call pm_runtime_resume_and_get() on the watchdog restart handler, mark
>> the watchdog device as IRQ safe and register the watchdog PM domain
>> with GENPD_FLAG_IRQ_SAFE.
>>
>> Register watchdog PM domain as IRQ safe. Along with it the always-on
>> PM domain (parent of the watchdog domain) was marked as IRQ safe.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>
>> Changes in v2:
>> - changed patch title; it was "clk: renesas: rzg2l-cpg: Mark
>>   watchdog and always-on PM domains as IRQ safe"
> 
> Thanks for the update!
> 
>> --- a/drivers/clk/renesas/r9a08g045-cpg.c
>> +++ b/drivers/clk/renesas/r9a08g045-cpg.c
>> @@ -259,7 +259,7 @@ static const struct rzg2l_cpg_pm_domain_init_data r9a08g045_pm_domains[] = {
>>         /* Keep always-on domain on the first position for proper domains registration. */
>>         DEF_PD("always-on",     R9A08G045_PD_ALWAYS_ON,
>>                                 DEF_REG_CONF(0, 0),
>> -                               GENPD_FLAG_ALWAYS_ON),
>> +                               GENPD_FLAG_ALWAYS_ON | GENPD_FLAG_IRQ_SAFE),
>>         DEF_PD("gic",           R9A08G045_PD_GIC,
>>                                 DEF_REG_CONF(CPG_BUS_ACPU_MSTOP, BIT(3)),
>>                                 GENPD_FLAG_ALWAYS_ON),
>> @@ -270,7 +270,8 @@ static const struct rzg2l_cpg_pm_domain_init_data r9a08g045_pm_domains[] = {
>>                                 DEF_REG_CONF(CPG_BUS_REG1_MSTOP, GENMASK(3, 0)),
>>                                 GENPD_FLAG_ALWAYS_ON),
>>         DEF_PD("wdt0",          R9A08G045_PD_WDT0,
>> -                               DEF_REG_CONF(CPG_BUS_REG0_MSTOP, BIT(0)), 0),
>> +                               DEF_REG_CONF(CPG_BUS_REG0_MSTOP, BIT(0)),
>> +                               GENPD_FLAG_IRQ_SAFE),
>>         DEF_PD("sdhi0",         R9A08G045_PD_SDHI0,
>>                                 DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, BIT(0)), 0),
>>         DEF_PD("sdhi1",         R9A08G045_PD_SDHI1,
> 
> Can't you just do this for all domains (e.g. in rzg2l_cpg_pd_setup()),
> instead of limiting this to the wdt0 and always-on domains?

I thought about it but this, too, but I wasn't sure about the behavior of
the currently unexplored drivers for RZ/G3S. AFAICT from the current code
investigation, if this approach is implemented we need to be sure there is
no sleeping in drivers runtime PM APIs.

Thank you,
Claudiu Beznea

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

