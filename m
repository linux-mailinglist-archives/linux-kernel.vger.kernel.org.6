Return-Path: <linux-kernel+bounces-202001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D2D8FC665
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6591C22F8D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F3D1946D8;
	Wed,  5 Jun 2024 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tQhBomdH"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD401946BB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 08:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717576030; cv=none; b=KxZuQSuGBKgsSMwP4T1T51kWq7kcbP6tsZYmsYJL6R5PQlHqY0sodM1hOjK1hsi9NBHEN4veSPR9HLhINYnZ9MeI+OjPjwcd7c05PHXFoKbzUjeBzVp9tQ+U1FTWelMhJWCDwxhZqqF26j0IrizQFHxjFH6Hi/l4kKXhTgHs7Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717576030; c=relaxed/simple;
	bh=2TFfww5X8HPC/lv2HxZO2q+XLVp5JgHK5PK6QtebPhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E0Y6T8cez1wzSWSzz/CFA2dXQwcPcd3q/ldtqGUB7tejvKHkU6xh26N0J/ybvMu/PQKRS46Btn0nxO+2bJXp100EKe9hX3+Szxoq4BL9KpRVxNKBX6mpvib/AQJJURiC6UeJfNuUW3VmM/FJIZJVCu5saNo9eZsogCW7ptEWM18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tQhBomdH; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4e1c721c040so2434295e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 01:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717576028; x=1718180828; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xI2ZfUOQMB97s+bgDqzvmTsNCCSzvd4YgPMgpPkWMVM=;
        b=tQhBomdHA86gAP6HmAXCk40GnEFvKgpJ/7zuxO1nofjIt6bXotYZX/TI/eIZmxlQDc
         h7uqN6FW3m0yGsxdwYpASkSf88sTFBt/Qa7eYmhh/TTVpzzlYm34CP/JhDcr3Np6lyeK
         /que2bV9Dd0TB7IIrd9cthCdXBrAcEyMnSj9b82cP4y3ZCRtQoFoL8pv+5X98jZKCSt2
         3dMpZsYhmH1pxhfDSWbeygQIKffuAquvQWaEj+zErbuf87faRLbSCgOL7sl3N7Itu9p5
         EoZNsBsG/oX9CuNYlVQxTZuC4lhBk/YhJf+Nb45jCBgXFjCHB1DilHxsFGEvyE4W2iyP
         r3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717576028; x=1718180828;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xI2ZfUOQMB97s+bgDqzvmTsNCCSzvd4YgPMgpPkWMVM=;
        b=IMrVpRbhNuFaQqEaznHrSoD18iR+2Li0uuSmnrW3R1Z8Gus5xMIyfduRr9xYOm5Jhw
         8YLsvmI4s9PYJm73jO5H2OuONSOO/kdIT5qHBdNOVugM0f6S933G2R+zJR284KbUDKbM
         fSG46/gJSqU+g88eRsLGM4Wh7TRnoCbeH/8nAJrna0VGpO+bPX9fFU9ZWHsVyEdCrM44
         gmSpLte5beHiBBeMUC1U5y5Q4RYs4NTTy8IRFXkGGcC/vYyvgrte9juwstsGpttdJh/c
         cAv8JwtAkGNstrMLjgBo5B+y2WQAbe54gYUamC14IpittAYYuhh4sTabx14QKHQQ0fad
         9ZZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU2KDcUEqR/aHKYIKh8qTdl5NTJZ0d5JfF+PXoJ3ybGC+pATs65djAXiQ8hCrQqBclpAX1aG37mofsQ6omJbHs+bwWrKlPE+13S4yN
X-Gm-Message-State: AOJu0YzLv/0r2xZWdhHU/afnB6cqzHzN2Fb9DHZf9RTcxBq9LuMzlinQ
	JujI2yDKKXL3+x9otbSDSjK2Ha89By1Fm6403ZPmf8lZMy2Y/zf46oPUeH/vB4QEHHrzfrIctu5
	g6G56hxiADway6pKrH+fGu/PmP+6dmYFWF3Mj
X-Google-Smtp-Source: AGHT+IH9T9LMxxCD9D30Usm/dWXYTh4/H+ogY1MDRCuladOzvjAP8+tQecNHLWDrEgM8djyjeAp8q/TJu2MemHXJv2k=
X-Received: by 2002:a05:6122:6111:b0:4ea:ede1:ab15 with SMTP id
 71dfb90a1353d-4eb3a508dcdmr1730390e0c.15.1717576027167; Wed, 05 Jun 2024
 01:27:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717507310.git.dvyukov@google.com> <4c05efefe278bc5b140dba40eb1d195cceb2e6ce.1717507310.git.dvyukov@google.com>
In-Reply-To: <4c05efefe278bc5b140dba40eb1d195cceb2e6ce.1717507310.git.dvyukov@google.com>
From: Marco Elver <elver@google.com>
Date: Wed, 5 Jun 2024 10:26:27 +0200
Message-ID: <CANpmjNMoMmz_+jw-s9FBeTcHo6dBaqZdk3MJbQveRtira=Adrg@mail.gmail.com>
Subject: Re: [PATCH 4/4] x86: Ignore stack unwinding in KCOV
To: Dmitry Vyukov <dvyukov@google.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com, glider@google.com, nogikh@google.com, 
	tarasmadan@google.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Jun 2024 at 15:45, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> Stack unwinding produces large amounts of uninteresting coverage.
> It's called from KASAN kmalloc/kfree hooks, fault injection, etc.
> It's not particularly useful and is not a function of system call args.
> Ignore that code.
>
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: syzkaller@googlegroups.com
> ---
>  arch/x86/kernel/Makefile | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 20a0dd51700a..cd49ebfae984 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -39,6 +39,14 @@ KMSAN_SANITIZE_sev.o                                 := n
>  # first second.
>  KCOV_INSTRUMENT_head$(BITS).o                          := n
>  KCOV_INSTRUMENT_sev.o                                  := n
> +# These are called from save_stack_trace() on debug paths,
> +# and produce large amounts of uninteresting coverage.
> +KCOV_INSTRUMENT_stacktrace.o                           := n
> +KCOV_INSTRUMENT_dumpstack.o                            := n
> +KCOV_INSTRUMENT_dumpstack_$(BITS).o                    := n
> +KCOV_INSTRUMENT_unwind_orc.o                           := n
> +KCOV_INSTRUMENT_unwind_frame.o                         := n
> +KCOV_INSTRUMENT_unwind_guess.o                         := n
>
>  CFLAGS_irq.o := -I $(src)/../include/asm/trace
>
> --
> 2.45.1.467.gbab1589fc0-goog
>

