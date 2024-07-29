Return-Path: <linux-kernel+bounces-265802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4890A93F623
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD2BD1C22217
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB63148314;
	Mon, 29 Jul 2024 13:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Wrv3EeBw"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109191420D0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722258337; cv=none; b=tXC5dsdVveQJxPe43C0M42rBWTWQS7wWnbxwmRYxTVNHG3QFagIwuQjG3Y7Th5TTaIGGHl92uLDNKVLNuhuburL9/mCut6tBomw6E9DrXzl1AEzuLMZC8vHqdEt4adKhPLnku+S9yvp2Kd6YpllLKSzr6J8n0NiIrsOM6GTgo+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722258337; c=relaxed/simple;
	bh=Cah9Ls8WTDTMm/sfnBeGjdlMY6StD0qfOF7XAI67hxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFrUqxfMWCnsobqhh30xnm2yyLdTAYPZ9xHX3MH50YSYzaYrkx3AcqrMefvle4OmsEXf2ROvnqAl5hoNbnIv/EVKa9A/JVI2EeC4J6/I/uC1ap+R4IJI7AAlgN1hl7WStiJo6VVgpXADWc167b+pglYn6lWoKn9ZwzDpp7HBR2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Wrv3EeBw; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a108354819so5658704a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 06:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1722258334; x=1722863134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oL6Ei2KYeBDeJNbLf68ofb+Lx3i9/7UrWfP1UrSTo+I=;
        b=Wrv3EeBwtBCcBtvAIXpmLegvpxBnIx2F/i2+e77DVMWo98tLSPCuyh9kfVXSM1Ea4H
         IyZq+yZrN/sPCzci31ZE6bxoJqAe6s/KiUXkTm6kMd4TttYUr3y9k4RuyM6l4jqMWJil
         jns1gCiH5HOI92ohk8fc5jCoY3B77pv3GBh0gpNyCfoMFeh8HBwq29N9nGJw5MHWUq6o
         u4JpCmlhCpH3O5Phs3ocQyu6xUXHWstVCeN0rs0CJlVLbHpDODozGVuJwUGdnwl/oAaO
         quIkg/je7DiXWCs1ycFr6Oy9ek3glM81bXEf5AmBEF3ndHUB+NHQoI97mt0BnnuGkqLC
         bv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722258334; x=1722863134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oL6Ei2KYeBDeJNbLf68ofb+Lx3i9/7UrWfP1UrSTo+I=;
        b=xCmNgSwquZT5pOQ7dIzKSoc4/bF6LjI4SzscCDy+/Os8ZWA15QpY3l2rxBVuCq4E66
         vwDIetQB0MRtQuli9tLFL3q/lXMa1K+vytfPgsVyuY7CAbLlDSIFOE5k/P0qsaKbWIMI
         mV8SIb4qHmTGOoSjUFXg0Zku+c5KQOleidgKQ57HxXUtJImYIJmV8wHT4CrqEU4tCd9F
         rAYXuSRueXaRAcH2tSQp4lfeNd1cxomJAxmKzTVbjDQUY2Uff5/R7cHgtQq346AQBKZz
         WQ/keVK10thpYQ+TQcv6u71U2zei+hcaA321T3i+L3bAjNY/j8+LEjltzkp5cD12etoh
         xE0g==
X-Forwarded-Encrypted: i=1; AJvYcCWrqt9VLTb+v/Kb1oBrN4MG/D/zEXoK605FNOkdQgzt2/LijPaLDeVbiAiiQTtMviMdcQDqNbOiCEd3FmkSt9cJDAblZYyctVxMjNWp
X-Gm-Message-State: AOJu0YxoYxhl4XAabNL/NTBVi/qbQ55Yz//7PUpiqqdMs+vnthjG5YtQ
	f+NuJGsUllLPxvLoCZLzZZJixND3Zc9xAcnZEe3tmKnNniRrocAiP0zdwydKjQw=
X-Google-Smtp-Source: AGHT+IF0LI+nFBLvWwrjgKxa86+5pT2h9JjZMBwNTkHKWP7qRNiQQsN51SlBoLwcS80o17x5Hl5UHQ==
X-Received: by 2002:a05:6402:13ce:b0:59f:9fc7:1e70 with SMTP id 4fb4d7f45d1cf-5b02000c21amr5865160a12.6.1722258334038;
        Mon, 29 Jul 2024 06:05:34 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63b5a7a0sm5773400a12.51.2024.07.29.06.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 06:05:33 -0700 (PDT)
Date: Mon, 29 Jul 2024 15:05:32 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Haibo Xu <haibo1.xu@intel.com>
Cc: sunilvl@ventanamicro.com, xiaobo55x@gmail.com, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Gavin Shan <gshan@redhat.com>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	James Morse <james.morse@arm.com>, Hanjun Guo <guohanjun@huawei.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] ACPI: NUMA: initialize all values of acpi_early_node_map
 to NUMA_NO_NODE
Message-ID: <20240729-fdff8667bb22fcd63ea33ce3@orel>
References: <20240729035958.1957185-1-haibo1.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729035958.1957185-1-haibo1.xu@intel.com>

On Mon, Jul 29, 2024 at 11:59:55AM GMT, Haibo Xu wrote:
> Currently, only acpi_early_node_map[0] was initialized to NUMA_NO_NODE.
> To ensure all the values were properly initialized, switch to initialize
> all of them to NUMA_NO_NODE.
> 
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>

Thanks, but I think Reported-by, or both Reported-by and Suggested-by,
is more appropriate. Also, I agree with Sunil that we probably need to
split this patch for arm64 and riscv in order to add appropriate Fixes
tags.

> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  arch/arm64/kernel/acpi_numa.c | 2 +-
>  arch/riscv/kernel/acpi_numa.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
> index 0c036a9a3c33..2465f291c7e1 100644
> --- a/arch/arm64/kernel/acpi_numa.c
> +++ b/arch/arm64/kernel/acpi_numa.c
> @@ -27,7 +27,7 @@
>  
>  #include <asm/numa.h>
>  
> -static int acpi_early_node_map[NR_CPUS] __initdata = { NUMA_NO_NODE };
> +static int acpi_early_node_map[NR_CPUS] __initdata = { [0 ... NR_CPUS - 1] = NUMA_NO_NODE };
>  
>  int __init acpi_numa_get_nid(unsigned int cpu)
>  {
> diff --git a/arch/riscv/kernel/acpi_numa.c b/arch/riscv/kernel/acpi_numa.c
> index 0231482d6946..ff95aeebee3e 100644
> --- a/arch/riscv/kernel/acpi_numa.c
> +++ b/arch/riscv/kernel/acpi_numa.c
> @@ -28,7 +28,7 @@
>  
>  #include <asm/numa.h>
>  
> -static int acpi_early_node_map[NR_CPUS] __initdata = { NUMA_NO_NODE };
> +static int acpi_early_node_map[NR_CPUS] __initdata = { [0 ... NR_CPUS - 1] = NUMA_NO_NODE };
>  
>  int __init acpi_numa_get_nid(unsigned int cpu)
>  {
> -- 
> 2.34.1
>

With the tags additions,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew

