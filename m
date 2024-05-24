Return-Path: <linux-kernel+bounces-188275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3D88CDFF1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 05:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D522837FB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 03:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC5D2E622;
	Fri, 24 May 2024 03:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkQLW85K"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E7A1C17
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 03:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716522856; cv=none; b=Csmk5OzyRrhubE952uWSkXlsB6Tcjr78UlFmJi1QcvbcMjKVYDUbHuWhj31Fo/uGQnWjF6CjCRk61EvyW7gpHh/Au1PCq7eBlGz1wUuaYHh5DpCbn4jCPkV5q79xtZckVgC/JOnZ7JAXI4plJxTtRGF7vEeLaufI22z+K21q8fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716522856; c=relaxed/simple;
	bh=K99KUrVlDSGTuaBU0qLuO5KhBt6w+TaptshsCpmiKfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OQMrY97mo8trbwYobUhmnJtI5j5JPEw62lP1zUlZnxDf5nXN9ZE2p0bxhft0Fa69G95hB63bCjAxAb6MOVmkPkDtiOy/ygm8IegQCkNeBYXXt4bgJAyW69RuB6KTp4sknb3GviRBtS9zIhHyU4DCUgB+JkKyAeggjaYvmET54rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkQLW85K; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-578517cab9eso438451a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 20:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716522853; x=1717127653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWW3AQa8TPc9MawrkKffK2j0szmcKvitO1soT+4auc0=;
        b=PkQLW85KmbVuaxY9AX/KwWcvxeb+WJgJPRi9ruULOCQl2LtpFRBMe+gGHSzQJujl46
         PWdEognNXog/rkKop/V38vuewn9BBz4HRZoRdbHYfV2lvT1GlTsGbS+FVwly3OfC1Ge4
         4CCvrg6q1JAcqWwCLNtakFJN0yVkDUApAJOO33KzPo4AvVn71CUcxH19zE/R2c72ChH1
         cBasIR06PFm9FAmP0KrSBuyENx8yJ5SU/EVALqCuJHIKfUzqSRr8qwsrb9tDyeOoMWK9
         3XiHlAkHcl9OTdXe1qC8dzQ3TSGwCKylXXLb1elK1O57jhG3CSej7/PNRpc3/ic9i8na
         U00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716522853; x=1717127653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWW3AQa8TPc9MawrkKffK2j0szmcKvitO1soT+4auc0=;
        b=iW1HdSqakkEmCzjvFEKEo/F9SjSf6ba3T1KsVwglw2yd3O2UbQebnBpHNJd5bOVccv
         T/WwK26mpgt5BW+n4tLw/kIgpd46Z4Dg5YGx7ANSDlJACI7j1gdjDPuZtkT8gYzKfvdA
         KAwT4rTlOHQyr2CbsMN3Xsbvxdr9BCm9aZiLnL6TmLi+dDHnSu9xFhU9iVGrN0H0inBJ
         6QLsoSM/GrhCkVrLZ0gJMM/0ZOtCgxzcJqL3/GV2nEf/Fyki6pWmsjSMQX00GUBy8uwF
         N7bdcoQn35fT9YHglvNC02wbsQDPcDmePwmpQhEjmWxWwV93WaX8JF1ZWhdLQjWVNPGw
         qxCA==
X-Forwarded-Encrypted: i=1; AJvYcCU0h/2pUOzwcIlY0xEm03CILbRjGF6W6+RpKN8WBtdKlzmBBim1p2JGl7RAPH/E41ZsUS/su1N4uFTTJB5Nd7xKRNvya9y7zWcvjN37
X-Gm-Message-State: AOJu0Yz2bfGFRnHE2BOdkGZoJdURgGo3dLs/4+moLJMGAO62HhxPcLn2
	y8z7Yu85/gTvTZeyzNZEW3Zv/qtapdDp1DGq7h6ZKBCPEOruxn8TbX3RyJhtq6w9bagcQ918ZfL
	PuW4js0F94k6DCvJ/pQj8K+7YAAE=
X-Google-Smtp-Source: AGHT+IGm8NBKfc/0PfmmWPj5Rz0Bs+ulDT4bDs5xol5Uuy0q/JDIXHIkkcYMZ0MH/xgLyuJy0C3yELiKVk9Ie4Hc154=
X-Received: by 2002:a50:9557:0:b0:56e:7751:ae4e with SMTP id
 4fb4d7f45d1cf-57851a5c3bdmr544568a12.33.1716522853140; Thu, 23 May 2024
 20:54:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524005444.135417-1-21cnbao@gmail.com>
In-Reply-To: <20240524005444.135417-1-21cnbao@gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 24 May 2024 11:54:01 +0800
Message-ID: <CAK1f24kfV0wHVFTmp7YdWMRB8jzncHTiM91kTn9dBtgfnqwdYQ@mail.gmail.com>
Subject: Re: [PATCH] mm: arm64: Fix the out-of-bounds issue in contpte_clear_young_dirty_ptes
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	David Hildenbrand <david@redhat.com>, Jeff Xie <xiehuan09@gmail.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Michal Hocko <mhocko@suse.com>, 
	Minchan Kim <minchan@kernel.org>, Muchun Song <songmuchun@bytedance.com>, 
	Peter Xu <peterx@redhat.com>, Yang Shi <shy828301@gmail.com>, 
	Yin Fengwei <fengwei.yin@intel.com>, "Zach O'Keefe" <zokeefe@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks a lot for reaching out, Barry!

On Fri, May 24, 2024 at 8:55=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> We are passing a huge nr to __clear_young_dirty_ptes() right
> now. While we should pass the number of pages, we are actually

Yes.

It's my mistake - sorry :(

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

LGTM.

Acked-by: Lance Yang <ioworker0@gmail.com>

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

