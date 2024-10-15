Return-Path: <linux-kernel+bounces-365780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF7A99E9DB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B447284095
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332F220111A;
	Tue, 15 Oct 2024 12:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKRcuqPu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF9E207A1E
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 12:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728995280; cv=none; b=YX56aja4W8PtgABncRPCsNl25P1cvZnQigRqp1Rj2qREeYNm0IJ0OxEjwRo/nWChwQ38uXVqCMR8Rv8Xd7M6CNDzhQ6iveQjNsnDgq4uH3oA375e96S4ATQ8FG4taiZlh5u0fHPQgvW9A3Sn6hUhjtynvF5uh2kzvHiCyvA7Kn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728995280; c=relaxed/simple;
	bh=PNLn1/pCtXUyStU0U2BVMLfpIt+9X20DAEgGORY0iH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nyv4S111gQJt3ZpE+L+NwRY6TCoIAtPBEWTnQNynOCcQM22ogJDw6E25bUztpUUFpq3FQZO8X00aELN1YO3mkRqJZ7G/mtZXzMNskm4v0VzDJj2QrWe3pOC8YoIadOm1m/8gBsfRGIGE2+z9dgIekqg5eP675O1idzumdyXIz3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKRcuqPu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A98DC4CEC6
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 12:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728995280;
	bh=PNLn1/pCtXUyStU0U2BVMLfpIt+9X20DAEgGORY0iH4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DKRcuqPufglS2KDcdgst9CtDv9nI0ZLxzJ6tvHWGLDLJ0fQDbK31YVylSYaLqcq0i
	 Uxkg+ll5WZV+HMnHSv1bqOEcntWVPdennBVpf/oiBeaMyR+ysDH+0ceixuwOJrgl3G
	 veEGqMZEuNR3/dTgJqknrlBGhyLsp4om/nl9FPotEgoDsp0VCuai7u4F/RU+K8OYlj
	 rJL6/ZwRQ5ucGp5CCwd+9gfcAPKwH49ZGqZE/j6gwrCko1vhQkkXGfXEA7Gs/Xkw9a
	 XEqI1cNbTm9KN78ga0Y86dynyneFcuGeDqb22sjVSAsk6uphgCXGDOBpqbQhQw6fD9
	 3tLgDjQ999qsg==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9a2209bd7fso178747066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 05:28:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXD424ahFYpBSOAGlYuLRucCb0AH07ToYxKSzoX0rj2JaCbbBF2owmHLAqoqQOYOhIFfFFA4ng4v4wnpfo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy71C3WB47Lh8YhMgx2I9utBU3TK6BzvCHpPIfv0RZraXiFkkP
	St/VLeaMKPsUgyPD55F1WNYRuNEQV67xsQJkBmujS+xzW1Y4JiaSM1yV2TFyeP78BxN3i72QsEU
	DwZil51M6E2t7S0EfTgtEiMqHPMg=
X-Google-Smtp-Source: AGHT+IF7wVxa4z12T17CxaCFQcgsO/SFzkpZWZ6Gldwe9M2owZr6r0gxkCYAZsQRGltQQSnQfoF0tccs3lOOlaBOnJY=
X-Received: by 2002:a17:907:934e:b0:a9a:26dd:16bc with SMTP id
 a640c23a62f3a-a9a34d3b5dcmr396366b.5.1728995278707; Tue, 15 Oct 2024 05:27:58
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014035855.1119220-1-maobibo@loongson.cn> <20241014035855.1119220-3-maobibo@loongson.cn>
 <CAAhV-H6nkiw_eOS3jFdojJsCJOA2yiprQmaT5c=SnPhJTOyKkQ@mail.gmail.com> <e7c06bf4-897a-7060-61f9-97435d2af16e@loongson.cn>
In-Reply-To: <e7c06bf4-897a-7060-61f9-97435d2af16e@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 15 Oct 2024 20:27:46 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6H=Q=1KN5q8kR3j55Ky--FRNifCT93axhqE=vNMArDaQ@mail.gmail.com>
Message-ID: <CAAhV-H6H=Q=1KN5q8kR3j55Ky--FRNifCT93axhqE=vNMArDaQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] LoongArch: Add barrier between set_pte and memory access
To: maobibo <maobibo@loongson.cn>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Barry Song <baohua@kernel.org>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 10:54=E2=80=AFAM maobibo <maobibo@loongson.cn> wrot=
e:
>
>
>
> On 2024/10/14 =E4=B8=8B=E5=8D=882:31, Huacai Chen wrote:
> > Hi, Bibo,
> >
> > On Mon, Oct 14, 2024 at 11:59=E2=80=AFAM Bibo Mao <maobibo@loongson.cn>=
 wrote:
> >>
> >> It is possible to return a spurious fault if memory is accessed
> >> right after the pte is set. For user address space, pte is set
> >> in kernel space and memory is accessed in user space, there is
> >> long time for synchronization, no barrier needed. However for
> >> kernel address space, it is possible that memory is accessed
> >> right after the pte is set.
> >>
> >> Here flush_cache_vmap/flush_cache_vmap_early is used for
> >> synchronization.
> >>
> >> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >> ---
> >>   arch/loongarch/include/asm/cacheflush.h | 14 +++++++++++++-
> >>   1 file changed, 13 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/loongarch/include/asm/cacheflush.h b/arch/loongarch/=
include/asm/cacheflush.h
> >> index f8754d08a31a..53be231319ef 100644
> >> --- a/arch/loongarch/include/asm/cacheflush.h
> >> +++ b/arch/loongarch/include/asm/cacheflush.h
> >> @@ -42,12 +42,24 @@ void local_flush_icache_range(unsigned long start,=
 unsigned long end);
> >>   #define flush_cache_dup_mm(mm)                         do { } while =
(0)
> >>   #define flush_cache_range(vma, start, end)             do { } while =
(0)
> >>   #define flush_cache_page(vma, vmaddr, pfn)             do { } while =
(0)
> >> -#define flush_cache_vmap(start, end)                   do { } while (=
0)
> >>   #define flush_cache_vunmap(start, end)                 do { } while =
(0)
> >>   #define flush_icache_user_page(vma, page, addr, len)   do { } while =
(0)
> >>   #define flush_dcache_mmap_lock(mapping)                        do { =
} while (0)
> >>   #define flush_dcache_mmap_unlock(mapping)              do { } while =
(0)
> >>
> >> +/*
> >> + * It is possible for a kernel virtual mapping access to return a spu=
rious
> >> + * fault if it's accessed right after the pte is set. The page fault =
handler
> >> + * does not expect this type of fault. flush_cache_vmap is not exactl=
y the
> >> + * right place to put this, but it seems to work well enough.
> >> + */
> >> +static inline void flush_cache_vmap(unsigned long start, unsigned lon=
g end)
> >> +{
> >> +       smp_mb();
> >> +}
> >> +#define flush_cache_vmap flush_cache_vmap
> >> +#define flush_cache_vmap_early flush_cache_vmap
> >  From the history of flush_cache_vmap_early(), It seems only archs with
> > "virtual cache" (VIVT or VIPT) need this API, so LoongArch can be a
> > no-op here.
OK,  flush_cache_vmap_early() also needs smp_mb().

>
> Here is usage about flush_cache_vmap_early in file linux/mm/percpu.c,
> map the page and access it immediately. Do you think it should be noop
> on LoongArch.
>
> rc =3D __pcpu_map_pages(unit_addr, &pages[unit * unit_pages],
>                                       unit_pages);
> if (rc < 0)
>      panic("failed to map percpu area, err=3D%d\n", rc);
>      flush_cache_vmap_early(unit_addr, unit_addr + ai->unit_size);
>      /* copy static data */
>      memcpy((void *)unit_addr, __per_cpu_load, ai->static_size);
> }
>
>
> >
> > And I still think flush_cache_vunmap() should be a smp_mb(). A
> > smp_mb() in flush_cache_vmap() prevents subsequent accesses be
> > reordered before pte_set(), and a smp_mb() in flush_cache_vunmap()
> smp_mb() in flush_cache_vmap() does not prevent reorder. It is to flush
> pipeline and let page table walker HW sync with data cache.
>
> For the following example.
>    rb =3D vmap(pages, nr_meta_pages + 2 * nr_data_pages,
>                    VM_MAP | VM_USERMAP, PAGE_KERNEL);
>    if (rb) {
> <<<<<<<<<<< * the sentence if (rb) can prevent reorder. Otherwise with
> any API kmalloc/vmap/vmalloc and subsequent memory access, there will be
> reorder issu. *
>        kmemleak_not_leak(pages);
>        rb->pages =3D pages;
>        rb->nr_pages =3D nr_pages;
>        return rb;
>    }
>
> > prevents preceding accesses be reordered after pte_clear(). This
> Can you give an example about such usage about flush_cache_vunmap()? and
> we can continue to talk about it, else it is just guessing.
Since we cannot reach a consensus, and the flush_cache_* API look very
strange for this purpose (Yes, I know PowerPC does it like this, but
ARM64 doesn't). I prefer to still use the ARM64 method which means add
a dbar in set_pte(). Of course the performance will be a little worse,
but still better than the old version, and it is more robust.

I know you are very busy, so if you have no time you don't need to
send V3, I can just do a small modification on the 3rd patch.


Huacai

>
> Regards
> Bibo Mao
> > potential problem may not be seen from experiment, but it is needed in
> > theory.
> >
> > Huacai
> >
> >> +
> >>   #define cache_op(op, addr)                                          =
   \
> >>          __asm__ __volatile__(                                        =
   \
> >>          "       cacop   %0, %1                                  \n"  =
   \
> >> --
> >> 2.39.3
> >>
> >>
>
>

