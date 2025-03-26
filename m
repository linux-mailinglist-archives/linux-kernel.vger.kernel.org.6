Return-Path: <linux-kernel+bounces-577680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 100BDA72037
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 21:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB12172BAD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011E725DCE9;
	Wed, 26 Mar 2025 20:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFYOwGFS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622F91F8901
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 20:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743022171; cv=none; b=UYBlPVghADk7O5aOnu7E62NKVFGvsTThaVDSnEplLcfAEaq6EaivDZWFEq/z7wbq4HPzZ9WaNbw4xqp43vuYW+ZttUWNLA2KQ6+/LSsyI7qUqh5nEdi8DDSK5CUFix8iJ3Rr+EV+AxaqXe3U4bRQTLoSCpTC67XxztLIFFGiftg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743022171; c=relaxed/simple;
	bh=PcSjWA7MXwFfyvPKFloh1oReYLk1/2AWnKMGIn5AHRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1BuTQA77Cj/Wm6+9Ls+AWkJDoJkvpC4kUL8Evc49voGYofe2Yi4Dh7Xs6EYp8qDCO8WjkZ3GIBrxQmU7YNwMiHkFH8U227DAVVjhw8FGEMkZN/vezsyR/ZRacV/ZNtHzS8XDaV8eZr9qsnkICG5FzHw6YHx6JpcdG40R+oGcdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFYOwGFS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6D3C4CEE2;
	Wed, 26 Mar 2025 20:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743022170;
	bh=PcSjWA7MXwFfyvPKFloh1oReYLk1/2AWnKMGIn5AHRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fFYOwGFSEqBZJGpNRaTumru73lVvdAR6s0usdA29N3p/UfkVbAYHw04K78Yw9LlFl
	 xZY1IaQ6JuEfhfkBseebBpW+Ey33ckmFXZ6mYNqLcvBo+hWUQ5kX+MyP++WUMbYOoh
	 ZL2wbxXwlfdQL69LzZaNVMxbUHPQTdMDo9YCyr22ODRIkDIhBSo1BaNwoGik14JWfw
	 qmcThEJG/ckwIdQMAb2988QFqvDwxOPRBjRQy8FcMr0l/44IRVcMBG8xYoh7ojO+nQ
	 xqJL1/XINqbvp33K5tFNCe+4o2ts9+pHRy+5jJzKQ+BaEOqy7mMnDybPjj6IngnMPD
	 2cOsRgeRXlCKA==
Date: Wed, 26 Mar 2025 10:49:29 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: initialize built-in idle state before
 ops.init()
Message-ID: <Z-RoWbLDwgqGYvtq@slm.duckdns.org>
References: <20250325093212.47188-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325093212.47188-1-arighi@nvidia.com>

On Tue, Mar 25, 2025 at 10:32:12AM +0100, Andrea Righi wrote:
> A BPF scheduler may want to use the built-in idle cpumasks in ops.init()
> before the scheduler is fully initialized, either directly or through a
> BPF timer for example.
> 
> However, this would result in an error, since the idle state has not
> been properly initialized yet.
> 
> This can be easily verified by modifying scx_simple to call
> scx_bpf_get_idle_cpumask() in ops.init():
> 
> $ sudo scx_simple
> 
> DEBUG DUMP
> ===========================================================================
> 
> scx_simple[121] triggered exit kind 1024:
>   runtime error (built-in idle tracking is disabled)
> ...
> 
> Fix this by properly initializing the idle state before ops.init() is
> called. With this change applied:
> 
> $ sudo scx_simple
> local=2 global=0
> local=19 global=11
> local=23 global=11
> ...
> 
> Fixes: d73249f88743d ("sched_ext: idle: Make idle static keys private")
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Applied to sched_ext/for-6.15-fixes.

Thanks.

-- 
tejun

