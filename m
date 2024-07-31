Return-Path: <linux-kernel+bounces-269511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 442189433A6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DCB2B24049
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA21D1B581F;
	Wed, 31 Jul 2024 15:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7a6ngC2"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B2C1CF83;
	Wed, 31 Jul 2024 15:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722440866; cv=none; b=LbVVlNPUuAqL+sJJkYz1d2FylMWu2L9ldS288unRNiY2dOD5BF7NZNUVBQs8H8BVfPn2CpY1EdY+SJvz/ZakVSzS3bL7zbewArZp5gGxhlg6IPhks3JCuF2ljmoQjNGAglAWllHIEvf5ckelFFmao9Dl4HcxP5YX6wtATJXKSpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722440866; c=relaxed/simple;
	bh=4u97t/RaLcuFx19cl6/FF+3nhsfsuomYYTTtLurA7Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHpg+2OiULnIFDYoWPXiJMM3R0fUTmFxYHxlahZ1kWHqw9LPvpblKi9Jl1GZWiK2Zvd89V1FxH7imEqMInInC/USIYkCnQlTjHZDYwjp4w+06d1iidDK5RBadfrOaroz2Vw0OaeeHFPbpozGDw9h5UB5FaHdI/+fplsTNXIqXIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7a6ngC2; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fee6435a34so39628325ad.0;
        Wed, 31 Jul 2024 08:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722440864; x=1723045664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7oFTJ+3+Ld1Sad4Yjzou2SbBkqLkLd+A5kfPRLxBvso=;
        b=g7a6ngC2+O2lyfc6YgrtjGPw2UGIqCoGh/xGpbEfXzYl4aBdnVMcTTGQXJnDuIhIRC
         qYonMC7E0r/kgF+qjxKZ1Pcyf2uBXfuy86GpfzT1DfyWK1XdFVG+rNtqVAKKWHnlzW30
         D2NvkeAJh/ouYk5tIHPGX1xlVXdQNcDwQCvRnV+s8p83M8NlRgcboyuZOlj6hfrwIe5Z
         u/7es38j8wS2rgEHyauow3HpXNyMii87q1FvSwsGjcjRVfh8FrcNsMb6GpWDQ6iOI6CT
         LHl1iNFDxO9NNS5tn+1kHg52pSKPQOpNys53buy2ZLV0Mhvtwd9pSzBP4gEz0bdWgRhV
         wreg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722440864; x=1723045664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7oFTJ+3+Ld1Sad4Yjzou2SbBkqLkLd+A5kfPRLxBvso=;
        b=HAkk+JWHa++kKkwZUARPx1DrI04BMSpuKqyp+8aeZALTU4v6BtqPXsdXVQxVidoF92
         un2CHfDj8jyR0fKgPWo3FzJsJYYQZiU/3m2tSH8yoTUMjL3llbLggk6mLfJ21tXN++/D
         hb19JMx3QJ+E/XO6LFiV0rMV/hMzduxnoS49Ca5QI2j+bI7rxncrI2lPe1Kj99TSQ86d
         GXjxLOv7cQfd4wOcnslyI8dJSGh5MK5boSgdJTaykQqsxK20HN9Yvc9kDSg1rrKBjT6k
         0MG1AUe8t8srRm7qZPcDyepSnBsqS/4U/YfZK7vzpIc+hAWcfdpHqoiFrOALM/GaIV5B
         kjtg==
X-Forwarded-Encrypted: i=1; AJvYcCX25rOt7DKPlP4VelhmuNRNJq1P5enoMflJS4xN4KqCkLNRmLJqI/4wWbMV/QtuZHGfG+JS2iUjvuvDpBaa+PMOAx8M1U5UMEiadaNLqIXJoLaMyz0ePWCsayk9VzSV5hXbPTBc9jiRtHM=
X-Gm-Message-State: AOJu0YzFBdpaAIWzSUN5Cw1HIBSd9Cx/R8dtrsVj3c6A7f0tT5teZfyM
	vW0uRqgFMDEAz7ZdEOvt+qjP9I6S2WCI3mJyh4rGFOdwdyo9df2t
X-Google-Smtp-Source: AGHT+IF/u4j2lKXiTEY0Vxrj+c3pKIEnk6/2LcyHMMUQH2XF79eFPMqC4ykikjay8jVijHF5XpvvTw==
X-Received: by 2002:a17:902:d4c9:b0:1fb:29e8:5400 with SMTP id d9443c01a7336-1ff0493127fmr137562745ad.56.1722440863799;
        Wed, 31 Jul 2024 08:47:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c7fb04sm122097525ad.43.2024.07.31.08.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 08:47:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 31 Jul 2024 08:47:42 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Baoquan He <bhe@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] alpha: fix ioread64be()/iowrite64be() helpers
Message-ID: <6bd73068-4474-4129-857b-39150a31f224@roeck-us.net>
References: <20240730152744.2813600-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730152744.2813600-1-arnd@kernel.org>

On Tue, Jul 30, 2024 at 05:27:25PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Compile-testing the crypto/caam driver on alpha showed a pre-existing
> problem on alpha with iowrite64be() missing:
> 
> ERROR: modpost: "iowrite64be" [drivers/crypto/caam/caam_jr.ko] undefined!
> 
> The prototypes were added a while ago when we started using asm-generic/io.h,
> but the implementation was still missing. At some point the ioread64/iowrite64
> helpers were added, but the big-endian versions are still missing, and
> the generic version (using readq/writeq) is would not work here.
> 
> Change it to wrap ioread64()/iowrite64() instead.
> 
> Fixes: beba3771d9e0 ("crypto: caam: Make CRYPTO_DEV_FSL_CAAM dependent of COMPILE_TEST")
> Fixes: e19d4ebc536d ("alpha: add full ioread64/iowrite64 implementation")
> Fixes: 7e772dad9913 ("alpha: Use generic <asm-generic/io.h>")
> Closes: https://lore.kernel.org/all/CAHk-=wgEyzSxTs467NDOVfBSzWvUS6ztcwhiy=M3xog==KBmTw@mail.gmail.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
> I've queued this in the asm-generic tree now, will send a pull request
> in the next few days to fix alpha allmodconfig.
> 
>  arch/alpha/include/asm/io.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/alpha/include/asm/io.h b/arch/alpha/include/asm/io.h
> index 2bb8cbeedf91..52212e47e917 100644
> --- a/arch/alpha/include/asm/io.h
> +++ b/arch/alpha/include/asm/io.h
> @@ -534,8 +534,11 @@ extern inline void writeq(u64 b, volatile void __iomem *addr)
>  
>  #define ioread16be(p) swab16(ioread16(p))
>  #define ioread32be(p) swab32(ioread32(p))
> +#define ioread64be(p) swab64(ioread64(p))
>  #define iowrite16be(v,p) iowrite16(swab16(v), (p))
>  #define iowrite32be(v,p) iowrite32(swab32(v), (p))
> +#define iowrite64be(v,p) iowrite64(swab64(v), (p))
> +
>  

FWIW: Unnecessary extra blank line

Thanks,
Guenter

