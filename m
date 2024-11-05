Return-Path: <linux-kernel+bounces-396110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2C89BC7F1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FB471F2461F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569E419F132;
	Tue,  5 Nov 2024 08:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ywj8lJAL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1618E1CCB38
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 08:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730795061; cv=none; b=uSqijSrZWiVF4H17SYZcZiKld6bo+O1RraInfzkOnNqEUjV7Wx6VeESIJAJPI4QOql39TixQgyU9osnCp8XHmIyS6kxlifj+jAaDjHNwxFSsU3vtEZO8qYoNrGaqQGJJsIODrHhiOwnpK3wS/Keqqogqa3zttQkrBJDPRZFdOQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730795061; c=relaxed/simple;
	bh=Rh9ZkFAH4IzaK/jVaOTGyRlqijEk9yFtDyBWANjG6/M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=k/+7ar0i9mGBfoejw6NnlVLqNmCzF9wwZJbaaorE0crOCSYH8R4SE76433wAIm54R1yxFMTxvuxK+0MkQV2zDPPriKKOjxb4LD1umMLe7Po+SzlWJjOcAYtvW2c0+P4n2lNPFHgz0PqIjfsbz2Z7/kaTSPD/RgfgXCTGFvEHE3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ywj8lJAL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730795058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dQUFO2XUW50DORC+SNwdJKqHhIbV1k4dr1/SWsv+/60=;
	b=Ywj8lJALTqfp+zgMWM2MNqEmFqYkfkTq5G7Q0kecMxHO4PViKarGjDTKhHoKkTDLKNRPZv
	K+1a+ZY9L67Ef9VhKXZlVcg2infYMKBIjVGc+ptrafePaVcdowYRuXagxqrwzn6WZvY/S2
	ZapyizWpbbWAsvcZmG+Ah/ycAQfshgk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-mhuHDSIUM-e3rRHlc1BDQQ-1; Tue, 05 Nov 2024 03:24:16 -0500
X-MC-Unique: mhuHDSIUM-e3rRHlc1BDQQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4315dd8fe7fso43687985e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 00:24:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730795055; x=1731399855;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dQUFO2XUW50DORC+SNwdJKqHhIbV1k4dr1/SWsv+/60=;
        b=fr1Bbvlze+FfxH8Ek6f2D++2kBd7mApMWUD7QElmKqkW2aVfG7LzqrgGbrhocGi1vI
         5kbzUros4s2/7QIY1rhol0aiS9IpwnPWZx5eTly3RoLqX0L6dDsCX3NrDv5IBvkf/FEx
         SYQwwTrDPAJPtwvu9jd1EdcIFXJXGhDWLL+Klk8nZr4kEBinbS9DV5kNaNOnJO/qYo01
         bRhqQwueJpWuHAD8+PB1h7cHEbxJQnexFUjAlCo1A2gBdIhuhG3XCx4P1EYo3xlaFME9
         QpMjMfYWohLUB3/SVF8wVdWTAMUHsWUIPx9Sbi7cmeUADXnpF/upUlH531RoiX3pJJn+
         Q83w==
X-Forwarded-Encrypted: i=1; AJvYcCXnYgGyC9L9ov/ZxWR+aeHW8WSIcsz/ftQUicfMx2gi/yrr0HrhHiJ7qWxrlZ/cT+RVSXp/ZrNTmsNcTnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQlBzJUjwKyLE66pcsHznE/dZWTndlInYXCU2x5b3NdbI60dp6
	zC+gbEoc+tFgvmmnT6i9fLs4KPsbZp6rro+Elop6Yjmo8Mqf/KZq6t5HG4uomoyTYs9cKdBhg2r
	F0QDZVx/f8P4E6hp7BacJSunYVbywQ88XfQEqs6cgnqHWATMVsw3xJq18EDmDhQ==
X-Received: by 2002:a05:600c:4f03:b0:431:4847:47c0 with SMTP id 5b1f17b1804b1-43283242c79mr150365725e9.7.1730795055511;
        Tue, 05 Nov 2024 00:24:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAHD9ZvRUyVdWRYj1zjt8UvHSRmmBipeQuJqR1A99WMPUQHDDStfowGETKywBG2QXUpxJPGQ==
X-Received: by 2002:a05:600c:4f03:b0:431:4847:47c0 with SMTP id 5b1f17b1804b1-43283242c79mr150365435e9.7.1730795055166;
        Tue, 05 Nov 2024 00:24:15 -0800 (PST)
Received: from ?IPV6:2003:cb:c73b:db00:b0d7:66ca:e3e9:6528? (p200300cbc73bdb00b0d766cae3e96528.dip0.t-ipconnect.de. [2003:cb:c73b:db00:b0d7:66ca:e3e9:6528])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5ab305sm179407195e9.7.2024.11.05.00.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 00:24:14 -0800 (PST)
Message-ID: <91c683e7-58dc-4518-94bb-884b11683895@redhat.com>
Date: Tue, 5 Nov 2024 09:24:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: count zeromap read and set for swapout and swapin
From: David Hildenbrand <david@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Barry Song <21cnbao@gmail.com>, Usama Arif <usamaarif642@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Barry Song <v-songbaohua@oppo.com>, Chengming Zhou
 <chengming.zhou@linux.dev>, Yosry Ahmed <yosryahmed@google.com>,
 Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Andi Kleen <ak@linux.intel.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>,
 "Huang, Ying" <ying.huang@intel.com>, Kairui Song <kasong@tencent.com>,
 Ryan Roberts <ryan.roberts@arm.com>
References: <20241102101240.35072-1-21cnbao@gmail.com>
 <6c14ab2c-7917-489b-b51e-401d208067f3@gmail.com>
 <CAGsJ_4wpdf6Fky7jj8O6OuLc0WTBjKXTfEqxE0cXiUjxxuLgZA@mail.gmail.com>
 <3f943f72-59d6-4124-96b2-e0bb8d7a5ebd@redhat.com>
 <20241104194024.0284288a28a71a70a3eab9b0@linux-foundation.org>
 <942f8355-4b23-4fd9-b00e-1121552d89ee@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <942f8355-4b23-4fd9-b00e-1121552d89ee@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.11.24 09:23, David Hildenbrand wrote:
> On 05.11.24 04:40, Andrew Morton wrote:
>> On Mon, 4 Nov 2024 13:32:55 +0100 David Hildenbrand <david@redhat.com> wrote:
>>
>>>> As mentioned above, this isn't about fixing a bug; it's simply to ensure
>>>> that swap-related metrics don't disappear.
>>>
>>> Documentation/process/submitting-patches.rst:
>>>
>>> "A Fixes: tag indicates that the patch fixes an issue in a previous
>>> commit. It is used to make it easy to determine where a bug originated,
>>> which can help review a bug fix."
>>>
>>> If there is no BUG, I'm afraid you are abusing that tag.
>>
>> I think the abuse is reasonable.  We have no Should-be-included-with:.
> 
> A "Belongs-to:" might make sense, for this kind of stuff that is still
> only in an RFC.

s/RFC/RC/

-- 
Cheers,

David / dhildenb


