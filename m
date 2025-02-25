Return-Path: <linux-kernel+bounces-532253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16133A44ABF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E02A53BEEDF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FCD2046B1;
	Tue, 25 Feb 2025 18:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1+sOLgW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750DC1DB375
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740508574; cv=none; b=abPSzb0pQECKx0mfOP6uCIpMeCNNhU5dI76NYopUg5OMPPGxQ35z2oD0itEJeLqF5rVVMOxwZatYWvD/f3AntlAZwZDh+XGsfGRXDYFJ/L/ROmSVXiVe5Yxd4/DB+BhJjXundfxQYkzJ6uUg06HjYU4QaBenIkTvDWxR9G6WFOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740508574; c=relaxed/simple;
	bh=qp+2fdaK6xwqIci8/DQUqgU3VmMxaMSuxbdhmyn6gqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtxCAdkzmnyXPRZAVLVPMObw7IToG2MTFYwS4g6usKXpwtHAusL6AJYQ99pmSq33k9OinrMnUkh4jIVtL36HnIZlQE84DRpFbyWYwmKuO+8aZU6iD5wbKEgp6psfminnmgG3mGMOCJA7vlzJVFJcKIpHogx2g7DDsI9HZqAxLyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1+sOLgW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1E5C4CEE2;
	Tue, 25 Feb 2025 18:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740508574;
	bh=qp+2fdaK6xwqIci8/DQUqgU3VmMxaMSuxbdhmyn6gqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I1+sOLgWL1ZdGrnYzqKx4hrkhsQDgK81V01W+K+RrF/PVsQjOiFWG2MRmh1ChWbHL
	 Rog/BvIHXX/3a/18OlVcqmNeKc/Sr3oFPEVia1dG7mIcfuRwCfNyMhz46QJpKB4mvg
	 VEoseqXN1OUg7lVAcX9wAhHQ7Ci2M8TGwxa7wCq1qQEFIxyMLvF5HOAJdu1n/TsCkL
	 zHC5I9iqyGZwKHb8BX4Y/YR+3v6O7LK/q4AxmYgWY4k0PXdf8hbXvVzNX3CIlCUshy
	 1LLhYJxXgQud+lH3a+HhygsQ4l5YJB1pV8FKl2ZXyF0Xwq3syRCTp2z0u5Th8jgUgB
	 8DTro8Z4wVSBQ==
Date: Tue, 25 Feb 2025 08:36:12 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.15] sched_ext: idle: Fix
 scx_bpf_pick_any_cpu_node() behavior
Message-ID: <Z74NnCIYPtHPZvM-@slm.duckdns.org>
References: <20250225093742.51597-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225093742.51597-1-arighi@nvidia.com>

On Tue, Feb 25, 2025 at 10:37:42AM +0100, Andrea Righi wrote:
> When %SCX_PICK_IDLE_IN_NODE is specified, scx_bpf_pick_any_cpu_node()
> should always return a CPU from the specified node, regardless of its
> idle state.
> 
> Also clarify this logic in the function documentation.
> 
> Fixes: 01059219b0cfd ("sched_ext: idle: Introduce node-aware idle cpu kfunc helpers")
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Applied to sched_ext/for-6.15.

Thanks.

-- 
tejun

