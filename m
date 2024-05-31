Return-Path: <linux-kernel+bounces-196360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F4F8D5AA9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F5471F23A0F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 06:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F7E80027;
	Fri, 31 May 2024 06:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k+3j+SoV"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBE1339A8
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 06:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717137888; cv=none; b=tAM6LJfv67HOcSDOm5XWw87b4haLXOXQt5fF/KqztrsJpzTqSoM35oLuXMfNDtooww9G161TiR3RE2K4+/2SZZHzGpIIytmorW2Mu0PEZ7s7hqtrBukZepYZWvx5AV0GMuTj7P12eHXEjRocCFBA7pC0pIL/jZTjYwXwPTU2l4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717137888; c=relaxed/simple;
	bh=BCGsz3iZV2DrmSa/WUkiRfpcRISW7pinFjp8ivjl398=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F3LAbpAYQMRfrfrV07ur3+WBCxEZlWEHCHY+9hIve99eikhJkkl9SzG94djCB2XHLcktqhOomXMVdu9ZUF9WqBZjN+9G5BRc1I1zvLmwyhnQMJFQZSP0vSKPtZO2f5I7SuCmIjxfWbyabKSisMBXZ95aUjNcTvpZZCLkr+mfOUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k+3j+SoV; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-62a08b1a81bso13975647b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717137885; x=1717742685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rHvbYiipVOuDjYGCfTtKSuc1awi5eLZfdGsz5nVF2ZQ=;
        b=k+3j+SoV2TCpjOslTAt9PMA9pAXJtMuAI2nngCD2w2K+7eS2Fbc6bePVtXFPBp3plu
         4ZOcTPcszaO5sBY718byYyQwAoRQ8LKPfJzl3+y6yu/Q0LbRpQPjcN3Sfcz3Z6a/rHEv
         LQ5NA+KIt3cSfaU3Ef21gjBmTfKLonBbSP6R3mnlW7vU2o1IgX061orUR9riIX0ZMAkb
         cfRP4DG3AMdlrsgtnAdmHmCsgUjLr/c3irfx1JX7nJ5DZUWhEF1F3WafXVndXFaXAvA2
         Ehtu/ZpLyaJE80wa3frXRJ5r3uRg6OZ9+MmKba7uX9jnHjt/j+/RmZkmXgRJowcrlZh2
         QoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717137885; x=1717742685;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rHvbYiipVOuDjYGCfTtKSuc1awi5eLZfdGsz5nVF2ZQ=;
        b=LXGq0rb5h36MPd6us6AxWllbzjmaYv9UovTWqY1s7Bjsqbe/TLQavhay74AwjBOqgU
         kukVda6kiyQRWeQCK5/87wiSquI/w73aWIO6CIDSSXVhlEsJ6rRVorZMIVVx1GUiiPw9
         45tuhEpfen2p/dtRFFNTSEk13miwH4QcUlNuH+VHMVzLsQ9nVVwsRdatUG8luoGOrLu3
         qZjzEbTMdXb4zWoKdH2RhLaEE8Ayc6wgSS5IwfsX/p7E4L72jUAyEUMvBHvD1LNPtdtf
         YCn6aKvb1Om0gyib1f0Feisvdyr3duBtVLnX7ejepxrz+6cHFFuS5j+08ONHo4Jyd4iW
         suEg==
X-Forwarded-Encrypted: i=1; AJvYcCU3J7+l1meNaZkwf3RQaykc41ivQMXaKY6ANCSTXRRbhWNLW/RSamhCQ//pFhqmFT+KPcjbUy85O0GyMNPrcnt4uxpfADfXi5UdwZ6y
X-Gm-Message-State: AOJu0Yw0d6BO4YT3mMYtAnlmuBducfTOO6YQO/iL39KGWWhQYGsgWq59
	vbfmlm7m1E+4/7Lf5w45ZAjsY7zbETLuXQgP4D+RWrYQCPUhG3oM/1OC7hPQ+5oWK5TrQ+WpZin
	+
X-Google-Smtp-Source: AGHT+IEbplcJjnkF9ceT4BZITDuJNgu2aEsuEwyLLAkBCdRRYbtUcF8wWEdP4XOrGo4ERPlrSMTPQw==
X-Received: by 2002:a81:ed0d:0:b0:609:ff2d:1814 with SMTP id 00721157ae682-62c797fd91emr8919517b3.37.1717137885591;
        Thu, 30 May 2024 23:44:45 -0700 (PDT)
Received: from [192.168.86.191] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-794f2f042dasm39390285a.22.2024.05.30.23.44.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 23:44:45 -0700 (PDT)
Message-ID: <87e109a7-2088-42f7-b8c1-fb549fe3e377@linaro.org>
Date: Fri, 31 May 2024 07:44:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] ASoC: qcom: common: add Display port Jack function
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Johan Hovold <johan@kernel.org>, broonie@kernel.org, perex@perex.cz,
 tiwai@suse.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
References: <20240422134354.89291-1-srinivas.kandagatla@linaro.org>
 <20240422134354.89291-3-srinivas.kandagatla@linaro.org>
 <ZiejT5yddioQ8upR@hovoldconsulting.com>
 <b9d0e2fd-069c-439c-a85f-1e99bf9018c3@linaro.org>
 <Zi-0kSU6TMcev05r@hovoldconsulting.com>
 <a980d7a5-0d80-4ff1-93e1-b5f5806980c3@linaro.org>
 <Zlj_4IuZqnC3gESL@eriador.lumag.spb.ru>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <Zlj_4IuZqnC3gESL@eriador.lumag.spb.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/05/2024 23:38, Dmitry Baryshkov wrote:
>>> It will always be DP out of the machine even if an adapter can convert
>>> to HDMI internally.
>>>
>>> The DRM ports are called "DP-1" and "DP-2" so it seems we should match
>>> that.
>>>
>>>> This is the most common naming for the USB-C DP/HDMI jack events.
>>> It looks like some Intel machines use names like "HDMI/DP, pcm=%d Jack"
>>> (with a pcm device number), but we also have "DP Jack". Not sure which
>>> are are used with USB-C, though. (Or if the former actually support HDMI
>>> altmode.)
>> I checked this on my machine which has usb-c and I can confirm using HDMI/DP
>> naming for these jack.
>>
>> Either way I don't mind having any names, but my point here is to be more
>> consistent across.
> I fear it is till not consistent. On the Intel laptop I see following
> jacks:
> 
> numid=18,iface=CARD,name='HDMI/DP,pcm=3 Jack'
> numid=24,iface=CARD,name='HDMI/DP,pcm=7 Jack'
> numid=30,iface=CARD,name='HDMI/DP,pcm=8 Jack'
> 
> On the other hand Mediatek and RockChip use just 'DP Jack'.
> 
> I'd suggest settling on the latter option. We are closer to MTK and
> RockChip rather than Intel.
that is fine with me.

> 
> BTW: a platform can easily have 4 (x1e8100) or even 8 (sc8280xp) DP
> outputs. Could you please point out why there are just 3 jacks?
The CRD platform that I have access to has 3 ports which is why I 
started with 3 ports, but we can add more ports as and when we can 
really test them.

--srini

