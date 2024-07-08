Return-Path: <linux-kernel+bounces-244877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B327792AAC3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 22:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD12628153C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 20:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCBC146D53;
	Mon,  8 Jul 2024 20:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MzzOQvHu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FF938FA5
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 20:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720471837; cv=none; b=TCYu+bGX1unSe1I+wuQ5JKg1iMj+3/ULp5/D65wlteCAU7F43j3Qlq9Ju7fTyB+EaTQKYaAqOqgyqGcUiDux4kSqyYmBO0iXdYMPniYIFzaSQWWZAe4SXY0sKbgk7f8IgPDUmboj6dDug6y+fVipvdX9Ul8eZxcdlrujJ4rrCK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720471837; c=relaxed/simple;
	bh=x6SXe8X+r2t9DP9tnD/wGWVHCLmHzgk3z5xVT1TFKN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a9iYC310/JT3SKpGhv8QYLldtSduz2m1wXznHaPDqC3h/Z+I49VKSq0boMuAGKqVHSVpYrg7HcEHlgMg3NFdyyBfD1Zl7hMSF+OnSQpwGrnlSoHC/arJjH3qf/ORveDYHiyb7IykwaKkKalfPK9z98zEZsrfELBVD7XEMytGdn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MzzOQvHu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720471834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=21FSmDblZNftZJXSTYoJSkCrLdlQhBfb2VdBCJvg3Zo=;
	b=MzzOQvHuzx3vi+otzvYBvOJ/AMdz8a7VPfBfolFMpFSDNUXgXI3SS9vIm+dCMNorf24HnG
	wQo71x+AH6R18eM6FBEniaMsTnOYBQjAIJOrCFyEipHDrMEi274p/HBXTSe8vO3C5UAL6R
	PCkul58j6qtCah1RECGXhUY7JzSnXw8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-O_bZ4K3nNAWGerQz-try_g-1; Mon, 08 Jul 2024 16:50:33 -0400
X-MC-Unique: O_bZ4K3nNAWGerQz-try_g-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4266945770eso10263515e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 13:50:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720471832; x=1721076632;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=21FSmDblZNftZJXSTYoJSkCrLdlQhBfb2VdBCJvg3Zo=;
        b=mCeoDZtra8odCYen5l4a1nTUyJR5FP0Y7jAnFMOa7qyW965jPRsGsc5fDbQ7eWKSY6
         7ti2H9jvBsINzJQzR0be/sp6vXOzTqsrIBCCb/e67ylt6aNESZy3A/nBGf1dt1xSXGPG
         clZH+q2ij6S9bx770r6kg8RcjnITYOpKY9tu4ZsG1wMx8SsbOuauDgJA/IH8ESDBqsG/
         dXLdWPltgVVD6+0n5L4uCVTbGCSXr/EBAQI4RyBgaLJqjLcdH4xznPwBRd5zk5TCbYJu
         +Oh7hDq9kpF70w1EYTB5WOHC+cqRRxuUKFj1A3736iuXmAu7Nr4JhlDxIvRjtky818Ev
         LuvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWoGUjFP1A1eOYBpwJ57fgqfTrjqOFOcb4i8eQX6e57eRTXxc/FFaO8hxAtlmvnzBHj4pbQOKpfFgfmxO+btP9EFV2SVbhxqlYjlGN
X-Gm-Message-State: AOJu0Ywp3anNyG2EqNtKrnyNVUTCLNU2QcipGMe+DhXLJ4E8rwVFar9C
	3uV0SS7NYfbeS6++mb3GMPTwV46l+1El0dluyTCIY2qcuKfZYFA9oJCOhuIQU22wcpuU84G5vt6
	xmwLe5WZmHgfMhv4oCaH2Wfj8B8DdG9U635y8qrV/qmH6fzd8t3pOE1P375d/Kg==
X-Received: by 2002:a05:600c:5354:b0:425:649b:60e8 with SMTP id 5b1f17b1804b1-426707e31b9mr4097865e9.18.1720471832264;
        Mon, 08 Jul 2024 13:50:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtxbpqTayz8+tqxhqDfKyeA6P7Tebp5iyqPQHQc68t4qPt882CDQY4q8lmd/xMxLNHU5VH+w==
X-Received: by 2002:a05:600c:5354:b0:425:649b:60e8 with SMTP id 5b1f17b1804b1-426707e31b9mr4097745e9.18.1720471831835;
        Mon, 08 Jul 2024 13:50:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c744:2200:bad7:95bd:e25e:a9e? (p200300cbc7442200bad795bde25e0a9e.dip0.t-ipconnect.de. [2003:cb:c744:2200:bad7:95bd:e25e:a9e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f7361b5sm11232735e9.29.2024.07.08.13.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 13:50:31 -0700 (PDT)
Message-ID: <10b201b1-53d3-4f62-be8e-996aa95d2b99@redhat.com>
Date: Mon, 8 Jul 2024 22:50:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: shmem: Rename mTHP shmem counters
To: Ryan Roberts <ryan.roberts@arm.com>, Barry Song <baohua@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
 <hughd@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Lance Yang
 <ioworker0@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Zi Yan <ziy@nvidia.com>, Daniel Gomez <da.gomez@samsung.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240708112445.2690631-1-ryan.roberts@arm.com>
 <CAGsJ_4zH72FyLq5gJm215oiWrtd6uf40L_F1UO6cFZ4sy7qt0A@mail.gmail.com>
 <744749c3-4506-40d9-ac48-0dbc59689f92@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <744749c3-4506-40d9-ac48-0dbc59689f92@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08.07.24 14:29, Ryan Roberts wrote:
> On 08/07/2024 12:36, Barry Song wrote:
>> On Mon, Jul 8, 2024 at 11:24 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>
>>> The legacy PMD-sized THP counters at /proc/vmstat include
>>> thp_file_alloc, thp_file_fallback and thp_file_fallback_charge, which
>>> rather confusingly refer to shmem THP and do not include any other types
>>> of file pages. This is inconsistent since in most other places in the
>>> kernel, THP counters are explicitly separated for anon, shmem and file
>>> flavours. However, we are stuck with it since it constitutes a user ABI.
>>>
>>> Recently, commit 66f44583f9b6 ("mm: shmem: add mTHP counters for
>>> anonymous shmem") added equivalent mTHP stats for shmem, keeping the
>>> same "file_" prefix in the names. But in future, we may want to add
>>> extra stats to cover actual file pages, at which point, it would all
>>> become very confusing.
>>>
>>> So let's take the opportunity to rename these new counters "shmem_"
>>> before the change makes it upstream and the ABI becomes immutable.
>>
>> Personally, I think this approach is much clearer. However, I recall
>> we discussed this
>> before [1], and it seems that inconsistency is a concern?
> 
> Embarrassingly, I don't recall that converstation at all :-| but at least what I
> said then is consistent with what I've done in this patch.
> 
> I think David's conclusion from that thread was to call them FILE_, and add both
> shmem and pagecache counts to those counters, meaning we can keep the same name
> as legacy THP counters. But those legacy THP counters only count shmem, and I
> don't think we would get away with adding pagecache counts to those at this
> point? (argument: they have been around for long time and there is a risk that
> user space relies on them and if they were to dramatically increase due to
> pagecache addition now that could break things). In that case, there is still
> inconsistency, but its worse; the names are consistent but the semantics are
> inconsistent.
> 
> So my vote is to change to SHMEM_ as per this patch :)

I also forgot most of the discussion, but these 3 legacy counters are 
really only (currently) incremented for shmem. I think my idea was to 
keep everything as FILE_ for now, maybe at some point make the pagecache 
also use them, and then maybe have separate FILE_ + SHMEM_.

But yeah, likely it's best to only have "shmem" here for now, because 
who knows what we can actually change about the legacy counters. But 
it's always though messing with legacy stuff that is clearly suboptimal ...

-- 
Cheers,

David / dhildenb


