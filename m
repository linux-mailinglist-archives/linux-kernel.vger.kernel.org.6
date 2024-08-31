Return-Path: <linux-kernel+bounces-309699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AC4966F70
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 07:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15501C21A81
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 05:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8747314A0B8;
	Sat, 31 Aug 2024 05:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dyg+xEEB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98858468
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 05:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725082568; cv=none; b=LUGjvIBt7u6dkxx/CptjEvOwejot68UePbU64KjFShnoBHoTmAHQLjoiQ/sWLhuKxoH1Ha/j8QKpuSZ9vJzfu5cSDRdk52NWvJJ+ygksA+xYli/GPVynJ0zz7TFQpUcOTrIX+9bqg1ClHtpn03XMwEwrz3jXMW1bgw3u8QPg078=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725082568; c=relaxed/simple;
	bh=+BIG6+c1DoySxAL61na3Q1EGCrMqnIarblbfyjv8+wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sacVuVuXuPyx48i1ndjRQtXC8ppQnbqioTEKHKUxduemHa9r2i7f9w+9veQOE2iw6DIjxh0p9doUcywXzN0L0ATpiOoruPNR3zYKRn5Qb3TUncM/wqzU66FJWS6Nm7ZV/HUdcE2Ce5le0uGwwmlGTmX6+BWA6jbfEtmnmqryt40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dyg+xEEB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249F3C4CEC0;
	Sat, 31 Aug 2024 05:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725082568;
	bh=+BIG6+c1DoySxAL61na3Q1EGCrMqnIarblbfyjv8+wI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dyg+xEEBSs0vnHda375RB8ZpZTpHz4r3sK1OjZLJOz34AfawkX78rChPfSkdEo/PJ
	 69c/Fw7NSrEMJtbYnNkBbrnaL/nhqbBLKCHr6h/c3tmfohyaSKlAogiKcLl6t/x5GH
	 kfnDjnnf92huF0SbaiISPOrneU9EjEdCutrPGId9xavaHMxl1b4YlVBOEsPPrSfwB+
	 oBYGE1KUVvWzJtRoWmIIc5iwRLMs/Eh8gYmolFhiPwZjgVijudqq89mivpd+8mni5j
	 3ih4H+YOJO88Xqd6tvlYv3nA3JqQTuJ+wC0kLMayEITCsNvN5OUMyRHMSQ/RHv/OKG
	 Ei5b3/VMRzpXg==
Date: Fri, 30 Aug 2024 19:36:07 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	kernel-team@meta.com
Subject: Re: [PATCH v2 2/2 sched_ext/for-6.12] sched_ext: Use
 sched_clock_cpu() instead of rq_clock_task() in touch_core_sched()
Message-ID: <ZtKrx3qxaN6SrNfv@slm.duckdns.org>
References: <ZtGkPKgoE5BeI7fN@slm.duckdns.org>
 <ZtGkgCEkgNLzjxUC@slm.duckdns.org>
 <ZtIHYe4DgGlu8k1n@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtIHYe4DgGlu8k1n@slm.duckdns.org>

On Fri, Aug 30, 2024 at 07:54:41AM -1000, Tejun Heo wrote:
> Since 3cf78c5d01d6 ("sched_ext: Unpin and repin rq lock from
> balance_scx()"), sched_ext's balance path terminates rq_pin in the outermost
> function. This is simpler and in line with what other balance functions are
> doing but it loses control over rq->clock_update_flags which makes
> assert_clock_udpated() trigger if other CPUs pins the rq lock.
> 
> The only place this matters is touch_core_sched() which uses the timestamp
> to order tasks from sibling rq's. Switch to sched_clock_cpu(). Later, it may
> be better to use per-core dispatch sequence number.
> 
> v2: Use sched_clock_cpu() instead of ktime_get_ns() per David.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Fixes: 3cf78c5d01d6 ("sched_ext: Unpin and repin rq lock from balance_scx()")
> Cc: David Vernet <void@manifault.com>
> Cc: Peter Zijlstra <peterz@infradead.org>

Applied 1-2 to sched_ext/for-6.12.

Thanks.

-- 
tejun

