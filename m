Return-Path: <linux-kernel+bounces-564728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C68A659EE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27DB91888E68
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33171A264A;
	Mon, 17 Mar 2025 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DbVpv00x"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9643E1A2630
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231175; cv=none; b=JbxXAH5PrFtSuSuTnfTWA0cwl+CAhasThDyic/svGsQoGtQRaxfuaEo9sQW+6m4X1/GAgfYW6vIWW4jnoFlxR5dbuV0zQigOo+UC5qNCtSq142VHRescKpZPhU6LsNmeO40cSXLBuyA3JZHSkEMV0dfHBriyCW9AeaoZ4bECyCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231175; c=relaxed/simple;
	bh=EKcGOxVMzjKzzpY2bAD/qKhkOsw3/ZS5jWoFiHGL9QY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqTvhJry/YSAGb0vtSfuhKPln8Ny/OKGntUSR+j5Yv97jmsG0tsKynF+8v1zPvU+Ypo+fJ/tv5QmFWcsJOLGgmRPoJL0YAN6XIWfQSop6WbrHcnjHxKXgMJer/mgz0QDqWHJKUJTvu2F0vMWSg1hOmSfjE0BgyTGCYod6Xc/jN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DbVpv00x; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dGzCutVqaGoQAQTN8SMp16X3bMGayRAE4xjT/iqKqv4=; b=DbVpv00x+lyC9GE1HhMwx82/pC
	vST0lop5ZdDtgbprWQDxdG3UJkVQ0FDsUayc6xmlw6peWOxTTJPkEXTeyVnjOcWdYdzUiVRTLh6qc
	95R8FpRI2h9eobEmTk0VvVIFVlQ7nuYJXmHUADS8KT20JsiCgIGmQOc/LgKp/LDQJYeeabEx2KBDn
	iksISKi5Dav5WoR8BwFG1E7VZrqThVzNCVOR0msWOMHzu8A2rjkOfq4nH/weONbOIpu6hjMJfO9iC
	VUYxRRoG0wIOCg+BsGyNTvpoFALPCAjP/VQruEDR5qFtIMLFv3dBJIwmD/U3p/LbL7l+BcbPeqviX
	uDxU772w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tuDud-00000003UtN-2WOY;
	Mon, 17 Mar 2025 17:06:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2F1A6300B40; Mon, 17 Mar 2025 18:06:03 +0100 (CET)
Date: Mon, 17 Mar 2025 18:06:02 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
	Andrea Righi <arighi@nvidia.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Luigi De Matteis <ldematteis123@gmail.com>, paulmck@kernel.org,
	boqun.feng@gmail.com
Subject: Re: [PATCH RFC 3/8] sched/ext: Add a DL server for sched_ext tasks
Message-ID: <20250317170602.GE6888@noisy.programming.kicks-ass.net>
References: <20250315022158.2354454-1-joelagnelf@nvidia.com>
 <20250315022158.2354454-4-joelagnelf@nvidia.com>
 <20250315072225.GG36322@noisy.programming.kicks-ass.net>
 <3b244939-6d55-4d86-8b77-a9a7629f8239@nvidia.com>
 <20250317103101.GC34541@noisy.programming.kicks-ass.net>
 <Z9hUby9e1JYaE6iC@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9hUby9e1JYaE6iC@slm.duckdns.org>

On Mon, Mar 17, 2025 at 06:57:19AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Mon, Mar 17, 2025 at 11:31:01AM +0100, Peter Zijlstra wrote:
> > On Sat, Mar 15, 2025 at 07:15:27PM -0400, Joel Fernandes wrote:
> > > If so, that will not handle the case where the system has both
> > > FAIR and EXT tasks in the mix (EXT has a partial mode where certain tasks can be
> > > made EXT with certain others left as FAIR) and FAIR runs 100% and starves EXT.
> > 
> > Well, you did not mention that issue, you only babbled about RT.
> > 
> > I did point out that issue with ext, and TJ said this mixed mode wasn't
> > really meant to be used or somesuch.
> 
> It's true that most of the current use cases don't use mixed mode. That
> said, some folks are interested in it and if we can prevent starvation from
> fair saturating CPUs in mixed mode with a DL server, that'd be really nice.
> Would it be possible to toggle the reservations depending on the ext's
> operation mode?

Yeah, that should be doable.

