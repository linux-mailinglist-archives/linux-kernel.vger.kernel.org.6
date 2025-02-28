Return-Path: <linux-kernel+bounces-538833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14493A49D97
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 110841899C62
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BAD26B95A;
	Fri, 28 Feb 2025 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YL028L48"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3A6189902
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 15:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756897; cv=none; b=UCSMIKuArBNQDivQqjhpAyXmXyTG2uYDUPo2FA1+KmUNBfFHAIufzzRzRh3jPRcJVJeUGYi4Ykngkaah2bZDbjyUQee1VZYLHePVucdfKqn27imKCPbCxxgj71WJHbsJZ3JBliOAQUy1SD8Hpo/KzCfeCy+cGDkKFbkh1bv56ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756897; c=relaxed/simple;
	bh=fYGr//6cLS4dSYgPJpm27AY/CVUFW/gsFl/rDJ+jINo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WhPk0AzXEywV5cZGvuLybxcswSdgEyUKHy1nXKiId4nFe57a5O56/SdxqcQuDGU/t2bGSNCsGvqtbc0B5KqPsJV/2CBSpDGRcioxlcOg1LNIHw4SXTp8bsAsS/LHnPjdPSIy1jYriobrJl2t28YlXSp68EQw59PC3cl0Ejb8/d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YL028L48; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740756894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DPsfiK56AKxZCGmabFP7JCG7/h/DbBco010SEUNRESA=;
	b=YL028L4872s1cUEW/Gai3N92gCeExRcziRoi5Y3Su2/zTrxiZIRIqjNI0CQ5NavSsDfdZ8
	SABpFKEUi5T7Ahnwyj5sAW6B58hG8pjKYqGeYcJqZMYQtyWaBWt5qKU984rhjUw2nIXLNV
	TcGiNnhHm3/HY2kJaFEOEcT2Jy0f4rg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-rJgbbsJCNq-AWzyLWWej3Q-1; Fri, 28 Feb 2025 10:34:53 -0500
X-MC-Unique: rJgbbsJCNq-AWzyLWWej3Q-1
X-Mimecast-MFC-AGG-ID: rJgbbsJCNq-AWzyLWWej3Q_1740756892
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-390df5962e1so1316408f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 07:34:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740756892; x=1741361692;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DPsfiK56AKxZCGmabFP7JCG7/h/DbBco010SEUNRESA=;
        b=HSWsyN0lquxs6IpXZK7OUgM0cUXQVh8nCVUPUS2G6nEJeSDcgJu3qTanMYjol9XnSR
         B4ryoCoCUFvosVheaJHPM/L58nBFUfySV72V07bi5wHXnWZFiGIo+DGxNEJ05imGgzYE
         xacpaIRRL2Nn4XLl/xN0yhkwO6qHLME5MsmnM/p+KwHLIR30w5V9dgeFFPl9vZaXJeqI
         zaVVDGB/JdBjxalru0YN5/eSClv6x8U0XWoABbciZU2bRqrN+8HF+Ln+Xw2mSui630vR
         svmh18YwzEsLgXaGRQFMkARET/+xRo0lgajPS7G0P8/UxPlI2c+o9uYm6fV0OjKXcaCs
         5N+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdhgfFpyRwqCl1ZonOXRgvQizSn9stKhobikEoAgiOVj6IrsXP3g+eR1igF0a0f+SPHgxvdGMiBgwVX8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvrQWQ+0fKFFsE801KQGXYTgmZWEcT3tUjTiuKVrnMXyMBBNUv
	cYtsg65p6v5KWfB9F6N06oC32BYPnMANCsnfWlc99Ws02NWncouauDm897+eH8j51DPmBFLq+8/
	ETE2qu+2eigmGTGnqkIDKPPk+X4r3cgGFarvsglQtyUaG6VRnMLj8S16Saa2IPbkNsdCCaihE
X-Gm-Gg: ASbGnctuPMTZrMAHtCM9ROwC2nRhUNttTcSdmYxJEJVAXSgUbhHLfl8vAXWFZFyHK0z
	0xWYVTe79sfguUYzkYqROFpaDzY6Pg9kXWok6RUWlc3QJCbfjGnflpxbMojdGaKmhAfJ4Y2MPHr
	hzKrcI5rIvshGKy6lsvgyTfk6FksvE1nHS1GDsnPJMORu3eMNb9lQbRmMIUxXw0i2f7TxeTl/64
	mBqncnytXpJp/iVKy1Y75US2j0rtXuP5k9x8K8rJEXGA0tYTRKmoIDxjouoigouCwMAgR9np/QR
	3iXl778M42vQzYgVZA0bbqr8
X-Received: by 2002:a5d:6c6c:0:b0:390:ef45:1a36 with SMTP id ffacd0b85a97d-390ef451ce9mr2632223f8f.19.1740756891916;
        Fri, 28 Feb 2025 07:34:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLP76e1iRqMbRfDsApRYRZe4Bu7iVV4/N4rxk4fteRZT5/SQCoZbEvS4Kn7DAGi42tC6WQmQ==
X-Received: by 2002:a5d:6c6c:0:b0:390:ef45:1a36 with SMTP id ffacd0b85a97d-390ef451ce9mr2632198f8f.19.1740756891529;
        Fri, 28 Feb 2025 07:34:51 -0800 (PST)
Received: from ?IPV6:2a02:8070:4688:86a0::a40b? ([2a02:8070:4688:86a0::a40b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a7868sm5548287f8f.24.2025.02.28.07.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 07:34:51 -0800 (PST)
Message-ID: <a70158c3-d683-42d6-8af5-c800d51039e4@redhat.com>
Date: Fri, 28 Feb 2025 16:34:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] SKSM: Synchronous Kernel Samepage Merging
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, Olivier Dion <odion@efficios.com>,
 linux-mm@kvack.org
References: <20250228023043.83726-1-mathieu.desnoyers@efficios.com>
 <CAHk-=wgedRzDqOLhbOnvziVHZm9jtGOrT4GJEqA9etJDwTQ5Mg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAHk-=wgedRzDqOLhbOnvziVHZm9jtGOrT4GJEqA9etJDwTQ5Mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.02.25 03:51, Linus Torvalds wrote:
> On Thu, 27 Feb 2025 at 18:31, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> This series introduces SKSM, a new page deduplication ABI,
>> aiming to fix the limitations inherent to the KSM ABI.
> 
> So I'm not interested in seeing *another* KSM version.
> 
> Because I absolutely do *NOT* want a new chapter in the saga of SLUB
> vs SLAB vs SLOB.
> 
> However, if the feeling is that this can *replace* the current horror
> that is KSM, I'm a lot more interested. I suspect our current KSM
> model has largely been a failure, and this might be "good enough".

Maybe it would be comparable to khugepaged vs. MADV_COLLAPSE?

Many/most use cases just leave THP scanning+collapsing to khugepaged; 
selected ones might "know better" what to do, so they effectively 
disable khugepaged, and manually collapse THPs using MADV_COLLAPSE.

If it would be similar to that, it would not be completely different KSM 
version, just a different way to trigger merging: background scanning 
vs. user-space triggered ("synchronous").

I could see use cases for such a synchronous interface, but I doubt it 
could replace the background scanning that is actively getting used for 
existing use cases; I have similar thoughts about khugepaged vs. 
MADV_COLLAPSE.

-- 
Cheers,

David / dhildenb


