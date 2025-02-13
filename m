Return-Path: <linux-kernel+bounces-513527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF60A34B2F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAE0A16ED97
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E553328A2BD;
	Thu, 13 Feb 2025 16:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FP8FQGjt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B5A28A2B8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465870; cv=none; b=c+vu+DSATByZoUmCSzHpUU5eJDrm+yzSXftYiwSBOU0M5Pz9BNUY7v0x9/fC7RDw/DObTDIebYhQmyoRAtMKBSwIL7VNLlzntQ1A1tEaO+WBdEP/Kyaz7SC2qnE0WxNc9ytfsgcJJi3yIddO4Zlp4gistGS560+5RK4oGladBiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465870; c=relaxed/simple;
	bh=TiOFrWknCmCxOjO0cZRKr0nz5wjGtkBdyqJ2Eu8qIKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHks7pS3d7x6DNaOaaXDI/nvzz1E6PDdHsThNSQUJFrDLUovOIt9J7xn/a41ENerobOirCo8nVDtzCpYXpJ+ORRLuht+UOaN9ArGWnPZX6PlM/rBwLoars8FaLqmyWS28TcGAlYQwQdOmpJ5CSjDx6Gp1U4QhX09oo41NfJG2Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FP8FQGjt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB6AC4CED1;
	Thu, 13 Feb 2025 16:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739465869;
	bh=TiOFrWknCmCxOjO0cZRKr0nz5wjGtkBdyqJ2Eu8qIKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FP8FQGjttA7DLOb1ySFxrlnTQ4AS9oUxnRSZL08tZUIaR3IlzDR6rrWe0alWNxatQ
	 kHNxkMb52Zj1YSGt9cx41QBQR/ilG/WEB5SLNYJGHL7n3L5oo2rZeq3hnSiYIK6cu0
	 HiRKSfAqcD5hy5KjBG/47DepZ4yBVBi8DkcL/Pl4cb6PuTwzF//pWgCrBh/tifLgi+
	 eDA+L5/ZHMaDpR7Kv+hNT/1/mgz9OukpboO+/s78tYzs/acY9pWVL8x/7cpguMfWbC
	 R9emjLkIk2GHLs4ecWaXeDfhSjcMdVeRGl3dZYUKXPVij4+p9Bjvniz3JKBIDySa//
	 EATyB11awE++A==
Date: Thu, 13 Feb 2025 06:57:47 -1000
From: Tejun Heo <tj@kernel.org>
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Use SCX_CALL_OP_TASK in task_tick_scx
Message-ID: <Z64ki36mCAmT0ORF@slm.duckdns.org>
References: <20250212130935.1585338-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212130935.1585338-1-zhouchuyi@bytedance.com>

On Wed, Feb 12, 2025 at 09:09:35PM +0800, Chuyi Zhou wrote:
> Now when we use scx_bpf_task_cgroup() in ops.tick() to get the cgroup of
> the current task, the following error will occur:
> 
> scx_foo[3795244] triggered exit kind 1024:
>   runtime error (called on a task not being operated on)
> 
> The reason is that we are using SCX_CALL_OP() instead of SCX_CALL_OP_TASK()
> when calling ops.tick(), which triggers the error during the subsequent
> scx_kf_allowed_on_arg_tasks() check.
> 
> SCX_CALL_OP_TASK() was first introduced in commit 36454023f50b ("sched_ext:
> Track tasks that are subjects of the in-flight SCX operation") to ensure
> task's rq lock is held when accessing task's sched_group. Since ops.tick()
> is marked as SCX_KF_TERMINAL and task_tick_scx() is protected by the rq
> lock, we can use SCX_CALL_OP_TASK() to avoid the above issue. Similarly,
> the same changes should be made for ops.disable() and ops.exit_task(), as
> they are also protected by task_rq_lock() and it's safe to access the
> task's task_group.
> 
> Fixes: 36454023f50b ("sched_ext: Track tasks that are subjects of the in-flight SCX operation")
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>

Applied to sched_ext/for-6.14-fixes.

Thanks.

-- 
tejun

