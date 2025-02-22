Return-Path: <linux-kernel+bounces-527092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 428DEA40732
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 10:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4449701FD1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 09:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3FB207A2D;
	Sat, 22 Feb 2025 09:58:25 +0000 (UTC)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA72207657
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 09:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740218305; cv=none; b=QX0KYGviK1d7q9TqYCwB/0T1ultOEhSf5gRnv9ajw18xzq5ECj36Lxi4laOMVdx+d1jf58GHSAl19oU71tq71dDRF+HvzENI6+Qp5RvsI1lvjZrIsu1PNluvi63PuuvwOtms+2UWZWEptiedNsVnX6DV5ZNIERImbV/hYSNwQIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740218305; c=relaxed/simple;
	bh=5jjxoi+NyBSTA5CyOpM5cn5oDUoNtYuVeSGvy6lO+Sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBUM7H63GIPHFMt6YCF2gPRl+07iEr5ZSae35pUTmoXia0Ms6L14HVGCwhi9e9ZQri1G+wKDOo/1HyNpjhhtvZZxyJs/QBxwwbyxrgHdyB1IqxhJtMv17Fvglzm/Vvey5RG+p8sUSWRk17CFkCDZPUZJCMtcdIhBkI+B7NX9HnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4b68cb2abacso871231137.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 01:58:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740218302; x=1740823102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miMTL+Ibz2ZHlrxtRz9K3mZRlvBnkZQuM5tmX7QkF0c=;
        b=MkCahlBK5O5gybWKVQkGdTfeCo4PM3kOsy/cKtL4UUGtKlGvXVo9uGyKRaEeZswwrc
         1tO2/1YFgCX1ww9ohXD5bwsVlG2jOWACKXNMYBZ8cR05QjYDiHlRyYyv+BUydCKMc15s
         OTX8GgnfBB8P7+clQpc2iBe7yFve7unmQoathsFat2XMFd5YuKBMhAxYF2JeSAbNF4oj
         B2gn0kL62LkGjQRguvXEdCEsEy7ozazQlCtZ9dJD239JNpLV6W0QEyLPMYIBz4yumEpN
         PoZtCrwsgqoOT0AAOc5jicW9qvXjy78AgahxKdW7SQeWuMiWDwcAcMJ3Vwb3eAnEPIFo
         ME8g==
X-Forwarded-Encrypted: i=1; AJvYcCUZGOyKGNP42/14zhWBVLAtWrFf560FoMLZqIRREjMpBzlnbzoD7Ds10BesPnPYRTCkpfHOiComFHrvd/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy12fcZsPCvCumgUoxrBVp2dr4W7Jqb+N+fMnY8JfeMMKngOf5Q
	+Is2Znn+uTWzPoUcbnpE4htnhl3ssDOE2lHyXOQU5ha1SxSRUGoZ2ZGwFezQKCzHYwKXH7CbGX3
	uP7Yde2Er8lErgkxD+yUJuF+trxM=
X-Gm-Gg: ASbGncvBzEJdq8PuRlTQYYb3bj+atb98zFDdydNJkzgmZQ9sFVIsIYznylbhlsUehvb
	3KTxNZ9Y8gw390OBAKBkvuUvu+XYoeje5FvOZqe86qvMA2vTgh8hmgElz4299HrLwozALfu3DNa
	zt8DGQowE=
X-Google-Smtp-Source: AGHT+IH862+3snHiTNiHtpiNOaVebF10wLzPZDhja6mB2OdnLByqTrRDd9lQn502Dky8M/LD1mFJ7ahBqOc3/0wE0U0=
X-Received: by 2002:a05:6102:dc6:b0:4bb:b868:9d2d with SMTP id
 ada2fe7eead31-4bfc028c564mr3923572137.24.1740218302311; Sat, 22 Feb 2025
 01:58:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222024617.2790609-1-mawupeng1@huawei.com>
 <CAMgjq7AfZnwGAHoyCEhO5p2km-gPLk65WLL+2vO1i8hQDaTy+A@mail.gmail.com>
 <a868e635-a86e-4dd7-8bae-c6ca94a2dc09@huawei.com> <CAMgjq7C7hguzq3DmR3s7=3LNGeaCC8qdmiQvLCZrdkB86=BFFw@mail.gmail.com>
In-Reply-To: <CAMgjq7C7hguzq3DmR3s7=3LNGeaCC8qdmiQvLCZrdkB86=BFFw@mail.gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Sat, 22 Feb 2025 22:58:11 +1300
X-Gm-Features: AWEUYZkREUP02MnSFVZ9f4vjkeZNf-q9qUt0ApDtdRrJ74AE5UIIkwURMldW7Ns
Message-ID: <CAGsJ_4zW6EtXrzk05caQhOcZuC+5ovQWrzYxP6PFKkMY1H2R3g@mail.gmail.com>
Subject: Re: [PATCH] mm: swap: Avoid infinite loop if no valid swap entry
 found during do_swap_page
To: Kairui Song <ryncsn@gmail.com>
Cc: mawupeng <mawupeng1@huawei.com>, akpm@linux-foundation.org, david@redhat.com, 
	ryan.roberts@arm.com, chrisl@kernel.org, huang.ying.caritas@gmail.com, 
	schatzberg.dan@gmail.com, hanchuanhua@oppo.com, willy@infradead.org, 
	gaoxu2@honor.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	nphamcs@gmail.com, yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 9:03=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Sat, Feb 22, 2025 at 3:41=E2=80=AFPM mawupeng <mawupeng1@huawei.com> w=
rote:
> > On 2025/2/22 15:33, Kairui Song wrote:
> > > On Sat, Feb 22, 2025 at 10:56=E2=80=AFAM Wupeng Ma <mawupeng1@huawei.=
com> wrote:
> > >>
> > >> From: Ma Wupeng <mawupeng1@huawei.com>
> > >>
> > >> During our test, infinite loop is produced during #PF will lead to i=
nfinite
> > >> error log as follow:
> > >>
> > >>    get_swap_device: Bad swap file entry 114000000
> > >>
> > >> Digging into the source, we found that the swap entry is invalid due=
 to
> > >> unknown reason, and this lead to invalid swap_info_struct. Excessive=
 log
> > >
> > > Hi Wupeng,
> > >
> > > What is the kernel version you are using? If it's another bug causing
> > > this invalid swap entry, we should fix that bug instead, not
> > > workaround it.
> > >
> > > This looks kind of similar to another PATCH & Bug report, corrupted
> > > page table or swap entry:
> > > https://lore.kernel.org/linux-mm/e223b0e6ba2f4924984b1917cc717bd5@hon=
or.com/
> > >
> > > Might be the same kernel bug? Gaoxu mentioned the bug was observed on
> > > Kernel 6.6.30 (android version), and neither of these two workarounds
> > > will fix it completely, the invalid value could cause many other
> > > issues too. We definitely need to find out the root cause.
> >
> > We are having this problem in linux-v5.10, since the log is lost and sw=
ap
> > is not enabled in this machines, maybe memory corrupted in the pt.
>
> Thanks for the info, that's very strange. Since you didn't even enable
> SWAP, it must be something else corrupted the page table I think
>
> > >
> > >> printing can fill up the prioritized log space, leading to the purgi=
ng of
> > >> originally valid logs and hindering problem troubleshooting. To make=
 this
> > >> more robust, kill this task.
> > >>
> > >> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
> > >> ---
> > >>  include/linux/swap.h | 1 +
> > >>  mm/memory.c          | 9 ++++++++-
> > >>  mm/swapfile.c        | 2 +-
> > >>  3 files changed, 10 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/include/linux/swap.h b/include/linux/swap.h
> > >> index b13b72645db3..0fa39cf66bc4 100644
> > >> --- a/include/linux/swap.h
> > >> +++ b/include/linux/swap.h
> > >> @@ -508,6 +508,7 @@ struct backing_dev_info;
> > >>  extern int init_swap_address_space(unsigned int type, unsigned long=
 nr_pages);
> > >>  extern void exit_swap_address_space(unsigned int type);
> > >>  extern struct swap_info_struct *get_swap_device(swp_entry_t entry);
> > >> +struct swap_info_struct *_swap_info_get(swp_entry_t entry);
> > >>  sector_t swap_folio_sector(struct folio *folio);
> > >>
> > >>  static inline void put_swap_device(struct swap_info_struct *si)
> > >> diff --git a/mm/memory.c b/mm/memory.c
> > >> index b4d3d4893267..2d36e5a644d1 100644
> > >> --- a/mm/memory.c
> > >> +++ b/mm/memory.c
> > >> @@ -4365,8 +4365,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> > >>
> > >>         /* Prevent swapoff from happening to us. */
> > >>         si =3D get_swap_device(entry);
> > >> -       if (unlikely(!si))
> > >> +       if (unlikely(!si)) {
> > >> +               if (unlikely(!_swap_info_get(entry)))
> > >> +                       /*
> > >> +                        * return VM_FAULT_SIGBUS for invalid swap e=
ntry to
> > >> +                        * avoid infinite #PF.
> > >> +                        */
> > >> +                       ret =3D VM_FAULT_SIGBUS;
> > >
> > > This could lead to VM_FAULT_SIGBUS on swapoff. After swapoff
> > > get_swap_device will return NULL.
> >
> > If swap is off, All swap pages should be swap in as expected, so
> > such entry can not trigger do_swap_page?
>
> do_swap_page may get blocked due to some random reason, and then a
> concurrent swapoff could swap in the entry and disable the device.
> Very unlikely to trigger but in theory possible.

The "goto out" in do_swap_page() should have handled this case. If swapoff
occurred before the actual swap-in began, we should have aborted the
swap-in, and userspace would retry.

        /* Prevent swapoff from happening to us. */
        si =3D get_swap_device(entry);
        if (unlikely(!si))
                goto out;

Thanks
Barry

