Return-Path: <linux-kernel+bounces-293506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2969580A8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5223F284449
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E41189B83;
	Tue, 20 Aug 2024 08:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5or6Ia1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D2218E347
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724141735; cv=none; b=oz4q5l/mRqUgqNpYNxJUK+a3go8oaV7w18qEchK89CMhOLZZoicBTImRsPlSZP5W4cFSCOS3J1nhQTT4c4UU/3B9ZxORt7KE/UjMrZKee6C7iQMk/NyDsc9xwOunpsOxVj127ynTQd26auKfe8JPl1SG+wWiKcgSmNTb5790su0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724141735; c=relaxed/simple;
	bh=51b5d59H7rz5qUAC29vRSYWAIedOK240x4dzC0V2boI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VpVujkTviklUZUV2kVmTCzkb+kmQ2RZxVPxd5bYQpw55BXxDVww/vUy6qp+cqC5e5mKX9vw3CMYgncB2lkFIGOpQ+Q05bGUVRROEKD5KEuKPKvYJnLCq00g+1XcolCtT/07JU2RsNeQlrrPowBui3+ZKx70rLaYWBzF3+y3OnXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G5or6Ia1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724141733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9amrvqS31P2ey+4yHRJ1V8LdGDFGb3mu9Q16JPVzu2A=;
	b=G5or6Ia1WvEchLstaggFzUR6lnSU7XyrcKKYoY9DzxAexC/gblSKZuadfjAvXqbXgj+wgR
	eTSyavf8wbYRm7H/oks5I3e7d3kRUUBX92wwBhI4Hk18z+IaMOGi5v8ZZ5Xz7O8qhVZbTq
	Gc1mZiXoXPcw5hQ3GYvCV9bVrhZOIFY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-8_tvTnmPNjGDxrDpwuPuBQ-1; Tue, 20 Aug 2024 04:15:31 -0400
X-MC-Unique: 8_tvTnmPNjGDxrDpwuPuBQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3719ee7c72eso2062400f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 01:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724141730; x=1724746530;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9amrvqS31P2ey+4yHRJ1V8LdGDFGb3mu9Q16JPVzu2A=;
        b=LJ+FBSqh1GvBlCAvAY9S0UK5NCoxzH6a+lXDMWVCD7GgKQfbP+H9z+7rdJFMoDDUNz
         joXGDuIm+Pf6UCWA5tsRsUNgiaMxCQRUp2s2A1QJ3YYEmxz5Ox84ppUKjgaDMSaQbYZ2
         a9YuUvdqzEJPWxpCIs0kJazulIYnKl1Z8MWkvgyb4hWXwUYeTqp4i7p7lonAC54NCuvd
         LWVfq63rnuV1yHjB0IewJrF6QaiQaeHTlUpLM2IG4aRyooH7FzaWn/rER0moWq6VjObm
         ug5NH8ViOm//uMxnZDpZM+RCT4cxeenz1llyfO97ylv+W+GSIcBEZVTv1qj7Che0dIRy
         dcQA==
X-Forwarded-Encrypted: i=1; AJvYcCW5ODqjoylEl79Iivp6AA9eipSyAIG2i+3bHCBSTSEabZam5HTsignSW1mktqe9ieaqsn4Trw/QKKN2MEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQtYWVhMGtOQXPr6CaNLBE+3BDKfC1adb4x1RbDlraWgG2hbrC
	erKHgY0hwT90tWf3901ejkEvihNPJJx58EmldL/v0oV5dH5cTgU1oPjpFx09kl+491GzrKPUFms
	Kjk0kms4TokXHeoYZhIT42OysZkBFB/uJ3guPc1yIkE3k+g/+Ub+7T0o3cykzJR9niiYIGA==
X-Received: by 2002:a5d:484d:0:b0:371:7c68:7cf2 with SMTP id ffacd0b85a97d-371946be9efmr6916741f8f.50.1724141730695;
        Tue, 20 Aug 2024 01:15:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG132/sePCwFNYLA9Dw+tXLfuZhVg26rpJdxruG5iN9lelpEYruL39IDbMxnWZsARoKdfVrgw==
X-Received: by 2002:a5d:484d:0:b0:371:7c68:7cf2 with SMTP id ffacd0b85a97d-371946be9efmr6916721f8f.50.1724141729947;
        Tue, 20 Aug 2024 01:15:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:e00:9c12:cdf2:bf1c:b8ed? (p200300cbc74b0e009c12cdf2bf1cb8ed.dip0.t-ipconnect.de. [2003:cb:c74b:e00:9c12:cdf2:bf1c:b8ed])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189897128sm12505656f8f.81.2024.08.20.01.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 01:15:29 -0700 (PDT)
Message-ID: <f1fac65f-366b-4f8c-ae5a-20277a26aa60@redhat.com>
Date: Tue, 20 Aug 2024 10:15:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] mm: override mTHP "enabled" defaults at kernel cmdline
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 baolin.wang@linux.alibaba.com, corbet@lwn.net, ioworker0@gmail.com,
 linux-kernel@vger.kernel.org, ryan.roberts@arm.com, v-songbaohua@oppo.com
References: <20240817045516.58037-1-21cnbao@gmail.com>
 <e36e4157-ba42-432f-aebe-7c2c36917e57@redhat.com>
 <CAGsJ_4xC+ixRB0n8yOQeQz_YndmtGcDcjjv8bLwcgmkj2XW+1w@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4xC+ixRB0n8yOQeQz_YndmtGcDcjjv8bLwcgmkj2XW+1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

  long __thp_vma_allowable_orders(struct vm_area_struct *vma,>>> 
                                 unsigned long vm_flags,
>>> @@ -756,7 +757,10 @@ static int __init hugepage_init_sysfs(struct kobject **hugepage_kobj)
>>>         * disable all other sizes. powerpc's PMD_ORDER isn't a compile-time
>>>         * constant so we have to do this here.
>>>         */
>>> -     huge_anon_orders_inherit = BIT(PMD_ORDER);
>>> +     if (!anon_orders_configured) {
>>> +             huge_anon_orders_inherit = BIT(PMD_ORDER);
>>> +             anon_orders_configured = true;
> 
> I realized this is redundant since anon_orders_configured won't be
> accessed later.
> so i would like to also drop  "anon_orders_configured = true" in v6.

Makes sense.

>>> +static char str_dup[PAGE_SIZE] __initdata;
>>> +static int __init setup_thp_anon(char *str)
>>> +{
>>> +     char *token, *range, *policy, *subtoken;
>>> +     unsigned long always, inherit, madvise;
>>> +     char *start_size, *end_size;
>>> +     int start, end, nr;
>>> +     char *p;
>>> +
>>> +     if (!str || strlen(str) + 1 > PAGE_SIZE)
>>> +             goto err;
>>> +     strcpy(str_dup, str);
>>> +
>>> +     always = huge_anon_orders_always;
>>> +     madvise = huge_anon_orders_madvise;
>>> +     inherit = huge_anon_orders_inherit;
>>
>> Should we only pickup these values if "anon_orders_configured",
>> otherwise start with 0? Likely that's implicit right now.
> 
> My point is that, initially, those values are always 0, so copying
> them won't cause any issues.

Right, it's more a conceptual thing: on the first cmdline configuration, 
we start from scratch. Afterwards we start with the state that the 
previous configuration left behind.

I'm fine with leaving it as is as well, whatever you prefer.

-- 
Cheers,

David / dhildenb


