Return-Path: <linux-kernel+bounces-434012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C68729E6022
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 22:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30F0166B60
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 21:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460A81C07C8;
	Thu,  5 Dec 2024 21:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="iWc+FMhK"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907AF192D8B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 21:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733434265; cv=none; b=Ab5d4NF4xBTbWCPIkq27mxUboSEEA2+CVnvFZPJFDW4Zwn/5QuClDPW8PB4Uiq3qz/rZ8+gS0lgzEQJA8e1jBkC51y2GpEiIo3uFTr4oA0Y+dyoc+Ilh4okRra1PWb1oSbFoqdFP1a8QZSU9A4urXyFaXZKv8XexqqWGw5Cxhj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733434265; c=relaxed/simple;
	bh=hD2+1vy6RYUSGnMZ0ttXTvGPWWJm2B1GfGDmqcwKzrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKuWF3DyLyihRPEy/aY5MJANpmSDch+6D/e1rlvGnYFEgNdJmBR7bGG91eE5zSLVuhs4BvOrfm+I4m8Q0tBXrRqcp5BuGCArYmWzRIxG+g+PfHXrWkSTE8C69iA6MkTwTJv1TnJ5YQqAfnmYpcj1GJJ7goH/whH2AgTU/VbCxwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=iWc+FMhK; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-724ffe64923so1633157b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 13:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733434262; x=1734039062; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=swrB1X9v62XhnQOwomPfhFuZeA3/Dy25MIYnjNAQ9Aw=;
        b=iWc+FMhK1Fp/UVnkXHVvSw7/XPzUUyOvovm1qWMPTCSjNFUfqn2oC3Vhy4I8LGx2hQ
         zoOmVYnwG1Xya9ZjHC71h43vf0W1OOcmvlz2Pj00ipS9p3s/1U2yOUBjwfHiBHzFadoq
         j/YCCkCeq2cSZ+9SHn5D1ZOkNN3Y3Ip38f0DR3OfokW2i8w3pBA69CC1FksMhSJvP28O
         5tz2pKaetiQ1j5fX1XmSTiVRLcSKSsI/7e6VHtCgLi/ZGNN8vSrzpwjYk0Jx9iBmjsRU
         1WQmUwgOEZjhOg478fCdD47f8Nu+HtUtr9NQpovnmiz4/6YuFAFnoIQIU0yAcPYtPCrX
         NugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733434262; x=1734039062;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=swrB1X9v62XhnQOwomPfhFuZeA3/Dy25MIYnjNAQ9Aw=;
        b=Od//nHcGWMIAqq5A8FoU1QbcjNVkUCa6882nj6MLLpbkeLvtup45xsLE272IAO4rLi
         Zcjw37Y0Cobobh1erfkbRcKdzo/2HJR1YWQDcOKNnQqCcrX7h2QukR7TFKnxd+kDtKnV
         IfnLKD60wRiTYGdlWXNKDDMr8s+cCowAtrUbGNc7LdEm2XkA3eWk9ktBf3CMvYQf7Qyi
         qNw7tnxu+GdFErImjW+tW04dOYT2VhkJLkVHrw7sJJpLPwvFR4ZAFOOxdzrq7REsTVIE
         b56qcnAsPvs2IcZ5Ihrp11V6LE3cidEQZ5Ax/jI6lX7TYHoJwEKHdIgMQPBNWgWMHw9u
         NTZg==
X-Forwarded-Encrypted: i=1; AJvYcCVk/LMlmKcrbBttw+Z3bndkZ38SbzMNg0X5rLN+HkJW5dI9XfWKmV6a8KoaFOTupe2cWtrFozgefa2kSCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkChWaF/01c8I3NaLokybY/ze9OTIzyqzgEiAlreynSR8feM2c
	EhokMF6JCoWzxv07o1QzcVacIlt0fBQulBeQyOJNQE3UuTTh4dvruvpYZ9AnRo4=
X-Gm-Gg: ASbGncsIdXVk6V7wGFYcW97OlguCNwPG2j0rTC9kV9dQUIEP3MqFRt3679rjV16s9FX
	AZ7UlLZ/APuBWG5SrT6GICfdIVPbhsXknThrlMbFHTDQ0EzqFbHdZ2Sf82KsikcHcADDN9NdxMj
	yirWsbPEIlF0y+touS8MR+yhVzz8h0CmGX9EhH10iDrTz1YM7jdhYmMv0lnV27GZucdtXDXyGGV
	IMfDR2rh1FhQMJL++5+1mgGnhfD+b/8BKsHB9Gpnme2
X-Google-Smtp-Source: AGHT+IFL9KJFSFdqWEJ5S3rFfqk+7jTG8B4QqZ1/8txfPBPRJMuKSjeQj3xp8kqjhhl1CQpulA+rfw==
X-Received: by 2002:a05:6a00:2196:b0:714:15ff:a2a4 with SMTP id d2e1a72fcca58-725b8156675mr1310656b3a.13.1733434261665;
        Thu, 05 Dec 2024 13:31:01 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:643d:2bb:e7d1:adbd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a29e8fa7sm1748633b3a.67.2024.12.05.13.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 13:31:01 -0800 (PST)
Date: Thu, 5 Dec 2024 13:30:59 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Shuah Khan <shuah@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v2] riscv: selftests: Fix warnings pointer masking test
Message-ID: <Z1Ibk8izrtPAywoU@ghost>
References: <20241204-fix_warnings_pointer_masking_tests-v2-1-1bf0c5095f58@rivosinc.com>
 <20241205-45c00adab2636bf26ce05f70@orel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241205-45c00adab2636bf26ce05f70@orel>

On Thu, Dec 05, 2024 at 09:04:12AM +0100, Andrew Jones wrote:
> On Wed, Dec 04, 2024 at 06:57:10PM -0800, Charlie Jenkins wrote:
> > When compiling the pointer masking tests with -Wall this warning
> > is present:
> > 
> > pointer_masking.c: In function ‘test_tagged_addr_abi_sysctl’:
> > pointer_masking.c:203:9: warning: ignoring return value of ‘pwrite’
> > declared with attribute ‘warn_unused_result’ [-Wunused-result]
> >   203 |         pwrite(fd, &value, 1, 0); |
> >       ^~~~~~~~~~~~~~~~~~~~~~~~ pointer_masking.c:208:9: warning:
> > ignoring return value of ‘pwrite’ declared with attribute
> > ‘warn_unused_result’ [-Wunused-result]
> >   208 |         pwrite(fd, &value, 1, 0);
> > 
> > I came across this on riscv64-linux-gnu-gcc (Ubuntu
> > 11.4.0-1ubuntu1~22.04).
> > 
> > Fix this by checking that the number of bytes written equal the expected
> > number of bytes written.
> > 
> > Fixes: 7470b5afd150 ("riscv: selftests: Add a pointer masking test")
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> > Changes in v2:
> > - I had ret != 2 for testing, I changed it to be ret != 1.
> > - Link to v1: https://lore.kernel.org/r/20241204-fix_warnings_pointer_masking_tests-v1-1-ea1e9665ce7a@rivosinc.com
> > ---
> >  tools/testing/selftests/riscv/abi/pointer_masking.c | 19 +++++++++++++++----
> >  1 file changed, 15 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/riscv/abi/pointer_masking.c b/tools/testing/selftests/riscv/abi/pointer_masking.c
> > index dee41b7ee3e3..229d85ccff50 100644
> > --- a/tools/testing/selftests/riscv/abi/pointer_masking.c
> > +++ b/tools/testing/selftests/riscv/abi/pointer_masking.c
> > @@ -189,6 +189,7 @@ static void test_tagged_addr_abi_sysctl(void)
> >  {
> >  	char value;
> >  	int fd;
> > +	int ret;
> >  
> >  	ksft_print_msg("Testing tagged address ABI sysctl\n");
> >  
> > @@ -200,14 +201,24 @@ static void test_tagged_addr_abi_sysctl(void)
> >  	}
> >  
> >  	value = '1';
> > -	pwrite(fd, &value, 1, 0);
> > +	ret = pwrite(fd, &value, 1, 0);
> > +	if (ret != 1) {
> > +		ksft_test_result_fail("Write to /proc/sys/abi/tagged_addr_disabled failed.\n");
> > +		return;
> > +	}
> > +
> >  	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == -EINVAL,
> >  			 "sysctl disabled\n");
> >  
> >  	value = '0';
> > -	pwrite(fd, &value, 1, 0);
> > -	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == 0,
> > -			 "sysctl enabled\n");
> > +	ret = pwrite(fd, &value, 1, 0);
> > +	if (ret != 1) {
> > +		ksft_test_result_fail("Write to /proc/sys/abi/tagged_addr_disabled failed.\n");
> > +		return;
> > +	}
> 
> Could make a wrapper function for pwrite() to avoid duplicating the ret
> value check.

I'll change it to a goto statement to avoid duplicating the
ksft_test_result_fail call.

> 
> > +
> > +	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == -EINVAL,
> > +			 "sysctl disabled\n");
> 
> Why is this changed from expecting 0 for the return and being the
> "sysctrl enabled" test? We still write '0' to tagged_addr_disabled here.

Silly copy mistake, thank you!

> 
> >  
> >  	set_tagged_addr_ctrl(0, false);
> >  
> > 
> > ---
> > base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> > change-id: 20241204-fix_warnings_pointer_masking_tests-3860e4f35429
> > -- 
> > - Charlie
> >
> 
> Not part of this patch, but now that I looked at
> test_tagged_addr_abi_sysctl() I see that
> ksft_test_result_skip() is duplicated.

Oh huh I hadn't noticed that. I'll send a patch for that I guess, easy
fix.

- Charlie

> 
> Thanks,
> drew
> 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

