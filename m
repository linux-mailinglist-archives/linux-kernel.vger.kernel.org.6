Return-Path: <linux-kernel+bounces-353851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6CE9933A9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FA99B22D35
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0741D1DB958;
	Mon,  7 Oct 2024 16:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmMsQPQX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6633C1D968B
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319501; cv=none; b=q/TDAtdqd6YZwblt5/BSjYdY2cAxj3SycKfVzoiFyI3UnWg25eknXVxgq7PR7+x3P4OYhjTJnvIpU2GFu7nCaPTEpa95h5Sh3RNjtVuYXpe8/umWJSSXbEewI7dPR5URW1gilXWedYzIBf2OoyGs/Io2IuU6ukvk1XfuVNsNqFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319501; c=relaxed/simple;
	bh=GFSWp8GSXkoOdRQNQtstCUiiiNO7CblRMiReWg6M3JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y97h8t5J5ngrWfP3fOvmYrXd9Irf3GqXz/TA6+eZG1L9QkUYWrOB1D2j8/PBwLkX0KIaCMH13m+mxkfQxBA8ztUSnkYNPeGO1n2yLqj7aAsFBNIEL9IrGfGifuU5+xuK3vOIgHXbS8eGrmE4zmpMZ/wY0qATti8jpkRInwmPH7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmMsQPQX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE094C4CEC6;
	Mon,  7 Oct 2024 16:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728319500;
	bh=GFSWp8GSXkoOdRQNQtstCUiiiNO7CblRMiReWg6M3JU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UmMsQPQXeF/PjV/N1TE9BBOvjD1FGw6MMX100WWlQ1Pwk4v56V0OKdiMMOyPBY0av
	 7UL9FGzkQ41kxlIK/FREnFxHGKzEPElQOshzrSmf7H1ldksCyRn2QGmZjPdbBH6DUV
	 viJoemBVBSIB0EB/WV8RnRWyCBw6Qn0GQNAS5tVg9v5SWyuymHUiIEr78i676Mvg/Q
	 DhH1DATLmxc40DhJwuMpaOfHPAfUF3gGc1ypLzAiPSjI2imDthjYSWr+x+hf1GPiHx
	 Dv8vjH1L8xfFH0sXdRLauEjl4UkvFuSO/q40VgMFE5mfehBTZMvHISZalETyzFMAWH
	 JETX/JKCRg+Mg==
Date: Mon, 7 Oct 2024 06:44:59 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: void@manifault.com, mingo@redhat.com, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, sched-ext@meta.com
Subject: Re: [PATCH 2/3] sched/core: Add ENQUEUE_RQ_SELECTED to indicate
 whether ->select_task_rq() was called
Message-ID: <ZwQQC7fF7NdWRSdt@slm.duckdns.org>
References: <20240927234838.152112-1-tj@kernel.org>
 <20240927234838.152112-3-tj@kernel.org>
 <ZvxXxT8Lc0u9dTLo@slm.duckdns.org>
 <ZwBMnL55W1qfcjwc@slm.duckdns.org>
 <20241005093804.GY18071@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241005093804.GY18071@noisy.programming.kicks-ass.net>

On Sat, Oct 05, 2024 at 11:38:04AM +0200, Peter Zijlstra wrote:
> Right, I've been busy chasing merge window fallout, and this didn't seem
> that urgent. I'm not exactly liking it, but it isn't too horrible. So
> yeah, you can take it I suppose.

Thanks for taking a look. Will route them through sched_ext/for-6.12-fixes.

-- 
tejun

