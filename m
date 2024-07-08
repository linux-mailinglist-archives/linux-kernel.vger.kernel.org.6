Return-Path: <linux-kernel+bounces-244149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE8B929FD3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EF941C20C03
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 10:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFCB74C1B;
	Mon,  8 Jul 2024 10:05:51 +0000 (UTC)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A031BF37
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 10:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720433151; cv=none; b=B35DOInb7k74m1/s9EdUI+o6WGE/WzEhZzmxsPoro0v1pWz/SrTAIesgQEpdFo0McBQim1w8qzBHjw+wGkNpbOGZA6155C03kkiM5ZwF5A2M8DPd1d6DpULkjhIWMOB+KMk34RLzQG7BMHjfmFI8r/nAbgfcSbpPvKoTv/c0j1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720433151; c=relaxed/simple;
	bh=R07v5njRYO1kmgalthCceieXraLo4fbqfHCdXHiYUD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQobmS1DSoeV+rd+zskOW78r3vgWIGDwHhqepDkg1s4LMQUXYuIfbSdtfxpY8K7zXyqc7df/o82vfiJb/IRP2jxDSBEQU9yo3IkicNbNzUbuzfqtZEdYOhLz5YxOI0D6XEZRXTovB0WYnxdqdTwnTrQbaTHim0YZQU30qj2RX6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-48fddbb579dso1124512137.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 03:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720433149; x=1721037949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/tsYyibVEXL+6UmILt7GnYiNyfPwNj+z3ZkernFD+Ag=;
        b=tCA04qvVxgEbmSwTM1tfjXDBCryBkJ1qbq8tjS/jvo5Kg3muK8xKZ9FIEaIDFNKvH7
         h6ony5fpf8EMgJXvTSFyYDoPUrjxXCauWlLVpx8GS84qCs+/vjn+hAsTwM0VnNcE4qHd
         GoZHhJOqBG3BS2vSdCF31rTK9VfEYin71JVuclQTT97O+ap9ehK5pLeMtNd+ptu5yCon
         9Zcq+0eXg/5oXkY1c/nAykO3oQ35l7NGiZCWxeojUcGjGvst/sEXkm80YssX3TVIS1zL
         iU5QtjCSK9UwBPZSuYkT2um8hhL5PTcFmhcKLWBrNZSHDim2UDSIyM7aeWbCjY6tipjR
         Zuww==
X-Forwarded-Encrypted: i=1; AJvYcCWod25VVncpnImVAwmH2d8iBwwRLP/1O12xUk1Y5fdanARdoMiLvb4i/6hVA/lyA81jS1JUb0KWepN0JjXAEuW3cjyBaojnp1v9RLws
X-Gm-Message-State: AOJu0YxzMGcjYrgztKBCm1rESxuMIsIPAFPBSm+5TooyG9CDKgDZYSZ3
	Iyi08T0ZuNOkVT7vuU3izqRMO1j84LQB8B2mrX8EobWGQfZMABA3MGwudWBiZCBO1OHz8LysI8R
	K7+WtaFG/61Q2kRkippWUpXOOJ/E=
X-Google-Smtp-Source: AGHT+IFSPah4hfiBN6PfhxDs/lAMd6pYf3ppUrht3vHNaTQSMPvMhayjumxla0Vg9p9RnsmuJ+1WSVPyQimrmvMSm/E=
X-Received: by 2002:a67:e292:0:b0:48f:4416:dd59 with SMTP id
 ada2fe7eead31-48fee7ed7famr12349014137.33.1720433148742; Mon, 08 Jul 2024
 03:05:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708090413.888-1-justinjiang@vivo.com> <ad7873f4-9c98-45cc-b7be-0c1c36b65ade@redhat.com>
 <CAGsJ_4zN95hh6G15L=hCTmXx4Y_OC-ExpsU7iErZ2SiZZaxmhA@mail.gmail.com> <611dd616-a626-4968-b88a-4db82dccfb90@redhat.com>
In-Reply-To: <611dd616-a626-4968-b88a-4db82dccfb90@redhat.com>
From: Barry Song <baohua@kernel.org>
Date: Mon, 8 Jul 2024 22:05:37 +1200
Message-ID: <CAGsJ_4zrC6Ma82OcOM+yMH7Tj-9oUO5Lbv7hCejH7dQqqO_Q6w@mail.gmail.com>
Subject: Re: [PATCH v5] mm: shrink skip folio mapped by an exiting process
To: David Hildenbrand <david@redhat.com>
Cc: Zhiguo Jiang <justinjiang@vivo.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 9:49=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 08.07.24 11:46, Barry Song wrote:
> > On Mon, Jul 8, 2024 at 9:36=E2=80=AFPM David Hildenbrand <david@redhat.=
com> wrote:
> >>
> >> On 08.07.24 11:04, Zhiguo Jiang wrote:
> >>> The releasing process of the non-shared anonymous folio mapped solely=
 by
> >>> an exiting process may go through two flows: 1) the anonymous folio i=
s
> >>> firstly is swaped-out into swapspace and transformed into a swp_entry
> >>> in shrink_folio_list; 2) then the swp_entry is released in the proces=
s
> >>> exiting flow. This will increase the cpu load of releasing a non-shar=
ed
> >>> anonymous folio mapped solely by an exiting process, because the foli=
o
> >>> go through swap-out and the releasing the swapspace and swp_entry.
> >>>
> >>> When system is low memory, it is more likely to occur, because more
> >>> backend applidatuions will be killed.
> >>>
> >>> The modification is that shrink skips the non-shared anonymous folio
> >>> solely mapped by an exting process and the folio is only released
> >>> directly in the process exiting flow, which will save swap-out time
> >>> and alleviate the load of the process exiting.
> >>>
> >>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
> >>> ---
> >>>
> >>> Change log:
> >>> v4->v5:
> >>> 1.Modify to skip non-shared anonymous folio only.
> >>> 2.Update comments for pra->referenced =3D -1.
> >>> v3->v4:
> >>> 1.Modify that the unshared folios mapped only in exiting task are ski=
p.
> >>> v2->v3:
> >>> Nothing.
> >>> v1->v2:
> >>> 1.The VM_EXITING added in v1 patch is removed, because it will fail
> >>> to compile in 32-bit system.
> >>>
> >>>    mm/rmap.c   | 13 +++++++++++++
> >>>    mm/vmscan.c |  7 ++++++-
> >>>    2 files changed, 19 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/mm/rmap.c b/mm/rmap.c
> >>> index 26806b49a86f..5b5281d71dbb
> >>> --- a/mm/rmap.c
> >>> +++ b/mm/rmap.c
> >>> @@ -843,6 +843,19 @@ static bool folio_referenced_one(struct folio *f=
olio,
> >>>        int referenced =3D 0;
> >>>        unsigned long start =3D address, ptes =3D 0;
> >>>
> >>> +     /*
> >>> +      * Skip the non-shared anonymous folio mapped solely by
> >>> +      * the single exiting process, and release it directly
> >>> +      * in the process exiting.
> >>> +      */
> >>> +     if ((!atomic_read(&vma->vm_mm->mm_users) ||
> >>> +             test_bit(MMF_OOM_SKIP, &vma->vm_mm->flags)) &&
> >>> +             folio_test_anon(folio) && folio_test_swapbacked(folio) =
&&
> >>> +             !folio_likely_mapped_shared(folio)) {
> >>
> >> I'm currently working on moving all folio_likely_mapped_shared() under
> >> the PTL, where we are then sure that the folio is actually mapped by
> >> this process (e.g., no concurrent unmapping poisslbe).
> >>
> >> Can we do the same here directly?
> >
> > Implementing this is challenging because page_vma_mapped_walk() is
> > responsible for
> > traversing the page table to acquire and release the PTL. This becomes
> > particularly
> > complex with mTHP, as we may need to interrupt the page_vma_mapped_walk
> > loop at the first PTE.
>
> Why can't we perform the check under the PTL and bail out? I'm missing
> something important.

You are right. we might use page_vma_mapped_walk_done() to bail out.

>
> --
> Cheers,
>
> David / dhildenb
>

