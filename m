Return-Path: <linux-kernel+bounces-532230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA282A44A62
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BEB116B4BC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C91A19E998;
	Tue, 25 Feb 2025 18:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NM5jAP5N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC6619ADA2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 18:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740508238; cv=none; b=OZ8BWIJXNFcbQtz0aANyxNXeDFpEORomb8zMRJ56PwhCjSW1LFLZm42UWjUL0hbtwH+StYZfc8DbdvQdGiD3NjVlVq+gK/u+iCQXdJmxR/yD6ZX6e97jP4pEuF6ZABC3UCc97wnydC1dP+5/ho3hA6MC2f8aoqbaBsoSfqVm8gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740508238; c=relaxed/simple;
	bh=Ium2QLfl32OjTwDrKz/6n4+Fa0knub6CtKddhBxbL/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6U5aty0+FAjIvAhIP/eCk0vP9/lYbsXnjsmwr2aGX5XRolj4iTLTmOIpntszF3Lbk3nOBBWRm1BTTYLXaX8OW2k4NhDCFEnFLWZfgC0wQO586/umPyAHLGFOfIM27H5mMXY2YHvXOEjVsURel9pM5Jdn7KIyv1lBqJ5ePkb10c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NM5jAP5N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A8AC4CEDD;
	Tue, 25 Feb 2025 18:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740508238;
	bh=Ium2QLfl32OjTwDrKz/6n4+Fa0knub6CtKddhBxbL/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NM5jAP5NvgWZ8AVJpBGdRj8j4Bd8UDcTfyS2M0bjx8SZhphZbgvDnaX7poDs0knX+
	 QbcZ43zSKgh9Z5KbZWrQ2ThOcUeIjK2EUaN0vci35p95aoYSolmDnLUI8/EHauOv9D
	 uds0loE/qhlrEOiLYDSgqbcZeTQuezXqCdYQ4yycZNYB/InhaZ9fN91oK1vbRz04Tm
	 NrmtEWFkSrrm0VHVwanWNJV8M2u+snYcsus07lBODs9dEepN7wbG7InRqamVu0I057
	 69oB8reJaqKvs64YQkd+6LAgEQgTFnTol1G3p6+dWmXfjp7Kjp1r4pDKSpAMPq/1YH
	 gCN/99IjszhDw==
Date: Tue, 25 Feb 2025 08:30:36 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@meta.com
Subject: Re: [PATCH sched_ext/for-6.14-fixes] sched_ext: Fix pick_task_scx()
 picking non-queued tasks when it's called without balance()
Message-ID: <Z74MTER2Mycqt8xg@slm.duckdns.org>
References: <Z73pjysZYNEIbkiy@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z73pjysZYNEIbkiy@slm.duckdns.org>

On Tue, Feb 25, 2025 at 06:02:23AM -1000, Tejun Heo wrote:
> a6250aa251ea ("sched_ext: Handle cases where pick_task_scx() is called
> without preceding balance_scx()") added a workaround to handle the cases
> where pick_task_scx() is called without prececing balance_scx() which is due
> to a fair class bug where pick_taks_fair() may return NULL after a true
> return from balance_fair().
> 
> The workaround detects when pick_task_scx() is called without preceding
> balance_scx() and emulates SCX_RQ_BAL_KEEP and triggers kicking to avoid
> stalling. Unfortunately, the workaround code was testing whether @prev was
> on SCX to decide whether to keep the task running. This is incorrect as the
> task may be on SCX but no longer runnable.
> 
> This could lead to a non-runnable task to be returned from pick_task_scx()
> which cause interesting confusions and failures. e.g. A common failure mode
> is the task ending up with (!on_rq && on_cpu) state which can cause
> potential wakers to busy loop, which can easily lead to deadlocks.
> 
> Fix it by testing whether @prev has SCX_TASK_QUEUED set. This makes
> $prev_on_scx only used in one place. Open code the usage and improve the
> comment while at it.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Pat Cody <patcody@meta.com>
> Fixes: a6250aa251ea ("sched_ext: Handle cases where pick_task_scx() is called without preceding balance_scx()")
> Cc: stable@vger.kernel.org # v6.12+

Applied to sched_ext/for-6.14-fixes.

Thanks.

-- 
tejun

