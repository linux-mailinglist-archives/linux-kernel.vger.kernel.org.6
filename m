Return-Path: <linux-kernel+bounces-342154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26531988B09
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 22:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495391C220DF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 20:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB4A1C1AA8;
	Fri, 27 Sep 2024 20:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8eQ9rmt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5861474B5
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 20:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727467430; cv=none; b=bOIahaP14Re4nHa62t2nOmOxtqf0I7gzoH+e60cihRwbJI/uQeaUgHPf0WvTrZfAlUIt7bnyMvY2lWOhRL5wim0z7ZMFYH8PTAvorK3hVDhhjOTwMJFBV99NRStc3k0NlRgHaK1EtNsYMvOWRQVAvDccPKVtq4MHxShokCFGgvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727467430; c=relaxed/simple;
	bh=3uglxUsJ67JuWNCwJxJ+5gn8ysIXu/NPK69DAbglC3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6rIDIKsesplJD1XuWPv3j0vBTf4tXAVX94rRrvVpU/08DY7363XpdyQIB8WCeu3///89hp6jXbuHsZeLX9nw88HndnIB8WVEYnoIa/Ufd6k+bvmNuXdOxn6Eo0z75UO+iD0QX2koF4c1RY8DHP0eTDgAeoXcYhbXuQYun+v0XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8eQ9rmt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A81C4CEC4;
	Fri, 27 Sep 2024 20:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727467429;
	bh=3uglxUsJ67JuWNCwJxJ+5gn8ysIXu/NPK69DAbglC3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D8eQ9rmtXSVCI09e29BP5VUvH5hDNoFt1T7pe3VJ0TKCA02XrcFLJMrxlBT+90kRM
	 /ov16AKCPCK9QFbTJW4QFwi1WB/4UyZKyxuo832YN/HOOpgzLJGK++5gciT3cPmamg
	 iplfW8u8vINhePaoxPfGRoy8C5s/OB38qoCFwaeoS3a36w8VGhvXuNvGdz5vTjCRQl
	 sPTnqcHtiASOi7SUnWr/vPXJKppn1usNFMboHg0sewlhn/U5kHzL3XTp2BGtRyFgsk
	 jgPePE+4REqlBUCTDOFigWgtmIy4tQIvtY1U0B3YBTk++zVi3udbi0hhneh5aR0Wwj
	 fdQc7sJNgejCA==
Date: Fri, 27 Sep 2024 10:03:48 -1000
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org, sched-ext@meta.com,
	aboorvad@linux.ibm.com
Subject: Re: [PATCHSET sched_ext/for-6.12-fixes] sched_ext: Fix locking
 enable/disable path bugs includling locking order one
Message-ID: <ZvcPpEJxeeDy_sGI@slm.duckdns.org>
References: <20240923190020.1446325-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923190020.1446325-1-tj@kernel.org>

On Mon, Sep 23, 2024 at 08:59:27AM -1000, Tejun Heo wrote:
> Aboorva Devarajan reported an issue where sched_ext init code can
> occasionally deadlock when scheduler loading races CPU hotplug. The deadlock
> scenario is as follows:
> 
>        scx_ops_enable()                               hotplug
> 
>                                           percpu_down_write(&cpu_hotplug_lock)
>    percpu_down_write(&scx_fork_rwsem)
>    block on cpu_hotplug_lock
>                                           kthread_create() waits for kthreadd
> 					  kthreadd blocks on scx_fork_rwsem
> 
> Note that this doesn't trigger lockdep because the hotplug side dependency
> bounces through kthreadd.
> 
> This is primarily caused by SCX enable/disable paths grabbing big locks
> together. This patchset updates the enable/disable paths to decouple the
> locks. In the process, it also fixes several subtle bugs in the enable path.
> 
> This patchset contains the following patches:
> 
>  0001-sched_ext-Relocate-check_hotplug_seq-call-in-scx_ops.patch
>  0002-sched_ext-Remove-SCX_OPS_PREPPING.patch
>  0003-sched_ext-Initialize-in-bypass-mode.patch
>  0004-sched_ext-Fix-SCX_TASK_INIT-SCX_TASK_READY-transitio.patch
>  0005-sched_ext-Enable-scx_ops_init_task-separately.patch
>  0006-sched_ext-Add-scx_cgroup_enabled-to-gate-cgroup-oper.patch
>  0007-sched_ext-Decouple-locks-in-scx_ops_disable_workfn.patch
>  0008-sched_ext-Decouple-locks-in-scx_ops_enable.patch

Applied to sched_ext/for-6.12-fixes.

Thanks.

-- 
tejun

