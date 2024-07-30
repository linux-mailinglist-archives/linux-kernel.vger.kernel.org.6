Return-Path: <linux-kernel+bounces-268241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B0F942219
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8771BB227CA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CBD18E022;
	Tue, 30 Jul 2024 21:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IWKzbrlg"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA7E18C914
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 21:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722374283; cv=none; b=tR/OEFcVvemAsaV9Pahew2xG8XybBmpK+2hYbKLvPH8iMN164m8gaLKS6xgjfizyDE1dnoaUGkIa/B3hPQfdZiy0BXinbhdMdkqp8E5u3PSViVQ78m/Zg9pQGqvBN59BXYxLciQmMhQTyno8NZhZP6Of3Qu27zbZpnl6PAmtgpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722374283; c=relaxed/simple;
	bh=AuZvuV9QI0ZXSU2eRATLyGutCm4zrCTj2B6X4fSl41Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pSRwdLAJQVRN0ukZH3LA6itNt7WIyOH92qsczOnwE8Mh6DmG0CmQVecwh/eHQpYgiNTn32php/hDZaKrG+rScqqWo0Xdw0Isxid0W8BqUzSO6wBFmE8CYjlA3gTA4ytAqVYiyaN2ch5ZNwcY0IYXzKNtUDAO4TUSjGL/GGmKUGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IWKzbrlg; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-44fee2bfd28so98261cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 14:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722374279; x=1722979079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQzlvmVa30s7/0Cvf/ONz0CiTkA5Kxf3WVqHHnXgoEc=;
        b=IWKzbrlgzZyPMStBaFuOhc3A8xT15IoZNvs2pUzmt13mRhbN2m7pXXqs3LNmUPIeBM
         swfve9YDp0oTbZk4khwlbBjsck8JyYbywv23BGE9K0bn/UgeKFm3VoX11CDBxd4Fxa2r
         3Q/xHXEpZEAtaqmtZ77kHYB2XQpp0iqu/xTA/8IJfakpvGErHKAH6f7T52MFgbJTKd27
         rAU2recj3eMV3dglt2tlY/AxdyxojSiznipRD2aq69OkAHU58TMHGepeuDyNsyy7U7HE
         emEXdRudERB6CmlkmQus3LfLOJGY3YfOZaT6XHXCUF2yRa3lDu0o9+igReYdrS6/AisY
         cvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722374279; x=1722979079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQzlvmVa30s7/0Cvf/ONz0CiTkA5Kxf3WVqHHnXgoEc=;
        b=haZ0vPe//YIbqTpzjv0d83eElRETUinTQLRavCrPZXespps2Auln8S0ihGNgN+giGk
         GIXapaICEdcp3/j1DJBN9810QksNpBNCPK0VkHlnKuJTGgSnFqipkidKF/vW8AkGoMRz
         V7PRz0TbDUd5qQNY8V9rFNGo28eR4h+wLVFxg5Ajw+UbpnI8vkRrFur33sGcydmvz+/B
         jKVhU+fR/4ZfoXgAm+FXljfxgn+kmlj2X2HE+WjoUfnuvZMUpVSlOipGYwuo5h5CERrB
         5fH1IacaDjCoFUp6OpQxfiD75GdWHIcyeUmGJniGMfP3UjtQq2239UI0/2dHLKU0iljw
         uaeg==
X-Gm-Message-State: AOJu0Yw8QP7w+22M8RnxPaGuHv3vTKjtOAOFg9Yf8t5d6hYg0xmlKh4b
	Fk2T9NRt9kuiYsgjCUjFbzRdWSI4xPLwDESA1nyjWL1KCjdpxBbHHLhxwJIgAIz+18ujxWPMSwK
	r37eR0C8lZ6dE32DxQAODiSzasmY5FnvvDIYQ
X-Google-Smtp-Source: AGHT+IGeKl2MOsrgbgEMzNO2zod+Gnz547WZLav1AuvB9pAYXBjlGRyP+IPA8eSDlgyvuFGiez+ewEJrRBnpTpkL6V4=
X-Received: by 2002:a05:622a:410:b0:447:d555:7035 with SMTP id
 d75a77b69052e-4504314cf01mr166851cf.13.1722374279116; Tue, 30 Jul 2024
 14:17:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730200341.1642904-1-david@redhat.com> <CADrL8HXRCNFzmg67p=j0_0Y_NAFo5rUDmvnr40F5HGAsQMvbnw@mail.gmail.com>
 <3f6c97b5-ccd8-4226-a9ac-78d555b0d048@redhat.com> <b74fcedb-60c5-4fd3-bcc7-74959e12c38d@redhat.com>
In-Reply-To: <b74fcedb-60c5-4fd3-bcc7-74959e12c38d@redhat.com>
From: James Houghton <jthoughton@google.com>
Date: Tue, 30 Jul 2024 14:17:22 -0700
Message-ID: <CADrL8HUvxp8TX31SsVaQg_HBgTWMDUKWxOJqCp-G_c9Lqz9n+g@mail.gmail.com>
Subject: Re: [PATCH v2] mm/hugetlb: fix hugetlb vs. core-mm PT locking
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org, 
	Peter Xu <peterx@redhat.com>, Oscar Salvador <osalvador@suse.de>, 
	Muchun Song <muchun.song@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 2:07=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 30.07.24 23:00, David Hildenbrand wrote:
> > On 30.07.24 22:43, James Houghton wrote:
> >> On Tue, Jul 30, 2024 at 1:03=E2=80=AFPM David Hildenbrand <david@redha=
t.com> wrote:
> >>> diff --git a/include/linux/mm.h b/include/linux/mm.h
> >>> index b100df8cb5857..1b1f40ff00b7d 100644
> >>> --- a/include/linux/mm.h
> >>> +++ b/include/linux/mm.h
> >>> @@ -2926,6 +2926,12 @@ static inline spinlock_t *pte_lockptr(struct m=
m_struct *mm, pmd_t *pmd)
> >>>           return ptlock_ptr(page_ptdesc(pmd_page(*pmd)));
> >>>    }
> >>>
> >>> +static inline spinlock_t *ptep_lockptr(struct mm_struct *mm, pte_t *=
pte)
> >>> +{
> >>> +       BUILD_BUG_ON(IS_ENABLED(CONFIG_HIGHPTE));
> >>> +       return ptlock_ptr(virt_to_ptdesc(pte));
> >>
> >> Hi David,
> >>
> >
> > Hi!
> >
> >> Small question: ptep_lockptr() does not handle the case where the size
> >> of the PTE table is larger than PAGE_SIZE, but pmd_lockptr() does.
> >
> > I thought I convinced myself that leaf page tables are always single
> > pages and had a comment in v1.
> >
> > But now I have to double-check again, and staring at
> > pagetable_pte_ctor() callers I am left confused.
> >
> > It certainly sounds more future proof to just align the pointer down to
> > the start of the PTE table like pmd_lockptr() would.
> >
> >> IIUC, for pte_lockptr() and ptep_lockptr() to return the same result
> >> in this case, ptep_lockptr() should be doing the masking that
> >> pmd_lockptr() is doing. Are you sure that you don't need to be doing
> >> it? (Or maybe I am misunderstanding something.)
> >
> > It's a valid concern even if it would not be required. But I'm afraid I
> > won't dig into the details and simply do the alignment in a v3.
>
> To be precise, the following on top:
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 1b1f40ff00b7d..f6c7fe8f5746f 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2926,10 +2926,22 @@ static inline spinlock_t *pte_lockptr(struct mm_s=
truct *mm, pmd_t *pmd)
>          return ptlock_ptr(page_ptdesc(pmd_page(*pmd)));
>   }
>
> -static inline spinlock_t *ptep_lockptr(struct mm_struct *mm, pte_t *pte)
> +static inline struct page *ptep_pgtable_page(pte_t *pte)
>   {
> +       unsigned long mask =3D ~(PTRS_PER_PTE * sizeof(pte_t) - 1);
> +
>          BUILD_BUG_ON(IS_ENABLED(CONFIG_HIGHPTE));
> -       return ptlock_ptr(virt_to_ptdesc(pte));
> +       return virt_to_page((void *)((unsigned long)pte & mask));
> +}
> +
> +static inline struct ptdesc *ptep_ptdesc(pte_t *pte)
> +{
> +       return page_ptdesc(ptep_pgtable_page(pte));
> +}
> +
> +static inline spinlock_t *ptep_lockptr(struct mm_struct *mm, pte_t *pte)
> +{
> +       return ptlock_ptr(ptep_ptdesc(pte));
>   }

Thanks! That looks right to me. Feel free to add

Reviewed-by: James Houghton <jthoughton@google.com>

>
>
> virt_to_ptdesc() really is of limited use in core-mm code as it seems ...
>
> --
> Cheers,
>
> David / dhildenb
>

