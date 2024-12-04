Return-Path: <linux-kernel+bounces-432237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 546019E4817
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 23:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3516188045F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 22:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59141C3C13;
	Wed,  4 Dec 2024 22:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AjxIvlHs"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA94192B88
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 22:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733352490; cv=none; b=p626MfLl6tFhRHcJrvS6HCK86umzPno+tPVzibesM+YAVBhs5hwNyRTYazKxevysnJNL67M9akZ2KmGrjhGTvJwT4Xgcww2+ZqBLDDw5WrS12Z7P34a7GMI2Bnb1oEFwupvZJaaIUSJIgRpv8KWSpXyqiN616rCHpFKGQwIMb3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733352490; c=relaxed/simple;
	bh=ihO3CW5VFzATTaROcHLypVMgxnj6D/t73M49l7mA4MU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NX9InCGlKwBbVRwoqB6KyvHadZE/QzvHSuZ/QYW9ZVIvXPofknoQjaEGMqaqFNdNmGv/3Vws0PKn351ofp+fmglyNq7YgGkIR30vXMCBZQZzUwu/ny6aDcQ35kff7j3QkMcFGIy8BWZAEX5fkT7OmbpADk1pPsFRCr6yZ0ZKZYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AjxIvlHs; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d0aab1aafcso1275a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 14:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733352487; x=1733957287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1i377nu++qLdmOLgcxee8cAP5hNqhYVzOX02yU9RrIs=;
        b=AjxIvlHsA45uIuYvc0q0XGmG9atiToYKz4N4P2dwcj668CQ5hHQhtiZLKGJ2jM8hGh
         o3Hm94sCZkRssBTWoqRtB+LRtDxhKTT3skWsoNvfvOgeum7oZs71mc0XX7CxutJR1a1k
         oqffnttGjBVk3cOn1OZR66IFpVvz8OElRCiAheLQRHkJT6BGJVO2mPK77N1bRhz4rqgN
         n0pazUU6CAjsCUIjut2fjNao4FvaLAl7y+a8022Ri2jH31knaJIrLBdDJdAl016QNBFk
         KvSTdf0YWiveqmxe55o1RlvkTrNqEHWbS8AvuVPMe1/yEFYvZX35tFLt9FWPotXGc6O+
         sMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733352487; x=1733957287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1i377nu++qLdmOLgcxee8cAP5hNqhYVzOX02yU9RrIs=;
        b=hDkSH8CFgnK6nPL6wV2H3K8NBKQ2pSYA/Ck1adOqpb8kmSLlbZxN6ogzmXpct+/wFf
         HfhNxm/D/sbtaPN71lmPwOb7AiZIrKO4A8JWyUyZlsZ1ZeU2yfQrgYBAY3JCARu0zJVc
         3nzEb5HQWo5xbXwsxDJRH1lr72yCZmHF0tnMkRlQ/wkyyN3mMxI6BW1sxj/eWIYfZQNA
         MlKQKLlPrfWFFoid2zdc0VVITTpc7OviqHT1cc1osoGKRexF5MbVh0WvljXTQFJuI8Fx
         4u+bnVUTPhhcVNAaWB53mb8JIPxVc1JFTJP/ORmJ2NQIa8154ALi55r3GNdUl2cMqu5C
         hPkA==
X-Forwarded-Encrypted: i=1; AJvYcCV58fzYMEz9OjJPE7lmiK4PAKqNzAxGBSlQrszfHQMMWacm5raoKzJh5qaxxDoW2MJBNGQlqyyFOw13UCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQgHvH5e1appmusHQgAtF/OAs4JR5xxiaUNlX0wGIGTfkDUQet
	S/2nGW1UloZOtay8AIu6bR0YNBcAUy+i9KdJAVaZmk4SRLy3J8JBJB05S5kT27aKWbWhxwgvF17
	aoNt9Hht9Ws9Fs4fwnm4vRWDy42yddz4Be/Pi
X-Gm-Gg: ASbGncvUlmPNLLjATxZWsaj+9yToWz0QtSaQeKWmyB23JTJ6IgxZ33jqQHvQZx8rwZo
	57P4KhP4GEFrIFCV9jfAsHVU6kgXr1oGnfH2/AJVDY0aPmMsV1MopCSuS/1Q=
X-Google-Smtp-Source: AGHT+IFut9yUAXYtT2MdTOBVgQ/tvh7Uh5w614iijMxjBbTbOVc4uk+lry4TS3NDkThd/iprdC4bfMpTsRSsHPDfvSo=
X-Received: by 2002:a05:6402:1342:b0:5d0:dfe4:488a with SMTP id
 4fb4d7f45d1cf-5d1259b6906mr24278a12.2.1733352486308; Wed, 04 Dec 2024
 14:48:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733305182.git.zhengqi.arch@bytedance.com>
 <92aba2b319a734913f18ba41e7d86a265f0b84e2.1733305182.git.zhengqi.arch@bytedance.com>
 <20241204143625.a09c2b8376b2415b985cf50a@linux-foundation.org>
In-Reply-To: <20241204143625.a09c2b8376b2415b985cf50a@linux-foundation.org>
From: Jann Horn <jannh@google.com>
Date: Wed, 4 Dec 2024 23:47:30 +0100
Message-ID: <CAG48ez1HjoZiyk+_JOxcA5eM797vCmzvXaEVUgd6Mkze-aykbg@mail.gmail.com>
Subject: Re: [PATCH v4 09/11] mm: pgtable: reclaim empty PTE page in madvise(MADV_DONTNEED)
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>, david@redhat.com, hughd@google.com, 
	willy@infradead.org, muchun.song@linux.dev, vbabka@kernel.org, 
	peterx@redhat.com, mgorman@suse.de, catalin.marinas@arm.com, will@kernel.org, 
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, 
	x86@kernel.org, lorenzo.stoakes@oracle.com, zokeefe@google.com, 
	rientjes@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 11:36=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed,  4 Dec 2024 19:09:49 +0800 Qi Zheng <zhengqi.arch@bytedance.com> =
wrote:
> > As a first step, this commit aims to synchronously free the empty PTE
> > pages in madvise(MADV_DONTNEED) case. We will detect and free empty PTE
> > pages in zap_pte_range(), and will add zap_details.reclaim_pt to exclud=
e
> > cases other than madvise(MADV_DONTNEED).
> >
> > Once an empty PTE is detected, we first try to hold the pmd lock within
> > the pte lock. If successful, we clear the pmd entry directly (fast path=
).
> > Otherwise, we wait until the pte lock is released, then re-hold the pmd
> > and pte locks and loop PTRS_PER_PTE times to check pte_none() to re-det=
ect
> > whether the PTE page is empty and free it (slow path).
>
> "wait until the pte lock is released" sounds nasty.  I'm not
> immediately seeing the code which does this.  PLease provide more
> description?

It's worded a bit confusingly, but it's fine; a better description
might be "if try_get_and_clear_pmd() fails to trylock the PMD lock
(against lock order), then later, after we have dropped the PTE lock,
try_to_free_pte() takes the PMD and PTE locks in the proper lock
order".

The "wait until the pte lock is released" part is just supposed to
mean that the try_to_free_pte() call is placed after the point where
the PTE lock has been dropped (which makes it possible to take the PMD
lock). It does not refer to waiting for other threads.

> > +void try_to_free_pte(struct mm_struct *mm, pmd_t *pmd, unsigned long a=
ddr,
> > +                  struct mmu_gather *tlb)
> > +{
> > +     pmd_t pmdval;
> > +     spinlock_t *pml, *ptl;
> > +     pte_t *start_pte, *pte;
> > +     int i;
> > +
> > +     pml =3D pmd_lock(mm, pmd);
> > +     start_pte =3D pte_offset_map_rw_nolock(mm, pmd, addr, &pmdval, &p=
tl);
> > +     if (!start_pte)
> > +             goto out_ptl;
> > +     if (ptl !=3D pml)
> > +             spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
> > +
> > +     /* Check if it is empty PTE page */
> > +     for (i =3D 0, pte =3D start_pte; i < PTRS_PER_PTE; i++, pte++) {
> > +             if (!pte_none(ptep_get(pte)))
> > +                     goto out_ptl;
> > +     }
>
> Are there any worst-case situations in which we'll spend uncceptable
> mounts of time running this loop?

This loop is just over a single page table, that should be no more
expensive than what we already do in other common paths like
zap_pte_range().

