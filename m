Return-Path: <linux-kernel+bounces-339620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 923839867ED
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 23:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC1131C214CC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 21:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A5114AD24;
	Wed, 25 Sep 2024 21:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLM5iGnF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C4C13E02E
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 21:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727298257; cv=none; b=j0Mb2tB+4Ep+N5akycqZpTR2op+UDAnuqdHlxPxT8uh5Z1Br9WIIFslGRESqeWYXPzfFROcOEUkBiLvrEBw3ax2kWsO5AMfmPatRakbwFPwE/+rFJ4xNisSIQEAKi24Zrz3MGg6HKXu8y7eQkJJipnXNo2y5PD89dA5qFwSEMjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727298257; c=relaxed/simple;
	bh=cyanZkb9d26TDKDlSfaHdhJwah9qTldIxfXFZtL2ffU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rn+vGEDBxljXfY7CYuz2zmk1P41JeKZHUWbBp67eBV7LjwU9htwEY2kG9aH5Fmz/Pjo/BzZWkUz1KHsSR/cqGZEsdN8jZCaUG2WktmIVZccbmGv3fTnJiwqCeXxKGYW+9JdVMyUihllHJAgQDMuUlOwdEmoDzj+jVSWWz0eLWAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLM5iGnF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97BFC4CEC3;
	Wed, 25 Sep 2024 21:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727298256;
	bh=cyanZkb9d26TDKDlSfaHdhJwah9qTldIxfXFZtL2ffU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hLM5iGnFGhHISqB6rmDrupKCW95tITt+gSshV99aIyTwyFBG6BjwNm01nvzJ7Jg8O
	 JlFlIgLi0uiJqvuyV41QHgOa4A9QAYNKoaopYBO26/aYb9+l/GfInILsLd04+l5lCF
	 Ru16VsDwZTgMJcpUP6m8G/ggj59M5MZidTVuJsdlVoaqpr9Hs0Xh7dEdDQjnrQXrid
	 vVdEaPNp1gLNvDFc6k57Pgiya68O8t495B0yAOdiNRwZjfcLh9a7sPdYiZ0vfPdHn8
	 WnY+xyRsm4V3z+VjcfDtdZPnatsX1LbLkLx8SF2pJ4fcvu9LTsGp23iQGt2/hzk6fj
	 aE3lFgT1Ir8RA==
Date: Wed, 25 Sep 2024 11:04:15 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org, sched-ext@meta.com
Subject: Re: [PATCH 2/5] sched_ext: Allow only user DSQs for
 scx_bpf_consume(), scx_bpf_dsq_nr_queued() and bpf_iter_scx_dsq_new()
Message-ID: <ZvR6z9WoThpP5pWo@slm.duckdns.org>
References: <20240925000622.1972325-1-tj@kernel.org>
 <20240925000622.1972325-3-tj@kernel.org>
 <20240925170956.GC26346@maniforge>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925170956.GC26346@maniforge>

Hello,

On Wed, Sep 25, 2024 at 12:09:56PM -0500, David Vernet wrote:
> On Tue, Sep 24, 2024 at 02:06:04PM -1000, Tejun Heo wrote:
...
> This API impedance where you can dispatch but not consume feels unnatural, and
> a bit leaky. I understand why we don't want to allow BPF to consume it -- we're
> already doing it for the user as part of (and before) the dispatch loop. That's
> also one-off logic that's separate from the normal interface for DSQs though,
> and because of that, SCX_DSQ_GLOBAL imposes a cognitive overhead that IMO
> arguably outweighs the convenience it provides.

I don't know. One can also argue that this makes all built-in DSQs behave
more consistently as the local DSQs can only be dispatched to too. Either
way, I don't think it makes meaningful differences.

> I'm still of the opinion that we should just hide SCX_DSQ_GLOBAL from the user
> altogether. It makes sense why we'd need it as a backup DSQ for when we're e.g.
> unloading the scheduler, but as a building block that's provided by the kernel
> to the user, I'm not sure. In a realistic production scenario where you're
> doing something like running a scheduler that's latency sensitive and cares
> about deadlines, I'm not sure it would be viable or ever the optimal decision
> to throw the task in a global DSQ and tolerate it being consumed before other
> higher-priority tasks that were enqueued in normal DSQs. Or at the very least,
> I could see users being surprised by the semantics, and having instead expected
> it to function as just a built-in / pre-created DSQ that functions normally
> otherwise.

Maybe we can further block it in the future but it doesn't seem material
either way and I tend to prefer not putting extra restrictions unless
necessary.

Thanks.

-- 
tejun

