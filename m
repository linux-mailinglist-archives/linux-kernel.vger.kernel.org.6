Return-Path: <linux-kernel+bounces-411034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B709CF1FC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EF302954AC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4B51DD0E1;
	Fri, 15 Nov 2024 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKBSI3XD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474531D54E2
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 16:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731689070; cv=none; b=TKVLAsaJaMif5DGyONObj6cCorbTsK4EnujuksstuKwdmk31D/0HHqgK+bCCJAJjpGUxyW0TjYPwZtkGjeEj7XPbZC4x0Fi11201cKXMyk+2Ol7WbknZ95WLDqLYqS4w5ErwYYEwoh+MXO+qjf0UwV8wwI8ARv02IIuyO3xFX+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731689070; c=relaxed/simple;
	bh=akiNJQx+ZCZjtwKblHx8WJ6hGg5i2uj18CmiFXB4DZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXrXwuedS0Mokn1kNJIbW60DPuJpS8ON5Zfbs6iIF5ZCr+I5/0Jef6XqI8tvtOAI2FPBXUj9wGs7iO7ON5z3IOPDf5RM94S/j6ALw1Holi8XaoxsA1FRfxaZE+UM9T6LYMwC8jt8ldhn1k0A8RzY6KAgjehrBSlVe+qtKunPnqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKBSI3XD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA1CC4CECF;
	Fri, 15 Nov 2024 16:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731689069;
	bh=akiNJQx+ZCZjtwKblHx8WJ6hGg5i2uj18CmiFXB4DZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UKBSI3XDFVeA0419fxIPf58B3e72boVbPHKT4lcACEhgkoa6jhgXTfh1yKCMq1wpv
	 KMlLDHXVSUMlGZVHcP4vQ32HKFDKzPQs6KyQKnJ+JiokrA4er3m8IzHQNdsRjGJR7T
	 eOregjxv5OcoBq3rSw1wvniqVCsiWevfgLvbXlx07NXB+CYJWp+smDu+b0rg/MqTEq
	 sQJ0H1aStk9fqM/zM1X44o2WpRnxoyn5ys0cLK6A+VVBArOksLCqDRYTp+Chg1i+qp
	 cwNDYfztxqZNqo0H/2DRdC3G7EsEH4CMyrji9ifOUGVv2+AgZ7T86NqTa7tV9+ND1a
	 YJK/mGq7wwWag==
Date: Fri, 15 Nov 2024 06:44:28 -1000
From: Tejun Heo <tj@kernel.org>
To: Wangyang Guo <wangyang.guo@intel.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
	Tim Chen <tim.c.chen@linux.intel.com>, tianyou.li@intel.com,
	pan.deng@intel.com
Subject: Re: [PATCH] workqueue: Reduce expensive locks for unbound workqueue
Message-ID: <Zzd6bLND-dwE-xZb@slm.duckdns.org>
References: <20241115054936.113567-1-wangyang.guo@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115054936.113567-1-wangyang.guo@intel.com>

On Fri, Nov 15, 2024 at 01:49:36PM +0800, Wangyang Guo wrote:
> For unbound workqueue, pwqs usually map to just a few pools. Most of
> the time, pwqs will be linked sequentially to wq->pwqs list by cpu
> index.  Usually, consecutive CPUs have the same workqueue attribute
> (e.g. belong to the same NUMA node). This makes pwqs with the same
> pool cluster together in the pwq list.
> 
> Only do lock/unlock if the pool has changed in flush_workqueue_prep_pwqs().
> This reduces the number of expensive lock operations.
> 
> The performance data shows this change boosts FIO by 65x in some cases
> when multiple concurrent threads write to xfs mount points with fsync.
> 
> FIO Benchmark Details
> - FIO version: v3.35
> - FIO Options: ioengine=libaio,iodepth=64,norandommap=1,rw=write,
>   size=128M,bs=4k,fsync=1
> - FIO Job Configs: 64 jobs in total writing to 4 mount points (ramdisks
>   formatted as xfs file system).
> - Kernel Codebase: v6.12-rc5
> - Test Platform: Xeon 8380 (2 sockets)
> 
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Wangyang Guo <wangyang.guo@intel.com>

Applied to wq/for-6.13.

Thanks.

-- 
tejun

