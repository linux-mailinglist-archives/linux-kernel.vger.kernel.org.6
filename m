Return-Path: <linux-kernel+bounces-398971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AA49BF8A6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 22:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9400E2841F1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 21:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA96B1D88D3;
	Wed,  6 Nov 2024 21:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="piUrunAq"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606421684AC
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 21:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730929763; cv=none; b=ubLkbKrRMLU89AqrzgA/UYwW601aG4V2NWiNDE1Ubtlk1IP7TEgs9ofH/U562dtU17LUcZ0eU4WHys+Gowxnb4vG/OwHhYArX7CNv/i5qxUwBGOtYo8CX8c+95m9VxnUVi5DoXOKxeES87XVMzYUeZgZPaqpr67xLZiqH0XOSSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730929763; c=relaxed/simple;
	bh=RgT7FVW/v08P0NjkHlKyV8gHQssyLNaz/If3umGsNnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZqW649omK9Q4GA9dG2fVo3oMh4PwAGeBr7T3+P9EEGFcWny5eFLzbCD0hTKlAYDWLr3on5HEHOmQegZRpWxerOQA9+RunMGHKdoi5f/ProGnbJm0ZHGPCa0gtZNqJRlzWGNT97B2lALrs5agDBJzJrjwbEshcuQBcw3Y+946l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=piUrunAq; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c947c00f26so1859a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 13:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730929760; x=1731534560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqBReMzQ4QYB8LLJpM6gahb2W8ayiPnSC7EMvyXGOk4=;
        b=piUrunAq5+aJBwUbxpckls8fC/V0Yw+XZHlqu9fcCw0t+K77Xm2jdTy84Rq5Js8daa
         y8KhKQIbQzR9IUQxT/Z6lHcbZSkJ2FIhRkdv4kWhhua9OeplTefd8uLD/CQlvsmm5nGk
         tC/QOzRDZEySlt2KYdFb2dU+fPETMiNJqc1A7uHQ6eIJOAPi5x4cjgu7gGYuVqw+Mg5+
         AWrNohIFJV96HYCZ8a3EefX7sMPsRZmRuP5KjApDxmZ6dF0iQ/GA9HuoCF3BjtqTluhF
         8SOttYvzZPuIkD27JR9+9cuRskX1qepUCSH+DBCJExZo9L1qibgxRBSwFZnkraf6lTMs
         qQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730929760; x=1731534560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iqBReMzQ4QYB8LLJpM6gahb2W8ayiPnSC7EMvyXGOk4=;
        b=ujx+zvWqm7mYjI2wwBFvzZAk26sb2Rwe4o51do4QqpTAV/V6O7X/peEihDrzhxA9Lb
         /yb1CF09HXTBWZj72YxSDy0/g3ZpV+7J9i6tCRGaB3sCElwDF1rtKT17PFDCAHQB4i46
         8RNrxnrMrEtKIjaPWwOiK2DP4XCxEFuLbaH4xUQWybUhYEB2Cd0dDUR1fMlXlLQLhzLx
         oCotApP9rIqcCT5dNaDIB9bsAjlkshq4msZ15aRF1VH6I41hKZuNP8sCjQJBrAA29hOW
         ZQknlb1FdSblAewTldAq1z4GQWnd4+Dlp48XNpdxrIveGTsOv9+GtNN+DZ0V+Sh8B7oC
         ieRA==
X-Forwarded-Encrypted: i=1; AJvYcCWOuXP+dW7TkZtdVVXGM7sePgYXKN76GXNLx/oKqvLVbBAHd0MWV8/BSmhVyZNy2nuwTcw1YAkE34nVpiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqwuS/fIUIMfItvYyHcBM5K1jFcBwgOy4En9/m8PJct+GkX0iQ
	nAlDC1X1cOG5rZcyALlgfMLysitLNUkRkffqqVpsoAh5jAY2JYhTNP5s7C+YNoHAorpE6AVqp05
	j8wHRuWGZagiBPIW4mLiKML35XH6E/XScSqBB
X-Gm-Gg: ASbGncufr3vuWepEo/EBoprusDO1Atw8QLID50CbEEUNPZ6ohiIUMyVa8IQC9iYrL9U
	hwnRJEBgWA4L+GCRXgNaNAnSxN+4VIINe4hwRLbIBQ0VrrSOzzhxf8wGSJrY=
X-Google-Smtp-Source: AGHT+IG1aBUYlTL8mRWEZzGnMhdvOJ97x/UkRnuojHriKyUAEksu27Bi3SoiNa+Ns1JqqKMmuo7TOb3Dps7+GIbPctc=
X-Received: by 2002:a50:f69a:0:b0:5cb:7316:2e15 with SMTP id
 4fb4d7f45d1cf-5cefbb03500mr239807a12.0.1730929759279; Wed, 06 Nov 2024
 13:49:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730360798.git.zhengqi.arch@bytedance.com> <4c3f4aa29f38c013c4529a43bce846a3edd31523.1730360798.git.zhengqi.arch@bytedance.com>
In-Reply-To: <4c3f4aa29f38c013c4529a43bce846a3edd31523.1730360798.git.zhengqi.arch@bytedance.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 6 Nov 2024 22:48:43 +0100
Message-ID: <CAG48ez1S3nU0qzf6zZYAOTGO=RmK_2z+ZvHLzrpfamQ4uGK4hg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] mm: khugepaged: retract_page_tables() use pte_offset_map_rw_nolock()
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: david@redhat.com, hughd@google.com, willy@infradead.org, mgorman@suse.de, 
	muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org, 
	zokeefe@google.com, rientjes@google.com, peterx@redhat.com, 
	catalin.marinas@arm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 9:14=E2=80=AFAM Qi Zheng <zhengqi.arch@bytedance.co=
m> wrote:
> In retract_page_tables(), we may modify the pmd entry after acquiring the
> pml and ptl, so we should also check whether the pmd entry is stable.

Why does taking the PMD lock not guarantee that the PMD entry is stable?

> Using pte_offset_map_rw_nolock() + pmd_same() to do it, and then we can
> also remove the calling of the pte_lockptr().
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  mm/khugepaged.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 6f8d46d107b4b..6d76dde64f5fb 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1721,6 +1721,7 @@ static void retract_page_tables(struct address_spac=
e *mapping, pgoff_t pgoff)
>                 spinlock_t *pml;
>                 spinlock_t *ptl;
>                 bool skipped_uffd =3D false;
> +               pte_t *pte;
>
>                 /*
>                  * Check vma->anon_vma to exclude MAP_PRIVATE mappings th=
at
> @@ -1756,11 +1757,25 @@ static void retract_page_tables(struct address_sp=
ace *mapping, pgoff_t pgoff)
>                                         addr, addr + HPAGE_PMD_SIZE);
>                 mmu_notifier_invalidate_range_start(&range);
>
> +               pte =3D pte_offset_map_rw_nolock(mm, pmd, addr, &pgt_pmd,=
 &ptl);
> +               if (!pte) {
> +                       mmu_notifier_invalidate_range_end(&range);
> +                       continue;
> +               }
> +
>                 pml =3D pmd_lock(mm, pmd);

I don't understand why you're mapping the page table before locking
the PMD. Doesn't that just mean we need more error checking
afterwards?


> -               ptl =3D pte_lockptr(mm, pmd);
>                 if (ptl !=3D pml)
>                         spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
>
> +               if (unlikely(!pmd_same(pgt_pmd, pmdp_get_lockless(pmd))))=
 {
> +                       pte_unmap_unlock(pte, ptl);
> +                       if (ptl !=3D pml)
> +                               spin_unlock(pml);
> +                       mmu_notifier_invalidate_range_end(&range);
> +                       continue;
> +               }
> +               pte_unmap(pte);
> +
>                 /*
>                  * Huge page lock is still held, so normally the page tab=
le
>                  * must remain empty; and we have already skipped anon_vm=
a
> --
> 2.20.1
>

