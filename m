Return-Path: <linux-kernel+bounces-376835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8109AB67D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CF04B227B7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2DA1CB309;
	Tue, 22 Oct 2024 19:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dceB7xFN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815221C9B9F
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 19:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729624313; cv=none; b=h2pVzqUPxCOEsbPtLhcs4UaTfzFuv9o7nDtwopJW7VPL8DDegXUA+4ZHEv5t0LXOGsFv0pnwJVghRRzD3uXK1DPSC5ut1F9fA7g2PFz4w1Zcsx5rqyX8sorgVxVzR2WbvVR4PNKoTesI0xHmu4W9xiUgezPU7dB3ixB250enXug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729624313; c=relaxed/simple;
	bh=ijMc4zj21Dc4vHTn3YhPNdPc1cmQhGT4XZAL2OKkUGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAQ59sb4vAmwfZwr2+S09aK4taSg51NjCje+CZoJn8xqnBtbyClGO9HxkrWsd8mOlyeucVaJDPnPyyPdyUtdnEBHwHQ7moBot2x27LNZU6kv8+UGmJH9qqy/7luEsypEKMCj04LmTXXsVnI5Bu82ceUvyP5zRhUrZdiegnhKHKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dceB7xFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC78C4CEE6;
	Tue, 22 Oct 2024 19:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729624313;
	bh=ijMc4zj21Dc4vHTn3YhPNdPc1cmQhGT4XZAL2OKkUGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dceB7xFNzT29MpmtIYutpfeCqBOc6jFaeYbzTfEs2G7IysX7NnuvxZHPyhk617U27
	 dtndSmc0YHuprG9yK1VzLChLnRS9dlEif2yR4ELbg1a6CrxvkA74qaIeR0OHfbvJqW
	 Hu4UiWVTj6icMniqdl27HXf9g9neZfFePFKJblz7n18FyCYIumMEJzo/dEmVvCRDbY
	 9I8rfFB7Zmm89RjrXgtHrjP2PkB7/FllvGNfUkJqJq6UUfeF/i1YfaFFBZv/ObOTWP
	 tco71K/8hbDgzm7Q6Vnafnp0+5Zs/WrdiLF0to2qz/spI9+hOfrqSkG6M6naKW6jYv
	 HndV0rhX+zrWA==
Date: Tue, 22 Oct 2024 09:11:52 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: Introduce LLC awareness to the default
 idle selection policy
Message-ID: <Zxf4-DewpSO8Lcsg@slm.duckdns.org>
References: <20241022101422.212810-1-arighi@nvidia.com>
 <Zxe89zvC5uhI7ZxG@gpd3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxe89zvC5uhI7ZxG@gpd3>

Hello,

On Tue, Oct 22, 2024 at 04:55:51PM +0200, Andrea Righi wrote:
...
> Thinking more about this, we can avoid re-generating the llc_cpus
> cpumask when the task can run on all CPUs (likely the majority of the
> cases) and it's probably more efficient to check for
> cpumask_equal(p->cpus_ptr, cpu_possible_mask) and just use llc_mask in
> this case.

At the simplest, we can just skip llc-aware idle picking if not all CPUs are
allowed. Also, it's probably cheaper to test p->nr_cpus_allowed than testing
cpus_ptr.

> We could also optimize tasks that can only run on 1 CPU, but we never
> call ops.select_cpu() for them, they're just skipped in
> select_task_rq(), so I'm not sure if we should handle this special case
> (maybe I can add a comment, to make it more clear).

Yeah, a comment can be helpful.

Thanks.

-- 
tejun

