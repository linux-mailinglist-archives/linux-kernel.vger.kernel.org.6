Return-Path: <linux-kernel+bounces-399569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8879C00E4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CE041F22B15
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10511E0096;
	Thu,  7 Nov 2024 09:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AttxUdHk"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AE41DFE36
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 09:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730970771; cv=none; b=dPEg/JHtCZ4yWK/yO5ymhNaElWeh9Eo/n6/DXniU5HiYRdv5KOmzssZI56GGfoFV5NERZ+hwa9DoNwsGty4rKd5iDeNBWWuMNuVXLTFLkpzZUb0LVCQiCZlwKqZy7tUC63PaSwmg9TdGy6Hp1wAMLYiOhVS4YTOHLsnA7KlqVcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730970771; c=relaxed/simple;
	bh=oEq6Bpq9jtRyKMwhrFiYBsMaw4wa9Blc95c7/NVmjfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KodEMumZTlfsZESUh1dFTivYOcdW2NPdSvJ28zC3YiirCSKXd5UfUeTIm0CfYzw1jvSjnkxrCYUMoJJ7bfyF7WdgSPwKWFoB6xRq26JsDFD9GsXh3zVigGmegqI+mYhXBHZGsh2rNjX7jc278gOgeIuvyE+zZ7MsBsJ7qWc2ndw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AttxUdHk; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d43a9bc03so453203f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 01:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730970768; x=1731575568; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CSGQrTX6RPEJ5ltwOkhPplbF6XskuwzGte6a11RVMyU=;
        b=AttxUdHkoPUdZek2amJl27dnAgtyDCG0M7sXMDT4ZMw3vxquTKLkOOQ6pQJgkd+eca
         fjRdNwBzdh4drejsCyeNzBELsFxOETgQomxrZGNUQPYrWkook1syt3r3XDLJX3tbLgXi
         2AzICpSM2QqKPaAa3q3hjFfwSXpYv8cabK4FK/0x+v0hmBcF/+dsVpSCZLobyfs6pksl
         QjwhnZj1se33bs81/BbZXpGBqWo2yw4jCqH9oOIWGRYJ1FjdMdUu+BUgRT+5vzeyox6Z
         2fM2cqMjoju35+XwaIs1HQ2+rAq/4uWlufa6B+kmbRXNhoRXSrmL6KZxujZkkNYWbBSU
         t94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730970768; x=1731575568;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CSGQrTX6RPEJ5ltwOkhPplbF6XskuwzGte6a11RVMyU=;
        b=eR77K3hjGOksQ6NEADUCqyCBpL6vdtdfDzPJnkXt3ishkk8zW4WS36FYKVeElmJpBc
         EsERwGhtejtFvYaHJk584bn8eyxB9P1hWxwTry+iP3uSzCIUvLpahTyLC37vm6ISltTx
         qlkGjtKbC3XoUvZoYLmyTDW3zmLTLode1rwjouULZInxGBxySPBRjVag9UdidrdOz+ji
         G5RbbD6rxwjB7WdhtKZ15nOr3cED+537sxtHfsLufTmw/e7wPJoOLbYArYoF01iYRJeJ
         th1eCR2lmbxc+lv4Qe1Hdb7SzEsrSwcvJf408JBJmPIWA36A3sJ0UDFFYJQOnTRNIXPt
         jPgg==
X-Forwarded-Encrypted: i=1; AJvYcCUOKyYF2Bg/cDPzqPkxQsXFYbZzvD2vgvymQ06cnly4ifR/040/rE2xr6KXDT4K1USq2xs4cweeP39j5Xs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyeie9PmDhasyftHvvqLxMg1qkIV+8TbxjtztYQIUuQf4khI3QT
	rJ1EhvOL3E9r9LgmGmAl0GbRgYY1r0+ukV95ATTa3MYyAZhnf6HVEqATn5/I2Pg=
X-Google-Smtp-Source: AGHT+IEMgszAeoujvnm+EHb15Ezxw32/wzRi/AgvpY4lG2K21v203JKIrGkQz4rMrdtjTjqkqPH+Bw==
X-Received: by 2002:a5d:64c7:0:b0:37d:4937:c9eb with SMTP id ffacd0b85a97d-381c7a5e2bfmr19441264f8f.21.1730970767795;
        Thu, 07 Nov 2024 01:12:47 -0800 (PST)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda04ad0sm1145847f8f.100.2024.11.07.01.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 01:12:47 -0800 (PST)
Date: Thu, 7 Nov 2024 09:13:07 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Quentin Monnet <qmo@kernel.org>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	David Abdurachmanov <davidlt@rivosinc.com>
Subject: Re: [PATCH] tools: Override makefile ARCH variable if defined, but
 empty
Message-ID: <20241107091307.GA2016393@myrica>
References: <20241106193208.290067-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241106193208.290067-1-bjorn@kernel.org>

On Wed, Nov 06, 2024 at 08:32:06PM +0100, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> There are a number of tools (bpftool, selftests), that require a
> "bootstrap" build. Here, a bootstrap build is a build host variant of
> a target. E.g., assume that you're performing a bpftool cross-build on
> x86 to riscv, a bootstrap build would then be an x86 variant of
> bpftool. The typical way to perform the host build variant, is to pass
> "ARCH=" in a sub-make. However, if a variable has been set with a
> command argument, then ordinary assignments in the makefile are
> ignored.
> 
> This side-effect results in that ARCH, and variables depending on ARCH
> are not set.
> 
> Workaround by overriding ARCH to the host arch, if ARCH is empty.
> 
> Fixes: 8859b0da5aac ("tools/bpftool: Fix cross-build")
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  tools/scripts/Makefile.arch | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/scripts/Makefile.arch b/tools/scripts/Makefile.arch
> index f6a50f06dfc4..eabfe9f411d9 100644
> --- a/tools/scripts/Makefile.arch
> +++ b/tools/scripts/Makefile.arch
> @@ -7,8 +7,8 @@ HOSTARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
>                                    -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ \
>                                    -e s/riscv.*/riscv/ -e s/loongarch.*/loongarch/)
>  
> -ifndef ARCH
> -ARCH := $(HOSTARCH)
> +ifeq ($(strip $(ARCH)),)
> +override ARCH := $(HOSTARCH)
>  endif
>  
>  SRCARCH := $(ARCH)
> 
> base-commit: 7758b206117dab9894f0bcb8333f8e4731c5065a
> -- 
> 2.45.2
> 

