Return-Path: <linux-kernel+bounces-303562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B55960E26
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC15E1C22FB4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4011C57A9;
	Tue, 27 Aug 2024 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EIOtcfIc"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1CE1C68A0
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 14:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769912; cv=none; b=eJdE2HPt7VTsSuchiHXh4pu1BD0/WYVTAWoEL1A37tGZkTYDpnjY+NZuAuSgE06LGmBODYCdcT6oktOYBmml7mCYtbXJlzlsXEiNe5gVhMgKjzlDkSNMVAuvTQ3ycVsWqLIbr+NLc7ipCiUZsUEAdsDm/hL8J9vtlCF5mh/7cVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769912; c=relaxed/simple;
	bh=vqvl2wd7DAFMAHHpX+evfMh9e2Jl+1xEc6H1La+3K1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FkAjoKgYM+kM/dmRFIRr1Eo/weT6M3IBa+GeupuVdv5EUHnh6bcy0blwi2C+BEzPE0pQqOhrJ42CKDgumxIY+9ZpU4ZCu+0COIbB/ymxezgGvhfo9HmVZDFREI9ns4jPmvBmG1JbwJAzg49aOss2aWXiG3RGLm0SqFaJoiPtYjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EIOtcfIc; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71423704ef3so4502773b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 07:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724769909; x=1725374709; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iZbuGqIhqoTjhqlrNnto8kSYtP9PG/eWiGML5Tm64Lg=;
        b=EIOtcfIcG8LOVTJ/YFktcqH0VAR+K1mFNObME36qd4JB6xRgJSjoHW4uzSP5XhAHrq
         q+PZa5KZByz5X0NLWdfFv+2hUooSFLsY42sPHglOuH44a3CH2NtYfR64Vbc8lhhFjrAj
         nb+8luuu9FcoGuD5TdKKfRB/bJafolRCZ8Ds1Nm38CjI1OFMkLwwN7phZ0qcli/Q+sRF
         OnC7Y36lX13gf7pCfE0Bk57Hbq0JPA9zToOay/ExNdQ02/pV4QPI4RwoDXh6i1u7z51H
         814q1XNPnrMsHQaUjUrHRz7o7Vf1qrXtMpO0UmvcjUiM2HqTUOs2e8Tfb94o9+cfy62K
         0JIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724769909; x=1725374709;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iZbuGqIhqoTjhqlrNnto8kSYtP9PG/eWiGML5Tm64Lg=;
        b=NQcc88wTd14Q3LP2stL6xIxcdSc9SCuurqsBAf6H0c3q0Afm960sNIdbfiLlwMYoXN
         NthDxonbIxeY0Ssw4DQq/4Sgs8YsrIhszQ0HnMgpVQy8fujcYz+QZJyiv85YpYalelRA
         J4w9L9r13R4SlqP1diCbLbIwJZUfKvg3fXdHbPnn/fHcdeUCqrDOSdWofBP2r/d5eJaH
         jl/nNMkBMsFvFMcnaXz67syUcBnZJeCWaQ6OO291KramOUAAVAKZyKmy6ywc8Y93dI17
         L/0A51l/l324x1aK8IimRS79pfzC4nBNnZwZYxiLRUvUnYR32dleuUVtZNaEHm2b+bg5
         p2Og==
X-Forwarded-Encrypted: i=1; AJvYcCWFpdiRrF71gHvx4OVuNqQpcWcPcR/GZsvROH4bedxrwSGtYTDVhi4ZRyC8g+ftp7XFeWlfhyJjXEUrOKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc5ITrEhWIQiIpxeSOUtmPNzPO+8tSOrgQd5nv5hbzeKicMGJr
	8oXp0rPM2AqOTO2wY8fjwLy/wzTkfk1ZMHDL3jzYeIGoKK/C19vz19DJQWUIoGEviNFYn7OoWCg
	+Bvk=
X-Google-Smtp-Source: AGHT+IF9N8sFDFv0WTjVLHaUzgFXEzBqE1vJnTU8YzQa+GyLpaD3Pj3el5aQAziWJeULrCiTACQr3A==
X-Received: by 2002:a05:6a21:6f83:b0:1c2:8cc4:9084 with SMTP id adf61e73a8af0-1cc8b5d8839mr18734691637.34.1724769908968;
        Tue, 27 Aug 2024 07:45:08 -0700 (PDT)
Received: from ?IPV6:2804:1b3:a7c3:4c2c:7d73:fa05:8bad:32cb? ([2804:1b3:a7c3:4c2c:7d73:fa05:8bad:32cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342e0a98sm8651786b3a.135.2024.08.27.07.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 07:45:07 -0700 (PDT)
Message-ID: <a333f3c5-2bc2-442f-8a27-7ec0d6380de8@linaro.org>
Date: Tue, 27 Aug 2024 11:45:05 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/vDSO: separate LDLIBS from CFLAGS for libsodium
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org
References: <7d9c376c-10ae-40cc-8d8a-d614b8dd289f@linaro.org>
 <20240827144200.3315093-1-Jason@zx2c4.com>
Content-Language: en-US
From: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Organization: Linaro
In-Reply-To: <20240827144200.3315093-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 27/08/24 11:41, Jason A. Donenfeld wrote:
> On systems that set -Wl,--as-needed, putting the -lsodium in the wrong
> place on the command line means we get a linker error:
> 
>       CC       vdso_test_chacha
>     /usr/bin/ld: /tmp/ccKpjnSM.o: in function `main':
>     vdso_test_chacha.c:(.text+0x276): undefined reference to `crypto_stream_chacha20'
>     collect2: error: ld returned 1 exit status
> 
> Fix this by passing pkg-config's --libs output to the LDFLAGS field
> instead of the CFLAGS field, as is customary.
> 
> Reported-by: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  tools/testing/selftests/vDSO/Makefile | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
> index 180854eb9fec..834aa862ba2c 100644
> --- a/tools/testing/selftests/vDSO/Makefile
> +++ b/tools/testing/selftests/vDSO/Makefile
> @@ -1,7 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>  uname_M := $(shell uname -m 2>/dev/null || echo not)
>  ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
> -SODIUM := $(shell pkg-config --libs --cflags libsodium 2>/dev/null)
> +SODIUM_LIBS := $(shell pkg-config --libs libsodium 2>/dev/null)
> +SODIUM_CFLAGS := $(shell pkg-config --cflags libsodium 2>/dev/null)
>  
>  TEST_GEN_PROGS := vdso_test_gettimeofday
>  TEST_GEN_PROGS += vdso_test_getcpu
> @@ -13,7 +14,7 @@ endif
>  TEST_GEN_PROGS += vdso_test_correctness
>  ifeq ($(uname_M),x86_64)
>  TEST_GEN_PROGS += vdso_test_getrandom
> -ifneq ($(SODIUM),)
> +ifneq ($(SODIUM_LIBS),)
>  TEST_GEN_PROGS += vdso_test_chacha
>  endif
>  endif
> @@ -41,8 +42,9 @@ $(OUTPUT)/vdso_test_getrandom: CFLAGS += -isystem $(top_srcdir)/tools/include \
>                                           -isystem $(top_srcdir)/include/uapi
>  
>  $(OUTPUT)/vdso_test_chacha: $(top_srcdir)/tools/arch/$(ARCH)/vdso/vgetrandom-chacha.S
> +$(OUTPUT)/vdso_test_chacha: LDLIBS += $(SODIUM_LIBS)
>  $(OUTPUT)/vdso_test_chacha: CFLAGS += -idirafter $(top_srcdir)/tools/include \
>                                        -idirafter $(top_srcdir)/arch/$(ARCH)/include \
>                                        -idirafter $(top_srcdir)/include \
>                                        -D__ASSEMBLY__ -DBULID_VDSO -DCONFIG_FUNCTION_ALIGNMENT=0 \

This seems to be wrong '-DBULID_VDSO'.

> -                                      -Wa,--noexecstack $(SODIUM)
> +                                      -Wa,--noexecstack $(SODIUM_CFLAGS)

LGTM, thanks.

Reviewed-by: Adhemerval Zanella  <adhemerval.zanella@linaro.org>

