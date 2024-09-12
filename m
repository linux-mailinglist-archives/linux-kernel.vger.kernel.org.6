Return-Path: <linux-kernel+bounces-325844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8620975EE5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 04:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71BE12852A2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16B241C89;
	Thu, 12 Sep 2024 02:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lyfbqo43"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FF83A8E4
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 02:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726108120; cv=none; b=CMaxGUcQPlfeMozXOkAB4Pqwpf1SJurxa6tkOGwPaMjzL2sRIneKpMlofXun2snoT6KxG4r+9ixUlmzi687XrElDrGwUGl02TnTEb8YIkUezIEmVm3HLA+9atVlM1jNwcqlVsPXtKvCciR7lfWKKQ9PuHGHJUk3t04gYTcButxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726108120; c=relaxed/simple;
	bh=qodVbfsk2jzTOVDM5QUgWXPpxmGD7DmX0L54gqdkxZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tc6cPYjKIqfvtTXh6LeYaReTbdy/fN7s97ujs0P8gq26M3l52nNvAFE57ChRJMgw6Z3K1eYcUh5VGdmuLnh5zOlmX85wMQCqbix5NNo5XrriiNulp+w8NfbT3UM5FlaUr/ZcXRBe4BWLiJNwRlZ/H5L8ACx4rldYBOuJw+9HiUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lyfbqo43; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2055f630934so4408675ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 19:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726108118; x=1726712918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y3JUbu16VfQSd9QVqb7yoAZ12Rb7JByfojqzpqofCls=;
        b=Lyfbqo43tzY0UlNMMH4gGTroXhBvVbE4PC0K1OUbNkibkNBK+uigVEJ0XR+4gOGgRH
         Wa/bDzTMMsxTTI04NeFHK3As3xI+1G3hsNpntRIePidA7d+aul3ajybUGmoNFs6Y/nBV
         4hm/nRZu+BZAO2pzJ909ad75BlBZ6Ck5Wnl+cb4o/5LBb2hvAtt9Gmw1Dar6IKvgGYR+
         Rs1uSXOGGs+ZNiLRIvZrf55tvdUiStRQHlJSaipckXPDHaFkh0GfqiKVzMLSvlIG62Ug
         VTxPVL+V6jQTlrTeJa+RwLOePlboenVzx/QiG/QY4xvT17s4SarS2syaoQWcyXovTM1n
         2nLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726108118; x=1726712918;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3JUbu16VfQSd9QVqb7yoAZ12Rb7JByfojqzpqofCls=;
        b=bCinqvqyXEj9QDiukp8VkvTMPRVo8GTSKPhOVPv9TF6MUhDgobzgV/95TErCh1mNdI
         egwSfur08al97cvuxOZVfAINOO89shW4G1RyLGnxT87D+u+CaoZbQJ01aJnLwFQZeBHy
         JfPsmTquxSZ6dfCztUXyh2zLT9RA2/6TB+mE/7pBSPZGiS3Qco54+Am0iHqHEcMMu/a0
         mDWVuyW5s1E1RHDiYwDPZ1erWxfvssSc5/+oCB0nTVpjeXxvDWJubIUbsmue6rAGHZhm
         0POFZXkBiiE6EDPhC3Ffb8oAMXtOazQ/dCOh5rMNP2RM4So8X+T6q5YPdYrEgIIKY22P
         vpCw==
X-Forwarded-Encrypted: i=1; AJvYcCUDgidOU8+RBAeoWd2zeVoDxxfMPoHPJTT5N+aHqN23EMo6h+7ls6pBq+9ZSvchSFmJOwwPyO0dAZTgs0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1NuScWAEbNrYV5vSPdzJcOMwsjrcTEiY9+ooGXD+rNOSXZl8r
	ZJfiE+SERJiVPPUbyk1P26peKrMb4rHm8Q3uAsQAWjMGlAYigBDy
X-Google-Smtp-Source: AGHT+IE8jJbwto1D6atTHvUw6MoZSBz0Mbq4oirenkf3ludI59+GenOLwEMtKNX/Mxh9AiLM/nU6OA==
X-Received: by 2002:a17:903:2347:b0:205:8610:3e3c with SMTP id d9443c01a7336-2076e30652amr21113025ad.9.1726108117938;
        Wed, 11 Sep 2024 19:28:37 -0700 (PDT)
Received: from [192.168.255.10] (23.105.223.42.16clouds.com. [23.105.223.42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076b009867sm5533135ad.296.2024.09.11.19.28.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 19:28:37 -0700 (PDT)
Message-ID: <1691f16c-af41-4b38-bd5e-38af0e7a2c99@gmail.com>
Date: Thu, 12 Sep 2024 10:28:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/21] mm/zsmalloc: add zpdesc memory descriptor for
 zswap.zpool
To: Vishal Moola <vishal.moola@gmail.com>
Cc: alexs@kernel.org, Vitaly Wool <vitaly.wool@konsulko.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, minchan@kernel.org, willy@infradead.org,
 senozhatsky@chromium.org, david@redhat.com, 42.hyeyoo@gmail.com,
 Yosry Ahmed <yosryahmed@google.com>, nphamcs@gmail.com
References: <20240902072136.578720-1-alexs@kernel.org>
 <0a10e61b-f0e6-4423-996c-7884c93af65f@gmail.com>
 <66d8bd3e.170a0220.18832.0206@mx.google.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <66d8bd3e.170a0220.18832.0206@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/5/24 4:04 AM, Vishal Moola wrote:
> On Wed, Sep 04, 2024 at 02:54:14PM +0800, Alex Shi wrote:
>>
>>
>> On 9/2/24 3:21 PM, alexs@kernel.org wrote:
>>> From: Alex Shi <alexs@kernel.org>
>>>
>> ...
>>
>>>
>>> This patchset abstracts the memory descriptor used in zsmalloc by zswap/zram.
>>> The descriptor still overlays the struct page; nothing has changed
>>> in that regard. What this patchset accomplishes is the use of folios in
>>> to save some code size, and the introduction of a new concept, zpdesc. 
>>> This patchset is just an initial step; it does not bias the potential 
>>> changes to kmem_alloc or larger zspage modifications.
>>>
>> ...
>>>
>>> Thanks a lot for comments and suggestion from Yosry, Yoo, Sergey, Willy
>>> and Vishal!
>>>
>>
>> This patchset could save 6.3% code size, and it's a nice abstract of zsmalloc
>> memory usage.
>> Is there any more comments, or mind to give a reviewed-by?
> 
> Please CC me on future versions. Most of the zsmalloc conversions seem
> ok, but I'd hold off on further iterations of the descriptor patches until
> the maintainers decide on what/how this descriptor will be used
> (i.e. our end goals).

Thanks for your care.

Is there some places or some conversion should be changed?

btw, the descriptor is used now and could save a few code size. :)

Thanks

