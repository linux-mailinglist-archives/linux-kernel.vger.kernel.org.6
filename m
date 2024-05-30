Return-Path: <linux-kernel+bounces-195620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D638D4F63
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 17:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53EF11C23003
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 15:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC48F208A7;
	Thu, 30 May 2024 15:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="WVdSqWHi"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C389E1CD2C
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717084100; cv=none; b=HUmPeZlsq4zHfeULX/jYlNGUqbMranoU/OhGpuSR8lLsBTrZvEF0YzS1f7HcsDHmmNctWaqzKEIyLm0IUVE8qBpuGTQHFNXk3xPvUze36LUNxU4ZZaoGFQro41NDLKlC7YXiuYOG4tzmAq6MrCnuvi2duMqF0ihdGBWZ9HgTf1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717084100; c=relaxed/simple;
	bh=uiGOFfneORywVqa7KwbGbVLdPn3xrlFWKiXYGWlSZWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjLd/PD4OHnts54mVpiszM58VUCPkTdhvyakzaVl7bp0KWebP+F5MY91Nk1Z9ImI0xHVcxzKBYKgoPeTOaMzUL5zOQ5IPnoyOHk0GDfcqLlzlwoxE3nvoaGBms9wp6yn/+Gok16z3MNfzwed1ymygE0dPhJRljt9S3PtW8C4iEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=WVdSqWHi; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f48e9414e9so10205065ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 08:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717084097; x=1717688897; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z2/9YXup/8RbMNmyLIVK+PNdaz2WPXgvrHbc/uuCS+s=;
        b=WVdSqWHiu5sKaDLWZCxaBXUV31ZBsthCdZZZutKEkDcX0e61rFlvsCJTLb3B04m05m
         dAIH+HyiM647olGbM+CDjUCzUmEg/4RI2zyqBxMj+yoqLTxMhXWbYt9bSf7YKAAtZ/8q
         1HO5hyaXQilQrcmuveR7lGVHRGN20WpXFNlyoFsjJE0heqSPm1sB+d54c6GmwhKAIfk2
         G3SHZNVzMW9nmYz1Ah4ZfpOylk9AsCrkiceqrqohFTErQ2RHMvO3JQ445W7+8jY/szIZ
         b0c3UV0yO7SK/xyD6NBOgb7iuVJC+7Dd4XPGCQsEnGfkEDIUwASlnGrfRigBExCYzm70
         PKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717084097; x=1717688897;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z2/9YXup/8RbMNmyLIVK+PNdaz2WPXgvrHbc/uuCS+s=;
        b=U7NsMH1FIucKPkX/7VnpnVvIF2MDDoLJ5bYsvs9NaeHvKM9POiRJq1yprVwchzJyJm
         eJchgAE11fVdwfWbDJOjQtOSBZzUibw4nJ2/z7rNw0jRU6NDFewIk3gl+8m78pfbvVEk
         0RobD8z/OwuRkkgkZ5qzpOG1rVgEo1qrtk6ezepTFDh81B05lr5Kjt0eclQcMAuWJeKD
         F+OSbf4+LdWL/CBx4N68tCOr/AI+y1UsKrujN83/DQvadhRu0YXr8irfTK5eUXHIeGY9
         usGs3KKVVmWJo9pI7OAn0gD1yywmkYRze8xcT3tSlDBF7N6aVRs3+1uxR0k4P8tVjcix
         89NA==
X-Forwarded-Encrypted: i=1; AJvYcCWsMnqF3GqIceUB9lsE4y4eW+rLdKQvbvQFUoH2zqsumyE7Dz9iFbCHm4EefhvqRR/7Dc8tPJE9SgkP4ATkytoiEjy/9lPHDuFCYkvg
X-Gm-Message-State: AOJu0YxbikJQk+lVQkdsbYUkvEqTFUUemxvJZ0IcqXRooJpjy5l8Ikgl
	GqZYtWloKmjgDbCYT4BXGy9G3bQbBAAeJGoMsCPcH15xTIOP4htsn4snW426YQQ=
X-Google-Smtp-Source: AGHT+IFEoPjpm6Eoux4dPoJuolosadGpX2I41dVnCKtavoFPe5puywtXMZkqH8FzHI7me3wq7SDgqA==
X-Received: by 2002:a17:902:db09:b0:1f4:9468:38b6 with SMTP id d9443c01a7336-1f61c1ba67dmr29549475ad.34.1717084096975;
        Thu, 30 May 2024 08:48:16 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f4d6fe4775sm49803095ad.257.2024.05.30.08.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 08:48:16 -0700 (PDT)
Date: Thu, 30 May 2024 08:48:13 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>, Shuah Khan <shuah@kernel.org>,
	Atish Patra <atishp@atishpatra.org>, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 13/16] riscv: add ISA extension parsing for Zcmop
Message-ID: <ZlifvXUiHeNnEJqq@ghost>
References: <20240517145302.971019-1-cleger@rivosinc.com>
 <20240517145302.971019-14-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240517145302.971019-14-cleger@rivosinc.com>

On Fri, May 17, 2024 at 04:52:53PM +0200, Clément Léger wrote:
> Add parsing for Zcmop ISA extension which was ratified in commit
> b854a709c00 ("Zcmop is ratified/1.0") of the riscv-isa-manual.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---
>  arch/riscv/include/asm/hwcap.h | 1 +
>  arch/riscv/kernel/cpufeature.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index a5836fa6b998..aaaf23f204ac 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -85,6 +85,7 @@
>  #define RISCV_ISA_EXT_ZCB		76
>  #define RISCV_ISA_EXT_ZCD		77
>  #define RISCV_ISA_EXT_ZCF		78
> +#define RISCV_ISA_EXT_ZCMOP		79
>  
>  #define RISCV_ISA_EXT_XLINUXENVCFG	127
>  
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 3bb2ef52a38b..0a40fa1faa04 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -290,6 +290,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>  	__RISCV_ISA_EXT_DATA_VALIDATE(zcb, RISCV_ISA_EXT_ZCB, riscv_ext_zca_depends),
>  	__RISCV_ISA_EXT_DATA_VALIDATE(zcd, RISCV_ISA_EXT_ZCD, riscv_ext_zcd_validate),
>  	__RISCV_ISA_EXT_DATA_VALIDATE(zcf, RISCV_ISA_EXT_ZCF, riscv_ext_zcf_validate),
> +	__RISCV_ISA_EXT_DATA_VALIDATE(zcmop, RISCV_ISA_EXT_ZCMOP, riscv_ext_zca_depends),
>  	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
>  	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
>  	__RISCV_ISA_EXT_DATA(zbc, RISCV_ISA_EXT_ZBC),
> -- 
> 2.43.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>


