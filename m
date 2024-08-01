Return-Path: <linux-kernel+bounces-271357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0D2944D2E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EA4A1C2262D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56ABA189B98;
	Thu,  1 Aug 2024 13:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPnisI6b"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDAA61FF2
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 13:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722519036; cv=none; b=udfUbeWepUyx2hV85vW+XnKNd0A/a4HnGD76gELAwii5rYSR0PXEElRZet8xvl+eUnsOTr/MGXFWlumGxkgWtIMajVeWQac0WQZnfThAGW0HNHPnKqozzUqAwjzqasIRUUbALdQOw6ziOyasHhooToPgdXmvMWdsz2Zv5aLfK7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722519036; c=relaxed/simple;
	bh=+p/9q2S3jDJrrMqPlyzPhzttP9ieHJalkZErx9J/Bi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4jpwkj2mghZllJXSIuq2itt5zK5c151FacqDUGFHMO/wbU7xMBgyejxO4FCbODnDNIs1dJ++pVKMWSPRU95F3JIty5BAfeEOl+XNuZF++bXRstmhnYOLqqI7TdCy6GK4wAv9nSiBBykbGzbm8STAP+d3BdXq9rECmrx0+5DCWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GPnisI6b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722519034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7S+VuZpDhoSrdItmQyG2cBKjlF+TyM//bwuTj5nERxg=;
	b=GPnisI6b5419mJ9gpLAeOPOt3/GVz94wYoOGV+MJOXryFFS8sZBbe+1q8kHuIi7cFv/pCK
	Hn/S+ioBlpBm4HhASPTfIL5HGgl7sf/5LI4pLtcS8iGifZILOuZp6wtx3mbG8+U7VYif2G
	ueHnNxtVPTjxfMOXZMccq4ak2SKgKf8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-dRlYe4tRPCudiY9yKRQ2xQ-1; Thu,
 01 Aug 2024 09:30:31 -0400
X-MC-Unique: dRlYe4tRPCudiY9yKRQ2xQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 765281955D57;
	Thu,  1 Aug 2024 13:30:27 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.16.46])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3863219560B2;
	Thu,  1 Aug 2024 13:30:20 +0000 (UTC)
Date: Thu, 1 Aug 2024 09:30:18 -0400
From: Phil Auld <pauld@redhat.com>
To: John Stultz <jstultz@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Joel Fernandes <joelaf@google.com>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>,
	Youssef Esmat <youssefesmat@google.com>,
	Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com,
	Connor O'Brien <connoro@google.com>
Subject: Re: [PATCH v11 7/7] sched: Split scheduler and execution contexts
Message-ID: <20240801133018.GA47256@pauld.westford.csb>
References: <20240709203213.799070-1-jstultz@google.com>
 <20240709203213.799070-8-jstultz@google.com>
 <20240712150158.GM27299@noisy.programming.kicks-ass.net>
 <CANDhNCrkf1Uz42V3vMFChp1nKnkeHH7ZPxd_gC4KOMmWPcRVgQ@mail.gmail.com>
 <Zqn_0XIcxTpHxswZ@jlelli-thinkpadt14gen4.remote.csb>
 <20240731113720.GB33588@noisy.programming.kicks-ass.net>
 <CANDhNCoy+eYJwBcCq+YGaO2OqGav_KyLEEbQ-tMkrQY6UDGSDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCoy+eYJwBcCq+YGaO2OqGav_KyLEEbQ-tMkrQY6UDGSDg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Jul 31, 2024 at 04:32:33PM -0700 John Stultz wrote:
> On Wed, Jul 31, 2024 at 4:37 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Sorry for the delay, I need the earth to stop spinning so goddamn fast
> > :-) 36 hours days ftw or so... Oh wait, that'd mean other people also
> > increase the amount of crap they send my way, don't it?
> >
> > Damn..
> 
> Yeah. My sympathies! I do really appreciate your taking time to
> provide feedback here (amongst all the other eevdf patches and
> sched_ext stuff you're reviewing).
>

Not to mention way too many rust patches...


> > Would 'donor' work in this case?
> >
> > Then the donor gets all the accounting done on it, while we execute
> > curr.
> 
> 'Donor' is great, I'll switch to that.
> 
> Thanks again for getting back to me here!
> -john
> 

-- 


