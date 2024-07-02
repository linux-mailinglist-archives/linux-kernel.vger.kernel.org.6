Return-Path: <linux-kernel+bounces-237196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B93891ED47
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 05:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA257286030
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 03:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80DF12C526;
	Tue,  2 Jul 2024 03:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="jM/WdWgV"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D1E85298
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 03:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719889331; cv=none; b=JKPJYoLRzLxyDCS7hnRXKrfkrgkFA80xiGBIDlW1bVGb01WvtQAltGuQ/JhnCIZpLFpR6qdujtxVwmgisCVyCWtTOfu5DLHjTUaAUCLPmZQ25qKCU75XfadeyiDN0JUExftKFXzufdDCiF+e0JVwAN0BUbj52OTMRVlQ8m+RKMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719889331; c=relaxed/simple;
	bh=juDRxuue6BuNqcCiTQ1oRGV1+UkKo+RHyTXKiyOaT44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7oiRxz32JZbf1nvy/XsAS1jY1QoEcqp1cfe/MiF8DQbf3htA/pXIHpQWKQgny2dsPfU2K/zeKiFSI55g9TfD48T4MO2cTjQI3bzHx/5xc3XoIbcWaZo89L4TkOc271OlkrinPaqbHM+SovG8TWOtx8/bvkMNm/po1PfVnZ2B6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=jM/WdWgV; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-72c03d2926eso2040630a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 20:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719889329; x=1720494129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ojm2WDT+jRVGV+bXsvRAENxh4cvFhiHctBiMqtse7vA=;
        b=jM/WdWgVkZB0UZc7R6fqYmyiJJjCE+b1o5Z6D9SYoKHF+vnGmgupnW2rkXVIOwlrry
         MJtHnd2X0xj2+NM9fwdXUJr77G5TT+ZTnpYZ2BtZnZQD5OLi/bBpwOwVksfP8USpriaS
         Ur+tt/0hWuYcpyVJkbvzW5FXAv8lLFbZN8bUHmK2SD4CiZUsiiO2cnEErX4C0Z8pqlcO
         ISYTzf+xsPhEgKpUrwrD6Dc2lsNrrai7U80S0Z+MdHVhWNxSn6SvM5OHPI+EfzCA3XDW
         j2HYSnvTucA5OF1H1U3rKRYAQnWtzWasmFdtNI9GUDxQF36o+d+vkRMDn00wX3tFJ2Ly
         BP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719889329; x=1720494129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ojm2WDT+jRVGV+bXsvRAENxh4cvFhiHctBiMqtse7vA=;
        b=XE1MOflJfEo6c6i+56KHDTbEMiEad0uPdgXuW7Xu207HfIsH/FeAdSCz8iTXZIMtV9
         1UA2rpDoiLuomzbPS9h3OvhPB6Slz6YvIYISTdDkbPtBrVj2KSHEXeIIzq8wbEtzFxFZ
         UjxPdDCvbVsYuxtBE0n5hHxrzj/gBWZU3lqIrzhaVm6ExsN3iTphE+W03ukXYL3pqaF1
         6hLNULH+Qeu+2OGMy2/F95MhXtFPNaGET2ZyVAh2vsBbT7jhSleAkFCQuOSMb8wEOGUa
         y7rERER5rEG2djLCsNGtAsyujZh6IN9XMIf/ZytKK1+Q9OuqrauTzpRfCg86ribAvgIY
         0QNA==
X-Forwarded-Encrypted: i=1; AJvYcCUvPL1ydoE7gtr6CwKL4AVqJEz6vUBSqyIDjuVjr6xa3KtsIfRMHJDqjlh6DnjqaWjWXFkegI6INgwe6LgoFy3Ul5G+Ito7c6RVrfn3
X-Gm-Message-State: AOJu0YxF9dp9eBqDOYkCxCM4reF3AKgo62yVEtCMmTzE/6UsuY0XJYIv
	CxoH/ElgnhEF+xXNLHi7dRvANLY7ftNgyMCz0ckIwPYc/Jo9YUfaZunh4ptDi0c=
X-Google-Smtp-Source: AGHT+IFtzRVBgPoIZ5spdIWYcesTZAiiJeslpnCGATGmgq3SV6QGiwVYg4WyG0rOC5lcz8Vf2zmQxA==
X-Received: by 2002:a05:6a20:cf84:b0:1bd:2699:436c with SMTP id adf61e73a8af0-1bef62066c0mr6579915637.40.1719889329603;
        Mon, 01 Jul 2024 20:02:09 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:a569:328b:99ad:ce17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1538ee0sm72521095ad.149.2024.07.01.20.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 20:02:09 -0700 (PDT)
Date: Mon, 1 Jul 2024 20:02:05 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Jesse Taube <jesse@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, Ard Biesheuvel <ardb@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Wende Tan <twd2.me@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sami Tolvanen <samitolvanen@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v3 2/4] RISC-V: lib: Add pi aliases for string functions
Message-ID: <ZoNtrXawP8nvXUds@ghost>
References: <20240701185132.319995-1-jesse@rivosinc.com>
 <20240701185132.319995-3-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701185132.319995-3-jesse@rivosinc.com>

On Mon, Jul 01, 2024 at 02:51:30PM -0400, Jesse Taube wrote:
> memset, strcmp, and strncmp are all used in the the __pi_ section.
> add SYM_FUNC_ALIAS for them.
> 
> When KASAN is enabled in <asm/string.h> __pi___memset is also needed.
> 
> Suggested-by: Charlie Jenkins <charlie@rivosinc.com>
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> ---
> V2 -> V3:
>  - New patch
> ---
>  arch/riscv/lib/memset.S  | 2 ++
>  arch/riscv/lib/strcmp.S  | 1 +
>  arch/riscv/lib/strncmp.S | 1 +
>  3 files changed, 4 insertions(+)
> 
> diff --git a/arch/riscv/lib/memset.S b/arch/riscv/lib/memset.S
> index 35f358e70bdb..da23b8347e2d 100644
> --- a/arch/riscv/lib/memset.S
> +++ b/arch/riscv/lib/memset.S
> @@ -111,3 +111,5 @@ SYM_FUNC_START(__memset)
>  	ret
>  SYM_FUNC_END(__memset)
>  SYM_FUNC_ALIAS_WEAK(memset, __memset)
> +SYM_FUNC_ALIAS(__pi_memset, __memset)
> +SYM_FUNC_ALIAS(__pi___memset, __memset)
> diff --git a/arch/riscv/lib/strcmp.S b/arch/riscv/lib/strcmp.S
> index 687b2bea5c43..bc73325b2fd1 100644
> --- a/arch/riscv/lib/strcmp.S
> +++ b/arch/riscv/lib/strcmp.S
> @@ -120,3 +120,4 @@ strcmp_zbb:
>  .option pop
>  #endif
>  SYM_FUNC_END(strcmp)
> +SYM_FUNC_ALIAS(__pi_strcmp, strcmp)
> diff --git a/arch/riscv/lib/strncmp.S b/arch/riscv/lib/strncmp.S
> index aba5b3148621..b36325a57f6a 100644
> --- a/arch/riscv/lib/strncmp.S
> +++ b/arch/riscv/lib/strncmp.S
> @@ -136,3 +136,4 @@ strncmp_zbb:
>  .option pop
>  #endif
>  SYM_FUNC_END(strncmp)
> +SYM_FUNC_ALIAS(__pi_strncmp, strncmp)
> -- 
> 2.45.2
> 

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>


