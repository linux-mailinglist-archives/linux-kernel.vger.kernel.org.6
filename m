Return-Path: <linux-kernel+bounces-196764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F9B8D6197
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C809F2857AE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299B015821A;
	Fri, 31 May 2024 12:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwYQoW8j"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C2E15821F
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717158028; cv=none; b=UYT9oZMVLTok4cMfbU4jYJrgXv9dCC1nUBzJMzPvDtFzL/C5vWeO99tsSb743tQhaV7vAEy3S9SJvzJf2m7IKdec5psgMExXcu8ewUeNdI07pQuD+E2il+9IUUTpLfOKpysGBXs5btANvQvZxTzF2Dqud5vhf6bDwqufsP1u8WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717158028; c=relaxed/simple;
	bh=Py1xqjbV4PXYM3kiYbGkWVoqLS/mAFHMmryBZ56b/AY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ng0zZXyhKoWug27EdIY+VWnkAMFay2GV4PjzvFDJtUyPp/umYhkue1qEH4/se9fz7hgCQJ91F5HU6iWGDm1y/++cY0SlWfEpBzWeyk3gk4f3Dy1snV3J78rYLJPfJgPFyQQ+VeRgmRHMxE3SOOWE7xyyD3bW/72HXVtEm/bByzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwYQoW8j; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-48bbcdd2ba6so555123137.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 05:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717158025; x=1717762825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6mihzZPIajhm/Tu9byM7yxkAls9gPvYzrS97XWomiU=;
        b=QwYQoW8jsez+JKqIG4R9wCfPdcgqw1SKo30OXm2yXnZMrjDvEdm/iOpoGqCiSZTtst
         aNSC59hODxFLcYF8RqE6bMGQ+KMPFkcogR0rUXnreESDECzZy/4AC5sO632CoX+GgyXd
         LwWqbNZWLmOKHhuc9y77MPui3W8OE4dEUu+H0vQWOE+m65hK29v36A+AIECVyzA2tdRV
         Yob+3pa4jOqSdGfFXLGhivx1zsyJizOqlWSJbHW74MJXil9qAV7hFSv+FYh9FdCcPZAb
         K5X9VIzlBVrJbTborVwOc3L6WRwQkGERAYR7/RRc1IHLAY1SjQpJwWA5MmFf4JXe2A0x
         usUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717158025; x=1717762825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6mihzZPIajhm/Tu9byM7yxkAls9gPvYzrS97XWomiU=;
        b=ePT4LIxhTGEIktSEY/m0GB87KfHT2ggUiMkTM8e89j5U9WGgFIPwLh3Rv98vb/Xsnu
         sRDzDlyokDMEmD3jNEjNxrHhvwEtDhBvEQpCnVjIRoIOVsA+xzj4RXeo/A2FPETgQCv6
         0pIEZwH7KqJgjydEsSEmhcaH8os/nhHONPEJrdo+1hK/LYIdDECGLwL06QDzSF94Un9f
         sF1Q+jXucs0JQBHl5CMdy6UEf25KcP6zfufRcFAtetux4ZR4icm2TmeDeBU8ZjmnGsPa
         hJpOHo3OHQ0DZB24f2xcYjHi27WwnL9OPKau4AZGGoQhnTqZVd26r2zkUdhqEL8LXCZE
         oq1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU55w5JY9/ehVD9brwIZ7MymGJxEqRkceWkr2LRX1M07tEyIEbtHcTwcCY+CwGeZZb6JufzZaQxFfSa0eshJm9MeBOortwojh2BEnrg
X-Gm-Message-State: AOJu0YxsjTWiQDSJeir6GQ2WV2a0maDqOdARgMkbn2qRfNc94hMYDzr0
	rnZ0mKh5Sc3wkJn7XOvyX4sOOJz/xfk0JcNI4Ol0CILLo1SLZLQPZCPSwR6Q3i7wyaDkjwpDQOD
	9yQsjOrHQII6Fj0ucsLmr+fpo9+s=
X-Google-Smtp-Source: AGHT+IHiSk8nsMoWq1B4TPpiCuasKi0m15AKvxCuWsKbkFMpf5vL7h++LNU/oxFMSgsmPoCxlK5oMwonvhVAZi6kZ6c=
X-Received: by 2002:a05:6102:7d0:b0:48b:c32e:2185 with SMTP id
 ada2fe7eead31-48bc32e220dmr892093137.9.1717158025416; Fri, 31 May 2024
 05:20:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531104819.140218-1-21cnbao@gmail.com> <87ac9610-5650-451f-aa54-e634a6310af4@redhat.com>
 <CAGsJ_4zgf8j0oRnVBhe-__=K2RFDHTCo-JnMak95HTvxtMUwnQ@mail.gmail.com> <d4c1a9ad-4945-40d7-9b7a-5b02df805884@redhat.com>
In-Reply-To: <d4c1a9ad-4945-40d7-9b7a-5b02df805884@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 1 Jun 2024 00:20:13 +1200
Message-ID: <CAGsJ_4xpDwTTbwzMx8ipmpCyNmVmABpRN1f9yfZfFiOaGMKiew@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: swap: reuse exclusive folio directly instead of
 wp page faults
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, chrisl@kernel.org, 
	surenb@google.com, kasong@tencent.com, minchan@kernel.org, 
	willy@infradead.org, ryan.roberts@arm.com, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 1, 2024 at 12:10=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 31.05.24 13:55, Barry Song wrote:
> > On Fri, May 31, 2024 at 11:08=E2=80=AFPM David Hildenbrand <david@redha=
t.com> wrote:
> >>
> >> On 31.05.24 12:48, Barry Song wrote:
> >>> From: Barry Song <v-songbaohua@oppo.com>
> >>>
> >>> After swapping out, we perform a swap-in operation. If we first read
> >>> and then write, we encounter a major fault in do_swap_page for readin=
g,
> >>> along with additional minor faults in do_wp_page for writing. However=
,
> >>> the latter appears to be unnecessary and inefficient. Instead, we can
> >>> directly reuse in do_swap_page and completely eliminate the need for
> >>> do_wp_page.
> >>>
> >>> This patch achieves that optimization specifically for exclusive foli=
os.
> >>> The following microbenchmark demonstrates the significant reduction i=
n
> >>> minor faults.
> >>>
> >>>    #define DATA_SIZE (2UL * 1024 * 1024)
> >>>    #define PAGE_SIZE (4UL * 1024)
> >>>
> >>>    static void *read_write_data(char *addr)
> >>>    {
> >>>            char tmp;
> >>>
> >>>            for (int i =3D 0; i < DATA_SIZE; i +=3D PAGE_SIZE) {
> >>>                    tmp =3D *(volatile char *)(addr + i);
> >>>                    *(volatile char *)(addr + i) =3D tmp;
> >>>            }
> >>>    }
> >>>
> >>>    int main(int argc, char **argv)
> >>>    {
> >>>            struct rusage ru;
> >>>
> >>>            char *addr =3D mmap(NULL, DATA_SIZE, PROT_READ | PROT_WRIT=
E,
> >>>                            MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> >>>            memset(addr, 0x11, DATA_SIZE);
> >>>
> >>>            do {
> >>>                    long old_ru_minflt, old_ru_majflt;
> >>>                    long new_ru_minflt, new_ru_majflt;
> >>>
> >>>                    madvise(addr, DATA_SIZE, MADV_PAGEOUT);
> >>>
> >>>                    getrusage(RUSAGE_SELF, &ru);
> >>>                    old_ru_minflt =3D ru.ru_minflt;
> >>>                    old_ru_majflt =3D ru.ru_majflt;
> >>>
> >>>                    read_write_data(addr);
> >>>                    getrusage(RUSAGE_SELF, &ru);
> >>>                    new_ru_minflt =3D ru.ru_minflt;
> >>>                    new_ru_majflt =3D ru.ru_majflt;
> >>>
> >>>                    printf("minor faults:%ld major faults:%ld\n",
> >>>                            new_ru_minflt - old_ru_minflt,
> >>>                            new_ru_majflt - old_ru_majflt);
> >>>            } while(0);
> >>>
> >>>            return 0;
> >>>    }
> >>>
> >>> w/o patch,
> >>> / # ~/a.out
> >>> minor faults:512 major faults:512
> >>>
> >>> w/ patch,
> >>> / # ~/a.out
> >>> minor faults:0 major faults:512
> >>>
> >>> Minor faults decrease to 0!
> >>>
> >>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >>> ---
> >>>    mm/memory.c | 7 ++++---
> >>>    1 file changed, 4 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/mm/memory.c b/mm/memory.c
> >>> index eef4e482c0c2..e1d2e339958e 100644
> >>> --- a/mm/memory.c
> >>> +++ b/mm/memory.c
> >>> @@ -4325,9 +4325,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>>         */
> >>>        if (!folio_test_ksm(folio) &&
> >>>            (exclusive || folio_ref_count(folio) =3D=3D 1)) {
> >>> -             if (vmf->flags & FAULT_FLAG_WRITE) {
> >>> -                     pte =3D maybe_mkwrite(pte_mkdirty(pte), vma);
> >>> -                     vmf->flags &=3D ~FAULT_FLAG_WRITE;
> >>> +             if (vma->vm_flags & VM_WRITE) {
> >>> +                     pte =3D pte_mkwrite(pte_mkdirty(pte), vma);
> >>> +                     if (vmf->flags & FAULT_FLAG_WRITE)
> >>> +                             vmf->flags &=3D ~FAULT_FLAG_WRITE;
> >>
> >> This implies, that even on a read fault, you would mark the pte dirty
> >> and it would have to be written back to swap if still in the swap cach=
e
> >> and only read.
> >>
> >> That is controversial.
> >>
> >> What is less controversial is doing what mprotect() via
> >> change_pte_range()/can_change_pte_writable() would do: mark the PTE
> >> writable but not dirty.
> >>
> >> I suggest setting the pte only dirty if FAULT_FLAG_WRITE is set.
> >
> > Thanks!
> >
> > I assume you mean something as below?
>
> It raises an important point: uffd-wp must be handled accordingly.
>
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index eef4e482c0c2..dbf1ba8ccfd6 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4317,6 +4317,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >          add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
> >          pte =3D mk_pte(page, vma->vm_page_prot);
> >
> > +       if (pte_swp_soft_dirty(vmf->orig_pte))
> > +               pte =3D pte_mksoft_dirty(pte);
> > +       if (pte_swp_uffd_wp(vmf->orig_pte))
> > +               pte =3D pte_mkuffd_wp(pte);
> >          /*
> >           * Same logic as in do_wp_page(); however, optimize for pages =
that are
> >           * certainly not shared either because we just allocated them =
without
> > @@ -4325,18 +4329,19 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >           */
> >          if (!folio_test_ksm(folio) &&
> >              (exclusive || folio_ref_count(folio) =3D=3D 1)) {
> > -               if (vmf->flags & FAULT_FLAG_WRITE) {
> > -                       pte =3D maybe_mkwrite(pte_mkdirty(pte), vma);
> > -                       vmf->flags &=3D ~FAULT_FLAG_WRITE;
> > +               if (vma->vm_flags & VM_WRITE) {
> > +                       if (vmf->flags & FAULT_FLAG_WRITE) {
> > +                               pte =3D pte_mkwrite(pte_mkdirty(pte), v=
ma);
> > +                               vmf->flags &=3D ~FAULT_FLAG_WRITE;
> > +                       } else if ((!vma_soft_dirty_enabled(vma) ||
> > pte_soft_dirty(pte))
> > +                                   && !userfaultfd_pte_wp(vma, pte)) {
> > +                                       pte =3D pte_mkwrite(pte, vma);
>
> Even with FAULT_FLAG_WRITE we must respect uffd-wp and *not* do a
> pte_mkwrite(pte). So we have to catch and handle that earlier (I could
> have sworn we handle that somehow).
>
> Note that the existing
>         pte =3D pte_mkuffd_wp(pte);
>
> Will fix that up because it does an implicit pte_wrprotect().

This is exactly what I have missed as I am struggling with why WRITE_FAULT
blindly does mkwrite without checking userfaultfd_pte_wp().

>
>
> So maybe what would work is
>
>
> if ((vma->vm_flags & VM_WRITE) && !userfaultfd_pte_wp(vma, pte) &&
>      !vma_soft_dirty_enabled(vma)) {
>         pte =3D pte_mkwrite(pte);
>
>         /* Only set the PTE dirty on write fault. */
>         if (vmf->flags & FAULT_FLAG_WRITE) {
>                 pte =3D pte_mkdirty(pte);
>                 vmf->flags &=3D ~FAULT_FLAG_WRITE;
>         }
> }
>

looks good!

> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry

