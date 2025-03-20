Return-Path: <linux-kernel+bounces-570054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD2DA6AB71
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CF3148209B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49453221549;
	Thu, 20 Mar 2025 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/m3OXj/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE2417591
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742489388; cv=none; b=NkmvQSZnaSYABZtalyTSGdgVsrOcxMfwHEb3Qa1GKN4ZGFi75QcNWuL/Intj5U42366Bk3G0ycYy0gJADbz91qNsbGUepDSGy9Lhgybfald495a4qc9ocRIH8f+k4FDbkNPT6gLQfApYX/oyfxutcFVQD1MShGA0u3n5ovDyrY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742489388; c=relaxed/simple;
	bh=SPStBJ/8Qw8fTp13I5VFke43dQWNqVPyMtV214zvn3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4odOlF/0KG/FdkSHzuC6jZZ5e21F59iGtGOB5mkqZolKtpFnE7sLv1DpszXRHs51jY62XeMHCHgJ8IYdH2PWlSyWJ+q+HdhTRASR9t4Pxj4V/zKgL2mmA0iEGiR6u4WrgtdfY9B5k/95fkyX1sfTUmx3EdDlbi3DM3tC4Kae2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/m3OXj/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D8FC4CEDD;
	Thu, 20 Mar 2025 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742489388;
	bh=SPStBJ/8Qw8fTp13I5VFke43dQWNqVPyMtV214zvn3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d/m3OXj/bDsrXXFBY30dMxuqf70f06F4h4O8ulGGWMDcvQ6ImdYhC5+CMIc7+Ecsg
	 7WNavLeXESS5J6A9yIKoKlCQbjD8rTtJu56cXyLFtTavj5zdlRCEl3lS1CHWH9eOhi
	 cqG4DWbLEfx7V35ZYl6ZJcg/h/WMbISO5KbANDR7XSgLYFYOFsMzp82JoVpWIWsK/Y
	 sdVDwLp4W0wQTHz93rvLUOE/2Tkyc4e8teL112ynZhqZFOx/bfYJ9ZYdbk4rxpZS5C
	 6XqFvuTKk30AmwkPNbm5gQtbbq07f4WxbFD6kFSplOxFbJGBrYVxzCBar0IISU+rc3
	 kKofIiUnLUpoA==
Date: Thu, 20 Mar 2025 06:49:47 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] sched_ext: idle: Extend topology optimizations to
 all tasks
Message-ID: <Z9xHK8xgnWjXQ1-p@slm.duckdns.org>
References: <20250320073927.216147-1-arighi@nvidia.com>
 <20250320073927.216147-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320073927.216147-2-arighi@nvidia.com>

On Thu, Mar 20, 2025 at 08:36:41AM +0100, Andrea Righi wrote:
> +static const struct cpumask *task_cpumask(const struct task_struct *p, const struct cpumask *cpus,
> +					  struct cpumask *local_cpus)
> +{
> +	/*
> +	 * If the task is allowed to run on all CPUs, simply use the
> +	 * architecture's cpumask directly. Otherwise, compute the
> +	 * intersection of the architecture's cpumask and the task's
> +	 * allowed cpumask.
> +	 */
> +	if (!cpus || p->nr_cpus_allowed >= num_possible_cpus() ||
> +	    cpumask_subset(cpus, p->cpus_ptr))
> +		return cpus;
> +
> +	if (!cpumask_equal(cpus, p->cpus_ptr) &&

Weren't we talkign about removing this test?

Thanks.

-- 
tejun

