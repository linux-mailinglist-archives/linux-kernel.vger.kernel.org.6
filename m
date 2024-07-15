Return-Path: <linux-kernel+bounces-252246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFA9931085
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26E871F22511
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 08:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8EF187327;
	Mon, 15 Jul 2024 08:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="I8MmniB7"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5807186E50
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 08:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721033061; cv=none; b=MXIc6EZ3iV7FvNu6NqgTgSTNPhoGoq5aBnsMXFiLXCPDzZBaFZhBqnclKncoQrFRVtML6wIQgQV76rlkGCppnuenXCpVyE/WT8sfeJb5Y+xCcRzBso2SL5BqMqC/0/3AIaBZ/ASwQCelbsG7+A0vj6OZkgZ+2l7GOkEgNQJ2PEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721033061; c=relaxed/simple;
	bh=ioJwmCwEIVCH6O2g8AfPZFZgHDKJSuHyo52Rd8aRs8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rZkONJ5N6qCOc4cwH25HLmFQpH3LplGy7WMFy0YMxR5YNIETOfj7YCuf1Wte+b80i6/hAddnmUkPTrLwMP2g5uWiA/7pAfDO7WirwLNPALyIl1DBYB1klgSN932DcCKsd7+NAIFH1uqjpyc6o45c6LWWBXUlff9Nctb78bfhzR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=I8MmniB7; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4266f3e0df8so27205155e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 01:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1721033058; x=1721637858; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WM0yZ3dZzzFTTxe4hgvAgtIJwKRKDgqcOStwGt2gSJ8=;
        b=I8MmniB7fY2847u0qQ9SZWsxuSmKXRVsE8GPOfKyqbP7kzRdHSQRiZNnQkBkjohpo7
         68Q2+x3aAenv8AKAFERkm0B0LVu5asZlYWz5LpE/Q05K2pB4hSMpy2TJxPVCvA9wucpb
         h3NPHu06GXrbqc9vUcnqUKqkRPoA5iwQ22yJDFi1mVskLrfqRLgoy2KcGIWjVdkC0j8q
         1iaFPyUzzEQB7gA89uBGv0ZscpzDA859QMBOdcS6czkih71ZjIdBP3eOcVqosEObj/Gy
         vviB8NCzqh8n4XgXP4iTI0xkL2nS9vkmtv0Gyp+Gnfa+ToHRtZ/Rd18utXNA5spoGqrR
         Ns5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721033058; x=1721637858;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WM0yZ3dZzzFTTxe4hgvAgtIJwKRKDgqcOStwGt2gSJ8=;
        b=YJnfqaDzdX2gMZ14UdIKWzkBWsueWFxPaMvQXeTn9mJZZjFWjpnuvh6O6/eXrWtP8L
         2xVCEQvLUuVFPwQze+obY0OfL71W5+laXqUnbFjxoolnpSEAv5r+FWFQEYkhSAb0O/2J
         GUFRisC2k6ZZrmZ958NgVXp/cyEtEywrdQgXqj22FBY6iNBdV55KZLH3y/iiv2xPo7Mb
         yPSpQ9UVte3sbLLL5MoX36jpShYRs5aUGbieSJFn/300uAcn1Mv2mWRaHMtFYEqayL4i
         3M04RZSYN818vCK7dxPI5Pbfvx4b+OBxGkNsJkhRJqymJEvkB7CcgW7OYFhA8FGq4Kgl
         pKSw==
X-Forwarded-Encrypted: i=1; AJvYcCVdb1CZypPbwfsBxKv2i5EqfhO+qYp2xvN1pJUtfDeDkC0jJhHZ1N+wMIz8w5BQ5EBo2L+Leii+XY2hxztfR6x2wv16Be87oPrHd/ey
X-Gm-Message-State: AOJu0YysBAO0bdiP/D/Pk5j5CiES2gPUeZeC3/uMltjC/v4m8cxX6mjg
	S9MGJRKJwm38JGqVRXGm2JFurzU2AS6aSEgGDVN6EtPNRwcAdqZV0lwIeWUVwx0=
X-Google-Smtp-Source: AGHT+IGi4ZuAQ/yriu2Z9Cdv2XEyhj7rSOXhNHCWeEiNJIx9fF5ukvI9h0+hmRATjeo6CGGYegYPkw==
X-Received: by 2002:a05:600c:a:b0:426:63b8:2cce with SMTP id 5b1f17b1804b1-426707cc06emr117802385e9.7.1721033058270;
        Mon, 15 Jul 2024 01:44:18 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dabf20dsm5717442f8f.38.2024.07.15.01.44.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 01:44:17 -0700 (PDT)
Message-ID: <0ff64285-8a88-421c-96c3-aa10decc8d05@tuxon.dev>
Date: Mon, 15 Jul 2024 11:44:16 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/27] clk: at91: sam9x7: add sam9x7 pmc driver
Content-Language: en-US
To: Varshini.Rajendran@microchip.com, mturquette@baylibre.com,
 sboyd@kernel.org, Nicolas.Ferre@microchip.com,
 alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240703102011.193343-1-varshini.rajendran@microchip.com>
 <20240703102800.195957-1-varshini.rajendran@microchip.com>
 <ac4fbdb2-013f-40d8-9f92-1b489f172a60@tuxon.dev>
 <ddefd4e4-b719-464b-b8bc-d4d69fa07cf1@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <ddefd4e4-b719-464b-b8bc-d4d69fa07cf1@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Varshini,

On 15.07.2024 09:46, Varshini.Rajendran@microchip.com wrote:
> Hi Claudiu,
> 
> On 14/07/24 7:25 pm, claudiu beznea wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> Hi, Varshini,
>>
>> On 03.07.2024 13:28, Varshini Rajendran wrote:
>>> Add a driver for the PMC clocks of sam9x7 Soc family.
>>>
>>> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
>>> ---
>>>   drivers/clk/at91/Makefile |   1 +
>>>   drivers/clk/at91/sam9x7.c | 946 ++++++++++++++++++++++++++++++++++++++
>>>   2 files changed, 947 insertions(+)
>>>   create mode 100644 drivers/clk/at91/sam9x7.c
>>>

...

>>> +     for (i = 0; i < PLL_ID_MAX; i++) {
>>> +             for (j = 0; j < 3; j++) {
>>
>> I now realize that we are alocating more than needed memory for each PLL in
>> sam9x7_plls[][]. The number of columns for the 2d array is PLL_ID_MAX and
>> it should be 3. I can adjust it when applying but I need you to run a
>> simple boot test with it.
>>
> Yes. It boots and works perfectly with the change suggested. I am 
> pasting the snippet below just to be on the same page.
> 
> --- a/drivers/clk/at91/sam9x7.c
> +++ b/drivers/clk/at91/sam9x7.c
> @@ -198,7 +198,7 @@ static const struct {
>          const struct clk_pll_characteristics *c;
>          unsigned long f;
>          u8 eid;
> -} sam9x7_plls[][PLL_ID_MAX] = {
> +} sam9x7_plls[][3] = {

Great! Thank you!

