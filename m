Return-Path: <linux-kernel+bounces-315893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C7196C842
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303F91C22728
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117951448E4;
	Wed,  4 Sep 2024 20:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfIGtva8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740821EBFEC
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 20:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481178; cv=none; b=d2nC3EE+aTzRkAB+QMrSQmR45h3jQeD1rxjE2WeSdjgJYuUrIm30o11N+QBPOKPBQ05xdplFw8ZNMr5F4zc9lnVN8MkDzX5YigBEaFxHEEs63269LIQnu7yVdSELSYXoNJLRwGoT1Kw9WG0dGKloT1GhMNAqkwttzHoQdPEMO80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481178; c=relaxed/simple;
	bh=6E+z1a4feayFGttJhcEnyuo7bEGQuJ7HBIny5vcGLC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOl5okxmk5hzs7ETjt8AAHEbxoMITMy+0swYGGwTU7Tqn7x+IorVMbBIx60FgTqXLQ6IypE2XLckW1baE+ePmPV9TyzXkrZSY7k2IUBRH31Sw8BlOXYZwobuIUhnWZMvcZQIVRJUL3YmWGeXovE4eceCGYBzVTaIPNripyiMljM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfIGtva8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3D7C4CEC2;
	Wed,  4 Sep 2024 20:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725481178;
	bh=6E+z1a4feayFGttJhcEnyuo7bEGQuJ7HBIny5vcGLC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rfIGtva8IuEI31S2RVkGrjjFhYVUx4nWkpQVKDYUmytbvZqg0rpbHSSgV5zTFV1lY
	 vAZ58RQZLaZiVjaEOfh7Isq7igt6d1NAgtuAggsSnrrb2bqi6C8LLX/Oe/79SR8EmX
	 U0Gn/AgzEX4lSrR3r6WwV+Pb/lCwATuvRMb5ih8hKmyraKWxHi8X6IS1XRtNc0MZ2Y
	 rkfzqsAmN+bpz46Yva8WnrxzGReA05fTNVjF1q9mpQYZbJjT/r2vzOM7l/FXCtF9Qb
	 aDJpSPgQnLqUyLP6uKI2TMVSzMWLU9DIxyNn0ZCBkc7d7SXA4tjSxovHI+kGEuToxc
	 +Q3mfVySUO2NQ==
Date: Wed, 4 Sep 2024 10:19:36 -1000
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org,
	peterz@infradead.org
Subject: Re: [PATCHSET sched_ext/for-6.12] sched_ext: Apply pick_next_task()
 updates and remove switch_class()
Message-ID: <ZtjA2Kk52dbnWaSC@slm.duckdns.org>
References: <20240904080326.1132275-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904080326.1132275-1-tj@kernel.org>

On Tue, Sep 03, 2024 at 10:03:02PM -1000, Tejun Heo wrote:
> d7b01aef9dbd ("Merge branch 'tip/sched/core' into for-6.12") received sched
> core udpates around pick_next_task() and put_prev_task(). While the merge
> commit added a minimal workaround to keep sched_ext building and mostly
> functioning, sched_ext is currently out of step with other sched classes.
> 
> This patchset brings sched_ext upto the code by replacing
> pick_next_task_scx() with pick_task_scx() which doesn't require the current
> task to be queued and can detemrine between the current task and the top of
> the local DSQ statelessly. This allows unifying regular and core-sched pick
> task paths. After the updates, sched_class->switch_class() is no longer used
> and dropped.
> 
> This change causes two subtle API changes for the BPF schedulers. Both are
> desirable and all the existing schedulers should be okay with them.
> 
> The patchset is also available in the following git branch:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-pick_task
> 
> and contains the following patches:
> 
>  0001-sched_ext-Don-t-call-put_prev_task_scx-before-pickin.patch
>  0002-sched_ext-Replace-SCX_TASK_BAL_KEEP-with-SCX_RQ_BAL_.patch
>  0003-sched_ext-Unify-regular-and-core-sched-pick-task-pat.patch
>  0004-sched_ext-Relocate-functions-in-kernel-sched-ext.c.patch
>  0005-sched_ext-Remove-switch_class_scx.patch
>  0006-sched_ext-Remove-sched_class-switch_class.patch

Applying to sched_ext/for-6.12.

Thanks.

-- 
tejun

