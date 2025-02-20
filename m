Return-Path: <linux-kernel+bounces-524216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7F8A3E0C9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 131F13A7DD1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A18E2045AB;
	Thu, 20 Feb 2025 16:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZWTAu4sf"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636B7DF58
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068873; cv=none; b=sPN+hh9YnaFyfgt64QEe1DQiEKzYtg5fGMPIrcgZXipAbh4Fhcms4UQuR21LS6k6uUMnkRk5xLdnAxfjA1EW3i4j2T3+gVXbN/M+p6b9uLZ/m7wacnihvYguuQw7mJKQihcOV0faOSQafcO8PinxLSOhirTkWnfuLclUOad9e6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068873; c=relaxed/simple;
	bh=BLQ1IP4exzcN8Kb+oDw9C4Il2MvG9m3hGzv57Hm52xw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CITn/0twl0wvpzd+YhpHfQRQLktNpVS+cI2JvnP7HZwoYXVRHjqg9sxgQ56LlRuKXimxDazb0xGyLVaFSMCZ4ESme3JUGTa1d5aqQvSDz/ytT/eiHxmc8eHJPjUv3Kf+f/9oXGpb+XLL0+H1MoW8QO0OF7z82tETtcqBgaXDzVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZWTAu4sf; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d2af701446so10115885ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740068869; x=1740673669; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AwjlKhRG0iGOyn0ejvOkf3BvOfxLPNGzGQ5wbxYo/lU=;
        b=ZWTAu4sfiM5NvJYVNNWLkOi2RDKRuSbwq1JKC0B3ud95i+Xny3X6GOKdg2+3DMKncO
         YIQCOCBasIYhihetGbUHf22bC/ijrhyI+QwW0kjL6VSIEpOHu+ZS2ehTp2WyZxCXdIBE
         udnkOcRb6SOisr69W1u3GttaP7S9Uozf2iIZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740068869; x=1740673669;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AwjlKhRG0iGOyn0ejvOkf3BvOfxLPNGzGQ5wbxYo/lU=;
        b=eT/84dHbCMzmCsEVO6vJKaR5jTEibe+U9MRtNdPtDbzAs+SUb5ntURhifYFgxIcK9r
         HeVahhbu1ie2NwIT7utUC+vZTe4qS8Zk8+7RvesYfuQ/fjpcRUcDuPl12IogwEYhFeFE
         4gq5YJp35E2/otazcEpOJwC+6MIAQv2/mrJ2/LdmpLDcwfFjD1+NQu5w6oPcjZF6RbvP
         93nh+joOYfk78584MrQI8kMvXAYmN1EsPgikq0gAASPvi+nYWUaFQEddmjNN/Iwbdyss
         PUJOBu6ydBPZ4tOoCJR/tK8SB7SXBRT4BN3PuplACETu60t5/4bxClHBTX8b4M1ZX4Qb
         L39Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLw22YHWxvVSASZ+CT3e53yxr0Hg/R+pJPYOh6OxjJi/iVm1rDfM+VFLAgMkf5dCMl/HkrjBZ+yq2pM6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YznSPO1gq+1N1d3ZDESRbe68O027GQRaUY6J+cj2hPUWNonXTYT
	prl2ACvAHPp0I3rg6dyPXlePwjxmPwHcTpVRFxaRygXWBoTrXm3GIFFD6cljMFpSLvjsN4jXDPX
	B
X-Gm-Gg: ASbGncsNBsH8+YMrY10I7oeciJu/wD+j3zFN3eYUb/c/vxXTzresurEJ7cti9Kl39sk
	pwcjHbEImLVdCOrVKIc6k9lYnnGiEBlJ3K/YvQ6CcElBqdzkQBcbMyAa7aAVmTjK/MZTiSQxsv7
	AyQB/E4eZXPivz+GR8QLpFYVeoCslxhVb3j6jhGLyzbbIthkGxPt6U1sIFzQRcwvMEXJntqNiz9
	aX/DPuBwvBm2LAK6FgjfHBQTtGrq4Rgi2ZZ9uV/B8bebkX5LQa3TJYsNU+rkeKokXR/08HjAw2c
	1f6aMuwBRu9QnOdGW9rnfOlvVQ==
X-Google-Smtp-Source: AGHT+IFASkn5j/fmfjTm2TAx7kTG0tE4mRqekWxZMkb1c+xrRe5TIpTFGtFlIN+DjXR3rXi+Js/zuQ==
X-Received: by 2002:a05:6e02:20cf:b0:3cf:c17d:5cc0 with SMTP id e9e14a558f8ab-3d2b52df712mr77663015ab.13.1740068869421;
        Thu, 20 Feb 2025 08:27:49 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4eeb9359772sm971606173.60.2025.02.20.08.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 08:27:48 -0800 (PST)
Message-ID: <fdd0356f-d91e-400e-9598-d34e0862c9cb@linuxfoundation.org>
Date: Thu, 20 Feb 2025 09:27:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: vim2m: print device name after registering device
To: Matthew Majewski <mattwmajewski@gmail.com>,
 Uwe Kleine-Konig <u.kleine-koenig@baylibre.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250219190501.295976-1-mattwmajewski@gmail.com>
 <ym5q2cpn2lxk7sarylnf4o3ztvtnb47wroxdiibdsp6yz4gt2y@jfyfo2ekmdmj>
 <5051c252-f1ef-4731-b0cb-fedfcda04d98@linuxfoundation.org>
 <61bd42742ff8a8e5f409b0f2ccc4ab8875dfe7a4.camel@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <61bd42742ff8a8e5f409b0f2ccc4ab8875dfe7a4.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/25 08:29, Matthew Majewski wrote:
> On Wed, 2025-02-19 at 17:21 -0700, Shuah Khan wrote:
>> On 2/19/25 14:58, Uwe Kleine-Konig wrote:
>>> On Wed, Feb 19, 2025 at 02:05:01PM -0500, Matthew Majewski wrote:
>>>> Move the v4l2_info() call displaying the video device name after
>>>> the
>>>> device is actually registered.
>>>>
>>>> This fixes a bug where the driver was always displaying
>>>> "/dev/video0"
>>>> since it was reading from the vfd before it was registered.
>>>>
>>>> Signed-off-by: Matthew Majewski <mattwmajewski@gmail.com>
>>>
>>> A Fixes: tag would be great.
>>
>> Matthew, there is no need to resend the patch. Just send me the
>> Fixes tag and I will update the repo.
>>
>>
> 
> Ok, here is the fixes tag:
> 
> Fixes: cf7f34777a5b4100a ("media: vim2m: Register video device after
> setting up internals")
> 

Thank you. commit is now updated.

thanks,
-- Shuah


