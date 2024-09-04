Return-Path: <linux-kernel+bounces-315301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C37C996C0AC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02E721C2195E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDE61DC07E;
	Wed,  4 Sep 2024 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXHs3hkH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8351DC758
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 14:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460345; cv=none; b=lcgB7tes0AE4L3pkeGxRoNSuhONFLdIARQT7ENprP7xZ2t9lYBim0sm5hdk7foym/cp7spytrnNF7yZBtrotSE4uwII581s7z4BdEsfn5nEqhoMiTSt7NmMwtEU+jk+02bT1Xtj1gxaNwJNuJE12eT4vmm9n85Fq6TFpYIMxfV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460345; c=relaxed/simple;
	bh=ng+e6Hp2igkpglFQmoOkK2z+OPcTq8ojmWWL20fwpCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsszWjtP47b9s8j1cy95N96T6m5N1s14BXzpboz7PVY8c7e7ZmeJvOALEi1DYZeI73OGbyXyocj3wBnjTyTL2yKvfdQjKvs/rIvHq0JRaBf3luxXaKmavDuKvnPA0dL2/sdj23l14n1xZLYMqsIL5xTc40WJoafiIY75UL0cH+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KXHs3hkH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725460342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IrAclQ5t/FQ//5pJEryFEgtiOd8QFT6os7SDI+A77qU=;
	b=KXHs3hkH5lQXxLu+aYl6A4gOpJ+psRQnVkCIueH6XGMLnY2J6KVjQ0h7mlAVlf5vvPbDOl
	lvunErGWmjqfsXa6PHeMNNQbjIk5HQPKIZ8pcH2tIGgF1Og233A9FYIelVN9J+XQ/gU+VJ
	vGCiyBcL1jLIVvg1lteXCxaEcWNZFFU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-_EIpnjPFMVKJe0mua-s76g-1; Wed,
 04 Sep 2024 10:32:19 -0400
X-MC-Unique: _EIpnjPFMVKJe0mua-s76g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B1F0193F07E;
	Wed,  4 Sep 2024 14:32:17 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.39.194.241])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D8B651955F44;
	Wed,  4 Sep 2024 14:32:11 +0000 (UTC)
Date: Wed, 4 Sep 2024 10:32:07 -0400
From: Phil Auld <pauld@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] sched/isolation: Add HK_FLAG_SCHED to nohz_full
Message-ID: <20240904143207.GB136544@pauld.westford.csb>
References: <20240818234520.90186-1-longman@redhat.com>
 <20240818234520.90186-2-longman@redhat.com>
 <ZtcK3aF_d3BUhiVz@localhost.localdomain>
 <7fa3dbd5-7c2e-4614-a5f4-258546cb090b@redhat.com>
 <ZteAfUXZd1TgIwiL@pavilion.home>
 <4822d111-b02d-469a-a457-46392c35021f@redhat.com>
 <ZthWKgK9B_AUqSs1@localhost.localdomain>
 <20240904130445.GI4723@noisy.programming.kicks-ass.net>
 <20240904134427.GA136544@pauld.westford.csb>
 <20240904140210.GK4723@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904140210.GK4723@noisy.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Wed, Sep 04, 2024 at 04:02:10PM +0200 Peter Zijlstra wrote:
> On Wed, Sep 04, 2024 at 09:44:27AM -0400, Phil Auld wrote:
> 
> > > You can create single CPU partitions using cpusets dynamically.
> > >
> > 
> > This is somewhat new though...   Although you could turn off load balancing with
> > groups v1, in v2 you could not. 
> 
> I can't remember, but I think I stalled cpuset-v2 until this was
> adressed -- that is, AFAIR any v2 can actually do this too. You create
> many 1 cpu partitions. It is more cumbersome that v1, but it is very
> much doable.
> 
> 

v2 can do this _now_. It couldn't before. Or at least not in a way that was
usable until Waiman's partitioning patches I believe.

I did say that in the past tense :)



Cheers,
Phil

-- 


