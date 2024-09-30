Return-Path: <linux-kernel+bounces-344450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FDE98A9C0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DAAF281520
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7D8193062;
	Mon, 30 Sep 2024 16:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="jOEEmuPW"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F061C18EFFA
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 16:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727713702; cv=none; b=i3e9fJsOiCkaPxQdEzTwCe/9L/n/Wj2rt9GE5gFuAURz4gdzK79Es2IaJe3kZZk5i9TGGhxdditllpxmcUaiApMaU80MkEuIrDifIQ9IST99dlxg+BXk4exKUBP34GWbI3XBmAKIJOJRnTN5+xbweVoK3TEMY95QCRkTEl9El0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727713702; c=relaxed/simple;
	bh=Y9PKmiUsvzYWzqXdVhWZcJsPhtaaCIQO33lN2V8zD7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngSkkRygPSKPudl1Uko4/ocxXl8uAOW8mu5i0hDJ5+mTTV41cAFXGl4PDClNREpcP+prFbDPVKHY7EbGLmHRunv9zSr5LSrurGi9/ScxB0JZ/yS+x+9ln287uWWhdxm32PUAXIeJUWhpgF6pQITzVyEIDaIJCpI/V6/X/7uEVFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=jOEEmuPW; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-710f44f8cc9so2739458a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 09:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1727713700; x=1728318500; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u26AHe8qW6WrMNznYkx5Wjri5Kg2+jGayT+z3qw7kdo=;
        b=jOEEmuPWc+d6xzFk39vBpvZnUEDOd4sku/iOxsKA/VFSc+WniafIiStjxlyWldWp27
         N13oDIsvwO7x09KnOUjGbP76BtZ0olmfzqRComRSsZXJFhVzUKNG1W8aX0gXTMjr6mhu
         AgVSo+EbtzT81fIVjxflJ4gF6soxdCOd8Q0wEBX+KPd4RVf6sNx26GYUR7eDdm0eBtnf
         HR3rIMOdzZUK/G45IZV3A3TuxyFoeCAFOnynJM/QOblWH9FGS5GpWDWxuodqxdvVtxEc
         OG0R87U5+YfSmVHC+b4mva+rELByuZBn9YnCG71Ug4IiPfnPsZCGtm5bZLEcAHjQEI99
         tSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727713700; x=1728318500;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u26AHe8qW6WrMNznYkx5Wjri5Kg2+jGayT+z3qw7kdo=;
        b=WQPtjJSPBdsZCfBhmcxj0kCdYaXh4GuWwG+9G+rQe5/Vc3e3T/8PxCKalzEYYevrwE
         LZYLGAASXrMHvg9tqKirbJrx/U2A5qGyX7rw9vBnK8Mt2XeYkrqCB2xO8rzqyCy6F0xd
         Kse6leyN0Wuo1lTJVs7B6z/gcxqlNkk3vZ04EuNTMWluq0QVqL/ZW5WM9bpWSontdtVM
         lkcG2ruqkT8csCg/Zq6bwDMlyFtBK8TsJjDdd4DmCvQX7URm2D15So0L/jsbBLgsOMYx
         +/pVkMqNAjaLGGilAnum+Yda+py3uTScVVwi8x8TM7+AhxewBiC1uNkN3KTjxU1RRaUo
         /uHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8fgDBsuT7AFUuZyXgfkxRiuEGzADufkm5Z4ERkdQPhgTUOBRF7TKkA83fXzhKeZ3GdTHYqRMFTmbjWm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDK3Ed7hBHqCDhvyJs0n97upqeM/KH63xnfErbzpQzllqndDLE
	9yeAnszvMOcTAt/vOEBHHw9e/2sZ33AmCeNYld5EEJuSc9wZPS1kFLA02BvOpYg=
X-Google-Smtp-Source: AGHT+IGM05fYy8IDp69U6l4O00QmQxNfIzJ7eXngleOfu4Zv9vUEqnJjXTMet+NXOfXDlkGLAOJRug==
X-Received: by 2002:a05:6808:14cd:b0:3e0:489b:9bd8 with SMTP id 5614622812f47-3e3acbb96cemr96706b6e.16.1727713700022;
        Mon, 30 Sep 2024 09:28:20 -0700 (PDT)
Received: from sunil-laptop ([106.51.192.229])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e3935c67e6sm2513939b6e.54.2024.09.30.09.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 09:28:18 -0700 (PDT)
Date: Mon, 30 Sep 2024 21:58:10 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Miquel =?utf-8?B?U2FiYXTDqSBTb2zDoA==?= <mikisabate@gmail.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	cuiyunhui@bytedance.com, sudeep.holla@arm.com,
	jeremy.linton@arm.com, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Prevent a bad reference count on CPU nodes
Message-ID: <ZvrRmqvmVjvmACsd@sunil-laptop>
References: <20240913080053.36636-1-mikisabate@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240913080053.36636-1-mikisabate@gmail.com>

On Fri, Sep 13, 2024 at 10:00:52AM +0200, Miquel Sabaté Solà wrote:
> When populating cache leaves we previously fetched the CPU device node
> at the very beginning. But when ACPI is enabled we go through a
> specific branch which returns early and does not call 'of_node_put' for
> the node that was acquired.
> 
> Since we are not using a CPU device node for the ACPI code anyways, we
> can simply move the initialization of it just passed the ACPI block, and
> we are guaranteed to have an 'of_node_put' call for the acquired node.
> This prevents a bad reference count of the CPU device node.
> 
> Moreover, the previous function did not check for errors when acquiring
> the device node, so a return -ENOENT has been added for that case.
> 
> Signed-off-by: Miquel Sabaté Solà <mikisabate@gmail.com>
> ---
> I was wondering if this should also be sent to stable, but  I have not seen
> a report on it, and this is not responsible for an oops or anything like that.
> So in the end I decided not to, but maybe you consider otherwise.
> 
>  arch/riscv/kernel/cacheinfo.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
> index d6c108c50cba..d32dfdba083e 100644
> --- a/arch/riscv/kernel/cacheinfo.c
> +++ b/arch/riscv/kernel/cacheinfo.c
> @@ -75,8 +75,7 @@ int populate_cache_leaves(unsigned int cpu)
>  {
>  	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
>  	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
> -	struct device_node *np = of_cpu_device_node_get(cpu);
> -	struct device_node *prev = NULL;
> +	struct device_node *np, *prev;
>  	int levels = 1, level = 1;
> 
>  	if (!acpi_disabled) {
> @@ -100,6 +99,10 @@ int populate_cache_leaves(unsigned int cpu)
>  		return 0;
>  	}
> 
> +	np = of_cpu_device_node_get(cpu);
> +	if (!np)
> +		return -ENOENT;
> +
LGTM.

Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>

Thanks,
Sunil

