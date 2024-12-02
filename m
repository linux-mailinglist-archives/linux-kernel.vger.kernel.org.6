Return-Path: <linux-kernel+bounces-426849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B29579DF969
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 04:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECDBDB21259
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 03:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D832C190;
	Mon,  2 Dec 2024 03:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZEBwwQX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FBC1CAA4
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 03:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733109132; cv=none; b=MEAPuW1j4GKNT+SzW+lxJLS8Qtk1sw3BUi0ZAFfaIQDSszQ7IWuC7+yn7/gsP1SXmOwpkrilFF12YfeiEsjRYbhxvlFLRXmH5+e8CvfxAG9cp78GrOklUrFtwxa635BmSh80DZQ9cMsyBFBx+aVxkKahoV/PIixFL5LIMoM8JFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733109132; c=relaxed/simple;
	bh=p3sOEcIQbU7yJCXrL3Pvo87jrg7unNiCZUDar3hWbx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HGh7Ii1ihKWUdHSOJ5fn5dRnp5+eYH9JRvcXy/CfpTKcApMCocqb6LgCyj/t4EMmB0ZZIHw9FvNBngyEV8JmEfBbM0E+RBljqkDHM0NjbOvKvmgW60oxy2af6HNIOWGinxaN2JPvNvz0a+keqypUFG9wXaNubS+TBc27zYe0sKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZEBwwQX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF430C4CEDC
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 03:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733109131;
	bh=p3sOEcIQbU7yJCXrL3Pvo87jrg7unNiCZUDar3hWbx4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pZEBwwQXSA/S9zG0WHk8a1zDq3qKl1gQwTWHaGPUuCK1GOEGa22cFvtYf4/lwjV+r
	 hsO2UDcRuOl2UfBHCWNiQXaako+CnKf62NUY7evJfjfD7VGnaIdRe1VeZZqJxev/ZC
	 xuQd/a6vNWyvTmA9zLm+XW8Yad8xHoFBGTd/SGF3fQDCNtGf7fkPoDkmwDgiyWsapK
	 YkZql4CpRAaauSXhsnTGyvy19fRiK+AkEoH2gL5YlnqYnG3fkIFsqNZxnBJOkFA9UB
	 4IWN3i8yl4L1oR3ofpCcSCuCJvDQn4F0AMmA0oCkzcdgbpwv5HzI7WhF+hV2mCO2wb
	 G2okpn6L4qMtw==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa560a65fd6so645767266b.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 19:12:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWb2L+UAsqcrZSVsDIraRzARLXH8a0SneWK+DqhEbotpryiTHmt5mAbWQwlfkC+looRjcc8uulMjckUR+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyr0/EQvWGJdNcC6QpD7wyyz5nRqNrTgdY+9gt43+7YRVepEvs
	4FSgv08BZYSKXlXHZZ7XVR27YiEdRX68IbVTlQ66EzI5eQe5i6Bkv4taJxDxU9c0/FfkDA0kweu
	LpTg760BVdp8Y9lAFyEFUMQRnhww=
X-Google-Smtp-Source: AGHT+IGpcbt+4A1jCHFYyr6Hq68NtVf/E7bdIPl0OfNipkmiNecARxjNwS/15wDk7MZw/zTkufymZIDHZloOko+bgtg=
X-Received: by 2002:a17:907:3da0:b0:aa4:cd1e:c91b with SMTP id
 a640c23a62f3a-aa5945344c1mr2128060566b.7.1733109130294; Sun, 01 Dec 2024
 19:12:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128083043.1208664-1-maobibo@loongson.cn>
In-Reply-To: <20241128083043.1208664-1-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 2 Dec 2024 11:12:00 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4a+rmcTzmEfbrS3q8cS++80r6e=vZh4qp0jbaW7-YwPg@mail.gmail.com>
Message-ID: <CAAhV-H4a+rmcTzmEfbrS3q8cS++80r6e=vZh4qp0jbaW7-YwPg@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Add architecture specific huge_pte_clear
To: Bibo Mao <maobibo@loongson.cn>
Cc: WANG Xuerui <kernel@xen0n.name>, Andrew Morton <akpm@linux-foundation.org>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Thu, Nov 28, 2024 at 4:30=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> When executing mm selftests run_vmtests.sh, there is such error:
>
>  BUG: Bad page state in process uffd-unit-tests  pfn:00000
>  page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x0
>  flags: 0xffff0000002000(reserved|node=3D0|zone=3D0|lastcpupid=3D0xffff)
>  raw: 00ffff0000002000 ffffbf0000000008 ffffbf0000000008 0000000000000000
>  raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
>  page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
>  Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfkill vfat fat
>     virtio_balloon efi_pstore virtio_net pstore net_failover failover fus=
e
>     nfnetlink virtio_scsi virtio_gpu virtio_dma_buf dm_multipath efivarfs
>  CPU: 2 UID: 0 PID: 1913 Comm: uffd-unit-tests Not tainted 6.12.0 #184
>  Hardware name: QEMU QEMU Virtual Machine, BIOS unknown 2/2/2022
>  Stack : 900000047c8ac000 0000000000000000 9000000000223a7c 900000047c8ac=
000
>          900000047c8af690 900000047c8af698 0000000000000000 900000047c8af=
7d8
>          900000047c8af7d0 900000047c8af7d0 900000047c8af5b0 0000000000000=
001
>          0000000000000001 900000047c8af698 10b3c7d53da40d26 0000010000000=
000
>          0000000000000022 0000000fffffffff fffffffffe000000 ffff800000000=
000
>          000000000000002f 0000800000000000 000000017a6d4000 90000000028f8=
940
>          0000000000000000 0000000000000000 90000000025aa5e0 9000000002905=
000
>          0000000000000000 90000000028f8940 ffff800000000000 0000000000000=
000
>          0000000000000000 0000000000000000 9000000000223a94 0000000120018=
39c
>          00000000000000b0 0000000000000004 0000000000000000 0000000000071=
c1d
>          ...
>  Call Trace:
>  [<9000000000223a94>] show_stack+0x5c/0x180
>  [<9000000001c3fd64>] dump_stack_lvl+0x6c/0xa0
>  [<900000000056aa08>] bad_page+0x1a0/0x1f0
>  [<9000000000574978>] free_unref_folios+0xbf0/0xd20
>  [<90000000004e65cc>] folios_put_refs+0x1a4/0x2b8
>  [<9000000000599a0c>] free_pages_and_swap_cache+0x164/0x260
>  [<9000000000547698>] tlb_batch_pages_flush+0xa8/0x1c0
>  [<9000000000547f30>] tlb_finish_mmu+0xa8/0x218
>  [<9000000000543cb8>] exit_mmap+0x1a0/0x360
>  [<9000000000247658>] __mmput+0x78/0x200
>  [<900000000025583c>] do_exit+0x43c/0xde8
>  [<9000000000256490>] do_group_exit+0x68/0x110
>  [<9000000000256554>] sys_exit_group+0x1c/0x20
>  [<9000000001c413b4>] do_syscall+0x94/0x130
>  [<90000000002216d8>] handle_syscall+0xb8/0x158
>  Disabling lock debugging due to kernel taint
>  BUG: non-zero pgtables_bytes on freeing mm: -16384
>
> On LoongArch system, invalid huge pte entry should be invalid_pte_table
> or _PAGE_HUGE. And it need be the same with invalid pmd entry, since
> pmd_none() is called by function free_pgd_range(), pmd_none() return 0
> by huge_pte_clear(). So _PAGE_HUGE is treated as valid pte table and
> free_pte_range() will be called in free_pmd_range().
>
> free_pmd_range()
>         pmd =3D pmd_offset(pud, addr);
>         do {
>                 next =3D pmd_addr_end(addr, end);
>                 if (pmd_none_or_clear_bad(pmd))
>                         continue;
>                 free_pte_range(tlb, pmd, addr);
>         } while (pmd++, addr =3D next, addr !=3D end);
>
> Here invalid_pte_table is used for both invalid huge pte entry and
> pmd entry.
>
> Fixes: 09cfefb7fa70 ("LoongArch: Add memory management")
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/include/asm/hugetlb.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/loongarch/include/asm/hugetlb.h b/arch/loongarch/includ=
e/asm/hugetlb.h
> index b837c65a4894..c8e4057734d0 100644
> --- a/arch/loongarch/include/asm/hugetlb.h
> +++ b/arch/loongarch/include/asm/hugetlb.h
> @@ -24,6 +24,16 @@ static inline int prepare_hugepage_range(struct file *=
file,
>         return 0;
>  }
>
> +#define __HAVE_ARCH_HUGE_PTE_CLEAR
> +static inline void huge_pte_clear(struct mm_struct *mm, unsigned long ad=
dr,
> +                                 pte_t *ptep, unsigned long sz)
> +{
> +       pte_t clear;
> +
> +       pte_val(clear) =3D (unsigned long)invalid_pte_table;
> +       set_pte_at(mm, addr, ptep, clear);
> +}
> +
>  #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
>  static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
>                                             unsigned long addr, pte_t *pt=
ep)
>
> base-commit: b86545e02e8c22fb89218f29d381fa8e8b91d815
> --
> 2.39.3
>

