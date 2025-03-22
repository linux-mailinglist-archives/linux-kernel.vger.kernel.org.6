Return-Path: <linux-kernel+bounces-572405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39936A6CA06
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 13:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 817B73AB820
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 12:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED80721507B;
	Sat, 22 Mar 2025 12:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="pfVWZLGf"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9504D1E7C3A
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 12:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742645169; cv=none; b=M/1jqT1t4NNIXkCaEKlYsLWKPqL1OPZHEhYLGCdBd1+TcwTZ032yqJKQJ78qWt/FbBHwu8Jos0fANIWhtQATZ40xOp+uBz0vV3gL4WBmQjLHX+CKYKf2TPUN4hrDdhWItQVn4cLqHK6qR6DAAZJIvJWiR073lsRgEdEwacGxKCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742645169; c=relaxed/simple;
	bh=oOwIic0xoWcK/W7bScwvvNxG27FtWKsUDiBHcGLGMEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cd6WAdB4dqwuKHm/DGGevl+Y8E3NJxHcnGFtxrzH6b+quH33/d0PLNIdFpMKfdgY/gWfYZEcQpkZoMlHGlOYRrGMIcQeElBT1EQYLFwZXQ83g4rD47ADEGvlejPmVkxnWicFrgCe/Rp5CNucZ/7dsRmBchcUl/pG+jGV5eNhQ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=pfVWZLGf; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so18983615e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 05:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1742645166; x=1743249966; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZKCRWgSlF1v0cutxAi8x3LCFESHSHWoNhfvIYKSJItY=;
        b=pfVWZLGfHoQsMmWHi54ghr7KbiyyJFpAMemHA4DI398Vhpz1z/JsE643sFQ1ehK9zl
         Clw4wgHobbHkiCQXGyiU7Eqj6nStsGZz5jalsceV3p31r5hpN89/3D39dBQCN672KKhY
         SlT2poaxnVeXaFVC5PpFbax3DQh5ipvKlna28PGbWmGvwKg60CnFyq4GuSViWAbNAaHE
         b6nQbieQAmhXUuyUeZL+6TAJtCS7BfvAmIsFfE8Xt8GwYRtvBdSwVUzyjIulhBEqH10m
         8CmvdvayXOc0Vo+uLQJ+81AL56LPVMRdXEh24EohL+YfeAwVv85vSlJfwMRS6/HhLA0B
         DoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742645166; x=1743249966;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKCRWgSlF1v0cutxAi8x3LCFESHSHWoNhfvIYKSJItY=;
        b=CfQcQV/qjIhGabAklRcuP3DFlzCnVUlYunTtwxD4j3JyLWl9plSeuFrwYASeSGgrS+
         fylHNEVT/PZv094qU13bipg/2wFLIC0qisZl44EJKJgFPctvnx40DOILLp9Tva9Zj80I
         1JOdzl3tsuI9RhdHmcfCvAvAyituAaDjbZN9ZcA8bBcoVDE0evv9NPcLJix6hRKIbXxj
         gUg5zyDCiAHjOE4+W5tRbwSOWXeiYEiAlX4iHZSqN98uYlbhwMHYcH/N/87+p7erRXFU
         mb9E3hbJ43QxFQCBwxXhx8RRXb+zuDThxtr/0oeIJWY+lIzU4fc7s433LuOv98cirp2H
         GmFQ==
X-Forwarded-Encrypted: i=1; AJvYcCX53cGNRo5AkK4WEV6Rl1QLI1EHPP41qmjizvgJUPG3InlJFI5E2mV0XrH/W8HKgvVOqrt6bZ+wZzfuPaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk1IsbW30mrOedMNEoqMCuyTwe2O/KgM7iyb7FcMowfxFQvvZR
	oDyXMRTi2vr0KKCc0Ykxel5S3Z07XYmo1fiNmN3M1p9GBwk27FLHvy0picHX0iE=
X-Gm-Gg: ASbGncu/LMlBrgMZfaPP53Nn+So26SXKelgTLjOGXCYEYRSItouHIEp8Gsp0KAReYC3
	kWL/lBfYhgT10T/P8xfy3UKdl+O4vN0vNwUDTo/uJAjEMUxQOeWYZrqleN+H4s0j669r4R9YLVJ
	UIGmDx9Z/d2ZF7GpRuptNwDBMHuHgFeaExKfbLfNTKrfamJdym7zF+0ZFM3NVuh8yz2tmcWiqI1
	rNqFkFMZl/2O+b8XNtKLXTk52EQhq7a4jeFF6AjXXLn3frykdO12WaLgQsf7/G4JPVUV2LJDNIH
	BZXhXIb4TpVFlUG77hfxCU2nmT/emz4gux1utkGOXd7+TZs3TMxPT3RXniA4YoosL+TOpnmN2A=
	=
X-Google-Smtp-Source: AGHT+IFTfC3V3Y+aXvtwsAGDzN2r/TELBK33hItKDRr/I6qX4Pf8OQOcC8wMhwn6dPn+tHwLQGn1PA==
X-Received: by 2002:a05:600c:470f:b0:43c:fe15:41e1 with SMTP id 5b1f17b1804b1-43d509e190fmr61771675e9.4.1742645165642;
        Sat, 22 Mar 2025 05:06:05 -0700 (PDT)
Received: from localhost (cst2-173-28.cust.vodafone.cz. [31.30.173.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9ef23esm4932401f8f.81.2025.03.22.05.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 05:06:05 -0700 (PDT)
Date: Sat, 22 Mar 2025 13:06:04 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v4 02/18] riscv: sbi: add new SBI error mappings
Message-ID: <20250322-cce038c88db88dd119a49846@orel>
References: <20250317170625.1142870-1-cleger@rivosinc.com>
 <20250317170625.1142870-3-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250317170625.1142870-3-cleger@rivosinc.com>

On Mon, Mar 17, 2025 at 06:06:08PM +0100, Clément Léger wrote:
> A few new errors have been added with SBI V3.0, maps them as close as
> possible to errno values.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---
>  arch/riscv/include/asm/sbi.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index bb077d0c912f..d11d22717b49 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -536,11 +536,20 @@ static inline int sbi_err_map_linux_errno(int err)
>  	case SBI_SUCCESS:
>  		return 0;
>  	case SBI_ERR_DENIED:
> +	case SBI_ERR_DENIED_LOCKED:
>  		return -EPERM;
>  	case SBI_ERR_INVALID_PARAM:
> +	case SBI_ERR_INVALID_STATE:
> +	case SBI_ERR_BAD_RANGE:
>  		return -EINVAL;
>  	case SBI_ERR_INVALID_ADDRESS:
>  		return -EFAULT;
> +	case SBI_ERR_NO_SHMEM:
> +		return -ENOMEM;
> +	case SBI_ERR_TIMEOUT:
> +		return -ETIME;
> +	case SBI_ERR_IO:
> +		return -EIO;
>  	case SBI_ERR_NOT_SUPPORTED:
>  	case SBI_ERR_FAILURE:
>  	default:
> -- 
> 2.47.2
>

I'm not a huge fan sbi_err_map_linux_errno() since the mappings seem a bit
arbitrary, but if we're going to do it, then these look pretty good to me.
Only other thought I had was E2BIG for bad-range, but nah...

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew

