Return-Path: <linux-kernel+bounces-416224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C41C9D423E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEB2BB282B1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 18:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307AC1AB6CD;
	Wed, 20 Nov 2024 18:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OqQF6dlw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C561547C6
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 18:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732128633; cv=none; b=IKPrpd4tCR17EkR2XnGf+Km5LEYQMatPJbkNPHtWJQi1LZMmivoRxs0vAVlS8S6MeoPsQG77EKIMzy+bkTaVLcw4OcX7bQAvIQoVhJk+QtSLK66qrHieIPgj4dLK0Ltt2uNKJWeiFHDhaLvfeHEyW9JFP5+9PjnBIVk5hlzstDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732128633; c=relaxed/simple;
	bh=sSoH4nNHxXJdP9UXheG2InR/89C2s2/2rztWdKqpBII=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=k2lKNJ20Me5SGIejVG8KF4Ggi38xYl0ZR8bn1T9sJ7BIL6t2lIDgfGv/wG6dsgxRfnQqq+96UGpn/RaSSBgcvMBL7xihq2WnEEcXk+EZxl8jUKgula2G0xKCbjUKsyMeBxD7q2SGY3ddYgNjFd9Y/Mzlt6QwXV9cvibRzk5nCpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OqQF6dlw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732128630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BpkqdGGyV1AjnWV9kFZrpVgjTBYUrLmGnK+wXYGZR2w=;
	b=OqQF6dlwlAYPB4DFXEh8VSuNSbcTSlPow3ODXWOxxz5PPPeGAUQbgZEEiRwGLNQzveRtCT
	jjfk5Sms70Wp78KTV4cv9CWTV5ms7RaauJfZHOPFfMsoQ0gRUiULNxoM/7tz+G4pj98MBv
	w8PPRAQa079nfI8V5uHS8Axuki2ZyO8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-dHD-hrl2NQOf63pes1T3KQ-1; Wed, 20 Nov 2024 13:50:29 -0500
X-MC-Unique: dHD-hrl2NQOf63pes1T3KQ-1
X-Mimecast-MFC-AGG-ID: dHD-hrl2NQOf63pes1T3KQ
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43154a0886bso150395e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 10:50:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732128628; x=1732733428;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpkqdGGyV1AjnWV9kFZrpVgjTBYUrLmGnK+wXYGZR2w=;
        b=o1Bt+ZwWopoU0qzF69M22/QFtBzkkVxyIXPQT6Un2IsTSguLJhAXyMwipSA+u5Xvo8
         7kDCeqRcV0N+FJUDPdekrDjIzm7+RrDIzqCe4fyAtGNHWBSjwDB3UEe1zFCmGc54FPqo
         SenEFf3uP1tAEINwKGefmNy6MgcNrhUMn6zXDl6VIaD6ZY+PwZ2RwEmQUFRlZGbScaHc
         puyq/c/eAqVLViPHrpwMgq/x0504BrFT/GopUXsxrRXVTnCuPAlsZhkGqxiZ4KrK1TCZ
         OOGd4LeD3/1CS5sLYcXEue0ysLGAtAuWKOr9krT5JfIaL9pTgj0Pr/68SxeMXKiOq4Am
         sEqA==
X-Forwarded-Encrypted: i=1; AJvYcCV3QzmCzrbbgHvpy5XpWXyr47cBqzCGwFQ1KmDolATiE5euxwzsDUb7PtgzH58WhO+Q1VXKhJrWy62Gocs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWqMjxsMT9mEFqXKD2X04NHknfW2jT6OzZvHcWCM68Lk0szuaP
	2vMZNLBjxGnHYz9xTp6hjddbjtmKk4o1/6O6gwGrX6yA1ObTcJpPlCBQ7XuMRRv7PTbYgrwBGGv
	/auWL+PzYyHqKhLCrMWMxzEkpmCabb2yP0Ru0bU9WRJqBQIDmvundJaJiv7Qqbw==
X-Gm-Gg: ASbGncsATJrLeHGPPK0os22CBaMXnbZ59NKAElMAhCqQ7bX5Egh2bEha4ahJRQMMXSK
	CaGsnMLNvFkMkPMhGg7ovMhd5TIcXFlyujoTVCFZdMWQpW7U1mcS/V3W7XLiq9VKcdlbe7B9uG6
	IQ3PNh+likGlVfae7nAVIIa/HbXIOvRM3isAgb2+PwurdyboKUcVUeZRcYCVodTyMHzgGOECxNR
	yWzMt75vD2kc/Yd/mTD6spVj2broL762VWTR/YpqySXV4GQjfPJFWYhFwFeq0HlZI6S8LdrLVzT
	GVE+v/YC/M1wCUZnd8qpcQo28eWzLemoKzQqS84VK8ub4P9pRLPSL+leuhkQ5/RPpJ4s6Up3NhR
	Urw==
X-Received: by 2002:a05:600c:34d1:b0:42a:a6d2:3270 with SMTP id 5b1f17b1804b1-4334f0213e0mr32288565e9.21.1732128627729;
        Wed, 20 Nov 2024 10:50:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhlDL9j6M2JgjOneawDfKdU8xs1lHM3Sw9OHm7fgSKp8aD+DzZhHY5qzzzehKedtFlb/3Wdw==
X-Received: by 2002:a05:600c:34d1:b0:42a:a6d2:3270 with SMTP id 5b1f17b1804b1-4334f0213e0mr32288485e9.21.1732128627406;
        Wed, 20 Nov 2024 10:50:27 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:4200:ce79:acf6:d832:60df? (p200300cbc7054200ce79acf6d83260df.dip0.t-ipconnect.de. [2003:cb:c705:4200:ce79:acf6:d832:60df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b45fb5f6sm28123725e9.15.2024.11.20.10.50.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 10:50:26 -0800 (PST)
Message-ID: <b8002d24-9817-4913-8da6-c652e58a971c@redhat.com>
Date: Wed, 20 Nov 2024 19:50:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] general protection fault in do_migrate_pages
To: syzbot <syzbot+3511625422f7aa637f0d@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com
References: <673d2696.050a0220.3c9d61.012f.GAE@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <673d2696.050a0220.3c9d61.012f.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.11.24 01:00, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f868cd251776 Merge tag 'drm-fixes-2024-11-16' of https://g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15473cc0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ff8e8187a30080b5
> dashboard link: https://syzkaller.appspot.com/bug?extid=3511625422f7aa637f0d
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17e8d130580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=159c71a7980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/a0d46da55993/disk-f868cd25.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/da57ef4813fd/vmlinux-f868cd25.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/3cdde892ea08/bzImage-f868cd25.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3511625422f7aa637f0d@syzkaller.appspotmail.com
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 1 UID: 0 PID: 6021 Comm: syz-executor284 Not tainted 6.12.0-rc7-syzkaller-00187-gf868cd251776 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
> RIP: 0010:migrate_to_node mm/mempolicy.c:1090 [inline]
> RIP: 0010:do_migrate_pages+0x403/0x6f0 mm/mempolicy.c:1194
> Code: 8b 54 24 30 41 83 c8 10 80 3a 00 4d 63 c0 0f 85 d1 02 00 00 48 89 c1 48 8b 54 24 18 48 be 00 00 00 00 00 fc ff df 48 c1 e9 03 <80> 3c 31 00 48 8b 92 b0 00 00 00 0f 85 74 02 00 00 48 8b 30 49 89
> RSP: 0018:ffffc9000375fd08 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffffc9000375fd78 RCX: 0000000000000000
> RDX: ffff88807e171300 RSI: dffffc0000000000 RDI: ffff88803390c044
> RBP: ffff88807e171428 R08: 0000000000000014 R09: fffffbfff2039ef1
> R10: ffffffff901cf78f R11: 0000000000000000 R12: 0000000000000003
> R13: ffffc9000375fe90 R14: ffffc9000375fe98 R15: ffffc9000375fdf8
> FS:  00005555919e1380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005555919e1ca8 CR3: 000000007f12a000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   kernel_migrate_pages+0x5b2/0x750 mm/mempolicy.c:1709
>   __do_sys_migrate_pages mm/mempolicy.c:1727 [inline]
>   __se_sys_migrate_pages mm/mempolicy.c:1723 [inline]
>   __x64_sys_migrate_pages+0x96/0x100 mm/mempolicy.c:1723
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fedcca74af9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe4d85c278 EFLAGS: 00000206 ORIG_RAX: 0000000000000100
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fedcca74af9
> RDX: 0000000020000000 RSI: 000000000000005a RDI: 0000000000001786
> RBP: 0000000000010bf2 R08: 0000000000006080 R09: 0000000000000006
> R10: 0000000020000040 R11: 0000000000000206 R12: 00007ffe4d85c28c
> R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
>   </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:migrate_to_node mm/mempolicy.c:1090 [inline]
> RIP: 0010:do_migrate_pages+0x403/0x6f0 mm/mempolicy.c:1194
> Code: 8b 54 24 30 41 83 c8 10 80 3a 00 4d 63 c0 0f 85 d1 02 00 00 48 89 c1 48 8b 54 24 18 48 be 00 00 00 00 00 fc ff df 48 c1 e9 03 <80> 3c 31 00 48 8b 92 b0 00 00 00 0f 85 74 02 00 00 48 8b 30 49 89
> RSP: 0018:ffffc9000375fd08 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffffc9000375fd78 RCX: 0000000000000000
> RDX: ffff88807e171300 RSI: dffffc0000000000 RDI: ffff88803390c044
> RBP: ffff88807e171428 R08: 0000000000000014 R09: fffffbfff2039ef1
> R10: ffffffff901cf78f R11: 0000000000000000 R12: 0000000000000003
> R13: ffffc9000375fe90 R14: ffffc9000375fe98 R15: ffffc9000375fdf8
> FS:  00005555919e1380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005555919e1ca8 CR3: 000000007f12a000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>     0:	8b 54 24 30          	mov    0x30(%rsp),%edx
>     4:	41 83 c8 10          	or     $0x10,%r8d
>     8:	80 3a 00             	cmpb   $0x0,(%rdx)
>     b:	4d 63 c0             	movslq %r8d,%r8
>     e:	0f 85 d1 02 00 00    	jne    0x2e5
>    14:	48 89 c1             	mov    %rax,%rcx
>    17:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
>    1c:	48 be 00 00 00 00 00 	movabs $0xdffffc0000000000,%rsi
>    23:	fc ff df
>    26:	48 c1 e9 03          	shr    $0x3,%rcx
> * 2a:	80 3c 31 00          	cmpb   $0x0,(%rcx,%rsi,1) <-- trapping instruction
>    2e:	48 8b 92 b0 00 00 00 	mov    0xb0(%rdx),%rdx
>    35:	0f 85 74 02 00 00    	jne    0x2af
>    3b:	48 8b 30             	mov    (%rax),%rsi
>    3e:	49                   	rex.WB
>    3f:	89                   	.byte 0x89
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.


#syz test: https://github.com/davidhildenbrand/linux.git mempolicy_vma

-- 
Cheers,

David / dhildenb


