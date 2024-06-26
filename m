Return-Path: <linux-kernel+bounces-230336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 759AF917B68
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD776B255BA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D695D167DB7;
	Wed, 26 Jun 2024 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ty26Cz2R"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EF7EEC3
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 08:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719391942; cv=none; b=R97g4CptnBjREHPigUkXaQXBBrajrUL/GBRMn4t0P1Us87jsnt76Ti8/qBjdfM1Gx/H0Ti7cmepdh7uJA81uQhAZXz4H1/pzKFl/Isx2WKKtIwyRP/1HEEk3k4KjDFs9mse41zMCuCU4uCgA8TxutMwMkH+mouLtbTHFP9P8jsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719391942; c=relaxed/simple;
	bh=8vHmrJcwys+86ECp4vQk4mlr9NLaMvMBDlphuYd4Hv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i61UowEHf0gdRjGmnN+UymoAZxoAFfoDhDQ1H5u2CmrSupMTLc61nnqCnjJrlfgDIshP1KpaW0fp5wF5Xb/auRuhecM7sfuU0Ly3KBS6S5CJsm16lMByhYTJRRketUSUwLZGn16zXgj7cvtonz35rzFCgf89BksA1W2VP35td7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ty26Cz2R; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so100916641fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 01:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719391938; x=1719996738; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KnFVdy4+ae2BUOnNtfAoMiKw5cr1cs0xDtfUlQA/s0g=;
        b=Ty26Cz2RzVI3HWhM4FWVs2hkf9Bjq96h6OnSYF3+844bIf963qz7PKtj8Kp5UJTdVV
         Kuj+9hQ2GvFg9pNpy9VeLA7dhvsGLYBz8H08LtjScbEJMPB8JzsXH2uS4gMpE4l9fNyn
         5vQGzq5/FkCU458ApOTLpBFEkpZ5n/i81+JdOVDdHxJbipOeLrYPCVZB2UFvOAPmT5iR
         u2tdvhn3hXsweiLUivPRO6n/HeyXpPEc5umRYrW8+Nc7spmDfzYvJP5upDatx9FNFw2X
         0u55BdrBjssbCWPY69ezHaet2Am3d9IFEyeemCRj0RW+7F8NzellUego7VdjHApkzkw+
         wHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719391938; x=1719996738;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KnFVdy4+ae2BUOnNtfAoMiKw5cr1cs0xDtfUlQA/s0g=;
        b=ebvA+C71OCC8+z2t1TsJqTwlzzSTvFrWDuzRHLKOfXvhuUx01nJtUhRuwEG5oFqgvF
         Gt2mIAy/o657cMqhNWtm1AHyu38kWkwQUvCx3yAoWLCyDK2Tgny7RgOVWCQ3Q1YOHIYz
         +0Fd+4jDBhBc99n9SVKCcI/th0xQ49FxFez5kEJ2uRIpEwthMbQZz6YuC462E3WB6kn4
         14zJXtlm95DvQRjGJKa/bPibuJlzbBuqlmfoqeAKtVFDIseXbCQX7V8ZFy0fnhVhoxwC
         xZy7CzLG1EydY1aauSayaIwXgLBeGB5MIV9pNExJ+5v5RrmLiuSAUGgDXkAShGWFe9d4
         QyLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuSbjBjY2CnO4v3rIwsneyNPir/u/iXOgNrcei4LXciFslhyC+pJT7Rh+UYWBN7TPQyp+7VryjvuAgJNSK+PYJOviREPg6jjdpjrhX
X-Gm-Message-State: AOJu0Yw3Mek05Z+o7rtfQCyLcSlQpF+bum6911m7XFCqSxUnN2JWBsMO
	hGw2LmKHyZq7j1Ss3Z8/kTaRUY/D5/rRR/Y35H2x7FHzDe2hbOIf/M86xtfZTw==
X-Google-Smtp-Source: AGHT+IEuFuL4yWPCdBXokIYl02WfiKm6TAR4Czd6HSjI2CaAH/tBF03BEkRSssAGep22B7jjqefRwQ==
X-Received: by 2002:a2e:7c07:0:b0:2ec:4f0c:36f9 with SMTP id 38308e7fff4ca-2ec5b31d140mr78269471fa.36.1719391937973;
        Wed, 26 Jun 2024 01:52:17 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb329b83sm94479965ad.115.2024.06.26.01.52.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 01:52:17 -0700 (PDT)
Message-ID: <0b55dcb7-dbba-4c90-b0a2-9e158317f88a@suse.com>
Date: Wed, 26 Jun 2024 10:52:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen: Fix null pointer dereference in xen_init_lock_cpu()
To: Ma Ke <make24@iscas.ac.cn>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 jgross@suse.com, boris.ostrovsky@oracle.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com
References: <20240626074339.2820381-1-make24@iscas.ac.cn>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
Autocrypt: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJgBBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AACgkQoDSui/t3IH4J+wCfQ5jHdEjCRHj23O/5ttg9r9OIruwAn3103WUITZee
 e7Sbg12UgcQ5lv7SzsFNBFk3nEQQCACCuTjCjFOUdi5Nm244F+78kLghRcin/awv+IrTcIWF
 hUpSs1Y91iQQ7KItirz5uwCPlwejSJDQJLIS+QtJHaXDXeV6NI0Uef1hP20+y8qydDiVkv6l
 IreXjTb7DvksRgJNvCkWtYnlS3mYvQ9NzS9PhyALWbXnH6sIJd2O9lKS1Mrfq+y0IXCP10eS
 FFGg+Av3IQeFatkJAyju0PPthyTqxSI4lZYuJVPknzgaeuJv/2NccrPvmeDg6Coe7ZIeQ8Yj
 t0ARxu2xytAkkLCel1Lz1WLmwLstV30g80nkgZf/wr+/BXJW/oIvRlonUkxv+IbBM3dX2OV8
 AmRv1ySWPTP7AAMFB/9PQK/VtlNUJvg8GXj9ootzrteGfVZVVT4XBJkfwBcpC/XcPzldjv+3
 HYudvpdNK3lLujXeA5fLOH+Z/G9WBc5pFVSMocI71I8bT8lIAzreg0WvkWg5V2WZsUMlnDL9
 mpwIGFhlbM3gfDMs7MPMu8YQRFVdUvtSpaAs8OFfGQ0ia3LGZcjA6Ik2+xcqscEJzNH+qh8V
 m5jjp28yZgaqTaRbg3M/+MTbMpicpZuqF4rnB0AQD12/3BNWDR6bmh+EkYSMcEIpQmBM51qM
 EKYTQGybRCjpnKHGOxG0rfFY1085mBDZCH5Kx0cl0HVJuQKC+dV2ZY5AqjcKwAxpE75MLFkr
 wkkEGBECAAkFAlk3nEQCGwwACgkQoDSui/t3IH7nnwCfcJWUDUFKdCsBH/E5d+0ZnMQi+G0A
 nAuWpQkjM1ASeQwSHEeAWPgskBQL
In-Reply-To: <20240626074339.2820381-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26.06.2024 09:43, Ma Ke wrote:
> kasprintf() is used for formatting strings and dynamically allocating
> memory space. If memory allocation fails, kasprintf() will return NULL.
> We should add a check to ensure that failure does not occur.
> 
> Fixes: d5de8841355a ("x86: split spinlock implementations out into their own files")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Found this error through static analysis.
> ---
>  arch/x86/xen/spinlock.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
> index 5c6fc16e4b92..fe3cd95c1604 100644
> --- a/arch/x86/xen/spinlock.c
> +++ b/arch/x86/xen/spinlock.c
> @@ -75,6 +75,8 @@ void xen_init_lock_cpu(int cpu)
>  	     cpu, per_cpu(lock_kicker_irq, cpu));
>  
>  	name = kasprintf(GFP_KERNEL, "spinlock%d", cpu);
> +	if (!name)
> +		return;
>  	per_cpu(irq_name, cpu) = name;
>  	irq = bind_ipi_to_irqhandler(XEN_SPIN_UNLOCK_VECTOR,
>  				     cpu,

While yes, error checking would better be added here, this isn't enough.
You're treating an easy to diagnose issue (at the point where the NULL
would be attempted to be de-referenced) for a possibly more difficult to
diagnose issue: Any such failure will also need propagating back up the
call stack.

Jan

