Return-Path: <linux-kernel+bounces-203830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F191A8FE102
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B9061F22C68
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C251513C69A;
	Thu,  6 Jun 2024 08:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NhI+Jdu/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE8326292
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662814; cv=none; b=s0wNLh3IfOrHU+lo5EuMeQyDzoVWbia3tuUfzrOBoaK6YDzopeJNr5XmUR81g0kifvW/JM/FqhB1QxLTDI4kh2rMZ3jIx4oKVskui+y4ASXjwBwmGMXTM1NElrBrO2sXtKGsyT09jj3rREy7voaWwLf1JxHAxhpdMEttatdZrqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662814; c=relaxed/simple;
	bh=LD74jJWJuircWSkL9dyztZMxEZNVknNz1aruUljGhHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TrIsonT0v9pFd32KjcBJKUhYwhWdBsuNMtvl4DHngQv+c/K+KjHBToe5jfGi4u3Cb+ATDSpKETCVHndVcYw7k4Jo8HY3PPD7SER2BoqWpwmetpYK7NnlauoJKEsM7B6yHlpSTwKOh0AgoD3/uyGkhiGSjxqNgChGDcae86Qd9N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NhI+Jdu/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717662812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=v4ymki/6gNSFMJej8nfikxAgXYlPj01as+Nv5Lqi0VY=;
	b=NhI+Jdu/v4pE3OMk3ehfV0wqIHZDn98dmPcJmwmnN+ED3EBXTRrzs3k84zsruw6deRARnR
	iyXoxdelU6x4nIZ40zoBmk9qPNihJco++oyWUDxQTk1myZID0H+gLONBXUueXenFQSrEaP
	tQ18vuGEefYPIqZdh0dfkWKcomwLyW0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-ZQD35_rPN9GtfybNUlMBoQ-1; Thu, 06 Jun 2024 04:33:29 -0400
X-MC-Unique: ZQD35_rPN9GtfybNUlMBoQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42155e1f0aaso7168715e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 01:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717662808; x=1718267608;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v4ymki/6gNSFMJej8nfikxAgXYlPj01as+Nv5Lqi0VY=;
        b=PPHg33KCsleTp34nxRCIeO8NZFgWH6bp07yFA7k8Ysi+xnxrjAsjAatxf0/7G01L8s
         cN7T42MvDK8w8GEIHnimqinI0pVvgpsNIEjkhYIU+gP86xiioLxqiYaOQ9Alke0BTQ+7
         rlSxfbfcXoWMy2Ca5DYXy+/1pa+LDxGbp995YKO5xkIwEtAYdMr5eFEWYRNU6yR0WS3L
         dkFhqTNPV7tdkuRptjNg3rAj32u2JPdVAF9q1k3qnkWenemA0lgVVKFCr4pvaSQvrrGn
         GLMPzHE6qqjrsqwK1Krpv48+LuCOAGE56eecJDyu8oNzCEWMZ5JGycaTAFb8CwP51po6
         r9JA==
X-Forwarded-Encrypted: i=1; AJvYcCVhIjKAmUZHt9eLLFDX3DZIIDso7CRPxR/uQanzAamSU6yQbFFJh6Mpz2+V0dekZqvbk9JBCvSGV7y6LNbNJZSw3G2IfSzmE/8cDBKI
X-Gm-Message-State: AOJu0YzQ9YvzFbWBH1BohLVBcEjRjlM9ZGVdFTWsY3hczc5GjuWZ6GpV
	unS6ieMI99a51BvcuvmbExEDTrqiuD1dCqs+U8H/lbRdVhGt8SgZW6kFEg0qCiwh21cAOMB0KqY
	/ld8kn/EcyqHLyufxzBJZKJh5dFvciPDtYakDZdxsS96gneI2yRWIUqkUmKlY5g==
X-Received: by 2002:a05:600c:4514:b0:421:1e47:62d3 with SMTP id 5b1f17b1804b1-421562c3517mr47810305e9.3.1717662808522;
        Thu, 06 Jun 2024 01:33:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElUQV8h3GfTD4X+DYsukpPUpGuMUNYt132KZEbfMl+rjNnJNPpLc/98F9uXTTwCPKVcUgf9w==
X-Received: by 2002:a05:600c:4514:b0:421:1e47:62d3 with SMTP id 5b1f17b1804b1-421562c3517mr47809995e9.3.1717662808055;
        Thu, 06 Jun 2024 01:33:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c710:8800:a73c:ec5b:c02c:5e0b? (p200300cbc7108800a73cec5bc02c5e0b.dip0.t-ipconnect.de. [2003:cb:c710:8800:a73c:ec5b:c02c:5e0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c364bcdsm13086275e9.19.2024.06.06.01.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 01:33:27 -0700 (PDT)
Message-ID: <d267c102-61fa-4ac7-849d-92cb1ac9a104@redhat.com>
Date: Thu, 6 Jun 2024 10:33:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 09/12] mm: implement LUF(Lazy Unmap Flush) defering
 tlb flush when folios get unmapped
To: Byungchul Park <byungchul@sk.com>, Dave Hansen <dave.hansen@intel.com>
Cc: Byungchul Park <lkml.byungchul.park@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com,
 akpm@linux-foundation.org, ying.huang@intel.com, vernhao@tencent.com,
 mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
 peterz@infradead.org, luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, rjgolo@gmail.com
References: <20240531092001.30428-1-byungchul@sk.com>
 <20240531092001.30428-10-byungchul@sk.com>
 <fab1dd64-c652-4160-93b4-7b483a8874da@intel.com>
 <CAHyrMpxETdVewTH3MCS4qPyD6Xf1zRUfWZf-8SCdpCFj2Pj_Wg@mail.gmail.com>
 <f17f33e8-1c1f-460f-8c5a-713476f524a3@intel.com>
 <26dc4594-430b-483c-a26c-7e68bade74b0@redhat.com>
 <20240603093505.GA12549@system.software.com>
 <d650c29b-129f-4fac-9a9d-ea1fbdae2c3a@intel.com>
 <20240604015348.GB26609@system.software.com>
 <20240604044348.GA40889@system.software.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240604044348.GA40889@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.06.24 06:43, Byungchul Park wrote:
> On Tue, Jun 04, 2024 at 10:53:48AM +0900, Byungchul Park wrote:
>> On Mon, Jun 03, 2024 at 06:23:46AM -0700, Dave Hansen wrote:
>>> On 6/3/24 02:35, Byungchul Park wrote:
>>> ...> In luf's point of view, the points where the deferred flush should be
>>>> performed are simply:
>>>>
>>>> 	1. when changing the vma maps, that might be luf'ed.
>>>> 	2. when updating data of the pages, that might be luf'ed.
>>>
>>> It's simple, but the devil is in the details as always.
>>
>> Agree with that.
>>
>>>> All we need to do is to indentify the points:
>>>>
>>>> 	1. when changing the vma maps, that might be luf'ed.
>>>>
>>>> 	   a) mmap and munmap e.i. fault handler or unmap_region().
>>>> 	   b) permission to writable e.i. mprotect or fault handler.
>>>> 	   c) what I'm missing.
>>>
>>> I'd say it even more generally: anything that installs a PTE which is
>>> inconsistent with the original PTE.  That, of course, includes writes.
>>> But it also includes crazy things that we do like uprobes.  Take a look
>>> at __replace_page().
>>>
>>> I think the page_vma_mapped_walk() checks plus the ptl keep LUF at bay
>>> there.  But it needs some really thorough review.
>>>
>>> But the bigger concern is that, if there was a problem, I can't think of
>>> a systematic way to find it.
>>>
>>>> 	2. when updating data of the pages, that might be luf'ed.
>>>>
>>>> 	   a) updating files through vfs e.g. file_end_write().
>>>> 	   b) updating files through writable maps e.i. 1-a) or 1-b).
>>>> 	   c) what I'm missing.
>>>
>>> Filesystems or block devices that change content without a "write" from
>>> the local system.  Network filesystems and block devices come to mind.
>>
>> AFAIK, every network filesystem eventully "updates" its connected local
>> filesystem.  It could be still handled at the point where updating the
>> local file system.
>>
>>> I honestly don't know what all the rules are around these, but they
>>> could certainly be troublesome.
>>>
>>> There appear to be some interactions for NFS between file locking and
>>> page cache flushing.
>>>
>>> But, stepping back ...
>>>
>>> I'd honestly be a lot more comfortable if there was even a debugging LUF
>>
>> I'd better provide a method for better debugging.  Lemme know whatever
>> it is we need.
>>
>>> mode that enforced a rule that said:
> 
> Do you means a debugging mode that can WARN or inform the situation that
> we don't want?  If yes, sure.  Now that I get this, I will re-read all
> you guys' talk.
> 

In my opinion either for debugging, or for actually enforcing it at 
runtime. Whatever the cost of that would be needs to be determined.

-- 
Cheers,

David / dhildenb


