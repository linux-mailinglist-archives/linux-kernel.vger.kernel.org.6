Return-Path: <linux-kernel+bounces-331583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 958D597AE86
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A60C284D80
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C73A169AC5;
	Tue, 17 Sep 2024 10:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RInZ8yfZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEC4161914
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 10:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726567934; cv=none; b=DGuzgH/Nigpn/UAgwnpPyvlccaEFlGyrJreg0clouT/V8xBskX0gUEevvTSgFbUYaBtNBYNivtxSZ1HQKNVR8crj/umPb197O5nNR1Ldy4iwmst78slZVrZd7n8yrdGsVUKM8ye5gqroUdLYSB+tibDtQnDOxfkMjSi6WPUZb3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726567934; c=relaxed/simple;
	bh=w7uDImBl/yiyrFp4gyImZSsKnxA7iMPL9oIHYgrOLog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jC0k/IKzgLqjwHH2F24d8GGP8AivwUj5l952LmBGpCiwOgMNYqQ4DqaeFoXlgFdVVnm9iBKz+qYPCK6ucqmYKoGD7elZEHMIW7r+r5SCVL8xGV0ZlqioT13DTD9wd2aY440JCbXwmvcWEb2LuoFK+172F+kegwJfrDjPLqqs3/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RInZ8yfZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726567932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=K3TcmzWsKcOn2D/zTq/VqUBkrUgN58Qt2qARdum+c8g=;
	b=RInZ8yfZORXPSRqVAS54UXHJp+YTdPLgo32WsAqx+HAImLfWbZzwDSQcQ3gnudcIL0o8XW
	yEnBgB8jKvSWsYKrO2tCcDfA7Xtt6tQGZLy74QIRFQeHF2qnSPjdshOPXtWBRUI3JpYnUs
	VjHdjEseDTeB2tMVie/EqIR76HcmMO0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-wos-2vYvNK2_H66YZIDdxw-1; Tue, 17 Sep 2024 06:12:10 -0400
X-MC-Unique: wos-2vYvNK2_H66YZIDdxw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5365cd47dd8so4198381e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 03:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726567929; x=1727172729;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3TcmzWsKcOn2D/zTq/VqUBkrUgN58Qt2qARdum+c8g=;
        b=pNOdD3KyOzU1tOQLKLEgMQ9Fyxzp0lBDQDxl+/yIBj1V1nZoNJeSvLuMpcUsEbS24g
         3e8TR/DJcFG3QBu9Bz/w25uj/NCQz8J4zzrKS9FARskwPheuuS3LVbc6Vr81WD5kZ4fI
         CFUDvOZ0Em8b4URh5ezaQ0AdjU7XKD2gosbyRb66r0MYeBJeFkrgpAm8qwjnsl4phcQl
         0MdkmCXxOOffMCeh77cYOTM6Q7ygOiqgKfZ85wiZmNgHb9xsUZ3y7MPLnXx3cbbDqR46
         IBHSbbdkkVjqSvFJw1pwufU2SrcE5wFLHIaKyygwtlkONFhdW3slAVym1rANOOsE1ilc
         eoUg==
X-Forwarded-Encrypted: i=1; AJvYcCUwN8f/G3wft8VhIEqoKd6UVlpRHxLJi2Vsr8upCd0CQCXA75g2lySH4R+gxrgHIbyEHI5smht9KT3OZVo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn6YL3BRzclf24nGLLTuP7Bzfv8BEFhcGeIEN+cnao6mqr3lS+
	IWc32X4odKvkHXjU2bepmLtgNaY5GYF/I4qvlsvDlP0Kgndqi1DCAW4+MpP3q+bpk6q4ldETmWH
	uoggbVHVjPm5vvqTqhto55Qvs5pAeIeHyqHo27I942KMcg0Jq01VLM9dmMuLX6g==
X-Received: by 2002:a05:6512:3b23:b0:52c:e086:7953 with SMTP id 2adb3069b0e04-53678fb1ddfmr10010354e87.4.1726567929043;
        Tue, 17 Sep 2024 03:12:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUqh89IYw3T52nNGioXRj6w9IQtnD8JqxFgvYDLozNYDQCCxx+WtthwaYegUtdHPvb80vB4Q==
X-Received: by 2002:a05:6512:3b23:b0:52c:e086:7953 with SMTP id 2adb3069b0e04-53678fb1ddfmr10010329e87.4.1726567928527;
        Tue, 17 Sep 2024 03:12:08 -0700 (PDT)
Received: from [192.168.55.136] (tmo-067-108.customers.d1-online.com. [80.187.67.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb5f2b6sm3464989a12.52.2024.09.17.03.12.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 03:12:08 -0700 (PDT)
Message-ID: <42d6f3db-33db-4475-97e3-fbd28ea131ea@redhat.com>
Date: Tue, 17 Sep 2024 12:12:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Compute mTHP order efficiently
To: Dev Jain <dev.jain@arm.com>, Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com,
 anshuman.khandual@arm.com, baohua@kernel.org, hughd@google.com,
 ioworker0@gmail.com, wangkefeng.wang@huawei.com,
 baolin.wang@linux.alibaba.com, gshan@redhat.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240913091902.1160520-1-dev.jain@arm.com>
 <ZugxqJ-CjEi5lEW_@casper.infradead.org>
 <091f517d-e7dc-4c10-b1ac-39658f31f0ed@arm.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <091f517d-e7dc-4c10-b1ac-39658f31f0ed@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.09.24 05:55, Dev Jain wrote:
> 
> On 9/16/24 18:54, Matthew Wilcox wrote:
>> On Fri, Sep 13, 2024 at 02:49:02PM +0530, Dev Jain wrote:
>>> We use pte_range_none() to determine whether contiguous PTEs are empty
>>> for an mTHP allocation. Instead of iterating the while loop for every
>>> order, use some information, which is the first set PTE found, from the
>>> previous iteration, to eliminate some cases. The key to understanding
>>> the correctness of the patch is that the ranges we want to examine
>>> form a strictly decreasing sequence of nested intervals.
>> This is a lot more complicated.  Do you have any numbers that indicate
>> that it's faster?  Yes, it's fewer memory references, but you've gone
>> from a simple linear scan that's easy to prefetch to an exponential scan
>> that might confuse the prefetchers.
> 
> I do have some numbers, I tested with a simple program, and also used
> ktime API, with the latter, enclosing from "order = highest_order(orders)"
> till "pte_unmap(pte)" (enclosing the entire while loop), a rough average
> estimate is that without the patch, it takes 1700 ns to execute, with the
> patch, on an average it takes 80 - 100ns less. I cannot think of a good
> testing program...

And that is likely what Willy is actually wondering about: does it have 
any real world impact or is the benefit just noise. :)

Change does not look too wild to me, but yes, it increases complexity.

-- 
Cheers,

David / dhildenb


