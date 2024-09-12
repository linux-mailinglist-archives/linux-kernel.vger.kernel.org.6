Return-Path: <linux-kernel+bounces-327365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B6F9774A6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 01:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A52DA28445F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 23:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A2219E98B;
	Thu, 12 Sep 2024 23:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="BJgTVTJG"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8279049654
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 23:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726182100; cv=none; b=YRrIEmSUkiSd/FsBtSDJI2WYPfdvQ8TeMaq3r9F5wSzq1iE3ch03GCAB3AUFXqoK37xxdT+m0f2Hj4dv2xxXZ+c02Z8FTXp765hmbhmpToCsgaio5SciwGZjrD5ypU/ptKCzCmd9BunO6H8jMriT5kaebMfr0/79k8eTvcEslaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726182100; c=relaxed/simple;
	bh=IawwxT8RgkovRSNlbIXTBn8jyM3A45DJni2eOsvVrkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1hiSNtCSK0cVWEEpaRm/sCoXCC8foGUXmgLQeFo9a/kIwUCe5EqA22r9SxzGaK67+x+XrCMbjTIDn3BCazbtqNA3ENHIBRaaf22x/0kM5PF31NNYV9rnjU4WMI84tQ9tIrY3VYd3KWgLg8eOuZAhMRF0ge6FH6/qFSfF1p78dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=BJgTVTJG; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71790ed8c2dso1263440b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 16:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726182098; x=1726786898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gXcV8jbFts4t9XD/hggH3giDaMs3zJsjMShL2Y10OZY=;
        b=BJgTVTJGyvtDPWi0F17HfrvAUasrsmvmWpNDzSBrc5vcPy7oswY9DDHFR/IeQUN1bF
         GtoAw9zc801EP8IOA58RHMwVOvJ6WFWTXrptfuh6Yg+hNXFLt5ldbNasnHwP0IwqIeWt
         +DWllp3jepCbLGARKLFhlsJQ07WdTlOXs0ZWyPzmSqHwRPP+Vp7idxaLa0dVdDi3W0Ml
         qk65jTkcq4skh7VxVeqPT8+jaIN4eDGz8BMjSWc49tBGdIQJao/SaHKaRklJnXDUwkYB
         GjAouRHHqWwVkdig5bf3rDfGV7+0sMkw1Aor2HVXZTdqJt7AfZJHFWYHwankvrr5RVzh
         CoPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726182098; x=1726786898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXcV8jbFts4t9XD/hggH3giDaMs3zJsjMShL2Y10OZY=;
        b=tJEeXxXkdHrMXrwYo4rLQ8yuR7/W+vuVivB3wNKVMfEU93/d/4IoEPEB5B4g8eP03Q
         +b7Ipnpb5KOLHL3OLhIlThZhpjl/It6FUCrIbWf/jWD1OAa6kmsCyf0N+/tKZ++s+wCz
         GY4DRzLwzHQgHchPm7W74ANft2jf0sXnzmQk1M7Mgy5QyTm2u4weoO20ELHwnhxBgnT/
         2c8NMW3+LIif69ESopLn8DpAG1FHPIreLffosL3zZTzcPp1gavuGK0bi/sb5eAvdFUN0
         G7TlINgbMTW7tAAtvWnU89sBUs1JA3DGHSplAc1WYyWHfKSXqdB3SUJ7d7nhwvJNRu1o
         A1Eg==
X-Forwarded-Encrypted: i=1; AJvYcCURZXji54KyudiAZD4LWWTziUS09HWiTcA0ZMIG+cOojR8vxt6lZCP2qRO5ABnVbPKEhfuSG6ApC+34VqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc3M4SsioRtA8uZTb8q0UA/iE8ooMhAKyLjsAaFsjsKWV2JqwG
	vMxqBKdv/v+Rpm//ZFO0i9ljObP8D7x4KrVgCl7C3E43QtexKEF7Z8sG6zh3lQlZerAAC4Uo0vm
	W
X-Google-Smtp-Source: AGHT+IGA0ZtiOG8+WbEJ7rjuu0f8eCrPbZ5QeaMeNPlHl9dVMItuTHlOjdo8kxxxxAZ9gUAw9fT6bA==
X-Received: by 2002:a05:6a00:1906:b0:70d:2621:5808 with SMTP id d2e1a72fcca58-7192607fcb9mr6715512b3a.9.1726182097519;
        Thu, 12 Sep 2024 16:01:37 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fddd86asm2221706a12.68.2024.09.12.16.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 16:01:36 -0700 (PDT)
Date: Thu, 12 Sep 2024 16:01:34 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org,
	Deepak Gupta <debug@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Andy Chiu <andy.chiu@sifive.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: Re: [PATCH v4 1/3] riscv: Enable cbo.zero only when all harts
 support Zicboz
Message-ID: <ZuNyztqpH09ns0ws@ghost>
References: <20240814081126.956287-1-samuel.holland@sifive.com>
 <20240814081126.956287-2-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814081126.956287-2-samuel.holland@sifive.com>

On Wed, Aug 14, 2024 at 01:10:54AM -0700, Samuel Holland wrote:
> Currently, we enable cbo.zero for usermode on each hart that supports
> the Zicboz extension. This means that the [ms]envcfg CSR value may
> differ between harts. Other features, such as pointer masking and CFI,
> require setting [ms]envcfg bits on a per-thread basis. The combination
> of these two adds quite some complexity and overhead to context
> switching, as we would need to maintain two separate masks for the
> per-hart and per-thread bits. Andrew Jones, who originally added Zicboz
> support, writes[1][2]:
> 
>   I've approached Zicboz the same way I would approach all
>   extensions, which is to be per-hart. I'm not currently aware of
>   a platform that is / will be composed of harts where some have
>   Zicboz and others don't, but there's nothing stopping a platform
>   like that from being built.
> 
>   So, how about we add code that confirms Zicboz is on all harts.
>   If any hart does not have it, then we complain loudly and disable
>   it on all the other harts. If it was just a hardware description
>   bug, then it'll get fixed. If there's actually a platform which
>   doesn't have Zicboz on all harts, then, when the issue is reported,
>   we can decide to not support it, support it with defconfig, or
>   support it under a Kconfig guard which must be enabled by the user.
> 
> Let's follow his suggested solution and require the extension to be
> available on all harts, so the envcfg CSR value does not need to change
> when a thread migrates between harts. Since we are doing this for all
> extensions with fields in envcfg, the CSR itself only needs to be saved/
> restored when it is present on all harts.
> 
> This should not be a regression as no known hardware has asymmetric
> Zicboz support, but if anyone reports seeing the warning, we will
> re-evaluate our solution.
> 
> Link: https://lore.kernel.org/linux-riscv/20240322-168f191eeb8479b2ea169a5e@orel/ [1]
> Link: https://lore.kernel.org/linux-riscv/20240323-28943722feb57a41fb0ff488@orel/ [2]
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Deepak Gupta <debug@rivosinc.com>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---

I realized I was looking at v4 but responding to v3, whoops. I will put
my tags here as well.

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>

> 
> (no changes since v3)
> 
> Changes in v3:
>  - Rebase on riscv/for-next
> 
>  arch/riscv/kernel/cpufeature.c | 7 ++++++-
>  arch/riscv/kernel/suspend.c    | 4 ++--
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index b427188b28fc..0139d4ea8426 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -28,6 +28,8 @@
>  
>  #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
>  
> +static bool any_cpu_has_zicboz;
> +
>  unsigned long elf_hwcap __read_mostly;
>  
>  /* Host ISA bitmap */
> @@ -98,6 +100,7 @@ static int riscv_ext_zicboz_validate(const struct riscv_isa_ext_data *data,
>  		pr_err("Zicboz disabled as cboz-block-size present, but is not a power-of-2\n");
>  		return -EINVAL;
>  	}
> +	any_cpu_has_zicboz = true;
>  	return 0;
>  }
>  
> @@ -918,8 +921,10 @@ unsigned long riscv_get_elf_hwcap(void)
>  
>  void riscv_user_isa_enable(void)
>  {
> -	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICBOZ))
> +	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICBOZ))
>  		csr_set(CSR_ENVCFG, ENVCFG_CBZE);
> +	else if (any_cpu_has_zicboz)
> +		pr_warn_once("Zicboz disabled as it is unavailable on some harts\n");
>  }
>  
>  #ifdef CONFIG_RISCV_ALTERNATIVE
> diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
> index c8cec0cc5833..9a8a0dc035b2 100644
> --- a/arch/riscv/kernel/suspend.c
> +++ b/arch/riscv/kernel/suspend.c
> @@ -14,7 +14,7 @@
>  
>  void suspend_save_csrs(struct suspend_context *context)
>  {
> -	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_XLINUXENVCFG))
> +	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_XLINUXENVCFG))
>  		context->envcfg = csr_read(CSR_ENVCFG);
>  	context->tvec = csr_read(CSR_TVEC);
>  	context->ie = csr_read(CSR_IE);
> @@ -37,7 +37,7 @@ void suspend_save_csrs(struct suspend_context *context)
>  void suspend_restore_csrs(struct suspend_context *context)
>  {
>  	csr_write(CSR_SCRATCH, 0);
> -	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_XLINUXENVCFG))
> +	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_XLINUXENVCFG))
>  		csr_write(CSR_ENVCFG, context->envcfg);
>  	csr_write(CSR_TVEC, context->tvec);
>  	csr_write(CSR_IE, context->ie);
> -- 
> 2.45.1
> 

