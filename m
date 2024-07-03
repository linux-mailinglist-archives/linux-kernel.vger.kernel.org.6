Return-Path: <linux-kernel+bounces-240222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1911C926A67
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB2BE28402F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA46191F80;
	Wed,  3 Jul 2024 21:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="s+Ogc7vL"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26031849C4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 21:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042656; cv=none; b=MAqvyYhOOxUdnqjxQlkwR/w75AUBZl/3DaPQXZZ3lkA38xphqeOV2qNzBXTAB1P5BMvfpMsX+2uIaWI51r+MrRBA5HyWN/WWYoa42dKMUpuh3lkNpXZjM4gG0UauKZLvncDlwhi96HOfi8GxV5bte5mjc0QloUYOJi9jv0ykesc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042656; c=relaxed/simple;
	bh=uYt6o+zEHfwFk+zn+k05obxJHzNcf+MyzWshPyi92gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJyHIdEmP+ypxD5IXJIG2sWwYqcjD0ffDSm7/ld628k4pOYfE5zTqLBFP7XR2a+3Hv/Un9KG6/AYwm5ecdg4mLAL7J+2EGpD0mMJEEX4sKPU0Y3r8X6t0jMiDTKdWja5c6U1Wb5DwNXE0vO5tS241FHNIQEjlghGZJj9D7qbIcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=s+Ogc7vL; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-25e0d750b73so8736fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 14:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1720042654; x=1720647454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zJl5lbxOblXV+VY9eYdDhIzc4AxnB7Ej+x8YMqN+ZTk=;
        b=s+Ogc7vLXlaLPT6/h0cux9GusCuEgeyCUYc7MgiLI6AuW6SpbhGajqzkeuf2h1uqLJ
         cCPKS05CGDXYjfH9PUEJdxiTJ4r0d2oLLZHkBV6jPmRlYeythKlhBNWb2z5+fOsDCWs5
         NG8/6IwtZrC7OOKAsboIpRiZ32N0k4FJoA9okudavUhMPc5QbtUK+bDVS8CPZ5e0og3/
         g94EF2ZJ8WsKUapeZY2gIzis16EgR9kSF/XRmGWgflcjxiPvWDmID5ZN6i0HmsaT8DKD
         41yPAujg4excfv6sek2hxsdPBDU2CjuuH3nLcAfjuC0/IW3syvcOktlVNmFCnGsLVKdD
         x5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720042654; x=1720647454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJl5lbxOblXV+VY9eYdDhIzc4AxnB7Ej+x8YMqN+ZTk=;
        b=mnyfs/x2SUqCpRR1NNULdleJioTFjQT/CLZfIvzg1/J/SsU4FPX56JsFbJ2/QuKiEq
         gdZ3WH4hUaYSU96Y902qywEUTolxf3cPVmSdzXQywzZUHEmt0HIdNarBtA7iN7MRttuv
         A7vG3s+wXtUJKumn+aH+nMaEvVfdNXO+0MqIwJYrPglOlWS82RZxBOX83wlq6BOngYs+
         Fr+kG1yCsKHKiMhFNPnSRVPfHcla0z4C3Y67OhkUZxHdn/7P2vB2nOmdreKXgQ4HZhlQ
         Ebd20tkuCOGkFuNHNreOoDMC+t+d/uHzgLQTpy0JdjjJ12t++SnoGWhIJl8Qs6NtvPGX
         IKhw==
X-Forwarded-Encrypted: i=1; AJvYcCU87yiW+UWe2/lBWdHIdMiBLc1sPJfGPbJDnbVFo+xWyhLTo3vT2367cEWkTPOMhJ2r+IguXEUpU4QW9Wry9bLRbXZonVM3fFRA+uHH
X-Gm-Message-State: AOJu0YynckHoVYpQV2rvFvyWNN9fO2YwBoW5clMdYyUDWPuhwjlBBsuG
	D6P78NEQIyofklBcYkDRzgAsWf4p2cJfmAJP9WNbdQiqm2jEfAzhnDosTpoWJNc=
X-Google-Smtp-Source: AGHT+IEeWsp99UN1m39sv7cNO+ei78yo6Zs/uUaB9KxR7A/1pZfRAcG15szQcDfzaxshAXC9DRQK3Q==
X-Received: by 2002:a05:6870:168e:b0:25e:1711:90e3 with SMTP id 586e51a60fabf-25e17119566mr1870117fac.2.1720042653830;
        Wed, 03 Jul 2024 14:37:33 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080205a180sm11253906b3a.18.2024.07.03.14.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:37:33 -0700 (PDT)
Date: Wed, 3 Jul 2024 14:37:30 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: rppt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alexghiti@rivosinc.com,
	akpm@linux-foundation.org, bhe@redhat.com, dawei.li@shingroup.cn,
	jszhang@kernel.org, namcao@linutronix.de, chenjiahao16@huawei.com,
	bjorn@rivosinc.com, vishal.moola@gmail.com,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] RISC-V: cmdline: Add support for 'memmap' parameter
Message-ID: <ZoXEmryf8RuLMZWN@ghost>
References: <20240624123739.43604-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624123739.43604-1-cuiyunhui@bytedance.com>

On Mon, Jun 24, 2024 at 08:37:39PM +0800, Yunhui Cui wrote:
> Add parsing of 'memmap' to use or reserve a specific region of memory.
> 
> Implement the following memmap variants:
> - memmap=nn[KMG]@ss[KMG]: force usage of a specific region of memory;
> - memmap=nn[KMG]$ss[KMG]: mark specified memory as reserved;
> 
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  arch/riscv/mm/init.c | 46 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index e3405e4b99af..8e1d93ae5cb2 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -208,6 +208,52 @@ static int __init early_mem(char *p)
>  }
>  early_param("mem", early_mem);
>  
> +static void __init parse_memmap_one(char *p)
> +{
> +	char *oldp;
> +	unsigned long start_at, mem_size;
> +
> +	if (!p)
> +		return;
> +
> +	oldp = p;
> +	mem_size = memparse(p, &p);
> +	if (p == oldp)
> +		return;
> +
> +	switch (*p) {
> +	case '@':
> +		start_at = memparse(p + 1, &p);
> +		memblock_add(start_at, mem_size);
> +		break;
> +
> +	case '$':
> +		start_at = memparse(p + 1, &p);
> +		memblock_reserve(start_at, mem_size);
> +		break;
> +
> +	default:
> +		pr_warn("Unrecognized memmap syntax: %s\n", p);
> +		break;
> +	}
> +}
> +
> +static int __init parse_memmap_opt(char *str)
> +{
> +	while (str) {
> +		char *k = strchr(str, ',');
> +
> +		if (k)
> +			*k++ = 0;
> +
> +		parse_memmap_one(str);
> +		str = k;
> +	}
> +
> +	return 0;
> +}
> +early_param("memmap", parse_memmap_opt);
> +
>  static void __init setup_bootmem(void)
>  {
>  	phys_addr_t vmlinux_end = __pa_symbol(&_end);
> -- 
> 2.20.1
> 

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>


