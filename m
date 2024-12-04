Return-Path: <linux-kernel+bounces-432096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3031F9E4510
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 20:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0558316624E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95AD1F03C2;
	Wed,  4 Dec 2024 19:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgdPWN+G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B852391AA
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 19:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733341833; cv=none; b=lP81Jh5GdLKdrfI4I1fdQKN5OsUdk91TM8ZFRfD2w/xRBCEidBgM9MIG4OfVXabRhXdFk+j1GvTx4PPC4s6FE9Sncuxmi4ctFn86OOAMW3WfWdRVwgvp52R1S04ZO/ywXYpHKWwdJNQyyoUXmI1VtoDlTtK7bcpnmnlft53p3EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733341833; c=relaxed/simple;
	bh=a1M4b0161YPMWNjU0qSumAmXZld+rF2FDuC2TmYj1qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noYcqQR4oLjwV1ARuzOBu2UoKPWlGsjPR6X+gYX2QxYu0+VV1UY8zTBqpfaYCMxnvemT4F61TQiaguLfXT8g0OLQfIBupUYVD3XTh0gDiwkNUZ8yWsLOutbpyqLxEmQjV+vVEOImkOMkeHxJqGziT9R3uMUKQs35DdCWeIqzlT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgdPWN+G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B005C4CECD;
	Wed,  4 Dec 2024 19:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733341832;
	bh=a1M4b0161YPMWNjU0qSumAmXZld+rF2FDuC2TmYj1qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rgdPWN+GggVZprqYlupn1/UcnC0nW14nhaBX1HZvqD1r0Y0TdvSVwkWAnbPHy/R4I
	 lkvArVwv8lH7E3NMfVppeK42n4zcw4kw+glFBcxdU4wVr068YNjiK63gVDAmAKTWzk
	 shVVuTpxuKShsYKzk8OMX18IuXenG3BCWbnOOIPkE6XzHt7VstY3eQIIqCak/2AHsB
	 bjPRRqrKA+VGHBfN4ahNRhgj4gRvXNswuVuyOafC1tGcgXm6Ev2ESoIiW5Qluru+v2
	 K8pswp3+3Ew4LIICQ5ZbdBbf3jy/9kEUvRxL34ljpshB9MWnZjluX6dhkNlkCYuTQV
	 WVeGA56kSlWTg==
Date: Wed, 4 Dec 2024 09:50:31 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Use the NUMA scheduling domain for NUMA
 optimizations
Message-ID: <Z1CyhyYN_MBSro07@slm.duckdns.org>
References: <20241120142903.59521-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120142903.59521-1-arighi@nvidia.com>

On Wed, Nov 20, 2024 at 03:29:03PM +0100, Andrea Righi wrote:
> Rely on the NUMA scheduling domain topology, instead of accessing NUMA
> topology information directly.
> 
> There is basically no functional change, but in this way we ensure
> consistent use of the same topology information determined by the
> scheduling subsystem.
> 
> Fixes: f6ce6b949304 ("sched_ext: Do not enable LLC/NUMA optimizations when domains overlap")
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Applied to sched_ext/for-6.14.

Thanks.

-- 
tejun

