Return-Path: <linux-kernel+bounces-205658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A598FFE8E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BA0C1C21902
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D42915B0FC;
	Fri,  7 Jun 2024 09:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdoCsf54"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7C31BC23
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 09:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717750853; cv=none; b=J3V06grvIr/WSPF83klBXJaPjqzvzNiCEAjYUYcmsMzxEM1LIUDpyjtW+VQCM6UHYHqm0Jb3sQf9QC7QSc3JPKqiLkPdxeDa/oLSxg5uiqUro9jJSaU7Y+o/IAs4NI3IKx/x5wWwGT8VJsJ+W+1y20RoSK3hhUynM/0SrbWkAtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717750853; c=relaxed/simple;
	bh=hbH9FscCbenKyJOliecIL8HXiCKJO1fhxhChk9cPvPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rAZ+JrSqn2cqBOFoQf7WEPMFpe59Q+PW5kDlx2V9iN0jdtolHJJgRYiWyGjirt5huG4M3Re/TnKbC+cjLpO8HRfvvkLb4Yu4FIATcEYDZtYR7iuQoFm6rlKiuAGGuT4ANwn0UrD7YQz5bwoH6rehUDi3vQoJwvUj9q2r9rt9r5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdoCsf54; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4eb007a9f6fso585857e0c.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 02:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717750851; x=1718355651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBcoLUrX2L9eb2fV5NkylUMV+gvpxQM/JqT0hm0OtKQ=;
        b=QdoCsf54zCcbgQ9pL2my7TNT0/jHAqdn6hkGE8x+yG3dzr6TngdKF8Go/1LIToUAzk
         yz9rMHhkvwZm+7MH5cb7HZMavYqMpGfrR4ZkCHOwiL/Ya0/jECPFq0o3XhSgkrFir1hE
         C2IEQO2m22GNGNMNB3q415OK6HfUQE7sahL4XIBi6Gq4g71fyRMP9TL1Io9vpHndZZz7
         iE5LWaElmULQgOnGQ1+6/WmermRB6GdODZrZHKioU/N3t1n+NVSqq0urs/UyR5fV6Y6Q
         WtvPkbUdKmi5Ck7L/SUlnD+zbWXRwUifEi2mRYg14ieY8RwuZYa5JvkpyrWnqrUuMtTK
         QqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717750851; x=1718355651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBcoLUrX2L9eb2fV5NkylUMV+gvpxQM/JqT0hm0OtKQ=;
        b=AaXs38fEjf9TUvaDbqGLYwwnry8ePOQcCfcev+Vf+7W5d5lx1YMctH9HjA28W1bB4P
         zbqRKN2MBJeZE3hV6oeVnWy/HYJ29OLd7RLhCNp/QWAw2aZW5Uf9OFVQXwXGtklqnA1t
         ZlCWDIwATlzFabHWr73v6++EQvRq9k+kh18yYMY05Sot3nWjdGMd93tUhLbTUoabj0e0
         8Wu8Y1K8K4G1FYOgLSpsXmUXoaOCBBuedl05GUDtPoPQM6z3sfuvpMvLPRAlLCokgMlH
         zckjjhk1mw9wZmW4nsGQue3fav6tBOCq5P8MfHzRPZZ1Df/KiwnrODx/xnVVxydzeTia
         ztqg==
X-Forwarded-Encrypted: i=1; AJvYcCVMc2xiZ9wMdRaudZi1GKn/ACnoUCXMopgzk+tAyhctwkkvajJ7eQfOvXyfippvp1b9f4JwEw3XFLQFsDQFzURM09cGpsJAVcsXGa9p
X-Gm-Message-State: AOJu0YwMDYjH8nyld5k+UDR4D8wZNkyCmi36LLAk48FTOObcTL+mbeQp
	irzs7LhMk/fDvMYCIW9QySkC2cNMpqCGyqcquD/eqsVEjX+ZahgBLVYUg4+3fj3kYiC9Xk9MWCp
	WxuraFDrFfZEcCOyMOsxfBUteups=
X-Google-Smtp-Source: AGHT+IGLUmk2eI7NKtebudys+AdNxQPrEw0y6t74Brmd9i82lSeOm4DST94C+ok3UcTEGRrcETFb4Cjpiqg67slKY/4=
X-Received: by 2002:ac5:ccad:0:b0:4e4:eb50:fd57 with SMTP id
 71dfb90a1353d-4eb562543bdmr2166514e0c.9.1717750850115; Fri, 07 Jun 2024
 02:00:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606034016.82559-1-21cnbao@gmail.com> <a04dd2d6-8526-488f-b46a-80c530891415@redhat.com>
In-Reply-To: <a04dd2d6-8526-488f-b46a-80c530891415@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 7 Jun 2024 21:00:38 +1200
Message-ID: <CAGsJ_4wSFWMpgd38XqZNNdfDT9PHp+xNjfFYY46yHvjqwJ5QkA@mail.gmail.com>
Subject: Re: [PATCH] mm: introduce pmd|pte_need_soft_dirty_wp helpers for
 softdirty write-protect
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, chrisl@kernel.org, 
	kasong@tencent.com, linux-kernel@vger.kernel.org, minchan@kernel.org, 
	ryan.roberts@arm.com, surenb@google.com, v-songbaohua@oppo.com, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 8:46=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 06.06.24 05:40, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > This patch introduces the pte_need_soft_dirty_wp and
> > pmd_need_soft_dirty_wp helpers to determine if write protection is
> > required for softdirty tracking. This can enhance code readability
> > and improve its overall appearance.
> >
> > These new helpers are utilized in gup, huge_memory, and protect,
> > and are particularly applied in do_swap_page() to optimize a
> > softdirty scenario where mkwrite can still be performed.
>
> [...]
>
> > +static inline bool pmd_need_soft_dirty_wp(struct vm_area_struct *vma, =
pmd_t pmd)
> > +{
> > +     return vma_soft_dirty_enabled(vma) && !pmd_soft_dirty(pmd);
> > +}
> > +
> > +static inline bool pte_need_soft_dirty_wp(struct vm_area_struct *vma, =
pte_t pte)
> > +{
> > +     return vma_soft_dirty_enabled(vma) && !pte_soft_dirty(pte);
> > +}
> > +
>
> Should these be "needs" ? I tend to like these names/semantics.

yes. "needs" is better. Glad to know you have the common liking
for these names.

>
>
> >   static inline void vma_iter_config(struct vma_iterator *vmi,
> >               unsigned long index, unsigned long last)
> >   {
> > diff --git a/mm/memory.c b/mm/memory.c
> > index db9130488231..6307c43796aa 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4322,7 +4322,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       if (!folio_test_ksm(folio) &&
> >           (exclusive || folio_ref_count(folio) =3D=3D 1)) {
> >               if ((vma->vm_flags & VM_WRITE) && !userfaultfd_pte_wp(vma=
, pte) &&
> > -                 !vma_soft_dirty_enabled(vma)) {
> > +                 !pte_need_soft_dirty_wp(vma, pte)) {
> >                       pte =3D pte_mkwrite(pte, vma);
>
> I would move that into a separate patch, as it's not a simple conversion.
>

cool. will separate it in v2.

> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry

