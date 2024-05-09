Return-Path: <linux-kernel+bounces-174318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB65C8C0CFF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 11:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B7991F221D5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 09:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FC514A4FF;
	Thu,  9 May 2024 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B96uMNGA"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D4E149C7C
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715245185; cv=none; b=UPeVf7oS9jphizsdXJb5uQeDQvVU8DFMkSQCJ6rUTUPliPGGxMzrz5+XhCj7LYQI0jm6tr4Ui0W1isF53Q5BRwARl2HWQg5kjB9F7KgqrxbRwP3iL+sF4ELVbiyIctPx2vgLOuoXeeCpO65Ex9W+xzDppgWQfaDwbm/MRUUXrmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715245185; c=relaxed/simple;
	bh=6tEP5W7E5rNrTuVQkJNbh1NgFDLzBuXP4UK9b2HnLcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PBVyRyfoL+Yc5RX4k6YPlI7sLBnvqQbpjJliGOIr4hP3bz/xgicvvouZb87nLDsv5rt2ZmCbCLCexKctrDDN4jIQhAkfJkbwONxZVo1arlesezOg//aon1DkDKvTo2d0mJg8PeHtgCmfx27tO6R/M+tXsizGN+vdhyTF7TcNW4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B96uMNGA; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41fd5dc04f0so1576625e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 01:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715245182; x=1715849982; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3RC6fstJDXsghafNDD46lbDOhml+R8Iq6EzCaj20EYo=;
        b=B96uMNGA6WLQOb3UYdEwS51ErXDtRe15S7uALNp4UCO/mAlsZ1g3KNbrDRPFOXrg3V
         VJ8GgiL2MpRBhv2mN9JxBxNlbb6660Y1jEjkRz5y8tglsbjGFTYJib3G39BHlZxd+7Gz
         51gMBzFRoAOl3aIUR3b/vPYYmrQmavc4eIrlYZrMVkQamdFJIfQxHgxB2qhrc/6t5r3s
         O4kb5TrSOurlFOBgqqLryvVNefppNsQYDR1PqBV998CV1TAyg9rUs1KMC+e6YoS297QG
         gjDjxzpWcvHWLHgiYxRH+n6z0V7X0IPt6ecy7GsXML0tgycx78QjJAlLuXCq16CvnmgM
         iWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715245182; x=1715849982;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3RC6fstJDXsghafNDD46lbDOhml+R8Iq6EzCaj20EYo=;
        b=Mnk3VsJkTTxUpTQIgmwkhusjGAkg309s/Z+0AsJ2HUDeNVX1Oy4rrmAvLXSIylSF7h
         6RDalRf22qTAQlNWILGMavbohTkiVhdN3f4aqTe7iB3EZ8KCX/LVm8ngWFjjIJ63xRku
         DR8OnCypXJkPWN6y01lgitwCvObmw0WjjKV93cnPoLelLJnvWsDYyiAPlrsP/FfoMenH
         t9MiT+KizD0CpkSHSf4sqROeIqGmbjIINHaaW5tTYuxg4VLn5TnrAibU5Nu6BNAm96vz
         UejrRy/a0gNgJp69Ed7SOk5VfAWWX/zFrFbqoC1txBS9x9tt1JjuXuFj2QdkYShtP8gH
         M/HQ==
X-Forwarded-Encrypted: i=1; AJvYcCUepebonbaXY67SeQPUzxQP3DU9DXzaN82vVUqs6P9iobRbjB8ac0SRqjylmSgHttv1Lpcp+un5zxJI7+Xy78VzhYF7B7K/NWjoD0l/
X-Gm-Message-State: AOJu0YwCUB3lF/8sZq+qJDhHtmoQiPelunFb03BNfdVdryy72KsVPC2u
	Kc1y0ebiAK95txJMHKftgxW4p6rvbQRKAz2mCc4SqKD+fyVjAvYWjZgivDTYoko=
X-Google-Smtp-Source: AGHT+IFGM+zedQ3XccNEQmdxXTeGO/UYm0MlRcoX4lJrzzJEQVjrWdPX/UOeEIf8JIQxHSLjdaIf3w==
X-Received: by 2002:a05:600c:4755:b0:41b:9e4f:d2b2 with SMTP id 5b1f17b1804b1-41f71cc1c66mr50020535e9.2.1715245181948;
        Thu, 09 May 2024 01:59:41 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-41f87c235b4sm52614135e9.11.2024.05.09.01.59.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 01:59:41 -0700 (PDT)
Message-ID: <a980d7a5-0d80-4ff1-93e1-b5f5806980c3@linaro.org>
Date: Thu, 9 May 2024 09:59:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] ASoC: qcom: common: add Display port Jack function
To: Johan Hovold <johan@kernel.org>
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20240422134354.89291-1-srinivas.kandagatla@linaro.org>
 <20240422134354.89291-3-srinivas.kandagatla@linaro.org>
 <ZiejT5yddioQ8upR@hovoldconsulting.com>
 <b9d0e2fd-069c-439c-a85f-1e99bf9018c3@linaro.org>
 <Zi-0kSU6TMcev05r@hovoldconsulting.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <Zi-0kSU6TMcev05r@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29/04/2024 15:54, Johan Hovold wrote:
> On Tue, Apr 23, 2024 at 04:55:32PM +0100, Srinivas Kandagatla wrote:
>> On 23/04/2024 13:02, Johan Hovold wrote:
>>> On Mon, Apr 22, 2024 at 02:43:52PM +0100, Srinivas Kandagatla wrote:
>>>    
>>>>    static const struct snd_soc_dapm_widget qcom_jack_snd_widgets[] = {
>>>>    	SND_SOC_DAPM_HP("Headphone Jack", NULL),
>>>>    	SND_SOC_DAPM_MIC("Mic Jack", NULL),
>>>> +	SND_SOC_DAPM_SPK("HDMI/DP0 Jack", NULL),
>>>> +	SND_SOC_DAPM_SPK("HDMI/DP1 Jack", NULL),
>>>> +	SND_SOC_DAPM_SPK("HDMI/DP2 Jack", NULL),
>>>
>>> Shouldn't these be split in dedicated HDMI and DP jacks too? What if you
>>> have a machine with HDMI and DP jacks which would otherwise both claim
>>> "HDMI/DP0"?
>>
>> These map to the Jack's added as part of qcom_snd_dp_jack_setup and
>> belong to DISPLAY_PORT_RX_0, DISPLAY_PORT_RX_1, DISPLAY_PORT_RX_2.
>>
>> If its going via USB-C DP controller it will be either DP or an HDMI ?
> 
> It will always be DP out of the machine even if an adapter can convert
> to HDMI internally.
> 
> The DRM ports are called "DP-1" and "DP-2" so it seems we should match
> that.
> 
>> This is the most common naming for the USB-C DP/HDMI jack events.
> 
> It looks like some Intel machines use names like "HDMI/DP, pcm=%d Jack"
> (with a pcm device number), but we also have "DP Jack". Not sure which
> are are used with USB-C, though. (Or if the former actually support HDMI
> altmode.)

I checked this on my machine which has usb-c and I can confirm using 
HDMI/DP naming for these jack.

Either way I don't mind having any names, but my point here is to be 
more consistent across.


--srini
> 
>> Qualcomm LPASS in some older SoCs had a dedicated HDMI interface which
>> is different to this one.
>>
>> Usual Other ways to connect HDMI is via external HDMI Bridge using I2S
>> interface which totally different to this DP interface.
> 
> Sure, but if there's ever a design with such a port then it will be
> called "HDMI Jack" and then the "HDMI in "HDMI/DP0 Jack" is unnecessary
> and confusing when it is always DP out.
> 
> Johan

