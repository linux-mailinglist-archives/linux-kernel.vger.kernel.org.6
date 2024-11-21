Return-Path: <linux-kernel+bounces-416532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC119D4677
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 05:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07AEB283964
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 04:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C59074C08;
	Thu, 21 Nov 2024 04:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qtz6+GQD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1242309B6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 04:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732162072; cv=none; b=VZhYhlXyU/CFMV7WmE5sf8VLN5ckCPBCO6zWHA9fIy55HKJ6xHlHmXS3iUGlhd11MMXUAJgtoDJ+Wk7ae0ikqEZ0WnCXran6wceBstEK88gpJi1ruwp5tRXy2WG3sBU1GXr5ba+Xy65EvyUH4b013Xix2trIsjSa7CElm2iC+Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732162072; c=relaxed/simple;
	bh=R3M/G3WFfh5fe8L9TVMk4hKrwFb2rnUMCR2MrEnTL6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TaXdScoiVPLNpjq5UNOl5gL5imsH5/uTkeYSmWT/PXW4+ehtUXxFeOvAaPB3E8YpMoGMCi3FaTCrqXWDaFKadysfKtkgnkwyje4mHjIQSXzSkRNlvg3N6PEyreM+aJrfh+OOM4m0l2W4yq5kNb7EamFjleLMR1w5jn+OLiRrtC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qtz6+GQD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A591FC4AF0B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 04:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732162072;
	bh=R3M/G3WFfh5fe8L9TVMk4hKrwFb2rnUMCR2MrEnTL6o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Qtz6+GQDkhGkhSMdf8RJ6/HJwGj01tC6TAJEYsqYqdyAN6BdIeShAKhX80Ka9DJ8U
	 cJJE4D3mQvNrUQsBDehUcK2fx3CN0Y24Nj84sGS3R2X5ICYBU4jDJy7AUXk6K7LpOl
	 eT1xTtcKacMFGEOsT4xqrutE9YQb5q7lULfAu61OQEXlnaCtR+4AWu3xqYeDA+magY
	 TTTVhanG91U9e8akmVm71gck2gCwZNL9F7IAfOIpZTPos8mkGbULHYRbGhLhd32S9q
	 SgYhz9SNvJw9KUnTlgdn5xGSCvbfIwNRqhRMvRkVzPg0fJsV5X5eM+h3gIHREvl+1y
	 jYqVXnx+ZftBg==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9eb3794a04so52823066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 20:07:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWYNtSY86tiUin3kL2h6vvz/up7XQqzx2yYbZ8dMg7DoderDP7OUtV7hHJzFKpEbzOSOeUVHPO6Eev5EPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YywRF4BW05WTU8Lsoem/3jpv7PLPo+S5Pnvpp1v/aC1gt7op+5J
	pg1TxULdmyeUFHhIroGCzzePR4ekcbcdlx3oyJbr+x9QJHxeX+3ih9t7Gn+9RogjJbv9QqubIqW
	iR3i4gMZCu+TYp0FByh1PP3DaiwI=
X-Google-Smtp-Source: AGHT+IFshvJULdgY3VYbxX4U5+WOGh0vxRKU5KWpqiKRNWSV+gim8TUcZ3230OS5y6Cvp2FRHIJtAcBdHsTda3bJRU8=
X-Received: by 2002:a17:907:9614:b0:a9e:441c:f729 with SMTP id
 a640c23a62f3a-aa4dd383bb0mr434863866b.0.1732162071202; Wed, 20 Nov 2024
 20:07:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121034127.8325-2-xry111@xry111.site>
In-Reply-To: <20241121034127.8325-2-xry111@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 21 Nov 2024 12:07:39 +0800
X-Gmail-Original-Message-ID: <CAAhV-H61P1Qnocn1eEOszufcj=BzC_8cPZVfTw-ui8M+nmxZdw@mail.gmail.com>
Message-ID: <CAAhV-H61P1Qnocn1eEOszufcj=BzC_8cPZVfTw-ui8M+nmxZdw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Add PREEMPT_LAZY support
To: Xi Ruoyao <xry111@xry111.site>
Cc: WANG Xuerui <kernel@xen0n.name>, Peter Zijlstra <peterz@infradead.org>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Jinyang He <hejinyang@loongson.cn>, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hmmm, I have just written the same patch...
https://github.com/chenhuacai/linux/commit/d908e12e493173df4a3edf23c4a26538=
5f475621

Huacai

On Thu, Nov 21, 2024 at 11:42=E2=80=AFAM Xi Ruoyao <xry111@xry111.site> wro=
te:
>
> Like x86 and RISC-V, we are using GENERIC_ENTRY so supporting
> PREEMPT_LAZY just needs to allocate a bit in thread flags.
>
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>  arch/loongarch/Kconfig                   | 1 +
>  arch/loongarch/include/asm/thread_info.h | 8 +++++---
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index d9fce0fd475a..b8cc5997d595 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -25,6 +25,7 @@ config LOONGARCH
>         select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>         select ARCH_HAS_PTE_DEVMAP
>         select ARCH_HAS_PTE_SPECIAL
> +       select ARCH_HAS_PREEMPT_LAZY
>         select ARCH_HAS_SET_MEMORY
>         select ARCH_HAS_SET_DIRECT_MAP
>         select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
> diff --git a/arch/loongarch/include/asm/thread_info.h b/arch/loongarch/in=
clude/asm/thread_info.h
> index 8bf0e6f51546..fd68a6d81b8e 100644
> --- a/arch/loongarch/include/asm/thread_info.h
> +++ b/arch/loongarch/include/asm/thread_info.h
> @@ -66,8 +66,9 @@ register unsigned long current_stack_pointer __asm__("$=
sp");
>   * - pending work-to-be-done flags are in LSW
>   * - other flags in MSW
>   */
> -#define TIF_SIGPENDING         1       /* signal pending */
> -#define TIF_NEED_RESCHED       2       /* rescheduling necessary */
> +#define TIF_NEED_RESCHED       0       /* rescheduling necessary */
> +#define TIF_NEED_RESCHED_LAZY  1       /* Lazy rescheduling needed */
> +#define TIF_SIGPENDING         2       /* signal pending */
>  #define TIF_NOTIFY_RESUME      3       /* callback before returning to u=
ser */
>  #define TIF_NOTIFY_SIGNAL      4       /* signal notifications exist */
>  #define TIF_RESTORE_SIGMASK    5       /* restore signal mask in do_sign=
al() */
> @@ -88,8 +89,9 @@ register unsigned long current_stack_pointer __asm__("$=
sp");
>  #define TIF_LBT_CTX_LIVE       20      /* LBT context must be preserved =
*/
>  #define TIF_PATCH_PENDING      21      /* pending live patching update *=
/
>
> -#define _TIF_SIGPENDING                (1<<TIF_SIGPENDING)
>  #define _TIF_NEED_RESCHED      (1<<TIF_NEED_RESCHED)
> +#define _TIF_NEED_RESCHED_LAZY (1<<TIF_NEED_RESCHED_LAZY)
> +#define _TIF_SIGPENDING                (1<<TIF_SIGPENDING)
>  #define _TIF_NOTIFY_RESUME     (1<<TIF_NOTIFY_RESUME)
>  #define _TIF_NOTIFY_SIGNAL     (1<<TIF_NOTIFY_SIGNAL)
>  #define _TIF_NOHZ              (1<<TIF_NOHZ)
>
> base-commit: 43fb83c17ba2d63dfb798f0be7453ed55ca3f9c2
> --
> 2.47.0
>
>

