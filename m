Return-Path: <linux-kernel+bounces-258705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD66938BE1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B4151F21AB2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65441607B4;
	Mon, 22 Jul 2024 09:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SmceImXg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C70B168483
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721639885; cv=none; b=XcV0Zj6UaXE2wmgSST2DFvII1O3xXFk6kB5kuH0tRw/PRl05MK9e2agBBj2uE/pLfN3cm7XutHHzmTUmQ7pHx1TgOd3kLHkGfW//VXYEp7LF78T+zhKi9sn5IHSidcDx9eLfxzTqvwaJiYx61u6k22THdjAQe0r6ywd/0H3hchk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721639885; c=relaxed/simple;
	bh=VpwiQL3bQl15QDlMh9yr8inz3ZF/ltiTa/Zg03sslE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p0MF1vj457YpGWI+kzQK243yxOUkG0S0X1yR586XJg5/dp1dFsWjZSsK5jzIkL+5y+e7oFH3CgoyJhsuaaWNRJiebjgvqJCxKsuGASgXZaKcUwbl58Lg1LCodUaUUk4lurZFFfMkT0enePNzW/I4BZwFlqdMd9sy0y16H40vV9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SmceImXg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721639883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JsbK0w156h2SWYer2AVQ1surFwvSsjm1qQcMdcBN1L0=;
	b=SmceImXgITXHols9r8Lm7DRhVDjgw1pLnqYbxL9QlwNKrEu2ZFe0fwvpzMlaciwcrgD5y2
	bL+gnUR9ec2pVwXSzyNLg0EV+MoTYKiUNsAd6sKfc4jBzw6ULmJd3xWw+fajWqVX5+C8Pg
	oPQXGdk90ie2KA/0J2ovGEgGLcDb8pM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-AUE3dLKdM9OZlTBkG1GXzw-1; Mon, 22 Jul 2024 05:18:00 -0400
X-MC-Unique: AUE3dLKdM9OZlTBkG1GXzw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4279418eb2bso28413475e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 02:18:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721639879; x=1722244679;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JsbK0w156h2SWYer2AVQ1surFwvSsjm1qQcMdcBN1L0=;
        b=smB20ict8E60OQfatVjsDJxwnkj4WLC/XWe8FJxQrFcglNOsv/F8XadOYAurvAfzWE
         ENYupa3f++HhI4GHVp9nPa0eIidfouyZ4pI/SyKttBZdf4RhTZZW9p1GS8VwpETWaqGK
         ZzN9yMsWr7pW78fdgxNBGTRJswj7ThSIG1xSkPn6PP26Ip4uy8YFBwmeqj9GVp87b+JE
         3iimqq6najIfcZdsgQpVmdNxpBSSgM+aG85L1h70UZKmOh+lVZXjnUs+9PoZLF37ZRJH
         v5H5xpx14foS3531JBz2vO8QxtMv2XJll5KbFEIheGM888Bk4YA+DWzDQbhYyDgjTnyF
         G9Ag==
X-Forwarded-Encrypted: i=1; AJvYcCV0eTggGLEKlL7w7s4Z/Rz8Joc7g+PVVfNUTj/ULQWqAHWTUgzpGj06NzEH964SRebsgoqCqB4inYM0Gv9sBvSXcYlq6jAz/V3Xedgg
X-Gm-Message-State: AOJu0YzJmOs8NcNSNN931zUVph93gWVzrG6stkh6y8gqyinw6k59H6l0
	3+1BakqDFEOs2e3KZKpcnQ+n3gWKA37jX9G97QaVuuV3h5lcECXzyRDQYReMj9w1c0M8ws6JN+P
	QRqy/Jg0l4W+HfriOV8XfzFud6cvLR9NOVz9LpyvIX0XUgJfB50O93uLordDhfA==
X-Received: by 2002:a05:600c:3553:b0:426:618f:1a31 with SMTP id 5b1f17b1804b1-427dc574167mr42162115e9.34.1721639879688;
        Mon, 22 Jul 2024 02:17:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgHB3Qv8k4nasZsbeUcit/XbumcBp5++vAOLMJTwKywkYTiAyQQTbsbn97JtcFPN+W6746MQ==
X-Received: by 2002:a05:600c:3553:b0:426:618f:1a31 with SMTP id 5b1f17b1804b1-427dc574167mr42161925e9.34.1721639879282;
        Mon, 22 Jul 2024 02:17:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c727:7000:c050:e303:f8a7:6ed9? (p200300cbc7277000c050e303f8a76ed9.dip0.t-ipconnect.de. [2003:cb:c727:7000:c050:e303:f8a7:6ed9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d68fa394sm118725875e9.3.2024.07.22.02.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 02:17:58 -0700 (PDT)
Message-ID: <56c982c4-9863-4134-b088-8dfb4b94c531@redhat.com>
Date: Mon, 22 Jul 2024 11:17:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/x86/pat: Only untrack the pfn range if unmap region
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Peter Xu <peterx@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "Kirill A . Shutemov"
 <kirill@shutemov.name>, "x86@kernel.org" <x86@kernel.org>,
 "Tian, Kevin" <kevin.tian@intel.com>, Pei Li <peili.dev@gmail.com>,
 David Wang <00107082@163.com>, Bert Karwatzki <spasswolf@web.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
References: <ZpTLCscCFGtsrEjC@yzhao56-desk> <ZpUyZ9bH1-f5y5XG@x1n>
 <ZpY5uU2NyOoMVu5A@yzhao56-desk> <ZpbDnoQxGubegtu-@x1n>
 <Zpcgmk6wexTKVv2E@yzhao56-desk> <ZpfR_L9wtuXhtSGk@x1n>
 <Zph051h5BsSFMpR6@yzhao56-desk.sh.intel.com> <ZpkglfpbHH7lQSft@x1n>
 <Zpmi2JWirNDiJz+7@yzhao56-desk.sh.intel.com>
 <1a0884cb-39ed-455e-a505-7c1b2a0e5225@redhat.com>
 <Zp3/ha6IXL5AYA8r@yzhao56-desk.sh.intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zp3/ha6IXL5AYA8r@yzhao56-desk.sh.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.07.24 08:43, Yan Zhao wrote:
> On Fri, Jul 19, 2024 at 10:28:09AM +0200, David Hildenbrand wrote:
>> On 19.07.24 01:18, Yan Zhao wrote:
>>> On Thu, Jul 18, 2024 at 10:03:01AM -0400, Peter Xu wrote:
>>>> On Thu, Jul 18, 2024 at 09:50:31AM +0800, Yan Zhao wrote:
>>>>> Ok. Then if we have two sets of pfns, then we can
>>>>> 1. Call remap_pfn_range() in mmap() for pfn set 1.
>>>>
>>>> I don't think this will work..  At least from the current implementation,
>>>> remap_pfn_range() will only reserve the memtype if the range covers the
>>>> whole vma.
>>> Hmm, by referring to pfn set 1 and pfn set 2, I mean that they're both
>>> covering the entire vma, but at different times.
>>>
>>> To make it more accurately:
>>>
>>> Consider this hypothetical scenario (not the same as what's implemented in
>>> vfio-pci, but seems plausible):
>>>
>>> Suppose we have a vma covering only one page, then
>>> (1) Initially, the vma is mapped to pfn1, with remap_pfn_range().
>>> (2) Subsequently, unmap_single_vma() is invoked to unmap the entire VMA.
>>> (3) The driver then maps the entire vma to pfn2 in fault handler
>>>
>>> Given this context, my questions are:
>>> 1. How can we reserve the memory type for pfn2? Should we call
>>>      track_pfn_remap() in mmap() in advance?
>>> 2. How do we untrack the memory type for pfn1 and pfn2, considering they
>>>      belong to the same VMA but mutual exclusively and not concurrently?
>>
>> Do we really have to support such changing PFNs in a VMA? Are there existing
>> use cases that would rely on that?
> I don't know. But it's not disallowed.

Okay, but we don't know of any such use case.

What we do have is a single VMA, whereby within that VMA we place 
various different PFN ranges. (randomly looking at 
drivers/video/fbdev/smscufx.c)

These wouldn't have triggered VM_PAT code.

-- 
Cheers,

David / dhildenb


