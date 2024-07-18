Return-Path: <linux-kernel+bounces-256794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58964937050
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 23:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BC4C1C21CD9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 21:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15C2145B13;
	Thu, 18 Jul 2024 21:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="koodigHU"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F8B6BFA3
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 21:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721339830; cv=none; b=U3MyexAedMDsX+NQN3qbSotDi9RfO5f2+LW3rpCiv+bKya6AXsRQdYsYdR6lv2l74EQlzYbPgClPVJH10WCWjJs8KRNek1RNbI7ChmYSpdWjqG5iOOPmtkVDYRNqtO1G7UbN73s/srLue73eRMW6bEBlOFlexWWHXYbftxrip6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721339830; c=relaxed/simple;
	bh=tr8y1zMCdf7qCEuA6WV/TmJ8+hyuQ+30cAZOVnc72Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZvrt1G2nW8nRGjlyD5YlkfKccxc4qtGkkgM0whiCUqiO4AbOGO51svKnK58FSSHDd86a8ruseiPJ9XUnJjnNwumRC/oYsf7+0YalI+4HW2sv1f+plytWVkCCbZd6aY35MVxaaftoJAOf91oOj+tCMxh9hREetaE3QI3ZhdlyBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=koodigHU; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-80767b21543so52484439f.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 14:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1721339828; x=1721944628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bHwfmEtN2E+ymE9t7lYKh6HDNkIVdbk4aYEg9FHEZF4=;
        b=koodigHUT926sc1Rs2POZxEzNCKHSaKIki2DJ8gQESrmGGwdRuIMtLPA6PY9nHczfK
         0XvciDxRG3sMOiwkamsnPtQWQdj7oQsH+dT0scRvyOCfh/l403b/yJ9LzVR+53PJSUzx
         SAUf1JtJNiLkwruWJW3YVYK/yG8tEggrdI+D/fZ/xjuIJw60fO4d/TunJpC0giErm9b1
         fxcy3J7aMNAUSpiaKhxON/yxJWEINpRAvVYJUrK/UJW3++oK/sfOZ5xZB5fPXlYqLaXd
         W/oDnDP+oYXr9X+UU5npMd6yQYXvY7nyi8NQaK2Eqphqs1V6Wv/GtM5NZnAtKENyRlwy
         RWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721339828; x=1721944628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHwfmEtN2E+ymE9t7lYKh6HDNkIVdbk4aYEg9FHEZF4=;
        b=l+wqXkjha0Ov5u2WCMRaIB7AHEFZQ0iTMDdFWmUoMWHp7jN25yX2owj6/xBNfIG4SL
         BuTtfxBUhXxKguSQBQXRVz0gfO48kynTxcszJfE3csmViOG3vqm6mVnkbYBPqoK6PFAC
         hlNVNdyFOPXFxHE+luYDGurn4jjFkIbwxOVpC9qWdFAV90kz897sYm43tJ2pJwvdaTIR
         diNmBldvBl6SbzD9q969aTJsN7jGDYvUj1rkpVzEOixKVwn4/o2fYQLErxQQH4V81yeu
         gmpTpcH7FpMSErKAPZ2/UNdbWJpCVFHIRiJmWx9imCBW4Rs+kl9jjTySqCilo2zSJ1nM
         PGBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqYlq8AsB0YZka95jGIMVBUYJH3v0TqF2LvTr1h/8P/yfbXXsYdN2escNWyY4eFytgudiIfF/HQLFsj+60ClokPpVWjveBBcIjx270
X-Gm-Message-State: AOJu0YzAdhPQx3SI3EvdUM3vn47GZEY7egHro6lDGBYSkr+IzZxTDR/z
	TOZP7kZr/uJmKp+//6t4GIKkaHHWMKSzaeqLwpAbnk2oKmytVOSoupg2+yMhW14=
X-Google-Smtp-Source: AGHT+IHgduXCJ2ARddrS9gvb1XzJLRZZuOvRvqS0t1x1wW6YQXNExLkXLMyBN1QygkfCSlId5RMcxw==
X-Received: by 2002:a05:6602:6c01:b0:7f6:1f87:70c7 with SMTP id ca18e2360f4ac-81710cca2bcmr710978439f.11.1721339828191;
        Thu, 18 Jul 2024 14:57:08 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c2343d3364sm36300173.132.2024.07.18.14.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 14:57:07 -0700 (PDT)
Date: Thu, 18 Jul 2024 16:57:07 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Albert Ou <aou@eecs.berkeley.edu>, Andy Chiu <andy.chiu@sifive.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Conor Dooley <conor@kernel.org>, Evan Green <evan@rivosinc.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -fixes] riscv: cpufeature: Do not drop Linux-internal
 extensions
Message-ID: <20240718-a5097a4070f457529d2fff91@orel>
References: <20240718213011.2600150-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718213011.2600150-1-samuel.holland@sifive.com>

On Thu, Jul 18, 2024 at 02:29:59PM GMT, Samuel Holland wrote:
> The Linux-internal Xlinuxenvcfg ISA extension is omitted from the
> riscv_isa_ext array because it has no DT binding and should not appear
> in /proc/cpuinfo. The logic added in commit 625034abd52a ("riscv: add
> ISA extensions validation callback") assumes all extensions are included
> in riscv_isa_ext, and so riscv_resolve_isa() wrongly drops Xlinuxenvcfg
> from the final ISA string. Instead, accept such Linux-internal ISA
> extensions as if they have no validation callback.

This assumes we'll never need a validation callback for a Linux-internal
ISA extension. We can make that assumption now and change our mind
later, but we could also add Xlinuxenvcfg to riscv_isa_ext now and
modify the places where it matters (just print_isa?). If we add
Xlinuxenvcfg to the array with a NULL name then we could do something
like

 print_isa()
 {
    for (...) {
        ...
        if (!riscv_isa_ext[i].name)
	   continue;
    }
 }

> 
> Fixes: 625034abd52a ("riscv: add ISA extensions validation callback")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> 
>  arch/riscv/kernel/cpufeature.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 0366dc3baf33..dd25677d60de 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -457,28 +457,26 @@ static void __init riscv_resolve_isa(unsigned long *source_isa,
>  		bitmap_copy(prev_resolved_isa, resolved_isa, RISCV_ISA_EXT_MAX);
>  		for_each_set_bit(bit, source_isa, RISCV_ISA_EXT_MAX) {
>  			ext = riscv_get_isa_ext_data(bit);
> -			if (!ext)
> -				continue;
>  
> -			if (ext->validate) {
> +			if (ext && ext->validate) {
>  				ret = ext->validate(ext, resolved_isa);
>  				if (ret == -EPROBE_DEFER) {
>  					loop = true;
>  					continue;
>  				} else if (ret) {
>  					/* Disable the extension entirely */
> -					clear_bit(ext->id, source_isa);
> +					clear_bit(bit, source_isa);
>  					continue;
>  				}
>  			}
>  
> -			set_bit(ext->id, resolved_isa);
> +			set_bit(bit, resolved_isa);
>  			/* No need to keep it in source isa now that it is enabled */
> -			clear_bit(ext->id, source_isa);
> +			clear_bit(bit, source_isa);
>  
>  			/* Single letter extensions get set in hwcap */
> -			if (ext->id < RISCV_ISA_EXT_BASE)
> -				*this_hwcap |= isa2hwcap[ext->id];
> +			if (bit < RISCV_ISA_EXT_BASE)
> +				*this_hwcap |= isa2hwcap[bit];
>  		}
>  	} while (loop && memcmp(prev_resolved_isa, resolved_isa, sizeof(prev_resolved_isa)));
>  }
> -- 
> 2.45.1
>

If we'd rather leave Xlinuxenvcfg out of the array (and generally support
extensions not in the array), then LGTM

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew

