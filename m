Return-Path: <linux-kernel+bounces-382658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5424A9B1186
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 23:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFFEEB24C8A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 21:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9B5217F59;
	Fri, 25 Oct 2024 21:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qG8OtYN/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09D6217F20
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 21:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890723; cv=none; b=ILEpCxYoNcuXAU43jkV/IQuQuaoxts26YsC7Gr3G8wDXC7doU2cmyuFFWJHdlxUVtWyxWdhMtNXO78989pzLjtURp2IcVkqdZmSoK1Ysz0HUpbHAMFv71AZUkScubDlNldR8eKwZHLq+K/spECBxD2DUQ6+th8Edxhvpz54Tx8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890723; c=relaxed/simple;
	bh=ITkCa2nLRnfgf4FH1RrHbtuIRQzsTB17WU75UTJB76w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBwgC2T4TS/MQiLc0aJirTpAnEIbe2SABfiECFKsSt9tI1SIBWNg7XyWizDEnLU34bhril0teL78DoF924PpfcqJLHUvSLKYfoJdnELbnU9c6Ed1YkRuafWFS/JFOYtf5K+a94S7yPdWQ7xx7ggjtGS3qz9gQoqAErbnuLeoKxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qG8OtYN/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27617C4CEC3;
	Fri, 25 Oct 2024 21:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729890723;
	bh=ITkCa2nLRnfgf4FH1RrHbtuIRQzsTB17WU75UTJB76w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qG8OtYN/hx4NQbfUREySngSguCLpSkahFS3OjYg7gUzm0THdpLc3mRjcKQBci/tuT
	 oOYJoHbatthr4EON4eOLKY3ocRLWkx0FId0rAjirsDfIl7BqMf77COxgQm97nqo+v7
	 1hFHD0Q5WA1iULZ5rFi9cVehmk/E+qbOGeHfqBsEVDrsjx28BHwvOiRNDXJaB0RWlx
	 4FVctYmAD97zXdIgRectQqljoibsoOL5dhqWLEJm6LjhsNvFc5Np2iLDJx3e+vy50Q
	 +JDT2zQsW1ODu6tI/xV1SmKSEpTq4cAs2r6zTK5qLGTKmlVIY5GfprBGSIM2BdpfCt
	 YGENzkYq7PnBQ==
Date: Fri, 25 Oct 2024 11:12:02 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: sched-ext@meta.com, kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] scx: Fix raciness in scx_ops_bypass()
Message-ID: <ZxwJovsaUSv8b_Zg@slm.duckdns.org>
References: <ZxwDCUcyTABN8Exj@slm.duckdns.org>
 <20241025205408.25166-1-void@manifault.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025205408.25166-1-void@manifault.com>

On Fri, Oct 25, 2024 at 03:54:08PM -0500, David Vernet wrote:
> scx_ops_bypass() can currently race on the ops enable / disable path as
> follows:
> 
> 1. scx_ops_bypass(true) called on enable path, bypass depth is set to 1
> 2. An op on the init path exits, which schedules scx_ops_disable_workfn()
> 3. scx_ops_bypass(false) is called on the disable path, and bypass depth
>    is decremented to 0
> 4. kthread is scheduled to execute scx_ops_disable_workfn()
> 5. scx_ops_bypass(true) called, bypass depth set to 1
> 6. scx_ops_bypass() races when iterating over CPUs
> 
> While it's not safe to take any blocking locks on the bypass path, it is
> safe to take a raw spinlock which cannot be preempted. This patch therefore
> updates scx_ops_bypass() to use a raw spinlock to synchronize, and changes
> scx_ops_bypass_depth to be a regular int.
> 
> Without this change, we observe the following warnings when running the
> 'exit' sched_ext selftest (sometimes requires a couple of runs):
...
> Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
> Signed-off-by: David Vernet <void@manifault.com>

Applied to sched_ext/for-6.12-fixes. Thanks!

-- 
tejun

