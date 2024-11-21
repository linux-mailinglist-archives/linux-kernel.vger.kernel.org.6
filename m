Return-Path: <linux-kernel+bounces-417489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2ACA9D54A8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED502811EE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 21:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1EA1C9EBB;
	Thu, 21 Nov 2024 21:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QEe87WBV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EB51C2307
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 21:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732224120; cv=none; b=hlJq4E/D5dPttiwYyj4+xvMrf2oM5dqFHfZHPCNFLnPes8emy3HSpMQKnlTj+Jp3LHNTMI9m6wGlfJGIXIPJZJAmwEfpbULDq73uAOBn2DUiPxlwr9PKgae9sbTuGMe4/0g1p6/qVRYXPBDuN7HKF5vKzWRIgjWGaV6v/oZz4Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732224120; c=relaxed/simple;
	bh=wkSwR0azkL3Md0QdDN3Ua8FtgvqdJdV9ATN18OO1n+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZC/JSYc7kkdQO1YWQgyA8N3jn2kj4D+MvkBdTOX7UI5WiSidpgj42Av79C+Lah/DHEf0fWitPx2oTMxtpHH2ePa06bfKUqxpUp2Fvl2I1/2kjk9E+o0mp/bb6V64oqnl2OxfApwu0LURMrX7ODIunHW/wP4Vz4dumCZAAfMo3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QEe87WBV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732224117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t92srYTLUbUpyPkHghmLUL2yaj5b2j3zDv6b9Le7YIU=;
	b=QEe87WBVWNxLryi5JUFVJ+LdHmNIfIMF7eH1GQj8vAKWIP9CNQ76cuxaPgM9lWf2HKj/v9
	w8GKwkVe5UKcmiaiELXqLGu/e4Za0qKuFUu7OSYV9YjA35VYIA/+OyE0eK3kwGlx39IDJ2
	ZpTdzVXWapDNBlCCF5/H3RVxV4pbxro=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-WietTaCrNz6iMxytMUBaFg-1; Thu,
 21 Nov 2024 16:21:54 -0500
X-MC-Unique: WietTaCrNz6iMxytMUBaFg-1
X-Mimecast-MFC-AGG-ID: WietTaCrNz6iMxytMUBaFg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25E511955EEA;
	Thu, 21 Nov 2024 21:21:52 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.80.137])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4763F30000DF;
	Thu, 21 Nov 2024 21:21:48 +0000 (UTC)
Date: Thu, 21 Nov 2024 16:21:45 -0500
From: Phil Auld <pauld@redhat.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de
Subject: Re: [PATCH] sched/fair: Dequeue sched_delayed tasks when waking to a
 busy CPU
Message-ID: <20241121212145.GG394828@pauld.westford.csb>
References: <0befc9ed8979594d790a8d4fe7ff5c5534c61c3c.camel@gmx.de>
 <20241112154140.GC336451@pauld.westford.csb>
 <81de2f710d8922a47364632335ff5ba1a45625b3.camel@gmx.de>
 <95ff75cacab4720bbbecd54e881bb94d97087b45.camel@gmx.de>
 <20241114112854.GA471026@pauld.westford.csb>
 <20241119113016.GB66918@pauld.westford.csb>
 <bede25619ef6767bcd38546e236d35b7dadd8bd4.camel@gmx.de>
 <915eab00325f2bf608bcb2bd43665ccf663d4084.camel@gmx.de>
 <20241121115628.GB394828@pauld.westford.csb>
 <20241121120704.GC394828@pauld.westford.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241121120704.GC394828@pauld.westford.csb>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Nov 21, 2024 at 07:07:04AM -0500 Phil Auld wrote:
> On Thu, Nov 21, 2024 at 06:56:28AM -0500 Phil Auld wrote:
> > On Wed, Nov 20, 2024 at 07:37:39PM +0100 Mike Galbraith wrote:
> > > On Tue, 2024-11-19 at 12:51 +0100, Mike Galbraith wrote:
> > > > On Tue, 2024-11-19 at 06:30 -0500, Phil Auld wrote:
> > > > >
> > > > > This, below, by itself, did not do help and caused a small slowdown on some
> > > > > other tests.  Did this need to be on top of the wakeup change?
> > > >
> > > > No, that made a mess.
> > > 
> > > Rashly speculating that turning mobile kthread component loose is what
> > > helped your write regression...
> > > 
> > > You could try adding (p->flags & PF_KTHREAD) to the wakeup patch to
> > > only turn hard working kthreads loose to try to dodge service latency.
> > > Seems unlikely wakeup frequency * instances would combine to shred fio
> > > the way turning tbench loose did.
> > >
> > 
> > Thanks, I'll try that. 
> >
> 
> Also, fwiw, I think there is another report here
> 
> https://lore.kernel.org/lkml/392209D9-5AC6-4FDE-8D84-FB8A82AD9AEF@oracle.com/
> 
> which seems to be the same thing but mis-bisected. I've asked them to try
> with NO_DELAY_DEQUEUE just to be sure.  But it looks like a duck.
>

But it does not quack like one.  Their issue did not go away with
NO_DELAY_DEQUEUE so something different is causing that one.


> 
> Cheers,
> Phil
> 
> -- 
> 
> 

-- 


