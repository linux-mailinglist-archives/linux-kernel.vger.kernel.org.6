Return-Path: <linux-kernel+bounces-431405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346D19E3D20
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9776FB31B26
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE7720A5E3;
	Wed,  4 Dec 2024 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="khvcWUzp"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3181B4157
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733323201; cv=none; b=BBpL6i/0mWcyuVjQIq7+hd/2aquZcvYxOrDUSJ2lCrnh6f5cG/IQ2kBINUPY/VKu82PMhe0VZgVpzOXSFuYMlTNyRKp7w78d9fiqltK7+zFsx6wGKJJZvIx3fzYwBpURxvnA1iILPRLatkB+ihPyafJyRC/VQHaO4mRNzaBG+D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733323201; c=relaxed/simple;
	bh=uVD+qQ302h8IZk5YMc72gfXu5DsYD5rz89prDwpBRuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMaYklaagP99fkKkmtbY0ACC/Pm1daNvJlpakunp3deRvRn3ITOwdBGgcQ0iQ+iAYqZ3311tfl5rX9HHIyw2jeN5kH8m+NtLQJbcxi/zqUl/vJDfbWxjSdItJiRIhKCDWKpT6w5r5DELczznlhD1CluNJoYm1gHVGDzTxVpZ/Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=khvcWUzp; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-466ab386254so217221cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 06:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733323198; x=1733927998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5oqqzwviB0cnruZZagLfTt+wkZgmhV4OxTYeK6vdMg=;
        b=khvcWUzpnyu/ULY9x82Xb5EbH1B+1VYH2LPebbigeLzxxJBAGxGNlYjlvkyq5qvG3l
         OpipMO11jHGLccnCegMYxslghTGZQSXCc62xHRPf69J9Qm7a8P3LAgaJLv33o1H8aKgE
         e97FNdIyzjBL2RCY1PtIvlxBWuc7JYoW0SbWPSWq3QJSwZ7tluJwiHbZTwXjwRjWXhxA
         dSENBxw4GEJPvBO1l28A8fh7heTh3yKIRUebExVseltflwZ7H0dHOoKjMbKHof3KqPPi
         G+V35lBXgjEz14Z+rXRzccfpPJrQy+eWqloIsnXdxIvvPBuFhB1GiQYIG/zeeKwm0WM3
         jtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733323198; x=1733927998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5oqqzwviB0cnruZZagLfTt+wkZgmhV4OxTYeK6vdMg=;
        b=KPMDbkdGudGhHlh0SY1yCBpGM0gUrbJXUCs6+N5BXG7k72LwxLvxhgBuYG2YGHE2Ih
         DnXs31VLj2zo1s30OViDX2YPKx6SYgOFGa6w8yctbO+9kPRhtp5J/FS0L6XQbDhMIK7t
         udHb+POCEHACpfkoII6b25COXz1E9TetHthca5LoKe6pokf1JloePG2iSOA1y/7syCBl
         aSLQAsZ716TgTvkU8gWpGeZ+PrAcNvY3a9uGhDFg9kwdQiYZdcpJ8rM0onWREzTnuSeE
         9/0NfBfjFZq7clJ5z7we4hUbdZKWDLCXQN/P2k8IdMFJvtYUqAG3LRQdUm62pBFK7fbM
         HPZA==
X-Forwarded-Encrypted: i=1; AJvYcCXBKYaY/XloIb3KIlSE81lxW40aMMymLygVVhRisb98+v8saBTGXMPr5gbw+/4lXsQwHxgMwYSoE/rt9jI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxTrjIWU4a5oQTXqEKLdM0wYwrg16y1I1KlHpi1s9rF9UhV5Ab
	8RgJ/X/EHbuP8Wn7qHo/Z5kSqh5vCxGcfinUPECAlDp5jRNCxtcxZszcXXQgUUCseE3Z2qsTsTx
	bL7PGm33lzz7hoEY7dr0O03WN7mWgVBT7s3vqIb/lQ01NpFjKdKhDeDOivg==
X-Gm-Gg: ASbGncstKPfAFYsz80AqNjoPRDaWxNucNEHUTRnnG6/4aZ34ia1a+Gi6h0UFwgN+QnL
	Iu5mK2/QC5p2AzVYzyhrTxhV/xln8bqmMWQ==
X-Google-Smtp-Source: AGHT+IHHcJyaltbbRC8sOLBrsWMRfccYEJo0D3YMqc1idj70Se9R3/ZjO6oXwM3ktDa3CJtR6gIawpRyVSY4a8lNXvU=
X-Received: by 2002:a05:622a:5191:b0:466:9b73:8e3c with SMTP id
 d75a77b69052e-4671b76615cmr3039611cf.13.1733323197413; Wed, 04 Dec 2024
 06:39:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204075248.384215-1-hao.ge@linux.dev> <20241204083448.387862-1-hao.ge@linux.dev>
In-Reply-To: <20241204083448.387862-1-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 4 Dec 2024 06:39:45 -0800
Message-ID: <CAJuCfpF5Yo3Bz1OUy=rfd5-0DRZsWSRaekR3Y-f5TRatdXWkVQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm/alloc_tag: fix vm_module_tags_populate's KASAN
 poisoning logic
To: Hao Ge <hao.ge@linux.dev>
Cc: kent.overstreet@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 12:35=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> From: Hao Ge <gehao@kylinos.cn>
>
> After merge commit 233e89322cbe ("alloc_tag:
> fix module allocation tags populated area calculation"),
> We still encountered a KASAN bug.
>
> This is because we have only actually performed
> page allocation and address mapping here.
> we need to unpoisoned portions of underlying memory.
>
> Because we have a change in the size here,we need to
> re-annotate poisoned and unpoisoned portions of underlying memory
> according to the new size.
>
> Here is the log for KASAN:
>
> [    5.041171][    T1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [    5.042047][    T1] BUG: KASAN: vmalloc-out-of-bounds in move_module+0=
x2c0/0x708
> [    5.042723][    T1] Write of size 240 at addr ffff80007e510000 by task=
 systemd/1
> [    5.043412][    T1]
> [    5.043523][   T72] input: QEMU QEMU USB Tablet as /devices/pci0000:00=
/0000:00:01.1/0000:02:001
> [    5.043614][    T1] CPU: 0 UID: 0 PID: 1 Comm: systemd Not tainted 6.1=
3.0-rc1+ #28
> [    5.045560][    T1] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.=
0 02/06/2015
> [    5.046328][    T1] Call trace:
> [    5.046670][    T1]  show_stack+0x20/0x38 (C)
> [    5.047127][    T1]  dump_stack_lvl+0x80/0xf8
> [    5.047533][    T1]  print_address_description.constprop.0+0x58/0x358
> [    5.048092][   T72] hid-generic 0003:0627:0001.0001: input,hidraw0: US=
B HID v0.01 Mouse [QEMU 0
> [    5.048126][    T1]  print_report+0xb0/0x280
> [    5.049682][    T1]  kasan_report+0xb8/0x108
> [    5.050170][    T1]  kasan_check_range+0xe8/0x190
> [    5.050685][    T1]  memcpy+0x58/0xa0
> [    5.051135][    T1]  move_module+0x2c0/0x708
> [    5.051586][    T1]  layout_and_allocate.constprop.0+0x308/0x5b8
> [    5.052219][    T1]  load_module+0x134/0x16c8
> [    5.052671][    T1]  init_module_from_file+0xdc/0x138
> [    5.053193][    T1]  idempotent_init_module+0x344/0x600
> [    5.053742][    T1]  __arm64_sys_finit_module+0xbc/0x150
> [    5.054289][    T1]  invoke_syscall+0xd4/0x258
> [    5.054749][    T1]  el0_svc_common.constprop.0+0xb4/0x240
> [    5.055319][    T1]  do_el0_svc+0x48/0x68
> [    5.055743][    T1]  el0_svc+0x40/0xe0
> [    5.056142][    T1]  el0t_64_sync_handler+0x10c/0x138
> [    5.056658][    T1]  el0t_64_sync+0x1ac/0x1b0
>
> Fixes: 233e89322cbe ("alloc_tag: fix module allocation tags populated are=
a calculation")
> Signed-off-by: Hao Ge <gehao@kylinos.cn>

Thanks for the fix!

>
> ---
> v2: Add comments to kasan_unpoison_vmalloc like other places.
>
> commit 233e89322cbe ("alloc_tag: fix module allocation
> tags populated area calculation") is currently in the
> mm-hotfixes-unstable branch, so this patch is
> developed based on the mm-hotfixes-unstable branch.
> ---
>  lib/alloc_tag.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> index 4ee6caa6d2da..f885b3f3af0e 100644
> --- a/lib/alloc_tag.c
> +++ b/lib/alloc_tag.c
> @@ -421,7 +421,20 @@ static int vm_module_tags_populate(void)
>                                 __free_page(next_page[i]);
>                         return -ENOMEM;
>                 }
> +
> +               kasan_poison_vmalloc((void *)module_tags.start_addr,
> +                                    vm_module_tags->nr_pages << PAGE_SHI=
FT);
> +
>                 vm_module_tags->nr_pages +=3D nr;
> +
> +               /*
> +                * Mark the pages as accessible, now that they are mapped=
.
> +                * With hardware tag-based KASAN, marking is skipped for
> +                * non-VM_ALLOC mappings, see __kasan_unpoison_vmalloc().
> +                */
> +               kasan_unpoison_vmalloc((void *)module_tags.start_addr,
> +                                      vm_module_tags->nr_pages << PAGE_S=
HIFT,
> +                                      KASAN_VMALLOC_PROT_NORMAL);

Instead of poisoning [module_tags.start_addr,
vm_module_tags->nr_pages], incrementing vm_module_tags->nr_pages and
the unpoisoning [module_tags.start_addr, vm_module_tags->nr_pages]
could we simply poisons the additional area like this:

                kasan_unpoison_vmalloc((void *)module_tags.start_addr +
                                       (vm_module_tags->nr_pages << PAGE_SH=
IFT),
                                       nr << PAGE_SHIFT,
                                       KASAN_VMALLOC_PROT_NORMAL);
               vm_module_tags->nr_pages +=3D nr;
?

>         }
>
>         return 0;
> --
> 2.25.1
>

