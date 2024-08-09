Return-Path: <linux-kernel+bounces-281033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1696694D21E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACCF01F22EC7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4645197A7F;
	Fri,  9 Aug 2024 14:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgK2OB6f"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E62E19754A;
	Fri,  9 Aug 2024 14:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723213561; cv=none; b=AvNu9fFDxFE5YauNSeTs68frNt2Zdkny/QTtXBeiWsboIFrWBos9DPogpjRYkogbguiFcASHReSIwisnxbgve41z1K8DEIrQ623ee3mBr043PW3RJCW4C1FHmTrWzJ6pnnhyhX/XV3MQtn1GjbbHQ3YM7lmJZBOYQihHO1KvAGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723213561; c=relaxed/simple;
	bh=vlC6MpCPMFC2AxNAPZC/pzsw2qhNyLWQJQEik8B7I5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lmJXGZ1O5Mw2uzbRR3DnvVEVUBdX4g5bh5aGdBN+h79Z7hCoh7Viy99SkZJ3CIuGq0r0oNqhvLaLlze0EzoIEH3qfMWPJd5OEanSGHLlcX5UnBP9WeQvMbS8gdMNQJ/bC/JrkFTY/rt8hhvBNCUdJfinPT0BDzwLr0GrArXjCIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgK2OB6f; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5b9d48d1456so112912a12.1;
        Fri, 09 Aug 2024 07:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723213558; x=1723818358; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CVmL+JUtY+Wn7F+T3SL86Jtw2K/7k/JyMHzuTw81wh4=;
        b=NgK2OB6fDJ2jrYJZxMf0WYGvMv0FNdpPVJyMfN30RxPs9daLIDaK7l7FCuQyZnnVS/
         nbQJvakj7ioQrFKa3HRVdg5ISoypZ/0S5SxUdgeVTYPmlGwKrArLhDvY3iWeVLQEc4ai
         QCa2DlIKack6hR3pR+Ij2mTVw5GmIVpw/o4mbMIQicNfHmMiI7gF00RHzCCwQ1b8lMFJ
         RgLjNXzTwlzj8DRbIq9hctt5v4isgkYE+zlh/th4xlHlZawJh+v+SK4FgdgzOHweSSNJ
         0k8nfFmSU+J6J+LrFlbeZV8fM/GR3ofFkprY94qB+/cW0z6Y57kWKU+q2j77kLZOqRJg
         HDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723213558; x=1723818358;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CVmL+JUtY+Wn7F+T3SL86Jtw2K/7k/JyMHzuTw81wh4=;
        b=G095lesZ+z872FMzBTpmdOwpJiMp79kX86fcPNf4NhoYHbm294Do+M5GKvSNFb3Sxw
         v8Qc9KxpjgD/51PZqNozJUg36IRhQzZ5/PlMbKsplKzc473hGA8FwIdkM1ZJ+W3DgmMN
         lwcu+Bxu+vn1qN30BdhtS1ctRBrjHItkbYCiB+eFqKuwzHnGvHGcvCmBmAc17WLqtWGs
         pouZXtg/EZKR7ed1YIb6g6vDjnst+YsgAS0ktYmsjs1s/5dkBgG1UYjrBb7T30MnVwow
         vWARb4YzMs3MHJFunGnS1WE1jtR3Wlq57TorNR1ngdrMj68a3OI55VF6i+r5+79+2lYW
         0Cdw==
X-Forwarded-Encrypted: i=1; AJvYcCXaGWH3tB+lF9hbAlE7DYAqxkgyaM6TNrxfe3rPy95k4oZGsoYxvJ0fsMKjRSE6Uh9FWOJXRO6k+THvai9TzDOoIGjEyjJEIEHpdpXcNqTjOjGWkT5KFkTWIaeKxet0aHT0BkewN3pl
X-Gm-Message-State: AOJu0Yy2tFfycQ2h9DVsL8I++Z3px77bSITmpnyFHEhwkBOM6CjjFcZk
	23qWXE9CPs8O+mR/ir8WKkzEKPpuiGi154+zW3Wztw+mw6aor7lU
X-Google-Smtp-Source: AGHT+IFnExldOKrhy5GHhFfjiCC/km2Eo6GrWXuovjXEgdCYefbnjSGwy+f02GPsbVNwm69iWCHPpw==
X-Received: by 2002:a05:6402:27c9:b0:5b8:36b7:ae51 with SMTP id 4fb4d7f45d1cf-5bbb3c417ddmr4729643a12.9.1723213558079;
        Fri, 09 Aug 2024 07:25:58 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::6:b73e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2c1d615sm1650192a12.23.2024.08.09.07.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 07:25:57 -0700 (PDT)
Message-ID: <dccf0806-0627-4deb-850e-367689af5b0a@gmail.com>
Date: Fri, 9 Aug 2024 15:25:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mm: split underutilized THPs
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev,
 roman.gushchin@linux.dev, yuzhao@google.com, baohua@kernel.org,
 ryan.roberts@arm.com, rppt@kernel.org, willy@infradead.org,
 cerasuolodomenico@gmail.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20240807134732.3292797-1-usamaarif642@gmail.com>
 <20240807134732.3292797-5-usamaarif642@gmail.com>
 <5adb120e-5408-43a6-b418-33dc17c086f0@redhat.com>
 <c0ed5796-a6a6-4757-b7df-666ba598d9fe@gmail.com>
 <3f6e1e0a-6132-4222-abb6-133224e11009@redhat.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <3f6e1e0a-6132-4222-abb6-133224e11009@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 09/08/2024 14:21, David Hildenbrand wrote:
> On 09.08.24 12:31, Usama Arif wrote:
>>
>>
>> On 08/08/2024 16:55, David Hildenbrand wrote:
>>> On 07.08.24 15:46, Usama Arif wrote:
>>>> This is an attempt to mitigate the issue of running out of memory when THP
>>>> is always enabled. During runtime whenever a THP is being faulted in
>>>> (__do_huge_pmd_anonymous_page) or collapsed by khugepaged
>>>> (collapse_huge_page), the THP is added to  _deferred_list. Whenever memory
>>>> reclaim happens in linux, the kernel runs the deferred_split
>>>> shrinker which goes through the _deferred_list.
>>>>
>>>> If the folio was partially mapped, the shrinker attempts to split it.
>>>> A new boolean is added to be able to distinguish between partially
>>>> mapped folios and others in the deferred_list at split time in
>>>> deferred_split_scan. Its needed as __folio_remove_rmap decrements
>>>> the folio mapcount elements, hence it won't be possible to distinguish
>>>> between partially mapped folios and others in deferred_split_scan
>>>> without the boolean.
>>>
>>> Just so I get this right: Are you saying that we might now add fully mapped folios to the deferred split queue and that's what you want to distinguish?
>>
>> Yes
>>
>>>
>>> If that's the case, then could we use a bit in folio->_flags_1 instead?
>> Yes, thats a good idea. Will create the below flag for the next revision
>>
>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>> index 5769fe6e4950..5825bd1cf6db 100644
>> --- a/include/linux/page-flags.h
>> +++ b/include/linux/page-flags.h
>> @@ -189,6 +189,11 @@ enum pageflags {
>>     #define PAGEFLAGS_MASK         ((1UL << NR_PAGEFLAGS) - 1)
>>   +enum folioflags_1 {
>> +       /* The first 8 bits of folio->_flags_1 are used to keep track of folio order */
>> +       FOLIO_PARTIALLY_MAPPED = 8,     /* folio is partially mapped */
>> +}
> 
> This might be what you want to achieve:
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index a0a29bd092f8..d4722ed60ef8 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -182,6 +182,7 @@ enum pageflags {
>         /* At least one page in this folio has the hwpoison flag set */
>         PG_has_hwpoisoned = PG_active,
>         PG_large_rmappable = PG_workingset, /* anon or file-backed */
> +       PG_partially_mapped, /* was identified to be partially mapped */
>  };
>  
>  #define PAGEFLAGS_MASK         ((1UL << NR_PAGEFLAGS) - 1)
> @@ -861,8 +862,9 @@ static inline void ClearPageCompound(struct page *page)
>         ClearPageHead(page);
>  }
>  FOLIO_FLAG(large_rmappable, FOLIO_SECOND_PAGE)
> +FOLIO_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
>  #else
> -FOLIO_FLAG_FALSE(large_rmappable)
> +FOLIO_FLAG_FALSE(partially_mapped)
>  #endif
>  
>  #define PG_head_mask ((1UL << PG_head))
> 
> The downside is an atomic op to set/clear, but it should likely not really matter
> (initially, the flag will be clear, and we should only ever set it once when
> partially unmapping). If it hurts, we can reconsider.
> 
> [...]

I was looking for where the bits for flags_1 were specified! I just saw the start of enum pageflags, saw that compound order isn't specified anywhere over there and ignored the end :)

Yes, this is what I wanted to do. Thanks.


