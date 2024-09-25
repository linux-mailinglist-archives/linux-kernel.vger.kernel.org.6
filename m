Return-Path: <linux-kernel+bounces-339351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB5A9863A3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491401F270FF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3177680C04;
	Wed, 25 Sep 2024 15:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jIezXG1p"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08C14965C
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 15:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727278190; cv=none; b=n135olLX7boidX3Ed8tO1m5FJORF7kBxNQI1KVyH5wU1Y6Nhl2kfxJEuQPZeqQTQiGw75qu1/xVq22tIGnEJMwiVNdvaLQHUZMO7K0jQ/vVomAiN9LaQDjgKGlGEqbyUDSBKUT5gBEeG+n8Mu+ercc0zk+2ACudVrHi2F8nS4Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727278190; c=relaxed/simple;
	bh=m1RnTWL1JxFXTpZgCZFPMCjdk9aWhphg5RLo5+aBEk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FT9Qdd0uK8xlu6ahZVOLRF8f80TaE10tpfFuiqnbLmm2/B3jxTzVMYz8nIaeCN3XXJa1COQ33JJWu6S9rHVLAFKegl+xEk83tO1UruHybSqYkbR2PnF3s16/06YnvxC2IC2uRF6f+/l/BCtgkZFOOPxxDokKTHu4Cu73HS5+lQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jIezXG1p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727278187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6mlfhHjDi3T1OSBnYI9QlZrEPdXTG1xOSeZrY2Cl2Fs=;
	b=jIezXG1pbC3D1ABMPMRQqEKY0ilCfmr04zMi75XId/gwuapAPMHlU17lCIKEKfxREYx3d/
	cRBDKz2j4+soabOddFtD8BP6NaaNKEI7cQnSTPwUXI2mXvE4DhNXZujwg9EbyJW4X6bCgR
	eBBLwixb0wwukac5eldkpwSvcRkR790=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-L9rNrtbQMlm1aCY8Dd2-Pg-1; Wed,
 25 Sep 2024 11:29:44 -0400
X-MC-Unique: L9rNrtbQMlm1aCY8Dd2-Pg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE93818E6D9F;
	Wed, 25 Sep 2024 15:29:41 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.16.231])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D22C1977028;
	Wed, 25 Sep 2024 15:29:37 +0000 (UTC)
Date: Wed, 25 Sep 2024 11:29:34 -0400
From: Phil Auld <pauld@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] sched/deadline: fixes and improvements
Message-ID: <20240925152934.GC98338@pauld.westford.csb>
References: <20240724142253.27145-1-wander@redhat.com>
 <CAAq0SU=MufS+j+T_AN01Pvy4WctmB5wEG66F4VfN3_ZoqDYm9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAq0SU=MufS+j+T_AN01Pvy4WctmB5wEG66F4VfN3_ZoqDYm9Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Mon, Sep 23, 2024 at 01:45:13PM -0300 Wander Lairson Costa wrote:
> On Wed, Jul 24, 2024 at 11:23 AM Wander Lairson Costa <wander@redhat.com> wrote:
> >
> > Hello,
> >
> > This patch series addresses specific issues and improvements within
> > the scheduler's deadline (DL) class. The patches aim to fix warnings,
> > remove redundant checks, and consolidate timer cancellation logic for
> > better consistency and code quality.
> >
> > Patch 1: Fix warning in migrate_enable for boosted tasks
> >
> > Fix a warning caused by unnecessary calls to setup_new_dl_entity for
> > boosted tasks during CPU migate_enable calls.
> >
> > Patch 2: sched/deadline: Consolidate Timer Cancellation
> >
> > Consolidate timer cancellation logic into dedicated functions,
> > ensuring consistent behavior and reducing code duplication.
> >
> > Changelog
> > ---------
> >
> > v2:
> > * Drop patch to remove the redundant WARN_ON call.
> > * Change the "Fixes" tag in the patch 1.
> > * Change function names in the patch 2.
> >
> > Wander Lairson Costa (2):
> >   sched/deadline: Fix warning in migrate_enable for boosted tasks
> >   sched/deadline: Consolidate Timer Cancellation
> >
> >  kernel/sched/deadline.c | 45 ++++++++++++++++++++++++++---------------
> >  1 file changed, 29 insertions(+), 16 deletions(-)
> >
> > --
> > 2.45.2
> >
> 
> Notice there was a PR from sched a few days ago, but this patchset was
> not part of it. Do you know if this will be added later in this
> window?
>

Unless Peter takes this in sched/urgent then it will likely be in v6.13
assuming it gets picked up.  Ping Peter?


Cheers,
Phil



-- 


