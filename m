Return-Path: <linux-kernel+bounces-212991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 858FF90697E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1AA1F21723
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45B01411CB;
	Thu, 13 Jun 2024 09:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPqUD7CE"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A205140E22
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 09:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718272729; cv=none; b=MzVdjAl7ctbyaGVKq3w5wvGEl467uFtNzSVzvSyvt/ru7ngoa6I7edteIwytI5f5Xq4mgE4crPQMEn4VQnnLT+VrGLOcfXaYbfkAqsc+U5NsJtoQD6YOJKwpmz98hR4QqEYgHjyjRhWIkpkyLx3QLvjK63XIuBcGelhL1+RagLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718272729; c=relaxed/simple;
	bh=zHKsqiZ44O+Y+JfNxBobcXmmxjiuldmqCDK/gG18V4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jUCqQFJlwbAH4V3iXCo8bXpCutnZVeJz/cHCLA6P509Mn3PpH57ozjbkUrFhJBR8z3gyNy9E3USBUXwy16Jm/j1nkXUqO3P1k56nSO5iXB7R5wy7U6UlSQyQIMwI049/SOOI4PPjS8L6on5aFNfrV01TM7pbKNR/NtDSxtexCDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPqUD7CE; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-80b8efd9adcso255049241.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 02:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718272726; x=1718877526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PISS48tZawjaWikz7z/zrvsV2Sl+fMVlabGyAg/WHjg=;
        b=GPqUD7CEkxtnX1hOvNLI+/agh7O0nFdN/DDCbBaWaXbVHWMEcK2Li4a3pr7bInlmoy
         yvS2ILy0jwpeqRXCBoAr0cm1OosmViSpXne7WZOqDEpPrDMgVMkTxp/4q/hDSSos58/S
         5aiMyhBHyseaRxYiRhjE7jKFQJd8E9RJ2DIdE689VdoTlKfSglLHkOkMxhe6xDxHSjBN
         op1mOz8YElLMj5STqvkKgarUOiHa8WDasteky0KUHc0O99EfiWMGz6iHwSKIzayuQ1Y6
         DaBGeya1yQZ+XmtiC+CXGpOddS1omr1GmWcS2wFYgPowkv+clwZm0anUYQF7Es4B2exG
         SNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718272726; x=1718877526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PISS48tZawjaWikz7z/zrvsV2Sl+fMVlabGyAg/WHjg=;
        b=YGPbtSpkRAStXMvbBvhy9S9CslyY0mhPwALOzI5DBq6o0Y2Ilm0SJXGF+bhICfxK2Y
         3v9WrihWDnSA+OfLbBNNCY10x8O2JSRh1vHRWbbBboQlui4xJugAEMjmATKj+ztcTeny
         8L3kipk4hz7L7chefGJ9WDPHz/ZUXfoISt0LCer1D/cfRf4hdIc1ofzCyKQOB/5Y1ULT
         eoqaSlc5snaNxszzPoa9wVPmdZ1TQUgiBKuf5+dYr7O5Zl9VbVcpSE4WOH4hUGwB5Ay2
         a2Uw54qs7xBr6L2bSeaoEJt4GaE+CuZqtn8yxWwOfFTx1CKQPLGSd8rzS3sbd06Nw49S
         yqfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsETaU6GJw8S8HhX2o+o5wkAyybv0RtRPZxPMyK2GnjkLUQlDCh+dHsHslwjVxfedA3hYBbMQhxJNQXp134xK8KXK3XWc3WBzeSdwt
X-Gm-Message-State: AOJu0YzTgvIjKhAUDxKx5ayAxnTh/k0vcctCrWOolmj7AGh/hkFlNbo4
	Dv86gmT/PjGdw09SmjAzZD/yot3L1+ok4+0v4rxtJAHhPNDLg2WsKwNv/vl0OEUQTkOGz1es66t
	PKJq3XFzyFgnJLnxQ2igIExXjR5U=
X-Google-Smtp-Source: AGHT+IHQ2XzGpscWrWx/gXlH+D2XG780duCe40ms54wbZIL1i333OYL+Z/epIDW7H9Oi9eZCBLs8FGCFWp1W/T0CMc4=
X-Received: by 2002:a67:f4d8:0:b0:47c:ac1:6f84 with SMTP id
 ada2fe7eead31-48d91d92523mr4271384137.2.1718272726252; Thu, 13 Jun 2024
 02:58:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613000721.23093-1-21cnbao@gmail.com> <20240613000721.23093-3-21cnbao@gmail.com>
 <77da1feb-2257-4545-9427-5729250ceb2b@redhat.com>
In-Reply-To: <77da1feb-2257-4545-9427-5729250ceb2b@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 13 Jun 2024 21:58:35 +1200
Message-ID: <CAGsJ_4xi6xuBzF1bhShGJJ6aPzpnzOk0JQ542=LpMiJ7ExqNJQ@mail.gmail.com>
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

On Thu, Jun 13, 2024 at 9:23=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 13.06.24 02:07, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > For the !folio_test_anon(folio) case, we can now invoke folio_add_new_a=
non_rmap()
> > with the rmap flags set to either EXCLUSIVE or non-EXCLUSIVE. This acti=
on will
> > suppress the VM_WARN_ON_FOLIO check within __folio_add_anon_rmap() whil=
e initiating
> > the process of bringing up mTHP swapin.
> >
> >   static __always_inline void __folio_add_anon_rmap(struct folio *folio=
,
> >                   struct page *page, int nr_pages, struct vm_area_struc=
t *vma,
> >                   unsigned long address, rmap_t flags, enum rmap_level =
level)
> >   {
> >           ...
> >           if (unlikely(!folio_test_anon(folio))) {
> >                   VM_WARN_ON_FOLIO(folio_test_large(folio) &&
> >                                    level !=3D RMAP_LEVEL_PMD, folio);
> >           }
> >           ...
> >   }
> >
> > It also enhances the code=E2=80=99s readability.
> >
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >   mm/memory.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 2f94921091fb..9c962f62f928 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4339,6 +4339,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       if (unlikely(folio !=3D swapcache && swapcache)) {
> >               folio_add_new_anon_rmap(folio, vma, address, RMAP_EXCLUSI=
VE);
> >               folio_add_lru_vma(folio, vma);
> > +     } else if (!folio_test_anon(folio)) {
> > +             folio_add_new_anon_rmap(folio, vma, address, rmap_flags);
>
> So, with large folio swapin, we would never end up here if any swp PTE
> is !exclusive, because we would make sure to allocate a large folio only
> for suitable regions, correct?
>
> It can certainly happen during swapout + refault with large folios. But
> there, we will always have folio_test_anon() still set and wouldn't run
> into this code path.
>
> (it will all be better with per-folio PAE bit, but that will take some
> more time until I actually get to implement it properly, handling all
> the nasty corner cases)
>
> Better add a comment regarding why we are sure that the complete thing
> is exclusive (e.g., currently only small folios).

No, patch 1/3 enables both cases to call folio_add_new_anon_rmap(). Current=
ly,
small folios could be non-exclusive. I suppose your question is
whether we should
ensure that all pages within a mTHP have the same exclusivity status,
rather than
always being exclusive?

>
> >       } else {
> >               folio_add_anon_rmap_ptes(folio, page, nr_pages, vma, addr=
ess,
> >                                       rmap_flags);
>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry

