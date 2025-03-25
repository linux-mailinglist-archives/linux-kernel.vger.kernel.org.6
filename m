Return-Path: <linux-kernel+bounces-575319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50835A6FE13
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51AD67A2FC8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0660E25FA04;
	Tue, 25 Mar 2025 12:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u/HHRMv/"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5034825F98B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905408; cv=none; b=YQ7Q8hFDJYwSCW9vbQa7jA9sU67gwX2LpY7TseWEnHrgw4ZWSJLj+AReg9UooUFsWEqXQC/h3eMKz23KfgFzhf8HNn085Ul1k1qJ/GeJ4WLVa3mAd+ujBsL0CmaeXHTYCJadEbftpYya7wsA+C//s5ZRJu77t4pYjwtGq4F7sTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905408; c=relaxed/simple;
	bh=8q3d5xPwjiMNlEhK1ZkFhNcMkgP7L+QcL0KZwaCRenY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u9iicuGWslbiKTFOW0jhNtBjLwpmPiI8KtwRQIgLmS0gt7J4/8zf13MyKRR+lEWibK8XJ6adjxSwfzHURPEZE4/yQxjUwHHOuwJuZDIyODa1KgsKeJjW3Ae6FcFsYh/Zh2RL6mGTODxVWxuTA5vWYhUbfUdgt2UTLAQTEgSultA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u/HHRMv/; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso34622815e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 05:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742905404; x=1743510204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gnl5RH7POTVxhZTqrexGViAgN1F/XxGfRRowwJehUVo=;
        b=u/HHRMv/9hJ8Nasf6OIXnr5r07wea0jqB7S4dXrxnfSxOqKk7c/GZC/NE4YCRdbg7s
         c5XRDXoPx4iI+S3e8rc2EM8QmFnx7J0w0eL7cTKPsmAuhvhH/ZdK/8rCGNk0bL5HdPSB
         Mb0QDAc5V8kJsTO4ekiRwOJjKmDRLO5QHFfYSE80RSRX65ot/tMNX9nTbEtSL49LMgEt
         Q+RqcZcKUsoGKd/+sSJbN2aqWrPOXbK2Uf7fSocuzsdVnvgMQW+n593hfbGjWGIb4kre
         Zvlossu1tPggnozWm14GSOA+qaGtgipBjxAIB/FiiCAKdWpvr/vBX2ZN9EsAfhIBRD7Z
         8PHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742905404; x=1743510204;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gnl5RH7POTVxhZTqrexGViAgN1F/XxGfRRowwJehUVo=;
        b=DZtsJlhGjaZSWPMYBmGjGnXzo7B/G78WMQFMGQgBu5qNFgSW+Z3p0woPgutzuixpO7
         VzTm5/HKpv9hqYUaPQyAeaJkaTlbAbWXcLy8xXMAXfapG9nvSSX1Co6lKdtaiofQIe/b
         6TUSMlzSRmcNX25lHEYXFPJQQ9ZffM6IJyylWqUAUMc6TxfCQChQhvNnGV/rBiDqNyYV
         hw4y/ZUMk1uwxhTQz1mMnGmve+VTWKRsamdAva8AVIIo0imh0Fwx4RlhVdN6ZQEWt1sJ
         uzV4/zhxW3Nc+fNp1NBk5+SxGFykG84IqA6+EM1Z+Vb78lzkeKpXrtoY84V9ozEISx2/
         ZhBQ==
X-Gm-Message-State: AOJu0YxTcEy7aXQ0EnIaV0DqQw2Wnlj5Tv4J7dVdF6twtFp1QWlPwdx4
	slXiS999JaJgW0Hmoi1YVFrlXMhjZQZzEgh6i0ZweCAMBKFwfcZk0Jpqg3GswR0=
X-Gm-Gg: ASbGncv6QFG6UTEuCTtZG4DUFmIm7VJmLRZQSR/dwLd3fxE+8K0RhhnlfmaBvDmLMLl
	e+J57R85Q2Bi0Z4zJkHeUvxOaiywrh7hXNx3cya2tFET5LodI+4K+ppmY+ZRx01bwoN8bZKQ44R
	ppuG+mTDwWJz5jsW9NqCsiAuoxsOlisjDrwix41w/5MLvgcc6yvqeRFemYKlWcjb5OxI9gDTpeY
	iomuqK4pQ3H9d8qLeJglI6ZU7Ikp+A+N3cVFipYx4vSFZcdJnQYUNmdiPUyJxugwYrvWfrhEr70
	uxJLqk2FDUJO4ltyfhb7UieyaiIsckVK1hQQg+mXHz1BXfbnXtK9yxroo9cblWaa1vJnUoFirNM
	tbMdmG74r
X-Google-Smtp-Source: AGHT+IE6bRcBJovGsSP7syxDYUzmQ6H73XOh9NrMfUBBqcvJmW/fILYdlvhCAYwBYc/zAFfQY02Mbg==
X-Received: by 2002:a05:600c:a00b:b0:439:9434:4f3b with SMTP id 5b1f17b1804b1-43d503056cemr148450025e9.8.1742905404410;
        Tue, 25 Mar 2025 05:23:24 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d43f43e2asm204517715e9.11.2025.03.25.05.23.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 05:23:24 -0700 (PDT)
Message-ID: <1bf2d9ad-325e-4b1d-8440-ddbc90eabc67@linaro.org>
Date: Tue, 25 Mar 2025 13:23:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] clocksource/drivers/nxp-timer: Add the System Timer
 Module for the s32g platform
To: Krzysztof Kozlowski <krzk@kernel.org>, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, Thomas Fossati <thomas.fossati@linaro.org>,
 Larisa Grigore <Larisa.Grigore@nxp.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, dl-S32 <S32@nxp.com>
References: <20250324100008.346009-1-daniel.lezcano@linaro.org>
 <20250324100008.346009-2-daniel.lezcano@linaro.org>
 <bb7e4740-9608-4534-9c19-3ac066e2aa8f@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <bb7e4740-9608-4534-9c19-3ac066e2aa8f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


[Added s32@ list which I miss from the initial series]

On 25/03/2025 08:30, Krzysztof Kozlowski wrote:
> On 24/03/2025 11:00, Daniel Lezcano wrote:
>> +
>> +static int __init nxp_stm_clocksource_init(struct device *dev, const char *name,
>> +					   void __iomem *base, struct clk *clk)
>> +{
>> +	struct stm_timer *stm_timer;
>> +	int ret;
>> +
>> +	stm_timer = devm_kzalloc(dev, sizeof(*stm_timer), GFP_KERNEL);
>> +	if (!stm_timer)
>> +		return -ENOMEM;
>> +
>> +	stm_timer->base = base;
>> +	stm_timer->rate = clk_get_rate(clk);
>> +
>> +	stm_timer->scs.cs.name = name;
> 
> You are aware that all node names will have exactly the same name? All
> of them will be called "timer"?

 From the caller const char *name = of_node_full_name(np);

The names are:

"clocksource: Switched to clocksource stm@4011c000"

Or:

  17:      24150          0          0          0    GICv3  57 Level 
stm@40120000
  18:          0      22680          0          0    GICv3  58 Level 
stm@40124000
  19:          0          0      24110          0    GICv3  59 Level 
stm@40128000
  20:          0          0          0      21164    GICv3  60 Level 
stm@4021c000

And:

cat /sys/devices/system/clocksource/clocksource0/current_clocksource
stm@4011c000

cat /sys/devices/system/clockevents/clockevent*/current_device
stm@40120000
stm@40124000
stm@40128000
stm@4021c000

[ ... ]

>> +
>> +static int __init nxp_stm_timer_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *np = dev->of_node;
>> +	struct stm_instances *stm_instances;
>> +	const char *name = of_node_full_name(np);
>> +	void __iomem *base;
>> +	int irq, ret;
>> +	struct clk *clk;
>> +
>> +	stm_instances = (typeof(stm_instances))of_device_get_match_data(dev);
> 
> No, you *cannot* drop the const. It's there on purpose. Match data
> should be const because it defines per variant differences. That's why
> the prototype of of_device_get_match_data() has such return type.
> You just want some global singleton, not match data.
> 
>> +	if (!stm_instances) {
>> +		dev_err(dev, "No STM instances associated with a cpu");
>> +		return -EINVAL;
>> +	}
>> +
>> +	base = devm_of_iomap(dev, np, 0, NULL);
>> +	if (IS_ERR(base)) {
>> +		dev_err(dev, "Failed to iomap %pOFn\n", np);
> 
> You need to clean up the downstream code to match upstream. All of these
> should be return dev_err_probe().

Oh right, thanks for the reminder

>> +		return PTR_ERR(base);
>> +	}
>> +
>> +	irq = irq_of_parse_and_map(np, 0);
>> +	if (irq <= 0) {
>> +		dev_err(dev, "Failed to parse and map IRQ: %d\n", irq);
>> +		return -EINVAL;
>> +	}
>> +
>> +	clk = devm_clk_get(dev, NULL);
>> +	if (IS_ERR(clk)) {
>> +		dev_err(dev, "Clock not found\n");
> 
> And this is clearly incorrect - spamming logs. Syntax is:
> return dev_err_probe
> 
>> +		return PTR_ERR(clk);
>> +	}
>> +
>> +	ret = clk_prepare_enable(clk);
> 
> Drop, devm_clk_get_enabled.
> 
>> +	if (ret) {
>> +		dev_err(dev, "Failed to enable STM timer clock: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	if (!stm_instances->clocksource && (stm_instances->features & STM_CLKSRC)) {
>> +
>> +		/*
>> +		 * First probed STM will be a clocksource
>> +		 */
>> +		ret = nxp_stm_clocksource_init(dev, name, base, clk);
>> +		if (ret)
>> +			return ret;
>> +		stm_instances->clocksource++;
> 
> That's racy. Devices can be brought async, ideally. This should be
> rather idr or probably entire structure protected with a mutex.

Mmh, interesting. I never had to think about this problem before

Do you know at what moment the probing is parallelized ?

>> +static struct stm_instances s32g_stm_instances = { .features = STM_CLKSRC | STM_CLKEVT_PER_CPU };
> 
> Missing const. Or misplaced - all file-scope static variables are
> declared at the top.
> 
>> +
>> +static const struct of_device_id nxp_stm_of_match[] = {
>> +	{ .compatible = "nxp,s32g2-stm", &s32g_stm_instances },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, nxp_stm_of_match);
>> +
>> +static struct platform_driver nxp_stm_probe = {
>> +	.probe	= nxp_stm_timer_probe,
>> +	.driver	= {
>> +		.name = "nxp-stm",
>> +		.of_match_table = of_match_ptr(nxp_stm_of_match),
> 
> Drop of_match_ptr, you have here warnings.
> 
>> +	},
>> +};
>> +module_platform_driver(nxp_stm_probe);
>> +
>> +MODULE_DESCRIPTION("NXP System Timer Module driver");
>> +MODULE_LICENSE("GPL");

Thanks for the review

   -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

