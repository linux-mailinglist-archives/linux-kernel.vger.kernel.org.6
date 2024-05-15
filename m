Return-Path: <linux-kernel+bounces-180100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CD68C6A15
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A8281F233EF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 15:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A14156221;
	Wed, 15 May 2024 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAsBbdQT"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EB1156653
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715788729; cv=none; b=l1RWwRPvx6tLqIpjZyh9a9tvf6uNNp2mVsYmGJBBxAZ5KD5Dyys9zUsG5YCcf3JEGm3F0ttp21BRTcMI+PlPzf4rtrju9ltwfgGUkXSrX3lBcaI+jLkoY+BGstcWaurCs/Dv15TjDyG4F4bmIm2Xo+nce6nXqxhw7w1Wh+FcVDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715788729; c=relaxed/simple;
	bh=pGEkzf1qcpDKbJPPzrmpblwq6zQnfwhuHrqMW2Q8p3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PUeNBQT49ptcTcqTIIi59zO68rbZH8IaU4n0m10+yBm9KHNtgfWrn9HJ0i4k/+7iWEVFc0fBsh+bXCTNHljxj6GY0HPSZL6KR7udaW/8Bbv7SM5xiq+0uxCJDPsJ5mBjxh7Prr+k1fzpn7yVHlxpQrtoF14l6hFoaBIih3uCuII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAsBbdQT; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-574bf7ab218so2163626a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 08:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715788726; x=1716393526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6iRHbyNTGvr9sjRduejmHoKiGmzFnKEKB6uzL8EQKYw=;
        b=NAsBbdQTcdQhwAGLBtlhNfK09LweAKI7klmAVqVsriAPvuA9vfqjmUSQPiWve2ls8X
         n97YSM47IakOn1puzdjHvMSrkQx+NjfNkpMqqbPcInoY7RytG36yWMWWlw4Tm2sk+Lhg
         pWwVff+/cAZcnB/n3XIUKQfaDWj3cmvEN7MoBp5Pbc+DEOTLzek9yAmMW6w84okShdIc
         /Q6lXgKxWJ2qFnVy5mP6NfKRsoVF1GxjR6FyLFDIY18RmidAnhp1dpgquZwHdZaTOr0R
         1pd+rNBN92iVfQR1N4aL7zQegaB7cA4QblztVFjZ4ZrgauhdUzuQlR8an0NstzdEVeP0
         npmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715788726; x=1716393526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6iRHbyNTGvr9sjRduejmHoKiGmzFnKEKB6uzL8EQKYw=;
        b=c59br9af9lqUd6atUqxbb+DUnxYJjOGOdmVYAoPTq4IXw8lNJGq6xK6zGazZnNoxtx
         +ISfKVldJu77ZBbUZCX5e0gf1od93eIGObx50hLnF0kSd8QFm0RRilafRsJ0RgwdIUyn
         i+bhdyQDCg5DR2gxk2BY94nmJUvQCyNtiRc5jintd5OtWDO4EsoN56KurqXKaxAOspr0
         6NwTclqvDwzvc4RXuH4nRlKEu8ekrQoeBqb8ifKtlZH2uUvjB8nZ8ZRBYV4nzQ/6c7++
         VKznHXDByuvQ4K56tfXpYtmhMHuRj8SYf0QKJlVaXQgV6DIpO6uBLlZ4gT21kUyCZgsq
         lD4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVskd3iE96SiB+qEk4Aoj7djXGxJBEXasJCWiRKRhVmPSNaPBxlRFFc84878FU+YhQ7NKwXTmPBlwMETcuHLkP9omQp5olF1J+YD16X
X-Gm-Message-State: AOJu0Yyxwl6H3ycgRMyhQmyh/CCU6WIjlH2UAvsGGQ9FIdJiAoDLhHOK
	uoC6Fcfyjstfrxq3t/CmUlGVJaH6Zfga1WputBQy1pLru/4DaG+oKcNP3nG9At7LD78Mk1kyOUa
	v7udODfxsgLE+0MWPa2J0imxAf+s=
X-Google-Smtp-Source: AGHT+IEWavW0b5hH9Os46OQ//THLw953i+0xH4jkXXGxq/ZWERzJILGCxJY2Bdd4m6uSBXvQUtJ4tkMu+D5/qpgWivc=
X-Received: by 2002:a50:d684:0:b0:572:a13c:30ca with SMTP id
 4fb4d7f45d1cf-5734d5de823mr11907722a12.20.1715788725606; Wed, 15 May 2024
 08:58:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515023607.870022-1-linmiaohe@huawei.com>
In-Reply-To: <20240515023607.870022-1-linmiaohe@huawei.com>
From: Yang Shi <shy828301@gmail.com>
Date: Wed, 15 May 2024 09:58:32 -0600
Message-ID: <CAHbLzkrO9-yWRFrWoE0idWwMffkBWNSku6iO2vdPLCpWAY7wQg@mail.gmail.com>
Subject: Re: [PATCH v2] mm/huge_memory: don't unpoison huge_zero_folio
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: akpm@linux-foundation.org, nao.horiguchi@gmail.com, xuyu@linux.alibaba.com, 
	david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 8:39=E2=80=AFPM Miaohe Lin <linmiaohe@huawei.com> w=
rote:
>
> When I did memory failure tests recently, below panic occurs:
>
>  kernel BUG at include/linux/mm.h:1135!
>  invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>  CPU: 9 PID: 137 Comm: kswapd1 Not tainted 6.9.0-rc4-00491-gd5ce28f156fe-=
dirty #14
>  RIP: 0010:shrink_huge_zero_page_scan+0x168/0x1a0
>  RSP: 0018:ffff9933c6c57bd0 EFLAGS: 00000246
>  RAX: 000000000000003e RBX: 0000000000000000 RCX: ffff88f61fc5c9c8
>  RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff88f61fc5c9c0
>  RBP: ffffcd7c446b0000 R08: ffffffff9a9405f0 R09: 0000000000005492
>  R10: 00000000000030ea R11: ffffffff9a9405f0 R12: 0000000000000000
>  R13: 0000000000000000 R14: 0000000000000000 R15: ffff88e703c4ac00
>  FS:  0000000000000000(0000) GS:ffff88f61fc40000(0000) knlGS:000000000000=
0000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 000055f4da6e9878 CR3: 0000000c71048000 CR4: 00000000000006f0
>  Call Trace:
>   <TASK>
>   do_shrink_slab+0x14f/0x6a0
>   shrink_slab+0xca/0x8c0
>   shrink_node+0x2d0/0x7d0
>   balance_pgdat+0x33a/0x720
>   kswapd+0x1f3/0x410
>   kthread+0xd5/0x100
>   ret_from_fork+0x2f/0x50
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
>  Modules linked in: mce_inject hwpoison_inject
>  ---[ end trace 0000000000000000 ]---
>  RIP: 0010:shrink_huge_zero_page_scan+0x168/0x1a0
>  RSP: 0018:ffff9933c6c57bd0 EFLAGS: 00000246
>  RAX: 000000000000003e RBX: 0000000000000000 RCX: ffff88f61fc5c9c8
>  RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff88f61fc5c9c0
>  RBP: ffffcd7c446b0000 R08: ffffffff9a9405f0 R09: 0000000000005492
>  R10: 00000000000030ea R11: ffffffff9a9405f0 R12: 0000000000000000
>  R13: 0000000000000000 R14: 0000000000000000 R15: ffff88e703c4ac00
>  FS:  0000000000000000(0000) GS:ffff88f61fc40000(0000) knlGS:000000000000=
0000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 000055f4da6e9878 CR3: 0000000c71048000 CR4: 00000000000006f0
>
> The root cause is that HWPoison flag will be set for huge_zero_folio
> without increasing the folio refcnt. But then unpoison_memory() will
> decrease the folio refcnt unexpectly as it appears like a successfully
> hwpoisoned folio leading to VM_BUG_ON_PAGE(page_ref_count(page) =3D=3D 0)
> when releasing huge_zero_folio.
>
> Skip unpoisoning huge_zero_folio in unpoison_memory() to fix this issue.
> We're not prepared to unpoison huge_zero_folio yet.
>
> Fixes: 478d134e9506 ("mm/huge_memory: do not overkill when splitting huge=
_zero_page")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Cc: <stable@vger.kernel.org>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
> v2:
>  Change to simply check for the huge zero page. Thanks.
> ---
>  mm/memory-failure.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 16ada4fb02b7..68bc8d7ff53d 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2558,6 +2558,12 @@ int unpoison_memory(unsigned long pfn)
>                 goto unlock_mutex;
>         }
>
> +       if (is_huge_zero_folio(folio)) {
> +               unpoison_pr_info("Unpoison: huge zero page is not support=
ed %#lx\n",
> +                                pfn, &unpoison_rs);
> +               goto unlock_mutex;
> +       }
> +
>         if (folio_test_slab(folio) || folio_test_pgtable(folio) ||
>             folio_test_reserved(folio) || folio_test_offline(folio))
>                 goto unlock_mutex;
> --
> 2.33.0
>

