Return-Path: <linux-kernel+bounces-277861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 362B594A76C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A82BB26B8D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14F91E4EEB;
	Wed,  7 Aug 2024 12:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJfKLEGZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFF3376E6
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 12:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723032241; cv=none; b=X8BSKUzbsHn0KstL0xgbRy08/M1oERN4QyiBgJDz82grdWjeiQJal+4laOnjxKBOnXuXsf/wcLnWjnbjkry7Z/m/FHzpf8x2JSJs+di8PriR0vL6oLBQrxEK6I+MZGOTnJAIThxsii7pO/EnDEGz6YM2fuaEE/MkO5urrA1OTzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723032241; c=relaxed/simple;
	bh=ACWINonOV7jXMI5qO4yAb5gUW9lEvSCz7Jx5tZ2ZrXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e+2CjRzkhmxp615NjsxXsmtlJJAkL3Q9SiuGlEOXI5vkNgxDz063Tq5GzlzEVPbJ9msvWFhZMDLqLCpql8fzDKoS8z8Y59QrjANa9COo8lRBLsEHVMDZYxOdsX9JOE73XlHMIwxABIBK6m6Cd2VVCpzk8MC0U1YKMw4VYLZluHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IJfKLEGZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723032238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3yKjh7cHIqTwQc0esXiUaqFIXadhVQzrS8A1fogarFo=;
	b=IJfKLEGZhJw6wWat01SMA9ZmOTvH/0upNY+J1gXK+cVUNYBrMJIU1gVulOStfof8HVuVhv
	28UflVDsDxzH/TXDUngz94KesD7+M76k8J9i4GU+2SMWeoD2ZOf7tNGMXrBVD6hc4R2SHE
	TYKbswJCrpT/zvcTKLSa0DcA5ayUELU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-4AnZoyGYP_iYUw801KNX_w-1; Wed, 07 Aug 2024 08:03:57 -0400
X-MC-Unique: 4AnZoyGYP_iYUw801KNX_w-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2f03d84f79bso19313691fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 05:03:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723032235; x=1723637035;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3yKjh7cHIqTwQc0esXiUaqFIXadhVQzrS8A1fogarFo=;
        b=KyGWKLvARpRY1h11Un2YmqH5D3cppFjv7kOUTdVFJgMxvUuGIwxs/oap1r5VtQF5JI
         xTAUvdChZV14hVsYr3N0kGkHTatmAAKrjc3zWzWmzAzOYay5V6nBkGA+Ypy5zGpNQjKT
         df4FBTFjraEOtXeStnoH5kx7n5sT2+wxL/MfPuYbqUzbW0cp9L4HYiJY48ZVSCKfa3WO
         gJyjT29G3YS3uQ8elbJOEU8jCEa93NU9pL0g3IsZPepkCj/HzrXJ/UdA5r/W6jHsORLq
         9vEVKWhK2uIPAWP4Bq+WOlzcy32Oi5ovZV78v/hflzL6LZMe2SZ0Z1ZycK7FTuDRCX3W
         A2/g==
X-Forwarded-Encrypted: i=1; AJvYcCUxZtkd45NtHq/Mr5CfLwWfMnfnJoF5dWCboyU5ZRgJjBm6on27w/e5gZtD85TUvooDNTB2xLj+w+X1Gq8ftgK8gXJwB76SXkWSzZof
X-Gm-Message-State: AOJu0Yx1l0zPSCMKXRB/dLaOYNDBz9RQWZ1SCNXvSlNO/pzUUGclBHH0
	Old1eHZ9K8B2+eSf8pmZ63vTsoz6J6mmkUNNfvXSXs6Z5U/9pRcG2H0CwOIEPpOqQLBVFjCLV1n
	8sXItKuKI+g10CNhXUFvnwVYRODugi63j5RFDtFSkSk2SuZlnSAUeSjqwIBXGxchb4GUaRQ==
X-Received: by 2002:a2e:91d5:0:b0:2ef:26ec:44ea with SMTP id 38308e7fff4ca-2f15ab3507emr118990441fa.39.1723032235444;
        Wed, 07 Aug 2024 05:03:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWuRa3qy7iQNpS/NzL7zESnDWOHWFrxO98N86VEQIKq7YJ+/oAAgCct9NJeyygYfi/xup4IA==
X-Received: by 2002:a2e:91d5:0:b0:2ef:26ec:44ea with SMTP id 38308e7fff4ca-2f15ab3507emr118990231fa.39.1723032234872;
        Wed, 07 Aug 2024 05:03:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:1a00:df86:93fe:6505:d096? (p200300cbc7081a00df8693fe6505d096.dip0.t-ipconnect.de. [2003:cb:c708:1a00:df86:93fe:6505:d096])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42905796a4csm26589385e9.1.2024.08.07.05.03.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 05:03:54 -0700 (PDT)
Message-ID: <96439797-355e-493f-b652-1d933c4739b8@redhat.com>
Date: Wed, 7 Aug 2024 14:03:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/sparse: return right away if sparsemap_buf is null
To: Leesoo Ahn <lsahn@ooseel.net>, Mike Rapoport <rppt@kernel.org>
Cc: Leesoo Ahn <lsahn@wewakecorp.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240726071023.4078055-1-lsahn@wewakecorp.com>
 <ZqY81pf9dvl6mvg9@kernel.org>
 <CANTT7qg7JRZR0DpaUg_YFVTrbBDE9hrb_6bv4XDQ_3QXcgY_vw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CANTT7qg7JRZR0DpaUg_YFVTrbBDE9hrb_6bv4XDQ_3QXcgY_vw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07.08.24 05:21, Leesoo Ahn wrote:
> 2024년 7월 28일 (일) 오후 9:43, Mike Rapoport <rppt@kernel.org>님이 작성:
>>
>> On Fri, Jul 26, 2024 at 04:10:23PM +0900, Leesoo Ahn wrote:
>>> sparse_buffer_fini(..) takes the following actions even though the value of
>>> sparsemap_buf is NULL,
>>> 1. calculate size of sparsemap buffer (which is meaningless).
>>> 2. set sparsemap_buf variable to NULL (although it is already NULL).
>>>
>>> These steps are unnecessary if the variable, sparsemap_buf is NULL.
>>>
>>> Refactor the function to return right away if the variable is NULL.
>>> Hence, it doesn't need to take further actions.
>>
>> sparse_buffer_fini() is called a few times on init so saving a jump (if at
>> all) does not worth the churn.
> 
> Fair enough.
> 
> Any related to refactoring codebase will be unlikely to be taken into upstream??

Any reasonable cleanups or reasonable optimizations are welcome.

Micro-optimizations that effectively add code/LOC, not so much :)

-- 
Cheers,

David / dhildenb


