Return-Path: <linux-kernel+bounces-265451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B2F93F168
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD46A1C21A63
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A67613FD86;
	Mon, 29 Jul 2024 09:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JVzZ9goL"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18873801
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246191; cv=none; b=HpzXMgq7b15du5/rqnWnfYGpoPYSo3hZPir3yd3FNhwHuLQUQ7Z/QOio7rUwLgOx5hTuuBHcXEuip0jeOekxAT9TsjEMOqsvR1HsyZl0SVFWT+b7PHM1UI612b4jp6/JncUpuPmaVSFF6x9fS8o7rqB8aIOTBIj0SKOoYXgFJ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246191; c=relaxed/simple;
	bh=RGb56mY821IGOqIZuwq4G1VfEE5nkMUSqk6/TRosDdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X9DZcYAFolLeWoHm8onLyoHHRIC7OcquA3jP01vrwdkj7C45OlO0o1Zen8sMsKnykdDcLueRB+ZlOdjJutyXa7WiRKD5hyPtixcpLF3JL0MTGPqSytbLgj3tCkpCBaqOZNSy37BaeolMXuBZ9bqcgN8OlepLdcomgDzw8iEpSYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JVzZ9goL; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4928e347ac5so228506137.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 02:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722246189; x=1722850989; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZoJ3ZacNS55oRX7hJpHDUlm+X3SpBJFA/ypVEqbSLQ8=;
        b=JVzZ9goLKBwgcf/odU8UUyyTjmDv3aPsByygTQewmmi5I1giT74MRhepLQ6ky0rYDu
         8cJUd7HmQBVsxMjsCwTwD9wiO2VVls8lT9r7MHyobJ6F7EXJRkayrqYD2Mb+vA7Oot19
         +kneIjKbsH3fgcqg/as/cwjqaTMhbo7ZTzDjUGsJhZOBFQE9mxzweBytAySddKNajvbc
         9D4V6NrI30jclrgtTfY9VqpmkTJil5/fUFtRUFVe33ytMfxufTINOc2adPuQWEkBggkq
         sUUInW3U9aVbrR/frD1UY3FTbfBfdMNSON4GgypnJUPAs3G/GZkExrXlJmNXZCbU70VV
         DIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722246189; x=1722850989;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZoJ3ZacNS55oRX7hJpHDUlm+X3SpBJFA/ypVEqbSLQ8=;
        b=PPV1C6Rl6hzsMyn3x/rWc5iXi0ctq5tPV1UZr/d/NFlQYdEveoHrOXxTSoCLEfjxZb
         GSkeb+Rmpz2j7x2zWDuCm0G9J1uKsRiU3oz99SRQtB2ib5PK4G7auO/ZimEHdi/OxjLG
         eRr7P10MCUOuhTpcBMkASVSZ6Hj2G4DziDy5N0tQ9hCFYlMwb0GI3S4eTVCWBVrNGiOr
         dBDbZ2aCBOsY2sUTOfGA2K7iO6HvY4HUUgo+1HI6OQZj+L2VGkDLfGyUBL0lpQul2kkn
         PhAXxzfmowSqt7SvNYIbxKM/KOuTxNQFigWB/L+YE521h6s4P0PI2CSapoYbXXYpMUnU
         jTnA==
X-Forwarded-Encrypted: i=1; AJvYcCU/Xo2YTMuVf7IAVDtsiGz47QzHxvl7EwYpuPE15NR7KMKHqagc9nc8Zbnu2JwKyZWsE3yZjJ7r6tK6J/eqXhhAsSDbtVNTu5b1ppi6
X-Gm-Message-State: AOJu0YxwGcIDUG+IpdcY+TkxDGUW/zIhOvpztA2UGII1Ve4JPWqjz+Ic
	+BPSjuXrVI9sAjUsySBfRqug319ZglnvOcKjrxGDzLUGlANrkNblV/epWFJS9lmD/EOeIokquAH
	AXyN7T/dnyyZUKFgxbcGXO+xtv5OPLT4CNFBh
X-Google-Smtp-Source: AGHT+IEswDxk0VCMm32cFENqTsoXGj13514gdRwA6aQk9DZX2174YDOKdaN+jZodkccBMjEYKq6GfgKsKv7ISSQQam8=
X-Received: by 2002:a05:6102:c4e:b0:493:d360:6f58 with SMTP id
 ada2fe7eead31-493fad1515dmr3478038137.20.1722246188837; Mon, 29 Jul 2024
 02:43:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729022158.92059-1-andrey.konovalov@linux.dev>
In-Reply-To: <20240729022158.92059-1-andrey.konovalov@linux.dev>
From: Marco Elver <elver@google.com>
Date: Mon, 29 Jul 2024 11:42:30 +0200
Message-ID: <CANpmjNP6ouX1hSayoeOHu7On1DYtPtydFbEQtxoTbsnaE9j77w@mail.gmail.com>
Subject: Re: [PATCH] kcov: properly check for softirq context
To: andrey.konovalov@linux.dev
Cc: Dmitry Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Aleksandr Nogikh <nogikh@google.com>, 
	Alexander Potapenko <glider@google.com>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Marcello Sylvester Bauer <sylv@sylv.io>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+2388cdaeb6b10f0c13ac@syzkaller.appspotmail.com, stable@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jul 2024 at 04:22, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@gmail.com>
>
> When collecting coverage from softirqs, KCOV uses in_serving_softirq() to
> check whether the code is running in the softirq context. Unfortunately,
> in_serving_softirq() is > 0 even when the code is running in the hardirq
> or NMI context for hardirqs and NMIs that happened during a softirq.
>
> As a result, if a softirq handler contains a remote coverage collection
> section and a hardirq with another remote coverage collection section
> happens during handling the softirq, KCOV incorrectly detects a nested
> softirq coverate collection section and prints a WARNING, as reported
> by syzbot.
>
> This issue was exposed by commit a7f3813e589f ("usb: gadget: dummy_hcd:
> Switch to hrtimer transfer scheduler"), which switched dummy_hcd to using
> hrtimer and made the timer's callback be executed in the hardirq context.
>
> Change the related checks in KCOV to account for this behavior of
> in_serving_softirq() and make KCOV ignore remote coverage collection
> sections in the hardirq and NMI contexts.
>
> This prevents the WARNING printed by syzbot but does not fix the inability
> of KCOV to collect coverage from the __usb_hcd_giveback_urb when dummy_hcd
> is in use (caused by a7f3813e589f); a separate patch is required for that.
>
> Reported-by: syzbot+2388cdaeb6b10f0c13ac@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=2388cdaeb6b10f0c13ac
> Fixes: 5ff3b30ab57d ("kcov: collect coverage from interrupts")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
> ---
>  kernel/kcov.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index f0a69d402066e..274b6b7c718de 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -161,6 +161,15 @@ static void kcov_remote_area_put(struct kcov_remote_area *area,
>         kmsan_unpoison_memory(&area->list, sizeof(area->list));
>  }
>
> +/*
> + * Unlike in_serving_softirq(), this function returns false when called during
> + * a hardirq or an NMI that happened in the softirq context.
> + */
> +static inline bool in_softirq_really(void)
> +{
> +       return in_serving_softirq() && !in_hardirq() && !in_nmi();
> +}

Not sure you need this function. Check if just this will give you what you want:

  interrupt_context_level() == 1

I think the below condition could then also just become:

  if (interrupt_context_level() == 1 && t->kcov_softirq)

Although the softirq_count() helper has a special PREEMPT_RT variant,
and interrupt_context_level() doesn't, so it's not immediately obvious
to me if that's also ok on PREEMPT_RT kernels.

Maybe some RT folks can help confirm that using
interrupt_context_level()==1 does what your above function does also
on RT kernels.

>  static notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_struct *t)
>  {
>         unsigned int mode;
> @@ -170,7 +179,7 @@ static notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_stru
>          * so we ignore code executed in interrupts, unless we are in a remote
>          * coverage collection section in a softirq.
>          */
> -       if (!in_task() && !(in_serving_softirq() && t->kcov_softirq))
> +       if (!in_task() && !(in_softirq_really() && t->kcov_softirq))
>                 return false;
>         mode = READ_ONCE(t->kcov_mode);
>         /*
> @@ -849,7 +858,7 @@ void kcov_remote_start(u64 handle)
>
>         if (WARN_ON(!kcov_check_handle(handle, true, true, true)))
>                 return;
> -       if (!in_task() && !in_serving_softirq())
> +       if (!in_task() && !in_softirq_really())
>                 return;
>
>         local_lock_irqsave(&kcov_percpu_data.lock, flags);
> @@ -991,7 +1000,7 @@ void kcov_remote_stop(void)
>         int sequence;
>         unsigned long flags;
>
> -       if (!in_task() && !in_serving_softirq())
> +       if (!in_task() && !in_softirq_really())
>                 return;
>
>         local_lock_irqsave(&kcov_percpu_data.lock, flags);
> --
> 2.25.1
>

