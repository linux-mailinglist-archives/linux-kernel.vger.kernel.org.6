Return-Path: <linux-kernel+bounces-400534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 831A79C0EE5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3744C1F225B2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 19:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09511195F04;
	Thu,  7 Nov 2024 19:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4hj4D6N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C8B802
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 19:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731007863; cv=none; b=F9EYmAvnhmwed6irQg3XiCH/2/OJ2QztVtD3+6IPFujyc0UzcwbMwkVfc1rbHE75z2Gpwn+4/EBwKy59ap2rbseyATsHOhP3GqWclJ39teHO7BDFbHji4xdemwQMzYY9OFsE53Kf8/EhcyAW1toNJMnyjYD5XPv/o0/ETIrxV00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731007863; c=relaxed/simple;
	bh=dtiWMCvzYijElRPlAlS36wx3yEhVY7VT6BQSlIDqEDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbfpZZ8ycID7ic0RQ4jjjqTBGYgtABpBJytDYZDZTShnPJqO0e3nzMIWaTOZKfsTD3Npg1+0vYm1BB87RjupmM2BMdqQfuVOP0QHpjl2PXRmngR9ZNHq1geNi5SfFD+bq73VBHi6DVBD2wbwgUNGoKSagdMvXepDg3khZ8PjxSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4hj4D6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71CAC4CECC;
	Thu,  7 Nov 2024 19:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731007863;
	bh=dtiWMCvzYijElRPlAlS36wx3yEhVY7VT6BQSlIDqEDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r4hj4D6NimZrW/QqWZpaI1gwghnDFvvM0qG47kadPW2nR3HnTOoTbEF7Wt9fRS7MS
	 OD9ZokE25v2KTg3M3kImDBUgOiULdaeEp7u4d53p4Vb4j9BSrbWQ0viOgDqv5fjwXv
	 oWXJ59GjWzztc7LT1xOtE1OzqVLyE3KPpfJtqu6mijuRB034VOB2+35E7OTM9cWYPQ
	 wnEXiBIbiaEV1UBbbkioXzCJekBwlNXLBNG+5nP7/6khoW4m36SrAtkjLv3SSq5yOp
	 kK8H2EUbKJQuSMSiSgrYh/F+ifctRF/D4GE1OAL55fw9A1X88qkPr4Z5u5zN6+aJuH
	 ZJN7evsf6zZVw==
Date: Thu, 7 Nov 2024 09:31:01 -1000
From: Tejun Heo <tj@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, sched-ext@meta.com,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <multics69@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH sched_ext/for-6.13 2/2] sched_ext: Enable the ops
 breather and eject BPF scheduler on softlockup
Message-ID: <Zy0VdUvZinPUQeZN@slm.duckdns.org>
References: <ZyqSm4B4NuzuHEbp@slm.duckdns.org>
 <ZyqS0GP9h2hG2lvC@slm.duckdns.org>
 <CAD=FV=U7z-Lf_1T2cYyae3b6W5Joyp+oiRSp-iXe_3jz9Aqoaw@mail.gmail.com>
 <Zyvo7lFcnAddB9RT@slm.duckdns.org>
 <CAD=FV=UTh=JGUDZxO74+ZRQbF+yzcWnBo-f=oie0msmBn2_00g@mail.gmail.com>
 <Zyv2x6kb3gO8cTO7@slm.duckdns.org>
 <CAD=FV=XuvhaQPoLN7q5JnraBGggN90aXPoSEFG-H80i368u5Xg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=XuvhaQPoLN7q5JnraBGggN90aXPoSEFG-H80i368u5Xg@mail.gmail.com>

Hello, Doug.

On Wed, Nov 06, 2024 at 03:20:17PM -0800, Doug Anderson wrote:
> It still feels wrong to me that the softlockup detector duration is
> affecting how long schedext tasks are running. It feels like a
> fundamentally separate knob to be adjusting. You might want to stop
> misbehaving schedext tasks really quickly but otherwise leave the
> softlockup detector to be longer. Tying the two just seems weird.

The tying happens because softlockup can take a really drastic action of
resetting the whole machine.

> If we're trying to avoid duplicating code / avoid spinning up extra
> timers then it feels like separating out some common code makes sense
> and then that common code could be used by both the softlockup
> detector and the schedext watchdog. This would allow both to be
> configured separately. Yes, you could configure the schedext watchdog
> to be effectively "useless" by setting it to be too big, but that's
> true of lots of other watchdog-like things that are in the system. You
> have to set the timeouts sensibly. Certainly you could make the
> default something sensible, at least.

I don't really get the argument. It's just adding a simple notification to
tell another part of the kernel which can have effect on the condition being
detected that the threshold is imminent because it can resolve the situation
in an a lot more amicable way. I don't see what the big design problem is.
Sure, if we keep adding those notifications, we'd want to make the mechanism
more generic but that's not a difficult thing to do.

I don't see balance in your argument. Softlockup can already take a
remediative action, a pretty drastic one at that and that has practical
implications. In this case, it can be pretty easily dealt with. It solves a
practical problem. Even if we refactor everything and so that sched-ext can
do softlockup detection on its own (why? what's the benefit?), we still have
a coordination problem which is just brushed away. On the other side of the
scale is three lines of notification code. The trade off seems pretty clear.

> In any case, I'm not actually a maintainer here even if I've touched a
> lot of this code recently. As I said, if someone more senior wants to
> step in and say "Doug, you're wrong and everything looks great" then I
> won't be offended.

Andrew, if you don't object, I'll route the patches through the sched-ext
tree.

Thanks.

-- 
tejun

