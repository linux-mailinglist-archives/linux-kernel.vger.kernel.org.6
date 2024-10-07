Return-Path: <linux-kernel+bounces-352679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBA1992287
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 02:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 627972812E8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 00:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37A8C156;
	Mon,  7 Oct 2024 00:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMSS37ZL"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04B6E552
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 00:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728262206; cv=none; b=ObLwKfFlSTgb5s4QOoFQN22nk7UJlErTzYeytk3CZwy7mymroJe5Zn0AmO0w44TACxjVFjXQhhg9fgqJxM1Ps3Dtmb5IiNk3DovAEFtOIU4LZISiWduSpzJGSHjdpXpEUWjkI4wXsu566d944OI4ybiQcQxV5nCLCA8gO53kdHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728262206; c=relaxed/simple;
	bh=nA8xaZ2y9NXsCYTxA+v+KOBHyBSMDyoVJMvUzLjaM4Q=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=cHrnzaiGffWVCtvI4h4oDAn66jDY2xHUfd7kh4AJHCZVrWBiTLFS2K6JTs9VC0C4SXWFrwMqDtt5K/QbqVytc5HQeRx0wZU5zboRA/2k2+QAobbxBWaAbJ8Rh9aNBXVRaLJ+71ZfrZhS669N/l6tfShSqbaTl5GZlbcixmWCYXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMSS37ZL; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7163489149eso3449501a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 17:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728262204; x=1728867004; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9UoEirc48WoShRWJkgSyYJTn+CPG6EgZ9obsIIAaI4M=;
        b=IMSS37ZLcGAsHCjByV3VD2+zeKNeTZfL6NJMsqtgilF/t+bYI4pT0lYSMTCSnUDAE3
         WIcuXYPfoTwK/9qGKOCdJveR/xGYexIcxnW8l7O6ZtalUv9SAN7tqxyZMbAyx8IQfKio
         JpqU85T9gy/PsRYIRWWkObbgw5IARwc+GO2cub+lzAn3fngiaG61SdBRxT/wOnUmAM7E
         LrBwxzykQmHmcd8ISh5iCO82WMSMxZFc0qHYpHTBjCJ34UvamP7vzYBew3pHTQZoGmBU
         YbuvlduJcQfqLlRcKfXPaLZ4oaJ96wi1FrgdnmEXIjKgXn53xZ+wedFy7UrK6gIykHQl
         WJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728262204; x=1728867004;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UoEirc48WoShRWJkgSyYJTn+CPG6EgZ9obsIIAaI4M=;
        b=WvUPlB9UBNYQPceA8SnXhVXCG8CnzGC/gQZ8tgmhNiLgpLlHiVU0WHWJg+ck4JHaT4
         0qZmF8gCZOKZa1OrWZy0LMX1tRAHSKIu2D2hDo2GVW663RxGJYhOEBRcuqgs6y6pCCmL
         a3sQpAAOeGDwp8UtLWvpOEO4eYjVA57E1abZ7MgvjHImPjBinbrIk/gPD5/4VrMHElyu
         y4P0Mc6AePKRxYVKrs4meM8oFHNdU5tr9hZRr8UTDGy0XKNub7uMV++SwWjnzPd0eO2e
         UbCKL/YrJRbVd8G3dzVM929Bl4axa1envU6ZJpjGReoXfft0Lc/MVQiHkR5I/3AvIk3U
         9sYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/dDrnwzA5ONVfJvjhM4yGxJZj53yO2gJsY8RJf8FX2BvCDCbIC/cUOo5diDcnLnr5H20PT2Acl6UixDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTwRNGvLHD5RlcK1uS9WjxJup1xR1bUy5UXGawQUxTfP4u4iA+
	HmhBj2XjkwvEvttAlgo+DhiFO9T/x7UQN/pssV8DhX8zcxUXpuGn8IShdQPk
X-Google-Smtp-Source: AGHT+IHHu/1Qvsm4TuMguUJKhX8HZEAb0EwSOOD8UY1BCN9lYnpVX1gV7+okdDZdgqO+x8zgrfn/Rg==
X-Received: by 2002:a05:6a21:2d84:b0:1d5:10c3:af5a with SMTP id adf61e73a8af0-1d6dfae286emr13465380637.47.1728262203776;
        Sun, 06 Oct 2024 17:50:03 -0700 (PDT)
Received: from smtpclient.apple ([2001:e60:a831:3e8c:ac0b:7f7:4372:3af9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6c491e2sm3746061a12.77.2024.10.06.17.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2024 17:50:03 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Jeongjun Park <aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm: swap: prevent possible data-race in __try_to_reclaim_swap
Date: Mon, 7 Oct 2024 09:49:51 +0900
Message-Id: <C53384BB-34E9-4C50-B8EC-9B9D59D2A45A@gmail.com>
References: <CAMgjq7A4O=Yruznhxd+hqBE=XohWwHx=UyJVNPENHA+Mx3kLtQ@mail.gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 syzbot+fa43f1b63e3aa6f66329@syzkaller.appspotmail.com
In-Reply-To: <CAMgjq7A4O=Yruznhxd+hqBE=XohWwHx=UyJVNPENHA+Mx3kLtQ@mail.gmail.com>
To: Kairui Song <ryncsn@gmail.com>
X-Mailer: iPhone Mail (21G93)


Kairui Song <ryncsn@gmail.com> wrote:
>=20
> =EF=BB=BFOn Fri, Oct 4, 2024 at 10:26=E2=80=AFPM Jeongjun Park <aha310510@=
gmail.com> wrote:
>>=20
>> A report [1] was uploaded from syzbot.
>>=20
>> In the previous commit 862590ac3708 ("mm: swap: allow cache reclaim to sk=
ip
>> slot cache"), the __try_to_reclaim_swap() function reads offset and nr_pa=
ges
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
>> Therefore, I think it is appropriate to change all read operations for
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
>> mm/swapfile.c | 13 ++++++-------
>> 1 file changed, 6 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index 0cded32414a1..904c21256fc2 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -193,13 +193,6 @@ static int __try_to_reclaim_swap(struct swap_info_st=
ruct *si,
>>        folio =3D filemap_get_folio(address_space, swap_cache_index(entry)=
);
>>        if (IS_ERR(folio))
>>                return 0;
>> -
>> -       /* offset could point to the middle of a large folio */
>> -       entry =3D folio->swap;
>> -       offset =3D swp_offset(entry);
>> -       nr_pages =3D folio_nr_pages(folio);
>> -       ret =3D -nr_pages;
>> -
>>        /*
>>         * When this function is called from scan_swap_map_slots() and it'=
s
>>         * called by vmscan.c at reclaiming folios. So we hold a folio loc=
k
>> @@ -210,6 +203,12 @@ static int __try_to_reclaim_swap(struct swap_info_st=
ruct *si,
>>        if (!folio_trylock(folio))
>>                goto out;
>>=20
>> +       /* offset could point to the middle of a large folio */
>> +       entry =3D folio->swap;
>> +       offset =3D swp_offset(entry);
>> +       nr_pages =3D folio_nr_pages(folio);
>> +       ret =3D -nr_pages;
>> +
>>        need_reclaim =3D ((flags & TTRS_ANYWAY) ||
>>                        ((flags & TTRS_UNMAPPED) && !folio_mapped(folio)) |=
|
>>                        ((flags & TTRS_FULL) && mem_cgroup_swap_full(folio=
)));
>> --
>>=20
>=20
> Thanks for catching this!
>=20
> This could lead to real problems, holding reference is not enough for
> protecting folio->swap. There are several BUG_ONs later that will be
> triggered if it changed.
>=20
> But you still have to keep `nr_pages ` and `ret` before the
> `folio_trylock `, or `ret` will be uninitialized if folio_trylock
> fails, this function should always return the page number even if the
> try lock failed. And as WIlly said, `folio_nr_pages` doesn't require
> folio lock.

Oh, I see. After looking at the code again, I realized that=20
if we can get the folio, you should return a valid nr_pages=20
even if folio_trylock fails.=20

I'll send v2 patch with that shortly.

Regards,
Jeongjun Park=

