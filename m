Return-Path: <linux-kernel+bounces-293888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5327F958632
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795431C21E59
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBA218E75E;
	Tue, 20 Aug 2024 11:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="QOfFrLuZ"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0A918E74F
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 11:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724154906; cv=none; b=Y4oj9iExGEuKLYIj8mghFtkydM7b1w2ua9hR/iRtO/k7UgkjNZqaywXzNs2N7Hy3+68aGOG+3OGBGPUlrTCTMvLv+I6i3alYycChKDwvHLufB3WOksR6m2DOP0ySdvV9fox1znN5iefpHRXjezXFxXhC4lUdeQaOq508Y/ga7oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724154906; c=relaxed/simple;
	bh=aLF1QS2bweCC1rgUwCudbiwq9Dncg3ueoYZJMejgBWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NyQKuizQ5+2IE9GDS/+OA9Cd2aDQNnzkc7gMMClfz2YPLs8MkhY8dQX9oVaJ/fB1wp8OspnRZg2/NzTdLnWMGF2UZ1jN2lzmCtrn7uVK7XLdA+CVnwNTUZ0HmVomEOUgXrflcjPoDs4QT6YQwGZARyJfC88yyZcW4tKLoBFlxS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=QOfFrLuZ; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52efa16aad9so6697088e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 04:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724154902; x=1724759702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dCf/kUCM4tXS0nTsH53L6T8+OzmPfbxe5arQDk7ZTKU=;
        b=QOfFrLuZLBRm7eWc09xEqsvGU2+q2bWwKr/KjGh/YUa9WwhfoFHmwXBeNPz5Ra3aCn
         AOcX8OnYaGB7ERiNLUXrcDggQVfyjVGAkBhVTSuhRv5NSYPnpo1r36EphZrHwFFbDgcB
         Y9HVUUWd8+q8rZ+9PywcabLWjkVh7g1xOS7y8gU/B5PDPWylTKkGa/ExUIYTqEhXSjpt
         frhPuiC35ayDBqUr7TEIaH1b/s7KI8CbuXYfTl2XpWVL7m6GCRGAJfQ9ZB0AJY0vbm1K
         MIOJS1PhCgRc4tM4RCely3HnCum58iXQnO6rwPTFhbAQOqaRBLaAtM1roSqQ5iZpfvOG
         xHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724154902; x=1724759702;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dCf/kUCM4tXS0nTsH53L6T8+OzmPfbxe5arQDk7ZTKU=;
        b=lE8okHjnWgi1EnDN5p3CTBxx8i4zkyzZLxJOiDsfFZGrV5A8eow2Wo8Jres7aDcoq4
         Rzboyx9Y70z+4sTOY9JpDB6WcETzXV2rmbosrUtxhWX9euWAf5WWScuz/eQfTMmQqzBr
         lraApVu4hgYQQElXeX3rIwfbLlJJwQunOgsSCIuscSW5tcwGtKdVHWsMSy0M28Ih9E8D
         lHkaozhUh/AJcRmOjNvM4Obkzg8nqjJR7qnyufvCai5vzG+vQsLGHj+UTZRkjXKJRlpb
         u+n16yYSypoefxzDAN88kw6qOSCp/V4Ee0t7QsG10C2xoaucZW8td5oNYsmf5lOKYPBm
         owtw==
X-Forwarded-Encrypted: i=1; AJvYcCWJB2/Oh6ik49LccCQUzyPs2S8CR2k/+9RnmAC/yJjCjFVfmkwyOEAstviK2S2Qt/2MWkIihh03E6WpAVJCJGDH34uVb8uIOWkHXAIK
X-Gm-Message-State: AOJu0Yw37zyX2fXu3ZMzaKJE1OpTW5t/b/P0/TKMnEt6ew6S8XVHEpky
	z2Z6098lsUzzkmvJOcC1fiSTCBZEuxcAGmigAnY6zciHaYt7nP0ytlp3UPHhxQs=
X-Google-Smtp-Source: AGHT+IFmkyyi7oEfSVRFQNguF9vZTRyURXZWy3bWUM0PTamahtdy6X2DNoHO5mK2sJMAFvWiBqn67A==
X-Received: by 2002:a05:6512:2243:b0:52e:7542:f471 with SMTP id 2adb3069b0e04-5331c6ae178mr10118665e87.29.1724154901477;
        Tue, 20 Aug 2024 04:55:01 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83839471f7sm749478066b.162.2024.08.20.04.55.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 04:55:01 -0700 (PDT)
Message-ID: <384919bc-7d45-445a-bc85-630c599d43ef@tuxon.dev>
Date: Tue, 20 Aug 2024 14:54:59 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: get, prepare, enable a clock not in DT?
Content-Language: en-US
To: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240816-ludicrous-lagging-65e750c57ab4@thorsis.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240816-ludicrous-lagging-65e750c57ab4@thorsis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Alexander,

On 16.08.2024 17:34, Alexander Dahl wrote:
> Hello everyone,
> 
> while further investigating timeout issues with the at91 otpc
> controller on sam9x60 [1] I came to the conclusion the main RC
> oscillator on that SoC must be enabled for that driver to work.

Not sure how that works (unless undocumented) as figure Figure 28-1. Clock
Generator Block Diagram from [1] states that main_rc_osc feeds only the mainck.

Also, Table 9-1. Peripheral Identifiers from [1] say that there is no clock
control for OTCP on the PMC side.

[1]
https://ww1.microchip.com/downloads/aemDocuments/documents/MPU32/ProductDocuments/DataSheets/SAM9X60-Data-Sheet-DS60001579.pdf

> (Verified that by poking single bits in registers through devmem
> already.)
> 
> Fortunately the necessary clk is already registered from the SoC code
> in drivers/clk/at91/sam9x60.c [2] and I can see the clock in sysfs clk
> summary:
> 
>     root@DistroKit:~ head -n4 /sys/kernel/debug/clk/clk_summary 
>                                      enable  prepare  protect                                duty  hardware                            connection
>        clock                          count    count    count        rate   accuracy phase  cycle    enable   consumer                         id
>     ---------------------------------------------------------------------------------------------------------------------------------------------
>      main_rc_osc                         0       0        0        12000000    50000000   0     50000      Y   deviceless                      no_connection_id         
> 
> That clock has no parent and is not found anywhere in devicetree, nor
> is it handled by the two clock-producers on that platform, so
> from within mchp_otpc_probe() I just tried this:
> 
>     otpc->clk = devm_clk_get_enabled(&pdev->dev, "main_rc_osc");

> 
> However that returns with -ENOENT, so I assume I can not reference the
> clock just by name?  Same result with this:
> 
>     otpc->clk = devm_clk_get_enabled(NULL, "main_rc_osc");
> 
> How do I get a pointer to that clk then to enable it?  Docs [3] where

To expose it though DT you may want to save its hw object to one array
entry in sam9x60_pmc, sam9x60_pmc->chws[] fits best for this atm.

Otherwise, you can try to register the main_rc_osc with CLK_IS_CRITICAL for
simple trials.

Thank you,
Claudiu Beznea

> not as useful as I hoped for, neither was clk.h header docs. :-/
> 
> From what I understood from header docs reading 'device for clock
> "consumer"' I must pass the device from which I call that clk_get() as
> first parameter, so this would be the otpc device then, right?  What's
> that second parameter clock consumer id then?  Are these terms
> explained somewhere?
> 
> Greets
> Alex
> 
> [1] <20240813-payable-ecology-8a9e739704bb@thorsis.com>
> [2] https://elixir.bootlin.com/linux/v6.10.4/source/drivers/clk/at91/sam9x60.c#L217
> [3] https://kernel.org/doc/html/latest/driver-api/clk.html
> 

