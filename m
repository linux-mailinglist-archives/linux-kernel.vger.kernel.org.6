Return-Path: <linux-kernel+bounces-416191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC339D41DF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6422A1F22F37
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 18:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4880B1F931;
	Wed, 20 Nov 2024 18:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WI1MXt/k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0DE1B9B50
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 18:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732126313; cv=none; b=s5BWY7XxUwDZvUo7HDx3KdzECTYYevfWq8Fstpgg+KTMvxwR5WgVRN/MgFox5sUGlWz4Q3iCo1V6wUsch1AUBvxYYrkVkg6DmZ10yoEpdT15mCgkjkDqWtXvveQtB/MqH0bQ656KF9MjBDarYPf0cMTWzLBxWTPqYznzHnY1eT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732126313; c=relaxed/simple;
	bh=Qi9pn91FZEyBD2Trbyjdlg736aNrUqZz3dJEgk5Yicw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=JYz0Dr8oi21+iZpg1kaR8Jd+A/sOQW0gevs2eEdlAj3e9JKSwiR7h4hMyHtcgLkmSZ26jSNx2d5OInMBqEgIU8Sz+/6Vc5GJRWiFOreYMajeQ2SuKHU6g1R8WQ4Wrpvmn26MOpgRm0nKWJ2dNmp73PS/skzcYAWD6DKPr0SaIO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WI1MXt/k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732126309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IkhSedlzgHeaG25ffdndZcLsKjOCYrEP4QPOqqFYZVQ=;
	b=WI1MXt/ktzC9lPWVXS2Wn+PAD/w6ZOwgpK90CLiqpr6P2A6kxQ2qXRSO5qv3VtnT3ANxYT
	Q4H3iRVYzH0M92KoJtP7Qh0zZ33/RtFCPHvUM721PhdtTEEVy5hFHln7sWwPiMwdl3cECK
	bfmkelmQA/I2L6Li8lKwlMhIiWJua84=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-PDSQA28cOZemdHo_BjXhBA-1; Wed, 20 Nov 2024 13:11:48 -0500
X-MC-Unique: PDSQA28cOZemdHo_BjXhBA-1
X-Mimecast-MFC-AGG-ID: PDSQA28cOZemdHo_BjXhBA
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3822ecd84b3so2175036f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 10:11:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732126307; x=1732731107;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:from:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkhSedlzgHeaG25ffdndZcLsKjOCYrEP4QPOqqFYZVQ=;
        b=qWKJogv7KmpBXuDCpU6KJVEx37GPDM4kGAh1pFhsd7DDGgsn9IgH+/XxJFZinqyLoA
         /BxtI4odLyPupJAIHht7RHvC9ukxXBkJKMxBi5qj5qGj0cB7qsFJnHgGQwM5W0jjS8Vu
         m8/KoQxbDCFSY4k5pjr8karYS6/wbSWr4FmmU3lNdOgcYiPLN3BooPL5/0uXca4IqaqB
         6ggvNfy5GN1uCGRgnnpwIFjJqrG2brd9oH5vNArobhdrolEr3YU4nLr0lqSlJUI8QVBS
         TxTiOSpJaX01bGqeEy2SY/+vdm3S8kXiVVYvFOi+rdTqTa7WWxazrj2v4DFBXaj4fvL+
         6sfw==
X-Forwarded-Encrypted: i=1; AJvYcCVmlhnK2KhAshwraqj030MYiZ7nYIdLYved1J1YizvfSHDBFlyN4E6gkaQ0w3cJbpT3SZsJOmueYX7cdeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzgjvhPGOdcVJu0rWsdIDLwBtqenoJawoXDl59+miCaDBpEix2
	KAbNpFtV1HqLnHHSL38zYggwetW1i03OMdKoMPvOSLtIRm18YX7m3CR+uj75EnLSgdWhPUXMaDg
	qRuw09MOupwnksW9dIDukFgqvLzYz0YyeQOhVH4FQyYtyt6Ap3OE0JjzQpJ2ot4SViEtKuQ==
X-Gm-Gg: ASbGnctE6Wws1DKNkRxiHmAiAAkmSfB7kIP/zOVdXGapMy6mCHdEj896CrWIdvnEaSr
	qduGTSnAD1JdHaMrqwDJWL8y47Xy0AO9ttJ5j05irBaD6Ate3uTrLms4hWF7pR8tzkVnaZ3bJ8B
	1B7YvQ7pSzhOICbs77+tmyYbXprbY9WZcvAdZyWtHdd4x5kY458CCT/brbbqETT5bw+FOTYmVEr
	e4g2v+R3MyN1SbuBW7P7tWZoMA9OuwBpSNSZWcIE2E6RR/rRm9zrAtT1+quSxNV7Mtw2qRyVY9e
	CIcS130iz/hxS3lbrHhTnoFfvQ3PWYoTZ/rRvC6AP/0pD3JE+P6ucrllau7opH5l3JRXPwDxWB1
	Qwg==
X-Received: by 2002:a5d:64a3:0:b0:382:4a4e:25bb with SMTP id ffacd0b85a97d-38254b20f51mr2676638f8f.46.1732126306739;
        Wed, 20 Nov 2024 10:11:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHmtsT/qDey+t7umr0NDsGhgqEzsIr1IuqjuW5psvbBT7VNg93EeVWXyK5bZtia6jGmZJI/w==
X-Received: by 2002:a5d:64a3:0:b0:382:4a4e:25bb with SMTP id ffacd0b85a97d-38254b20f51mr2676618f8f.46.1732126306338;
        Wed, 20 Nov 2024 10:11:46 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:4200:ce79:acf6:d832:60df? (p200300cbc7054200ce79acf6d83260df.dip0.t-ipconnect.de. [2003:cb:c705:4200:ce79:acf6:d832:60df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-382549052b5sm2696772f8f.13.2024.11.20.10.11.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 10:11:45 -0800 (PST)
Message-ID: <252adf0e-9a0b-4419-88eb-e94adc5c2320@redhat.com>
Date: Wed, 20 Nov 2024 19:11:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] general protection fault in do_migrate_pages
From: David Hildenbrand <david@redhat.com>
To: syzbot <syzbot+3511625422f7aa637f0d@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com
References: <673d2696.050a0220.3c9d61.012f.GAE@google.com>
 <13aa3ca2-00a3-4b9f-a052-261d873f017d@redhat.com>
 <a299097b-7070-44c4-97ec-40dcf87c5c21@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <a299097b-7070-44c4-97ec-40dcf87c5c21@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.11.24 17:39, David Hildenbrand wrote:
> On 20.11.24 16:38, David Hildenbrand wrote:
>> On 20.11.24 01:00, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    f868cd251776 Merge tag 'drm-fixes-2024-11-16' of https://g..
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=15473cc0580000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=ff8e8187a30080b5
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=3511625422f7aa637f0d
>>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17e8d130580000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=159c71a7980000
>>>
>>> Downloadable assets:
>>> disk image: https://storage.googleapis.com/syzbot-assets/a0d46da55993/disk-f868cd25.raw.xz
>>> vmlinux: https://storage.googleapis.com/syzbot-assets/da57ef4813fd/vmlinux-f868cd25.xz
>>> kernel image: https://storage.googleapis.com/syzbot-assets/3cdde892ea08/bzImage-f868cd25.xz
>>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>> Reported-by: syzbot+3511625422f7aa637f0d@syzkaller.appspotmail.com
>>>
>>> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
>>> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>>> CPU: 1 UID: 0 PID: 6021 Comm: syz-executor284 Not tainted 6.12.0-rc7-syzkaller-00187-gf868cd251776 #0
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
>>> RIP: 0010:migrate_to_node mm/mempolicy.c:1090 [inline]
>>> RIP: 0010:do_migrate_pages+0x403/0x6f0 mm/mempolicy.c:1194
>>> Code: 8b 54 24 30 41 83 c8 10 80 3a 00 4d 63 c0 0f 85 d1 02 00 00 48 89 c1 48 8b 54 24 18 48 be 00 00 00 00 00 fc ff df 48 c1 e9 03 <80> 3c 31 00 48 8b 92 b0 00 00 00 0f 85 74 02 00 00 48 8b 30 49 89
>>> RSP: 0018:ffffc9000375fd08 EFLAGS: 00010246
>>> RAX: 0000000000000000 RBX: ffffc9000375fd78 RCX: 0000000000000000
>>> RDX: ffff88807e171300 RSI: dffffc0000000000 RDI: ffff88803390c044
>>> RBP: ffff88807e171428 R08: 0000000000000014 R09: fffffbfff2039ef1
>>> R10: ffffffff901cf78f R11: 0000000000000000 R12: 0000000000000003
>>> R13: ffffc9000375fe90 R14: ffffc9000375fe98 R15: ffffc9000375fdf8
>>> FS:  00005555919e1380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 00005555919e1ca8 CR3: 000000007f12a000 CR4: 00000000003526f0
>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>> Call Trace:
>>>     <TASK>
>>>     kernel_migrate_pages+0x5b2/0x750 mm/mempolicy.c:1709
>>>     __do_sys_migrate_pages mm/mempolicy.c:1727 [inline]
>>>     __se_sys_migrate_pages mm/mempolicy.c:1723 [inline]
>>>     __x64_sys_migrate_pages+0x96/0x100 mm/mempolicy.c:1723
>>>     do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>>     do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>>>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>> RIP: 0033:0x7fedcca74af9
>>> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
>>> RSP: 002b:00007ffe4d85c278 EFLAGS: 00000206 ORIG_RAX: 0000000000000100
>>> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fedcca74af9
>>> RDX: 0000000020000000 RSI: 000000000000005a RDI: 0000000000001786
>>> RBP: 0000000000010bf2 R08: 0000000000006080 R09: 0000000000000006
>>> R10: 0000000020000040 R11: 0000000000000206 R12: 00007ffe4d85c28c
>>> R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
>>>     </TASK>
>>> Modules linked in:
>>> ---[ end trace 0000000000000000 ]---
>>> RIP: 0010:migrate_to_node mm/mempolicy.c:1090 [inline]
>>> RIP: 0010:do_migrate_pages+0x403/0x6f0 mm/mempolicy.c:1194
>>> Code: 8b 54 24 30 41 83 c8 10 80 3a 00 4d 63 c0 0f 85 d1 02 00 00 48 89 c1 48 8b 54 24 18 48 be 00 00 00 00 00 fc ff df 48 c1 e9 03 <80> 3c 31 00 48 8b 92 b0 00 00 00 0f 85 74 02 00 00 48 8b 30 49 89
>>> RSP: 0018:ffffc9000375fd08 EFLAGS: 00010246
>>> RAX: 0000000000000000 RBX: ffffc9000375fd78 RCX: 0000000000000000
>>> RDX: ffff88807e171300 RSI: dffffc0000000000 RDI: ffff88803390c044
>>> RBP: ffff88807e171428 R08: 0000000000000014 R09: fffffbfff2039ef1
>>> R10: ffffffff901cf78f R11: 0000000000000000 R12: 0000000000000003
>>> R13: ffffc9000375fe90 R14: ffffc9000375fe98 R15: ffffc9000375fdf8
>>> FS:  00005555919e1380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 00005555919e1ca8 CR3: 000000007f12a000 CR4: 00000000003526f0
>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>> ----------------
>>> Code disassembly (best guess):
>>>       0:	8b 54 24 30          	mov    0x30(%rsp),%edx
>>>       4:	41 83 c8 10          	or     $0x10,%r8d
>>>       8:	80 3a 00             	cmpb   $0x0,(%rdx)
>>>       b:	4d 63 c0             	movslq %r8d,%r8
>>>       e:	0f 85 d1 02 00 00    	jne    0x2e5
>>>      14:	48 89 c1             	mov    %rax,%rcx
>>>      17:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
>>>      1c:	48 be 00 00 00 00 00 	movabs $0xdffffc0000000000,%rsi
>>>      23:	fc ff df
>>>      26:	48 c1 e9 03          	shr    $0x3,%rcx
>>> * 2a:	80 3c 31 00          	cmpb   $0x0,(%rcx,%rsi,1) <-- trapping instruction
>>>      2e:	48 8b 92 b0 00 00 00 	mov    0xb0(%rdx),%rdx
>>>      35:	0f 85 74 02 00 00    	jne    0x2af
>>>      3b:	48 8b 30             	mov    (%rax),%rsi
>>>      3e:	49                   	rex.WB
>>>      3f:	89                   	.byte 0x89
>>>
>>
>> Hmmm, there is not much meat in this report :)
>>
>> The reproducer seems to execute migrate_pages() in a fork'ed child
>> process, and kills that process after a while. Not 100% sure if the
>> concurrent killing of the process is relevant.
>>
>> Before the child process calls migrate_pages(), it executes
>> MADV_DONTFORK on the complete address space (funny, I wonder what that
>> does ...) and then calls clone3() without CLONE_VM.
>>
> 
> After running it for a while in a VM with the given config:
> 
> [  827.514143][T37171] Oops: general protection fault, probably for
> non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
> [  827.516614][T37171] KASAN: null-ptr-deref in range
> [0x0000000000000000-0x0000000000000007]
> [  827.518162][T37171] CPU: 4 UID: 0 PID: 37171 Comm: repro4 Not tainted
> 6.12.0-rc7-00187-gf868cd251776 #99
> [  827.519935][T37171] Hardware name: QEMU Standard PC (Q35 + ICH9,
> 2009), BIOS 1.16.3-2.fc40 04/01/2014
> [  827.521648][T37171] RIP: 0010:do_migrate_pages+0x404/0x6e0
> [  827.522774][T37171] Code: 10 80 39 00 4d 63 c0 0f 85 9b 02 00 00 48
> be 00 00 00 00 00 fc ff df 48 8b 4c 24 28 48 8b 91 b0 00 00 00 48 89 c1
> 48 c1 e9 03 <80> 3c 31 00 0f 85 95 02 00 00 48 8b 30 49 89 d9 48 8b 4c
> 24 08 48
> [  827.526342][T37171] RSP: 0018:ffffc90028157ce8 EFLAGS: 00010256
> [  827.527480][T37171] RAX: 0000000000000000 RBX: ffffc90028157d68 RCX:
> 0000000000000000
> [  827.528942][T37171] RDX: 00007ffffffff000 RSI: dffffc0000000000 RDI:
> ffff88811dcd8444
> [  827.530406][T37171] RBP: 0000000000000003 R08: 0000000000000014 R09:
> ffff88811dcd8ad8
> [  827.531865][T37171] R10: ffffffff903e668f R11: 0000000000000000 R12:
> ffffc90028157e80
> [  827.533341][T37171] R13: ffff8881f3a2b0a8 R14: ffffc90028157e28 R15:
> ffffc90028157e88
> [  827.534806][T37171] FS:  00007f096d49f740(0000)
> GS:ffff8881f4a00000(0000) knlGS:0000000000000000
> [  827.536452][T37171] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  827.537672][T37171] CR2: 00007ff2dcb96810 CR3: 00000001eed18000 CR4:
> 0000000000750ef0
> [  827.539135][T37171] PKRU: 55555554
> [  827.539799][T37171] Call Trace:
> [  827.540407][T37171]  <TASK>
> [  827.540965][T37171]  ? die_addr.cold+0x8/0xd
> [  827.541823][T37171]  ? exc_general_protection+0x147/0x240
> [  827.542888][T37171]  ? asm_exc_general_protection+0x26/0x30
> [  827.543960][T37171]  ? do_migrate_pages+0x404/0x6e0
> [  827.544915][T37171]  ? do_migrate_pages+0x3cd/0x6e0
> [  827.545873][T37171]  ? __pfx_do_migrate_pages+0x10/0x10
> [  827.546895][T37171]  ? do_raw_spin_lock+0x12a/0x2b0
> [  827.547854][T37171]  ? apparmor_capable+0x11c/0x3b0
> [  827.548818][T37171]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  827.549878][T37171]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  827.550937][T37171]  ? security_capable+0x80/0x260
> [  827.551893][T37171]  kernel_migrate_pages+0x5b7/0x750
> [  827.552891][T37171]  ? __pfx_kernel_migrate_pages+0x10/0x10
> [  827.553975][T37171]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  827.555028][T37171]  ? rcu_is_watching+0x12/0xc0
> [  827.555938][T37171]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  827.557000][T37171]  __x64_sys_migrate_pages+0x96/0x100
> [  827.558022][T37171]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  827.559077][T37171]  ? lockdep_hardirqs_on+0x7b/0x110
> [  827.560052][T37171]  do_syscall_64+0xc7/0x250
> [  827.560909][T37171]  entry_SYSCALL_64_after_hwframe+0x77/0x7f

.. digging further, we call migrate_pages() with the pid of a process
we created using clone3(!CLONE_VM).

The crashing code is likely:

         vma = find_vma(mm, 0);
     722c:       e8 00 00 00 00          call   7231 <do_migrate_pages+0x3c1>
     7231:       48 8b 7c 24 28          mov    0x28(%rsp),%rdi
     7236:       31 f6                   xor    %esi,%esi
     7238:       e8 00 00 00 00          call   723d <do_migrate_pages+0x3cd>
                                       flags | MPOL_MF_DISCONTIG_OK, &pagelist);
     723d:       44 8b 44 24 3c          mov    0x3c(%rsp),%r8d
         nr_failed = queue_pages_range(mm, vma->vm_start, mm->task_size, &nmask,
     7242:       48 8b 4c 24 40          mov    0x40(%rsp),%rcx
                                       flags | MPOL_MF_DISCONTIG_OK, &pagelist);
     7247:       41 83 c8 10             or     $0x10,%r8d
         nr_failed = queue_pages_range(mm, vma->vm_start, mm->task_size, &nmask,
     724b:       80 39 00                cmpb   $0x0,(%rcx)
     724e:       4d 63 c0                movslq %r8d,%r8
     7251:       0f 85 9b 02 00 00       jne    74f2 <do_migrate_pages+0x682>
     7257:       48 be 00 00 00 00 00    movabs $0xdffffc0000000000,%rsi
     725e:       fc ff df
     7261:       48 8b 4c 24 28          mov    0x28(%rsp),%rcx
     7266:       48 8b 91 b0 00 00 00    mov    0xb0(%rcx),%rdx
     726d:       48 89 c1                mov    %rax,%rcx
     7270:       48 c1 e9 03             shr    $0x3,%rcx
     7274:       80 3c 31 00             cmpb   $0x0,(%rcx,%rsi,1)

<--- we seem toc rash here

     7278:       0f 85 95 02 00 00       jne    7513 <do_migrate_pages+0x6a3>
     727e:       48 8b 30                mov    (%rax),%rsi
     7281:       49 89 d9                mov    %rbx,%r9
     7284:       48 8b 4c 24 08          mov    0x8(%rsp),%rcx
     7289:       48 8b 7c 24 28          mov    0x28(%rsp),%rdi
     728e:       e8 8d 9a ff ff          call   d20 <queue_pages_range>
     7293:       48 89 44 24 30          mov    %rax,0x30(%rsp)
     7298:       e9 c4 00 00 00          jmp    7361 <do_migrate_pages+0x4f1>
         up_read(&mm->mmap_lock);
     729d:       e8 00 00 00 00          call   72a2 <do_migrate_pages+0x432>
     72a2:       4c 89 ef                mov    %r13,%rdi
     72a5:       e8 00 00 00 00          call   72aa <do_migrate_pages+0x43a>


Which would be do_migrate_pages()->migrate_to_node():

mmap_read_lock(mm);
vma = find_vma(mm, 0);
nr_failed = queue_pages_range(mm, vma->vm_start, mm->task_size, &nmask,
			      flags | MPOL_MF_DISCONTIG_OK, &pagelist);
mmap_read_unlock(mm);

... and it seems to fail before calling queue_pages_range() :/

Did we, for some reason get a vma=NULL, because someone is concurrently tearing down the MM?
-- 
Cheers,

David / dhildenb


