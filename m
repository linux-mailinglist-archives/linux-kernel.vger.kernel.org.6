Return-Path: <linux-kernel+bounces-305001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978319627EE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD3A71C23F1F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D82817BB1A;
	Wed, 28 Aug 2024 12:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WdlDOlkB"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8C417ADEE
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 12:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724849833; cv=none; b=qXkbXOMyB5vXbwmDPcBGXpL/Qn41aWuCgwFZTpXEah3lfhqnIYnEGyhVzHwE8Gfx/C5QMjws2rl6JJTwEb/ecx9KZv5Sgu18FIclMIqytkxNXs4xSSHTv4Iq3wgGqWwUs/i7v9Fknt7KFRK4oIzWPWrdAGoYJ550u7nxqQydzQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724849833; c=relaxed/simple;
	bh=en/EQCw2UCDmexMgYYgFv7rBP7dW0WSTzgUrLHoZzkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RZmHPQQad5PKHVPrrGAG4KlHoW9wUu+d8NPMzsDSCaODMej77uAY47H7cI1UFIuNN9tyIwYOg10Ya6Ow6altigQZ6zhwfSj4VdpBD+lBZooWJtyOvKOHBCTibcvET41VxlqWvxP7cDqawJEzE5YL52RUzqFkOMpetyn39rHyllI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WdlDOlkB; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5beb6ea9ed6so7266651a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 05:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724849829; x=1725454629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ctZxfAD8ntCKeFnY2CieEfxm5MdMi7pRARDE5NCrex8=;
        b=WdlDOlkBLNIaM9Q59TBhppt0XIwIm0u1vmFqrSVYYakYfK/7/Yjn9MN7s5YN2X+g3L
         lsAlBt4Kjf7rJ2IWMWqBRZ5xUUikNc/5s1F3XOwOIMGwzNcbnIGMe3i0Es6zaV18RlVY
         14s0Rnzfw4bQF5LNtqWXqIUYXwssvJr4sRktBzUlIFnZBtdnxwSqEbCnuJKaYP1BGsLD
         DcuDIa+T+Q+2baMOaWajhXjF4ZFQ8t4xA8ebnGfRteP5/gT5MpbAixfjKqJ6I3QYx0zc
         DTC10yOHYhMJ0nZFr4f8nv/+5k/p2F5Idt+9x17nVZ4gdsk2IdI9XmsltE8C0m1/agOq
         b5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724849829; x=1725454629;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ctZxfAD8ntCKeFnY2CieEfxm5MdMi7pRARDE5NCrex8=;
        b=N4LxpT/Q58DQZqt0odu835FkntIoGB0ODWUzKDniuS7eH0XBKEbS60C2ymn+T6QbJ0
         VYcO0iZIrS0dyFCJALwoeaXVT7X2ffRWltant0P4IvQN4+a1Wjr6EKz2VTVlGVqqszdt
         rz5BRQa2UcAVXtenheS/9wavnTvrh+aTMCJMY+HnNmeyHaZnJ3+2zwY1qCzQk6mj+l92
         jrAQCzyR1H7QBZhNcE+CMyW32IouEG2Y/FJt/nh9bZpAXLB8S5zbXWXu07wT3zkUiF8Z
         KAURKXt27AOvcjfieeL0SIk+70VFAfnmNlYkImcbRkHcAocjpsCCffIo60RVF5PxLNMK
         Lnxw==
X-Forwarded-Encrypted: i=1; AJvYcCVJc67iFhCCfgBFmzw45tyun9/X4P5CY2gYg5/Mvv+t46YwVDvMp8O7wHwgJNtNKeK9RULIz2+xfAUMwX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUlIsbn0zIlXQWOL2PTmDq5TQ/36pHes72sl7MoT/bJeNB8iWS
	Nvz1uctJKNvCOfNQYqOOLnlZHmLZkOmKlwE6B+c0v90UK8Vifr94qL2nqvNKQfI=
X-Google-Smtp-Source: AGHT+IHmohqHV4r5zKMkFvXWsvsuzW0cndviKtyPlnzSAezp3nS+68u26AFlaYxsmiBisFH9S31E0A==
X-Received: by 2002:a05:6402:51c6:b0:5c2:106b:7194 with SMTP id 4fb4d7f45d1cf-5c2138e0f3bmr1697168a12.3.1724849829063;
        Wed, 28 Aug 2024 05:57:09 -0700 (PDT)
Received: from [10.20.4.146] (212-5-158-46.ip.btc-net.bg. [212.5.158.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb1c4977sm2236807a12.10.2024.08.28.05.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 05:57:08 -0700 (PDT)
Message-ID: <f300d558-9798-40a1-9d11-ec6b6020a1b3@suse.com>
Date: Wed, 28 Aug 2024 15:57:05 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] x86/cacheinfo: Delete global num_cache_leaves
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, x86@kernel.org
Cc: Andreas Herrmann <aherrmann@suse.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Chen Yu <yu.c.chen@intel.com>,
 Len Brown <len.brown@intel.com>, Radu Rendec <rrendec@redhat.com>,
 Pierre Gondois <Pierre.Gondois@arm.com>, Pu Wen <puwen@hygon.cn>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Huang Ying <ying.huang@intel.com>, Ricardo Neri <ricardo.neri@intel.com>,
 linux-kernel@vger.kernel.org
References: <20240827051635.9114-1-ricardo.neri-calderon@linux.intel.com>
 <20240827051635.9114-4-ricardo.neri-calderon@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240827051635.9114-4-ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 27.08.24 г. 8:16 ч., Ricardo Neri wrote:
> Linux remembers cpu_cachinfo::num_leaves per CPU, but x86 initializes all
> CPUs from the same global "num_cache_leaves".
> 
> This is erroneous on systems such as Meteor Lake, where each CPU has a
> distinct num_leaves value. Delete the global "num_cache_leaves" and
> initialize num_leaves on each CPU.
> 
> Reviewed-by: Len Brown <len.brown@intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Cc: Andreas Herrmann <aherrmann@suse.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Chen Yu <yu.c.chen@intel.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Nikolay Borisov <nik.borisov@suse.com>
> Cc: Radu Rendec <rrendec@redhat.com>
> Cc: Pierre Gondois <Pierre.Gondois@arm.com>
> Cc: Pu Wen <puwen@hygon.cn>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: stable@vger.kernel.org # 6.3+
> ---
> After this change, all CPUs will traverse CPUID leaf 0x4 when booted for
> the first time. On systems with symmetric cache topologies this is
> useless work.
> 
> Creating a list of processor models that have asymmetric cache topologies
> was considered. The burden of maintaining such list would outweigh the
> performance benefit of skipping this extra step.
> ---
> Changes since v4:
>   * None
> 
> Changes since v3:
>   * Rebased on v6.7-rc5.
> 
> Changes since v2:
>   * None
> 
> Changes since v1:
>   * Do not make num_cache_leaves a per-CPU variable. Instead, reuse the
>     existing per-CPU ci_cpu_cacheinfo variable. (Dave Hansen)
> ---


Overall LGTM, one minor nit below which is not a deal breaker.


Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

>   arch/x86/kernel/cpu/cacheinfo.c | 44 +++++++++++++++++++--------------
>   1 file changed, 26 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
> index 392d09c936d6..b5e216677a46 100644
> --- a/arch/x86/kernel/cpu/cacheinfo.c
> +++ b/arch/x86/kernel/cpu/cacheinfo.c
> @@ -178,7 +178,16 @@ struct _cpuid4_info_regs {
>   	struct amd_northbridge *nb;
>   };
>   
> -static unsigned short num_cache_leaves;
> +static inline unsigned int get_num_cache_leaves(unsigned int cpu)
> +{
> +	return get_cpu_cacheinfo(cpu)->num_leaves;
> +}
> +
> +static inline void
> +set_num_cache_leaves(unsigned int nr_leaves, unsigned int cpu)
> +{

nit: I think it's more natural to have the cpu parameter come first.
> +	get_cpu_cacheinfo(cpu)->num_leaves = nr_leaves;
> +}
>   
>   /* AMD doesn't have CPUID4. Emulate it here to report the same
>      information to the user.  This makes some assumptions about the machine:


<snip>

