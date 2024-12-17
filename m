Return-Path: <linux-kernel+bounces-449144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E25D39F4A6E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2468816F414
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F931F4E24;
	Tue, 17 Dec 2024 11:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ELZ2f7bN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95441F4E2A
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 11:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734436610; cv=none; b=OF4UvgaGxcVfcuNQCjbyo/aPQAdZaPFuJRODMTt98vOOboCDaTh0Ed4oZOZo2jb5hGZvyLEYXWagyI84ho9M/c1B9iTISWXPuyaCJvPmwqDj93nKXKgGR0U8jR5BsuP99bll/wyAJdK1eEFZ5WydMGjwDd2D8bXCrlRwjXH3VnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734436610; c=relaxed/simple;
	bh=r06WS41rxN0/35nQSW+GD844biqXNAP0/imkHhzW+/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GdBGj7K/IMBHMD7C0CR1hF1yj4Fwn3+PGjZLAokz7e3f2Qj7wqRJpMxATVxM2RLqOgTv22ociNXNj3bl6jnEhM03T2YrfL9kspRs7KABCOib94mH6PQlGDiQ/6ZkjaJ/NaZrhw0d+K4kpU3DYmmuEUEqveFqtylHBSDDjCL+4Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ELZ2f7bN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734436606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4j3RJ6u8WKht0eWYFAXC4mdKyekBt3cyxE0dVaW09rM=;
	b=ELZ2f7bNoxAsbeAHewpwIPzHDHDXnO0wLph93lv60dikWsxhSuVNjX4rbPNigW3+iiybBS
	GbRfb7GITOyR45H29N/+LbvNQv+LstMav4Y6+sLEVtT7vmk7CloEENCjvpvmDaoa/SyK0/
	2LoYESqzR31pZM+O/bjhyxnoIohKkQY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-f3MDQ10mNfCj0PkFCGLeSA-1; Tue, 17 Dec 2024 06:56:44 -0500
X-MC-Unique: f3MDQ10mNfCj0PkFCGLeSA-1
X-Mimecast-MFC-AGG-ID: f3MDQ10mNfCj0PkFCGLeSA
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-388d1f6f3b2so1061778f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 03:56:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734436604; x=1735041404;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4j3RJ6u8WKht0eWYFAXC4mdKyekBt3cyxE0dVaW09rM=;
        b=oiVK6wlvTTj10htsqkqbL/VfD1kPm6SgLjrHQ9lLi5o9ITH+TH9JUeetkGDiDL16I7
         zCFNOV3Dd9pIBDyILbWXpiRBEPb47Uj26tbT/zwLvZwE3q3SS9G4cEipqBZIaeuzoHCP
         krP/GZPhioC4qwqXvZ0jau9wKtCn7WUES9msbF5NW5QQakNmJalRFp/oJmEJdk2R588x
         5l1CMScGOFhNIxYf3IdTVSymfn29y01AAPpubK26D2TAs1yw+vA+0U4c8H1nfs6CMU9/
         qTVZr3oKCE4k+EiX4GTFDghVRV4LxK/0lmm+AhlOnJ4cy/hJnSXF1DWhqLV9NYXmnGHe
         SVPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsX4x3YPObBaL9oPdpflmnP+0nwkHK/dcWWC5ibUBykByHZMSccD6+ifZz3UPrNrnEx/8vuvxzdmx/Z8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6SsS0Vch5b+C5DyYOex3/CCUTB63CM8Oo54atxRdMnpzmE9o+
	v6Ja5Wxjl//EVO5C2wmaoYXnFZYVIQP/ajJyrNlDjxT2rJBFvnwSiOVpjGZoOQEU2KRmTJE1Q2U
	Z3swrxnhrDs7Mwbv/t4N7WgSKap+E7Rf6v0Gi0JEGtkuR/gX9UPHGQa4HNMScAA==
X-Gm-Gg: ASbGnctQ+c59MUyew6cD/YlVHL5nZrumscSgH9oOIyP6CBYuI8kaJsVg5vpUexe3uCg
	nDemcYuO6+qKw5HhCYUzs5oJqOiGeThxk4IqB6c4lXk4WcJ0TDH5GpepSKEmyEnt1DZxwRPisR1
	dO0CwrVv958sM/pJf7ovURaM6qtVVudEEtjaUd9t7SRvc3muOEzzvRXlCvzOGiZiA9g+sEeqQ7G
	WngZiW5sg8BZSn2GsbfxVyUaLfJdaKtsRbsWqfWy0E4QqI4Y178Qxrwe81HWUasvBva4ePBSB/W
	M9zeBYMQQ41Je5A=
X-Received: by 2002:a05:6000:1fae:b0:385:ed16:c8b with SMTP id ffacd0b85a97d-388da39cd7dmr2484416f8f.23.1734436603663;
        Tue, 17 Dec 2024 03:56:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHa6WYqV5Qge4oQqUVyLttlkTx2SZO8PlQZNXX//tdqnqghLk3HOX4fGS672Qzkn0EpanB+qw==
X-Received: by 2002:a05:6000:1fae:b0:385:ed16:c8b with SMTP id ffacd0b85a97d-388da39cd7dmr2484393f8f.23.1734436603302;
        Tue, 17 Dec 2024 03:56:43 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c80121d4sm11215958f8f.2.2024.12.17.03.56.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 03:56:42 -0800 (PST)
Message-ID: <d863bcc8-ce96-4095-b4ef-4a0da73e985e@redhat.com>
Date: Tue, 17 Dec 2024 12:56:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: hugetlb: independent PMD page table shared count
To: Liu Shixin <liushixin2@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>,
 Kenneth W Chen <kenneth.w.chen@intel.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Nanyong Sun <sunnanyong@huawei.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20241214104401.1052550-1-liushixin2@huawei.com>
 <8e59d2bd-77d3-41bc-83b7-532b018db4e2@redhat.com>
 <00edd087-8df6-343a-95bf-ca23381085a8@huawei.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <00edd087-8df6-343a-95bf-ca23381085a8@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.12.24 03:02, Liu Shixin wrote:
> 
> 
> On 2024/12/16 23:34, David Hildenbrand wrote:
>> On 14.12.24 11:44, Liu Shixin wrote:
>>> The folio refcount may be increased unexpectly through try_get_folio() by
>>> caller such as split_huge_pages. In huge_pmd_unshare(), we use refcount to
>>> check whether a pmd page table is shared. The check is incorrect if the
>>> refcount is increased by the above caller, and this can cause the page
>>> table leaked:
>>
>> Are you sure it is "leaked" ?
>>
>> I assume what happens is that we end up freeing a page table without calling its constructor. That's why page freeing code complains about "nonzero mapcount" (overlayed by something else).
> 
> 1. The page table itself will be discarded after reporting the "nonzero mapcount".
> 
> 2. The HugeTLB page mapped by the page table miss freeing since we treat the page table as shared
>      and a shared page table will not be to unmap.

Ah, the page table still maps something, that makes sense. So we're 
leaking that indeed.

-- 
Cheers,

David / dhildenb


