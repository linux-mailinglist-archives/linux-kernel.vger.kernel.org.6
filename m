Return-Path: <linux-kernel+bounces-173625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5948C030F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAF99B22169
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE7B12AAE7;
	Wed,  8 May 2024 17:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KoXABiOS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1086612BF33
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 17:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189325; cv=none; b=jMeN+wB4yYMyhjS19+DexRUO/eVvVTUs/o2Iz5zjpL3WpBk2zV6lI23F9uTQlTwQhi5R8HxqhjkmVfceemayiiidQA/X/j/wbLt3v/3fdNGtSlh3kD72ENX81LcfU9t4yV+ZbKAF5KWyv79tRe8+O2QxWl3qWRAglADwDxZGFPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189325; c=relaxed/simple;
	bh=xEfYIU7jbEiu1wosPcRsQ6yMS4I9QYT5PTklVrZa46M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kRw7fEAIszonTyKDVtZw6eW7hd3/t9xW7o+uxrM3uMi/UZE3iuMswguPbp/se1Qb9iNj9Hxg3+8ZpkEU4LwrZr74YkOUx+l3q/KviGnnSV3DOH3OQ/6IkrDN1Sbv0BCQrGdN68RRVAHEYppMpiWQB1sHL1nkEBoG/cvJ9URD9+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KoXABiOS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715189314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yLU/dWnfpXVjHkLPC8pfGl1am4FJ3d5ve0zTGmVoA9Q=;
	b=KoXABiOS8WNllGR74NsZrbwX9iZcfzUr4V+3DVur+UUh/gWqldvxTGYHQT0URjVrdNUB1m
	pB9lwSv1n1JQ+QmY3uYc+wLbZxPlNAEvp/IdqBwua4VZrk4xjhOfkVRXdTIz7lMYXSh3T5
	48V22zLLk84j/LYhnE1TU158f/otLbI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-x7vv94jgMx2NQTOru44YSQ-1; Wed, 08 May 2024 13:28:31 -0400
X-MC-Unique: x7vv94jgMx2NQTOru44YSQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2e2ec0c8807so59071fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 10:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715189310; x=1715794110;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yLU/dWnfpXVjHkLPC8pfGl1am4FJ3d5ve0zTGmVoA9Q=;
        b=hgnDpVw+kyCvBnoo1J/j2movc5t+bg8L/C4ScSMIu4rqkUY//9JjPHecEknASmUnhh
         ozh2Qq0KpSOnaTazrekI/e12sGe93b/ycB1f5G6jZNRPYkNk4aTXRH3teXO/IT1YwqcC
         DUB5LBRs8Xe0W56oi3Ki4dZo7vJShwQOm5A/ZVpOTJUlHHY4XcTsFoCId14jml3Dn7RR
         7erU7VFiRcy093LEX6cf/h1mUJKs1uj/aFoJ4U67cCAzGHt+wbF96Xbme0LWdth3Gtpb
         evgzLV3IeN84MvacEncz+YQZgv7+ngBllymukKwqP/af9t5I409Vkv55w564fDngB5/p
         CFpg==
X-Forwarded-Encrypted: i=1; AJvYcCXezurrwOPmQY+zPzfL+C5UfmbbfmeSp9qkrti7mM9VRjTuVrq4+4HEdtapPEsj2ioMzO2TORa092UD88os2n7S5q90e2G7khLuME+s
X-Gm-Message-State: AOJu0YxHDj7N9JCD/wC3LJxMHfmKuG3uRvnjjTq1YY1mzCLyD7UDB1qy
	3lGjE9sHp47VXvjAAEzB2Wj0ioI3diA21RE+s8Fgf7PpovNLm+yhADwqB107PwIQDv7yD7X8Veq
	rmTUaYqrDa+6u2P8v0maf00Lzd9yeAe4QM96cYJKfPoZLkCP/gLbNoyxCDhrQIA==
X-Received: by 2002:a2e:a0d6:0:b0:2d8:930c:bbfa with SMTP id 38308e7fff4ca-2e447381dd5mr20004891fa.5.1715189310233;
        Wed, 08 May 2024 10:28:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrvHQdQ31BBT5yv8l8ohsbogvW5UvbPukgFv4qSb+hfYnWjo/jo9Hi6qvsu+u8S2Hof2aZbw==
X-Received: by 2002:a2e:a0d6:0:b0:2d8:930c:bbfa with SMTP id 38308e7fff4ca-2e447381dd5mr20004721fa.5.1715189309600;
        Wed, 08 May 2024 10:28:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:3100:35c3:fc4b:669f:9ff9? (p200300cbc707310035c3fc4b669f9ff9.dip0.t-ipconnect.de. [2003:cb:c707:3100:35c3:fc4b:669f:9ff9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fa9dbab53sm13295755e9.13.2024.05.08.10.28.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 10:28:29 -0700 (PDT)
Message-ID: <c1b69c38-59c8-4d27-9ff5-bcca553da7c2@redhat.com>
Date: Wed, 8 May 2024 19:28:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] Address hugetlbfs mmap behavior
To: Prakash Sangappa <prakash.sangappa@oracle.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "muchun.song@linux.dev" <muchun.song@linux.dev>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "willy@infradead.org" <willy@infradead.org>
References: <1714699270-7360-1-git-send-email-prakash.sangappa@oracle.com>
 <901d53f0-1cbf-436e-8ccb-875680dbc1d5@redhat.com>
 <0C0831EB-AA56-49C9-9D92-460C0FFF9BB5@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <0C0831EB-AA56-49C9-9D92-460C0FFF9BB5@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08.05.24 19:00, Prakash Sangappa wrote:
> 
> 
>> On May 7, 2024, at 5:00 AM, David Hildenbrand <david@redhat.com> wrote:
>>
>> On 03.05.24 03:21, Prakash Sangappa wrote:
>>> This patch proposes to fix hugetlbfs mmap behavior so that the
>>> file size does not get updated in the mmap call.
>>> The current behavior is that hugetlbfs file size will get extended by a
>>> PROT_WRITE mmap(2) call if mmap size is greater then file size. This is
>>> not normal filesystem behavior.
>>> There seem to have been very little discussion about this. There was a
>>> patch discussion[1] a while back, implying hugetlbfs file size needs
>>> extending because of the hugetlb page reservations. Looks like this was
>>> not merged.
>>> It appears there is no correlation between file size and hugetlb page
>>> reservations. Take the case of PROT_READ mmap, where the file size is
>>> not extended even though hugetlb pages are reserved.
>>> On the other hand ftruncate(2) to increase a file size does not reserve
>>> hugetlb pages. Also, mmap with MAP_NORESERVE flag extends the file size
>>> even though hugetlb pages are not reserved.
>>> Hugetlb pages get reserved(if MAP_NORESERVE is not specified) when the
>>> hugeltbfs file is mmapped, and it only covers the file's offset,length
>>> range specified in the mmap call.
>>> Issue:
>>> Some applications would prefer to manage hugetlb page allocations explicity
>>> with use of fallocate(2). The hugetlbfs file would be PROT_WRITE mapped with
>>> MAP_NORESERVE flag, which is accessed only after allocating necessary pages
>>> using fallocate(2) and release the pages by truncating the file size. Any stray
>>> access beyond file size is expected to generate a signal. This does not
>>> work properly due to current behavior which extends file size in mmap call.
>>
>> Would a simple workaround be to mmap(PROT_READ) and then mprotect(PROT_READ|PROT_WRITE)?
> 
> Another workaround could be to ftruncate(2) the file after  mmap(PROT_READ|PROT_WRITE), if MAP_NORESERVE is used. But these will require application changes as a special case for hugetlbfs that can be considered.

I'd assume that most applications that mmap() hugetlb files need to
special-case hugetlb because of the different logical page size
granularity already. But yes, it's all unfortunate.

> 
> However, should this mmap behavior  be addressed? Why mmap(PROT_WRITE) has to extend the file size needs clarification.

The issue is, as you write, that it's existing behavior and changing it
could cause harm to other apps that rely on that. But I do wonder if really
anybody relies on that ...

Let's explore the history:

The current VM_WRITE check was added in:

commit b6174df5eec9cdfd598c03d6d0807e344e109213
Author: Zhang, Yanmin <yanmin.zhang@intel.com>
Date:   Mon Jul 10 04:44:49 2006 -0700

     [PATCH] mmap zero-length hugetlb file with PROT_NONE to protect a hugetlb virtual area
     
     Sometimes, applications need below call to be successful although
     "/mnt/hugepages/file1" doesn't exist.
     
     fd = open("/mnt/hugepages/file1", O_CREAT|O_RDWR, 0755);
     *addr = mmap(NULL, 0x1024*1024*256, PROT_NONE, 0, fd, 0);
     
     As for regular pages (or files), above call does work, but as for huge
     pages, above call would fail because hugetlbfs_file_mmap would fail if
     (!(vma->vm_flags & VM_WRITE) && len > inode->i_size).
     
     This capability on huge page is useful on ia64 when the process wants to
     protect one area on region 4, so other threads couldn't read/write this
     area.  A famous JVM (Java Virtual Machine) implementation on IA64 needs the
     capability.

But it was only moved.

Before that patch:
* mmap(PROT_WRITE) would have failed if the file size would be exceeded
* mmap(PROT_READ/PROT_NONE) would have extended the file

After that patch
* mmap(PROT_WRITE) will extend the file
* mmap(PROT_READ/PROT_NONE) do not extend the file

The code before that predates git times.

Having a mount option to change that really is suboptimal IMHO ... we shouldn't add mount options to work
around all hugetlbfs quirks.

I suggest either

(a) Document it, along with the workaround
(b) Change it an cross fingers.


In QEMU source code is a very interesting comment:

      * ftruncate is not supported by hugetlbfs in older
      * hosts, so don't bother bailing out on errors.
      * If anything goes wrong with it under other filesystems,
      * mmap will fail.

So, was mmap() maybe the way to easily grow a hugetlbfs file before ftruncate() support
was added?

QEMU will only call ftruncate() if the file size is empty, though. So if you'd have a
smaller file QEMU would not try growing it, and mmap() would succeed and grow it. That's
a rare case to happen, though, and likely also undesired here: we want it to behave just
like ordinary files!

-- 
Cheers,

David / dhildenb


