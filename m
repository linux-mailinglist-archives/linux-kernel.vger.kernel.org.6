Return-Path: <linux-kernel+bounces-371602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C072E9A3D32
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FE0EB22471
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9F12010EC;
	Fri, 18 Oct 2024 11:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hrlNCp4h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E34118E34C
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 11:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729250446; cv=none; b=QwbRL7tRPvZUJqpl0A5iKal8ngcw0V5F2hqr+HMk8mYy/yBO9THiJR5NJhijNfwV8/WXbsIuFKhd90WHy6nT9fFuz/nDTAzwkcaJjXZ56OsumIztU03CTKkg3unUPMYHs6yJBSIDK4fR2corC0niWmswLEdJbW8yZt6dkzs8FIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729250446; c=relaxed/simple;
	bh=5MthbbqNj0s7HgwqdIQbWi3gEYYkcOxHotMOiP3j40Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MLBmYcPib7+jxo32FkVilkNH1MkLN5siII+oPGCHHIfuPGX85VFJ7/AdqYvOFqhJ9uOMLr0vzWfOQnLR2xP6jjIFAH6cjndUfrdwfaEe18aJ+VClJybosXIitF/r9MeZvpYjDPn9NqlEv7/Avrv+5Dr4BkwKfeBmHv8vNltPars=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hrlNCp4h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729250443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tNzHhif2tNmZfO6vKFUjltLarV15b1JLWYUX/l/UOZw=;
	b=hrlNCp4hbdYhkYagBeWPsaMh8EHHsY2am0CpUDMLnC0mOyZdLHgA7/g0Mjp/ucCVtJqgOw
	DFp6NaOZogKPOp1Kb+GlxcaK0ngV3jbRO3WOZv1+ITb4Jkscmdkngj4yzdNye0y59urdkl
	gQ9SLpIWyswRGRLd3ufw8pT+6ur3yfY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-3N7WBReLP5-KZNaj78jLiQ-1; Fri, 18 Oct 2024 07:20:42 -0400
X-MC-Unique: 3N7WBReLP5-KZNaj78jLiQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d4af408dcso1088692f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 04:20:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729250441; x=1729855241;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tNzHhif2tNmZfO6vKFUjltLarV15b1JLWYUX/l/UOZw=;
        b=OkPVSq16pAy3Vx77SxwUqI2mF0ey/OvAd6C5dm7RZC0MCDIBFSc2EZ1hFvctgFhuIi
         KMlo+yfWZuw7z0ogkBZsCjOUBQagvkUj+JICB/z7ixvlpZWawhiMJdJeempjI2hiGnGQ
         dckN1kTd9uHGlmApDFlyKSLHk5iqzpVDPMvRN7PqBDpIRwOg6zQmoOmrR2QMsR+YkhAi
         ezx1iQYc+P6e+m+aAzU1CUi6rCjLuMDdPCF0lwdfYTzYfitqUORvVwCqB8wBApIHFxWr
         pTEBCSe2hk4MzaKd0qVMXUkT55e8Z6JPdVh3KQp5zZm7g+AJhL5NSwgsKwnVYU2V9k2S
         M3XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaRROBeG+013o5vbmP2xyhcbJG79govXWLKQISJCt8IietgiyyU0u8wQYMxMRvShWThlEuHIqdo48CdNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHddhIVTbpj/hEW3qF0ORXzSjh7ZFhS83ojODzjzivrDbv5NZe
	3tJav02xp/8xjEJMOtSTqKW+6ZPzCrJFG5tsU/XNgq/bEsIYoaVB5EisHMs588MGpX1jifblBSf
	IHSi5iXo9y2i0k0DJeEZBdb6MjJVkjeQbtMtiDVcgif1xxUkSlOK8gL9OCiTciA==
X-Received: by 2002:a05:6000:118c:b0:374:c92e:f69f with SMTP id ffacd0b85a97d-37eab4d88a2mr1467317f8f.16.1729250441224;
        Fri, 18 Oct 2024 04:20:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHT1LZRA5VlkcVCQMFfnkj1fwl+/Tgb/pAM6wTUoTamG85cB+rHP4g7hM+lh6B2ArSEbkz5iQ==
X-Received: by 2002:a05:6000:118c:b0:374:c92e:f69f with SMTP id ffacd0b85a97d-37eab4d88a2mr1467291f8f.16.1729250440779;
        Fri, 18 Oct 2024 04:20:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:2400:68a3:92e0:906f:b69d? (p200300cbc707240068a392e0906fb69d.dip0.t-ipconnect.de. [2003:cb:c707:2400:68a3:92e0:906f:b69d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf118b67sm1674741f8f.99.2024.10.18.04.20.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 04:20:40 -0700 (PDT)
Message-ID: <0a1dcac5-9897-4667-9b35-04ccf7506437@redhat.com>
Date: Fri, 18 Oct 2024 13:20:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WARNING in get_pat_info
To: lee bruce <xrivendell7@gmail.com>, dave.hansen@linux.intel.com,
 linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org
Cc: bp@alien8.de, hpa@zytor.com, mingo@redhat.com,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 wang1315768607@163.com, syzkaller@googlegroups.com
References: <CABOYnLx_dnqzpCW99G81DmOr+2UzdmZMk=T3uxwNxwz+R1RAwg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CABOYnLx_dnqzpCW99G81DmOr+2UzdmZMk=T3uxwNxwz+R1RAwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.08.24 11:44, lee bruce wrote:
> Hello, I found a bug titled "WARNING in get_pat_info" with modified
> syzkaller in the lasted upstream and lasted mm branches.
> 
> If you fix this issue, please add the following tag to the commit:
> Reported-by: xingwei lee <xrivendell7@gmail.com>
> Reported-by: yuxin wang <wang1315768607@163.com>
> 
> TITLE: WARNING in get_pat_info
> ------------[ cut here ]------------
> WARNING: CPU: 2 PID: 12458 at arch/x86/mm/pat/memtype.c:1002
> get_pat_info+0x4b6/0x5c0 arch/x86/mm/pat/memtype.c:1002
> arch/x86/mm/pat/memtype.c:1002
> Modules linked in:
> CPU: 2 PID: 12458 Comm: syz-executor.0 Not tainted 6.10.0 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.16.2-debian-1.16.2-1 04/01/2014
> RIP: 0010:get_pat_info+0x4b6/0x5c0 arch/x86/mm/pat/memtype.c:1002
> arch/x86/mm/pat/memtype.c:1002
> Code: 00 00 00 48 89 de e8 79 28 54 00 48 83 fb 20 75 11 48 83 7c 24
> 18 00 74 6e 31 ff e8 74 23 54 00 eb 0b 31 ff e8 6b 23 54 00 90 <0f> 0b
> 90 bb ea ff ff ff 48 c7 44 24 40 0e 36 e0 45 4b c7 44 25 00
> RSP: 0018:ffffc9000f3ff2a0 EFLAGS: 00010246
> RAX: ffffffff81453f35 RBX: 0000000000000000 RCX: ffffc90013051000
> RDX: ffffffff81453f35 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffc9000f3ff3b0 R08: 000000000001fcbe R09: 000000000001fcbf
> R10: dffffc0000000000 R11: fffffbfff1fdc6f6 R12: 1ffff92001e7fe5c
> R13: dffffc0000000000 R14: 1ffff92001e7fe64 R15: 1ffff92001e7fe68
> FS: 00007fb3403356c0(0000) GS:ffff888063500000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f74b7104000 CR3: 000000001c1ce000 CR4: 0000000000752ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
> <TASK>
> untrack_pfn+0x338/0x660 arch/x86/mm/pat/memtype.c:1104
> arch/x86/mm/pat/memtype.c:1104
> unmap_single_vma+0x20c/0x2c0 mm/memory.c:1819 mm/memory.c:1819
> unmap_vmas+0x3d7/0x600 mm/memory.c:1885 mm/memory.c:1885
> exit_mmap+0x279/0xce0 mm/mmap.c:3341 mm/mmap.c:3341
> __mmput+0x120/0x3a0 kernel/fork.c:1343 kernel/fork.c:1343
> mmput kernel/fork.c:1365 [inline]
> dup_mm kernel/fork.c:1687 [inline]
> mmput kernel/fork.c:1365 [inline] kernel/fork.c:1720
> dup_mm kernel/fork.c:1687 [inline] kernel/fork.c:1720
> copy_mm+0x1a5b/0x1fe0 kernel/fork.c:1720 kernel/fork.c:1720
> copy_process+0x1cc7/0x3f70 kernel/fork.c:2373 kernel/fork.c:2373
> kernel_clone+0x236/0x910 kernel/fork.c:2780 kernel/fork.c:2780
> __do_sys_clone kernel/fork.c:2923 [inline]
> __se_sys_clone kernel/fork.c:2907 [inline]
> __do_sys_clone kernel/fork.c:2923 [inline] kernel/fork.c:2907
> __se_sys_clone kernel/fork.c:2907 [inline] kernel/fork.c:2907
> __x64_sys_clone+0x25d/0x2b0 kernel/fork.c:2907 kernel/fork.c:2907
> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> do_syscall_x64 arch/x86/entry/common.c:52 [inline] arch/x86/entry/common.c:83
> do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fb33f67dde9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fb340335078 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
> RAX: ffffffffffffffda RBX: 00007fb33f7abf80 RCX: 00007fb33f67dde9
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 00007fb340335120 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
> R13: 000000000000000b R14: 00007fb33f7abf80 R15: 00007ffd35a9fb48
> </TASK>
> 
> 
> I use the same kernel as syzbot instance
> git tree: upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=122bfdb8980000
> kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=8e5f5ae13ab96e5e
> compiler: clang version 15.0.6
> 
> =* repro.c =*

Simply compiling repro.c and running it does not seem to reproduce this 
for me. Can you please share the detailed steps to get this reproduced?

-- 
Cheers,

David / dhildenb


