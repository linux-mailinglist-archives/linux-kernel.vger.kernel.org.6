Return-Path: <linux-kernel+bounces-424912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB5E9DBB24
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 17:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1465B21458
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469161BD9E1;
	Thu, 28 Nov 2024 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AWVX07Vd"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC682192B74;
	Thu, 28 Nov 2024 16:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732810897; cv=none; b=KQ5RDidIVX359dpDtC1JeWDLV0Vrys26WtAV9+Qtlhp/gUTCN54vl9iy5a+cm4zuONzXtO76GSbu2RrUheleoaPb03t9nGdorkmJbDX+6ODLiAVZFBPNK0KeZYiSK9SHuwNhDnfOtBJmWuF/j01mO1+yp//5vSM4KKBDQ+i0zvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732810897; c=relaxed/simple;
	bh=Q+vYEVGc8WCG4y/Ymty9SbHR9XrHC963OI21gHFHHgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Puw/ToKaZEX9h/NfNp6he+5Pd3tsrqegMHKFyv4iyF1QomJRw6In2bc/ti5JkiOFkWcd3witc0Yon9dJdKSso65mpho8EDhXknht+XDJzu9jV/j1lxkGbww0apZAcJoqVsk3EdoUYyQzCutkIIQiVj+fEcVKmnJoqt28uDJjljo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AWVX07Vd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AH+QWVp5IumyQjD1NJLyaerHrMXbLkOD0ucThVi1jNY=; b=AWVX07VdgFpgvt7mlPor6MbqPo
	qui+RxZaXYgktjdTGMFstqn5NQ/ffB6JfogdA+9Wm1HegzgQoJiVZHlyWtzX0wwBTdWVXymBwJlBM
	zQThbk8iL6uIZ9yIVw67LWKoNQZ9wTRHjOlR6/HYt/vdifM4tcrA5xjIinWKMIOz6e9M7JKFq5pqc
	aoxFNz7rUtCguHhIENYjeTAOX/tGQ+TGDKK7CQ/Loeva0zTwdeC70bEJsQ7RoUaDnN+A9+8UawcPm
	t8pg25LTTqig54iPbvbnW2APBaIilsTh6cf0sYQfhL+aceCDxnB8oFDfTcgHsRffMY7cI+8T3SZqh
	qGs62ndg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGhGi-00000002qKT-3jea;
	Thu, 28 Nov 2024 16:21:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B67EF300271; Thu, 28 Nov 2024 17:21:28 +0100 (CET)
Date: Thu, 28 Nov 2024 17:21:28 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: Rik van Riel <riel@surriel.com>, oe-lkp@lists.linux.dev, lkp@intel.com,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mel Gorman <mgorman@suse.de>
Subject: Re: [tip:x86/mm] [x86/mm/tlb]  209954cbc7:
  will-it-scale.per_thread_ops 13.2% regression
Message-ID: <20241128162128.GE35539@noisy.programming.kicks-ass.net>
References: <202411282207.6bd28eae-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202411282207.6bd28eae-lkp@intel.com>

On Thu, Nov 28, 2024 at 10:57:35PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a 13.2% regression of will-it-scale.per_thread_ops on:
> 
> 
> commit: 209954cbc7d0ce1a190fc725d20ce303d74d2680 ("x86/mm/tlb: Update mm_cpumask lazily")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git x86/mm
> 
> [test failed on linux-next/master 6f3d2b5299b0a8bcb8a9405a8d3fceb24f79c4f0]
> 
> testcase: will-it-scale
> config: x86_64-rhel-9.4
> compiler: gcc-12
> test machine: 104 threads 2 sockets (Skylake) with 192G memory
> parameters:
> 
> 	nr_task: 100%
> 	mode: thread
> 	test: tlb_flush2
> 	cpufreq_governor: performance
> 
> 
> In addition to that, the commit also has significant impact on the following tests:
> 
> +------------------+------------------------------------------------------------------------------------------------+
> | testcase: change | vm-scalability: vm-scalability.throughput 40.7% regression                                     |
> | test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory |
> | test parameters  | cpufreq_governor=performance                                                                   |
> |                  | nr_ssd=1                                                                                       |
> |                  | nr_task=32                                                                                     |
> |                  | priority=1                                                                                     |
> |                  | runtime=300                                                                                    |
> |                  | test=swap-w-seq-mt                                                                             |
> |                  | thp_defrag=always                                                                              |
> |                  | thp_enabled=never                                                                              |
> +------------------+------------------------------------------------------------------------------------------------+
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202411282207.6bd28eae-lkp@intel.com
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20241128/202411282207.6bd28eae-lkp@intel.com
> 
> =========================================================================================
> compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
>   gcc-12/performance/x86_64-rhel-9.4/thread/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/tlb_flush2/will-it-scale
> 
> commit: 
>   7e33001b8b ("x86/mm/tlb: Put cpumask_test_cpu() check in switch_mm_irqs_off() under CONFIG_DEBUG_VM")
>   209954cbc7 ("x86/mm/tlb: Update mm_cpumask lazily")

I got a bit lost in the actual jobs descriptions. Are you running this
test with or without affinity? AFAICT will-it-scale itself defaults to
being affine (-n is No Affinity).

