Return-Path: <linux-kernel+bounces-375070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B16659A9080
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 22:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B5FE1F2248B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 20:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18521DF732;
	Mon, 21 Oct 2024 20:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRygKCiY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDDC1DDC2E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 20:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540889; cv=none; b=Zjw728Ndu42nFh84nRb8Y48dwwaXAz2uwaSWQUwJYevzSuxGqO+gWI+xbXMiLNk2VNUCzl+BWQQXgQEW9Y3Ln2vgqttaNSHqGsan3iMXXpQUqW/FLRtRERSoYgeJNmq+RXbMpzAkqOUJoLAMhyBRFxZ2PGXwOVGoHrMKVm0alpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540889; c=relaxed/simple;
	bh=CESHfBqOqt52DB4sox2hdR2wAyKL5ctaHenVPNh5MWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlakuH2WwJTJdYZEEf//TdkeoXntcZzoJwsaK6hMhamnl9IobHIL3LO2/n0frwXBoRoESNg8UnNuSJj756kPcKsZ6Cr8kBj1IEvA0PB1MIN6kByXnKz5kmx88Gq5WUAGtW3KI8+519z0NP25nSIBwpz3dpzQtD4typBj4XS5q7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRygKCiY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2437C4CEC7;
	Mon, 21 Oct 2024 20:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729540888;
	bh=CESHfBqOqt52DB4sox2hdR2wAyKL5ctaHenVPNh5MWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PRygKCiYtqubqKi9VJFzccKsMTCMGGFkhYg7tNyjQGMVbQYsTqCAEdScNC/sV8Dal
	 t+a+RBvk+rjXJsQpQavHkACCQozupzsjB9yTbccyuS8TX1XzBDS4qtHO4x5V5ssO9M
	 ym0zPLP8wZvvxhUNZkEFNCyYMr7BsQCczK7eEZ7gsX7D83Rggs6NGJXAxsn9uusioF
	 Jg3dLJpe5wOi0Fv/O/8YQ4efm8BMDDR2uzjCE/SOagL3zA862UlGtB7/oEmri2dqtA
	 B+jIljmW5NEdyzcupSdBmLzG/8ITKwpFDyz/M9XtkXrEq7ydPdqgpDQdltp/yq54E5
	 ZkUd/8E/wlhlQ==
Date: Mon, 21 Oct 2024 10:01:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: introduce LLC awareness to the default idle
 selection policy
Message-ID: <ZxazF56XRJ3CJ0mN@slm.duckdns.org>
References: <20241021071304.27856-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021071304.27856-1-arighi@nvidia.com>

Hello,

Overall, I think this is a great idea. 

On Mon, Oct 21, 2024 at 09:13:04AM +0200, Andrea Righi wrote:
...
> +	/*
> +	 * Determine the task's LLC domain.
> +	 */
> +	sd = rcu_dereference(per_cpu(sd_llc, prev_cpu));
> +	if (sd)
> +		cpumask_and(llc_cpus, sched_domain_span(sd), p->cpus_ptr);
> +	else
> +		cpumask_copy(llc_cpus, p->cpus_ptr);

However, I wonder whether we can be a bit more efficient here. Always
copying cpumasks can become noticeable in larger machines. It should be
possible to cover most common cases without copying cpumasks - e.g. tasks
which don't have any cpumask restrictions or affine within a single LLC
(including tasks restricted to one CPU) don't need to compute a new cpumask
each time. They can use either sched_domain_span() or p->cpus_ptr directly.

Thanks.

-- 
tejun

