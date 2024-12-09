Return-Path: <linux-kernel+bounces-437472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 409A39E93B7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A89242834E8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBD92236F0;
	Mon,  9 Dec 2024 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="NfM0HMg1"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E860622C6F7
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 12:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733746932; cv=none; b=DoMENuWvf50400ATXkuFWGTgOOKvF1LgoY4IzHhPBwPxffc31bbMjos5tW0DwtuXmq0zM2SApndJ1PWjWbRX5FxNTiSwiE0PtFJ5oku9wCIYiDFmhnRxHbKWcrth54LLnjr+XqwT14OA4gNQEkyxEFJC+ObsD0y+IRAPet4TOLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733746932; c=relaxed/simple;
	bh=P69xlLlnsh6tfh5k/PNDJbpFeIwWZrU2caWat8R3mr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gpEtQeDi2PWlxfHosk9T4fjCNVrehU0OwB+7Hj3jIa1Gl2zRHao6royE7LBgbrsWMpRg/f7TTf7pcAGRyORzW4S1494UpupCw/9uPNRGT3VpuJYmZ6+suIGbmjl3ZfBndVh84C1o+p5o4GuPJIPnPRoRnQbTE/vgRMeqDlf1FUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=NfM0HMg1; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa68b513abcso124088366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 04:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733746929; x=1734351729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HPvy/PspRQz6rBMMwakJ01l4PrgBxzRdAz/Y+7Xngoc=;
        b=NfM0HMg1s4G6ZeYUU+YXFqYWmuu9kBb62d4UYAsbMjbYxeGbPfov/wquDjXkeEt0kf
         WxhIImhFep0Tsu3HZSsbOd6L3iFJIjZphU6xHSMAVfNpBBFJHlwotZS0fgIp7nr+gtOk
         3Q4wHwvZRdtmYVcbAD/5p/Aa0r2V2CMGo7FujAjtROKsISXAW9YIv9uUc3zf9lXAppFx
         b7Jx4WYmkeJ2VgJH9o6vPQF3uMRP5d1VIbxObCf9H0mAPV8AuaLQzoDrKnWq7bIR11JT
         KcHPi7grYXvbT1ivhJdwDNPqOzhq2Jupqj7Tcvc3kKktPUFUqJ6zWk14KyL8l+bdAPkN
         yNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733746929; x=1734351729;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HPvy/PspRQz6rBMMwakJ01l4PrgBxzRdAz/Y+7Xngoc=;
        b=NGyxcT3JmVN1HQWr+mUopOMubPIkN8488D+Z6jqRnb+fp3THyR6/oMyOqGnEhpYrN1
         9Qe8KtZLTZ2iNMECg5KyP3YaV2t9hNbQhP92Yz3GWe2/DTV5wK2BpWUYnSXVf4txx8FF
         718Wo0b57D0Re3yF6Bh4LHLN8CuLx/dCgSLrW6HqRza0Csydgax6tf14OrFQlzQUvSnG
         PjdiY9YGuyk/G9VGt4MB960zNZWsJVn3Q6BDVz4V0OtUdx45hU/jEvRFa4mXwN66bXBz
         kgcGjVmg6xT+BH06MIasVQt4IhsC2Js1/H8TASGlDT7HkTrAtY7aGnBY6JPsbjC3YY+s
         d0SQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr1lQgD+lnejFDpitDYmBI6LjwuxdW0YbhN3q6YjOnDLOZ6Z426cR2mEsdCEaX7QiVol9m6COOtDeQ9Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYq3RbRqZvkRG/xW/Fb7gVjKM9+KxSbFatGzGqe4llfbmOb5cj
	lNLZuXZrlQmcum7RXAfYxvw0cUOaZHKA8PWbLBttY5zGt0inediqQl4C+Ah7dlg=
X-Gm-Gg: ASbGncvyatmF5P4F7RqqxhVTGmBcxr1UgmL6xdiuC0TbjQsN96mBla514v0VVVsLOtX
	b3dchFfxs4wKtk2xY5Gp1QfzS0vrwbupe2U5Kl6fr5tPJJ1wsk+LDeSMTxcv/2paliqlhtrhAN1
	6Fik8FJDUVgD2FxDMtHMa1NSGF/0vhjXMns5UHPIAx0YrYUR9mJyzx/3okg1TiV/JnyMiA+I8fp
	Qj/peKHUQFdou+HvziG+sF7mf8a6ra0t/A81RExKom1LovbpRv+sH8OjHY=
X-Google-Smtp-Source: AGHT+IHdIFr9jhhsBk3LA/yMhIo1sPstspknh/fJv6TIYCYORpTOtn3BgFqoQz0uOcxmOjnzfBpxdw==
X-Received: by 2002:a17:906:4c2:b0:a9a:ad8:fc56 with SMTP id a640c23a62f3a-aa63a2083d8mr1026209966b.44.1733746928786;
        Mon, 09 Dec 2024 04:22:08 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa699618041sm39442266b.81.2024.12.09.04.22.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 04:22:08 -0800 (PST)
Message-ID: <91c80c8e-729d-46ac-bb05-2cdcdb95ba1e@tuxon.dev>
Date: Mon, 9 Dec 2024 14:22:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/25] clk: versaclock3: Prepare for the addition of
 5L35023 device
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, biju.das.jz@bp.renesas.com,
 prabhakar.mahadev-lad.rj@bp.renesas.com, lgirdwood@gmail.com,
 broonie@kernel.org, magnus.damm@gmail.com, linus.walleij@linaro.org,
 perex@perex.cz, tiwai@suse.com, p.zabel@pengutronix.de,
 linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-gpio@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20241113133540.2005850-1-claudiu.beznea.uj@bp.renesas.com>
 <20241113133540.2005850-3-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdVv+2tEQ5hf+sbihbJMo3+=8kJaWy0YNU_spxQnmWF-bA@mail.gmail.com>
 <d65354a0-c4b8-4379-b824-f4541718a3c2@tuxon.dev>
 <CAMuHMdV8M49m3h3NshzK+KRbT1G7U8hc09T9xUH0Gz1GefUcMg@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdV8M49m3h3NshzK+KRbT1G7U8hc09T9xUH0Gz1GefUcMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Geert,

On 09.12.2024 14:16, Geert Uytterhoeven wrote:
> Hi CLaudiu,
> 
> On Mon, Dec 9, 2024 at 12:14 PM Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
>> On 09.12.2024 12:57, Geert Uytterhoeven wrote:
>>> On Wed, Nov 13, 2024 at 2:35 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>
>>>> The 5P35023 and 5L35035 Versa 3 clock generator variants are different but
>>>> the versaclock3 driver could be used with small adjustments. The features
>>>> that are implemented in driver and differs b/w variants are the PLL2 Fvco
>>>> and clock sel bit for SE2 clock. Adjust the driver to prepare for the
>>>> addition of 5L35023 device.
>>>>
>>>> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>
>>> Thanks for your patch!
>>>
>>>> --- a/drivers/clk/clk-versaclock3.c
>>>> +++ b/drivers/clk/clk-versaclock3.c
>>>> @@ -166,12 +167,17 @@ struct vc3_div_data {
>>>>  struct vc3_hw_data {
>>>>         struct clk_hw hw;
>>>>         struct regmap *regmap;
>>>> -       const void *data;
>>>> +       void *data;
>>>>
>>>>         u32 div_int;
>>>>         u32 div_frc;
>>>>  };
>>>
>>>> @@ -698,8 +706,6 @@ static struct vc3_hw_data clk_pll[] = {
>>>>                         .num = VC3_PLL2,
>>>>                         .int_div_msb_offs = VC3_PLL2_FB_INT_DIV_MSB,
>>>>                         .int_div_lsb_offs = VC3_PLL2_FB_INT_DIV_LSB,
>>>> -                       .vco_min = VC3_PLL2_VCO_MIN,
>>>> -                       .vco_max = VC3_PLL2_VCO_MAX
>>>>                 },
>>>>                 .hw.init = &(struct clk_init_data) {
>>>>                         .name = "pll2",
>>>
>>>> @@ -1029,9 +1037,16 @@ static int vc3_probe(struct i2c_client *client)
>>>>                                              clk_pfd[i].hw.init->name);
>>>>         }
>>>>
>>>> +       data = i2c_get_match_data(client);
>>>> +
>>>>         /* Register pll's */
>>>>         for (i = 0; i < ARRAY_SIZE(clk_pll); i++) {
>>>>                 clk_pll[i].regmap = regmap;
>>>> +               if (i == VC3_PLL2) {
>>>> +                       struct vc3_pll_data *pll_data = clk_pll[i].data;
>>>> +
>>>> +                       pll_data->vco = data->pll2_vco;
>>>
>>> You cannot modify the global clk_pll[] data, as it is shared when
>>> there are multiple instances.
>>
>> By "multiple instances" do you mean, multiple versa3 devices using this
>> driver? Do you know if we have such a board integrated, ATM?
> 
> Exactly.
> Currently there are no such (upstream) users for 5p35023,
> but e.g. the Beacon RZ/G2M kit has two 5p49v6965 instances.

Are you OK with keeping it as is for the RZ/G3S SSIF support and returning
back later with a solution for the scenario you pointed out? Although, ATM,
I don't have a board to test it.

Thank you,
Claudiu

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

