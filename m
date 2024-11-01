Return-Path: <linux-kernel+bounces-391490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E156B9B87CB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 01:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9669F28428A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 00:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502BA17C77;
	Fri,  1 Nov 2024 00:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="2BQupkX/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3BB8825
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 00:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730421959; cv=none; b=ZgJroHu9xbVIx2SNt+6ASY3o91iaCi+Af1IkzDQz1OvSJYfDz/rA04SoJbvLlEbzR/pKBkS/qd0i6gIAkMMAs+oRjgZ/qhNdbAuUxq3Hbs5mZjpOVkPfzRh2UpBfktE5hht48JDL1kqYqLLleNzVbyqwHD/lxpwZz9W1z0wD3kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730421959; c=relaxed/simple;
	bh=Yl0Nq/X2C+orEWo5hcJOW21CSwUj1o3v/S2ZVXjvMew=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Gcwgpa6e7s1aRD0u9btODR06FZ/Uc2093BMxMNYWtbFQx9ZXV0pZVlH1QfVmVEbNxaX82Z+8UzCXbnLGlJiYNjAvf1lqjqNvKSzeb+QpFHhq97GQBw+N8WqEzSSd6N3SDIfZV5yeh57GPQVbj+2RkvdTYDyXRXSFHRV7tFQKX/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=2BQupkX/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95EA3C4CEC3;
	Fri,  1 Nov 2024 00:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730421959;
	bh=Yl0Nq/X2C+orEWo5hcJOW21CSwUj1o3v/S2ZVXjvMew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=2BQupkX/pYNAp73p4KB9XxE/1ZiGGuZx5jx5Lgftm78Y1wsf8m6JRUOI7aG+xK0JY
	 Q+sBukFekSbNwi1kId03qRE94o97FmiuXkFMczMVJluENlvu0vznILaI+ofEdu1s7f
	 NOps3W1+og/Wn7nD8aH2rgVx7GMUAuiAkt9kx2NQ=
Date: Thu, 31 Oct 2024 17:45:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: kent.overstreet@linux.dev, dan.carpenter@linaro.org, rppt@kernel.org,
 mcgrof@kernel.org, petr.pavlu@suse.com, samitolvanen@google.com,
 da.gomez@samsung.com, yuzhao@google.com, souravpanda@google.com,
 pasha.tatashin@soleen.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] alloc_tag: fix empty codetag module section
 handling
Message-Id: <20241031174557.18b8f408a6b810b3fe7468c6@linux-foundation.org>
In-Reply-To: <CAJuCfpGiFDPArB-3_oTvuMSy3=MVQWFW2K8f-k+M9G2EA0L+Mw@mail.gmail.com>
References: <20241101000017.3856204-1-surenb@google.com>
	<CAJuCfpGiFDPArB-3_oTvuMSy3=MVQWFW2K8f-k+M9G2EA0L+Mw@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 31 Oct 2024 17:13:58 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> On Thu, Oct 31, 2024 at 5:00 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > When a module does not have any allocations, it's allocation tag section
> > is empty and codetag_alloc_module_section() returns NULL. However this
> > condition should never happen because codetag_needs_module_section() will
> > detect an empty section and avoid calling codetag_alloc_module_section().
> > Change codetag_alloc_module_section() to never return NULL, which should
> > prevent static checker warnings. Add a WARN_ON() and a proper error
> > reporting in case codetag_alloc_module_section() returns NULL, to prevent
> > future codetag type implementations from returning NULL from their
> > cttype->desc.alloc_section_mem() operation.
> >
> > Fixes: 61c9e58f3a10 ("alloc_tag: load module tags into separate contiguous memory")
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/all/50f12fa1-17c1-4940-a6bf-beaf61f6b17a@stanley.mountain/
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> 
> Andrew, I was going to respin v5 of my patchset and include all these
> small fixes in it but it's a bit tricky because I would have to revert
> another unrelated patch [1] from mm-unstable which refactors relevant
> code. So far the fixes are rather small, so I think you should not
> have much trouble folding them into the original patchset when the
> time comes, but if that becomes a problem I can prepare a new version.
> 

No probs, thanks, I figured it out.  The descriptions of
where-it-fits-and-why are helpful.

Of course we could just pile everything onto mm-unstable HEAD and live
with a messier commit history, but I think things are manageable at
present.

