Return-Path: <linux-kernel+bounces-217134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFEC90ABE4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 820061C22A0C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE8B1953AF;
	Mon, 17 Jun 2024 10:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4VFX6SS"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D2F1946D5
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 10:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718621040; cv=none; b=NpdCkyNW3vBHhqVgW7vwhJ19sFD2GolNTN5ytMSCCoLCwPVmjdfjark/8rFFGQWgyT6Ozr1rXkUY954+0+EYWqWzbOEqvYzBgZY7/ferrzfEHMcEANXt9XlcOSegoOOY2FX5+/VHHh2+TeKw/hnyaDwNdJtxEubGGw55pjT/owo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718621040; c=relaxed/simple;
	bh=lgIjOP5nWQRNHxugpzpf0zYbqXBsYfU94nJDit9pbzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jcUhUWNQ9K3Fk1VNgqqm1pfjXfo2aoNDTl/wSLTTtfDR2d44qq49yYoGq3+LpFtXsqvTrlzW/drsco459PPQwp2qaIZ04TKY8Xb19RRcX2rNaSf2eCrge+sLVYn6LduS+BnsBUgbEPeNx/WxohD5SFzubAPZe1VgQAYZDuKxMY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4VFX6SS; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-48baea0acfdso1327100137.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 03:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718621038; x=1719225838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4nLkqlsqvsKsWqeWur6tKtmzT9Q8xCH7R5hLwg3FSc=;
        b=d4VFX6SSiNlo3S3I9R38ZCtaJErcfp0NmcDVz95t2mdHhnISv50kxvKZYGob4Us7XR
         NRRhQvz/WSlhlibvo//3ql7pUOy0S2KP/pbQQpxM/t3r7MG9gnh5ykLJBxFspH/7GESc
         tGpwrhZn+YOLCW606ruJH5k1wxbYvS6HS5KodVf41jJpi9k7YlS4pyYBWTD2YISImuqD
         1FKl9ddjDtfSJmGtje6/cIrr4xKwQ81clLfFXzlcKCUjY7naoQTEsAfLS/YuIWBtSuaq
         GvkdeVPLNYKAVs+/9d6a3a+KHtmH3bZJ0PE1VbzmBEdaaCfJ8LDKUsetyves78MHLa+K
         6Q/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718621038; x=1719225838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4nLkqlsqvsKsWqeWur6tKtmzT9Q8xCH7R5hLwg3FSc=;
        b=gfxA4TsCa/matZZRtUddUAO/FSHfURfbqryc8bY/CwZZuJPnuwUEKTFtXJxrm6uL8y
         sT9OCETPiWoG10nlhTGF8F3xfhjkrCW4GaGHJnLrDZEnqitZYS+JlO3Ekzpuj2S7XAV1
         aVy+Zs2/LbS+I7pXn1JBMHoBTAFpkEOj3JabrBMhU9EnDW395gDRQ3Y2rb58vKMPq4q/
         lODN9wpHEZkv/jgAdcvBGHmMI/Xq9994nCoFFzPb2VEhLg/XTpt9Bo0UxniyLaQ4HCx6
         Mhz79f/ATA0VNksRHHOeoSyFVl78Og7Z6QVKjSLnUhsf3553zg1CJmmEO1L7+ucr8SYe
         TWPw==
X-Forwarded-Encrypted: i=1; AJvYcCXfeqce3PLW05/7nd7kVW2ME5/2RnxKWfl3R8PhEPeI7C9nEKNpSYRhHkDI/qZksIHabL2zpzj5KfSnEIn3tQqQbUoBj8hNzblIuMkk
X-Gm-Message-State: AOJu0Yx2ReoDTWs8UEK89QgTQjk+hl7zfQJIJcEKEEh7NIVAuO2Rcmqq
	r+LhNBlvE62+6yb6fBG1XZmOY7CgkeZGDlrCDPr59k7epMLITypkocm9s9sTnqaD+HJMAYHzOxh
	VjMjTupqpSJguyqCEdKPIsvYeu+q+CnSr708=
X-Google-Smtp-Source: AGHT+IH94ZfxSyz3r9dp5aCDfWRtBxC24cxXWsg1H700/hxN/YUb4p1hkU4K61N59jhQte6xW3NcDlk3+KA9Xq3w0CY=
X-Received: by 2002:a05:6102:3569:b0:48d:9fde:2b7 with SMTP id
 ada2fe7eead31-48dae3b4095mr10148163137.27.1718621037914; Mon, 17 Jun 2024
 03:43:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1717492460-19457-1-git-send-email-yangge1116@126.com>
 <c180d2a0-1e34-41f0-bae8-1205d04a5f6b@linux.alibaba.com> <82d31425-86d7-16fa-d09b-fcb203de0986@126.com>
 <7087d0af-93d8-4d49-94f4-dc846a4e2b98@linux.alibaba.com>
In-Reply-To: <7087d0af-93d8-4d49-94f4-dc846a4e2b98@linux.alibaba.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 17 Jun 2024 22:43:47 +1200
Message-ID: <CAGsJ_4xgqDrTsQRYB_VKn+KC6rvYeJF6TQwhT5JnLi-b4nFTOQ@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: skip THP-sized PCP list when allocating
 non-CMA THP-sized page
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: yangge1116 <yangge1116@126.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, liuzixing@hygon.cn, 
	Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 3:07=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2024/6/4 20:36, yangge1116 wrote:
> >
> >
> > =E5=9C=A8 2024/6/4 =E4=B8=8B=E5=8D=888:01, Baolin Wang =E5=86=99=E9=81=
=93:
> >> Cc Johannes, Zi and Vlastimil.
> >>
> >> On 2024/6/4 17:14, yangge1116@126.com wrote:
> >>> From: yangge <yangge1116@126.com>
> >>>
> >>> Since commit 5d0a661d808f ("mm/page_alloc: use only one PCP list for
> >>> THP-sized allocations") no longer differentiates the migration type
> >>> of pages in THP-sized PCP list, it's possible to get a CMA page from
> >>> the list, in some cases, it's not acceptable, for example, allocating
> >>> a non-CMA page with PF_MEMALLOC_PIN flag returns a CMA page.
> >>>
> >>> The patch forbids allocating non-CMA THP-sized page from THP-sized
> >>> PCP list to avoid the issue above.
> >>>
> >>> Fixes: 5d0a661d808f ("mm/page_alloc: use only one PCP list for
> >>> THP-sized allocations")
> >>> Signed-off-by: yangge <yangge1116@126.com>
> >>> ---
> >>>   mm/page_alloc.c | 10 ++++++++++
> >>>   1 file changed, 10 insertions(+)
> >>>
> >>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >>> index 2e22ce5..0bdf471 100644
> >>> --- a/mm/page_alloc.c
> >>> +++ b/mm/page_alloc.c
> >>> @@ -2987,10 +2987,20 @@ struct page *rmqueue(struct zone
> >>> *preferred_zone,
> >>>       WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
> >>>       if (likely(pcp_allowed_order(order))) {
> >>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >>> +        if (!IS_ENABLED(CONFIG_CMA) || alloc_flags & ALLOC_CMA ||
> >>> +                        order !=3D HPAGE_PMD_ORDER) {
> >>
> >> Seems you will also miss the non-CMA THP from the PCP, so I wonder if
> >> we can add a migratetype comparison in __rmqueue_pcplist(), and if
> >> it's not suitable, then fallback to buddy?
> >
> > Yes, we may miss some non-CMA THPs in the PCP. But, if add a migratetyp=
e
> > comparison in __rmqueue_pcplist(), we may need to compare many times
> > because of pcp batch.
>
> I mean we can only compare once, focusing on CMA pages.
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3734fe7e67c0..960a3b5744d8 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2973,6 +2973,11 @@ struct page *__rmqueue_pcplist(struct zone *zone,
> unsigned int order,
>                  }
>
>                  page =3D list_first_entry(list, struct page, pcp_list);
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +               if (order =3D=3D HPAGE_PMD_ORDER &&
> !is_migrate_movable(migratetype) &&
> +                   is_migrate_cma(get_pageblock_migratetype(page)))
> +                       return NULL;
> +#endif

This doesn't seem ideal either. It's possible that the PCP still has many
non-CMA folios, but due to bad luck, the first entry is "always" CMA.
In this case,
allocations with is_migrate_movable(migratetype) =3D=3D false will always l=
ose the
chance to use the PCP.   It also appears to incur a PCP spin lock/unlock.

I don't see an ideal solution unless we bring back the CMA PCP :-)

>                  list_del(&page->pcp_list);
>                  pcp->count -=3D 1 << order;
>          } while (check_new_pages(page, order));
>

