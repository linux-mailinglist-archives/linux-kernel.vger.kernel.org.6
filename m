Return-Path: <linux-kernel+bounces-200455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1268FB042
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 953151C2323F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9058C1448EE;
	Tue,  4 Jun 2024 10:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="COT1BMKx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232F522F14
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 10:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717497955; cv=none; b=ZqoksnJEggH7MkX5HGaHC5M5vpDtkfyHnS7gSyFlYrXcQeP/zlxmGtu904ayTUy1laG9DxdN6Yas5fn155ypfAjwvw3z9WNBj/Q78B0AkFftXtKzvlfFpHV81fF4VS8Ndy0ffkgDo+NYMdBNO6oloUa68u7bqZp5REDWwhpp3YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717497955; c=relaxed/simple;
	bh=B2/nT1cG4jKC4NmbLwlGBPm8cRm2uK1rxj4/nZNSGIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rIUSUXhV9tqlbzj/l5aisZ9o0e67egyHMH6OSmPexfUo+GBsSz78TNcYoyKU59E+vyQr/DtNvXOafYYJMfGCzbdZGqdfrNChXkTNdjoEtB4QDIR6USiUQv7y56eGcNffr8GGziW+8Dsp83K1W/f3hkxsoSl/vDDq8Ow2yBTkco0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=COT1BMKx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717497952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9HPM0o2rvx0/bFV4qmRXd0NqDxdmnpbCI/tYptEl7x8=;
	b=COT1BMKxE2ixXCFbr1JNI+ME/pP909uN3xctbArGVQyz8S64SbK+bi9hzRe+mYBbqOolsd
	tmQG21a5Y3mMcVXXZDx0RBpcCSR7HCrEzf5awzzi5w8ZrT9rIdtoff7utUGWOL/SnsYeKx
	tSrOMgtbSs68LfdUin6viuRYZmU816o=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-q1awNP8DOpCdARQBC2i7pA-1; Tue, 04 Jun 2024 06:45:51 -0400
X-MC-Unique: q1awNP8DOpCdARQBC2i7pA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52b9ea6e320so1121269e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 03:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717497950; x=1718102750;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HPM0o2rvx0/bFV4qmRXd0NqDxdmnpbCI/tYptEl7x8=;
        b=Q1T5axPoHWdOkctZAAQmDz6JQL2yeTOdMahafJhsVauPeEOytgsGrMl0I2n2WIR64j
         sxI0xFqRgf4RGEK4qXRvLIZClcURQehRXnrb14ceVlKiBqBOdgx8dPhoNcU3091xbHa1
         cFt7MHkkW4O5QBIxgkP83NOjURn0qvZsBqJwhVD+M6Lwwz/DQpEdCBVbqTjs9XM6b3z+
         9HQts+kVRgEh/P9KzKBdIW/Q6v+HGBWbilcSYcfRzkiN9MRB5tSfjnc9e7N6EdGIMq1G
         YDBzm1eZSLUKE5aKpJkPSe82+gX5cIC9eIkcVEqQYXxIt0+m9CdTFNyPlxZAueS4BSf0
         tLVg==
X-Forwarded-Encrypted: i=1; AJvYcCV1upXkx0c/rFikQjGMTd2QJH0u4hk1RoDh9QglICqZANS3Pq5sofNkI6Wmt1FFqBVGMeOGbEGbSCgSISsCMDdWPYzAp553CDz/PXEG
X-Gm-Message-State: AOJu0YzRgZsW41XMzsWQlazOJhSzn6TNuJoOltt88WVFjKuTt/NypPWE
	Ph/YItdTYmqmkWYz+/2j/dDU04aWfr4VYKLUE7Y5jv4kQc4TUtVPfNk6dSOcSIxz3pJYEIDUJQc
	F9KVVduMDHrdYITQ4H/sa8h2D1GWgr3nsjfolXcqAHy1jHnMHose2mkO/pc8CeQ==
X-Received: by 2002:ac2:4a9a:0:b0:51f:4096:dbca with SMTP id 2adb3069b0e04-52b896d8785mr6857693e87.62.1717497950149;
        Tue, 04 Jun 2024 03:45:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYG4IrwksvZP3MoLvphLDi6zoGDHlCeqi18mwapWVaqnHicwb5LLwKcle3GYS5cWbJc8acsA==
X-Received: by 2002:ac2:4a9a:0:b0:51f:4096:dbca with SMTP id 2adb3069b0e04-52b896d8785mr6857680e87.62.1717497949702;
        Tue, 04 Jun 2024 03:45:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73a:3a00:a025:9b06:549e:c16b? (p200300cbc73a3a00a0259b06549ec16b.dip0.t-ipconnect.de. [2003:cb:c73a:3a00:a025:9b06:549e:c16b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd062edbcsm11213042f8f.84.2024.06.04.03.45.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 03:45:49 -0700 (PDT)
Message-ID: <7c6ae2a3-8ec3-4c9b-81c3-125f6973f0f3@redhat.com>
Date: Tue, 4 Jun 2024 12:45:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] mm/ksm: reduce the flush action for ksm merging
 page
To: Alex Shi <seakeel@gmail.com>, alexs@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, izik.eidus@ravellosystems.com,
 willy@infradead.org, aarcange@redhat.com, chrisw@sous-sol.org,
 hughd@google.com
References: <20240604042454.2012091-1-alexs@kernel.org>
 <20240604042454.2012091-2-alexs@kernel.org>
 <9ca730ce-2b2f-42d2-8c7a-78735a995c64@redhat.com>
 <4d299245-3166-4810-b22b-2a5b4f54a049@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <4d299245-3166-4810-b22b-2a5b4f54a049@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.06.24 12:26, Alex Shi wrote:
> 
> 
> On 6/4/24 4:07 PM, David Hildenbrand wrote:
>> On 04.06.24 06:24, alexs@kernel.org wrote:
>>> From: "Alex Shi (tencent)" <alexs@kernel.org>
>>>
>>> We can put off the flush action util a merging is realy coming. That
>>> could reduce some unmerge page flushing.
>>> BTW, flushing only do at arm, mips and few other archs.
>>>
>>
>> I'm no expert on that flushing, but I thought we would have to do the flushing before accessing page content -- before calculating the checksum etc.
>>
>> Now you would only do it before the pages_identical() check, but not when calculating the checksum.
>>
> 
> Hi David,
> 
> Thanks a lot for comments!
> 
> If calc_checksum() is wrong before pages_idential(), (that's just after page was write_protected, that's a real guarantee for page context secured) pages_identical could recheck and make thing right.
> 

Yes, but you would get more wrong checksums, resulting in more 
unnecessary pages_identical() checks.

That is missing from the description, and why we want to change that 
behavior.

What's the net win?

> And as to 2 flush functions here, I didn't see the guarantee for other writer from any other place. So maybe we should remove these flush action?

"I didn't see the guarantee for other writer from any other place" can 
you rephrase your comment?

If you mean "the process could modify that page concurrently", then you 
are right. But that's different than "the process modified the page in 
the past and we are reading stale content because we missed a flush".

-- 
Cheers,

David / dhildenb


