Return-Path: <linux-kernel+bounces-549654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C139AA55514
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FB817A6C82
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC0426B088;
	Thu,  6 Mar 2025 18:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSK9K8dG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD582946C;
	Thu,  6 Mar 2025 18:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741286056; cv=none; b=dyMQvyw7YRrxO23AgH5aIeJlwpaxaNvqtQg1Er7+5iWYESAOGw6zTXMA2HayzDgLAfY9vN4xqMEQhj/C+mt/BFEj8uwls7JqFYMOcpU4SjhFO7kQFvX/1KWT8Mze9zIvnebMyRN9p2ifjDf0X73MkZIq/l3sa3F3PzUq9n/bhH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741286056; c=relaxed/simple;
	bh=BXG0u2C8O0s2res3+fOfQ3GYUXKl/BjQt2yWybbwgbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubJ4sZEQow0XECQl5f9YfDtUP/kxlUVsZ/5XfutJqaHcWctoPVVGRZw6kB+zuiapHOV+62K4eyl0YprVjOf+95UnJtMqGPA873vSDrRwjNG1xb1aNowY/OdBBRiYBio04JcQ4QbvlZMWcgS6sTs6kRZLLFTABeBgeEuw9+rOn/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSK9K8dG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70061C4CEE8;
	Thu,  6 Mar 2025 18:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741286056;
	bh=BXG0u2C8O0s2res3+fOfQ3GYUXKl/BjQt2yWybbwgbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qSK9K8dGXPfQmZIZcKL6L23riOd/IPbgmMjB6LypoDquuPpxtFoFp9Rq9Gxp9AOFD
	 lrDz4dKuVRrWwJRjXZdkSXo4NC4O3oif2wWNU5ymPW7o9RSslx2S0mHhs/fgfuHF2e
	 iC8cX0mWTmKiTQ8oQ28RpfLTYz+++nj4R3ovLTXHmAHNfnWuVtjiCG0wyzAwVdZTe4
	 YoWtCXmWw6I41mduzOvRnJ0kxrmbe91JBUHZkI2uiwA7PbFZbxEoGahb0NUiul8GZt
	 0CQrwYDcjDOVKjGk2qQ26hXjf+NarU9+g/AzX8fTqd4vo/QqkAX/1WR7AglGNrTYOe
	 DpZkgZptqz1Iw==
Date: Thu, 6 Mar 2025 08:34:15 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-6.15] sched_ext: Enhance built-in idle
 selection with preferred CPUs
Message-ID: <Z8nqpyEQmmff9E8X@slm.duckdns.org>
References: <20250306182544.128649-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306182544.128649-1-arighi@nvidia.com>

Hello,

On Thu, Mar 06, 2025 at 07:18:03PM +0100, Andrea Righi wrote:
> To implement this, introduce a new helper kfunc scx_bpf_select_cpu_pref()
> that allows to specify a cpumask of preferred CPUs:
> 
> s32 scx_bpf_select_cpu_pref(struct task_struct *p,
> 			    const struct cpumask *preferred_cpus,
> 			    s32 prev_cpu, u64 wake_flags, u64 flags);
> 
> Moreover, introduce the new idle flag %SCX_PICK_IDLE_IN_PREF that can be
> used to enforce selection strictly within the preferred domain.

Would something like scx_bpf_select_cpu_and() work which is only allowed
pick in the intersection (ie. always SCX_PICK_IDLE_IN_PREF). I'm not sure
how much more beneficial a built-in two-level mechanism is especially given
that it wouldn't be too uncommon to need multi-level pick - e.g. within l3
then within numa node and so on.

Thanks.

-- 
tejun

