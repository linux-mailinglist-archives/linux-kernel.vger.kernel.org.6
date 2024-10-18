Return-Path: <linux-kernel+bounces-372367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8C69A47B6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E992B2208F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CDF205AAA;
	Fri, 18 Oct 2024 20:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="rcFzKkhB"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AA9204026
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 20:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729282294; cv=none; b=QhVy0C+CmiL6VdjMw5KwTM42v60DnYjhmUnMYTdTjGkFAGSOWPpgWlWp6jdFs2Sq7LMewworfmtXwNxTujHH++8PjccEcWJ9l6TxN9BdFAbHYVDbTKDcRvm9tRTqfxBrEMgwza70v/YmvKYznRC5rvMMGxFdUabY7Eo6fNEGAPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729282294; c=relaxed/simple;
	bh=L1zmrwMA350Pw6vNvSRdXg7wao7p9uWvjSldj4JS//Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P93B/BG9wWT3ixMJE/z128m9zwsQmk7P+fLiFxNl5ZqXeO+Oq+MoTMH17n3wILawjwnqLQRwQ4Dh8FiQzVe3oJDik8MzuvkIWtbFJSzbCas5RKziIYH66kkGOGZ22BzasY/nxZgw2oExeSfCXEHKJfm1KB5IQcBHUUVHRiuJ/Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org; spf=pass smtp.mailfrom=atishpatra.org; dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b=rcFzKkhB; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atishpatra.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539e5c15fd3so2453995e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1729282290; x=1729887090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pjceIsWcwiJi9o8K3wuHgDeqcBFmrQpMfaaoOm2yWMc=;
        b=rcFzKkhBR2/uw92tqX6bro8El+cnw7SGXNMZZ6hUrYpJC/2erRf5iJfkGSSJZqsb6u
         XM6TjQtj/gnNC+m6+ccq7k6E0Npcipns0tYILarHsCQBQJg/2NlmsPHejHlk42J8if6L
         7J8WvLMD8kpaAwFp+3d9yjwXMcrkR1oKZRZXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729282290; x=1729887090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pjceIsWcwiJi9o8K3wuHgDeqcBFmrQpMfaaoOm2yWMc=;
        b=UbBVR/JdfRm2Uvowz8zDARDGhCB5QaM0R9pQQQAyo+BF3CRlwKXIK1Y23+m+YRPYbO
         dewt2grp6GyV0G30NboTW1CJ9eQg2BbK8YscIE5ZtnMtxhdJH+80L4028qe8n7KpUzGo
         HtGxyqUv1GUANr6PzRMXuz7Eyr0sHJaO2AIL8tljt12281fsO7zHjz2Jr0h9JMoyX/9/
         e+5xfm1Q+omjjvwESrPv0Bm86kZudeQcJlMDX05GwuZXvB/T6IvAEGBPeeclXvkAk3fP
         8u3vnvZpQYMg+XTWncRrfvN/VxH3VL9b3gUCIMIkNocC1vdC/qgPxAq2gFVpfEVoTktd
         sKdA==
X-Forwarded-Encrypted: i=1; AJvYcCWrqgesZHCjjlORI55W++96jZ0yvl4SwEeN1qnjpR6FpEPxJVazrSTUjpDZWc+FdgooilPfQFigG31rDwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfe8nKFE1H1KSXshyujq/JsjPh/GGgLFvT8h2US/bXVk6Vrjgb
	DDhXIMxInTESnnTwzuyLbWPSsS4CDy2Sq+tWrJgppwxYu56b9CSHEt8MGJqAky8Vm6f5xbCOphH
	4XQ5gMd/2siarndoTyn5Uuer3jrDMfc1YEuaR
X-Google-Smtp-Source: AGHT+IEdHOrSLjkzUAeYvCUQQHFAMWufe92JOuvK/VstP4tFd3/prjystEPcQ+qjzWFtQzonKenRkCQKn82nAdly+bo=
X-Received: by 2002:a05:6512:6c5:b0:530:ad7d:8957 with SMTP id
 2adb3069b0e04-53a1545dff1mr2826449e87.49.1729282290131; Fri, 18 Oct 2024
 13:11:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719160913.342027-1-apatel@ventanamicro.com> <20240719160913.342027-13-apatel@ventanamicro.com>
In-Reply-To: <20240719160913.342027-13-apatel@ventanamicro.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Fri, 18 Oct 2024 13:11:18 -0700
Message-ID: <CAOnJCULYc-m_Jq-MxwGMbktmCvLPsMiA_tzxE2qYuoKgeR0BEw@mail.gmail.com>
Subject: Re: [PATCH 12/13] RISC-V: KVM: Save trap CSRs in kvm_riscv_vcpu_enter_exit()
To: Anup Patel <apatel@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 9:10=E2=80=AFAM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> Save trap CSRs in the kvm_riscv_vcpu_enter_exit() function instead of
> the kvm_arch_vcpu_ioctl_run() function so that HTVAL and HTINST CSRs
> are accessed in more optimized manner while running under some other
> hypervisor.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/kvm/vcpu.c | 34 +++++++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 13 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index fe849fb1aaab..854d98aa165e 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -757,12 +757,21 @@ static __always_inline void kvm_riscv_vcpu_swap_in_=
host_state(struct kvm_vcpu *v
>   * This must be noinstr as instrumentation may make use of RCU, and this=
 is not
>   * safe during the EQS.
>   */
> -static void noinstr kvm_riscv_vcpu_enter_exit(struct kvm_vcpu *vcpu)
> +static void noinstr kvm_riscv_vcpu_enter_exit(struct kvm_vcpu *vcpu,
> +                                             struct kvm_cpu_trap *trap)
>  {
>         void *nsh;
>         struct kvm_cpu_context *gcntx =3D &vcpu->arch.guest_context;
>         struct kvm_cpu_context *hcntx =3D &vcpu->arch.host_context;
>
> +       /*
> +        * We save trap CSRs (such as SEPC, SCAUSE, STVAL, HTVAL, and
> +        * HTINST) here because we do local_irq_enable() after this
> +        * function in kvm_arch_vcpu_ioctl_run() which can result in
> +        * an interrupt immediately after local_irq_enable() and can
> +        * potentially change trap CSRs.
> +        */
> +
>         kvm_riscv_vcpu_swap_in_guest_state(vcpu);
>         guest_state_enter_irqoff();
>
> @@ -805,14 +814,24 @@ static void noinstr kvm_riscv_vcpu_enter_exit(struc=
t kvm_vcpu *vcpu)
>                 } else {
>                         gcntx->hstatus =3D csr_swap(CSR_HSTATUS, hcntx->h=
status);
>                 }
> +
> +               trap->htval =3D nacl_csr_read(nsh, CSR_HTVAL);
> +               trap->htinst =3D nacl_csr_read(nsh, CSR_HTINST);
>         } else {
>                 hcntx->hstatus =3D csr_swap(CSR_HSTATUS, gcntx->hstatus);
>
>                 __kvm_riscv_switch_to(&vcpu->arch);
>
>                 gcntx->hstatus =3D csr_swap(CSR_HSTATUS, hcntx->hstatus);
> +
> +               trap->htval =3D csr_read(CSR_HTVAL);
> +               trap->htinst =3D csr_read(CSR_HTINST);
>         }
>
> +       trap->sepc =3D gcntx->sepc;
> +       trap->scause =3D csr_read(CSR_SCAUSE);
> +       trap->stval =3D csr_read(CSR_STVAL);
> +
>         vcpu->arch.last_exit_cpu =3D vcpu->cpu;
>         guest_state_exit_irqoff();
>         kvm_riscv_vcpu_swap_in_host_state(vcpu);
> @@ -929,22 +948,11 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>
>                 guest_timing_enter_irqoff();
>
> -               kvm_riscv_vcpu_enter_exit(vcpu);
> +               kvm_riscv_vcpu_enter_exit(vcpu, &trap);
>
>                 vcpu->mode =3D OUTSIDE_GUEST_MODE;
>                 vcpu->stat.exits++;
>
> -               /*
> -                * Save SCAUSE, STVAL, HTVAL, and HTINST because we might
> -                * get an interrupt between __kvm_riscv_switch_to() and
> -                * local_irq_enable() which can potentially change CSRs.
> -                */
> -               trap.sepc =3D vcpu->arch.guest_context.sepc;
> -               trap.scause =3D csr_read(CSR_SCAUSE);
> -               trap.stval =3D csr_read(CSR_STVAL);
> -               trap.htval =3D ncsr_read(CSR_HTVAL);
> -               trap.htinst =3D ncsr_read(CSR_HTINST);
> -
>                 /* Syncup interrupts state with HW */
>                 kvm_riscv_vcpu_sync_interrupts(vcpu);
>
> --
> 2.34.1
>


Reviewed-by: Atish Patra <atishp@rivosinc.com>
--=20
Regards,
Atish

