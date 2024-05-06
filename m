Return-Path: <linux-kernel+bounces-169487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5F48BC96E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68D2A1C216C6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3FC1411CE;
	Mon,  6 May 2024 08:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjdeGwll"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10509140E5F
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714983637; cv=none; b=DmJ/UjvQgi0VQ8zU0IfH2dTdSa7WK56tERErl2bjq/8J5kFbK7Rw3aukrds7PbWWn6Mp1CjmtYxk8Kx4li413n+BKQSD2Mett94Y2CTgBDF0imVE8TvlA4YT3navunKFybDBu39XOoG2wNqfipN21gOWxTGw7RrWEGZ3vUqgyp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714983637; c=relaxed/simple;
	bh=R8danFEIme5x1ge9C9d3IvaJY3UpKztziVSnmYT39dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+bcFVioHLd9LNmhHARob6a/1wkUFjzuZOlMaJEzvtfEPzwJOX5Z4qrkxG39wkSiXe8yY/62KdhJR+FAsImMbPeMrTKDPsYPuAjyr8atIYmTtrbz/ILYUyW8SIpPZkNaCE4+0wkXdvKyde3dkZT1X0gjVoerq31uFB/QvEI/Wiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjdeGwll; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4affeacaff9so481673e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 01:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714983635; x=1715588435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUZgBQtBX5ARqva0g5FbDYV/cJoa1D6v0dTRxQmOsoQ=;
        b=mjdeGwllKUam6m08DUi7zR2+D4pNJzDch2r2QZc3913/BAWhG3PQlrSg7Nap346Iog
         nCaoLymabR+I1Ey3IHUX97Wj9MBjB+d8w321R6t0nr+6iOvshWFT3aBCyPikzc9909EF
         RH32K5ytJEBoBDg7lKrHo9JBOF4aLSCu7Roj80nM3RYgTwB7YuY5MyrlJpWmwaTR+tsF
         nMlHFTVSX2NsVWhCpGziwShmCDc67THxr2qcQdH56FGobz0hlYRjPNlRS9N1IzqalfI7
         SNk9+zVd5GcyZNbgnLHaRytEOuZ5n7InOXqp3gUx1D35PKjF73f1uUw70y4JINJGLsnp
         nZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714983635; x=1715588435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUZgBQtBX5ARqva0g5FbDYV/cJoa1D6v0dTRxQmOsoQ=;
        b=CZ8142ACSd+ezu2HYHHvKe30hcdhX18U7Txfxw8iY3pf7OZ9+rPOJG3TQNS4Y6mg6z
         mLflkOaEBpirsjkohZkJP6Ikhl0r9yM4oxRxZjQLP+bNEgz6dVTm1H1Aqcf7rqdXiCP6
         yqbUJYcUPjC1m3BXCkXRNiDJ2+U2/XAsKb99AfYYAqjkFn5KcGC09zxdCVZcSyqdU3iL
         DNafsSSREL1dGUQmx3GLjGTd0theBR7QMZtghOqJycHX1qyYsavQiAanlPTVQHuy0rTT
         /fzhXZwnfy2uos+rnl8PCf9oje+eS/XaTL1q/cadPWPNf8YwTnsivGZ0mC+HccRRgS8p
         pe5A==
X-Forwarded-Encrypted: i=1; AJvYcCXOQ5d3u/c2xkt6yKLjwmKOWbjAjCGZ+AtIFseWGqnJMLhk6BMOA8WUhnHU/Lco/MHqcOA4qPSD8MbJzZaMA05kfh/OyyE/fdiZ6kcz
X-Gm-Message-State: AOJu0Yz4QyNJIJf8616cbvb7EPKCvdXtMX5H+4TLzu5DcyuJ/7BzOKL4
	pcDu9H83xOlNkVmrpsDPliuYoDs1X2p3KDso62Q3iw2uW7UU3+KX0WTGOCUKb8wcIXqcsfxi3//
	I0smg0jUKojGTDq8lRK3kJW1SGD0=
X-Google-Smtp-Source: AGHT+IFPxFkhjBkhh9PvsldyACZ9XMzB9HXDMHrxqgbMKOEOCqvI6vpAeNzkhiZCllYzo4CBv5K+cxLJ/nFBII7swzw=
X-Received: by 2002:a05:6122:a0f:b0:4da:704f:7fc6 with SMTP id
 15-20020a0561220a0f00b004da704f7fc6mr7520629vkn.15.1714983634818; Mon, 06 May
 2024 01:20:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503005023.174597-1-21cnbao@gmail.com> <20240503005023.174597-4-21cnbao@gmail.com>
 <7548e30c-d56a-4a57-ab87-86c9c8e523b1@arm.com> <CAGsJ_4wx60GoB1erTQ7v3GTXLb_140bOJ_+z=kqY39eOd3P23g@mail.gmail.com>
 <0d20d8af-e480-4eb8-8606-1e486b13fd7e@redhat.com>
In-Reply-To: <0d20d8af-e480-4eb8-8606-1e486b13fd7e@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 6 May 2024 20:20:23 +1200
Message-ID: <CAGsJ_4wP75tFWDcKJZfw7Pk9AdigVCv0niGUeTY6RTZwk1UnjQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] mm: introduce pte_move_swp_offset() helper which
 can move offset bidirectionally
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, hanchuanhua@oppo.com, 
	hannes@cmpxchg.org, hughd@google.com, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, surenb@google.com, v-songbaohua@oppo.com, 
	willy@infradead.org, xiang@kernel.org, ying.huang@intel.com, 
	yosryahmed@google.com, yuzhao@google.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 8:06=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 04.05.24 01:40, Barry Song wrote:
> > On Fri, May 3, 2024 at 5:41=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.c=
om> wrote:
> >>
> >> On 03/05/2024 01:50, Barry Song wrote:
> >>> From: Barry Song <v-songbaohua@oppo.com>
> >>>
> >>> There could arise a necessity to obtain the first pte_t from a swap
> >>> pte_t located in the middle. For instance, this may occur within the
> >>> context of do_swap_page(), where a page fault can potentially occur i=
n
> >>> any PTE of a large folio. To address this, the following patch introd=
uces
> >>> pte_move_swp_offset(), a function capable of bidirectional movement b=
y
> >>> a specified delta argument. Consequently, pte_increment_swp_offset()
> >>
> >> You mean pte_next_swp_offset()?
> >
> > yes.
> >
> >>
> >>> will directly invoke it with delta =3D 1.
> >>>
> >>> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
> >>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >>> ---
> >>>   mm/internal.h | 25 +++++++++++++++++++++----
> >>>   1 file changed, 21 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/mm/internal.h b/mm/internal.h
> >>> index c5552d35d995..cfe4aed66a5c 100644
> >>> --- a/mm/internal.h
> >>> +++ b/mm/internal.h
> >>> @@ -211,18 +211,21 @@ static inline int folio_pte_batch(struct folio =
*folio, unsigned long addr,
> >>>   }
> >>>
> >>>   /**
> >>> - * pte_next_swp_offset - Increment the swap entry offset field of a =
swap pte.
> >>> + * pte_move_swp_offset - Move the swap entry offset field of a swap =
pte
> >>> + *    forward or backward by delta
> >>>    * @pte: The initial pte state; is_swap_pte(pte) must be true and
> >>>    *    non_swap_entry() must be false.
> >>> + * @delta: The direction and the offset we are moving; forward if de=
lta
> >>> + *    is positive; backward if delta is negative
> >>>    *
> >>> - * Increments the swap offset, while maintaining all other fields, i=
ncluding
> >>> + * Moves the swap offset, while maintaining all other fields, includ=
ing
> >>>    * swap type, and any swp pte bits. The resulting pte is returned.
> >>>    */
> >>> -static inline pte_t pte_next_swp_offset(pte_t pte)
> >>> +static inline pte_t pte_move_swp_offset(pte_t pte, long delta)
> >>
> >> We have equivalent functions for pfn:
> >>
> >>    pte_next_pfn()
> >>    pte_advance_pfn()
> >>
> >> Although the latter takes an unsigned long and only moves forward curr=
ently. I
> >> wonder if it makes sense to have their naming and semantics match? i.e=
 change
> >> pte_advance_pfn() to pte_move_pfn() and let it move backwards too.
> >>
> >> I guess we don't have a need for that and it adds more churn.
> >
> > we might have a need in the below case.
> > A forks B, then A and B share large folios. B unmap/exit, then large
> > folios of process
> > A become single-mapped.
> > Right now, while writing A's folios, we are CoWing A's large folios
> > into many small
> > folios. I believe we can reuse the entire large folios instead of doing=
 nr_pages
> > CoW and page faults.
> > In this case, we might want to get the first PTE from vmf->pte.
>
> Once we have COW reuse for large folios in place (I think you know that
> I am working on that), it might make sense to "COW-reuse around",

TBH, I don't know if you are working on that. please Cc me next time :-)

> meaning we look if some neighboring PTEs map the same large folio and
> map them writable as well. But if it's really worth it, increasing page
> fault latency, is to be decided separately.

On the other hand, we eliminate latency for the remaining nr_pages - 1 PTEs=
.
Perhaps we can discover a more cost-effective method to signify that a larg=
e
folio is probably singly mapped? and only call "multi-PTEs" reuse while tha=
t
condition is true in PF and avoid increasing latency always?

>
>
> >
> > Another case, might be
> > A forks B, and we write either A or B, we might CoW an entire large
> > folios instead
> > CoWing nr_pages small folios.
> >
> > case 1 seems more useful, I might have a go after some days. then we mi=
ght
> > see pte_move_pfn().
> pte_move_pfn() does sound odd to me. It might not be required to
> implement the optimization described above. (it's easier to simply read
> another PTE, check if it maps the same large folio, and to batch from the=
re)
>

It appears that your proposal suggests potential reusability as follows: if=
 we
have a large folio containing 16 PTEs, you might consider reusing only 4 by
examining PTEs "around" but not necessarily all 16 PTEs. please correct me
if my understanding is wrong.

Initially, my idea was to obtain the first PTE using pte_move_pfn() and the=
n
utilize folio_pte_batch() with the first PTE as arguments to ensure consist=
ency
in nr_pages, thus enabling complete reuse of the whole folio.

> --
> Cheers,
>
> David / dhildenb

Thanks
Barry

