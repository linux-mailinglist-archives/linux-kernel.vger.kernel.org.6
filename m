Return-Path: <linux-kernel+bounces-208494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A97C9025C4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B48C1F27D59
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF1113DDCD;
	Mon, 10 Jun 2024 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W3DwxLEa"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322AB1E51E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718033769; cv=none; b=pf3aifeMdYcqdiRRbaDt8bWlhx9+sPz/nBC0kaW2za88NtRWVdyaN5/Xqy6kPmNmN0kzqRVNKsbgDskO/V6iyDh/7JztIu1t5Msve2qE2T7eJNL9oXbEKOZPtXNE8hpSj4+m2W8+OjmqwuqOdP0a/8uOmCInd98DSLgcvOPrI1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718033769; c=relaxed/simple;
	bh=Ah1Pc9Tx+SfASALqTWximD0HQRflB2G4Tq5TvplHIfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SHksrQ+UTeHOVxrd1J0rIb8w+fJzQMeAyYLSpMAC3KL2h096BcGBHSqcvQE8Hgz6UAVhN9tB6JcGpjqxMwtJniJrH4NWcfsUAab0GZtoJq1gwT2bQ0MYZtOBiG+H4Gdd0O1+NoP24OnwPTEUfg763Jm+9s5SuWMLQjxGNgoCzW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W3DwxLEa; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6f09eaf420so212072666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 08:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718033766; x=1718638566; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/+E80Q5rdxeGOmqKds9oqdRbVVK3jiXABymm7gK6I9o=;
        b=W3DwxLEao055/FJbiiegaFShy2Gp7ZZpAxHo+9DFcBIzeRvZfoN+qH5olox0adrC3Y
         1swITSxaueFdDObUpDUxP28yJj/AHUGbPsxQ/PlWiuEyzqGnWXemjfTlFcm+jpI/72cr
         aDzjwERhxzJhCPjFsUXtPFpr+98pg3V4Q4QQ7Kk5UTkouMP0366BdWJTkBBLgLSemsuG
         Asqd5vUT7vGbq3rb2DdSdMGErwP+YHBEzArg5Bs3ZVxRNK/yNb3cEyOc+q0E7MFXROOn
         tMujokhk8rdih0V3qPTrHsHDp2NGflO68cfEBTabgxlgAOrqalaK2mynzFqeDC9M+FSQ
         qbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718033766; x=1718638566;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+E80Q5rdxeGOmqKds9oqdRbVVK3jiXABymm7gK6I9o=;
        b=Noa+ebYkeOMdH2WUXHjFSP+6gQGr6wUHTncC/WYRAhRcHw2efjyjIi594pdU0DkfaF
         QScwmviyYAq3Bx5LCmGr6531Jdtb4M50p2VUoy7pF47AHY8w4uYYqSOjmSWf02yKXR8C
         6YWUiqpc7EFyVvN6MOL4UGEQXsAMTtP7K4pZc+7GUb8fbrcOb+hdB63xAJle0VdMpYW9
         tPqURL8EoM3Kac7zAxJZx5XOEBD7aCEqRwtt9d3DGJ/vgM9NGjDTsqmCu3taZcD0l5NK
         kuIy47IGFT6f1OtWHXQD7BjCfQ668/bPMxKDLCaGwTMY0zdn1NeWOqTUgCmnF2Fp5Vmr
         +P3g==
X-Forwarded-Encrypted: i=1; AJvYcCXpJC0VvueIRay6WWNxDhyA8kXzydMdxENoLYTD0SpInje2p5WtA57HirW045QFvGOJ1o/Qmem4akdyAU3a3u/+mb7TpMF8cTa8daxk
X-Gm-Message-State: AOJu0Yy62mvJZveNsxVOIFmt0IJsFEHriARVjfdlotXG/6NZvcqU3lgo
	lPc2zzN4pkd2Pdz221PY72SA7XbX7xa9DcH1X6K6y8O4eXrIvKlp+9BVJEfrgks=
X-Google-Smtp-Source: AGHT+IGECHz6J6eLlLoS1mhmDrqUcykuz5pFaLMgXUzzL7Qbv358E5AMAFWML4yz8R0kd+585prxAQ==
X-Received: by 2002:a17:907:76d4:b0:a6f:23a:9151 with SMTP id a640c23a62f3a-a6f023a9299mr421078866b.55.1718033766498;
        Mon, 10 Jun 2024 08:36:06 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a6e00b47420sm486088366b.42.2024.06.10.08.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 08:36:05 -0700 (PDT)
Message-ID: <ab5c2a6d-6819-48eb-a3c5-178fa37204bb@linaro.org>
Date: Mon, 10 Jun 2024 16:36:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] ASoC: qcom: display port changes
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: broonie@kernel.org, perex@perex.cz, lgirdwood@gmail.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, krzk+dt@kernel.org
References: <20240606104922.114229-1-srinivas.kandagatla@linaro.org>
 <i6jwqycgywrq42u4km6pjppgvvhsbvuh7m6mzyqy2qcge32ihy@n3lrowkyouv2>
 <3ea05a12-27a8-46df-9fb3-28501404a399@linaro.org>
 <CAA8EJpqMk9vujHAmF+xSKBDzR1LM9w-M7a8vxcCkXey9VpHBhA@mail.gmail.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <CAA8EJpqMk9vujHAmF+xSKBDzR1LM9w-M7a8vxcCkXey9VpHBhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/06/2024 15:56, Dmitry Baryshkov wrote:
> On Sat, 8 Jun 2024 at 12:12, Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>>
>> Thanks Dmitry for testing this out.
>>
>> On 08/06/2024 03:23, Dmitry Baryshkov wrote:
>>> On Thu, Jun 06, 2024 at 11:49:18AM +0100, srinivas.kandagatla@linaro.org wrote:
>>>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>>
>>>> This patchset adds support for.
>>>>       1. parse Display Port module tokens from ASoC topology
>>>>       2. add support to DP/HDMI Jack events.
>>>>       3. fixes a typo in function name in sm8250
>>>>
>>>> Verified these patches on X13s along with changes to tplg in
>>>> https://git.codelinaro.org/linaro/qcomlt/audioreach-topology/-/tree/topic/x13s-dp?ref_type=heads
>>>> and ucm changes from https://github.com/Srinivas-Kandagatla/alsa-ucm-conf/tree/topic/x13s-dp
>>>>
>>>> x1e80100 is verified by Krzysztof with his changes in tplg
>>>>
>>>> https://git.codelinaro.org/linaro/qcomlt/audioreach-topology/-/merge_requests/7/commits
>>>>
>>>> Thanks,
>>>> Srini
>>>>
>>>
>>> I have been testing this patchset on X13s, switching between speakers,
>>> connected and disconnected DP output.
>>>
>>
>> This series changed the Jack event names by removing HDMI string from it
>> as suggested, did you update the UCM to reflect this?
> 
> Yes, I did. The pipewire properly reports 'unconnected' state, but
> nothing stops user from selecting the unconnected device / verb.

No, the jack events should prevent that from happening. You should not 
see them in output devices in settings->Sound.


> 
>> I have pushed changes required to
>> https://github.com/Srinivas-Kandagatla/alsa-ucm-conf/tree/topic/x13s-dp
>>
...

>> kernel:
>> https://git.codelinaro.org/srinivas.kandagatla/linux/-/tree/dp/sc8280xp-6.10-rc1?ref_type=heads
>> ucm: https://github.com/Srinivas-Kandagatla/alsa-ucm-conf/tree/topic/x13s-dp
>> tplg:
>> https://git.codelinaro.org/linaro/qcomlt/audioreach-topology/-/tree/topic/x13s-dp?ref_type=heads
>>
>>
>> with the above on my x13s, I can properly do switching between dp0,dp1
>> and speakers with no issues.
> 
> Have you tried switching to the unconnected sink? Starting the
> pipewire when the previously selected sink is now disconnected?
> 
>>
>> Can you try them?
> 
> Is the changing of the JACK names the only change in the UCM? compared
> to your previous version?

Yes.

> 
> I've used the following topology, fom the topology repo / x13s-dp branch
> 
> 5206af2e1915b8dba52da2e59fb5ebff audioreach-tplg.bin
> 
> 
> 
> 

