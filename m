Return-Path: <linux-kernel+bounces-309824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 286329670BD
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 12:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AA711C21426
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 10:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCB717BB08;
	Sat, 31 Aug 2024 10:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g0NXgUVo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36CE13A27E
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 10:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725099286; cv=none; b=ndk3bMrhb84/uAqUUL+GJJ1vlm2+d9PTixwaZBZvr3t1RmTVO5PGv7hxzpl1rKG7QiJIPmHUfIZ/nCPmIsTIcXRpw+IDrxivc9HlzMX6A8rM0VrcrM1kgQiwHPWCL4dScH33UrOXeC+Nv01NxW2/H1WEvBR0zFaWVkuyLhIJaQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725099286; c=relaxed/simple;
	bh=5sv7X0OPGqhK2noPQJ60r9uWKR2cYCHI+rNjT55zT+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKuJa44E7W0ThlNG4Ah4I2N2ul7jhUqET/S9ponp2MSzvkxzPyC5LCCiptvMgcf90Se3AOpjhV0mijRfvxSySQC7JGZKSXcm3sCXXjLWMlvVZSVPnJomtrC/33an8+AlpncQOJrP45WlDZ/zIRF30fPx5sjCA7rAzb8GMkLuGPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g0NXgUVo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725099283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HuRd4ekYP8HZkUoIly2pUJYfQS832KqBzVDTs9P6KI4=;
	b=g0NXgUVoAZkiI2L5YcguAywLcuj3rjamgGqygX0TY5QiG4L0W+RH25VSPxkIFlTA63RYZ4
	oBC8qXsi/YVnd5fzZVaEgv7RuLKEwvtvpLISqGLU9NbWpgKcrT+L/CQfEm0eA6uE7Qn1xO
	TjOeWy+8pSEMYhbrK0+Kqgp4S5cnzxo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-BLbeFDdlNFWM9sGVahKWIg-1; Sat, 31 Aug 2024 06:14:41 -0400
X-MC-Unique: BLbeFDdlNFWM9sGVahKWIg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-374b9617ab0so748448f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 03:14:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725099280; x=1725704080;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HuRd4ekYP8HZkUoIly2pUJYfQS832KqBzVDTs9P6KI4=;
        b=vGyUCCST7g6BBnkRwuSVRGpAxPVBk8aF5Ci6hgU/wLBAN0mzn1xPLW56rV9j5AIEnT
         VruKn3tojutAI1hw3YPw0vVBUbHXC65U/9hOfy15LmwtyPvo8mVdISwpwoZiJ8jV5zDb
         3TTmq0x3zYJaHhwLej7JHY+IbsYTWtuv+GNHdtMZKTOvKC5y8WnNr8RtzLEOJv/ecX6U
         bFY3WNywPmqk+zg+FrgsRwjrlurS/uRZbL8GJr37S5QS3fbVp7YCXpgRM+cTz6PBxWEw
         zdutE4e1J7KvEM+AbT6ZKXgZvHL0piVbQZkbK2Cw6u4l11/d8E+14W/R/nGe9AjJ29Qm
         wYQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmpOkITp3XnMcOGDimaCZCxaSUxNjfy8xcKJbEsfug7RtUYvU9Y0abhPwBL3+HT3Gp2WaLSLJdJbV66qU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3UbptgBt7/96KF5AimI9Ujhnl394K0rvvLIHCdJ8wvlZGATTf
	mB+J1EvWQihNwNPg267VtarT7iaDRojHWfvFXjqzRmQMS/te9QPcpAA7hm5X6Osjo+gOZSNFq79
	3jc+ieJDHzK3nOQ5RjAAeS3RgPjmvQrI4aYoP1ekGUh4z2nwBdYYHY9gD46TuaQ==
X-Received: by 2002:a05:6000:4388:b0:374:b9d0:f2c3 with SMTP id ffacd0b85a97d-374b9d0f45dmr1902026f8f.17.1725099280448;
        Sat, 31 Aug 2024 03:14:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFl0KuDxBhxIr3g1iMoIBpGqVTyDBXjDS9APZqydKrO5jRv8RFMvKBhUZ5zVr93TuwdicILxg==
X-Received: by 2002:a05:6000:4388:b0:374:b9d0:f2c3 with SMTP id ffacd0b85a97d-374b9d0f45dmr1901993f8f.17.1725099279489;
        Sat, 31 Aug 2024 03:14:39 -0700 (PDT)
Received: from [192.168.3.141] (p5b0c6ee6.dip0.t-ipconnect.de. [91.12.110.230])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c1b0a62esm696550f8f.47.2024.08.31.03.14.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Aug 2024 03:14:39 -0700 (PDT)
Message-ID: <5d0b6380-833d-449e-a6b2-e9b023832832@redhat.com>
Date: Sat, 31 Aug 2024 12:14:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] mm: entirely reuse the whole anon mTHP in do_wp_page
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Chuanhua Han <hanchuanhua@oppo.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Zi Yan <ziy@nvidia.com>,
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
 Kalesh Singh <kaleshsingh@google.com>, Suren Baghdasaryan <surenb@google.com>
References: <20240831092339.66085-1-21cnbao@gmail.com>
 <c0f79761-f753-4df7-9d02-3bbcbfbd902f@redhat.com>
 <CAGsJ_4z=wHXa4Mug8RZJa4zULndPA0k9dw+OC41Lbv4nJUw3Ww@mail.gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4z=wHXa4Mug8RZJa4zULndPA0k9dw+OC41Lbv4nJUw3Ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 31.08.24 12:09, Barry Song wrote:
> On Sat, Aug 31, 2024 at 9:59 PM David Hildenbrand <david@redhat.com> wrote:
>>
>>
>>> +             idx = folio_page_idx(folio, vmf->page);
>>> +             folio_start = address - idx * PAGE_SIZE;
>>> +             folio_end = folio_start + nr * PAGE_SIZE;
>>> +
>>> +             if (unlikely(folio_start < max(address & PMD_MASK, vma->vm_start)))
>>> +                     return false;
>>> +             if (unlikely(folio_end > pmd_addr_end(address, vma->vm_end)))
>>> +                     return false;
>>> +             folio_ptep = vmf->pte - idx;
>>> +             folio_pte = ptep_get(folio_ptep);
>>> +             if (!pte_present(folio_pte) || pte_pfn(folio_pte) != folio_pfn(folio))
>>> +                     return false;
>>> +             if (folio_pte_batch(folio, folio_start, folio_ptep, folio_pte, nr, 0,
>>> +                             NULL, NULL, NULL) != nr)
>>> +                     return false;
>>> +             if (folio_mapcount(folio) != nr)
>>> +                     return false;
>>
>> BTW, you're not checking against the refcount (and it's all a bit racy
>> on concurrent unmapping!). So you're re-introducing the vmsplice
>> child->parent attak.
> 
> i don't quite understand this, you mean the below is not enough?
> 

Ah! You use the fallthrough, sorry I missed that!

You're not handling the swapcache references "correctly" (would have one 
reference per page), but the final check would be correct.

Yes, that should not allow for false positives here.

-- 
Cheers,

David / dhildenb


