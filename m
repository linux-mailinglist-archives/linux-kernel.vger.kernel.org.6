Return-Path: <linux-kernel+bounces-437650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 458089E9673
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB97B283390
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B9135966;
	Mon,  9 Dec 2024 13:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MFIiQwxb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5C4233147
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 13:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749887; cv=none; b=Z+8BkqPgQMw7zE8SWplWCjYNTTuQtWevWnE4PkU7VBRzMD8Yo/LqIPO/ajmqrz3FW98RmbD2zxcyOOwsXoD2FYKehKH69gz+rxJT77AdnO+WwWRzGMjPBEAbI/Wc6onKrJdc5NoMTVQeSuVKMheHnIzuHUNXkH6VrpsrIpKa9DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749887; c=relaxed/simple;
	bh=zjBwD0aLX7o7j1/0ZqI6eThNSoLM2hlnGvxP8Y+aeQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qb2v7F1fhfA+1VrT5Pc07JX31KiKZf9SzCcCeBdc4LBnhvtCfEI17+rXLf4r8oxllgQukWkj3460ScMuQYjb6h68OvupHq1j/UzIAsPTCb1K5VksfUxGTMj0WYtuUUL5Zht6v+CpfN7l9pMkoLH10j5AHLgvDDLMNwFtZvLjjoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MFIiQwxb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733749884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BWQY6IfLo/S/CDRVbklgCeHn2aHAFhi5zAR23hUPFQw=;
	b=MFIiQwxbjJsBTWVCv0jHCNuPGSzZmbgFazT7T+k1CbFkMhNR8cfH9rIu2ZwouQ5AypvUfg
	1FfdKKYMXKbdG4BN3MtNNn6WTxnlI0eozVJbRclTPG9zoMNZ6SCNwGBdt85wLyvT/QQ5s/
	u+hok6W3kCLtD3e5za+CTatqEE1Vugg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-XGwXXF_sMmOO5I1OiVC7hA-1; Mon,
 09 Dec 2024 08:11:19 -0500
X-MC-Unique: XGwXXF_sMmOO5I1OiVC7hA-1
X-Mimecast-MFC-AGG-ID: XGwXXF_sMmOO5I1OiVC7hA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 362FB1956060;
	Mon,  9 Dec 2024 13:11:17 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.88.126])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00C783000198;
	Mon,  9 Dec 2024 13:11:12 +0000 (UTC)
Date: Mon, 9 Dec 2024 08:11:10 -0500
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
Message-ID: <20241209131110.GC117639@pauld.westford.csb>
References: <95ff75cacab4720bbbecd54e881bb94d97087b45.camel@gmx.de>
 <20241114112854.GA471026@pauld.westford.csb>
 <20241119113016.GB66918@pauld.westford.csb>
 <bede25619ef6767bcd38546e236d35b7dadd8bd4.camel@gmx.de>
 <915eab00325f2bf608bcb2bd43665ccf663d4084.camel@gmx.de>
 <20241121115628.GB394828@pauld.westford.csb>
 <bf4f50886c462ee1f33cc404843944fea4817616.camel@gmx.de>
 <20241202162427.GB1226982@pauld.westford.csb>
 <9c78aebb3fdb8af68937a0301fabc3acb3e20c2d.camel@gmx.de>
 <20241202191252.GA1233297@pauld.westford.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202191252.GA1233297@pauld.westford.csb>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


Hi Mike et al.,

On Mon, Dec 02, 2024 at 02:12:52PM -0500 Phil Auld wrote:
> On Mon, Dec 02, 2024 at 05:55:28PM +0100 Mike Galbraith wrote:
> > On Mon, 2024-12-02 at 11:24 -0500, Phil Auld wrote:
> > > On Sat, Nov 23, 2024 at 09:44:40AM +0100 Mike Galbraith wrote:
> > >
> > >
> > > > Question: did wiping off the evil leave any meaningful goodness behind?
> > >
> > > Is that for this patch?
> > 
> > Yeah.  Trying it on my box with your write command line didn't improve
> > the confidence level either.  My box has one CPU handling IRQs and
> > waking pinned workers to service 8 fio instances.  Patch was useless
> > for that.
> >
> 
> I'll give it a try. Our "box" is multiple different boxes but the results
> vary somewhat.  The one I sent info about earlier in this thread is just
> one of the more egregious and is the one the perf team lent me for a while.
>

In our testing this has the same effect as the original dequeue-when-delayed
fix.  It solves the randwrite issue and introduces the ~10-15% randread
regression. 

Seems to be a real trade-off here. The same guys who benefit from spreading
in one case benefit from staying put in the other... 


Cheers,
Phil

-- 


