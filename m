Return-Path: <linux-kernel+bounces-327351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1882B977484
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 00:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9662EB22770
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 22:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774071C2326;
	Thu, 12 Sep 2024 22:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="RaV8bw4G"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BAD1A3020
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 22:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726181312; cv=none; b=bDbPBPV3K6fscOYD0U+2W7ef9piVWSf/QDpRaF4l8Uato7k2iY9DXSLgJ+istvZavEeiYabIgq6hg7vubQOqSohmRKPNFkZmbKN1GPJOXdiotWJHxRjntz9jCcf5OFdlNQNLu9OExb+K6VxjpGxnzsp3H0ECt4G487Bo8JdS4/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726181312; c=relaxed/simple;
	bh=NtxiMajVJoGl4F42ukndc9cQWspUtiQ7t8WML53k3xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vdp6p1TtLSDb7wWJySqMylQ4E7F1ALHIr1jB+aUW8+h5dQSphaM1CITCJF4Am0FjljrRriQd4JNehDW393UVMYGsemTkSLrdHf1Eao7vj8lZuGvYkExpyx84FG1LKm5b8IGnVf9QCgf3XyMYAI0vQSI6PLlVRWPQmkLOCfaqEJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=RaV8bw4G; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-718e285544fso267438b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726181310; x=1726786110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/h00ZjLk2imx8cWKKpvEPhErDm4Vfw4gifc+W6TK3Es=;
        b=RaV8bw4GAI3FdCxWXt7Ie4tdKtJNiZmeZRUybplZ+81uS1/kB735sf4wMBCekXRQR5
         8M6GRjM9m+GMAa1G8otuvddM8gV7KuumON3ZNms+G6Kpgbjc57BoISyjrFa+5wbpaw/Q
         sftFYeQdIQr6Wgs9mXHY4biRCN1vviCDGTpj3Ffrrk9NRQFKp8LciDe9/kAh4fogn7FE
         XSglnIHsDTb/tYYCtXGI7ATZTO0RTAvte90yqoQTdkE96EHjsMkWju7jKNKSAFnxRmnL
         0Zi2K550xDiNTDLL9rrtns4n8WtBlvKUHwClWKBpn73ak7aCBwlsxVhCWGiS0vbQSoO9
         7nJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726181310; x=1726786110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/h00ZjLk2imx8cWKKpvEPhErDm4Vfw4gifc+W6TK3Es=;
        b=PuV9XZyDTlFPEdqdpwekBuivNuljiA88otdhutpPDtqNjG+ATy9oE18Qf8MgaCzyEj
         JKRSAYrLN+OuCQNaWZnl6SbUbF3vCCYQMdgvJCBOQuFkxRv7yIVJk14LSgezhNtLimgP
         OrMZSp3ADAP56+4wu96a9u8dgxmpp4qPgNFqu5DqpkGmwl8XKdRRKF9KnJosxXeY5cLn
         T0vV4YLqmOqCXQ6OEjrer4H0CgJgMYKGBVHLMPIPDdLsI2U1NZe92QAyLDHdSRw7+2ts
         iesTCmfz1G9xiZuW8+5J5xAqTxOiT3GWK0/x7DKFc/+21qvjzc0TviYM3cdH+Zz36ykh
         D0Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWI1RRXjE79VKx2j2xdVOwShrVck1SgYY+RSSNFTqaXbRm1UbGlcOJEHNRJDkeZdrE4m8xXV1MKcvtzcyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJF+WIs0oGo/1HH0zqQWOkmjYQxb43e6+r+IdBpfEVrGS3GIW0
	y7JtvdSGBab88hMNa5GlkwGQx5fvYjUQyTbv4o/RBdirVA9W03GzsGdjOkuWlCQ=
X-Google-Smtp-Source: AGHT+IFHKYA2lFjm6mZXPMtdBmTm4ranRMQPIItlOqGD1foZiKQNThK7a9zBsWSaCcACNEYgUZSExg==
X-Received: by 2002:a05:6a00:39aa:b0:714:160e:8f5f with SMTP id d2e1a72fcca58-71936a4f533mr1500265b3a.11.1726181309514;
        Thu, 12 Sep 2024 15:48:29 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719090d11e6sm5008302b3a.205.2024.09.12.15.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 15:48:28 -0700 (PDT)
Date: Thu, 12 Sep 2024 15:48:26 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org,
	Deepak Gupta <debug@rivosinc.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Andy Chiu <andy.chiu@sifive.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: Re: [PATCH v3 1/3] riscv: Enable cbo.zero only when all harts
 support Zicboz
Message-ID: <ZuNvukQnx9ghn6+6@ghost>
References: <20240718004808.2246354-1-samuel.holland@sifive.com>
 <20240718004808.2246354-2-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718004808.2246354-2-samuel.holland@sifive.com>

On Wed, Jul 17, 2024 at 05:47:54PM -0700, Samuel Holland wrote:
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
> Reviewed-by: Deepak Gupta <debug@rivosinc.com>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>

> ---
> 
> Changes in v3:
>  - Rebase on riscv/for-next
> 
>  arch/riscv/kernel/cpufeature.c | 7 ++++++-
>  arch/riscv/kernel/suspend.c    | 4 ++--
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 0366dc3baf33..4efaf12b470e 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -27,6 +27,8 @@
>  
>  #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
>  
> +static bool any_cpu_has_zicboz;
> +
>  unsigned long elf_hwcap __read_mostly;
>  
>  /* Host ISA bitmap */
> @@ -97,6 +99,7 @@ static int riscv_ext_zicboz_validate(const struct riscv_isa_ext_data *data,
>  		pr_err("Zicboz disabled as cboz-block-size present, but is not a power-of-2\n");
>  		return -EINVAL;
>  	}
> +	any_cpu_has_zicboz = true;
>  	return 0;
>  }
>  
> @@ -874,8 +877,10 @@ unsigned long riscv_get_elf_hwcap(void)
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

