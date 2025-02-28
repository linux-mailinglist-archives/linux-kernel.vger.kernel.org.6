Return-Path: <linux-kernel+bounces-539507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF851A4A542
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81F9D16D513
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EC11DE3A5;
	Fri, 28 Feb 2025 21:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bz8XFeZ7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8761DDA39
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 21:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740779167; cv=none; b=OqJnGltCUPa8gQWqbBl9zYKlvKxfsD1RIt+lJcwR7vg9NLgqkqqiz5n5gwPVv+X9KmhKZOuuqCL6NLxuC1kp2iQAlaB5+zfOJb3AmOriFcw3DfixqThfTPN4NdzxRjBTI/BUjTzQ6CMO3o9LkG6KZFbpbqh4wgPhOpHRKjkkMXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740779167; c=relaxed/simple;
	bh=8T9bgLgRvlpfOWd16u6mMIsSnKoCHA7h0QujpMhn0t8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kOIeelLaIem8c1ewInhZu46V5rWZ923jTfNGg3jQa1zAi8kciFW1CBc80Bd6n/Mb63tu6d8VNNBq04sXEGHNNKbvCbKhtgUGj8nOmwHpk6H2ulmZmLEm6FVyYCiAJEsuwZc2CLMeFou5aY/ww4qxYXC+hRZ0fL/kLSrg4F+RGo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bz8XFeZ7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740779163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nDYzJL5vGJLEKJ5yDUlwXy7G+JatGW9eUOsorOskj2I=;
	b=Bz8XFeZ7typ4u1ZcD70M40s5VPkhwOuCeGCokGJU1IaObWD3brbJhnqXfngj7G5OmdsedC
	XUO9hGJfrR7hBVK5otpX0yon7KoxfhXOXm2oW//z8qfxQ1Jci/fV31lhS5lYu2ZfGlaZyx
	BFi/hvCOdPBE+HjMgnorp94Op3hVb8s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-sGwJC_5wNqm-0Tbi2kLB8w-1; Fri, 28 Feb 2025 16:46:01 -0500
X-MC-Unique: sGwJC_5wNqm-0Tbi2kLB8w-1
X-Mimecast-MFC-AGG-ID: sGwJC_5wNqm-0Tbi2kLB8w_1740779160
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f4e3e9c5bso1103062f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:46:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740779160; x=1741383960;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nDYzJL5vGJLEKJ5yDUlwXy7G+JatGW9eUOsorOskj2I=;
        b=IqpoiiH+KaFyHOQ7D4NUurKrE8lOHa4ng/FZgqEg5VkwTXgvvvhKSvS4XI8S6Bjti1
         zDbd2TemPd/9HA7OhR+g79rQTeV2kM7A3RrVs9iTxKL/iwRAeldPTIlguLpl6tdLd10V
         9MW/fG8Olg0UpnyQPBpfxOJJ8j2L9OO7KlLpKD+YQhPO9/q8n6I3AGpWzqk1FpoIvLTp
         R9/+qFVW2DvF3dEE+G3nSrC/OhdvLYnlWr819Zgz6a6xl9GNLgW9AyhBTDFbVRTU96o8
         +S3Op9t/golzWb0kYWRVOBMm4oYjN1+4bqu8koATZfLiMaBJ23tbOQhyOaqturTFTM5N
         6CKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMSvS7fZxK0wHFB8x3eiXWSkxyGvjJJaW/YTjz3FXejAC8KcXEtHtgGurcd70mjUrpsDK1qnC+4qlyg+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbgI6CQg5si0ZLjjdImac6uvuoc0/Ly6O0Au0JQLALWqRKjxMI
	OuP0ku8ivQzxtCiT6eub3yEdg9MQO5b3gd+kmfuuDogWlFxZSM/siMY+2lZmt8LScMQNKN4Q8h3
	L2OQQldwZ29R3eQ7tAxwuhh4GIZRP6Y+umHCQdjuMpu5BadPYywalrYh24odjSw==
X-Gm-Gg: ASbGnctpn1jZwAGw3IlCorD5sEnIvV+nw1GfKoOHzGgCG7j28HQim7bXlGOdG/JUeKC
	Egc/f01GNY2288FMi6ReobYQlSz/79jBmAZG/o6LFIkzfeZBm220tKhpuUE+OuY0L/vj+9O4wzn
	pv/nwDPQksWyMZmJ/V64RnZ9tVKvaPgZoWP9j+VWcn3QGHEuMtglsk8fQeeJNAeRf2epjyqrMc8
	rVjITJV+b84qS5oEAoae3k+ktxf0RGLKp1WO7vEFPayPQr+XRg72hCKWUaZZKejLqPZdK+KEtOM
	f92ILvjnPzW4WsXzQ9TierY5yY7Yx7OH0iXyOHpTc+UkjRJtxpHXdXhyR3I0bdfEHjZN4BegqO3
	YIKpLlzLANWvhn3/VzYB5uJ4x4rot/8+G5gdU0+4qoX8=
X-Received: by 2002:a5d:5983:0:b0:390:d6ab:6c3f with SMTP id ffacd0b85a97d-390eca1fademr4015982f8f.37.1740779160373;
        Fri, 28 Feb 2025 13:46:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXEMjeMIK0fiEz9eZNggGAua4CJNH6o8msHILyE9LryVAqmGVYy868qvHswkdCoDFBwxaNTQ==
X-Received: by 2002:a5d:5983:0:b0:390:d6ab:6c3f with SMTP id ffacd0b85a97d-390eca1fademr4015952f8f.37.1740779159546;
        Fri, 28 Feb 2025 13:45:59 -0800 (PST)
Received: from ?IPV6:2003:d8:2f36:d800:164f:7689:99fe:7f58? (p200300d82f36d800164f768999fe7f58.dip0.t-ipconnect.de. [2003:d8:2f36:d800:164f:7689:99fe:7f58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73718abcsm68236435e9.22.2025.02.28.13.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 13:45:58 -0800 (PST)
Message-ID: <adc90638-79a7-4015-accc-0932611cc697@redhat.com>
Date: Fri, 28 Feb 2025 22:45:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] SKSM: Synchronous Kernel Samepage Merging
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Sean Christopherson <seanjc@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, Olivier Dion <odion@efficios.com>,
 linux-mm@kvack.org
References: <20250228023043.83726-1-mathieu.desnoyers@efficios.com>
 <CAHk-=wgedRzDqOLhbOnvziVHZm9jtGOrT4GJEqA9etJDwTQ5Mg@mail.gmail.com>
 <8524caa9-e1f6-4411-b86b-d9457ddb8007@efficios.com>
 <CAHk-=wi5-+P49c3NPeZB_qrNyOtAJS3YadHB0q7J3eZ3UUwrjw@mail.gmail.com>
 <029759d4-f7b2-4ec6-b5d0-7c8a1c0fbd80@redhat.com>
 <Z8HPN5sAgInM4dN2@google.com>
 <e110e00f-9032-43ec-808e-45a912065fb0@redhat.com>
 <331ed532-eb98-4665-9d1b-b6b8bf46e396@efficios.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <331ed532-eb98-4665-9d1b-b6b8bf46e396@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.02.25 22:38, Mathieu Desnoyers wrote:
> On 2025-02-28 10:10, David Hildenbrand wrote:
> [...]
>> For example, QEMU will mark all guest memory is mergeable using MADV, to
>> limit the deduplicaton to guest RAM only.
>>
> 
> On a related note, I think the madvise(2) documentation is inaccurate.
> 
> It states:
> 
>          MADV_MERGEABLE (since Linux 2.6.32)
>                 Enable  Kernel Samepage Merging (KSM) for the pages in the range
>                 specified by addr and length. [...]
> 
> AFAIU, based on code review of ksm_madvise(), this is not strictly true.
> 
> The KSM implementation enables KSM for pages in the entire vma containing the range.
> So if it so happens that two mmap areas with identical protection flags are merged,
> both will be considered mergeable by KSM as soon as at least one page from any of
> those areas is made mergeable.

I *think* it does what is documented. In madvise_vma_behavior(), 
ksm_madvise() will update "new_flags".

Then we call madvise_update_vma() to split the VMA if required and set 
new_flags only on the split VMA. The handling is similar to other MADV 
operations that end up modifying vm_flags.

If I am missing something and this is indeed broken, we should 
definitely write a selftest for it and fix it.

-- 
Cheers,

David / dhildenb


