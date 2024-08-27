Return-Path: <linux-kernel+bounces-303404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 364AA960BA0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 929B8B2125D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28E817BED8;
	Tue, 27 Aug 2024 13:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VPsZic3+"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F581BA875
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 13:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764646; cv=none; b=E5Q/eFj+TiLRK3gFi7O1wMhCazrBOnJ3aAQce/33gHMm9lYzBlfsPLZTG3rBK08o+7pSdwRyE87LT0w1MLH3w3XroinR7WDjy+7cnPWt1RtmE8iXhZcfWG05QuU6UsMb0TbQAfaJo3G0qWvXOzMye4SBlATOrtZbcgZhxuvCe+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764646; c=relaxed/simple;
	bh=vwt6e777tT51vo7BVYhsyOE+lwnCOE+ATUVN8ZFprPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lRTxIGS+hYm/gEAfaeOhfGpFzqyILHDAHx63aXEft4dKlVL8uwbbn9SlEPQLiZa46zJjXOjOquj+Tno/zxSodCf8I1SADr2moGBiMpikawmYIqnqlHRujvsp3rWPj0m4cgypfuUpLNGFXA16xi/mLy8+UzHUU0hyHCjPu0A0vhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VPsZic3+; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7141feed424so4528793b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 06:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724764644; x=1725369444; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vNDvQ0p8YG1nUDHlej3r9c38HmVmkFpUvXQbHfKwb18=;
        b=VPsZic3+JuNkNkvidzsT9nyttmCBlF7lNwoOALRsmd8keH8M6tunuUA8s+DE/rJMQi
         eruyNe8cNWJXXjlCFgHsKSJGRzcQy5X5E0+qOOQ4S5rN1okatLo3Zop3NsMr5t9/Zjif
         lrV+a+ErSpJtjyo5DHeITkBi5Hq3HEwHYN3maj5seSKd3w8Cpr9SeJJPKVQU75yyB0Xr
         A6AhSgZ5zgC4CXqLYYmB0b5y2Jom8W4Kd2PbVaGj2mJmI8ThzFexA9SNWVHHE7f6MZyC
         LMzoqXMCicS6qjmNYAiJkahq94RmKlKo4+8tJks1if9UjRSQ+cd+z7os7yp79VT67QqN
         8KUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724764644; x=1725369444;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNDvQ0p8YG1nUDHlej3r9c38HmVmkFpUvXQbHfKwb18=;
        b=slKzSYCZ+mwxyfopMYcOAk8ptVmA443pePT03UhzUH9coHGI2qrh5hyQRWIcHyFbzM
         0gfItxMjFk7dMFw7w+4lfDj+gihioKSIocM0qX9z1fYYnG8lk3Q/uR7OAm3CoKyTm58B
         mEXq7TOMJSbKw7o6L3nUfbN2jX9/tzR5m4JFw/Js9Y/4DK7D4dPgdox/elaYdBvpLR8N
         HP5pP9ctbv8IFexu7E783MMFYbPBp5p2y9LtqmTigECiAw0IjbowwRO7o9NW3zB0kcu2
         i1VA/o83hyyyOi2L1/9E0L/ODcfrzj6QEl40Nv0KMMNvVYFa3Ez8JCVinolh4z8BYwC+
         Onyg==
X-Forwarded-Encrypted: i=1; AJvYcCWkA36fjioY0iwGCBPa5MlD/kivpq05nM7aIziTJ2DoVjVj98UHfDIuzec4eKwh7AYue+xLjWpUuJBvCCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5c099CFQPwCcNvC97Xht2d952SuHK5gKJvu3C4lNUIJTk1eYO
	jpzLyhncspKFWHjJNes89daTwEV2tQwRJXjbLnvYaLH0GS5/nCzh43sbNXXM9tk=
X-Google-Smtp-Source: AGHT+IH9wVCtiNWpud5VecI+or3EQC2B6MQxmB4kaQPqUnITYluTDe+8K/OQr6CZCu9mmsY3lcLP0g==
X-Received: by 2002:a05:6a21:6f83:b0:1ca:edfc:8550 with SMTP id adf61e73a8af0-1cc8b59174dmr13599820637.38.1724764643822;
        Tue, 27 Aug 2024 06:17:23 -0700 (PDT)
Received: from ?IPV6:2804:1b3:a7c3:4c2c:7d73:fa05:8bad:32cb? ([2804:1b3:a7c3:4c2c:7d73:fa05:8bad:32cb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9acabe0esm9315176a12.35.2024.08.27.06.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 06:17:23 -0700 (PDT)
Message-ID: <fd3cd385-131a-43b2-8ce9-05547a4f2d1d@linaro.org>
Date: Tue, 27 Aug 2024 10:17:18 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] aarch64: vdso: Wire up getrandom() vDSO implementation
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Eric Biggers <ebiggers@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20240826181059.111536-1-adhemerval.zanella@linaro.org>
 <ZszlGPqfrULzi3KG@zx2c4.com>
Content-Language: en-US
From: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Organization: Linaro
In-Reply-To: <ZszlGPqfrULzi3KG@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 26/08/24 17:27, Jason A. Donenfeld wrote:
> Hi Adhemerval,
> 
> Thanks for posting this! Exciting to have it here.
> 
> Just some small nits for now:
> 
> On Mon, Aug 26, 2024 at 06:10:40PM +0000, Adhemerval Zanella wrote:
>> +static __always_inline ssize_t getrandom_syscall(void *buffer, size_t len, unsigned int flags)
>> +{
>> +	register long int x8 asm ("x8") = __NR_getrandom;
>> +	register long int x0 asm ("x0") = (long int) buffer;
>> +	register long int x1 asm ("x1") = (long int) len;
>> +	register long int x2 asm ("x2") = (long int) flags;
> 
> Usually it's written just as `long` or `unsigned long`, and likewise
> with the cast. Also, no space after the cast.

Ack.

> 
>> +#define __VDSO_RND_DATA_OFFSET  480
> 
> This is the size of the data currently there?

Yes, I used the same strategy x86 did.

> 
>>  #include <asm/page.h>
>>  #include <asm/vdso.h>
>>  #include <asm-generic/vmlinux.lds.h>
>> +#include <vdso/datapage.h>
>> +#include <asm/vdso/vsyscall.h>
> 
> Possible to keep the asm/ together?

Ack.

> 
>> + * ARM64 ChaCha20 implementation meant for vDSO.  Produces a given positive
>> + * number of blocks of output with nonnce 0, taking an input key and 8-bytes
> 
> nonnce -> nonce

Ack.

> 
>> -ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
>> +ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/ -e s/aarch64.*/arm64/)
>>  SODIUM := $(shell pkg-config --libs libsodium 2>/dev/null)
>>  
>>  TEST_GEN_PROGS := vdso_test_gettimeofday
>> @@ -11,7 +11,7 @@ ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
>>  TEST_GEN_PROGS += vdso_standalone_test_x86
>>  endif
>>  TEST_GEN_PROGS += vdso_test_correctness
>> -ifeq ($(uname_M),x86_64)
>> +ifeq ($(uname_M), $(filter x86_64 aarch64, $(uname_M)))
>>  TEST_GEN_PROGS += vdso_test_getrandom
>>  ifneq ($(SODIUM),)
>>  TEST_GEN_PROGS += vdso_test_chacha
> 
> You'll need to add the symlink to get the chacha selftest running:
> 
>   $ ln -s ../../../arch/arm64/kernel/vdso tools/arch/arm64/vdso
>   $ git add tools/arch/arm64/vdso
> 
> Also, can you confirm that the chacha selftest runs and works?

Yes, last time I has to built it manually since the Makefile machinery seem 
to be broken even on x86_64.  In a Ubuntu vm I have:

tools/testing/selftests/vDSO$ make
  CC       vdso_test_gettimeofday
  CC       vdso_test_getcpu
  CC       vdso_test_abi
  CC       vdso_test_clock_getres
  CC       vdso_standalone_test_x86
  CC       vdso_test_correctness
  CC       vdso_test_getrandom
  CC       vdso_test_chacha
In file included from /home/azanella/Projects/linux/linux-git/include/linux/limits.h:7,
                 from /usr/include/x86_64-linux-gnu/bits/local_lim.h:38,
                 from /usr/include/x86_64-linux-gnu/bits/posix1_lim.h:161,
                 from /usr/include/limits.h:195,
                 from /usr/lib/gcc/x86_64-linux-gnu/13/include/limits.h:205,
                 from /usr/lib/gcc/x86_64-linux-gnu/13/include/syslimits.h:7,
                 from /usr/lib/gcc/x86_64-linux-gnu/13/include/limits.h:34,
                 from /usr/include/sodium/export.h:7,
                 from /usr/include/sodium/crypto_stream_chacha20.h:14,
                 from vdso_test_chacha.c:6:
/usr/include/x86_64-linux-gnu/bits/xopen_lim.h:99:6: error: missing binary operator before token "("
   99 | # if INT_MAX == 32767
      |      ^~~~~~~
/usr/include/x86_64-linux-gnu/bits/xopen_lim.h:102:7: error: missing binary operator before token "("
  102 | #  if INT_MAX == 2147483647
      |       ^~~~~~~
/usr/include/x86_64-linux-gnu/bits/xopen_lim.h:126:6: error: missing binary operator before token "("
  126 | # if LONG_MAX == 2147483647
      |      ^~~~~~~~
make: *** [../lib.mk:222: /home/azanella/Projects/linux/linux-git/tools/testing/selftests/vDSO/vdso_test_chacha] Error 1


I will try to figure out to be build it correctly, but I think it would be
better to vgetrandom-chacha.S with a different rule.

