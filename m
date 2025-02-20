Return-Path: <linux-kernel+bounces-524424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74423A3E2ED
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5F74224D9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64949213243;
	Thu, 20 Feb 2025 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tpY863UG"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3AB2135B9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740073454; cv=none; b=j9zVSIE1s8oCJnXUoKJVcLL5NiQjSSzBIu2neGn9HZIVxs7F8kKDcP79q6CQ3uKUxTfG5ul4g1JqjzqiRi7Q2h75LSe7AS44I6BNk8riX6/6AnY9k87vTQv7XeN9v28+fKO2yVac3+ntpxk+wKlnKV9UkleO35B62bFdBmBvBOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740073454; c=relaxed/simple;
	bh=DneaOLbAQ7VQD+JuzmSchiqjCJyQCKdlD8hIDvj4wBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fLtNK+lJCqaAotTKr2OUG5tJRg3w6lKktMyefrwn4P2X7Erbci5Hs3pb+oqz5pxrPRJyWEKpHcXVlIBD5TLCF2eAFsTQKIdNWotrlbjKZzP9LqXL736IbJUOY8wz8kvWKrGC9PZsFru1vFIIgJ3VV8At5Skhd/OdGMMyJZTvlh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tpY863UG; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43996e95114so8385245e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740073451; x=1740678251; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BZRZWiGBAfgL83TcOf96tTHitqDUChal+U/SH39N6Mw=;
        b=tpY863UGoj83sF0rTFvH60dFd8TQ00iFmPXsbTcOiIL+CE2+xmlJJQZzdCvErBURvw
         u75HcNB2/5sS2mQgL0OkBlVVdVWmiTCBOwH5SqYy/irLqsgZZ3JDiCeQzbIpA0/5qAhz
         2cpXdqtE/rEuabyum3+3HAq27URYX5hHKwy2eMcdOTlPbYz4MPWVVz9TF+8zZY3SVb6V
         tiLPXnFGtyWzYfkM/2HPCOG7NxWHIIlLKDqecI4RxVsam0OebuyxaveMjIE9J0u1N+rE
         ss/Zs3x4gizRfdaSz4MQXD87nXcJg1zHKMJqcfK6qaOrHhCQTp9+UbFnYN/gXzW5JDfH
         iuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740073451; x=1740678251;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZRZWiGBAfgL83TcOf96tTHitqDUChal+U/SH39N6Mw=;
        b=QxoJiTHVVBwXWgiK82VXtPCqKEN3QkBbEDIDtJGpGySUj+h0P3Wefz/kRLHf0QKxxG
         hEX9B/bPQNk8Rjbo0bhRJG6QGjdJQEeIlJyKI8ToLtLUrHe7y2wg3i54F1QgdWEwpk56
         BeUCPfgkAiXEXvZl+QnKCtDongRrGea+FR4ikRwanBe0Y1AbTVtQWIWKE8Nq9LwXdHeH
         iwviFGucUgUm8Q8jwrqukxlds5b0OBD/ndKFmaYRPPnV1qagpGDarBBL5CHAh8cLZjf6
         2Cbtbm+3b9YErKcSlNUNUG0l0pw84lfvNoHIPV1s3uMkLonjElhtd0h56jZ1bg/JwYJ8
         B5pQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8vc6dcWXE3PJOTFRx8/G1IoazXIW15zyc1kARc606sspIMWmDYE7cETx1ywSPoGDgPPtNPYAt1Nu2aME=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrDFlyM7EFqM0FGQm0rlJyyty+XusEEeDPDC29/ZelP7v2U+Ep
	hX8R9OITJ6XWgyWD80jhzehavsmWAPaj70B95cLn8tjYlOT3V0Qd+IpgvlgyzME=
X-Gm-Gg: ASbGncu6MFJZwCToXhanv4mVhnd7Zf3Keo3OGxXrOdhJXpOWK9yYLCZ7+df5b3HRz5j
	njsRCDxRefEJgasCxaTe9flJX+6rGH2nuZ+/j5Y/Ddjin5pSUrHzeW9+xIlJZxS/MzZ5x05ud6y
	8qXDhTwvGRXsGtDrqIgZ3kwd1iNTKOC4dfpWriDWdKybblwzDv+pkIUAKIc1wiKc2lmVQOXJ02D
	JvVlqgFYkUk2WwrqnApkNeBp0+r5xDleUm7O7/cm53OLPTRhINbwEr83wtL9wrsKMfIjq/4d+/r
	yysMhPbESqcyB5oJ3W0SbQwAsPlMJm+YrQ==
X-Google-Smtp-Source: AGHT+IFe6CdnY0iTDDh64olzUg8kY4wR9n3edQZV0kmbJbpdhL+rgUP7hqGBidLPFVQcmbfkko7vlg==
X-Received: by 2002:a05:600c:3b8f:b0:439:9c0e:3709 with SMTP id 5b1f17b1804b1-439ae1e858dmr1240095e9.8.1740073451357;
        Thu, 20 Feb 2025 09:44:11 -0800 (PST)
Received: from [192.168.68.111] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43984dd042fsm123446215e9.12.2025.02.20.09.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 09:44:10 -0800 (PST)
Message-ID: <2f8a46a5-80f4-4c79-9493-6137e1f4940e@linaro.org>
Date: Thu, 20 Feb 2025 17:44:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] ASoC: q6apm: fix under runs and fragment sizes
To: Johan Hovold <johan@kernel.org>
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 krzysztof.kozlowski@linaro.org, linux-sound@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dmitry.baryshkov@linaro.org, johan+linaro@kernel.org
References: <20250220162847.11994-1-srinivas.kandagatla@linaro.org>
 <Z7dog3cWe4BroZdT@hovoldconsulting.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <Z7dog3cWe4BroZdT@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johan,
thanks for testing.
On 20/02/2025 17:38, Johan Hovold wrote:
> Hi Srini,
> 
> On Thu, Feb 20, 2025 at 04:28:42PM +0000, Srinivas Kandagatla wrote:
> 
>> On Qualcomm Audioreach setup, some of the audio artifacts are seen in
>> both recording and playback. These patches fix issues by
>> 1. Adjusting the fragment size that dsp can service.
>> 2. schedule available playback buffers in time for dsp to not hit under runs
>> 3. remove some of the manual calculations done to get hardware pointer.
>>
>> With these patches, am able to see Audio quality improvements.
>>
>> Any testing would be appreciated.
> 
> With this series, the choppy (robotic) capture when using pipewire
> appears to be fixed (pulseaudio worked before).
> 

> Playback is still choppy (heavily distorted), though, and now it also
> appears to be too slow.

Interesting, Am running 6.14-rc2 aswell on t14
Both pw-play and youtube, it seems to be fine.
Let me check my pipewire config if I had disabled the tsched.



--srini

> 
> I tested using pw-record and pw-play (and mpv) on the T14s (6.14-rc3).
> 
> Johan

