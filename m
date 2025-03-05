Return-Path: <linux-kernel+bounces-547833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 143DDA50E26
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 412211890ABA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD59626388B;
	Wed,  5 Mar 2025 21:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="QLRmIH4Z"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DEE262D15
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 21:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741211357; cv=none; b=FgWKNwLoQLyEjGPsSBafzRUeHJpG0zDzXVWJSKco3kbkQxF84e4UJeBYyP0oeR1sXw3NgheyzYcJHaoJsrcOM1axcNZbQK1VSa0RzZ3i6O0NIloDNR/XR7Rfd+swXx1Zi+4vRvaCnthZQzl3mhe+D4b238/s6YUXMvTRp9Q1yzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741211357; c=relaxed/simple;
	bh=EkMRTYZI41o9lStwnMlleZqWRQi6QzJ1U+G8jqGCdrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0fISeasID6z/FhosA9cYHdNHQlBLjgx/2DnERR45s49O0gfL8t1uNWhGHWuqvzytxPobMceAl+NC6iNa0tTYvKA01cIbVcoiYv/bL8rNhrGuAHSpvU+CIGQ6PT9HcSuSPXlY1ZVa5HSjpUSzPLbdP5yn2LEHw3pA84MQidk/PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=QLRmIH4Z; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2234e4b079cso136217365ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 13:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741211353; x=1741816153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kjoSc6E8cjM2Yo8eK5HFN8pI09NM2S8qt1nM/UlA0TU=;
        b=QLRmIH4ZyLWQJZ8hm6XZLv0qJLQEdiJTPx9Hq2QiLHxtHKnYkR3/SPXGrJMuyHnfD8
         CfprSDwYBHl/PkTQsJQPYzNWnZd3o7NkQTFPy2CL9CyPsZKR69QJzfrTkGOxSFtJRr2Z
         fjr1s7TkC2qID8oMeRsY6uXTmMd7pJVho1NttA040EfBbTrxHTIUO27b0HB75jZwolnr
         iaOFp4NZ4oTposwty3Lwa8QTW36UmsqFrUxupV9MH1H9aeuXhruV5y4TLiYSEAsK6ZSX
         JuRY5iHWcc6SP4l9bKnb1a3xWvmrywShXFj6QFf+lMDhf4v7+AchCGS1zKzl0o+34Vc3
         iXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741211353; x=1741816153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjoSc6E8cjM2Yo8eK5HFN8pI09NM2S8qt1nM/UlA0TU=;
        b=c0Ymg0HB0VizR9GvVud5+BzOlw/j3ExnGAb9teeRYVLf08U7l8a85Cq6C9qOQ28INH
         /PUHyy5r/174wAdRZKgLIiPv0k3cxY79WH7gj9nL+zq4VIkkr3o+NGHYQwACXkwqr5hl
         viy1U1YK7Mpc6WwScD2ChDG/C1X08xI3UK3XqV12v0eOuIjQ4pWjVsQuanfwE+oeAB6+
         4TuaWHmrih1AZkYniiIQM6gjKkpHpfaKsYsv6HsUecONzv09EQGvcCafhJ+1fJ1sCdtE
         z9LiGp6DU5ERYJiAFIffI2GQJQVVOKcrZBSWMl0Lfzz4LfT5X5pzYk56/6JTJd2+bu6L
         c3Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVYrVt0Tvn1tLYyMwETRWUqXJYm3LiTGc8VtyXbfc2a5OWaYBMblHPKxSKzbmJL0p96S0j62w1knJHpzNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKh2RanEwOET44UGue48r/GwPbbHsaBlqctvmRvtbZPn1Ax+Nr
	Vd0G/74TAhLDAb08AsbF92JSyUeAIUvVa9Bwg0n/SYsFvshQlosPxsloDttHFih5MR6OL+stZyi
	3
X-Gm-Gg: ASbGncvMuGO5nHhzgBe+ds2rXdhOP1oLFja+Qidg19B2V9YkLQOJt19UdBN5B0qCj5G
	3zy+ggid33dej3l4gX1ZtdCyvPC7XmXq2VKA19/WNHy9/1Dr24HoDrwqJyYsuzsjZlz4hq7h4hy
	7JQoWOkgAFcVS9NJzxq3QRQ4ytf9UagZcEvx4685vmLqVLsowphc0GwsIxXKtwP/SaqZDoePJrg
	MlrlyL1kVLDqHqTN7Myd+9PVkSHngOK7epdkZiGbc0y2rr/3stOjr4/msdgGBsBOWvXVeW85Ns2
	ePoqKvv9Q7LIk5E9rPoFeLr/7S6Rw9W8hfoOlqV0
X-Google-Smtp-Source: AGHT+IGiq/MXIy1PesAIjd/q+Uj1GRVM25G7HYgqYDLVTQNdRiqv0JEG2/8H91arLf8HKxgXjRaCBg==
X-Received: by 2002:a17:902:f693:b0:220:ca08:8986 with SMTP id d9443c01a7336-223f1cdae3dmr83408555ad.22.1741211353117;
        Wed, 05 Mar 2025 13:49:13 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:9b3c:3246:a388:fe44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501fa8fdsm117591535ad.76.2025.03.05.13.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 13:49:12 -0800 (PST)
Date: Wed, 5 Mar 2025 13:49:09 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Ignacio Encinas <ignacio@iencinas.com>
Cc: linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>, linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: riscv: fix v_exec_initval_nolibc.c
Message-ID: <Z8jG1ViOUbw79cEN@ghost>
References: <20250305-fix-v_exec_initval_nolibc-v1-1-b87b60e43002@iencinas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305-fix-v_exec_initval_nolibc-v1-1-b87b60e43002@iencinas.com>

On Wed, Mar 05, 2025 at 05:39:28PM +0100, Ignacio Encinas wrote:
> Vector registers are zero initialized by the kernel. Stop accepting
> "all ones" as a clean value.
> 
> Note that this was not working as expected given that
> 	value == 0xff
> can be assumed to be always false by the compiler as value's range is
> [-128, 127]. Both GCC (-Wtype-limits) and clang
> (-Wtautological-constant-out-of-range-compare) warn about this.

This check was included because the "dirty" value is an implementation
detail that I believe is not strongly defined in the ABI. Since linux
does always set this value to zero (currently) we can safely remove this
check. 

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>

> 
> Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>
> ---
> I tried looking why "all ones" was previously deemed a "clean" value but
> couldn't find any information. It looks like the kernel always 
> zero-initializes the vector registers.
> 
> If "all ones" is still acceptable for any reason, my intention is to 
> spin a v2 changing the types of `value` and `prev_value` to unsigned 
> char.
> ---
>  tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c b/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c
> index 35c0812e32de0c82a54f84bd52c4272507121e35..b712c4d258a6cb045aa96de4a75299714866f5e6 100644
> --- a/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c
> +++ b/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c
> @@ -6,7 +6,7 @@
>   * the values. To further ensure consistency, this file is compiled without
>   * libc and without auto-vectorization.
>   *
> - * To be "clean" all values must be either all ones or all zeroes.
> + * To be "clean" all values must be all zeroes.
>   */
>  
>  #define __stringify_1(x...)	#x
> @@ -46,7 +46,7 @@ int main(int argc, char **argv)
>  			: "=r" (value));					\
>  		if (first) {							\
>  			first = 0;						\
> -		} else if (value != prev_value || !(value == 0x00 || value == 0xff)) { \
> +		} else if (value != prev_value || value != 0x00) {              \
>  			printf("Register " __stringify(register)		\
>  				" values not clean! value: %u\n", value);	\
>  			exit(-1);						\
> 
> ---
> base-commit: 03d38806a902b36bf364cae8de6f1183c0a35a67
> change-id: 20250301-fix-v_exec_initval_nolibc-498d976c372d
> 
> Best regards,
> -- 
> Ignacio Encinas <ignacio@iencinas.com>
> 

