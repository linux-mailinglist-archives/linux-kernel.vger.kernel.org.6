Return-Path: <linux-kernel+bounces-233668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B5B91BB4E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5161F1F22F2C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699E114EC78;
	Fri, 28 Jun 2024 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="o+5aXFEl"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74AD43AC0
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 09:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719566320; cv=none; b=ljCDHtOP2+rHoqk66x4JHXBlmF0WEWkTreoeL0vvJp4EDfgmlWXImNlvNkLVEhLHjmW10kCcWaFPkDZlQl+9g+3rABHMY42liOE4iY1+ghRF+yy/c74lBNe2va5wDemIeZHOivuE0oL6CPGZVxsRXsn4VNCVbePMjowXwpMgIHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719566320; c=relaxed/simple;
	bh=JwGvK0qeOLrELKDXtXg20v+0XzyrOv8zOjOREGV38bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iexIMx33Cj65JDXvKvgmLMVIMaI67kruXn1qMs+cEWg6RaGqEnnQzbYQCntnu02zbawjmVRNcHzfQY3J796eCSEA+Xm65fiUQUQNoZjkPrw3p9kMUe4NrvmUMvg8PX6YikxnbnKuoUvTOozRk9Pp4YCP/p0Ized63cGSZQNlVBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=o+5aXFEl; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6fe81a5838so34791766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 02:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719566317; x=1720171117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4nRdrD3NJ1hYJ32BRxvgX77ACcWSuo5vSiMAPd1QEo=;
        b=o+5aXFElerjlzv84wxAkPaRqlt91z0g2X9rhv4q4KoVJKp9p8GLK9NvMlLLgMEZXnF
         RnD6PUHNUlQCDJk1+KkCsecaetFwAw7xT7ZUiHvavPixPs5nFVyHlDaHJBKrWBpXow3j
         vQdlWhq0s9Rj8Qvq0rzQQcCSdAIFZ3fZfXW2KrBiXOh0+aP1ZnYIeBbRVKhbEBbwK5rv
         6yLgjNHR+jW8/bx+J6HQGZ3zvpU0PlcZNkEYxMprEJ997C+bf3sRHgmUYMst+4eHuW3P
         YjNA/zbLpQ5PWD2DTxeAxs+Ib6o1jq9g/HQG84rLfXW4v8pkyKnzL1HstKxEM/8OmqWR
         t9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719566317; x=1720171117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4nRdrD3NJ1hYJ32BRxvgX77ACcWSuo5vSiMAPd1QEo=;
        b=IdO6q6xnqxdrO7VJFIOqlxo4rXdBx27R6GIH0J/XO4ORN0sDndjibdli69R0M7+hpi
         dBuIsfxI0bS3UdpPd8/iSJDQGtJjsfTXHJ7TriSTfOd/h+c3j3/hfsajVjHstBhxHjA8
         Nt5SktLbkkOK4K0XoBHzBmkWMf1LXvC1DLdmJ+yjtFjN4j9ZVKKpC7ihllwepVSQrFUj
         lSB7bxK510rX6BmxLR5TAPpfb7iYEtuM2X1jUzqF/DtVZLSplg5s0+3tNSlVx9kcCzin
         DBa+l3tBXDsAmfnnptKPRAZzFWGP9mr6StKHJLosmYAWLg+SmsI4umbWq68/SYaJCAqj
         Cg8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8+DoEodwd00ZZVRsac7MdcqissHtEdKaCFbjU0LTjTlZABQ74bgjKEaSVNWYF7qsWMZbmD/woJHfwD8EIQcyo5DQnHhfrRzYC7m//
X-Gm-Message-State: AOJu0YyXMwuvFkcmgjW6LpEGMkB5OVQGLDzhiH6pB7e5039DaFJgTvE+
	z7M81Bs5MRFL90b4bI5U29ktsBj8VwwT7NbYvQNvcpHOmdP1tt89rsSbvUUggIpH+rdw0PKSVdo
	hAvnptcyoRsTt0hydIuI4nCGuxb4TNdivwBHgvA==
X-Google-Smtp-Source: AGHT+IHQJz049InCepkhc9kI7uFveWNYHnmaFhmkq0HnaP5qPMrwHzUEhWfGz6Royoe7qcT6s2kIKsKqsb8mkKgqVpA=
X-Received: by 2002:a17:906:9c87:b0:a72:7a71:7f59 with SMTP id
 a640c23a62f3a-a727a7180b9mr787751266b.57.1719566317015; Fri, 28 Jun 2024
 02:18:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626171652.366415-1-jesse@rivosinc.com> <20240626171652.366415-2-jesse@rivosinc.com>
In-Reply-To: <20240626171652.366415-2-jesse@rivosinc.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Fri, 28 Jun 2024 11:18:25 +0200
Message-ID: <CAHVXubgUnHOQ4QF_sSYVD88W6Zuj32W3U9NSJ0Xzf9N36cqh6g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] RISC-V: pi: Add kernel/pi/pi.h
To: Jesse Taube <jesse@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, Ard Biesheuvel <ardb@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Wende Tan <twd2.me@gmail.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Sami Tolvanen <samitolvanen@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Chen Jiahao <chenjiahao16@huawei.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jesse,

On Wed, Jun 26, 2024 at 7:17=E2=80=AFPM Jesse Taube <jesse@rivosinc.com> wr=
ote:
>
> Add pi.h header for declarations of the kernel/pi prefixed functions
> and any other related declarations.
>
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> ---
>  arch/riscv/kernel/pi/cmdline_early.c | 10 ++--------
>  arch/riscv/kernel/pi/fdt_early.c     |  7 +------
>  arch/riscv/kernel/pi/pi.h            | 17 +++++++++++++++++
>  3 files changed, 20 insertions(+), 14 deletions(-)
>  create mode 100644 arch/riscv/kernel/pi/pi.h
>
> diff --git a/arch/riscv/kernel/pi/cmdline_early.c b/arch/riscv/kernel/pi/=
cmdline_early.c
> index f6d4dedffb84..fbcdc9e4e143 100644
> --- a/arch/riscv/kernel/pi/cmdline_early.c
> +++ b/arch/riscv/kernel/pi/cmdline_early.c
> @@ -6,15 +6,9 @@
>  #include <asm/pgtable.h>
>  #include <asm/setup.h>
>
> -static char early_cmdline[COMMAND_LINE_SIZE];
> +#include "pi.h"
>
> -/*
> - * Declare the functions that are exported (but prefixed) here so that L=
LVM
> - * does not complain it lacks the 'static' keyword (which, if added, mak=
es
> - * LLVM complain because the function is actually unused in this file).
> - */
> -u64 set_satp_mode_from_cmdline(uintptr_t dtb_pa);
> -bool set_nokaslr_from_cmdline(uintptr_t dtb_pa);
> +static char early_cmdline[COMMAND_LINE_SIZE];
>
>  static char *get_early_cmdline(uintptr_t dtb_pa)
>  {
> diff --git a/arch/riscv/kernel/pi/fdt_early.c b/arch/riscv/kernel/pi/fdt_=
early.c
> index 899610e042ab..40ee299702bf 100644
> --- a/arch/riscv/kernel/pi/fdt_early.c
> +++ b/arch/riscv/kernel/pi/fdt_early.c
> @@ -3,12 +3,7 @@
>  #include <linux/init.h>
>  #include <linux/libfdt.h>
>
> -/*
> - * Declare the functions that are exported (but prefixed) here so that L=
LVM
> - * does not complain it lacks the 'static' keyword (which, if added, mak=
es
> - * LLVM complain because the function is actually unused in this file).
> - */
> -u64 get_kaslr_seed(uintptr_t dtb_pa);
> +#include "pi.h"
>
>  u64 get_kaslr_seed(uintptr_t dtb_pa)
>  {
> diff --git a/arch/riscv/kernel/pi/pi.h b/arch/riscv/kernel/pi/pi.h
> new file mode 100644
> index 000000000000..65da99466baf
> --- /dev/null
> +++ b/arch/riscv/kernel/pi/pi.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _RISCV_PI_H_
> +#define _RISCV_PI_H_
> +
> +#include <linux/types.h>
> +
> +/*
> + * The folowing functions are exported (but prefixed) declare them here =
so

s/folowing/following

And it lacks something between "(but prefixed)" and "declare": what
was wrong with the initial comment?

> + * that LLVM does not complain it lacks the 'static' keyword (which, if
> + * added, makes LLVM complain because the function is unused).
> + */
> +
> +u64 get_kaslr_seed(uintptr_t dtb_pa);
> +bool set_nokaslr_from_cmdline(uintptr_t dtb_pa);
> +u64 set_satp_mode_from_cmdline(uintptr_t dtb_pa);
> +
> +#endif /* _RISCV_PI_H_ */
> --
> 2.45.2
>

Suggested-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex

