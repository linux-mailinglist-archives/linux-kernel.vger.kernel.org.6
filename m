Return-Path: <linux-kernel+bounces-306353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA77963DE3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45E001F2318D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE48189F4B;
	Thu, 29 Aug 2024 07:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="CZtfE2m1"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C6D1B813
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 07:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724918350; cv=none; b=Rju3wvvOpAkma9IAb5kCy3UHxDi50C8WXxxPT51YuG6WQKwV+Prh3SFVGQcaAkYGDzoWKn4+AnfmJIwVuECDn4hdaHDrTJjTaU7Nb36qL8YlsdDfkBsFzdOGUbEA9ELXtS4bc0RxsvbeqTP6STgygNNBsFiJeTbOvqq9+B59LSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724918350; c=relaxed/simple;
	bh=ISm5ntBSyRBtS44vfURV3RiQumBNWuZaV6guM8smmW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFcmMDrb7+CA9sEdwZotoae91hhplyjytsEce2sfaszZz9xwDXpIHrw5TTstd1FNCbn1ej/KyMticcec0VpN++2jlnddMt5S3atiRJ+9X6Bx5EJUW0oisLCZ27YICqauzs51Ai3YwFdGUFWq41AJ3PrpAcRCBJH563KM4Cb6f4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=CZtfE2m1; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f50f1d864fso3914831fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 00:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1724918347; x=1725523147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6elqEmMP4Fqdb/aWp7gByX3m8OcBQtHxRmlqmcr7txg=;
        b=CZtfE2m1jwNh6+FsnH+oZnpR2Ya96oguOsWuPl2SBenkV2wTFqD5Bb2oevEylbbD9+
         k0BbHfTG7XmhUdQ6CEeFf72IgYxwWgx6MmSLLxIvtgsK61QpcLA/E5diX17E6IYBlD4K
         PXNCn5T+tm9YN5Smc5gSJCpjUPF7i8oEp+Jkqv7zaoBq9gvJPV4RKXdGvOSE/+ZWAvtT
         c7gZgSn0x/9QoG1f11tcGgTAmZ+9+HHU8BV9MWKyUv+oFdRvUj+XX1Xv2kZgCNsIqPZc
         lr/KrAKBwipmCvq7wFPBn37kkeeXyFMyCYTEPWlgIv2yC2I4l49NBpGXMC9KB05uQmCp
         tyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724918347; x=1725523147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6elqEmMP4Fqdb/aWp7gByX3m8OcBQtHxRmlqmcr7txg=;
        b=bxsRWPDMNkc5u4UQEJ91M6pLF2RlsoROSgkK+9KTr013A/digy4UB8fGC24HEypyka
         hGwsAHomcmUHLZYJyNjNCSrYjaj6Khp9onwXxCbmQoHnoVwKsYp4QtKXyFdK9XBvuG/e
         6tTyXJoX36RYYTXJOOm65eZ0PiWU6tOWJ2aShXH1BUmDo/qVHjly3iuQ2QzFaot0dB1y
         AZ4EF0MgDpZCITskl3wNKMExRhxhaKq+4Jq/3nqNoNIMFvC+T14pH3iSq6/aRmmIb4OP
         LG0vig87JIzTzwGj/Z+CRn9/D8VfnkncJcY26yCp7V5U1thH9Ht2tR50HgFWyfLqh/rF
         G2zA==
X-Forwarded-Encrypted: i=1; AJvYcCW+TfHF1VIrQF5+cg0AIdvcip4xx5d9Zt+r++Mtj7n6914/f7qYkepQAGBeCrBlFHnEHo5h4EV7MZQ/YzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZuDmnxU7ZDOXhDJsxCgt+BC4fyXTmfra+LH11zaMBLCMvuiMz
	gDwMEItEcWE1daKiw1Un6SpAuodrVBPHsp3sMmj0+0+g4WsHcVZHKDbxmQXsq1Q=
X-Google-Smtp-Source: AGHT+IEknpoiPwNIZCUWqC5wlzEu9yh+Rxh2v4jcs1wvi/j58/8VhBs0RUuviEJZYalHd8CSAHV62w==
X-Received: by 2002:a05:651c:1990:b0:2ef:2b05:2ab3 with SMTP id 38308e7fff4ca-2f610392703mr13785621fa.10.1724918346154;
        Thu, 29 Aug 2024 00:59:06 -0700 (PDT)
Received: from localhost (cst2-173-13.cust.vodafone.cz. [31.30.173.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c7c2aesm382119a12.51.2024.08.29.00.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 00:59:05 -0700 (PDT)
Date: Thu, 29 Aug 2024 09:59:04 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Nick Hu <nick.hu@sifive.com>
Cc: greentime.hu@sifive.com, zong.li@sifive.com, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Conor Dooley <conor.dooley@microchip.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Sunil V L <sunilvl@ventanamicro.com>, linux-pm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] riscv: Add stimecmp save and restore
Message-ID: <20240829-fb7bda6b46302b65b2f89d20@orel>
References: <20240829033904.477200-1-nick.hu@sifive.com>
 <20240829033904.477200-2-nick.hu@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829033904.477200-2-nick.hu@sifive.com>

On Thu, Aug 29, 2024 at 11:38:59AM GMT, Nick Hu wrote:
> If the HW support the SSTC extension, we should save and restore the
> stimecmp register while cpu non retention suspend.
> 
> Signed-off-by: Nick Hu <nick.hu@sifive.com>
> ---
>  arch/riscv/include/asm/suspend.h |  4 ++++
>  arch/riscv/kernel/suspend.c      | 13 +++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/suspend.h
> index 4ffb022b097f..ffaac2efabb5 100644
> --- a/arch/riscv/include/asm/suspend.h
> +++ b/arch/riscv/include/asm/suspend.h
> @@ -16,6 +16,10 @@ struct suspend_context {
>  	unsigned long envcfg;
>  	unsigned long tvec;
>  	unsigned long ie;
> +#if __riscv_xlen < 64
> +	unsigned long stimecmph;
> +#endif

I'm not sure the reduction in struct size is worth the #ifdeffery. If we
just always add stimecmph, then we can also change the #ifdef's below to
if's, i.e. if (__riscv_xlen < 64), which should still remove the code from
64-bit builds.

Or maybe we need something like

#if __riscv_xlen < 64
#define csrh_write(r, v) csr_write(r, v)
#else
#define csrh_write(r, v)
#endif

in asm/csr.h and then use it for all the *h csrs, but keep the #if in
the struct.

Thanks,
drew

> +	unsigned long stimecmp;
>  #ifdef CONFIG_MMU
>  	unsigned long satp;
>  #endif
> diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
> index c8cec0cc5833..3afd86e1abf7 100644
> --- a/arch/riscv/kernel/suspend.c
> +++ b/arch/riscv/kernel/suspend.c
> @@ -19,6 +19,12 @@ void suspend_save_csrs(struct suspend_context *context)
>  	context->tvec = csr_read(CSR_TVEC);
>  	context->ie = csr_read(CSR_IE);
>  
> +	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SSTC)) {
> +		context->stimecmp = csr_read(CSR_STIMECMP);
> +#if __riscv_xlen < 64
> +		context->stimecmph = csr_read(CSR_STIMECMPH);
> +#endif
> +	}
>  	/*
>  	 * No need to save/restore IP CSR (i.e. MIP or SIP) because:
>  	 *
> @@ -42,6 +48,13 @@ void suspend_restore_csrs(struct suspend_context *context)
>  	csr_write(CSR_TVEC, context->tvec);
>  	csr_write(CSR_IE, context->ie);
>  
> +	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SSTC)) {
> +		csr_write(CSR_STIMECMP, context->stimecmp);
> +#if __riscv_xlen < 64
> +		csr_write(CSR_STIMECMPH, context->stimecmph);
> +#endif
> +	}
> +
>  #ifdef CONFIG_MMU
>  	csr_write(CSR_SATP, context->satp);
>  #endif
> -- 
> 2.34.1
> 

