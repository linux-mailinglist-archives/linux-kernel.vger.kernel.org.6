Return-Path: <linux-kernel+bounces-529378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B42A42400
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0DB18992E3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E647719644B;
	Mon, 24 Feb 2025 14:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IH5p2viR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCFA198857
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408236; cv=none; b=guCoTafJO5v5bMbjv/pjiYukWd8k7J9he4bDms3faohZk65WyyVv80DDLCxC8E/GUzkT5oDQfSnXBsS1vpejCK9a58BTGhiE7dRoRdTnfHb1iFmDHsKBi+9sOEiVrMo1yPCV+c7qefkDJ0xqmGtMb9hZthwjPdHJZRcGRrdk/Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408236; c=relaxed/simple;
	bh=Vplb6sVTkE1F6QC8kAIX9Js8pg7WFYwGMj49qCAS0nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIx2eUyhC1m/2S2OyoFKunCsNt3iGBN3B3CzARV6T5QmZQ+lzPuC1PgugewjjctVgMEA/Ex/K74LsimzNNPPy54WVvmmiH+ikHompUFBijYYx1+xqk3QcCyMpsgJVRlzv2PmY/pBBdpWWi5j0ufj/4QjeO9Yub4to/Virb3eof4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IH5p2viR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913BDC4CED6;
	Mon, 24 Feb 2025 14:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740408235;
	bh=Vplb6sVTkE1F6QC8kAIX9Js8pg7WFYwGMj49qCAS0nU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IH5p2viR3R7F0TbMkt7TqkMFuqWPNnQtXsbbmzEk9ucOTW7sTsWL6a30Q8iV3/Wes
	 WssP67K/SiQRgcQ4lVC4ryYl3VH3ZdUjfzFXIQfbS0o6Likyjt6hXqoiOn+yJR2gnT
	 /8GPefiq62lVdbomDsRVmv9h6SJjm5TuVuRGSc1cd7ereItTtqMFN9JDV8WG9Qi+QI
	 14aFnlKVUR2TobOp4/WiM/CiJ3xU4J1NVDL749IRwNIa7c0p05jN+OQlNekLLKzZ5w
	 1KUZpKhMLmPgE9kjrl04cYs1m99DWBPW0kRSjaR9UZV2BUL9HWYaxgTKxSaW2M15MF
	 3Y0BM2U7uhMjA==
Date: Mon, 24 Feb 2025 15:43:49 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: phasta@kernel.org, Matthew Brost <matthew.brost@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] drm/sched: Adjust outdated docu for run_job()
Message-ID: <Z7yFpZMCFINhEht7@cassiopeiae>
References: <20250220112813.87992-2-phasta@kernel.org>
 <20250220112813.87992-4-phasta@kernel.org>
 <12c53d41-21c4-443d-a572-fd22c3cc56ad@igalia.com>
 <1457e985f88e02cd04b2152d2468a65b7a513e63.camel@mailbox.org>
 <cfef8bd7-f335-4796-9d4f-93197bb3fc2d@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cfef8bd7-f335-4796-9d4f-93197bb3fc2d@igalia.com>

On Mon, Feb 24, 2025 at 10:29:26AM -0300, Maíra Canal wrote:
> On 20/02/25 12:28, Philipp Stanner wrote:
> > On Thu, 2025-02-20 at 10:28 -0300, Maíra Canal wrote:
> > > Would it be possible to add a comment that `run_job()` must check if
> > > `s_fence->finished.error` is different than 0? If you increase the
> > > karma
> > > of a job and don't check for `s_fence->finished.error`, you might run
> > > a
> > > cancelled job.
> > 
> > s_fence->finished is only signaled and its error set once the hardware
> > fence got signaled; or when the entity is killed.
> 
> If you have a timeout, increase the karma of that job with
> `drm_sched_increase_karma()` and call `drm_sched_resubmit_jobs()`, the
> latter will flag an error in the dma fence. If you don't check for it in
> `run_job()`, you will run the guilty job again.

Considering that drm_sched_resubmit_jobs() is deprecated I don't think we need
to add this hint to the documentation; the drivers that are still using the API
hopefully got it right.

> I'm still talking about `drm_sched_resubmit_jobs()`, because I'm
> currently fixing an issue in V3D with the GPU reset and we still use
> `drm_sched_resubmit_jobs()`. I read the documentation of `run_job()` and
> `timeout_job()` and the information I commented here (which was crucial
> to fix the bug) wasn't available there.

Well, hopefully... :-)

> 
> `drm_sched_resubmit_jobs()` was deprecated in 2022, but Xe introduced a
> new use in 2023

Yeah, that's a bit odd, since Xe relies on a firmware scheduler and uses a 1:1
scheduler - entity setup. I'm a bit surprised Xe does use this function.

> for example. The commit that deprecated it just
> mentions AMD's case, but do we know if the function works as expected
> for the other users?

I read the comment [1] you're referring to differently. It says that
"Re-submitting jobs was a concept AMD came up as cheap way to implement recovery
after a job timeout".

It further explains that "there are many problem with the dma_fence
implementation and requirements. Either the implementation is risking deadlocks
with core memory management or violating documented implementation details of
the dma_fence object", which doesn't give any hint to me that the conceptual
issues are limited to amdgpu.

> For V3D, it does. Also, we need to make it clear which
> are the dma fence requirements that the functions violates.

This I fully agree with, unfortunately the comment does not explain what's the
issue at all.

While I do think I have a vague idea of what's the potential issue with this
approach, I think it would be way better to get Christian, as the expert for DMA
fence rules to comment on this.

@Christian: Can you please shed some light on this?

> 
> If we shouldn't use `drm_sched_resubmit_jobs()`, would it be possible to
> provide a common interface for job resubmission?

I wonder why this question did not come up when drm_sched_resubmit_jobs() was
deprecated two years ago, did it?

Anyway, let's shed some light on the difficulties with drm_sched_resubmit_jobs()
and then we can figure out how we can do better.

I think it would also be interesting to know how amdgpu handles job from
unrelated entities being discarded by not re-submitting them when a job from
another entitiy hangs the HW ring.

[1] https://patchwork.freedesktop.org/patch/msgid/20221109095010.141189-5-christian.koenig@amd.com

