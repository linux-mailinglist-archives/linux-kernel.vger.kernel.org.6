Return-Path: <linux-kernel+bounces-290097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C81D4954F5F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F31761C242D9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C60A1C0DC0;
	Fri, 16 Aug 2024 16:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrnTxuBH"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D7B1BE85F;
	Fri, 16 Aug 2024 16:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723827364; cv=none; b=DDtxgIUIKleKUxfyIs/7zBqJG8+A8ooHZ/H+kDEn+2Tc2lO9ART38ZjFnxBi9Fx8GjcwmxSEQQIqDFaly/N4Z6APnh6sXMbEVy2IKs6aYFGg9WHESUv+UgO8H2+fBV7+alsS73eerxzZO7Mdw8Ca58v5//THG6aL2dVIWQJXTNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723827364; c=relaxed/simple;
	bh=SX3VrYx5Xg5zABiMLMmLry3Aks/eq+W4C1Fj5fYpKUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QnTkzGobkm6QTilaEa0g0NqD+9BYZaakSoxROQNPZH9LHe7RPPc4OSxQzFZDg9Z6dTHbDEvMAH4cKLTGIWrzXXB1fI0d+bodtQrjN3z4Q/WBRFBpp2BsTt2Ntj5tyVVMt3qB1zYOMKr8BZjJ6c/HRAsLLnIpoeb2yxNJkxigo+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrnTxuBH; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f01e9f53e3so34686661fa.1;
        Fri, 16 Aug 2024 09:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723827360; x=1724432160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNTYAuLguEm/KVzhzDONt+kKrDKZHthfsPB3DnaxLOE=;
        b=CrnTxuBHA8uENiCFyyNkyHCXelENRiD5Wj1WKtSXCxGcuEc4/K/YIeB7hJXFcj0zgi
         3qC2KxaB60TaEqTG7rizV0jxLCtI6/dQWbbopjc/0hBMQdy6EYgK0NpwVZ29J0QRKGw5
         0cDB2VY5fwHaxI4fMIeSQ4d8+NSRYobGiS0t9kcLGscoctmMnXAgu6I8+6bw7lH+BGUo
         AElhR/bhVgCxLarg0OoKUwkV81s6S2HT35NEoy0/WiI6nk14tjYDr/aspy0KTWCy5dqb
         2xX78XBIlgiCYvghmK+3rik0C7SOT556uEseJfMfHnPLn+rbwEfXRbPLbVcqS6wALieT
         8eug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723827360; x=1724432160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNTYAuLguEm/KVzhzDONt+kKrDKZHthfsPB3DnaxLOE=;
        b=NRPcK9LxHnlraGUKmrMCC9owBiX8t/r9yVT9AwTTnZGmwIy4vSifUV69tsj7CeuDrG
         XbpULKXMPMjn9y6uL+cnWiqsd9BWc6hXWMtNHGyfUs7of/fQlaOMtsiZ0UlgfW5dLpZU
         XCOCkmlRa3UnItcVUU8eFpSya/lpuP1/zFyyN2PDnEGeGcWEt8N9wqK2TT2C4kqNObcJ
         YincH/sop+GAxFubf9JyrQwcd+Kicy+v9rOhSLFpKmtUiblhkwdEZWn1f291raZ6wTpH
         KURoHoD55N35E4ulvX2I+5r2vz314UydACIdOYTZUAumEt5kdOBRCG8SrUqbHKlEW0h/
         cTwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWc9/UQp7hvix1r8HTeJilCYHn7mdwy2v0Zat2mCVO85e53fpMjYYnmNxKKH9qS/s4NtUYeignNyTgFZJYIeQMrTOuzzXZraH85UL138M4HxnVnKipKwnJLVbHJpsaiRzCCHaE/i8oy
X-Gm-Message-State: AOJu0Yz25wcdtVsBGjafL9yl6MHlQkD7mORLiApksFELk89fwFszy+Z8
	5VtIQ5iIEaLFPQFN4SZLLPUBWTNkQeUDvq0kfi+0yN/6TQVLnuW1Zd1F9rvm9G7+Ekc1zKzQLP0
	qlv1d3lU1GvdLTTMSWjJQDmA0v0s=
X-Google-Smtp-Source: AGHT+IHsk4aXpZLWNLR6slFmyVVdq4I/vtPxpETP6Cg81SVckhGjxhqzcz5+PKIg8r85RQMhWblRrLO94EwlWrc4YmM=
X-Received: by 2002:a2e:b5db:0:b0:2f1:67de:b536 with SMTP id
 38308e7fff4ca-2f3be5963fbmr29160261fa.24.1723827359824; Fri, 16 Aug 2024
 09:55:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813120328.1275952-1-usamaarif642@gmail.com>
 <20240813120328.1275952-2-usamaarif642@gmail.com> <CAMgjq7DhdSXMHPLa3AHgAtcRN0A7pemTFFd1h19w4H_qyUMZMQ@mail.gmail.com>
 <a4b1b34f-0d8c-490d-ab00-eaedbf3fe780@gmail.com>
In-Reply-To: <a4b1b34f-0d8c-490d-ab00-eaedbf3fe780@gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 17 Aug 2024 00:55:43 +0800
Message-ID: <CAMgjq7BisxrVBSdNfmXWVP1FBx_yEoxe6=HWfoeGyMV+8UmLCA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] mm: free zapped tail pages when splitting isolated thp
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	riel@surriel.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev, 
	yuzhao@google.com, david@redhat.com, baohua@kernel.org, ryan.roberts@arm.com, 
	rppt@kernel.org, willy@infradead.org, cerasuolodomenico@gmail.com, 
	corbet@lwn.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	kernel-team@meta.com, Shuang Zhai <zhais@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 3:16=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
> On 15/08/2024 19:47, Kairui Song wrote:
> > On Tue, Aug 13, 2024 at 8:03=E2=80=AFPM Usama Arif <usamaarif642@gmail.=
com> wrote:
> >>
> >> From: Yu Zhao <yuzhao@google.com>
> >>
> >> If a tail page has only two references left, one inherited from the
> >> isolation of its head and the other from lru_add_page_tail() which we
> >> are about to drop, it means this tail page was concurrently zapped.
> >> Then we can safely free it and save page reclaim or migration the
> >> trouble of trying it.
> >>
> >> Signed-off-by: Yu Zhao <yuzhao@google.com>
> >> Tested-by: Shuang Zhai <zhais@google.com>
> >> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> >> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> >> ---
> >>  mm/huge_memory.c | 27 +++++++++++++++++++++++++++
> >>  1 file changed, 27 insertions(+)
> >
> > Hi, Usama, Yu
> >
> > This commit is causing the kernel to panic very quickly with build
> > kernel test on top of tmpfs with all mTHP enabled, the panic comes
> > after:
> >
>
> Hi,
>
> Thanks for pointing this out. It is a very silly bug I have introduced go=
ing from v1 page version to the folio version of the patch in v3.
>
> Doing below over this patch will fix it:
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 907813102430..a6ca454e1168 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3183,7 +3183,7 @@ static void __split_huge_page(struct page *page, st=
ruct list_head *list,
>
>                         folio_clear_active(new_folio);
>                         folio_clear_unevictable(new_folio);
> -                       if (!folio_batch_add(&free_folios, folio)) {
> +                       if (!folio_batch_add(&free_folios, new_folio)) {
>                                 mem_cgroup_uncharge_folios(&free_folios);
>                                 free_unref_folios(&free_folios);
>                         }
>
>
> I will include it in the next revision.
>

Hi,

After the fix, I'm still seeing below panic:
[   24.926629] list_del corruption. prev->next should be
ffffea000491cf88, but was ffffea0006207708. (prev=3Dffffea000491cfc8)
[   24.930783] ------------[ cut here ]------------
[   24.932519] kernel BUG at lib/list_debug.c:64!
[   24.934325] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[   24.936339] CPU: 32 UID: 0 PID: 2112 Comm: gzip Not tainted
6.11.0-rc3.ptch+ #147
[   24.938575] Hardware name: Red Hat KVM/RHEL-AV, BIOS 0.0.0 02/06/2015
[   24.940680] RIP: 0010:__list_del_entry_valid_or_report+0xaa/0xc0
[   24.942536] Code: 8c ff 0f 0b 48 89 fe 48 c7 c7 f8 9d 51 82 e8 9d
36 8c ff 0f 0b 48 89 d1 48 89 f2 48 89 fe 48 c7 c7 30 9e 51 82 e8 86
36 8c ff <0f> 0b 48 c7 c7 80 9e 51 82 e8 78 36 8c ff 0f 0b 66 0f 1f 44
00 00
[   24.948418] RSP: 0018:ffffc90005c2b770 EFLAGS: 00010246
[   24.949996] RAX: 000000000000006d RBX: ffffea000491cf88 RCX: 00000000000=
00000
[   24.952293] RDX: 0000000000000000 RSI: ffff889ffee1c180 RDI: ffff889ffee=
1c180
[   24.954616] RBP: ffffea000491cf80 R08: 0000000000000000 R09: c0000000fff=
f7fff
[   24.956908] R10: 0000000000000001 R11: ffffc90005c2b5a8 R12: ffffc90005c=
2b954
[   24.959253] R13: ffffc90005c2bbc0 R14: ffffc90005c2b7c0 R15: ffffc90005c=
2b940
[   24.961410] FS:  00007fe5a235e740(0000) GS:ffff889ffee00000(0000)
knlGS:0000000000000000
[   24.963587] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   24.965112] CR2: 00007fe5a24ddcd0 CR3: 000000010cb40001 CR4: 00000000007=
70eb0
[   24.967037] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[   24.968933] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[   24.970802] PKRU: 55555554
[   24.971559] Call Trace:
[   24.972241]  <TASK>
[   24.972805]  ? __die_body+0x1e/0x60
[   24.973756]  ? die+0x3c/0x60
[   24.974450]  ? do_trap+0xe8/0x110
[   24.975235]  ? __list_del_entry_valid_or_report+0xaa/0xc0
[   24.976543]  ? do_error_trap+0x65/0x80
[   24.977542]  ? __list_del_entry_valid_or_report+0xaa/0xc0
[   24.978891]  ? exc_invalid_op+0x50/0x70
[   24.979870]  ? __list_del_entry_valid_or_report+0xaa/0xc0
[   24.981295]  ? asm_exc_invalid_op+0x1a/0x20
[   24.982389]  ? __list_del_entry_valid_or_report+0xaa/0xc0
[   24.983781]  shrink_folio_list+0x39a/0x1200
[   24.984898]  shrink_inactive_list+0x1c0/0x420
[   24.986082]  shrink_lruvec+0x5db/0x780
[   24.987078]  shrink_node+0x243/0xb00
[   24.988063]  ? get_pfnblock_flags_mask.constprop.117+0x1d/0x50
[   24.989622]  do_try_to_free_pages+0xbd/0x4e0
[   24.990732]  try_to_free_mem_cgroup_pages+0x107/0x230
[   24.992034]  try_charge_memcg+0x184/0x5d0
[   24.993145]  obj_cgroup_charge_pages+0x38/0x110
[   24.994326]  __memcg_kmem_charge_page+0x8d/0xf0
[   24.995531]  __alloc_pages_noprof+0x278/0x360
[   24.996712]  alloc_pages_mpol_noprof+0xf0/0x230
[   24.997896]  pipe_write+0x2ad/0x5f0
[   24.998837]  ? __pfx_tick_nohz_handler+0x10/0x10
[   25.000234]  ? update_process_times+0x8c/0xa0
[   25.001377]  ? timerqueue_add+0x77/0x90
[   25.002257]  vfs_write+0x39b/0x420
[   25.003083]  ksys_write+0xbd/0xd0
[   25.003950]  do_syscall_64+0x47/0x110
[   25.004917]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   25.006210] RIP: 0033:0x7fe5a246f784
[   25.007149] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f
84 00 00 00 00 00 f3 0f 1e fa 80 3d c5 08 0e 00 00 74 13 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20
48 89
[   25.011961] RSP: 002b:00007ffdb0057b38 EFLAGS: 00000202 ORIG_RAX:
0000000000000001
[   25.013946] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fe5a24=
6f784
[   25.015817] RDX: 0000000000008000 RSI: 0000558c0d311420 RDI: 00000000000=
00001
[   25.017717] RBP: 00007ffdb0057b60 R08: 0000558c0d258c40 R09: 0000558c0d3=
11420
[   25.019618] R10: 00007ffdb0057600 R11: 0000000000000202 R12: 00000000000=
08000
[   25.021519] R13: 0000558c0d311420 R14: 0000000000000029 R15: 00000000000=
01f8d
[   25.023412]  </TASK>
[   25.023998] Modules linked in:
[   25.024900] ---[ end trace 0000000000000000 ]---
[   25.026329] RIP: 0010:__list_del_entry_valid_or_report+0xaa/0xc0
[   25.027885] Code: 8c ff 0f 0b 48 89 fe 48 c7 c7 f8 9d 51 82 e8 9d
36 8c ff 0f 0b 48 89 d1 48 89 f2 48 89 fe 48 c7 c7 30 9e 51 82 e8 86
36 8c ff <0f> 0b 48 c7 c7 80 9e 51 82 e8 78 36 8c ff 0f 0b 66 0f 1f 44
00 00
[   25.032525] RSP: 0018:ffffc90005c2b770 EFLAGS: 00010246
[   25.033892] RAX: 000000000000006d RBX: ffffea000491cf88 RCX: 00000000000=
00000
[   25.035758] RDX: 0000000000000000 RSI: ffff889ffee1c180 RDI: ffff889ffee=
1c180
[   25.037661] RBP: ffffea000491cf80 R08: 0000000000000000 R09: c0000000fff=
f7fff
[   25.039543] R10: 0000000000000001 R11: ffffc90005c2b5a8 R12: ffffc90005c=
2b954
[   25.041426] R13: ffffc90005c2bbc0 R14: ffffc90005c2b7c0 R15: ffffc90005c=
2b940
[   25.043323] FS:  00007fe5a235e740(0000) GS:ffff889ffee00000(0000)
knlGS:0000000000000000
[   25.045478] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   25.047013] CR2: 00007fe5a24ddcd0 CR3: 000000010cb40001 CR4: 00000000007=
70eb0
[   25.048935] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[   25.050858] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[   25.052881] PKRU: 55555554
[   25.053634] Kernel panic - not syncing: Fatal exception
[   25.056902] Kernel Offset: disabled
[   25.057827] ---[ end Kernel panic - not syncing: Fatal exception ]---

If I revert the fix and this patch, the panic is gone, let me know if
I can help debug it.

