Return-Path: <linux-kernel+bounces-287123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFFE952348
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 22:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10001B20C48
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 20:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF571C231D;
	Wed, 14 Aug 2024 20:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Cus6QGVH"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F801762D2
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 20:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723666926; cv=none; b=aElRVvdt2FATBa2sYDsNxdPnYvnSGoNHbJI3gi2TwFNOzDIU9yMmzgbav6Y8jasPQvtvdsnYD3oE9mHj1/hoDBPO1Q03o7f+kHh1SQkuW9xpmarn+HqlKrH3hC7Hslgd/J/xt1QsiidMg/t2F4HSH0XeSnfyD74ZZwStN7YFP6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723666926; c=relaxed/simple;
	bh=klgx7fIfxIwYSsC2xOg20bcBSN5EhBdfHpM3HGgPJp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZlRLpMNhfdMk4F+BfFr2mkYq2rI6Oock4Vk7vUph/5EzxgEHvLIy4V1W8hwwQsDB7/6Bpj78MaD8GoGJ9lOe+Qn3vjRjqsqxpIpx+wy9Smy65Hx+BxyGzRUZ8RCRnKbHG6bNjDlKmag0VO54uOzgLeeqDOJAIEO5LRiQRdvdYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Cus6QGVH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fd66cddd07so2264605ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 13:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723666923; x=1724271723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=stUNjkX0MpnpU5tgftjr7ORKywYwQiBPnahluN05hMI=;
        b=Cus6QGVHJoNRRd9n9iYi/k/KX7fIuSDutQEm08zxLHKE3BzCtTEEgjKOkV4mg3s1E5
         S1C6FEG7LFYJiXK1LEjd7EpsoRnKI6DrbRTR/WJOhGBaQr1D1HdOmFaPWVDCgq9sT5Mb
         HbgXJxsIWIDs+i+w69n6kgWviZZN1xU6esL0/lOHr6u68+h8o1t9SWsqcYgGhqaHdJv7
         OjkcovMGWsZU20oxV7joN5SgLqjkNJMenVQVjF9yh3Hre2V0/rursoTiT3Bkz9uzmTIb
         iGeVJ+O6uBp3rNBXcJHZNyK3u+VI1zlW6eosGumslTsWcmSPMrMqSIWM/PCJGmmivnHy
         7o4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723666923; x=1724271723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stUNjkX0MpnpU5tgftjr7ORKywYwQiBPnahluN05hMI=;
        b=UQgAdgJgvWBhmbP+wW22ruBBek1gYo/qOlUKQg4U6A8vGpZyTGH6NQ/HDBBcFv7dqw
         BOj3qnthh3cc58hJpATSxehUrbmaQEhOFN7SjhX4zGfW3YDQoVSZOEVnAXEOlQT4fQpv
         mHny/BA/qOMzkOmqsIxmKqC2wV+pGAOHvhABUFOULg3gYWWHFCdyqtK7sJ3rvSFuMr0W
         vam7P0DZs1EM+JJsRFIN891qtvgnMBPwolyyvVH5Lb9QaupMuVTtPbfGSY8HAMNwOpU4
         C1yugWetkQ21y5tToM/JUD62VwEJmbhxtB3ZVgSB/ISzcgSav6D2QA6NtncPCPWa60Fc
         kqQg==
X-Forwarded-Encrypted: i=1; AJvYcCW5cE3sJO+BTq9VhzWYeSWL/rcim6/7iasuVaD5daZVRlUcLd6XXeI6T+ANOLF1QeJSx/pGuAWhcjmtGy+gUqb1AatWs+/eVWRhzV8U
X-Gm-Message-State: AOJu0Ywfmlwj0hrkTv87QoE41KCBiOHWIOwYGh5RUOzgDvh2cdEqA4Zb
	sn1+EzJN29xpQMzhCAkxBFoJPlGOxUXkgHnvuqH4PgzNzOa4DQ9EM81KAX+OIrc=
X-Google-Smtp-Source: AGHT+IG0/CFBU9Bq6alVt+gaPLnIf7VfsUi7sesDXbH+O9QNL5l0cs0hatjNsXRKHdrcTaXkzS3OXQ==
X-Received: by 2002:a17:903:2291:b0:1fb:8c35:6022 with SMTP id d9443c01a7336-201d6393a51mr46560335ad.4.1723666923538;
        Wed, 14 Aug 2024 13:22:03 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f038b4d8sm238005ad.206.2024.08.14.13.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 13:22:02 -0700 (PDT)
Date: Wed, 14 Aug 2024 13:21:59 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Andy Chiu <andy.chiu@sifive.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -fixes v2] riscv: Fix out-of-bounds when accessing Andes
 per hart vendor extension array
Message-ID: <Zr0R5/gHWGs+eK/5@ghost>
References: <20240814192619.276794-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814192619.276794-1-alexghiti@rivosinc.com>

On Wed, Aug 14, 2024 at 09:26:19PM +0200, Alexandre Ghiti wrote:
> The out-of-bounds access is reported by UBSAN:
> 
> [    0.000000] UBSAN: array-index-out-of-bounds in ../arch/riscv/kernel/vendor_extensions.c:41:66
> [    0.000000] index -1 is out of range for type 'riscv_isavendorinfo [32]'
> [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.11.0-rc2ubuntu-defconfig #2
> [    0.000000] Hardware name: riscv-virtio,qemu (DT)
> [    0.000000] Call Trace:
> [    0.000000] [<ffffffff94e078ba>] dump_backtrace+0x32/0x40
> [    0.000000] [<ffffffff95c83c1a>] show_stack+0x38/0x44
> [    0.000000] [<ffffffff95c94614>] dump_stack_lvl+0x70/0x9c
> [    0.000000] [<ffffffff95c94658>] dump_stack+0x18/0x20
> [    0.000000] [<ffffffff95c8bbb2>] ubsan_epilogue+0x10/0x46
> [    0.000000] [<ffffffff95485a82>] __ubsan_handle_out_of_bounds+0x94/0x9c
> [    0.000000] [<ffffffff94e09442>] __riscv_isa_vendor_extension_available+0x90/0x92
> [    0.000000] [<ffffffff94e043b6>] riscv_cpufeature_patch_func+0xc4/0x148
> [    0.000000] [<ffffffff94e035f8>] _apply_alternatives+0x42/0x50
> [    0.000000] [<ffffffff95e04196>] apply_boot_alternatives+0x3c/0x100
> [    0.000000] [<ffffffff95e05b52>] setup_arch+0x85a/0x8bc
> [    0.000000] [<ffffffff95e00ca0>] start_kernel+0xa4/0xfb6
> 
> The dereferencing using cpu should actually not happen, so remove it.
> 
> Fixes: 23c996fc2bc1 ("riscv: Extend cpufeature.c to detect vendor extensions")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/kernel/vendor_extensions.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/vendor_extensions.c b/arch/riscv/kernel/vendor_extensions.c
> index b6c1e7b5d34b..a8126d118341 100644
> --- a/arch/riscv/kernel/vendor_extensions.c
> +++ b/arch/riscv/kernel/vendor_extensions.c
> @@ -38,7 +38,7 @@ bool __riscv_isa_vendor_extension_available(int cpu, unsigned long vendor, unsig
>  	#ifdef CONFIG_RISCV_ISA_VENDOR_EXT_ANDES
>  	case ANDES_VENDOR_ID:
>  		bmap = &riscv_isa_vendor_ext_list_andes.all_harts_isa_bitmap;
> -		cpu_bmap = &riscv_isa_vendor_ext_list_andes.per_hart_isa_bitmap[cpu];
> +		cpu_bmap = riscv_isa_vendor_ext_list_andes.per_hart_isa_bitmap;
>  		break;
>  	#endif
>  	default:
> -- 
> 2.39.2
> 

Thanks!

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>


