Return-Path: <linux-kernel+bounces-255286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384CF933E5F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8781C20A1D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2DC181315;
	Wed, 17 Jul 2024 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4wxJUYJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3381802DC
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 14:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721226347; cv=none; b=tD4k/uXXU2BTdVAES1DYeX8ZJua2FVD2mfP86jZTyh7lpsvWv/Wj3gvapQLEiCCiEVR/Ugon5BrPTpDq/8mbPPRrqQZ0QYS/1zZ88zITg9yrmokMlt73WZZs1FbBARUybl9bw2ZbkpLszv56gnPXjIaIaDfI+54HCd38T6AyJF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721226347; c=relaxed/simple;
	bh=SzmZVcYjUGaAJdvjwwSPGTC1vLRu1i+OE4/S71pzyqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BJdhdckoAc4q9CYM1vFbxyT2OddbRkC8AH9+77uIBXAJhOnD/G9MpS6at2KeFhWp+KlHQT2jkXLhqe2hIc6MN7KXnz3IMM7+B2sNHPzG7TOPu85PyuvBMHcHWGucXsJHzgRagHI9aZ/CtOk8AZKhN/erbIKwfWC5h5Y76HqJCc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N4wxJUYJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721226345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WmgchlVL2R/2zwyoj2YA6w0fkpeUwdLz21Lh1PDYG+8=;
	b=N4wxJUYJNRGGnhgfypN9Fe/NaRSwoH5FR4w749r/rSwK+XXA1qrpWPsPTfF+lcSVnj8CxU
	gosH/wRUrFcuOVc87Ug99vKbwuAi8ojl8wJFdam5+0r03nwd2ZT+/ydRjYBwsMiyzj3iFO
	HpTKazMx1K0fTR2NUqRMQg3YLaY+6s8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-5pRGG7_XNAyp_sAxbYU5kQ-1; Wed, 17 Jul 2024 10:25:43 -0400
X-MC-Unique: 5pRGG7_XNAyp_sAxbYU5kQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-367990a5796so4082423f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721226342; x=1721831142;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WmgchlVL2R/2zwyoj2YA6w0fkpeUwdLz21Lh1PDYG+8=;
        b=fr8eVWkduf78ap84t9XWywjkz453B7fgyAdppeNnWuPX+i4P2FEzAHBiRVZuayUSOk
         40CD9BJnBx5n68hyRXeDVKL6nPK4DD0/51qwRWRp8vpm/MaR303v5klFk2FtrM8lfF0e
         /Jof88ir6gQ1e5AQlBTKaOgy2wt0/o/tIikhG8d8Sjp8RxxXPGLMLpqRzY3gLqolkhag
         DyPUostmoOrp+9Nu1t2mpFX2mepEq9zm/TEtr68Pgna9+kqflBb6JPPII0nHErXIIanV
         gqRSpxzXK335hx45daJ2/+mWcfZoyttAtE9e21/VnuVkMIQL9uNboJHtgrtIDbb7P22o
         q5Vg==
X-Gm-Message-State: AOJu0YyCy9n2S4tEbr7fGg6l6e0Qpqk75muYtSkF6O9yWakc6AdRDBjw
	1che+WRlP661tR8AdowNDTPTsV7M0zjxexarg17lXAbj5PdoY0L3EfeDeRY4d1WRj7jjWjy7X0b
	ll+XgxpNB9q7KpD1/2KLnzmO377ldG+IyCLyPAt1wEwhyOXFcdV+kX9thtVbEgQ==
X-Received: by 2002:a05:6000:dc2:b0:367:97b9:d5ed with SMTP id ffacd0b85a97d-368315e7717mr1647698f8f.9.1721226342218;
        Wed, 17 Jul 2024 07:25:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlXZ2Z2/69TTCaU7nOgdTfa8Do1HC+YRzbfwY7iKPZYpptrsU6RQidA4EH3VMR6EmGUUPdKw==
X-Received: by 2002:a05:6000:dc2:b0:367:97b9:d5ed with SMTP id ffacd0b85a97d-368315e7717mr1647677f8f.9.1721226341797;
        Wed, 17 Jul 2024 07:25:41 -0700 (PDT)
Received: from ?IPV6:2003:cb:c714:c00:b08b:a871:ce99:dfde? (p200300cbc7140c00b08ba871ce99dfde.dip0.t-ipconnect.de. [2003:cb:c714:c00:b08b:a871:ce99:dfde])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680db0484dsm12077535f8f.110.2024.07.17.07.25.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 07:25:41 -0700 (PDT)
Message-ID: <7efc4b0b-4e12-4b29-815f-0854182ce135@redhat.com>
Date: Wed, 17 Jul 2024 16:25:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/4] Control folio sizes used for page cache memory
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 Jonathan Corbet <corbet@lwn.net>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Barry Song <baohua@kernel.org>, Lance Yang <ioworker0@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Gavin Shan <gshan@redhat.com>,
 Pankaj Raghav <kernel@pankajraghav.com>, Daniel Gomez <da.gomez@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240717071257.4141363-1-ryan.roberts@arm.com>
 <eb2d8027-6347-4cc5-b1f6-6e79dc9a02ef@redhat.com>
 <99b33a29-e97a-4932-8d7a-85bc01885d18@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <99b33a29-e97a-4932-8d7a-85bc01885d18@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.07.24 12:45, Ryan Roberts wrote:
> On 17/07/2024 11:31, David Hildenbrand wrote:
>> On 17.07.24 09:12, Ryan Roberts wrote:
>>> Hi All,
>>>
>>> This series is an RFC that adds sysfs and kernel cmdline controls to configure
>>> the set of allowed large folio sizes that can be used when allocating
>>> file-memory for the page cache. As part of the control mechanism, it provides
>>> for a special-case "preferred folio size for executable mappings" marker.
>>>
>>> I'm trying to solve 2 separate problems with this series:
>>>
>>> 1. Reduce pressure in iTLB and improve performance on arm64: This is a modified
>>> approach for the change at [1]. Instead of hardcoding the preferred executable
>>> folio size into the arch, user space can now select it. This decouples the arch
>>> code and also makes the mechanism more generic; it can be bypassed (the default)
>>> or any folio size can be set. For my use case, 64K is preferred, but I've also
>>> heard from Willy of a use case where putting all text into 2M PMD-sized folios
>>> is preferred. This approach avoids the need for synchonous MADV_COLLAPSE (and
>>> therefore faulting in all text ahead of time) to achieve that.
>>>
>>> 2. Reduce memory fragmentation in systems under high memory pressure (e.g.
>>> Android): The theory goes that if all folios are 64K, then failure to allocate a
>>> 64K folio should become unlikely. But if the page cache is allocating lots of
>>> different orders, with most allocations having an order below 64K (as is the
>>> case today) then ability to allocate 64K folios diminishes. By providing control
>>> over the allowed set of folio sizes, we can tune to avoid crucial 64K folio
>>> allocation failure. Additionally I've heard (second hand) of the need to disable
>>> large folios in the page cache entirely due to latency concerns in some
>>> settings. These controls allow all of this without kernel changes.
>>>
>>> The value of (1) is clear and the performance improvements are documented in
>>> patch 2. I don't yet have any data demonstrating the theory for (2) since I
>>> can't reproduce the setup that Barry had at [2]. But my view is that by adding
>>> these controls we will enable the community to explore further, in the same way
>>> that the anon mTHP controls helped harden the understanding for anonymous
>>> memory.
>>>
>>> ---
>>
>> How would this interact with other requirements we get from the filesystem (for
>> example, because of the device) [1].
>>
>> Assuming a device has a filesystem has a min order of X, but we disable anything
>>> = X, how would we combine that configuration/information?
> 
> Currently order-0 is implicitly the "always-on" fallback order. My thinking was
> that with [1], the specified min order just becomes that "always-on" fallback order.
> 
> Today:
> 
>    orders = file_orders_always() | BIT(0);
> 
> Tomorrow:
> 
>    orders = (file_orders_always() & ~(BIT(min_order) - 1)) | BIT(min_order);
> 
> That does mean that in this case, a user-disabled order could still be used. So
> the controls are really hints rather than definitive commands.

Okay, because that's a difference to order-0, which is -- as you note -- 
always-on (not even a toggle).

Staring at patch #1, you use the name "file_enable". That might indeed 
cause some confusion. Thinking out loud, I wonder if a different 
terminology could better express the semantics. Hm ... but maybe it only 
would have to be documented.

Thanks for the details.

-- 
Cheers,

David / dhildenb


