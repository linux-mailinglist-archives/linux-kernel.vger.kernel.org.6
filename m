Return-Path: <linux-kernel+bounces-523731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12863A3DA7E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77F517F54B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F131F5836;
	Thu, 20 Feb 2025 12:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Bs38ThKC"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB101F4E37
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740056055; cv=none; b=bmLz9CB70w7AQJuBVxjGnPF+W/U2MgBXlaA/re4AaB/DGEUYBz/gA+OF9PtRTE2VfrFL/xLv7J3wUnpFH2P5QKdoTkG4DKHk/JHGrZv7evaUrouV5Op/SQ8qGGM5qcR1jmORijbu5nLe9CYcNAzrmo29JQLmMKPcJlU7etgnOdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740056055; c=relaxed/simple;
	bh=7ALyS9KrCUX9bH5WW4Aa+MDKHcdMoNhpAI9S1zryjOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=bGqCaF1sXtnjmikhdhq+OfSMDpEbPkiozjh9CfY6whGrLCbG3wXVrp6PnWrhg13dNCDjBvIqJZUnIC0PGt859B37DPMVCKGUNEz+5oqef1CH93FwihSvk86wdEUMnF2ho2OFcrKG+d0UWHu9Y+qAPSUZ7SqHmm/7hqmCY4HDUYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Bs38ThKC; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5fc6fe05460so617241eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 04:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740056053; x=1740660853; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MH37PuNdNK/TNpbApdmC6WP6Q7SzSxWOUdbOcTxyoM=;
        b=Bs38ThKCaaaTw1cQtVuUhYveeA4Jpq7LkmwRq2+c7thN5EIHzT4/ILSgbeYoNqs1nX
         cSrIpnmeKjGqqRrUo+ExeQzjhskMNo3NI/G+2DoxLeBaqQzKl1YuzCBEm/N3f9T364Tq
         9ymyVP56SIUGEosWGDFd/RDj2UYqZAqgd3tXx10lqePpPkLBWJYR6NFmumzjE6raausV
         ebVNnGWyj0U7EjRjtpBYPTzqnbbz1p1pCRaocnHM9OrhsPiDkI4y/PhKD6uyNrIzWQzV
         UplUR6vO1z3uetFoYgN6sYW3ghWQ7R2Z4dwqexOWjqZW/+aSiJNCBCQco8c7G8WuqsxT
         HnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740056053; x=1740660853;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2MH37PuNdNK/TNpbApdmC6WP6Q7SzSxWOUdbOcTxyoM=;
        b=Eubx1v+n5Uqugt/Mt//cSKjt+GZyajmANJfSgFt+LuMNUluZfeAwhxpeSNNaQS8sN7
         Mln0pbarxzPdu3Ly1TrtWgFRa8RWxdfnFZ6YdlxbY2KO8iM//2JRKdwzZ4tEqfDGiqa5
         NzpySXA4r+63fblbllFlR/VjCbCzOqYslQSGt6zuHc3cmzNxNtAQV6yIzcVFMN0/HlzM
         vyIfHBfv65ypdkSKyTTqqx9BBbtVLrVl2k1kStXTuH4PVuvUxZXA5iKVEDe3F1afK65i
         d9VFghsdeExYI8M6F4wgNs0jA/SwuXcz+QWZU9L746qLcIMSbCHGoNrhYqEU9PBnbajQ
         3UOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYL7wz+sDRUY6KYHQtbfhnu0RPA96j3ge4/t7h/cNEtDWEICSvvff+WTl78uZ2i2ROx/G2P1SbBA0HG9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YylzBeuUAaOIyudq2B8gyZ48RNJMO7JJecsEK5SYFZbq3cKZUMc
	+RsuDU/BWkWdjBXrPmVsNbzkJn0YL8b785mtidAssailza7J6tMUfcpG/UmYK28sgvIsLg3FXBX
	KOtctJFI1tcmp3mcVqYzSYoqAwMiSi14tzwWZ4Q==
X-Gm-Gg: ASbGncutFw26VnTIfj+KhUC3Jymj0A3Lu9pwfTU2Mk1JWTN9gdkSizCaTk14R9LDfaM
	Yr1aj0UOKGEeEVr0JpIJ7Lo4MuYDArKxwU2lRkemeIbBKd1T2VX/45myAKVx4lhsvyJZp1bAY+O
	I=
X-Google-Smtp-Source: AGHT+IE6AHLnXcnNaoX4Nr22F0xV34Vth2voEdt9B7/95wnKbTHnVuJFPRSBTJU3K4esXEhAaDOcYDtzEfpdF78woc0=
X-Received: by 2002:a05:6871:216:b0:2b8:84d7:ddd5 with SMTP id
 586e51a60fabf-2bd104903b6mr5735450fac.39.1740056052647; Thu, 20 Feb 2025
 04:54:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250201110607.34766-1-cuiyunhui@bytedance.com>
In-Reply-To: <20250201110607.34766-1-cuiyunhui@bytedance.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 20 Feb 2025 20:54:01 +0800
X-Gm-Features: AWEUYZlZmbedW8oazja7YV8FQbGYiYqk4bf7DN3jmBvkvPch_3_i3rkkftu0WUc
Message-ID: <CAEEQ3w=uYad7UAedSU4M_L277v=RQGWHpJQwOW-p7W6=hcijsQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: print hartid on bringup
To: apatel@ventanamicro.com, atishp@rivosinc.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, cuiyunhui@bytedance.com, 
	samuel.holland@sifive.com, alexghiti@rivosinc.com, jassisinghbrar@gmail.com, 
	takakura@valinux.co.jp, valentina.fernandezalanis@microchip.com, 
	ruanjinjie@huawei.com, charlie@rivosinc.com, conor.dooley@microchip.com, 
	haibo1.xu@intel.com, andybnac@gmail.com, ke.zhao@shingroup.cn, 
	tglx@linutronix.de, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

Gentle ping. Any comments on this patch?

On Sat, Feb 1, 2025 at 7:06=E2=80=AFPM Yunhui Cui <cuiyunhui@bytedance.com>=
 wrote:
>
> Firmware randomly releases cores, so CPU numbers don't linearly map
> to hartids. When the system has an exception, we care more about hartids.
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  arch/riscv/kernel/smp.c     | 2 ++
>  arch/riscv/kernel/smpboot.c | 4 ++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index d58b5e751286..e650dec44817 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -48,6 +48,8 @@ EXPORT_SYMBOL_GPL(__cpuid_to_hartid_map);
>  void __init smp_setup_processor_id(void)
>  {
>         cpuid_to_hartid_map(0) =3D boot_cpu_hartid;
> +
> +       pr_info("Booting Linux on hartid %lu\n", boot_cpu_hartid);
>  }
>
>  static DEFINE_PER_CPU_READ_MOSTLY(int, ipi_dummy_dev);
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index e36d20205bd7..beba0efb00b9 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -231,6 +231,10 @@ asmlinkage __visible void smp_callin(void)
>         riscv_ipi_enable();
>
>         numa_add_cpu(curr_cpuid);
> +
> +       pr_info("CPU%u: Booted secondary hartid %lu\n", curr_cpuid,
> +               cpuid_to_hartid_map(curr_cpuid));
> +
>         set_cpu_online(curr_cpuid, true);
>
>         /*
> --
> 2.39.2
>

Thanks,
Yunhui

