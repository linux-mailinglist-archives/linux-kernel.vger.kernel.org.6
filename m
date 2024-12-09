Return-Path: <linux-kernel+bounces-436929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA279E8CBB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1991C1880643
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9951A215072;
	Mon,  9 Dec 2024 07:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BjpYb6Ij"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A13215067
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 07:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733731120; cv=none; b=FHrxO3FLI77hN3NqWDvgwMKHd8jvUjyCtgpTTThhwQWxmuPkyI62SYrfCATS5TeUv/bvgxjTlb+CUqFsShBABvr0EkhlEIislnWcRWaSQGMk99EbtTkrLG0W25ljewBRJkfMY/6CP7gaAuzxkcL5NOsY+kBAaP6L7zgIgr0kGtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733731120; c=relaxed/simple;
	bh=ScdSRlYv1t/3IMRg7kjk7hx7y/yT9M18xFt3CJQe1v0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=JiUXhPReVOC92YAGmkJj3PV1XsxO3tT7FwThB863JCgYIXm2Epja00O30wMo16sh2LZvjt6vS3zvUEnjuVPj7hlF7V+IDi9iexySfwyvLj9dHXu5wUnPn2f3tsBSph/9jOJmZ3F9Gk4Jm4Xwv8KBr/lNc4oXtazXE1UV/STTTBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BjpYb6Ij; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2eeb4d643a5so3641332a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 23:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733731118; x=1734335918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8g2xdg9p5+uH4cGruNZ7ySDPkRDhVMxXNPc6aGQ32Hk=;
        b=BjpYb6Ij48wfmZBOYcVUKmByzdii/VI7Ob1r4Fi63YoovJXVa6/ITjzKXuMndeKR32
         r/zPZ7HNbpOKxKIzg5Yj9+RvNVM+4piD4er9KVN578JB8uBJ823UBZ9vYFv76+DTysvO
         od5cXv1lZ4RL0W0rERXxN1vAeBSVY7VQpVpo7ptvS5rK6Ooa0WThw/iqhD+qOunM+ikf
         ijUb4MxjuS97hDyyOTZD6vgeARi/B0uB8jg5FmEBfe4IocDUzkX7AgMCGJUfDe/7OZP/
         q807x6f7N0foDIIr2zjFyQAWkXT2oVTx/fuMgjW7+eKAwKUnGmxI7Qo+7LT2er3w79mc
         eyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733731118; x=1734335918;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8g2xdg9p5+uH4cGruNZ7ySDPkRDhVMxXNPc6aGQ32Hk=;
        b=jPtifhpceTOYrW/JMqTJP3Ho1dtk2kvaOX6bibqOHNuJwiJnc/R4WxBqhMEBWPmFS4
         TAjiF2G1lqVopYkWYlZRxUWinvoQc9KEE7j+ruOW7OszZPwIR9yNjGSNq7ZMAHegzIja
         jKHEo8NFKwoPvFr2FkAvgx0vEN9e1piApU++QRzYT+5A8WzS7YnKWsd5XiL+h0s6IWNt
         NpTjsC7mSiaOJUtUTTVvztoMXt9VnADJSFnhv0fkfBy9f270h33GUGWZZw39urR+M0/Q
         0DC37m+YQ5S0SxjEbKV6GtPaE23b32lkZvPQvSyLKQpNDqLouA3ZxMuk7fxNtT/BhSvH
         95hA==
X-Forwarded-Encrypted: i=1; AJvYcCXoVH3SdatA1mO71A/1R9R5OF/OLEj4nj4Fz3uyGKEWQVdUe7XEIkcHceZR4OigaO3ltCP6Cyus2mRjj70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+5XDwKTdcygmu7RUsDSJzhObOsGcbrOvn562vQll3KyomtsUd
	D9iA55W8l/jBr+S7ssLpNKz6VeVCTCgbmjpeziK6mHwYwOq0iCVsexLh9cB1YY4=
X-Gm-Gg: ASbGncuKUPh9y01e4vBkXhdZcqdQIBRkdQoGxKqx7EBiQXYejLVqVLkNSGYx/Q21J8H
	rnE8yPSEKZ290RJoSQcfbmG2L//zi3SxnYIQ8nDjcmtKdVjuV+l3+QRCj0xeXgyroXE1iCC4UJu
	zLHWDu2gedYAZctI+fsDPkOexrgeZLc0KHmAv4uCR+pDuvRi4yD08B5bkrKI8xo56tIIyFa6LgC
	VGhzH0G+nDZ5lxR45PKWVPsIZ5TJUMaaz8FbI32Q0+fqDUejej7Q/HrqXDuF7s+E6cZsLl2uA==
X-Google-Smtp-Source: AGHT+IHPR9lQduuFl9SmgV7fHugB2oUHPmbw4+VKgM0DNluz0xofkPR6h8mhwsz0kKeppVgZwt2Naw==
X-Received: by 2002:a17:90b:3a48:b0:2ee:9e06:7db0 with SMTP id 98e67ed59e1d1-2ef69e12619mr18427663a91.11.1733731117984;
        Sun, 08 Dec 2024 23:58:37 -0800 (PST)
Received: from [10.84.148.23] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2efa267857esm1972516a91.19.2024.12.08.23.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2024 23:58:37 -0800 (PST)
Message-ID: <e4f64f16-7b8c-4f77-beb3-336334a7d3ea@bytedance.com>
Date: Mon, 9 Dec 2024 15:58:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in move_pages_pte
Content-Language: en-US
To: syzbot <syzbot+1c58afed1cfd2f57efee@syzkaller.appspotmail.com>
References: <6756a166.050a0220.2477f.0039.GAE@google.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 mingo@redhat.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
 x86@kernel.org
In-Reply-To: <6756a166.050a0220.2477f.0039.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/12/9 15:51, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> WARNING in move_pages_pte
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 6741 at mm/userfaultfd.c:1188 move_pages_pte+0x26bb/0x3400 mm/userfaultfd.c:1188

The code of triggering warning is as follows:

	/* Sanity checks before the operation */
	if (WARN_ON_ONCE(pmd_none(*dst_pmd)) ||	WARN_ON_ONCE(pmd_none(*src_pmd)) ||
	    WARN_ON_ONCE(pmd_trans_huge(*dst_pmd)) || 
WARN_ON_ONCE(pmd_trans_huge(*src_pmd))) {
		err = -EINVAL;
		goto out;
	}

This is expected, we can just remove these WARN_ON_ONCE().

> Modules linked in:
> CPU: 0 UID: 0 PID: 6741 Comm: syz.0.36 Not tainted 6.13.0-rc1-syzkaller-00172-g6e165f544379-dirty #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> RIP: 0010:move_pages_pte+0x26bb/0x3400 mm/userfaultfd.c:1188
> Code: 8d ff b8 f5 ff ff ff e9 f9 f1 ff ff e8 de 41 8d ff 90 0f 0b 90 b8 ea ff ff ff 48 89 44 24 18 e9 9a fb ff ff e8 c6 41 8d ff 90 <0f> 0b 90 eb 14 e8 bb 41 8d ff 90 0f 0b 90 eb 09 e8 b0 41 8d ff 90
> RSP: 0018:ffffc900034871c0 EFLAGS: 00010293
> RAX: ffffffff8212016a RBX: 0000000000000000 RCX: ffff88801fbb9e00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffc90003487600 R08: ffffffff8211df31 R09: 1ffffffff2853d10
> R10: dffffc0000000000 R11: fffffbfff2853d11 R12: dffffc0000000000
> R13: 0000000000000000 R14: 00000000321be067 R15: 0000000000000000
> FS:  00007fd136ec86c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fd136ea6fb8 CR3: 0000000031194000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   move_pages+0xdd7/0x1600 mm/userfaultfd.c:1742
>   userfaultfd_move fs/userfaultfd.c:1899 [inline]
>   userfaultfd_ioctl+0x518b/0x6770 fs/userfaultfd.c:2022
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:906 [inline]
>   __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fd13617ff19
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fd136ec8058 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007fd136345fa0 RCX: 00007fd13617ff19
> RDX: 0000000020000080 RSI: 00000000c028aa05 RDI: 0000000000000003
> RBP: 00007fd1361f3986 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007fd136345fa0 R15: 00007ffd06723498
>   </TASK>
> 
> 
> Tested on:
> 
> commit:         6e165f54 mm/page_isolation: fixup isolate_single_pageb..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-unstable
> console output: https://syzkaller.appspot.com/x/log.txt?x=14142b30580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3884fb5fa6f2533c
> dashboard link: https://syzkaller.appspot.com/bug?extid=1c58afed1cfd2f57efee
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=11245944580000
> 

