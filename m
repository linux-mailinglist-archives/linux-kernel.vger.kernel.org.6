Return-Path: <linux-kernel+bounces-398699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B11119BF4DD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB7D11C23766
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1FC207A30;
	Wed,  6 Nov 2024 18:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cbhsWiiy"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61823206948
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 18:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730916640; cv=none; b=dBv8qR13PvSi+8lcK9HWQbhOf5XlgWNCi8lImtfVieDhmrfRE8KtaLHkHHeTBjUVDcZiCp2U0q+n7SAopKnRaon9WZYkWSs5KWYupgTqy0Ir38HsF4WtNjkNzQ6KMdBmUCOh6bvNsGbuuqnMJ4Bkd5KzK9Inm1hPzO29qWBlvoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730916640; c=relaxed/simple;
	bh=PkPc+B615k/kXFxDS+L9I6dgsDOmeLZNoXXNnkOMAUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tTLKzrGxJu9MjRa3skt1BkcuJWZNT76xzS7oFN0NpN2jQnGp/Tl8DNQeaiizdK6F10X1NJKQ9OqK+CyKJQlb2E1MTYRfUv+l7/Q6qjOvTeGWm36nmR4V0dDSxreOjWD/kDNITK3XIXhHQSs1RfDxQM1Kxi5qkGUXUwxgjj6d8xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cbhsWiiy; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c947c00f26so1090a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 10:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730916636; x=1731521436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpqiovl0ffII9JvtOiEcilqO6gAo6Ysuk7IQTNDHH1E=;
        b=cbhsWiiyfjGvIlEiDlfACsw7l1jb9cdeeh4nJPlS+ZA1vzch9YsysDOffzQdjlIIuF
         TqkFRQvkb0hQ4bBfAppn8QywrTXHmVnT1J8EtgR77ueAmevFizoQqMCxDi6WAAIB0Y55
         jIMTVADnu7lyk9Jo9ckpGpJuBGqDv2y70w+AvgKDQvOgFMeVGhTy1RslhGXgwh5DZnDE
         NorfLJiHt3zMfe4eArbNpC1GI8k/9Quhsqd20LD/K2jzNRYMxZwPcsP06zt6Z1XH92P1
         wb3+UACnnwxARyN4TKf6ULgno2NAs+ZqeZ9UL1+5q4ZVq8Xg59JrXPpCrNkX2O3k/Fr5
         +elg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730916636; x=1731521436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpqiovl0ffII9JvtOiEcilqO6gAo6Ysuk7IQTNDHH1E=;
        b=dhNYtYZYjSOi1JrrsOvN/u+tZ673+xqPoPLRt5unS4QgganU30b25/ocqnAFm4ilCQ
         RCF2UDDnNkB1P9rqyVo6oZ9KURZ4AQcSo5+8swRd78bd+O3w6g2b1MfvHcTEj7c5bnvQ
         cC8QuCH38BPe/axbIA5tJcGyU79QJWFq43qVAZo9B8s+zF91/gbav4Drday/arLJ8aeu
         vLGM2hZHz0sAE7rmL1rBNCGaSYqThU3IZjkHo6Dq37bsccdLq0xittnnpyVL9mbq078x
         gRPH0Ir2F/DRsEgLRWUp0IdjnMkA484Ud87AnPo1WzcI4s+D2pes6KAVNJupsdFTnVZa
         Zwog==
X-Forwarded-Encrypted: i=1; AJvYcCVyHprvqOrWDvWVFrRGBaw/UtF0LXE0uq5hz5Ln7uFMzw9AEIGoQjCzCPAXwxLj5UeeZusJzqver29t4rY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEaNj02/iNsrt+vZTYJjcQxUAvI9GgpjSsKka0v13TAHgRVcIH
	GVqzk5+efrf7PmxvED228cQLLBz3XiEQn4+X+yBLMajMm1ORwGSV/zxmaSet4Irw+TxjRZ8zTKP
	5J21gPe13SPM6RfuEcJ2F2cvl/7ITwilP4pXL
X-Gm-Gg: ASbGncssW13SlGCtMJO4NR6dXZu4ALGpiNJy/8D3i1CQLprq5VHDt4k1zEkFdViX0UW
	I2h+CsAH43TGpDsEWvBWFZH51OXYnFsH1uuK78NGartigFGWfT3eaQPc9lKY=
X-Google-Smtp-Source: AGHT+IFfu8DjAm0U1ISPoTiJAxlj7uKrBs27eWrWlAcwhN7fibd3fMEyowQvMJcxtq9Vya2Xc31xMnfP1tRWRloFaGo=
X-Received: by 2002:a05:6402:6c1:b0:5c9:85dc:5ae2 with SMTP id
 4fb4d7f45d1cf-5cefbcd6d8bmr119927a12.7.1730916635289; Wed, 06 Nov 2024
 10:10:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101185033.131880-1-lorenzo.stoakes@oracle.com>
 <CAG48ez0qsAM-dkOUDetmNBSK4typ5t_FvMvtGiB7wQsP-G1jVg@mail.gmail.com>
 <2bf6329e-eb3b-4c5e-bd3a-b519eefffd63@lucifer.local> <CAG48ez1eeQatc0GC_hfOM_mvwjwQ=89JDmp_U5_diLy7ycjEdQ@mail.gmail.com>
 <c0f64fa7-81fd-4691-86b5-2ad39ba9d8a7@bytedance.com>
In-Reply-To: <c0f64fa7-81fd-4691-86b5-2ad39ba9d8a7@bytedance.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 6 Nov 2024 19:09:58 +0100
Message-ID: <CAG48ez3hyaymBo_Y9V2Hpx8TRHbE2WyZoeLhi1n0VW9Np7iw2Q@mail.gmail.com>
Subject: Re: [RFC PATCH] docs/mm: add VMA locks documentation
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 4:09=E2=80=AFAM Qi Zheng <zhengqi.arch@bytedance.com=
> wrote:
> On 2024/11/5 05:29, Jann Horn wrote:
> > On Mon, Nov 4, 2024 at 5:42=E2=80=AFPM Lorenzo Stoakes
>
> [...]
>
> >
> > I think it's important to know about the existence of hardware writes
> > because it means you need atomic operations when making changes to
> > page tables. Like, for example, in many cases when changing a present
> > PTE, you can't even use READ_ONCE()/WRITE_ONCE() for PTEs and need
> > atomic RMW operations instead - see for example ptep_get_and_clear(),
> > which is basically implemented in arch code as an atomic xchg so that
> > it can't miss concurrent A/D bit updates.
> >
>
> Totally agree! But I noticed before that ptep_clear() doesn't seem
> to need atomic operations because it doesn't need to care about the
> A/D bit.
>
> I once looked at the history of how the ptep_clear() was introduced.
> If you are interested, you can take a look at my local draft below.
> Maybe I missed something.
>
> ```
> mm: pgtable: make ptep_clear() non-atomic
>
>      In the generic ptep_get_and_clear() implementation, it is just a sim=
ple
>      combination of ptep_get() and pte_clear(). But for some architecture=
s
>      (such as x86 and arm64, etc), the hardware will modify the A/D bits
> of the
>      page table entry, so the ptep_get_and_clear() needs to be overwritte=
n
>      and implemented as an atomic operation to avoid contention, which ha=
s a
>      performance cost.
>
>      The commit d283d422c6c4 ("x86: mm: add x86_64 support for page table
>      check") adds the ptep_clear() on the x86, and makes it call
>      ptep_get_and_clear() when CONFIG_PAGE_TABLE_CHECK is enabled. The pa=
ge
>      table check feature does not actually care about the A/D bits, so on=
ly
>      ptep_get() + pte_clear() should be called. But considering that the
> page
>      table check is a debug option, this should not have much of an impac=
t.
>
>      But then the commit de8c8e52836d ("mm: page_table_check: add hooks t=
o
>      public helpers") changed ptep_clear() to unconditionally call
>      ptep_get_and_clear(), so that the  CONFIG_PAGE_TABLE_CHECK check can=
 be
>      put into the page table check stubs (in
> include/linux/page_table_check.h).
>      This also cause performance loss to the kernel without
>      CONFIG_PAGE_TABLE_CHECK enabled, which doesn't make sense.
>
>      To fix it, just calling ptep_get() and pte_clear() in the ptep_clear=
().
>
>      Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 117b807e3f894..2ace92293f5f5 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -506,7 +506,10 @@ static inline void clear_young_dirty_ptes(struct
> vm_area_struct *vma,
>   static inline void ptep_clear(struct mm_struct *mm, unsigned long addr,
>                                pte_t *ptep)
>   {
> -       ptep_get_and_clear(mm, addr, ptep);
> +       pte_t pte =3D ptep_get(ptep);
> +
> +       pte_clear(mm, addr, ptep);
> +       page_table_check_pte_clear(mm, pte);
>   }
>
> ```

ptep_clear() is currently only used in debug code and in khugepaged
collapse paths, which are fairly expensive, so I don't think the cost
of an extra atomic RMW op should matter here; but yeah, the change
looks correct to me.

