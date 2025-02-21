Return-Path: <linux-kernel+bounces-525773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D94EA3F4B9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A199A860D05
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8671F4299;
	Fri, 21 Feb 2025 12:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWCeNVqq"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C56F1E493
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 12:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740142472; cv=none; b=oNEqOREul9aoz/Z9tSltopXUHnswOecLi+f4J5vKhaOG0QME9taEm4wkujOyr6sMejSLdi00njQXn9bbJM98BMtsyzz8c4ZNn/MbFGVArFakdVidPTFLezDQQjr2ZciLEqFMk4+oSynyG7GDnl7rCNzg6waqoumrTv0Ph0Cqpkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740142472; c=relaxed/simple;
	bh=A3tU1qmviqN1gYLdXMOFW56DHGiyI3nBCsX3vmN9VBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=snv0WJ1luNiHLECJDDSPIHSZG27ptIsAwAwMviMiASl20KNu8oSyAVc0217Ix8GExLGmZSrNTrMWOG4NoRuhYxVRFs8Vgpbjn2GxKZK48vKtrKYj9qd8NpQJ8MNcjxpKrC/lACuUrmcrGth0qhEc6c0hzbKoxCE7w3xJI+VSM7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWCeNVqq; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54605bfcc72so3608836e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 04:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740142469; x=1740747269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7H4KgtdCw0V7e7PnQ4G6MngYQuULtr247bmZ5GyawY=;
        b=GWCeNVqqkVtoK/OPUqfpj8tMdEi4NmfZdp/MoNiQvtcWfa8uWnTRW9aKWAy4Mm0Gry
         PuvKK27LMCsvttUGnPwrxj4ygJFJG9K8HMgh7YFZlfN9H5D9K4UzE19JYuYh7Bi/E/uO
         MamZSOdjSHc3iSelltapjegm/zUtnJurxf13GM1uq8n7fAhK8x9E10nrXrVVjhiKdM0n
         eavc9Z1quGDB45ST+4h8bHcgq4ivKG+zt4xhbm77/7B3MJWzJbCLSnIT606xdpTpmt8B
         H5Z0owF3TWtxNlbNxamVPu8527Wp6ZXZK/v5mr+TufEIijkf5epBZyGYLkR+heiaKt6a
         rIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740142469; x=1740747269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7H4KgtdCw0V7e7PnQ4G6MngYQuULtr247bmZ5GyawY=;
        b=CKIXGhvSHbIydKh20Q4AJ/iJWF+IPP250UIhS7/LHxQfHVp5NM53XY/0Ep7xXBoVUK
         GbOhQ5h0Qu7jYxNR3n7NGXyJjwlB3jEKv7grtUP3frHwtcwMUiytu/X+dPXCTnK2HhVC
         GjKZQt8+QIaGZIpo+wk/WzVVaHdwHPXnEhX3GCGslFSDneZw5mBU7x0z7bKZIL++uwZd
         kdq/jp8Laowh8dgEGLOIXbAGjHBNG/6tGr/s92VCCUP41EcHvhJxP5bMJH3hjOaON10F
         u4pVMhqtnuoKeewJ5nWODnj00rGnywk8qE6lDXvs65muCx5meJZ1zY31gF3ygUUcLPzO
         L4HQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6sZjh3RQgR0GYRhzliSG62qnMgO38htfVmsx6LZOOTATj5xkAGEe+vzyear584SO7rT9CPC9Yikzf2Hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUpZmMV1pz/feA7dnldhojl3vsZOBNXIpPBV2Q5Lil8crf39ne
	5vkdRdN1wMdNRt5Y/f8h4svJ/z5EiYFe9uSFnaOcuZdWtEYpAQmvGbPAdbnkvfeKf+Fw3B8vGJd
	Kzx5e0qMUr1wN+iIr1jUchIftvA==
X-Gm-Gg: ASbGncvwSqcTWMj5rCN8v6r7qSuA2//pw/bDD4BYKBc0vq8wQTqrfm4Nm8269McFYh1
	VvN25pqeMkb3U/GqRVYwpyKiVAWrEINxId/oGmlTBTNzdqNV+VctfrdwrnsvbChWjrENcV4+E0f
	LQZGMkDvs+KoDJd5AjcmoDvA==
X-Google-Smtp-Source: AGHT+IG49HcGTCtHjp/gqQyaVPLeJNvrKP8JWOstEsSJdYTMkvfjTTwAY9rucdhc2Uw/cDJ3y022yZecJO8Ia/R5kok=
X-Received: by 2002:a05:6512:1153:b0:545:e2e:8442 with SMTP id
 2adb3069b0e04-54838c5e21amr862979e87.6.1740142468450; Fri, 21 Feb 2025
 04:54:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220200439.4458-1-ubizjak@gmail.com>
In-Reply-To: <20250220200439.4458-1-ubizjak@gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Fri, 21 Feb 2025 07:54:17 -0500
X-Gm-Features: AWEUYZkU5dmyRPiCPp8sHO86RssObQLw9EhpnmrfPUoMnrLy7NBKvqNXdwyPKYg
Message-ID: <CAMzpN2i8uR7L9DmL1AX1R9p__x5KwAtdey_4iJ5ZP_frTqu9vQ@mail.gmail.com>
Subject: Re: [PATCH -tip] x86/stackprotector: Move stack canary to struct pcpu_hot
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 3:04=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> Move stack canary from __stack_chk_guard to struct pcpu_hot and
> alias __stack_chk_guard to point to the new location in the
> linker script.
>
> __stack_chk_guard is one of the hottest data structures on x86, so
> moving it there makes sense even if its benefit cannot be measured
> explicitly.
>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Brian Gerst <brgerst@gmail.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/include/asm/current.h | 13 +++++++++++++
>  arch/x86/kernel/cpu/common.c   |  1 -
>  arch/x86/kernel/vmlinux.lds.S  |  2 ++
>  3 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/curren=
t.h
> index bf5953883ec3..e4ff1d15b465 100644
> --- a/arch/x86/include/asm/current.h
> +++ b/arch/x86/include/asm/current.h
> @@ -15,6 +15,9 @@ struct task_struct;
>  struct pcpu_hot {
>         union {
>                 struct {
> +#ifdef CONFIG_STACKPROTECTOR
> +                       unsigned long           stack_canary;
> +#endif
>                         struct task_struct      *current_task;
>                         int                     preempt_count;
>                         int                     cpu_number;
> @@ -35,6 +38,16 @@ struct pcpu_hot {
>  };
>  static_assert(sizeof(struct pcpu_hot) =3D=3D 64);
>
> +/*
> + * stack_canary should be at the beginning of struct pcpu_hot to avoid:
> + *
> + * Invalid absolute R_X86_64_32S relocation: __stack_chk_guard

This should be R_X86_64_PC32 relocations.

> + *
> + * error when aliasing __stack_chk_guard to struct pcpu_hot
> + * - see arch/x86/kernel/vmlinux.lds.S.
> + */
> +static_assert(offsetof(struct pcpu_hot, stack_canary) =3D=3D 0);

The simple solution to this is to add the symbol to the whitelist in
tools/relocs.c:
/*
 * These symbols are known to be relative, even if the linker marks them
 * as absolute (typically defined outside any section in the linker script.=
)
 */

 I just got rid of hardcoding fixed_percpu_data from the start of
percpu memory.  I'd rather not add something similar back in.


Brian Gerst

