Return-Path: <linux-kernel+bounces-431605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0367E9E3FDA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88EBDB61ABE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE13199FA2;
	Wed,  4 Dec 2024 16:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d15TTqe+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E2B20C499
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 16:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733328506; cv=none; b=VMjuFKhfpmBDfye9HW6b08VYuAcmjIjkhlTLuBYLj5+rGN26+spA7OvYNZiVL3N5HnSnhaaicXqD0X7bnIu81wg84rsZ5QipAAXcrUR4q4AaeVFu3jroGzw7EkIAXJGq4IBUJuii71N1KZikesr++MKke0+9m0xgh2ETRhQUPwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733328506; c=relaxed/simple;
	bh=bzAwao8QjOPvqtVCiPC6OiokVC3z+kaEwGgoxmvaCmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bQ0ZvyTbplvMhlMGSZ+ysXi0oCGSeiXdVqdR0h+afqrAbe/i9YXExZhJbB0cMYuM0NwLXbc+vkiSA3ZGlTL6o+TACx49WtbmxZgV3OLjn6gYcqZ3Ib5U9gbDAevPtKEahOvecRq6AEtz6yJOYkQWCBodc5FFo3P+oMAHnaSl4Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d15TTqe+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733328503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vDuCHOE0GA6gKvp7DYwdRM7TZ4zAFNafutqSh9uvaPw=;
	b=d15TTqe+8FUW/2HKqjZTfSKh0bqDUc7OB448GERLIv+TlKMkkUqxiJGDay8o+YBrWexxDc
	pJplBOlCk6UgtsksvnUIxAVf/L+SiTk2tiqebX5vrMxCA5kwT4k2rfKbJIfYwDHbC1tSEa
	Zg1nKZEgNHw9DQdE68YdS8t8JZrLyvM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-3155zEwiPreDUW44Ffzthw-1; Wed, 04 Dec 2024 11:08:22 -0500
X-MC-Unique: 3155zEwiPreDUW44Ffzthw-1
X-Mimecast-MFC-AGG-ID: 3155zEwiPreDUW44Ffzthw
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ffcd8a12e4so49542841fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 08:08:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733328501; x=1733933301;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vDuCHOE0GA6gKvp7DYwdRM7TZ4zAFNafutqSh9uvaPw=;
        b=HxrrCRxcn7dfsG/Zi4HfNK1IgU9iCMVKc8Y+EuCzYKPATdvrd4SmQ3Wn7ZRiVs2vYl
         Fdd2dISjBJCo5iwyUnXaet24rrifI8pRB3u4CltiQ+ugZZ5jshF67gsLncn5kStYyei6
         4ThnAjTh6dRpZjE+ggEg6K3Xp+9Eu7fg66d33KHr8d3ZUhVdYkdLFsoD3POGRVl7tAoa
         bolnNS3Tn1CgigCVeu8WIP1hMUkoxWei+C4hEs1Zhvde1gMm4ZMObAzjqpkvLFNl4VQz
         3+yUqvTLEt2ObCLyPB7J6kZCWfeeP4VYhvcm6Orgzbu1I+0VxcD2oRv8+Nlz+oTv0TYb
         vdOA==
X-Forwarded-Encrypted: i=1; AJvYcCXsxrXB+oDskxJUD2GPk2GWXh7CFkXWVjAaegvj1S+vYETZxqyUrYqQZZ5Wk3/GQI5fncmVuGQ8OL1TmYo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg2DVBsyQyPgem/6cEe53nRKtEUzEgHCkVjROswnbujR8xx9ib
	xvtbRrHSrUI/jX7C6s0RPkJvbE7BrIULO1+w+ee0TqAjuCdKPwoOJ4kqP/2jlpBcgNRYUEU0Ni+
	3ykecq8yysQR1K4HwkzmUU5OS+IJ9pLt24ami4Z5CS0lhTyax/mWT9IswuX0Y+oSUGOWgdQ2c
X-Gm-Gg: ASbGncuUTGTAbJDtDYmUgPaUghhX5RcnHkxtqP4nVEQnjTHHoD8r51QkhGbaSpruLLZ
	BYDhthB2S7zEf6SfxpqIeIzU/hJC7V4p3KoNzP/TahA3ZoQfyy5DbjwJ3M+7G743tUVV3lYs0a9
	cmT+e9OldWGza0Z+3O7vT9rd/CSxBY7VP9tasQlqxDQKS4cfsFCYAa7DezGQdm0UReqrNCTR5Fl
	n1aJnU3Kmo8E7T1VzbgiiMudw4fBMO4+Dx3S6DER3L0CcDY8Vv9QWTs15BUlRhQWjFIACZ+Ohcc
	l0OCXugfmSmAtV6MIBFrUCFyKJ2nAbs4KLNg+DHp1mlpnPqLJlAtXXQywU6y1PePw3jPA+Bk7UQ
	jiQ==
X-Received: by 2002:a2e:a5ca:0:b0:300:1a2e:fec8 with SMTP id 38308e7fff4ca-3001a2f00bbmr12774421fa.23.1733328500870;
        Wed, 04 Dec 2024 08:08:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFn3YLrZIc7IidSKxYtLhWwN1NIWs0/yLoQ9B/e6YqBH4OAblj7zIFJzvIK29nsgtkANdXZlw==
X-Received: by 2002:a05:6000:1843:b0:382:488d:dfc5 with SMTP id ffacd0b85a97d-385fd37ad0fmr6077659f8f.0.1733328057075;
        Wed, 04 Dec 2024 08:00:57 -0800 (PST)
Received: from ?IPV6:2003:cb:c70b:e100:38d6:8aa1:11b0:a20a? (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd36b80sm18477515f8f.29.2024.12.04.08.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 08:00:55 -0800 (PST)
Message-ID: <f7e0029e-f940-4f08-84f4-e89450d3e981@redhat.com>
Date: Wed, 4 Dec 2024 17:00:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] arm64 updates for 6.13-rc1
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Yang Shi <yang@os.amperecomputing.com>, Sasha Levin <sashal@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon
 <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241118100623.2674026-1-catalin.marinas@arm.com>
 <Z0STR6VLt2MCalnY@sashalap> <Z0TLhc3uxa5RnK64@arm.com>
 <0c09425b-c8ba-4ed6-b429-0bce4e7d00e9@os.amperecomputing.com>
 <Z0dhc-DtVsvufv-E@arm.com>
 <dc5e8809-825f-4c38-b487-b16c7d516311@os.amperecomputing.com>
 <e6b3e6c7-193d-43c4-a8c6-6023458723dd@redhat.com>
 <6aec1d44-4a89-4acf-a16b-4493626b93bb@os.amperecomputing.com>
 <Z1B1VS8PayXsXDzl@arm.com> <4919faec-3e35-459f-a7d3-b5b3f188bd9c@redhat.com>
 <Z1B6OMqEZitgBVEx@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z1B6OMqEZitgBVEx@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04.12.24 16:50, Catalin Marinas wrote:
> On Wed, Dec 04, 2024 at 04:32:11PM +0100, David Hildenbrand wrote:
>> On 04.12.24 16:29, Catalin Marinas wrote:
>>> On Mon, Dec 02, 2024 at 08:22:57AM -0800, Yang Shi wrote:
>>>> On 11/28/24 1:56 AM, David Hildenbrand wrote:
>>>>> On 28.11.24 02:21, Yang Shi wrote:
>>>>>>>> diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
>>>>>>>> index 87b3f1a25535..ef303a2262c5 100644
>>>>>>>> --- a/arch/arm64/mm/copypage.c
>>>>>>>> +++ b/arch/arm64/mm/copypage.c
>>>>>>>> @@ -30,9 +30,9 @@ void copy_highpage(struct page *to, struct
>>>>>>>> page *from)
>>>>>>>>           if (!system_supports_mte())
>>>>>>>>               return;
>>>>>>>> -    if (folio_test_hugetlb(src) &&
>>>>>>>> -        folio_test_hugetlb_mte_tagged(src)) {
>>>>>>>> -        if (!folio_try_hugetlb_mte_tagging(dst))
>>>>>>>> +    if (folio_test_hugetlb(src)) {
>>>>>>>> +        if (!folio_test_hugetlb_mte_tagged(src) ||
>>>>>>>> +            !folio_try_hugetlb_mte_tagging(dst))
>>>>>>>>                   return;
>>>>>>>>               /*
>>>>>>> I wonder why we had a 'return' here originally rather than a
>>>>>>> WARN_ON_ONCE() as we do further down for the page case. Do you seen any
>>>>>>> issue with the hunk below? Destination should be a new folio and not
>>>>>>> tagged yet:
>>>>>>
>>>>>> Yes, I did see problem. Because we copy tags for all sub pages then set
>>>>>> folio mte tagged when copying the data for the first subpage. The
>>>>>> warning will be triggered when we copy the second subpage.
>>>>>
>>>>> It's rather weird, though. We're instructed to copy a single page, yet
>>>>> copy tags for all pages.
>>>>>
>>>>> This really only makes sense when called from folio_copy(), where we are
>>>>> guaranteed to copy all pages.
>>>>>
>>>>> I'm starting to wonder if we should be able to hook into / overload
>>>>> folio_copy() instead, to just handle the complete hugetlb copy ourselves
>>>>> in one shot, and assume that copy_highpage() will never be called for
>>>>> hugetlb pages (WARN and don't copy tags).
>>>>
>>>> Actually folio_copy() is just called by migration. Copy huge page in CoW is
>>>> more complicated and uses copy_user_highpage()->copy_highpage() instead of
>>>> folio_copy(). It may start the page copy from any subpage. For example, if
>>>> the CoW is triggered by accessing to the address in the middle of 2M. Kernel
>>>> may copy the second half first then the first half to guarantee the accessed
>>>> data in cache.
>>>
>>> Still trying to understand the possible call paths here. If we get a
>>> write fault on a large folio, does the core code allocate a folio of the
>>> same size for CoW or it starts with smaller ones? wp_page_copy()
>>> allocates order 0 AFAICT, though if it was a pmd fault, it takes a
>>> different path in handle_mm_fault(). But we also have huge pages using
>>> contiguous ptes.
>>>
>>> Unless the source and destinations folios are exactly the same size, it
>>> will break many assumptions in the code above. Going the other way
>>> around is also wrong, dst larger than src, we are not initialising the
>>> whole dst folio.
>>>
>>> Maybe going back to per-page PG_mte_tagged flag rather than per-folio
>>> would keep things simple, less risk of wrong assumptions.
>>
>> I think the magic bit here is that for hugetlb, we only get hugetlb folios
>> of the same size, and no mixtures.
> 
> Ah, ok, we do check for this and only do the advance copy for hugetlb
> folios. I'd add a check for folio size just in case, something like
> below (I'll add some description and post it properly):
> 
> diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
> index 87b3f1a25535..c3a83db46ec6 100644
> --- a/arch/arm64/mm/copypage.c
> +++ b/arch/arm64/mm/copypage.c
> @@ -30,11 +30,14 @@ void copy_highpage(struct page *to, struct page *from)
>   	if (!system_supports_mte())
>   		return;
>   
> -	if (folio_test_hugetlb(src) &&
> -	    folio_test_hugetlb_mte_tagged(src)) {
> -		if (!folio_try_hugetlb_mte_tagging(dst))
> +	if (folio_test_hugetlb(src)) {

To be safe, maybe also test that dst is a hugetlb folio? But maybe the 
implicit checks we added in folio_try_hugetlb_mte_tagging() will already 
check that.

> +		if (!folio_test_hugetlb_mte_tagged(src) ||
> +		    from != folio_page(src, 0) ||
> +		    WARN_ON_ONCE(folio_nr_pages(src) != folio_nr_pages(dst)))
>   			return;
>   
> +		WARN_ON_ONCE(!folio_try_hugetlb_mte_tagging(dst));
> +
>   		/*
>   		 * Populate tags for all subpages.
>   		 *
> 


-- 
Cheers,

David / dhildenb


