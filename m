Return-Path: <linux-kernel+bounces-416789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60499D4A44
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 10:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FBE0B21D65
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4582C1C7299;
	Thu, 21 Nov 2024 09:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FR24Dwsz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85C2175562
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 09:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732182914; cv=none; b=q4PsgxQR4N7nY5DA9TtPp+93HYMRTr1MtiZcOs+364yGC30bZZhRwaRQAlYRVso7q+2G7ZYCaGqH9pJcIGfAgrxsUDniBiJC5gNuAy16JCDfwMkubka/hqvhQpuoriVK0rJN1fJwZfUpt8iosBI1zRtHQNshBRmC2d8+8VDc6ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732182914; c=relaxed/simple;
	bh=V9zSHS1pJjVSXltgG8ToSIxHEsIBoQJt5QpPTu7JfXY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=B1RUE/yfdt1MF94KcALgMDFF4FE9iQRjgM2l6Z6B30k+pf8RS4+i1XNiD5ANcEYKvphvOU9e87HusKgGOWRKr3VY18E6naf8H2h0hYXOgYa+4Kg3Iwshno7sCuWnkkcuidZfiNEiqjo2E2hYmsj7VWlIk9bG+QFGhwRvYaP6a9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FR24Dwsz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732182910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oeSXhCxBTTH4vqfY7AAKMHZ+Jnc8WGPxhnpKzz8e11o=;
	b=FR24DwszE0o7yMYP1fJW4JVxfDdttTVCkflf+jGYXQMdcDLe700CsXQNtMtFWfVWwvcBxR
	zrYKBf0Xp1CtQ4NPMArTpFamA5wBOXHgXyHlzFX4154ThAWtsnBilt0Mq5LyP0x3PFZIIG
	ZjvnEMUp9MS3L2+bxIaU6g0Z3ToJRys=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-WyOqWQ8fPDGAeTC0ZIjFgQ-1; Thu, 21 Nov 2024 04:55:08 -0500
X-MC-Unique: WyOqWQ8fPDGAeTC0ZIjFgQ-1
X-Mimecast-MFC-AGG-ID: WyOqWQ8fPDGAeTC0ZIjFgQ
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4315afcae6cso3762485e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 01:55:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732182907; x=1732787707;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oeSXhCxBTTH4vqfY7AAKMHZ+Jnc8WGPxhnpKzz8e11o=;
        b=Sl3KqhYTPTMKFn9UnBSzhayRPF/WbHMDDz55D5vd8dxUDlTOsQIGOZg3ejW5hPHF2M
         jlb+702EkS39KGGuYeLfQE6vR91Ga7j6CQ+Q+uPfeecmiDFEmtgt3CYg+qigmmxsHcIF
         A4XA+VFkXyZrVAQunk9czh0VH3KR0bH3qObzuwbUOMO18/l+Wg+KCL5t/mh3ZllMnnlg
         pn+jLL4xsnxLEdd7u4YTbr1xOwztkc64XNUQlFrXZrqGBHe6OQFBTUJZ35GQxeDHOOOa
         fotRYt0Z9FOQt6kolqY/z+1GbqcsySMXBsk07JtY9ok7zHYL/ixRHDBe7Nl6rLCBRbzG
         MphA==
X-Forwarded-Encrypted: i=1; AJvYcCXSHAy+MaDFjIMtXRt9vs4g7wO9Y2cSo9TEx9heSJKBNzc5xnNE0IQBSsuBTFVvFS7B2ag2b/5biXfq//0=@vger.kernel.org
X-Gm-Message-State: AOJu0YypBT9dLV/RYSES7Gt3yCDBtZ88zvLzV6PvQOz8hNEUV2BzPvaJ
	A0QQmnI9IrrNUWM87pJ0Tv7w+gSDwi1mQB0fGF+PZ7IjkqK0h24ykXuy96+ylMZptsM/NuikKJf
	1fKGujJGlinwrDlscLW3umbDwzPR/rA6Hprc34c96UtkqMkdyoLzbA9Nns9ZppmuyGPe7ig==
X-Received: by 2002:a05:600c:3ca1:b0:42c:ae4e:a96c with SMTP id 5b1f17b1804b1-433c5cd8e80mr20000045e9.16.1732182907446;
        Thu, 21 Nov 2024 01:55:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyGk12OZ73HibIfae1Pd8GsBtuNqYucsHxtEDFplxjw7+0U1nJJ0gTYQ+41N0tKRGkd5aImQ==
X-Received: by 2002:a05:600c:3ca1:b0:42c:ae4e:a96c with SMTP id 5b1f17b1804b1-433c5cd8e80mr19999895e9.16.1732182907067;
        Thu, 21 Nov 2024 01:55:07 -0800 (PST)
Received: from ?IPV6:2003:cb:c70c:de00:1200:8636:b63b:f43? (p200300cbc70cde0012008636b63b0f43.dip0.t-ipconnect.de. [2003:cb:c70c:de00:1200:8636:b63b:f43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432f643b299sm54461735e9.0.2024.11.21.01.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 01:55:05 -0800 (PST)
Message-ID: <6b8351f6-39bb-4312-b3ff-000eb1f1fe90@redhat.com>
Date: Thu, 21 Nov 2024 10:55:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] BUG: Bad page state in iomap_write_begin
From: David Hildenbrand <david@redhat.com>
To: syzbot <syzbot+c317c107c68f8bc257d9@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com
Cc: David Howells <dhowells@redhat.com>
References: <673d9fc5.050a0220.363a1b.0007.GAE@google.com>
 <f3170ddb-7626-4631-b284-40c8bac7e549@redhat.com>
 <7bab1234-45d7-43f6-8ebf-4a2c923c6a46@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <7bab1234-45d7-43f6-8ebf-4a2c923c6a46@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.11.24 10:46, David Hildenbrand wrote:
> On 21.11.24 10:26, David Hildenbrand wrote:
>> On 20.11.24 09:37, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    e8bdb3c8be08 Merge tag 'riscv-for-linus-6.12-rc8' of git:/..
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=1644d2c0580000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=d2aeec8c0b2e420c
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=c317c107c68f8bc257d9
>>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1144d2c0580000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=176252e8580000
>>>
>>> Downloadable assets:
>>> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-e8bdb3c8.raw.xz
>>> vmlinux: https://storage.googleapis.com/syzbot-assets/fcae16ff0e0f/vmlinux-e8bdb3c8.xz
>>> kernel image: https://storage.googleapis.com/syzbot-assets/758973beace8/bzImage-e8bdb3c8.xz
>>> mounted in repro #1: https://storage.googleapis.com/syzbot-assets/a097a300c8a9/mount_0.gz
>>> mounted in repro #2: https://storage.googleapis.com/syzbot-assets/36b9fff6ab5e/mount_6.gz
>>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>> Reported-by: syzbot+c317c107c68f8bc257d9@syzkaller.appspotmail.com
>>>
>>> BUG: Bad page state in process syz-executor315  pfn:49e01
>>> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x49e01
>>> head: order:0 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:-1
>>
>> So, we have a pincount underflow on a large folio (order-9). We
>> allocated the folio in iomap_write_begin()->__iomap_get_folio(). Nothing
>> special.
>>
>> [...]
>>
>>>     </TASK>
>>> BUG: Bad page state in process syz-executor315  pfn:49e00
>>> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x49e00
>>> head: order:0 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
>>> flags: 0x4fff0000000004d(locked|referenced|uptodate|head|node=1|zone=1|lastcpupid=0x7ff)
>>> raw: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
>>> raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
>>> head: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
>>> head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
>>> head: 04fff00000000000 0000000000000000 ffffffffffffffff 0000000000000000
>>> head: 0000000000000200 0000000000000000 00000000ffffffff 0000000000000000
>>> page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
>>
>> And we seem to have an unexpected flag set on the head page of the same
>> large folio. Likely PG_locked.
>>
>> ...
>>
>>> XFS (loop0): Unmounting Filesystem 9f1cad42-11bd-4e12-8f0b-f07876b81d9a
>>> BUG: Bad page state in process syz-executor315  pfn:49c01
>>> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x49c01
>>> head: order:0 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:-1
>>> flags: 0x4fff0000000004d(locked|referenced|uptodate|head|node=1|zone=1|lastcpupid=0x7ff)
>>> raw: 04fff00000000000 ffffea0001270001 ffffffffffffffff ffffffff00000000
>>> raw: 0000000000000200 0000000000000000 00000000ffffffff 0000000000000000
>>> head: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
>>> head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
>>> head: 04fff00000000000 ffffea0001270001 ffffffffffffffff ffffffff00000000
>>> head: 0000000000000200 0000000000000000 00000000ffffffff 0000000000000000
>>> page dumped because: nonzero pincount
>>
>> [...]
>>
>>>     </TASK>
>>> BUG: Bad page state in process syz-executor315  pfn:49c00
>>> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x49c00
>>> head: order:0 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
>>> flags: 0x4fff0000000004d(locked|referenced|uptodate|head|node=1|zone=1|lastcpupid=0x7ff)
>>> raw: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
>>> raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
>>> head: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
>>> head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
>>> head: 04fff00000000000 0000000000000000 ffffffffffffffff 0000000000000000
>>> head: 0000000000000200 0000000000000000 00000000ffffffff 0000000000000000
>>> page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
>>> page_owner tracks the page as allocated
>>
>> Same thing, different folio.
>>
>>
>> So we seem to be repeatedly freeing a large folio that
>> (a) Is locked
>> (b) Has a pincount underflow
>>
>> Likely because we have an unbalanced unpin, that happens before
>> evicting/truncating the folio. If we then evict/truncate the (locked)
>> folio, we free the folio before unlocking it and dropping the actual
>> last reference.
>>
>> Not sure why we see a comparable thing with small folios (pincount part
>> of refcount, but on unpin our refcount should seriously underflow
>> immediately)
>>
>> CCing David
> 
> If I get the reproducer right, it does:
> 
> (1) Create a temporary folder and chdir into it
> 
> (2) Mounts an (XFS?) image (syz_mount_image() magic )
> 
> (3) Opens a file1 in there
> 
> (4) Writes some data into it using write(). Likely this allocates the
> folios.
> 
> (5) Mmaps the file1 (MAP_UNINITIALIZED|MAP_LOCKED|MAP_FIXED|MAP_SHARED)
> 
> (6) Creates a socket -- socket() -- and binds it -- bind().
> 
> (7) Writes some more data into the mmap of file1 using memcpy.
> 
> (8) Mounts another (?) image (syz_mount_image() magic )
> 
> (9) Opens a file2 in there with O_SYNC|O_DIRECT|O_CREAT|O_RDWR.
> 
> (10) Calls ioctl(0xc0185879) on the file2
> 
> (11) Calls sendmsg() on the socket. msghdr and all data seems to reside
> completely in the mmap of file1.
> 
> (12) Calls symlink(0,0)
> 
> (13) Calls rename(0,0)
> 
> 
> I doubt 12+13 are relevant. Likely (11) is the problematic bit: we are
> performing direct-io on folios allocated during (4) from file1 into file2.
> 
> I have not deciphered yet what the ioctl in (10) does.

Seems to be FITRIM.

-- 
Cheers,

David / dhildenb


