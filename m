Return-Path: <linux-kernel+bounces-559154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE86A5F027
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5F8C1894547
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF2A2641DE;
	Thu, 13 Mar 2025 10:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DWQy/Hfj"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0431D5154;
	Thu, 13 Mar 2025 10:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741860181; cv=none; b=LyWtkg/L0P2cqkdk+Lh4hd60WwuYoYOXyVPgzO1hReqYJVi88fEjTspi6g0uvXH4XYmYyiPAGdMPUkGcCqGvDJcg+G/5ZLu+z0/OCOYxyyCGM+VLMZg3NuL8J+6fi2eQrEAKtaRDyBGvAHY2+Stm9P0ZlpOygbptOUy7uz39r6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741860181; c=relaxed/simple;
	bh=l0fumYIg0NYCdhTh3a1qt9G3CuZK2lteX+DZEbj+6ZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BPmW1sXpn02xw+bCAup6iLuWTfayrphC1p77T71SfxcY2wvW2wvzAgkmXAUuPLwIys639Y9JII19gygHPRDPNWHJusp5CaNYpUM8yHfyTLILweW99T9jlNa+vTgnNzPmUUKJepoSPUTYq2Pw7EDK6/QcXqH1fVfpFpf4yKrYVgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DWQy/Hfj; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=Oqs1UZTlRHa6oFrEBtaWOF/mZRqIvWmGezxzzASYwe4=;
	b=DWQy/HfjO2PcRXIvF4fneEjFCLMWxChmsLupmC0kwSvg+ve/pMSABY+hdXg7s7
	0kWhI009abuerHYQUCKJbVdr6nZirdLzLv2PNZFjijob4GMtNe3KZ+24uw5veLZ+
	qbPuIwfMKZVSxSR4yhC2bi69caM6EYVR99G1YIrRV6oCY=
Received: from [10.42.12.155] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wAHA2A3rdJniQ73SA--.14057S2;
	Thu, 13 Mar 2025 18:02:33 +0800 (CST)
Message-ID: <7e9db4d9-0a22-44b4-a981-0de25d6a2aa4@163.com>
Date: Thu, 13 Mar 2025 18:02:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usbip: Fix the error limitation on max_hw_sectors for
 usbip device
Content-Language: en-US
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: valentina.manea.m@gmail.com, shuah@kernel.org, i@zenithal.me,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zongmin Zhou <zhouzongmin@kylinos.cn>
References: <20250219092555.112631-1-min_halo@163.com>
 <88b2fb4b-96a4-4d29-bf92-4064d3572fa4@linuxfoundation.org>
 <5a41d6c3.8c78.195371996e0.Coremail.min_halo@163.com>
 <247c7e15-bbff-427f-8315-ca463f8b933b@linuxfoundation.org>
 <4d4035bf.26b9.19556dcc23d.Coremail.min_halo@163.com>
 <c49917d2-5157-4878-9866-be6053b5124d@linuxfoundation.org>
 <6d47fef6.9eef.19565c308e5.Coremail.min_halo@163.com>
 <803b43c6-9aab-4380-9753-fd2efa8061fa@linuxfoundation.org>
From: Zongmin Zhou <min_halo@163.com>
In-Reply-To: <803b43c6-9aab-4380-9753-fd2efa8061fa@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHA2A3rdJniQ73SA--.14057S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZry5uFy7Gw4UurykKF4Uurg_yoW5Ww4fpa
	s3XFWxKFsrtFyFyFsFkw1rXa4YqrW7KFyUWryDCw1UZws09r1UKrs2k3Z5uFyxXF13Ww12
	vr4qyF9xurWqyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U3UUbUUUUU=
X-CM-SenderInfo: pplqsxxdorqiywtou0bp/1tbixwEPq2fSpjyrWgAAs8


On 2025/3/11 00:49, Shuah Khan wrote:
> On 3/5/25 03:03, Zongmin Zhou wrote:
>> At 2025-03-05 03:45:28, "Shuah Khan" <skhan@linuxfoundation.org> wrote:
>>
>>> On 3/2/25 05:37, Zongmin Zhou wrote:
>>>> Dear shuah,
>>>>
>>>>
>>>> Yes, I agree with you.It would be better if there have a more 
>>>> simpler fixes than This patch.
>>>>
>>>> I can just think of the two possible solutions that mentioned before.
>>>
>>  >What are the two possible solutions?
>> 1. The patch we are discussing now,have to change the API between the 
>> kernel and user-space.
>
> 2. Simply set vhci-hcd dma mask to 64 by default,just modify the 
> vhci-hcd driver. Then dma_max_mapping_size() will always return SIZE_MAX.
>
> I prefer option #2 - What are the downsides if any with this option?
>
If set vhci-hcd dma mask to 64 by default,I can't predict what will 
happen when the real USB controller support less than 64bit?

After all, the data flows from vhci-hcd to usbip-host and finally to the 
USB controller to which the device is actually connected.

the data is ultimately processed through the real USB controller?

However, the default setting to 64-bit is equivalent to eliminating the 
impact of

the patch(commit d74ffae8b8dd) on usbip protocol devices, sounds feasible?

I am not very professional in this field, waiting for your evaluation.

>>>>
>>>>
>>>> If SWIOTLB disabled,dma_max_mapping_size() return SIZE_MAX.
>>>
>>> Right when CONFIG_HAS_DMA, if not it returns 0. Perhaps we
>>  >can ignore CONFIG_HAS_DMA=n for this for this discussion.
>> Yeah, let's ignore that.
>>>
>>>>
>>>> Only if SWIOTLB is active and dma addressing limited will return 
>>>> the swiotlb max mapping size.
>>>>
>>>>
>>>> The swiotlb config seems rely on many other config options like 
>>>> x86_64/IOMMU_SUPPORT and so on,
>>>>
>>>> and the configuration on host and client side only use the default 
>>>> at all,Like the default ubuntu release version.
>>>>
>>>> It seems that switlb is enabled by default on most platforms.
>>>
>>> If understand correctly the problem happens only when SWIOTLB
>>> is enabled on client or host?
>>>
>>> The following combinations are possible:
>>>
>>> SWILTLB enabled on client and disabled on host - rate limited?
>>> SWILTLB enabled on client and enabled on host - rate limited?
>>> SWILTLB disabled on client and enabled on host - rate limited?
>>> SWILTLB disabled on client and disabled on host - not a problem
>>  >
>> This problem happens only when SWIOTLB is enabled on client,have 
>> nothing to do with host setting. Because the USB xhci controller may 
>> set dma mask to 64bit if controllers support. The combinations may 
>> like below: SWILTLB enabled on client and enabled/disabled on host - 
>> rate limited SWILTLB disabled on client and enabled/disabled on host 
>> - not a problem
>
> Got it. So the problem happens only when SWILTLB enabled on client
>
Yes.
> thanks,
> -- Shuah


