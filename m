Return-Path: <linux-kernel+bounces-223628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B51859115B9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 00:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D779E1C221DE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EFE13777F;
	Thu, 20 Jun 2024 22:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EpJG02OZ"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423F155880
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 22:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718922425; cv=none; b=t0sT7Hchg8pEDiYa7fj+5+OhbirIvF4SBuaLSEYIaX2sWRdgjhqCid9acw3LA0cbDzQRCuUiU3VAVJHj70zMUvkQ/FX8RX+nx0S5Ap7ttu80iXaJ8wTidwxNDg94qUWFUy1W3yMihJ8qDj3NUUzOZ8+/8nGO368xR9tiUlt+jrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718922425; c=relaxed/simple;
	bh=pGNaopACUYYHsOMoxW/mbJ43qGuxp2QbW8pwqwjs5Oo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A/eHc8irytyyLpdAZviqk8f8863wB7fZnkxZdNgoODiZezfCxy6A+6jBTNakCW3dlSHFh7RmuTELoLGifGLxMAz0injMFpSY0IqYDy7ZjYtoklxjRPVgnQ4Loi/XlrIMViF+x5cpwUnyOzf3l4oNDETnyuACGN3jOPZutgBxvZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EpJG02OZ; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-63bf3452359so14244857b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 15:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718922421; x=1719527221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EzdFJfzdHX4fxEYrmnqjujELtIjoZxiiSu3te+CIyHA=;
        b=EpJG02OZ4OM4LFlFzEFbXkjA6yaI5r4juWuxoqJ9c3NdCCi/Uia/M7vePW9aJ0E3qf
         AklXsunRJJ6o51LBl2N0tjUfWM82M786sEMtEqQy499mZeWXW3coTry5JJxZqq9WeTY4
         kyGPppsfvVvo9HanpLRl1ssOwxf0a6Vs0TNqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718922421; x=1719527221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EzdFJfzdHX4fxEYrmnqjujELtIjoZxiiSu3te+CIyHA=;
        b=xQU73F4krbu38qeywBDLLTLJb9a+KdDbYa370Gy8iI94MySQO7HV0XLxHjX6JzfoDc
         p7KGlPZiOH00G6dB0EZuFdMPqJ/ReIaKJsr862vd0LYj3wXs/Bq5BHirMO9yP9OsVWD9
         uYzl8jnxbHaq/qbCtFJJ75V7T2OiCKY4Uy+3bO9SKd7y8aKy5T4cuSOy0zsV0Fytd9Gs
         hkyJM46qpcpo/sb8OnrUGU3mKX/Aiy0O7WOjGCH8EpK3E47newoqy+zUygs+qqvKP45P
         nwR3J7nlhGouiK6YMUAA/ibJ9tsXwYXUEFbrnkERA3u/v5lg2AE+XmpcQyr0N7TvIjr7
         KJZA==
X-Forwarded-Encrypted: i=1; AJvYcCXIDUQZS8c9emIKicx/TJNWFMWSRZVC3Gpbqefh0/f52aF5BZUA7o+JigfZ3m28QGMI2D6TF0HZBxpLiRAEzkINC3R+qbC/5MwKytef
X-Gm-Message-State: AOJu0YyuyBl6v/97x65kUocZWI1n7J1Ru/kZuhGpV4WoTexelZ0iH7Yj
	BE3+ZPs3I1yunlV0Q2rlUDrKCzFgagmV++4V8ytHkrXbk5bDexjM6CN/w7ugpF3E4JMteyuHvsQ
	=
X-Google-Smtp-Source: AGHT+IFkm0XA8FNLpBbzXx29OS4TK1kfwUb5sx8mUuDmIa6vrZK7sTjhjp4xmj6GqUD8UU/NUfenhw==
X-Received: by 2002:a05:690c:c8d:b0:63b:c16e:a457 with SMTP id 00721157ae682-63bc16ea5bemr49400087b3.13.1718922420440;
        Thu, 20 Jun 2024 15:27:00 -0700 (PDT)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com. [209.85.160.169])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ef30d53sm883376d6.81.2024.06.20.15.26.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 15:26:59 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-443580f290dso49531cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 15:26:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXuHf3KVvoN+JQIlHiUNoQ8PBYcxe1ABOQVQDbAPOQ7/ZqKrOSRxsdlifvKCJMRmHrq4yhAks8HY4eZkZN0IJayeI+jhA5G9VObhGuY
X-Received: by 2002:ac8:7c43:0:b0:444:938e:5ce0 with SMTP id
 d75a77b69052e-444c1775541mr1333581cf.0.1718922418815; Thu, 20 Jun 2024
 15:26:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620063417.573467-1-ruanjinjie@huawei.com>
In-Reply-To: <20240620063417.573467-1-ruanjinjie@huawei.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 20 Jun 2024 15:26:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UvwopskN3J_dhHsna143uG=Dh0YO=NO+9DHX-a4t7+RA@mail.gmail.com>
Message-ID: <CAD=FV=UvwopskN3J_dhHsna143uG=Dh0YO=NO+9DHX-a4t7+RA@mail.gmail.com>
Subject: Re: [PATCH] arm64: smp: Fix missing IPI statistics
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
	swboyd@chromium.org, sumit.garg@linaro.org, frederic@kernel.org, 
	scott@os.amperecomputing.com, misono.tomohiro@fujitsu.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 19, 2024 at 11:31=E2=80=AFPM Jinjie Ruan <ruanjinjie@huawei.com=
> wrote:
>
> commit 83cfac95c018 ("genirq: Allow interrupts to be excluded from
> /proc/interrupts") is to avoid IPIs appear twice in /proc/interrupts.
> But the commit 331a1b3a836c ("arm64: smp: Add arch support for backtrace
> using pseudo-NMI") and commit 2f5cd0c7ffde("arm64: kgdb: Implement
> kgdb_roundup_cpus() to enable pseudo-NMI roundup") set CPU_BACKTRACE and
> KGDB_ROUNDUP IPIs "IRQ_HIDDEN" flag but not show them in
> arch_show_interrupts(), which cause the interrupt kstat_irqs accounting
> is missing in display.
>
> Before this patch, CPU_BACKTRACE and KGDB_ROUNDUP IPIs are missing:
>         / # cat /proc/interrupts
>                    CPU0       CPU1       CPU2       CPU3
>          11:        466        600        309        332     GICv3  27 Le=
vel     arch_timer
>          13:         24          0          0          0     GICv3  33 Le=
vel     uart-pl011
>          15:         64          0          0          0     GICv3  78 Ed=
ge      virtio0
>          16:          0          0          0          0     GICv3  79 Ed=
ge      virtio1
>          17:          0          0          0          0     GICv3  34 Le=
vel     rtc-pl031
>          18:          3          3          3          3     GICv3  23 Le=
vel     arm-pmu
>          19:          0          0          0          0 9030000.pl061   =
3 Edge      GPIO Key Poweroff
>         IPI0:         7         14          9         26       Rescheduli=
ng interrupts
>         IPI1:       354         93        233        255       Function c=
all interrupts
>         IPI2:         0          0          0          0       CPU stop i=
nterrupts
>         IPI3:         0          0          0          0       CPU stop (=
for crash dump) interrupts
>         IPI4:         0          0          0          0       Timer broa=
dcast interrupts
>         IPI5:         1          0          0          0       IRQ work i=
nterrupts
>         Err:          0
>
> After this pacth, CPU_BACKTRACE and KGDB_ROUNDUP IPIs are displayed:
>         / # cat /proc/interrupts
>                    CPU0       CPU1       CPU2       CPU3
>          11:        393        281        532        449     GICv3  27 Le=
vel     arch_timer
>          13:         15          0          0          0     GICv3  33 Le=
vel     uart-pl011
>          15:         64          0          0          0     GICv3  78 Ed=
ge      virtio0
>          16:          0          0          0          0     GICv3  79 Ed=
ge      virtio1
>          17:          0          0          0          0     GICv3  34 Le=
vel     rtc-pl031
>          18:          2          2          2          2     GICv3  23 Le=
vel     arm-pmu
>          19:          0          0          0          0 9030000.pl061   =
3 Edge      GPIO Key Poweroff
>         IPI0:        11         19          4         23       Rescheduli=
ng interrupts
>         IPI1:       279        347        222         72       Function c=
all interrupts
>         IPI2:         0          0          0          0       CPU stop i=
nterrupts
>         IPI3:         0          0          0          0       CPU stop (=
for crash dump) interrupts
>         IPI4:         0          0          0          0       Timer broa=
dcast interrupts
>         IPI5:         1          0          0          1       IRQ work i=
nterrupts
>         IPI6:         0          0          0          0       CPU backtr=
ace interrupts
>         IPI7:         0          0          0          0       KGDB round=
up interrupts
>         Err:          0
>
> Fixes: 331a1b3a836c ("arm64: smp: Add arch support for backtrace using ps=
eudo-NMI")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Suggested-by: Doug Anderson <dianders@chromium.org>
> ---
> v2:
> - Report them in arch_show_interrupts().
> - Add suggested-by.
> - Update the commit message.
> ---
>  arch/arm64/kernel/smp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Personally I don't find a ton of value in having the "CPU backtrace
interrupts" and "KGDB roundup interrupts" reported, but I agree that
if someone does find value in having them reported that this is the
best way. I guess that means a light:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

