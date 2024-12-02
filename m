Return-Path: <linux-kernel+bounces-427968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 609FC9E0891
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA8AAB2B61B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CB31714A0;
	Mon,  2 Dec 2024 16:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MXlSuJSb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3C316DC28
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 16:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733155868; cv=none; b=aJgz5RVpx6pfxNHM6vhnhGGTmTN9s3fn3cGOD5zWF60246zTuPcjTlximI0BA78kon5L3Et7HCekQUx7gu2KIB/l/0EkWT7ykqd/UTIHgOhMcgmLvliZmY3PsnZT8CHIwdUCErGpXvIssYUyhZAE5N4l48QX5ab+9KwxRsyLQZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733155868; c=relaxed/simple;
	bh=bGw1Gor6KA+VQ281ABpmNIdq2Sgd9yl3Sxbxuf6h9K8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ehic9JqPGUVmB1VhiqkB838Ue1UNDbCFMNklxUwx7Yia9HpysJ9g3XqwMuLAeQw7mu0LVE5lIDJfKWyIO+hh67nr2ZfqNUaxiX3zYDSW5NEgYohmCVCH6kM+XbT+qSWaW4B0/8h2cqXnuaFcX+kxS++ajrecoCAzG6fD+PYwb/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MXlSuJSb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733155865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UeMvm5EnFdrIdqfp6aMO3RZ6O6x0CMFFsFBU61eAI9Q=;
	b=MXlSuJSbKY1d3nuoNALS+/MDNpWiegYAXVxnJsu7/seJIMIkcxZOSo+9zEXYRgTyBenWqy
	JihcLC2Nbbk17Ya10kvD8C0gRbrp/X2zYVYlt+/cZAqrcJeymkyEcIXKZMMXohEY+jRGIS
	teLFkUtq3ZH7zxuj+22gSQ6/d8xE6AM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-_jvzI6q9PG2H0NAKrV8HMg-1; Mon, 02 Dec 2024 11:11:04 -0500
X-MC-Unique: _jvzI6q9PG2H0NAKrV8HMg-1
X-Mimecast-MFC-AGG-ID: _jvzI6q9PG2H0NAKrV8HMg
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385d123aa38so2200461f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 08:11:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733155863; x=1733760663;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UeMvm5EnFdrIdqfp6aMO3RZ6O6x0CMFFsFBU61eAI9Q=;
        b=Sca1kEyAr745ZD+TUcpI1Ay6KomuYTvLrX3jLSi5A222vNyawQeZ7KSq0jPNzXMedy
         T0Y0Nih5p3KDcn+NM5la5pRjeUZgDLnMG4+UVW3ImcUSuJk5DrZspusLLAr539HixLvW
         4CNxKJPVvxS6zoEuo2Svh7TDPU6TIijKcX6i15x3IfV7+eQxjpArfFTavxG3rbC/crjA
         UG87lukh7I2IbcuTewqphq0QmppMbUbN6DuYVX0X3u9YM0PLe61NyNjb/Z8R2h184rwq
         w+Rl6eRJ3r7m0Jxa4UV58TW3HyvLnpgl43sKHbaDOaXx2uaXuUGKFbSxpkcC7xu6i0Fs
         k4YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb3mPe9ZcVP48OhsfXovL092xOUowgZ6B+HaDSuj6ti26bw7JNO/SaU32cUUxlZQWCCdJQBSH2lYn/rPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPPQ7MRshXWuQdJ28dmXJhKccF90FljaaE73G430S9aesXK2n1
	9p/lFKKU10uV+yWlxb03oPM9W19uiS5fazueUmMVSxbbmDHL2PRJJWexB9qvDoUJqqgF8gb3NhL
	WxZi/Z17prRXH8A4H+G2kJWXsCBYzMq3fYrKledk2/yVHVV5zYDEgLPdvpm720g==
X-Gm-Gg: ASbGncvFSEGgurCsvMSVIquil2oiUOQ56i8ueBVlERNmNSYLBwq7Gi7Wdnx6ISm0Kam
	MMAqkJXEfzxCLxv+b4uZatjsczhFw4nyLYqL/eRdVP5T/xYCrJdyAYpEqIS7jM1LzFhjjAP9PqG
	1mfIIXYfBIcpykxPL0pOgMnWB1MENtjL39Ek2wGrdRSKgl/zovDdw7KHovxNXPVscpJpWFP7UHf
	Mh9HU98AHSY4K7D8imbRaMCWfm+eKFTi+sHmT74OvH2du90tJhxrUDlGvnWH2s1ZR5F7i+G+a+M
	vXZE7t1qsaIvj5T10hmP0+LCVHbc8yN3zQNVBOvRiBwJUS3dtxRluKc69WHznOAky+Wc7V/Efb6
	u3g==
X-Received: by 2002:a5d:64c3:0:b0:385:faaa:9d1d with SMTP id ffacd0b85a97d-385faaaa0famr1211526f8f.35.1733155863044;
        Mon, 02 Dec 2024 08:11:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjInTc7ygfnAmD6TjdglitCOoutWAV+90CVhwOGIUhKaDe+qMP4cJZO6lUHPEL2rPPpjKvlA==
X-Received: by 2002:a5d:64c3:0:b0:385:faaa:9d1d with SMTP id ffacd0b85a97d-385faaaa0famr1211475f8f.35.1733155862595;
        Mon, 02 Dec 2024 08:11:02 -0800 (PST)
Received: from ?IPV6:2003:cb:c73b:ba00:bcff:e7c1:84bd:9486? (p200300cbc73bba00bcffe7c184bd9486.dip0.t-ipconnect.de. [2003:cb:c73b:ba00:bcff:e7c1:84bd:9486])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0d9bd06sm159755685e9.3.2024.12.02.08.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 08:11:00 -0800 (PST)
Message-ID: <789f8be8-a423-43aa-baa7-b808d6c59072@redhat.com>
Date: Mon, 2 Dec 2024 17:10:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] arm64 updates for 6.13-rc1
To: Catalin Marinas <catalin.marinas@arm.com>,
 Yang Shi <yang@os.amperecomputing.com>
Cc: Sasha Levin <sashal@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon
 <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241118100623.2674026-1-catalin.marinas@arm.com>
 <Z0STR6VLt2MCalnY@sashalap> <Z0TLhc3uxa5RnK64@arm.com>
 <0c09425b-c8ba-4ed6-b429-0bce4e7d00e9@os.amperecomputing.com>
 <Z0dhc-DtVsvufv-E@arm.com>
 <dc5e8809-825f-4c38-b487-b16c7d516311@os.amperecomputing.com>
 <Z0h6Qtleb-znhX3u@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z0h6Qtleb-znhX3u@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.11.24 15:12, Catalin Marinas wrote:
> On Wed, Nov 27, 2024 at 05:21:37PM -0800, Yang Shi wrote:
>>>> diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
>>>> index 87b3f1a25535..ef303a2262c5 100644
>>>> --- a/arch/arm64/mm/copypage.c
>>>> +++ b/arch/arm64/mm/copypage.c
>>>> @@ -30,9 +30,9 @@ void copy_highpage(struct page *to, struct page *from)
>>>>     	if (!system_supports_mte())
>>>>     		return;
>>>> -	if (folio_test_hugetlb(src) &&
>>>> -	    folio_test_hugetlb_mte_tagged(src)) {
>>>> -		if (!folio_try_hugetlb_mte_tagging(dst))
>>>> +	if (folio_test_hugetlb(src)) {
>>>> +		if (!folio_test_hugetlb_mte_tagged(src) ||
>>>> +		    !folio_try_hugetlb_mte_tagging(dst))
>>>>     			return;
>>>>     		/*
>>> I wonder why we had a 'return' here originally rather than a
>>> WARN_ON_ONCE() as we do further down for the page case. Do you seen any
>>> issue with the hunk below? Destination should be a new folio and not
>>> tagged yet:
>>
>> Yes, I did see problem. Because we copy tags for all sub pages then set
>> folio mte tagged when copying the data for the first subpage. The warning
>> will be triggered when we copy the second subpage.
> 
> Ah, good point, copy_highpage() will be called multiple times for each
> subpage but we only do the copying once for the folio.
> 

It makes me still a bit nervous that we assume both the src and the 
destination folio have the same #pages (and in particular, that both are 
hugetlb folios :) ).

Hopefully that's an invariant that will always hold :)

> Now, I wonder whether we should actually defer the tag copying until
> copy_page() is called on the head page. This way we can keep the warning
> for consistency with the non-compound page case:
> 
> diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
> index 87b3f1a25535..a86c897017df 100644
> --- a/arch/arm64/mm/copypage.c
> +++ b/arch/arm64/mm/copypage.c
> @@ -30,11 +30,13 @@ void copy_highpage(struct page *to, struct page *from)
>   	if (!system_supports_mte())
>   		return;
>   
> -	if (folio_test_hugetlb(src) &&
> -	    folio_test_hugetlb_mte_tagged(src)) {
> -		if (!folio_try_hugetlb_mte_tagging(dst))
> +	if (folio_test_hugetlb(src)) {
> +		if (!folio_test_hugetlb_mte_tagged(src) ||
> +		    from != folio_page(src, 0))
>   			return;
>   
> +		WARN_ON_ONCE(!folio_try_hugetlb_mte_tagging(dst));
> +
>   		/*
>   		 * Populate tags for all subpages.
>   		 *
> 

Yes, looks better. A comment describing the oddity of "copy single page 
but copy all tags on head page access" might be reasonable.

-- 
Cheers,

David / dhildenb


