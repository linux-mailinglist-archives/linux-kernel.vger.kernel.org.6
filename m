Return-Path: <linux-kernel+bounces-292682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FF59572BD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 20:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E647283F93
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1238188CDA;
	Mon, 19 Aug 2024 18:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="boQL4L/S"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEB517557E
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 18:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724091099; cv=none; b=lY1KDj4BL1iaY1Vvbh0Z4fl8p1yDt7OglwEwSGmyO/Y8w5RkpdmGfntnNvGj3yoFn2AgUuhxqrilX+JCJzZnFtu974GEhPCnsyieSQLIyyyZNZmO26LWTRGv/IhwVBA+MrbccnGI0swPWRZTKgIfJBF0iK1zBYzC1936vDg6tzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724091099; c=relaxed/simple;
	bh=2t0Z2QEvu6iIXrmbgctjgOqSj1baJo4T/dTpMSF8kPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HE+HRAqZcqlL3FvkTerawYgM+3xXOK0/eobLcCYgVYsrzB9sVFzRfi2KJObi29OGCMsKm40ozVLOfV3c875b8vhMjZJXfyj22TlTF//Q+VZdFyQnk7z6Y/S3BsNIo7J3PtZnaRER7LHtLwEIerBICVRIbWk5uM1MYwAXtnbH0zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=boQL4L/S; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-713eeb4e4a9so1037337b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 11:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724091096; x=1724695896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vYDHGgJN71LoTtjJp/4v5I3zXOy8Lpidv1xHx/d3UwI=;
        b=boQL4L/Sj3CU8Sw9rQnP3s+HE6mD0o6sIR0jz0UPNCPXt0VkLhvWk6pSSwT/BU23VY
         AhNh+Eb20GeDYriHtW/DWBjlheG24aFmH8pgDXQ5MEpdRd+bPPEYk9q60hyWOtTLPTB2
         okxfQsEjbVi6q3g/dCgb9UqwBjWje8lGOKxslhOVPnDCDAXWSwtF1dRwd2D5v/yZ7a+q
         9tL9BZU6uR+XGxNe2NzHzj3D/CHM2HVMonIiDzxMocxbRwocFHan0Q9Y+dK6W0FEouWI
         lqhe4dXwrVFmYvych73vDBpbhpE41c50KWNs/zIDOAN+Mlgh8uoFvnWMXU2vUCgsllNa
         7cUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724091096; x=1724695896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYDHGgJN71LoTtjJp/4v5I3zXOy8Lpidv1xHx/d3UwI=;
        b=K9FbAGxSp5bnTGx+D8ka/Z1K9MG6I4B76+VofHJusuTjRzO73WVGxNRP/F53AWDkFd
         uVZWwJ2vU0UQhpm32hEKHeFB9Pl1ldgrfoMCcwR4N0duC9w1MonLVXWK9XPXUPHMaPzg
         QP3fiKCWi/Y1TNDG94xq7QghHbFY11rw5HpLXhSIGfAzbtISgrzB/dQzId89HW+wZYcr
         /FzdrhrU7Ce6a3p/tDRyV7uq4lMI5+MMa9QSlmFrrIOD5uH4AgHUjZWnLQ7RPiiKzB6X
         mCqRAWMtTPF8NR8wi5Ho8rDjcNyLqsP1gsFBp1BS5KZC5+FO+X42keZRdcnKdAYN3bIf
         czow==
X-Forwarded-Encrypted: i=1; AJvYcCW2a/cBtnmt3SB93EYxYhvxrbIUDPgdTuTxr7cQ0VV1+35Uf1pE8ZjSgbDQ3D71qnBJwBa+8IYSSW2QSob5867LGLlB439UgxakspHy
X-Gm-Message-State: AOJu0Yz3PnJYytrODEe4OM0Cn1UNiXAFzXlexTHAfZghStv5i4JuLjZB
	7daHVrDlu2PL042eJcpLZ29dNWZHg30/ORX0rUm9qAFWn7OgkVdxS5qcNyY6xtXl8R0eH09hlJW
	W
X-Google-Smtp-Source: AGHT+IGsAw7s8B/onOqSBkHQHwBaC3lk/QipjP8EXDXBC7ou+6mircvQsdDdvqKmLSLgz4oe08BXDw==
X-Received: by 2002:a05:6a20:c90e:b0:1c4:ae55:2b5a with SMTP id adf61e73a8af0-1caa360c14amr9772943637.18.1724091095927;
        Mon, 19 Aug 2024 11:11:35 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127add7cc8sm6847892b3a.36.2024.08.19.11.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 11:11:35 -0700 (PDT)
Date: Mon, 19 Aug 2024 11:11:33 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Jesse Taube <jesse@rivosinc.com>
Cc: linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor@kernel.org>, Evan Green <evan@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] RISC-V: hwprobe: Use BIT macro to avoid warnings
Message-ID: <ZsOK1bY7MrbYRKYs@ghost>
References: <20240819180443.1774641-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819180443.1774641-1-jesse@rivosinc.com>

On Mon, Aug 19, 2024 at 02:04:43PM -0400, Jesse Taube wrote:
> In uapi/asm/hwprobe.h file, (1 << N) is used to define the bit feild
"field" not "feild"
> this causes checkpatch to warn. Use BIT(N) and BIT_ULL(N) to avoid
The grammar is slightly odd here, I think replacing "this" with "which"
makes the sentence less awkward. 
> warnings.
> 
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> ---
>  arch/riscv/include/uapi/asm/hwprobe.h | 102 +++++++++++++-------------
>  1 file changed, 51 insertions(+), 51 deletions(-)
> 
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
> index b706c8e47b02..d0874ff2fd37 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -21,57 +21,57 @@ struct riscv_hwprobe {
>  #define RISCV_HWPROBE_KEY_MARCHID	1
>  #define RISCV_HWPROBE_KEY_MIMPID	2
>  #define RISCV_HWPROBE_KEY_BASE_BEHAVIOR	3
> -#define		RISCV_HWPROBE_BASE_BEHAVIOR_IMA	(1 << 0)
> +#define		RISCV_HWPROBE_BASE_BEHAVIOR_IMA	BIT_ULL(0)
>  #define RISCV_HWPROBE_KEY_IMA_EXT_0	4
> -#define		RISCV_HWPROBE_IMA_FD		(1 << 0)
> -#define		RISCV_HWPROBE_IMA_C		(1 << 1)
> -#define		RISCV_HWPROBE_IMA_V		(1 << 2)
> -#define		RISCV_HWPROBE_EXT_ZBA		(1 << 3)
> -#define		RISCV_HWPROBE_EXT_ZBB		(1 << 4)
> -#define		RISCV_HWPROBE_EXT_ZBS		(1 << 5)
> -#define		RISCV_HWPROBE_EXT_ZICBOZ	(1 << 6)
> -#define		RISCV_HWPROBE_EXT_ZBC		(1 << 7)
> -#define		RISCV_HWPROBE_EXT_ZBKB		(1 << 8)
> -#define		RISCV_HWPROBE_EXT_ZBKC		(1 << 9)
> -#define		RISCV_HWPROBE_EXT_ZBKX		(1 << 10)
> -#define		RISCV_HWPROBE_EXT_ZKND		(1 << 11)
> -#define		RISCV_HWPROBE_EXT_ZKNE		(1 << 12)
> -#define		RISCV_HWPROBE_EXT_ZKNH		(1 << 13)
> -#define		RISCV_HWPROBE_EXT_ZKSED		(1 << 14)
> -#define		RISCV_HWPROBE_EXT_ZKSH		(1 << 15)
> -#define		RISCV_HWPROBE_EXT_ZKT		(1 << 16)
> -#define		RISCV_HWPROBE_EXT_ZVBB		(1 << 17)
> -#define		RISCV_HWPROBE_EXT_ZVBC		(1 << 18)
> -#define		RISCV_HWPROBE_EXT_ZVKB		(1 << 19)
> -#define		RISCV_HWPROBE_EXT_ZVKG		(1 << 20)
> -#define		RISCV_HWPROBE_EXT_ZVKNED	(1 << 21)
> -#define		RISCV_HWPROBE_EXT_ZVKNHA	(1 << 22)
> -#define		RISCV_HWPROBE_EXT_ZVKNHB	(1 << 23)
> -#define		RISCV_HWPROBE_EXT_ZVKSED	(1 << 24)
> -#define		RISCV_HWPROBE_EXT_ZVKSH		(1 << 25)
> -#define		RISCV_HWPROBE_EXT_ZVKT		(1 << 26)
> -#define		RISCV_HWPROBE_EXT_ZFH		(1 << 27)
> -#define		RISCV_HWPROBE_EXT_ZFHMIN	(1 << 28)
> -#define		RISCV_HWPROBE_EXT_ZIHINTNTL	(1 << 29)
> -#define		RISCV_HWPROBE_EXT_ZVFH		(1 << 30)
> -#define		RISCV_HWPROBE_EXT_ZVFHMIN	(1ULL << 31)
> -#define		RISCV_HWPROBE_EXT_ZFA		(1ULL << 32)
> -#define		RISCV_HWPROBE_EXT_ZTSO		(1ULL << 33)
> -#define		RISCV_HWPROBE_EXT_ZACAS		(1ULL << 34)
> -#define		RISCV_HWPROBE_EXT_ZICOND	(1ULL << 35)
> -#define		RISCV_HWPROBE_EXT_ZIHINTPAUSE	(1ULL << 36)
> -#define		RISCV_HWPROBE_EXT_ZVE32X	(1ULL << 37)
> -#define		RISCV_HWPROBE_EXT_ZVE32F	(1ULL << 38)
> -#define		RISCV_HWPROBE_EXT_ZVE64X	(1ULL << 39)
> -#define		RISCV_HWPROBE_EXT_ZVE64F	(1ULL << 40)
> -#define		RISCV_HWPROBE_EXT_ZVE64D	(1ULL << 41)
> -#define		RISCV_HWPROBE_EXT_ZIMOP		(1ULL << 42)
> -#define		RISCV_HWPROBE_EXT_ZCA		(1ULL << 43)
> -#define		RISCV_HWPROBE_EXT_ZCB		(1ULL << 44)
> -#define		RISCV_HWPROBE_EXT_ZCD		(1ULL << 45)
> -#define		RISCV_HWPROBE_EXT_ZCF		(1ULL << 46)
> -#define		RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 47)
> -#define		RISCV_HWPROBE_EXT_ZAWRS		(1ULL << 48)
> +#define		RISCV_HWPROBE_IMA_FD		BIT_ULL(0)
> +#define		RISCV_HWPROBE_IMA_C		BIT_ULL(1)
> +#define		RISCV_HWPROBE_IMA_V		BIT_ULL(2)
> +#define		RISCV_HWPROBE_EXT_ZBA		BIT_ULL(3)
> +#define		RISCV_HWPROBE_EXT_ZBB		BIT_ULL(4)
> +#define		RISCV_HWPROBE_EXT_ZBS		BIT_ULL(5)
> +#define		RISCV_HWPROBE_EXT_ZICBOZ	BIT_ULL(6)
> +#define		RISCV_HWPROBE_EXT_ZBC		BIT_ULL(7)
> +#define		RISCV_HWPROBE_EXT_ZBKB		BIT_ULL(8)
> +#define		RISCV_HWPROBE_EXT_ZBKC		BIT_ULL(9)
> +#define		RISCV_HWPROBE_EXT_ZBKX		BIT_ULL(10)
> +#define		RISCV_HWPROBE_EXT_ZKND		BIT_ULL(11)
> +#define		RISCV_HWPROBE_EXT_ZKNE		BIT_ULL(12)
> +#define		RISCV_HWPROBE_EXT_ZKNH		BIT_ULL(13)
> +#define		RISCV_HWPROBE_EXT_ZKSED		BIT_ULL(14)
> +#define		RISCV_HWPROBE_EXT_ZKSH		BIT_ULL(15)
> +#define		RISCV_HWPROBE_EXT_ZKT		BIT_ULL(16)
> +#define		RISCV_HWPROBE_EXT_ZVBB		BIT_ULL(17)
> +#define		RISCV_HWPROBE_EXT_ZVBC		BIT_ULL(18)
> +#define		RISCV_HWPROBE_EXT_ZVKB		BIT_ULL(19)
> +#define		RISCV_HWPROBE_EXT_ZVKG		BIT_ULL(20)
> +#define		RISCV_HWPROBE_EXT_ZVKNED	BIT_ULL(21)
> +#define		RISCV_HWPROBE_EXT_ZVKNHA	BIT_ULL(22)
> +#define		RISCV_HWPROBE_EXT_ZVKNHB	BIT_ULL(23)
> +#define		RISCV_HWPROBE_EXT_ZVKSED	BIT_ULL(24)
> +#define		RISCV_HWPROBE_EXT_ZVKSH		BIT_ULL(25)
> +#define		RISCV_HWPROBE_EXT_ZVKT		BIT_ULL(26)
> +#define		RISCV_HWPROBE_EXT_ZFH		BIT_ULL(27)
> +#define		RISCV_HWPROBE_EXT_ZFHMIN	BIT_ULL(28)
> +#define		RISCV_HWPROBE_EXT_ZIHINTNTL	BIT_ULL(29)
> +#define		RISCV_HWPROBE_EXT_ZVFH		BIT_ULL(30)
> +#define		RISCV_HWPROBE_EXT_ZVFHMIN	BIT_ULL(31)
> +#define		RISCV_HWPROBE_EXT_ZFA		BIT_ULL(32)
> +#define		RISCV_HWPROBE_EXT_ZTSO		BIT_ULL(33)
> +#define		RISCV_HWPROBE_EXT_ZACAS		BIT_ULL(34)
> +#define		RISCV_HWPROBE_EXT_ZICOND	BIT_ULL(35)
> +#define		RISCV_HWPROBE_EXT_ZIHINTPAUSE	BIT_ULL(36)
> +#define		RISCV_HWPROBE_EXT_ZVE32X	BIT_ULL(37)
> +#define		RISCV_HWPROBE_EXT_ZVE32F	BIT_ULL(38)
> +#define		RISCV_HWPROBE_EXT_ZVE64X	BIT_ULL(39)
> +#define		RISCV_HWPROBE_EXT_ZVE64F	BIT_ULL(40)
> +#define		RISCV_HWPROBE_EXT_ZVE64D	BIT_ULL(41)
> +#define		RISCV_HWPROBE_EXT_ZIMOP		BIT_ULL(42)
> +#define		RISCV_HWPROBE_EXT_ZCA		BIT_ULL(43)
> +#define		RISCV_HWPROBE_EXT_ZCB		BIT_ULL(44)
> +#define		RISCV_HWPROBE_EXT_ZCD		BIT_ULL(45)
> +#define		RISCV_HWPROBE_EXT_ZCF		BIT_ULL(46)
> +#define		RISCV_HWPROBE_EXT_ZCMOP		BIT_ULL(47)
> +#define		RISCV_HWPROBE_EXT_ZAWRS		BIT_ULL(48)
>  #define RISCV_HWPROBE_KEY_CPUPERF_0	5
>  #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
>  #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
> @@ -85,6 +85,6 @@ struct riscv_hwprobe {
>  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>  
>  /* Flags */
> -#define RISCV_HWPROBE_WHICH_CPUS	(1 << 0)
> +#define RISCV_HWPROBE_WHICH_CPUS	BIT(0)
>  
>  #endif
> -- 
> 2.45.2
> 

Thanks for doing this. It will be nice to not get this checkpatch
warning anymore.

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>


