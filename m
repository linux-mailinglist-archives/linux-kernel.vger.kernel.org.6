Return-Path: <linux-kernel+bounces-567365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 926C1A68520
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 07:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 554D43BFC26
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 06:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0E6212D8D;
	Wed, 19 Mar 2025 06:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="f57pklXC"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E95F187346
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 06:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742366111; cv=none; b=Jc0o6NU0Na3amUtkdkO3gh6rYPybZTRB65KzPTLiCRM4gDUmXZTWWbhGdJt45cXmbLVMXbP92tsdjBsQoF/lnwkAS3CfpP6SZ/QlvQuRUO53/mFtKcAnZ5SLhmeGwVjSiEv9VBognJ1lfq8NW3Y5p8WBq127L+juLcN4SFlpGEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742366111; c=relaxed/simple;
	bh=3C2fH56/ANPFLK5srhoeuXlQMjKMqMfCndGH5a7mUAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZXTKEXHVkbHFcwvnkqkiyRyplpSrBrTVT2wbE8H9/58s9H5xc3S03euAujg94M+wNkchcPD4MhtXe0lFFdrGfgfhiKUbD7w81AHv533llLN7TIxwgdFE4ai4onohE6aVQCuSnosTwpOIG5OeJDvaa6BssLOCjbm9NbkcmQY4nGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=f57pklXC; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-549963b5551so6339022e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 23:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1742366107; x=1742970907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nRcMBAnBB1cdPSStkQP8KD4Ik0+X3f5WUJpWyEcmszQ=;
        b=f57pklXCk1ulSi5raEGocP5b89UxVGNCODC3W0kcDuRMkWmmgd4rHos1dkxd0432eg
         zlhvDnxPuankZHKJyw+ZaUbY6mLGwn+SLgw+J2dZtN58ntRuFrN+Lww2ThWiAd7aPYqS
         xE40NxaHHPNROU9vv2zhj8s7LGUm8YQqdUFn5df013IQvc+DpXaSLqJPMD+JvS7EVpYp
         62PD4xYXSvApQ+dd9Ow6Ggnmcwr2lj1X/HSFUKW9KCS2buWsQzQz7V+fsir+I6A02jui
         QUUBZR+Ll5AFzSB6iC3AbJ2XJHt8F8VnPbTZjbm+4tM08ywwMJkiel0q4N3s6gPeURse
         577g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742366107; x=1742970907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRcMBAnBB1cdPSStkQP8KD4Ik0+X3f5WUJpWyEcmszQ=;
        b=Qbx4yHZbjRud8SVXDY2vdAFOZR2/7sWVdTBQqsduUMGn+GRJBejjPXOgm0FSyS9k/p
         YQ6pOayExsBIjO8nCOqFRWFUDuTS3heMbNKYmzblztw+F473QCoZgxOrRwD2SQWGVMP4
         IS+mNsP9UMNV/wxvDMBsZnGgetfFstQzNIDd3uBmWWf+JX1zLAP1NxzF2KYXIiiZrqzc
         4sIm68K/oy0aD9YzQJE6dnVduV6AeEtGoEy5FRXHr17vdQq2oapWrAMqje/90Di854LI
         ZEmDoMDGmAdepxEayBcfGM7/XAkb1iiDFXHyiOpUQRJcD1MDS0DDeFihj9tGPvNpcYvN
         M+cA==
X-Forwarded-Encrypted: i=1; AJvYcCV8Pl9X85uhM4et56atfck9WaIO3O8l3efPfcc1YhrNhEeAnDnj1njhPRxxFkA4y7an0NULN7O3+j8F68s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxxPai/peNb+6yUBsuDDqmDg/pLfLxSaenb/+DbCugvChnFP6r
	PBihxxagVxioPEKuG737v7tDA5U4gm0Txmjm7slY4GSZCIHfOF/hGGYec/pYTb9/Tfo9x57ZeqK
	pp+y5mapLwRgJhkTRmR0hpHwNvUxG+k8VCwXkLQa08FE2zwoyYRQ=
X-Gm-Gg: ASbGncthGEINzZun9VKkgH25o4HLMaPRhcq2YPaHGsRglYe8hukC2wj/BG1BKWr6fAG
	JAktDIrHg/uXZ4OsMGVGBmkIxvdhMeZD6kkzVKEDjlJeQ7sx/U/H5M4mxBuSBfSWRcvh4yNxdjN
	3l2x/n5jeQSX4EPbZ5cN8+GHsFfwo=
X-Google-Smtp-Source: AGHT+IG2DF9ysJOnGisWYlJRKJjNI7goJzS2EHde/phn2/2Rqicusog58ZNjwKuNH+aDT8iIlFKP1DPR1Tk9Qcbg6iY=
X-Received: by 2002:a05:6512:2c89:b0:54a:cc09:eacc with SMTP id
 2adb3069b0e04-54acc09ebcemr366625e87.39.1742366106954; Tue, 18 Mar 2025
 23:35:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-kvm_exit_fix-v1-1-aa5240c5dbd2@rivosinc.com>
In-Reply-To: <20250317-kvm_exit_fix-v1-1-aa5240c5dbd2@rivosinc.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Wed, 19 Mar 2025 12:04:55 +0530
X-Gm-Features: AQ5f1JqvoOcfbMQnETX7LXFFQmbgXKx4mcvkbI8cra0TF1szaF4KZK20bqrxCC4
Message-ID: <CAK9=C2XzuUO3NiKOwwa+Xyh+j7XUtHNBb=YCbe49kHHJY0Ke8Q@mail.gmail.com>
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

The kvm_riscv_treadown() was introduced by some other commit so
we should include a second Fixes tag which is:

Fixes: eded6754f398 ("riscv: KVM: add basic support for host vs guest
profiling")

>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Otherwise, this looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
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

