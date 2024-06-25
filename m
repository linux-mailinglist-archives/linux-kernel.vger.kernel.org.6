Return-Path: <linux-kernel+bounces-228718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 631789165E8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A864DB23EDD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DB014AD19;
	Tue, 25 Jun 2024 11:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="KAcwXyrb"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FFE1494A8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 11:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719313925; cv=none; b=Sr/Rv4IzVpnaFIKehfCNf47RYwt2DRIHFY53npACUOv1V7oE33F6npmGIE91PfGO2EeMZzdR8944bAtKh32PlKq/1MjaOIsobSifHWqGgmwvFOw/L6m7ALyo7vtwCEOWDbYxHu7WltFbv13H7pZdnkMDz20kY9npxqcMPR8jCpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719313925; c=relaxed/simple;
	bh=kjk0LK3YFu3G9wetBfeiQSN+4jlT6L8eoLRxrlIc3Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbirGgJZGUYLJyN98NVkbwqhiOIUaI91/8/EpDeERcck2yCzO40PFJ390m7xVBUBgPArsYEIVfKeynuHDSx7U/WEPBdkZa2cM2eIozbCUJ/W9WQke6a59YaA9W1xYBjszPZJJa/aEn/yTcPtfC5zitbJh9AnzcXCH8S8GFguIT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=KAcwXyrb; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-424a2dabfefso5098825e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 04:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1719313922; x=1719918722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dNSvJYQ84Lpo91/CHZiCcfBSDNWg96rwdJh6THLplUc=;
        b=KAcwXyrbBYWdI02cVbTqLuggtjCifZBnjVE+0EMmVV7VR7a6dCZ+JGp7a63C3c9u/t
         iVDZX6pk5TsX7UgA4DLv/9AvostdkHpcnaGcYSGdFm4OYy3LhvPzBYSinSiK62gI58ms
         WYfeBqGja80d/8QpZuT9ibt6LekYIaHGJ7idRcQEayW0VtWEqzkgsjkT6KHFjL5P6E5g
         V/uC0cv/CHeTlkIGus45yFRc79VZwwg6vK8Ueiu3VZ4GoU70AsWAMuXpYnjleUD9pVn9
         0p6qszVWTnICxqIKs9UJARNbIuSvePrMRK8rAA39MUZorVdsPj4TMiyfXT7WnuGDnCif
         OEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719313922; x=1719918722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNSvJYQ84Lpo91/CHZiCcfBSDNWg96rwdJh6THLplUc=;
        b=V+8xgsoi/urSRowLhz5IpB+dVJY3kI0dj+rO3bDYQN803IZstDXKDlw6XxI61y7FCU
         VuaEEnfWl8oaqVT0Ucfo/fzY8dvei0y6y89qYHEW1bJ3V0wetB5QQfIpn0FcdO83TpxM
         s+pOC63LMSPniK/qJHtGUGWqLeV+KfP71QesUhAUq7n9pS/HBAgahkWE0B6D2q0ZGt7l
         5hQZosj5GKkrNz2BX570anrUneX3aQgnaAb10eICfD7PdqM0GgJDBVhkL652qBXc85wH
         MpiuhHQbs+IUlzDLtCCjnKh8dgN9HEptIjqFE52j5acGzQoimGDjeuSlT0hF/lDHIcD+
         91CA==
X-Forwarded-Encrypted: i=1; AJvYcCVelzd6+XqYXDp0bGrIX50YL1cc6ZZAH5N/qgYOS5iRVYDJqy3kT9+rGOr28xktb5DqGiW2ogf9f954z54HGlQVhLDKS1tCBlTxbL+U
X-Gm-Message-State: AOJu0YxlVX9fs/DTJAXEolXqCjBc5NvPCf2Jvy5H1mNrM8DLQmOsMyDM
	O060eKia8GC9/iaShKX1V5OEA4f8DjUVQbxBr+E9DGnORqV9mKvk8blVgpdk670=
X-Google-Smtp-Source: AGHT+IGOs8W4dqBLPwVmEQpe8KBAzt7p9Tyv8qL9RalgDqyktsyQVdOw7/ZJpWLQpvL7uzLTru39qw==
X-Received: by 2002:a5d:6584:0:b0:360:7c17:5936 with SMTP id ffacd0b85a97d-366e965297fmr5500858f8f.58.1719313921757;
        Tue, 25 Jun 2024 04:12:01 -0700 (PDT)
Received: from localhost ([185.71.170.219])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a2f6f0csm12669975f8f.75.2024.06.25.04.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 04:12:01 -0700 (PDT)
Date: Tue, 25 Jun 2024 13:11:59 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Yuntao Liu <liuyuntao12@huawei.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Subject: Re: [PATCH] RISC-V: Dynamically allocate cpumasks and further
 increase range and default value of NR_CPUS
Message-ID: <20240625-c1c3b9fcb6ee148294d4ceb4@orel>
References: <20240614075306.357861-1-liuyuntao12@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614075306.357861-1-liuyuntao12@huawei.com>

On Fri, Jun 14, 2024 at 07:53:06AM GMT, Yuntao Liu wrote:
> Currently default NR_CPUS is 64 for riscv64, since the latest QEMU virt
> machine supports up to 512 CPUS, so set default NR_CPUS 512 for riscv64.
> 
> Under the promotion of RISC-V International and related chip
> manufacturers, RISC-V has also begun to enter the server market, which
> demands higher performance. Other major architectures (such as ARM64,
> x86_64, MIPS, etc) already have a higher range, so further increase
> this range up to 4096 for riscv64.
> 
> Due to the fact that increasing NR_CPUS enlarges the size of cpumasks,
> there is a concern that this could significantly impact stack usage,
> especially for code that allocates cpumasks on the stack. To address
> this, we have the option to enable CPUMASK_OFFSTACK, which prevents
> cpumasks from being allocated on the stack. we choose to enable this
> feature only when NR_CPUS is greater than 512, why 512, since then
> the kernel size with offstack is smaller.

This isn't the reason why Arm decided to start at 512, afaict. The reason
for Arm was because hackbench did better with onstack for 256. What are
the hackbench results for riscv?

> 
> vmlinux size comparison(difference to vmlinux_onstack_NR_CPUS baseline):
> 
> NR_CPUS     256         512         1024        2048        4096
> onstack     19814536    19840760    19880584    19969672    20141704
> offstack    19819144    19840936    19880480    19968544    20135456
> difference  +0.023%     +0.001%     -0.001%     -0.001      -0.031%
> is_smaller  n           n           y           y           y

Since the savings are almost nothing we must not have too many global
cpumasks. But I'm in favor of ensuring stack depths stay under control,
so turning on CPUMASK_OFFSTACK sounds good to me in general.

> 
> Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
> ---
>  arch/riscv/Kconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0525ee2d63c7..5960713b3bf9 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -77,6 +77,7 @@ config RISCV
>  	select CLINT_TIMER if RISCV_M_MODE
>  	select CLONE_BACKWARDS
>  	select COMMON_CLK
> +	select CPUMASK_OFFSTACK if NR_CPUS > 512
>  	select CPU_PM if CPU_IDLE || HIBERNATION || SUSPEND
>  	select EDAC_SUPPORT
>  	select FRAME_POINTER if PERF_EVENTS || (FUNCTION_TRACER && !DYNAMIC_FTRACE)
> @@ -428,11 +429,11 @@ config SCHED_MC
>  config NR_CPUS
>  	int "Maximum number of CPUs (2-512)"
>  	depends on SMP
> -	range 2 512 if !RISCV_SBI_V01
> +	range 2 4096 if !RISCV_SBI_V01
>  	range 2 32 if RISCV_SBI_V01 && 32BIT
>  	range 2 64 if RISCV_SBI_V01 && 64BIT
>  	default "32" if 32BIT
> -	default "64" if 64BIT
> +	default "512" if 64BIT

This is somewhat reasonable, even if nothing is going to use this for
quite a while, since it'll help avoid bugs popping up when NR_CPUS gets
bumped later, but it feels excessive right now for riscv, so I'm a bit
on the fence about it. Maybe if hackbench doesn't show any issues we
could turn CPUMASK_OFFSTACK on for a smaller NR_CPUS and also select
a smaller default?

Thanks,
drew

>  
>  config HOTPLUG_CPU
>  	bool "Support for hot-pluggable CPUs"
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

