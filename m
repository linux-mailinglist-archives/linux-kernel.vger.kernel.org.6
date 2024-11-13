Return-Path: <linux-kernel+bounces-408005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 840F79C78BD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C2231F22B9B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569A21632C9;
	Wed, 13 Nov 2024 16:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EKNoqpld"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F851632CC
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 16:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731514997; cv=none; b=Q3MOghxW4F1sKZFxBcBezU9t6cOBWQweWA9X7Pu5UNOXY9Yb2BrUidwZXPkJFHlIHNEGy3KE8uFVjr/xcENcBdJ+mhI18Gc/r7JFpTQsiwfx2zGpAWuEqPcZCU/h1TDM73WMRXxxN9cUikMnCt/LIBYFWqcFPBHfC6E3RIHFiFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731514997; c=relaxed/simple;
	bh=ILvq6iNvezbN5hyeS4cFP9EsIKXnczJpSfJnBlbgllw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfHlAwU1xLnB8ImrRRlnzBqst5yOHKcoV36C882crq8tuT6RCmFJAF3gvIW4W2j1/yUmRBm6yGhsEaHHxKjZmsvYXW/sLIFbT6ZZPCTaB4DMqEyaZjR/t13rUU7wwd3UsD+bSApIZOtsfB0v7xtVfCNpM/Jb3x47bOme4RPkoYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EKNoqpld; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731514995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0i5JZQNBT2nQgVVIZnUtd5qJVO8cAjUL1gi6Yy6QyBs=;
	b=EKNoqpldSUsL0QnJFrJMZwXYf9vyXQdRX8kHDR9ozVClkyUnczBak+VmrKwbp7f/ORy61+
	6hevmRQ5rBB7/mpChMivg7MgLOrU1KAzgX9KaRpkWG/H4xQKE3ePkT46BMv5gXMP2LS6bK
	k3pP9wjpxBthEgFv6hxVDqtbicS1Ljg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-KTtZl-DqPlyTr_Md41KiCg-1; Wed,
 13 Nov 2024 11:23:09 -0500
X-MC-Unique: KTtZl-DqPlyTr_Md41KiCg-1
X-Mimecast-MFC-AGG-ID: KTtZl-DqPlyTr_Md41KiCg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56E431953948;
	Wed, 13 Nov 2024 16:23:04 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.80.158])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B176230001A2;
	Wed, 13 Nov 2024 16:22:58 +0000 (UTC)
Date: Wed, 13 Nov 2024 11:22:44 -0500
From: Phil Auld <pauld@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Aashish Sharma <shraash@google.com>,
	Shin Kawamura <kawasin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/deadline: Correctly account for allocated
 bandwidth during hotplug
Message-ID: <20241113162244.GC402105@pauld.westford.csb>
References: <20241113125724.450249-1-juri.lelli@redhat.com>
 <20241113125724.450249-3-juri.lelli@redhat.com>
 <20241113134908.GB402105@pauld.westford.csb>
 <ZzS-ncIOnEgrOlte@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzS-ncIOnEgrOlte@jlelli-thinkpadt14gen4.remote.csb>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Nov 13, 2024 at 02:58:37PM +0000 Juri Lelli wrote:
> Hi Phil,
> 
> On 13/11/24 08:49, Phil Auld wrote:
> > 
> > Hi Juri,
> > 
> > On Wed, Nov 13, 2024 at 12:57:23PM +0000 Juri Lelli wrote:
> > > For hotplug operations, DEADLINE needs to check that there is still enough
> > > bandwidth left after removing the CPU that is going offline. We however
> > > fail to do so currently.
> > > 
> > > Restore the correct behavior by restructuring dl_bw_manage() a bit, so
> > > that overflow conditions (not enough bandwidth left) are properly
> > > checked. Also account for dl_server bandwidth, i.e. discount such
> > > bandwidht in the calculation since NORMAL tasks will be anyway moved
> > 
> > "bandwidth"  :)
> 
> Grrrr. :)
>

Yeah, those are just minor nits.   Maybe Peter can fix them on the
way by...


Cheers,
Phil

> > 
> > 
> > > away from the CPU as a result of the hotplug operation.
> > >
> > 
> > LGTM.
> > 
> > Reviewed-by: Phil Auld <pauld@redhat.com>
> 
> Thanks!
> Juri
> 

-- 


