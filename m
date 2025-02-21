Return-Path: <linux-kernel+bounces-525579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E68DEA3F19E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 265977A9F1D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781412063ED;
	Fri, 21 Feb 2025 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wlY7dJEi"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E57205E21
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740132916; cv=none; b=o05aPCIeD8Uawk/vMeJ2Q78W/GA5CX8NOfmKw6EoSbVxL+umcSWmmAqyn3yKjdGXG8qIaEc0x3kZ32XbcwKvymbyWN7QQkF096b3oXRMRt2Ja2c5cs949FeTvYptM1CLP6tvPOWOWT7EgLhKEuRODscKwrlKwV8PLBINbRskQFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740132916; c=relaxed/simple;
	bh=UdcYjV22LJAtanzSNBkgkEhCCbJV4PqgUmZbYYZfH78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z7fqRmMz2Ley/rtj5w4VIWGarg7QUZe/I93ivkavsl19BnxK5v4+nT5KMHqUKB6gtQ3iSCQJnaNk4gZdmX1ddfp1gpJejyXUEj0n0mV8mabAmBH4CafiiKfjy8anLQNmhy+W6hOdQ3FCSSc8WKrC97Aj3N8TeOEpRREqKz9qxCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wlY7dJEi; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4394036c0efso11927065e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 02:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740132913; x=1740737713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i87rotjO6zoXIGEp7j7IctCY9/qoavWizZ0RPKxAJoU=;
        b=wlY7dJEiFC1MWUMWTeI/GakHlLPoYi6H8wd85GepYwm7fR7lbDBP91KzJCH78jAK3D
         JDKHptco5BlagjdDG9jSo0lkXRniiPjt4RSXhW3Xv1WSXnR6rPWJ76Z8cXpcl446yby+
         7vUh5jEG/PdRd9A49/FC/yeNYY0np24sLUCeg6Aduolu9qStfW+7bwxBTwOOzxtKr+C7
         RB2MqrcKtlDdYBfjV17Byz9g7NRykTn6Zcj5MJYCseGrsQqUbyGbLUkIimRGwb8V0lOs
         x21wTF9trSNAtSnHjVqDhP5OyzvJbWpBFLwXdo/lT4zHUbGafGwOWf49KlQWTCBRXTP4
         NIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740132913; x=1740737713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i87rotjO6zoXIGEp7j7IctCY9/qoavWizZ0RPKxAJoU=;
        b=gRaQC6eyrJBIddUTRW3Yx7BrhG6/Vrk8S2CJ9Xflq2hMJAbbsAK8icWa59Eb3hFkVc
         EUgv4WiNViTJdb7Gvf3z1oYTOKQ/0rBZMNEbnPMAHKLoeRHsJgSpSTWIWizYtTDDea4m
         RtTow4/GrjSzBba/VmhmouxHo9JXNFRh95gdU8cf4nuJq3BLi2ZC5ZNvNwRzs7up24Wn
         /oyutAaesr9mEygr8j/ULCz65D1R+TLQ/SQQw3k3yGmd7D0FnBPxoNBD19+AWjdcoeI3
         05Gvb0ZfOXNVL8ds4Jp8bq46F2p2M5U6rEcYCuybu5+DXLIRi0gsm2n07dj38LJT7Eoz
         PKUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdVui4NbsPnJlNoxGfhcaEQQnJaDtJfwqBPoKL4CvdZ2UPeoKQsCHb9635avaagQITmRX46gk5uGIJo6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfwCMlPEPeokDVM+48OV6LdTcrvTosr3qg2cf1zxcwgBrSbhgn
	WGNb2jeWfFuiLumyCD2yFTHkMoSZeFbUEZjBeDXL711hORShoG3IOcx/kTfYEe8=
X-Gm-Gg: ASbGncug6DU0Nnn6VzMZpARDCMPaef1myrCpI93VkDkJIQc658G3iPkjH3WealPr2cu
	XgBupaDzhpiuM9GIeeFCrRcImLVmB3BXwHjQ/DunsNAm37Jwlk74BUYfHED9uldYb88XxUHCT7b
	o2JruYBb5FRhhl4FHsD1brRzmAFtjLN4F/oHHeI0dGAuadZ2ENPYmC7P71ycTR8lU1u9bhv9jf3
	AJtAspfrQK5xUGHRVBlb76tXo1zTtbisFdHwESQpd/4HheqMH4JUMNOJFCO/Uxc9zJ7GKp0KbLi
	DXuUzwxHiQcrzJVk74S/wMdKXcYhRyGv6piO9UqweG2R
X-Google-Smtp-Source: AGHT+IGs9NvKFIrKnXrzHMSGbBJ0oy+uXlJm086a7XejqQUgpF1zmN5RxP381nbAlt43bqejwAwrgQ==
X-Received: by 2002:a05:600c:354f:b0:439:6ab6:5d46 with SMTP id 5b1f17b1804b1-439ae21d210mr20795145e9.27.1740132913197;
        Fri, 21 Feb 2025 02:15:13 -0800 (PST)
Received: from [192.168.68.111] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38f64b0f565sm4215318f8f.51.2025.02.21.02.15.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 02:15:12 -0800 (PST)
Message-ID: <b359e44c-fb9f-412c-bc3b-f0a129d0c34e@linaro.org>
Date: Fri, 21 Feb 2025 10:15:12 +0000
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
 <Z7g5c0_vJNpN9fI4@hovoldconsulting.com>
 <Z7hAfGHvdeWpZ4Y3@hovoldconsulting.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <Z7hAfGHvdeWpZ4Y3@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/02/2025 08:59, Johan Hovold wrote:
> On Fri, Feb 21, 2025 at 09:29:39AM +0100, Johan Hovold wrote:
>> On Thu, Feb 20, 2025 at 06:38:11PM +0100, Johan Hovold wrote:
>>> On Thu, Feb 20, 2025 at 04:28:42PM +0000, Srinivas Kandagatla wrote:
>>
>>>> On Qualcomm Audioreach setup, some of the audio artifacts are seen in
>>>> both recording and playback. These patches fix issues by
>>>> 1. Adjusting the fragment size that dsp can service.
>>>> 2. schedule available playback buffers in time for dsp to not hit under runs
>>>> 3. remove some of the manual calculations done to get hardware pointer.
>>>>
>>>> With these patches, am able to see Audio quality improvements.
>>>>
>>>> Any testing would be appreciated.
>>>
>>> With this series, the choppy (robotic) capture when using pipewire
>>> appears to be fixed (pulseaudio worked before).
>>>
>>> Playback is still choppy (heavily distorted), though, and now it also
>>> appears to be too slow.
>>>
>>> I tested using pw-record and pw-play (and mpv) on the T14s (6.14-rc3).
>>
>> Retested this morning and realised that playback is only choppy (and too
>> slow) while I have pavucontrol open. That would be nice to fix if
>> possible, but this is still a great improvement since pipewire was not
>> usable at all before these changes.
>>
>> Tested-by: Johan Hovold <johan+linaro@kernel.org>
> 
> Hmm... Scratch that.
> 
> This series apparently breaks pulseaudio instead.
> 
Thanks for trying out pulseaudio, I will try to reproduce this with my t14.
--srini
> Too fast playback on the T14s with mpv, and after I stopped it I wasn't
> able too play any audio anymore. And systemd complains about a stop job
> running for long when rebooting. Similar issues on the X13s.
> 
> Johan

