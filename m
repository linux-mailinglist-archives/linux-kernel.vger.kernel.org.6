Return-Path: <linux-kernel+bounces-186558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA578CC5A5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 19:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 500E81C20D5B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3381422DF;
	Wed, 22 May 2024 17:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="DAsC82GC"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615C91422AE
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 17:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716399323; cv=none; b=ggfh/YowLQkIyaVzPfNGuSEf1HxOsAJaQYKQQpSSUb8TkYMuf0FVTsN2ZgFmU+pVonKBRwggMgmPDdjAyMqKApb9werxGE9wrNgk4k/mdKrb0kHuNmIVoa5WxzvU9/59QgkvlZmtLfjMZe+7Gv5vnJiKkaE7NUuORDKelciLEZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716399323; c=relaxed/simple;
	bh=h4xDjoVBbGCwsS9xKPDSs0gCw1+IXJwG83x1dxLD/vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNMo4hDKQHORzql0eFbZQP5XwGAUVw61GDpoZGl0JLfdokho5VO5OQcEBZERlGpA5ShsfRitbBOCxJ0Xg6s/fKPW+URGzsksi7yON6tNgHxl4uUG5H+qH3KkeXA8Lx3hHz9DQtcZbEDL3NmEPOBCn+v7qKQyXeMpYwchjrqmD5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=DAsC82GC; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f6911d16b4so1900720b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 10:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1716399322; x=1717004122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jtcwHXQhuywjWtHL8fvX3LFZZ/ytDiic4eCWATEojeU=;
        b=DAsC82GCCi/9D+bWWykzRIg8kz1HH1AccNbltetZKDu2pJ+CJHlGbO7mm8hxJbP5bZ
         AZHKm6y+UGpt+sCXnLKMAjkeTg3O2JZveMZJQY9GmMFzHjZ7ahOvFOEr9e7rTy86wqgs
         Qwhpo8ryAuSdGCNMU7TRKJVI+VinDwA1CElmZOD26NxLQ22a6PWV0TLP1jdv7YGzsMKM
         HShunNEKq4FD+t/LaccNSLEQra0YDuwDXndEVu4tUs0qK5CSfH29xf2gOtNwBlxshyaH
         rfCUWuZLdfVgWGoLep1iTJ4psN7PkF6mjnixxg4fKpelWHJsfACTiHEdr6TXyIyfKxo9
         czEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716399322; x=1717004122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtcwHXQhuywjWtHL8fvX3LFZZ/ytDiic4eCWATEojeU=;
        b=Qy0hAB1QchZgHplCzuykk+6Sd2uAuI5I6G3vKQ8zasO9WnCnrcl+9fplvuc91tf2YI
         tagQUhGTSQZJyNMtG8lqR1Jm0X957B2UgT+Fl+1fyXilbDjKbBUONRz3HG0e13HnhVix
         IbNwPOPqd7dwV7kvH/yFpG8ziYJKqd8dFlRu1hSprtTnUhRlIfncelGsshIMoOs64DUo
         +xWhcZHomVE/vZL9o9CKFw026CGtE2YGxaxLq90etRR9zGiYQJMYg7JOxl9yfzTq9qB5
         81tv1kaTLJB8uMABm/eS2FOH/hm8bfmNeGqLmFNA+VQ4WzEhAjTiUM0vrLxSwNOVsXty
         eC1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEXKzs+94YfSIo4niLin+cxWTvZQeZAjl+dsKok7SaQJaH7Ddla0kh/yUNM2+C3YycGYeJJszj7nZ5yRaUmdCuEjEMwdacjUoHpvFi
X-Gm-Message-State: AOJu0YxhsKfolV55kJy56eP1mGqWseKO3OiJ0y8eHwWzRu793QLyLoBv
	bcwXc8ZK3iVEgm5SzSZZHGctNhOs5YKfahFVej5E6QyudAajiOIOSYaGa2OYpoU=
X-Google-Smtp-Source: AGHT+IFnVExZ9w4FLsmZMki4aPDFIr85cfle6enyYjYsVAi4+pfoOCqX9NTQeS826YOJ4cg7meMOkA==
X-Received: by 2002:a05:6a00:3cc7:b0:6f3:ecdc:220e with SMTP id d2e1a72fcca58-6f6d617a507mr3058370b3a.24.1716399321714;
        Wed, 22 May 2024 10:35:21 -0700 (PDT)
Received: from sunil-laptop ([106.51.188.31])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a9d976sm22673408b3a.89.2024.05.22.10.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 10:35:21 -0700 (PDT)
Date: Wed, 22 May 2024 23:05:03 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Haibo Xu <haibo1.xu@intel.com>
Cc: arnd@arndb.de, xiaobo55x@gmail.com, ajones@ventanamicro.com,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Guo Ren <guoren@kernel.org>, Baoquan He <bhe@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Zong Li <zong.li@sifive.com>,
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	James Morse <james.morse@arm.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Evan Green <evan@rivosinc.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ard Biesheuvel <ardb@kernel.org>, Tony Luck <tony.luck@intel.com>,
	Yuntao Wang <ytcoode@gmail.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v3 5/6] ACPI: NUMA: change the ACPI_NUMA to a hidden
 option
Message-ID: <Zk4sxy4a5gy6ZfdJ@sunil-laptop>
References: <cover.1713778236.git.haibo1.xu@intel.com>
 <5c3a005a67096010cf3c465f8e3362651763fe3b.1713778236.git.haibo1.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c3a005a67096010cf3c465f8e3362651763fe3b.1713778236.git.haibo1.xu@intel.com>

On Wed, Apr 24, 2024 at 01:46:25PM +0800, Haibo Xu wrote:
> x86/arm64/loongarch would select ACPI_NUMA by default and riscv
> would do the same thing, so change it to a hidden option and the
> select statements except for the X86_64_ACPI_NUMA can also go away.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Suggested-by: Sunil V L <sunilvl@ventanamicro.com>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  arch/arm64/Kconfig        | 1 -
>  arch/loongarch/Kconfig    | 1 -
>  drivers/acpi/numa/Kconfig | 5 +----
>  3 files changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 7b11c98b3e84..c6c667898da6 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1439,7 +1439,6 @@ config HOTPLUG_CPU
>  config NUMA
>  	bool "NUMA Memory Allocation and Scheduler Support"
>  	select GENERIC_ARCH_NUMA
> -	select ACPI_NUMA if ACPI
>  	select OF_NUMA
>  	select HAVE_SETUP_PER_CPU_AREA
>  	select NEED_PER_CPU_EMBED_FIRST_CHUNK
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index a5f300ec6f28..29d574a5c34c 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -465,7 +465,6 @@ config NR_CPUS
>  config NUMA
>  	bool "NUMA Support"
>  	select SMP
> -	select ACPI_NUMA if ACPI
>  	help
>  	  Say Y to compile the kernel with NUMA (Non-Uniform Memory Access)
>  	  support.  This option improves performance on systems with more
> diff --git a/drivers/acpi/numa/Kconfig b/drivers/acpi/numa/Kconfig
> index 849c2bd820b9..f33194d1e43f 100644
> --- a/drivers/acpi/numa/Kconfig
> +++ b/drivers/acpi/numa/Kconfig
> @@ -1,9 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  config ACPI_NUMA
> -	bool "NUMA support"
> -	depends on NUMA
> -	depends on (X86 || ARM64 || LOONGARCH)
> -	default y if ARM64
> +	def_bool NUMA && !X86
>  
LGTM.

Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>

