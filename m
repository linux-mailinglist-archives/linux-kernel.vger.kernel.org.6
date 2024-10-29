Return-Path: <linux-kernel+bounces-386351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F18699B4251
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DD721F231E5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 06:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442BD201005;
	Tue, 29 Oct 2024 06:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILLlqmgM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E1B1FF603
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 06:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730182722; cv=none; b=JYrBi4GRK6eUQRKUqKezZMaAyxQGw3MlVPAuQFevqmYQSB8U6NPIbnY5YRveMW39hwxXkOvmNvGsFbiEmYeQKIvUk2mW4sQ08D1WQA7DvDgFAWXcXnq+sMCk99MZd1j9NdOo5PbcsOWIXqsONd4T0QF3B1Kwwn0iNpVNkDnbalo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730182722; c=relaxed/simple;
	bh=ppf6eFjKl85knUWcnFMSFXU9CjJVKMIJWfoC6pkShBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dw4FGsK2pW3XSQcOfTANDrAYbnWmgX3tRoDWid9n4LkL/tBddK0tQNdDuaXtYD4xP38/nIe6r0Z5YerqeD8D7pRYebjKNWt3Z6s5UrqkhHo+Fx6FfJ0e86DWOu9EVNRZ4sBzNiOrahfx96R7/n2YE52CrdYdO1SUPe/XRAFMcvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILLlqmgM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2089BC4CECD;
	Tue, 29 Oct 2024 06:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730182722;
	bh=ppf6eFjKl85knUWcnFMSFXU9CjJVKMIJWfoC6pkShBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ILLlqmgMA5WZBz+PlJWxEKws/hP3dRQu3EqDp2PqfXA0/fCLm87NvlNgw/e/UnBLv
	 j/dMV0rrK23K67vZoqqyBtXA5196A2U5NumgJWk0aQ+cM9sV/21VdkGtF2aM8ZJCpH
	 aTKdYym3TzYpHR+yKfPIS1N28edgtAC5s8RK2b+TZSgdp0bjXWu7Kmex8mtD1WA5kV
	 nr2sb1YMdhCI4L9lQnos89CWKw2jZFphgZjTPFAyRYKN6VzabVezeLaTmdH2B+jXA2
	 HxnBi//ulXAS07+PEHVWhJKdDFhXP7UC13pCe4fLmIfv0DMAALAysrhzshzzHfczjA
	 1kvXwJ/qn6MMw==
Date: Mon, 28 Oct 2024 20:18:41 -1000
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
Message-ID: <ZyB-QdXryezwSswB@slm.duckdns.org>
References: <20241028063313.8039-1-dtcccc@linux.alibaba.com>
 <20241028063313.8039-3-dtcccc@linux.alibaba.com>
 <Zx_LwYshJV5LERm9@slm.duckdns.org>
 <ddfca6ac-f7a6-4b51-80e8-2e422de7d597@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddfca6ac-f7a6-4b51-80e8-2e422de7d597@linux.alibaba.com>

Hello,

On Tue, Oct 29, 2024 at 10:07:36AM +0800, Tianchen Ding wrote:
....
> For eevdf, per-task interface has been introduced in commit 857b158dc5e8
> ("sched/eevdf: Use sched_attr::sched_runtime to set request/slice
> suggestion")

I see.

> So This patch is trying to introduce a cgroup level interface.

If I'm reading the code correctly, the property can be set per task and is
inherited when forking unless RESET_ON_FORK is set. I'm not sure the cgroup
interface adds all that much:

- There's no inherent hierarchical or grouping behavior. I don't think it
  makes sense for cgroup config to override per-thread configs.

- For cgroup-wide config, setting it in the seed process of the cgroup would
  suffice in most cases. Changing it afterwards is more awkward but not
  hugely so. If racing against forks is a concern, you can either use the
  freezer or iterate until no new tasks are seen.

Thanks.

-- 
tejun

