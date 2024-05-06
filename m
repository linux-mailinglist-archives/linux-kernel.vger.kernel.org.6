Return-Path: <linux-kernel+bounces-170074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BE58BD187
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D1D283D5F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E491A155356;
	Mon,  6 May 2024 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgLLYqHC"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD51415531A
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715009456; cv=none; b=f87ZfWLTfkHpoFnmLnu/Kg/vVrhTxSR7FWU0xGHc9uKBFw1n65hDaEm2YMKt2Bi7qrKKXJJxquPNA1NNlZQw4yA4gfbDU9YVyLJDuQr+BeQ6NkqNNOY3YZ9opYEbnAPKTTdPfd2z//ndsSyADe0QFjonkDcEOIGgevPO2rAKX8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715009456; c=relaxed/simple;
	bh=0pDxkiEJ2LoRsQ/lAD4W6k/YMqHAvm09MqAFgXeqYUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GE5GzM3NhWScjjkX22NFQ17aMNJtf/j2q1H5X4XyKY5h28/xbjlO10uwjWOUbcjBPLf7f+UT87dd9JzoNbgYf0WdA89nSTAi7iJPFYNCOu326mqOMYZwyCDGwhhYzcoIw+maCrARbbsv1qLY38r54j+ptCDPJ6pbuLVrxKGywgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgLLYqHC; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51fdc9af005so3201897e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 08:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715009453; x=1715614253; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GJL1u5m+pLYItM9KAL3mbxkUQV/1xhwiHQhmsyGUc6M=;
        b=TgLLYqHC6a/dncS7wLYhezZbFdAg6FzAQyqMZpVgiwwYVWcBoudBYIj1Uw9eUZULyU
         mEMxiw7xF+eqQpXSEC0ZQoCzoQtIFX4ehCjQ17loRUJPt9qmSQ4B6j0kXzPDWKOsiYRd
         glxpxoE4O2ayGoyQhpQzaFe1OtTFIW0ymStcrlKkX/IrOWLhtl0kbGuzxxirMQN0p1SL
         kDP3TEDeU0UXrBIBZt0Kq3Dn05vLvDwkCvtRnBILD5lBEQ0UxLiM49x4JJnbybkoju/r
         GaKVF/Kw4JKiFAVEbCBoHOpiZAP+xy/aJ9SYNOVLm2MThFViqBEvZ5EcSSi2jxDO9r9P
         l8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715009453; x=1715614253;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GJL1u5m+pLYItM9KAL3mbxkUQV/1xhwiHQhmsyGUc6M=;
        b=ZK36C5GgGsI+Pv6hcsMC3rLqHITNrMz6cRUInI0aFJdBaWY0fzOfJPnxbpS2+lx6j+
         f7LJ+VT0txO6uAC4XjaABFmRUR2+THtbeU+HajkRCujAa34oPEa14Ohe7Z75c7KADjgX
         Y7ScwjlLa5ckpbtvbcjmhjbz0m8maUYMIz9KDcWIeb57xx6VDOloOtalDCg2pUoWRw3v
         zrcQIGDGgL3rTkblmIbzAIrZr+DGk+d9a8subKSpMtct5EvwGT4OZb9GFXypwDj0eWTz
         1iE6wIad41133L3UhjPAgvqgKh4opBu36XOZ0fOuycStEayOXb+gmMelTpJYniTavIrn
         px0A==
X-Forwarded-Encrypted: i=1; AJvYcCVd8ozTrdwzW1O4LvsGOVh2TlGu41NVyTUa8OJk9fzkf74G92vJEBv8DNYR9TuS0QgU2l18x80rprpEyPRZepsvzN2045lZy26UcysX
X-Gm-Message-State: AOJu0YwhmXVvXc6Fl0zXi1CdgpZXmgG6hU26hwlfZ7CQ6ZN4vdP27KA+
	LWppNnopA1eE7TZ/A4+87+F/v3QC7TH3f+dFz87p20vsx+6cpqRz8DogdymmPM8=
X-Google-Smtp-Source: AGHT+IGZrFfkURzSpITozP9PNnEpr8PqVBnyzlEfp3WA4jCqJgV2Hu14WP0OjYC2D1z2gJ3vI63+ZA==
X-Received: by 2002:ac2:54b9:0:b0:51f:3a04:ba9b with SMTP id w25-20020ac254b9000000b0051f3a04ba9bmr8461033lfk.22.1715009452471;
        Mon, 06 May 2024 08:30:52 -0700 (PDT)
Received: from [192.168.1.20] (net-37-182-167-227.cust.vodafonedsl.it. [37.182.167.227])
        by smtp.gmail.com with ESMTPSA id ww1-20020a170907084100b00a59cb8c93f3sm1632649ejb.58.2024.05.06.08.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 08:30:51 -0700 (PDT)
Message-ID: <2398ca58-eafc-46df-92c1-c03cd920fd06@gmail.com>
Date: Mon, 6 May 2024 17:30:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 v3] drivers: use __free attribute instead of
 of_node_put()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: sudeep.holla@arm.com, javier.carrasco.cruz@gmail.com,
 julia.lawall@inria.fr, linux-kernel@vger.kernel.org, rafael@kernel.org,
 skhan@linuxfoundation.org, conor@kernel.org
References: <20240424125401.oxvt5n64d7a57ge3@bogus>
 <20240501094313.407820-1-vincenzo.mezzela@gmail.com>
 <20240501094313.407820-3-vincenzo.mezzela@gmail.com>
 <2024050102-reshuffle-licking-f84e@gregkh>
 <673df61a-e0f5-450b-8fb4-746bc950e3d1@gmail.com>
 <2024050148-dutiful-unsubtle-dbb1@gregkh>
Content-Language: en-US
From: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
In-Reply-To: <2024050148-dutiful-unsubtle-dbb1@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 01/05/24 15:06, Greg KH wrote:
> On Wed, May 01, 2024 at 02:33:39PM +0200, Vincenzo Mezzela wrote:
>> On 01/05/24 12:48, Greg KH wrote:
>>> On Wed, May 01, 2024 at 11:43:13AM +0200, Vincenzo Mezzela wrote:
>>>> Introduce the __free attribute for scope-based resource management.
>>>> Resources allocated with __free are automatically released at the end of
>>>> the scope. This enhancement aims to mitigate memory management issues
>>>> associated with forgetting to release resources by utilizing __free
>>>> instead of of_node_put().
>>>>
>>>> The declaration of the device_node used within the do-while loops is
>>>> moved directly within the loop so that the resource is automatically
>>>> freed at the end of each iteration.
>>>>
>>>> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
>>>> Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
>>>> ---
>>>>    drivers/base/arch_topology.c | 51 +++++++++++++++---------------------
>>>>    1 file changed, 21 insertions(+), 30 deletions(-)
>>> How was all of this tested?
>>>
>>> thanks,
>>>
>>> greg k-h
>> Hi,
>>
>> I just cross-compiled it for RISC-V to enable the config
>> GENERIC_ARCH_TOPOLOGY
>> and include arch_topology.c as well.
> Cross-compile is nice, how about running it?
>
>> Do you have any suggestion to trigger the affected code and perform some
>> testing?
> That is up to you to determine if you wish to modify it :)
>
> thanks,
>
> greg k-h
Hi,

I've successfully run it on QEMU. There are no differences in the dmesg 
after applying the patches.

Furthermore, I've tracked the execution of the parse_dt_topology() which 
is calling all the functions that I've modified with the patches and I 
checked that of_node_put was correctly called at the end of each scope.

Is there anything else that can be done to further testing this changes?

Thanks,

Vincenzo


