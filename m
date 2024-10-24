Return-Path: <linux-kernel+bounces-380776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E7B9AF5EB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 01:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F435282C10
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 23:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9FE217902;
	Thu, 24 Oct 2024 23:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="AiWIdRw8"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E262170C5
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 23:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729814230; cv=none; b=Uzuh/TCirAqMrtNDcMjRpxxkX+Om2J4YZ2/CMFhAVuD8C5hvVCcT1XlLkuHxQw/aAVYEEBhNvzbLQUwHIjM4SucX0lXKwic0yJoCcWophkPOHUn1kBeQ8pr24uY24AoZCiydcA1I5OBbYYhn/56RS1aL3Sg8O5L8TS7wx7Gqfi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729814230; c=relaxed/simple;
	bh=OTLrDgahjhpS7tk6wVi1Gf+890pY2/yu+a7WrpBPIns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mEPJmJGSw97TdbqKVS0vxDj4Yf+Qz5y09Rv3itJWFZpqHk4GwSTbhxIKxbylaeN3smxOWXppLlouKzh/qeRozYPGOORtKWY4FSW9OOqcIPVB0+/dWnl7v/RLLNIAFh0rVSDMttjXa2i3ZfkTCo33s5/mt1upxohqIMqcXnbMYfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org; spf=pass smtp.mailfrom=atishpatra.org; dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b=AiWIdRw8; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atishpatra.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539fe02c386so2574544e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 16:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1729814225; x=1730419025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9rfSyJCD8BY6O6PSI+2pcUwGXf0gHlX8f+v+C08yQM=;
        b=AiWIdRw8WBpRvT+dPhBOv4gvUhI08f0U8gLc6TbzHa0jqTeNibV1e5KPOa8cHrjQUx
         KND6POwu8tWTuFLkJ6c7pZ+pnai8MVHgdCjbnRMcYR9d8uofVgQZXGkUl726kG1XS+kN
         DNrAMdY2lLPITodzpnLSRVb6XkvsWtbxMJPlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729814225; x=1730419025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9rfSyJCD8BY6O6PSI+2pcUwGXf0gHlX8f+v+C08yQM=;
        b=BTeaKwmIEi2jyfkaBmAwKrW8+f0sBVv/W0q90B7Ax8naLS21Zx/v0egr0X4YCsElez
         B+a100iCc7TVScrwaZrt5mR9UaJAHl4WoYBol0YVlXc9aDtuGrlEZFAUWqLuOxZNzgfQ
         NJorgqp41EH5ZE6YBmV8rCrIaUQH0o0OEUrH0LCJXQOJq/fMyoSihbQ/7PG2MNYMDzbF
         HwJgIXARJOUmCrS4ZIjlsCdmt5XeFugiunKpPRVvWn4uxQorb85CnLMP6Mkmaevn36Rd
         js1F097f2pPIV0LT8cHZYeqtakcfYh9VHhSRfL2UfXltI1w80K8oAQ5mddOLyMWertr0
         CXhw==
X-Forwarded-Encrypted: i=1; AJvYcCUraI5V1NAeOs/UPGh9nyKtz2oSc+Lgy43+dwpnfZJ5YKJtolm4G4b59xjer73fmozeQrGoSAB+rvCl4aI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcBZlt3aB7kix4sVt9H+wIarJkK2fQBJkaL2H5+T1cTCQQs11d
	zYMo4YOKi8htkFsxy5RaqZaltG+bHCHg003NrVpyi22ugD9ZW5aK4m7GmVLmXXH281yXTIuebPy
	4vaDuP/PTNrCS0H1HjL7mVONoHrzV/URNgDe3
X-Google-Smtp-Source: AGHT+IFtzZLHt5IRuxdRf/8xBTE1piSCrKaHJKNOKHhV4Xc3UGvVG8tpLg0Gm5PGJN+M0D4zkk4RZYGEvImxki54eug=
X-Received: by 2002:a19:6a12:0:b0:539:fd75:2b6c with SMTP id
 2adb3069b0e04-53b2375231dmr1061157e87.21.1729814225295; Thu, 24 Oct 2024
 16:57:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020194734.58686-1-apatel@ventanamicro.com> <20241020194734.58686-14-apatel@ventanamicro.com>
In-Reply-To: <20241020194734.58686-14-apatel@ventanamicro.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Thu, 24 Oct 2024 16:56:53 -0700
Message-ID: <CAOnJCU+WAUJbBjVvjvdGbWs8ELVDYkARqqzZceHdzHzgYko2ig@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] RISC-V: KVM: Use NACL HFENCEs for KVM request
 based HFENCEs
To: Anup Patel <apatel@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 20, 2024 at 12:48=E2=80=AFPM Anup Patel <apatel@ventanamicro.co=
m> wrote:
>
> When running under some other hypervisor, use SBI NACL based HFENCEs
> for TLB shoot-down via KVM requests. This makes HFENCEs faster whenever
> SBI nested acceleration is available.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/kvm/tlb.c | 57 +++++++++++++++++++++++++++++++-------------
>  1 file changed, 40 insertions(+), 17 deletions(-)
>
> diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
> index 23c0e82b5103..2f91ea5f8493 100644
> --- a/arch/riscv/kvm/tlb.c
> +++ b/arch/riscv/kvm/tlb.c
> @@ -14,6 +14,7 @@
>  #include <asm/csr.h>
>  #include <asm/cpufeature.h>
>  #include <asm/insn-def.h>
> +#include <asm/kvm_nacl.h>
>
>  #define has_svinval()  riscv_has_extension_unlikely(RISCV_ISA_EXT_SVINVA=
L)
>
> @@ -186,18 +187,24 @@ void kvm_riscv_fence_i_process(struct kvm_vcpu *vcp=
u)
>
>  void kvm_riscv_hfence_gvma_vmid_all_process(struct kvm_vcpu *vcpu)
>  {
> -       struct kvm_vmid *vmid;
> +       struct kvm_vmid *v =3D &vcpu->kvm->arch.vmid;
> +       unsigned long vmid =3D READ_ONCE(v->vmid);
>
> -       vmid =3D &vcpu->kvm->arch.vmid;
> -       kvm_riscv_local_hfence_gvma_vmid_all(READ_ONCE(vmid->vmid));
> +       if (kvm_riscv_nacl_available())
> +               nacl_hfence_gvma_vmid_all(nacl_shmem(), vmid);
> +       else
> +               kvm_riscv_local_hfence_gvma_vmid_all(vmid);
>  }
>
>  void kvm_riscv_hfence_vvma_all_process(struct kvm_vcpu *vcpu)
>  {
> -       struct kvm_vmid *vmid;
> +       struct kvm_vmid *v =3D &vcpu->kvm->arch.vmid;
> +       unsigned long vmid =3D READ_ONCE(v->vmid);
>
> -       vmid =3D &vcpu->kvm->arch.vmid;
> -       kvm_riscv_local_hfence_vvma_all(READ_ONCE(vmid->vmid));
> +       if (kvm_riscv_nacl_available())
> +               nacl_hfence_vvma_all(nacl_shmem(), vmid);
> +       else
> +               kvm_riscv_local_hfence_vvma_all(vmid);
>  }
>
>  static bool vcpu_hfence_dequeue(struct kvm_vcpu *vcpu,
> @@ -251,6 +258,7 @@ static bool vcpu_hfence_enqueue(struct kvm_vcpu *vcpu=
,
>
>  void kvm_riscv_hfence_process(struct kvm_vcpu *vcpu)
>  {
> +       unsigned long vmid;
>         struct kvm_riscv_hfence d =3D { 0 };
>         struct kvm_vmid *v =3D &vcpu->kvm->arch.vmid;
>
> @@ -259,26 +267,41 @@ void kvm_riscv_hfence_process(struct kvm_vcpu *vcpu=
)
>                 case KVM_RISCV_HFENCE_UNKNOWN:
>                         break;
>                 case KVM_RISCV_HFENCE_GVMA_VMID_GPA:
> -                       kvm_riscv_local_hfence_gvma_vmid_gpa(
> -                                               READ_ONCE(v->vmid),
> -                                               d.addr, d.size, d.order);
> +                       vmid =3D READ_ONCE(v->vmid);
> +                       if (kvm_riscv_nacl_available())
> +                               nacl_hfence_gvma_vmid(nacl_shmem(), vmid,
> +                                                     d.addr, d.size, d.o=
rder);
> +                       else
> +                               kvm_riscv_local_hfence_gvma_vmid_gpa(vmid=
, d.addr,
> +                                                                    d.si=
ze, d.order);
>                         break;
>                 case KVM_RISCV_HFENCE_VVMA_ASID_GVA:
>                         kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_HFENC=
E_VVMA_ASID_RCVD);
> -                       kvm_riscv_local_hfence_vvma_asid_gva(
> -                                               READ_ONCE(v->vmid), d.asi=
d,
> -                                               d.addr, d.size, d.order);
> +                       vmid =3D READ_ONCE(v->vmid);
> +                       if (kvm_riscv_nacl_available())
> +                               nacl_hfence_vvma_asid(nacl_shmem(), vmid,=
 d.asid,
> +                                                     d.addr, d.size, d.o=
rder);
> +                       else
> +                               kvm_riscv_local_hfence_vvma_asid_gva(vmid=
, d.asid, d.addr,
> +                                                                    d.si=
ze, d.order);
>                         break;
>                 case KVM_RISCV_HFENCE_VVMA_ASID_ALL:
>                         kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_HFENC=
E_VVMA_ASID_RCVD);
> -                       kvm_riscv_local_hfence_vvma_asid_all(
> -                                               READ_ONCE(v->vmid), d.asi=
d);
> +                       vmid =3D READ_ONCE(v->vmid);
> +                       if (kvm_riscv_nacl_available())
> +                               nacl_hfence_vvma_asid_all(nacl_shmem(), v=
mid, d.asid);
> +                       else
> +                               kvm_riscv_local_hfence_vvma_asid_all(vmid=
, d.asid);
>                         break;
>                 case KVM_RISCV_HFENCE_VVMA_GVA:
>                         kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_HFENC=
E_VVMA_RCVD);
> -                       kvm_riscv_local_hfence_vvma_gva(
> -                                               READ_ONCE(v->vmid),
> -                                               d.addr, d.size, d.order);
> +                       vmid =3D READ_ONCE(v->vmid);
> +                       if (kvm_riscv_nacl_available())
> +                               nacl_hfence_vvma(nacl_shmem(), vmid,
> +                                                d.addr, d.size, d.order)=
;
> +                       else
> +                               kvm_riscv_local_hfence_vvma_gva(vmid, d.a=
ddr,
> +                                                               d.size, d=
.order);
>                         break;
>                 default:
>                         break;
> --
> 2.43.0
>

Reviewed-by: Atish Patra <atishp@rivosinc.com>
--=20
Regards,
Atish

