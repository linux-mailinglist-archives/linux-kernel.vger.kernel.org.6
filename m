Return-Path: <linux-kernel+bounces-229512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C02917056
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67D3F1C213CB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8E617B513;
	Tue, 25 Jun 2024 18:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="NmfL+Qa3"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2B2172BC7
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 18:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719340408; cv=none; b=RD51ku6htSh/pGCF8JJ2qfsS6kVJjvucJYs9ekxfQdZCBrRaF6HTtjzPvwqg+XYR4ja8utqqAQkG9GIwct0y2Mk5qqrDLISmKYuIwTN/DmepHTfjt7oIY5cQsCl3Xon/VBGCFKb7PkjoKYrTvgwBTWh4yjhFKKalRyOJx30Dkl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719340408; c=relaxed/simple;
	bh=OFx+dARF+TxDh1xWW+q3L6lNbW9jeqgwxKdItrn2hGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdf9rQLyTaFiBbjN/z0uzOpMWYOkzTdMORZ6yyA/5l9Ogtei67FRkl8ZdMdETclR0MM+fHbYpFfBO5vTpFfCi4Wvba11UG7kYnDMknyaDwLg2ZTFiBL7qkEjufKY9xoLC9J03rcSae+PvsvVkalcQBqfDh64uiw+c9VRanIxE8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=NmfL+Qa3; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f9b364faddso47968795ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 11:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719340406; x=1719945206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ry9kqDT4CgcwIlwoEzItiGRVLYvMKM4MU9guIUm1Hv8=;
        b=NmfL+Qa3/NfUXEGn/GtascfB58+70aWFvDjtzIVo3J+TcUs6VPc2wKYrBkOoJGEHQ2
         ZBgqOjWrsp4hi5De0tqxCzzA9h7nMF/voQEXbE7HlWiggEwP3Ewe3NyXSXQcNzhyzovG
         iayRRiKy6KihWFuVf4gvpCBRDoFykopQcmK0fgCPr8r3P7pBFkGHN9X/tJCJS4uPgkAN
         gsUwD9w8+NcoBzOlnjPOG5u/Amcve+349FiwH8RfkdRhBkgOtj5VQqwm9ly9Fcp1oRQL
         irOrzf3ODfNG1fv36K9EL99eg5pWpxE4DCObbKlJfXtJSrrM+I1xxm/frU7DdfcwTnfN
         47WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719340406; x=1719945206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ry9kqDT4CgcwIlwoEzItiGRVLYvMKM4MU9guIUm1Hv8=;
        b=PWZYt0zvL3wsK+oal/z8g3WhGW2hjKHGg6+Ltj1Tzcf8JcYU4tF7ktOG6p205PK5fI
         nQzZIcEkbK69S4d024m9K2mVYkHt9U9ZofT2eLxaRu/UrqlcTtRhTiP+z28YcpTNxbFC
         i97+H5KOxWuaJQz5AalP29eUlOj3NnmukFuqmcikqdb7DA6mC5olrvnwpe4/qeDov0ng
         79WgZTg9v5eGgmUZUWB2cn+azCliYHio/ApevZ8UNiBC7zrrnU8p+JwKCioCVuJBFS9x
         9q4UAghOtBVYcgUFfM/rzABvcJQ+H6VxBYncwUQ06iuEzBgdwQVAIziJh8vm8g1cvtD6
         uWqw==
X-Forwarded-Encrypted: i=1; AJvYcCXiaFgKzbcnqnquDgy2mS5UEKHnvzsngt6eDbQ1rXBWpsvJM3XU+Txw2Oec1++tYQFCIphTo2leGAOAWyci0oZoaUHL1U7ugU12Wxen
X-Gm-Message-State: AOJu0YzHLRBBCGkQjy3JafwU2OllmiqqIp5sVFYll4P4vs2/F6up6c4A
	v8prrtHBWgvVMnIu84ZLFYqBJW2KIRqGoFECTE2R12+vmH7n+ZnhvURNeaR6n8w=
X-Google-Smtp-Source: AGHT+IGVxAUgKjd+btB4sbZk2hD8oYIZh+/DyvbKdEo+mV0urTB5M9FFR43SbdPOunmNPcwS0EvfCw==
X-Received: by 2002:a17:903:32ce:b0:1f8:3c9e:3ba8 with SMTP id d9443c01a7336-1fa23f07251mr90203205ad.10.1719340405618;
        Tue, 25 Jun 2024 11:33:25 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:b583:35e3:86c6:2f7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3c5fdesm84885955ad.164.2024.06.25.11.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 11:33:25 -0700 (PDT)
Date: Tue, 25 Jun 2024 11:33:22 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Evan Green <evan@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Yangyu Chen <cyy@cyyself.name>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Erick Archer <erick.archer@gmx.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/2] RISC-V: hwprobe: Add SCALAR to misaligned perf
 defines
Message-ID: <ZnsNctHQROouE1Nj@ghost>
References: <20240625165121.2160354-1-evan@rivosinc.com>
 <20240625165121.2160354-3-evan@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625165121.2160354-3-evan@rivosinc.com>

On Tue, Jun 25, 2024 at 09:51:21AM -0700, Evan Green wrote:
> In preparation for misaligned vector performance hwprobe keys, rename
> the hwprobe key values associated with misaligned scalar accesses to
> include the term SCALAR.
> 
> Signed-off-by: Evan Green <evan@rivosinc.com>

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

> 
> ---
> 
> Changes in v2:
>  - Added patch to rename misaligned perf key values (Palmer)
> 
>  Documentation/arch/riscv/hwprobe.rst       | 20 ++++++++++----------
>  arch/riscv/include/uapi/asm/hwprobe.h      | 10 +++++-----
>  arch/riscv/kernel/sys_hwprobe.c            | 10 +++++-----
>  arch/riscv/kernel/traps_misaligned.c       |  6 +++---
>  arch/riscv/kernel/unaligned_access_speed.c | 12 ++++++------
>  5 files changed, 29 insertions(+), 29 deletions(-)
> 
> diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
> index c9f570b1ab60..83f7f3c1347f 100644
> --- a/Documentation/arch/riscv/hwprobe.rst
> +++ b/Documentation/arch/riscv/hwprobe.rst
> @@ -215,22 +215,22 @@ The following keys are defined:
>    the performance of misaligned scalar word accesses on the selected set of
>    processors.
>  
> -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNKNOWN`: The performance of misaligned
> -    accesses is unknown.
> +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN`: The performance of
> +    misaligned accesses is unknown.
>  
> -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_EMULATED`: Misaligned accesses are
> +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED`: Misaligned accesses are
>      emulated via software, either in or below the kernel.  These accesses are
>      always extremely slow.
>  
> -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SLOW`: Misaligned word accesses are
> -    slower than equivalent byte accesses.  Misaligned accesses may be supported
> -    directly in hardware, or trapped and emulated by software.
> +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SCALAR_SLOW`: Misaligned word accesses
> +    are slower than equivalent byte accesses.  Misaligned accesses may be
> +    supported directly in hardware, or trapped and emulated by software.
>  
> -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_FAST`: Misaligned word accesses are
> -    faster than equivalent byte accesses.
> +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SCALAR_FAST`: Misaligned word accesses
> +    are faster than equivalent byte accesses.
>  
> -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNSUPPORTED`: Misaligned accesses are
> -    not supported at all and will generate a misaligned address fault.
> +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SCALAR_UNSUPPORTED`: Misaligned accesses
> +    are not supported at all and will generate a misaligned address fault.
>  
>  * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
>    represents the size of the Zicboz block in bytes.
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
> index 22073533cea8..e11684d8ae1c 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -66,11 +66,11 @@ struct riscv_hwprobe {
>  #define		RISCV_HWPROBE_EXT_ZVE64F	(1ULL << 40)
>  #define		RISCV_HWPROBE_EXT_ZVE64D	(1ULL << 41)
>  #define RISCV_HWPROBE_KEY_CPUPERF_0	5
> -#define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	0
> -#define		RISCV_HWPROBE_MISALIGNED_EMULATED	1
> -#define		RISCV_HWPROBE_MISALIGNED_SLOW		2
> -#define		RISCV_HWPROBE_MISALIGNED_FAST		3
> -#define		RISCV_HWPROBE_MISALIGNED_UNSUPPORTED	4
> +#define		RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN		0
> +#define		RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED	1
> +#define		RISCV_HWPROBE_MISALIGNED_SCALAR_SLOW		2
> +#define		RISCV_HWPROBE_MISALIGNED_SCALAR_FAST		3
> +#define		RISCV_HWPROBE_MISALIGNED_SCALAR_UNSUPPORTED	4
>  #define		RISCV_HWPROBE_MISALIGNED_MASK		7
>  #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE	6
>  #define RISCV_HWPROBE_KEY_MISALIGNED_SCALAR_PERF	7
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> index 991ceba67717..fbf952e7383e 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -170,13 +170,13 @@ static u64 hwprobe_misaligned(const struct cpumask *cpus)
>  			perf = this_perf;
>  
>  		if (perf != this_perf) {
> -			perf = RISCV_HWPROBE_MISALIGNED_UNKNOWN;
> +			perf = RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN;
>  			break;
>  		}
>  	}
>  
>  	if (perf == -1ULL)
> -		return RISCV_HWPROBE_MISALIGNED_UNKNOWN;
> +		return RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN;
>  
>  	return perf;
>  }
> @@ -184,12 +184,12 @@ static u64 hwprobe_misaligned(const struct cpumask *cpus)
>  static u64 hwprobe_misaligned(const struct cpumask *cpus)
>  {
>  	if (IS_ENABLED(CONFIG_RISCV_EFFICIENT_UNALIGNED_ACCESS))
> -		return RISCV_HWPROBE_MISALIGNED_FAST;
> +		return RISCV_HWPROBE_MISALIGNED_SCALAR_FAST;
>  
>  	if (IS_ENABLED(CONFIG_RISCV_EMULATED_UNALIGNED_ACCESS) && unaligned_ctl_available())
> -		return RISCV_HWPROBE_MISALIGNED_EMULATED;
> +		return RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED;
>  
> -	return RISCV_HWPROBE_MISALIGNED_SLOW;
> +	return RISCV_HWPROBE_MISALIGNED_SCALAR_SLOW;
>  }
>  #endif
>  
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
> index b62d5a2f4541..192cd5603e95 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -338,7 +338,7 @@ int handle_misaligned_load(struct pt_regs *regs)
>  	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
>  
>  #ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
> -	*this_cpu_ptr(&misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_EMULATED;
> +	*this_cpu_ptr(&misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED;
>  #endif
>  
>  	if (!unaligned_enabled)
> @@ -532,13 +532,13 @@ static bool check_unaligned_access_emulated(int cpu)
>  	unsigned long tmp_var, tmp_val;
>  	bool misaligned_emu_detected;
>  
> -	*mas_ptr = RISCV_HWPROBE_MISALIGNED_UNKNOWN;
> +	*mas_ptr = RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN;
>  
>  	__asm__ __volatile__ (
>  		"       "REG_L" %[tmp], 1(%[ptr])\n"
>  		: [tmp] "=r" (tmp_val) : [ptr] "r" (&tmp_var) : "memory");
>  
> -	misaligned_emu_detected = (*mas_ptr == RISCV_HWPROBE_MISALIGNED_EMULATED);
> +	misaligned_emu_detected = (*mas_ptr == RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED);
>  	/*
>  	 * If unaligned_ctl is already set, this means that we detected that all
>  	 * CPUS uses emulated misaligned access at boot time. If that changed
> diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
> index a9a6bcb02acf..160628a2116d 100644
> --- a/arch/riscv/kernel/unaligned_access_speed.c
> +++ b/arch/riscv/kernel/unaligned_access_speed.c
> @@ -34,9 +34,9 @@ static int check_unaligned_access(void *param)
>  	struct page *page = param;
>  	void *dst;
>  	void *src;
> -	long speed = RISCV_HWPROBE_MISALIGNED_SLOW;
> +	long speed = RISCV_HWPROBE_MISALIGNED_SCALAR_SLOW;
>  
> -	if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_UNKNOWN)
> +	if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN)
>  		return 0;
>  
>  	/* Make an unaligned destination buffer. */
> @@ -95,14 +95,14 @@ static int check_unaligned_access(void *param)
>  	}
>  
>  	if (word_cycles < byte_cycles)
> -		speed = RISCV_HWPROBE_MISALIGNED_FAST;
> +		speed = RISCV_HWPROBE_MISALIGNED_SCALAR_FAST;
>  
>  	ratio = div_u64((byte_cycles * 100), word_cycles);
>  	pr_info("cpu%d: Ratio of byte access time to unaligned word access is %d.%02d, unaligned accesses are %s\n",
>  		cpu,
>  		ratio / 100,
>  		ratio % 100,
> -		(speed == RISCV_HWPROBE_MISALIGNED_FAST) ? "fast" : "slow");
> +		(speed == RISCV_HWPROBE_MISALIGNED_SCALAR_FAST) ? "fast" : "slow");
>  
>  	per_cpu(misaligned_access_speed, cpu) = speed;
>  
> @@ -110,7 +110,7 @@ static int check_unaligned_access(void *param)
>  	 * Set the value of fast_misaligned_access of a CPU. These operations
>  	 * are atomic to avoid race conditions.
>  	 */
> -	if (speed == RISCV_HWPROBE_MISALIGNED_FAST)
> +	if (speed == RISCV_HWPROBE_MISALIGNED_SCALAR_FAST)
>  		cpumask_set_cpu(cpu, &fast_misaligned_access);
>  	else
>  		cpumask_clear_cpu(cpu, &fast_misaligned_access);
> @@ -188,7 +188,7 @@ static int riscv_online_cpu(unsigned int cpu)
>  	static struct page *buf;
>  
>  	/* We are already set since the last check */
> -	if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_UNKNOWN)
> +	if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN)
>  		goto exit;
>  
>  	buf = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
> -- 
> 2.34.1
> 

