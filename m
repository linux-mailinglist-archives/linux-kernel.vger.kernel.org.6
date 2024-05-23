Return-Path: <linux-kernel+bounces-187981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8838CDB82
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 22:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754CB286146
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 20:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096A684E09;
	Thu, 23 May 2024 20:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENHvKpTL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74D584DF7
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 20:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716496833; cv=none; b=raL7pv9ca8L7RZTtQn4pZ71sHHL7SfU3CQaLkAhSQX06rBV3FlDJFzuzrJYUWHIwtrKKMKB29cbkQGOogzdGpqnw6+3ENp6RrryQjxNRmfbUxnMDMmQQjqds9WHFjLFYVNyyeMpkEnz28c/F0BeG19IsTnD23u516D4jwGuUjpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716496833; c=relaxed/simple;
	bh=ltO5em4AVQnYhKAyiqcASG2EnbQQabcM2h0UzoDpUeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SLyg+RQ1eMQ7pkmPHkqi6pdSEC/JN1btJxR3BgO92aAlLYOWKTwUHt+6Tz4qoQs4NWT+qaEG+nRMIqM07D71P5du2BO3AP++BPNJjC3GN8K5naKfi1zEdlsTmcf0q1++KeG0kx1nhz8VWLyXB9s0cN+9ORRUIae1lCo3sBP2s3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ENHvKpTL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716496830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HMRwhM4rpgDOdhtnbcfTstE8zL3QawjuI32cVW7/W+w=;
	b=ENHvKpTLd0bouzPVkZIYjYu4+jFmt4WnWQqiEeCXcXHGCsAYcJfRw+5FsPn0oGI83CL+ga
	lNd9EHqfg6wNX+yr3PEyuleD1gIBxeeoRnbx9Ah+LnRoTr5c1SUM9qatgKOVSJOmkm9zIu
	AX3j15klDOcYhbnx4QdsFLa0mftc8sc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-3P5Rqj-BObiD5KcQVLl1kw-1; Thu, 23 May 2024 16:40:29 -0400
X-MC-Unique: 3P5Rqj-BObiD5KcQVLl1kw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-35559d305e3so25025f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 13:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716496828; x=1717101628;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HMRwhM4rpgDOdhtnbcfTstE8zL3QawjuI32cVW7/W+w=;
        b=S/II9BinzlJ94vVs1AEZzn8kZmzuVCYzmfXDoP+kgQrGdWET4zQeV2Tzz6kxPkSyqD
         mCMOeDvAhOvuwPMA0DTzgRXuGJGXiV2lBo73RBvZj9AETNiqzKJh/Dq4cow71MlEoZVP
         WbjKqfxNf4EI7vUf1RY4NsaZphFulWnn5jJsnWUryWXOfpK7izJrjRAi0zEwNoGluBAf
         q1gujEdxP0xpqZB7RO0CB4GkXrXLJllYXUOjNhmzlpaYk9bpxctALBUpD4EgoKNobdkR
         d7NuXVl0RNJ/XSa+OsbDvN4N4zu7HqHzI+WBkgfo9slDO5llBgAGAKI+dVsySLSO2ToD
         mBbg==
X-Forwarded-Encrypted: i=1; AJvYcCXqShqprWjXwHTIDg/+6EaLCvv8PeqaNQhppWdVeZNb5npArm0h51XWanWsy2JxiStnxzIMk2ZGu1kQ9m7D5vH2lT0S+7vvxZgWp9qJ
X-Gm-Message-State: AOJu0YxFhAdPYFhsrdORy4h9x9MDSlR7bomj/d29X/fa/zosKgqSb5VT
	FYVVMWMArdDM3UVqYm0kKAmNzaOQZ3dT9tDMG+IjWueFOJBxWeOBYbz9EWThBg7oRcMhmAmVSCy
	/us9FuQ7zVeggm/pPobyaxCvpqi4QU04ntdLiMfqAmhxRVPMlU8kyLEkmmxqV7g==
X-Received: by 2002:adf:f183:0:b0:354:f5f2:198b with SMTP id ffacd0b85a97d-3552fdc828bmr88015f8f.46.1716496827854;
        Thu, 23 May 2024 13:40:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIlHlYs/IzRViA3Kqxz4toDkVk96XetDA5NIaYKisMefLa6AGLghVkkUDvpvwpKUhwSEnXaA==
X-Received: by 2002:adf:f183:0:b0:354:f5f2:198b with SMTP id ffacd0b85a97d-3552fdc828bmr88004f8f.46.1716496827449;
        Thu, 23 May 2024 13:40:27 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:5f00:c949:6700:cce1:e60b? (p200300cbc7175f00c9496700cce1e60b.dip0.t-ipconnect.de. [2003:cb:c717:5f00:c949:6700:cce1:e60b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-355049af3d9sm514554f8f.76.2024.05.23.13.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 13:40:27 -0700 (PDT)
Message-ID: <d551d1cd-a02f-42aa-9de2-10ff7757224c@redhat.com>
Date: Thu, 23 May 2024 22:40:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftest: mm: Test if hugepage does not get leaked during
 __bio_release_pages()
To: Andrew Morton <akpm@linux-foundation.org>,
 Donet Tom <donettom@linux.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Tony Battersby <tonyb@cybernetics.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ritesh Harjani <ritesh.list@gmail.com>, Mike Rapoport <rppt@kernel.org>,
 Muchun Song <songmuchun@bytedance.com>, stable@vger.kernel.org
References: <20240523063905.3173-1-donettom@linux.ibm.com>
 <20240523121344.6a67a109e0af2ba70973b34b@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240523121344.6a67a109e0af2ba70973b34b@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.05.24 21:13, Andrew Morton wrote:
> On Thu, 23 May 2024 01:39:05 -0500 Donet Tom <donettom@linux.ibm.com> wrote:
> 
>> Commit 1b151e2435fc ("block: Remove special-casing of compound
>> pages") caused a change in behaviour when releasing the pages
>> if the buffer does not start at the beginning of the page. This
>> was because the calculation of the number of pages to release
>> was incorrect.
>> This was fixed by commit 38b43539d64b ("block: Fix page refcounts
>> for unaligned buffers in __bio_release_pages()").
>>
>> We pin the user buffer during direct I/O writes. If this buffer is a
>> hugepage, bio_release_page() will unpin it and decrement all references
>> and pin counts at ->bi_end_io. However, if any references to the hugepage
>> remain post-I/O, the hugepage will not be freed upon unmap, leading
>> to a memory leak.
>>
>> This patch verifies that a hugepage, used as a user buffer for DIO
>> operations, is correctly freed upon unmapping, regardless of whether
>> the offsets are aligned or unaligned w.r.t page boundary.
>>
> 

Two SOF, is there a Co-developed-by: missing?

> You have stable@vger.kernel.org in the mail headers, so I assume you're
> proposing this for backporting.  When doing this, please include
> 
> Cc: <stable@vger.kernel.org>
> 
> in the changelog footers and also include a Fixes: target.  I'm
> assuming the suitable Fixes: target for this patch is 38b43539d64b?

This adds a new selfest to make sure what was fixed (and backported to 
stable) remains fixed.

-- 
Cheers,

David / dhildenb


