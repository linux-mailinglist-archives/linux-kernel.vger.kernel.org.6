Return-Path: <linux-kernel+bounces-204926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51ADD8FF514
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 21:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A852428B021
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 19:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8F0502BE;
	Thu,  6 Jun 2024 19:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="dJ7a7QlR"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07854F5FB
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 18:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717700400; cv=none; b=nIkbrF2Jh2n5eu3HKg/K9I31XdF+XDD/1pBYmHey1cryjjA7yrY7iZTZb7oIKEEPC8KgFHOqDNo4ve3LTLNgkYBfbpL7TZxmJZU2jaQsQXjIy2OHPaxHaSNntSqyAomjg4qf5AYV3pZa7hyOLzmS2AhE+IcsPzifns7MlH5qK0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717700400; c=relaxed/simple;
	bh=vOQgcwA5EHsaRJO3NwWJpj4GwTvo04V3/aZpmhG42OY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDyX0GPglKo88go3tcdY7UsFSkJxgZ+TMGdys41y/Yfb6yD04YVNZF67lhZTGe7qT+j/UQUZEzXYQQjhqKKXqqJob+EqeJ5jK6FQp9yDpDYnil6MkiDSm7m+MHmCRRaKlna4biacnYWCG3eo+NHfLrsXy6nW2B1hBcdy1YJf9Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=dJ7a7QlR; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-6819d785528so903574a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 11:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717700398; x=1718305198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ia5T96X7Cdh71B4P1DUGWX14XzgXv8MDLAXPXG9Rctk=;
        b=dJ7a7QlRZd/xMmlY8U243UWgSUVFsmfEPihG2B1ZaXTb8V94WM1AUCPtWQL8dMMoUK
         UDkyBr5jV1OQJiSwbC1xPqcv2KDFmzKZba77tiTgvBkvUoJqi7EzmfWvw6tbb4ZxDb7D
         7ookvAVvU0556BQQT0F/1iXPc0klrUrVBe8ODfssGpwaxDKhy0jybnu4Oxfi7BcARl45
         HKS4vITHEJPaeERcAGzhPy1BZ31SMfK4Ilh9Z+4dwZ4J+3P8Ix7roVKpz3mqNvENOCnp
         mC46oLVRM3im9vsULuUIYwaF1c3LdGylBXHPbjYWeVFM5Q8QqRJhBkn08I6dd4o2GujL
         1FkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717700398; x=1718305198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ia5T96X7Cdh71B4P1DUGWX14XzgXv8MDLAXPXG9Rctk=;
        b=ZD0FKwjt3o0zSx4f3zlzUfzfW4ZmdkzlrP2xJLikoWPEJcB6mlkKB2yYuMXNMF6Qbf
         u4vS/ysngl6JXYwpbJndh4YjDPJd9vo1KUtV1FXzjX4CbyEGuXAifsSuhUMnGk2c3Wo7
         RNUKYLoiJ27N4BNNIVtFnf1vV4luDsX/C7uKQeSnQQLoLLen1jQbkQBB9cR62MonmB9h
         3uHxC5VDSTgT4rHT3hRq0KX9FfsreWk9Wb9qNCxaij6o0p6dsDgEedu/T2Uxd36yGVZk
         1NQUBui9X+jX0PpW3F8gF4lsTAFP6sWLERiJ1xoWvLyT2/d1OZacVdna4hvIpUlppBwq
         jtLA==
X-Forwarded-Encrypted: i=1; AJvYcCX4nKUFL/zc9JcNyhQ9dyOKH5qUVfbgWtZEyUpjMS69xc8oSf4CLBuOHnio8de+1mtmo9GJLATi7WBtWnsOF0q2lEHfUnB3YRTeNr+v
X-Gm-Message-State: AOJu0Yx/lnN3q2jRH59xpVE9bWalq4fi1hmxg9PhySmls1cqwm1J+GYa
	5zLZtgUXMp5mI3yKnoqfS5wNbke4aEiNziiVG6AI3VV01KKvFuhAcWQmH5mm08s=
X-Google-Smtp-Source: AGHT+IG0mTorn4UEEtaw8tMjG5VLaVYsSBfByfTDWyjZz8MAIW4igAg5dCtNVB+4OhFZ69AIpdCMtw==
X-Received: by 2002:a17:902:e847:b0:1f6:782e:da23 with SMTP id d9443c01a7336-1f6d039d1efmr5796465ad.63.1717700398198;
        Thu, 06 Jun 2024 11:59:58 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7e578asm19058455ad.232.2024.06.06.11.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 11:59:57 -0700 (PDT)
Date: Thu, 6 Jun 2024 11:59:55 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Jesse Taube <jesse@rivosinc.com>
Cc: linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Nam Cao <namcaov@gmail.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Andy Chiu <andy.chiu@sifive.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: fix vector insn load/store width mask
Message-ID: <ZmIHKwhEyuQJnymK@ghost>
References: <20240606182800.415831-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606182800.415831-1-jesse@rivosinc.com>

On Thu, Jun 06, 2024 at 02:28:00PM -0400, Jesse Taube wrote:
> RVFDQ_FL_FS_WIDTH_MASK should be 3 bits [14-12], shifted down by 12 bits.
> Replace GENMASK(3, 0) with GENMASK(2, 0).
> 
> Fixes: cd054837243b ("riscv: Allocate user's vector context in the first-use trap")
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> ---
>  arch/riscv/include/asm/insn.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.h
> index 06e439eeef9a..09fde95a5e8f 100644
> --- a/arch/riscv/include/asm/insn.h
> +++ b/arch/riscv/include/asm/insn.h
> @@ -145,7 +145,7 @@
>  
>  /* parts of opcode for RVF, RVD and RVQ */
>  #define RVFDQ_FL_FS_WIDTH_OFF	12
> -#define RVFDQ_FL_FS_WIDTH_MASK	GENMASK(3, 0)
> +#define RVFDQ_FL_FS_WIDTH_MASK	GENMASK(2, 0)
>  #define RVFDQ_FL_FS_WIDTH_W	2
>  #define RVFDQ_FL_FS_WIDTH_D	3
>  #define RVFDQ_LS_FS_WIDTH_Q	4
> -- 
> 2.43.0
> 

Thanks!

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>


