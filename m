Return-Path: <linux-kernel+bounces-431457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3681B9E3D88
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EF5F1641AF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6462B20B1E0;
	Wed,  4 Dec 2024 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="oZOwjBa8"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F381B21BA
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 15:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733324479; cv=none; b=ka5tlnJJjduHj7l8nplSqqzXnTSSLyNqT3OV9bcNH4CI4nvv6Ss9JGeE2bxldpbgTC7ND4II1zep8GV8dxwS8sJWh3G1UtcaHa85SjJ9jppuiC68icP68iSrilMz1xYLQFxL0kWDPtdnT0gYF+eL1/Zs+fPZVKvRzQhIPjTjzp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733324479; c=relaxed/simple;
	bh=6kjyngAnwpH6ls7V5d24AxdLuqf0alE2vR0sSf2qLag=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R0F6zzPz8uKSNYjrzhr6IjBagJdqyycqGemlPr0PpNhVy0ilQrf4i9tX3+FlzLFDa6OgMLnzx611+21D3hC6qLxYNzHhvEld8IihDNiLSutCBazuBTDvBZwnIB111/H5cVNPWFH/GxRV7FY+/mhCBTtOhCSKX8eZwREasR7LaVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=oZOwjBa8; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3ea45abb4e1so2899131b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 07:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733324476; x=1733929276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GU+LWkcgTUBKRbXJUWBk2tKb9KisMQLrnXNhHENNNSA=;
        b=oZOwjBa8S60GkP4U6jrZzpAVCnA+kwjtjpBs4hI0yIn1GFIAU9SzZ3sGTWKfdHLHf+
         /qI/MrZ7I85W5qq6XYssaEjlcbvUpf5Y775Jz/tg3ee3vXuC8juCpfbRxxLTnz21OU9+
         Q9MlRYcGi8aSvqvLhNwUokJBJC3VLQgdv1CotSTZfm4CU+nj+OOPKG2fnbpjGJ8Iu+uL
         qQ+bjwk31nyflF1rERRjkSaX+NssQaO+FEaux7w1m2W2K9/82xjiyPkgLphv5obAeUIz
         lTY63XsFnb+OLRL3Ur6lhs1W9RTEMiPh224I0TNznaX65rCbQk2t+xP7r6CZ9jbNF8Rs
         UkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733324476; x=1733929276;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GU+LWkcgTUBKRbXJUWBk2tKb9KisMQLrnXNhHENNNSA=;
        b=F0/9/2h1shSrdJ/FIzKfF3CcHhfKIr06N48F2XT6jnXj85MUlgmmGJzk6a/LyF/L3d
         jRlAnc7SD9zU3vyQZJ5sifficeDTXt3HjPoHttPNq8LEcFLX1sgUr878wG59g/gUsskB
         f3s64jARhOaNdqN2LsVEEQnZtLMKcp9wqmEmL7w81t2MLYP/dNBD2RqshXZ6S+WG02bq
         87udFPswl46ZPhVWcCDUEvq+u6fHVT+JdMnCrBOwIUYjRwSXXgHLalsAdues8KuJx/ge
         ld2dEz4ar3S69buBKPa/JQ1nG33hA8Eosv6QYmCcbCgUb6/aRxlvkpHSJ0/e42jEF6Z4
         093w==
X-Forwarded-Encrypted: i=1; AJvYcCUPuc4JmuYVgZ87P54SzsEVoR2naFdxOeL/yUJHt630iG+KCSpA5AkW7q6bWmQ+cJJqcLMAmF2PUZEyQjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVI+oGFvbXGzT97DMhj80Cfzb/ehSNFZW7ybL32fc/GwelDCN9
	E8ntybAS/tASP8r1o9T/geUkfEepUYE0Z79AWrZBQzVM4UdpwNGJwnvkgSaZ5FQ=
X-Gm-Gg: ASbGncs8g58zB3lHAKPBfQhnbKEIa3+qvRcMGSwbGIFvF+W+rlQ2idIim7GuNcjhIHe
	5j4+Ep7iM3bmjDdymn81n9Sc+Ot/a7VtZ+xr3luKFLqWiBisZJ/d9B4NlhQcyvotwfRz9Xf+pVe
	CwCqRBM0JK/TK4qnDOgF7/ZDSnB3OUjTaDzEXQ050p2wwiKu/sZpyjTH23H0/1bGghZ2dxTXD0n
	ficvqB29mEy0jc7vjmMjbQSrCM41jYTIFb6L0Bk1LFgDvOl
X-Google-Smtp-Source: AGHT+IFKmmrKt72kBSqpTqcbtxEF3R5Y2zboMiL6UtgHDWZL9dVc3fUYJ+oRiHg2rky5L2PB5/7ppw==
X-Received: by 2002:a05:6808:219f:b0:3ea:4ec7:79cc with SMTP id 5614622812f47-3eae4ec7d31mr7289593b6e.3.1733324475602;
        Wed, 04 Dec 2024 07:01:15 -0800 (PST)
Received: from [172.20.2.46] ([130.250.255.163])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ea860d92dcsm3375114b6e.24.2024.12.04.07.01.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 07:01:14 -0800 (PST)
Message-ID: <6be84787-b1d9-4a20-85f3-34d8d9a0d492@kernel.dk>
Date: Wed, 4 Dec 2024 08:01:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] KASAN: null-ptr-deref Write in
 sys_io_uring_register
To: syzbot <syzbot+092bbab7da235a02a03a@syzkaller.appspotmail.com>,
 asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <67505f88.050a0220.17bd51.0069.GAE@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <67505f88.050a0220.17bd51.0069.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/4/24 6:56 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c245a7a79602 Add linux-next specific files for 20241203
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=10ae840f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=af3fe1d01b9e7b7
> dashboard link: https://syzkaller.appspot.com/bug?extid=092bbab7da235a02a03a
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a448df980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15cca330580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/8cc90a2ea120/disk-c245a7a7.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/0f6b1a1a0541/vmlinux-c245a7a7.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9fa3eac09ddc/bzImage-c245a7a7.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+092bbab7da235a02a03a@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: null-ptr-deref in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
> BUG: KASAN: null-ptr-deref in atomic_long_sub_and_test include/linux/atomic/atomic-instrumented.h:4521 [inline]
> BUG: KASAN: null-ptr-deref in put_cred_many include/linux/cred.h:255 [inline]
> BUG: KASAN: null-ptr-deref in put_cred include/linux/cred.h:269 [inline]
> BUG: KASAN: null-ptr-deref in io_unregister_personality io_uring/register.c:82 [inline]
> BUG: KASAN: null-ptr-deref in __io_uring_register io_uring/register.c:698 [inline]
> BUG: KASAN: null-ptr-deref in __do_sys_io_uring_register io_uring/register.c:902 [inline]
> BUG: KASAN: null-ptr-deref in __se_sys_io_uring_register+0x1227/0x3b60 io_uring/register.c:879
> Write of size 8 at addr 0000000000000406 by task syz-executor274/5828
> 
> CPU: 1 UID: 0 PID: 5828 Comm: syz-executor274 Not tainted 6.13.0-rc1-next-20241203-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_report+0xe8/0x550 mm/kasan/report.c:492
>  kasan_report+0x143/0x180 mm/kasan/report.c:602
>  kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
>  instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
>  atomic_long_sub_and_test include/linux/atomic/atomic-instrumented.h:4521 [inline]
>  put_cred_many include/linux/cred.h:255 [inline]
>  put_cred include/linux/cred.h:269 [inline]
>  io_unregister_personality io_uring/register.c:82 [inline]
>  __io_uring_register io_uring/register.c:698 [inline]
>  __do_sys_io_uring_register io_uring/register.c:902 [inline]
>  __se_sys_io_uring_register+0x1227/0x3b60 io_uring/register.c:879
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f65bbcb03a9
> Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe8fac7478 EFLAGS: 00000246 ORIG_RAX: 00000000000001ab
> RAX: ffffffffffffffda RBX: 000000000000371d RCX: 00007f65bbcb03a9
> RDX: 0000000000000000 RSI: 000000000000000a RDI: 0000000000000003
> RBP: 0000000000000003 R08: 00000000000ac5f8 R09: 00000000000ac5f8
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffe8fac7648 R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
> ==================================================================

Not sure what's going on with -next, but this looks like nonsense - we
store a valid pointer in the xarry, and then attempt to delete an
invalid index which then returns a totally garbage pointer!? I'll check
what is in -next, but this very much does not look like an io_uring
issue.

-- 
Jens Axboe

