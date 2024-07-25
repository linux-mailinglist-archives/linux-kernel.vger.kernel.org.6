Return-Path: <linux-kernel+bounces-261945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB8893BE1A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D11AF1C2147D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40A318734B;
	Thu, 25 Jul 2024 08:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malat-biz.20230601.gappssmtp.com header.i=@malat-biz.20230601.gappssmtp.com header.b="PSLj8cAP"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E68185E6E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721897046; cv=none; b=iBnMkUzOH4RN24w9NUNzeeKlqmcyzruSIVXx64lzu16EcMyA5YEiPNyMcd6IsbulrZKZo7gAKVUY2a16t5yadt8XYxK0idVTgdXqHnyrd0CGklVLwiL1af9z4jWxSqtqnlUhru1qu9qu1c7xDiYCYPJeg1Q30g7WwjE8S11teHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721897046; c=relaxed/simple;
	bh=3hVeBhN9VSB963WnZaQ0faB+MHj3ceuavhmYsB/pXJM=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R40py7nzQ0VrdL/T4dzc+qsfB+F5mrgR0iFMdTwt/1bVSHNjI3gyPuj5DNLq3tbPpFqpHMwbLK85bHWv6hc15WOf5IjEXZTjHi7rm4dpi9G70wpCkGOj0sc7RaG7lhWSYqQ8/3yapB6Si0dU54NChp+6ESnCU0brCYfL09QC3xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=malat.biz; spf=none smtp.mailfrom=malat.biz; dkim=pass (2048-bit key) header.d=malat-biz.20230601.gappssmtp.com header.i=@malat-biz.20230601.gappssmtp.com header.b=PSLj8cAP; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=malat.biz
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=malat.biz
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4f51981b1beso279324e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 01:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20230601.gappssmtp.com; s=20230601; t=1721897042; x=1722501842; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UWFT391akSNblu6fAi7D/G8rVMoKUwNF/to8pwyoEQo=;
        b=PSLj8cAPZa8PMn1kNrFoBHGAEb8ow/veaervMne8WWf7deWwaiDGDC6oWJAw5uGRKk
         bBT4fI2xKadxwnBZ8HrhSjh51Sc+9oADp9KZoCHMID0+SnwHnC/1go+NiIv6E+rH0dGV
         5/TxvQ4Q9DxNHZYz9QNDAvn0ZhXqb6NCrJRM/H3gtn0BHkkerGe/L2+giTW0wYE/hwIS
         8UkfjKiESMuWprCr5gefpGUIdmr+rIeVFyYz1gMt0afefEnyL/8zy06rG4LB5JpkNdxq
         oy18GiwMhrfqK7+A8uRMn6N9Qg2K5BhEWcwLLNCKE8M8N5KJsvCwokmuaruvTiEsYU1J
         /hvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721897042; x=1722501842;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UWFT391akSNblu6fAi7D/G8rVMoKUwNF/to8pwyoEQo=;
        b=VE9KxDk8L3sW7cVSoYfRlOO1t7ivqlELi/HN2nUlo3TlO98Pn6Ej7VASl5km3frmtK
         lcGjukirGhZOO6a1+Psp028Lb+ybXwrPQ/cYH5Q/qntGWPE7wXj8RZfk8AzpbpvUGt2a
         3Nw8i9E8S0ig5Fitne5syMZubtOQW7OIXLdaZZJwIwigS2Y/roKDQ6RG2kmRWih8Pb+n
         cifYdpgJzK9Rs4nMwAI91R2j0kbSUBzmpSC7s7wMpwkhI9D2XKL6AF/7M9pb0JxHW+Sr
         f9WdacdU6AMDkWUu5Ij/vszBzJ3WNFEHvhmzRuI1U+b9pkP9bXHqRIrO1ZGYJQfcvzQU
         fIXA==
X-Gm-Message-State: AOJu0Yy8+F3/lTPOV5vKARjOy05M4x5zRN7YQYCZ9h5YKHsLFvrg7whD
	KLNt/SwqqGtrJGtWL/9oG1Yeg3aDUiCn70lJUG8hLMOL12IEp7WjcJy1b3tt5EDXasVTlrhb/6I
	LYHSktxvrp8TaNTpWijovH9kNMaehYzLGJkLO
X-Google-Smtp-Source: AGHT+IE/Wg2FcrODxfY9y3PClDBxVOGquMnyzXy6QATUqLhu5dUYwNbdTeKiT15QXGx4Vmn/Asovl4prMqHvZfm9X9o=
X-Received: by 2002:a05:6102:292c:b0:493:dee7:9b8e with SMTP id
 ada2fe7eead31-493dee79daamr277261137.7.1721897042581; Thu, 25 Jul 2024
 01:44:02 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 25 Jul 2024 08:44:02 +0000
From: Petr Malat <oss@malat.biz>
References: <20230306154548.655799-1-oss@malat.biz> <20230308091458.Q42uCjR2@linutronix.de>
 <ZAnZKoH38Telq1qG@ntb.petris.klfree.czf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZAnZKoH38Telq1qG@ntb.petris.klfree.czf>
Date: Thu, 25 Jul 2024 08:44:02 +0000
Message-ID: <CANMuvJk95Ui09wZ89OrjJeOF5ySx5xO4+sS5Nd8af2wgaXgt=w@mail.gmail.com>
Subject: Re: [PATCH] softirq: Do not loop if running under a real-time task
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, paulmck@kernel.org, tglx@linutronix.de, 
	nsaenzju@redhat.com, frederic@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Sebastian,
what is the status of this softirq issue? By looking on the current
upstream code, I think the problem is still there. I can resend my
patch or rework it to use independent task struct flag to decide if
softirq processing should be skipped in the current thread.
BR,
  Petr

On Thu, Mar 09, 2023 at 02:03:38PM +0100, Petr Malat wrote:
> On Wed, Mar 08, 2023 at 10:14:58AM +0100, Sebastian Andrzej Siewior wrote:
> > On 2023-03-06 16:45:48 [+0100], Petr Malat wrote:
> > > Softirq processing can be a source of a scheduling jitter if it executes
> > > in a real-time task as in that case need_resched() is false unless there
> > > is another runnable task with a higher priority. This is especially bad
> > > if the softirq processing runs in a migration thread, which has priority
> > > 99 and usually runs for a short time.
> > >
> > > One option would be to not restart the softirq processing if there is
> > > another runnable task to allow the high prio task to finish and yield the
> > > CPU, the second one is to not restart if softirq executes in a real-time
> > > task. Usually, real-time tasks don't want to be interrupted, so implement
> > > the second option.
> >
> > This affects only PEEMPT_RT, right?
> I have observed the issue on 5.15 CONFIG_PREEMPT=y arm32 kernel.
>
> > I have plans to redo parts of it. You shouldn't enter ksoftirqd to be
> > begin with. There is this ktimerd in v6.1 which mitigates this to some
> > point and I plan to extend it to also cover the sched-softirq.
> > Other than that, you are right in saying that the softirq must not
> > continue with a RT prio and that need_resched() is not visible here.
> > However ksoftirqd itself must be able to do loops unless the
> > need-resched flag is seen.
> >
> > Since you mentioned migration thread, how ofter to you see this or how
> > does this trigger?
> I have seen only one occurrence, where I have a back trace available
> (from hundreds systems). I think that's because on my system it may occur
> only if it hits the migration thread, otherwise there are more runable
> threads of the same priority and need_resched() breaks the loop.
>
> I obtained the stack trace by making a debugging module which uses a
> periodic timer to monitor active tasks and it dumps stack when it finds
> something fishy. This is what I got:
>  [<bf84f559>] (hogger_handler [hogger]) from [<c04850ef>] (__hrtimer_run_queues+0x13f/0x2f4)
>  [<c04850ef>] (__hrtimer_run_queues) from [<c04858a5>] (hrtimer_interrupt+0xc9/0x1c4)
>  [<c04858a5>] (hrtimer_interrupt) from [<c0810533>] (arch_timer_handler_phys+0x27/0x2c)
>  [<c0810533>] (arch_timer_handler_phys) from [<c046de3b>] (handle_percpu_devid_irq+0x5b/0x1e4)
>  [<c046de3b>] (handle_percpu_devid_irq) from [<c0469a27>] (__handle_domain_irq+0x53/0x94)
>  [<c0469a27>] (__handle_domain_irq) from [<c041e501>] (axxia_gic_handle_irq+0x16d/0x1bc)
>  [<c041e501>] (axxia_gic_handle_irq) from [<c0400ad3>] (__irq_svc+0x53/0x94)
>  Exception stack(0xc1595ca8 to 0xc1595cf0)
>  [<c0400ad3>] (__irq_svc) from [<c098e404>] (_raw_spin_unlock_irqrestore+0x1c/0x3c)
>  [<c098e404>] (_raw_spin_unlock_irqrestore) from [<c0446b6d>] (try_to_wake_up+0x1d9/0x5d0)
>  [<c0446b6d>] (try_to_wake_up) from [<c0483d2d>] (call_timer_fn+0x31/0x16c)
>  [<c0483d2d>] (call_timer_fn) from [<c048406f>] (run_timer_softirq+0x207/0x2d4)
>  [<c048406f>] (run_timer_softirq) from [<c0401293>] (__do_softirq+0xd3/0x2f8)
>  [<c0401293>] (__do_softirq) from [<c042876b>] (irq_exit+0x57/0x78)
>  [<c042876b>] (irq_exit) from [<c0469a2b>] (__handle_domain_irq+0x57/0x94)
>  [<c0469a2b>] (__handle_domain_irq) from [<c041e501>] (axxia_gic_handle_irq+0x16d/0x1bc)
>  [<c041e501>] (axxia_gic_handle_irq) from [<c0400ad3>] (__irq_svc+0x53/0x94)
>  Exception stack(0xc1595e78 to 0xc1595ec0)
>  [<c0400ad3>] (__irq_svc) from [<c044d37c>] (active_load_balance_cpu_stop+0x1ec/0x234)
>  [<c044d37c>] (active_load_balance_cpu_stop) from [<c04ac099>] (cpu_stopper_thread+0x69/0xd8)
>  [<c04ac099>] (cpu_stopper_thread) from [<c0440b53>] (smpboot_thread_fn+0x9f/0x17c)
>  [<c0440b53>] (smpboot_thread_fn) from [<c043ccf9>] (kthread+0x129/0x12c)
>  [<c043ccf9>] (kthread) from [<c0400131>] (ret_from_fork+0x11/0x20)
>
> I was then looking into the code how it could happen softirqs were not
> offloaded to the thread and the only explanation I have is what I described
> in the original mail.
> BR,
>   Petr

