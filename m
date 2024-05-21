Return-Path: <linux-kernel+bounces-184493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB65B8CA76B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 06:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 243A91C212D6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 04:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4EC2E85A;
	Tue, 21 May 2024 04:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SlAmuSfl"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCBC219FD
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 04:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716266155; cv=none; b=DI+E+SisKeAFTkR4Jn16nDjwNGwaBhekGTyxUElMyk4uh0QBSD2Vt6fYg3IGa9xX7PHsT2R6i1SvJvAKmctsBG29e0qLUN3ki4dcOoA3lkxEvbGtiypaXClU8M4CuyMr1LhOSCCWxoKn9WtARLHK31hyvW1rJjuy46zWlzp/ThI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716266155; c=relaxed/simple;
	bh=oIb1+7uh+06Z+q5AS8/+QPd2zvTrWldoSW9ItO1LXn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i0WkqqPmtF+T1UXEAdnW41cvn9lwi8VdsicKZs+yscBBblQbISiHx27uGmTpJsCCABDDd7BSX7ogQG+kHWswYHXkQ4kShzFli5cGAzSk3AsO4nFKgMPBM7Q5zXJAlbbNwimrb8apxL4oHjNNrYhX0t9zjbY4qrXeEnwFQ+asvKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SlAmuSfl; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-518948e1ec8so7931e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 21:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716266150; x=1716870950; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bu1zy9E7az32y56EOjWw+O7OSWd3qh6SwlhX3MCkEJU=;
        b=SlAmuSflaDC56/H5Imkc/qHy6MqN19TMm/Qz1qkLktNAGFFMfkmf7uAKoH7U/JjF+y
         cjJmjfh2mL40bldWKMRAFYSI7rDer49yTtIrOS80nGkfm4jGaAkYmidCx5OG7aZlBdK/
         aQQifmzMEJ3DPlG7nnoYBsFhS/GA4PFSUacXUJJwdMVi+SzjpFfHfhSQ/AcVFLL6hZHp
         /6SuWiVHmvyOKKgyS/nxMFCopv+iFTE6PMTrzL1uT+y7ZxhVhJnwKbTD4DONIZ3ZEa7q
         2AV7Q8MmVDnywGiCRFfvnhrs6plibrsKX/VwuOUVsAr08eUSnxVSQAj6rauvRWpGnn8C
         AzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716266150; x=1716870950;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bu1zy9E7az32y56EOjWw+O7OSWd3qh6SwlhX3MCkEJU=;
        b=VMq4BOKqccd3BOfX6BOyv3TAofYsNq7CmaJD1EwXSyad1N3qQ/LAdXH3AsKSMLFsez
         X+p1wxYnUxcHyJtba7rGPbcX/HgAN7IHfrebjvTvAb5qBUMSfKbncMU+YRbbLSrMRk4C
         10+fN8RMQHnEx4kirGe140yhhHVxxEIlqZUwLVwK+xh1dOYtGdVm78GcK/qNNc+92UAL
         8DPaGKvt9h5pGI34qhYaNjF7rdcM0XU0QG7sJevC+37ZaotnQX44gQAUPpXklZ9n4Nn+
         LrjXVob3kBsswlTKboR5ehFOBzRzd8nVYziMGGCzlkTWXYxz2Jzqu9rKsIMP8rEu3iZv
         XACg==
X-Forwarded-Encrypted: i=1; AJvYcCUwC7XcR7vCo/QBWup9yugJnqMKdH9RkCQG0LGHgNQhHHHraiVV7TTdPqQTcZsVUY1EPtB/q5gk/I3ku2sZhewAH1U6SBVYJducq3YW
X-Gm-Message-State: AOJu0Yz4A/Bc7GbGpu31HcBMGb0lGzQ5RXmbGh62pPR5T/DltTUy1UBK
	kVribcwv6SVUAcD/xvytdjUsZjM+vdARD59Te8Oy0klbIpLCMXNAIK3+3wFFZBHewSmHvTDPL4j
	SoXScUeDjwhBfzwJ8aY/dpNOwDp43uWvKeQnB
X-Google-Smtp-Source: AGHT+IFu3a7msPa74eUvIkK+T+tLgcRjbGiXR5HJUfRYCvJ6PIcMJ5a6SHnY++ijLVp/Kk+pLKbCsgusXSOXBkUSEhk=
X-Received: by 2002:a05:6512:3a9:b0:523:69f8:ead with SMTP id
 2adb3069b0e04-5240a1004e9mr297353e87.1.1716266150078; Mon, 20 May 2024
 21:35:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520205856.162910-1-andrey.konovalov@linux.dev>
In-Reply-To: <20240520205856.162910-1-andrey.konovalov@linux.dev>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 21 May 2024 06:35:37 +0200
Message-ID: <CACT4Y+bO03Efd48XW7V6F2D9FMUoWytV8L9BL8OK2DR8scJgmQ@mail.gmail.com>
Subject: Re: [PATCH] kcov, usb: disable interrupts in kcov_remote_start_usb_softirq
To: andrey.konovalov@linux.dev
Cc: Alan Stern <stern@rowland.harvard.edu>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Marco Elver <elver@google.com>, Alexander Potapenko <glider@google.com>, kasan-dev@googlegroups.com, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Tejun Heo <tj@kernel.org>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 May 2024 at 22:59, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@gmail.com>
>
> After commit 8fea0c8fda30 ("usb: core: hcd: Convert from tasklet to BH
> workqueue"), usb_giveback_urb_bh() runs in the BH workqueue with
> interrupts enabled.
>
> Thus, the remote coverage collection section in usb_giveback_urb_bh()->
> __usb_hcd_giveback_urb() might be interrupted, and the interrupt handler
> might invoke __usb_hcd_giveback_urb() again.
>
> This breaks KCOV, as it does not support nested remote coverage collection
> sections within the same context (neither in task nor in softirq).
>
> Update kcov_remote_start/stop_usb_softirq() to disable interrupts for the
> duration of the coverage collection section to avoid nested sections in
> the softirq context (in addition to such in the task context, which are
> already handled).

Besides the issue pointed by the test robot:

Acked-by: Dmitry Vyukov <dvyukov@google.com>

Thanks for fixing this.

This section of code does not rely on reentrancy, right? E.g. one
callback won't wait for completion of another callback?

At some point we started seeing lots of "remote cover enable write
trace failed (errno 17)" errors while running syzkaller. Can these
errors be caused by this issue?


> Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Closes: https://lore.kernel.org/linux-usb/0f4d1964-7397-485b-bc48-11c01e2fcbca@I-love.SAKURA.ne.jp/
> Closes: https://syzkaller.appspot.com/bug?extid=0438378d6f157baae1a2
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Fixes: 8fea0c8fda30 ("usb: core: hcd: Convert from tasklet to BH workqueue")
> Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
> ---
>  drivers/usb/core/hcd.c | 12 +++++++-----
>  include/linux/kcov.h   | 44 +++++++++++++++++++++++++++++++++---------
>  2 files changed, 42 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index c0e005670d67..fb1aa0d4fc28 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -1623,6 +1623,7 @@ static void __usb_hcd_giveback_urb(struct urb *urb)
>         struct usb_hcd *hcd = bus_to_hcd(urb->dev->bus);
>         struct usb_anchor *anchor = urb->anchor;
>         int status = urb->unlinked;
> +       unsigned long flags;
>
>         urb->hcpriv = NULL;
>         if (unlikely((urb->transfer_flags & URB_SHORT_NOT_OK) &&
> @@ -1640,13 +1641,14 @@ static void __usb_hcd_giveback_urb(struct urb *urb)
>         /* pass ownership to the completion handler */
>         urb->status = status;
>         /*
> -        * This function can be called in task context inside another remote
> -        * coverage collection section, but kcov doesn't support that kind of
> -        * recursion yet. Only collect coverage in softirq context for now.
> +        * Only collect coverage in the softirq context and disable interrupts
> +        * to avoid scenarios with nested remote coverage collection sections
> +        * that KCOV does not support.
> +        * See the comment next to kcov_remote_start_usb_softirq() for details.
>          */
> -       kcov_remote_start_usb_softirq((u64)urb->dev->bus->busnum);
> +       flags = kcov_remote_start_usb_softirq((u64)urb->dev->bus->busnum);
>         urb->complete(urb);
> -       kcov_remote_stop_softirq();
> +       kcov_remote_stop_softirq(flags);
>
>         usb_anchor_resume_wakeups(anchor);
>         atomic_dec(&urb->use_count);
> diff --git a/include/linux/kcov.h b/include/linux/kcov.h
> index b851ba415e03..ebcfc271aee3 100644
> --- a/include/linux/kcov.h
> +++ b/include/linux/kcov.h
> @@ -55,21 +55,47 @@ static inline void kcov_remote_start_usb(u64 id)
>
>  /*
>   * The softirq flavor of kcov_remote_*() functions is introduced as a temporary
> - * work around for kcov's lack of nested remote coverage sections support in
> - * task context. Adding support for nested sections is tracked in:
> - * https://bugzilla.kernel.org/show_bug.cgi?id=210337
> + * workaround for KCOV's lack of nested remote coverage sections support.
> + *
> + * Adding support is tracked in https://bugzilla.kernel.org/show_bug.cgi?id=210337.
> + *
> + * kcov_remote_start_usb_softirq():
> + *
> + * 1. Only collects coverage when called in the softirq context. This allows
> + *    avoiding nested remote coverage collection sections in the task context.
> + *    For example, USB/IP calls usb_hcd_giveback_urb() in the task context
> + *    within an existing remote coverage collection section. Thus, KCOV should
> + *    not attempt to start collecting coverage within the coverage collection
> + *    section in __usb_hcd_giveback_urb() in this case.
> + *
> + * 2. Disables interrupts for the duration of the coverage collection section.
> + *    This allows avoiding nested remote coverage collection sections in the
> + *    softirq context (a softirq might occur during the execution of a work in
> + *    the BH workqueue, which runs with in_serving_softirq() > 0).
> + *    For example, usb_giveback_urb_bh() runs in the BH workqueue with
> + *    interrupts enabled, so __usb_hcd_giveback_urb() might be interrupted in
> + *    the middle of its remote coverage collection section, and the interrupt
> + *    handler might invoke __usb_hcd_giveback_urb() again.
>   */
>
> -static inline void kcov_remote_start_usb_softirq(u64 id)
> +static inline unsigned long kcov_remote_start_usb_softirq(u64 id)
>  {
> -       if (in_serving_softirq())
> +       unsigned long flags = 0;
> +
> +       if (in_serving_softirq()) {
> +               local_irq_save(flags);
>                 kcov_remote_start_usb(id);
> +       }
> +
> +       return flags;
>  }
>
> -static inline void kcov_remote_stop_softirq(void)
> +static inline void kcov_remote_stop_softirq(unsigned long flags)
>  {
> -       if (in_serving_softirq())
> +       if (in_serving_softirq()) {
>                 kcov_remote_stop();
> +               local_irq_restore(flags);
> +       }
>  }
>
>  #ifdef CONFIG_64BIT
> @@ -103,8 +129,8 @@ static inline u64 kcov_common_handle(void)
>  }
>  static inline void kcov_remote_start_common(u64 id) {}
>  static inline void kcov_remote_start_usb(u64 id) {}
> -static inline void kcov_remote_start_usb_softirq(u64 id) {}
> -static inline void kcov_remote_stop_softirq(void) {}
> +static inline unsigned long kcov_remote_start_usb_softirq(u64 id) {}
> +static inline void kcov_remote_stop_softirq(unsigned long flags) {}
>
>  #endif /* CONFIG_KCOV */
>  #endif /* _LINUX_KCOV_H */
> --
> 2.25.1
>

