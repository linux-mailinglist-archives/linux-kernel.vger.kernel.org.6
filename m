Return-Path: <linux-kernel+bounces-357311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0878996F84
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0087B21457
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00B11E3DEB;
	Wed,  9 Oct 2024 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XbplJ/kb"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204651E3DDD
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728486685; cv=none; b=MTnM3MrMkrZE5nwgDLJDyFDew3XCeLJumI7bylWqzaxX//gTQNG2KmXo9Uk5BDjkG0H58NoJdulv0D07UGXTdULjYco3UYydsVBCveWgitnvgQVnnZF3cK83lFpfUHd7f92zzVegKMOnW/buyw6fP27dhgX4glSFUAI/EkeM690=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728486685; c=relaxed/simple;
	bh=YAyjDXg/x8EITUJ5Pcg/OnP6hSOdHCLesdCNNW49cFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OlR8l2yLwjJ1kqg8klpRFMNMbcD1G6/4/ORYpnMrwunYnCw/fMetmnKlVZY+J+QEBVSNENsq31vCZVgCSF0TRgB9h+K5r+jyTBQwmWd4zWhpCaOrgyad7xE/WT2EWUUP0hG7A+gLY4vJLwMMSq+Ji5E5bA4vqRNSOdA7Jk3lXJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XbplJ/kb; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-82ce1cd2026so274630839f.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 08:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728486681; x=1729091481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ICvUOk0W3V9cUGd1HaodpXuUIaBC/7ub9mNShcqtKD8=;
        b=XbplJ/kbHPPNIg39GT/mjwmWi6Yi0FWJiwl5TdRVuOobCfTUz6IVeBhiZB9yphmvF9
         uxYsZ3zz7AhC7Iyitmu93Pvsaz0EveTFajMtpQQmPGcDHkpNMWNRWDUyH8F9iS/jKMtj
         Vf/Q53p3HOeiwHvLpnn2uv64OcrltDsx+xaBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728486681; x=1729091481;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ICvUOk0W3V9cUGd1HaodpXuUIaBC/7ub9mNShcqtKD8=;
        b=TpTH4QSDJ5SFgs+4CERLqNHTP/eTvQ3Hy5cbqCUT9za0x3m7d4+E9n4lVYEbHADI78
         hb4TnvlIIOQqb9BIyCi+GfFDTSTX9KNik3UpTyqdiZS73VjaXdcuejWKaJ4WD1SWAdiR
         ZT9LF6hmFuKlcE2nTCqH+chK+KXioWWNbTTf0b++/B/yh64FDwBOPpMiGLkhkimuAe0d
         flDwzYggHLLo6i7yRAes/IT36yN/7oDSa2yPx+MHsAs6vzqrPUcvf2dNQjLToBcfpYKt
         z2GkcDqgqyc1T13U366OCIDGcwZvjvieGHjZJcvn7UJB/Vgp7j/FMSdgP+d3CI7lHrZg
         Ngmw==
X-Forwarded-Encrypted: i=1; AJvYcCX7Q8+5wVvKlVUVXbMi/VXgWJHynLzLz1ahy4b3z2dicDu0IOWox47IWMJmYStwpYYmpEluly5RRMfub5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLnf1yDvZD9wtJ1EDX2FKZ8XJbXFqZg9NJHOZh24l4ATF38tJQ
	YEdWYP4/3gHCzoiZ82ptdVXfB2AADrUEcdkguna3MC9pwyY1wQqrxmW65zGFxoM=
X-Google-Smtp-Source: AGHT+IHIQd+4JF1Rw+2n1rqjmSLdY5D1Feb6AJJuqJ8U/pxlyZdWcx3DsZ8GtvW2sFwFI79OyN+YFw==
X-Received: by 2002:a05:6602:2dc6:b0:82c:f517:dc9e with SMTP id ca18e2360f4ac-8353d4b7702mr426808539f.8.1728486680884;
        Wed, 09 Oct 2024 08:11:20 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db8dac7279sm1107567173.33.2024.10.09.08.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 08:11:20 -0700 (PDT)
Message-ID: <51d2cb33-c0d3-4837-a22c-9c42a7a4818e@linuxfoundation.org>
Date: Wed, 9 Oct 2024 09:11:19 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the kunit-next tree with the mm tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Brendan Higgins <brendanhiggins@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, David Gow <davidgow@google.com>
Cc: =?UTF-8?Q?Bruno_Sobreira_Fran=C3=A7a?= <brunofrancadevsec@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241004135527.1e2fc747@canb.auug.org.au>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241004135527.1e2fc747@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/24 21:55, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the kunit-next tree got conflicts in:
> 
>    lib/math/Makefile
>    lib/math/tests/Makefile
> 
> between commit:
> 
>    aa2cc84cfeb0 ("lib/math: add int_log test suite")
> 
> from the mm-nonmm-unstable branch of the mm tree and commit:
> 
>    f099bda563dd ("lib: math: Move kunit tests into tests/ subdir")
> 
> from the kunit-next tree.
> 
> I fixed it up (I used the latter version of lib/math/Makefile and see
> below the signature by the patch immediately below) and can carry the
> fix as necessary. This is now fixed as far as linux-next is concerned,
> but any non trivial conflicts should be mentioned to your upstream
> maintainer when your tree is submitted for merging.  You may also want
> to consider cooperating with the maintainer of the conflicting tree to
> minimise any particularly complex conflicts.

Sorry for the delay on this. Thank you for fixing this up.

Andrew,

Looks like we might see more conflicts between mm and kunit trees
with the move from lib/ lib/tests/

I dropped a couple of patches I couldn't apply. Would you like
me to drop this from kunit tree?

Adding David as well for feedback on this.

> 
> rom: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 4 Oct 2024 13:51:56 +1000
> Subject: [PATCH] fix up for "lib: math: Move kunit tests into tests/ subdir"
> 
> interacting with "lib/math: add int_log test suite" from the mm tree.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>   lib/Kconfig.debug       | 2 +-
>   lib/math/tests/Makefile | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 9ed36fec4390..d3e44b17876d 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -3105,7 +3105,7 @@ config INT_POW_KUNIT_TEST
>   
>   	  If unsure, say N
>   
> -config INT_LOG_TEST
> +config INT_LOG_KUNIT_TEST
>   	tristate "Integer log (int_log) test" if !KUNIT_ALL_TESTS
>   	depends on KUNIT
>   	default KUNIT_ALL_TESTS
> diff --git a/lib/math/tests/Makefile b/lib/math/tests/Makefile
> index 64b9bfe3381d..89a266241e98 100644
> --- a/lib/math/tests/Makefile
> +++ b/lib/math/tests/Makefile
> @@ -2,6 +2,6 @@
>   
>   obj-$(CONFIG_DIV64_KUNIT_TEST)    += div64_kunit.o
>   obj-$(CONFIG_INT_POW_KUNIT_TEST)  += int_pow_kunit.o
> -obj-$(CONFIG_INT_LOG_TEST) += int_log_kunit.o
> +obj-$(CONFIG_INT_LOG_KUNIT_TEST)  += int_log_kunit.o
>   obj-$(CONFIG_MULDIV64_KUNIT_TEST) += mul_u64_u64_div_u64_kunit.o
>   obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational_kunit.o

thanks,
-- Shuah

