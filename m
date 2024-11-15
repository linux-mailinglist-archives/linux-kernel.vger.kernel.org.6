Return-Path: <linux-kernel+bounces-410757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C11199CE0A5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D2328E437
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 13:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477731CDA0B;
	Fri, 15 Nov 2024 13:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJBTK3m8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18191BC08B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731678521; cv=none; b=AQ2lEx71sWq9k8lcbvy3w/k+1lgAGj18BEQ8RMAXw5szSblct2Ue4UxERzEfa1ZBorC/SuBWk8hogR4ly2mpNCDicOj/izwxe4I2a1lDPlOLcZtG7dmVff6/9wD6CP/MK5kEUoxcpeWw/scg5w8IHfD+NNhR1Tniycv8TKB6iYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731678521; c=relaxed/simple;
	bh=psEwcWoUe5dz6skMX9Qt9wLsqudIxQmoFRsb4Vz4Ru8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CD4trV6HBTmpZ5mmXdiDk+BoCrQA4SxH//820lT/dU0Y2t4Nwg4p1YTrwbkwICgOUyyJ3HjCprG0VIZLPbn43Pw/6eVVXUvdEKFQp+8VqGwlCRZRMkUem//3SlnQE0lXOzRxYAFsxeP5Z8pIqIwkc8vnnHAXO9wMO+RSkmbjDBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YJBTK3m8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731678518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8hBhkGbE6xhBvpPRosEZLqGdsTCTQ5VufGYOyTgvFuE=;
	b=YJBTK3m8G4ylfHK0VX5v+Luz6/CjiSosZJFnk93okTKjX0cx7El6yJcv2Cr9y70DapRsk+
	Znkb7U7sGiKuGJBw/qX+FV6nDAQ1wzQMxlVWAvk0f56fQOiGJ3qHphYdd0ViQ6NP4J6uIq
	l+9YS6oZM8SObsTA+vGm0AIDtHnS7MQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-HRqtgL8DOe-29GeEJV4Gbw-1; Fri, 15 Nov 2024 08:48:37 -0500
X-MC-Unique: HRqtgL8DOe-29GeEJV4Gbw-1
X-Mimecast-MFC-AGG-ID: HRqtgL8DOe-29GeEJV4Gbw
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3822f550027so79312f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 05:48:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731678516; x=1732283316;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8hBhkGbE6xhBvpPRosEZLqGdsTCTQ5VufGYOyTgvFuE=;
        b=RfCOKvOESZ6THhwQecopBmZaHSploNOBjGnjVhR27dveAwH8RVdbCvGIIPUDjhRM0f
         FIKxjfOy2dly/eJaIbVl+cygTVcp1N+8cvTTJwSuhh6Bl3KEeV3HFn/TyIRyquyHzQB1
         kJmG9n0/cB88MKDlwdYqr/nhPVa53swhRzZ2LE47+9cF0z1m+ssF6K30tlpmR/D1zQOB
         2GiFwmFFAUgtK0yk162tcHNetnhiyI8oJUhukVRBg9vjViQ+9GBj9rBARUK+Y3BG2qxG
         8J29IIIowZlNziV3bJ2BHSRpkEo6dG8EzSzpbxhPwgvZIwEEDvKiJhgGMcwf/CtPBEwc
         3X+w==
X-Forwarded-Encrypted: i=1; AJvYcCWZxlWFaCTbYRbUWcqiAFWgE5EmY/Hv4DR9reYdLF0HRltdWBjmJRavBF0BFkvnWJGQJHpFadzgDE8P/B0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSDYL++vVYF1e4YJA00xDIyFH62UMItKio9EJLYKNjC9f1RaAl
	yXL1wNePlSRW0GWZtPIsD5gJDLYNlpi2ba9rzW3zdZzL1LqXbYSEmM/XpTNh3dTKdu/MpWtBisH
	XjLKkWkrJXc7fuSgkFb6ZxQsfJSvnKptL5JGGChP0v0pB3bpEVCxU3n3J9hgzlQ==
X-Received: by 2002:a05:6000:4915:b0:374:c92e:f6b1 with SMTP id ffacd0b85a97d-38225a047bamr2053555f8f.23.1731678516371;
        Fri, 15 Nov 2024 05:48:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPRRvRB5XeIgfeAOT6kSREBhCjUqUwvNKXWbGApsw9lwrnalY1Xdt56nV49uIoZP3gDyssdA==
X-Received: by 2002:a05:6000:4915:b0:374:c92e:f6b1 with SMTP id ffacd0b85a97d-38225a047bamr2053527f8f.23.1731678515990;
        Fri, 15 Nov 2024 05:48:35 -0800 (PST)
Received: from ?IPV6:2003:cb:c721:8100:177e:1983:5478:64ec? (p200300cbc7218100177e1983547864ec.dip0.t-ipconnect.de. [2003:cb:c721:8100:177e:1983:5478:64ec])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ada2a8bsm4416754f8f.17.2024.11.15.05.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 05:48:34 -0800 (PST)
Message-ID: <5ed3c225-e77e-4d1b-be73-3027a1be1080@redhat.com>
Date: Fri, 15 Nov 2024 14:48:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] mm: shmem: add large folio support for tmpfs
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, wangkefeng.wang@huawei.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, ioworker0@gmail.com, da.gomez@samsung.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1731397290.git.baolin.wang@linux.alibaba.com>
 <eabd8c89fc1b4807eaf28750e04c44b718ae6487.1731397290.git.baolin.wang@linux.alibaba.com>
 <c7c3f529-4cd0-4209-b3b9-48a29dfcb08d@redhat.com>
 <6c2c25b7-3929-4d1c-8312-61a69f2c5b26@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <6c2c25b7-3929-4d1c-8312-61a69f2c5b26@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


>>>            return BIT(HPAGE_PMD_ORDER);
>>
>> Why not force-enable all orders (of course, respecting
>> MAX_PAGECACHE_ORDER and possibly VMA)?
> 
> The ‘force’ option will affect the tmpfs mmap()'s huge allocation, which
> I intend to handle in a separate patch as we discussed. Additionally,
> for the huge page allocation of tmpfs mmap(), I am also considering the
> readahead approach for the pagecache.

Okay, we can change this later. Likely force/deny are a blast from the 
past either way.

[...]

>>> +
>>> +        order = highest_order(within_size_orders);
>>> +        while (within_size_orders) {
>>> +            aligned_index = round_up(index + 1, 1 << order);
>>> +            i_size = max(write_end, i_size_read(inode));
>>> +            i_size = round_up(i_size, PAGE_SIZE);
>>> +            if (i_size >> PAGE_SHIFT >= aligned_index)
>>> +                return within_size_orders;
>>> +
>>> +            order = next_order(&within_size_orders, order);
>>> +        }
>>>            fallthrough;
>>>        case SHMEM_HUGE_ADVISE:
>>>            if (vm_flags & VM_HUGEPAGE)
>>
>> I think the point here is that "write" -> no VMA -> vm_flags == 0 -> no
>> code changes needed :)
> 
> Yes. Currently the fadvise() have no HUGEPAGE handling, so I will drop
> the 'fadvise' in the doc.

Interesting that we documented it :)

-- 
Cheers,

David / dhildenb


