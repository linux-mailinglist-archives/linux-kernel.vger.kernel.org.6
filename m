Return-Path: <linux-kernel+bounces-428821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8499E13ED
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2CCE164564
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 07:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF111D86C6;
	Tue,  3 Dec 2024 07:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WBzQ31Dj"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAF51D5AD7
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 07:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733210522; cv=none; b=cULuKaGpyaLvYu3nXt0Uru5w9NSmwn3ZEsQMh/EcfYQPphF6gA+H1YlSetNQFV2HymTsJPBgQbsDsF9gNBiP6IS72lwMok8oGhYg54ZYAOd8WK5v9SfDqszVezLo5Z5YrrZY6wXbSKedgZWeVjX69z7Eyr26O6tkX2lJNGaNGpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733210522; c=relaxed/simple;
	bh=uqtEzhMRnLJS8l9b3AtgK6MI4i3l2hhWw2hu1Eq/0uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sTowmLbZxdOQh1SjKAtCnD5koEDttP39SvBxR1lEAzZ4BR17z4/xEuoMlKD5KHrlNYHCDqI0D0GcfemRc7PLkCv9JFn/WaJbxRsEBej9oHK6XQo5DnqbzFs5OFbeea9HIBi0pu8hXIxtusCxibjU4fRRpOMJj8VVZc44/uqCPs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WBzQ31Dj; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434a29ecbceso6115745e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 23:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733210519; x=1733815319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aZDPQgCN95ive2Go/94hQIU8M1AGDAd9f/tRZEAyTBE=;
        b=WBzQ31DjQDOaIJJz5dsX6laJzknIMZRumex+GIJNlR+1svcViZwySHcxSTVjCGVjZI
         9HYhkRH8zFLUF85P8CpssfYgdZery9xlRyAsAd9kFKtjsN7ctfUhxhsv1qOINAja7bh/
         c0iaG8R5jlaeMw0i2f5343tsqS3JfdTFSmbr9DOlfRiZyOjXhXNY0PDv2/2fX2Pq+208
         0UDQbioD0JWbl3tVlKcx04bLJKRgXP+8yluUyVbsQJwmdOS4zppnklwNtuYef3wxXkZv
         1z6WYJYaWvSOA5F0GSUD/KbkJDw/uvYrL/Q9+85bE7xAquahkTbCWQgoa2W75oAxFP/K
         VLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733210519; x=1733815319;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aZDPQgCN95ive2Go/94hQIU8M1AGDAd9f/tRZEAyTBE=;
        b=vfuC9TLV+g2wHohWnAw7bsbqGUoLjKSaHmmrFbIuAz91IJ/2EsnVISRF55Q2XCQiih
         Pp7HClj3E8AmswFr/m/aliMHOT6RWaHkxmuTdvN2fF8b9TPU9DfhB8YNX0iIZouRiaki
         Y4xSxUOUhRXJcfsR6pWhNS/dY7fC/GbEhV1pT+njYWuDjLRonHZj8FQ5YvS6Xc3tJTg7
         8AKTZq2l97ack+SwXNNYYhbUxDprdBYKAxAyVnmaMA84GHpcC04dqWHHwBtQWIq/Doed
         Y/YQeRo0+3+FNtwhLz8vbRFFitxTPKNCrU0RmMz3pqhbvHapCH3hWAddlWm7DC4tKt+o
         l5Rw==
X-Forwarded-Encrypted: i=1; AJvYcCXaHvf9jywMYd04785MghxDoqAPfoY8ulYArLUQehEN6MnSQvday0IY9ku2xd0WUJmuraco3R53O02ApdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFiv9XWKBTR9y69WKo7ZXosXyEXIfgo7vKtGzyweqJHvUPnLU5
	+pjf6qlUBIg2MLNkzLJuNtQvYj39BDihF3w3HwwLGCCJ58ADc8As9GLqdRfAT7uA+wAEx9vJM7i
	Mbh8=
X-Gm-Gg: ASbGnctyj1Fp+mwxMKJ9cxfciFSDFK3HOFj/3fGJrMbbVgcLwELbdWR/+Il6XxgM+XR
	QN3BaFIauaXOvWQsFK1t+ejmnFs9PHTRa5yBQOoGava6kbU5CU76uA1adRzJO8V1rB63nSaiUbm
	03bmrHFKkpGucaqe+M7w7KLPhOoCxS6GcfF19pfuoxVC4KkCnV3dCdu2NBibx+W7ZAH5mYDThRj
	PCfyO1xgUgrlxpMybVys+Pw2FcmxFseZVlxCudOrJ+k6BaKMwInSwL5GgfNYOFwXcXN
X-Google-Smtp-Source: AGHT+IGqkMMM9vwLKbsqpB8xE0dK7oGk/YKtHBBwJoLgbBX+yeynhxOMPyEcqXB1eD1BxtvM411LNg==
X-Received: by 2002:a05:600c:68c9:b0:434:a0fd:95d0 with SMTP id 5b1f17b1804b1-434d0a062b0mr4186435e9.4.1733210519191;
        Mon, 02 Dec 2024 23:21:59 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385d7f103e0sm13043254f8f.19.2024.12.02.23.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 23:21:58 -0800 (PST)
Message-ID: <4e91aa96-69c2-4584-b312-46d26653c071@linaro.org>
Date: Tue, 3 Dec 2024 08:21:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: clk-alpha-pll: Do not use random stack value
 for recalc rate
To: Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241127093623.80735-1-krzysztof.kozlowski@linaro.org>
 <140e036792e7d7468130a47b0724132d.sboyd@kernel.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <140e036792e7d7468130a47b0724132d.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/12/2024 06:08, Stephen Boyd wrote:
>> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
>> index 5e9217ea3760..0cd937ab47d0 100644
>> --- a/drivers/clk/qcom/clk-alpha-pll.c
>> +++ b/drivers/clk/qcom/clk-alpha-pll.c
>> @@ -682,9 +682,12 @@ clk_alpha_pll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
>>         struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
>>         u32 alpha_width = pll_alpha_width(pll);
>>  
>> -       regmap_read(pll->clkr.regmap, PLL_L_VAL(pll), &l);
>> +       if (regmap_read(pll->clkr.regmap, PLL_L_VAL(pll), &l))
>> +               return 0;
>> +
>> +       if (regmap_read(pll->clkr.regmap, PLL_USER_CTL(pll), &ctl))
>> +               return 0;
>>  
>> -       regmap_read(pll->clkr.regmap, PLL_USER_CTL(pll), &ctl);
>>         if (ctl & PLL_ALPHA_EN) {
>>                 regmap_read(pll->clkr.regmap, PLL_ALPHA_VAL(pll), &low);
> 
> What about 'low'?

Indeed, this and one more below regmap_read also need it.

Best regards,
Krzysztof

