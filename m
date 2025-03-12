Return-Path: <linux-kernel+bounces-558603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63780A5E87E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 00:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3855F7A464B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883C11F12ED;
	Wed, 12 Mar 2025 23:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCKF23Rb"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BBB1D79B6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 23:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741822690; cv=none; b=YYLjyYyWYFVOZJCar2rL8UaMc7OuR/hOJXi3EM2V5GfeoLbQga04/mBImet4upkclZ47BtvnFS+762AmQUg8tuzdops5BNSRWbiKgTtlF9t1WUu4nQAi6GiX2vdqExeqJGYyytB9gD0UV6ESYr5Vnx1dmvADK+sOzfHRsyXiBNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741822690; c=relaxed/simple;
	bh=vN3VEd66BFpxzGPu+gzWhrvDg3yMVNnbOuWzXhos1NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDj3jjn65rDwIgVXKhCLjvKCH3oUxCMjsBh3XystrhgvI3tkKGY8J6rPStsbPg6VtNpGIXxlLrWDc4QGG4HjsN4JF+2E9fyxnpJxKzREFtqsAYQdaE2uSMYTeLWMC7fD9Jx8U0cM6Ecc4s+twztdA6vxnmOsCtmOXa/8Q3SKbQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCKF23Rb; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22337bc9ac3so6722135ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741822688; x=1742427488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Iv9X1O+iJ055EOoqMTSQh8pZkA9omS3qAlLfPhpnypc=;
        b=lCKF23Rb0fxbzgp+zMdvn2rmKoe8osoDfGaJB7hesDyXw3rVkkHlyNKQj7LjDCna7U
         NUEyGopZBG/wHANDngdY8BK25IL62aDh5llt2FDEOi8hlbPAw2KIWhUrwySDIMnrix2K
         aIbuNxr98wKM0n1qd0JCXD/quror/mYXnBFdqf1HxTIY5imphwC24koT4RBypti03xjb
         pIzbJQIOewkoJ26bkuzCXvsxqK90wxcfXcwh+hkL6m5X2TZ7CtJk8Nr3i0j8SGU3N08E
         x1awBMisZXCNXDBtzYZwsrodw8WtOJXd1Q9PlLoxaRh0HYFoTrvXI0pzCff4Rn6WU1XP
         5R9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741822688; x=1742427488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iv9X1O+iJ055EOoqMTSQh8pZkA9omS3qAlLfPhpnypc=;
        b=WwEdDPxEBw49gbzAq85+hgdE+1MkQokLcB1w3jPDLM+HIL/uwh2oFurOeOYSwHr2c6
         t9sJ9eSh3yfPhQkzZTxWqw7xs3LjkM/n4MCW1f8RRR+pyredBkw1Fbm+LDO7wBK/Qo7r
         Xz8Qrbp6g4BjJCqZHIvE+bNd/HQI3kaecgQcJs+64v0BxDKaB+q/p4/l16WKvFvBIumj
         Ofnr7FbdP4kJfarRhadjE8ohznyRJlmu9kcIovplwNN6hYizIzMfEvwKQZxWU3T5mBXl
         +YBtqno0ZSadyre2uRR6+RrpNi4UidZKg8zj6Uk+WRpKTK+ABMwbwssB4yFrqcja4kKl
         jjlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHrqWIr5gynwILAWqqTFJnAFzqXCHmMxvKKdWZO7Oqj0MyxyrSVeMWy0hg4e2l85EFe+f1Vj3OjvHVrwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD7t2MWqRb+zUvIkMVlgKl6YEQEzl0m4X6VVVzOTkQvHiyPo30
	nOvIseNmrZiCALw/wj1ckD8lhegixOFPSyOQBl2wNOnanZr2jsth
X-Gm-Gg: ASbGncuGvak3J3cfz7FdjulyY88MHvcwbzV5FWC/LCzjAGXWZz6ZTiDP+UfPZgPb1Uo
	RwmzbRRMS0bwB5sjSEmxxmoH/JI2hJqWupE91eV4w6yxKYZWVjVw2CWGhEiCJi0bPJU+nx7wFdg
	KFNR/SuxfSX/K6u2xLQExSCg52K2EKuzLPGEa/aBki1JRz+CWqhX/2WtqtB41XBL64DcsWRiB55
	75O/qQ1dnaOe2yrjHPLNxoCnSTgHj2Tfy7j8XvOUjluk57W/ta95IRAGeq5D8/oAUlUvzR3Vdcj
	T31HO9qav9aglNwQBwextXjoebQ0Lex9Vm7dJneLi9oC
X-Google-Smtp-Source: AGHT+IG5xBWHcUI1ZiPr4lIPXq2LhR2k/iVfRjmn8GAY/lSsqcezJg1grQWMvGOFPF2cHAToz5e+tw==
X-Received: by 2002:a17:902:f54f:b0:223:58ff:c722 with SMTP id d9443c01a7336-22592e44a1fmr156857395ad.28.1741822687725;
        Wed, 12 Mar 2025 16:38:07 -0700 (PDT)
Received: from localhost ([216.228.125.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68883d0sm1323525ad.10.2025.03.12.16.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 16:38:06 -0700 (PDT)
Date: Wed, 12 Mar 2025 19:38:04 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Ignacio Encinas <ignacio@iencinas.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: fix test_and_{set,clear}_bit ordering
 documentation
Message-ID: <Z9Ia3AMqFpNj6fUb@thinkpad>
References: <20250311-riscv-fix-test-and-set-bit-comment-v1-1-8d2598e1e43b@iencinas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311-riscv-fix-test-and-set-bit-comment-v1-1-8d2598e1e43b@iencinas.com>

On Tue, Mar 11, 2025 at 06:20:22PM +0100, Ignacio Encinas wrote:
> test_and_{set,clear}_bit are fully ordered as specified in
> Documentation/atomic_bitops.txt. Fix incorrect comment stating otherwise.
> 
> Note that the implementation is correct since commit
> 9347ce54cd69 ("RISC-V: __test_and_op_bit_ord should be strongly ordered")
> was introduced.
> 
> Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>

Applied in bitmap-for-next.

Thanks,
Yury

> ---
> This seems to be a leftover comment from the initial implementation
> which assumed these operations were relaxed.
> 
> Documentation/atomic_bitops.txt states:
> 
>   [...]
>   RMW atomic operations with return value:
>   
>     test_and_{set,clear,change}_bit()
>     test_and_set_bit_lock()
>   [...]
> 
>    - RMW operations that have a return value are fully ordered.
> 
> Similar comments can be found in
> include/asm-generic/bitops/instrumented-atomic.h,
> include/linux/atomic/atomic-long.h, etc...
> ---
>  arch/riscv/include/asm/bitops.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
> index c6bd3d8354a96b4e7bbef0e98a201da412301b57..49a0f48d93df5be4d38fe25b437378467e4ca433 100644
> --- a/arch/riscv/include/asm/bitops.h
> +++ b/arch/riscv/include/asm/bitops.h
> @@ -226,7 +226,7 @@ static __always_inline int variable_fls(unsigned int x)
>   * @nr: Bit to set
>   * @addr: Address to count from
>   *
> - * This operation may be reordered on other architectures than x86.
> + * This is an atomic fully-ordered operation (implied full memory barrier).
>   */
>  static __always_inline int arch_test_and_set_bit(int nr, volatile unsigned long *addr)
>  {
> @@ -238,7 +238,7 @@ static __always_inline int arch_test_and_set_bit(int nr, volatile unsigned long
>   * @nr: Bit to clear
>   * @addr: Address to count from
>   *
> - * This operation can be reordered on other architectures other than x86.
> + * This is an atomic fully-ordered operation (implied full memory barrier).
>   */
>  static __always_inline int arch_test_and_clear_bit(int nr, volatile unsigned long *addr)
>  {
> 
> ---
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> change-id: 20250311-riscv-fix-test-and-set-bit-comment-aa9081a27d61
> 
> Best regards,
> -- 
> Ignacio Encinas <ignacio@iencinas.com>

