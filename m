Return-Path: <linux-kernel+bounces-301633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A4F95F370
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D033D1C21564
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4669214AD1A;
	Mon, 26 Aug 2024 14:01:29 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A14B372
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 14:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724680888; cv=none; b=BqVXxjaQXLIdaqQQWXmBvAskye2s8ZajNveF+T7w+1CYxM0WKGKoeq6wXOot5qtfCIrcZwzT+p/NsqKQ3U+JEBE8X9kD2wNRzR9S5NcX99QUVjunIrjGgVf7F7FrYeQQFeRCOKpb7fwZWdyoVM9Jh3NuVs5twsFll4fjmHgdhMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724680888; c=relaxed/simple;
	bh=dVGXJ8xfFvQwR9YQcBzFmT6g2qXYJnvyNtTiTEDBouU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0SWEss/vdo4PYuIGrrI1WOcTT1ekoCyB2bIU98zN2IinF37lBbK8p64vY8Io0JUeo/Gdl5NDUxpj7n5nAHIzcHxTs1RfJGR+Xfv6y+/5aXkSbWa4rwC34/4whSftYwJFeOncfcwESN/U3WSllWT5f8ODfzZqeufGrGLKM6bBwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6c91f9fb0d7so17586947b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 07:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724680884; x=1725285684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3+6+zszjG25uKB5YsPuXSVnLU6Olwn6W73A2LlZ3Hg=;
        b=qonUNBbcyP9VDlCxFsgkWHauxv+4saZ3lydUj6V2B/KVxkpI0b7JuDpjZSYM0ROpX1
         LyVYbc9Z6TfnjFR5ExgHRIYJ/IE9hCR73Ou+2okWrvy+0BKbgF9MGrtfQ2alPLyIpifc
         NGiS5ebV3eogP4thNPTQ38wqiFQ0mb9e9T7Ui/Tt4hQPmMpvsScefAwYIzJolI7haZ0W
         gwAjHnHa1a7Celc60S10SvO6V/azZDOhr/Z12nWzLKE/Z1oxfmh57yy7GnX4P4ak0p4F
         Od7zdN9MBIF59xMdVwg5BrTGA9sgYiEIywHWbsf3lCPthusLkzdkL8NBSX8oYpJBsrIy
         Dmhw==
X-Forwarded-Encrypted: i=1; AJvYcCXQulyZLQIO7isopsl6m+yal8Tt45yhLB9Dktw8gThDLDU4Q2vOUm1+glC6NkXtg9OyYWy0bdOHoUfXn4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdbc527zppH19sVeLXikMZnx1DUX5bZnzESzFkAWEwgVLPEuJL
	eFLklFUSJSF32foPAHjga7+RYPNOnKlqt3xo7EkP04dcND7dz4gGI40tebXa
X-Google-Smtp-Source: AGHT+IGFmL6P+upyyAXikm7dfoEGQKP0kMdycUVXCnxMB8bDKvyAKVpvapcqeBoTicAxMl+BiBXBvw==
X-Received: by 2002:a05:690c:60c4:b0:697:7cc0:ce1 with SMTP id 00721157ae682-6c62460327cmr142950467b3.7.1724680883963;
        Mon, 26 Aug 2024 07:01:23 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c399cb4f42sm15243507b3.22.2024.08.26.07.01.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 07:01:23 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6c0adbbf2eeso35203227b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 07:01:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUA1lYxQWRTKB1M9hh/TtOyksY0W9IT6N9PV8ZOav8mOWyuxeCfzJtcidyihYi6zoqAeF2IbMjjzEbrwks=@vger.kernel.org
X-Received: by 2002:a05:690c:f8c:b0:61a:e4ef:51d with SMTP id
 00721157ae682-6c6246037a6mr144593157b3.9.1724680882369; Mon, 26 Aug 2024
 07:01:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822192543.3359552-1-Liam.Howlett@oracle.com> <20240822192543.3359552-13-Liam.Howlett@oracle.com>
In-Reply-To: <20240822192543.3359552-13-Liam.Howlett@oracle.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Aug 2024 16:01:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW0HuK_26vejYL8nMwULwN8wFWS0-6HH69hOLuHzncwyA@mail.gmail.com>
Message-ID: <CAMuHMdW0HuK_26vejYL8nMwULwN8wFWS0-6HH69hOLuHzncwyA@mail.gmail.com>
Subject: Re: [PATCH v7 12/21] mm/vma: Track start and end for munmap in vma_munmap_struct
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, sidhartha.kumar@oracle.com, 
	Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Liam,

On Thu, Aug 22, 2024 at 9:27=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> Set the start and end address for munmap when the prev and next are
> gathered.  This is needed to avoid incorrect addresses being used during
> the vms_complete_munmap_vmas() function if the prev/next vma are
> expanded.
>
> Add a new helper vms_complete_pte_clear(), which is needed later and
> will avoid growing the argument list to unmap_region() beyond the 9 it
> already has.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks for your patch, which is now commit ca39aca8db2d78ff ("mm/vma:
track start and end for munmap in vma_munmap_struct") in next-20240826.

> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -38,6 +38,8 @@ struct vma_munmap_struct {
>         struct list_head *uf;           /* Userfaultfd list_head */
>         unsigned long start;            /* Aligned start addr (inclusive)=
 */
>         unsigned long end;              /* Aligned end addr (exclusive) *=
/
> +       unsigned long unmap_start;      /* Unmap PTE start */
> +       unsigned long unmap_end;        /* Unmap PTE end */
>         int vma_count;                  /* Number of vmas that will be re=
moved */
>         unsigned long nr_pages;         /* Number of pages being removed =
*/
>         unsigned long locked_vm;        /* Number of locked pages */
> @@ -108,6 +110,8 @@ static inline void init_vma_munmap(struct vma_munmap_=
struct *vms,
>         vms->vma_count =3D 0;
>         vms->nr_pages =3D vms->locked_vm =3D vms->nr_accounted =3D 0;
>         vms->exec_vm =3D vms->stack_vm =3D vms->data_vm =3D 0;
> +       vms->unmap_start =3D FIRST_USER_ADDRESS;
> +       vms->unmap_end =3D USER_PGTABLES_CEILING;

noreply@ellerman.id.au reported build failures for m5272c3_defconfig
http://kisskb.ellerman.id.au/kisskb/buildresult/15224802/

$ make ARCH=3Dm68k m5272c3_defconfig mm/filemap.o
In file included from mm/internal.h:22,
                 from mm/filemap.c:52:
mm/vma.h: In function =E2=80=98init_vma_munmap=E2=80=99:
mm/vma.h:113:21: error: =E2=80=98FIRST_USER_ADDRESS=E2=80=99 undeclared (fi=
rst use in
this function)
  113 |  vms->unmap_start =3D FIRST_USER_ADDRESS;
      |                     ^~~~~~~~~~~~~~~~~~
mm/vma.h:113:21: note: each undeclared identifier is reported only
once for each function it appears in
mm/vma.h:114:19: error: =E2=80=98USER_PGTABLES_CEILING=E2=80=99 undeclared =
(first use
in this function)
  114 |  vms->unmap_end =3D USER_PGTABLES_CEILING;
      |                   ^~~~~~~~~~~~~~~~~~~~~

Both are defined in include/linux/pgtable.h inside #ifdef CONFIG_MMU,
so they are not available on nommu.


>  }
>
>  int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

