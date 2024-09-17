Return-Path: <linux-kernel+bounces-331677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 254DD97AFE8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 14:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48065B22E00
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B5115C127;
	Tue, 17 Sep 2024 12:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvmnoU4N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056B9E57D
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 12:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726574548; cv=none; b=I1wSahtJbR4hYlS4gT9yR1yylGriSjoIfHkCaSmAKJJmwR+wtdKosffLi8hRhJ9L75QtV1YHlP3HRAsoQV6MB7LsWfCxaNsuiWLZYX0iXvkCTYOVSxpGnXhucyoDLTx7D6M2NRuYzctfjQ1t3wWWpCU91YWY+8epGsrSrEINtQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726574548; c=relaxed/simple;
	bh=DJrPMF2iMphiZujxhVwZs9FvSw2YZsoxIM2Xx5C182Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MrkVsHIbys/NU1BdCPGZQ/lRShQZXm94FJusutFfJcmhnOLKdPy4NBiEqjLY2Ao6uzVELOkNbN4x+q+Rz+Vs4ZUcAdfB4MGDh5Mhckq/uwud0leiLXxZl6nyIt91oV7sVsNg2N4yTRDXQrzO2fBFtroYYJsj76/hgOxnu00wX3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fvmnoU4N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726574546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dTizJfqYrZ1eGNFNnTVt8fMRPv3GrUVc+z4dSs5TcXw=;
	b=fvmnoU4NwlZx117AWc14S7q+SQYo+z/3AoY1S5Wg91dWSpNVCWQjTl24mWDQcB/8aO8RUq
	LTCn4yqTH8qNzVnwoNin13docU3JbweFmIVw4qgkPy7gF073rWiC7vw87/AZlTP7u9YzOj
	NqtlIxsvkMVYIkpqAJ0pBZEcyTTZ1hE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-VRZdXEr0N92T2S1crNJ5PA-1; Tue, 17 Sep 2024 08:02:24 -0400
X-MC-Unique: VRZdXEr0N92T2S1crNJ5PA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a8d34e41915so403782666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 05:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726574543; x=1727179343;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dTizJfqYrZ1eGNFNnTVt8fMRPv3GrUVc+z4dSs5TcXw=;
        b=pwMRbUpvtnRLEtJa6jhbVHNi2vum879QlcAcKuiWkEU8+MR9PRi0HDFQ5wx/lRW+yw
         WdqdOkXGu3oNRRyptZO+M83nrnjq58ZvX5zytTZqEPOEbDpboAr2m3yeIv1GCb7MB10O
         soxrDotGfAQ7ocSpjeRC9smISWNIol1e6rvmeHavt8Tt8AKSLz8MfNzFoXT/WeFDYlts
         90f3vEZ6Ml2cpUqsBBJsL3uMpJX19dMURWbp3avLzsLGRxuheJmunGiYzXLVyK7v1abX
         vY47Ai/XNDFjav5/XBRMSXgfspX1x+5kkiV1e7jqN3AvoLKZtRtiqvhP6i7UHrN1AJ1i
         cUrA==
X-Forwarded-Encrypted: i=1; AJvYcCXHC0Da+WNBpAeEGKrQbw/mxLp+v3DxXlS1jfLwmWdY9AM7m4XDX/sH2dShdKmcV0qpd24oWckD7xkBEKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDhBt2dXj6vg9Hvue/MJWR7pXbecb3zPOkKNszB4TPy+Em1uQM
	Y0kIkmIe0D5mHASFYZKrFmGD6dU+bTadAV/e58jnGg1sl89L+5SiXcXlc1FtSM6O014UU68/9hu
	ow3EV0nXeWswYty/XMhv/mJkxqKEuQZMQE+DR8AdJg83WBUFQ4D4vGNP0JBW9lw==
X-Received: by 2002:a17:906:fe04:b0:a8a:1ffe:70f1 with SMTP id a640c23a62f3a-a9029617496mr1746618666b.50.1726574543024;
        Tue, 17 Sep 2024 05:02:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/AYIL3HnAmcyaVMGU1v9PWUkTCOfJxKQ0ma5ztCblUGaRbWU1amACDso+3ibXc3mKulVbqw==
X-Received: by 2002:a17:906:fe04:b0:a8a:1ffe:70f1 with SMTP id a640c23a62f3a-a9029617496mr1746615166b.50.1726574542445;
        Tue, 17 Sep 2024 05:02:22 -0700 (PDT)
Received: from [192.168.55.136] (tmo-113-196.customers.d1-online.com. [80.187.113.196])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f44fasm435751066b.79.2024.09.17.05.02.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 05:02:22 -0700 (PDT)
Message-ID: <92f97c8e-f23d-4c6e-9f49-230fb4e96c46@redhat.com>
Date: Tue, 17 Sep 2024 14:02:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] mm: mglru: provide a separate list for lazyfree anon
 folios
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: mhocko@suse.com, fengbaopeng@honor.com, gaoxu2@honor.com,
 hailong.liu@oppo.com, kaleshsingh@google.com, linux-kernel@vger.kernel.org,
 lokeshgidra@google.com, ngeoffray@google.com, shli@fb.com,
 surenb@google.com, yipengxiang@honor.com, yuzhao@google.com,
 minchan@kernel.org, Barry Song <v-songbaohua@oppo.com>
References: <20240914063746.46290-1-21cnbao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240914063746.46290-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.09.24 08:37, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> This follows up on the discussion regarding Gaoxu's work[1]. It's
> unclear if there's still interest in implementing a separate LRU
> list for lazyfree folios, but I decided to explore it out of
> curiosity.
> 
> According to Lokesh, MADV_FREE'd anon folios are expected to be
> released earlier than file folios. One option, as implemented
> by Gao Xu, is to place lazyfree anon folios at the tail of the
> file's `min_seq` generation. However, this approach results in
> lazyfree folios being released in a LIFO manner, which conflicts
> with LRU behavior, as noted by Michal.
> 
> To address this, this patch proposes maintaining a separate list
> for lazyfree anon folios while keeping them classified under the
> "file" LRU type to minimize code changes. These lazyfree anon
> folios will still be counted as file folios and share the same
> generation with regular files. In the eviction path, the lazyfree
> list will be prioritized for scanning before the actual file
> LRU list.
> 

What's the downside of another LRU list? Do we have any experience on that?

-- 
Cheers,

David / dhildenb


