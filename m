Return-Path: <linux-kernel+bounces-320632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BFC970CFF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 07:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1551B21967
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 05:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780A71ACE0C;
	Mon,  9 Sep 2024 05:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lqk9+8fN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D7422638;
	Mon,  9 Sep 2024 05:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725860298; cv=none; b=OxaIMNwCJ0iQQunjPQFXoKFMAdmKn96kl//zEw5SxE4sxkWWXyluUeL6DWDNTqj3NpCNU+jYPNENOAlxPNC7noc3Z3OzlN0J5n5ltl46pldEzPjuHUDOAfatdJvdqsl2CIqFLrvr2d97Qbjd7FLr3QrhPWcM4yjsRFHBuCog68M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725860298; c=relaxed/simple;
	bh=248ziiTVCRGbM5LmN8AO7b96LuuBfqOH7lAwbsdPjxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mVDmMXAMPp/0G8wmQrK09TnR64/3AHkxiMd5dfjBc/2+9zdag/wUb7ynaAPm7JWKJ6lKdjV93dpCHWa3zdn+e+LaMgNtX7rGyjABTT3Kbo51qBAiogCjgIYhK+n80W1GdybA0MDKKcrbUjkNVdZL1QUKFrc/R4n99pjw80rM0Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lqk9+8fN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF8CC4CECF;
	Mon,  9 Sep 2024 05:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725860298;
	bh=248ziiTVCRGbM5LmN8AO7b96LuuBfqOH7lAwbsdPjxE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Lqk9+8fNiAJZsLmJZfNjOcJJrbex0CFOVOdjWsTc910wOK86Qm4pLowAw5rr5eeB+
	 wo9r+pJbFpgOffoaExZP4OAp91aCK7r73u492I3hZeWJDNXSMTFJNS9M+FRo+3MzzD
	 K44EA65vVaR5h8BqtrHvgLf15QhZs13OSz4ZUut5PrICZaAXuMm+u13n0g3x2UR/WP
	 viN9fQwVPKtuNovaGECTam2aoE3V05ijvMtgo/m8mieZxCYVHH0GdiSDqx9mRwELw5
	 9rXtc1IS19Qnh4VwtzwMC/AijM3ZIT6r47iyjhPMKbqbzezQfCm7xOeMQEeJDtPIR8
	 N+bxt61PaH3AA==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8a7596b7dfso640278166b.0;
        Sun, 08 Sep 2024 22:38:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX4vJE6QeCGtcQ6I6QpI2cc6Fs8KoakIiQU/t8bOFxpbpXLJdlxQryqJYlOZMZN3V6/trB6nRBONX6tZzMW@vger.kernel.org, AJvYcCXBreL8lh73iyE2LiVRAeohrHZKKSrrgBgs2isGzADfTfoElEhFmAoYEujzacisGHhbO51slAj7o6qK@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp8BN+6bIKvSW9T1oG0nKrvh4Ff5EnSkVggWcfT2spRmdlOvds
	Gc2fVGMZ43Ye5QycW3xKY/VRvMUaDQrV630jfFP8WNv0BMCfD13LX0R5z3JnIdMIGqHVKalI7LM
	kD9C3SzdBH/SKHGE4VkOLyaHntfQ=
X-Google-Smtp-Source: AGHT+IHjBN35NmKR1OI5li20cLHkx9049W05deSAnLeL3Dhe+9B6DZKPW9onBE/+E2iLUZA1jWuOyBcAVE2WJG31aWA=
X-Received: by 2002:a17:906:eece:b0:a77:c051:36a9 with SMTP id
 a640c23a62f3a-a8a85f9af7cmr1134497066b.9.1725860296616; Sun, 08 Sep 2024
 22:38:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906114151.519028-1-jvetter@kalrayinc.com> <20240906114151.519028-4-jvetter@kalrayinc.com>
In-Reply-To: <20240906114151.519028-4-jvetter@kalrayinc.com>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 9 Sep 2024 13:38:05 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQHkdgNRBg+fGkKre1zdCXfC57YUGDU-GrMJOTRyCQzZg@mail.gmail.com>
Message-ID: <CAJF2gTQHkdgNRBg+fGkKre1zdCXfC57YUGDU-GrMJOTRyCQzZg@mail.gmail.com>
Subject: Re: [PATCH 3/4] Activate GENERIC_IO for the csky architecture
To: Julian Vetter <jvetter@kalrayinc.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, 
	loongarch@lists.linux.dev, Yann Sionneau <ysionneau@kalrayinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 7:47=E2=80=AFPM Julian Vetter <jvetter@kalrayinc.com=
> wrote:
>
> Use the generic __memcpy_{from,to}io and __memset_io for the csky
> processor architecture.
>
> Reviewed by: Yann Sionneau <ysionneau@kalrayinc.com>
> Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
I'm okay with moving it into GENERIC_IO

Acked-by: Guo Ren <guoren@kernel.org>

> ---
>  arch/csky/Kconfig         |  1 +
>  arch/csky/kernel/Makefile |  2 +-
>  arch/csky/kernel/io.c     | 91 ---------------------------------------
>  3 files changed, 2 insertions(+), 92 deletions(-)
>  delete mode 100644 arch/csky/kernel/io.c
>
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index 5479707eb5d1..d64329b691f7 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -48,6 +48,7 @@ config CSKY
>         select DMA_DIRECT_REMAP
>         select IRQ_DOMAIN
>         select DW_APB_TIMER_OF
> +       select GENERIC_IO
>         select GENERIC_IOREMAP
>         select GENERIC_LIB_ASHLDI3
>         select GENERIC_LIB_ASHRDI3
> diff --git a/arch/csky/kernel/Makefile b/arch/csky/kernel/Makefile
> index 8a868316b912..de1c3472e8f0 100644
> --- a/arch/csky/kernel/Makefile
> +++ b/arch/csky/kernel/Makefile
> @@ -2,7 +2,7 @@
>  extra-y :=3D vmlinux.lds
>
>  obj-y +=3D head.o entry.o atomic.o signal.o traps.o irq.o time.o vdso.o =
vdso/
> -obj-y +=3D power.o syscall.o syscall_table.o setup.o io.o
> +obj-y +=3D power.o syscall.o syscall_table.o setup.o
>  obj-y +=3D process.o cpu-probe.o ptrace.o stacktrace.o
>  obj-y +=3D probes/
>
> diff --git a/arch/csky/kernel/io.c b/arch/csky/kernel/io.c
> deleted file mode 100644
> index 5883f13fa2b1..000000000000
> --- a/arch/csky/kernel/io.c
> +++ /dev/null
> @@ -1,91 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -
> -#include <linux/export.h>
> -#include <linux/types.h>
> -#include <linux/io.h>
> -
> -/*
> - * Copy data from IO memory space to "real" memory space.
> - */
> -void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t=
 count)
> -{
> -       while (count && !IS_ALIGNED((unsigned long)from, 4)) {
> -               *(u8 *)to =3D __raw_readb(from);
> -               from++;
> -               to++;
> -               count--;
> -       }
> -
> -       while (count >=3D 4) {
> -               *(u32 *)to =3D __raw_readl(from);
> -               from +=3D 4;
> -               to +=3D 4;
> -               count -=3D 4;
> -       }
> -
> -       while (count) {
> -               *(u8 *)to =3D __raw_readb(from);
> -               from++;
> -               to++;
> -               count--;
> -       }
> -}
> -EXPORT_SYMBOL(__memcpy_fromio);
> -
> -/*
> - * Copy data from "real" memory space to IO memory space.
> - */
> -void __memcpy_toio(volatile void __iomem *to, const void *from, size_t c=
ount)
> -{
> -       while (count && !IS_ALIGNED((unsigned long)to, 4)) {
> -               __raw_writeb(*(u8 *)from, to);
> -               from++;
> -               to++;
> -               count--;
> -       }
> -
> -       while (count >=3D 4) {
> -               __raw_writel(*(u32 *)from, to);
> -               from +=3D 4;
> -               to +=3D 4;
> -               count -=3D 4;
> -       }
> -
> -       while (count) {
> -               __raw_writeb(*(u8 *)from, to);
> -               from++;
> -               to++;
> -               count--;
> -       }
> -}
> -EXPORT_SYMBOL(__memcpy_toio);
> -
> -/*
> - * "memset" on IO memory space.
> - */
> -void __memset_io(volatile void __iomem *dst, int c, size_t count)
> -{
> -       u32 qc =3D (u8)c;
> -
> -       qc |=3D qc << 8;
> -       qc |=3D qc << 16;
> -
> -       while (count && !IS_ALIGNED((unsigned long)dst, 4)) {
> -               __raw_writeb(c, dst);
> -               dst++;
> -               count--;
> -       }
> -
> -       while (count >=3D 4) {
> -               __raw_writel(qc, dst);
> -               dst +=3D 4;
> -               count -=3D 4;
> -       }
> -
> -       while (count) {
> -               __raw_writeb(c, dst);
> -               dst++;
> -               count--;
> -       }
> -}
> -EXPORT_SYMBOL(__memset_io);
> --
> 2.34.1
>
>
>
>
>


--=20
Best Regards
 Guo Ren

