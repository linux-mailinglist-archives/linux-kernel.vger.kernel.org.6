Return-Path: <linux-kernel+bounces-188961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE24A8CE90F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 19:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE371C20FA6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 17:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A259D12EBFA;
	Fri, 24 May 2024 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fscSqUUR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E180B8626C
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 17:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570676; cv=none; b=UtfAuIEE/P7mYa7C4fMuOsFOx/ySKaGEYzzXKAO87QCJJ53g8NYU8FqvgJvpWKYp/vf7AJab8OWyGQUMQ5HwYuTx7DJvEYXxwdRpmFKU/v+AME/J1c3nuxYNTiSuGxbBWXlUS2l5qcrwzUqEXS95OZNNX/sa9ULs4DmXAjBPbDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570676; c=relaxed/simple;
	bh=EW7U8OL67LgQ87FmsjPAN6G93rJjTK3RaZspc5VFz6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pHOeiBHBxZ9iFLJS/L7KwdDGUqfY2kyg/sbxwatkZUElfOfw6t1YOZK2jlFUNBvmdU0FEGeWkzdurnsUI1vyDBSTAJzN4Vg5yqp++TD9W4Ew3mtZ9NoT2VQ/Wgb/deRpYu4TyOLce+6TlOAF/vFAV2zsyVOntVZoDrT8MrhFZ6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fscSqUUR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6617EC32789
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 17:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716570675;
	bh=EW7U8OL67LgQ87FmsjPAN6G93rJjTK3RaZspc5VFz6c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fscSqUURwSS6+ozUaMfVD2YOYoEcX9AsoC0EpFs+WMYMw9A2U9r1jdxcK79f0d5R2
	 nKZE9IATQy1chqAMsLqLhYuqdJa9vqjMpH2i7YoN/GrAxfwxIdRChXTOX3O3kxkWLy
	 6/Z+V3RA5DrnIY9ktbFnC6dLEtIPIQ/B1iQZrPY7HDyTjLGTtqfmYS3ZYDEV5Rp8BE
	 OqVIDMqLBQJxju16ejt1Xw4ABBxcF+37r4Dco9JDdovzo40cLxvKzakcwvQ300kgxb
	 IVUtDVISpH/7iNr/npOPEaKKld+4CF2aDCp35fQrOrEnFbjD80hrdHN5KKSnA+JCvv
	 xwe+0ZUhZubEw==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e538a264f7so103884931fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 10:11:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXTS5bBnQLNdUlC+bJGC1JqBc4iNyThkS9Cx8gdLD1A4cBc4gzkvw5F2jnysP95wxJ747VLHnK+0HyhetAduuhq6+SgycSg6rcGT6rN
X-Gm-Message-State: AOJu0Ywtu18wBUPA1UHwJoWIJQtkPEhm24kprKp7Zq6JaQtgo7RWdW6O
	H0cb61826vWGlP/zrz5Lu8wimHAaBZkWnkJnabxyH88ehGnSQFLLKb7xIXRcXr5TKSY2c8oPSMb
	OvkWLtDNK3s9OBe817dbO+R3QeA==
X-Google-Smtp-Source: AGHT+IGYyiWg0Q4ErVkLcKoC+PxC65Q/kLjUaeqp7KA48Ru2qUXyOJp8WWGLvr3hVy9IMjwk5svE/i2ae4NHMGmA+Zc=
X-Received: by 2002:a2e:9dd3:0:b0:2e6:b00f:da92 with SMTP id
 38308e7fff4ca-2e95b1dc418mr17731461fa.24.1716570673945; Fri, 24 May 2024
 10:11:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524005444.135417-1-21cnbao@gmail.com>
In-Reply-To: <20240524005444.135417-1-21cnbao@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 24 May 2024 10:10:58 -0700
X-Gmail-Original-Message-ID: <CANeU7QmtMh31A=qswRfD08R2mGdMFVja39=vq3WjOzysa3f=Vw@mail.gmail.com>
Message-ID: <CANeU7QmtMh31A=qswRfD08R2mGdMFVja39=vq3WjOzysa3f=Vw@mail.gmail.com>
Subject: Re: [PATCH] mm: arm64: Fix the out-of-bounds issue in contpte_clear_young_dirty_ptes
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Lance Yang <ioworker0@gmail.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>, Jeff Xie <xiehuan09@gmail.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Michal Hocko <mhocko@suse.com>, 
	Minchan Kim <minchan@kernel.org>, Muchun Song <songmuchun@bytedance.com>, 
	Peter Xu <peterx@redhat.com>, Yang Shi <shy828301@gmail.com>, 
	Yin Fengwei <fengwei.yin@intel.com>, "Zach O'Keefe" <zokeefe@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Good catch.

Acked-by: Chris Li <chrisl@kernel.org>

Chris


On Thu, May 23, 2024 at 5:55=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> We are passing a huge nr to __clear_young_dirty_ptes() right
> now. While we should pass the number of pages, we are actually
> passing CONT_PTE_SIZE. This is causing lots of crashes of
> MADV_FREE, panic oops could vary everytime.
>
> Fixes: 89e86854fb0a ("mm/arm64: override clear_young_dirty_ptes() batch h=
elper")
> Cc: Lance Yang <ioworker0@gmail.com>
> Cc: Barry Song <21cnbao@gmail.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Jeff Xie <xiehuan09@gmail.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Muchun Song <songmuchun@bytedance.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Yin Fengwei <fengwei.yin@intel.com>
> Cc: Zach O'Keefe <zokeefe@google.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  arch/arm64/mm/contpte.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
> index 9f9486de0004..a3edced29ac1 100644
> --- a/arch/arm64/mm/contpte.c
> +++ b/arch/arm64/mm/contpte.c
> @@ -376,7 +376,7 @@ void contpte_clear_young_dirty_ptes(struct vm_area_st=
ruct *vma,
>          * clearing access/dirty for the whole block.
>          */
>         unsigned long start =3D addr;
> -       unsigned long end =3D start + nr;
> +       unsigned long end =3D start + nr * PAGE_SIZE;
>
>         if (pte_cont(__ptep_get(ptep + nr - 1)))
>                 end =3D ALIGN(end, CONT_PTE_SIZE);
> @@ -386,7 +386,7 @@ void contpte_clear_young_dirty_ptes(struct vm_area_st=
ruct *vma,
>                 ptep =3D contpte_align_down(ptep);
>         }
>
> -       __clear_young_dirty_ptes(vma, start, ptep, end - start, flags);
> +       __clear_young_dirty_ptes(vma, start, ptep, (end - start) / PAGE_S=
IZE, flags);
>  }
>  EXPORT_SYMBOL_GPL(contpte_clear_young_dirty_ptes);
>
> --
> 2.34.1
>
>

