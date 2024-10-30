Return-Path: <linux-kernel+bounces-389472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A0E9B6D79
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 774B91C23ACF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 20:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8CB1D0B8A;
	Wed, 30 Oct 2024 20:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cV6AklPL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7141BD9D4
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 20:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319579; cv=none; b=lAvEx8EKUo/Z9+awTBWp81BLIYglvMXkEBt+xr906SfgAXgiZr4VHkm1AkmXiagwpv4fQIRARKLRcov+ZfRXw1DcToFFutGQXdmcU2IyPyRnEtXccbmB+gLkRWf55Dju42ld7sDZXfJldTTktKA6XqpCOMny5DgpMxoJ2lypiZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319579; c=relaxed/simple;
	bh=fPvXnQUa24Nyn0vjJvWuMFEvX/dQczwmbIFcMv2BJIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRG0FfsEwz8/TlO4409tOmYEhoo9vOXTkcWROEdkKilQ5pptRMsxBY9RZF4DJPzqeJmGqKQ8RFlkHIWkFoDiv/C8SeSZfOFG2dxhCNK6MEoise0tA2XtBRhkMgC0h3/U5hEdvo+Z40g/k1dZCWK0to+VUejIyrzBQumbKroTyPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cV6AklPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D03DC4CECE;
	Wed, 30 Oct 2024 20:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730319578;
	bh=fPvXnQUa24Nyn0vjJvWuMFEvX/dQczwmbIFcMv2BJIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cV6AklPLPorzzJ3/SDfS+c0qxdmA795DijZC8KnIL2MW6tL+7jnrSwhZQ2jpnw+Id
	 2uiNNxAuNX+W90FiWmU71b4JTI42a9pR3U/iS2ryNPR/G7dTWpn/9hp/PihPQLJABL
	 328flgRRarYiRwRQ5lctemhtScQHfhm0sds2e0BUBZSUp+if8ViZoMKnnklmXtIcP6
	 MtpgyALTkZmPDPhsm72BYbCD0SV672WQlmVnLD33sqoCMm2FHVSJrfehDRni163O9H
	 sS0rolJivEOEeuOtzY8SbKZzDUdMxVUIdAWo+VCz9mINOffrtJTpZEVu8aWCTF1xT0
	 KrkgRjlLd9q3Q==
Date: Wed, 30 Oct 2024 10:19:37 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, void@manifault.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] sched/ext: Fix scx vs sched_delayed
Message-ID: <ZyKU2WrtZa_EggOZ@slm.duckdns.org>
References: <20241030151255.300069509@infradead.org>
 <20241030152142.372771313@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030152142.372771313@infradead.org>

On Wed, Oct 30, 2024 at 04:12:56PM +0100, Peter Zijlstra wrote:
> Commit 98442f0ccd82 ("sched: Fix delayed_dequeue vs
> switched_from_fair()") forgot about scx :/
> 
> Fixes: 98442f0ccd82 ("sched: Fix delayed_dequeue vs switched_from_fair()")
> Reported-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20241030104934.GK14555@noisy.programming.kicks-ass.net

Sans the compile issue:

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

