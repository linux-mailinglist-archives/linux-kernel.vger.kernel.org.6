Return-Path: <linux-kernel+bounces-213061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDB1906A7F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7452B285148
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1A01428EC;
	Thu, 13 Jun 2024 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYIpu9MG"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259A913C68A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 10:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718276158; cv=none; b=LljiREc9W1rMNJCTGC26FV0QtGzVKlLHGtiron2iQebp758UYQ2jTbJfE5uAGnrscbXySp8y/ykesCPuEX1E1XhRvWrkN2fuVb/jraOqPFwzuWQzbAxpzzp5lebkJnHB/ojLXmSoX6TT7YlDBwI/b1a9uWEshNEgF5SPw4ZzKa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718276158; c=relaxed/simple;
	bh=oVim22qZfVw2cjHhrSL4MzhwI1o0cSLBrOF3Kt0+J7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGFm8nxzKfjvqtPawKqqKKUiTyhofRUkyf3OnVWSxA/q3W4FWZ9hAqKcraq3DZH45K9fTYZjgUiJGCOIc24m8+zXwZIE4MPdyz+CuJsSeoAv6dif7NzuWh2Fbv6kVamJw9FiLeSmKKIEz4IduwB3UxqMIfJnL0KrKftzbcksSl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYIpu9MG; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-80b87c529f0so275123241.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 03:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718276156; x=1718880956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBfPg0Sf6+FiIihToqXtkFxEPPt7zTvyf0r/NMVh4q4=;
        b=IYIpu9MGWzceSt8DUyxXjl/gZ4OtSTsuFwT4Gldr31H4Ke0J9Vxe+eHpXBcKhYTj6O
         8vI7Xtdaw+T6PvBWrQ2QKOhA0TWgM7MISgF7dJnRMTUbKkB/D5uy01UiZSVUe9EOvN6v
         FyUIEWkqK4Z+ksbPsdyT6CkL/oKwX136p5ngaIc6U4ayopbVvCIZzSKTaIuka1T5+msq
         +hjGQbLwExU5mlyepjsBMNEnsJBhEPg3IRg6ioxm2y2v934+cdchYc8QJX+iNqJqpTn7
         ZMpGqBXCehGU23Cd7tz/7vsvmS/vchtxJ1wqP28cV3KrdFtVrCEWTNKdjwRlT/cGwIuo
         T5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718276156; x=1718880956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBfPg0Sf6+FiIihToqXtkFxEPPt7zTvyf0r/NMVh4q4=;
        b=auxq+mgxgEQ9ZoGt+U4A6oMo3Lzsz7jTXDLFW1P2iigc01M2+9w2cw4c1VdUDgFpAB
         uT+8ilepGZS5oK8W/FeSIzRpKsLZ/MeNdteD8uNFpenE+2tEY+RWko3aH7R4J9l02dUu
         9O86JBKGc56ScC4uid3VkEbMeXa8e5vs8DZnp7+rCgqaid4ouwDbyN3Mx/Gg75gR43iM
         zsXXVdgPe86uQnmeycBDSgYRpDDtSPlFOE/WKbVRT0QjH6Z8lre40tkixxOIUf86nLeA
         NrvsUu2tVeTFW+SS50oSuNeyOXYy3oSrolqN8FvyJodykE3K/Fenk3ocdXfV6PR0lh9Y
         VrqA==
X-Forwarded-Encrypted: i=1; AJvYcCUpWStdiswZWPGOJK5zhKY9AYm3VNs1zkgZMgUL/T9+oyk0IJVmqSaPJZL9xwWrbLHzk+AxgrfSG7gh5IF+VCZnr3pVZs5Wf7LtdaNb
X-Gm-Message-State: AOJu0YwzMdSNRb2cxlHtFpr7pu1UArNZrIEZKdaKpubP2OHUuZ47EO/L
	OAOxQNtGDphN1zEfzEKgxZM4g9UlltwErfvA6gyR3u2GgpY9XNPL7M+S47Of2yNae85NrNMs/jV
	mDyQIjKFr0rMomBaycLxwuXKpj3s=
X-Google-Smtp-Source: AGHT+IFy8J6HgirDhGUDAbHi69VM2snxKddoGXz2BjvjuNFQJmuZsq1sGxEfpFWlBvC0mjuwkP3unHNmPM0m7/dAG1g=
X-Received: by 2002:a67:f755:0:b0:48d:8b45:753e with SMTP id
 ada2fe7eead31-48d91db9d8fmr5037400137.11.1718276155873; Thu, 13 Jun 2024
 03:55:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613000721.23093-1-21cnbao@gmail.com> <20240613000721.23093-3-21cnbao@gmail.com>
 <77da1feb-2257-4545-9427-5729250ceb2b@redhat.com> <CAGsJ_4xi6xuBzF1bhShGJJ6aPzpnzOk0JQ542=LpMiJ7ExqNJQ@mail.gmail.com>
 <6ac8ff4d-7099-4547-9e76-528d14f171d8@redhat.com>
In-Reply-To: <6ac8ff4d-7099-4547-9e76-528d14f171d8@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 13 Jun 2024 22:55:44 +1200
Message-ID: <CAGsJ_4wRk2BMpHTERgzcgBr6qODdVPdbqn8hm0YxAWNHxkp48g@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] mm: do_swap_page: use folio_add_new_anon_rmap()
 if folio_test_anon(folio)==false
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, chrisl@kernel.org, 
	linux-kernel@vger.kernel.org, mhocko@suse.com, ryan.roberts@arm.com, 
	baolin.wang@linux.alibaba.com, yosryahmed@google.com, shy828301@gmail.com, 
	surenb@google.com, v-songbaohua@oppo.com, willy@infradead.org, 
	ying.huang@intel.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 10:37=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 13.06.24 11:58, Barry Song wrote:
> > On Thu, Jun 13, 2024 at 9:23=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> On 13.06.24 02:07, Barry Song wrote:
> >>> From: Barry Song <v-songbaohua@oppo.com>
> >>>
> >>> For the !folio_test_anon(folio) case, we can now invoke folio_add_new=
_anon_rmap()
> >>> with the rmap flags set to either EXCLUSIVE or non-EXCLUSIVE. This ac=
tion will
> >>> suppress the VM_WARN_ON_FOLIO check within __folio_add_anon_rmap() wh=
ile initiating
> >>> the process of bringing up mTHP swapin.
> >>>
> >>>    static __always_inline void __folio_add_anon_rmap(struct folio *fo=
lio,
> >>>                    struct page *page, int nr_pages, struct vm_area_st=
ruct *vma,
> >>>                    unsigned long address, rmap_t flags, enum rmap_lev=
el level)
> >>>    {
> >>>            ...
> >>>            if (unlikely(!folio_test_anon(folio))) {
> >>>                    VM_WARN_ON_FOLIO(folio_test_large(folio) &&
> >>>                                     level !=3D RMAP_LEVEL_PMD, folio)=
;
> >>>            }
> >>>            ...
> >>>    }
> >>>
> >>> It also enhances the code=E2=80=99s readability.
> >>>
> >>> Suggested-by: David Hildenbrand <david@redhat.com>
> >>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >>> ---
> >>>    mm/memory.c | 2 ++
> >>>    1 file changed, 2 insertions(+)
> >>>
> >>> diff --git a/mm/memory.c b/mm/memory.c
> >>> index 2f94921091fb..9c962f62f928 100644
> >>> --- a/mm/memory.c
> >>> +++ b/mm/memory.c
> >>> @@ -4339,6 +4339,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>>        if (unlikely(folio !=3D swapcache && swapcache)) {
> >>>                folio_add_new_anon_rmap(folio, vma, address, RMAP_EXCL=
USIVE);
> >>>                folio_add_lru_vma(folio, vma);
> >>> +     } else if (!folio_test_anon(folio)) {
> >>> +             folio_add_new_anon_rmap(folio, vma, address, rmap_flags=
);
> >>
> >> So, with large folio swapin, we would never end up here if any swp PTE
> >> is !exclusive, because we would make sure to allocate a large folio on=
ly
> >> for suitable regions, correct?
> >>
> >> It can certainly happen during swapout + refault with large folios. Bu=
t
> >> there, we will always have folio_test_anon() still set and wouldn't ru=
n
> >> into this code path.
> >>
> >> (it will all be better with per-folio PAE bit, but that will take some
> >> more time until I actually get to implement it properly, handling all
> >> the nasty corner cases)
> >>
> >> Better add a comment regarding why we are sure that the complete thing
> >> is exclusive (e.g., currently only small folios).
> >
> > No, patch 1/3 enables both cases to call folio_add_new_anon_rmap(). Cur=
rently,
> > small folios could be non-exclusive. I suppose your question is
> > whether we should
> > ensure that all pages within a mTHP have the same exclusivity status,
> > rather than
> > always being exclusive?
>
> We must never end up calling folio_add_new_anon_rmap(folio, vma,
> address, RMAP_EXCLUSIVE) if part of the folio is non-exclusive.

Agreed.

>
> I think we *may* call folio_add_new_anon_rmap(folio, vma, address, 0) if
> part of the folio is exclusive [it go swapped out, so there cannot be
> GUP references]. But, to be future proof (single PAE bit per folio), we
> better avoid that on swapin if possible.
>
> For small folios, it's clear that it cannot be partially exclusive
> (single page).

Yes, for small folios, it is much simpler; they are either entirely exclusi=
ve or
entirely non-exclusive.

For the initial swapin patch[1], which only supports SYNC-IO mTHP swapin,
mTHP is always entirely exclusive. I am also considering non-SYNCHRONOUS_IO
swapcache-based mTHP swapin but intend to start with the entirely exclusive
cases.

[1] https://lore.kernel.org/linux-mm/20240304081348.197341-6-21cnbao@gmail.=
com/

>
> We better comment why we obey to the above. Like
>
> "We currently ensure that new folios cannot be partially exclusive: they
> are either fully exclusive or fully shared."
>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry

