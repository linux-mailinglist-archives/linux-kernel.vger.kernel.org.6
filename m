Return-Path: <linux-kernel+bounces-233507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FA391B872
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DDA11C216A8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 07:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FD113FD9D;
	Fri, 28 Jun 2024 07:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Jkn/0ttF"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC9154BD4
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 07:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719559956; cv=none; b=QGaR/5+ai4unfTG1Nk9l0Disd/1FmgqDwA/xJbI6ixmvTCz+yJ2YDC34sb96whozDufF+G+GQznC6LQwqwCLkfI6Cb5Z5uAZ4b9MlTLm4DocdTCUMMCg2DOi0Rx5ijeE4ZRb6Np++WPAR1dOHnDd8C1A4nBLYxXAeg5fPVgJzks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719559956; c=relaxed/simple;
	bh=A401YoRPY2BYXZXMptssJ0+FDFzALUl8OZ77lFAkgzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=twQuyi6WBkjMf+vIp19xmhXuCq9UEpAgi9lVuVDx96nifErHnDtWyy/ApaLjTeaqRqQtKqBBfAUsvBoL2/OdClXsKF1yM2SAeF8cczvHsg55Cpsjx5atTqFGJIzyFMiXEJ7+HQLAbkx1MY9bfEAZOWCLj/NLA7Ct+Lrs6RAvuNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Jkn/0ttF; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-354b722fe81so251441f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 00:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1719559952; x=1720164752; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VSdYYsERq4BglkmF4kqFHjBMai4DxG/z1x2hgxRtp5s=;
        b=Jkn/0ttF1CI2FXescTgDoYlEjfed/AcregGivi1Ddl9fjId7teviDdlhKl/JYaUZtA
         W2MFRoeQ0VtKr/d6dGDU89S411L4ipN8NcLFdroX5zCGUwyxKnDlxAoYe7ALt9CHcgsV
         6tA9vlgDMzcfPHNroIlne4g2HSeKxy9h+/+xNYkT8kbdzmr1vZCoO/LFc0JUAc5JPX7M
         ShB7WC/fARN9U71jhZzIbzJJuPlRXcaDHyr5214int9p/pJw6cFEstAI6KdbmmFj429A
         dJz/srT57YHBZlHpMMe36hGJc3wv86w6Q9knBk6fwvIdBEzoMsqFi3c70Clh+UQc0R/9
         163Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719559952; x=1720164752;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VSdYYsERq4BglkmF4kqFHjBMai4DxG/z1x2hgxRtp5s=;
        b=blyV8OGS8pPo7PsARJlaUZW7gG7+awOypNfa7tjJhr2KqRvvdzrvzs436bRpMiw2td
         X4q74o7Ba1TaSbE2sDDueo8ziBuUgGN6slcOE33xelaco+y+t+9lJpy/nUG+GRQ8JgA1
         PU5pVNtPCC2fc6l+3VjOM9JZSXb3GIbxYbqZ/tVAiZV0o3/fmRN99rvyHcPbl6HBniae
         GbfTvJ5lL3ixctolwbuActdT/HUonNYBdNW6JdyCjLnjULmeaErHAvQ+DtmBkI1LtlsY
         Hbet2O5VKSx1lGFoRbB9t7BJPO+nggI30nf1xExhr66+jBe3GTCqbXzg7dvqvagTSSBa
         WdXA==
X-Forwarded-Encrypted: i=1; AJvYcCXCzA5hNnxtXz1xFuBRSSvwVwEcLEvbU+/VOenkQp9vkC+fCVG7zl95kzNB3cf9vMbpZsUAZBGb4rIkVQOh14UJNZRr3TdnNFJuJNrt
X-Gm-Message-State: AOJu0YxZV0IciksZu8DcFD1YIcSzPDCcycUbnYdNv1ydtTSBRyCwZTFo
	k9XIjRgLwzTOvYPGDjmpI338wE4HhvWY8XFxPk/DTvKzi9Unq0Ikg/K8hco0Foo=
X-Google-Smtp-Source: AGHT+IFt/kJGpdjMPUeslt8Yxh3oy1C0tE/fivaQ2JuElWKWqWkX3ZHZ5uko3ECPJTY2FRQhBkKh7Q==
X-Received: by 2002:adf:f887:0:b0:361:dde2:87a0 with SMTP id ffacd0b85a97d-366e4f0cd03mr10365925f8f.65.1719559952307;
        Fri, 28 Jun 2024 00:32:32 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fc623sm1382868f8f.87.2024.06.28.00.32.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 00:32:31 -0700 (PDT)
Message-ID: <6289f329-118f-4970-a525-75c3a48bd28b@tuxon.dev>
Date: Fri, 28 Jun 2024 10:32:29 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/12] i2c: riic: Define individual arrays to describe
 the register offsets
Content-Language: en-US
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Chris Brandt <Chris.Brandt@renesas.com>,
 "andi.shyti@kernel.org" <andi.shyti@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "geert+renesas@glider.be" <geert+renesas@glider.be>,
 "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>
Cc: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240625121358.590547-1-claudiu.beznea.uj@bp.renesas.com>
 <20240625121358.590547-8-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB11346EF9A001F68162148B70F86D02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <TY3PR01MB11346EF9A001F68162148B70F86D02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Biju,

On 28.06.2024 08:59, Biju Das wrote:
> Hi Claudiu,
> 
>> -----Original Message-----
>> From: Claudiu <claudiu.beznea@tuxon.dev>
>> Sent: Tuesday, June 25, 2024 1:14 PM
>> Subject: [PATCH v2 07/12] i2c: riic: Define individual arrays to describe the register offsets
>>
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Define individual arrays to describe the register offsets. In this way we can describe different IP
>> variants that share the same register offsets but have differences in other characteristics. Commit
>> prepares for the addition of fast mode plus.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>
>> Changes in v2:
>> - none
>>
>>  drivers/i2c/busses/i2c-riic.c | 58 +++++++++++++++++++----------------
>>  1 file changed, 31 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c index
>> 9fe007609076..8ffbead95492 100644
>> --- a/drivers/i2c/busses/i2c-riic.c
>> +++ b/drivers/i2c/busses/i2c-riic.c
>> @@ -91,7 +91,7 @@ enum riic_reg_list {
>>  };
>>
>>  struct riic_of_data {
>> -	u8 regs[RIIC_REG_END];
>> +	const u8 *regs;
> 
> 
> Since you are touching this part, can we drop struct and
> Use u8* as device_data instead?

Patch 09/12 "i2c: riic: Add support for fast mode plus" adds a new member
to struct riic_of_data. That new member is needed to differentiate b/w
hardware versions supporting fast mode plus based on compatible.

Keeping struct riic_of_data is necessary (unless I misunderstood your
proposal).

Thank you,
Claudiu Beznea

> 
> ie, replace const struct riic_of_data *info->const u8 *regs in struct riic_dev
> and use .data = riic_rz_xx_regs in of_match_table?
> 
> Cheers,
> Biju
>>  };
>>
>>  struct riic_dev {
>> @@ -531,36 +531,40 @@ static void riic_i2c_remove(struct platform_device *pdev)
>>  	pm_runtime_dont_use_autosuspend(dev);
>>  }
>>
>> +static const u8 riic_rz_a_regs[RIIC_REG_END] = {
>> +	[RIIC_ICCR1] = 0x00,
>> +	[RIIC_ICCR2] = 0x04,
>> +	[RIIC_ICMR1] = 0x08,
>> +	[RIIC_ICMR3] = 0x10,
>> +	[RIIC_ICSER] = 0x18,
>> +	[RIIC_ICIER] = 0x1c,
>> +	[RIIC_ICSR2] = 0x24,
>> +	[RIIC_ICBRL] = 0x34,
>> +	[RIIC_ICBRH] = 0x38,
>> +	[RIIC_ICDRT] = 0x3c,
>> +	[RIIC_ICDRR] = 0x40,
>> +};
>> +
>>  static const struct riic_of_data riic_rz_a_info = {
>> -	.regs = {
>> -		[RIIC_ICCR1] = 0x00,
>> -		[RIIC_ICCR2] = 0x04,
>> -		[RIIC_ICMR1] = 0x08,
>> -		[RIIC_ICMR3] = 0x10,
>> -		[RIIC_ICSER] = 0x18,
>> -		[RIIC_ICIER] = 0x1c,
>> -		[RIIC_ICSR2] = 0x24,
>> -		[RIIC_ICBRL] = 0x34,
>> -		[RIIC_ICBRH] = 0x38,
>> -		[RIIC_ICDRT] = 0x3c,
>> -		[RIIC_ICDRR] = 0x40,
>> -	},
>> +	.regs = riic_rz_a_regs,
>> +};
>> +
>> +static const u8 riic_rz_v2h_regs[RIIC_REG_END] = {
>> +	[RIIC_ICCR1] = 0x00,
>> +	[RIIC_ICCR2] = 0x01,
>> +	[RIIC_ICMR1] = 0x02,
>> +	[RIIC_ICMR3] = 0x04,
>> +	[RIIC_ICSER] = 0x06,
>> +	[RIIC_ICIER] = 0x07,
>> +	[RIIC_ICSR2] = 0x09,
>> +	[RIIC_ICBRL] = 0x10,
>> +	[RIIC_ICBRH] = 0x11,
>> +	[RIIC_ICDRT] = 0x12,
>> +	[RIIC_ICDRR] = 0x13,
>>  };
>>
>>  static const struct riic_of_data riic_rz_v2h_info = {
>> -	.regs = {
>> -		[RIIC_ICCR1] = 0x00,
>> -		[RIIC_ICCR2] = 0x01,
>> -		[RIIC_ICMR1] = 0x02,
>> -		[RIIC_ICMR3] = 0x04,
>> -		[RIIC_ICSER] = 0x06,
>> -		[RIIC_ICIER] = 0x07,
>> -		[RIIC_ICSR2] = 0x09,
>> -		[RIIC_ICBRL] = 0x10,
>> -		[RIIC_ICBRH] = 0x11,
>> -		[RIIC_ICDRT] = 0x12,
>> -		[RIIC_ICDRR] = 0x13,
>> -	},
>> +	.regs = riic_rz_v2h_regs,
>>  };
>>
>>  static int riic_i2c_suspend(struct device *dev)
>> --
>> 2.39.2
>>
> 

