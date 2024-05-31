Return-Path: <linux-kernel+bounces-196747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777478D610F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E2DA286103
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792EC158219;
	Fri, 31 May 2024 11:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/b0Px03"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D8B15820F
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 11:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717156566; cv=none; b=V+/Ecnifsnoxti7FV29TEI6ilvM28qeDVs6oCSBvv+4H5r217IyNOjefVO3bTOtxfmpvmvLGhRQyEdbi8CXn0NqNyjjNN/dbSiV3xdzFocjYb99jBTAcR2WDlsmg64ekA4rgn3wpHowLNg4fqBCWr360d+xidZA2wPFmCPguUew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717156566; c=relaxed/simple;
	bh=5szRaxmWnqzaS+EGbuG6yS90OC2sUaYERFChoSSUU7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TDqtvhMgSbE6ri09u6btN+aUbBbMIBwLjNac95KFQuvOUqZV8jNnZvIhSCyia11MSmBy7gG2mXlR1DN/7vexmWyRk3OuV3oW8H8gAtzFDSIj+s0PPEYdjbUf9AJPapCJO5WavmoTPjEUZ3XYZIXdFYkJywaX8l9Nu0WtDz1Kt9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/b0Px03; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4e1c721c040so691001e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 04:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717156564; x=1717761364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQxilVtxLYz3Pay3/b52pECIgOOAi98LJMD2Qy2kC+Q=;
        b=E/b0Px03eG/CYGDdu8vMvCoC5RvIyvYSXNi5xnHbh8gZQY6/Kveo4Q6mHBDX9R8JRg
         iciVbn9r1pl/44RPXGfJcVXlFkKogW+plowgYFljsjulYEjEDvJxW3o82ZnWKzI8sBb5
         ccyJ4qBxrF1l3sQnmbuLSDRATDxrrIyUqxXSgLobf33JVvw0OP5RU6niUQ/jCfbItEQI
         3GYyRtYctxJpWQg2gNpNbHyrowYCi6/Q6nuhAdrbRcQXOi4kdbxzKfIcXGrscPNKcpp9
         +J18XFU9v06LK/7b8JbdyXXMgmte+7IjWy7B0QMRdXc15GkCTkF9/j1lsU+X9EFqCb58
         hC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717156564; x=1717761364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQxilVtxLYz3Pay3/b52pECIgOOAi98LJMD2Qy2kC+Q=;
        b=XkuW662SNfEALydzUo3rM/iJVXFGQPWq0acFqOZsBfGDagQU0Npo9bw76DYw31M2nR
         JnciYKdf6WNvDdzPKC2tGlEU/UGmURcHNIlrZQQ3dK02XiZHY5uaHJOhsxVKVpt/8ryZ
         CDRrkWGsRFikl8zFmJg6H+fmqa1eHwBw8i12bNdtfcKcVoHbsg0mb0KtAXfXcp6hTuZ1
         GdTXanxNMu6rFUCdA8q2ar6WtGZ7wzr+U7dBL4qhGoSl0ppJzDP5A99hJzW1u0h4a/DL
         AVNguBPBxu4lMiFz39Nc7B1LVytR4BvoQCGLzmTnljpScM7w5RzqiJY+S66E/2kaYnZW
         uQHw==
X-Forwarded-Encrypted: i=1; AJvYcCUGMKQGlaTMdF0gGmu5sW7SH35KZZe03aP7mKFBPeYsAHrK5DcFpDQPIcvObXcG2HzxKNcX7/3XUIEYPyNbzNeS4jZXpPz/2qtHXxQC
X-Gm-Message-State: AOJu0Yy9nTJFbefhwdCxyPTCK6sywe8f7o3JjFMnJhgGzyELGQ1DJLtn
	qGw1/qoAOdFCpz9qKgyWQtlg1l0fI5xLId/tTLEhW9cGTLwlfoEMYOtaY+kwhgdlf4BGJ2oMaKR
	MxbZmOhQ+Ffyc0fT/7BzSuGqz5fz45nn/
X-Google-Smtp-Source: AGHT+IENheezYWDrZmGudS5loMzwnDgESISvO+ZVKHu3Dr8W5sTiuO2SHQuiiiLbNMMR8YqWZxyxJ0G2WXA7YFnvd8A=
X-Received: by 2002:a1f:f24b:0:b0:4e4:e8a7:2620 with SMTP id
 71dfb90a1353d-4eb02ede2aemr1632753e0c.14.1717156563797; Fri, 31 May 2024
 04:56:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531104819.140218-1-21cnbao@gmail.com> <87ac9610-5650-451f-aa54-e634a6310af4@redhat.com>
In-Reply-To: <87ac9610-5650-451f-aa54-e634a6310af4@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 31 May 2024 23:55:51 +1200
Message-ID: <CAGsJ_4zgf8j0oRnVBhe-__=K2RFDHTCo-JnMak95HTvxtMUwnQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: swap: reuse exclusive folio directly instead of
 wp page faults
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, chrisl@kernel.org, 
	surenb@google.com, kasong@tencent.com, minchan@kernel.org, 
	willy@infradead.org, ryan.roberts@arm.com, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 11:08=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 31.05.24 12:48, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > After swapping out, we perform a swap-in operation. If we first read
> > and then write, we encounter a major fault in do_swap_page for reading,
> > along with additional minor faults in do_wp_page for writing. However,
> > the latter appears to be unnecessary and inefficient. Instead, we can
> > directly reuse in do_swap_page and completely eliminate the need for
> > do_wp_page.
> >
> > This patch achieves that optimization specifically for exclusive folios=
.
> > The following microbenchmark demonstrates the significant reduction in
> > minor faults.
> >
> >   #define DATA_SIZE (2UL * 1024 * 1024)
> >   #define PAGE_SIZE (4UL * 1024)
> >
> >   static void *read_write_data(char *addr)
> >   {
> >           char tmp;
> >
> >           for (int i =3D 0; i < DATA_SIZE; i +=3D PAGE_SIZE) {
> >                   tmp =3D *(volatile char *)(addr + i);
> >                   *(volatile char *)(addr + i) =3D tmp;
> >           }
> >   }
> >
> >   int main(int argc, char **argv)
> >   {
> >           struct rusage ru;
> >
> >           char *addr =3D mmap(NULL, DATA_SIZE, PROT_READ | PROT_WRITE,
> >                           MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> >           memset(addr, 0x11, DATA_SIZE);
> >
> >           do {
> >                   long old_ru_minflt, old_ru_majflt;
> >                   long new_ru_minflt, new_ru_majflt;
> >
> >                   madvise(addr, DATA_SIZE, MADV_PAGEOUT);
> >
> >                   getrusage(RUSAGE_SELF, &ru);
> >                   old_ru_minflt =3D ru.ru_minflt;
> >                   old_ru_majflt =3D ru.ru_majflt;
> >
> >                   read_write_data(addr);
> >                   getrusage(RUSAGE_SELF, &ru);
> >                   new_ru_minflt =3D ru.ru_minflt;
> >                   new_ru_majflt =3D ru.ru_majflt;
> >
> >                   printf("minor faults:%ld major faults:%ld\n",
> >                           new_ru_minflt - old_ru_minflt,
> >                           new_ru_majflt - old_ru_majflt);
> >           } while(0);
> >
> >           return 0;
> >   }
> >
> > w/o patch,
> > / # ~/a.out
> > minor faults:512 major faults:512
> >
> > w/ patch,
> > / # ~/a.out
> > minor faults:0 major faults:512
> >
> > Minor faults decrease to 0!
> >
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >   mm/memory.c | 7 ++++---
> >   1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index eef4e482c0c2..e1d2e339958e 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4325,9 +4325,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >        */
> >       if (!folio_test_ksm(folio) &&
> >           (exclusive || folio_ref_count(folio) =3D=3D 1)) {
> > -             if (vmf->flags & FAULT_FLAG_WRITE) {
> > -                     pte =3D maybe_mkwrite(pte_mkdirty(pte), vma);
> > -                     vmf->flags &=3D ~FAULT_FLAG_WRITE;
> > +             if (vma->vm_flags & VM_WRITE) {
> > +                     pte =3D pte_mkwrite(pte_mkdirty(pte), vma);
> > +                     if (vmf->flags & FAULT_FLAG_WRITE)
> > +                             vmf->flags &=3D ~FAULT_FLAG_WRITE;
>
> This implies, that even on a read fault, you would mark the pte dirty
> and it would have to be written back to swap if still in the swap cache
> and only read.
>
> That is controversial.
>
> What is less controversial is doing what mprotect() via
> change_pte_range()/can_change_pte_writable() would do: mark the PTE
> writable but not dirty.
>
> I suggest setting the pte only dirty if FAULT_FLAG_WRITE is set.

Thanks!

I assume you mean something as below?

diff --git a/mm/memory.c b/mm/memory.c
index eef4e482c0c2..dbf1ba8ccfd6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4317,6 +4317,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
        add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
        pte =3D mk_pte(page, vma->vm_page_prot);

+       if (pte_swp_soft_dirty(vmf->orig_pte))
+               pte =3D pte_mksoft_dirty(pte);
+       if (pte_swp_uffd_wp(vmf->orig_pte))
+               pte =3D pte_mkuffd_wp(pte);
        /*
         * Same logic as in do_wp_page(); however, optimize for pages that =
are
         * certainly not shared either because we just allocated them witho=
ut
@@ -4325,18 +4329,19 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
         */
        if (!folio_test_ksm(folio) &&
            (exclusive || folio_ref_count(folio) =3D=3D 1)) {
-               if (vmf->flags & FAULT_FLAG_WRITE) {
-                       pte =3D maybe_mkwrite(pte_mkdirty(pte), vma);
-                       vmf->flags &=3D ~FAULT_FLAG_WRITE;
+               if (vma->vm_flags & VM_WRITE) {
+                       if (vmf->flags & FAULT_FLAG_WRITE) {
+                               pte =3D pte_mkwrite(pte_mkdirty(pte), vma);
+                               vmf->flags &=3D ~FAULT_FLAG_WRITE;
+                       } else if ((!vma_soft_dirty_enabled(vma) ||
pte_soft_dirty(pte))
+                                   && !userfaultfd_pte_wp(vma, pte)) {
+                                       pte =3D pte_mkwrite(pte, vma);
+                       }
                }
                rmap_flags |=3D RMAP_EXCLUSIVE;
        }
        folio_ref_add(folio, nr_pages - 1);
        flush_icache_pages(vma, page, nr_pages);
-       if (pte_swp_soft_dirty(vmf->orig_pte))
-               pte =3D pte_mksoft_dirty(pte);
-       if (pte_swp_uffd_wp(vmf->orig_pte))
-               pte =3D pte_mkuffd_wp(pte);
        vmf->orig_pte =3D pte_advance_pfn(pte, page_idx);

        /* ksm created a completely new copy */


>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry

