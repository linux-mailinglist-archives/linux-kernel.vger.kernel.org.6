Return-Path: <linux-kernel+bounces-441573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE00D9ED044
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A401289612
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C21F1D9320;
	Wed, 11 Dec 2024 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m18/biRz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C4D5789D;
	Wed, 11 Dec 2024 15:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931998; cv=none; b=AGBv5x8AUtl6fAlQw/czY6FGyI5SaBx+iRiAIpigw1sH8eGRGAZmLO9UDsmZ6C5210605Kb0vFkoQv4raF5QAhXbN+BcQDMXWy/l6M8Ta0FcjCsu2ZVOiyn2oQhQob+VpIRStlZZ2jd6o5VS41kLUdv2tmA81ov+uWBNDc6KAko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931998; c=relaxed/simple;
	bh=6wcjGksCHxQ6h4pDwDLqXPxZOF/z6oF0XZY/cvAb5To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bm8GeaEqJ9roRf+/I1zlJ5xZMqNNvXjCGQ7reY6HJkOQiBnKo3YF05odjjO/UkXkwmGxCxJ6fbw80sTmAZFpBoEovL8068lRBUCGmzt7jn8sVvLn+dqz1F+XeYyOsA/QN5kInnGAkPJy9YSkWpO0rZjhzJQktnplthCwWlPbVYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m18/biRz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C4DC4CED4;
	Wed, 11 Dec 2024 15:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733931998;
	bh=6wcjGksCHxQ6h4pDwDLqXPxZOF/z6oF0XZY/cvAb5To=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m18/biRzF/gSLrpmCe9hRZB+7iB68GLToghbx7TeRfBPxFczhJCTwpIw+Xmm+5EyY
	 pv1h1vXvfKnINDxuoJI/yoTpIR9s7opKTKJZiZZZZ1IF26l0cwLp6OLvkhTGegSrbF
	 WJ0xLnpZRLQ4QJt5SloiIo71+041lTAC7ScwKzKSPIyaGO8VeFVcYpgvFLVmuKPCi2
	 kAXZq2/6fhnbimbJJz75RpXwCCU/DQVCp6PNQOndwBbd2P+z5wOHdT9Hon5ykB1cjK
	 wsFwTgxP0toY0uyR4BpdU6lIFDddbRm2JRConsQu3gQ559DrwkPwDYdEveI8KSLMSV
	 +GpJzb7EGqOHg==
Date: Wed, 11 Dec 2024 05:46:37 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: Prevent leakage of isolated CPUs into
 sched domains
Message-ID: <Z1mz3Rh221Lbcinv@slm.duckdns.org>
References: <20241205195101.31108-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205195101.31108-1-longman@redhat.com>

On Thu, Dec 05, 2024 at 02:51:01PM -0500, Waiman Long wrote:
> Isolated CPUs are not allowed to be used in a non-isolated partition.
> The only exception is the top cpuset which is allowed to contain boot
> time isolated CPUs.
> 
> Commit ccac8e8de99c ("cgroup/cpuset: Fix remote root partition creation
> problem") introduces a simplified scheme of including only partition
> roots in sched domain generation. However, it does not properly account
> for this exception case. This can result in leakage of isolated CPUs
> into a sched domain.
> 
> Fix it by making sure that isolated CPUs are excluded from the top
> cpuset before generating sched domains.
> 
> Also update the way the boot time isolated CPUs are handled in
> test_cpuset_prs.sh to make sure that those isolated CPUs are really
> isolated instead of just skipping them in the tests.
> 
> Fixes: ccac8e8de99c ("cgroup/cpuset: Fix remote root partition creation problem")
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied to cgroup/for-6.13-fixes.

Thanks.

-- 
tejun

