Return-Path: <linux-kernel+bounces-430655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 816E69E3426
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5377B235A7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 07:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606CE18A6C1;
	Wed,  4 Dec 2024 07:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="QFQokjf7";
	dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="pDac4oAL"
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DDD848C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733297458; cv=pass; b=Y0iZlgOYmPZU86V+RkYXImdRqXgjDsnPJBBUmK12wnwhbqpK0sLMAkU3gH3yGj622Ut5osljH37YgF4PisyiqaqO+iuScpCt1RgZI4xVZ78rZO2tCbRWz98ygSB99sLEVv9VWqqjij/QXQ6ZDyh9+Qq99NcZYLRTUHlnooJ2rPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733297458; c=relaxed/simple;
	bh=lT0tCdrCGqK25uoxSeYyHMV4miVl9/zjxIxfiGpXRdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zxvia6xCoh2N01W8RyjHZ3obwQxNlLSIArosgfWl+4STA+/cH0svjh5IXRV0p3yWthxSy4OUKGMtmPX+jpMXoArf40TAly2PY9lGXQOFGPeDSh8A4tz2rB/bwIyHm0kHFgRLTgWwZIZGWHHZaFwT3ThOLnoORcnGE8/zpjs1lig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outer-limits.org; spf=none smtp.mailfrom=outer-limits.org; dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=QFQokjf7; dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=pDac4oAL; arc=pass smtp.client-ip=81.169.146.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=outer-limits.org
ARC-Seal: i=1; a=rsa-sha256; t=1733297268; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=DW+Ixa3XQxtFxQfckZJV97A9gxX7U1xrO7Qh11l17QsQpXEL5809FG4grREDbp91Wd
    AHl6BQB+GimvuXaAfQRPC86hbw158Fbix1yk+WUVQJ6OiPcqzNXt0/CZCcwnH3g0v893
    hcU57Bedo/hgJmec5lBvhq5XoscbsrPHqVSjeHeE53XIPZXa4o+OeFeLdurN918ni2lF
    fJSGr5bLjZRPj3KYY2gfFfp8rthgDJ+XkkhiouIN5oue8UNTLh5FZTClvhMxMy3fLo2i
    vM61nXznsTnKAoTOwNcwf5iYn4O/XwUu+Frulrwmh79nXfCQ14+W90PdsA5cTtDYJBME
    RQfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1733297268;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=7QTF0rM+w5EQbe0dkyUe0EzmXHLlCV/ymZQZNrVKoto=;
    b=AZySPL+UH1afjVxjYrO+xin6wVfi8z5SctW/Dk7eVxnG34ynmiXI4aP6UUZJw7slEI
    VgvWtAX/h6UnJnGIW3/ae49uZO+eL02dHPrc5TvrayF8TqsuVP3AmbpxiQ6Jr3kxaxtA
    w40gwdNm9o8vM754f6TIpTyl3A7di5qQ3pShzq4aei9CERwt8z3lcOZV1KpluFy3H0AR
    /jo96/tCi9eMB2SNDj3pbFmCq+ItPFwoE6mQSEW+KymFE8oRuLKXW1wBX5XDfIIeuda4
    HXrE8JYWDcV417NY2KyXgRh04QNE0bd5Md2ciibi7SCBlae6Vvn9ycIrNulAGRPZDJa8
    4MRw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1733297268;
    s=strato-dkim-0002; d=outer-limits.org;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=7QTF0rM+w5EQbe0dkyUe0EzmXHLlCV/ymZQZNrVKoto=;
    b=QFQokjf7U6HgALX84BrA/qhbM1YOMUP3OSMvIgqsBzSCj2ACkmP880wtCZTCAa8SxQ
    kFz7GpagWtoYKH0ctFM6hWNc9/Nzqp5o/MaBUUhXeKAoaVsNClRyDWrIe4VD6sqhYeIA
    QDr8mJIMsiNLm4PKDU6vqR00XAlbwfs27p0J7iH0Ci0bYRxDoXhrW6T4n1QK2QtM2sVx
    RAxYlalY7VTywW/U0g+v3tmIjcP614ARydN5FXNucj+o2oMmgtx1/1Y5X3Ut85QlJb1r
    6o0KEwxdoeyc82xErKBAf+xuO+w/ye3/+zXUoPfF4THbLqvN3ELVBckj8+4Z/CIElNqQ
    Otkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1733297268;
    s=strato-dkim-0003; d=outer-limits.org;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=7QTF0rM+w5EQbe0dkyUe0EzmXHLlCV/ymZQZNrVKoto=;
    b=pDac4oALLSCJWwi2Zc4IMR1V0n1zxBNs0rdh1Uqkl3kq2KLWgXavwjx5lu3zHNwjVl
    dtv55yj5hQs1ZDXj6FCg==
X-RZG-AUTH: ":JnkIfEGmW/AMJS6HttH4FbRVwc4dHlPLCp4e/IoHo8zEMMHAgwTfqBFXdk5Zv9blcw/Guou9tnmlcuycxXU9rVIojJAYOMzGkPFeCwPebw=="
Received: from [IPV6:2a02:8429:5895:8b01:5ea:3d78:a142:af08]
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id Ja0a030B47RmQWc
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 4 Dec 2024 08:27:48 +0100 (CET)
Message-ID: <8d674373-0f30-4d0b-aac7-53eb38c81513@outer-limits.org>
Date: Wed, 4 Dec 2024 08:27:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: Remove IO memcpy for Big-Endian
To: Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>
References: <20241203083838.3260036-1-jvetter@outer-limits.org>
 <609b026d-d54c-4a11-b7df-6ef0ac315f25@app.fastmail.com>
Content-Language: en-US
From: Julian Vetter <julian@outer-limits.org>
In-Reply-To: <609b026d-d54c-4a11-b7df-6ef0ac315f25@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03.12.24 11:08, Arnd Bergmann wrote:
> On Tue, Dec 3, 2024, at 09:38, Julian Vetter wrote:
>> From: Julian Vetter <julian@outer-limits.org>
>>
>> Recently a new IO memcpy was added in libs/iomem_copy.c. So, remove the
>> byte-wise IO memcpy operations used in ARM big endian builds and fall
>> back to the new generic implementation. It will be slightly faster,
>> because it uses machine word accesses if the memory is aligned and falls
>> back to byte-wise accesses if its not.
>>
>> Signed-off-by: Julian Vetter <julian@outer-limits.org>
>> ---
>>   arch/arm/include/asm/io.h | 11 ----------
>>   arch/arm/kernel/io.c      | 46 ---------------------------------------
>>   2 files changed, 57 deletions(-)
> 

Hello Arnd,
first, sorry, that I messed up my sender email while sending the patch.

> I'm not sure if this is safe on all platforms. Big-endian arm
> is extremely rare in practice, and in comes in multiple variants
> that behave slightly differently:
> 
> - On modern ARMv7 the byte-invariant big-endian "BE8" mode
>    generally well-behaved and works as one would expect it to.
> 
> - There is one ARMv5 "BE32" based platform, the ixp4xx, which
>    works differently, and this in turn allows multiple configurations
>    for its buses where a byte-swap is performed in the PCI
>    controller.
> 
> When the little-endian I/O string operations got optimized to
> calling the word-based helpers in commit 7ddfe625cbc1 ("ARM:
> optimize memset_io()/memcpy_fromio()/memcpy_toio()"), Russell
> intentionally left the big-endian versions alone, which I think
> was done for the case of PCI on ixp4xx, but could have been
> out of general caution.
> 

Wow, thank you for the explanation!

> Before we apply your patch, I think the minimum would be to
> have Linus Walleij try it out on an an ixp4xx with a driver
> that uses these functions. Maybe Russell remembers the exact
> constraints that led to using byte access for big-endian
> mmio string operations, and whether the new lib/iomem_copy.c
> version causes problems.
> 
> I also looked at the little-endian arm32 version, and
> it seems that here the generic code would work fine, but
> the custom variant is likely much faster when both the
> source and destination buffers are aligned, as it can
> do larger MMIO transactions using ldm/stm instructions,
> though the generic version would be a bit better if the
> in-memory buffer is unaligned.
> We could get the best of both by implementing optimized
> arm32 versions __iowrite32_copy()/__ioread32_copy and
> using those in the generic memcpy_{from,to}io.
> 

ok, then I will wait for now, to see if it works with the current 
version. If not, I will have a look at using the 
__iowrite32_copy/__ioread32_copy functions.

>         Arnd


