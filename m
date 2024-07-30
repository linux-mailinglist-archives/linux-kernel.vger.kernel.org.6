Return-Path: <linux-kernel+bounces-267009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 003E9940B2F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A980B1F23E2F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1631922FB;
	Tue, 30 Jul 2024 08:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q1sYKjeQ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896C2167D83
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722327766; cv=none; b=mzqKqoFsWHvUpS9MCNEAseNtyCiftDn3lGARt2kF+h/NcqsCfxTOjX056+48YKlBIs/aPazhKVnNK2/f3iRyHUTd5mWNK6d4CYT3n3RNqqmzhunKaRfHoSki6MZWnE6uJV62d3dUhuwDKAGwJC4fMjyjFsJv0K+aN88ZX26FVd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722327766; c=relaxed/simple;
	bh=qIlviDQo2AKmQo5tMu+8UJtd/6aI2D4IPx4Vx7k/oNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DlF/0rbO6zMtriEBkAQGxxYqzUFUHZDpsyvriO+Uw3wJUfCtFpOw0xjXseAec95aUmvSYkSNoSwPGU8xgdqDwMV9K49y0QVeGBNtTiU/8IkfT/uB0vwpm+imtU2zeMr3SXyVbp5vb6VqCdA+bHTd+9Kah/4uZ6awFcmliMAN56o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Q1sYKjeQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fsokpSFt+kz9W7Uga5Y/mHlH6kvQZdpzy/ryrYp/Mck=; b=Q1sYKjeQZhyOpQSbVUXtgvHa5r
	YornNA3ffAqtQhcFucvD19a9v/JzrnDKDpVU85tc9dUgy69lWW75PCQhNCZKrgehK6MvYg7ZlJBtl
	4G2GWwtnJbNzJLeGwaaZocntDAte10OnDpz3De9BjbuKb27qtuyX9FDyuJQ6cU2LtOnnPS+awixXs
	vf9krT8q1+rKqZdknuscsmGRIz+2vthZYhD6RWBR1O+k/ydFVDv++B1DJz0WNc2O5X9Ruji0wzQKU
	Sy09p8CBfHO0P+87MV1DUjHJSV8fPzaRDTs9tN34pwHGRGqLheDYZ5SJi6UeGE2bPGdvQ8QZwFLiQ
	kDYF2prA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYi7z-0000000ESV4-1iNV;
	Tue, 30 Jul 2024 08:22:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 102493003EA; Tue, 30 Jul 2024 10:22:39 +0200 (CEST)
Date: Tue, 30 Jul 2024 10:22:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: wujing <realwujing@qq.com>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org, dongml2@chinatelecom.cn,
	QiLiang Yuan <yuanql9@chinatelecom.cn>
Subject: Re: [PATCH] sched/fair: Correct CPU selection from isolated domain
Message-ID: <20240730082239.GF33588@noisy.programming.kicks-ass.net>
References: <tencent_E2C5C1A1B50F453656C6C7FB140CD3AFB305@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_E2C5C1A1B50F453656C6C7FB140CD3AFB305@qq.com>

On Tue, Jul 30, 2024 at 03:10:50PM +0800, wujing wrote:
> We encountered an issue where the kernel thread `ksmd` runs on the PMD
> dedicated isolated core, leading to high latency in OVS packets.
> 
> Upon analysis, we discovered that this is caused by the current
> select_idle_smt() function not taking the sched_domain mask into account.
> 
> Kernel version: linux-4.19.y

If you're trying to backport something, I think you forgot to Cc stable
and provide the proper upstream commit.

As is this isn't something I can do anything with. The patch does not
apply to any recent kernel and AFAICT this issue has long since been
fixed.

> 
> Signed-off-by: wujing <realwujing@qq.com>
> Signed-off-by: QiLiang Yuan <yuanql9@chinatelecom.cn>
> ---
>  kernel/sched/fair.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 09f82c84474b..0950cabfc1d0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6171,7 +6171,8 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
>  		return -1;
>  
>  	for_each_cpu(cpu, cpu_smt_mask(target)) {
> -		if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
> +		if (!cpumask_test_cpu(cpu, &p->cpus_allowed) ||
> +			!cpumask_test_cpu(cpu, sched_domain_span(sd)))
>  			continue;
>  		if (available_idle_cpu(cpu))
>  			return cpu;
> -- 
> 2.45.2
> 

