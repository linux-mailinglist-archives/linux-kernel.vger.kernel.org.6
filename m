Return-Path: <linux-kernel+bounces-386091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 033859B3F0A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 01:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEADF1F234C4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 00:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7BEEACE;
	Tue, 29 Oct 2024 00:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oYuCQ8ah"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37034A2D;
	Tue, 29 Oct 2024 00:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730161309; cv=none; b=dvv/Rl/Xdrkin99crjIAVrwUKbcqSys9dyfI13YQN8JeIVZWMLJEh5w99EUDbSM5FJFQv4VxDHCwKH4ktC7KfFdbHF717EyEcWm0TB7cklXpswsn2CyxIlAIJ0IhZGaU/jBi2fyhsVrqtaT53On0OQ4uTTY+xbBBDL9sgDV9+Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730161309; c=relaxed/simple;
	bh=w4C9vOwVGFZiRT0Fz27ZKL0MWwvq5h9ls4orop1dnWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2AUgSZzBc/k1oAqV8i4npEiklPYbpOpiJs/LFfEOwVtH+SlukqwmqfFpTdkFFF0nphsK8vZw8eGSEngRON5UCNawJxAhRq0M1BJWroGAHrSndfHm2Lkj6oNlVeOm5ghvPPaPoDQzfzWImUCTH7ob28JmfAE1c6uozDMw6Fc6Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oYuCQ8ah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310FBC4CEE7;
	Tue, 29 Oct 2024 00:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730161308;
	bh=w4C9vOwVGFZiRT0Fz27ZKL0MWwvq5h9ls4orop1dnWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oYuCQ8ahiRHO/MMQjk6KI/A/arhBtKFk6AzEiHSfxPla6U8mp2MpbWovFMbXU7rVK
	 raC9tk1/HvewF1iPPIiTyckVLyFIrLkzU/hT6hPUnKyzIrFc5Q9bLVAX1SDc0JsPfe
	 mvYnIacnZa+f2DDvbVzYoIEgzsil8KV+O1apEq9E=
Date: Tue, 29 Oct 2024 01:21:35 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	rafael.j.wysocki@intel.com, tj@kernel.org,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [PATCH v2] driver core: Fix userspace expectations of
 uevent_show() as a probe barrier
Message-ID: <2024102915-swiftly-almanac-9534@gregkh>
References: <172790598832.1168608.4519484276671503678.stgit@dwillia2-xfh.jf.intel.com>
 <67047c516045d_964fe294b1@dwillia2-xfh.jf.intel.com.notmuch>
 <42dfef93-eb8a-458b-b76b-b7de9077d0af@leemhuis.info>
 <672016f35ed5d_bc69d2946a@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <672016f35ed5d_bc69d2946a@dwillia2-xfh.jf.intel.com.notmuch>

On Mon, Oct 28, 2024 at 03:57:55PM -0700, Dan Williams wrote:
> Thorsten Leemhuis wrote:
> > On 08.10.24 02:26, Dan Williams wrote:
> > > Dan Williams wrote:
> > >> Changes since v1 [1]:
> > >> - Move the new "locked" infrastructure to private header files to make
> > >>   it clear it is not approved for general usage (Greg)
> > > 
> > > Greg, per the 0day report and further testing I am missing something
> > > subtle in using kernfs open files to pin device objects. So hold off on
> > > this for now until I can get that root caused. If someone else can spot
> > > what I missed feel free to chime in, but otherwise I will circle back.
> > > 
> > > If I don't get back to this before -rc6 I think the theoretical deadlock
> > > that would be re-introduced by a revert of 15fffc6a5624 would be
> > > preferable to this reported regression. I am not aware of any reports of
> > > that deadlock triggering in practice.
> > Was there any progress? If not: given that Linus prefers to have things
> > fixed by -rc6 I wonder if now would be a good time to get the revert on
> > track for a merge later this week.
> 
> Revert 15fffc6a5624 ("driver core: Fix uevent_show() vs driver detach
> race"), which reintroduces a theoretical lockdep splat, is my preference
> at this point.
> 
> Even if I had a new version of this replacement patch in hand today I
> would still want it to be v6.13 material, not v6.12-rc. It deserves a
> full kernel cycle soak time to shake out issues before release.

Ok, I'll do the revert in my tree and push it for the next -rc release
thanks.

greg k-h

