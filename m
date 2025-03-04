Return-Path: <linux-kernel+bounces-544131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED87A4DDB9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5700D3A888B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C36202C46;
	Tue,  4 Mar 2025 12:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9OQWGoE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C8B202C20
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 12:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741090824; cv=none; b=WNbD0VQaYmLsXBd7ZZ4kp7IoHGfMyRC6ObIjOUFtnbcGOf+6Q1PH2k7z8oIVehr4kBqH2k9hUIDCxKzkrJ1daKYiAVpY3/HTRumyFZdEjkdn0eHUp2N+J1/yw+6SvkEVSqIbsdRIAxfMyZVooJAk4ACvNggrjniO+4fuI91L3hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741090824; c=relaxed/simple;
	bh=xw3wyvUOJS5mdgY1QWhsMI2KSuimzDRG6M/hdDd2hcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ab90v7tjp+1YaLGRUbcXRXbTRWkvD0LcTOm4q3Z9WQG9MnstcNzF28uX3OF/8KQ8A1wNdmwOK7+sQwtcE/Q5K8m1Eu1TSumu0X6j1oUOsiT+xPx2UWBKMoT2PENcPBKpKnzlKIc2l94dGE5V86tjsibvxTsPqczhWwt7mihvfzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9OQWGoE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00D8C4CEEC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 12:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741090823;
	bh=xw3wyvUOJS5mdgY1QWhsMI2KSuimzDRG6M/hdDd2hcs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Y9OQWGoE17K2vnE6wOIojAGq5RgiGpj9jFYJKfIUTfSPQNkgQhiTlQvpcYk3YiXT8
	 Dj8fVUX3C465S2VNhwnMLeWWE6abVw7PtojxY019eMnV31kR0/lL+jIrdLgTsEbFOn
	 n6uRRhN0H8ZKrMmY9h9YnPxaac5pO6RWA/naZ25/eosSkKI96kJhrEzzj4xHb2qfFz
	 LzEeRMF9m5auW2gTgAACArsq1/ieXKMZ0aXlqYekWMsoi5jbYuN8G2VBSQoh5PdES/
	 1kyz3xM9m+IeH09Gu9NRXXu6EwMCct0wCeFja9oQ7KtMsmB4lNG/agqub0ibV6/i8Y
	 EscZDzn6gVP1Q==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac0cc83e9adso355712566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 04:20:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUUZ6VA7VxmtW5XRVdZ1EInNXJpeOKBoYAxlIZzYflRNUFZaIC3uHG5PF8v/isAl+vk6aMAdD6xfD2rmr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAS1l6b0YOpImBtIP0b6aehlzbhbT6Uebn0XDY5x16ab+a+KkU
	giBxo7C/2t3JaXKWEe7rHcs4nUbxwFxImt5sjhnoPtN8w5SNuWOU6uVSYr67mbcswK6mzWEBE2J
	WQv87nwaAHxb4r4RWAgpWhrNYs9s=
X-Google-Smtp-Source: AGHT+IEHzftfHcwd+SZI6gGQKw6De60uYiQ5Iiz6OuxpN6JEhmQJJSk2v/X8q1I7Nznpxig9660faVXg8f34jrzTL3Y=
X-Received: by 2002:a17:907:2da4:b0:abf:6ead:2e57 with SMTP id
 a640c23a62f3a-ac1f1372261mr223774566b.24.1741090822350; Tue, 04 Mar 2025
 04:20:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304112717.1810047-1-maobibo@loongson.cn>
In-Reply-To: <20250304112717.1810047-1-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 4 Mar 2025 20:20:11 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4A74u9CmLcF3O6sFJbJXcxOyww1or1NJ-AntEOUgBMzQ@mail.gmail.com>
X-Gm-Features: AQ5f1JrbbAn90PBn51LjqYMOSQNRkWPDRkyPmggx_ZqaCk8ntkQ-Qb0ts0IxiLg
Message-ID: <CAAhV-H4A74u9CmLcF3O6sFJbJXcxOyww1or1NJ-AntEOUgBMzQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: mm: Set hugetlb mmap base address aligned with
 pmd size
To: Bibo Mao <maobibo@loongson.cn>
Cc: WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

On Tue, Mar 4, 2025 at 7:27=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrote=
:
>
> With ltp test case "testcases/bin/hugefork02", there is dmesg error
> report message such as
>  kernel BUG at mm/hugetlb.c:5550!
>  Oops - BUG[#1]:
>  CPU: 0 UID: 0 PID: 1517 Comm: hugefork02 Not tainted 6.14.0-rc2+ #241
>  Hardware name: QEMU QEMU Virtual Machine, BIOS unknown 2/2/2022
>  pc 90000000004eaf1c ra 9000000000485538 tp 900000010edbc000 sp 900000010=
edbf940
>  a0 900000010edbfb00 a1 9000000108d20280 a2 00007fffe9474000 a3 00007ffff=
3474000
>  a4 0000000000000000 a5 0000000000000003 a6 00000000003cadd3 a7 000000000=
0000000
>  t0 0000000001ffffff t1 0000000001474000 t2 900000010ecd7900 t3 00007fffe=
9474000
>  t4 00007fffe9474000 t5 0000000000000040 t6 900000010edbfb00 t7 000000000=
0000001
>  t8 0000000000000005 u0 90000000004849d0 s9 900000010edbfa00 s0 900000010=
8d20280
>  s1 00007fffe9474000 s2 0000000002000000 s3 9000000108d20280 s4 900000000=
2b38b10
>  s5 900000010edbfb00 s6 00007ffff3474000 s7 0000000000000406 s8 900000010=
edbfa08
>     ra: 9000000000485538 unmap_vmas+0x130/0x218
>    ERA: 90000000004eaf1c __unmap_hugepage_range+0x6f4/0x7d0
>   PRMD: 00000004 (PPLV0 +PIE -PWE)
>   EUEN: 00000007 (+FPE +SXE +ASXE -BTE)
>   ECFG: 00071c1d (LIE=3D0,2-4,10-12 VS=3D7)
>  ESTAT: 000c0000 [BRK] (IS=3D ECode=3D12 EsubCode=3D0)
>  PRID: 0014c010 (Loongson-64bit, Loongson-3A5000)
>  Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfkill vfat fat =
virtio_net net_failover failover efi_pstore virtio_balloon pstore fuse nfne=
tlink virtio_scsi dm_multipath efivarfs
>  Process hugefork02 (pid: 1517, threadinfo=3D00000000a670eaf4, task=3D000=
000007a95fc64)
>  Call Trace:
>  [<90000000004eaf1c>] __unmap_hugepage_range+0x6f4/0x7d0
>  [<9000000000485534>] unmap_vmas+0x12c/0x218
>  [<9000000000494068>] exit_mmap+0xe0/0x308
>  [<900000000025fdc4>] mmput+0x74/0x180
>  [<900000000026a284>] do_exit+0x294/0x898
>  [<900000000026aa30>] do_group_exit+0x30/0x98
>  [<900000000027bed4>] get_signal+0x83c/0x868
>  [<90000000002457b4>] arch_do_signal_or_restart+0x54/0xfa0
>  [<90000000015795e8>] irqentry_exit_to_user_mode+0xb8/0x138
>  [<90000000002572d0>] tlb_do_page_fault_1+0x114/0x1b4
>
> The problem is that base address allocated from hugetlbfs is not aligned
> with pmd size. Here add checking for hugetlbfs and align base address
> with pmd size. After this patch rest case "testcases/bin/hugefork02"
> passes to run.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/mm/mmap.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/mm/mmap.c b/arch/loongarch/mm/mmap.c
> index 914e82ff3f65..1df9e99582cc 100644
> --- a/arch/loongarch/mm/mmap.c
> +++ b/arch/loongarch/mm/mmap.c
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
>   */
>  #include <linux/export.h>
> +#include <linux/hugetlb.h>
>  #include <linux/io.h>
>  #include <linux/kfence.h>
>  #include <linux/memblock.h>
> @@ -63,8 +64,11 @@ static unsigned long arch_get_unmapped_area_common(str=
uct file *filp,
>         }
>
>         info.length =3D len;
> -       info.align_mask =3D do_color_align ? (PAGE_MASK & SHM_ALIGN_MASK)=
 : 0;
>         info.align_offset =3D pgoff << PAGE_SHIFT;
> +       if (filp && is_file_hugepages(filp))
> +               info.align_mask =3D huge_page_mask_align(filp);
> +       else
> +               info.align_mask =3D do_color_align ? (PAGE_MASK & SHM_ALI=
GN_MASK) : 0;
Thank you for your catch, I think this problem only exist after commit
7f24cbc9c4d42db8a3c8484d120cf9c1 ("mm/mmap: teach
generic_get_unmapped_area{_topdown} to handle hugetlb mappings"). But
you don't need to resend, I will add this information when I apply.

Huacai

>
>         if (dir =3D=3D DOWN) {
>                 info.flags =3D VM_UNMAPPED_AREA_TOPDOWN;
> --
> 2.39.3
>

