Return-Path: <linux-kernel+bounces-319458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC6F96FCC5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 22:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08A251C25ABF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 20:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18151D7E52;
	Fri,  6 Sep 2024 20:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="N9t3LUm0"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189461D6DC5
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 20:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725654558; cv=none; b=gjU7S/JROTF5jbmk2R9WAtJxNJmFtZbC320IeOny6UVpWshep04EexEf8WsPyxQ6hVFDQN/417b4Enrf2JcS/iPkcNfmCnrolI7lUuz4zat4B1XPUg1+09T4YDVfEm83Q/YfdgqikVXOB827UB4yFhzbzE2wE477AiI98UCotxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725654558; c=relaxed/simple;
	bh=Au4J4GA+6DOM0usuFdEhi0zOlTVgSXfd9YtOKjaxc60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pNt1Qw6TVjbeKKyrjt6LaqdThP15mFWLjso5C7wYOvIc6wCV+gwtim1F0kJINmf4I1rez0Fn4TVu7A4eKi+QNpgqGP79q/vdtzN6tGgED8otcXMZyovXevxbpBcIVlhFBDCDvkfHwE5NN4ZkdZUYTYmzF3+7QcL7GgYwEDndccc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=fail smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=N9t3LUm0; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 725E0BFB15;
	Fri,  6 Sep 2024 22:29:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1725654545; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=YisR86D+NPklZUoC/AmUcCo2cdDFV+U2ayj19qG5cA4=;
	b=N9t3LUm09IZvtC9KYG6JseREc+K9Qa4H9A5i2sDw1T/G69Ql4QKvXoyU4RSTFf+BxliUSg
	63gtcXAy0/hbR+JhfxMC6Bbm80BCb0W0rpmwZ3X91CLa9iTfYlHrMC6Yv2GDpCc/N//eEB
	B0yX+ZBxBt8TGjPAyZfwvtbM2OdYWw3PxCRNJFCPQXz9X5WpZbp/SrdVt1ugpQe7947aID
	aln46o1pEacIboFUfgBw/GlkF1XXWErOlJ9dHepr5/5wNpfdr1yfx5QN7oBAnExGcrEtZj
	5AIcXQN5els7ZWeZTF62XhLkrB1oyxVmQwuNvJ/86qDXO9dJCLOUwM6bpmSn3Q==
Message-ID: <ada922ea-b307-4ccf-9e2d-9a2a08fb97c1@fris.de>
Date: Fri, 6 Sep 2024 22:28:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 4/5] phy: freescale: fsl-samsung-hdmi: Use closest
 divider
To: Adam Ford <aford173@gmail.com>,
 Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc: linux-phy@lists.infradead.org, linux-imx@nxp.com, festevam@gmail.com,
 frieder.schrempf@kontron.de, aford@beaconembedded.com, Sandor.yu@nxp.com,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Marco Felsch <m.felsch@pengutronix.de>, Lucas Stach
 <l.stach@pengutronix.de>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
References: <20240904233100.114611-1-aford173@gmail.com>
 <20240904233100.114611-5-aford173@gmail.com>
 <ZtpMPCHBnEgtkBWp@atmark-techno.com>
 <CAHCN7xLo1RgkUPTdTpCtKjnT7w=gPDCfe_ZEbKj0joVvLG02Dw@mail.gmail.com>
Content-Language: en-GB, de-DE
From: Frieder Schrempf <frieder@fris.de>
In-Reply-To: <CAHCN7xLo1RgkUPTdTpCtKjnT7w=gPDCfe_ZEbKj0joVvLG02Dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 06.09.24 02:57, Adam Ford wrote:
> On Thu, Sep 5, 2024 at 7:26 PM Dominique Martinet
> <dominique.martinet@atmark-techno.com> wrote:
>>
>>
>> (sorry I meant to send this yesterday but I'm being forced to adjust my
>> mail pipeline with work and gmail and it didn't go out -- trying
>> again. Sorry if it actually did go through. Hopefully I didn't misfire
>> anything else yesterday...)
>>
>> Adam Ford wrote on Wed, Sep 04, 2024 at 06:30:32PM -0500:
>>> Currently, if the clock values cannot be set to the exact rate,
>>> the round_rate and set_rate functions use the closest value found in
>>> the look-up-table.  In preparation of removing values from the LUT
>>> that can be calculated evenly with the integer calculator, it's
>>> necessary to ensure to check both the look-up-table and the integer
>>> divider clock values to get the closest values to the requested
>>> value.  It does this by measuring the difference between the
>>> requested clock value and the closest value in both integer divider
>>> calucator and the fractional clock look-up-table.
>>>
>>> Which ever has the smallest difference between them is returned as
>>> the cloesest rate.
>>>
>>> Signed-off-by: Adam Ford <aford173@gmail.com>
>>> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
>>
>> b4 (or whatever you're using) probably picked that up from the patch I
>> included in my reply to this patch, this sob should go away.
>>
> For each iteration, I grabbed the patches from patchwork which
> contained any s-o-b messages, if present.  I didn't add anything
> manually.
>>
>>
>>> diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
>>> index 4b13e386e5ba..9a21dbbf1a82 100644
>>> --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
>>> +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
>>> @@ -547,6 +547,16 @@ static unsigned long phy_clk_recalc_rate(struct clk_hw *hw,
>>>        return phy->cur_cfg->pixclk;
>>>   }
>>>
>>> +static u32 fsl_samsung_hdmi_phy_get_closest_rate(unsigned long rate,
>>> +                                              u32 int_div_clk, u32 frac_div_clk)
>>> +{
>>> +     /* The int_div_clk may be greater than rate, so cast it and use ABS */
>>> +     if (abs((long)rate - (long)int_div_clk) < (rate - frac_div_clk))
>>
>> I still think `rate - frac_div_clk` might not always hold in the future
>> (because there is no intrinsic reason we'd pick the smaller end in case
>> of inexact match and a future improvement might change this to the
>> closest value as well), so I'll argue again for having both use abs(),
>> but at least there's only one place to update if that changes in the
>> future now so hopefully whoever does this will notice...
> 
> I can add the ABS on the fractional divider.  I left it out on purpose
> since the LUT table always return a value equal or less, so the extra
> ABS seemed like busy work.  However, I can see the argument for being
> consistent.
> 
>>
>>> +             return int_div_clk;
>>> +
>>> +     return frac_div_clk;
>>> +}
>>> +
>>>   static long phy_clk_round_rate(struct clk_hw *hw,
>>>                               unsigned long rate, unsigned long *parent_rate)
>>>   {
>>> @@ -563,6 +573,7 @@ static long phy_clk_round_rate(struct clk_hw *hw,
>>>        for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--)
>>>                if (phy_pll_cfg[i].pixclk <= rate)
>>>                        break;
>>> +
>>
>> (unrelated)
> 
> I don't understand what you're asking here.
> 
>>
>>>        /* If the rate is an exact match, return it now */
>>>        if (rate == phy_pll_cfg[i].pixclk)
>>>                return phy_pll_cfg[i].pixclk;
>>> @@ -579,8 +590,7 @@ static long phy_clk_round_rate(struct clk_hw *hw,
>>>        if (int_div_clk == rate)
>>>                return int_div_clk;
>>>
>>> -     /* Fall back to the closest value in the LUT */
>>> -     return phy_pll_cfg[i].pixclk;
>>> +     return fsl_samsung_hdmi_phy_get_closest_rate(rate, int_div_clk, phy_pll_cfg[i].pixclk);
>>>   }
>>>
>>>   static int phy_clk_set_rate(struct clk_hw *hw,
>>> @@ -594,27 +604,37 @@ static int phy_clk_set_rate(struct clk_hw *hw,
>>>
>>>        /* If the integer divider works, just use it */
>>
>> I found this comment a bit confusing given the current flow as of this
>> patch. Might make more sense immediately before the if?
>>
> 
> This code evolved with each iteration, but I didn't necessarily
> reorganize the comments.  I can rearrange them.
>>
>>>        int_div_clk = fsl_samsung_hdmi_phy_find_pms(rate * 5, &p, &m, &s) / 5;
>>> +     calculated_phy_pll_cfg.pixclk = int_div_clk;
>>> +     calculated_phy_pll_cfg.pll_div_regs[0] = FIELD_PREP(REG01_PMS_P_MASK, p);
>>> +     calculated_phy_pll_cfg.pll_div_regs[1] = m;
>>> +     calculated_phy_pll_cfg.pll_div_regs[2] = FIELD_PREP(REG03_PMS_S_MASK, s-1);
>>> +     phy->cur_cfg = &calculated_phy_pll_cfg;
>>>        if (int_div_clk == rate) {
>>>                dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: using integer divider\n");
>>> -             calculated_phy_pll_cfg.pixclk = int_div_clk;
>>> -             calculated_phy_pll_cfg.pll_div_regs[0] = FIELD_PREP(REG01_PMS_P_MASK, p);
>>> -             calculated_phy_pll_cfg.pll_div_regs[1] = m;
>>> -             calculated_phy_pll_cfg.pll_div_regs[2] = FIELD_PREP(REG03_PMS_S_MASK, s-1);
>>> -             /* pll_div_regs 3-6 are fixed and pre-defined already */
>>
>> nitpick: might want to keep the above comment?
> 
> ok.
>>
>>> -             phy->cur_cfg  = &calculated_phy_pll_cfg;
>>> +             goto done;
>>>        } else {
>>>                /* Otherwise, search the LUT */
>>> -             dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: using fractional divider\n");
>>> -             for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--)
>>> -                     if (phy_pll_cfg[i].pixclk <= rate)
>>> +             for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--) {
>>> +                     if (phy_pll_cfg[i].pixclk == rate) {
>>> +                             dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: using fractional divider\n");
>>
>> nitpick: might make sense to print what was picked in case of inexact
>> match as well, but these are dbg warning so probably fine either way.
> 
> I can add the actual values returned.
> 
>>
>>
>> overall I find the flow of this function hard to read; it's a bit ugly
>> flow-wise but jumping in the clock comparison 'if' might help trim this?
>> (and if we're going out of our way to factor out the diff, maybe the lut
>> lookup could be as well)
>>
>> But I'm probably just being overcritical here, it's fine as is if you
>> pefer your version, just writing down this as an illustration of what I
>> meant with the above sentence as I'm not sure I was clear -- I'll be
>> just as happy to consider this series done so we can do more interesting
>> things :P
> 
> Now I am a bit more confused, because above I got the impression you
> were withdrawing your s-o-b, but now it sounds like you want to move
> it forward.
> 
> It sounded like Frieder was making some progress on understanding a
> little more about the fractional divider.

I think I managed to get behind the calculation of the fractional-n 
divider parameters. I came up with a spreadsheet to calculate the output 
frequency from existing register values and I have a crude Python script 
that can be used to search for parameters for a given pixel clock.

I tested this with three different non-CEA-861 pixel clock values 
(supported by my HDMI USB grabber) for which the integer PLL yielded 
deviations >0.5%. With the new LUT entries those modes work now.

I will clean things up a bit and then share what I have. I hope that 
this allows anyone to calculate parameters for their non-standard 
displays if required.

If someone feels extra motivated they could try to calculate the 
fractional parameters at runtime. However I'm not sure that this is 
feasible. The numerical computation of a large number of parameters is 
quite heavy and it's probably not easy to strip the algorithm down to 
something that can be run on the target without too much overhead.

> 
>>
>> {
>>      u32 int_div_clk, frac_div_clk;
>>      int i;
>>      u16 m;
>>      u8 p, s;
>>
>>      // (I haven't given up on that *5 to move inside this function...)
> 
> I wanted to keep the PMS calculator returning the real clock value
> since the calculations are based on equation in the ref manual, Fpll =
> Fref * M / (P*S)
> This way, the calling function can determine if it needs to be
> multiplied by 5.  I haven't fully determined how the fractional
> calculator determines what frequency it wants for a target frequency,
> and using the values for P, M and S from the fractional divider
> doesn't seem to always yield 5x like they did for the table entries
> using the integer divider.

For what I found out the factor of 5 always applies. For the integer 
part and also for the fractional part.

> 
> I am hoping someone from NXP can elaborate, or give us some clues on
> how to get better fractional divider values.


