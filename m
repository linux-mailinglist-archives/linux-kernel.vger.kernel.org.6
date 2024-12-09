Return-Path: <linux-kernel+bounces-437147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 863AB9E8FA0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 465AE1885B69
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E336C215F57;
	Mon,  9 Dec 2024 10:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bIad6Yex"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCCC174EDB
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 10:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733738705; cv=none; b=qZo/k6KqTCqLeWlrtr/8mNAJ7SaSEMt9pNMaUZcqZXrDzu7pa7/rfutYDaYfaCi+mDnlQq3b2+xUu3G2A2wHzKqlaPYToh9iuUib14F51BFWBcSBWsZCKDmihHIeLomgUaQhJPIsgld0p5cUViw8mW5T04ExGLpB5nD4TrUINK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733738705; c=relaxed/simple;
	bh=AGXtCb0LfqHtRusnKYsEVEPUOpJEsJVM9qi5Yl+09Pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HhGqP+OkeqBs41kDYUDNk1jCFD09E1KuHoQ6CbPnA9y4FpMVXbaFU1Gl1UbqNpERur8u3ihtVTBLSKNzai7Ca8Veq9jQzAwiGl+1FQWTA8lu8AyeMYVmgVFu5/3Q0gQtcvkwopbtdNtLZUGsUzLcco/IH4SNaWWLvPqkLwPumac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bIad6Yex; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434e9716feaso9444605e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 02:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733738701; x=1734343501; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m7IgHTFnElHj8LHSL2zttzGa0TlfPS3g9WeiUH2crnw=;
        b=bIad6YexuX3socf7tZL2+/qnksdyE7lmRU6r2lzezkERlxbaJN5XYY06On7F2tA07o
         KD/v2KvTWK9hvUTKKnaL1gu2vIwgvT7MiHcl07scFyFz6ixllXdh+LaLyJHvmIyjvrLt
         4FN4BT7T862EWodQQUhikvMww7qQQHaUh/7Bw9rFna0AQTM1Py25w7fDzZuLkjn4wH+n
         gHx5FWf2lgL9/A57pjJySqaaysFGIbr+SQS7xzrcjmVX1rXtL6YbXnp5XYpEM6RrTQj1
         3XJa0gVDpWdtGpptN1qgLO7+2x1pHQzzFTnmgzSmNQeGA3EsOIS0njbpA1SUN6me8xcj
         jr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733738701; x=1734343501;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7IgHTFnElHj8LHSL2zttzGa0TlfPS3g9WeiUH2crnw=;
        b=Aj9B5wEQAdlwceuirS40WO6sUOCGpV8I6Kuxin+4vJ30GjsZ18PpFW/WdjAJwcEEAJ
         2NG/7pmJz2Sh8s0pKSFKy2Y5mScsuOXojtsDdYVtC3oeiNdZMbX/kfId9Gpub/iVgndL
         Dz7mPUQe12cKJgbvmea2ZOykFuPRd+HHPeQS7SPTqJU/lhaj1YqOYvMg9TqGuY5d2qFV
         sGir73WmE8GGvMzHjmSm8luxRRrtnFQywiCxbPm9kq7WRR0B6zX2dHnHUnvuI8H/jzlm
         RQFK1I9QsMReV5id9bZ2Nb7Fj84H9+jx9o3x9/zJZ1XXZzXTSplqm685jp8ub2QW6bc3
         Tj2w==
X-Forwarded-Encrypted: i=1; AJvYcCXpAncJoLYxEnInb3dPqSjU66h7uajCvyY3N5k9lo/e7gG0mSY2lUCqgyXGFVh/2555DV+C3Dr6By+pA/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl/JdkSelcVr01buzo/tmSd9srdH+EFwCn/rZZJdQFtv9CLYuS
	+8MI475AZzTPLzIxJvIxBihsSTLiq4JMO6/liNlQFngpurYYIK5FqMYQRWgfmA==
X-Gm-Gg: ASbGncuFd8xvlY40SZca6r3KfUwpPNSLfEHF1xJLFgck4+7tQEHqEIXeXTEjBbhPcm7
	0mTvX8+jh4M1qj2O5cMvO/IvbwKIS4FykB7jfnu0i0p7gv3jt9CfElbVMaB+q0D5LK3xkOKOjCy
	bhpqcVfDW/RF2p70VVediPeGJfyvMpVSefvYBZqjv3aUKPc8+ljjIOLQzdZCNgfw8Fqt3f/amW6
	aAHYf1xzG/ZuKqHubPPGQ3Rj1H8UhvvzCrnEqUlTCovPtSFj89e5bDDhp47L6LmlhywKs8RCfW5
	qnuxV1l/ou0BTEqMJX/MZWpAzHbXURZleKE=
X-Google-Smtp-Source: AGHT+IEnfvCRcF0/n98UeB42/2lit+SYcQYhp9aQu4bytpgLstYwUybJ0NOfoPhXqV0YtAJFO/FmRA==
X-Received: by 2002:a05:6000:1ac8:b0:385:fc32:1ec3 with SMTP id ffacd0b85a97d-3862b36b015mr8399209f8f.20.1733738701401;
        Mon, 09 Dec 2024 02:05:01 -0800 (PST)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2708b93dsm9497925a91.51.2024.12.09.02.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 02:05:00 -0800 (PST)
Message-ID: <ccb28ccc-531c-4ead-9a27-76cc430f8c35@suse.com>
Date: Mon, 9 Dec 2024 11:04:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/xen/mmu: Increase MAX_CONTIG_ORDER
To: Thierry Escande <thierry.escande@vates.tech>
Cc: sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
 xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
 linux-kernel@vger.kernel.org
References: <20241204171346.458105-1-thierry.escande@vates.tech>
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
In-Reply-To: <20241204171346.458105-1-thierry.escande@vates.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04.12.2024 18:14, Thierry Escande wrote:
> With change 9f40ec84a797 (xen/swiotlb: add alignment check for dma
> buffers), the driver mpt3sas fails to load because it cannot allocate
> its DMA pool for an allocation size of ~2,3 MBytes. This is because the
> alignement check added by 9f40ec84a797 fails and
> xen_swiotlb_alloc_coherent() ends up calling
> xen_create_contiguous_region() with a size order of 10 which is too high
> for the current max value.
> 
> This patch increases the MAX_CONTIG_ORDER from 9 to 10 (4MB) to allow
> such allocations.
> 
> Signed-off-by: Thierry Escande <thierry.escande@vates.tech>
> ---
>  arch/x86/xen/mmu_pv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
> index 55a4996d0c04..7f110740e1a2 100644
> --- a/arch/x86/xen/mmu_pv.c
> +++ b/arch/x86/xen/mmu_pv.c
> @@ -2200,7 +2200,7 @@ void __init xen_init_mmu_ops(void)
>  }
>  
>  /* Protected by xen_reservation_lock. */
> -#define MAX_CONTIG_ORDER 9 /* 2MB */
> +#define MAX_CONTIG_ORDER 10 /* 4MB */
>  static unsigned long discontig_frames[1<<MAX_CONTIG_ORDER];

While lacking respective commentary, bumping this value imo also needs to
take into account Xen itself, at least commit-message-wise. The bumping is
fine for Dom0 in any event. It is also fine for DomU-s with the defaults
built into the hypervisor (orders 12 and 10 respectively for x86 and Arm),
yet especially for Arm (and in the future PPC and RISC-V) any further
bumping would be less straightforward.

However - does the driver really need this big a contiguous chunk? It
would seem far more desirable to me to break that up some, if possible.

Jan

