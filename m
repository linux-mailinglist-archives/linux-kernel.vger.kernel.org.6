Return-Path: <linux-kernel+bounces-398985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC11C9BF8EA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 23:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81136284534
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 22:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6DA20C31C;
	Wed,  6 Nov 2024 22:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2tYCDvL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5870E1DFE13
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 22:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730930928; cv=none; b=KL1OiAaFoyew9ZbO5KsXpL7CiopydhRlZ5a9SMN4GInVZDBBehtM0OvoPJS2pozTRYD9KtCJjfRE56TrZG3+0j34OBSlzMZ6RShkkl1EgIQ0XnS5dYppBC9v/b13Z78gQZCRKn3gv3+rf2N0r/dsSE2P/39AJFvehqiOszdebJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730930928; c=relaxed/simple;
	bh=hhWAmwBQhVE8xzrGQ0BSu4tVcF62l6hQtHry/TighJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UlupKI47wYuo+sCcHrpG4idKd3f4JWoJbLNcZWICPWaEs4vSoY5ws59oCCXxx6d7DkQ4TB8T3c1mRE56a3lMJn0CTss+GfKHOYnHlKxMsqYWWrs8ilRbXSJ+PB49NrViSH/BRF3Fi4p85oAMUTnsy6xrCBSgTmWYLzUhsGtF83I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2tYCDvL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D65C4CEC6;
	Wed,  6 Nov 2024 22:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730930928;
	bh=hhWAmwBQhVE8xzrGQ0BSu4tVcF62l6hQtHry/TighJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V2tYCDvLe6v2bgFbEHHXFkXpmGe1Ip1r4x7oh8S6xTZGlavcJZB8ITEBRo2BLAdoD
	 rtEmSxzPp0AtkRGYfdnmKNWs+XKlEFsRYTayFuNSTFvpRq9KNoozMSvDSsb0QULF++
	 AKOMBJ0JgoIvKbOxe8aFmT1x6TFacIXWdWLvPmP5OJQlwxCJKeY4tFqpeuAp4j3Boa
	 8lGNoDmwuAF8rps5KBuXNKxQw+mRry4yXPfNdaG1s8YA9/6uRmWpxbDw1zNWDbT3qh
	 KjFqpyIgDWAd/ACXnchSFONXR+inmCMJNzcWTtWTNyWzfnc6PDxCNMdKZA/Xv+nyxY
	 w4DgPiC/jFmSA==
Date: Wed, 6 Nov 2024 12:08:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, sched-ext@meta.com,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <multics69@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH sched_ext/for-6.13 2/2] sched_ext: Enable the ops
 breather and eject BPF scheduler on softlockup
Message-ID: <Zyvo7lFcnAddB9RT@slm.duckdns.org>
References: <ZyqSm4B4NuzuHEbp@slm.duckdns.org>
 <ZyqS0GP9h2hG2lvC@slm.duckdns.org>
 <CAD=FV=U7z-Lf_1T2cYyae3b6W5Joyp+oiRSp-iXe_3jz9Aqoaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=U7z-Lf_1T2cYyae3b6W5Joyp+oiRSp-iXe_3jz9Aqoaw@mail.gmail.com>

Hello, Doug.

On Wed, Nov 06, 2024 at 01:32:40PM -0800, Doug Anderson wrote:
...
> 1. It doesn't feel right to add knowledge of "sched-ext" to the
> softlockup detector. You're calling from a generic part of the kernel
> to a specific part and it just feels unexpected, like there should be
> some better boundaries between the two.

I suppose we can create a notifier like infrastructure if directly calling
is what's bothersome but it's likely an overkill at this point. The second
point probably is more important to discuss.

> 2. You're relying on a debug feature to enforce correctness. The
> softlockup detector isn't designed to _fix_ softlockups. It's designed
> to detect and report softlockups and then possibly reboot the machine.
> Someone would not expect that turning on this debug feature would
> cause the system to take the action of kicking out a BPF scheduler.

Softlockups can trigger panic and thus system reset, which is arguably also
a remediative action.

> It feels like sched-ext should fix its own watchdog so it detects and
> fixes the problem before the softlockup detector does.

sched_ext has its own watchdog with configurable timeout and softlockups
would eventually trigger that too. However, that's looking at the time
between tasks waking up and running to detect stalls and the (configurable)
time duration is usually longer than softlockup detection threshold, which
makes sense given what the different failure modes they're looking at.

If sched_ext is to expand its watchdog to monitor softlockup like
conditions, it would essentially look just like softirq watchdog and we
would still have the same problem of coordinating detection thresholds.

Having a notification mechanism which triggers when watchdog is about to
trigger which can take a drastic action doesn't sound too odd to me. If I
make it use a notification chain so that the mechanism is more generic,
would that make it more acceptable to you?

Thanks.

-- 
tejun

