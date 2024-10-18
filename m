Return-Path: <linux-kernel+bounces-372382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E4B9A47E9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62590B23843
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2D0202637;
	Fri, 18 Oct 2024 20:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LK4qxbrZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B93C18C32A
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 20:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729283200; cv=none; b=Tgwl7MiuMyrGD51BiQDu8KJ8DqWhTLO19m+9YUoEV+Hg+ZKJWlaKVkAEOdoI82qAk40o7fNmVRpDa1sul9B7U0jwnlnAmiSCiffFNkArR3nTq31/figrWFanqtKReeCprOaXgIIoEd8eTKrxQrfew1jz0PQef3Wozqozdia0HN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729283200; c=relaxed/simple;
	bh=m1gA4gSTnAoCx9RzLHmgBYXWrCqqE/mPzaNWIWHHCrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1WgIYFsHF/5OITyxvNrT136tZ1mxAsuuUer4AoUURKq9YeoZsFwO63inmQ8yztExIOn1tccTAOq9uqVdKev9uFjb8F0k/iP8cT2/NSHwkl8rIdgqCdxbfn3aftyzZDJht6xWXg7h3cvUpqHezuRIYdm9o0ke831ql8fdvPOLSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LK4qxbrZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F2BC4CEC3;
	Fri, 18 Oct 2024 20:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729283200;
	bh=m1gA4gSTnAoCx9RzLHmgBYXWrCqqE/mPzaNWIWHHCrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LK4qxbrZZns6+wBcKyk4G82DYGlDpQGTWxneGOrGc0jgZHWC2nRwa+UK4ZuLQrXgJ
	 AODyigrXMmdwBqjmlZA1IFYvrSZBq6BpgI4DJMp3GGcrZRzq3c7aRT1DSffecrOgq1
	 AHffSYCfPDigWEJwIkxKOFs2EIJupMy6E6iagBwXQrDUWXXG1OLy4LZrg2AxVxky9/
	 q3FSdbYSkkYhNpwLbpsVW/o0aSP8SmZCacKlxDaBEzGqFrVJupwlCq+OlxJaG+uKFO
	 K0F9v8axKJ5DK96WUHMdCaUo4TsAOvjcMOVE4ibVe+yiUbz7F5Xr4b+Hk9yN3RPIW1
	 ThSR2//Pul3xA==
Date: Fri, 18 Oct 2024 10:26:38 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <andrea.righi@linux.dev>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: improve WAKE_SYNC behavior for default
 idle CPU selection
Message-ID: <ZxLEfqsZJH6Mp1Fd@slm.duckdns.org>
References: <20241018180951.599625-1-andrea.righi@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018180951.599625-1-andrea.righi@linux.dev>

On Fri, Oct 18, 2024 at 08:09:51PM +0200, Andrea Righi wrote:
> In the sched_ext built-in idle CPU selection logic, when handling a
> WF_SYNC wakeup, we always attempt to migrate the task to the waker's
> CPU, as the waker is expected to yield the CPU after waking the task.
> 
> However, it may be preferable to keep the task on its previous CPU if
> the waker's CPU is cache-affine.
> 
> The same approach is also used by the fair class and in other scx
> schedulers, like scx_rusty and scx_bpfland.
> 
> Therefore, apply the same logic to the built-in idle CPU selection
> policy as well.
> 
> Signed-off-by: Andrea Righi <andrea.righi@linux.dev>

Applied to sched_ext/for-6.13.

Thanks.

-- 
tejun

