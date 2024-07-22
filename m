Return-Path: <linux-kernel+bounces-259003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFE2938FD8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04F021F21885
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 13:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D665616D4D6;
	Mon, 22 Jul 2024 13:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PpdLVbwh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA0A16938C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 13:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721654639; cv=none; b=XDe/BibCUeP65JKWpLkehbxmOQxBxM4dzWXPAGtDbuRlGtjSDhFsE6H57AYL2/fVgxOU8pUkPPNGtoDvYvl920pbTFtnAnixhbAXrVg/KqHzUKb81DAoDCnLlMX8tHKFZffmSVGMLKR+89IstxmQVoccb6o/GgxJ3HtQF1Fusig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721654639; c=relaxed/simple;
	bh=TpkXoIbS29lGBmIzc1QVVI7KwUr3uqqLMWqSCXKcGHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KY/6bI0ywlskrwhzIPlw4NrRg2lKGfkW/gICZaipXIlHarrSitZCVpR6wCKjCmIVGCaHJYcgFNzRWRQ1NgA+b9Z3gipa3VQOhz4eJTGGnO46N0KxOSpA5i3xsnGu7f4uhAxTtJwsSenEjY7T2MO52Ps4Ckyd2e5FN6t3Iebqq6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PpdLVbwh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721654636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=F04SlJJullNum8McQISmIMasrmkoqWbSgpnIQ4Kl30c=;
	b=PpdLVbwhEQ4JIijYGy58crMBQxrVOWyFmHUzvm4lNwkGOOOzck8eLvSmgSjmXXShcjCxDZ
	S6Ox0Uqkdoei6kbJAaSJQ5UoZOOPqL+uggqxF+MBarDlDZRhS40YgIOUO47VOZ6yLP20VV
	2krdoQbuTFWaOeOqEH55/5m6vRARdn4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-VEG7D91NOfKjoZ-SwI1T3w-1; Mon, 22 Jul 2024 09:23:52 -0400
X-MC-Unique: VEG7D91NOfKjoZ-SwI1T3w-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ef311ad4bcso7917571fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 06:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721654631; x=1722259431;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F04SlJJullNum8McQISmIMasrmkoqWbSgpnIQ4Kl30c=;
        b=es+xvZ1EYgiSm3bSIFJYNo0m/eElzTvueutlBnH02MKfulElJSKjbjFjXvx/gKF6h0
         26lbpIZ2RUM12t1UCoX94PNvu+apXboOXM41vJ2/BGxnO9SVKZvDraiKeV0bdio8Cod6
         JDnmKfzqjGHi6BhNf2AiXo1zRKnvr/DfsGmpfTepksFJIQcqrlKk3ljSTQLIWmjo+1fY
         H+NfiNQ6v2MpL7HkOWL/GXCak3pb9euEWyLn685pCx4G0QdPWWCIQ52CdlHkUy+ibER/
         DmgQ/Yk72ATzuoI/sJmv06TweIJ5mmz7JnVt4Bx1yrmyuJfgWkG9jhP8myxb16BlOB0h
         2WNw==
X-Forwarded-Encrypted: i=1; AJvYcCWtwjW8WoE9Ns9tKkK51jNio6iZokUt1N/vOLwt4jBZZOX3zY1+D2+yKcYkFKh/SCvhjRRyifCBIVOhRT0kdvF/aY3CboDNMgXTS8zQ
X-Gm-Message-State: AOJu0YyqU7Q3g+vi21yfW4hRSwMykpPIFJWWphFeFz7x+XDChFyA9y51
	ve9RfouV0sbSYkwbdquZsNRL8A6jVCadhm1uWgx/VyIVE+sdCeQEQMAHvB7ogG2cqOrCs+iGxMm
	siH5Ew8HaPx5G9PUWbvJn42KCaEutmmaiDmsx2ke2yClTJMIwol9gDRRI4jgB5Q==
X-Received: by 2002:a05:651c:549:b0:2ef:32fb:6c4c with SMTP id 38308e7fff4ca-2ef32fb6e8amr16007221fa.45.1721654631392;
        Mon, 22 Jul 2024 06:23:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF13w93G+v9yeNkY4YBGT7gLSuiziqPRuuS1m69zlHFC9lAE12YwZlXWoUjUjGKiLsM8iP/Q==
X-Received: by 2002:a05:651c:549:b0:2ef:32fb:6c4c with SMTP id 38308e7fff4ca-2ef32fb6e8amr16007011fa.45.1721654630880;
        Mon, 22 Jul 2024 06:23:50 -0700 (PDT)
Received: from ?IPV6:2003:cb:c727:7000:c050:e303:f8a7:6ed9? (p200300cbc7277000c050e303f8a76ed9.dip0.t-ipconnect.de. [2003:cb:c727:7000:c050:e303:f8a7:6ed9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368787ed572sm8472272f8f.110.2024.07.22.06.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 06:23:50 -0700 (PDT)
Message-ID: <d72d044c-0c24-4899-ac9c-3e1a24e9b85f@redhat.com>
Date: Mon, 22 Jul 2024 15:23:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] BUG: Bad page map (8)
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+ec4b7d82bb051330f15a@syzkaller.appspotmail.com>,
 hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com, Matthew Wilcox <willy@infradead.org>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
References: <20240720050219.1813-1-hdanton@sina.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240720050219.1813-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.07.24 07:02, Hillf Danton wrote:
> On Fri, 19 Jul 2024 13:21:30 +0200 David Hildenbrand <david@redhat.com>
>> On 19.07.24 00:51, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    4d145e3f830b Merge tag 'i2c-for-6.10-rc8' of git://git.ker..
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=11321495980000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=6b5a15443200e31
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=ec4b7d82bb051330f15a
>>> compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>>> userspace arch: arm64
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113e054e980000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1366ab85980000
>>>
>>
>> The reproducer involves udmabuf. I suspect it has to do with it.
>>
>> But I'm curius, does the reproducer not trigger before 4d145e3f830b on
>> mainliny?
>>
>> Viveks changes are not upstream yet, but I can only speculate that we
>> have some issue similar to the one we had with hugetlb: udmabuf doing
>> things with memfd/shmem pages that it shouldn't do, because it doesn't
>> "own" these pages.
>>
>> "udmabuf: Use vmf_insert_pfn and VM_PFNMAP for handling mmap" might help.
> 
> 	cpu1				cpu2
> 	---				---
> 	evict()				find folio2 in page cache
> 	truncate_inode_folio()
> 	truncate_cleanup_folio();
> 	  // unmap folio2 from mmA
> 	  unmap_mapping_folio(folio2);
> 					mmap folio2 to mmB
> 	filemap_remove_folio(folio2);
> 
> 
> If the window exists for mapping folio to userspace while indoe is evicted,
> is this report false positive?

I think what happens here is that filemap_unaccount_folio() will force 
the mapcount to be logically 0 (value -1).

And if we then actually go ahead and unmap that folio from our udmabuf 
page tables, we will let it go negative (and also free up the refcount 
too early) resulting in all kinds of issues.

filemap_unaccount_folio() was written under the assumption that the 
mapcount will only get modified when we map something via the pagecache, 
not when some other code (udmabuf) looked up something from the 
pagecache and then maps it to user space itself.

"Fortunately", the issue only exists with CONFIG_DEBUG_VM.

The right fix is probably to stop udmabuf from touching the mapcount 
(use a PFNMAP as that patch does). Another fix would be removing that 
debugging code from filemap_unaccount_folio().

I do see value in part of that debugging code. The refcount+mapcount 
modifications, not so much. But the "BUG: Bad page cache in process ..." 
message sounds helpful.

-- 
Cheers,

David / dhildenb


