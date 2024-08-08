Return-Path: <linux-kernel+bounces-279828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B921B94C24E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 141A8B22312
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1B318F2FE;
	Thu,  8 Aug 2024 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UwPfqS+1"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777DC8003F
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723133418; cv=none; b=D2NMC4c+dMWxYcC/7WemAfPEAgC64yi/MaS/gYN1QdDQFMsGVbRgNhra71SLq8oXHg4i1gm8ZddNClw6FgXPWViiflQV25iLDQk52S7Ek8cQORRu77k8GEDGWcYImpi75p9T6gTG7WCjKzAjnPifvv9bzh7WqFZXv/RXHlSFU+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723133418; c=relaxed/simple;
	bh=Yg8ZjNWDOo8heW7YXKGR1CnV8a5vIPSEoOnWfg0IpyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WrkGhbTESa3UoxXVNEeLJU0nK88Fs7S35DN8yTN6E8eciYk18aoSz7+zSKgm1XOBUEohPT9i0q6ZqU3f6/W0eUHCYA59ycEsAt/thl5m2mpLM4V9X3cmktzIupT5sexFj+ZQV8LmW+p9szydfCrVf0+Peo5KS+5lYmART1kb7kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UwPfqS+1; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a1d42da3f7so66240085a.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 09:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723133413; x=1723738213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9shKGPom8+7CDuqTBeG4B35Rr+yA0WEcyomuSH9VeXc=;
        b=UwPfqS+1FCV71kuGp4QKphg0T5nAbzBdP6P2BlyNaGrV79dlkYbA3KszNrTwwbZ5LI
         qLpEX1/aN950iZkLFWRkXx8CyIuUHapfkhENJksUEfFxGkhkWhv3bLP2fS00B2cyv5gY
         xK+l4x/5kYww9EyNhc2fR5AY5q/phEiKwo6ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723133413; x=1723738213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9shKGPom8+7CDuqTBeG4B35Rr+yA0WEcyomuSH9VeXc=;
        b=Nwkx9CMVWzEcSl/Hw7nvBB2RHYESzl7EeWtfoJ9BxaJ6FsPhCKrjrCFFkRxz8hkxUC
         LXl8HCHkhZ7PzXVIs0Fc55pUN3HplkUmxwNYgT4+J+FjnWiyT405RIjPxtVV126OY0+C
         8c8Ll4Eodskn/A4uyrreNi5mz3XXA+ZMTcb0VEQRIqkP1kHO8tvRVhLwj7eKiNbzrcpH
         sPMb9UeDK+aAbsewmZYU5KboMFI4f4Xqv/NpEyEW4WlSAmyezCCDp0xhXKEwxr7D6O6r
         jOMuB8kNKpYaZaATOhkrODyvrekMjqPl8Jm/Cx9Og84cuS+bontQbzanCdhBEh3bFRrM
         8ZcA==
X-Forwarded-Encrypted: i=1; AJvYcCUNnMLjqR6mUe3rKTXQn5T7eGo2W/kXg6E3FMuxd+8wIw/+XeZjHULZiO90RS8In7Kggtt29biG87Mn9zXWKYDW0iZAht+VlTITQ0KF
X-Gm-Message-State: AOJu0Yy0jttuNRJXLSdCbCAv4p3BhhuAalk/a3pxxY9LPlk5shLEzOBM
	tigy7w+DaM1i/wSZG+ZVEpaR4d1HInZlMDRgWYeVOEKno5DDsFDLurpXm0riTX5LEioPPFSMZFg
	UVA==
X-Google-Smtp-Source: AGHT+IFeDw/RNXCPAgO158hQEM8JatGc5dZ2XHIa2FuQDu22oVem0T4ZNuE3ZGjoXvt2p9MIprcWuQ==
X-Received: by 2002:a05:620a:2904:b0:79d:6d4a:a964 with SMTP id af79cd13be357-7a3817c97d6mr243545085a.2.1723133413213;
        Thu, 08 Aug 2024 09:10:13 -0700 (PDT)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com. [209.85.160.173])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785f4458sm172899785a.71.2024.08.08.09.10.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 09:10:12 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-44fdc70e695so508251cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 09:10:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXCZX9o7ivCPNMSXc56tkakwhoZVrXK+GKiwEiJ7CYPZUdVOICyvesql2W2hXVPWT7q+wux2oMeFaOV2YozSxwdC4G9mjZWirMU0rdF
X-Received: by 2002:a05:622a:1455:b0:447:d7fd:63f with SMTP id
 d75a77b69052e-451d384af87mr3066911cf.19.1723133411701; Thu, 08 Aug 2024
 09:10:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806022114.3320543-1-yuzhao@google.com> <20240806022114.3320543-3-yuzhao@google.com>
In-Reply-To: <20240806022114.3320543-3-yuzhao@google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 8 Aug 2024 09:09:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UoBEZV6LnickyQGPMcmzRgt8VVSdw7onQPnLPzMQcywQ@mail.gmail.com>
Message-ID: <CAD=FV=UoBEZV6LnickyQGPMcmzRgt8VVSdw7onQPnLPzMQcywQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] arm64: use IPIs to pause/resume remote CPUs
To: Yu Zhao <yuzhao@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>, 
	Frank van der Linden <fvdl@google.com>, Mark Rutland <mark.rutland@arm.com>, 
	Muchun Song <muchun.song@linux.dev>, Nanyong Sun <sunnanyong@huawei.com>, 
	Yang Shi <yang@os.amperecomputing.com>, linux-arm-kernel@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 5, 2024 at 7:21=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> Use pseudo-NMI IPIs to pause remote CPUs for a short period of time,
> and then reliably resume them when the local CPU exits critical
> sections that preclude the execution of remote CPUs.
>
> A typical example of such critical sections is BBM on kernel PTEs.
> HugeTLB Vmemmap Optimization (HVO) on arm64 was disabled by commit
> 060a2c92d1b6 ("arm64: mm: hugetlb: Disable HUGETLB_PAGE_OPTIMIZE_VMEMMAP"=
)
> due to the folllowing reason:
>
>   This is deemed UNPREDICTABLE by the Arm architecture without a
>   break-before-make sequence (make the PTE invalid, TLBI, write the
>   new valid PTE). However, such sequence is not possible since the
>   vmemmap may be concurrently accessed by the kernel.
>
> Supporting BBM on kernel PTEs is one of the approaches that can
> potentially make arm64 support HVO.
>
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>  arch/arm64/include/asm/smp.h |   3 +
>  arch/arm64/kernel/smp.c      | 110 +++++++++++++++++++++++++++++++++++
>  2 files changed, 113 insertions(+)

I'm a bit curious how your approach is reliable / performant in all
cases. As far as I understand it:

1. Patch #4 in your series unconditionally turns on
"ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP" for arm64.

2. In order for it to work reliably, you need the "pause all CPUs"
functionality introduced in this patch.

3. In order for the "pause all CPUs" functionality to be performant
you need NMI or, at least, pseudo-NMI to be used to pause all CPUs.

4. Even when you configure the kernel for pseudo-NMI it's not 100%
guaranteed that pseudo-NMI will be turned on. Specifically:

4a) There's an extra kernel command line parameter you need to
actually enable pseudo-NMI. We can debate about the inability to turn
on pseudo-NMI without the command line parameter, but at the moment
it's there because pseudo-NMI has some performance implications.
Apparently these performance implications are more non-trivial on some
early arm64 CPUs.

4b) Even if we changed it so that the command-line parameter wasn't
needed, there are still some boards out there that are known not to be
able to enable pseudo-NMI. There are certainly some Mediatek
Chromebooks that have a BIOS bug making pseudo-NMI unreliable. See the
`mediatek,broken-save-restore-fw` device tree property. ...and even if
you ignore the Mediatek Chromebooks, there's at least one more system
I know of that's broken with pseudo-NMI. Since you're at Google, you
could look at b/308278090 for details but the quick summary is that
some devices running a TEE are hanging when pseudo NMI is enabled.
...and, even if that's fixed, it feels somewhat likely that there are
other systems where pseudo-NMI won't be usable.


Unless I'm misunderstanding, it feels like anything you have that
relies on NMI/pseudo-NMI needs to fall back safely/reliably if
NMI/pseudo-NMI isn't there.


> diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
> index 2510eec026f7..cffb0cfed961 100644
> --- a/arch/arm64/include/asm/smp.h
> +++ b/arch/arm64/include/asm/smp.h
> @@ -133,6 +133,9 @@ bool cpus_are_stuck_in_kernel(void);
>  extern void crash_smp_send_stop(void);
>  extern bool smp_crash_stop_failed(void);
>
> +void pause_remote_cpus(void);
> +void resume_remote_cpus(void);
> +
>  #endif /* ifndef __ASSEMBLY__ */
>
>  #endif /* ifndef __ASM_SMP_H */
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 5e18fbcee9a2..aa80266e5c9d 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -68,16 +68,25 @@ enum ipi_msg_type {
>         IPI_RESCHEDULE,
>         IPI_CALL_FUNC,
>         IPI_CPU_STOP,
> +       IPI_CPU_PAUSE,
> +#ifdef CONFIG_KEXEC_CORE
>         IPI_CPU_CRASH_STOP,
> +#endif
> +#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
>         IPI_TIMER,
> +#endif
> +#ifdef CONFIG_IRQ_WORK
>         IPI_IRQ_WORK,
> +#endif

I assume all these "ifdefs" are there because this adds up to more
than 8 IPIs. That means that someone wouldn't be able to enable all of
these things, right? Feels like we'd want to solve this before landing
things. In the least it would be good if this built upon:

https://lore.kernel.org/r/20240625160718.v2.1.Id4817adef610302554b8aa42b090=
d57270dc119c@changeid/

...and then maybe we could figure out if there are other ways to
consolidate NMIs. Previously, for instance, we had the "KGDB" and
"backtrace" IPIs combined into one but we split them upon review
feedback. If necessary they would probably be easy to re-combine.

