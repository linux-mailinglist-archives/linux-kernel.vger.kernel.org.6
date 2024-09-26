Return-Path: <linux-kernel+bounces-339840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BB8986B3E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 05:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5A9E1F23239
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 03:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D911176231;
	Thu, 26 Sep 2024 03:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYWjXQDZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB3915B562;
	Thu, 26 Sep 2024 03:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727320992; cv=none; b=SRruFuz6xpSVwZ4U6Isbj77ligVWTJUjxSXMQrPNZ7eWS44kZX5mF0UPKvTFgfPCHj/DstPcEZSK6spc7AbK2f9NT/u3Q6eqTdhKiISSAH9DjxQiQ2l2GlvIRGve5nOtgvWqtMPu6RPYo4hQpWI7dthd0e9UuUFhYTaD9FnSyzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727320992; c=relaxed/simple;
	bh=fx8pZLczVjXeMg2rh9SYwd31ohW/5zVjlWO7j2A5L1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K1fxR8ltlkvtUs5GXgAoPrfbM9NucpTwU8xNjoJ1qR8QYCV89DNod4x2cdLMJpDg9JkBGeh0CdImcQTq6gkQrPcWwZ3Fw+DY2OnX7clF0az8e5S0IC+lVNeNfLN7oL+/AA+mnpT0xz3ND0X1SunzXrVdt4mhxWu9VsuuiPuY9So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYWjXQDZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FB9C4CED1;
	Thu, 26 Sep 2024 03:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727320992;
	bh=fx8pZLczVjXeMg2rh9SYwd31ohW/5zVjlWO7j2A5L1Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EYWjXQDZvPjfSLqN3QuWR1Ioppqi01WopwbMklWpJ5EvhHefAqLRpftZPJ/85fNau
	 OzBtgoxghQoZkG1W2aBedUQdy9VXQ4kCRGiCKew/cnrxNv7LhtBePsUsfGrauaoX2z
	 k6x5sobtQ5JG34qbmqsTBcH9UX8mpKC8yk2QUFMU8TrngWELCwkPfvAhufyrrqSTnb
	 LJkmFfNNzSBhXpG87PGZNJ3u4GhaEcs04fKxIQ2CZamQx2amkOwWRbn7Ke8/JJfKed
	 URFy+2nO85b8N6xaOfnPwuCuN1D2q/Zgr+uI1OJfo8aGWutMS5B+9mX5+LuzAt2a3A
	 gw3SmHiHFhUNw==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f752d9ab62so5245041fa.3;
        Wed, 25 Sep 2024 20:23:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWm2HGU5x/xkORSl1/gTYuEhwS5mPcw+F9AiVxV5B8ypPzfyNvktC//hesCKnYdP+X5dyPQ12lSxQHr@vger.kernel.org, AJvYcCX3NGIrgAfNAO8SdR80qY9UMlVfjfLwx1gEG3YUMM7dM+HSlQMEF+79Zfr/llj9M81XhDymvKe6xR9kO1U3@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh0R53qKpsNdT+LKvlxMXMsvfx5GBU+nq5mAs76v2GBKNbVZ5B
	kCDOH2T77JAOE269M5RWqaPlAqmmHoQ4RYnzcWdIYFLtGqeSn2k0uHdC+6QB/koEt3fvlUz8GUT
	Og1PbrjBTBbzbvyKfvgKkc6JLE0o=
X-Google-Smtp-Source: AGHT+IEVHn4SeOlm814f8v2WMfQzmUdfbYxE9ZZ+RDruflT0pl0gMYBsSeJIa+1mWZAwcNA8/DmrDT6J0t/IiRM9RwU=
X-Received: by 2002:a05:6512:138a:b0:52c:9e25:978d with SMTP id
 2adb3069b0e04-5387755c9bdmr2742508e87.45.1727320990548; Wed, 25 Sep 2024
 20:23:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925132420.821473-1-jvetter@kalrayinc.com> <20240925132420.821473-5-jvetter@kalrayinc.com>
In-Reply-To: <20240925132420.821473-5-jvetter@kalrayinc.com>
From: Guo Ren <guoren@kernel.org>
Date: Thu, 26 Sep 2024 11:22:59 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSuueSutg7tnYfrRbvY40AidnfZh4=ujEKye3sust1sXA@mail.gmail.com>
Message-ID: <CAJF2gTSuueSutg7tnYfrRbvY40AidnfZh4=ujEKye3sust1sXA@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] csky: Use generic io memcpy functions
To: Julian Vetter <jvetter@kalrayinc.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, 
	loongarch@lists.linux.dev, Yann Sionneau <ysionneau@kalrayinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 9:24=E2=80=AFPM Julian Vetter <jvetter@kalrayinc.co=
m> wrote:
>
> Use the generic __memcpy_{from,to}io and __memset_io functions.
>
> Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
> Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
> ---
> Changes for v6:
> - Added proper commit header suffix: 'csky: ...'
> ---
>  arch/csky/kernel/Makefile |  2 +-
>  arch/csky/kernel/io.c     | 91 ---------------------------------------
>  2 files changed, 1 insertion(+), 92 deletions(-)
>  delete mode 100644 arch/csky/kernel/io.c
>
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
Thx for the clean-up.

Acked-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren

