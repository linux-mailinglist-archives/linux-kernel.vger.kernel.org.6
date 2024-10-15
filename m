Return-Path: <linux-kernel+bounces-365492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 736D499E320
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32755283B54
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4681E2821;
	Tue, 15 Oct 2024 09:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vpkj2WDQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC1C7F7FC
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728985919; cv=none; b=Q3f6jQhgKAlwo8//SknR05DzH3GaWOYlYFH2xhna4B7r6qmxL65SPLYRbyqQ3Ep6eHVBt75oOmoFy6gErVhe+eR52n5BV3JQM1Htb3qpWk1K8yqO0t2a+TnQ1dq1BPjU7HWXw0IB27v00Mn0T9UgvrA7y7vNS7Gn5Jd56SlKbYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728985919; c=relaxed/simple;
	bh=HmWQMj75jVZljrNNrEilXWdTcPk4fZm1jW0UIrw7fZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jIi4AynDBkVut7ZGztjDkK/rcv5sZP9Y7H28V3pkB9eBjsDL+7KIjVsbomaRB+hJ7bGdDVBQ+paLsW0DCu2DuZd7fvGYBS4NFueMDJ25FRNnbicOK3VaBoqkFjXQ8mIYeb0Gn+8m72jMg+4k2fgVsQXMjrkHSawd9dZoKQdgMzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vpkj2WDQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728985916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sWpdxXD5AEA7cVTQMQjs69Oeju5EVxQlIN2Y5RRfkiQ=;
	b=Vpkj2WDQD8Q7BPZnQDTGDW9u6zgq1c8lZvDlzSN1OS2OE4RgtCHkR+p86JMDUvsehmBdjD
	wKDQEZxiKQUeJCm94/jkwvI2ocD5+NCS5FV/RzF1BYRg/r39SgbXMTSDSnQ8kM3swZDoYO
	+DwCgaemZZGpNGVXMOAgpzl/n9zjSUU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-A8Zcm0-iMNiLQIljX2ag3A-1; Tue, 15 Oct 2024 05:51:54 -0400
X-MC-Unique: A8Zcm0-iMNiLQIljX2ag3A-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4311c5e8c02so25534695e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 02:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728985913; x=1729590713;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWpdxXD5AEA7cVTQMQjs69Oeju5EVxQlIN2Y5RRfkiQ=;
        b=nAhwClk3QWmkTns0Vn6nbqrcPm9k6xEvjKwK76i5JIYiy75clv3B1HgaQLbEFmMyeB
         375SR8fi7SNZ1Yf9oMKeoKJREywbD2DZTBCijaU+0Sk9xxYFv2lfB8e1xqNyxoOMjuUg
         ipaewVvyTULdqvK/6VN1LL2jyfwb1sv0+wZmCY/PKmqx5qaZtUOdWGO2l0TRW83686VK
         DUpIk/NNqJf8DJu8L+Pc4Ob6/x/ZXAqqtACquHCjWdoCgoalxtxvOtakzhDu3zfJgdHZ
         1KtO5cPK8GJY2K18yCGtq863VcQaT6Rn3QGz3j6DI7OK+nhnPhfFGwkTriZWugdy2BEU
         RoTA==
X-Forwarded-Encrypted: i=1; AJvYcCVkxPFrwYy3dMI/NaNdcNJS1cZwMXZEUNZSNoeL2gK2gAs2w0j/Y/KlSohLEd4/W6TAON7sjAuR7aFTomw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbqVVpiVie1EqrCY44LBtrDzoFfPw1aAvQYumyD4slIpa0uqnI
	3fsNknVGTTOONwcRF2rN5zadz7zQnkXsQh8PHti3zauBm95s/RJ9YhB5jm+MY75T8xcDlBeGBHf
	v+nloYv8d2vuU+W4+JS2fdO0Qw1M/PxYhQYewd7j+6HLyGcTsj44smSQdbVb5VA==
X-Received: by 2002:a05:600c:3b28:b0:42e:93af:61c5 with SMTP id 5b1f17b1804b1-4311ded1a22mr132069065e9.14.1728985912772;
        Tue, 15 Oct 2024 02:51:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZ3W7qEKA0XU1c/4E9KjXK4MeQuBu94gq61u9IEffovjFc6XZ+wLkfizMGvDr7Mz5xaYoZvw==
X-Received: by 2002:a05:600c:3b28:b0:42e:93af:61c5 with SMTP id 5b1f17b1804b1-4311ded1a22mr132068885e9.14.1728985912340;
        Tue, 15 Oct 2024 02:51:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c730:9700:d653:fb19:75e5:ab5c? (p200300cbc7309700d653fb1975e5ab5c.dip0.t-ipconnect.de. [2003:cb:c730:9700:d653:fb19:75e5:ab5c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc45d63sm1112016f8f.117.2024.10.15.02.51.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 02:51:51 -0700 (PDT)
Message-ID: <e0861721-f32b-4d55-b653-0e60e7a4fc3a@redhat.com>
Date: Tue, 15 Oct 2024 11:51:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING in folio_walk_start
To: syzbot <syzbot+7d917f67c05066cec295@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com
References: <670d3248.050a0220.3e960.0064.GAE@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <670d3248.050a0220.3e960.0064.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.10.24 17:01, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    36c254515dc6 Merge tag 'powerpc-6.12-4' of git://git.kerne..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14edfb27980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=667b897270c8ae6
> dashboard link: https://syzkaller.appspot.com/bug?extid=7d917f67c05066cec295
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/62cbb10fcb60/disk-36c25451.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d63f77e475bd/vmlinux-36c25451.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/113b44f45a57/bzImage-36c25451.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+7d917f67c05066cec295@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 7022 at mm/pagewalk.c:815 folio_walk_start+0xef6/0x1160 mm/pagewalk.c:815
> Modules linked in:
> CPU: 1 UID: 0 PID: 7022 Comm: syz.3.435 Not tainted 6.12.0-rc2-syzkaller-00307-g36c254515dc6 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> RIP: 0010:folio_walk_start+0xef6/0x1160 mm/pagewalk.c:815
> Code: 90 0f 0b 90 49 81 ee 00 f0 ff 3f e9 1d f4 ff ff e8 8f b8 b1 ff 48 8b 7c 24 18 e8 85 9c 3a 09 e9 be f3 ff ff e8 7b b8 b1 ff 90 <0f> 0b 90 e9 22 f5 ff ff e8 6d b8 b1 ff 31 ff 89 ee e8 a4 ba b1 ff
> RSP: 0018:ffffc900096bfc80 EFLAGS: 00010287
> RAX: 0000000000004c5c RBX: ffff88807bc61c98 RCX: ffffc9000a2ba000
> RDX: 0000000000040000 RSI: ffffffff81db0095 RDI: 0000000000000007
> RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000000
> R10: 0000000000000080 R11: 0000000000000000 R12: fff00000001fffff
> R13: ffffc900096bfe28 R14: 0000000000000080 R15: ffff88802f484000
> FS:  00007f53545676c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000110c321de8 CR3: 0000000047274000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   add_folio_for_migration mm/migrate.c:2244 [inline]
>   do_pages_move mm/migrate.c:2346 [inline]
>   kernel_move_pages+0x619/0x15a0 mm/migrate.c:2553
>   __do_sys_move_pages mm/migrate.c:2567 [inline]
>   __se_sys_move_pages mm/migrate.c:2562 [inline]
>   __x64_sys_move_pages+0xe0/0x1c0 mm/migrate.c:2562
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f535377dff9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f5354567038 EFLAGS: 00000246 ORIG_RAX: 0000000000000117
> RAX: ffffffffffffffda RBX: 00007f5353936058 RCX: 00007f535377dff9
> RDX: 0000000020001100 RSI: 00000000000000d0 RDI: 0000000000000000
> RBP: 00007f53537f0296 R08: 0000000000000000 R09: 0000000000000002
> R10: 0000000020001140 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f5353936058 R15: 00007ffec6628d18
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
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
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

I suspect this won't work as there is no reproducer:

#syz test git@github.com:davidhildenbrand/linux.git foliowalk_leaf

-- 
Cheers,

David / dhildenb


