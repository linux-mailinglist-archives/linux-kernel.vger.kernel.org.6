Return-Path: <linux-kernel+bounces-255204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D241C933D6C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 152261C22A4E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06BB1802B2;
	Wed, 17 Jul 2024 13:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="DIEjpXpK"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE471CAB1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 13:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721222046; cv=none; b=BdwxtkSjI/FCaSPOIKQiHL9O4VDLaxZTCEuzm9i7j2ynzSoKfMzw4p3Mh7KdIj3W1b2uJw3N19nrYHpAJGv1eyu4Tp0i/asbK7hRWcpBY/59maUos+64/vFJ7zT0TPTHZzCFdiOVnjDYQ7YTowNAl+YKNyy5QRD7bdv0t0Y/MKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721222046; c=relaxed/simple;
	bh=armPa7YCf4iBcdOu3vxeKA+v5jvYIwG8BSMVQM7sxq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMqDyOw22cdLjSsRr29Yy3+m5WWInEFOkZVUHb3gL5grRWbDMEyNcBYQVaG8viJT0O1YQmOEDpFesjaBrkoDKnn2y04oqcq9SRBfJs1nYUqZLeCdHlbvuzV9BfHaYCtGzzgHJ1eMo54TiHMqHcLfYk1LNUWYN2+DYhliiTuioMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=DIEjpXpK; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3833cd120e5so2361215ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 06:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1721222044; x=1721826844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5uVCb0H5+qw23qlc6XhoPIVvBE69YNuKQHQJOvzKA2E=;
        b=DIEjpXpKGl1b7XV2HWO8nj6LNNLzpdd72mq3/TBRinVG8ZiDx2em44ST+mnB7tFrtR
         xNMFqoeUzmtooBDqoWN/Cx3CDuCO0l/AFvY1yOAB2PJmxThMdGdD6oJAQ+sGnB8Npn3T
         yUzj3qchlmrc/NBDRoDwsWpzamV8MLq/RNSqYt8kcLZQgWTYl3aqwXrWEpcr7KpPVLvM
         CCMniAJx0gzquLP0dFMyinocBJY/dUZl1R/2rO+hTwqfsiOHg0AIdoJ2f+YwwlG3FUmH
         9iz+civHuTiNWiSyyrBW3hwqBx/vrqcPSmK4ZBgPmDtqVQfqeUJuQ2YpxUSKRNDa8pOk
         0DCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721222044; x=1721826844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5uVCb0H5+qw23qlc6XhoPIVvBE69YNuKQHQJOvzKA2E=;
        b=BEbC5gHEQsCaryEoa0PQfr8P4JJp5aF+SFi6MOydozWsPGsE3RFVjsS7x7rR2OG8QM
         MzXIs2NEAfNiUKi8C8Lfd0Im/5aneyvKav7odMWcDeBQ7YQEYjWQDRk8f2k1m87wWXwQ
         YL/1bj9jssLCEt2lDAlhW3j4HNTlZ6cwUXBMuYWcMBe2dxFJBlIXv59bK0tM/OoCY5Kk
         vGalWOrn5mHUu7AE9qYVnoBjU9sw3YaPne0bPL9wpmxOZNCvmlj3Z6XQx67xqyLbQxMM
         GQXJJXJ5dfOfVIb9z0LjTGex2I8hFhKgemXaXj2+FFzSAWa64fKNtA05vQtCnaSrqRj9
         eOfg==
X-Forwarded-Encrypted: i=1; AJvYcCV7kO4Z3rEX0+ymoqGf0NK3w8rtAFGT5MTPCk/fvzkfWZadxLuKydFxqHZ3WJwHoyZ0uxjmu/VK/QoJBT8N00K7X8wFNKoKhhhBnzbb
X-Gm-Message-State: AOJu0YyKdVy9vreTzMQZ+qjmTaioS6obZ63JVdagIPzMHWyg0XDkilPV
	TVb3F2XrSBaCNPtfL56VxPdKdAGMVrh4So5HwGFtWifzVuDqCsaeYueMcyweCUg=
X-Google-Smtp-Source: AGHT+IFhw3MWoZSEt2rfShEC06vRpqsGgviNG/vejjaH60Y+5HYzE8TtnavkRKo4N4oXKY9d7Dnl1A==
X-Received: by 2002:a05:6e02:1c0d:b0:376:3c3b:e235 with SMTP id e9e14a558f8ab-3950f2855e2mr16902955ab.13.1721222043808;
        Wed, 17 Jul 2024 06:14:03 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c210f7c4c8sm651830173.130.2024.07.17.06.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 06:14:03 -0700 (PDT)
Date: Wed, 17 Jul 2024 08:14:02 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: sunying@isrc.iscas.ac.cn
Cc: ebiederm@xmission.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, kexec@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, zhuhengbo@iscas.ac.cn, Petr Tesarik <petr@tesarici.cz>
Subject: Re: [PATCH v1] riscv/kexec_file: Fix relocation type R_RISCV_ADD16
 and R_RISCV_SUB16 unknown
Message-ID: <20240717-c761f5af7369cdeba5b9c759@orel>
References: <20240711083236.2859632-1-sunying@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711083236.2859632-1-sunying@isrc.iscas.ac.cn>

On Thu, Jul 11, 2024 at 08:32:36AM GMT, sunying@isrc.iscas.ac.cn wrote:
> From: Ying Sun <sunying@isrc.iscas.ac.cn>
> 
> Runs on the kernel with CONFIG_RISCV_ALTERNATIVE enabled:
>   kexec -sl vmlinux
> 
> Error:
>   kexec_image: Unknown rela relocation: 34
>   kexec_image: Error loading purgatory ret=-8
> and
>   kexec_image: Unknown rela relocation: 38
>   kexec_image: Error loading purgatory ret=-8
> 
> The purgatory code uses the 16-bit addition and subtraction relocation
> type, but not handled, resulting in kexec_file_load failure.
> So add handle to arch_kexec_apply_relocations_add().
> 
> Tested on RISC-V64 Qemu-virt, issue fixed.
> 
> Co-developed-by: Petr Tesarik <petr@tesarici.cz>
> Signed-off-by: Petr Tesarik <petr@tesarici.cz>
> Signed-off-by: Ying Sun <sunying@isrc.iscas.ac.cn>
> ---
>  arch/riscv/kernel/elf_kexec.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
> index 11c0d2e0becf..3c37661801f9 100644
> --- a/arch/riscv/kernel/elf_kexec.c
> +++ b/arch/riscv/kernel/elf_kexec.c
> @@ -451,6 +451,12 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
>  			*(u32 *)loc = CLEAN_IMM(CJTYPE, *(u32 *)loc) |
>  				 ENCODE_CJTYPE_IMM(val - addr);
>  			break;
> +		case R_RISCV_ADD16:
> +			*(u16 *)loc += val;
> +			break;
> +		case R_RISCV_SUB16:
> +			*(u16 *)loc -= val;
> +			break;
>  		case R_RISCV_ADD32:
>  			*(u32 *)loc += val;
>  			break;
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

