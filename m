Return-Path: <linux-kernel+bounces-444360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9DB9F0584
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 08:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB92B169881
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 07:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931551957F4;
	Fri, 13 Dec 2024 07:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phJ6FlsM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16F73207
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 07:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734075067; cv=none; b=KxLckp2BL1BFvQiQl8P/Tyd6iKZ5obweShBgLCNxFGWWZJPEpZ0oR1LrDLmaQRy/ELM6Rh2n9/PB7ZWivc0PRr1ulkRCeSLnp+l9bsVnecFHhHRkW0EYw0nNV45Rj2HwlIdFA1EKq5uLL9i2TmuKTDMax7hZPh6qHWOIsMQoOCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734075067; c=relaxed/simple;
	bh=udmJv10fh2CLm5vULvFSSNcCm4a1l5ZQCzEqs4YICZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KfTQEF6UdWzAOnVXcUwXs70uZqg3elAMjY5WEp7dJ5BrOE83GXlpRT7NV0ZwRzm9tYdMWzRx7YV16WGuN1o/88T9+1Lyw++7Wo7DtjKPyDQi42qWRROkjpUkqD6cT3nbsFzxGCRUCKwH+y2LYNerarTAvy5C3wbfIgxNFZSDXIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phJ6FlsM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DABDC4CEE0;
	Fri, 13 Dec 2024 07:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734075066;
	bh=udmJv10fh2CLm5vULvFSSNcCm4a1l5ZQCzEqs4YICZg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=phJ6FlsM+IaC34REExBEOUL242wFqNaeCY/mrBFMCY0YmRpEB2S1jRvH3BsbUcXFj
	 FShyPtKaiLwZZEZR7wJQJpHTBQH7YSZoaaUjRvj7S+Sfhr1L98WQh57BbpGs+VA83Q
	 1kyrVeNbXsv0R47xcd5chaxhyRfiHU0hsUO84nqOteauDx5X8RZY4gpjxvjwyA9jMc
	 LYZ8lZcLMMZ3hLOh3lAZg5eCMHCBVhEzJ2pP27/JHTgkOfuny0KK5qx5T3ZQJ8gEl1
	 vurVjkF+ZwO7t+4xceoq/39T4I7YuVfJcxxULFtIiG+olA/KyZ1a48j9Wh63q+WyLl
	 Kq8ti7VvuQXeg==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3003d7ca01cso13109011fa.0;
        Thu, 12 Dec 2024 23:31:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWIVmA36LneyBf4tvsXqgFVqMiWcWZIgekazvlaYiYufzU/PKj82dyeTm8LV7lrVpEfdX7kDkHx2OWI4ydD@vger.kernel.org, AJvYcCWiRFxbkSCh9eXNT6bgKbQ6J6mvbcV0fSCd9OVAEzqHMJweMqLzcTcsaZNX08lRdCOEQ7psiOyw1w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8WQx/yNAC6hZRSoqvOET3Frkd+DC+mEkBFf44DbuC6CkEOAYl
	Jp0ltYS52WIX3bJ6L+MJwtXq+TSJK26qvLZCwqbkCdRVBU7JH/0UioOWNcGbwImq9pjjiS5HPuz
	SRnrmyWywmtPppDtThjCLbqP5Dzc=
X-Google-Smtp-Source: AGHT+IGBs51p6Bepaag3aknYx0wW3tY5m4W/Acd5iLX/msn6Rdi9kX6VTipTRzd+zf4QYDRmuU5cV+2MTWapuGcBfnw=
X-Received: by 2002:a2e:b8d5:0:b0:302:1fce:3956 with SMTP id
 38308e7fff4ca-30254423248mr4605551fa.4.1734075064542; Thu, 12 Dec 2024
 23:31:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212082426.4110-2-shijie@os.amperecomputing.com> <20241213053049.7592-1-shijie@os.amperecomputing.com>
In-Reply-To: <20241213053049.7592-1-shijie@os.amperecomputing.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 13 Dec 2024 08:30:53 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF=1Hr9G4ZjnEVzJ1snn0V4L-=+bMU4bn=m0UbYLyBqGA@mail.gmail.com>
Message-ID: <CAMj1kXF=1Hr9G4ZjnEVzJ1snn0V4L-=+bMU4bn=m0UbYLyBqGA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2 fix] arm64: refactor the rodata=xxx
To: Huang Shijie <shijie@os.amperecomputing.com>
Cc: catalin.marinas@arm.com, will@kernel.org, anshuman.khandual@arm.com, 
	corbet@lwn.net, patches@amperecomputing.com, cl@linux.com, 
	akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org, 
	xiongwei.song@windriver.com, inux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello Huang Shije,

On Fri, 13 Dec 2024 at 06:32, Huang Shijie
<shijie@os.amperecomputing.com> wrote:
>
> As per admin guide documentation, "rodata=on" should be the default on
> platforms. Documentation/admin-guide/kernel-parameters.txt describes
> these options as
>
>    rodata=         [KNL,EARLY]
>            on      Mark read-only kernel memory as read-only (default).
>            off     Leave read-only kernel memory writable for debugging.
>            full    Mark read-only kernel memory and aliases as read-only
>                    [arm64]
>
> But on arm64 platform, "rodata=full" is the default instead. This patch
> implements the following changes.
>
>  - Make "rodata=on" behaviour same as the original "rodata=full"
>  - Make "rodata=noalias" (new) behaviour same as the original "rodata=on"
>  - Drop the original "rodata=full"
>  - Add comment for arch_parse_debug_rodata()
>  - Update kernel-parameters.txt as required
>
> After this patch, the "rodata=on" will be the default on arm64 platform
> as well.
>
> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
> ---
> Add more descriptions for "noalias":
>   It is not a security feature yet.

Why did you add that?

How do you envisage 'noalias' becoming a security feature? The point
of 'full' rodata was to harden the read-only regions in the vmalloc
space against inadvertent modification via the writeable linear alias,
so 'noalias' is less secure than rodata=full, and should be documented
as such.

> ---
>  .../admin-guide/kernel-parameters.txt         |  3 ++-
>  arch/arm64/include/asm/setup.h                | 27 +++++++++++++++++--
>  2 files changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a22b7e621007..f5db01eecbd3 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5901,7 +5901,8 @@
>         rodata=         [KNL,EARLY]
>                 on      Mark read-only kernel memory as read-only (default).
>                 off     Leave read-only kernel memory writable for debugging.
> -               full    Mark read-only kernel memory and aliases as read-only
> +               noalias Use more block mappings,may have better performance.
> +                       But this is not a security feature.
>                         [arm64]
>
>         rockchip.usb_uart
> diff --git a/arch/arm64/include/asm/setup.h b/arch/arm64/include/asm/setup.h
> index ba269a7a3201..0ef57d19fc2a 100644
> --- a/arch/arm64/include/asm/setup.h
> +++ b/arch/arm64/include/asm/setup.h
> @@ -13,6 +13,29 @@
>  extern phys_addr_t __fdt_pointer __initdata;
>  extern u64 __cacheline_aligned boot_args[4];
>
> +/*
> + * rodata=on (default)
> + *
> + *    This applies read-only attributes to VM areas and to the linear
> + *    alias of the backing pages as well. This prevents code or read-
> + *    only data from being modified (inadvertently or intentionally),
> + *    via another mapping for the same memory page.
> + *
> + *    But this might cause linear map region to be mapped down to base
> + *    pages, which may adversely affect performance in some cases.
> + *
> + * rodata=off
> + *
> + *    This provides more block mappings and contiguous hints for linear
> + *    map region which would minimize TLB footprint. This also leaves
> + *    read-only kernel memory writable for debugging.
> + *
> + * rodata=noalias
> + *
> + *    This provides more block mappings and contiguous hints for linear
> + *    map region which would minimize TLB footprint. This is not a
> + *    security feature yet.

Better replace the last sentence with

"This leaves the linear alias of read-only mappings in the vmalloc
space writeable, making them susceptible to inadvertent modification
by software."

