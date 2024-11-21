Return-Path: <linux-kernel+bounces-416917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 300D19D4C62
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 12:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65511B220C9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 11:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0251D2F74;
	Thu, 21 Nov 2024 11:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hh2ynMM5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905691D27A0
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 11:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732190204; cv=none; b=dogWMicUuTN9jOsSHLVeWMuCKAygy24rh8FqnuUOCaHqfkjG3f4HIaSwVWkNhA1VkYVAy1BK7aWQOKRoeBkhT1WwkDwSsRDYAM2ku5elGnyfcLvEA9wVS+kQS8q8zD0QwkzC3lBDRdLMrnDDrMoDOP5rzXbLgf7UJrE6WJxEzF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732190204; c=relaxed/simple;
	bh=p/u4MFCjetG7YecklKYzh05VDlhESiTrCVy7KPXjBNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBc8mb3s/+Dvqlq1nGI+YDz1ZnJ+mhnngrj45Sw2H614E3BrX/h3UN8hJc9bvUsj0xQIoPf0ET0y0mUYnQMliuAF/srQHNxvbNT+YkxrjrLaXn31CZwSOdyCgf24RBldGTLYcDXWu84VU0kJHDb2/7OAKL8DBV4dJmoRKZmlQB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hh2ynMM5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732190200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YT1vTjmlkW658AsQD5WWZVQNoZbYtfe0XiDxPgbNrQQ=;
	b=hh2ynMM5ehq19q4wIPxA6bzI4XReB4xMccnZBBwVG6XED1ZWNr/zALUJ7ZbETkdgZ29pq0
	Errr9qWMg7Qm4QnCiYHls/9CYF/CCfgVDoxB3cnNZDRyEZSIno8olzM6gjW7GNuzR0krij
	4XN0oAI+7XX3rhMof3pjoB+vlXiq7lI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-445-0xRy0S-mMzGIn7uRA0Or5A-1; Thu,
 21 Nov 2024 06:56:37 -0500
X-MC-Unique: 0xRy0S-mMzGIn7uRA0Or5A-1
X-Mimecast-MFC-AGG-ID: 0xRy0S-mMzGIn7uRA0Or5A
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE24E1955EEA;
	Thu, 21 Nov 2024 11:56:34 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.80.137])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27EE01955F3D;
	Thu, 21 Nov 2024 11:56:31 +0000 (UTC)
Date: Thu, 21 Nov 2024 06:56:28 -0500
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
Message-ID: <20241121115628.GB394828@pauld.westford.csb>
References: <5a4cb3e4ab698fe2d8419e28d61e292dcd0c8fad.camel@gmx.de>
 <20241112124117.GA336451@pauld.westford.csb>
 <0befc9ed8979594d790a8d4fe7ff5c5534c61c3c.camel@gmx.de>
 <20241112154140.GC336451@pauld.westford.csb>
 <81de2f710d8922a47364632335ff5ba1a45625b3.camel@gmx.de>
 <95ff75cacab4720bbbecd54e881bb94d97087b45.camel@gmx.de>
 <20241114112854.GA471026@pauld.westford.csb>
 <20241119113016.GB66918@pauld.westford.csb>
 <bede25619ef6767bcd38546e236d35b7dadd8bd4.camel@gmx.de>
 <915eab00325f2bf608bcb2bd43665ccf663d4084.camel@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <915eab00325f2bf608bcb2bd43665ccf663d4084.camel@gmx.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Wed, Nov 20, 2024 at 07:37:39PM +0100 Mike Galbraith wrote:
> On Tue, 2024-11-19 at 12:51 +0100, Mike Galbraith wrote:
> > On Tue, 2024-11-19 at 06:30 -0500, Phil Auld wrote:
> > >
> > > This, below, by itself, did not do help and caused a small slowdown on some
> > > other tests.  Did this need to be on top of the wakeup change?
> >
> > No, that made a mess.
> 
> Rashly speculating that turning mobile kthread component loose is what
> helped your write regression...
> 
> You could try adding (p->flags & PF_KTHREAD) to the wakeup patch to
> only turn hard working kthreads loose to try to dodge service latency.
> Seems unlikely wakeup frequency * instances would combine to shred fio
> the way turning tbench loose did.
>

Thanks, I'll try that. 


Cheers,
Phil



> 	-Mike
> 

-- 


