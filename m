Return-Path: <linux-kernel+bounces-435412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 151B09E7718
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2D1188690F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F072D203D4F;
	Fri,  6 Dec 2024 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="svJS3xIk"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7849203D4C
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505717; cv=none; b=el8DhC0RzJCrPZpmv95ZMlZeoHZNJAxoCvW8EWtqBNg4l3vlvoBEa3zne/SpSPe2a5fZNots8ZhOQ799oEOIlTS5G2uNCWhck9MKqZrCV5P2zBoGwPwQHiydHmsa0hxJvGD1GWVvukZMf0vZVZWs787hzJ46l0F6kLsjdEI1FDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505717; c=relaxed/simple;
	bh=5SWrXNXCkR/Tdwhr338AiMHE76pVRKR+l91Mb2XjOJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L75b6d3Yz02iG1d8KFLswnMdc5sg0qVZk6EXoqP0wTlXItHFVDCTFI7FrdAz+MTLaVpSrc2cG5fpvqenR2weGbiu2dof6Lb4MiTA1TPciBGFHMRxCpJjSA/4t6cxbIdgUKeQNCW+ZpfS3OhbPaLSYH5xxCWbx5UIZGKwIsPVfAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=svJS3xIk; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-215513ea198so28170535ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 09:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733505714; x=1734110514; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+i+tasT2Gj7lYOeBeWZMOQQXNZXO0To2+VDLJbtR+G0=;
        b=svJS3xIkZu1I8f1icdjiiPnGXcUau9GdSmRZOqHtKXJ0FX/nPF9uxiUmxpQjvMxabu
         nUskllNtdlQJerJnSAumFinCiUHEVfjM0WlvSKPBEmI5IFqDWOcfqrpCZ1tfD4FOXUa5
         c95eO6v+4QOBZDwnfZGJ6s0XXx8DTDrW+HQWhC06l2+pXJ7nT40QSuivQaWXMohaUcUJ
         IbxEAc7TC6KVcPXsePiqxTX/YO/uoOz3w3UnbXAn8PRkI/bkvGkOkxNRvCYCV6ZwcXb9
         xf4nM0MjQ3Sk7kDEhtgZDnrlESdr0EdGBUFmzX3OqsEL2t2WStJHQ3DpDaB2OVT7FGiA
         yVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733505714; x=1734110514;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+i+tasT2Gj7lYOeBeWZMOQQXNZXO0To2+VDLJbtR+G0=;
        b=JqnlG9olldA5c74/S2EVRkcR5y5Rmhy2b5ryzZVTXn0tjTG5ZButsKSvs5YxApdHuh
         /+CNyt+j6WeJBKcHiqqw9N9n60NgMFlYfafh2KFZbNl3Ew/FZmdq85FPpYMT4ghOQQ6V
         SyBm3E2Ma3Kg0kwOQk9QGOL4RCOjUEyi/TXWc7FySquDLoorJ8ovmkUXXjVUo5GiAajz
         KbqVtS8a76e/CXbGDBm5gQPkDDooabDr6RJs1p05lUoukbJm4PCBCnmU/mTd9kf2SXG+
         d4D0NyF1I/88++7gPyFiMZn6RGw0VCiYVLs5G7fB+AaE+TzBZmmjMMrdxkITvjAk/yGV
         TSmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWL8gm7110ttgdatYwPCH0YHptIMYT5A9KGh5aLvAmIcVRd4RQMv9CSYjSc3oKX9FRh+Uviu1kYV2/1P0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywr1no8JCLAqhLD8lA0TGGI85us0OzsotqsWZ3FPJokkfbx1GE
	lP+WU0MJuQVPmVuaIov0k+sd9cvyKndjjJzo8uS+tHBVV05P5AmqSUZIvD0K27k=
X-Gm-Gg: ASbGnctnv9LIpoih6QuZS4sYXokpMlcjpqm9sSbIfm6oAgd6dSmfGKtc2zyOttXwDiM
	JNUdIWnNUZBEASpHvz2+YWHRDrbmWkWWDW6w/ikopZnSeTr24zw8zald516wHSMDblLUu35xZUZ
	VwYXk8Q71DJpmsbZnXFKeoN57QeGlh36CANSAMmTjqNG04Qscg1e9i9lQEWql4kJ3YgwnDfmZNe
	1exEZe+af0BPEHyZZzbfNh+UaSwiUGFsdIUtrgUzCfUQQ==
X-Google-Smtp-Source: AGHT+IGBrlMUCRA6EhqKpkEJniaz+WOJ8hm3M6cEs20NXgKFJ+7zC8Lu1pnHxeoDwgch7HO03IBy9A==
X-Received: by 2002:a17:903:2309:b0:215:beb2:1039 with SMTP id d9443c01a7336-215f3c56b8cmr131489695ad.4.1733505714299;
        Fri, 06 Dec 2024 09:21:54 -0800 (PST)
Received: from ghost ([2600:1010:b0ba:197a:c0e9:4a0e:e502:edf9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f29beesm31109165ad.254.2024.12.06.09.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 09:21:53 -0800 (PST)
Date: Fri, 6 Dec 2024 09:21:50 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Shuah Khan <shuah@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>, linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v4] riscv: selftests: Fix warnings pointer masking test
Message-ID: <Z1MyrgQJsHQscdZ2@ghost>
References: <20241205-fix_warnings_pointer_masking_tests-v4-1-0c77eb725486@rivosinc.com>
 <20241206-6f0aafe057dc10df9a9e02a5@orel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241206-6f0aafe057dc10df9a9e02a5@orel>

On Fri, Dec 06, 2024 at 10:15:17AM +0100, Andrew Jones wrote:
> On Thu, Dec 05, 2024 at 01:49:31PM -0800, Charlie Jenkins wrote:
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
> > Changes in v4:
> > - Skip sysctl_enabled test if first pwrite failed
> > - Link to v3: https://lore.kernel.org/r/20241205-fix_warnings_pointer_masking_tests-v3-1-5c28b0f9640d@rivosinc.com
> > 
> > Changes in v3:
> > - Fix sysctl enabled test case (Drew/Alex)
> > - Move pwrite err condition into goto (Drew)
> > - Link to v2: https://lore.kernel.org/r/20241204-fix_warnings_pointer_masking_tests-v2-1-1bf0c5095f58@rivosinc.com
> > 
> > Changes in v2:
> > - I had ret != 2 for testing, I changed it to be ret != 1.
> > - Link to v1: https://lore.kernel.org/r/20241204-fix_warnings_pointer_masking_tests-v1-1-ea1e9665ce7a@rivosinc.com
> > ---
> >  tools/testing/selftests/riscv/abi/pointer_masking.c | 20 ++++++++++++++++++--
> >  1 file changed, 18 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/riscv/abi/pointer_masking.c b/tools/testing/selftests/riscv/abi/pointer_masking.c
> > index dee41b7ee3e3..759445d5f265 100644
> > --- a/tools/testing/selftests/riscv/abi/pointer_masking.c
> > +++ b/tools/testing/selftests/riscv/abi/pointer_masking.c
> > @@ -189,6 +189,8 @@ static void test_tagged_addr_abi_sysctl(void)
> >  {
> >  	char value;
> >  	int fd;
> > +	int ret;
> > +	char *err_pwrite_msg = "failed to write to /proc/sys/abi/tagged_addr_disabled\n";
> >  
> >  	ksft_print_msg("Testing tagged address ABI sysctl\n");
> >  
> > @@ -200,18 +202,32 @@ static void test_tagged_addr_abi_sysctl(void)
> >  	}
> >  
> >  	value = '1';
> > -	pwrite(fd, &value, 1, 0);
> > +	ret = pwrite(fd, &value, 1, 0);
> > +	if (ret != 1) {
> > +		ksft_test_result_skip(err_pwrite_msg);
> 
> It seems like we should have a better way to keep the count balanced than
> to require a ksft_test_result_skip() call for each test on each error
> path. Every time we add a test we'll have to go add skips everywhere else.

It's only a problem if there are multiple tests in a single test
function like there is here. Since the tests disable then reenable it
makes sense to have them in one function, but does require us to do the
skipping.

> 
> > +		goto err_pwrite;
> > +	}
> > +
> >  	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == -EINVAL,
> >  			 "sysctl disabled\n");
> >  
> >  	value = '0';
> > -	pwrite(fd, &value, 1, 0);
> > +	ret = pwrite(fd, &value, 1, 0);
> > +	if (ret != 1)
> > +		goto err_pwrite;
> > +
> >  	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == 0,
> >  			 "sysctl enabled\n");
> >  
> >  	set_tagged_addr_ctrl(0, false);
> >  
> >  	close(fd);
> > +
> > +	return;
> > +
> > +err_pwrite:
> > +	close(fd);
> > +	ksft_test_result_fail(err_pwrite_msg);
> >  }
> 
> I don't think the goto reduces much code or improves readability much. A
> wrapper function should do better. I was thinking something like
> 
>  static bool pwrite_wrapper(int fd, void *buf, size_t count, const char *msg)
>  {
>    int ret = pwrite(fd, buf, count, 0);
>    if (ret != count) {
>       ksft_perror(msg);
>       return false;
>    }
>    return true;
>  }
> 
> 
>  value = '1';
>  if (!pwrite_wrapper(fd, &value, 1, "write '1'"))
>     ksft_test_result_fail(...);
> 
>  value = '0';
>  if (!pwrite_wrapper(fd, &value, 1, "write '0'"))
>     ksft_test_result_fail(...);
> 
> 

Will do, thanks!

- Charlie

> >  
> >  static void test_tagged_addr_abi_pmlen(int pmlen)
> > 
> > ---
> > base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> > change-id: 20241204-fix_warnings_pointer_masking_tests-3860e4f35429
> > -- 
> > - Charlie
> > 
> 
> Thanks,
> drew

