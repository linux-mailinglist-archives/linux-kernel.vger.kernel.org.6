Return-Path: <linux-kernel+bounces-370291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8649A2A71
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4B1D2869BF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36141DF99A;
	Thu, 17 Oct 2024 17:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LqOWLfhL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25031DEFDA
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729185057; cv=none; b=GQpNZzJE+mAoIvCq+g7JSCwWVd+sV3AosDKIJDeYWICtsRgM/xPZWG+aFIe7Q+r/ioUqCSeV4tHF/G3WsmhuLQSx0niK9KS0ZXazbYDCa5NogO4qKC3iu46WdW49zxpHts+kJM80yd/q1Gs3hyFJvXgXTAVD1N7cjL1F6SS6TKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729185057; c=relaxed/simple;
	bh=SFryjBwpxaVITgldOWA7QxHhO0UAI9YAqz8V/cofH0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KTDjSUhnSJtrcjSLshqQgAgcnjcPElzWBfd9yifSk+dSoIoZXTQBAP7yv+ohVkBORZOtz3EHO0DCZf3gHNioEeRd0nLOZ69eJIVPY15lKLJBK6v6HqUGHfBSAQ/hNefhvu43CYP47xg9WcQ6/1BzdUFYu/3cjuvZg0HyXfYz8U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LqOWLfhL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729185054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aRigJuIDB/xTaE7A8orTIswNtUgAH5fWYtB0DzmEb9s=;
	b=LqOWLfhLVoFJ7qCxxMSHa8LrkE7YxHbkZTuxWzFivXcmTjaWt8SlNFuXx84CYvENIhCRQq
	FT+vlZLsQ/L+YgAmHt9pNdnErckATOT+wB+gIPyJOFg5ZlD+E/q5GSMeJ6DBIOX7PZS9nR
	gjTqTUKZA/wSgd0ac20Z8TKp3ktUhK8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-l-thNVaeMIGrwLk66XLEzQ-1; Thu, 17 Oct 2024 13:10:23 -0400
X-MC-Unique: l-thNVaeMIGrwLk66XLEzQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-431604a3b47so739855e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 10:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729185022; x=1729789822;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aRigJuIDB/xTaE7A8orTIswNtUgAH5fWYtB0DzmEb9s=;
        b=JGnFSdCldshnjhLA8Ba2vpau6hQO457p2hBt0CpMQxEg3ij6yhRTpAkyvBlqfS7/+e
         aEm0nWYmugdrdhjAbU6j4noOjW7kx3CcCAyBLzvmqgnxylUhdcFnOCpd37MZ/qqQsAK+
         4iGf//YfxT+rvNZ2lkPgLzEFSeGV732wXkDJvSBsyGQxaYwe9DI3u2oNHS8Xv5w2mj6v
         Mt/RJrIKFL5v6axNfI0hN16pJ/PhyyWAYGNEFD7wvndJMNx0YGh4NCY+xowsiPQQGxBR
         VclQcr9Kqv3ugbPK3nJKcmq1cS+EGCZTirhTf66Or9wVpRDF25O/LNW8Q6Nw/DdAAGgz
         Nkwg==
X-Gm-Message-State: AOJu0Yy9/n+COk8ILIMWQNvSpuitV4UQGD1QzrokkGX/YePVdPzv4TcI
	d81MUPzWXaY8kHqzUUEPiyhjYK8gdusvx+I4aHdQ1XFt9tPs9sOy4I5xL4P8MYP5ZExBTlu2OvO
	9JCD52Q0fZb1iZdk8XCNXkK6S7HlLsHc0dxDQi1RgFl/np9yzI8hufrAFe7ZbCw==
X-Received: by 2002:a05:600c:1991:b0:42c:a580:71cf with SMTP id 5b1f17b1804b1-4314a384625mr69295475e9.30.1729185022005;
        Thu, 17 Oct 2024 10:10:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEs3zbSgz2t2BrSUeLT1tNXcidU7WUKKFeXlutV2SkuOujObegNY06KCbWB26fyjuXWz4IVvw==
X-Received: by 2002:a05:600c:1991:b0:42c:a580:71cf with SMTP id 5b1f17b1804b1-4314a384625mr69295225e9.30.1729185021555;
        Thu, 17 Oct 2024 10:10:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:7600:62cc:24c1:9dbe:a2f5? (p200300cbc705760062cc24c19dbea2f5.dip0.t-ipconnect.de. [2003:cb:c705:7600:62cc:24c1:9dbe:a2f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316068d08dsm1417875e9.15.2024.10.17.10.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 10:10:21 -0700 (PDT)
Message-ID: <a5b32587-877b-4b04-bb85-cb4738f3b748@redhat.com>
Date: Thu, 17 Oct 2024 19:10:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: stop leaking pinned pages in low memory
 conditions
To: John Hubbard <jhubbard@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 Alistair Popple <apopple@nvidia.com>, Shigeru Yoshida <syoshida@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Minchan Kim <minchan@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>
References: <20241016202242.456953-1-jhubbard@nvidia.com>
 <1f8dcae1-416e-43cf-8dda-5440e0db4c00@redhat.com>
 <9a2232d6-74c4-426f-bfab-668c5c5ad143@redhat.com>
 <de9ff75c-0416-46ed-90fd-c8801bbdc8ef@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <de9ff75c-0416-46ed-90fd-c8801bbdc8ef@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17.10.24 19:06, John Hubbard wrote:
> On 10/17/24 1:53 AM, David Hildenbrand wrote:
>> On 17.10.24 10:51, David Hildenbrand wrote:
>>> On 16.10.24 22:22, John Hubbard wrote:
> ...
>> And staring at memfd_pin_folios(), don't we have the same issue there if
>> check_and_migrate_movable_folios() fails?
> 
> Yes, it looks very clearly like the exact same bug, in a different location.
> This complicated return code is the gift that keeps on giving. Although
> likely people are just copying the pattern, which had the problem.
> 
> 
>>
>> diff --git a/mm/gup.c b/mm/gup.c
>> index a82890b46a36..f79974d38608 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -3708,12 +3708,10 @@ long memfd_pin_folios(struct file *memfd, loff_t
>> start, loff_t end,
>>                   ret = check_and_migrate_movable_folios(nr_folios, folios);
>>           } while (ret == -EAGAIN);
>>
>> -       memalloc_pin_restore(flags);
>> -       return ret ? ret : nr_folios;
>>    err:
>>           memalloc_pin_restore(flags);
>> -       unpin_folios(folios, nr_folios);
>> -
>> -       return ret;
>> +       if (ret)
>> +               unpin_folios(folios, nr_folios);
>> +       return ret ? ret : nr_folios;
> 
> That looks correct. I can send this out with the other patch as a tiny
> 2-patch series since they are related. Would you prefer to appear
> as a Signed-off-by, or a Suggested-by, or "other"? :)

Suggested-by: please :)

-- 
Cheers,

David / dhildenb


