Return-Path: <linux-kernel+bounces-340039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42267986DDF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0574B221AB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38E7191F6E;
	Thu, 26 Sep 2024 07:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="afJVYSFA"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD7E18E361
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 07:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727336586; cv=none; b=tRzAgN9dJdm1Pn7ATiMAMW/C48ulam6LaB/uBAaRIacDa2EtTJidjMZ+spWAnNk0Clfp57FNLopN+vspxsVD5jqsseoGB2Bw/XG58/Kfp5RF4yML0hfPymw9Em7FEdDPGU+rFSn2csyOjzOk0JPHxaxJUWzgGCxq9Io9qfvJ0mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727336586; c=relaxed/simple;
	bh=+nnlS1M7aeM09zElGK7XTOGlyP0eEhDm1RTB4QdNMaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GeXwW4f9kbnOLGgQBmwJsbR23PonUmRcOq06ejcu6mAFV9wkdtEkQ/xBA7D1prFXeEr548/Z9ED7Dzjt0+MYKyfFHCcpDMYTMntv5VmJqVlO70p83AvvA5lyUEH3IPXQ0FGZzM7AMRWOipekLOWmoB/OY1kwAVsFdxx69oczBLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=afJVYSFA; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-378c16a4d3eso644606f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 00:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1727336582; x=1727941382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QQkR69sKp8Yewhrmn8jwB2Hc/tFxgtKhEZk1YzyJXlA=;
        b=afJVYSFATHBbbVO7Ijr+9+h80yLpKn5fxkC4yIcJn/ryeSva7/RWhr4aH5fuqCL3sA
         sEYSEesWnKNsgec3CWOu441EX6Z2YbFjYxaiWMa9LDswInMoQJ47wYd6JBYJic0XFGaO
         uGGh26Xzvv4IHpaYJBRPiMjbsXEQ3V+uxDGB5gMqNLlKa8loIyrMHNlPGZrjjbhSfAD/
         UF0pbIaNCJqjwUrMpArrCVYxXdHmpFgZ8sf6FPuI363To0GJCo40y9DdQ1H7skqfdVAF
         dof8CUjXX6/8au/Q+3V+AmOneYbIuCRYlcoN+4OoZ4R6dCxmL41mVJbBgiKOYPoNjZHr
         c8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727336582; x=1727941382;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QQkR69sKp8Yewhrmn8jwB2Hc/tFxgtKhEZk1YzyJXlA=;
        b=vN/6L3lpEDK+E+JwcPGpgVrJhvsExSUXrEqYqUjyrvEoKurCRiyE12P59lV3Ssfh1b
         aY85DUSmi9aNffCfkgP85k2SLYsyEjuGb7txMPciOgYaOuqkB2MNeOAZGL9nbnKWLYx+
         WGhkYzLkIoo3kgaOQyNX9YB+Q1DT5tOK4nDRAbj4jNHBmpH2nkGkCQfZGFhbEEO3aQ9W
         JUGGDhYcT9tTT95wH2hrzaxoTgCoR8KMc3GcclAe2LLASN77vBvimqpQEdASkgzT9oV8
         oiKGlxyF1kU6DX57x5docBCarOD7iHEfQIjrjhSQSmFhP5w1QMJfEnJKGC1wQXvyzUew
         KLwg==
X-Forwarded-Encrypted: i=1; AJvYcCVK8+cOtlmPcLoqfLJXY7jglsigeAQMMADuZLjsp8X/dDHN8PSlkoDAH4VOSSGPjY/9szqBAGqEjGQentA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyI2tvKmbdFMP2H+dYPKpIl2XF+E6X2zIISnhulatgCGPZa80o
	KxBTwjngqEzu4kgxkB71o/OHUt2t0XH3P2WQVp9tzDss0mreBdSFdT5mAWceno4=
X-Google-Smtp-Source: AGHT+IHBv+8cCJ4P//uZgQU9mGKQlD7W6/9RP/K5Q7QoHFn/s97lU6vtCpnQ8hrmoZ5KSMACjGqOMw==
X-Received: by 2002:adf:fbcc:0:b0:374:c44e:ef27 with SMTP id ffacd0b85a97d-37cc245dd30mr4407870f8f.8.1727336581837;
        Thu, 26 Sep 2024 00:43:01 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ccd370ab7sm1819223f8f.25.2024.09.26.00.43.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 00:43:01 -0700 (PDT)
Message-ID: <e6c10efa-0ed6-4040-8fe2-e83d3903547a@tuxon.dev>
Date: Thu, 26 Sep 2024 10:42:59 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/12] clk: at91: sam9x60: Allow enabling main_rc_osc
 through DT
Content-Language: en-US
To: Ryan Wanner <ryan.wanner@microchip.com>, ada@thorsis.com
Cc: Conor Dooley <conor+dt@kernel.org>,
 "moderated list:ARM/Microchip (AT91) SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
 Rob Herring <robh@kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Christian Melki <christian.melki@t2data.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>
References: <20240821105943.230281-1-ada@thorsis.com>
 <20240821105943.230281-10-ada@thorsis.com>
 <20240919-outsider-extending-e0a926bd23fa@thorsis.com>
 <464f599a-7f0b-4e4e-901a-8f88a25428d6@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <464f599a-7f0b-4e4e-901a-8f88a25428d6@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan, Alexander,

Sorry for returning late, I took some time to think about it...

On 24.09.2024 18:52, Ryan Wanner wrote:
> Hello Alex,
> 
> I think a possible solution is to put the DT binding ID for main rc oc
> after PMC_MCK and then add 1 to all the other IDs that are not dependent
> on PMC_MAIN, the IDs that are before the branch for the sama7g54.

If I understand correctly, wouldn't this shift also the rest of the IDs
and break the DT ABI?

> 
> One issue I see with this solution is with SoCs that do not want the
> main rc os exported to the DT the driver array might be allocating too
> much memory, this can be solved by removing the +1 that is in the clock
> drivers next to the device tree binding macro, since this macro is now
> increased by 1 with this change.
> 
> Doing a quick test on the sam9x60 and sama7g54 I did not see any glaring
> issues with this potential solution.
> 
> Best,
> 
> Ryan
> 
> 
> On 9/19/24 05:39, Alexander Dahl wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> Hello Claudiu,
>>
>> after being busy with other things, I'm back looking at this series.
>> As Nicolas pointed out [1], we need three clocks for the OTPC to work,
>> quote:
>>
>>   "for all the products, the main RC oscillator, the OTPC peripheral
>>   clock and the MCKx clocks associated to OTP must be enabled."
>>
>> I have a problem with making the main_rc_osc accessible for both
>> SAM9X60 and SAMA7G5 here, see below.
>>
>> Am Wed, Aug 21, 2024 at 12:59:40PM +0200 schrieb Alexander Dahl:
>>> SAM9X60 Datasheet (DS60001579G) Section "23.4 Product Dependencies"
>>> says:
>>>
>>>     "The OTPC is clocked through the Power Management Controller (PMC).
>>>     The user must power on the main RC oscillator and enable the
>>>     peripheral clock of the OTPC prior to reading or writing the OTP
>>>     memory."
>>>
>>> The code for enabling/disabling that clock is already present, it was
>>> just not possible to hook into DT anymore, after at91 clk devicetree
>>> binding rework back in 2018 for kernel v4.19.
>>>
>>> Signed-off-by: Alexander Dahl <ada@thorsis.com>
>>> ---
>>>  drivers/clk/at91/sam9x60.c       | 3 ++-
>>>  include/dt-bindings/clock/at91.h | 1 +
>>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
>>> index e309cbf3cb9a..4d5ee20b8fc4 100644
>>> --- a/drivers/clk/at91/sam9x60.c
>>> +++ b/drivers/clk/at91/sam9x60.c
>>> @@ -207,7 +207,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
>>>       if (IS_ERR(regmap))
>>>               return;
>>>
>>> -     sam9x60_pmc = pmc_data_allocate(PMC_PLLACK + 1,
>>> +     sam9x60_pmc = pmc_data_allocate(PMC_MAIN_RC + 1,
>>>                                       nck(sam9x60_systemck),
>>>                                       nck(sam9x60_periphck),
>>>                                       nck(sam9x60_gck), 8);
>>> @@ -218,6 +218,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
>>>                                          50000000);
>>>       if (IS_ERR(hw))
>>>               goto err_free;
>>> +     sam9x60_pmc->chws[PMC_MAIN_RC] = hw;
>>>
>>>       hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name, NULL, 0);
>>>       if (IS_ERR(hw))
>>> diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
>>> index 3e3972a814c1..f957625cb3ac 100644
>>> --- a/include/dt-bindings/clock/at91.h
>>> +++ b/include/dt-bindings/clock/at91.h
>>> @@ -25,6 +25,7 @@
>>>  #define PMC_PLLBCK           8
>>>  #define PMC_AUDIOPLLCK               9
>>>  #define PMC_AUDIOPINCK               10
>>> +#define PMC_MAIN_RC          11
>>>
>>>  /* SAMA7G5 */
>>>  #define PMC_CPUPLL           (PMC_MAIN + 1)
>>
>> There are IDs defined in the devicetree bindings here, which are used
>> both in dts and in driver code as array indexes.  In v1 of the patch
>> series I just added a new last element in the end of the generic list
>> and used that for SAM9X60.
>>
>> For SAMA7G5 those IDs are branched of from PMC_MAIN in between, making
>> SAMA7G5 using a different last element, and different values after
>> PMC_MAIN.

Looking at it now, I think it was a bad decision to do this branch.
Thinking at it maybe it would be better to have per SoC specific bindings
to avoid this kind of issue in future. The PMC IP b/w different SAM SoCs is
anyway different and, as it happens now, we may reach to a point where, due
to issues in datasheet, or whatever human errors, we may reach this problem
again.

So, what do you think about having separate binding files for each SoC?

Another option would be to xlate the clocks not by directly indexing in
struct pmc_data::chws but by matching the driver clock ID and DT provided
id. This will increase the lookup time, from O(1) to O(N), N being 13 for
SAMA7G5, 15 for SAM9X7 and SAMA7D55. And will need adjustment at least for
SAM9X{60, 7} and SAMA7{G5, D55}. With this the of_clk_hw_pmc_get() will be
something like:

diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index 5aa9c1f1c886..22191d1ca78b 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -52,8 +52,10 @@ struct clk_hw *of_clk_hw_pmc_get(struct of_phandle_args
*clkspec, void *data)

        switch (type) {
        case PMC_TYPE_CORE:
-               if (idx < pmc_data->ncore)
-                       return pmc_data->chws[idx];
+               for (int i = 0; i < pmc_data->ncore; i++) {
+                       if (pmc_data->chws.idx[i] == i)
+                               return pmc_data->chws.hws[i];
+               }
                break;


diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 4fb29ca111f7..f7e88f9872dc 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -19,7 +19,10 @@ extern spinlock_t pmc_pcr_lock;

 struct pmc_data {
        unsigned int ncore;
-       struct clk_hw **chws;
+       struct {
+               struct clk_hw **hws;
+               int *idx;
+       } chws;

Thank you,
Claudiu Beznea

>>
>> Now we need a new ID for main rc osc, but not only for SAM9X60, but
>> also for SAMA7G5.  I'm not sure what the implications would be, if the
>> new ID would be added in between before PMC_MAIN, so all values would
>> change?  Adding it to the end of the lists would probably be safe, but
>> then you would need a diffently named variant for SAMA7G5's different
>> IDs.  I find the current status somewhat unfortunate for future
>> extensions.  How should this new ID be added here?  What would be the
>> way forward?
>>
>> Greets
>> Alex
>>
>> [1] https://lore.kernel.org/linux-clk/ec34efc2-2051-4b8a-b5d8-6e2fd5e08c28@microchip.com/T/#u
>>
>>> --
>>> 2.39.2
>>>
>>>
>>
> 

