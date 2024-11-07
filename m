Return-Path: <linux-kernel+bounces-399893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB959C05EB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E187AB21E0A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38891DBB37;
	Thu,  7 Nov 2024 12:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0uKlMri"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573881DE8BF
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 12:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730983025; cv=none; b=oO4B2fYDDGkrIZYdwbCprGrlFMJAg780+EQAZosZCeuZSgWNmZQY3bO51ByphDQ2HEb7ffXShm+bwodSNwLLGvjFrtuP5tU+D2MoSO2Cp5CUs/awJzGR8q4mGJvpXoQG76g2scmYtKoVqhYjOwkinDKXve8rukuXYwPuuya2xwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730983025; c=relaxed/simple;
	bh=MEsj55o4EmkgBfjC1zpGgfB0Zs8cxzdmgxLbp413KQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bCzdezHtNvzg94TGmwLWOrQ7gf4WDiGgvBG/fZ6G8bFY/wuyuVkixGCCb5Nc7MpzyqK6O1KG/JFEU5lof5wnwi1Awu9f7y5XbpB8Iy1Ie91rlEjuFo25udvgZ4vMBkuSm6BOq0D/95KgzDByeIvfy+VfaXayjefYq/B6W20I3V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0uKlMri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C54C4CECE
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 12:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730983025;
	bh=MEsj55o4EmkgBfjC1zpGgfB0Zs8cxzdmgxLbp413KQ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=D0uKlMrihjD6SH+yHSlQKLZ/lJHqeDkReZLPPHkGv0YJP2cfLD4WVEKWsjke0qunV
	 9uC5gcfB0GfvVkoiuoF3zePr6BL8R64v7cnbRcrmt5SQmU66lZwKsbV9ZtCJd/xwR3
	 UpDOEb7AQ9ZO+Pgwy7d4ojuzG1GRdyblaFJmKKjzzFx0DrkCvDtQNEo2d3DLhAwrWU
	 KzZ7Kh6GgYTaDwvh31iNdQwKDl5nJ9s5hfnODEBrB5RMnhkn9j2juP+K+NXEKcP3l7
	 soHdrzK2JsBvegwiJsUqxNxRFDon9WeVZZkaAc+uQnyKXmJ7iTRRABGokKez+vhmbz
	 +gGG7T34rI4Yw==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9a4031f69fso151049766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 04:37:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXAZL/nTm6GKEbJ20H/yJYfdnxBIe1zptWhMGd6zzuPvkq0oLJ6G2a1Wu/gTgdRhw5bn4Jbl73ssG54428=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf0qV5Xjo089e63C+TEmwgd+7H01u6SG857PktFeEf30/smHTf
	iDhEWcpRIrtPotPuMtqC0rezHjfAxIjzYRuMsFM+NgQmELHrsslE5NShPh/D/3BnIYJlXNnSX8x
	fy9rO8vgyfwCbTFxb141AuGt365M=
X-Google-Smtp-Source: AGHT+IF2RysN7UesHkecrcQUjZMLfbPdk1ZD/VYBHVdqfIKntBEjsJMrZFtwhFzLz5Rln5WwAQu3UDOD5S5nng3nnRE=
X-Received: by 2002:a17:907:6eac:b0:a9a:7f91:8c76 with SMTP id
 a640c23a62f3a-a9de5a3e0ebmr4598218266b.0.1730983023546; Thu, 07 Nov 2024
 04:37:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107032859.18276-1-zhaoqunqin@loongson.cn>
In-Reply-To: <20241107032859.18276-1-zhaoqunqin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 7 Nov 2024 20:36:51 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5A144ubJ6WD68y7f6sN3j=g-eWVqZ6mhko9nzTgM=xYA@mail.gmail.com>
Message-ID: <CAAhV-H5A144ubJ6WD68y7f6sN3j=g-eWVqZ6mhko9nzTgM=xYA@mail.gmail.com>
Subject: Re: [PATCH] arch: loongarch: fix loongarch S3 WARNING
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: kernel@xen0n.name, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Qunqin,

At first, the subject should be "LoongArch: Fix warnings during S3 suspend"=
.

On Thu, Nov 7, 2024 at 11:29=E2=80=AFAM Qunqin Zhao <zhaoqunqin@loongson.cn=
> wrote:
>
> The enable_gpe_wakeup() function may call the preempt_schedule_common()
> function, resulting in a thread switch and causing the CPU to be in an
> interrupt enable state after the enable_gpe_wakeup() function returns,
> leading to the warning as follow. Calling enable_gap_wakeup() before
Second, I think enable_gap_wakeup() should be enable_gpe_wakeup() here.

> local_irq_disable() to fix this waring.
>
> [ C0] WARNING: ... at kernel/time/timekeeping.c:845 ktime_get+0xbc/0xc8
> [ C0]         ...
> [ C0] Call Trace:
> [ C0] [<90000000002243b4>] show_stack+0x64/0x188
> [ C0] [<900000000164673c>] dump_stack_lvl+0x60/0x88
> [ C0] [<90000000002687e4>] __warn+0x8c/0x148
> [ C0] [<90000000015e9978>] report_bug+0x1c0/0x2b0
> [ C0] [<90000000016478e4>] do_bp+0x204/0x3b8
> [ C0] [<90000000025b1924>] exception_handlers+0x1924/0x10000
> [ C0] [<9000000000343bbc>] ktime_get+0xbc/0xc8
> [ C0] [<9000000000354c08>] tick_sched_timer+0x30/0xb0
> [ C0] [<90000000003408e0>] __hrtimer_run_queues+0x160/0x378
> [ C0] [<9000000000341f14>] hrtimer_interrupt+0x144/0x388
> [ C0] [<9000000000228348>] constant_timer_interrupt+0x38/0x48
> [ C0] [<90000000002feba4>] __handle_irq_event_percpu+0x64/0x1e8
> [ C0] [<90000000002fed48>] handle_irq_event_percpu+0x20/0x80
> [ C0] [<9000000000306b9c>] handle_percpu_irq+0x5c/0x98
> [ C0] [<90000000002fd4a0>] generic_handle_domain_irq+0x30/0x48
> [ C0] [<9000000000d0c7b0>] handle_cpu_irq+0x70/0xa8
> [ C0] [<9000000001646b30>] handle_loongarch_irq+0x30/0x48
> [ C0] [<9000000001646bc8>] do_vint+0x80/0xe0
> [ C0] [<90000000002aea1c>] finish_task_switch.isra.0+0x8c/0x2a8
> [ C0] [<900000000164e34c>] __schedule+0x314/0xa48
> [ C0] [<900000000164ead8>] schedule+0x58/0xf0
> [ C0] [<9000000000294a2c>] worker_thread+0x224/0x498
> [ C0] [<900000000029d2f0>] kthread+0xf8/0x108
> [ C0] [<9000000000221f28>] ret_from_kernel_thread+0xc/0xa4
> [ C0]
> [ C0] ---[ end trace 0000000000000000 ]---
Finally, I think you should enable some config options to produce such
warnings? Because I haven't observed it.


Huacai

>
> And move enable_pci_wakeup() before local_irq_disable(), just in
> case interrupt is enabled after the execution of enable_pci_wakeup()
>
> Fixes: 366bb35a8e48 ("LoongArch: Add suspend (ACPI S3) support")
> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
> ---
>  arch/loongarch/power/suspend.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/arch/loongarch/power/suspend.c b/arch/loongarch/power/suspen=
d.c
> index c9e594925..d0dc375b0 100644
> --- a/arch/loongarch/power/suspend.c
> +++ b/arch/loongarch/power/suspend.c
> @@ -28,6 +28,13 @@ struct saved_registers {
>  };
>  static struct saved_registers saved_regs;
>
> +void arch_suspend_disable_irqs(void)
> +{
> +       enable_gpe_wakeup();
> +       enable_pci_wakeup();
> +       local_irq_disable();
> +}
> +
>  void loongarch_common_suspend(void)
>  {
>         save_counter();
> @@ -61,9 +68,6 @@ void loongarch_common_resume(void)
>
>  int loongarch_acpi_suspend(void)
>  {
> -       enable_gpe_wakeup();
> -       enable_pci_wakeup();
> -
>         loongarch_common_suspend();
>
>         /* processor specific suspend */
>
> base-commit: 73adbd92f3223dc0c3506822b71c6b259d5d537b
> --
> 2.43.0
>

