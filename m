Return-Path: <linux-kernel+bounces-314990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FACD96BBD4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D64A1F2613F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5629E1D88BB;
	Wed,  4 Sep 2024 12:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="dYJdOnWT"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5251D79B3
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 12:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725452259; cv=none; b=K4CO4mVTeE1dXDrvP2fPSK/uV+rTofxs8kNsewrKlUqdxs8EbEB7vQfxFlYl1roT5w/We30AGVfTV8GAsGNEGb+L5/Eqt5UMQun39D/RgXOWDzfUAT9HavWMHK5OpUe1XlAnRUlhXKTCpDRjA9NmSJNu/ZXG2poTzu07UA4+wL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725452259; c=relaxed/simple;
	bh=qYsm8565woFnw1fHRK+sts6GjAK52KGTUSLhgkbr1Ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TXFz15XDBog2V09twsjLqY/SmJFxqN8uPzE/79TDo7y44J766P1CFJ7ckQfUq2aSZPCNPYt0+qPSawF0bbk3QRALERJSBhlk5H4TkVJzA+gjs86MUAnihHlprpGS0aFykpnarFfXPt65QrYWH5dQNpxDfl22o3vdvfn1M7KiUL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=dYJdOnWT; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53346132365so8018121e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 05:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1725452256; x=1726057056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlAAsB7SoUZZgOYwhXzTNmhBITwqQOW3TbtLYgYnb60=;
        b=dYJdOnWT4olSrGBwJXdnsjBFgU4j5y5nfHaI1FRevh5VXPaTfCDolFjtNFJSuk9pCW
         M2LqglnYgSeyywQyKuUn1R/+jgAnAyBniKVZuNy7Q9n3aBXGA+PiC0NZxbYLKtmPtrBs
         KQrT7xn8GRIlB7cF8zg57dRBIYBdLKaQYIlfgs3X7jKz/kSeYX9l6jFgk9nMlRi9hvvv
         H+dwS6ha2pfqCsgyhOoew5HQtsY7NIYB9cpFuh2xYN92oeAE3WDR1uc8CuVWs3fST5hE
         sX9UqsRKkFixlAViL+HMGzLjLVpxBdRaJDCFu9yBeM6XjEMnIoxMbzjx/RN8nV2PbAoC
         m/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725452256; x=1726057056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jlAAsB7SoUZZgOYwhXzTNmhBITwqQOW3TbtLYgYnb60=;
        b=rZK3wEjYgWjhnztCbk4gND/FwLX19FnU2y8k/dsZBdLtFl6tiuEOAvBYI4mJmx22GC
         Y6lxRWnc5N8hcD4PrJP67cCG5MkoSyfWH+8VDhHqa0xlXv4ObJnY8XIPRdieoZ5Lkamv
         Mh4PD+xY59+LP5p2Woms/MfwpMdlCzVbquDSEPMow9X7CmKHUw1a9vyu105D2cq1iIc7
         Q66Z9HxiuMQhgoO8K1uFa6eeCwgXNtY3uZP2+uTpPGuDUg23QNmPiH3UKTKJmP6DW0kc
         TfLRfnfaucsHf7ERX+/x7vxhVAdg2jkvY4aecrWjawbqOhJ6O4SsOzYC67i3C3FmoJIz
         YAjw==
X-Forwarded-Encrypted: i=1; AJvYcCUsUoxatzJvD5PwSJIN4Zt7iARJKEDJR9b/9lOFI2aPrr0qSRMiaYwSTdkarqDkHuELk4RAZrsVD6Kmshk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDMt1mOk49fNlJmn8b5PBCUXtJtsaPr03nB6VfITDUB+FPs2rR
	9GuwCBqlBcv8oeSfegUP8NKnfqM4aiOjot/TJC1lXHcPuguoy6RWDPhDWH6WQ2L5OvZ+tFGn+IW
	KcRM2oYhbJYdD+oQ6ZHxZJtvNlB6mdmzbbvC1oQ==
X-Google-Smtp-Source: AGHT+IHONA2kh/9cuUHglAMjIqImf7K09nF2SZfCubD5ZSJYCibfpv2CbmuIEnueZFBXb2pJWbIKdkcALwOvnjG7oMU=
X-Received: by 2002:a05:6512:2211:b0:534:3cdc:dbef with SMTP id
 2adb3069b0e04-53546b8d6d5mr11049948e87.43.1725452254963; Wed, 04 Sep 2024
 05:17:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829010151.2813377-1-samuel.holland@sifive.com> <20240829010151.2813377-10-samuel.holland@sifive.com>
In-Reply-To: <20240829010151.2813377-10-samuel.holland@sifive.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Wed, 4 Sep 2024 17:47:24 +0530
Message-ID: <CAK9=C2WjraWjuQCeU2Y4Jhr-gKkOcP42Sza7wVp0FgeGaD923g@mail.gmail.com>
Subject: Re: [PATCH v4 09/10] RISC-V: KVM: Allow Smnpm and Ssnpm extensions
 for guests
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
	linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>, 
	Conor Dooley <conor@kernel.org>, kasan-dev@googlegroups.com, 
	Atish Patra <atishp@atishpatra.org>, Evgenii Stepanov <eugenis@google.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 6:32=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> The interface for controlling pointer masking in VS-mode is henvcfg.PMM,
> which is part of the Ssnpm extension, even though pointer masking in
> HS-mode is provided by the Smnpm extension. As a result, emulating Smnpm
> in the guest requires (only) Ssnpm on the host.
>
> Since the guest configures Smnpm through the SBI Firmware Features
> interface, the extension can be disabled by failing the SBI call. Ssnpm
> cannot be disabled without intercepting writes to the senvcfg CSR.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
> (no changes since v2)
>
> Changes in v2:
>  - New patch for v2
>
>  arch/riscv/include/uapi/asm/kvm.h | 2 ++
>  arch/riscv/kvm/vcpu_onereg.c      | 3 +++
>  2 files changed, 5 insertions(+)
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
> index b319c4c13c54..6f833ec2344a 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
> @@ -34,9 +34,11 @@ static const unsigned long kvm_isa_ext_arr[] =3D {
>         [KVM_RISCV_ISA_EXT_M] =3D RISCV_ISA_EXT_m,
>         [KVM_RISCV_ISA_EXT_V] =3D RISCV_ISA_EXT_v,
>         /* Multi letter extensions (alphabetically sorted) */
> +       [KVM_RISCV_ISA_EXT_SMNPM] =3D RISCV_ISA_EXT_SSNPM,

Why not use KVM_ISA_EXT_ARR() macro here ?

>         KVM_ISA_EXT_ARR(SMSTATEEN),
>         KVM_ISA_EXT_ARR(SSAIA),
>         KVM_ISA_EXT_ARR(SSCOFPMF),
> +       KVM_ISA_EXT_ARR(SSNPM),
>         KVM_ISA_EXT_ARR(SSTC),
>         KVM_ISA_EXT_ARR(SVINVAL),
>         KVM_ISA_EXT_ARR(SVNAPOT),
> @@ -129,6 +131,7 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsign=
ed long ext)
>         case KVM_RISCV_ISA_EXT_M:
>         /* There is not architectural config bit to disable sscofpmf comp=
letely */
>         case KVM_RISCV_ISA_EXT_SSCOFPMF:
> +       case KVM_RISCV_ISA_EXT_SSNPM:

Why not add KVM_RISCV_ISA_EXT_SMNPM here ?

Disabling Smnpm from KVM user space is very different from
disabling Smnpm from Guest using SBI FWFT extension.

The KVM user space should always add Smnpm in the
Guest ISA string whenever the Host ISA string has it.

The Guest must explicitly use SBI FWFT to enable
Smnpm only after it sees Smnpm in ISA string.

>         case KVM_RISCV_ISA_EXT_SSTC:
>         case KVM_RISCV_ISA_EXT_SVINVAL:
>         case KVM_RISCV_ISA_EXT_SVNAPOT:
> --
> 2.45.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Regards,
Anup

