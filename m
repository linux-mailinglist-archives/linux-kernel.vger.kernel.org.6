Return-Path: <linux-kernel+bounces-568316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9925BA693B8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F3C6427CFF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B0F1DE2D8;
	Wed, 19 Mar 2025 15:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ZsBhBdZN"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7FE1C8602
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 15:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398637; cv=none; b=nZbrWTBfF0FLLXOaTUbyWncoMQZfW9dxRkzdWFvd22UZjWnIH4LW/6POgrWVwGSrpmC6O4WUwn6XK0JCBA5/lJYr9O735kCr5AUNKHfjWVnur7T42mWX37vTaUPahah8Mxoz8zq27QjAxFtDPnxp0DOw3iAXSjDqlfsl19ouzeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398637; c=relaxed/simple;
	bh=LNeEKTAKRRfrsuQtB3hF3PqGyblx8LqEqm7/ZGuJSX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iDfwRqtRQv4ijwCOyDtponWObuA8Ls8R8FcofvtEve4Qgwg1CrRgD+56REYsXOP16PBC6xSbTzJfEG7j+TdNd3ZRC9omSTWBJXUTW0tpuKsWMxLiL9g+keugck16ZRBVS0xBQbNd+VMa5vCWJbxymlAA5rkrxmwkhfB85n/J1jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ZsBhBdZN; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5439a6179a7so965391e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 08:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1742398634; x=1743003434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kYpJ+YWIm5kyww839SjAlRO2YxcNKECluRgtWLf4Uk=;
        b=ZsBhBdZNNW0JOTdJISnavg2/8Qyhx8vTuU/H5MI5ExYfR18He5s6jaHaQcQNdbbXlO
         ewuxAFJZpGgLNHZALJ4kVEwdsZrDL9rBPGpjySvYG86pa+HhBshEQHFGxA87XPTcoZrP
         4eCcEg43blrt0l2jL+dbmD362CAEFD5SfN3FltU8RPKkMBn0gT5w10eBJc2GYYQXvfv3
         SDpwOm0tB5nZKQn63a1/8gIjEjV+4NaqUSUuVxWo/Sle6DQck7+1yRCU4CjTh0gNZwbf
         cKUkW/ph4gqaR9ozj5LUAtGGcxIbK8YFzXPxFrbBumzd/PmJM41afVvfu42hsqJeJHkf
         0rqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742398634; x=1743003434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kYpJ+YWIm5kyww839SjAlRO2YxcNKECluRgtWLf4Uk=;
        b=BtoN1AbQOdZzRvhR6IGDiYW4/uifvrjf7N8BY9tspLldT53ih35ZxUOBz02R+HquEy
         5UR24D6AQWAj32B4iwJK0608ZpDwkSbpaZVRfuvI1a1fMTX6iFp8FMyMFcqBbzVE4qsV
         Sp9Yo4UgIn22pbm8HVJ7COoLuSw8H3gzOcP24Xttf0Jm5UKThbIWTpuTk1HKDki2lNsg
         yGCZrgWeOkUk3F9xNwF7rwa4FkK6zCshjG39qtCtBTsUXNzmQR/0hVo2eHLvL6zDPyHu
         PZ83KqBlcJdSGwLTjb9OMeBjY4xMzJlR6n1UtAVlWvGmgWdqgWGcK4EQwuQMeUorIALr
         345g==
X-Forwarded-Encrypted: i=1; AJvYcCUts4TN1PnuGeGt2X0lxPqx653hrFwCKMmaoTSYeDAvj8kUTAaa30Yg79T6OZXimSa+UPrA+XzX0DKW2DA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Nm0xP4jLbLU3arWQyLD2so88IWU1hDfSG5i20ETNZUpz2XqT
	gqI30c5+b3eYoThiwdH4nTt0xzbgzMJYVJAHG5g5xkxZDC1YwblVA17swEhdQ/icPXz8oZG/ILV
	taStEGpzi6GQwOrPN0tBoeD9xxmWB25Dat72WuA==
X-Gm-Gg: ASbGncvZD3cbis6gcbQz3CLxnLRVnnLfaDkU0sd8NiYNqnNsRVbTiqqo/NOjUYcob0y
	hlxagXu8nJ9sCcqD3AXkThG2maMW6Tihx1WCZtm/1r0+SXYTg9c3leDYAGX90yVVtNrIIjTFqNi
	RnLY3Hv0MZkRV5QblHYHB7zcfK6xQ=
X-Google-Smtp-Source: AGHT+IFCptMnikEraAGR3+R+hzqsR4hELpmCfLcM8ATnaG6QWGGUrAiiIW6drO0CCaxdf/r2HggliQzJYjThBHJXzdk=
X-Received: by 2002:a05:6512:10d6:b0:549:74a7:12ce with SMTP id
 2adb3069b0e04-54a30486a73mr4191860e87.14.1742398633481; Wed, 19 Mar 2025
 08:37:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-kvm_exit_fix-v1-1-aa5240c5dbd2@rivosinc.com>
In-Reply-To: <20250317-kvm_exit_fix-v1-1-aa5240c5dbd2@rivosinc.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Wed, 19 Mar 2025 21:07:01 +0530
X-Gm-Features: AQ5f1Jr9D_EWjJlaE139cU_qW55S55FYO9cnnZl-zgNXH-UdMwd_lNid37mPFXQ
Message-ID: <CAK9=C2WKuqmTtNYmhN2bnpb9PEE+mGJem_obvWsPVU4QrJm4eQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Teardown riscv specific bits after kvm_exit
To: Atish Patra <atishp@rivosinc.com>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 1:11=E2=80=AFPM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> During a module removal, kvm_exit invokes arch specific disable
> call which disables AIA. However, we invoke aia_exit before kvm_exit
> resulting in the following warning. KVM kernel module can't be inserted
> afterwards due to inconsistent state of IRQ.
>
> [25469.031389] percpu IRQ 31 still enabled on CPU0!
> [25469.031732] WARNING: CPU: 3 PID: 943 at kernel/irq/manage.c:2476 __fre=
e_percpu_irq+0xa2/0x150
> [25469.031804] Modules linked in: kvm(-)
> [25469.031848] CPU: 3 UID: 0 PID: 943 Comm: rmmod Not tainted 6.14.0-rc5-=
06947-g91c763118f47-dirty #2
> [25469.031905] Hardware name: riscv-virtio,qemu (DT)
> [25469.031928] epc : __free_percpu_irq+0xa2/0x150
> [25469.031976]  ra : __free_percpu_irq+0xa2/0x150
> [25469.032197] epc : ffffffff8007db1e ra : ffffffff8007db1e sp : ff200000=
0088bd50
> [25469.032241]  gp : ffffffff8131cef8 tp : ff60000080b96400 t0 : ff200000=
0088baf8
> [25469.032285]  t1 : fffffffffffffffc t2 : 5249207570637265 s0 : ff200000=
0088bd90
> [25469.032329]  s1 : ff60000098b21080 a0 : 037d527a15eb4f00 a1 : 037d527a=
15eb4f00
> [25469.032372]  a2 : 0000000000000023 a3 : 0000000000000001 a4 : ffffffff=
8122dbf8
> [25469.032410]  a5 : 0000000000000fff a6 : 0000000000000000 a7 : ffffffff=
8122dc10
> [25469.032448]  s2 : ff60000080c22eb0 s3 : 0000000200000022 s4 : 00000000=
0000001f
> [25469.032488]  s5 : ff60000080c22e00 s6 : ffffffff80c351c0 s7 : 00000000=
00000000
> [25469.032582]  s8 : 0000000000000003 s9 : 000055556b7fb490 s10: 00007fff=
f0e12fa0
> [25469.032621]  s11: 00007ffff0e13e9a t3 : ffffffff81354ac7 t4 : ffffffff=
81354ac7
> [25469.032664]  t5 : ffffffff81354ac8 t6 : ffffffff81354ac7
> [25469.032698] status: 0000000200000100 badaddr: ffffffff8007db1e cause: =
0000000000000003
> [25469.032738] [<ffffffff8007db1e>] __free_percpu_irq+0xa2/0x150
> [25469.032797] [<ffffffff8007dbfc>] free_percpu_irq+0x30/0x5e
> [25469.032856] [<ffffffff013a57dc>] kvm_riscv_aia_exit+0x40/0x42 [kvm]
> [25469.033947] [<ffffffff013b4e82>] cleanup_module+0x10/0x32 [kvm]
> [25469.035300] [<ffffffff8009b150>] __riscv_sys_delete_module+0x18e/0x1fc
> [25469.035374] [<ffffffff8000c1ca>] syscall_handler+0x3a/0x46
> [25469.035456] [<ffffffff809ec9a4>] do_trap_ecall_u+0x72/0x134
> [25469.035536] [<ffffffff809f5e18>] handle_exception+0x148/0x156
>
> Invoke aia_exit and other arch specific cleanup functions after kvm_exit
> so that disable gets a chance to be called first before exit.
>
> Fixes: 54e43320c2ba ("RISC-V: KVM: Initial skeletal support for AIA")
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Queued this patch for Linux-6.15 since the merge window is near.

Thanks,
Anup

> ---
>  arch/riscv/kvm/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
> index 1fa8be5ee509..4b24705dc63a 100644
> --- a/arch/riscv/kvm/main.c
> +++ b/arch/riscv/kvm/main.c
> @@ -172,8 +172,8 @@ module_init(riscv_kvm_init);
>
>  static void __exit riscv_kvm_exit(void)
>  {
> -       kvm_riscv_teardown();
> -
>         kvm_exit();
> +
> +       kvm_riscv_teardown();
>  }
>  module_exit(riscv_kvm_exit);
>
> ---
> base-commit: 4701f33a10702d5fc577c32434eb62adde0a1ae1
> change-id: 20250316-kvm_exit_fix-77cd0632d740
> --
> Regards,
> Atish patra
>

