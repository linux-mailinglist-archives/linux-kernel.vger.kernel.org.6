Return-Path: <linux-kernel+bounces-402177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 329679C24BE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAF092826CA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C49194138;
	Fri,  8 Nov 2024 18:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPglazpf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF56233D6E;
	Fri,  8 Nov 2024 18:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731089876; cv=none; b=OzxYxSJNHTZuww4+xVzLfoVZKRr+9vwgXfZ76MFqpEJo/jHdDzV6Yxywau8AyJPC2ginUd/d1MWNO93Wu++ZzmsyMku4tZKARMxc7AXmcVjdYbLk4ZOvGE/fettcmS5Ai0GhuZRQs1QtgGIgiU6Ha2pXcMgfkqJh71C8W7shP6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731089876; c=relaxed/simple;
	bh=nypbHBGDqp7tyTZKtcOJP5r0cq4FwCXcb+BhhHZ2Hlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNX+Ncfuc0FEEpu28MJj7xEJOn38MPFktRmtdxpjH6WxOjN0CQ74jyhny+2E5yRpSVjNCxHMSMKiSCzO4fXIVECMLHqwHVzmH1wZOgiKlQvpRFcoZOXlD2Lwc+c+qwc+Z65XkXGjoBGaTMN7JXQLARpNezPUS4Xo0n/egCmMFds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPglazpf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8E0C4CECD;
	Fri,  8 Nov 2024 18:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731089875;
	bh=nypbHBGDqp7tyTZKtcOJP5r0cq4FwCXcb+BhhHZ2Hlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PPglazpfQqnV1jTaVZIO1kY7FWpEOUZFDdQjQ4mt2DStw/uOhr/kM1//peQh/aEmz
	 LO2gTSo1sr73FshZepwMlqK6Io/f3iAskKqJ1/CJrVAzlJ74qPlFdoQfCCfeQPZ633
	 syo3MfddEXSVwxVwCVOv+7ELmV4S2172lWoUcU4XBTZF/9NNyoV9WWKxP7ffECf8+r
	 HF6Ki0EhpOfNrkSsrejdihl9xos9gkNZh33E870l5oC+rKp/E7BzpFTosWeWPCncDL
	 HS8zPOBmKxvd93bWV+5kEfKAorJunKFxHh1Na62v+CtPYcezFO79/83qp42zMIVOoW
	 3MJaSzEkuWzZA==
Date: Fri, 8 Nov 2024 11:17:53 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v3 sched_ext/for-6.13] sched_ext: Do not enable LLC/NUMA
 optimizations when domains overlap
Message-ID: <20241108181753.GA2681424@thelio-3990X>
References: <20241108000136.184909-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108000136.184909-1-arighi@nvidia.com>

Hi Andrea,

On Fri, Nov 08, 2024 at 01:01:36AM +0100, Andrea Righi wrote:
...
> +	/*
> +	 * Enable NUMA optimization only when there are multiple NUMA domains
> +	 * among the online CPUs and the NUMA domains don't perfectly overlaps
> +	 * with the LLC domains.
> +	 *
> +	 * If all CPUs belong to the same NUMA node and the same LLC domain,
> +	 * enabling both NUMA and LLC optimizations is unnecessary, as checking
> +	 * for an idle CPU in the same domain twice is redundant.
> +	 */
> +	cpus = cpumask_of_node(cpu_to_node(cpu));
> +	if ((cpumask_weight(cpus) < num_online_cpus()) & llc_numa_mismatch())
> +		enable_numa = true;

With this hunk in next-20241108, I am seeing a clang warning (or error
since CONFIG_WERROR=y):

  In file included from kernel/sched/build_policy.c:63:
  kernel/sched/ext.c:3252:6: error: use of bitwise '&' with boolean operands [-Werror,-Wbitwise-instead-of-logical]
   3252 |         if ((cpumask_weight(cpus) < num_online_cpus()) & llc_numa_mismatch())
        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        |                                                        &&
  kernel/sched/ext.c:3252:6: note: cast one or both operands to int to silence this warning
  1 error generated.

Was use of a bitwise AND here intentional (i.e., should
llc_num_mismatch() always be called regardless of the outcome of the
first condition) or can it be switched to a logical AND to silence the
warning? I do not mind sending a patch but I did not want to be wrong
off bat. If there is some other better solution that I am not seeing,
please feel free to send a patch with this as just a report.

Cheers,
Nathan

