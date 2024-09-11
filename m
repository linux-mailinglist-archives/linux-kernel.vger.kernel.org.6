Return-Path: <linux-kernel+bounces-324835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DBF975165
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171F628AD43
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B4518C930;
	Wed, 11 Sep 2024 12:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dxik5Zz7"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4401183CD1
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 12:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726056178; cv=none; b=n0ldSE1fGG1DEEfw05ikM+dDXlu7kCY8Et2bpc6aUFVItquUl9WQ+PDOddd4XL4QigjKomA1mupeAN5tbQPdrgW/Zx6D2L8TQ1U0//4oOQjetP5gw0NSgfbwsPd6vYP4RmxzpvGk+NWoJ333AGTVpzrsKXH4lzMjwhoIhLuSmhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726056178; c=relaxed/simple;
	bh=pvPCReOfqb0hl1N5DVnqiLi1EYUVIXYNuuNKrt8yl00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VWaOnZED7H13el6mCL5Opj+wfWOVheKYCiQ4Pxg6pQfMnop1qhE8pnw6Vn1WgPKd4RLXxhZpoYXuZVKB5ft/tRgQ2xSv5iRZ2C6tlGnJUQxT55JJYSSBoB6HpPBLdmWwzs/94l6MJ8vl76B3jDsNaNNvWRxbLEt1/Fuh5FF7jVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dxik5Zz7; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53661d95508so52492e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 05:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726056175; x=1726660975; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g8+WrkrtX7z+5qAOjWhXHblXMHkXc3ydENuaRKn/RkA=;
        b=dxik5Zz7Ao/vmhP/G7TF18d4kV0Uy+HPJYQen/914GHqgUIIyZpbg7W7jBTcS13Vo0
         KiKvJ+FFh+Pp+yF2McfPdJ7Xvrh0wkPMtD23UFjxNLcbSkE+Cd6rEahRMprxvK5eVQzQ
         vpkSy39APJRsSJsLcrxPFSfqiGmTJhMafysjaFFbabgv4dsWWodP7UcbNgUE3CuhHybT
         6EYrQOCwQJpBW7RzMBrMxifmvazNo6k0v8tVRTU1Ksy0UfRS5sOKc2xxmH2+7g2e92QZ
         Sa3Xac7AK5N7A+E5m7ngQFc/CrGU5j1IkL3ne6/j+IhClP+OKMoNIWsB/zGZZ6KzOdIg
         s7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726056175; x=1726660975;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g8+WrkrtX7z+5qAOjWhXHblXMHkXc3ydENuaRKn/RkA=;
        b=Ye3uijDMpsaIXSbhzJmiv5HS3p0fy8Mq2h8aJr18D0+75b7f2ynGzwIgZnOOhuGfOW
         h/a1YkSeRiOpAORGYALTeiyx+OEePRa4/86YqBG56/WTRj6J8nIBd8BKhDaNKZYU1f+V
         AE4Ho+3m2dcx6ZzYngYB7jcp5JEMjQQOVh2/BB47qse+UqzH3Q+sUD0ZmEacf0vv72Di
         VzWKJn1JQYwL+kL1YocHC/GnlNMPZ5wAjeute3FhNVanyJ5iZ6ad7AP8M6otrClrg4ip
         FAv3fM+6Ri5ont1DyttUIZjEj+mDf/HKHUyChiCbiP51WVBEbSJ1MyJhfoY0wIh2x9LD
         1Nxg==
X-Forwarded-Encrypted: i=1; AJvYcCWB1VyGagCmHTHKCmRTYJ47gnOFrII9OagBFvQOEwBqT37etztB3N95Qa9y0h1Mr6x3zS6PrHih78oL4DQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5lGeUqIUW/EwhMbd3WadP4oTstFDf40GTyN1DqgJJ4kRgbG0M
	7QS+DtBt0fY0w27JOr2M5QVmAlt5Yy1yMbqOQzFNOI+NiNrweWrKhKEQNxPfbtFYh5bQXSuA0ZH
	PHT6bnlU4Jy7QD25lPyM53v2MxdV1YqDfaavczdS0+HygJ/asSCj8
X-Google-Smtp-Source: AGHT+IGyiFWYQs1poeq0GVCiBhwyuLSgU3JDdcocqgqSStZELu7mBOadOBoTNT1J/cbDtILNItDbqsune6NpVx3GsmI=
X-Received: by 2002:a05:6512:b85:b0:535:68b2:9589 with SMTP id
 2adb3069b0e04-5367431fdeemr464105e87.2.1726056174422; Wed, 11 Sep 2024
 05:02:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910-kvm-arm64-limit-guest-vl-v1-1-54df40b95ffb@kernel.org>
In-Reply-To: <20240910-kvm-arm64-limit-guest-vl-v1-1-54df40b95ffb@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 11 Sep 2024 13:02:16 +0100
Message-ID: <CA+EHjTzk6_hWFnrEiJVYZnY41qGORL7NQdV6S+cobDy+UcAR-Q@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: Constrain the host to the maximum shared SVE
 VL with pKVM
To: Mark Brown <broonie@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Mark,

On Tue, 10 Sept 2024 at 21:26, Mark Brown <broonie@kernel.org> wrote:
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

I just tested this patch (QEMU, cpu max), and it crashes sometimes
when the guest after the guest has performed an fpsimd operation (pKVM
with a non-protected guest VM). I tested this patch applied to the
base patch (Linux 6.11-rc3).

The crash is triggered by arch/arm64/kernel/fpsimd.c:487
(fpsimd_save_user_state(): if (WARN_ON(sve_get_vl() != vl)) ...) ,
which ends up issuing a SIGKILL.

The easiest way to consistently reproduce the crash is with a host and
a guest both running the sve stress test (the one in the arm64
selftests).

I think the issue is that this patch doesn't cover all the cases that
are setting or assuming ZCR_ELx_LEN_MASK as the vector length.

Cheers,
/fuad



>
> Fixes: b5b9955617bc ("KVM: arm64: Eagerly restore host fpsimd/sve state in pKVM")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/kvm/hyp/include/hyp/switch.h | 2 +-
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c      | 7 ++++---
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
> index f59ccfe11ab9..ab1425baf0e9 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/switch.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
> @@ -339,7 +339,7 @@ static inline void __hyp_sve_save_host(void)
>         struct cpu_sve_state *sve_state = *host_data_ptr(sve_state);
>
>         sve_state->zcr_el1 = read_sysreg_el1(SYS_ZCR);
> -       write_sysreg_s(ZCR_ELx_LEN_MASK, SYS_ZCR_EL2);
> +       write_sysreg_s(sve_vq_from_vl(kvm_host_sve_max_vl), SYS_ZCR_EL2);
>         __sve_save_state(sve_state->sve_regs + sve_ffr_offset(kvm_host_sve_max_vl),
>                          &sve_state->fpsr,
>                          true);
> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> index f43d845f3c4e..90ff79950912 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
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
> +       write_sysreg_s(sve_vq_from_vl(kvm_host_sve_max_vl), SYS_ZCR_EL2);
>         __sve_restore_state(sve_state->sve_regs + sve_ffr_offset(kvm_host_sve_max_vl),
>                             &sve_state->fpsr,
>                             true);
>
> ---
> base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
> change-id: 20240910-kvm-arm64-limit-guest-vl-d5fba0c7cc7b
>
> Best regards,
> --
> Mark Brown <broonie@kernel.org>
>

