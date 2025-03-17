Return-Path: <linux-kernel+bounces-565133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D8FA66187
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3E5917513D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CA8204597;
	Mon, 17 Mar 2025 22:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Glubxaow"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527F71FFC55
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742250354; cv=none; b=q+xRnNmfx7DBfRbt+IMGZ3sq0VDg7mjV0GbRNzEqiGYsIyTi/6EA6MtVS3ORjatGNuIrscELwvobYe/tNM25kT/osjOj30OmFYkcNR9lQcFDSxTUCrjGRpfCWYpgLuRLiv7+rSSoO8ENPMIvAS/OlwAkkfhEnFIDY1TGfuY/b64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742250354; c=relaxed/simple;
	bh=YXhqoFceAYxum5yQk11C06WJaX6rsjvA+greKgjyzeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkrPEJyZ1vZ2NVyz+qLnWVfH5m+vSZvfUXKzaQ11yA0CMr4ewvMa96DrjwzIQc5fpI/QNPzBxKtgcixUAJy8LCqQmmphCbM8tebhS0Ay0Zij+ZnrvY8M9r2oR/3lvlfnHtUyP7MIRj/P+Sask8fVNsR7rToEN3NUg+/xgt77sgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Glubxaow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C67C4CEE3;
	Mon, 17 Mar 2025 22:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742250352;
	bh=YXhqoFceAYxum5yQk11C06WJaX6rsjvA+greKgjyzeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GlubxaowKYL7naaoDrfXDA1Z6tgWrFFzyP84pDDyTxVGXuhNbYcM26nViEooAQhQ5
	 RWzWpCPt6ANnp7+BhUS2pZb2PhewE7zXSeNivONAS11KWCC7mtLQsBzjSoQJSlM9o5
	 emod+iiF3soWsAQOi5R6nVmRz+3wvBf90JmUGuMoPnLBCbLpLbmkfmtzqpoFtDeMHF
	 X0xMdYBjCt8JF5ak/rAA8WUwBB4iiafMYxveJWCROJWpvXFOx0KZ0mnoCBwcBSFQCi
	 GT9BIJF1EVae6s7/Jbq8UyrtkS0BBeE05iO0OdlbQ0cY3DIv0SPuijuK3qRIoExeD9
	 MAESUyjMTKGag==
Date: Mon, 17 Mar 2025 12:25:50 -1000
From: Tejun Heo <tj@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH RFC] sched_ext: Choose prev_cpu if idle and cache affine
 without WF_SYNC
Message-ID: <Z9ihbiUV7dohm7FT@slm.duckdns.org>
References: <20250317082803.3071809-1-joelagnelf@nvidia.com>
 <Z9hW_3cPN8u7VURV@slm.duckdns.org>
 <b0dea973-bf41-4f44-850c-7bc860d5bf8a@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0dea973-bf41-4f44-850c-7bc860d5bf8a@nvidia.com>

Hello,

On Mon, Mar 17, 2025 at 11:07:36PM +0100, Joel Fernandes wrote:
...
> > I think it's preferring idle core a
> > bit too much - it probably doesn't make sense to cross the NUMA boundary if
> > there is an idle CPU in this node, at least.
> 
> Yes, that is a bit extreme. I believe that is what my patch is fixing.  If
> previous CPU and current CPU share cache, we prefer busy cores with free
> previous idle SMT, otherwise go looking for fully idle cores. But it sounds like
> from Peter's reply that is not necessarily a good thing to do in case 'fast
> numa'. So I guess there is no good answer (?) or way of doing it.

Yeah, recent AMD CPUs can be configured into NUMA mode where each chiplet is
reported as a node and they do behave like one as each has its own memory
connection but the distances among them are significantly closer than
traditional multi-socket. That said, I think the implementation is still a
bit too happy to jump the boundary. What Andrea is suggesting seems
reasonable?

Thanks.

-- 
tejun

