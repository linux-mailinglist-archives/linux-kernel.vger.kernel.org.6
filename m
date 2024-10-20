Return-Path: <linux-kernel+bounces-373316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E469A5534
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 18:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E8B5B2153F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 16:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0434D193436;
	Sun, 20 Oct 2024 16:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="XjPAGumF"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB94019342D
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 16:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729441633; cv=none; b=hSmG4o2Kn/YakIXKDx3PyscgYU1C+LGrGtkyA0XhWMAbOB2fppZY2U6NGAjp5sMGkcZzszE26KtanG97D+2QUT1KwvPvxpXtr8EzGM9q4WpGVDVqdl/1DOayte8CtOVnWSKeZ5FLweD/mgNn0H1SnR2k4sXO6nCw4l68RTq5ZIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729441633; c=relaxed/simple;
	bh=ZJWn3/ME7/PKMVdnFU/59dN2zZj9ws4GTRkgqj3wGV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t3DMxBc5EyH6+UIxrocznC4SZQ4YZwnydphWi/SfWLKb9TSetujcgr2zhI8XifF3Y79Jb6IX8UzYgO/9OBv0eEZpQJ9K6GC1EYY0XyuC9I4F5cjK5/OP99yQoFO9sDJ3HmF33ekCmrYoaGxQa0JiaLt/y2ZygMLJp4ZddGweqRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=XjPAGumF; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a3a309154aso13024815ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 09:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1729441630; x=1730046430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlJnZ2dnH0yKZQoVb1MYW1Cw6i1APoJ7tUtFkvOa8R4=;
        b=XjPAGumFjzgOouOvI19TBHCSzJZmvD8s1d2a8pm/9QmXxxLP0mpSHXJBpqG4e6MV0e
         89F5IhQQocXqa3miw2TSzrawL+wu/gSOxbX8+WLleKs3qgzUwRaN0fZsG/kL15uxl2f2
         VxA0hOtQuFVQpH8Nu/0pE+eRDmKsu8meobqWOhadkJqBD/DPoSU7USwSk97w+/CaIpQV
         YxS/rZwL5iEHe6Jm+ESyUBFjCbALjL/lKPM3VC3ZCpuhwk9KpU2lqljVqSIGYiUDiax9
         xqbM55EdIXIEd7BaSQZL6o1rv7AAsMF9URg6xWa1hFiF3i3gGHcyT2jHhHrLqawRJ96s
         cdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729441630; x=1730046430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlJnZ2dnH0yKZQoVb1MYW1Cw6i1APoJ7tUtFkvOa8R4=;
        b=bnNa4Pb+nC8+STqV20aw/pgUKUBOQq2WYr9XjKTECItpeU69aOWHvs+m29SO2esfqj
         Owkv5lydY5VTYi9SiYcKuSQA5A8TFcUPpq/1z8eXFw9Sqg3PUwRrVHqpoXlcSvplWwPZ
         FXOIREx2UlJjajQq4qU1a8xNCbwDb+8edpnHDjRVzzGvBdHf7KqHHjha2hK9n5Q5AGCh
         c2pgT6s15wAQbWSyCDpkwlpjN9Cq7X+EmXcjprJ2eQgkK8+oYNhUOC0aQTQT3BYtR3p7
         IArCNIPYYKOK1f/GCntuepw7A+T6+AgVmhV+uu/rVfHMfnzPaOI0FCZ2mNL/JicVM7HE
         P6Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUJI9STPMnprYEBn+mjr8SM4Nsm/OLlqziHt5KeZSFqcKzeUzI7TuG859127iY1B7a9yFeZgcpuiAke9ZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhm+RDL+57gKU+Wf93bJGa/B2/5btzijKK1fauE13gtKcz/5vx
	L7LfJGqh1KrvDu2jzOgoiD4ahxp4Yh/bai5hw3nonSHAtvvRcaDHMPg+UFPq9SYdg2c/6AUO5zT
	Ybbs6tNXALHtE7HXKwhCOdAFJHuq3zDT2O/KT/w==
X-Google-Smtp-Source: AGHT+IHut51aPnA4HRNe+5sFOzWqMYIfb+uEzsIdOlVQy40Ze9JNhMPONaOQfYNIMN+UGYB+CfdjzsYqyLXhrhld8kI=
X-Received: by 2002:a92:cd83:0:b0:3a3:96c4:29bc with SMTP id
 e9e14a558f8ab-3a3f406fe98mr81302935ab.11.1729441629798; Sun, 20 Oct 2024
 09:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016202814.4061541-1-samuel.holland@sifive.com> <20241016202814.4061541-10-samuel.holland@sifive.com>
In-Reply-To: <20241016202814.4061541-10-samuel.holland@sifive.com>
From: Anup Patel <anup@brainfault.org>
Date: Sun, 20 Oct 2024 21:56:58 +0530
Message-ID: <CAAhSdy3FTjVUDBJtbsFwj6+DWjrQh3nWwvsm_1edDUO9SkXB2A@mail.gmail.com>
Subject: Re: [PATCH v5 09/10] RISC-V: KVM: Allow Smnpm and Ssnpm extensions
 for guests
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Atish Patra <atishp@atishpatra.org>, 
	linux-kselftest@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan <shuah@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, kvm-riscv@lists.infradead.org, 
	Conor Dooley <conor@kernel.org>, kasan-dev@googlegroups.com, linux-doc@vger.kernel.org, 
	Evgenii Stepanov <eugenis@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 1:58=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> The interface for controlling pointer masking in VS-mode is henvcfg.PMM,
> which is part of the Ssnpm extension, even though pointer masking in
> HS-mode is provided by the Smnpm extension. As a result, emulating Smnpm
> in the guest requires (only) Ssnpm on the host.
>
> The guest configures Smnpm through the SBI Firmware Features extension,
> which KVM does not yet implement, so currently the ISA extension has no
> visible effect on the guest, and thus it cannot be disabled. Ssnpm is
> configured using the senvcfg CSR within the guest, so that extension
> cannot be hidden from the guest without intercepting writes to the CSR.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>
> Changes in v5:
>  - Do not allow Smnpm to be disabled, as suggested by Anup
>
> Changes in v2:
>  - New patch for v2
>
>  arch/riscv/include/uapi/asm/kvm.h | 2 ++
>  arch/riscv/kvm/vcpu_onereg.c      | 4 ++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/=
asm/kvm.h
> index e97db3296456..4f24201376b1 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -175,6 +175,8 @@ enum KVM_RISCV_ISA_EXT_ID {
>         KVM_RISCV_ISA_EXT_ZCF,
>         KVM_RISCV_ISA_EXT_ZCMOP,
>         KVM_RISCV_ISA_EXT_ZAWRS,
> +       KVM_RISCV_ISA_EXT_SMNPM,
> +       KVM_RISCV_ISA_EXT_SSNPM,
>         KVM_RISCV_ISA_EXT_MAX,
>  };
>
> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index b319c4c13c54..5b68490ad9b7 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
> @@ -34,9 +34,11 @@ static const unsigned long kvm_isa_ext_arr[] =3D {
>         [KVM_RISCV_ISA_EXT_M] =3D RISCV_ISA_EXT_m,
>         [KVM_RISCV_ISA_EXT_V] =3D RISCV_ISA_EXT_v,
>         /* Multi letter extensions (alphabetically sorted) */
> +       [KVM_RISCV_ISA_EXT_SMNPM] =3D RISCV_ISA_EXT_SSNPM,
>         KVM_ISA_EXT_ARR(SMSTATEEN),
>         KVM_ISA_EXT_ARR(SSAIA),
>         KVM_ISA_EXT_ARR(SSCOFPMF),
> +       KVM_ISA_EXT_ARR(SSNPM),
>         KVM_ISA_EXT_ARR(SSTC),
>         KVM_ISA_EXT_ARR(SVINVAL),
>         KVM_ISA_EXT_ARR(SVNAPOT),
> @@ -127,8 +129,10 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsig=
ned long ext)
>         case KVM_RISCV_ISA_EXT_C:
>         case KVM_RISCV_ISA_EXT_I:
>         case KVM_RISCV_ISA_EXT_M:
> +       case KVM_RISCV_ISA_EXT_SMNPM:
>         /* There is not architectural config bit to disable sscofpmf comp=
letely */
>         case KVM_RISCV_ISA_EXT_SSCOFPMF:
> +       case KVM_RISCV_ISA_EXT_SSNPM:
>         case KVM_RISCV_ISA_EXT_SSTC:
>         case KVM_RISCV_ISA_EXT_SVINVAL:
>         case KVM_RISCV_ISA_EXT_SVNAPOT:
> --
> 2.45.1
>

