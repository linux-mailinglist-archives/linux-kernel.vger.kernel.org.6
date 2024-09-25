Return-Path: <linux-kernel+bounces-338112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE98985371
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DD4C281843
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807BE156230;
	Wed, 25 Sep 2024 07:13:23 +0000 (UTC)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A981C132103
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727248403; cv=none; b=H9b3JF4LYG1suNHvbDe20jWiC3qcNvPLsxS2PPuI2U/bz7giAAd/AfP+6po0oofClfpNs9jGVXDzFhIkNQ50p5mSqIHumOUPxjwmnNBhHTJ+iuPz4ZuTZvcORNWzX7o8qKs83rji0ZJgYTsg8ybvQaqORBnixHUQA5N98iNfb0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727248403; c=relaxed/simple;
	bh=NAouOXnfZSx4sClkkDoOdtA4ac+4xrPaRYKpROUMo+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FUPZ8bXz7rY6i8Os/IsRSptob5fWYA8MlsI6Rlg6uu8V8TU3A8Iy2DDApgRgRhAQ9SMgYm+AUhRoH+XeEzbTR6mX9mhyv4AJcTsosIs3ODp63N71v5Tyrb3azJWirR1OcQ2BmZ6A4qClbf87/VypfzVmIJzbNNzyEhpquvZE1ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e1d22ecf2a6so5606348276.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 00:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727248399; x=1727853199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDJSLZpTdOFJK8FF5XW8Cg7hT2svdYMIT7VTN1ViwOg=;
        b=Tk01FIT0FU5F+FTJRxuYSZ9pXItj39c8QyAAeNx9oGrx4YwtyaK2ey6++Kkptt0SuL
         mvN96J+5tfsFYZ9LmOLQ4jXH4iKldWgkyUxi4W3CwZYBcZ/ABQlITMeEidNlL+kMog3Q
         WywCjv27MnhIrWQ9FDBStFRxN3zqRUXEjL/McNXSuYytIXkIgySwTsdPhxVTCMxTvWp3
         BgyGy+ZCc4etxdxbaWqlQNElpWVHudKWldKRxfQmM+c/W1/efcfpam9y30X23jgJvVzD
         zYX2xcK/pyFUL7VduopJgi86Ad9OXlRcnKnCk1euKDaluI5UceYUGtIM6avqE1HJdN0w
         HI8A==
X-Forwarded-Encrypted: i=1; AJvYcCXwyndEb1sS+Iv7uSUbhSIVXKf3N7GrytP+g/o0B78sF07sXAlOXnhIusgpubJidnWDQ8HTlFikZJf6xGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YydUSK4uZlky5spkCRgjVpcYyoBxQBdruvLzs7NTXUWxZNJgJ1S
	IzLXmsxJLkGsnvpLV1faRl/ptyOMS5khNgRijYU2gnLkLicWv3w5F57dlRHj
X-Google-Smtp-Source: AGHT+IGKWg22xe4ydK1DTgM1HvWeKYUcrWXCcpBjO2p8suuwr0VJzj0RVcKRnGeYbZxBviknJh0mAA==
X-Received: by 2002:a05:690c:a98:b0:6d3:9129:575f with SMTP id 00721157ae682-6e21da62ba5mr14352547b3.38.1727248399049;
        Wed, 25 Sep 2024 00:13:19 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e20d06eb02sm5197297b3.70.2024.09.25.00.13.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 00:13:18 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6ddfdeed0c9so52455647b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 00:13:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUfYir3hXkjnL2jjp2ON/OHdpvIILJ+/HHFfR3Gvv61KoDsum6MGpZvQXNtKhgH8vQ5adQ4TO4MW3b+vNQ=@vger.kernel.org
X-Received: by 2002:a05:690c:112:b0:6e2:5a8:3447 with SMTP id
 00721157ae682-6e21d86342dmr15183337b3.26.1727248398167; Wed, 25 Sep 2024
 00:13:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924154205.1491376-1-linux@roeck-us.net>
In-Reply-To: <20240924154205.1491376-1-linux@roeck-us.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 25 Sep 2024 09:13:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVSGuMBjD8h4BQeaGYX1BUvNQTMQGZworX0EaHEpF-zng@mail.gmail.com>
Message-ID: <CAMuHMdVSGuMBjD8h4BQeaGYX1BUvNQTMQGZworX0EaHEpF-zng@mail.gmail.com>
Subject: Re: [PATCH v3] mm: Make SPLIT_PTE_PTLOCKS depend on SMP
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 5:42=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
> SPLIT_PTE_PTLOCKS depends on "NR_CPUS >=3D 4". Unfortunately, that evalua=
tes
> to true if there is no NR_CPUS configuration option. This results in
> CONFIG_SPLIT_PTE_PTLOCKS=3Dy for mac_defconfig. This in turn causes the m=
68k
> "q800" and "virt" machines to crash in qemu if debugging options are
> enabled.
>
> Making CONFIG_SPLIT_PTE_PTLOCKS dependent on the existence of NR_CPUS
> does not work since a dependency on the existence of a numeric Kconfig
> entry always evaluates to false. Example:
>
> config HAVE_NO_NR_CPUS
>        def_bool y
>        depends on !NR_CPUS
>
> After adding this to a Kconfig file, "make defconfig" includes:
> $ grep NR_CPUS .config
> CONFIG_NR_CPUS=3D64
> CONFIG_HAVE_NO_NR_CPUS=3Dy
>
> Defining NR_CPUS for m68k does not help either since many architectures
> define NR_CPUS only for SMP configurations.
>
> Make SPLIT_PTE_PTLOCKS depend on SMP instead to solve the problem.
>
> Fixes: 394290cba966 ("mm: turn USE_SPLIT_PTE_PTLOCKS / USE_SPLIT_PTE_PTLO=
CKS into Kconfig options")
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -595,6 +595,7 @@ config ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
>  config SPLIT_PTE_PTLOCKS
>         def_bool y
>         depends on MMU
> +       depends on SMP
>         depends on NR_CPUS >=3D 4

Nit: please combine these two lines, to make it clear they are related.

>         depends on !ARM || CPU_CACHE_VIPT
>         depends on !PARISC || PA20

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

