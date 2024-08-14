Return-Path: <linux-kernel+bounces-285706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87599951195
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 03:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA4CB1C23183
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 01:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37E1156CE;
	Wed, 14 Aug 2024 01:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Il+mCR1m"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52CFD304
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 01:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723598982; cv=none; b=rvS0cMg6wbhxy9UP9I9ZlAK/G/ekXiV/npU86feQWIlMYouUIl53I+ZgxZFi4hxUxsDS5UuFt/dw2awUQ6KHx2PQEClgVmhD+etHlIjwwdIp/vdveoQUxF3Uh5maWFke2gHz/yP5njc6TUEC8ah7LLouuitnpu0xvaKL44+yy3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723598982; c=relaxed/simple;
	bh=hekSv/l3fp6cREq/VKCrzf91sOlgwPzT48hiA2bon48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjtumL+ooC1O87F+Kd7LsghhWENUlreZ8qh5KLaYlyMdLdACb5Y749SR5IYT0dIysk81Woguz2GJYwGBZGQoupAo9tex8+SVKhvvQ+Wp2Rbc+xyjzk3frqBa1+wdD6O9xm/UUF77bBzPiwtWoWCaw02fspBBY1Dcbtk7gBA3FJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Il+mCR1m; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-710dc3015bfso329696b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 18:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723598979; x=1724203779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hODmjSl6QW+3X/s9NClws+oOQIw7sZ/BkvPvK41RAqM=;
        b=Il+mCR1mYJFaGFdtaBq3GCUfrTV6d8h/8wEKA/3vsqFUVOhdC45S1sfegHqtP8KKvc
         ZiQ9qCap4EleCX6iq/dcDozhzhrMtnIV631a7aqsASEEGlIZ9RqdHwMty9R6PiC4wiLi
         lo1GHMJwiUUG5//Yu/+ijAMpzRUD70XM/VqcRmas+uPP+AFBVdoJrxwTvKn3I4zGaJWw
         38sFfDRbQAucGV3gwQpxy1qNoBRyzqG4uQCxD/1s7Z4VYaeuXvEHb9fTOKnvOe/kdwgM
         dqm1dgYKKmIOzFMY74oCIkLNShiwbfgVEGd0eiYFubAWTp1qUVLQC0OqDPh2TEoapnSP
         ou4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723598979; x=1724203779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hODmjSl6QW+3X/s9NClws+oOQIw7sZ/BkvPvK41RAqM=;
        b=D+l3SILPsPzM+GJ2ivR94ziQy1tgkQ6r3hoxsNzyGUrdTnA3kIyaq2dIBbCJKWnkNp
         C3onJAzKvLFFral8SR/HM9nPFryy2CWpJO9whNnaeurt4z5TmfcNFJGxj72nonPpuaBk
         D4vthgFiILFQOrDlLkYSPKod5xvO/u44CY9DjHMtqpIabivah0MQEhFiUtCefTO7iC5T
         jiWeVhYuX/TaU+CenWBZtTF61DUree0IUgW8Xf/J9SJDvFOlryOwlmV99ZQOIhJAUnkD
         R8Wmsn7LQZbsb2Eh94HKYt4EMde8dDGkYGdVJ9Cjfn+vxQZVN10X/3bgICjdonC6qo2z
         5wlA==
X-Forwarded-Encrypted: i=1; AJvYcCXGhr3nJwRQ3mviEylkWV5+wk2n3LyoFKwYo3HkdUq8gB3nhcEY35bKakws+Klrg8AWReKUoxrejWqqxgS3XoTS3b003Ghc2adKd5g1
X-Gm-Message-State: AOJu0YynlsTGfgMm+E0QPELhsuxCT3W1B13+kLwBh3qEmzM0/oFE0eeX
	pl1JCHIorgOt5XyqH2jgYTjo7smHNjm3pqn/z7c59q2tzmvWz2PWL6NlIMNdSQNM1QlZjsESr3O
	6
X-Google-Smtp-Source: AGHT+IEPcSEP7pmct3KvaMtw086pxINGCJd4rsCyrnC2QnEPyOF6Zdez6aYPylv/RSBLuTSk7D2X1Q==
X-Received: by 2002:a05:6a00:2d18:b0:70b:5368:a212 with SMTP id d2e1a72fcca58-7126a528997mr642990b3a.15.1723598978864;
        Tue, 13 Aug 2024 18:29:38 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7126c274c69sm83502b3a.42.2024.08.13.18.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 18:29:38 -0700 (PDT)
Date: Tue, 13 Aug 2024 18:29:35 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Andy Chiu <andy.chiu@sifive.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -fixes] riscv: Fix out-of-bounds when accessing Andes per
 hart vendor extension array
Message-ID: <ZrwIf8nwte43+274@ghost>
References: <20240811150229.82321-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240811150229.82321-1-alexghiti@rivosinc.com>

On Sun, Aug 11, 2024 at 05:02:29PM +0200, Alexandre Ghiti wrote:
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
> This happens because we unconditionally use the cpu parameter to access
> this array. But if -1 is passed, that means we should not and we don't
> need to access this array, so simply prevent accessing the array in that case.
> 
> Fixes: 23c996fc2bc1 ("riscv: Extend cpufeature.c to detect vendor extensions")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/kernel/vendor_extensions.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/kernel/vendor_extensions.c b/arch/riscv/kernel/vendor_extensions.c
> index b6c1e7b5d34b..01dc79b1d17b 100644
> --- a/arch/riscv/kernel/vendor_extensions.c
> +++ b/arch/riscv/kernel/vendor_extensions.c
> @@ -27,7 +27,7 @@ const size_t riscv_isa_vendor_ext_list_size = ARRAY_SIZE(riscv_isa_vendor_ext_li
>   * @bit: bit position of the desired extension
>   * Return: true or false
>   *
> - * NOTE: When cpu is -1, will check if extension is available on all cpus
> + * NOTE: When cpu is VENDOR_EXT_ALL_CPUS, will check if extension is available on all cpus
>   */
>  bool __riscv_isa_vendor_extension_available(int cpu, unsigned long vendor, unsigned int bit)
>  {
> @@ -38,14 +38,15 @@ bool __riscv_isa_vendor_extension_available(int cpu, unsigned long vendor, unsig
>  	#ifdef CONFIG_RISCV_ISA_VENDOR_EXT_ANDES
>  	case ANDES_VENDOR_ID:
>  		bmap = &riscv_isa_vendor_ext_list_andes.all_harts_isa_bitmap;
> -		cpu_bmap = &riscv_isa_vendor_ext_list_andes.per_hart_isa_bitmap[cpu];
> +		if (cpu != VENDOR_EXT_ALL_CPUS)
> +			cpu_bmap = &riscv_isa_vendor_ext_list_andes.per_hart_isa_bitmap[cpu];
>  		break;
>  	#endif
>  	default:
>  		return false;
>  	}
>  
> -	if (cpu != -1)
> +	if (cpu != VENDOR_EXT_ALL_CPUS)
>  		bmap = &cpu_bmap[cpu];
>  
>  	if (bit >= RISCV_ISA_VENDOR_EXT_MAX)
> -- 
> 2.39.2
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

The line that is setting the cpu_bmap shouldn't be indexing into it at
all. It is supposed to be:

cpu_bmap = &riscv_isa_vendor_ext_list_andes.per_hart_isa_bitmap;

The indexing is handled later on by the if-statement.

Thank you for looking into this.

- Charlie


