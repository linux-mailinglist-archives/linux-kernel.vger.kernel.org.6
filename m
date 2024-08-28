Return-Path: <linux-kernel+bounces-305635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEAD963182
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 22:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C157A1C219CC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40931ABECB;
	Wed, 28 Aug 2024 20:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2fdSESp"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FC013775E
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 20:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724876045; cv=none; b=S7Q0Ylh+1x7wE/3PdPTVyQhCCzX5yPFARLtrs/vM1Hpk2PXzm8fgiucCiiugFcR46rybL+PFILxsruFCdF7e2WSC1J5pd2DlMMGpoFAvjEYdfr3VTPTND3L4xw5wFNJ0tZ2b4K62I+fNfHRD7tYbarGFf4W+Et9KA7At/4hvafw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724876045; c=relaxed/simple;
	bh=Y06yZnkUUBwT+omJd7ueaRipWdu6BJ1uHApBmv8158g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QY0e+0P6q6NtgXcWF03okYNCrtBTqpJxx5s3W0/jpGmrmKVLOV8jNz83m+V3trQBwDdjAcpMNf0/CX871TjtdiiqJeHInHrCcgXAgxKnPuu5R9yevVZSJcwlSRFAexuKkM0xQ3XwZP+oDgBSb0uL7xZIerlchZp5X6mC91nx3zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2fdSESp; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37496a92188so745425f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 13:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724876042; x=1725480842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDhRF3a1TWvDvUzGxnSYhDAvIHT22WKK+VnaRoNWpX8=;
        b=g2fdSESp48E7n+qo5K/9n1cCmtE93w3KEzFlYr0pEYCy/3oRubhcauDhuXvQLgJBfW
         V38klCDrkxNED3kEugQj/Mh0QiJ3PBoR+DZt0/DwTFC6AU8Lza9OmuujB1rfuAYyi0s2
         xLOtjqbuEfqpflTH20DTrL71u3oisHwkd2ilJO3GsiEpBMLb9cw7DIsxJPzkEL5TTMsF
         jqAnkuV3vGdRQD1cfewmlVmVLddKhLTvcjDMoAgLEGAdjAPXNqpcTUAuGzuBMrWbKst2
         xk/FkelomhcYcmPFfKRlMSktaNbziRaZCZfX7ZnHNYiISBC5zhPdyissRJ8EvXhXaBf/
         dH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724876042; x=1725480842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDhRF3a1TWvDvUzGxnSYhDAvIHT22WKK+VnaRoNWpX8=;
        b=oqm9GzPKVh4IiAA8QWmDqXlRR3OFoXU6e1P3om3uog4KtCqNxSPvvN3Go87CPcmjSe
         Ga7PFGXEvrbxVJWzsGQsCZArFC9VY5muBqKvUi8kV2sLw3/com3Q04GOtG1cLQ3ZUBda
         Cli2WBVTKXnGImzi95Nj0uJURC2vMZmnhpOPu9l4u5CtAcCqKO9hEp1iwW/911MhZDhE
         08IlFU6yV6IsXL2eUQu/ovjWkVFEm9ZD00M4N6+DIyOWAocsVs5D8phzvr91sQZmcbuH
         nOs69IkQBtmgL609OsqYxIMP0ui6HBYHuMY0Bc7JWx+OUSUSHpG4rCdxGJSlEEq1hDiW
         3IkA==
X-Forwarded-Encrypted: i=1; AJvYcCW2QtcD7ZZYyagdp/pz1QBtbtqJ/JWEXzGWZVytnB6JX9Swdj/bey44LqF5YzJ25MpsQrN6UxRVv/kbF6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwnGU4XUWO/Rcs93N3DVKds2CpRNrncu45MlYAOxY/BYyRKrPo
	xzmDQSRFwLSn5rl9hX0NFCPCeM9ETPYtbvzJd1dA1rVAUVJRXqoJ9o4Wf6vkN3iWoZJ+9p4sXrr
	4M2+gStmjZSlxBxCvJiTITX6APEc=
X-Google-Smtp-Source: AGHT+IG2/4LLqNcmPGBSp3apsRIuJxUkG7hn1rGxzpIJ00o3ezT5tylYduiNcb2XIGOnNfejSpwmPdt+N/acB+CmPWM=
X-Received: by 2002:a5d:6606:0:b0:371:8ed7:49e9 with SMTP id
 ffacd0b85a97d-3749b548f9fmr431328f8f.26.1724876041552; Wed, 28 Aug 2024
 13:14:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828160704.1425767-1-mjguzik@gmail.com> <20240828124929.db332259c2afad1e9e545b1f@linux-foundation.org>
In-Reply-To: <20240828124929.db332259c2afad1e9e545b1f@linux-foundation.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 28 Aug 2024 22:13:49 +0200
Message-ID: <CAGudoHE73o5oK77iOFKqH4D4Cz6t9TAu4882+_F9vHH7muNH-A@mail.gmail.com>
Subject: Re: [PATCH] mm/hugetlb: sort out global lock annotations
To: Andrew Morton <akpm@linux-foundation.org>
Cc: muchun.song@linux.dev, dave@stgolabs.net, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 9:49=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed, 28 Aug 2024 18:07:04 +0200 Mateusz Guzik <mjguzik@gmail.com> wrot=
e:
>
> > The mutex array pointer shares a cacheline with the spinlock:
> > ffffffff84187480 B hugetlb_fault_mutex_table
> > ffffffff84187488 B hugetlb_lock
>
> Fair enough.  My x86_64 defconfig now has
>
> num_fault_mutexes:
>         .zero   4
>         .globl  hugetlb_lock
>         .section        .data..cacheline_aligned,"aw"
>         .align 64
>         .type   hugetlb_lock, @object
>         .size   hugetlb_lock, 4
> hugetlb_lock:
>         .zero   4
>         .section        .init.data
>         .align 32
>         .type   default_hugepages_in_node, @object
>         .size   default_hugepages_in_node, 256
> default_hugepages_in_node:
>         .zero   256
>         .type   parsed_default_hugepagesz, @object
>         .size   parsed_default_hugepagesz, 1
>
> which looks good.
>
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -72,14 +72,14 @@ static unsigned int default_hugepages_in_node[MAX_N=
UMNODES] __initdata;
> >   * Protects updates to hugepage_freelists, hugepage_activelist, nr_hug=
e_pages,
> >   * free_huge_pages, and surplus_huge_pages.
> >   */
> > -DEFINE_SPINLOCK(hugetlb_lock);
> > +__cacheline_aligned_in_smp DEFINE_SPINLOCK(hugetlb_lock);
> >
> >  /*
> >   * Serializes faults on the same logical page.  This is used to
> >   * prevent spurious OOMs when the hugepage pool is fully utilized.
> >   */
> > -static int num_fault_mutexes;
> > -struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
> > +static __ro_after_init int num_fault_mutexes;
> > +__ro_after_init struct mutex *hugetlb_fault_mutex_table;
>
> It's conventional (within MM, at least) to put the section thing at the
> end of the definition, so tweak:
>
> --- a/mm/hugetlb.c~mm-hugetlb-sort-out-global-lock-annotations-fix
> +++ a/mm/hugetlb.c
> @@ -72,14 +72,14 @@ static unsigned int default_hugepages_in
>   * Protects updates to hugepage_freelists, hugepage_activelist, nr_huge_=
pages,
>   * free_huge_pages, and surplus_huge_pages.
>   */
> -__cacheline_aligned_in_smp DEFINE_SPINLOCK(hugetlb_lock);
> +DEFINE_SPINLOCK(hugetlb_lock) __cacheline_aligned_in_smp;
>

I tried things in this order and this does not compile for me:
In file included from ./arch/x86/include/asm/current.h:10,
                 from ./arch/x86/include/asm/preempt.h:7,
                 from ./include/linux/preempt.h:79,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/mm.h:7,
                 from mm/hugetlb.c:8:
./include/linux/cache.h:80:3: error: expected =E2=80=98,=E2=80=99 or =E2=80=
=98;=E2=80=99 before =E2=80=98__attribute__=E2=80=99
   80 |   __attribute__((__aligned__(SMP_CACHE_BYTES),                  \
      |   ^~~~~~~~~~~~~
./include/linux/cache.h:86:36: note: in expansion of macro =E2=80=98__cache=
line_aligned=E2=80=99
   86 | #define __cacheline_aligned_in_smp __cacheline_aligned
      |                                    ^~~~~~~~~~~~~~~~~~~
mm/hugetlb.c:75:31: note: in expansion of macro =E2=80=98__cacheline_aligne=
d_in_smp=E2=80=99
   75 | DEFINE_SPINLOCK(hugetlb_lock) __cacheline_aligned_in_smp;
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~

I'm at next-20240828 with gcc 13.2.0

>  /*
>   * Serializes faults on the same logical page.  This is used to
>   * prevent spurious OOMs when the hugepage pool is fully utilized.
>   */
> -static __ro_after_init int num_fault_mutexes;
> -__ro_after_init struct mutex *hugetlb_fault_mutex_table;
> +static int num_fault_mutexes __ro_after_init;
> +struct mutex *hugetlb_fault_mutex_table __ro_after_init;
>
>  /* Forward declaration */
>  static int hugetlb_acct_memory(struct hstate *h, long delta);
> _
>
>


--=20
Mateusz Guzik <mjguzik gmail.com>

