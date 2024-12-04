Return-Path: <linux-kernel+bounces-432018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4868F9E43D0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF00164CB8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6565E1C3C15;
	Wed,  4 Dec 2024 18:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOflF9cV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25AD1C3C12
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 18:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733338396; cv=none; b=UkGPq7FkJgvX2ezdfa7ggY2RHbFtYn1a2w0QnT2h+nWm3zFkLEj/fwypfCGNrgwlB+4VyW65BpaJteSxG+7mCa1uodX5RtfAPyUwRHvcmcCYnySAsQYL8ahLcwrdH+DFb/mT5RvMJXAkMWPDsERHoVS6O+bZl4+1j3tTngCatK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733338396; c=relaxed/simple;
	bh=Ujt5pXo/M9j58m43ipqiDLz9NGXJ1W4lvwVxvN0LqYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQ/pbgHeah/Ry/ReSL+et0wAw8bsWvwRXrNWBzA9Wa2VvtjrzYsMrmV0TxQ+WNS9PRUpZk2fmRFodOMWLI49cJmayi4UXv5Y7RbZotrvPPp9mxpKKm1AmN+J0tyHKgapPDbW7pSIyuSikDzHaKTjOALmtiA43QhHjpv66UVm+Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOflF9cV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22756C4CECD;
	Wed,  4 Dec 2024 18:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733338396;
	bh=Ujt5pXo/M9j58m43ipqiDLz9NGXJ1W4lvwVxvN0LqYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UOflF9cVT2Jg10vVRrLEee8glrszX4XWFc6CxQ5fQRM/iGwnI4qAbjK16KZAVaCz8
	 tVwIglFfQ2N9dRWU0a49/HE0Q7Ob9sA8cn+dUj37ATYNnDPUUXU/5vW7UwyxrPxpfO
	 NJ91mjqOuPjJIV7mHobjm5Er+6JYaXT3UIRs0pckILybQEF2DVSKOpxCvK/UYlgJx7
	 RATuYeB0rwzQ7aGZtdbpyuNLGgPI0mBUr3Kh7GhlWkXNYXWEpRWsbiOTrkscaISA+m
	 4ohUGuqgEycrdvPuBA/Bj4GN/Ok4zZg9pWzs9aaXTkYUoPo7sPbcHnJKL5lOOlF+XK
	 u3Dxq9Y7Yjx1Q==
Date: Wed, 4 Dec 2024 08:53:15 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Yury Norov <yury.norov@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] sched_ext: Introduce per-NUMA idle cpumasks
Message-ID: <Z1ClG6qOvesfyGSU@slm.duckdns.org>
References: <20241203154917.123419-1-arighi@nvidia.com>
 <20241203154917.123419-3-arighi@nvidia.com>
 <Z0-cf7gUzV8jIWIX@slm.duckdns.org>
 <Z1AVx-yUY_37uMCb@gpd3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1AVx-yUY_37uMCb@gpd3>

Hello,

On Wed, Dec 04, 2024 at 09:41:43AM +0100, Andrea Righi wrote:
...
> I like the idea of introducing a flag. The default should be flattened
> cpumask, so everything remains the same, and if a scheduler explicitly
> enables SCX_OPS_NUMA_IDLE_MASK (suggestions for the name?) we can switch
> to the NUMA-aware idle logic.

I think it generally works better to use "node" instead of "numa" for these
interfaces. That's more common and matches the interface functions that need
to be used and exposed, so maybe sth like SCX_OPS_BUILTIN_IDLE_PER_NODE or
SCX_OPS_NODE_BUILTIN_IDLE?

Thanks.

-- 
tejun

