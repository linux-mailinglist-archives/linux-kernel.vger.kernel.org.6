Return-Path: <linux-kernel+bounces-308291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7449659DD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F412B23222
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4AB16DC26;
	Fri, 30 Aug 2024 08:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERpoDkUg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0A416D9B8
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725005707; cv=none; b=ojVd3aawEPRBk55WTLsPvg9zEgXGfSpJm5tOW72gTLhie40iMpAvcWWzv1/p+zJ59S2Xk/xm0yu++qeOSNfp12bkSMXp0DVCqggfwHDZ897pEHvrGzuAFechn78nj+HBWIz56zWmi1McYDiDyDSQq834uz9L+aV4AtUpW9p24FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725005707; c=relaxed/simple;
	bh=qPF+SE/ZS1bZ4RP2qS5zH7GzisZUNjOOKL3u+ENBFgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NtUBOryAhQW3Af0Gi/ZSP5texbSxj8aJGqvo7PQJW3z7EGs2lQZmmVibrHJVhBtbSpACKgYyVGm7PIDSUX6L6jAtd0Dn+64uZdpr+OfPwC5SvIfztfFHDzaDDkQfSiLaqcFGdy2xIaQNOgbVFsa/KBang+MK87NnE+3NkwKeRXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERpoDkUg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB74C4AF0C
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725005707;
	bh=qPF+SE/ZS1bZ4RP2qS5zH7GzisZUNjOOKL3u+ENBFgo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ERpoDkUgCz9ox9sNSKkuN45U5mLTlL0lHdrgjx9gntxlpQOCWHKAh+z3pQcYp8uKT
	 9fZKmA4j3T50CLUhRbGXWdNjKY4kTZZizmq/LjVpNJ0R2e19TBAf1+5vEoDnPEsZt7
	 caAhYG+UPoVTgV/PJmD2KXuFkCHGu7EQM3Qoylzy6GyFr0LsFbk5u7LLpUvbH0HlBp
	 4PhehkEzC233hC47kNsQljeEIEa/Iax24YihguvQqEH08581CY7k5bSoVXrXntqfCy
	 dNs+tVZqmC9IrpWExadPNyMgq8hL9Zx/4x76lTK0yfdd3NqMPAfXgpDFnxaHQh1XSx
	 89sJiyXzAMaeA==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f401c20b56so22500491fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 01:15:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFEEbbk2ifeoT71KyxT3SptqvJYtbVrr13h9l7q4b1876vrPG9SYgOybheeqnjYFnNP/9X5jw0fZNsU2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe41gpbSoxppovcNBXlb60l6074tBw8WqJkHn2hm090lM5bQtC
	p0Edif55Ff/1Exs9EtT/FqNXyDyfynM9jfTR8A7zE7qAQI/z1F53fJLWQnvrfB43cQoHUFk0xh6
	HJQbsvf4AeyDlVwcHfUBxsvQ55no=
X-Google-Smtp-Source: AGHT+IGaoNywe2WLkPQn2rHBMQhYNNd3kvikRfVNi9+Laag9UZfnfSzA2+5RrriZvtP5GexEVNoHLdQAEhAeD9PIpZg=
X-Received: by 2002:a05:6512:1396:b0:533:426a:d52f with SMTP id
 2adb3069b0e04-5353ebafce7mr2008067e87.11.1725005705524; Fri, 30 Aug 2024
 01:15:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830080020.33666-1-rongqianfeng@vivo.com>
In-Reply-To: <20240830080020.33666-1-rongqianfeng@vivo.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 30 Aug 2024 10:14:54 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGhiz5SHxABi5UwZvd_Lx-EpvfQ2_isPu-X7jmi3dogdg@mail.gmail.com>
Message-ID: <CAMj1kXGhiz5SHxABi5UwZvd_Lx-EpvfQ2_isPu-X7jmi3dogdg@mail.gmail.com>
Subject: Re: [PATCH] arm64/mm: Delete __init region from memblock.reserved
To: Rong Qianfeng <rongqianfeng@vivo.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Petr Tesarik <ptesarik@suse.com>, Baruch Siach <baruch@tkos.co.il>, 
	"Mike Rapoport (IBM)" <rppt@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"

Hi Rong,

On Fri, 30 Aug 2024 at 10:00, Rong Qianfeng <rongqianfeng@vivo.com> wrote:
>
> If CONFIG_ARCH_KEEP_MEMBLOCK is enabled, the memory information in
> memblock will be retained. We release the __init memory here, and
> we should also delete the corresponding region in memblock.reserved.
>
> Signed-off-by: Rong Qianfeng <rongqianfeng@vivo.com>
> ---
>  arch/arm64/mm/init.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index bfb10969cbf0..99cfa217e905 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -402,6 +402,13 @@ void __init mem_init(void)
>
>  void free_initmem(void)
>  {
> +       if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {

This is always true on arm64

> +               unsigned long aligned_begin = ALIGN_DOWN((u64)__init_begin, PAGE_SIZE);
> +               unsigned long aligned_end = ALIGN((u64)__init_end, PAGE_SIZE);
> +
> +               memblock_free((void *)aligned_begin, aligned_end - aligned_begin);
> +       }
> +

What does this achieve? The memory is already being reused by the page
allocator (due to free_reserved_area()), and the memblock allocator is
no longer usable at this point anyway.

>         free_reserved_area(lm_alias(__init_begin),
>                            lm_alias(__init_end),
>                            POISON_FREE_INITMEM, "unused kernel");

