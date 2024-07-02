Return-Path: <linux-kernel+bounces-237770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9202A923DE9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E54FEB26CD5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB6C15DBAB;
	Tue,  2 Jul 2024 12:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="pZKEWl+K"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1B515B118
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 12:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719923549; cv=none; b=UEeBR/nAohDkXLYaYFXlUOWstlCtzwX0mRN53evx/2eEEZBJlfR4IxiP6cVyZ3cQJV2S5SNy/k2FyZXpua3nMoS1Dem7k3Bud6F1ktROKEiOer0KhtHyDtaE2F1DH+x8w+F6i6vo2RJgKj5bN2+/DkBwxbAXMNnMvaHsE2L/7Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719923549; c=relaxed/simple;
	bh=H96XWUuXuHBDMDyPYgzw/DG/kM5NQVb/9StzB1WCRKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PpTVXCJeAKVl0zwKn+IclY9aS0gQ2/inYfpgVmfwHb6kh7I2/Cy/5nZXbvGiYIMJgdr5fZPnTau/p2wrhEPZzKiGgXw2mYbDFHLfjT4bY4OM/JuVDlDcknCR7RldB0picIgSgU5CUKURzwZs7tDi8OMYcu79qY8P+QfeWDtWOI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=pZKEWl+K; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52caebc6137so3603807e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 05:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719923545; x=1720528345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/EMsHPmSnth6woXBxvP2VppNfrx4K00pLmSD+g9HAg=;
        b=pZKEWl+Kz6/JAIBLLDK+BhmJdtVbOLdWCmrWIhtLEU6z/QVeo1BuBM4P/6VlBxch7r
         OVLHVAMgsNO0hpKDIrNPmJTNXn35hNtIZKJ7+hN5PswkRCpdpBP3+nhkCpmQmGLKte5M
         JPMCnIl6u3kGD6WGNVWCKap6BeCyyavK8AkEHGWPB1qN+dEuQQYgUxwANDRmQlE+J85S
         Jn3lLAd7SkvT5xFymAK14TRnDffwsvPVccn/P/UG9FK4DOSDx1Czp6gYsUlfpgxDlstc
         dKKK863YAU+ebcz2zM4sYxxwMW59aQgE5AUQmu0jJ/2GoYY6hXsGE7a8yYAA1j0DcC+d
         is8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719923545; x=1720528345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/EMsHPmSnth6woXBxvP2VppNfrx4K00pLmSD+g9HAg=;
        b=sDf/IDDnA2N2smWP2SLuSdonux9BilNwCaVIIgOqQNgjAwuQtU/q07J68WdKhLylQW
         ZzyaXqgvPZQ+Mjv4IBiYpzD8fMyyvmgoCfdRIjDcJ3MubovrMuDjz3aCuEzJ9AzydgpA
         d+b405g8OnVfuAF8K6Kp6Qj04gj9LM1vfaAUmhLib92AR2F64LEpsf2Gkx39h39qUKjA
         VztUktPoZTQbAanF+GbKk1X+D3ILdqLrz2wFs2FMAurRgbzzJ8sZ2wuZHoyvLuw6UVXz
         e+ZhP8vmC0I6ToWNp8BFTjxQxOVcCEXhkQFOXg21esCPL6fe6Cz0KXpPmkkp9rlX+/UL
         PE3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEtaeXyXdOeXiKab4AGivqCTEjhwRV10yUnaUuJPhGp54GxnDjW2IGiCwlxza1GsqOvRNEAKQaYMgUNV1SsysQ/r1Y6pE9ntxeBr87
X-Gm-Message-State: AOJu0YwFOMfiYCw/xFuwtCtuhfBLYoQrKfTccYHOazOvOfC59oG8SqBE
	4KjEftq6OeePEsnBouohEYTUTqFddwboYaaAy9BSOIxEjO2FGmNvumm8Cdc/Gmrk01Zr48IKgNp
	LfO/K42jP2OAZXOo5xw7xD/AaH3rISFN+GgsIDB+wJ7JBnAbP
X-Google-Smtp-Source: AGHT+IH/wq6oLQq9gHpx4/LxIpvCVyvhR97jieeJFeavDaFmUvfj5G+7Q1SeDu8eeD2sFxyTgA6yN6ypQP7I6t+1h0A=
X-Received: by 2002:a05:6512:33cd:b0:52c:ddce:4fda with SMTP id
 2adb3069b0e04-52e82646d35mr6262218e87.2.1719923544623; Tue, 02 Jul 2024
 05:32:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702102637.9074-1-mchitale@ventanamicro.com>
In-Reply-To: <20240702102637.9074-1-mchitale@ventanamicro.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 2 Jul 2024 14:32:09 +0200
Message-ID: <CAHVXubg1h3EUvVUaQduUqJ6v1zfM1Z_hPAEviutkt_Ys1A4TXw@mail.gmail.com>
Subject: Re: [PATCH v8] riscv: mm: Add support for Svinval extension
To: Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Samuel Holland <samuel.holland@sifive.com>, 
	Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mayuresh,

On Tue, Jul 2, 2024 at 12:26=E2=80=AFPM Mayuresh Chitale
<mchitale@ventanamicro.com> wrote:
>
> The Svinval extension splits SFENCE.VMA instruction into finer-grained
> invalidation and ordering operations and is mandatory for RVA23S64 profil=
e.
> When Svinval is enabled the local_flush_tlb_range_threshold_asid function
> should use the following sequence to optimize the tlb flushes instead of
> a simple sfence.vma:
>
> sfence.w.inval
> svinval.vma
>   .
>   .
> svinval.vma
> sfence.inval.ir
>
> The maximum number of consecutive svinval.vma instructions that
> can be executed in local_flush_tlb_range_threshold_asid function
> is limited to 64. This is required to avoid soft lockups and the
> approach is similar to that used in arm64.
>
> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
> Changes in v8:
> - Fix line wrap
> - Add RB tag
>
> Changes in v7:
> - Use existing svinval macros in the insn-def.h
> - Rename local_sinval_vma_asid to local_sinval_vma
>
> Changes in v6:
> - Rebase on latest torvalds/master
>
> Changes in v5:
> - Reduce tlb flush threshold to 64
> - Improve implementation of local_flush_tlb* functions
>
> Changes in v4:
> - Rebase and refactor as per latest changes on torvalds/master
> - Drop patch 1 in the series
>
> Changes in v3:
> - Fix incorrect vma used for sinval instructions
> - Use unified static key mechanism for svinval
> - Rebased on torvalds/master
>
> Changes in v2:
> - Rebased on 5.18-rc3
> - update riscv_fill_hwcap to probe Svinval extension
>
>  arch/riscv/mm/tlbflush.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 9b6e86ce3867..782147a63f3b 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -6,6 +6,27 @@
>  #include <linux/hugetlb.h>
>  #include <asm/sbi.h>
>  #include <asm/mmu_context.h>
> +#include <asm/cpufeature.h>
> +
> +#define has_svinval()  riscv_has_extension_unlikely(RISCV_ISA_EXT_SVINVA=
L)
> +
> +static inline void local_sfence_inval_ir(void)
> +{
> +       asm volatile(SFENCE_INVAL_IR() ::: "memory");
> +}
> +
> +static inline void local_sfence_w_inval(void)
> +{
> +       asm volatile(SFENCE_W_INVAL() ::: "memory");
> +}
> +
> +static inline void local_sinval_vma(unsigned long vma, unsigned long asi=
d)
> +{
> +       if (asid !=3D FLUSH_TLB_NO_ASID)
> +               asm volatile(SINVAL_VMA(%0, %1) : : "r" (vma), "r" (asid)=
 : "memory");
> +       else
> +               asm volatile(SINVAL_VMA(%0, zero) : : "r" (vma) : "memory=
");
> +}
>
>  /*
>   * Flush entire TLB if number of entries to be flushed is greater
> @@ -26,6 +47,16 @@ static void local_flush_tlb_range_threshold_asid(unsig=
ned long start,
>                 return;
>         }
>
> +       if (has_svinval()) {
> +               local_sfence_w_inval();
> +               for (i =3D 0; i < nr_ptes_in_range; ++i) {
> +                       local_sinval_vma(start, asid);
> +                       start +=3D stride;
> +               }
> +               local_sfence_inval_ir();
> +               return;
> +       }
> +
>         for (i =3D 0; i < nr_ptes_in_range; ++i) {
>                 local_flush_tlb_page_asid(start, asid);
>                 start +=3D stride;
> --
> 2.34.1
>

Great, thanks again for reworking this patchset!

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex

