Return-Path: <linux-kernel+bounces-370369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8D39A2B96
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 20:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056971C276FE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB1A1DF74F;
	Thu, 17 Oct 2024 18:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SlMAPAnE"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F42A762D0
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 18:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729188075; cv=none; b=FaGAfvn+QYDTLeBw92UbAOL8WftHMR6UVd3jrqs/DQZN6g5XsioV8/mOtudlOPbBnzBC2w7mqBEkAUp7lIJ0YUmZCKgaFBuIIU+N10q6VBgG3d4YQ+EXIyJiLVZ8K+m4zP2v9oV5138q6hxq0+wCOzkJDgN0J7pvQTrNX/YAgIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729188075; c=relaxed/simple;
	bh=DVgNm3ca9ROb01nvOKtFGb69j8JHxW0kTHVz3Y0Xd1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MTR8PbfRn48/J/J7iuBA7UCymK9kgtX92lwSaqWtw/3AWkmhcd6IV3ILSSLbdTaAXwp5nLYsi4ha2s3a1wdrX4mm+7TPoChgXLIv7346nc4e01OnRprDRQ5zqkPyxRhbY/twbMdGL/2XdhdR1CTY10IB9FevMKVsxgF7g9Gi7Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SlMAPAnE; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539e66ba398so2880e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 11:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729188069; x=1729792869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tq6vRXTn8lHPzINpeLq9DaDFBi1VKCSNHgf2UHYSZs=;
        b=SlMAPAnE3LoF7zuiSuiRgI8M3sfYA4Q/yRAVcvMXIEevQBR83VZqCnMK5CQZeDtPU4
         R/A/cSN/dVDs0iFzVqod7l2xOFjR/qIQ7OsI0NWqStMdAJXCINp6RLV2wJzlniFbtxsU
         Rdv4lvIeCrAisVbY8+gc2n90AszHIMyxB8rh7ktnrLwUXFgSWaLUgWyDMCV2VMp3DCfB
         j7OVzdsFBaZsOOvyu8Ed8hRwUMSPryDSn54T2vkpads48G71+y1O6uOdSuUAjMNlkp34
         xZGlz46+4FlwXKTkK0BVSIU2OfZrfU4jA9DZ55cjqQqTzSQd4mIADdCxf0pFisTopQkZ
         s9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729188069; x=1729792869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3tq6vRXTn8lHPzINpeLq9DaDFBi1VKCSNHgf2UHYSZs=;
        b=d+AUDqVAh7cepWkDlKcFm6hOPa2gCkeNRssjGnz2HW451RFyaKCj03RHhvOs5X3lvl
         KorIu5fUz6pIJDnvZQJsDeoeDEiJKV8ZeMCanoF8shjzDHrLfsxra23RBjJpIIaAAOzp
         v34dF5B0RoZh8jhUHqSKTR1sKRbp14R1SdItN0mcXyxmfGHh6Jfq8J4TC3OSblLbfGvk
         PpoHRXVMxEHSWUZ8D99M1JEyy6I1NxhK7Ru0q1MB56E02HX87dIu3WUBH3QvcGLvkdzg
         FrMa8qrLCpTgOajG4CrK0TpiqgZmFkrmzLtxZn96sM4W2JV52ejC01zSSTz5nLR6Noag
         gIfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV15PnVGIKGukdS4Y0VMT6tFn8A0oXZbVwkLDeAVAaBg4W8Hwa+jse4Lwk203QgnFZ4QiTfALMaady/+Zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNjo0z7F4nvITBpeFdpAXv84CscOcrDsmASur/SzTGwWyYcfhV
	RNZ8b3wNeZy4ZcCqointuvfWOTphqCSFxfK33/5tOwDxjKkkVWBPQwYWIc7ZcravSTrTf1yuAsD
	jjWYFKNtB1bpXUT3CYxv6GatlsQK95Ex2bLHS
X-Google-Smtp-Source: AGHT+IEs6lSI75tBkXW86ko6TEAGAckc/7GMFDqnAaeh6EW29o6PIKm0pr/qnKjOhqWrVCfS12Qhn6wWkiGlQ7tzLzw=
X-Received: by 2002:a05:6512:282b:b0:535:3d14:1313 with SMTP id
 2adb3069b0e04-53a14c82458mr12933e87.0.1729188068150; Thu, 17 Oct 2024
 11:01:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729157502.git.zhengqi.arch@bytedance.com> <258de4356bdcc01bce0ff1f6c29b2b64a4211494.1729157502.git.zhengqi.arch@bytedance.com>
In-Reply-To: <258de4356bdcc01bce0ff1f6c29b2b64a4211494.1729157502.git.zhengqi.arch@bytedance.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 17 Oct 2024 20:00:32 +0200
Message-ID: <CAG48ez2yPVjpPoAPmitrdaig-dF7j9THN=CZd6QD7to=tF2=NQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] mm: khugepaged: retract_page_tables() use pte_offset_map_lock()
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: david@redhat.com, hughd@google.com, willy@infradead.org, mgorman@suse.de, 
	muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org, 
	zokeefe@google.com, rientjes@google.com, peterx@redhat.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 11:47=E2=80=AFAM Qi Zheng <zhengqi.arch@bytedance.c=
om> wrote:
> In retract_page_tables(), we may modify the pmd entry after acquiring the
> pml and ptl, so we should also check whether the pmd entry is stable.
> Using pte_offset_map_lock() to do it, and then we can also remove the
> calling of the pte_lockptr().
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  mm/khugepaged.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 94feb85ce996c..b4f49d323c8d9 100644
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
> @@ -1757,9 +1758,15 @@ static void retract_page_tables(struct address_spa=
ce *mapping, pgoff_t pgoff)
>                 mmu_notifier_invalidate_range_start(&range);
>
>                 pml =3D pmd_lock(mm, pmd);
> -               ptl =3D pte_lockptr(mm, pmd);
> +               pte =3D pte_offset_map_lock(mm, pmd, addr, &ptl);

This takes the lock "ptl" on the success path...

> +               if (!pte) {
> +                       spin_unlock(pml);
> +                       mmu_notifier_invalidate_range_end(&range);
> +                       continue;
> +               }
>                 if (ptl !=3D pml)
>                         spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);

... and this takes the same lock again, right? I think this will
deadlock on kernels with CONFIG_SPLIT_PTE_PTLOCKS=3Dy. Did you test this
on a machine with less than 4 CPU cores, or something like that? Or am
I missing something?

