Return-Path: <linux-kernel+bounces-344400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E8898A91D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6A61F237FD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BB7191F8A;
	Mon, 30 Sep 2024 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LhG+K8Z2"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B2713634C
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727711578; cv=none; b=O498MaSwisyS2NulE65QEq7ThwX0V3JolZychg2VDu+7eDaPB8AYj2KU4HmhHgW27iePdNuemmG6QGDyii4wH14ReYu8Dnsl22vPJj5f8PJg6QkSOG+MWU4wT4hjqQY1GkSpba8dVQFOf3OVm8PJwkx3oLJkTVMO4MENP6m7f+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727711578; c=relaxed/simple;
	bh=0TLcAgHH7m/siCgQu8Dey/SFlXIMwkFOzNOmiqnZK1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iLUBymwQvcPhf8sbn6obnU7KvJga9F7TFj02OnW5j2BYoX9gjaWCaTjnauAKgFwqoies7tz+C84jeT0pSnho+hZ/w4JIPS8XBkwxzFxI+CLTJu+bAOvLenL2IrRkEK+Lg7F7TGOBAvwD5e0Lyak0dNfksx8bDQNKNd9qyMBMQBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LhG+K8Z2; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a1a90bd08cso16232375ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 08:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727711576; x=1728316376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pQM3NCJDPN3JicDKJjF5JzneVwHgszVonhw5AwjmTvo=;
        b=LhG+K8Z2S0Zr37Jhy253l55ebvBhhgPPNngyfqIUCuDCvq6haI+/nhv4iteQAlngSm
         PkkhDgnJpwHRiWz5xFwEYGov5flquEP0+ZT5qy5cuKYoRtrrbxytJ9GzHs+PNo6b7rOz
         1OpfrV79V5NmhzrZWZ8NnhBh3zZ9aKYJD8w+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727711576; x=1728316376;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pQM3NCJDPN3JicDKJjF5JzneVwHgszVonhw5AwjmTvo=;
        b=XDwwEcV9b6r5NNznO51N+xZ8vaVhmFaQ5x4yR1BHK4v1NrOF4YV4kFYmimGF7jJDIu
         siNgK6CIgSJ491grGTrbpRjwoKui/PSqOMygWJi2jqojTk9YhMue+OGeqR0SxFk/tuPP
         nmI861NOIRi92YPOlalTmaZnco0VVIMu0tPl/VlpUa4SjXQ9JZFRFbcjIuh7foHJ5RtG
         MMUJqRxVNnLsZlBQoCorONcYzx/AhjZzp6PsvGV5Ri5bF4AQn+gQkS08mm5rl67OjWNE
         LzelYBf5EoLDi6SLjkYa+AqO5ZrlmtRLwp9jYT0FFuNQw+Pnw6o/MP2K83CSC6aTqYxi
         dDng==
X-Forwarded-Encrypted: i=1; AJvYcCUlcunvnkwUXI0mWoq5cWsLNAq+cNRHXRoPN7A3bfsSKX7yglbzKxRsT0Y078kFslktPQuTFSghXoJ2rTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAGQYmjIFH8yRGnCJMhUnCANQtqq+fF5tkgw7971hxhJEao/wg
	tcJYx8oH0qk9UfcXAiWXEwGppDDsUpUfJJz2dZR/ZZ5V+/HFCEqyJqnG47g7HWc=
X-Google-Smtp-Source: AGHT+IGcBcQUqsljvEyKjVjYHWn7+Ju8/TkXHpj/UJODiFspBNxDpDxN2XPSpV3o99CUipgQnCvYmw==
X-Received: by 2002:a92:ca0c:0:b0:3a0:a0a1:650c with SMTP id e9e14a558f8ab-3a3451b6ca7mr112165035ab.22.1727711576524;
        Mon, 30 Sep 2024 08:52:56 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d8888c34d4sm2184304173.108.2024.09.30.08.52.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 08:52:56 -0700 (PDT)
Message-ID: <bc8f9633-57b4-4c70-b7ad-0da0b5d66dfa@linuxfoundation.org>
Date: Mon, 30 Sep 2024 09:52:52 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] tools: power: cpupower: Allow overriding
 cross-compiling envs
To: Peng Fan <peng.fan@nxp.com>, "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Thomas Renninger
 <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 John Kacur <jkacur@redhat.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240919-pm-v2-0-0f25686556b5@nxp.com>
 <ZuxTjy7I-pZBcXa0@rhfedora>
 <PAXPR04MB845910C56EA61D3215DA5452886C2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <PAXPR04MB84591B0819F847D79548CFB0886C2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <Zu1uNyTWDgot8cQY@rhfedora>
 <PAXPR04MB845992183A08AAF05C339C05886F2@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <PAXPR04MB845992183A08AAF05C339C05886F2@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/23/24 00:26, Peng Fan wrote:
>> Subject: Re: [PATCH v2 0/2] tools: power: cpupower: Allow overriding
>> cross-compiling envs
>>
>> On Fri, Sep 20, 2024 at 09:01:49AM +0000, Peng Fan wrote:
>>>>> Not sure you need 'tools: power: cpupower:' in the cover letter.
>>>>
>>>> Will use "tools: power:" in v3.
>>>>>
>>>>>> pm: cpupower: bench: print config file path when open
>>>>>> cpufreq-bench.conf fails
>>>>>
>>>>> I do not think you need bench either.
>>>>
>>>> Will drop "bench" in v3.
>>
>> I do not think those alone are needed for a v3 since I was corrected on
>> the changelog; at least as far I am concerned.
> 
> I will do a v3 to convert perror to strerror per the reply in v1 from
> Shuah.
> 

You can send perror to strerror in this file in a separate patch on top
of my cpupower branch.

Thank you. Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower

It will be included in my next pull request to PM maintainer.

thanks,
-- Shuah


