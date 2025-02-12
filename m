Return-Path: <linux-kernel+bounces-511172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF56A32736
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAF2F7A1737
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B950920E317;
	Wed, 12 Feb 2025 13:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D5p12Jn4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C550E20D512
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739367257; cv=none; b=hB1vAagT59SLkyYkUYQrK08pinKeV+d8pyFlJ/D7tY4tDbgp5c/v3cNnsZZIwg7+OlZSMMc+FbObIRWP3p2QpuLh9Ad6STOM2BlH3sG61pZOy0shRmBmmQOodJZYBAi3aUwnl8nnY6jLQfkCT7YZY7bBj/WCZ2oFk6OeQk6tqzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739367257; c=relaxed/simple;
	bh=Ar3+UJm2+3Xl3Ikw4Q4JPTOxtaU6TTApmjDQC+jXAlU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KBoYFrel8wWlMCQRaerquOXN1LiTo4l++6SQDhEryYEP8GYgJS32yQeWJYIHt3UwaFWiHpM7Ir4lwv5Zb2/IOq+YQrY4fgavqD9t8PgilpZiAyAcj8/lGYceErYpoOvvtut/Rwr90U30Jd1WZqNOxk5mejmCvSxY4rckU/WP9oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D5p12Jn4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739367253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RjHxnqTK7Tsl4746vRmLwJhugP3RFRR70bNvY/4d+hc=;
	b=D5p12Jn4l0+eypZuhsYLbOJY1KawGKkJzY2pvsZLKAPzPC5UplBurv5+Orbt/BIYpMwPui
	S+G2ujyBfPYB1EL4lFfVkctB+O7Ap+FkMXsAJj4Mj72tlBAm2D4HJxQbJC+IUc8a5qRqTm
	vx4LFRhIwKbpWL//eK7qGxiBihbFUMA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-Mv4XcmwLOHyZFb4PBFY6tw-1; Wed, 12 Feb 2025 08:34:10 -0500
X-MC-Unique: Mv4XcmwLOHyZFb4PBFY6tw-1
X-Mimecast-MFC-AGG-ID: Mv4XcmwLOHyZFb4PBFY6tw_1739367250
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e451554bc2so20435956d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 05:34:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739367250; x=1739972050;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RjHxnqTK7Tsl4746vRmLwJhugP3RFRR70bNvY/4d+hc=;
        b=r0ozOdRpPNpl1FjxI05MdijzWTYrsKJgGqngZ/M5upfoFSUrdQbNrvfjkyAnTE44jG
         RJ3uICmydXlNB7DkB5OJEWW/evKTVn7uziiW9HhOGuDfD5MpdPxjjuADdH2cU8q8hIVC
         JBfCdSJzi8RiJAuwfNRN8U1fkFm08a6tV6r9XmD6qRYAMqR+wxc1Ylh+uwuNcUExa1+A
         lQ5nzve5V/sJm1ObF74lfqRipl4EpZ8b102DTDRqpGp3l/zKm56frs5Mxk2D70fEL/nB
         3AYW+lQSKIXe9AiPBsf1IVHey1IQYa8UhVxUfO/8fi7wfXMmqhJ9RTg12oCVNAk5A8cv
         rDJA==
X-Forwarded-Encrypted: i=1; AJvYcCWmowxiURY6HcvGg/YsOuP0qC6xiQjSaDWDcQOPP8CwQAvQQbqC2gQ8FENI0wT60785TGkjqvW+104INeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaYI+PTIFybihJLStuxFF4/i+2SvAl804Ojxd5IG/dayrAtjN6
	8myNgAi2+mtBTK5RD+fdcs1V94ox0tsvBhZnP7bwww1JqVcS5WeeTC3X/1/pkrz9DqMLmhIgYT4
	oSBoae7SS6LJW1S63GSce11/z1+oHvdElJ2cw49eoQeSHve7j1Sk9XXjsabeSCw==
X-Gm-Gg: ASbGnctKL5SU8d3lAhLb8uh2v0TQPmX1iFhvqXFFqKlbjNqrGBqUo2xAV0A6BJG6vQq
	+ctOt+1I+5YjODFnG5veP6fyryF8jXU4zONR/w+ron6f+2KTFZ0zcB+yqp3cKUkfVzWwy0vwXNq
	R4DTpGhzxpo73XYh1RrPLVyXcmSHFQoNmlee197hxCvd08dDfVJE4ZlpdaX4ZruJd+tfeLvF2k8
	KxUucrQlk88uGOptLP3T7zglkrpG+TEGHlaTD4BFx8HI7LXCwQO3dm6Dk+QcO7s9q4Iq8m9re8v
	vgmpdAeBHOGsP2PBaxcn0xCRoj3zKMHkondJSFPAbhJ01rkn
X-Received: by 2002:a05:6214:c42:b0:6d8:a9a6:83ef with SMTP id 6a1803df08f44-6e46f1da496mr49185336d6.20.1739367250252;
        Wed, 12 Feb 2025 05:34:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGs0Pe9/V9TaL6+rhFjbdDu36BTL6SFLc78XicWOC9wyqy6n/fQPDTVqV0uazIlKcaI48DP+g==
X-Received: by 2002:a05:6214:c42:b0:6d8:a9a6:83ef with SMTP id 6a1803df08f44-6e46f1da496mr49184616d6.20.1739367249055;
        Wed, 12 Feb 2025 05:34:09 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e659e49ae1sm2715296d6.124.2025.02.12.05.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 05:34:08 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <cfe70f31-e650-4033-9281-baa4cdc40b96@redhat.com>
Date: Wed, 12 Feb 2025 08:34:06 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kasan: Don't call find_vm_area() in RT kernel
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 Nico Pache <npache@redhat.com>
References: <20250211160750.1301353-1-longman@redhat.com>
 <CAPAsAGzk4h3B-LNQdedrk=2aRbPoOJeVv_tQF2QPgzwwUvirEw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAPAsAGzk4h3B-LNQdedrk=2aRbPoOJeVv_tQF2QPgzwwUvirEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/12/25 6:59 AM, Andrey Ryabinin wrote:
> On Tue, Feb 11, 2025 at 5:08 PM Waiman Long <longman@redhat.com> wrote:
>> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
>> index 3fe77a360f1c..e1ee687966aa 100644
>> --- a/mm/kasan/report.c
>> +++ b/mm/kasan/report.c
>> @@ -398,9 +398,20 @@ static void print_address_description(void *addr, u8 tag,
>>                  pr_err("\n");
>>          }
>>
>> -       if (is_vmalloc_addr(addr)) {
>> -               struct vm_struct *va = find_vm_area(addr);
>> +       if (!is_vmalloc_addr(addr))
>> +               goto print_page;
>>
>> +       /*
>> +        * RT kernel cannot call find_vm_area() in atomic context.
>> +        * For !RT kernel, prevent spinlock_t inside raw_spinlock_t warning
>> +        * by raising wait-type to WAIT_SLEEP.
>> +        */
>> +       if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
>> +               static DEFINE_WAIT_OVERRIDE_MAP(vmalloc_map, LD_WAIT_SLEEP);
>> +               struct vm_struct *va;
>> +
>> +               lock_map_acquire_try(&vmalloc_map);
>> +               va = find_vm_area(addr);
> Can we hide all this logic behind some function like
> kasan_find_vm_area() which would return NULL for -rt?
Sure. We can certainly do that.
>
>>                  if (va) {
>>                          pr_err("The buggy address belongs to the virtual mapping at\n"
>>                                 " [%px, %px) created by:\n"
>> @@ -410,8 +421,13 @@ static void print_address_description(void *addr, u8 tag,
>>
>>                          page = vmalloc_to_page(addr);
> Or does vmalloc_to_page() secretly take  some lock somewhere so we
> need to guard it with this 'vmalloc_map' too?
> So my suggestion above wouldn't be enough, if that's the case.

AFAICS, vmalloc_to_page() doesn't seem to take any lock.  Even if it 
takes another spinlock, it will still be under the vmalloc_map 
protection until lock_map_release() is called.

Cheers,
Longman


