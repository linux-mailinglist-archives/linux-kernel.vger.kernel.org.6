Return-Path: <linux-kernel+bounces-363083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F47499BDB0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 04:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 815E1B20D1E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 02:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8436A35280;
	Mon, 14 Oct 2024 02:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxjuZID3"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3344D8AD
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 02:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728872248; cv=none; b=igPtZFUm902OP5IIZ1OySeqI65i8kJ/8WbPZ/9NsfU285By1DQ2rbsZYV3+9LxIC5sJQSLjgKGYFsKetxzRmuQKT7VCNLl2vGwclgzDn2KY28jO08Rip05JVegyewCu/tlbJLVDfW0gsABcdGO5h/OdgYlvvbmkswJSOACFlUWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728872248; c=relaxed/simple;
	bh=eCvaDjl0M0zpYO/OX3byee3JjUVwSBuwA7LAzy2/Ha0=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=hF9PXHnNCBpIyCW+hL8Z/yTA2e6egheFRgz1qXwCyuYNJZXYhUIoti5GahNM7oFwbHndMHqT4x/8rZE6UMLa0Sp9L8YuxmGyR9/pj3lyqcE43vLgFzCCPGPt858A5ez27l+T/p1jCfT5BwYIdJnqJaVvt4sUOnjdRSKBgR/YNzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxjuZID3; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e3d45bbb5so1538145b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 19:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728872247; x=1729477047; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rcPB3YmB5BHG6WNKd4tONjPqCA9wIHcCgzWiNUwB9Zw=;
        b=LxjuZID3rTiZwvrXIH7QP0+3RzL1zxLWiELX3w2TAe6TzNQaZ3YZehnDjP6bYygw6V
         yL/PHQPVWnjPs8S61ljs+9vryBFan2dGMSKukf80Fc4eKNF5j5St7WOWityDy1r1QM/W
         Ujrsk1O3riRh6ybq/j4hA3OHk05RJIXfNOuodz/EVNEKvGJ+WMye90lkKONuqi41WaIl
         13GIAYemJT1Lgi3qwcxgC/qKm9p2P47x0OCVgXHSE0blQLMKffkPQpeuBkwlDoVE9YZf
         ej5C/Qc+wG9dso0eq7do1oRDl9GLuRcUmdZpN2saJHrWzE+CFPq1JsF60RPyQqPFIfH4
         +DKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728872247; x=1729477047;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcPB3YmB5BHG6WNKd4tONjPqCA9wIHcCgzWiNUwB9Zw=;
        b=S3i2S6kTd6xgWuzC/j+I1TNwoSMfIDHqi0BC3PeTW/FSckQMAvqQyOtS3Jmisg6Rvn
         uhK3Znewyds07RDZC085WgqQXXTjjmISB3M8bAUxxUONyD9lS33wcJEinnWu33p4S4RZ
         2fSdUJrN0VTOFBE/r4snp7YA0clIjeJOEtc+EICp6IPF8S2gZLQKkWAnOBs/YBR44lEh
         JhcnxrZdE/wYa6sEKYHlv8xiXHlgnX/TCu5bWUktJt1cTE6EFLfWaBSh+3HC4MA0C/VE
         2jTEMwxCNQoqTpcyWrmMkIDB8h66dM2P+bJBy91ZXqwhRRPJl7bo4IZ5SVIC5QtPbXcw
         d32A==
X-Forwarded-Encrypted: i=1; AJvYcCVleRsRaZuUL+6nS0Fna7jL1y0ZuQsnDrrxSPxT/+Pg+BYY5apP12PmNC+GD1UOrbWB3vEVfSNrenQLse0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVw43uV8RVETqQM3y2CioP/OWtMVrL7IOR4rPgkRCZJfRcgGo7
	Gq6VqCEPk7oNftFdrIukWiAM2/79IL0e7RwbzWi2KsqLh0/EpkP+
X-Google-Smtp-Source: AGHT+IEttU3qiHCe1VIvFAnfKwKqkvDNBLNLIN9FCGgntq+XFIBt/CjL2+liif8MslmdwfdR0pbSSA==
X-Received: by 2002:a05:6a00:812:b0:71e:6122:5919 with SMTP id d2e1a72fcca58-71e61225fa8mr3716796b3a.20.1728872246575;
        Sun, 13 Oct 2024 19:17:26 -0700 (PDT)
Received: from smtpclient.apple ([2001:e60:a816:6dac:10d3:523b:453c:7c13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2a9f6d45sm6362679b3a.80.2024.10.13.19.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Oct 2024 19:17:26 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Jeongjun Park <aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] mm: swap: prevent possible data-race in __try_to_reclaim_swap
Date: Mon, 14 Oct 2024 11:17:14 +0900
Message-Id: <EF64B02C-05B4-4E51-91E1-9C3CD6FDF220@gmail.com>
References: <CAMgjq7BdaUe6YweW03MHEOmunXm7tJz=nMOCWTvq_jDoVGAL+Q@mail.gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 syzbot+fa43f1b63e3aa6f66329@syzkaller.appspotmail.com
In-Reply-To: <CAMgjq7BdaUe6YweW03MHEOmunXm7tJz=nMOCWTvq_jDoVGAL+Q@mail.gmail.com>
To: Kairui Song <ryncsn@gmail.com>
X-Mailer: iPhone Mail (21G93)



> Kairui Song <ryncsn@gmail.com> wrote:
>=20
> =EF=BB=BFOn Mon, Oct 7, 2024 at 3:06=E2=80=AFPM Jeongjun Park <aha310510@g=
mail.com> wrote:
>>=20
>> A report [1] was uploaded from syzbot.
>>=20
>> In the previous commit 862590ac3708 ("mm: swap: allow cache reclaim to sk=
ip
>> slot cache"), the __try_to_reclaim_swap() function reads offset and folio=
->entry
>> from folio without folio_lock protection.
>>=20
>> In the currently reported KCSAN log, it is assumed that the actual data-r=
ace
>> will not occur because the calltrace that does WRITE already obtains the
>> folio_lock and then writes.
>>=20
>> However, the existing __try_to_reclaim_swap() function was already implem=
ented
>> to perform reads under folio_lock protection [1], and there is a risk of a=

>> data-race occurring through a function other than the one shown in the KC=
SAN
>> log.
>>=20
>> Therefore, I think it is appropriate to change read operations for
>> folio to be performed under folio_lock.
>>=20
>> [1]
>>=20
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> BUG: KCSAN: data-race in __delete_from_swap_cache / __try_to_reclaim_swap=

>>=20
>> write to 0xffffea0004c90328 of 8 bytes by task 5186 on cpu 0:
>> __delete_from_swap_cache+0x1f0/0x290 mm/swap_state.c:163
>> delete_from_swap_cache+0x72/0xe0 mm/swap_state.c:243
>> folio_free_swap+0x1d8/0x1f0 mm/swapfile.c:1850
>> free_swap_cache mm/swap_state.c:293 [inline]
>> free_pages_and_swap_cache+0x1fc/0x410 mm/swap_state.c:325
>> __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
>> tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
>> tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
>> tlb_flush_mmu+0x2cf/0x440 mm/mmu_gather.c:373
>> zap_pte_range mm/memory.c:1700 [inline]
>> zap_pmd_range mm/memory.c:1739 [inline]
>> zap_pud_range mm/memory.c:1768 [inline]
>> zap_p4d_range mm/memory.c:1789 [inline]
>> unmap_page_range+0x1f3c/0x22d0 mm/memory.c:1810
>> unmap_single_vma+0x142/0x1d0 mm/memory.c:1856
>> unmap_vmas+0x18d/0x2b0 mm/memory.c:1900
>> exit_mmap+0x18a/0x690 mm/mmap.c:1864
>> __mmput+0x28/0x1b0 kernel/fork.c:1347
>> mmput+0x4c/0x60 kernel/fork.c:1369
>> exit_mm+0xe4/0x190 kernel/exit.c:571
>> do_exit+0x55e/0x17f0 kernel/exit.c:926
>> do_group_exit+0x102/0x150 kernel/exit.c:1088
>> get_signal+0xf2a/0x1070 kernel/signal.c:2917
>> arch_do_signal_or_restart+0x95/0x4b0 arch/x86/kernel/signal.c:337
>> exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
>> exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>> __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>> syscall_exit_to_user_mode+0x59/0x130 kernel/entry/common.c:218
>> do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
>> entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>=20
>> read to 0xffffea0004c90328 of 8 bytes by task 5189 on cpu 1:
>> __try_to_reclaim_swap+0x9d/0x510 mm/swapfile.c:198
>> free_swap_and_cache_nr+0x45d/0x8a0 mm/swapfile.c:1915
>> zap_pte_range mm/memory.c:1656 [inline]
>> zap_pmd_range mm/memory.c:1739 [inline]
>> zap_pud_range mm/memory.c:1768 [inline]
>> zap_p4d_range mm/memory.c:1789 [inline]
>> unmap_page_range+0xcf8/0x22d0 mm/memory.c:1810
>> unmap_single_vma+0x142/0x1d0 mm/memory.c:1856
>> unmap_vmas+0x18d/0x2b0 mm/memory.c:1900
>> exit_mmap+0x18a/0x690 mm/mmap.c:1864
>> __mmput+0x28/0x1b0 kernel/fork.c:1347
>> mmput+0x4c/0x60 kernel/fork.c:1369
>> exit_mm+0xe4/0x190 kernel/exit.c:571
>> do_exit+0x55e/0x17f0 kernel/exit.c:926
>> __do_sys_exit kernel/exit.c:1055 [inline]
>> __se_sys_exit kernel/exit.c:1053 [inline]
>> __x64_sys_exit+0x1f/0x20 kernel/exit.c:1053
>> x64_sys_call+0x2d46/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:6=
1
>> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>> do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
>> entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>=20
>> value changed: 0x0000000000000242 -> 0x0000000000000000
>>=20
>> Reported-by: syzbot+fa43f1b63e3aa6f66329@syzkaller.appspotmail.com
>> Fixes: 862590ac3708 ("mm: swap: allow cache reclaim to skip slot cache")
>> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
>> ---
>> mm/swapfile.c | 7 ++++---
>> 1 file changed, 4 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index 0cded32414a1..eb782fcd5627 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -194,9 +194,6 @@ static int __try_to_reclaim_swap(struct swap_info_str=
uct *si,
>>        if (IS_ERR(folio))
>>                return 0;
>>=20
>> -       /* offset could point to the middle of a large folio */
>> -       entry =3D folio->swap;
>> -       offset =3D swp_offset(entry);
>>        nr_pages =3D folio_nr_pages(folio);
>>        ret =3D -nr_pages;
>>=20
>> @@ -210,6 +207,10 @@ static int __try_to_reclaim_swap(struct swap_info_st=
ruct *si,
>>        if (!folio_trylock(folio))
>>                goto out;
>>=20
>> +       /* offset could point to the middle of a large folio */
>> +       entry =3D folio->swap;
>> +       offset =3D swp_offset(entry);
>> +
>>        need_reclaim =3D ((flags & TTRS_ANYWAY) ||
>>                        ((flags & TTRS_UNMAPPED) && !folio_mapped(folio)) |=
|
>>                        ((flags & TTRS_FULL) && mem_cgroup_swap_full(folio=
)));
>> --
>=20
> Reviewed-by: Kairui Song <kasong@tencent.com>
>=20
> Hi Andrew,
>=20
> Will this be added to stable and 6.12? 862590ac3708 is already in 6.12
> and this fixes a potential issue of it.

As far as I can see, commit 862590ac3708 was applied starting
from 6.12-rc1, so it looks like no additional commits are needed
for the stable version.

Regards,

Jeongjun Park=

