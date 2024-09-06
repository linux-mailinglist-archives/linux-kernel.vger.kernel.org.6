Return-Path: <linux-kernel+bounces-318043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F13E096E78C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 04:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 318071C2324A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 02:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942E72232A;
	Fri,  6 Sep 2024 02:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikT/YfIz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCEF208A0
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 02:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725588529; cv=none; b=IeP3dYCuh3fael1ePmug/Wm/KmVq2d9RkK2g/bXnwMOi/ptVLh9nPVE2ceDQZJIgszaiHTcqMFiAV3aoC+i53NB3nnjdJVa0elea6NwH6g9V04p4eQwW45t0N7daBkRv+3TIrytfI+Guzrr4crhJiKp28FH/KeWuD17DtM5pt6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725588529; c=relaxed/simple;
	bh=EeH5QISf1pRM7/m/hTAz7Vj/LLyRZRHdgdk6bbp1HcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnyGAqvqGF1YCKUfqQaa0NY5GfDkhNb4j+KZX5qgPvcCFI7y6M6cAPLGexyh4IsStgJewYnXPRzebJgjZHQsAp0arf226upTdcMJOSVH79eRBEnpZ04cEX9mSedGHhfNxUjNuyyxNw9xA/HOmVxXWFkca8EfPXlKbbyOdMc2K3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikT/YfIz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA1FC4CEC3;
	Fri,  6 Sep 2024 02:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725588528;
	bh=EeH5QISf1pRM7/m/hTAz7Vj/LLyRZRHdgdk6bbp1HcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ikT/YfIzlEsBclBfmIE/3RE/KqyPG5Zocmvjxy8Zgu7aFa0iMIkWw3JhJQm+6EWvC
	 Tcte6+9qdIHiPFVWWqvZtzm2NRRBnpioZrIo7XL/MRW+dhCFog3jMYfGPSOQflc+OP
	 SE0r2S/NVnIlezDpIsQChvABrU5qNXcWSbjPyvJhP0voLzgNAL7emZ6Ysli3j2UfzJ
	 IAsSGPvq3DkK0izeFyCzpJ/77/YVROpV/ojzBE6AsYGwlhmsA/1yI1GukqC1fuM1dl
	 nHlORG9/jcEoRHVpGezb0+N5i9yYKIdbHsl0tsUz4Qln/40CrtrwPixEyOC+wk2/9e
	 sCCnFTOxtM6hw==
Date: Thu, 5 Sep 2024 16:08:47 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH sched_ext/for-6.12] sched_ext: Handle cases where
 pick_task_scx() is called without preceding balance_scx()
Message-ID: <ZtpkL9qmRqF4u1wR@slm.duckdns.org>
References: <Ztj_h5c2LYsdXYbA@slm.duckdns.org>
 <20240905092858.GA15400@noisy.programming.kicks-ass.net>
 <20240905150012.GF4928@noisy.programming.kicks-ass.net>
 <ZtnfRnmo-EpWKcyC@slm.duckdns.org>
 <ZtpYGQ73WQcb95Fe@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtpYGQ73WQcb95Fe@slm.duckdns.org>

On Thu, Sep 05, 2024 at 03:17:13PM -1000, Tejun Heo wrote:
> Did a bit of testing and it seems like it's mostly coming from delayed
> dequeue handling. pick_next_entity() does this:
> 
> 	struct sched_entity *se = pick_eevdf(cfs_rq);
> 	if (se->sched_delayed) {
> 		dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
> 		SCHED_WARN_ON(se->sched_delayed);
> 		SCHED_WARN_ON(se->on_rq);
> 		return NULL;
> 	}
> 
> rq->cfs.nr_running includes the number of delay dequeued tasks which aren't
> really runnable, so it seems like balance_fair() saying yes and
> pick_next_entity() then hitting a delayed task. Maybe the solution is
> tracking the number of delayed ones and subtracting that from nr_running?
> I'm trying that but can't get the delayed count straight for some reason.

Backported http://lkml.kernel.org/r/Ztpjt5Pz9pJliblL@slm.duckdns.org to
v6.10 and it doesn't trigger (at least not easily) while the warning
triggers immediately on the current tip/sched/core. It does look like the
problem is delayed dequeue.

Thanks.

-- 
tejun

