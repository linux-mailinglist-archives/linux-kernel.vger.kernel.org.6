Return-Path: <linux-kernel+bounces-434698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 208559E69E3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DCBC1883DCC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7852E1DFDAE;
	Fri,  6 Dec 2024 09:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Nqxj1jIs"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A027F1CD219
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 09:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733476522; cv=none; b=akcKMBiv7C+oU5xnQmBB6hJt+QmFyCs16IDTXMcYusvG27hBUfy+3a3k3BmOIv0VWuX+kgLzGSDkTHmPWXsxyuN9sBylQ4rUTiUXIRvkM0upn/4vdv+ilSOaXaGaqXj73ZJacVqxLbZqqQosDwSVq+5fBuIXTNAns4i4jVcUa0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733476522; c=relaxed/simple;
	bh=RrqHduFztXI6fuif9Bgtzy4NkPFE/d96UM4y21IBc68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrWJAclhMdK9GGglFwmoDYxgZmGnrNOod+OXdMPtrzKtH/IZtjio13I/sUre83EiGquBGcn/0F8WnoikE6FofrM5C1bBi7VarkJvigK10+tGnA6dNvvfO5c4LKFzFALjLOnA1usf8wn7iGiPoYSEGwXAD+NQnD7oCOfwHXQ9wFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Nqxj1jIs; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa549d9dffdso264217166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 01:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1733476519; x=1734081319; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Au0c93U93rO97NhYFvNIJEuWkXGIUe8cMu7IX3WeSgo=;
        b=Nqxj1jIsMMapPlHMQiLh7Hash3G7y/iWoSzeYt04IV42fw47ayGJ3emTbEvPjkTlFe
         mP8sy9/5g2eS8epp0DhEwGlBYhMDGSIj6QKsA3HE+gzUXlSWhC8IMPrcF6B8foRYgM4O
         00EZ2yM/TNI/RoohseuZxG0430zYowv4iG5SOlTL14iUwHBPi0SDQVvoG4AX05e2lBuG
         vsWxcZl1uss1uaV0pfOPYNp2vEwKOyTcN8jXYLo1auZURvwqkf1DuUh1a3UOz7j90rzC
         iw3Dkn7PHcBzsi6pJcD309PxkO+FlK5hNiHL/sbf1da0AuB5CisBzhj7LfJ308Up8MfI
         orRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733476519; x=1734081319;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Au0c93U93rO97NhYFvNIJEuWkXGIUe8cMu7IX3WeSgo=;
        b=DK6XgEnSv6PAVgR8xtFzmK+PLMXhV86jC6TK6DQwHu0TnAAXsL9GMd6fXGVl4oUL9M
         kMgTefJm4y0a7TCi93MnWLXtF1fIvHVMNRf+RFYTiFItuorjb0v/FKRlzFxcSUKcYjXO
         XcPmiomyQuSGygqmQDdIm307Td+R4f0XPO9gdoFaJnLYtsyF4wBbd3R+9wMDQ6jjvOSA
         PFsR1SsKDM+9vED1kqxtHb8+iwdlSnwMnyxZer8dNyUr3tqOOjumU0bJ2SroGFJiaGDB
         zf7WWxxvMM34tCcrPMpVNseRriZ/8MDLHqnjoF/IkcQzIozrpJMdC53gShwd9bIAp1oL
         c28w==
X-Forwarded-Encrypted: i=1; AJvYcCVuHhvNGZeAwVKP5buLrMa5cfSj8lB2TSzFE3DZ1mocz8MsneJYSqOJ7ZfQZqx7yHAmMuv/5Y5dBsv9q6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIvWyJmAdPgczUd6u6lnW0m3Xt9PY71/4Xzc+PtTLscW973yWK
	VEWoZpTXoRENUmXpoiZKm2NMiyWJRAnTiUfmSPUIJT9oJbIQrKawYUCkvxX5ByQ=
X-Gm-Gg: ASbGncsC2eWXY444VdCcm0gn8zliKDvxizF2vTGjmQHUwGjcYXCHmg0GaWnXZNnTstN
	ssNEwb3C32dx8j6ngJwqW18i2IfFSwEeUWYS00YaIkBUNIlMW48iYN2dWVCfeW163UFE2uQnw+N
	hAQMN/PRySbFQfGFyUjyLjZJf9DNIEBrUqEZL116FJK+zdG8or27yfDErUjmIlYtFCoLfWVFNWG
	/bKMsCp6MOLITXvHKU7viKHRyaD5tovU35fkcSdhjDQV/QZV2xIrL12AyEAoV5KroDBRK9k25xh
	i+iRxreQ2rLbux/LE2MBemzEPoHypYq1yVc=
X-Google-Smtp-Source: AGHT+IGFa1Atr4OTSCsAzRpYaF67QB8hLiL347alXT2Z9V7fGxdy2SCFDKjMEc++Bsu1YVhVj4AyXw==
X-Received: by 2002:a17:907:760c:b0:aa6:4114:8d89 with SMTP id a640c23a62f3a-aa641149194mr63819466b.53.1733476518826;
        Fri, 06 Dec 2024 01:15:18 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e5c764sm211634566b.20.2024.12.06.01.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 01:15:18 -0800 (PST)
Date: Fri, 6 Dec 2024 10:15:17 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Shuah Khan <shuah@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Alexandre Ghiti <alex@ghiti.fr>, linux-kselftest@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v4] riscv: selftests: Fix warnings pointer masking test
Message-ID: <20241206-6f0aafe057dc10df9a9e02a5@orel>
References: <20241205-fix_warnings_pointer_masking_tests-v4-1-0c77eb725486@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241205-fix_warnings_pointer_masking_tests-v4-1-0c77eb725486@rivosinc.com>

On Thu, Dec 05, 2024 at 01:49:31PM -0800, Charlie Jenkins wrote:
> When compiling the pointer masking tests with -Wall this warning
> is present:
> 
> pointer_masking.c: In function ‘test_tagged_addr_abi_sysctl’:
> pointer_masking.c:203:9: warning: ignoring return value of ‘pwrite’
> declared with attribute ‘warn_unused_result’ [-Wunused-result]
>   203 |         pwrite(fd, &value, 1, 0); |
>       ^~~~~~~~~~~~~~~~~~~~~~~~ pointer_masking.c:208:9: warning:
> ignoring return value of ‘pwrite’ declared with attribute
> ‘warn_unused_result’ [-Wunused-result]
>   208 |         pwrite(fd, &value, 1, 0);
> 
> I came across this on riscv64-linux-gnu-gcc (Ubuntu
> 11.4.0-1ubuntu1~22.04).
> 
> Fix this by checking that the number of bytes written equal the expected
> number of bytes written.
> 
> Fixes: 7470b5afd150 ("riscv: selftests: Add a pointer masking test")
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
> Changes in v4:
> - Skip sysctl_enabled test if first pwrite failed
> - Link to v3: https://lore.kernel.org/r/20241205-fix_warnings_pointer_masking_tests-v3-1-5c28b0f9640d@rivosinc.com
> 
> Changes in v3:
> - Fix sysctl enabled test case (Drew/Alex)
> - Move pwrite err condition into goto (Drew)
> - Link to v2: https://lore.kernel.org/r/20241204-fix_warnings_pointer_masking_tests-v2-1-1bf0c5095f58@rivosinc.com
> 
> Changes in v2:
> - I had ret != 2 for testing, I changed it to be ret != 1.
> - Link to v1: https://lore.kernel.org/r/20241204-fix_warnings_pointer_masking_tests-v1-1-ea1e9665ce7a@rivosinc.com
> ---
>  tools/testing/selftests/riscv/abi/pointer_masking.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/riscv/abi/pointer_masking.c b/tools/testing/selftests/riscv/abi/pointer_masking.c
> index dee41b7ee3e3..759445d5f265 100644
> --- a/tools/testing/selftests/riscv/abi/pointer_masking.c
> +++ b/tools/testing/selftests/riscv/abi/pointer_masking.c
> @@ -189,6 +189,8 @@ static void test_tagged_addr_abi_sysctl(void)
>  {
>  	char value;
>  	int fd;
> +	int ret;
> +	char *err_pwrite_msg = "failed to write to /proc/sys/abi/tagged_addr_disabled\n";
>  
>  	ksft_print_msg("Testing tagged address ABI sysctl\n");
>  
> @@ -200,18 +202,32 @@ static void test_tagged_addr_abi_sysctl(void)
>  	}
>  
>  	value = '1';
> -	pwrite(fd, &value, 1, 0);
> +	ret = pwrite(fd, &value, 1, 0);
> +	if (ret != 1) {
> +		ksft_test_result_skip(err_pwrite_msg);

It seems like we should have a better way to keep the count balanced than
to require a ksft_test_result_skip() call for each test on each error
path. Every time we add a test we'll have to go add skips everywhere else.

> +		goto err_pwrite;
> +	}
> +
>  	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == -EINVAL,
>  			 "sysctl disabled\n");
>  
>  	value = '0';
> -	pwrite(fd, &value, 1, 0);
> +	ret = pwrite(fd, &value, 1, 0);
> +	if (ret != 1)
> +		goto err_pwrite;
> +
>  	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == 0,
>  			 "sysctl enabled\n");
>  
>  	set_tagged_addr_ctrl(0, false);
>  
>  	close(fd);
> +
> +	return;
> +
> +err_pwrite:
> +	close(fd);
> +	ksft_test_result_fail(err_pwrite_msg);
>  }

I don't think the goto reduces much code or improves readability much. A
wrapper function should do better. I was thinking something like

 static bool pwrite_wrapper(int fd, void *buf, size_t count, const char *msg)
 {
   int ret = pwrite(fd, buf, count, 0);
   if (ret != count) {
      ksft_perror(msg);
      return false;
   }
   return true;
 }


 value = '1';
 if (!pwrite_wrapper(fd, &value, 1, "write '1'"))
    ksft_test_result_fail(...);

 value = '0';
 if (!pwrite_wrapper(fd, &value, 1, "write '0'"))
    ksft_test_result_fail(...);


>  
>  static void test_tagged_addr_abi_pmlen(int pmlen)
> 
> ---
> base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> change-id: 20241204-fix_warnings_pointer_masking_tests-3860e4f35429
> -- 
> - Charlie
> 

Thanks,
drew

