Return-Path: <linux-kernel+bounces-564740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 143E4A65A13
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E6953BD5DF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F3F1A2C27;
	Mon, 17 Mar 2025 17:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qraltrrs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E471F1DDA3E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231297; cv=none; b=SkVMjetn3/EDlx5i0Wp8ZgYfhr+BoLmI36sj6Y9FmqM5pSzWvuHbPWK5j+p8tlf+tzc6H8dZsJqY8pcGm2nc0yOFkC5p5RtNus2ugHz7pggBbxyQ37lTH6bMbcJYVeyRN4080Wryv/sYnlO8MVPNLycypvRwlZphd9KyHTN8MaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231297; c=relaxed/simple;
	bh=abXTt9zVrzFx1N2PhYCKP2fttHqr08E1O6/mFcnVpOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/2JqORIABpmMWABy9itohRV/XuUX0At4IoSnC8m7D4+EwjvYa9m9Oc3s2iaci2HFb8RgXyReM6u2/ImcO+0unV9j0nUhI6NIu3Sj2jDXNQk4csHAKM1GH+u1Q27L2+Ti3n0o977mpaXO2sbxmG8+CeR5TKwVOajCM8ipZCeehc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qraltrrs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AB9C4CEE3;
	Mon, 17 Mar 2025 17:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742231296;
	bh=abXTt9zVrzFx1N2PhYCKP2fttHqr08E1O6/mFcnVpOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QraltrrsYWoF8ae+2Zj3p/cLOdc3TEPYyvOQdruUbDhZOUMCMfo5UCOaTAsroXeqK
	 HcpmSrgJd+3wFIiqgf3SDDbGKtBCjsRpfjtdYzc768R5gOApTsQrNbHxhMTN3lb9jT
	 tqbYJh1WG2kvgIA1YnVyWyO1Yel5mhXxWinAMi2OEwfm1COkm8yRoOsP2gW1Ul+zfm
	 2kAGEyKDiKXnkrpWTl6ymnBGuFtk8uX+6PGNF3MCNGGbTSMo+5ppNm1L46TTEjrflB
	 8NgnqUpJq7RGVoGS1K7YA6/BerkcTBwPXrWUCoRhfzI0Airq6TcrhANocIWnzO6ZD8
	 L5ckkcyeYtmPw==
Date: Mon, 17 Mar 2025 07:08:15 -1000
From: Tejun Heo <tj@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH RFC] sched_ext: Choose prev_cpu if idle and cache affine
 without WF_SYNC
Message-ID: <Z9hW_3cPN8u7VURV@slm.duckdns.org>
References: <20250317082803.3071809-1-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317082803.3071809-1-joelagnelf@nvidia.com>

Hello, Joel.

On Mon, Mar 17, 2025 at 04:28:02AM -0400, Joel Fernandes wrote:
> Consider that the previous CPU is cache affined to the waker's CPU and
> is idle. Currently, scx's default select function only selects the
> previous CPU in this case if WF_SYNC request is also made to wakeup on the
> waker's CPU.
> 
> This means, without WF_SYNC, the previous CPU being cache affined to the
> waker and is idle is not considered. This seems extreme. WF_SYNC is not
> normally passed to the wakeup path outside of some IPC drivers but it is
> very possible that the task is cache hot on previous CPU and shares
> cache with the waker CPU. Lets avoid too many migrations and select the
> previous CPU in such cases.

Hmm.. if !WF_SYNC:

1. If smt, if prev_cpu's core is idle, pick it. If not, try to pick an idle
   core in widening scopes.

2. If no idle core is foudn, pick prev_cpu if idle. If not, search for an
   idle CPU in widening scopes.

So, it is considering prev_cpu, right? I think it's preferring idle core a
bit too much - it probably doesn't make sense to cross the NUMA boundary if
there is an idle CPU in this node, at least.

Isn't the cpus_share_cache() code block mostly about not doing
waker-affining if prev_cpu of the wakee is close enough and idle, so
waker-affining is likely to be worse?

Thanks.

-- 
tejun

