Return-Path: <linux-kernel+bounces-362025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EE199B00F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 04:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9548EB21918
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 02:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D558912E7E;
	Sat, 12 Oct 2024 02:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+CAB8VO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7FDD531
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 02:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728699480; cv=none; b=JPCY9sqtb1MxI4HFWq2gdU1fY4gClxuVK0JTFgKk/NgbS6WMWPXd/k+jmeyj/aJMakvXkSgNspfrLzkSjp3L+YUF1Cw37uQTXYdBmOyWrCZvSYRUNVOZkzvUGp39hVcebGUGIY3mdd8e8z1cG+vXZxoxf56iq3EcELFe7r3jFZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728699480; c=relaxed/simple;
	bh=cbwIdPMTkXJZaw/g0jqTBZNpsKABLtmQqfxIXVFHsJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gcufpGFFFdkLwlju4HVtJMOXMaxHE4OR+K1BQ5ONH7mKs9afyTl8/HB+l/hhu96W4E1Dlewpy8EgXHiTxjoFSxKIwvMK+qVCcl6521kPctVJg6IYsVHQMaGxqcZhPl2tICEwfuxHTL2WeF/zNtFhNintFR3dSmfBDeuhchDWbqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+CAB8VO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A474C4CECF
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 02:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728699480;
	bh=cbwIdPMTkXJZaw/g0jqTBZNpsKABLtmQqfxIXVFHsJQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h+CAB8VOhTj/A/uouG8pFg2yoaPfGdL86TfFLKIn5o+zpGlutbFmH5QlkIZwn7CCm
	 XLtTadvsKM9dgCLQjY+wdWDxlfmV0HtUQQTZsecgY6CyHC5fFwGIJe+xNadJMq3mVm
	 XVeq5ILYQz1G/mQL0u0gIZOTj/RAjo6xy/JHWYrlwKnJpekRYfV5hhIw9RFhBnF7RL
	 CgKCDifS6g4Ho5zT9N6riuvlVuErYTFCL0EXxvIqExFajnQp5jlAQTB0mzhhOlBKTv
	 Z/6hMXkRDI3BG85qZ6MXQ2+gQV6TcwptN0TPdOcxQyuEdgLglDDDzf7C0BLop7uNky
	 IUfZSdTiDxetw==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9963e47b69so387373266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 19:18:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXP1AHY3me4yHQGljSSFENqMhAx9psZfQr8nAKhpV1F+yX1KqKX17Hof+bN0feNj++kcz2YKn5LiSPDPYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf39ba/Kc540GRONpf09cWwvY0jWUrln7Pdr/EAEs3QI8LrA07
	HFgy/w6rfuwulj+THJM8XrFh5Ie/z4cahsXFTgqPndfxKMpU/wsmnk6LpDdAvoVEnyp2zYRt3J6
	qpuYpQwFi9Xhu7xvUT0mV8UYM2Pk=
X-Google-Smtp-Source: AGHT+IFmjZGdy3AhXsSg3wBPqtzohdmOoU3lQFAGI8tv8oev4/YMxBqqtH+JJ8oRd4VKSyAVjJtvHkcEEzudybO5HHs=
X-Received: by 2002:a17:906:6a12:b0:a99:742c:5c7 with SMTP id
 a640c23a62f3a-a99b9305ed1mr326220766b.10.1728699478702; Fri, 11 Oct 2024
 19:17:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010035048.3422527-1-maobibo@loongson.cn> <20241010035048.3422527-3-maobibo@loongson.cn>
In-Reply-To: <20241010035048.3422527-3-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 12 Oct 2024 10:17:46 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6-m6PhD49X3UyHYhCggAruf=5g9zh=6FvNc5004Z5New@mail.gmail.com>
Message-ID: <CAAhV-H6-m6PhD49X3UyHYhCggAruf=5g9zh=6FvNc5004Z5New@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm/sparse-vmemmap: set pte_init when vmemmap is created
To: Bibo Mao <maobibo@loongson.cn>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Barry Song <baohua@kernel.org>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

Just declare kernel_pte_init() in header file. Since this series is a
bugfix, we should merge it as soon as possible. The refactoring patch
can be sent after this series.

Huacai

On Thu, Oct 10, 2024 at 11:50=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wro=
te:
>
> Like pmd_init(), a weak function kernel_pte_init() is added and it
> is only effective on LoongArch system. When pte table is created for
> vmemmap kernel space, function kernel_pte_init() is called here.
>
> It has no any effective on other architectures.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  mm/sparse-vmemmap.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index edcc7a6b0f6f..c0388b2e959d 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -184,6 +184,10 @@ static void * __meminit vmemmap_alloc_block_zero(uns=
igned long size, int node)
>         return p;
>  }
>
> +void __weak __meminit kernel_pte_init(void *addr)
> +{
> +}
> +
>  pmd_t * __meminit vmemmap_pmd_populate(pud_t *pud, unsigned long addr, i=
nt node)
>  {
>         pmd_t *pmd =3D pmd_offset(pud, addr);
> @@ -191,6 +195,7 @@ pmd_t * __meminit vmemmap_pmd_populate(pud_t *pud, un=
signed long addr, int node)
>                 void *p =3D vmemmap_alloc_block_zero(PAGE_SIZE, node);
>                 if (!p)
>                         return NULL;
> +               kernel_pte_init(p);
>                 pmd_populate_kernel(&init_mm, pmd, p);
>         }
>         return pmd;
> --
> 2.39.3
>

