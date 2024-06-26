Return-Path: <linux-kernel+bounces-229859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E81917540
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 02:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 880BE2846C3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 00:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ABB8C05;
	Wed, 26 Jun 2024 00:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CG6CcWs3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A3B79CE
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 00:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719362232; cv=none; b=B2WEsHDOIt3okZjY0ft1aIcABKeZAzQ79i1a23n385o7MxTW+kRXvX6zbpYpCXW5Ry3Aa3aWcH+oykU1eTia7dAl+TCxvCoEUSJCaT+Iwx+yk3WSjuR2i9kFZjcsFtSrIqrNfNKUB1CwlIcLepx1iCnXah0nbpdYV/dhKgcTtkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719362232; c=relaxed/simple;
	bh=S+YCG6Gtni5r+dPZPXoehUVpJrUKGN5ylG+dZOH2LZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FzZbPKGFXUX3/cgMfEu6Fbaeo880wwOM+attvDfSojNe+EfuBnOh6hJAigjMksssQRamrrH1z3GyB7AiZEHYbX4TF8Ft/Ed6Qf06dL2UlcDLuiragsqYkKh3PXNOEc3MD89QWMyGePcveW3u00fdFuv7cgQaRtnfJgjeZ+uztdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CG6CcWs3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719362230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7XSa6ZpfJ2JlPT3g8OgBf9PZ5iAj39OSQpGesaTNmpY=;
	b=CG6CcWs3D4w4x6rrDahtBJLeWWVbPIakmot5v+E7cNbC97ViuCp28eNWe8ThXitKxFJh1a
	7gcOOIlKVnmecbPrMTnJSVMvW1dRNjye8XR7X4u0Q9nwpKdOgqEBYSJJssCF+J6TPKb8KR
	72s51n523j8rmaDZ66Duo+jeIyzL0Co=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-EWVjh9hzNpG8Vz2lx1EGgA-1; Tue, 25 Jun 2024 20:37:08 -0400
X-MC-Unique: EWVjh9hzNpG8Vz2lx1EGgA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c7430b3c4bso7777125a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 17:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719362227; x=1719967027;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7XSa6ZpfJ2JlPT3g8OgBf9PZ5iAj39OSQpGesaTNmpY=;
        b=rDIJfMkGQFwYitiazpBZR6Vy+xtINme5e0poD3qtU2H7pcibZzk3f+LcWK4aYkbXP3
         ljz+eYIBVTL3oZm+/eRSTZ77Pocy2VHY/rJKGKpuyetiUtYMMy8WY+OakGNHt9UFcRBd
         UU0L/GKNaNpIV5HeE4BYjDtB0kfZR2g60feuUYUmmIeJbRlOPOn5zfrChTZxikXbOMqS
         A9sU1znjcfXDhQnlREI3vNzBAoMnQpZangkCDVrHsUt29X5IyO2ufFPEGtJhU3DxKnOv
         xo2jk2LRNys5LfhW551095oKEJLHcG7RbskCeu5YC8JxOsT/e8AGf1HMr73Ga76a48JI
         uWmA==
X-Forwarded-Encrypted: i=1; AJvYcCXd2Om3kvllxv4hg0ptQ+2keIMEQg7x8Hj8soPH1Y6WncHcoMRWC9LjA0Lz54jBA5W2Iint/lhWLaI5vNlcxU4BHy3KY+HLPIIYtPsK
X-Gm-Message-State: AOJu0YxOa8G44TVkXBgPQ7ffGf7HMPbCreepwEcCGxjEtRIEh1GQ216v
	AzcNO/Z0Gxas8F80pWsMGgk8mD1EPmbZjKsaWiCDL5YsVg+3HRaNWO/Lty72Iesd2KSaoK+R10T
	nhkddlqH8/CvlnmEuwDOYfSzkcAAvQPqYO/s75f/7Hq7FVMFM9/EYHIEKoxb5Hg==
X-Received: by 2002:a17:902:ecc8:b0:1f9:c289:737c with SMTP id d9443c01a7336-1fa1d683c1emr106652875ad.60.1719362227394;
        Tue, 25 Jun 2024 17:37:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDjNcz0viQEwIaipBp6N0yRlPUsIKoKAYuglwG9H2KqNectD+G314m4fAwmTDdbJQL9ffogQ==
X-Received: by 2002:a17:902:ecc8:b0:1f9:c289:737c with SMTP id d9443c01a7336-1fa1d683c1emr106652695ad.60.1719362226970;
        Tue, 25 Jun 2024 17:37:06 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3c6ec0sm88110985ad.169.2024.06.25.17.37.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 17:37:06 -0700 (PDT)
Message-ID: <4b05bdae-22e8-4906-b255-5edd381b3d21@redhat.com>
Date: Wed, 26 Jun 2024 10:37:00 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] mm/filemap: Limit page cache size to that supported
 by xarray
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, djwong@kernel.org, willy@infradead.org,
 hughd@google.com, torvalds@linux-foundation.org, zhenyzha@redhat.com,
 shan.gavin@gmail.com
References: <20240625090646.1194644-1-gshan@redhat.com>
 <20240625113720.a2fa982b5cb220b1068e5177@linux-foundation.org>
 <33d9e4b3-4455-4431-81dc-e621cf383c22@redhat.com>
 <20240625115855.eb7b9369c0ddd74d6d96c51e@linux-foundation.org>
 <f27d4fa3-0b0f-4646-b6c3-45874f005b46@redhat.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <f27d4fa3-0b0f-4646-b6c3-45874f005b46@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/26/24 5:05 AM, David Hildenbrand wrote:
> On 25.06.24 20:58, Andrew Morton wrote:
>> On Tue, 25 Jun 2024 20:51:13 +0200 David Hildenbrand <david@redhat.com> wrote:
>>
>>>> I could split them and feed 1&2 into 6.10-rcX and 3&4 into 6.11-rc1.  A
>>>> problem with this approach is that we're putting a basically untested
>>>> combination into -stable: 1&2 might have bugs which were accidentally
>>>> fixed in 3&4.  A way to avoid this is to add cc:stable to all four
>>>> patches.
>>>>
>>>> What are your thoughts on this matter?
>>>
>>> Especially 4 should also be CC stable, so likely we should just do it
>>> for all of them.
>>
>> Fine.  A Fixes: for 3 & 4 would be good.  Otherwise we're potentially
>> asking for those to be backported further than 1 & 2, which seems
>> wrong.
> 
> 4 is shmem fix, which likely dates back a bit longer.
> 
>>
>> Then again, by having different Fixes: in the various patches we're
>> suggesting that people split the patch series apart as they slot things
>> into the indicated places.  In other words, it's not a patch series at
>> all - it's a sprinkle of independent fixes.  Are we OK thinking of it
>> in that fashion?
> 
> The common themes is "pagecache cannot handle > order-11", #1-3 tackle "ordinary" file THP, #4 tackles shmem THP.
> 
> So I'm not sure we should be splitting it apart. It's just that shmem THP arrived before file THP :)
> 

I rechecked the history, it's a bit hard to have precise fix tag for PATCH[4].
Please let me know if you have a better one for PATCH[4].

#4
   Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
   Cc: stable@kernel.org # v4.10+
   Fixes: 552446a41661 ("shmem: Convert shmem_add_to_page_cache to XArray")
   Cc: stable@kernel.org # v4.20+
#3
   Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
   Cc: stable@kernel.org # v5.18+
#2
   Fixes: 4687fdbb805a ("mm/filemap: Support VM_HUGEPAGE for file mappings")
   Cc: stable@kernel.org # v5.18+
#1
   Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
   Cc: stable@kernel.org # v5.18+

I probably need to move PATCH[3] before PATCH[2] since PATCH[1] and PATCH[2]
point to same commit.

Thanks,
Gavin


