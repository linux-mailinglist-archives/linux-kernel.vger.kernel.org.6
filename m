Return-Path: <linux-kernel+bounces-368300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFA29A0DDF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D373D28528C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD6320F5B5;
	Wed, 16 Oct 2024 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LtjlC2zr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E75720CCEA
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729091810; cv=none; b=RSEocqwOfD0PNAG0EcoG5TpXbV0zrf8f9eOFyzQnL8+4bDuvck67AAG1wnbUC70EdGF8DJAsOVg2Kx9dXs8vyIqFpshnONt7tth76boWmzRrbmgPc2lw4fwzPZzjzfW2RJv4h6KmWRj/AzeFIr5oGFIHyC8ksn0nSrH+lNnN1IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729091810; c=relaxed/simple;
	bh=58KIiYGBvkzWTiADjEdlOgRX4OijCEWEURpwZFevy/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ilKAxqk8pxDjd4rzzmFEp6YBkSPluK479Jkrqnv7yeSSUaHkWBES38TqMEVsNkqhIXY/vQOX3tndud7GznlXjJf8jxAFI+LFph0MwGdmevxb3/cEhKDEaKyhUIKUJHdo0Mfdo2/oUbTf4DXR4PToQ+3y1e32ptxHj2KY59l20Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LtjlC2zr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729091807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rckCI6BcQdAYpz3FvS5gzBv3y2Neehx7nzPLfaUCfW4=;
	b=LtjlC2zrAU6iVSD3uEezx0ioMthelBNFW7dpra0h9JvhPQBaSuG7LWWKt6MRVkBfSnLHOT
	uNfniTw3fdQ6/LBsekewgB7RUpdS3e7U4qtthu8jyBBrjmzA14nHnAHS9A+Mgw/rtT+gP0
	XPGJ0q8n+DDRM4jdCVhX1LqvbKsf/os=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-MS7Ic3EoNeeMw18i4u3Xtg-1; Wed, 16 Oct 2024 11:16:46 -0400
X-MC-Unique: MS7Ic3EoNeeMw18i4u3Xtg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4313a8e81fdso13887745e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729091805; x=1729696605;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rckCI6BcQdAYpz3FvS5gzBv3y2Neehx7nzPLfaUCfW4=;
        b=jTnWVsNfADpvXSo/Mh5Mhn7MUgbs/wrAX4atkyidY8j72eSQXPnn3+QykORbXGoZx8
         Jkdyv5Did0906YP+rbm0hUctYwTl+swsR0BfSRpzyUo5WPJxa6Y5plxYbxs4jK46J3Cx
         dWLHHIESYv3d0ypgu4dXUX/caV6+xRMhRXkDVGiWN/Hz6jqsKplflo+2L9lNnULZw7WJ
         3fPQwfEGnUGmsBXq4x8fyiBYKwmEMGS94QcRVAcKrfkoVV2snXy4yKZ+2DEPAEURfsxM
         KFLTguOD+cAvf5kVvb/UvFpXm2gT9JrvQ6BKl38xp7t/oyq76U74Xr8h7HZMrqc7Bj4e
         iGRw==
X-Forwarded-Encrypted: i=1; AJvYcCVowGxdoBLp+EQgrPLjbzMKUHl2RY0EIraAa166m8V5TdWQIdXw9d9zCEoojLsxy1ZbVXdFyGbvAXdtLCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaeTqlRuiHcJRUej8A2azFyP12Ke6ZjlJOwKEa/Oa1j+mZ17Ev
	8qZFihWWYpLV8SiAOPoTX39XxZ9ftsUUHAlHorOJy5UYj7/MT6p0PCPdJm2oH3rp6qGT50oKT86
	WiJ3IzWeTCoqpOx7K5giuDZcDgctGV5gG3GDOE2/LfC5tUTEkZCBcJ7CL10wQ0Q==
X-Received: by 2002:a05:600c:444f:b0:42f:8515:e479 with SMTP id 5b1f17b1804b1-431255d4e6cmr114950705e9.4.1729091804898;
        Wed, 16 Oct 2024 08:16:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhhGcNrxVmkNJEtywMCqvJOFcBc8Fpq5HqvDzLlA5aNRCPuGv5s1RDNR37gx+mmV9Y0mGGVw==
X-Received: by 2002:a05:600c:444f:b0:42f:8515:e479 with SMTP id 5b1f17b1804b1-431255d4e6cmr114950495e9.4.1729091804477;
        Wed, 16 Oct 2024 08:16:44 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:d000:3a9:de5c:9ae6:ccb3? (p200300cbc74bd00003a9de5c9ae6ccb3.dip0.t-ipconnect.de. [2003:cb:c74b:d000:3a9:de5c:9ae6:ccb3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4315069032asm24478235e9.0.2024.10.16.08.16.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 08:16:44 -0700 (PDT)
Message-ID: <1fd0dae8-b04a-42b9-9d6f-32100610ef76@redhat.com>
Date: Wed, 16 Oct 2024 17:16:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 00/57] Boot-time page size selection for arm64
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Greg Marsden <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>,
 Donald Dutile <ddutile@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241014105514.3206191-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> Performance Testing
> ===================
> 
> I've run some limited performance benchmarks:
> 
> First, a real-world benchmark that causes a lot of page table manipulation (and
> therefore we would expect to see regression here if we are going to see it
> anywhere); kernel compilation. It barely registers a change. Values are times,
> so smaller is better. All relative to base-4k:
> 
> |             |    kern |    kern |    user |    user |    real |    real |
> | config      |    mean |   stdev |    mean |   stdev |    mean |   stdev |
> |-------------|---------|---------|---------|---------|---------|---------|
> | base-4k     |    0.0% |    1.1% |    0.0% |    0.3% |    0.0% |    0.3% |
> | compile-4k  |   -0.2% |    1.1% |   -0.2% |    0.3% |   -0.1% |    0.3% |
> | boot-4k     |    0.1% |    1.0% |   -0.3% |    0.2% |   -0.2% |    0.2% |
> 
> The Speedometer JavaScript benchmark also shows no change. Values are runs per
> min, so bigger is better. All relative to base-4k:
> 
> | config      |    mean |   stdev |
> |-------------|---------|---------|
> | base-4k     |    0.0% |    0.8% |
> | compile-4k  |    0.4% |    0.8% |
> | boot-4k     |    0.0% |    0.9% |
> 
> Finally, I've run some microbenchmarks known to stress page table manipulations
> (originally from David Hildenbrand). The fork test maps/allocs 1G of anon
> memory, then measures the cost of fork(). The munmap test maps/allocs 1G of anon
> memory then measures the cost of munmap()ing it. The fork test is known to be
> extremely sensitive to any changes that cause instructions to be aligned
> differently in cachelines. When using this test for other changes, I've seen
> double digit regressions for the slightest thing, so 12% regression on this test
> is actually fairly good. This likely represents the extreme worst case for
> regressions that will be observed across other microbenchmarks (famous last
> words). Values are times, so smaller is better. All relative to base-4k:
> 

... and here I am, worrying about much smaller degradation in these 
micro-benchmark ;) You're right, these are pure micro-benchmarks, and 
while 12% does sound like "much", even stupid compiler code movement can 
result in such changes in the fork() micro benchmark.

So I think this is just fine, and actually "surprisingly" small. And, 
there is even a way to statically compile a page size and not worry 
about that at all.

As discussed ahead of times, I consider this change very valuable. In 
RHEL, the biggest issue is actually the test matrix, that cannot really 
be reduced significantly ... but it will make shipping/packaging easier.

CCing Don, who did the separate 64k RHEL flavor kernel.

-- 
Cheers,

David / dhildenb


