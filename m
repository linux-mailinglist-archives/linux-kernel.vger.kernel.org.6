Return-Path: <linux-kernel+bounces-197750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C8C8D6EA6
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 09:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E951C21D82
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 07:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177AB17C66;
	Sat,  1 Jun 2024 07:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GplecGl4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821C314A84
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 07:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717226545; cv=none; b=apbEhR0v/p8CvpxnKWvZzrxpuunoQ8J1lki6cFbOFx4EavF4nVFc5ISN4YKU5sZN12XxaQyr9Ic+gBCPTzyylWcscFp1ohLxQUDIF/rGo9kAoqYugZlOLsk/8JqgNY4PaWKlY1A6+Wy6ZBnP64/EQUgxIelIxQ9Pp03fKBm/jMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717226545; c=relaxed/simple;
	bh=LsRsZtYO13MD2ucPqB67x4xGZ+BMGCWLS2hD8+IuJvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DXCreVOGPxHCPoSloWd+NDwW+vJ4L5ZW+Icgoqf6DK3oiZlwUoY9ayBPsYDRDzzW91eYoUEClwygDksKlP0a7eROg5MTmjuV0jQ5W67UwNt810gL4bGkVBeWcz6m5AJNDGXrNQnQhyj5S27kvXABKM//O5YL4z0Jc9Mf6hxylMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GplecGl4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717226542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AUoX/YBmGIr5899bRwjfMZUG3y2trLqiYLXDozpLOJE=;
	b=GplecGl41o+YLMfTIBcjZFUAAdVB4sP7NboX6AHpLj8a2vz8DXpPyZZtOrWuR5klToYdqg
	BcXQX3ZYrADMOjh/I1OTs8TL+xzayorXkGgX3SblXKcXItOogVl9anGrMiQMwupqr2HKCs
	iJXkqX6x7XtYIYewf6rBemol+K6jQHs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-0GdR0GnmM7OVHJSgexBHPQ-1; Sat, 01 Jun 2024 03:22:21 -0400
X-MC-Unique: 0GdR0GnmM7OVHJSgexBHPQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4212bf90891so9956305e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 00:22:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717226540; x=1717831340;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AUoX/YBmGIr5899bRwjfMZUG3y2trLqiYLXDozpLOJE=;
        b=qfkS62KJDb6Hpz9qfQOEM4GBe+82GtpHDzkbEfb4t609OhKxW3KD26rYmimU8sOoDN
         tl0CbYjXxsio8gpz9I7HZ2alsgTShy1txFmr5AsXUmDfnABn/d6mwFZOQXuumBUFbplL
         pwpd8/iaPtdnNQ3LaVXg5nNvZucfBalVi4qJgm865M9iPpLx8uug8dWKr8Q7UX0L/c5a
         vHvzusf6ZfvNx4+QOz7AbT2HeZIDAd2mgRi/yFtnOXj98zPbHzml8B3yDFFWqRQY2IAf
         8hfdqMmbt98YkVBfkLeGTNQl463lCBvV1kAiPQmBbJRTNPCWf8hvcu1P5S+LoWuvJOaY
         u67A==
X-Forwarded-Encrypted: i=1; AJvYcCWWXUks/GrOt3uyBpUY7uSa2FNkBeb0BcE/ah1QD6iyOtlXXTx4tkKAbkYPUIgNTl6BS95JO2luxSlw+PFh76GG67p6TPzjhFr9zb0+
X-Gm-Message-State: AOJu0YwUeCj2mmjOkuVmgUp6/Ew6yK4bC0v11rEIy6cB8LTMYhZs4TpX
	XEV6161/deVy9IHY3OEEm3K6TIS/U4U4X3Vgv2B9SaXFvcBVSt7ervu5O5pnER0LUhVU6Cs4I/d
	EtimCNLh6qCbiMmbKpP5FJebO5ZFmoqHVHs+PHHgIVRNtyW5ddln8Y0nyVAWwMg==
X-Received: by 2002:a05:600c:190b:b0:41b:e406:5ae6 with SMTP id 5b1f17b1804b1-4212e04762dmr26289085e9.9.1717226539837;
        Sat, 01 Jun 2024 00:22:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9y4VHAQJj9drZSofSZ7oBxxEVygT+efO4n5HkNPTL/17OCl3vW8BLe/ir8zvtNDBpbbAsfQ==
X-Received: by 2002:a05:600c:190b:b0:41b:e406:5ae6 with SMTP id 5b1f17b1804b1-4212e04762dmr26288925e9.9.1717226539420;
        Sat, 01 Jun 2024 00:22:19 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71f:b300:1d59:157a:ba27:f7e0? (p200300cbc71fb3001d59157aba27f7e0.dip0.t-ipconnect.de. [2003:cb:c71f:b300:1d59:157a:ba27:f7e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b84ae09sm46058795e9.18.2024.06.01.00.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jun 2024 00:22:18 -0700 (PDT)
Message-ID: <26dc4594-430b-483c-a26c-7e68bade74b0@redhat.com>
Date: Sat, 1 Jun 2024 09:22:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 09/12] mm: implement LUF(Lazy Unmap Flush) defering
 tlb flush when folios get unmapped
To: Dave Hansen <dave.hansen@intel.com>,
 Byungchul Park <lkml.byungchul.park@gmail.com>
Cc: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, kernel_team@skhynix.com, akpm@linux-foundation.org,
 ying.huang@intel.com, vernhao@tencent.com, mgorman@techsingularity.net,
 hughd@google.com, willy@infradead.org, peterz@infradead.org,
 luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, rjgolo@gmail.com
References: <20240531092001.30428-1-byungchul@sk.com>
 <20240531092001.30428-10-byungchul@sk.com>
 <fab1dd64-c652-4160-93b4-7b483a8874da@intel.com>
 <CAHyrMpxETdVewTH3MCS4qPyD6Xf1zRUfWZf-8SCdpCFj2Pj_Wg@mail.gmail.com>
 <f17f33e8-1c1f-460f-8c5a-713476f524a3@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <f17f33e8-1c1f-460f-8c5a-713476f524a3@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.05.24 23:46, Dave Hansen wrote:
> On 5/31/24 11:04, Byungchul Park wrote:
> ...
>> I don't believe you do not agree with the concept itself.  Thing is
>> the current version is not good enough.  I will do my best by doing
>> what I can do.
> 
> More performance is good.  I agree with that.
> 
> But it has to be weighed against the risk and the complexity.  The more
> I look at this approach, the more I think this is not a good trade off.
> There's a lot of risk and a lot of complexity and we haven't seen the
> full complexity picture.  The gaps are being fixed by adding complexity
> in new subsystems (the VFS in this case).
> 
> There are going to be winners and losers, and this version for example
> makes file writes lose performance.
> 
> Just to be crystal clear: I disagree with the concept of leaving stale
> TLB entries in place in an attempt to gain performance.

There is the inherent problem that a CPU reading from such (unmapped but 
not flushed yet) memory will not get a page fault, which I think is the 
most controversial part here (besides interaction with other deferred 
TLB flushing, and how this glues into the buddy).

What we used to do so far was limiting the timeframe where that could 
happen, under well-controlled circumstances. On the common unmap/zap 
path, we perform the batched TLB flush before any page faults / VMA 
changes would have be possible and munmap() would have returned with 
"succeess". Now that time frame could be significantly longer.

So in current code, at the point in time where we would process a page 
fault, mmap()/munmap()/... the TLB would have been flushed already.

To "mimic" the old behavior, we'd essentially have to force any page 
faults/mmap/whatsoever to perform the deferred flush such that the CPU 
will see the "reality" again. Not sure how that could be done in a 
*consistent* way (check whenever we take the mmap/vma lock etc ...) and 
if there would still be a performance win.

-- 
Cheers,

David / dhildenb


