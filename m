Return-Path: <linux-kernel+bounces-559527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AED7AA5F504
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0493B6795
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295762676EA;
	Thu, 13 Mar 2025 12:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="APOaxmmg"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4F42676C0
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741870657; cv=none; b=BS5EnmiTC2dbGOGy7ZO+LH3NAN2B4i+LXoTLkFVUwY7NTtMq9R+fn2PaEH6NpnqcsiO/h2E4YQMH7yypSh06Gc6AVF0ZsQ24db2jJbs2zKwM0qZTqS21wgZJzcnFe9Dig6oKIoWEfEqEWjyxy8Fp7uM/QiI6UuHqrzcE3JeDXjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741870657; c=relaxed/simple;
	bh=3SJF7mpLxysqOLGs7s+q7f1LccNakiGDFqv7+deqaJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6pfZMWBRhyh3fbGTLHbb5lUZI/x4JPRDGnrRUbYsRfNc5yi/IYuUMmi52exrF/Wl2xXaihay9nPgHAIrzOWarFxP1H+lCSc0sT8QzM+ymDIrFbqYIseapwRThI50MuTgDpY/mZ77AXa00YqFHCGEm3rb22bkbhLreQjL+nNikc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=APOaxmmg; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-390e3b3d3f4so543815f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 05:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1741870654; x=1742475454; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oU2CWGwDlIJhGLUqCxoni4cHhWUsK2iDFsgYYpF/oTQ=;
        b=APOaxmmggK32pxXRV68Rk7ps3GTf785tyvV1NoRdGow8T4TVJgHByJSrANXI4wyqHJ
         HHefvHlSgNUGh5DMal/5KsbjTtJ+XgyfwSk/CKlC50hkaC5pX2Yubu8+c5noE26g7JL+
         YsB7X7S1oDbUEalvVXLbg79kOdbDBCD82zricwFglb3VbUpLTSE/AZ+v2ki8Md/Z5trv
         taCeWZc8/TnH9fqWGL2Nkq26Hrnuog/oVL2lOFiRzNhd0bXILM/PMp+vZ6BFQGqefBgq
         pPng4xVPyagpcbUdhWCmOn1d39cPa2l8KGOOWadD2KTiMq2q4ewFFULdG4CMfGSrScxk
         6W6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741870654; x=1742475454;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oU2CWGwDlIJhGLUqCxoni4cHhWUsK2iDFsgYYpF/oTQ=;
        b=X4x4c/XUXCmEOgPDXziA33zr/9R6QWVoMqcX/Kdt//yF3HwQQHg7Yvc0m+i8QceMVi
         6EfKx03pTAy/R9zMVNN5dia2iunlpn6HHSkg/dTF/9dSdOQ4MUL7DlfVwlUy69Oq4TBL
         bRmHYmIxCuD7lKxFja1SMkxUFYip8xfOm2FpfExEopTNGZHYafHNfMFHCCXcZtiU4cWG
         elTrw39J6pRb/kclwVzVZ+wpPJa5+TZYNVNwE+R1NTUMYmQ5pIaL6HrvX4efP4+XKWSz
         GxZ+C89cBZMjut/lAUymwtqzyYX6lZp2230ZuoEHux6Hy46Xj3teCEiK4/yCbYRFwotz
         9IEg==
X-Forwarded-Encrypted: i=1; AJvYcCUFR/BbD9XWQyXaOO0wCytySfmXvYntecMYjTsAlaeLRg02i8yJa1h+zUhRhhCuUKVWyU0i0myUGCmYyC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Ma3LZ8H0XWSVkyKMjGQdvUHCQF+rQxd2AUd7qaSh0WvsgEJQ
	J3xI5Eu7zEIHFCR8wBTdvtwPL/IW/t9u+EjeUeZPRGJeVo7CFVGJodcnwrvqA60=
X-Gm-Gg: ASbGncsxywOhJZNV9DpoPlqA4YMAHKOcvFuFMAun6rcPFYRiZYmu4GFNfcKsmO143ji
	vDR5r2Eduf/zyuySADRf0YIsBYeHgxW2wOj+SD8DSe3R8EHlY/jF9Qgy+tDHpkOjEv7QN8X5BLy
	MLMoMZDdcUMi5qVVtBQvKdJWknEv8Dd2oMXem9MtzN5YRYyNfRdDAr8GFON0ZOUZexCdRvnjiYS
	xASnIYRnTgZIlpVQP7or6lt1KfAkVSxh2e6aDpeAEM2DW70RBEJwdoOtC9kyjo8DNdV6Y4NJtll
	1fd9vW2gQNgcYEPZy78TaNnTCxWH8tEI
X-Google-Smtp-Source: AGHT+IGM1DblGtxykFocIp33D2K47p5ADdU4DE4GFvOo3U3iDj70FwK79o4wmAKz0GgKu55I89czxg==
X-Received: by 2002:a5d:64ac:0:b0:390:e889:d1cf with SMTP id ffacd0b85a97d-39132dc561cmr20667619f8f.37.1741870654174;
        Thu, 13 Mar 2025 05:57:34 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::59a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c82c2690sm2044096f8f.25.2025.03.13.05.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 05:57:33 -0700 (PDT)
Date: Thu, 13 Mar 2025 13:57:32 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v3 05/17] riscv: misaligned: use on_each_cpu() for scalar
 misaligned access probing
Message-ID: <20250313-311b94f9bafe73bcd41158a1@orel>
References: <20250310151229.2365992-1-cleger@rivosinc.com>
 <20250310151229.2365992-6-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310151229.2365992-6-cleger@rivosinc.com>

On Mon, Mar 10, 2025 at 04:12:12PM +0100, Cl�ment L�ger wrote:
> schedule_on_each_cpu() was used without any good reason while documented
> as very slow. This call was in the boot path, so better use
> on_each_cpu() for scalar misaligned checking. Vector misaligned check
> still needs to use schedule_on_each_cpu() since it requires irqs to be
> enabled but that's less of a problem since this code is ran in a kthread.
> Add a comment to explicit that.
> 
> Signed-off-by: Cl�ment L�ger <cleger@rivosinc.com>
> ---
>  arch/riscv/kernel/traps_misaligned.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
> index 90ac74191357..ffac424faa88 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -616,6 +616,11 @@ bool check_vector_unaligned_access_emulated_all_cpus(void)
>  		return false;
>  	}
>  
> +	/*
> +	 * While being documented as very slow, schedule_on_each_cpu() is used
> +	 * since kernel_vector_begin() that is called inside the vector code
> +	 * expects irqs to be enabled or it will panic().

which expects

> +	 */
>  	schedule_on_each_cpu(check_vector_unaligned_access_emulated);
>  
>  	for_each_online_cpu(cpu)
> @@ -636,7 +641,7 @@ bool check_vector_unaligned_access_emulated_all_cpus(void)
>  
>  static bool unaligned_ctl __read_mostly;
>  
> -static void check_unaligned_access_emulated(struct work_struct *work __always_unused)
> +static void check_unaligned_access_emulated(void *arg __always_unused)
>  {
>  	int cpu = smp_processor_id();
>  	long *mas_ptr = per_cpu_ptr(&misaligned_access_speed, cpu);
> @@ -677,7 +682,7 @@ bool check_unaligned_access_emulated_all_cpus(void)
>  	 * accesses emulated since tasks requesting such control can run on any
>  	 * CPU.
>  	 */
> -	schedule_on_each_cpu(check_unaligned_access_emulated);
> +	on_each_cpu(check_unaligned_access_emulated, NULL, 1);
>  
>  	for_each_online_cpu(cpu)
>  		if (per_cpu(misaligned_access_speed, cpu)
> -- 
> 2.47.2
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

