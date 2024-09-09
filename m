Return-Path: <linux-kernel+bounces-320705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E50F9970EC4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1471C21EBF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 07:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81E41AD9F1;
	Mon,  9 Sep 2024 07:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="JreNt7ly"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F701AD9E2
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 07:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725865675; cv=none; b=tUNGkBNw93eWk2CdO37KSQd0Xdi+HxR/pCi2qXHsdxBYmjHeaMMclA7D2csnb14vVQ6i0sgyOrbS453UQPxbRMTyEwzrKq8gMXQncxvqTjDtzaufEN40m5D6mIg8Yqgz8RDNeEu4zrtgBcxXu7hSl4v53qgCaB6iqdFS+uQXilU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725865675; c=relaxed/simple;
	bh=5HdLRdwgILWy7NijZoXcTvZcLW7MCGW7u1wIqNnq2HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XUZ5dui6n3iZ2O0APocx7IUyR3ERN46tIXVr/NaIhlIwIFDR1q0BhphPWIhFklAAVH7LNRi5ML5/XVnei1jhhisBh5hlT4pW6EWJik7xJ96Cp1tQ9fVG/U+B86sD3/2U3SNp9oB0S7PhuOFUy6qIYL0wn/hx+CBw20ZKXcpFCEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=JreNt7ly; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8d29b7edc2so218849666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 00:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1725865671; x=1726470471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pO9t18GD+i5fBFY4VXd+D6OTewDWbOLXCFnosdNxa/U=;
        b=JreNt7lyzxS0F0xzkYhAojq1HAEl5JY5kGxT+3lsH3yItYb+MJ3v8a9fEcTVtJREzl
         2B6Zau+t47PzUzM7j8E6ISifRPDq3l/sbD17EKaFRuTFqch/k3fIERrYo4C6NR+SNT5p
         fnRMnpoIF6HdSsRs2zwNRJSvJdVIf23PFKra0ASGl3/9qzZJhO/4DoHRtKr8+xJ0pn57
         QHdxGSA0rgy3k85PT5sGmPpM9sGlu8V0Tft+oAhVszv9sWRdV5u4jpkFFbJpJTsqc/BX
         IZkK9gv3tEWw+yqu0c8N0sibPmwjypeo8+FCJkRK4B7jzKeJBvqObELKU1fM3oliVpEl
         KblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725865671; x=1726470471;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pO9t18GD+i5fBFY4VXd+D6OTewDWbOLXCFnosdNxa/U=;
        b=t/dMjQTfDzFkIGeYoBiGRDyYH/a5lLf5UlPbopV3mYJBwbxM3OLzKPnUDesBfNCMgX
         cKEXAKVF1mPyRnPNtGdICXzMELG0Yh7lTygXtaHv9dczthCFYh/u5di2REj3YTdBHLm7
         clPAdqdJ5lQUS2s3EF1JJAM6z4ZfoKBqbCpt8CfPiQqGCAFpZoDzQagcP2ToXZHEvmvp
         iRtXvmUdbvw0sxMfmJkP/nOo/n5wEG6oLBHlOUTlrI27XDjtv4gs6LTuGz8jWiqmM3bl
         QQqakY9+cl7rNJthyKmvCWmu0Ai02H7tJaq1DABshU4IAJtxUVzV+RVrVte9Jp42ZnRr
         Q9XQ==
X-Gm-Message-State: AOJu0Yx68lIQ9XUBApsjIeVC734YA/YxPuJ5uPEFBHVh66w1TwyleWJa
	hBT0q099KQGjljRry5MAURIivJPbtoqS2oDd+oSSBKS8AMWPY+Yui2o0+qwbOr4=
X-Google-Smtp-Source: AGHT+IEzFtJpDjpFcpaOK3zi2wC6+pmxuHOiV7xQ9M52ggf8MDENIzb7c111uhTAimm5UAc+Fb65+g==
X-Received: by 2002:a17:907:7421:b0:a8a:8d81:97a8 with SMTP id a640c23a62f3a-a8a8d81aa63mr707722566b.1.1725865670935;
        Mon, 09 Sep 2024 00:07:50 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d40064sm297908166b.190.2024.09.09.00.07.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 00:07:50 -0700 (PDT)
Message-ID: <503ed037-a16c-41b0-bb13-4ea11fcd2362@tuxon.dev>
Date: Mon, 9 Sep 2024 10:07:48 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] phy: renesas: rcar-gen3-usb2: Fix an error handling
 path in rcar_gen3_phy_usb2_probe()
Content-Language: en-US
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>
References: <4efe2d0419cbe98163e2422ebe0c7896b8a5efed.1725717505.git.christophe.jaillet@wanadoo.fr>
 <TY3PR01MB113468D1573C1E50AC9F97DCF86982@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <d01bed96-7811-4ace-8b92-1ee9fafac649@wanadoo.fr>
 <TY3PR01MB113466A2B99EE80E8BB0A94AD86992@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <TY3PR01MB113466A2B99EE80E8BB0A94AD86992@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 09.09.2024 09:00, Biju Das wrote:
> Hi Christophe JAILLET,
> 
>> -----Original Message-----
>> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> Sent: Sunday, September 8, 2024 5:59 PM
>> Subject: Re: [PATCH v2] phy: renesas: rcar-gen3-usb2: Fix an error handling path in
>> rcar_gen3_phy_usb2_probe()
>>
>> Le 08/09/2024 à 18:39, Biju Das a écrit :
>>> Hi Christophe JAILLET,
>>>
>>> Thanks for the patch.
>>>
>>>> -----Original Message-----
>>>> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>>> Sent: Saturday, September 7, 2024 2:59 PM
>>>> Subject: [PATCH v2] phy: renesas: rcar-gen3-usb2: Fix an error
>>>> handling path in
>>>> rcar_gen3_phy_usb2_probe()
>>>>
>>>> If an error occurs after the rcar_gen3_phy_usb2_init_bus(),
>>>> reset_control_assert() must be called, as already done in the remove function.
>>>>
>>>> This is fine to re-use the existing error handling path, because even
>>>> if "channel->rstc" is still NULL at this point, it is safe to call reset_control_assert(NULL).
>>>>
>>>> Fixes: 4eae16375357 ("phy: renesas: rcar-gen3-usb2: Add support to
>>>> initialize the bus")
>>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>>> ---
>>>> Changes in v2:
>>>>    - Re-use 'error' to simplify the patch   [claudiu beznea]
>>>>    - Update the commit description to explain why it is safe.
>>>>
>>>> v1:
>>>> https://lore.kernel.org/all/fc9f7b444f0ca645411868992bbe16514aeccfed.
>>>> 1725652654.git.christophe.jaillet
>>>> @wanadoo.fr/
>>>> ---
>>>>   drivers/phy/renesas/phy-rcar-gen3-usb2.c | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
>>>> b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
>>>> index 58e123305152..ccb0b54b70f7 100644
>>>> --- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
>>>> +++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
>>>> @@ -803,6 +803,7 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
>>>>   	return 0;
>>>>
>>>>   error:
>>>> +	reset_control_assert(channel->rstc);
>>>
>>> This will result in either kernel crash [1] or reset usage count
>>> imbalance in case of error [2] and [3] in
>>> rcar_gen3_phy_usb2_init_bus() see [4]. Also reset control API is not
>>> respected for SoCs other than RZ/G3S. For those SoC's reset assert is
>>> called without calling a get(). Maybe add a check (phy_data->init_bus)
>>> for assert api's, that guarantees assert is called after calling a get() as it valid only for
>> RZ/G3S??
>>>
>>> [1]
>>> channel->rstc = devm_reset_control_array_get_shared(dev);
>>> 	if (IS_ERR(channel->rstc))
>>> 		return PTR_ERR(channel->rstc);
>>>
>>> [2]
>>> ret = pm_runtime_resume_and_get(dev);
>>> 	if (ret)
>>> 		return ret;
>>> [3]
>>> ret = reset_control_deassert(channel->rstc);
>>> 	if (ret)
>>> 		goto rpm_put;

Indeed, I missed that. Thank you, Biju, for pointing it out.

>>>
>>> [4]
>>> https://elixir.bootlin.com/linux/v6.11-rc6/source/drivers/reset/core.c
>>> #L483
>>
>> So, if I understand correctly, v1 [5] was correct. :)
> 
> Yes, I agree v1 [5] is correct, if we ignore "reset control API is not respected for SoCs".
> 
> Another solution could be using action_or_reset() for cleanup for
> rcar_gen3_phy_usb2_init_bus(), so that it is applicable only for RZ/G3S??

That seems like a cleaner solution to me.

Thank you,
Claudiu Beznea

> 
> Cheers,
> Biju
> 
>>
>>
>> I don't think that [1] would crash, because of [6]. It would only WARN_ON. But with v1, it is not
>> called.
>>
>> With v1, reset_control_assert() is not called if
>> rcar_gen3_phy_usb2_init_bus() fails. So [2] and [3] can't occur.
>>
>> I can send a v3, which is the same of v1, or you can pick v1 as-is (if I'm correct... :)) or you can
>> just ignore it if "reset control API is not respected for SoCs".
>>
>>
>> If of interest, I spotted it with one of my coccinelle script that compares functions called
>> in .remove function, but not in error handling path of probe.
>>
>>
>> CJ
>>
>> [5]:
>> https://lore.kernel.org/all/fc9f7b444f0ca645411868992bbe16514aeccfed.1725652654.git.christophe.jaillet
>> @wanadoo.fr/
>>
>> [6]:
>> https://elixir.bootlin.com/linux/v6.11-rc6/source/drivers/reset/core.c#L473
>>
>>>
>>> Cheers,
>>> Biju
>>>
>>>>   	pm_runtime_disable(dev);
>>>>
>>>>   	return ret;
>>>> --
>>>> 2.46.0
>>>>
>>>
>>>
>>>
> 

