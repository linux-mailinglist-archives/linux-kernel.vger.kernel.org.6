Return-Path: <linux-kernel+bounces-315535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FF696C3E8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79C111F2653C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84421DFE0F;
	Wed,  4 Sep 2024 16:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KSLIu7ZP"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916AF1DA635
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 16:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466775; cv=none; b=ZdMbl/e6N0k/Q7jtLZvyqCO47Q3N51KnWuUuaIA8ZRdLaesGfWsGPfLV+cUGfEPlcOuIHS7NUE7adUvS79ZTqX+GdnJFZB8JOBb/1kMRRv1+HSjH7gD9SVsc+jQPZ3yicdSzN4XVRaaKIFc07RD11oC382+vRG3mOUfiqs4U4ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466775; c=relaxed/simple;
	bh=Yj6wBW13IkBp/d/GpRuGqimKcM/vqif5sF5qsan7SUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QtAk0loXJcaQ+uWU1/A5Arkg9a9PFhAwJhbDYitCTsJHP2/DF6QY+K8QbKTjE8wXvA1sg936i+tMGhOlNSydxY6rE2enihRhQL3gEiQxEZGU2Xw3QwUAVzBN8gF47qzvXAzmKZ9Q3YMr4B2RTo5gdRz6FXPko1P8r8eRJywsC9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KSLIu7ZP; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-714226888dfso913071b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 09:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725466773; x=1726071573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tE4kgR8raMIvlea9za7vYtY0pRI2oOfG776uBJHCznQ=;
        b=KSLIu7ZPdfWyzoeRIQwHIILolFEI2ZDjqLize/vd/1l670/ZKvFtJWqr4CDum8JnuX
         rXBvTCt2O5v1KM14FX57ZKILRUEiICLeoQw0LakLWD2dth8aQFiaTWjfUXcin6EkrET0
         dfgpuZUgQcWXKu7gVOwcrBdTjS7HDzVlbi0NIOKTjlanZc0cv6b44xw5jtrWDh3WSu2c
         cPjGm+jDy3d497CF3MuxotxnIa70+eIKyJ5GFUrE0QgtzdxQEuGQZX/QtyUYMiAmjKzP
         +A4rNYwgdQhxQT+0hbjXLtYqRp5puPlGkfC0u+XSyMhr77B3bV/q4GKnJvgEl1trPDiF
         bomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725466773; x=1726071573;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tE4kgR8raMIvlea9za7vYtY0pRI2oOfG776uBJHCznQ=;
        b=dt70ggaurR1PaC3tGj0x7ofrC08NqRDTWX2HA1Gr1qa+1XDYAPPGzB51uH8nS8Gi/f
         mzb9ml0EaVpLth6AGvIjYFy0tR7lA/k6Nwr4CDT+9aPi6Kxb33tVRE2IzoG4f0rqdVeu
         I6b2cNdhVcRAU/pTJrtnKmv/w4/c5RHav5ISXcKt6q16BeDqACBiif3RHS00e+57K8n9
         Xuv83RGlFvpLE/KtpJDdqrdGRGC8rkMCwZWNLaUpbQD6FZdqZm3i1V4wh3uMwNOAWQn0
         cZLCzl+HCEmlgI/7iFbUCA+HMr+YKynvFgjFmfkN6xUkYFT1fJ/AugukOmKmORGjVmD4
         1GwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlRXVEa4mRoujsP+pglCa2hPgQQXFomhAUNSXpIfHMdGmnzpL2nQ4yT3b2BlLfMfgxEHLz6T2SBZPgJ8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGDbkJj1Sjsi8Gvj+YxgixrVNh7Y/DS8tEx6agZ+xrMFfisnsg
	dR4vDn0fWAteXvd7jYZIYXq7j2tahqzcGSswoMNz2IyHGRlSbWIZCOgZf3BPuEDcyB26ubLNecE
	Pqew=
X-Google-Smtp-Source: AGHT+IFYhWo1crm6JBvG1SXhWbNLlyM92HJXdc0TWPt394DShMMg+137THmGcHZmoEklE6qfnrGZTw==
X-Received: by 2002:a05:6a00:984:b0:706:65f6:3ab9 with SMTP id d2e1a72fcca58-715dfc3a9f6mr27731421b3a.20.1725466772661;
        Wed, 04 Sep 2024 09:19:32 -0700 (PDT)
Received: from ?IPV6:2804:1b3:a7c3:e912:6904:dd5a:7f0d:ac77? ([2804:1b3:a7c3:e912:6904:dd5a:7f0d:ac77])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71778594f4fsm1856081b3a.144.2024.09.04.09.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 09:19:31 -0700 (PDT)
Message-ID: <9f12f377-0fd7-4178-b940-7917094ff2cb@linaro.org>
Date: Wed, 4 Sep 2024 13:19:29 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: vDSO: don't include generated headers for
 chacha test
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org
References: <20240904155817.1153783-1-Jason@zx2c4.com>
Content-Language: en-US
From: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Organization: Linaro
In-Reply-To: <20240904155817.1153783-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 04/09/24 12:58, Jason A. Donenfeld wrote:
> It's not correct to use $(top_srcdir) for generated header files, for
> builds that are done out of tree via O=, and $(objtree) isn't valid in
> the selftests context. Instead, just obviate the need for these
> generated header files by defining empty stubs in tools/include/asm,
> which is the same thing that's done for rwlock.h.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Works for me, thanks.

Reviewed-by: Adhemerval Zanella  <adhemerval.zanella@linaro.org>

> ---
>  tools/include/asm/asm-offsets.h       | 0
>  tools/include/asm/cpucap-defs.h       | 0
>  tools/include/asm/sysreg-defs.h       | 0
>  tools/testing/selftests/vDSO/Makefile | 1 -
>  4 files changed, 1 deletion(-)
>  create mode 100644 tools/include/asm/asm-offsets.h
>  create mode 100644 tools/include/asm/cpucap-defs.h
>  create mode 100644 tools/include/asm/sysreg-defs.h
> 
> diff --git a/tools/include/asm/asm-offsets.h b/tools/include/asm/asm-offsets.h
> new file mode 100644
> index 000000000000..e69de29bb2d1
> diff --git a/tools/include/asm/cpucap-defs.h b/tools/include/asm/cpucap-defs.h
> new file mode 100644
> index 000000000000..e69de29bb2d1
> diff --git a/tools/include/asm/sysreg-defs.h b/tools/include/asm/sysreg-defs.h
> new file mode 100644
> index 000000000000..e69de29bb2d1
> diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
> index 3c6fafbd83a6..55038a65fa61 100644
> --- a/tools/testing/selftests/vDSO/Makefile
> +++ b/tools/testing/selftests/vDSO/Makefile
> @@ -40,6 +40,5 @@ $(OUTPUT)/vdso_test_getrandom: CFLAGS += -isystem $(top_srcdir)/tools/include \
>  $(OUTPUT)/vdso_test_chacha: $(top_srcdir)/tools/arch/$(SRCARCH)/vdso/vgetrandom-chacha.S
>  $(OUTPUT)/vdso_test_chacha: CFLAGS += -idirafter $(top_srcdir)/tools/include \
>                                        -idirafter $(top_srcdir)/arch/$(SRCARCH)/include \
> -                                      -idirafter $(top_srcdir)/arch/$(SRCARCH)/include/generated \
>                                        -idirafter $(top_srcdir)/include \
>                                        -D__ASSEMBLY__ -Wa,--noexecstack

