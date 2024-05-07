Return-Path: <linux-kernel+bounces-171471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C678BE4CA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2865C1C240CC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F5E15EFB6;
	Tue,  7 May 2024 13:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r0m/XD4n"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046D115ECFA
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 13:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715089871; cv=none; b=jaMKuYYysLg/PcvAPjwrHqD14JZQZlhfF5J0tIbymLZMc/7kYDzCikgyniYNIp/PVXCu9KP6ra0DyW8DJjJOSiYXknCl3DsEVf3ggESQCx6YslLn0otI+Zx9qIcqKANj4eV8k7+gfb/EjOc65kTEXrsB2VthjA6eZfiH3VV5PF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715089871; c=relaxed/simple;
	bh=CYOMBbl8ouu83jPSzPzk5sBy7BZZRj9DTxYtalItm/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CFPj/E+lI+xBfoDD6BAWqBBWddNVVa02YKSpKm8qalNZge3OX+qbr3ATrjjMsjkq2Ezmz8wdOEhhTLihCwAnSD2OERUkMAxwmF10wmS8x+LBnFhnDn25MT/55E0JuyIJ75f+Xf9xVot7/Sqhvm/Klgwr8Qausz8w9jwuNGZLftk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r0m/XD4n; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e3efa18e6aso6948941fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 06:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715089868; x=1715694668; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LYgXmNSeZ5uAXbZ42Wd8TdT7DuRGzZ+iejAjgC1sq8M=;
        b=r0m/XD4nEyxoZxQPUI1mmK+HQkh2v5jkVYTj2t0nfvge7Rkp4Dfg7yiAzV9xdshnH6
         YAT+K3ulB++nUXZLAdE9pQtDgdd89+fobjtenSLa0RGtXwwqfZ/9VRO/foFxQS/Uot6D
         WmhApjK/Y5Do/CoRB+4APnlc9KuHT6tk0FRFmwoHZbPifHoXdAvTYX7mS5apG06+DZUE
         7tL7beyzWa+sRiNEAmie5xJ47VJ1X65lXN6fRlkjwO5QhahJL1rUvn9LouBFZRZgmUD+
         phmoe5rUG/d+ZxhsB2hRZON+YPZXCFyVIGCZ8xRlyjuVutSGiFakRnkd5Ta42CP/dDvF
         QbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715089868; x=1715694668;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LYgXmNSeZ5uAXbZ42Wd8TdT7DuRGzZ+iejAjgC1sq8M=;
        b=rRKgpcASzNTBRAvM/6SnYcNl3iJGf03fWQCg2INlTI7OylIQWBGzIie9R7au/iMk9l
         zLDBDTWrKP839G5QjW/ioVhas3Bh59w8xQBVUuWYnibLZJHOgSyhDaT0rCkbSMSo4DRM
         mIv5AkKIABGrCBMUtAg2Qo7HcD444u+H1ntvAdlmGm4t3YlZAbAqjik7d60/101GHI/O
         DVRLk+b25RpT2JDjT9NBlNOxVb6Kkaqa6BepL7iUORRZrSd9PESzj0xrhd4SnIvgOSNp
         HnUW5lyA2CQaTaoOh9OYKknode5T9bb+y4+Pp1vl4wSRLbYQpxf81az3mphTj00gEc5O
         gJGA==
X-Forwarded-Encrypted: i=1; AJvYcCVT8ingYEKt6rovpEfA6AxbgcTWxVUmgieZsS+mZXotNF+YoWqulXmCPj7FW1jC3RR0J80lO6Xy2J7tZGNXbX7ytIFCFEWDS42dBpzP
X-Gm-Message-State: AOJu0YxV5WEjcEeN6TenHLsu5Nc2FqIGoqnEqbs/7h3FS5CgJ4W1eINw
	TZer9hNJft5X7eDoR2caZRAZmjBPLsvWfcC+jxAC5bbv70VyUlgJZHUFD9wWKB0=
X-Google-Smtp-Source: AGHT+IE5G66ioLy5Gd2DnM6KVQtr/z1w+ypEcQkiY8UjkEBgG9dAKVeYIY4NAzVBcYXBb0Fh6caMbQ==
X-Received: by 2002:a2e:84d0:0:b0:2e2:6dd9:dd8a with SMTP id 38308e7fff4ca-2e3d811a8ebmr8385881fa.0.1715089868217;
        Tue, 07 May 2024 06:51:08 -0700 (PDT)
Received: from ?IPV6:2a00:f41:c0d:408:fa88:abdb:17c2:cf24? ([2a00:f41:c0d:408:fa88:abdb:17c2:cf24])
        by smtp.gmail.com with ESMTPSA id e3-20020a2e9e03000000b002d6daf3b41fsm1952160ljk.101.2024.05.07.06.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 06:51:07 -0700 (PDT)
Message-ID: <3a3c4279-a254-48d0-91ad-70b7f1e3eb77@linaro.org>
Date: Tue, 7 May 2024 15:51:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: gcc-sm8450: set OPS_PARENT_ENABLE on
 gcc_sdcc2_apps_clk_src
To: Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Vinod Koul <vkoul@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20240427-topic-8450sdc2-v1-1-631cbb59e0e5@linaro.org>
 <2337ba58adb3fb127710bead9b8665a9.sboyd@kernel.org>
 <11bd7146-30cd-4b71-b2ca-d76875763731@linaro.org>
 <6ba2967c6c9d24e3f1c9b76496176010.sboyd@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <6ba2967c6c9d24e3f1c9b76496176010.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/30/24 23:26, Stephen Boyd wrote:
> Quoting Konrad Dybcio (2024-04-30 03:46:52)
>> On 30.04.2024 2:21 AM, Stephen Boyd wrote:
>>> Quoting Konrad Dybcio (2024-04-27 05:01:07)
>>>> Similar to how it works on other SoCs, the top frequency of the SDHCI2
>>>> core clock is generated by a separate PLL (peculiar design choice) that
>>>> is not guaranteed to be enabled (why does the clock framework not handle
>>>> this by default?).
>>>>
>>>> Add the CLK_OPS_PARENT_ENABLE flag to make sure we're not muxing the
>>>> RCG input to a dormant source.
>>>
>>> The RCG2 hardware hasn't required the parent to be enabled for clk
>>> operations besides for the glitch-free source switch. What scenario is
>>> happening here that's requiring this flag? Is the RCG forcibly enabled
>>> perhaps because the bootloader has left the root enable bit set
>>> (CMD_ROOT_EN)? Or are we changing the parent while the clk framework
>>> thinks the clk is off when it is actually on?
>>>
>>> TL;DR: This is papering over a bigger bug.
>>
>> Definitely.
>>
>>
>> Take a look at:
>>
>> static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
>>          F(400000, P_BI_TCXO, 12, 1, 4),
>>          F(25000000, P_GCC_GPLL0_OUT_EVEN, 12, 0, 0),
>>          F(50000000, P_GCC_GPLL0_OUT_EVEN, 6, 0, 0),
>>          F(100000000, P_GCC_GPLL0_OUT_EVEN, 3, 0, 0),
>>          F(202000000, P_GCC_GPLL9_OUT_MAIN, 4, 0, 0),
>>          { }
>> };
>>
>> XO and GPLL0 are more or less always on, but GPLL9 is described to only
>> be used for this specific clock for this specific frequency (perhaps it
>> feeds something else on the soc but that's besides the point).
>>
>> Then, the parent input is changed during set_rate, but GPLL9 seems to
>> never be enabled:
> 
> Is the sdcc2 RCG enabled during the set_rate?

without PARENT_OPS_ENABLE:

[    3.326891] sdhci_msm 8804000.mmc: Got CD GPIO
[    3.336839] scsi host0: ufshcd
[    3.337105] gcc_sdcc2_apps_clk_src is DISABLED @ set_rate
[    3.346339] ------------[ cut here ]------------
[    3.351093] gcc_sdcc2_apps_clk_src: rcg didn't update its configuration.
[    3.351114] WARNING: CPU: 1 PID: 11 at drivers/clk/qcom/clk-rcg2.c:133 update_config+0xc8/0xd8

[...]

[    3.610523] gcc_sdcc2_apps_clk_src is ENABLED @ set_rate


with PARENT_OPS_ENABLE:

[    3.331419] sdhci_msm 8804000.mmc: Got CD GPIO
[    3.336569] gcc_sdcc2_apps_clk_src is DISABLED @ set_rate
[    3.344795] scsi host0: ufshcd
[    3.355122] qcrypto 1dfa000.crypto: Adding to iommu group 5
[    3.363567] remoteproc remoteproc0: 2400000.remoteproc is available
[    3.364729] gcc_sdcc2_apps_clk_src is ENABLED @ set_rate

after testing it both ways, I realized it wasn't supposed to make a
difference in this regard, but I suppose I can paste both results anyway..

Konrad

