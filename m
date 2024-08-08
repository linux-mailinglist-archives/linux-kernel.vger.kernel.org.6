Return-Path: <linux-kernel+bounces-279070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4264794B89B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A54BAB217F4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE151891C3;
	Thu,  8 Aug 2024 08:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X/ef6wPm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A858013CA8A
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 08:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723104633; cv=none; b=IV44hqLIj6Fe7463JKS+jU6BjhhUgbnYrkhEk5EZPnAnvDqSbe1aeGPCaIM7DpPIlCOjGYeoKK9zcwPxdzGVXaTHID8S1POUV5ZLGWH/IMlQYbMrDWBw4UrUVN9ZD3zXM4FQj4ZqSjXP/vpO+TE9etk+JxdJVXQoH84HGYvE8wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723104633; c=relaxed/simple;
	bh=gS03c8L4Br7kqJ0FBcylqY2gUGQivWm3ynHkwI3GMCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NBYEtIauTjuvzadi7uuaDwdq2GBwWe19dCEOlrSVeK2vB/J2lBfoH41SWlUDOJe2oJbRVapXpTiH9ExbqdGB3EDmrfHRFEHsOUtMRwL4bHOlehZ7wq3njr4prKcS0/ZWJixh/dZmQc/Yqetz3lGdBPzg3NOXrF6cpSXkBqOqlPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X/ef6wPm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723104630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IZOKtfV/4youKQKE4PG+0p4dlew66jnamMTdwNpcUh4=;
	b=X/ef6wPmymJ/oZ29iW9d6zFwtwHT9Ty13meQiE5Pt928rrw6YuYEnk9ooNk+UrEf949KSE
	B/xlAk5zieGd09y6+ZU4uOKOV7u55tdXpfbA7V5En+aiQfGNq/VO2avn++19V5PwB8/DEX
	GJJeBJM3Sze5ozlKZr79Vl6vQSlpOOw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-UFr8ovxXPFKm2Ba07fJt7Q-1; Thu, 08 Aug 2024 04:10:28 -0400
X-MC-Unique: UFr8ovxXPFKm2Ba07fJt7Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-428e48612acso9084255e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 01:10:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723104627; x=1723709427;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IZOKtfV/4youKQKE4PG+0p4dlew66jnamMTdwNpcUh4=;
        b=EDYYZJsr51NcUwd6och3DGUIykHVVRDHv26RleHl6ojO47jhKOuub3w0O0ZCqc9M3A
         nB0pBoO0H7xE2hHS9B0KZf1O5ZfKFxSRioNNEQ/OJ+CY9nYVdzj1crdVbLUNtVgDL/Lv
         iy+DC4NZXFInND//0is/yPCN5nO7mWADfEb9Qhr8v2sSTrymNx39xlmDyFdCoiGKHdHG
         wnrNgNKqvAAsTTUbcD8TWzaCMyuwWap3TlBjvnOVA3wfzxJhiUDMc2Eo/Steh+1xCWKB
         rhSHjyJb4dW+IDqKRFfmOOlR3i59MfvB0atWH0TFTDdrdwnzsWBvDTetZgAE8/vOBfz2
         bRzA==
X-Forwarded-Encrypted: i=1; AJvYcCXLxY7xktn7pjRORJuX9WtQ2/JUB39t84gdT+J+590YFWaCxa/SkIv2Mly8a2UwUcXgDds/s37n9GSUMGT9z5+qUlJzXs0pB0WyGFcP
X-Gm-Message-State: AOJu0Yx0oyPgQ/j8LVH936h8F3v/7QNExS9yJ9a3e4MxnZo3H0K9qccd
	q8Z9CbMEm8JqLsn/PHs9GxP8Y5JOjL3YEkHB16hwUiyFxKTaKNrwikujLLrnAXpObib2sfw8SoS
	wUJ97l7YH26LamuryAD5ZohalyQBdFPqgMluydEOChJfkoBeSi7jNt+VmCo+Phw==
X-Received: by 2002:a05:600c:45cb:b0:426:5e8e:aa48 with SMTP id 5b1f17b1804b1-4290af12dfdmr13366085e9.22.1723104627523;
        Thu, 08 Aug 2024 01:10:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxN6qNl6UlFXvnE+K8ZEpnOSBzULcVL7ISHO1sfn2HUAE1cDsohRfMX5Atopuw8Q7heP2zaQ==
X-Received: by 2002:a05:600c:45cb:b0:426:5e8e:aa48 with SMTP id 5b1f17b1804b1-4290af12dfdmr13365825e9.22.1723104627054;
        Thu, 08 Aug 2024 01:10:27 -0700 (PDT)
Received: from ?IPV6:2003:cb:c713:2a00:f151:50f1:7164:32e6? (p200300cbc7132a00f15150f1716432e6.dip0.t-ipconnect.de. [2003:cb:c713:2a00:f151:50f1:7164:32e6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c7a357bsm9697425e9.43.2024.08.08.01.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 01:10:26 -0700 (PDT)
Message-ID: <7d7dd1d2-0c5f-49d4-b3ca-39115f67d2d8@redhat.com>
Date: Thu, 8 Aug 2024 10:10:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mm: rename instances of swap_info_struct to
 meaningful 'si'
To: Barry Song <21cnbao@gmail.com>, Chris Li <chrisl@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hughd@google.com,
 justinjiang@vivo.com, kaleshsingh@google.com, kasong@tencent.com,
 linux-kernel@vger.kernel.org, ryan.roberts@arm.com, v-songbaohua@oppo.com,
 ying.huang@intel.com
References: <20240807215859.57491-1-21cnbao@gmail.com>
 <20240807215859.57491-2-21cnbao@gmail.com>
 <CACePvbV5nxGz=gPKZLzZ_nF-Wzxy_4bXFw-t40rsmA0zk=irCg@mail.gmail.com>
 <CAGsJ_4z=sCyYU9z-HGN=G3wDkoEFrXPXm9nwPnqJhjvjHjufTw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4z=sCyYU9z-HGN=G3wDkoEFrXPXm9nwPnqJhjvjHjufTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08.08.24 02:21, Barry Song wrote:
> On Thu, Aug 8, 2024 at 12:01 PM Chris Li <chrisl@kernel.org> wrote:
>>
>> On Wed, Aug 7, 2024 at 2:59 PM Barry Song <21cnbao@gmail.com> wrote:
>>>
>>> From: Barry Song <v-songbaohua@oppo.com>
>>>
>>> "p" means "pointer to something", rename it to a more meaningful
>>> identifier - "si".
>>
>> Hi Berry,
>>
>> I am fine with the reason for renaming it to something more
>> meaningful. On the other hand this will create a huge conflict on the
>> next iteration of the swap allocator series. There is not much urgency
>> in the renaming variable, right? Just try to figure out a way to
>> coordinate it better. As it is, I am not sure how to handle the next
>> refresh of swap allocator series, should I revert the rename or submit
>> a refresh of patches with rename conflict resolved, effectively foldin
>> the rename patch.
> 
> right, it is not urgent. if you are going to make another iteration
> for the swap allocation series. I am perfect fine that you can add
> these two patches into your series? it should be fine as this patchset
> obviously depends on Kairui's and Your work.

If it can be resolved within 5min of merging I think we shouldn't bother 
about delaying this.

I assume it can be resolved within 5min of merging ;)

-- 
Cheers,

David / dhildenb


