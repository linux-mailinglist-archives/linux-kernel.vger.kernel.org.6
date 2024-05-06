Return-Path: <linux-kernel+bounces-170122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE508BD21A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 826C0B21968
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228B9155A4D;
	Mon,  6 May 2024 16:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLSNCUAP"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C3544C7C
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 16:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715011650; cv=none; b=d3CbdQiv57tTuKDE/p7uLtD7kDAReMxFEDEYEJKeg0HNOJICU/yTKO6tkv1Py4neM+JbdAFoCzEi2OldqJEtBqt2SgilNjjrID5slKT4L9HL1GpR/t31Zzdp8ApEA8aEOHZPG5I3G3lwRFxHBXlgL308fHcYBqWqaA2AnDcKkH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715011650; c=relaxed/simple;
	bh=Ff54ZvbDcerjWAa+AdrO8cLOqCKnvqp+iB+TgdAhk7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jOT0xD5Yhu3G+NFgJs8N2a1ipHGBWMLsAAOO8hFHMWb7DH7qa1HXIRxvfpPGtlUgsREqtIm5k/M9HmB/IJGfjHKP7/Ud5jGb4mVUNREZYhtCg2XNtXEj2Xy9EWGQaBtEoqm2QdYVyOe5rrhmeP3L/z2FSdh1ppvOX0+A0lA7qzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLSNCUAP; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51f4d2676d1so2314709e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 09:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715011647; x=1715616447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrl9wYenAkny/KczU5T4LBnOH/HfDi64n5pKG7uxGwQ=;
        b=hLSNCUAPh90Ie7lEMjprgjGDn9pB0savjc1S0+cgsbD4cKwh2C5kd5QJcbh6PSq+XH
         7PTZxZVYduBXatBNb3TXvny4zZmmIOc3vcIjP8dMZmUS7LwXqhFIUf+NMo5g6LeC705J
         eLEXeJTaShBVeAbDxxHqFOwvaldQjnkA052NICR5NR/rKQ8g7nDSYLsatpkIw8AIcJXY
         /Rbh7axSu4h0A019H5he4KUlzX6B+9KgfZ/Y/tMm4dpvUfIZ1ndQUQ5k2qecxPpQFFki
         TLRekQQjC838FFpUhePonQ5ilW+vhLmz8NUpf5M4cyjua1PzVTOgsFwHzFNWgtHxr+qV
         vwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715011647; x=1715616447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nrl9wYenAkny/KczU5T4LBnOH/HfDi64n5pKG7uxGwQ=;
        b=s3UjGZ7bRvwTkYNUNPpllP5qhhkdHFeoaNHbylwYB+iRCqdiLd9Zo11KHtu8RgdQuv
         MN+ybzYXRTuYhqnVBXzTbyUfrNcl8CKTx3iqkAPrwiXmSYH9/qusNCerNzIctJMylGfH
         R4/Ws0iHQ7P8ZfhVsM+w+jWrUZnmA8/sJ1q7fs76DsLbFYTCUx3w0y/Y8l9HiCgputQd
         j7EwmCDnYqBWgZCU9yDtLopqL7UF4jEuZO7sFQSrJcjm6u43aInYiG3xgFnLNr7enrSk
         ur9pFO2YzW0oNmYQapToRlP4nHa586joLwuwEcl1UPeVyqTcQb4rDDesw7syWINO19gl
         ClJg==
X-Forwarded-Encrypted: i=1; AJvYcCWFcGO44cdVEOhBtXU5eoMD1T1Cj2VEyaO8I2fIN0O5C2bDeR4IVPyslNi8G2RrP2pYacHBQ0Z+C8mzAotip3RD/5dBQsHX6gxBMelx
X-Gm-Message-State: AOJu0Yypjhhtz7m6ZiTmBJnBUYQoszUzWl+CYkikm/anFci2aWmkWj9+
	FNIXYDqGQhjkCdhaTcrDSlb4kpQIoemlifgiAECMG+ajkRZF6ioXmHRcXHN3kKhRbzHlpwWjtzC
	kQ3qWrCjBwHz7c5cNh/L4Oj2suVM=
X-Google-Smtp-Source: AGHT+IGgclVNVqb50qaplhEiNbTTu3K8A0EV3SULEDaW0g40sWnAdxIwfF2EEqRKcTm96OkrR4aESZGXESCCHHFlBzk=
X-Received: by 2002:ac2:562f:0:b0:516:a6ff:2467 with SMTP id
 b15-20020ac2562f000000b00516a6ff2467mr5858381lff.0.1715011646493; Mon, 06 May
 2024 09:07:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506155120.83105-1-libang.li@antgroup.com> <20240506155120.83105-6-libang.li@antgroup.com>
In-Reply-To: <20240506155120.83105-6-libang.li@antgroup.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 7 May 2024 00:07:14 +0800
Message-ID: <CAK1f24nX6mvLXiXNJUQWSKKUQ-Avhs0_NU1k8JBhVupOr3W6Mg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] mm: Add update_mmu_tlb_range()
To: Bang Li <libang.li@antgroup.com>
Cc: akpm@linux-foundation.org, chenhuacai@kernel.org, 
	tsbogend@alpha.franken.de, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	chris@zankel.net, jcmvbkbc@gmail.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, loongarch@lists.linux.dev, 
	linux-riscv@lists.infradead.org, david@redhat.com, ryan.roberts@arm.com, 
	libang.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 11:52=E2=80=AFPM Bang Li <libang.li@antgroup.com> wr=
ote:
>
> After the commit 19eaf44954df ("mm: thp: support allocation of anonymous
> multi-size THP"), it may need to batch update tlb of an address range
> through the update_mmu_tlb function. We can simplify this operation by
> adding the update_mmu_tlb_range function, which may also reduce the
> execution of some unnecessary code in some architectures.
>
> Signed-off-by: Bang Li <libang.li@antgroup.com>
> ---
>  include/linux/pgtable.h | 8 ++++++++
>  mm/memory.c             | 4 +---
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 18019f037bae..869bfe6054f1 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -737,6 +737,14 @@ static inline void update_mmu_tlb(struct vm_area_str=
uct *vma,
>  #define __HAVE_ARCH_UPDATE_MMU_TLB
>  #endif
>
> +#ifndef __HAVE_ARCH_UPDATE_MMU_TLB_RANGE

IIRC, the contemporary practice is to define a macro with the same name
as the function if it is being overridden.

Thanks,
Lance

> +static inline void update_mmu_tlb_range(struct vm_area_struct *vma,
> +                               unsigned long address, pte_t *ptep, unsig=
ned int nr)
> +{
> +}
> +#define __HAVE_ARCH_UPDATE_MMU_TLB_RANGE
> +#endif
> +
>  /*
>   * Some architectures may be able to avoid expensive synchronization
>   * primitives when modifications are made to PTE's which are already
> diff --git a/mm/memory.c b/mm/memory.c
> index eea6e4984eae..2d53e29cf76e 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4421,7 +4421,6 @@ static vm_fault_t do_anonymous_page(struct vm_fault=
 *vmf)
>         vm_fault_t ret =3D 0;
>         int nr_pages =3D 1;
>         pte_t entry;
> -       int i;
>
>         /* File mapping without ->vm_ops ? */
>         if (vma->vm_flags & VM_SHARED)
> @@ -4491,8 +4490,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault=
 *vmf)
>                 update_mmu_tlb(vma, addr, vmf->pte);
>                 goto release;
>         } else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
> -               for (i =3D 0; i < nr_pages; i++)
> -                       update_mmu_tlb(vma, addr + PAGE_SIZE * i, vmf->pt=
e + i);
> +               update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
>                 goto release;
>         }
>
> --
> 2.19.1.6.gb485710b
>

