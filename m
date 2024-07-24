Return-Path: <linux-kernel+bounces-261323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874F393B5C6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B88E41C23980
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F2B15F30D;
	Wed, 24 Jul 2024 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQjfP6mb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6496415B0FF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721841593; cv=none; b=FuNMMc2GqVsjQS+0zl2Agm/9FFplLNrDD/M3DywsoI3jgzN9I2HbZQanMMS+4tQxqiguZtlEqSM78uAGCR+RN2PuhoFbvmJCOP3qcg/BlR/SZROMRASU6SIdnsjJJc2kkSJyPI0Y8ol0ylPX5w1waSvmRcpsIz7UdGivUzcYN30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721841593; c=relaxed/simple;
	bh=WxLcduIdMRGzQvOx8dGdBDLVrYTYWtS+0hJqjc5gSUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZolym/mqf5iV0DAMo385jhChGZ7nOaGtRxTHVzteIVxuQagkzCBrPbRxpO2SkSiCENlWGnDw0UWHlfWVMuxmngKVmISSMqPuN1dUc/zNpIfDuyxxZ6NqkHZzR28qqjQx7SUVt6rszX9YhQhTRs3PQzfTz/R5KmF5Mc5+RBLoSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQjfP6mb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829F8C4AF09;
	Wed, 24 Jul 2024 17:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721841593;
	bh=WxLcduIdMRGzQvOx8dGdBDLVrYTYWtS+0hJqjc5gSUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BQjfP6mbBdS1UGDSl4G/fFhUlpn9j7SAPFHdmPZCQYljfBVy7jM1WzuDAHD0lmSla
	 Ezad5o9AkBanlddlYhQ/6x5dVIpck4WSxtp9Es0QNuk4It52ASO5Md5GUMQrVgAP8J
	 VE3wFJgd5m3xVtRj9d8E4YDbGy6DmGQGeguGJRTIENl9K0G0bP1ggGiXqS9358CNH5
	 oTr0CLaPWaAopOJP7a7lnokzLkb37igvHb+KF1kYwSrAqC267vlhTGkNQ+vNCtdUKK
	 6dzoZuqhJMNqjUlpQiJSaSFMHJMiJqFGvxyxxDRkP+UsA8HqOfWNjZ2HALhVz+FN4i
	 ZkCC14pa9FPRw==
Date: Wed, 24 Jul 2024 22:49:44 +0530
From: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
To: riel@surriel.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, neeraj.upadhyay@kernel.org, mingo@kernel.org,
	rostedt@goodmis.org, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH] smp: print only local CPU info when sched_clock goes
 backward
Message-ID: <20240724171944.GA811274@neeraj.linux>
References: <20240715134941.7ac59eb9@imladris.surriel.com>
 <88d281fe-d101-47d9-b70e-bb6a8959f5ff@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88d281fe-d101-47d9-b70e-bb6a8959f5ff@paulmck-laptop>

On Mon, Jul 15, 2024 at 11:07:30AM -0700, Paul E. McKenney wrote:
> On Mon, Jul 15, 2024 at 01:49:41PM -0400, Rik van Riel wrote:
> > About 40% of all csd_lock warnings observed in our fleet appear to
> > be due to sched_clock() going backward in time (usually only a little
> > bit), resulting in ts0 being larger than ts2.
> > 
> > When the local CPU is at fault, we should print out a message reflecting
> > that, rather than trying to get the remote CPU's stack trace.
> > 
> > Signed-off-by: Rik van Riel <riel@surriel.com>
> 
> Tested-by: Paul E. McKenney <paulmck@kernel.org>
> 

I have included this patch as part of the CSD-lock diagnostics series
which is submitted for review and planned for v6.12 [1]. I have also
included it in RCU tree [2] for more testing.


[1] https://lore.kernel.org/lkml/20240722133559.GA667117@neeraj.linux/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/neeraj.upadhyay/linux-rcu.git/log/?h=next


- Neeraj

> > ---
> >  kernel/smp.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/kernel/smp.c b/kernel/smp.c
> > index f085ebcdf9e7..5656ef63ea82 100644
> > --- a/kernel/smp.c
> > +++ b/kernel/smp.c
> > @@ -237,6 +237,14 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
> >  	if (likely(ts_delta <= csd_lock_timeout_ns || csd_lock_timeout_ns == 0))
> >  		return false;
> >  
> > +	if (ts0 > ts2) {
> > +		/* Our own sched_clock went backward; don't blame another CPU. */
> > +		ts_delta = ts0 - ts2;
> > +		pr_alert("sched_clock on CPU %d went backward by %llu ns\n", raw_smp_processor_id(), ts_delta);
> > +		*ts1 = ts2;
> > +		return false;
> > +	}
> > +
> >  	firsttime = !*bug_id;
> >  	if (firsttime)
> >  		*bug_id = atomic_inc_return(&csd_bug_count);
> > -- 
> > 2.45.2
> > 

