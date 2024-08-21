Return-Path: <linux-kernel+bounces-295058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B1595962F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 09:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DCD21C21229
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 07:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2458E1A7AC2;
	Wed, 21 Aug 2024 07:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRq6bFrT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C81A1B81A8
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 07:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724225883; cv=none; b=M6UTWzXzfp5247ISGbtV7lQCy4WVws7Jftdt/kuTTI/B++VTS3POT6EhWTpJMznd18SbSk2Hl2QGBtCXO4fA/ImvYDG6/y+9BG+bvUM2M+LKMtR0pcXKWHcKrd4KmU2w3jCCet/YkKrojO58zqBxhylzmdrz5f9aafgzYpbtWBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724225883; c=relaxed/simple;
	bh=n0y1tUqVQ4fIM3H/3lqDQUYe/hlGQ2kJX2bSDgPYpJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1X37gayE2Q2HUmOziHILYsjQzs+l1oZy7fwHIkXGxdr8rGQ0irpi4spSsl13qVm6E3wr5ChcftarWUYSLCRNBONAlMD+hy3egLOM/mUw7ALKv7H54GN9l/ST10x9uxuM2z5aBRE2VeDjB52zP77MeeHuqSXCeYSO0p9C3fnnw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRq6bFrT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F56EC4AF09
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 07:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724225883;
	bh=n0y1tUqVQ4fIM3H/3lqDQUYe/hlGQ2kJX2bSDgPYpJQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qRq6bFrTRGRVrE3jk8Rqf9g8Wdey3Hmbhw7xQJIHarCByw/mLmOIpE8Rs7ufN0yRt
	 Aa+m+Y3XcZooD2PF/9DlYpUBcxCBGBb4Ir16gE+h+VaL6p5OmpfSv6aENVuTXT6BAj
	 TLlQezIFG/CgNinkJsITvCI6beMDBoEwKDTTFEOxROPjLn2ATLhqqd3dUmnUVYLarK
	 Ij9hv3AOsVTEenj8s3uwXuFUM172E5D9eNYYPCnpO/MLUnSx7/Zyqm/OGiO3RohZtL
	 /hts/MXK24YvbiYKDUGi1nc4JUcWlf9kDMnLnM1j1l/b7kIiTEA2g+Cp0DAvCcCTTM
	 rWNJa92ua2NIg==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f3cd4ebf84so50275141fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 00:38:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXZ/GysDM8nQGgZEyJfdKxnJcaSgNmJ4nexKq9INt/a7QcysDZmlyr8yi+9ou3tVFhVG4FIemWxokg+oxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTMUc2HMBMqAngYFh2FGns/U3jKRuZ5udytFOmj59GVMSRhlYU
	d7iIqEaG0R7kJFAwkbNQqbjDWP/NBjmzWoiuwlSCE6C9G4TTCPbz3hrvBAj5ODKLfDG2JmYDYmZ
	oH8lERa9CoDacd1JJSrsT7OfvCeg=
X-Google-Smtp-Source: AGHT+IEShOkMbPYRq0Maf0J8b85cfd6TJktvzDAzXlBcoXnwUSr2MahILkdgU141foEExPPD0rHQDxiYmD5CkSDu4Wc=
X-Received: by 2002:a2e:4c12:0:b0:2f3:f4db:910a with SMTP id
 38308e7fff4ca-2f3f894f50cmr8454771fa.46.1724225881462; Wed, 21 Aug 2024
 00:38:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820123731.31568-1-yangtiezhu@loongson.cn> <20240820123731.31568-2-yangtiezhu@loongson.cn>
In-Reply-To: <20240820123731.31568-2-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 21 Aug 2024 15:37:49 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6Mh3didzHnKJiEsMP4yVgggnBBuDS1U6yDzEvdVEbGRg@mail.gmail.com>
Message-ID: <CAAhV-H6Mh3didzHnKJiEsMP4yVgggnBBuDS1U6yDzEvdVEbGRg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] LoongArch: Define barrier_before_unreachable() as empty
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Jinyang He <hejinyang@loongson.cn>
Cc: Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Arnd and Jinyang,

On Tue, Aug 20, 2024 at 8:37=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> When building kernel with -Os (CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy) rather
> than the default -O2 (CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set),
> there exist many objtool warnings "unreachable instruction", this is
> because objtool couldn't find a code path to reach the instruction,
> objdump shows that the unreachable instruction is related with BUG()
> or unreachable().
>
> In include/linux/compiler-gcc.h, there is an empty inline assembly
>
>   #define barrier_before_unreachable() asm volatile("")
>
> in the definition of unreachable() to work around GCC 7.0 after the
> commit 173a3efd3edb ("bug.h: work around GCC PR82365 in BUG()") in
> the year of 2018, the unreachable instruction is generated by it.
>
> As far as I can see, this workaround is to fix warnings of frame sizes,
> the default CONFIG_FRAME_WARN is 2048 on 64 bit system now, it seems
> that there are no -Wframe-larger-than warnings in the current kernel
> without this workaround.
>
> I am not sure whether the GCC bug has been fixed, I can not find the
> fixup in the link https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D82365
> and in the GCC repo. So I am not sure whether it is time and proper
> to remove this workaround in the common header totally, just remove
> it in the arch specified header when compiling kernel with a newer
> GCC version (for example GCC 12.1 or higher on LoongArch) at least.
What's your opinion? From my point of view, this GCC bug hasn't been
fixed. So there may still be potential problems.

Huacai

>
> For example:
> arch/loongarch/kernel/cpu-probe.o: warning: objtool: cpu_probe+0x664: unr=
eachable instruction
>
> objdump -M no-aliases -D arch/loongarch/kernel/cpu-probe.o
>
> Without this patch:
>
> 0000000000000000 <cpu_probe>:
>  ...
>  65c:   44000d80        bnez            $t0, 12 # 668 <.L345^B1+0x4>
>
> 0000000000000660 <.L10001^B2>:
>  660:   002a0001        break           0x1
>
> 0000000000000664 <.L345^B1>:
>  664:   53ff63ff        b               -160    # 5c4 <.L344^B1>
>  668:   0280040c        addi.w          $t0, $zero, 1
>  66c:   00006d8d        cpucfg          $t1, $t0
>
> With this patch:
>
> 0000000000000000 <cpu_probe>:
>  ...
>  65c:   44000980        bnez            $t0, 8  # 664 <.L345^B1>
>
> 0000000000000660 <.L10001^B2>:
>  660:   002a0001        break           0x1
>
> 0000000000000664 <.L345^B1>:
>  664:   0280040c        addi.w          $t0, $zero, 1
>  668:   00006d8d        cpucfg          $t1, $t0
>
> Cc: stable@vger.kernel.org # 6.9+
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202407221208.6SSBeN9H-lkp@i=
ntel.com/
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/Kconfig                |  1 +
>  arch/loongarch/include/asm/compiler.h | 13 +++++++++++++
>  2 files changed, 14 insertions(+)
>  create mode 100644 arch/loongarch/include/asm/compiler.h
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 70f169210b52..3af0da76d103 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -102,6 +102,7 @@ config LOONGARCH
>         select GPIOLIB
>         select HAS_IOPORT
>         select HAVE_ARCH_AUDITSYSCALL
> +       select HAVE_ARCH_COMPILER_H
>         select HAVE_ARCH_JUMP_LABEL
>         select HAVE_ARCH_JUMP_LABEL_RELATIVE
>         select HAVE_ARCH_KASAN
> diff --git a/arch/loongarch/include/asm/compiler.h b/arch/loongarch/inclu=
de/asm/compiler.h
> new file mode 100644
> index 000000000000..4f6adb8d533e
> --- /dev/null
> +++ b/arch/loongarch/include/asm/compiler.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2024 Loongson Technology Corporation Limited
> + */
> +#ifndef _ASM_COMPILER_H
> +#define _ASM_COMPILER_H
> +
> +#ifdef barrier_before_unreachable
> +#undef barrier_before_unreachable
> +#define barrier_before_unreachable() do { } while (0)
> +#endif
> +
> +#endif /* _ASM_COMPILER_H */
> --
> 2.42.0
>
>

