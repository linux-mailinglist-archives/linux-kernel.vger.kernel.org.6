Return-Path: <linux-kernel+bounces-272677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6631A945FC3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF086B21DD4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51922101B7;
	Fri,  2 Aug 2024 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NzUOK8JC"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A172101B3
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722610795; cv=none; b=qZa7eelu/ZycO7NSWNnPv9QTqHj+7kUA9eQtf84IF7TmYYKCZWIH9nX8VhsvI0hRRNbh2qKonXnxK/ehgixBsWx1wo59zsrAeZhk4OFyO12rIDOCN8jDwoZheN/ToQaqh1yyZF08w6Y0sTIK/oGfo5rk//7TTdidxylFl5hoDN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722610795; c=relaxed/simple;
	bh=k039uiTahnQ0jWvwcQEkSgfiA6bciCGAJkPFZ3tBuqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZaK2cKaNALTCUR7HLM3l1giOidrTrzDyGK4BoTtm1ZPZwlScC3hE4b+OcLS+NR2pnd1Y+SpllNlvQywZm4Em9l5yV6h/d72rn+b0z4HWjnP3sTkLSo2F0awR8fOFUH8UjVMEuYEii5rEpMSiTLrB9Gb5knFduJgELqCNgujvEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NzUOK8JC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=X/nXXraID9KEuaRYcSTt7yvEVngafypmZKpw3LbU9t8=; b=NzUOK8JC6ZA2MRDbUHZQcLfy3t
	Sc54OTGr6avDlX+Lr2He4E8ZweVy0/yERKpxyW3UvojQ2N4XElWkxXiEGMOvJJ+9dLEjJNb+lHVTj
	vPecDTb2W4ImC63FrYbnWRdzK7qdsQqbO6Ct765iTlkS7LhrGrKEnBoL1/ZyHQxdjzbS1hXM5+hgx
	TX6RrN0z/GAxuA+QEKAXJdMX5RuOKUDzwa8FB/14+Y/zzVGYXSowj4KHDABrHH81diq9+N09kuWEp
	koAkogu+stbCfmDYUAb0H50BWeQyoMw3Honvm1fz8nvjE7WB0KqqXRTt37rZobSSucEud5EcVdnIb
	TfRfypuQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZtkp-000000018EB-2JXH;
	Fri, 02 Aug 2024 14:59:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8BDD530049D; Fri,  2 Aug 2024 16:59:38 +0200 (CEST)
Date: Fri, 2 Aug 2024 16:59:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
Subject: Re: [PATCH 17/24] sched/fair: Implement delayed dequeue
Message-ID: <20240802145938.GK39708@noisy.programming.kicks-ass.net>
References: <20240727102732.960974693@infradead.org>
 <20240727105030.226163742@infradead.org>
 <xhsmhjzgzt2er.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhjzgzt2er.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

On Fri, Aug 02, 2024 at 04:39:08PM +0200, Valentin Schneider wrote:
> 
> On 27/07/24 12:27, Peter Zijlstra wrote:
> > Extend / fix 86bfbb7ce4f6 ("sched/fair: Add lag based placement") by
> > noting that lag is fundamentally a temporal measure. It should not be
> > carried around indefinitely.
> >
> > OTOH it should also not be instantly discarded, doing so will allow a
> > task to game the system by purposefully (micro) sleeping at the end of
> > its time quantum.
> >
> > Since lag is intimately tied to the virtual time base, a wall-time
> > based decay is also insufficient, notably competition is required for
> > any of this to make sense.
> >
> > Instead, delay the dequeue and keep the 'tasks' on the runqueue,
> > competing until they are eligible.
> >
> > Strictly speaking, we only care about keeping them until the 0-lag
> > point, but that is a difficult proposition, instead carry them around
> > until they get picked again, and dequeue them at that point.
> >
> 
> Question from a lazy student who just caught up to the current state of
> EEVDF...
> 
> IIUC this makes it so time spent sleeping increases an entity's lag, rather
> than it being frozen & restored via the place_entity() magic.
> 
> So entities with negative lag get closer to their 0-lag point, after which
> they can get picked & dequeued if still not runnable.

Right.

> However, don't entities with positive lag get *further* away from their
> 0-lag point?

Which is why we only delay de dequeue when !eligible, IOW when lag is
negative.

The next patch additionally truncates lag to 0 (for delayed entities),
so they can never earn extra time.

