Return-Path: <linux-kernel+bounces-399025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A41B99BF9B5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 00:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C075B22204
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 23:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B755320C493;
	Wed,  6 Nov 2024 23:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfR2+0/S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2205B1D47B3
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 23:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730934473; cv=none; b=l7TSz23swdgMw+BTIP1mXPmSLrnzN7GldVqWHRYsFAzaRWJYmOAXMdtqvUOR4rvnHYiUbqRsc+KdjeHe/W2kM+EjlvR7R2MHBweqIBmmJZREHnRwyeiAh2moqxmjQQY3VF0NLMH7w4DMF9rpVco47g8q2WR0Zl0LoJK9lulAHuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730934473; c=relaxed/simple;
	bh=48oxp9/72bf+BcjFqLwzcdyiw1zEqHVeKh0lAmRWCMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTofpy8MQFARQpd0zbQaDU8W/yReQQ+QFnPyjjmU60dpo9jRjeHFefrOZKLYYExcl0HEbU6QxzkiS0vvUNBxkMxYwdhAwfDIg0V8M9JVVgUH2KASwbj59/zZG4b7pmLfegUw6NpeviZuulxlh36k9Yb/gjHNlvAxvqCPGJ9HFVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfR2+0/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9179BC4CEC6;
	Wed,  6 Nov 2024 23:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730934472;
	bh=48oxp9/72bf+BcjFqLwzcdyiw1zEqHVeKh0lAmRWCMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TfR2+0/SAxm9g3HXgn3BPtW/HMtyQ8lwdNb0lJRF+k/kNKn0uODY/Qokee1nM6sWW
	 +YnFnVOPMXr9QXUOicrhdTDkqRE7uHBi4VWOj87tEXyJsXJPj+90OrewkcgKnCcR9C
	 kCvnaOFHZf6ULxUSqR+aLO2uU8yuwVIzyY7VDFf+kduGzTX3fEEGG4112V0LiXkWIe
	 iehjV2dysmstQTFHJnh38DH2qM2GEq6FKbf+9dTG+NTZf1dOMr5iyzvFXyohg+SU8j
	 Uu3t75AzI9HD9Oyz+AziLgp7IAMYtvEC8t4P519ThtssO6eztC/gA9XbQ/iH2X4l3A
	 sqM3Dyv+7yI2A==
Date: Wed, 6 Nov 2024 13:07:51 -1000
From: Tejun Heo <tj@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, sched-ext@meta.com,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <multics69@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH sched_ext/for-6.13 2/2] sched_ext: Enable the ops
 breather and eject BPF scheduler on softlockup
Message-ID: <Zyv2x6kb3gO8cTO7@slm.duckdns.org>
References: <ZyqSm4B4NuzuHEbp@slm.duckdns.org>
 <ZyqS0GP9h2hG2lvC@slm.duckdns.org>
 <CAD=FV=U7z-Lf_1T2cYyae3b6W5Joyp+oiRSp-iXe_3jz9Aqoaw@mail.gmail.com>
 <Zyvo7lFcnAddB9RT@slm.duckdns.org>
 <CAD=FV=UTh=JGUDZxO74+ZRQbF+yzcWnBo-f=oie0msmBn2_00g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=UTh=JGUDZxO74+ZRQbF+yzcWnBo-f=oie0msmBn2_00g@mail.gmail.com>

Hello,

On Wed, Nov 06, 2024 at 03:02:35PM -0800, Doug Anderson wrote:
...
> Honestly, it would feel better to me if the soft lockup timer didn't
> tell schedext to kill things but instead we just make some special
> exception for "schedext" tasks and exclude them from the softlockup
> detector because they're already being watched by their own watchdog.
> Would that be possible? Then tweaking the "softlockup" timeouts
> doesn't implicitly change how long schedext things can run.

Some systems can get into full blown live-lock condition where CPUs are
barely making forward progress through the scheduler and all normal (!RT &&
!DEADLINE) tasks are on sched_ext, so the only reasonable way to exclude
sched_ext would be disabling softlockup detection while sched_ext is
enabled which doesn't feel like a sound trade-off.

Thanks.

-- 
tejun

