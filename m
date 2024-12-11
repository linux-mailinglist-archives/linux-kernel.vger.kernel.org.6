Return-Path: <linux-kernel+bounces-441661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CEB9ED1EA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD0F11667DD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA37B1DDC0C;
	Wed, 11 Dec 2024 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1E5PmfFV"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2300638DE9
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934764; cv=none; b=ug6xTVjB373gNrGtN5hyAVc5ugi04mdOXzaRwk/nAOPl0cEOxnius8Ugw3VoxW3H7F5A+QZljdbpnDP2S8XO+H3daDsrDv4jh010pw3DGrAWBU8HPBhvuP7uiUOJhSx6y3g3/6h3V4FITJqiNlVsTQpDYhjTzFsazw2DBJH50T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934764; c=relaxed/simple;
	bh=4PcwGyj4yKv0QGybm/lpsArjLyFHC46ZfRBA7g++PLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AeqOKpXaUZcrta7UwwN3+1SkXmRZviqq9biTU83X9u/pgoPvVRNh0awrEojUQL2oobti7jIs4JPa5CrQdP0Yh4rXUajCLbfoB6bfipYWXPiaz/wJbkFrrvVC+fz1iVnTlmz8RqGUoLwTbCFwmfWj0SS74u59/Nlx9qyMXtXpvRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1E5PmfFV; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4678c9310afso215911cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733934761; x=1734539561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ml6c82hnapuA+FlWUgURNaQU+aCa9IDu8DuMEMV2rro=;
        b=1E5PmfFVVZxjfXOOrmKs0mJgjv0uOiLDRFCQHwHL3krb1LxmdhxWjwTy7DKF/XE+/W
         mvvtRjZH1qG1IftcOyXThtErQu8tbVseJGi0HkSZBO3csGXNcVX/bjz2zV2vogt1kScr
         nPhu44o0dxwukz3h/2q4ayKcat5gOegvaf4QJRbQq1OwQoKuv0u4MwNdNihnWvY5nkY+
         dRCWhZT7QxqMrVL0oZO/36Ze4MDPpogX9fVDnO2yl2NP5esOWjdqTnXqQwJ+BV+Cr4fi
         WpgVeK8tW0d1hod0oLykUT+lRqb7+vanSrVpjJIrVPFJNKKEggzGWASssHXjsRNei/MJ
         Nsgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733934761; x=1734539561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ml6c82hnapuA+FlWUgURNaQU+aCa9IDu8DuMEMV2rro=;
        b=AXjne+0dnRy1sJYguuOvO9ieryQoHI9Lt/qqWOv2p/hvjiIck+lHKRjsu9wJtoOJEg
         Uq9M/PtAf3XU5iBfe3pbjLP79bECn8mLDRl2yabd0PB8cVLzfP0hWLXhoTk83g1z2qVf
         mGrmob4hFt8I3QlQX2XQPsoDROZOkr5p+IxK5I5u/l8s05Ngi4yqUFr1JldDhzT9CSje
         60d3lGe+rEbSYUwFM3QNatlj7Q+BlrsixEwNOr40Nq+iZeETvatsei7qFgP9ozkfRPjj
         JIq/0Ze8w7MKuvGtfzqv02dyibA69BaoFf0YqggesTOrKnm5JGzTp1qzMVIXxhXUHYO+
         a99Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKVK7E6OH986faBHLAMgrkbUG4tMA4c4/ndTcHh5rnya8EADMhv51xmXp06hA4ZQGL23z4Qdy9CTSyMKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW0bCtdZgN/QBn057pIPgNcPQTO9RktqpI7ukQJqrdblNvsVqj
	50vn0Pduom1lMJhFS4w542A7n7ui0Qq3H8a2T/N9b79QNM85WsK9sPYHcNSY7vgRAY7aviFAIZA
	n2fbimdp0QUK3M1o0mrufXdLtOVdj34e6mVq4
X-Gm-Gg: ASbGncvbH33P89uGF1FTXGhgOE0ahW7hY05wVFaHR94DAoYCNhpATK7JT19H29/aokq
	gnVP3vpjpbZ4ur7W5i0H2w5SZV+5dSwl6CLDnZmyYCgENlyOOmDOHuFgdpvtzf7vJqA==
X-Google-Smtp-Source: AGHT+IG/Bo0WZPK2yem/oCa5/xhzIAMwwDl2pun/pEjFZiHLTCAyGI9JZYsM4/SZlBYdT3OANGJXfrVKXRiwc+RnFGs=
X-Received: by 2002:a05:622a:5919:b0:461:4150:b835 with SMTP id
 d75a77b69052e-46795c6e739mr152441cf.6.1733934760680; Wed, 11 Dec 2024
 08:32:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <43a827f1-44ce-1338-9b5c-456d20fa4cf9@linux.dev> <20241211025755.56173-1-hao.ge@linux.dev>
In-Reply-To: <20241211025755.56173-1-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 11 Dec 2024 08:32:29 -0800
Message-ID: <CAJuCfpHVd=9LssH9LtyG8Mjgb4SoKs-eadG_whNn5-H67z-+1A@mail.gmail.com>
Subject: Re: [PATCH v3] mm/alloc_tag: Fix panic when CONFIG_KASAN enabled and
 CONFIG_KASAN_VMALLOC not enabled
To: Hao Ge <hao.ge@linux.dev>
Cc: kent.overstreet@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>, 
	Ben Greear <greearb@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 6:58=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
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
> v3: Adjusting the title because the previous one was a bit unclear.
>     Suren has pointed out that our condition for determining whether
>     to allocate shadow memory is unreasonable.We have adjusted our method
>     to use every 8 pages as an index (idx), and we will make decisions ba=
sed
>     on this idx when determining whether to allocate shadow memory.
>
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
>  lib/alloc_tag.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> index f942408b53ef..8bf04756887d 100644
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
> @@ -404,6 +405,9 @@ static int vm_module_tags_populate(void)
>         unsigned long phys_end =3D ALIGN_DOWN(module_tags.start_addr, PAG=
E_SIZE) +
>                                  (vm_module_tags->nr_pages << PAGE_SHIFT)=
;
>         unsigned long new_end =3D module_tags.start_addr + module_tags.si=
ze;
> +       unsigned long phys_idx =3D (vm_module_tags->nr_pages +
> +                                (2 << KASAN_SHADOW_SCALE_SHIFT) - 1) >> =
KASAN_SHADOW_SCALE_SHIFT;
> +       unsigned long new_idx =3D 0;
>
>         if (phys_end < new_end) {
>                 struct page **next_page =3D vm_module_tags->pages + vm_mo=
dule_tags->nr_pages;
> @@ -421,7 +425,26 @@ static int vm_module_tags_populate(void)
>                                 __free_page(next_page[i]);
>                         return -ENOMEM;
>                 }
> +
>                 vm_module_tags->nr_pages +=3D nr;
> +
> +               new_idx =3D (vm_module_tags->nr_pages +
> +                         (2 << KASAN_SHADOW_SCALE_SHIFT) - 1) >> KASAN_S=
HADOW_SCALE_SHIFT;
> +
> +               /*
> +                * Kasan allocates 1 byte of shadow for every 8 bytes of =
data.
> +                * When kasan_alloc_module_shadow allocates shadow memory=
,
> +                * its unit of allocation is a page.
> +                * Therefore, here we need to align to MODULE_ALIGN.
> +                *
> +                * For every KASAN_SHADOW_SCALE_SHIFT, a shadow page is a=
llocated.
> +                * So, we determine whether to allocate based on whether =
the
> +                * number of pages falls within the scope of the same KAS=
AN_SHADOW_SCALE_SHIFT.
> +                */
> +               if (phys_idx !=3D new_idx)
> +                       kasan_alloc_module_shadow((void *)round_up(phys_e=
nd, MODULE_ALIGN),
> +                                                 (new_idx - phys_idx) * =
MODULE_ALIGN,
> +                                                 GFP_KERNEL);
>         }

This seems overly-complicated. I was thinking something like this would wor=
k:

static int vm_module_tags_populate(void)
{
        unsigned long phys_end =3D ALIGN_DOWN(module_tags.start_addr, PAGE_=
SIZE) +
                                 (vm_module_tags->nr_pages << PAGE_SHIFT);
        unsigned long new_end =3D module_tags.start_addr + module_tags.size=
;

        if (phys_end < new_end) {
                struct page **next_page =3D vm_module_tags->pages +
vm_module_tags->nr_pages;
+                unsigned long old_shadow_end =3D ALIGN(phys_end, MODULE_AL=
IGN);
+                unsigned long new_shadow_end =3D ALIGN(new_end, MODULE_ALI=
GN);
                unsigned long more_pages;
                unsigned long nr;

                more_pages =3D ALIGN(new_end - phys_end, PAGE_SIZE) >> PAGE=
_SHIFT;
                nr =3D alloc_pages_bulk_array_node(GFP_KERNEL | __GFP_NOWAR=
N,
                                                 NUMA_NO_NODE,
more_pages, next_page);
                if (nr < more_pages ||
                    vmap_pages_range(phys_end, phys_end + (nr <<
PAGE_SHIFT), PAGE_KERNEL,
                                     next_page, PAGE_SHIFT) < 0) {
                        /* Clean up and error out */
                        for (int i =3D 0; i < nr; i++)
                                __free_page(next_page[i]);
                        return -ENOMEM;
                }
                vm_module_tags->nr_pages +=3D nr;
+                if (old_shadow_end < new_shadow_end)
+                        kasan_alloc_module_shadow((void *)old_shadow_end,
+                                              new_shadow_end - old_shadow_=
end
+                                              GFP_KERNEL);
        }

WDYT?

>
>         /*
> --
> 2.25.1
>

