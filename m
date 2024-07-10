Return-Path: <linux-kernel+bounces-248232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D13792DA69
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 22:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3D56283269
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 20:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053E8198833;
	Wed, 10 Jul 2024 20:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3S4hCWbQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QaWny3g5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01ECF18C161
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 20:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720644706; cv=none; b=OITR/gkATd+gQwDcNp8vQCyNtCST83u49cC2JIe2x0QF1smc9DK6YEGtCqqZYgcdYHD+59sRTCd4EwIB3WtGByyuYoB1xC6DGq5KexJiuxGBXvWc9OaTTMLBq4vOkhQ4B+u0+alm5v0o/e6v+0TTAjRd+pYbGI3GIlzOn0Q8EBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720644706; c=relaxed/simple;
	bh=mM7urxq3H6CqC5/7nFaBFe9nr5abGJX0Y0GRZMsnUsk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AnUqVavQZ2kRp8XX2IxlDebnZzxMhKDGprIB0cH/LVK4zJjwTnu4BhYB8Ir/EDlpOwZudz/JqVO3+cU8/sDlbcq7XeMr8TXKcm1udH4kAZQBJr2JJ6pY5k2ixZ+6I/5Q3eXWSj9d3MdJ/h66G34Tw/QPjNam4C9adF6I2IXZlNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3S4hCWbQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QaWny3g5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720644702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1b/sQFS4yBt+s8M+2F5hEDBh21vdQF31Q8cakLMnlPU=;
	b=3S4hCWbQPadDOYunyyU9VAq0zh6073fXDDG3rN3zCVRzJHAJQY2pd8OfTB9vWNC2KEkjKH
	vIjEWvb+R7EIKf7volrSt3WtwUarq+NVfR7I4xOfhINEtO9qHc7Y2KxeUEjXGPJKTibvMX
	4OwCsELydCfRfJTdDX2d3M/07clYIDLd7JSJHKlpLtKpdHADmMzqZD/Uea8VUUfjKhCA8N
	HA4xa+pHsWE5Uo3U36C15HSO5TIeQ45xPs3hN97m1Q5V1a1yCy2SFF2CLLtVh0Ouob6V6/
	bfFvvzW0A4J4KAOOi6inYudy9GsJf3Vyh9HiQISLRBZ9GmnirxXEkGUAz8wO+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720644702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1b/sQFS4yBt+s8M+2F5hEDBh21vdQF31Q8cakLMnlPU=;
	b=QaWny3g5WGuM0G7Px5JNq5n3B+fofn8axJVnAdexUNyDugfoYtAjjCp3IRIroyBBIAGKQa
	Y0idusv3eL7W4XCw==
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, Peter Zijlstra
 <peterz@infradead.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>
Cc: linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, Jiaxun Yang
 <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 1/3] cpu/hotplug: Make HOTPLUG_PARALLEL independent of
 HOTPLUG_SMT
In-Reply-To: <20240705-loongarch-hotplug-v1-1-67d9c4709aa9@flygoat.com>
References: <20240705-loongarch-hotplug-v1-0-67d9c4709aa9@flygoat.com>
 <20240705-loongarch-hotplug-v1-1-67d9c4709aa9@flygoat.com>
Date: Wed, 10 Jul 2024 22:51:42 +0200
Message-ID: <87le29ug0x.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jul 05 2024 at 11:29, Jiaxun Yang wrote:
>  
> +#ifdef CONFIG_HOTPLUG_SMT
>  static inline bool cpuhp_smt_aware(void)
>  {
>  	return cpu_smt_max_threads > 1;
> @@ -1817,6 +1818,7 @@ static inline const struct cpumask *cpuhp_get_primary_thread_mask(void)
>  {
>  	return cpu_primary_thread_mask;
>  }
> +#endif

Please provide stub functions in an #else clause

#else
static inline bool cpuhp_smt_aware(void) { return false; }
static inline cpumask *cpuhp_get_primary_thread_mask(void) { return NULL; }
#endif

or something to that effect.

>  /*
>   * On architectures which have enabled parallel bringup this invokes all BP
> @@ -1837,6 +1839,7 @@ static bool __init cpuhp_bringup_cpus_parallel(unsigned int ncpus)
>  	if (!__cpuhp_parallel_bringup)
>  		return false;
>  
> +#ifdef CONFIG_HOTPLUG_SMT

That way you spare the ugly #ifdef here in the middle of the code and
the compiler can optimize it out.

>  	if (cpuhp_smt_aware()) {
>  		const struct cpumask *pmask = cpuhp_get_primary_thread_mask();
>  		static struct cpumask tmp_mask __initdata;
> @@ -1857,6 +1860,7 @@ static bool __init cpuhp_bringup_cpus_parallel(unsigned int ncpus)
>  		cpumask_andnot(&tmp_mask, mask, pmask);
>  		mask = &tmp_mask;
>  	}
> +#endif

Thanks,

        tglx

