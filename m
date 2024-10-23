Return-Path: <linux-kernel+bounces-378741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4AC9AD4B8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 21:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C666283672
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867761D9A50;
	Wed, 23 Oct 2024 19:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8KH4DCz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86471CDA3A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 19:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729711556; cv=none; b=JK0c66NQxbXmocD9TIv2/dUtLz0T9bIUjG7nmY+bRC1BZSkToSJXbUpmajaoIi4MIcJBqlIu81DcEC7coYeJ4PmWbDkUrB0R2/0JT37vIqnavrcYURnimGNj/uGdgcDdzadePypKRn4gZRpVO8FJJY9EshGEdbwR2BVduGddHsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729711556; c=relaxed/simple;
	bh=dv3xK1136bDEpg0pZGmigB4aLUpf7pKcGVOXcmaOkWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3ZZYPM6za+A5i2bivEOzN/5bI7Utn/oO76RdI1CW5Yzm1X8+jajH2Hy6UhuOlNp/IUVrHHKMwOvqk0VA4y7klupydl5k/D33KJjq1vlwVvNmU1gTsKTp4je1UwVdKPaHJWmFouZSMa7Y9/pN7ZuSmrz/m02lCmN/8VZGLIwZiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8KH4DCz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F848C4CECD;
	Wed, 23 Oct 2024 19:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729711555;
	bh=dv3xK1136bDEpg0pZGmigB4aLUpf7pKcGVOXcmaOkWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a8KH4DCz9gLP+4L1lW/NUnTwm+VQocJwJk27Z4R01hzuyLLtgP+zWZ31p7K3Gktp7
	 wMWEJcq0QLCTB/w2HVhusojxNOdR2TbERzR5JfrMrBc6S/pmNJTKSGhLE8Qg/jjESp
	 zbVHoAw4oNtVi7sYWaK1VDukb3XWqBDBXO+DcekYyHvPz9u0503Nwh1IdlOhwHHAq6
	 NV3N8WTqhdBZtPaQe8WdtlV9k9ws6Ca4sz6TDn/wSzTGbpGakK2dt+WKUlCXxKuxAg
	 gJ+tY5uaY/H8OaI+TeINMV5jvbEa2uaLSep0VnI/PeZtPRUrLvioX1UluJfjP3Yk2G
	 H/QBZNtfyq2EA==
Date: Wed, 23 Oct 2024 09:25:54 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched_ext: Introduce LLC awareness to the default
 idle selection policy
Message-ID: <ZxlNwjogmNHQi7Se@slm.duckdns.org>
References: <20241022234718.63258-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022234718.63258-1-arighi@nvidia.com>

On Wed, Oct 23, 2024 at 01:47:18AM +0200, Andrea Righi wrote:
> Rely on the scheduler topology information to implement basic LLC
> awareness in the sched_ext build-in idle selection policy.
> 
> This allows schedulers using the built-in policy to make more informed
> decisions when selecting an idle CPU in systems with multiple LLCs, such
> as NUMA systems or chiplet-based architectures, and it helps keep tasks
> within the same LLC domain, thereby improving cache locality.
> 
> For efficiency, LLC awareness is applied only to tasks that can run on
> all the CPUs in the system for now. If a task's affinity is modified
> from user space, it's the responsibility of user space to choose the
> appropriate optimized scheduling domain.
> 
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Applied to sched_ext/for-6.13.

Thanks.

-- 
tejun

