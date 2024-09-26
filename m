Return-Path: <linux-kernel+bounces-340697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA46A9876C7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8E91F23750
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE9113B5B4;
	Thu, 26 Sep 2024 15:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jCyk9RUW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111E64C7C
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 15:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727365546; cv=none; b=AS2FTUdmVkiamUHZpw4OMFoQ5Z0nulqAVxoILzUJ0diF9kNCn4re6Qi3K8ZVHiCDdIIBCJMO10+z0//0dzXcnyxKSkgh5QiBdVFa18RmN9257tJaYIzlMfxeV5fI/mzutGQPN2SOZngkx6G7VGr8ouOv9JKtKBVYz9P+EKEjygA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727365546; c=relaxed/simple;
	bh=7N0bvIFXQIm+7L0ahpoamAC7bLNS3tJ6yjph6+ELfHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n4Su6kHr5ouefi9DJf7dhx1gN+LijdSKn9pR3/t6E5yK3eXfywc4b6aMphkoqizdsIcqmWg1VKwLWf9gU15eVSQOZW0uQw616A0TixPy+MC8NoHjgFfKCYzFUwyMM5g+MeYYLV1LlSRAUoWz56hFFtdznrsjetjtOYesJiZGlMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jCyk9RUW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727365544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3Gl9g8z9Zexo7jtYzHy1CGPeUIh6n8gav/gUqe3LYpY=;
	b=jCyk9RUWkTgOL5kfD7LiPoy9kdS17d68Au6CaENDdHbhhDbRu2pyhpS8N9VNz0xOCuolVV
	W5nl3Gos8AZycGOSrC0airTxh0SHfXaMDyWWZCW1eXgQ5HiD8zH/t3HorABP+8/acHtwsZ
	P34lCzBsisolxWLBC9BMsoaNivSaHSY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-9JEMsxxEO6-6nM44-2JH_Q-1; Thu, 26 Sep 2024 11:45:42 -0400
X-MC-Unique: 9JEMsxxEO6-6nM44-2JH_Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb6dc3365so8104565e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727365541; x=1727970341;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Gl9g8z9Zexo7jtYzHy1CGPeUIh6n8gav/gUqe3LYpY=;
        b=RXxzX5VbMKupFIf7FLx4RNEh0ApFJcgWkAxUDH+WPG6rsZmV9j2QppeCMY9SDeHJ1e
         mx+UKsPLc5pLLIBCzgzBCgs2WHfjglfwiz+4rUe79v/TGIiyPqDjlYfhrqR39RY84V7x
         YiiZylO2teDmuDVHq6SjpNtnz0WWHmUQCfueAdmaYoiyYMcd0FIGz18WvmKXjUhNz4MR
         KfW89yOHb6qLMqp5L1CXU4x2fnKajTEMPsXRafUksiSB4jsXQWNsNaMEO9hZ5TZ3tEG+
         8HSwBbMsoRgdQrzlTQRF3DzgURPn8KdzH7v5WNYMVQRWozneWSpJ7KDaKoL/GJUGFB1C
         KEiw==
X-Forwarded-Encrypted: i=1; AJvYcCWTVhhWh5UFL7F3c66XQUsaNRURDZ1SDlnQIXV9vYVSsa6o+gfWhIt1n05vokjJvgrKkhqLugCK5TX4ltQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLTGMegp1RMm+bGy62X838X+GiS4Cb/gRbXMibvIC+C/W8OTPD
	u/cwwn6KLmYdBxsL7PPp/m01FM3n5yPAx90scK7OSDjvDojE87l0aIGH2XGRQ/855QSxXrKZovK
	A+Mk9f2C6479C3QAT42ayjZM+LtFMRqyCspwuXsH7IqRMeToeB8UUtTacLESD4g==
X-Received: by 2002:a05:600c:45c9:b0:42c:b942:1bba with SMTP id 5b1f17b1804b1-42e96144c66mr48126015e9.27.1727365541421;
        Thu, 26 Sep 2024 08:45:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHD6PugydG8+kvyRAobmItvIoCnCRdHJLQtZ6DqCi8AP2NBbSLSJKNBW7K+tNogHHTShTHtZw==
X-Received: by 2002:a05:600c:45c9:b0:42c:b942:1bba with SMTP id 5b1f17b1804b1-42e96144c66mr48125705e9.27.1727365540876;
        Thu, 26 Sep 2024 08:45:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c744:ac00:ef5c:b66d:1075:254a? (p200300cbc744ac00ef5cb66d1075254a.dip0.t-ipconnect.de. [2003:cb:c744:ac00:ef5c:b66d:1075:254a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a36292sm50829035e9.32.2024.09.26.08.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 08:45:39 -0700 (PDT)
Message-ID: <ad1e7e02-26f2-43db-b18f-ab995cd4f982@redhat.com>
Date: Thu, 26 Sep 2024 17:45:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING in copy_huge_pmd
To: syzbot <syzbot+bf2c35fa302ebe3c7471@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, jgg@ziepe.ca, leitao@debian.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mingo@redhat.com,
 peterx@redhat.com, rppt@kernel.org, syzkaller-bugs@googlegroups.com,
 tglx@linutronix.de, x86@kernel.org
References: <66f15c8d.050a0220.c23dd.000f.GAE@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <66f15c8d.050a0220.c23dd.000f.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.09.24 14:18, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    88264981f208 Merge tag 'sched_ext-for-6.12' of git://git.k..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=16c36c27980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e851828834875d6f
> dashboard link: https://syzkaller.appspot.com/bug?extid=bf2c35fa302ebe3c7471
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12773080580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ed5e9f980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0e011ac37c93/disk-88264981.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f5c65577e19e/vmlinux-88264981.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/984d963c8ea1/bzImage-88264981.xz
> 
> The issue was bisected to:
> 
> commit 75182022a0439788415b2dd1db3086e07aa506f7
> Author: Peter Xu <peterx@redhat.com>
> Date:   Mon Aug 26 20:43:51 2024 +0000
> 
>      mm/x86: support large pfn mappings
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17df9c27980000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=143f9c27980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=103f9c27980000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+bf2c35fa302ebe3c7471@syzkaller.appspotmail.com
> Fixes: 75182022a043 ("mm/x86: support large pfn mappings")
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 5508 at mm/huge_memory.c:1602 copy_huge_pmd+0x102c/0x1c60 mm/huge_memory.c:1602
> Modules linked in:
> CPU: 1 UID: 0 PID: 5508 Comm: syz-executor274 Not tainted 6.11.0-syzkaller-08481-g88264981f208 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
> RIP: 0010:copy_huge_pmd+0x102c/0x1c60 mm/huge_memory.c:1602
> Code: ff 90 0f 0b 90 e9 2e f5 ff ff e8 8f fc 92 ff 48 ff cb e9 0f f7 ff ff e8 82 fc 92 ff 48 ff cb e9 8a f7 ff ff e8 75 fc 92 ff 90 <0f> 0b 90 e9 11 fd ff ff 4c 8d ac 24 00 01 00 00 48 b8 06 fe ff ff
> RSP: 0018:ffffc90003cdf0c0 EFLAGS: 00010293
> RAX: ffffffff8201bd3b RBX: ffff88803090c118 RCX: ffff8880317a9e00
> RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
> RBP: ffffc90003cdf248 R08: ffffffff8201bc06 R09: 1ffffffff2038ef5
> R10: dffffc0000000000 R11: fffffbfff2038ef6 R12: ffff88802fab89c0
> R13: d7ffe7fff1cbfe02 R14: 0000000000000020 R15: ffff888031e5b780
> FS:  00007f38182a06c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f381831d9f0 CR3: 000000007b18c000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   copy_pmd_range+0x425/0x85f0 mm/memory.c:1245
>   copy_pud_range mm/memory.c:1292 [inline]
>   copy_p4d_range mm/memory.c:1316 [inline]
>   copy_page_range+0x99f/0xe90 mm/memory.c:1414
>   dup_mmap kernel/fork.c:750 [inline]
>   dup_mm kernel/fork.c:1674 [inline]
>   copy_mm+0x11fb/0x1f40 kernel/fork.c:1723
>   copy_process+0x1845/0x3d50 kernel/fork.c:2375
>   kernel_clone+0x226/0x8f0 kernel/fork.c:2787
>   __do_sys_clone3 kernel/fork.c:3091 [inline]
>   __se_sys_clone3+0x2cb/0x350 kernel/fork.c:3070
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f3818306429
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f38182a0118 EFLAGS: 00000202 ORIG_RAX: 00000000000001b3
> RAX: ffffffffffffffda RBX: 00007f3818390318 RCX: 00007f3818306429
> RDX: 00007f38182e2ab6 RSI: 0000000000000058 RDI: 00007f38182a0120
> RBP: 00007f3818390310 R08: 00007fffb191b837 R09: 0000000000000080
> R10: 0000000000000000 R11: 0000000000000202 R12: 00007f381835d074
> R13: 00007f381839031c R14: 00007f38182a0120 R15: 000000080000000e
>   </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 

#syz test: https://github.com/davidhildenbrand/linux.git copy_huge_pmd_pfn

-- 
Cheers,

David / dhildenb


