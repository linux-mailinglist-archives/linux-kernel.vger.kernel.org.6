Return-Path: <linux-kernel+bounces-554726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F4037A59B9A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E34D716EEBF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B58238163;
	Mon, 10 Mar 2025 16:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MhgCgACk"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BDF233721
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741625367; cv=none; b=Lh2sBRZN8gdYSzfvBYtG5dBpA44NVeRVow0fk1w/UoYUNjAP/gGv4WySMqmB2HqWF6J6sWuAFDwbE4Jy0n/FXyhk4hshHMNKYzubMYXdmFNR5CtHHNlVoeEL5kI7Zqnw8TKT1Xl5qgyLa5xnXyXHClUkuHEuQyw1iVyQ4q9nqSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741625367; c=relaxed/simple;
	bh=4eZz5t8TmyBMoGlxRqvWrcvr4CS9phpiK7yt0a+8Obk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=stA4peJOE83y5hGRPH9U1Bj1eJE8eT25o8JM2sbFbMNQkjTfQ01QhaM0/O04j5Sik0/WjfDHydjnP+ku5Z6CH0xEVu86C67i/nVJejrB91nDr+KZHrAs2jZQkjViJasZcbCCqmhScubCxId8/CIkOHHoGjuEz6POzyRtT2rFROk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MhgCgACk; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-85b42db7b69so17960039f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741625364; x=1742230164; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZH6ZP4MFWU7A9nUkRxA5hx+hpyq7yda/wp2Or2UB93U=;
        b=MhgCgACk2fIjNdxt+dynZWlyznDsGvSVTE1u5M55sjdfARgkAmqrcpcgUCSua/6uCC
         bKhXEfS6FkX1/wLuQ7S1zBJy2yBCfjvdIvHR3AghDkKAaIFYOkuHzS43KOaGV8zJ9l+6
         6bInzwIVb1NddKRYVv7AHXSvfVqvXqhvZtWxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741625364; x=1742230164;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZH6ZP4MFWU7A9nUkRxA5hx+hpyq7yda/wp2Or2UB93U=;
        b=rFTcDA2wDviBAxMqTAKr4TMqV2agVj480IIbrL8Svwcm02+ufurGVqFwW+kz/1JUKP
         hfMbQP99YpYbq9wre0V8SFknBU0O9PjsOfDyafj+mmUUnYI665nBt4FJn1xU6vyiN2Nt
         KXmYZaeUhqV7fHaQ5yBkvk0bOeHHTt+Ctm0CXNtEEU9R4myE4jWgVMksSxg8nHle+4sx
         3jMzsCGYz1n3Dc16//oCG79xxCxnhU8AD0xKSJX3TsVeLtlcq01F8++PC2zgs+Z9paU1
         +cvkJx98BOe5wTs5QKjNYn6PlpnXglXTQxxxwl2+nmKnQkHQ+Ylo1uTEv2gZUgp0wdkg
         SXNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUo9Ses/o0Xc1UTNjG5lG0H4O/H51CavCjY7a0+/kFRgk/XWU1K8osIrbDeTFMe8StqD++L0Nr9S+nFty4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvE2tm/Fka1OZKqXBCTNxEZ2fXWGZhHPOdbWJd+uDVCaQVcWyI
	uz7kne83Jq4B//RToKGv+ahASaMy58MejRwDdQ+CJM23r2xcx9yINgNb+owhB3g=
X-Gm-Gg: ASbGnct6kltZYGxXjlkL6C5rCEGeNf9r6Xc0CCpxg4/cOFXurOF1spjuwr5Xf+pccO7
	Eav4txFBJEwHyynL+iFFvCuTYCgC0GhCbqE8hxcqzZDhadaOv5s6aoTpb7DOttTYop3kmX3+ZmE
	z+zUFOl6tk/PO5FDaqNXAvjXz4CLHI1ydaIygScncRs9sGxiTJILxw7dnj4OJUubOZ7/L/kO84T
	AdreYiFcG56tiXFQXHsFC9qsW12eybE0CQwf6rtM3ayipg0xOp+P1pOP3a08YDMD7ASvMhgPDTQ
	M6fBRo8dOdn4VslZ7Oket0bbdIVfEGqXJr4W7T3xvy/RCLuMfPhT09M=
X-Google-Smtp-Source: AGHT+IGLDbRYGP1wg1ZeFwOFD6XsJvCaWS9YFdaCgt+vrDCYBV37HnxlKh3y8F5V50/QJOi38l3Fsg==
X-Received: by 2002:a05:6602:388c:b0:85b:3885:159e with SMTP id ca18e2360f4ac-85b388516e9mr1121116939f.3.1741625364455;
        Mon, 10 Mar 2025 09:49:24 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f23a01ef9dsm592827173.125.2025.03.10.09.49.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 09:49:23 -0700 (PDT)
Message-ID: <803b43c6-9aab-4380-9753-fd2efa8061fa@linuxfoundation.org>
Date: Mon, 10 Mar 2025 10:49:22 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usbip: Fix the error limitation on max_hw_sectors for
 usbip device
To: Zongmin Zhou <min_halo@163.com>
Cc: valentina.manea.m@gmail.com, shuah@kernel.org, i@zenithal.me,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zongmin Zhou <zhouzongmin@kylinos.cn>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250219092555.112631-1-min_halo@163.com>
 <88b2fb4b-96a4-4d29-bf92-4064d3572fa4@linuxfoundation.org>
 <5a41d6c3.8c78.195371996e0.Coremail.min_halo@163.com>
 <247c7e15-bbff-427f-8315-ca463f8b933b@linuxfoundation.org>
 <4d4035bf.26b9.19556dcc23d.Coremail.min_halo@163.com>
 <c49917d2-5157-4878-9866-be6053b5124d@linuxfoundation.org>
 <6d47fef6.9eef.19565c308e5.Coremail.min_halo@163.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <6d47fef6.9eef.19565c308e5.Coremail.min_halo@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/5/25 03:03, Zongmin Zhou wrote:
> At 2025-03-05 03:45:28, "Shuah Khan" <skhan@linuxfoundation.org> wrote:
> 
>>On 3/2/25 05:37, Zongmin Zhou wrote:
>>> Dear shuah,
>>> 
>>> 
>>> Yes, I agree with you.It would be better if there have a more simpler fixes than This patch.
>>> 
>>> I can just think of the two possible solutions that mentioned before.
>>
>  >What are the two possible solutions?
> 1. The patch we are discussing now,have to change the API between the kernel and user-space.

2. Simply set vhci-hcd dma mask to 64 by default,just modify the vhci-hcd driver. Then dma_max_mapping_size() will always return SIZE_MAX.

I prefer option #2 - What are the downsides if any with this option?

>>> 
>>> 
>>> If SWIOTLB disabled,dma_max_mapping_size() return SIZE_MAX.
>>
>>Right when CONFIG_HAS_DMA, if not it returns 0. Perhaps we
>  >can ignore CONFIG_HAS_DMA=n for this for this discussion.
> Yeah, let's ignore that.
>>
>>> 
>>> Only if SWIOTLB is active and dma addressing limited will return the swiotlb max mapping size.
>>> 
>>> 
>>> The swiotlb config seems rely on many other config options like x86_64/IOMMU_SUPPORT and so on,
>>> 
>>> and the configuration on host and client side only use the default at all,Like the default ubuntu release version.
>>> 
>>> It seems that switlb is enabled by default on most platforms.
>>
>>If understand correctly the problem happens only when SWIOTLB
>>is enabled on client or host?
>>
>>The following combinations are possible:
>>
>>SWILTLB enabled on client and disabled on host - rate limited?
>>SWILTLB enabled on client and enabled on host - rate limited?
>>SWILTLB disabled on client and enabled on host - rate limited?
>>SWILTLB disabled on client and disabled on host - not a problem
>  >
> This problem happens only when SWIOTLB is enabled on client,have nothing to do with host setting. Because the USB xhci controller may set dma mask to 64bit if controllers support. The combinations may like below: SWILTLB enabled on client and enabled/disabled on host - rate limited SWILTLB disabled on client and enabled/disabled on host - not a problem

Got it. So the problem happens only when SWILTLB enabled on client

thanks,
-- Shuah

