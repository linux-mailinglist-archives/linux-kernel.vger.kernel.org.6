Return-Path: <linux-kernel+bounces-385487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B819B37C2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5734A1C218D3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE8E1DF72D;
	Mon, 28 Oct 2024 17:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVxbUPso"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293681922FC
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 17:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137027; cv=none; b=urupC9KMvqZF6FM2dN5RCjdieELfyIKt39ouVVWgijldIzmQyYSLwzyZIWrbGtyU3AABy+0vceIuZQDb/j1Pa4YrVFa+aQl7uhVCyAi1KMZF6Pqct969Tp1dMGzKUKWKR8200fyMAPaNXMW4r7yiJxhDLADUeQx3/2FE/7gN4fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137027; c=relaxed/simple;
	bh=Z4jYym1h9xT8mYNeI9RkQ+fBy0xqtLX0jJWPmnszD7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5abn9YRU5W0qVbL4A4HyxEcwwC3PGnP+t91fIJ/KW4tJm/pBWkFDhFot5ZBYaY2AuQaCqTpeWSioR4NfXGZZAk5lCaLFnmx5+1rwEracK3EC7Npy8Fu3OXt2dEVEml3sWwaNj7V0H0AorjXCKPh1iG1e1mZJqCQuAN9myp2P+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVxbUPso; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C94C4CEC3;
	Mon, 28 Oct 2024 17:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730137026;
	bh=Z4jYym1h9xT8mYNeI9RkQ+fBy0xqtLX0jJWPmnszD7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aVxbUPsohTs6P0u1C3y+ewFcPvmGPSrNWm8/SoqD0Q/aWlnVTMb1BUbhaScl9zrng
	 Z/QauPyYU5KZnzd2QrbPzgzXSLptokoRAqxlBSB5KtDqXGRoiAagwetg3wGmI0/4Th
	 umEQ4gJwPHWwWT6GFVo23sRTr/DK+qihcPuq50Z8mGakZUuPegzpP2tKiHPXNZQWth
	 I8wQ4A2SUvk4F5+EOLda3YpNcrGZF5jt2mEVRMxKxRxHA4U5H1EREjoZojlRUKrGME
	 f5cNFG918I2jDFrrPc3xoi3aQYP/rcQ/vH0I2ExdUPcVHqDhXJXy1eu5PhO0/eota+
	 s9k659wZ18QGQ==
Date: Mon, 28 Oct 2024 07:37:05 -1000
From: Tejun Heo <tj@kernel.org>
To: Tianchen Ding <dtcccc@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [RFC PATCH 2/2] sched/eevdf: Introduce a cgroup interface for
 slice
Message-ID: <Zx_LwYshJV5LERm9@slm.duckdns.org>
References: <20241028063313.8039-1-dtcccc@linux.alibaba.com>
 <20241028063313.8039-3-dtcccc@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028063313.8039-3-dtcccc@linux.alibaba.com>

Hello,

On Mon, Oct 28, 2024 at 02:33:13PM +0800, Tianchen Ding wrote:
> Introduce "cpu.fair_slice" for cgroup v2 and "cpu.fair_slice_us" for v1
> according to their name styles. The unit is always microseconds.
> 
> A cgroup with shorter slice can preempt others more easily. This could be
> useful in container scenarios.
> 
> By default, cpu.fair_slice is 0, which means the slice of se is
> calculated by min_slice from its cfs_rq. If cpu.fair_slice is set, it
> will overwrite se->slice with the customized value.

Provided that this tunable is necessary, wouldn't it be more useful to
figure out what per-task interface would look like first? Maybe there are
cases where per-cgroup slice config makes sense but that sounds
significantly less useful than being able to configure it per-task.

Thanks.

-- 
tejun

