Return-Path: <linux-kernel+bounces-212866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C6F906761
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C50A1F23471
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A3213D517;
	Thu, 13 Jun 2024 08:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvYu7vM1"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2438277118
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718268386; cv=none; b=W458OlR/muQgbHuhiS+Z5RbVi1UAKsPr5sOVVUqSMPtXEU1kODg+tlrrecNpodBxomq3NEaQVok2jEZYOJHvsjzMwhrU0sPiRxmEVmpwwe8DpLe+sGIkMUewsH9OtYGPcZb5tHI/dMeo99rb2jToSlQkVd0TPitS55mk2pFGI5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718268386; c=relaxed/simple;
	bh=c+6YGHZAWPgDR516eTVeoCk8cdewYFFE5+cBxZDjJ40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dp19NeufcNsvNv39ZAmGfxZsBGVb3ZwUd4Io96sSGnLGCjX0rvtggPKEW/jzJwo9ZgfhmsoI0ysVTqN0IMVBq4+qtb5QDkDo8jhQISfDFnaeMnkvH/graCiIbaXlUpDoq/okMo1rxYkVm/d1eG/cVxMbau7Wil1w9ygRgePqj08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvYu7vM1; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4ed128ac278so245601e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 01:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718268384; x=1718873184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNrMBohAlmbgJn1GzoPBttUeTFyiVjJwM4dKwfpEPEo=;
        b=mvYu7vM1Q1YA7K9XknXf3YIk4B6Fhd7zAbtQD9KvjHNmFoNGI+/Vj3fimFen/bMr0R
         EYAfPr2m/AvQ7LqKmYJPaiytnF0ZQiG3MfoM7dvpaJDI53/oDbrf+EmyjI6Z5n2brPkP
         FtnEfWIUI9PU/kAvrRkb5AHF71J1kWJCNrFyLbW+71zNvTS/jqedV6t717DxI0OMKZ3y
         7Y2EK5BHbarCY1NyZZs5e4HFdrHZqV6b4AeG0X6ZsKiV3rmzdn2Q5t3ZP2mY2LxVmHJE
         Oose971hEeBARn7jGM7qqnufgnPcp32eaj8j9X/PdfRQPt/8qFSn2ZFTz6lBWcCYfWJn
         DCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718268384; x=1718873184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNrMBohAlmbgJn1GzoPBttUeTFyiVjJwM4dKwfpEPEo=;
        b=J7OJgcJitGkRlFm1PeogB/FdubnJW3nT8bI0Bdvf7pJ1bmwO1eMBjMRZ8nRqL8IlIj
         nD6loeRMtrg1xLNSUqJ+Qt1ywbktYbttaLBXUwdPekQUSmUWwfn5QZtVDUSuUEwnmIHm
         B0v1vEMsKqFZnBDh9dmR0vLx2Im1AmLq6ucEy/0pAx0px8B2QDu1i6B2ALZ1g9OXMHUB
         M9Wg0hHq6a6qr23laKIRMKFx9xYCHXAvK/bi51VgcgXSbGElcMnjxP4mTMyU39jdqCCU
         3dPS0WcNvhuQlHaYRqqE0AW2za6cTGaxmyC6t9v1FpQpRz5J1hvSKAySOQOxZSEySNXu
         a1wA==
X-Forwarded-Encrypted: i=1; AJvYcCU3AUxwR18LgvXqb3yDF3Lk2V5S7cXlIZVteC8N7VEFQJsWGeQrsakPGCG2H+NQYGXu3T6PDU/6J0tZYFZM7fYkBFId9dtTV7C+Xpkg
X-Gm-Message-State: AOJu0YyAnyxbGDpzLu0n8EZzRHK2m1e003T4uBykg7AzloLAbh1WzTB+
	AOGbskhZqZAFQ22GuCS+7/lqWbedPMEKnGZHtriYmoML7KoVYOCMIkUYNOP9/VvnZTa6hRZGqYo
	2mg523RKtuJS5IbPD9UNKRWROfbE=
X-Google-Smtp-Source: AGHT+IFEK+ug0/3N2rQ2IpnKhQO82VHIZlOazodcSIaMISCry/y0HSqCVg6aI6xdR52+yrmh0qpBfJL54MD+9pD6KJg=
X-Received: by 2002:a05:6122:361a:b0:4d4:21cc:5f4f with SMTP id
 71dfb90a1353d-4ed07bcd848mr3740162e0c.11.1718268383993; Thu, 13 Jun 2024
 01:46:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613000721.23093-1-21cnbao@gmail.com> <20240613000721.23093-4-21cnbao@gmail.com>
In-Reply-To: <20240613000721.23093-4-21cnbao@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 13 Jun 2024 20:46:13 +1200
Message-ID: <CAGsJ_4zx3Rp9ye=LFhzEN+JypAq1zb_gLQZgyiRvYJZTMpLCHA@mail.gmail.com>
Subject: Re: [PATCH RFC 3/3] mm: remove folio_test_anon(folio)==false path in __folio_add_anon_rmap()
To: david@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org
Cc: chrisl@kernel.org, linux-kernel@vger.kernel.org, mhocko@suse.com, 
	ryan.roberts@arm.com, baolin.wang@linux.alibaba.com, yosryahmed@google.com, 
	shy828301@gmail.com, surenb@google.com, v-songbaohua@oppo.com, 
	willy@infradead.org, ying.huang@intel.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 12:08=E2=80=AFPM Barry Song <21cnbao@gmail.com> wro=
te:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> The folio_test_anon(folio)=3D=3Dfalse case within do_swap_page() has been
> relocated to folio_add_new_anon_rmap(). Additionally, two other callers
> consistently pass anonymous folios.
>
> stack 1:
> remove_migration_pmd
>    -> folio_add_anon_rmap_pmd
>      -> __folio_add_anon_rmap
>
> stack 2:
> __split_huge_pmd_locked
>    -> folio_add_anon_rmap_ptes
>       -> __folio_add_anon_rmap
>
> __folio_add_anon_rmap() only needs to handle the cases
> folio_test_anon(folio)=3D=3Dtrue now.

My team reported a case where swapoff() is calling
folio_add_anon_rmap_pte *not* folio_add_anon_rmap_ptes
with one new anon  (!folio_test_anon(folio)).

I will double check all folio_add_anon_rmap_pte() cases.

>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  mm/rmap.c | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index e612d999811a..e84c706c8241 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1299,21 +1299,10 @@ static __always_inline void __folio_add_anon_rmap=
(struct folio *folio,
>
>         nr =3D __folio_add_rmap(folio, page, nr_pages, level, &nr_pmdmapp=
ed);
>
> -       if (unlikely(!folio_test_anon(folio))) {
> -               VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
> -               /*
> -                * For a PTE-mapped large folio, we only know that the si=
ngle
> -                * PTE is exclusive. Further, __folio_set_anon() might no=
t get
> -                * folio->index right when not given the address of the h=
ead
> -                * page.
> -                */
> -               VM_WARN_ON_FOLIO(folio_test_large(folio) &&
> -                                level !=3D RMAP_LEVEL_PMD, folio);
> -               __folio_set_anon(folio, vma, address,
> -                                !!(flags & RMAP_EXCLUSIVE));
> -       } else if (likely(!folio_test_ksm(folio))) {
> +       VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
> +
> +       if (likely(!folio_test_ksm(folio)))
>                 __page_check_anon_rmap(folio, page, vma, address);
> -       }
>
>         __folio_mod_stat(folio, nr, nr_pmdmapped);
>
> --
> 2.34.1
>

