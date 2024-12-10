Return-Path: <linux-kernel+bounces-440104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC039EB8D7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38E8C188138F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F9D1DE2B4;
	Tue, 10 Dec 2024 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="odh4QGOX"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A161B4220
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 17:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733853341; cv=none; b=T+p84TcnKV/Ucopn2dO5MCu9FtT3Pj4V7QUR7GKSOzgJJCMbPDB4OSBvra34zH+XySsFs+8xFAhAq4WkXhAk9F4LNjkNjIo8h3QaAtXJDs8Y+Hkhppxd2yI4ctqxUws3L6PS/LgC8QWzbgDdvpmSy7d9uKq70/nTjMdZGodEH1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733853341; c=relaxed/simple;
	bh=5Lqgn1nZKsEr1Zvz28/OBYcyY8ixJY1MStjrAlmKHLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJle7sfk8kJU+P+c4EE1tOwfuza7o5z7u0At0eTOYmhi6HrxVhtxqi8R90dRQVQrnnZFBawivZQJ8vKAVgYO14754D77BPEyaEOL8WsppvC9eHbJ5q9ifMXQjJxkF75SXVwLIaPGQeijKW3NGdaq2upuz9SRlWbBgK8o/clm2UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=odh4QGOX; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-467431402deso6951cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733853338; x=1734458138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyxl+ttUb9oKqLIiCZsmpPDMeBgG6nRk3s3B134NCU0=;
        b=odh4QGOXRDWmvRIvmgwewrBmsJ2Y9BbUIoHut6TnGtGg6S2/6BA5pi3cIN4BoF2iqz
         8/JhpA38J28LoNmW8T7aDjnMEpxZ8WUHf/ox7DDxTaDow1fPVOxR9VXXppL4A5up9lt7
         00SAwrVsredhVdNK8pB2D1YKmja3JTDzInrOGfvspT687eEt88iyyNF+iG/3lCKDEB6k
         iK+20Z/4coCY79ru/PMCeKzzM83J9clmdd+0cbCbuKh1gi6OSmGN4XP6Vl4FXHS7HdiB
         MgjeYX/JKTR95LqH6pPWtMMhyraOeXCmOWpZ2EY+YNDJIT1zWeAk7R+Y1HgoLXm6sp7f
         0aRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733853338; x=1734458138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tyxl+ttUb9oKqLIiCZsmpPDMeBgG6nRk3s3B134NCU0=;
        b=PL4mQwd18IAYMTOy9sMl3FYNGUqdV0G+wgckjpzDE8hHFStyA2jZBpH4erJV+2RoPC
         vGeYO3BG1imO0p2YNhYeUpVE5sBok2U4U2ZZVpb+rPOEoNiWtsdYJvQYFrMonPUp1cmc
         646z0Tf5WAaJXjcFEkkgNSctWF1xJhT75B0l2ji9Uisra9h1AbrarMchhlNQ4vpWFXVJ
         baigzrQJw5S+KQ5WvqbXHwQypXPk/uhicVNpTQ74xlWqh3WzEUklS3k9ovHumIko9hDG
         9IHzJagc66WgYCp1BDfUogq6nyE5rogX1FiifVWgRyb9CVkRmssDnOFXmH7cGYDtQCaB
         8AWA==
X-Forwarded-Encrypted: i=1; AJvYcCW8wM1plhzvi8bW0/1SXYrBY3nvQ0phFkPQ8AXtq8gOU45rKmOKCRErM8zNS2GmLiBhOH+lQWtfjjhl8Ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVntk6/UjBAQeNS+Nfr2Mq/9Gee6T/EuHaDBRjDOQcXESSjibp
	XT4WPCf0tnISzL8aqR7EfGc/jTwQFo8wR1yX+OCJ5MtXLhNo8FJqq0AO9ASUNsRfXlO15pI/A6X
	Y791wnZXEk6dxsQVgrEqBaavYMwZe3ToFmG5a
X-Gm-Gg: ASbGncsnq9lZxDZlACNascT0M811EMvgIShL5o2xSISdTXw77258k8BhkR+2OScn9Nv
	BkzWE9SiTrqiL+GQJGLyw7KLgtHvYdlfdYwoDL6u1WsNXtaWEQ4bB0gDXm+YrPlDHHg==
X-Google-Smtp-Source: AGHT+IG3VpXV1WLM2E+buv1L2blkpVBsdm3XboX8oZHVk8mJpLJ9ElOelY7ne/6rJJPBu93F7oJ1RCJlUW5nZaN1dfk=
X-Received: by 2002:a05:622a:5a19:b0:466:9b73:8e3c with SMTP id
 d75a77b69052e-46777658682mr4661321cf.13.1733853338141; Tue, 10 Dec 2024
 09:55:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210041515.765569-1-hao.ge@linux.dev> <20241210065304.781620-1-hao.ge@linux.dev>
In-Reply-To: <20241210065304.781620-1-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 10 Dec 2024 09:55:26 -0800
Message-ID: <CAJuCfpGVTyKJ5yMQUqvNXRfBnBYj+dhUEqq0YAddtrqcWP27yw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/alloc_tag: Add kasan_alloc_module_shadow when
 CONFIS_KASAN_VMALLOC disabled
To: Hao Ge <hao.ge@linux.dev>
Cc: kent.overstreet@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, greearb@candelatech.com, 
	Hao Ge <gehao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 10:53=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
>
> From: Hao Ge <gehao@kylinos.cn>
>
> When CONFIG_KASAN is enabled but CONFIG_KASAN_VMALLOC
> is not enabled, we may encounter a panic during system boot.
>
> Because we haven't allocated pages and created mappings
> for the shadow memory corresponding to module_tags region,
> similar to how it is done for execmem_vmalloc.
>
> The difference is that our module_tags are allocated on demand,
> so similarly,we also need to allocate shadow memory regions on demand.
> However, we still need to adhere to the MODULE_ALIGN principle.
>
> Here is the log for panic:
>
> [   18.349421] BUG: unable to handle page fault for address: fffffbfff809=
2000
> [   18.350016] #PF: supervisor read access in kernel mode
> [   18.350459] #PF: error_code(0x0000) - not-present page
> [   18.350904] PGD 20fe52067 P4D 219dc8067 PUD 219dc4067 PMD 102495067 PT=
E 0
> [   18.351484] Oops: Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
> [   18.351961] CPU: 5 UID: 0 PID: 1 Comm: systemd Not tainted 6.13.0-rc1+=
 #3
> [   18.352533] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [   18.353494] RIP: 0010:kasan_check_range+0xba/0x1b0
> [   18.353931] Code: 8d 5a 07 4c 0f 49 da 49 c1 fb 03 45 85 db 0f 84 dd 0=
0 00 00 45 89 db 4a 8d 14 d8 eb 0d 48 83 c0 08 48 39 c2 0f 84 c1 00 00 00 <=
48> 83 38 00 74 ed 48 8d 50 08 eb 0d 48 83 c0 01 48 39 d0 0f 84 90
> [   18.355484] RSP: 0018:ff11000101877958 EFLAGS: 00010206
> [   18.355937] RAX: fffffbfff8092000 RBX: fffffbfff809201e RCX: ffffffff8=
2a7ceac
> [   18.356542] RDX: fffffbfff8092018 RSI: 00000000000000f0 RDI: ffffffffc=
0490000
> [   18.357153] RBP: fffffbfff8092000 R08: 0000000000000001 R09: fffffbfff=
809201d
> [   18.357756] R10: ffffffffc04900ef R11: 0000000000000003 R12: ffffffffc=
0490000
> [   18.358365] R13: ff11000101877b48 R14: ffffffffc0490000 R15: 000000000=
000002c
> [   18.358968] FS:  00007f9bd13c5940(0000) GS:ff110001eb480000(0000) knlG=
S:0000000000000000
> [   18.359648] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   18.360178] CR2: fffffbfff8092000 CR3: 0000000109214004 CR4: 000000000=
0771ef0
> [   18.360790] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [   18.361404] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [   18.362020] PKRU: 55555554
> [   18.362261] Call Trace:
> [   18.362481]  <TASK>
> [   18.362671]  ? __die+0x23/0x70
> [   18.362964]  ? page_fault_oops+0xc2/0x160
> [   18.363318]  ? exc_page_fault+0xad/0xc0
> [   18.363680]  ? asm_exc_page_fault+0x26/0x30
> [   18.364056]  ? move_module+0x3cc/0x8a0
> [   18.364398]  ? kasan_check_range+0xba/0x1b0
> [   18.364755]  __asan_memcpy+0x3c/0x60
> [   18.365074]  move_module+0x3cc/0x8a0
> [   18.365386]  layout_and_allocate.constprop.0+0x3d5/0x720
> [   18.365841]  ? early_mod_check+0x3dc/0x510
> [   18.366195]  load_module+0x72/0x1850
> [   18.366509]  ? __pfx_kernel_read_file+0x10/0x10
> [   18.366918]  ? vm_mmap_pgoff+0x21c/0x2d0
> [   18.367262]  init_module_from_file+0xd1/0x130
> [   18.367638]  ? __pfx_init_module_from_file+0x10/0x10
> [   18.368073]  ? __pfx__raw_spin_lock+0x10/0x10
> [   18.368456]  ? __pfx_cred_has_capability.isra.0+0x10/0x10
> [   18.368938]  idempotent_init_module+0x22c/0x790
> [   18.369332]  ? simple_getattr+0x6f/0x120
> [   18.369676]  ? __pfx_idempotent_init_module+0x10/0x10
> [   18.370110]  ? fdget+0x58/0x3a0
> [   18.370393]  ? security_capable+0x64/0xf0
> [   18.370745]  __x64_sys_finit_module+0xc2/0x140
> [   18.371136]  do_syscall_64+0x7d/0x160
> [   18.371459]  ? fdget_pos+0x1c8/0x4c0
> [   18.371784]  ? ksys_read+0xfd/0x1d0
> [   18.372106]  ? syscall_exit_to_user_mode+0x10/0x1f0
> [   18.372525]  ? do_syscall_64+0x89/0x160
> [   18.372860]  ? do_syscall_64+0x89/0x160
> [   18.373194]  ? do_syscall_64+0x89/0x160
> [   18.373527]  ? syscall_exit_to_user_mode+0x10/0x1f0
> [   18.373952]  ? do_syscall_64+0x89/0x160
> [   18.374283]  ? syscall_exit_to_user_mode+0x10/0x1f0
> [   18.374701]  ? do_syscall_64+0x89/0x160
> [   18.375037]  ? do_user_addr_fault+0x4a8/0xa40
> [   18.375416]  ? clear_bhb_loop+0x25/0x80
> [   18.375748]  ? clear_bhb_loop+0x25/0x80
> [   18.376119]  ? clear_bhb_loop+0x25/0x80
> [   18.376450]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Fixes: 233e89322cbe ("alloc_tag: fix module allocation tags populated are=
a calculation")
> Reported-by: Ben Greear <greearb@candelatech.com>
> Closes: https://lore.kernel.org/all/1ba0cc57-e2ed-caa2-1241-aa5615bee01f@=
candelatech.com/
> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> ---
> v2: Add comments to facilitate understanding of the code.
>     Add align nr << PAGE_SHIFT to MODULE_ALIGN,even though kasan_alloc_mo=
dule_shadow
>     already handles this internally,but to make the code more readable an=
d user-friendly
>
> commit 233e89322cbe ("alloc_tag: fix module allocation
> tags populated area calculation") is currently in the
> mm-hotfixes-unstable branch, so this patch is
> developed based on the mm-hotfixes-unstable branch.
> ---
>  lib/alloc_tag.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> index f942408b53ef..bd3ee57ea13f 100644
> --- a/lib/alloc_tag.c
> +++ b/lib/alloc_tag.c
> @@ -10,6 +10,7 @@
>  #include <linux/seq_buf.h>
>  #include <linux/seq_file.h>
>  #include <linux/vmalloc.h>
> +#include <linux/math.h>
>
>  #define ALLOCINFO_FILE_NAME            "allocinfo"
>  #define MODULE_ALLOC_TAG_VMAP_SIZE     (100000UL * sizeof(struct alloc_t=
ag))
> @@ -422,6 +423,17 @@ static int vm_module_tags_populate(void)
>                         return -ENOMEM;
>                 }
>                 vm_module_tags->nr_pages +=3D nr;
> +
> +               /*
> +                * Kasan allocates 1 byte of shadow for every 8 bytes of =
data.
> +                * When kasan_alloc_module_shadow allocates shadow memory=
,
> +                * it does so in units of pages.
> +                * Therefore, here we need to align to MODULE_ALIGN.
> +                */
> +               if ((phys_end & (MODULE_ALIGN - 1)) =3D=3D 0)

phys_end is calculated as:

unsigned long phys_end =3D ALIGN_DOWN(module_tags.start_addr, PAGE_SIZE) +
                                           (vm_module_tags->nr_pages
<< PAGE_SHIFT);

and therefore is always PAGE_SIZE-aligned. PAGE_SIZE is always a
multiple of MODULE_ALIGN, therefore phys_end is always
MODULE_ALIGN-aligned and the above condition is not needed.

> +                       kasan_alloc_module_shadow((void *)phys_end,
> +                                                 round_up(nr << PAGE_SHI=
FT, MODULE_ALIGN),

Here again, (nr << PAGE_SHIFT) is PAGE_SIZE-aligned and PAGE_SIZE is a
multiple of MODULE_ALIGN, therefore (nr << PAGE_SHIFT) is always
multiple of MODULE_ALIGN and there is no need for round_up().

IOW, I think this patch should simply add one line:

                vm_module_tags->nr_pages +=3D nr;
+               kasan_alloc_module_shadow((void *)phys_end, nr <<
PAGE_SHIFT, GFP_KERNEL);

Am I missing something?


> +                                                 GFP_KERNEL);
>         }
>
>         /*
> --
> 2.25.1
>

