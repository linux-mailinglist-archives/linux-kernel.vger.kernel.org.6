Return-Path: <linux-kernel+bounces-363212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C233B99BF0D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 06:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 621E9B21152
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 04:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2814F13D891;
	Mon, 14 Oct 2024 04:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFENU/jM"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C148212CD96
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 04:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878924; cv=none; b=BBYOvR08QXUp9nWyG+2pksc1LYldKNQfEOTFVy+WYhx+hnHJ3XHDb/CWnOrVLTe+GHhGzhDyFVCL18nbnp7naPxWhundOGBqK4R7cqcuLdQSDkbjqQyHUXZHBHzCEOZcYRkA9Shh0yaE3RyUb6dkP4Su19cgBLPnPRqyD7PJFwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878924; c=relaxed/simple;
	bh=DTa4kKCa/dbLXteCEu1pOmOxv6xtXfQJlAlr036MghQ=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=fAimpbdGmqzoW3ZZ8Y/FEdmUpEwbnHeos1ZtNihPuzgDA74Xk6AX6OLhWrBHP2A/07setG7PpyEXSc32kTj6Zklth7FqQ8oAjRuOQcUH/YFZe51do6UiEQRYy2L1n7z3wRRAFfpmE3W+H2NHikV2opEAvkeBemf3+M92IRdL4G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFENU/jM; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20bb39d97d1so31918005ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 21:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728878922; x=1729483722; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q0n3M3lRMu2x3EPFhPx2LmNLycYmfqIiVCwXkFopdKo=;
        b=EFENU/jM9APj8YooiO4lIT3i++jH2oR4Um8wc0VjWuFR9XJv+y3xyR5wOKhibfvIPB
         Wg235Y/t44CiAIpudHWmQmoDUbztUyqJurgsgcksachCNcPy5BZ4iuFDShJe+yLQPkuS
         twlgh9ZOUXKf+Gdlc/U52Ucwn0Xfi7gkOs5r0xMfklVL8JYAWuNY2HO7rM8xuUuCoEKa
         4CIof0H2vc1CNfEP8UNwy7vRioiEN47LL5HBhQ5WgOPPlMwpUi7Q4vXetGLtld0IR4k7
         3U7s6jmIGJFBUOAWLaPchlGia1kzzjpsAz2Yo5ARKzlTZRV6mT930iA2x8bF8pcOxK2Z
         dlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728878922; x=1729483722;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q0n3M3lRMu2x3EPFhPx2LmNLycYmfqIiVCwXkFopdKo=;
        b=xLjniw6DyGZzs3LwxZf4Z2S/y18XmgCz+EJWI1GYafY+4Swh2NzI6HyEbB+oSZP+K6
         vHBEepS/34NnYLqjupiYoIsEckoltDY981+qGsFZWgN6QRJ+h+pYnTaWHjV/pp6QCBvV
         KC1LokRPf3XvYWIc4VA3MYO2uoiyL5/21q7x9gojOaj/RACULdkJqW8zGDsZk1F0URpa
         xr3PfyWYnb3IX1PeYE15Enldo2CifvDxz9s3mgaOCUwMYadM0Vz4j8i7rKOgzKLG19sG
         r0qvKwwjXcvSuIrKOJYhLiDlw8fPCTuHZa6oBP5AmHaTcfjlM8r/pzLHt1aRs6Niyt+I
         3CZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEo6iM62+ygTOzVPUm8ShR+7DcCyl3TEc/KvoyRWig+QTIsMHUcYBW2LhqL6QYcghS84QlueSPJekjQjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRnvM6ylse+dM3HXPjwOFlwGHODXCbMOGKSz5Ko7y+EBLhaCPS
	ZMrpIqfjUnEO0okQ/I6ibWDKkXpawzTQ3dfU+PeIkUkc5UYVYsnGCDWAx5US
X-Google-Smtp-Source: AGHT+IEqIbAqxYF4GO3aZygQ5g3tt3hQnOiAkasSP5hJMEWNkQCio2zgfAGt23pD5wFMsZfTUUmslw==
X-Received: by 2002:a17:90b:88e:b0:2e2:92dc:6fd4 with SMTP id 98e67ed59e1d1-2e2f0aebf4bmr12516934a91.23.1728878921952;
        Sun, 13 Oct 2024 21:08:41 -0700 (PDT)
Received: from smtpclient.apple ([2001:e60:a816:6dac:10d3:523b:453c:7c13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e3132badd2sm4303993a91.40.2024.10.13.21.08.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Oct 2024 21:08:41 -0700 (PDT)
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
Date: Mon, 14 Oct 2024 13:08:29 +0900
Message-Id: <8C4EFDA4-A286-40C9-8F96-BD3EE07D6C45@gmail.com>
References: <CAMgjq7Ah6PjeQuR3PRyRgCpH1ybj=76cmpMfvV50D1prjZpH+w@mail.gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 syzbot+fa43f1b63e3aa6f66329@syzkaller.appspotmail.com
In-Reply-To: <CAMgjq7Ah6PjeQuR3PRyRgCpH1ybj=76cmpMfvV50D1prjZpH+w@mail.gmail.com>
To: Kairui Song <ryncsn@gmail.com>, akpm@linux-foundation.org
X-Mailer: iPhone Mail (21G93)



> Kairui Song <ryncsn@gmail.com> wrote:
>=20
> =EF=BB=BFOn Mon, Oct 14, 2024 at 10:17=E2=80=AFAM Jeongjun Park <aha310510=
@gmail.com> wrote:
>>> Kairui Song <ryncsn@gmail.com> wrote:
>>>=20
>>> =EF=BB=BFOn Mon, Oct 7, 2024 at 3:06=E2=80=AFPM Jeongjun Park <aha310510=
@gmail.com> wrote:
>>>>=20
>>>> A report [1] was uploaded from syzbot.
>>>>=20
>>>> In the previous commit 862590ac3708 ("mm: swap: allow cache reclaim to s=
kip
>>>> slot cache"), the __try_to_reclaim_swap() function reads offset and fol=
io->entry
>>>> from folio without folio_lock protection.
>>>>=20
>>>> In the currently reported KCSAN log, it is assumed that the actual data=
-race
>>>> will not occur because the calltrace that does WRITE already obtains th=
e
>>>> folio_lock and then writes.
>>>>=20
>>>> However, the existing __try_to_reclaim_swap() function was already impl=
emented
>>>> to perform reads under folio_lock protection [1], and there is a risk o=
f a
>>>> data-race occurring through a function other than the one shown in the K=
CSAN
>>>> log.
>>>>=20
>>>> Therefore, I think it is appropriate to change read operations for
>>>> folio to be performed under folio_lock.
>>>>=20
>>>> [1]
>>>>=20
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> BUG: KCSAN: data-race in __delete_from_swap_cache / __try_to_reclaim_sw=
ap
>>>>=20
>>>> write to 0xffffea0004c90328 of 8 bytes by task 5186 on cpu 0:
>>>> __delete_from_swap_cache+0x1f0/0x290 mm/swap_state.c:163
>>>> delete_from_swap_cache+0x72/0xe0 mm/swap_state.c:243
>>>> folio_free_swap+0x1d8/0x1f0 mm/swapfile.c:1850
>>>> free_swap_cache mm/swap_state.c:293 [inline]
>>>> free_pages_and_swap_cache+0x1fc/0x410 mm/swap_state.c:325
>>>> __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
>>>> tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
>>>> tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
>>>> tlb_flush_mmu+0x2cf/0x440 mm/mmu_gather.c:373
>>>> zap_pte_range mm/memory.c:1700 [inline]
>>>> zap_pmd_range mm/memory.c:1739 [inline]
>>>> zap_pud_range mm/memory.c:1768 [inline]
>>>> zap_p4d_range mm/memory.c:1789 [inline]
>>>> unmap_page_range+0x1f3c/0x22d0 mm/memory.c:1810
>>>> unmap_single_vma+0x142/0x1d0 mm/memory.c:1856
>>>> unmap_vmas+0x18d/0x2b0 mm/memory.c:1900
>>>> exit_mmap+0x18a/0x690 mm/mmap.c:1864
>>>> __mmput+0x28/0x1b0 kernel/fork.c:1347
>>>> mmput+0x4c/0x60 kernel/fork.c:1369
>>>> exit_mm+0xe4/0x190 kernel/exit.c:571
>>>> do_exit+0x55e/0x17f0 kernel/exit.c:926
>>>> do_group_exit+0x102/0x150 kernel/exit.c:1088
>>>> get_signal+0xf2a/0x1070 kernel/signal.c:2917
>>>> arch_do_signal_or_restart+0x95/0x4b0 arch/x86/kernel/signal.c:337
>>>> exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
>>>> exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>>>> __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>>>> syscall_exit_to_user_mode+0x59/0x130 kernel/entry/common.c:218
>>>> do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
>>>> entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>>>=20
>>>> read to 0xffffea0004c90328 of 8 bytes by task 5189 on cpu 1:
>>>> __try_to_reclaim_swap+0x9d/0x510 mm/swapfile.c:198
>>>> free_swap_and_cache_nr+0x45d/0x8a0 mm/swapfile.c:1915
>>>> zap_pte_range mm/memory.c:1656 [inline]
>>>> zap_pmd_range mm/memory.c:1739 [inline]
>>>> zap_pud_range mm/memory.c:1768 [inline]
>>>> zap_p4d_range mm/memory.c:1789 [inline]
>>>> unmap_page_range+0xcf8/0x22d0 mm/memory.c:1810
>>>> unmap_single_vma+0x142/0x1d0 mm/memory.c:1856
>>>> unmap_vmas+0x18d/0x2b0 mm/memory.c:1900
>>>> exit_mmap+0x18a/0x690 mm/mmap.c:1864
>>>> __mmput+0x28/0x1b0 kernel/fork.c:1347
>>>> mmput+0x4c/0x60 kernel/fork.c:1369
>>>> exit_mm+0xe4/0x190 kernel/exit.c:571
>>>> do_exit+0x55e/0x17f0 kernel/exit.c:926
>>>> __do_sys_exit kernel/exit.c:1055 [inline]
>>>> __se_sys_exit kernel/exit.c:1053 [inline]
>>>> __x64_sys_exit+0x1f/0x20 kernel/exit.c:1053
>>>> x64_sys_call+0x2d46/0x2d60 arch/x86/include/generated/asm/syscalls_64.h=
:61
>>>> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>>> do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
>>>> entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>>>=20
>>>> value changed: 0x0000000000000242 -> 0x0000000000000000
>>>>=20
>>>> Reported-by: syzbot+fa43f1b63e3aa6f66329@syzkaller.appspotmail.com
>>>> Fixes: 862590ac3708 ("mm: swap: allow cache reclaim to skip slot cache"=
)
>>>> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
>>>> ---
>>>> mm/swapfile.c | 7 ++++---
>>>> 1 file changed, 4 insertions(+), 3 deletions(-)
>>>>=20
>>>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>>>> index 0cded32414a1..eb782fcd5627 100644
>>>> --- a/mm/swapfile.c
>>>> +++ b/mm/swapfile.c
>>>> @@ -194,9 +194,6 @@ static int __try_to_reclaim_swap(struct swap_info_s=
truct *si,
>>>>       if (IS_ERR(folio))
>>>>               return 0;
>>>>=20
>>>> -       /* offset could point to the middle of a large folio */
>>>> -       entry =3D folio->swap;
>>>> -       offset =3D swp_offset(entry);
>>>>       nr_pages =3D folio_nr_pages(folio);
>>>>       ret =3D -nr_pages;
>>>>=20
>>>> @@ -210,6 +207,10 @@ static int __try_to_reclaim_swap(struct swap_info_=
struct *si,
>>>>       if (!folio_trylock(folio))
>>>>               goto out;
>>>>=20
>>>> +       /* offset could point to the middle of a large folio */
>>>> +       entry =3D folio->swap;
>>>> +       offset =3D swp_offset(entry);
>>>> +
>>>>       need_reclaim =3D ((flags & TTRS_ANYWAY) ||
>>>>                       ((flags & TTRS_UNMAPPED) && !folio_mapped(folio))=
 ||
>>>>                       ((flags & TTRS_FULL) && mem_cgroup_swap_full(foli=
o)));
>>>> --
>>>=20
>>> Reviewed-by: Kairui Song <kasong@tencent.com>
>>>=20
>>> Hi Andrew,
>>>=20
>>> Will this be added to stable and 6.12? 862590ac3708 is already in 6.12
>>> and this fixes a potential issue of it.
>>=20
>> As far as I can see, commit 862590ac3708 was applied starting
>> from 6.12-rc1, so it looks like no additional commits are needed
>> for the stable version.
>=20
> Hi, sorry for the confusion, I meant mm-stable, not the stable branch.
> It's better to merge this in 6.12.

I agree with you. I think this vulnerability should be fixed quickly,
so it should be applied directly to the next rc version, not the
next tree. However, this vulnerability does not affect the stable=20
version, so I think it is appropriate to move this patch to the
mm-hotfixes-unstable tree.

What do you think, Andrew?

Regards,

Jeongjun Park

>=20
>> Regards,
>>=20
>> Jeongjun Park

