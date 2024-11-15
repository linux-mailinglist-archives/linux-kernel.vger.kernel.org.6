Return-Path: <linux-kernel+bounces-411096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5AD9CF2E8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773341F2373C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB15166307;
	Fri, 15 Nov 2024 17:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EMIDNySW"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DCB1D63DD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 17:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731691718; cv=none; b=VY4SMNRES16iVT/yAJS4OKPJfPJUPqdPokEbB4nyueyx0WqPSGQS7wgx9XVAwbXsO+Grn+q4GN3FP/tkW6fsHhDv7F1dWUJuICsBuBM3DzhWgipCUgAqc0A+tQqC3Aq6bp2l+/CZG/pfc2MITtrp6SxmX+XkV8dKwwkIWRFHSpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731691718; c=relaxed/simple;
	bh=dk4zVXehQZIeGZtXh04YOc7zAiRI2LkDHFMjWUc8g1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQwh/U7jm28GlRsA31OYxvoR3YZOkFbIkWKdrDmFmaX2qRqAeq+EOry2A0yMkHWg03AiM7/B3whRW4DcuDDAOvGkSPF+NO0m3BIOwvzacEhuxlnPeJudWQpywC4oMpsqFF48AHos/Jhqez/o2FPsFao6p6N5jqYQn5TEGrrUQUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EMIDNySW; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cB5Ad0jk0l+riRhNH0YflsTWDYx1clQbELFT52Tp8TM=; b=EMIDNySW4lX3bbLpJUM7wB2WT6
	ZxZvS/wWCT0HCKbZny6sNNAKOYpcEst9gbyajmts2tGu3kKiKjtJjngjMZx8IwqzHErqzy2wZuyw0
	81b0wvbk1ec7v1gfM3WQiQgeCSYyNynp0syC3m2qE5xK4/+ZXVbRBDFkTWyypMNYT89Y1CaWz8Xr7
	qDFjSPvuXH7vHlncmaipkVY+i/mPylbP2itO2FwfDfm3FvezECNH5aXb+/JgMgKf5Ngm7ISALkwTe
	EqzfbV1FmVsjdjNJ9FPJfAEc+yFWt7xLhPtRQMxddHuI/iG8F2/HgVDIm1RoRahPjNdgc7Pat+pcz
	5TDNuLAQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tC07T-00000000J0e-1AdB;
	Fri, 15 Nov 2024 17:28:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 825F830066A; Fri, 15 Nov 2024 18:28:30 +0100 (CET)
Date: Fri, 15 Nov 2024 18:28:30 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Phil Auld <pauld@redhat.com>
Cc: Jon Kohler <jon@nutanix.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: hoist ASSERT_EXCLUSIVE_WRITER(p->on_rq) above
 WRITE_ONCE
Message-ID: <20241115172830.GE22801@noisy.programming.kicks-ass.net>
References: <20241114165352.1824956-1-jon@nutanix.com>
 <20241114185755.GG471026@pauld.westford.csb>
 <0C4B7BAD-04EA-4F60-B6D2-A7B2C14E52B7@nutanix.com>
 <20241114192056.GI471026@pauld.westford.csb>
 <20241115095847.GV22801@noisy.programming.kicks-ass.net>
 <20241115142658.GA837020@pauld.westford.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115142658.GA837020@pauld.westford.csb>

On Fri, Nov 15, 2024 at 09:26:58AM -0500, Phil Auld wrote:
> On Fri, Nov 15, 2024 at 10:58:47AM +0100 Peter Zijlstra wrote:
> > On Thu, Nov 14, 2024 at 02:20:56PM -0500, Phil Auld wrote:
> > 
> > > I don't know. I don't think it matters much since the assert is really
> > > independent of the actual write. Like I said it makes sense to have it
> > > first to me but others may see it as just moving code around for no strong
> > > reason.  Peter may or may not decide to pick this one up. Other "mis-ordered"
> > > uses are in code maintained by different folks.
> > > 
> > > You can see if anyone else weighs in...
> > 
> > So I'm not entirely about this patch... :-)
> >
> 
> I'm not entirely either :)

Hehe, typing is forever hard :-)

