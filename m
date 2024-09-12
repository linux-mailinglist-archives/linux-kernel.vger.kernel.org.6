Return-Path: <linux-kernel+bounces-326695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 134EA976BDA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ACA61F25E8F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39CB1AD25F;
	Thu, 12 Sep 2024 14:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F4oG6LR5"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBF12BB09
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726150944; cv=none; b=WazrMBH7ZGAyY8GVPRz5vzAuQ+WO71j/Cco0fwBIdVmkB4IIiXk4lhv54YrHG72RVkmOBwpj015cPyN+P9w1KG0b02Uixbm70CfVZa85tuL4Kjy+9wif23fVBxozCNjfSph/de1BXgbtQDXMBBKCCnp1ZE3yyyZmZbcQVml1tmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726150944; c=relaxed/simple;
	bh=wjbYL2Xn5q39ZUu2R2/TS92BlULoVl0GkzrND1hKir4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bNe49mkh/obSmrxR+BfeqsB4DCzX0IyMbb4/Ut87Ev9KrH21keEp7Q4jJjvmQqeMDjesgJg94Bo6uyX0EDvgbe28fzwqTP3BXxNt04HQRBiuOE7yt/Qx1Ytw67oIpM45WalUIpB/gDbGgvcqz5IWCdqr8VxhSBm2bmrib6LurCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F4oG6LR5; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c2460e885dso31799a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726150941; x=1726755741; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vPVa+TxePmfNOKyBF++5A+N++QA4GdG9hxLFcALU9M8=;
        b=F4oG6LR5IFRAnQIxxbXPf67dqByf3dVOALfMHKbGmeN6786biEmc/hj0hbHOoUa4qt
         aR1K8xx+vnEKgzOT9NURmRN9C2FjD+ElxHdlXjNuBj4hkjOCXH8z6ruWx7VrVosd4u0f
         cUp7zgGjeKoXJ3Qc6y8jiU3w0EBCcLKWi2iwxCPxnuKpuEw3oGsBipgVHO1Fxfvje0em
         rNZqslPKhfzFRdmDMhJG9nJNj9o+qWpyKH6fC7ovUSXPTf2O5G6g66VVbs9y6NKvCN4y
         FE3M4FRdKcBT3bl1sVFCrh4fbs6ojVfAbcRkgaeo9zVRJ6kkecnvrqT8m5Bw2prvOypn
         /diA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726150941; x=1726755741;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vPVa+TxePmfNOKyBF++5A+N++QA4GdG9hxLFcALU9M8=;
        b=gRfq33j7O9Zc459sTHShT/1UeWGaPKuQMjj4kbHP5O+aw6jxUgvXZX0g7i8nfkEDCa
         h20pfC48ufnyFxgUvLfZ7hAQPFu0vCGEXq88UOw59/hrnUVx3lvIHZQOtu89JxSHkMeh
         BC9IEZ3PyBi6r3tDB7cstbVdRXXlWBtnaTV85E5IwKABH/djxd9AK7MTB8EpAo7g3iGA
         xNAoVTMljADmGRUg+WtgU4eezTgTYNPtXZOgEvRqkDM2tzHcRxJuvoRZrWm6YvD05sCM
         U2gVLdvsDNcUKa7qxMk+hUes0Ll2fMv7RnmzfjiJRE3MmBmW3/AdPY3YfNyIKEcSk1Gd
         GE7A==
X-Forwarded-Encrypted: i=1; AJvYcCU1p3QSTzZKr8q0a+xDp7VURMsGPbiGD++j6qkEHtpxr/EOJ7/hXhjyloZKNNJ0tgszLD7L0DTIx4tijks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxucz2XLNCncDx+k2mRlQWi6+irjBFRY3kWoHz4wkDFerMgcJ6p
	N+HzCyOVeOjb6/Vp1leOfJbv2kpWcwyTrCrMHqdZxmpntPV7dnv0XdzGpDEFONY7mP+HSKXSD2e
	pCBCDNb1K/JmoQF6OGh5y2ITy7z76H4VdWgEz
X-Google-Smtp-Source: AGHT+IEa6Hzh8iplc2O4j6MAuHsPrz3gwMtJo4QDDed36sqLtaIyvZNgtfYHMunzORQAJFT/1HqMx5ok1MkSOReqCEc=
X-Received: by 2002:a05:6402:35cd:b0:58b:15e4:d786 with SMTP id
 4fb4d7f45d1cf-5c415dd2e59mr386985a12.5.1726150940497; Thu, 12 Sep 2024
 07:22:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912-kvm-arm64-limit-guest-vl-v2-1-dd2c29cb2ac9@kernel.org>
In-Reply-To: <20240912-kvm-arm64-limit-guest-vl-v2-1-dd2c29cb2ac9@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 12 Sep 2024 15:21:43 +0100
Message-ID: <CA+EHjTyJcP0NcvhF0WeuF9_zuFSa1o7w8tA5J2eU=GutF+ZmRA@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: arm64: Constrain the host to the maximum shared
 SVE VL with pKVM
To: Mark Brown <broonie@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Mark,

On Thu, 12 Sept 2024 at 12:39, Mark Brown <broonie@kernel.org> wrote:
>
> When pKVM saves and restores the host floating point state on a SVE system
> it programs the vector length in ZCR_EL2.LEN to be whatever the maximum VL
> for the PE is but uses a buffer allocated with kvm_host_sve_max_vl, the
> maximum VL shared by all PEs in the system. This means that if we run on a
> system where the maximum VLs are not consistent we will overflow the buffer
> on PEs which support larger VLs.
>
> Since the host will not currently attempt to make use of non-shared VLs fix
> this by explicitly setting the EL2 VL to be the maximum shared VL when we
> save and restore. This will enforce the limit on host VL usage. Should we
> wish to support asymmetric VLs this code will need to be updated along with
> the required changes for the host, patches have previously been posted:
>
>   https://lore.kernel.org/r/20240730-kvm-arm64-fix-pkvm-sve-vl-v6-0-cae8a2e0bd66@kernel.org

Thanks for fixing this.

One part that you haven't changed is setting ZCR_EL2 during el2 setup:
arch/arm64/include/asm/el2_setup.h: .Linit_sve_ : lines 290/291

I guess at that point it's not straightforward to figure sve_max_vl.
Is there a window after el2 setup where we might actually get the VL
implied by ZCR_ELx_LEN_MASK, or would it always get set to
sve_vq_from_vl(kvm_host_sve_max_vl) - 1 ?

That said, this passes the sve-stress test now: tested on qemu using
nvhe, pKVM non-protected guest, pKVM protected guest (the latest with
patches not upstream yet).

Assuming that the current code in el2_setup.h is fine as it is:
Tested-by: Fuad Tabba <tabba@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad



>
> Fixes: b5b9955617bc ("KVM: arm64: Eagerly restore host fpsimd/sve state in pKVM")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> Changes in v2:
> - Update all places where we constrain the host VL, not just those where
>   we save and restore host state.
> - The value written to the register is 0 based, not 1 based.
> - Link to v1: https://lore.kernel.org/r/20240910-kvm-arm64-limit-guest-vl-v1-1-54df40b95ffb@kernel.org
> ---
>  arch/arm64/kvm/hyp/include/hyp/switch.h |  2 +-
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c      | 12 +++++++-----
>  2 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
> index f59ccfe11ab9..c2cfb4d6dc92 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/switch.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
> @@ -339,7 +339,7 @@ static inline void __hyp_sve_save_host(void)
>         struct cpu_sve_state *sve_state = *host_data_ptr(sve_state);
>
>         sve_state->zcr_el1 = read_sysreg_el1(SYS_ZCR);
> -       write_sysreg_s(ZCR_ELx_LEN_MASK, SYS_ZCR_EL2);
> +       write_sysreg_s(sve_vq_from_vl(kvm_host_sve_max_vl) - 1, SYS_ZCR_EL2);
>         __sve_save_state(sve_state->sve_regs + sve_ffr_offset(kvm_host_sve_max_vl),
>                          &sve_state->fpsr,
>                          true);
> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> index f43d845f3c4e..dd1c6aa907a2 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> @@ -33,7 +33,7 @@ static void __hyp_sve_save_guest(struct kvm_vcpu *vcpu)
>          */
>         sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1, SYS_ZCR_EL2);
>         __sve_save_state(vcpu_sve_pffr(vcpu), &vcpu->arch.ctxt.fp_regs.fpsr, true);
> -       write_sysreg_s(ZCR_ELx_LEN_MASK, SYS_ZCR_EL2);
> +       write_sysreg_s(sve_vq_from_vl(kvm_host_sve_max_vl) - 1, SYS_ZCR_EL2);
>  }
>
>  static void __hyp_sve_restore_host(void)
> @@ -45,10 +45,11 @@ static void __hyp_sve_restore_host(void)
>          * the host. The layout of the data when saving the sve state depends
>          * on the VL, so use a consistent (i.e., the maximum) host VL.
>          *
> -        * Setting ZCR_EL2 to ZCR_ELx_LEN_MASK sets the effective length
> -        * supported by the system (or limited at EL3).
> +        * Note that this constrains the PE to the maximum shared VL
> +        * that was discovered, if we wish to use larger VLs this will
> +        * need to be revisited.
>          */
> -       write_sysreg_s(ZCR_ELx_LEN_MASK, SYS_ZCR_EL2);
> +       write_sysreg_s(sve_vq_from_vl(kvm_host_sve_max_vl) - 1, SYS_ZCR_EL2);
>         __sve_restore_state(sve_state->sve_regs + sve_ffr_offset(kvm_host_sve_max_vl),
>                             &sve_state->fpsr,
>                             true);
> @@ -479,7 +480,8 @@ void handle_trap(struct kvm_cpu_context *host_ctxt)
>         case ESR_ELx_EC_SVE:
>                 cpacr_clear_set(0, CPACR_ELx_ZEN);
>                 isb();
> -               sve_cond_update_zcr_vq(ZCR_ELx_LEN_MASK, SYS_ZCR_EL2);
> +               sve_cond_update_zcr_vq(sve_vq_from_vl(kvm_host_sve_max_vl) - 1,
> +                                      SYS_ZCR_EL2);
>                 break;
>         case ESR_ELx_EC_IABT_LOW:
>         case ESR_ELx_EC_DABT_LOW:
>
> ---
> base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
> change-id: 20240910-kvm-arm64-limit-guest-vl-d5fba0c7cc7b
>
> Best regards,
> --
> Mark Brown <broonie@kernel.org>
>

