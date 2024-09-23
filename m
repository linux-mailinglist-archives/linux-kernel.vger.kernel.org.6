Return-Path: <linux-kernel+bounces-336152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3201297EFCC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 19:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8221F22108
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0D119F125;
	Mon, 23 Sep 2024 17:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgB2MJ1A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FF81474BC
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 17:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727111930; cv=none; b=XfryCUCOSNzeo3eny+5sLwyX6I7E3DsFzPR4t009F8am6GZc6QV+xG4dsq3L2CnF2acX/pzXglW+6ejG8FannwudHeZIm2vt21cq0ca1hJo76nwAtanJ17KD6VAKk+/cMuhuKKdH+KbZ93E7cJkICeOAbmsPFGnO6phcwYWpOto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727111930; c=relaxed/simple;
	bh=SsKDtEbKl8KglAPeWxmOGNPbtBShCT5tjVuXyO1KJ4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nd+K6ZlN5+zR/1zg4adHpESyPfkkOW7DOHqWIOazNMZAGRloLdARCUPmcOupaxHGk//4t24UUAs5n/8cM5NtWE8q01wrSB5Iygjl6eqyBnGms+2nldQxgtnnqslDFKit0T7rrM6T4TOM2Q6mmIrhIhjB4MXoosSyXY9DS7T7uu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgB2MJ1A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0C5C4CEC4;
	Mon, 23 Sep 2024 17:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727111929;
	bh=SsKDtEbKl8KglAPeWxmOGNPbtBShCT5tjVuXyO1KJ4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OgB2MJ1A/Tvy9yu31wKQsGmwRUzQeEbcUV8gh05j5NxzE5E94LBIdpoIXj3oy7gEC
	 C+/fKbD139h/x51+ni9rog9ck6+0aJjkzeTnrqfEV53gpXhrig3xuyMaUIIxcmhDY9
	 kmfnhCE2yCpcpxBuYEQBuqmV0wNds1HEueTSeC8gTxSf0uTVRRK0d6Rq2YwAHae+WG
	 gKXfHgB+GZae29r36rJVyaVReepsRVANGP7HWrpNLyFt8+BYRi9yt5e6KSRtKyXtc+
	 HraMqY2C+XKpvgr3wYF0rPC5+6PHf0sd3I1qqsKHcgGh/Liysg/8vfOJESy4Cm5Y+8
	 mU5vXRd3UX16g==
Date: Mon, 23 Sep 2024 07:18:48 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, sched-ext@meta.com,
	David Vernet <void@manifault.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [GIT PULL] sched_ext: Fixes for v6.12-rc1
Message-ID: <ZvGi-Ciqmy8U5g_j@slm.duckdns.org>
References: <ZvGfmIJt-5gg9EwU@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvGfmIJt-5gg9EwU@slm.duckdns.org>

Forgot to cc Peter and Ingo for the fixes that touch sched core. Cc'ing and
quoting whole body.

On Mon, Sep 23, 2024 at 07:04:24AM -1000, Tejun Heo wrote:
> The following changes since commit 88264981f2082248e892a706b2c5004650faac54:
> 
>   Merge tag 'sched_ext-for-6.12' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext (2024-09-21 09:44:57 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.12-rc1-fixes
> 
> for you to fetch changes up to 431844b65f4c1b988ccd886f2ed29c138f7bb262:
> 
>   sched_ext: Provide a sysfs enable_seq counter (2024-09-23 06:53:02 -1000)
> 
> ----------------------------------------------------------------
> sched_ext: Fixes for v6.12-rc1
> 
> - Three build fixes.
> 
> - The fix for a stall bug introduced by a recent optimization in sched core
>   (SM_IDLE).
> 
> - Addition of /sys/kernel/sched_ext/enable_seq. While not a fix, it is a
>   simple addition that distro people want to be able to tell whether an SCX
>   scheduler has ever been loaded on the system.
> 
> ----------------------------------------------------------------
> Andrea Righi (1):
>       sched_ext: Provide a sysfs enable_seq counter
> 
> Pat Somaru (1):
>       sched, sched_ext: Disable SM_IDLE/rq empty path when scx_enabled()
> 
> Tejun Heo (1):
>       sched_ext: Fix build when !CONFIG_STACKTRACE
> 
> Yu Liao (2):
>       sched: Add dummy version of sched_group_set_idle()
>       sched: Put task_group::idle under CONFIG_GROUP_SCHED_WEIGHT
> 
>  Documentation/scheduler/sched-ext.rst | 10 ++++++++++
>  kernel/sched/core.c                   |  3 ++-
>  kernel/sched/ext.c                    | 24 +++++++++++++++++++++---
>  kernel/sched/sched.h                  | 10 ++++++----
>  tools/sched_ext/scx_show_state.py     |  1 +
>  5 files changed, 40 insertions(+), 8 deletions(-)
> 
> -- 
> tejun

-- 
tejun

