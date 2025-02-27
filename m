Return-Path: <linux-kernel+bounces-536906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E933FA485DB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23B7C17902D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339981B4151;
	Thu, 27 Feb 2025 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tfOjuzLe"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115CE1CB9EA
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674862; cv=none; b=X79hElg50jP9so5eJjflN03mgoh7NxYTIc8xgm3U9PU3Vbxov2FVtKx5ApKlV2g51javVL68N/eM6PQ+C0VFRzvhu4uYIoM6bXSA3MZDsvg3CRL6cDfneaowOIpArXExVzpquIRNwQn+7Vf/J8I/WpR/bj3jxKzEtJQ9O1ipbKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674862; c=relaxed/simple;
	bh=A0O7VaCBvhIde6HUIo2weVzpqQbN5OmJVjtijzFCX4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VXDzzl8zNqTKH7k9O/10vORIbB8DIIrtF0IpDHJQ2wx3lC0/w9ibRmt48E5xDcv0EO7CKckV95COgufr5av0vrz15CCKdY+ruarnnh1sY9PbvrBCBBaj9/zg4mEiclWWxUQy5SqV9yeOKLkVoRY93RV1iAlfvJjk97kBKFFekeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tfOjuzLe; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22342c56242so224085ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740674860; x=1741279660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjQglI5Jx4hFLotBiZ0PYZgwKxX6om4t0kw+FgWAq7w=;
        b=tfOjuzLeg+lf3R98BJBKMP5KLYX8Y1V6Kvb8r08S9mBE42q1hMf80GB5ZoXq2ltLKC
         F8vsvF/xtRIraFBD+6kOh/UG0h379xDZnbbibHC0wf6cImU//+yNPtfOOmRbhvauA9dE
         MEiHwLotuFklhLfB6Xh9dFju/w1f1rfX60QirXhhcg/oROjdhvdlLPYNopmoroOXXREY
         6VWSrpraCoy4qt7vL8zJr+MbeY/IiwJP+On7BJbPsZwZQvOT9KhO+lCq49egNx/zeAC+
         wQS2/99CdB0YLhXQqmwWm14N5FQeigMPlqnOsEabF6FXwzVTLHM9RfVxp6LmjulCF73o
         nj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740674860; x=1741279660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjQglI5Jx4hFLotBiZ0PYZgwKxX6om4t0kw+FgWAq7w=;
        b=tBGbK9Ymrqv/v0ijT1gfLfBVog4V9sJDYPR/PBPWQ0UtoOSAGoqbtuKwKZ1riOKOdY
         QfWOrvrzuFp9Ty3AxtYTVtd385VegTyilewq1WJAtEIh+BVIjKgn+MEKxe1KOcWjt/fy
         0skh5lqo8baBudHcGBBqF4lopqRFmiHSDvN2bKgoKyN8sD4FmiqZTiQJ7X+NjCqJnINQ
         dT++4WLIVpQn9QJeYkL5j4vfopKV7TYnPW/cRqv4+jp3320LBW4XDm/OSzMfBLsAqjrJ
         YP557u7FrL5VQYFYvn8Bn+nTMumYO2JbonEBgwYvkkgDPfgpId85aGRNfHk4OKS4UMHZ
         rrjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3fwPg2TPtB6a06OsYJpGC/FmDZoyrEAK5Sje6SrfhVCaP1SBdqaHnwrgw3Kg9Ak+UgjUpIpiMP2GRK+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVXZ/aLlm1hpc2cYQP8PmXI5pQVS7iDTyDHSjkBqsXqIaIv4eC
	66ipF7mT0RpvNyaIKWgVT4k/5/JQAEm8gDKBqtLG9Ewd3KJHOkA9VatrsDRVsO0IDjSj+/H0+FQ
	OykiR0gKMSHGRg4g7w7vr8z0OEZiiajW2W3X0dSUj9cFbs/EJ6w3B
X-Gm-Gg: ASbGncs7dIqz+lV85jHERdK6KTxQCERLluOgtdznOfhm7hwVQYEJglj2+yvYZubVODw
	f+XQYmJesWbkrJumiEXOIwZAGUf6Dr0xyAFr4yd5zz/JKvR0ldA55CyiBPjNGuYS4EzKkRC/ldQ
	U+wOIdbg==
X-Google-Smtp-Source: AGHT+IGbh2l4ajVTrlNsPmTCm4a8bZF9mLdxtA25l6wpBcMDhLAicmrXnr5nMHmIUgLPCdLGS7Du7gykIKVTKfuq8/g=
X-Received: by 2002:a17:903:2647:b0:21f:631c:7fc9 with SMTP id
 d9443c01a7336-2234d3abb47mr3241885ad.0.1740674859774; Thu, 27 Feb 2025
 08:47:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226114815.758217-1-bgeffon@google.com> <20250226162341.915535-1-bgeffon@google.com>
 <19624e55-ba41-41e7-ba11-38b6ab3b96e5@linux.alibaba.com>
In-Reply-To: <19624e55-ba41-41e7-ba11-38b6ab3b96e5@linux.alibaba.com>
From: Brian Geffon <bgeffon@google.com>
Date: Thu, 27 Feb 2025 11:47:02 -0500
X-Gm-Features: AQ5f1JrSljmPZJRVpwmBaun-Y2rCm8rPURUzFaXgFgfmntTS2L4B3GhyxYNcs0U
Message-ID: <CADyq12zgFigdBHiCv=AkZNLfbrmnCe2AVVOkjxNy9PwvJZsETQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: fix finish_fault() handling for large folios
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, 
	David Hildenbrand <david@redhat.com>, stable@vger.kernel.org, Hugh Dickins <hughd@google.com>, 
	Marek Maslanka <mmaslanka@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 2:34=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2025/2/27 00:23, Brian Geffon wrote:
> > When handling faults for anon shmem finish_fault() will attempt to inst=
all
> > ptes for the entire folio. Unfortunately if it encounters a single
> > non-pte_none entry in that range it will bail, even if the pte that
> > triggered the fault is still pte_none. When this situation happens the
> > fault will be retried endlessly never making forward progress.
> >
> > This patch fixes this behavior and if it detects that a pte in the rang=
e
> > is not pte_none it will fall back to setting a single pte.
> >
> > Cc: stable@vger.kernel.org
> > Cc: Hugh Dickins <hughd@google.com>
> > Fixes: 43e027e41423 ("mm: memory: extend finish_fault() to support larg=
e folio")
> > Suggested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Reported-by: Marek Maslanka <mmaslanka@google.com>
> > Signed-off-by: Brian Geffon <bgeffon@google.com>
> > ---
> >   mm/memory.c | 15 ++++++++++-----
> >   1 file changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index b4d3d4893267..b6c467fdbfa4 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -5183,7 +5183,11 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
> >       bool is_cow =3D (vmf->flags & FAULT_FLAG_WRITE) &&
> >                     !(vma->vm_flags & VM_SHARED);
> >       int type, nr_pages;
> > -     unsigned long addr =3D vmf->address;
> > +     unsigned long addr;
> > +     bool needs_fallback =3D false;
> > +
> > +fallback:
> > +     addr =3D vmf->address;
> >
> >       /* Did we COW the page? */
> >       if (is_cow)
> > @@ -5222,7 +5226,8 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
> >        * approach also applies to non-anonymous-shmem faults to avoid
> >        * inflating the RSS of the process.
> >        */
> > -     if (!vma_is_anon_shmem(vma) || unlikely(userfaultfd_armed(vma))) =
{
> > +     if (!vma_is_anon_shmem(vma) || unlikely(userfaultfd_armed(vma)) |=
|
> > +                     unlikely(needs_fallback)) {
>
> Nit: can you align the code? Otherwise look good to me.

I mailed a v3 with adjusted alignment, I'll let Andrew decide which
variation he prefers.

>
> >               nr_pages =3D 1;
> >       } else if (nr_pages > 1) {
> >               pgoff_t idx =3D folio_page_idx(folio, page);
> > @@ -5258,9 +5263,9 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
> >               ret =3D VM_FAULT_NOPAGE;
> >               goto unlock;
> >       } else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
> > -             update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
> > -             ret =3D VM_FAULT_NOPAGE;
> > -             goto unlock;
> > +             needs_fallback =3D true;
> > +             pte_unmap_unlock(vmf->pte, vmf->ptl);
> > +             goto fallback;
> >       }
> >
> >       folio_ref_add(folio, nr_pages - 1);

Thanks for looking
Brian

