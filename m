Return-Path: <linux-kernel+bounces-255306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E49F2933EB8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EAB5B21338
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA02518132E;
	Wed, 17 Jul 2024 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GD+b+m6V"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C5517FAD8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 14:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721227239; cv=none; b=cBBvRWJxM7XQE994kr51pJ16+Gr2D2htiabK/EXQnK5N6qtaLBZQVRvQgISal/nx9qZcMf4cnYE82PeARWmktdYjMPK21t/nToqo+c6kJqHV3LvAow7cRdH4YrLBJz1tUgL8P7CQZh+PtyGVkv/zjR3QiUr7PNm5+38vzbeXabM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721227239; c=relaxed/simple;
	bh=+cqM+pZK352HwU5frTpgb4pjngsVXMFRVEWBIdM9+Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkFQyQfg2piDzHrB/xHX6FLbxBKDexMMqoGLC0JWixZ8Df2Gc97F/AMKMHSrFwLxjexQedwd/XMHLsw8V1khUwXll4dv0DNnoXjKi2pPf+xK+FoweHw5prztsAHgd9UmiXIpkRXJHlb0mScOm7eosmRxN2xZSN/ETqNy5R+64L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GD+b+m6V; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eedeca1c79so52881541fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721227235; x=1721832035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=exCaK8M+IVOutz8AA1dE561HuzN3r+WbizxFtXswF5Y=;
        b=GD+b+m6VXdpT238UY3Yejra1nvOmwJgsZ4s/cgAzJ/0UtpYTjPhqKOP3VAWZO3KnhZ
         gEq6+pfE43iMhSNRFaIcJPqss6zA6BWNPtRyZ+7UflwfKy/qa5aDh37zo+6xW9CtL5eX
         9Np+ptj4o3Fe6FSw8IgI607k3UeL73CIK6IImwDpVtPshWvqfnblugR7bAm/xW1e1Pja
         jT5jppOgC0LKbW1zaGMIitFrFTerpbclh9HZKKJgNlcv1PFHDpNoiQMfl5efWpoTGbje
         2Yy8vkQtZx5gKS16cJCtBWUaZRNxx29pLPwd9n9WVbIW6KZr/pvW4/6Uc48RfLEfXuBr
         I6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721227235; x=1721832035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exCaK8M+IVOutz8AA1dE561HuzN3r+WbizxFtXswF5Y=;
        b=GTkJKw4G9JAYPJEYa4QG4Lc5KoYwd09KeqY/O37PC0/MasTESsMqhCPvn7TZu0q0dh
         EkF/5H3jVBigpOwT8Ou4TJkNoz8pAcV60IPcNUG03C1RyuIWLw0QneLrZy4yVyAVrrIw
         Pi1k86XymVadekEhjLm4qwVnUydm/10gumUkbMz0Z1BgZ6pQOEqliCn9JJshJf4KqgAh
         imYOdFdV2DO5K6rAF0hOAX8imB82hScPyKxa9wiyktVS80sobe5HnDut11Qy1EL7Kzu/
         4qZ1XGRBiDyxABhLR4zbarjz0YUCxZY+uzwPAKW5L29V5+xLoMPDAXP1EDEGo5JPpnTb
         nZ8A==
X-Forwarded-Encrypted: i=1; AJvYcCWFslgia+/tTDSIayBrnIChjn13VIFSQcRybyHwHNGNDNveqJdvYt0gIqZjRJQsQUorEVjeGjI84HCx1wK/gxlfRiPhbjY+QknG3crh
X-Gm-Message-State: AOJu0YwWWNpYP3HhlHLqcRbXRaG6beryjgD56rNcfdcDD77ptc9P4B4e
	w9IoDn6b2BZ4g5ZYbzHlekyo+DBj6yS987JRh3/LWOpt1lM0w5c+
X-Google-Smtp-Source: AGHT+IGlFB/5u6bBosn/exSsjgVwwLykPI+2u+YZGoEyoIoszW9DKCvlegrjxtJe81bngK8nvhddCA==
X-Received: by 2002:a05:6512:2803:b0:52e:9951:7881 with SMTP id 2adb3069b0e04-52ee5411e4amr1515180e87.52.1721227235116;
        Wed, 17 Jul 2024 07:40:35 -0700 (PDT)
Received: from gmail.com (84-236-112-196.pool.digikabel.hu. [84.236.112.196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c78076f7sm241275e9.37.2024.07.17.07.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 07:40:34 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 17 Jul 2024 16:40:32 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH 1/2] x86/percpu: Fix "multiple identical address spaces
 specified for type" clang warning
Message-ID: <ZpfX4KelYaXsHlHe@gmail.com>
References: <20240526175655.227798-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240526175655.227798-1-ubizjak@gmail.com>


* Uros Bizjak <ubizjak@gmail.com> wrote:

> The clang build with named address spaces enabled currently fails with:
> 
> error: multiple identical address spaces specified for type [-Werror,-Wduplicate-decl-specifier]
> 
> The warning is emitted when accessing const_pcpu_hot structure,
> which is already declared in __seg_gs named address space.
> 
> Use specialized accessor for __raw_cpu_read_const() instead, avoiding
> redeclaring __seg_gs named address space via __raw_cpu_read().
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Bill Wendling <morbo@google.com>
> Cc: Justin Stitt <justinstitt@google.com>
> ---
>  arch/x86/include/asm/percpu.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
> index c55a79d5feae..aeea5c8a17de 100644
> --- a/arch/x86/include/asm/percpu.h
> +++ b/arch/x86/include/asm/percpu.h
> @@ -160,7 +160,10 @@ do {									\
>  	*(qual __my_cpu_type(pcp) *)__my_cpu_ptr(&(pcp)) = (val);	\
>  } while (0)
>  
> -#define __raw_cpu_read_const(pcp)	__raw_cpu_read(, , pcp)
> +#define __raw_cpu_read_const(pcp)					\
> +({									\
> +	*(typeof(pcp) *)(__force uintptr_t)(&(pcp));			\
> +})

So shouldn't this be carried together with the patch that enables named 
address spaces on Clang? Is it possible that this patch might not be needed 
in a Clang version where named address spaces work as expected?

Thanks,

	Ingo

