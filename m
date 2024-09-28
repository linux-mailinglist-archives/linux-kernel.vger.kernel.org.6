Return-Path: <linux-kernel+bounces-342585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3D798909C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 18:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 037542819F4
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 16:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01A83B290;
	Sat, 28 Sep 2024 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPsQO3AX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1B322089
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727542327; cv=none; b=hf7biwEUI15EZOZjOkowsqGreLEX/0DIfjM0hA8q2xux4ccjC8orAAK/oKYCo+tEKef/6f96qjuEw30upf8QwvJcPl5JPdssLobt469t2PzFTMtdhfVY8bFIENuFj7j5oAXivSOU3rpLTahhEnXe00xZerTHUcDjHLL+W1GCixc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727542327; c=relaxed/simple;
	bh=yKRhcmgvO7ZUa0g4UElPy8WX5eVQgICXeFas361yv0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCJNqJE7ouTNOOZ1/p5vpSQjs4rYee6nPzzACGZmEHz2Y2t+bJbDQu1bXhVNqABZicJgiMM8Fy18NFltXSPZNt2GB5YRb4Yl/q6bRGUV11scHb55f2fhBAc5f3Cd0fUhH4grKWSYLPHQyYP3guOohZ5AezGUNCUY8TgG7iB1V4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPsQO3AX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6CCDC4CEC3;
	Sat, 28 Sep 2024 16:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727542327;
	bh=yKRhcmgvO7ZUa0g4UElPy8WX5eVQgICXeFas361yv0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SPsQO3AXMIdwpFhAzHvxcA6+anoVkK8kVWOyVqkr+15ltxED7ojpGMOm3Dh1thosy
	 37/aRjS4zbaBnM52Ej0PHR4byq8MXvMCaV9e2YZU+Pjo769FZvDbyfWgd5apcdtu/Q
	 aI9+MvtbOagWDw7vkiE9bRHEoWy1QvuYCP9OVBP4L1lV3wt9FOE5fgQxXLegrzwl6/
	 r7yWzHOQ3e43A0AcupdiTOnoaK/c4y873w3gbunSVbIRY2P3+iEc9yG1y+m+GG/6T6
	 fSv/1xlPzvxljMbwxF+alIf2bbcD9zZHg6sO0Zk8hfmXNuo6xbPK5N2otDjroAkyeh
	 2fcz26ijYEJ6A==
Date: Sat, 28 Sep 2024 06:52:05 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <andrea.righi@linux.dev>
Cc: void@manifault.com, peterz@infradead.org, mingo@redhat.com,
	kernel-team@meta.com, linux-kernel@vger.kernel.org,
	sched-ext@meta.com, Daniel Hodges <hodges.daniel.scott@gmail.com>,
	Changwoo Min <multics69@gmail.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>
Subject: Re: [PATCH 3/3] sched_ext, scx_qmap: Add and use SCX_ENQ_CPU_SELECTED
Message-ID: <Zvg0NarLiSoguzCA@slm.duckdns.org>
References: <20240927234838.152112-1-tj@kernel.org>
 <20240927234838.152112-4-tj@kernel.org>
 <ZvgC6rhPCxXYTrh6@gpd3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvgC6rhPCxXYTrh6@gpd3>

Hello,

On Sat, Sep 28, 2024 at 03:21:46PM +0200, Andrea Righi wrote:
...
> > sched core has been udpated to specify ENQUEUE_RQ_SELECTED if
> > ->select_task_rq() was called. Map it to SCX_ENQ_CPU_SELECTED and update
> > scx_qmap to test it instead of SCX_ENQ_WAKEUP.
> 
> Even if it's quite convenient to have the SCX_ENQ_CPU_SELECTED flag
> provided by kernel, I was wondering if we could just delegate this whole
> logic to BPF and avoid introducing this extra flag in the kernel.
> 
> In theory we could track when ops.select_cpu() is called by setting a
> flag in the BPF task context (BPF_MAP_TYPE_TASK_STORAGE). Specifically,
> the flag could be set in ops.select_cpu() and cleared in ops.stopping().
> Then, when ops.enqueue() is called, we can check the flag to determine
> whether ops.select_cpu() was skipped or not.
> 
> Since most of the scx schedulers already implement their own task
> context, this shouldn't add too much complexity/overhead to the BPF
> code, it'd be fully backward-compatible and it doesn't depend on the
> particular kernel logic that calls ->select_task_rq(). WDYT?

Yeah, that would work too and probably what we should do to work around on
older kernels, but also it's a relatively obvious hole in the API and we
don't lose anything by updating the kernel to indicate the state.

Thanks.

-- 
tejun

