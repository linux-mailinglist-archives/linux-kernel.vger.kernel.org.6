Return-Path: <linux-kernel+bounces-429970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9949E29D3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B1781648A8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6C21FC7EC;
	Tue,  3 Dec 2024 17:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GIIC6FEE"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318371E492D
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 17:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733247999; cv=none; b=aFDZhQW70koJ3IiPSTpbDNkZg5LiARukJPm6NqMK31EbWmu6Wc+rJGbS6P+GBkAJDl8IG+38SRYhreLkg2T6Zw5JPcHyyvPHYen1vcfy3ov4QL+H8hFS5wJD6uMTaAATUCBoSTuFiZIXWQXk3af1/QbivtttcgWlGxwSU1TSHwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733247999; c=relaxed/simple;
	bh=7ZIAPMkPeTEbfvq7656BNyWbZaPIwCHNSn6wtGvXZw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YNIbN1v/lQvOXs1TSRZMl006ZlvSDjUkMk4RIYAY4AGkWKxbwnU68KtgVnHVgifkcYr7KagQ55boKKuE3XFqzl33OcctrYarq6+cwA+dmJTIaADy5c2TZXnsmDoB8EvA5BI33SGIHtAk1O9WjdyJFXKdiO7ntBMFpqa1sHRDSCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GIIC6FEE; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434a2f3bae4so54256465e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 09:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733247995; x=1733852795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iFxdVjj7PZ/N/qs/J/1mLWKxmYr4aiVLL3tA6PIFZOU=;
        b=GIIC6FEEvpW/uv0jC4Fi7QOkqOAwpe9h/oixQK9dppf1Y+YbVSokNqg98l22EVzRx9
         07bliXvney/T3VOgeEwI5ufoVArDeUlsEsHoux1qZw5fXuQGs8Gt2RNoB75js5KPiNZ4
         Ju8+yQtFXJhmMkjp/zSzgVVFx3YjKOVQi95TGhE1F5R7WYpZkKSR2JdpbmsioXbL2MR8
         7zmncLSBriGWv1Oo2hzI2g0GOfIOAGZQuFw/POZXglAJ1U/+adA3aBTxgntKZuQdOIk/
         TJKjtngQ8pkCJKmLv9uVb05UYSZr5uJbnYqVuIJDF+Yt/cdrbzBrfE+6RaG/ZFPALbFD
         yj1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733247995; x=1733852795;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iFxdVjj7PZ/N/qs/J/1mLWKxmYr4aiVLL3tA6PIFZOU=;
        b=pRLzPHH//yJ0KzEEcDTPPPeBHHJMBUMzjo4Y9mZWG7jiAjZPBmYr8d9z4dVFwqrPoB
         NJZ2LINtTMSST1KFFjdcGbtvb0KC5yv5+a8kGQSWTMszs7cm1aLjwwV7hivL8zLQjtsU
         +SlZUAGhmTkTNALyOmYTzenrYylQpguSiQ/1Py8D3AWWdPgvzFWJ41DPBA/UzN1CxyJP
         ieSb7vSde/pEz8NGIgSxFgFdxiz2GxvBVV1myK/c1vi2kw82nlMe6xBhH3zRoS9OeZhK
         B2muL/KZucNcQmW+RFQQBXGNesatDoZemKtJtqAK0GodK4JX/+fDy6fD/SegGD9LEWGE
         iZkw==
X-Forwarded-Encrypted: i=1; AJvYcCXPEsng21WcZLh/uXV+d76jvrf21fWucLRwGQxDAwY81JVgnLg3ahogzV3vuFXgdANvYTn0EWrbo8Lln3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTBHUP37f56PUqH+Zw1xAvHyWqlRzk00aFBiErzYEZxXk1kB9F
	gVZtOopovhGJ1LvgHjCxTMNG645prAztfFB1cMOPB0Xo9pJGsPZIJRn7xDCvaVQ=
X-Gm-Gg: ASbGncs6UeT88zwXuhdRAUyyFQpoOY6/8dh0lbzPdROYovfkbd3firWf6DXh00Gb0Rp
	/7+0z122mMaJjfj3cBatzImjzjRqE1unxdSr/x/7ITVU5g9SPVfRJ3i/vwnEgibGunaX+01MsM2
	fzSmq8NZh7yYjWPqK3Eh7jNspa/HgLWkOwJGhfY6TuNklaYBUQKmKBcEN8WcTvNI0FsbC2E8Lmm
	f5QKj6d2ub5+ksuH1QED3pkcurnemp34P/xGdvCqre031CUbon23VkMW8+Y1HWXgOHTIdGjzKw=
X-Google-Smtp-Source: AGHT+IHsn0zhsY3RgS4QgXAl/s0nx8qN5jv8ueOZFuunzjyiUev362zciGDLjEQzLbYMzDUDDjWbjA==
X-Received: by 2002:a05:6000:4912:b0:385:f23a:2fe1 with SMTP id ffacd0b85a97d-385fd3f176amr3319514f8f.26.1733247995510;
        Tue, 03 Dec 2024 09:46:35 -0800 (PST)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [85.187.217.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa74f18bsm234796265e9.4.2024.12.03.09.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 09:46:35 -0800 (PST)
Message-ID: <b2bacaab-8264-4532-9a8b-e060f50d41ca@suse.com>
Date: Tue, 3 Dec 2024 19:46:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/tdx: Dump attributes and TD_CTLS on boot
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20241202072458.447455-1-kirill.shutemov@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20241202072458.447455-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2.12.24 г. 9:24 ч., Kirill A. Shutemov wrote:
> Dump TD configuration on boot. Attributes and TD_CTLS define TD
> behavior. This information is useful for tracking down bugs.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>


> ---
>   arch/x86/coco/tdx/Makefile        |  2 +-
>   arch/x86/coco/tdx/debug.c         | 69 +++++++++++++++++++++++++++++++
>   arch/x86/coco/tdx/tdx.c           | 27 ++++++++----
>   arch/x86/include/asm/shared/tdx.h | 39 +++++++++++++++--
>   arch/x86/include/asm/tdx.h        |  3 ++
>   5 files changed, 128 insertions(+), 12 deletions(-)
>   create mode 100644 arch/x86/coco/tdx/debug.c
> 
> diff --git a/arch/x86/coco/tdx/Makefile b/arch/x86/coco/tdx/Makefile
> index 2c7dcbf1458b..b3c47d3700e2 100644
> --- a/arch/x86/coco/tdx/Makefile
> +++ b/arch/x86/coco/tdx/Makefile
> @@ -1,3 +1,3 @@
>   # SPDX-License-Identifier: GPL-2.0
>   
> -obj-y += tdx.o tdx-shared.o tdcall.o
> +obj-y += debug.o tdcall.o tdx.o tdx-shared.o
> diff --git a/arch/x86/coco/tdx/debug.c b/arch/x86/coco/tdx/debug.c
> new file mode 100644
> index 000000000000..cef847c8bb67
> --- /dev/null
> +++ b/arch/x86/coco/tdx/debug.c
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#undef pr_fmt
> +#define pr_fmt(fmt)     "tdx: " fmt
> +
> +#include <linux/array_size.h>
> +#include <linux/printk.h>
> +#include <asm/tdx.h>
> +
> +#define DEF_TDX_ATTR_NAME(_name) [TDX_ATTR_##_name##_BIT] = __stringify(_name)
> +
> +static __initdata const char *tdx_attributes[] = {
> +	DEF_TDX_ATTR_NAME(DEBUG),
> +	DEF_TDX_ATTR_NAME(HGS_PLUS_PROF),
> +	DEF_TDX_ATTR_NAME(PERF_PROF),
> +	DEF_TDX_ATTR_NAME(PMT_PROF),
> +	DEF_TDX_ATTR_NAME(ICSSD),
> +	DEF_TDX_ATTR_NAME(LASS),
> +	DEF_TDX_ATTR_NAME(SEPT_VE_DISABLE),
> +	DEF_TDX_ATTR_NAME(MIGRTABLE),
> +	DEF_TDX_ATTR_NAME(PKS),
> +	DEF_TDX_ATTR_NAME(KL),
> +	DEF_TDX_ATTR_NAME(TPA),
> +	DEF_TDX_ATTR_NAME(PERFMON),
> +};
> +
> +#define DEF_TD_CTLS_NAME(_name) [TD_CTLS_##_name##_BIT] = __stringify(_name)
> +
> +static __initdata const char *tdcs_td_ctls[] = {
> +	DEF_TD_CTLS_NAME(PENDING_VE_DISABLE),
> +	DEF_TD_CTLS_NAME(ENUM_TOPOLOGY),
> +	DEF_TD_CTLS_NAME(VIRT_CPUID2),
> +	DEF_TD_CTLS_NAME(REDUCE_VE),
> +	DEF_TD_CTLS_NAME(LOCK),

nit: That's a bit wasteful for sparsely populated fields but I guess the 
extra complexity of having a struct in the array with the bit definition 
and the name isn't worth the space saving.

> +};
> +

<snip>


