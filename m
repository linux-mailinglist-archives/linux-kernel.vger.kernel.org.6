Return-Path: <linux-kernel+bounces-336005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB9697EDF2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDDB91C2144A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D913719DF4D;
	Mon, 23 Sep 2024 15:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="USzLv43l"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5B2823C8
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727104492; cv=none; b=hOWQAWIROdCUzCw4X20FF3JXjkk8BOXY3mTEpSOwxEJQYdlWT6711xuIaKB9ZVzpmHQ1TgX2080FAOPjrOgK3CZIwqfRf7a4x4hnNfl9GxvWpxvVgFxnpPXdRRIg570XRFmS0gJ3swinMyblqEuncjcRAq9TEpSwJHwwsgjXKgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727104492; c=relaxed/simple;
	bh=CzkcMC32TIAvO9Vn/pHff4Hhmd+47xHH0y9v1U78BMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPYyqUhS2lNbzZi1max6L9oToIfWy0O+qHrD2I8+UiKwzg/WcugKELF4G+oPp4Olrq+gmIbrkzYbyyFRvKmOXXIpysgjN8D267eH3K0fVRzxi3pu7fKYSPlTKtLcGjshm9Uk/jUyFFj9Bq3WFs07VdXIU4YfVsorTgC8GS003wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=USzLv43l; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 23 Sep 2024 17:14:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727104484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ygpJS1EPM5qqd+bkX9hCqkd6t4u54UpiDy2CYzSWpsc=;
	b=USzLv43lc9NBmMqMgIZtZnxRdv1sDjA1yBUeejteyf5+QyC21UwozCQFd0e9NqehbmAm4N
	+1sxfZsSFVlA13+hIHtxOraZ8Vj/6oLVGnSM6nr1BZl/fZp91gFoVGvlhwjOzMXA1R3cJ3
	hEMOZjC9k2L+nPyHhGO34oY4lGcb3/k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrea Righi <andrea.righi@linux.dev>
To: Phil Auld <pauld@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Giovanni Gherdovich <giovanni.gherdovich@suse.com>,
	Kleber Sacilotto de Souza <kleber.souza@canonical.com>,
	Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Provide a sysfs enable_seq counter
Message-ID: <ZvGF5N6oUtmfmq3f@gpd3>
References: <20240921193921.75594-1-andrea.righi@linux.dev>
 <ZvCKPkwwC9-o2dsQ@mtj.duckdns.org>
 <20240923104548.GA308802@pauld.westford.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923104548.GA308802@pauld.westford.csb>
X-Migadu-Flow: FLOW_OUT

On Mon, Sep 23, 2024 at 12:45:48PM +0200, Phil Auld wrote:
> 
> Hi Tejun,
> 
> On Sun, Sep 22, 2024 at 11:21:02AM -1000 Tejun Heo wrote:
> > Hello, Andrea.
> > 
> > On Sat, Sep 21, 2024 at 09:39:21PM +0200, andrea.righi@linux.dev wrote:
> > >  static struct attribute *scx_global_attrs[] = {
> > >  	&scx_attr_state.attr,
> > >  	&scx_attr_switch_all.attr,
> > >  	&scx_attr_nr_rejected.attr,
> > >  	&scx_attr_hotplug_seq.attr,
> > > +	&scx_attr_enable_seq.attr,
> > >  	NULL,
> > >  };
> > 
> > Can you put this in scx_sched_attrs instead as it probably would make sense
> > to track this per-scheduler in the future when we support stacked
> > schedulers.
> 
> It's not a per scheduler counter, though. It's global. We want to know
> that a (any) scx scheduler has been loaded at some time in the past. It's
> really only interesting when 0 or > 0. The actual non-zero number and which
> scheduler(s) don't matter that much.
> 
> And it needs to persist when the scheduler is unloaded (I didn't look but
> I uspect the per scheduler attrs come and go?).

Correct, if we make the counter per-scheduler we would lose this
information once the running scheduler is unloaded.

Instead we want to maintain this information persistent, so that user
support can clearly see if any of the BPF scheduler has ever been used
since boot.

Thanks,
-Andrea

