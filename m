Return-Path: <linux-kernel+bounces-200580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 534CC8FB211
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1D39B226E6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47539145FFA;
	Tue,  4 Jun 2024 12:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="qtRuht1T"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177B3145FE4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717503823; cv=none; b=e/ihSKFwNvD3KJlxXCEj5uhzGGi5Vfwo4ySUbJm5PWMBuEAWg6SiysC6bT53QaYli7E5GR2RtU+nk0A8ywZVlv0u9ud1wDWSDTWo2+YSLqjVoYdDSGG8/hqI/c8INXmt+yDE2Ppv52NHHVeeg2qCrd1N1i7PM96NzyZEEY/lDQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717503823; c=relaxed/simple;
	bh=pJ8H3OVU1c6IKHhJWjKqHXekB9Q4BtWpxv/w8o99SpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abXyPcTFhlD2p3EqgdD3ZmiMk3T3nqYxLCsuBuFOC3PPR1ZUWXRc5qiuko+r/q9hkX/vQK4h5RXRdEZfRK12xf1dtNXfevm8rMuqo6+NLifbGBlitBHxqMZpA/u130p1NCV7DrzUkwzlA4vkhkDJBpi6D7JT8vp4lfTDFf6vums=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=qtRuht1T; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so39301951fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 05:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1717503819; x=1718108619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nDT2bdM/4/u6WBFZYLUGZAG2i8Sme/HZ9vIEUuTgqF8=;
        b=qtRuht1Txt9xVm50fip4fbI8Us0Dw4z9pM4tdvKZSezzH4MLg+KHHP/4yMv9a36Nd5
         VoxaDSLzDN5ZFBszS5iQKeGdkTZH94KlE+R5QEOq1ZilJNIrhxwl4a6PINj6VUsxfsQM
         qqGgeds8YkfBgX7ryHxx44sLPGnqun9EexL4qZlYJrl5Ov3eNMw2CsyIgujI6XKqRUe1
         7oVWr9gaEwS7kU3u62ZzxwNkpxBtyCJrkeHBtBhzFKyIk1JqGhQCMriWqAsb/N/Lk+rr
         Wxcxvh+tmNNQVN7UHgI6ZVCa411zcvMMmoVJlkcku7QurKlinysdwkCjj5ItenER9+i4
         oeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717503819; x=1718108619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDT2bdM/4/u6WBFZYLUGZAG2i8Sme/HZ9vIEUuTgqF8=;
        b=jJynFO+R4kulroBV5pxeQWm0t8DgrZVQtjU1TS2NKDJHC8p/oFy7/euxhh8QVc6j8F
         lOOKQYFAjMgrwb3LKh9zChWJbKHeiOYc+pp6LqMNaobL4Qi3eDRoeWLvbgVFz7MHkpAx
         Zhfx+o4CmTECIu3COGYl7VgP6gnbIRBHtLViPtz4qDbzJB2RZ7iSGWDfitar2avwu0Bg
         dFB+v44+CtAnXG92vCT30g7qwONhR/Tdkg3SdqGatxkPfjHcWNrm6gbdJXIdhSw9huFs
         fDCuIz+QI2hKQ4Nz++0GeP9Czw7IKo1A8Kovpf8myihCr7tzis4b0I8Raaq6eE2va1l2
         BfvQ==
X-Gm-Message-State: AOJu0YzXqvjS5wA4Rbx/o/3V/UoseBClJKpU5UqzllHhOZ4zWy60e+p8
	u39vIo75qm9F77woaHm1AZuedLAW0FQxJz8K1xzn5uDYUuiWP2fMttTBe7+oaL1ItalXVmzsgnN
	+
X-Google-Smtp-Source: AGHT+IHVA2KZIKXkday394OQoHEQsAb8ys1XYmwHymcCWzs5rATPUFPYEXXC8yFBjceeQeSdZrSmRA==
X-Received: by 2002:a2e:978b:0:b0:2ea:7e9c:eb8f with SMTP id 38308e7fff4ca-2ea95153dc7mr97900971fa.24.1717503818985;
        Tue, 04 Jun 2024 05:23:38 -0700 (PDT)
Received: from airbuntu ([87.127.96.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4213860126fsm104473445e9.40.2024.06.04.05.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 05:23:38 -0700 (PDT)
Date: Tue, 4 Jun 2024 13:23:37 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Phil Auld <pauld@redhat.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] sched,x86: export percpu arch_freq_scale
Message-ID: <20240604122337.jknxekohcu23v7dz@airbuntu>
References: <20240530181548.2039216-1-pauld@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240530181548.2039216-1-pauld@redhat.com>

On 05/30/24 14:15, Phil Auld wrote:
> Commit 7bc263840bc3 ("sched/topology: Consolidate and clean up
> access to a CPU's max compute capacity") removed rq->cpu_capacity_orig
> in favor of using arch_scale_freq_capacity() calls. Export the
> underlying percpu symbol on x86 so that external trace point helper
> modules can be made to work again.

To expand. The problem here is that arch_scale_cpu/freq_capacity() are defined
in headers, but they rely on per cpu variables that are not exported for x86,
but are exported for arm (and riscv at least) in drivers/base/arch_topology.c

One user is sched_tp to help create trace events to track when capacity
changes. Not critical user, but this brings x86 inline with the rest of the
code.

> 
> Signed-off-by: Phil Auld <pauld@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Qais Yousef <qyousef@layalina.io>
> ---
>  arch/x86/kernel/cpu/aperfmperf.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
> index f9a8c7b7943f..b3fa61d45352 100644
> --- a/arch/x86/kernel/cpu/aperfmperf.c
> +++ b/arch/x86/kernel/cpu/aperfmperf.c
> @@ -345,6 +345,7 @@ static DECLARE_WORK(disable_freq_invariance_work,
>  		    disable_freq_invariance_workfn);
>  
>  DEFINE_PER_CPU(unsigned long, arch_freq_scale) = SCHED_CAPACITY_SCALE;
> +EXPORT_PER_CPU_SYMBOL_GPL(arch_freq_scale);

x86 uses the generic arch_scale_cpu_capacity() in sched/topology.h, so this
should make arch_scale_freq_capacity() 'work' for x86 too.

Reviewed-by: Qais Yousef <qyousef@layalina.io>

>  
>  static void scale_freq_tick(u64 acnt, u64 mcnt)
>  {
> -- 
> 2.43.0
> 

