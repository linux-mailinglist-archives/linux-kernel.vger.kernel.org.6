Return-Path: <linux-kernel+bounces-428244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC359E0BC7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9A0916049E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C281DE3BC;
	Mon,  2 Dec 2024 19:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gT6oyDYV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6F71B6D0A
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 19:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733166787; cv=none; b=XMvOpoV0PJ8knsQYDllAfiY40e/wSF7VVNPJkTwp7nO4oRhLJcCS8HM684uaOXXOzTtTGZqYY+5EqApObjxsaBL1/i1usLuZyG15GwqvDW6zKkeJOfTQyCEuXS5dpufFzZd8lXE7+o7KEgt7CCkWSEJsuWkDNUt7YZktWLuGf5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733166787; c=relaxed/simple;
	bh=CkZjJuypgXkCqCn32aMNAlcTxOjYDVbpVfxCPiQWavs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLEWAIOmNS6Avd7aY2PcM0UysQfbQxt8vjQ36sbIGAfzM+6p7sxHuBkZ8LyouDwnURr5DCH+yiRoH+KNu1rxZ5VoFYhiiJwQy0JmuZeVT9yV9IwIGWma6OeR6p3nOIsknHKUVGt7KpJyahDtgb083YHNYNYGqquiELyK93SXz8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gT6oyDYV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733166784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xfpQf6E0B44V3ZVeT2OJJ5r7ypMoBxbf5rfe84AuQIk=;
	b=gT6oyDYV2GsSfWryYZXCSQUi6EXnRPz+S1G4HdUilFQJa5J3QPce2HrFkbPhffeYSjrLCG
	EACLrpexwNOdKs8CurRZmncq6L44DghRnphOt54fpjQFJ05lt+Dz1NiPUmGldmHJ+nKyin
	CdsGNPeDXCU1dG8FbVm5ZxHLK+rtkig=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-yzeA75WLNQWxxc79GedT2A-1; Mon,
 02 Dec 2024 14:13:00 -0500
X-MC-Unique: yzeA75WLNQWxxc79GedT2A-1
X-Mimecast-MFC-AGG-ID: yzeA75WLNQWxxc79GedT2A
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D98C1955DA3;
	Mon,  2 Dec 2024 19:12:58 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.65.61])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC59330000DF;
	Mon,  2 Dec 2024 19:12:54 +0000 (UTC)
Date: Mon, 2 Dec 2024 14:12:52 -0500
From: Phil Auld <pauld@redhat.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de
Subject: Re: [PATCH V2] sched/fair: Dequeue sched_delayed tasks when waking
 to a busy CPU
Message-ID: <20241202191252.GA1233297@pauld.westford.csb>
References: <81de2f710d8922a47364632335ff5ba1a45625b3.camel@gmx.de>
 <95ff75cacab4720bbbecd54e881bb94d97087b45.camel@gmx.de>
 <20241114112854.GA471026@pauld.westford.csb>
 <20241119113016.GB66918@pauld.westford.csb>
 <bede25619ef6767bcd38546e236d35b7dadd8bd4.camel@gmx.de>
 <915eab00325f2bf608bcb2bd43665ccf663d4084.camel@gmx.de>
 <20241121115628.GB394828@pauld.westford.csb>
 <bf4f50886c462ee1f33cc404843944fea4817616.camel@gmx.de>
 <20241202162427.GB1226982@pauld.westford.csb>
 <9c78aebb3fdb8af68937a0301fabc3acb3e20c2d.camel@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c78aebb3fdb8af68937a0301fabc3acb3e20c2d.camel@gmx.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Dec 02, 2024 at 05:55:28PM +0100 Mike Galbraith wrote:
> On Mon, 2024-12-02 at 11:24 -0500, Phil Auld wrote:
> > On Sat, Nov 23, 2024 at 09:44:40AM +0100 Mike Galbraith wrote:
> >
> >
> > > Question: did wiping off the evil leave any meaningful goodness behind?
> >
> > Is that for this patch?
> 
> Yeah.  Trying it on my box with your write command line didn't improve
> the confidence level either.  My box has one CPU handling IRQs and
> waking pinned workers to service 8 fio instances.  Patch was useless
> for that.
>

I'll give it a try. Our "box" is multiple different boxes but the results
vary somewhat.  The one I sent info about earlier in this thread is just
one of the more egregious and is the one the perf team lent me for a while.


Cheers,
Phil


> 	-Mike
> 
> 

-- 


