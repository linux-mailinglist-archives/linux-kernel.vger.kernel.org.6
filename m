Return-Path: <linux-kernel+bounces-375845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BFB9A9BA5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F9971F21D43
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9172155326;
	Tue, 22 Oct 2024 07:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s/4k1Rd3"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3AE152166
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 07:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729583923; cv=none; b=R/iwXwtChZKDqvpB4t3FRWtBpae88UiNPekcCAmIZUyE4CcAPhQQCMvdYWGoOlqdb1h3RXiLJg3UYWB3mJd+aPU0DCrYDV8G1f5E52No1+YVP4kxv78s0DqeisFQp9ZQe3yt2bd4PnsrFTS/0JNBCiYkfYYkURHpZzNnGJAwWKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729583923; c=relaxed/simple;
	bh=ACLE3k7ry8IhdWilfTDtU5ViRWT8EWufxOmVvqccizY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p3Gl6djR28acDx6N+AETP0HRExnKuoGBVIa5Z/NYVyanNN3mqwMvBJBiey3cFlxYXesqKNe9mOYF1PzOm8ozeQ+sJKwuIFy/7TXZLEOF4iW8sxSyoe/DFFceIgOpsQ25RJA0d9RqFgbHZ76adUTv0LBy8FmSyHRJIwwuY5tFNL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s/4k1Rd3; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d4ac91d97so5140416f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 00:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729583920; x=1730188720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ebzEKZpU1QsVaDjvfaf3+sPH51pDYSb8RmLwVjrRqLs=;
        b=s/4k1Rd3V8f/DNdhiOiwoUfMzGrfrRCUFCvdpqzSxkQG8ZiCPHlRJE0IzCBq8gIFeI
         0pz1rDOPdRN4TV0zETsOkm26MlUMJROMxTNmnrpNxf0YIXI9bbeUohodirxry6WY2JEc
         1Z5Y9QhSVTGNlyv7E8GFbrh7r8yV7u5p7CLXIfr8+0jsjWpKbhbbks7D6OtPqIpvgcVO
         JQg7Fuv0xJj0Lgd2BlbzrwVWl2OmISl+lKbGEdWdoX4n6dLcgNGZBlNmUAs2XSodvDqR
         PqaO18a5gwD7m3JWq6VRD/Ut72V2SKpgQiaqOOWojcyfitcgw2YhcKL5HOSzuMflScSX
         afSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729583920; x=1730188720;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ebzEKZpU1QsVaDjvfaf3+sPH51pDYSb8RmLwVjrRqLs=;
        b=qR5PuE2I677C8vnp7ZCV5xD5KenstOOb4hn+xachcIg2cbptRgB3ZyMEFHMLQdLzIo
         eOGvS2CSuSwqFH7qDuP5SWqorO1R7JH38eyOFWm1um8jZNyxLadYP/eof3HraTLul2S3
         gerOpHDrmevrDRo3Tajei8dJSUIKK13DcLf04VlmQP7BXhheCgyX6GUwN99tO5QUVnms
         Z19drgM3O4m+rGM+TcR9r5k+ym4qJbfdQr52vu7FU8PJ8+Kast7Nc3T8KlZxHMaQWSSR
         6dkEKGIOl2n/YgtcU7gz9i/jxn3V7DLUtf33Ah1iHVQtgbpkN4uXdjFQUJjhxXv6hYyJ
         RRtA==
X-Forwarded-Encrypted: i=1; AJvYcCV5qjaami9dL+B9II5XA2OCdtHlk9j4rGZINiaJQoTn7FREMZzpe9b6QJWj/kwK3zM5wUZprds5p45dNto=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS87+FD5a8xazwn6Z/3SYe2hJdJflN+OypSrUdMTgvrSMHI06X
	InzGDiXJCVMfnPEuy21A/6suU/2t+0VDS1LAkf8I+KEL05LfMFcZs1M3snlHxFI=
X-Google-Smtp-Source: AGHT+IGDhMum5PAcQ3SHhrT5Fn6wbmAs5RW+1+vVA2DjTsESyf8MTIObzirLulaDFCdUAj06MnpWgw==
X-Received: by 2002:a5d:558b:0:b0:37d:3705:84e7 with SMTP id ffacd0b85a97d-37ea21d8f6cmr13090988f8f.17.1729583919797;
        Tue, 22 Oct 2024 00:58:39 -0700 (PDT)
Received: from ?IPV6:2a02:2f04:9203:6000:fdac:3c35:4719:3327? ([2a02:2f04:9203:6000:fdac:3c35:4719:3327])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a47b07sm6012954f8f.25.2024.10.22.00.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 00:58:39 -0700 (PDT)
Message-ID: <d91109a1-532a-4b95-ad4c-3b9cf8e3dbbb@linaro.org>
Date: Tue, 22 Oct 2024 08:58:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] firmware: add exynos acpm driver
To: Krzysztof Kozlowski <krzk@kernel.org>, jassisinghbrar@gmail.com
Cc: alim.akhtar@samsung.com, mst@redhat.com, javierm@redhat.com,
 tzimmermann@suse.de, bartosz.golaszewski@linaro.org,
 luzmaximilian@gmail.com, sudeep.holla@arm.com, conor.dooley@microchip.com,
 bjorn@rivosinc.com, ulf.hansson@linaro.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, marcan@marcan.st, neal@gompa.dev,
 alyssa@rosenzweig.io, broonie@kernel.org, andre.draszik@linaro.org,
 willmcvicker@google.com, peter.griffin@linaro.org, kernel-team@android.com,
 vincent.guittot@linaro.org, daniel.lezcano@linaro.org
References: <20241017163649.3007062-1-tudor.ambarus@linaro.org>
 <20241017163649.3007062-3-tudor.ambarus@linaro.org>
 <955530a5-ef88-4ed1-94cf-fcd48fd248b2@kernel.org>
 <d41ee8f6-9a2c-4e33-844a-e71224692133@linaro.org>
 <1ece02e6-bf78-443a-8143-a54e94dd744c@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <1ece02e6-bf78-443a-8143-a54e94dd744c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Krzysztof,

On 10/22/24 5:38 AM, Krzysztof Kozlowski wrote:

cut

>>> I skimmed through the driver and I do not understand why this is
>>> firmware. You are implementing a mailbox provider/controller.
>>
>> In my case the mailbox hardware is used just to raise the interrupt to
>> the other side. Then there's the SRAM which contains the channels
>> configuration data and the TX/RX queues. The enqueue/deque is done
>> in/from SRAM. This resembles a lot with drivers/firmware/arm_scmi/, see:
>>
>> drivers/firmware/arm_scmi/shmem.c
>> drivers/firmware/arm_scmi/transports/mailbox.c
> 
> Wait, SCMI is an interface. Not the case here.
> 
>>
>> After the SRAM and mailbox/transport code I'll come up with two helper
>> drivers that construct the mailbox messages in the format expected by
>> the firmware. There are 2 types of messages recognized by the ACPM
>> firmware: PMIC and DVFS. The client drivers will use these helper
>> drivers to prepare a specific message. Then they will use the mailbox
>> core to send the message and they'll wait for the answer.
>>
>> This layered structure and the use of SRAM resembles with arm_scmi and
>> made me think that the ACPM driver it's better suited for
>> drivers/firmware. I'm opened for suggestions though.
> 
> Sure, but then this driver cannot perform mbox_controller_register().
> Only mailbox providers, so drivers in mailbox, use it.
> 

Okay, I can move the driver to drivers/mailbox/.

cut

>>>> +/**
>>>> + * struct exynos_acpm_shmem_chan - descriptor of a shared memory channel.
>>>> + *
>>>> + * @id:			channel ID.
>>>> + * @reserved:		reserved for future use.
>>>> + * @rx_rear:		rear pointer of RX queue.
>>>> + * @rx_front:		front pointer of RX queue.
>>>> + * @rx_base:		base address of RX queue.
>>>> + * @reserved1:		reserved for future use.
>>>> + * @tx_rear:		rear pointer of TX queue.
>>>> + * @tx_front:		front pointer of TX queue.
>>>> + * @tx_base:		base address of TX queue.
>>>> + * @qlen:		queue length. Applies to both TX/RX queues.
>>>> + * @mlen:		message length. Applies to both TX/RX queues.
>>>> + * @reserved2:		reserved for future use.
>>>> + * @polling:		true when the channel works on polling.
>>>> + */
>>>> +struct exynos_acpm_shmem_chan {
>>>> +	u32 id;
>>>> +	u32 reserved[3];
>>>> +	u32 rx_rear;
>>>> +	u32 rx_front;
>>>> +	u32 rx_base;
>>>> +	u32 reserved1[3];
>>>> +	u32 tx_rear;
>>>> +	u32 tx_front;
>>>> +	u32 tx_base;
>>>> +	u32 qlen;
>>>> +	u32 mlen;
>>>> +	u32 reserved2[2];
>>>> +	u32 polling;
>>>

cut

>>>
>>> I also cannot find any piece of code setting several of above, e.g. tx_base
>>
>> I'm not writing any SRAM configuration fields, these fields are used to
>> read/retrive the channel parameters from SRAM.
> 
> I meany tx_base is always 0. Where is this property set? Ever?

It's not zero. My assumption is it is set in the acpm firmware, but I
don't have access to that to verify. Here are some debug prints made in
the linux driver:

[    0.069575][    T1] gs-acpm-ipc 17610000.mailbox:
exynos_mbox_chan_init ID = 2 poll = 1, mlen = 16, qlen = 5
[    0.069927][    T1] gs-acpm-ipc 17610000.mailbox:
exynos_mbox_chan_init ID = 2 offsets: rx_base = 0x00038290 rx_front =
0x0003828c, rx_rear = 0x00038288
[    0.070449][    T1] gs-acpm-ipc 17610000.mailbox:
exynos_mbox_chan_init ID = 2 offsets: tx_base = 0x000382f0 tx_front =
0x000382ec, tx_rear = 0x000382e8


tx_base contains the SRAM offset of the RX queue used in linux. The
offset is relative to the base address of the SRAM config data.

tx_base is seen/named from the firmware's point of view, thus named TX.
I assume the same struct is defined in the acpm firmware.


Somewhere below in the linux driver I get the RX ring base address by doing:

rx->base = exynos_acpm_get_iomem_addr(base, &shmem_chan->tx_base);

where base is the SRAM base address of the channels configuration data.

static void __iomem *exynos_acpm_get_iomem_addr(void __iomem *base,


                                                void __iomem *addr)


{


        u32 offset;





        offset = readl_relaxed(addr);


        return base + offset;


}

Hope this clarifies a bit these struct members.
Cheers,
ta

