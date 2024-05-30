Return-Path: <linux-kernel+bounces-195039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E7A8D46AB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 10:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3ACF1C21DFA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 08:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70FE14535A;
	Thu, 30 May 2024 08:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="QCPLY2q3"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063B17407F
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 08:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717056430; cv=none; b=oj9C3ZIHjcAZsOR4jtEV004PoudMVOKOW2mh0meAdEYx4uCpC6HJWmqOmhkqgc7wpsmI0zVu2oQIdGnOGtp2DzcJuuk13zt93phab2uKLildd8dRS0mI4XGjW2gOGonGFUzpn17Oy+zulJJsTxeuecDEqKEd0KiqjQK8s+2s6Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717056430; c=relaxed/simple;
	bh=DPXVfv9gCin27padQl0N45iKeyrBxgpvV3TGvylxXTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imzgHFC8p2acx7jO8pLTBMYPNSm6/GC7dRrhn+wZ6hAV/M8oeMSiT6hxiGscDkvzApR8iSD4kcpZw4SXysa/o59Iu/FawDFHrwAQURwN5ex89MjKR0WZWmyj2hv1S5oi9vOTgmi/vWeCnuwUGqpHTR8cV5cQVx8xc3B3aR0w6GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=QCPLY2q3; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42108856c33so4152525e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 01:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717056427; x=1717661227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=imJe00y9Y1CwcN7JN2PUg+7wMYdo2Jj6de/HwT6F9Uc=;
        b=QCPLY2q3GcI5tFtaVSPXqFkCCCnIuYskWM76DbjGl6ML363nOeq4cRK3lAPwrhCQtS
         x0C3qFGXrQ9GkAvd+mcs9U1aX8sCw7ThmoVcytSyi9lvTLV5cUH7bHsG42uFR/ic5KWx
         2E2Tb2x4jpncHZSEzy1dJlAbGpE+1fHt5BfnexSY4DKvR2/JI+S2cRMEbL+qpYjDL9Pu
         hd+XiIpY4abWE0R+7kKKeGGV2DrNud4ExkkxvmC7izzHxunEMmJAVVpMRKjaVwsZEPBp
         hIKvNrc7+3YBVwMNhKpNqJFZ8YZXccx1M07dhKCk2T5vcZj9QwJ10dN3JnLz5iYIqcKR
         P9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717056427; x=1717661227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imJe00y9Y1CwcN7JN2PUg+7wMYdo2Jj6de/HwT6F9Uc=;
        b=EVcsduh7P0zhqhMTyIhGNGdrqlSQ4vLEU9yQHWeaPLjfQVmXBhZKNVeDOq1eao//KX
         mFyD0pr4di6YBBWhEMs7eib5dTqybiT0npsq+1S8UlrrzvvDM1VCNKijZFS5SjpNe8X0
         rzIhxAJkKcv0wGe5+9Ukez6GLPhnJShgm1u5bgFhW6COKaL5JjdHZfsYDnTbtJmUpLCh
         +O6HbK9+t3yojdVjxkCsPEeyz/jTy4uJR2scDLL5vco0WDdH/kd6zW39PrnyPpgd5HNj
         8sl62xecS7DZpQJP3iQdI7Qmlt2cDIz9hl+QKhto/d2jsFtyShdLhQcSgI87utUZD16q
         LASQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjEkQELxSb/myi/yYqzzT2WWwIYUEdlFXKJ+tDpyBIrlCqK9HKBJ7Ghw16JlveLCg8cdUSV+LoN911OY16wgMTqWJA5Eohh0BkC3IU
X-Gm-Message-State: AOJu0YyTXz0jLzlE5QtA0TVmg2r/6r1fEMJGBjMSBAzFOx4pMOLGkXSL
	64pQk52hEUkeSn7J5+vk8DOunm69ZW+r4VDggmCr6m41y23nI2Ztv6mcwIbIC8g=
X-Google-Smtp-Source: AGHT+IFz86hjWVwDP/dkomv8c6/5Rk3tvlfabY/M/AgBKzpkM/zbIEiVEW4Mio38VYNi7sJ39diFGA==
X-Received: by 2002:a05:600c:1c9b:b0:421:2985:559a with SMTP id 5b1f17b1804b1-4212985574cmr4252445e9.7.1717056426856;
        Thu, 30 May 2024 01:07:06 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42127059769sm17110705e9.5.2024.05.30.01.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 01:07:06 -0700 (PDT)
Date: Thu, 30 May 2024 10:07:05 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Evan Green <evan@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Yangyu Chen <cyy@cyyself.name>, 
	Albert Ou <aou@eecs.berkeley.edu>, Andy Chiu <andy.chiu@sifive.com>, 
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Sami Tolvanen <samitolvanen@google.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] RISC-V: hwprobe: Add MISALIGNED_PERF key
Message-ID: <20240530-ae9f7725d4566a72e895f8fa@orel>
References: <20240529182649.2635123-1-evan@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529182649.2635123-1-evan@rivosinc.com>

On Wed, May 29, 2024 at 11:26:48AM GMT, Evan Green wrote:
> RISCV_HWPROBE_KEY_CPUPERF_0 was mistakenly flagged as a bitmask in
> hwprobe_key_is_bitmask(), when in reality it was an enum value. This
> causes problems when used in conjunction with RISCV_HWPROBE_WHICH_CPUS,
> since SLOW, FAST, and EMULATED have values whose bits overlap with
> each other. If the caller asked for the set of CPUs that was SLOW or
> EMULATED, the returned set would also include CPUs that were FAST.
> 
> Introduce a new hwprobe key, RISCV_HWPROBE_KEY_MISALIGNED_PERF, which
> returns the same values in response to a direct query (with no flags),
> but is properly handled as an enumerated value. As a result, SLOW,
> FAST, and EMULATED are all correctly treated as distinct values under
> the new key when queried with the WHICH_CPUS flag.
> 
> Leave the old key in place to avoid disturbing applications which may
> have already come to rely on the broken behavior.

I appreciate the paranoia, even if I think we could probably get away
with fixing CPUPERF_0.

> 
> Fixes: e178bf146e4b ("RISC-V: hwprobe: Introduce which-cpus flag")
> Signed-off-by: Evan Green <evan@rivosinc.com>
> 
> ---
> 
> 
> Note: Yangyu also has a fix out for this issue at [1]. That fix is much
> tidier, but comes with the slight risk that some very broken userspace
> application may break now that FAST cpus are not included for the query
> of which cpus are SLOW or EMULATED. I wanted to get this fix out so that
> we have both as options, and can discuss. These fixes are mutually
> exclusive, don't take both.
> 
> [1] https://lore.kernel.org/linux-riscv/tencent_01F8E0050FB4B11CC170C3639E43F41A1709@qq.com/
> 
> ---
>  Documentation/arch/riscv/hwprobe.rst  | 8 ++++++--
>  arch/riscv/include/asm/hwprobe.h      | 2 +-
>  arch/riscv/include/uapi/asm/hwprobe.h | 1 +
>  arch/riscv/kernel/sys_hwprobe.c       | 1 +
>  4 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
> index 204cd4433af5..616ee372adaf 100644
> --- a/Documentation/arch/riscv/hwprobe.rst
> +++ b/Documentation/arch/riscv/hwprobe.rst
> @@ -192,8 +192,12 @@ The following keys are defined:
>         supported as defined in the RISC-V ISA manual starting from commit
>         d8ab5c78c207 ("Zihintpause is ratified").
>  
> -* :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
> -  information about the selected set of processors.
> +* :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: Deprecated. Returns similar values to
> +     :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_PERF`, but the key was mistakenly
> +     classified as a bitmask rather than a value.
> +
> +* :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_PERF`: An enum value describing the
> +  performance of misaligned scalar accesses on the selected set of processors.
>  
>    * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNKNOWN`: The performance of misaligned
>      accesses is unknown.
> diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
> index 630507dff5ea..150a9877b0af 100644
> --- a/arch/riscv/include/asm/hwprobe.h
> +++ b/arch/riscv/include/asm/hwprobe.h
> @@ -8,7 +8,7 @@
>  
>  #include <uapi/asm/hwprobe.h>
>  
> -#define RISCV_HWPROBE_MAX_KEY 6
> +#define RISCV_HWPROBE_MAX_KEY 7
>  
>  static inline bool riscv_hwprobe_key_is_valid(__s64 key)
>  {
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
> index dda76a05420b..bc34e33fef23 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -68,6 +68,7 @@ struct riscv_hwprobe {
>  #define		RISCV_HWPROBE_MISALIGNED_UNSUPPORTED	(4 << 0)
>  #define		RISCV_HWPROBE_MISALIGNED_MASK		(7 << 0)

Can we also remove the unnecessary ( << 0) shifts for each of the
MISALIGNED_* values? The shifts imply bits of a bitmask (to me).

>  #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE	6
> +#define RISCV_HWPROBE_KEY_MISALIGNED_PERF	7
>  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>  
>  /* Flags */
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> index 969ef3d59dbe..c8b7d57eb55e 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -208,6 +208,7 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
>  		break;
>  
>  	case RISCV_HWPROBE_KEY_CPUPERF_0:
> +	case RISCV_HWPROBE_KEY_MISALIGNED_PERF:
>  		pair->value = hwprobe_misaligned(cpus);
>  		break;
>  
> -- 
> 2.34.1
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew

