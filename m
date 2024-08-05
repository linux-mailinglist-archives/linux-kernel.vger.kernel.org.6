Return-Path: <linux-kernel+bounces-274826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A03A947D4B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 542BC281973
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B204915AD95;
	Mon,  5 Aug 2024 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pTiPKTlO";
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="voJL2WTo"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97D013C827
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722869635; cv=none; b=oa/rd7sijkP/kABPZymt7Be5cUK3GiicLAsp9rdkxjNK7IvG1f5NMHd31kFPZjbFv/bJp48Qnl5Peht8Yk102QcgNJenWysH3PHnDIXi9Bg1lJN2MRXPDDtW285jyHOaIK76SJJo1RfcxuutVGPtrgU0sPDlNtmPdH69MJvMkSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722869635; c=relaxed/simple;
	bh=3rOz7BDXwlQ9UnOvzDCF2tjuOpsdwHuqigAqPDEx2yU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mSb3lfhIRnofdzNq+OZeHAPuUdtkUQoWte9AGKtruZpx19RwE6bNRYZSPAjdGtcm65I4LzZsypgRtxE2778BP8RVhS92UIlI2t9R7CJToqXyTqj0UXGaCVK8Gd5Q0w+QNtL5Vk3ANLPzy4UdEH4wCCpUrVnXrEp3dF5yKLtYOQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pTiPKTlO; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=voJL2WTo; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4DFDD23B3C;
	Mon,  5 Aug 2024 10:53:47 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=sasl; bh=3rOz7BDXwlQ9UnOvzDCF2tjuOpsdwHuqigAqPD
	Ex2yU=; b=pTiPKTlOj3boeCHQ4FiaFJwK0oJBnWmqCx+E9QvzRyMhImN3PfRB6p
	l6On54P2/yE+yBXomeBXCc1Wa+zBJpOc3FtoFGfnPbKTI97QT2oVmWNzKErsunqP
	rXNeFhmLmiC6p0wDSIj1wMqQO+CVuo1KMo6AhgzOJV9YNaZF8W9GA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 44E1923B3B;
	Mon,  5 Aug 2024 10:53:47 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=3rOz7BDXwlQ9UnOvzDCF2tjuOpsdwHuqigAqPDEx2yU=; b=voJL2WTo3lXi5FOcLjqmnorpdT57k2WqQNzyyy80RSn0wrrzTldWRw5IqswTBCJxn/m/mKMBnPJxi0+xiQ1gjY9T7n+u55U1eb50kcUbY0WcYhycTuE16Bw93o1emKVCuupeWzE8tHwMHilYrFY/kwgbUIHHV2tTZA2gB4sol5M=
Received: from yoda.fluxnic.net (unknown [184.162.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BA6DF23B3A;
	Mon,  5 Aug 2024 10:53:46 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu (unknown [IPv6:fd17:d3d3:663b:0:9696:df8a:e3:af35])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 936F6D8AE83;
	Mon,  5 Aug 2024 10:53:45 -0400 (EDT)
Date: Mon, 5 Aug 2024 10:53:45 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Dave Martin <Dave.Martin@arm.com>
cc: Frederic Weisbecker <frederic@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, 
    linux-arm-kernel@lists.infradead.org, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Peter Zijlstra <peterz@infradead.org>, 
    Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 01/20] arm/bL_switcher: Use kthread_run_on_cpu()
In-Reply-To: <ZrDlZYoafHFpW4TS@e133380.arm.com>
Message-ID: <q8r18os4-8ss5-qq61-so7p-0np12o8q3prr@syhkavp.arg>
References: <20240726215701.19459-1-frederic@kernel.org> <20240726215701.19459-2-frederic@kernel.org> <ZrDlZYoafHFpW4TS@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID:
 847DE1AC-533A-11EF-B06C-9B0F950A682E-78420484!pb-smtp2.pobox.com

On Mon, 5 Aug 2024, Dave Martin wrote:

> Hi,
> 
> On Fri, Jul 26, 2024 at 11:56:37PM +0200, Frederic Weisbecker wrote:
> > Use the proper API instead of open coding it.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >  arch/arm/common/bL_switcher.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
> > index 9a9aa53547a6..d1e82a318e3b 100644
> > --- a/arch/arm/common/bL_switcher.c
> > +++ b/arch/arm/common/bL_switcher.c
> > @@ -307,13 +307,11 @@ static struct task_struct *bL_switcher_thread_create(int cpu, void *arg)
> >  {
> >  	struct task_struct *task;
> >  
> > -	task = kthread_create_on_node(bL_switcher_thread, arg,
> > -				      cpu_to_node(cpu), "kswitcher_%d", cpu);
> > -	if (!IS_ERR(task)) {
> > -		kthread_bind(task, cpu);
> > -		wake_up_process(task);
> > -	} else
> > +	task = kthread_run_on_cpu(bL_switcher_thread, arg,
> > +				  cpu, "kswitcher_%d");
> > +	if (IS_ERR(task))
> >  		pr_err("%s failed for CPU %d\n", __func__, cpu);
> > +
> >  	return task;
> >  }
> 
> It's ages since I worked on this, but it looks like this is pure
> refactoring.  So far as I can see, it does the right thing, so, FWIW:
> 
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> 
> I don't currently have hardware I can test this on, though.
> 
> Nico (Cc added) might just possibly have an opinion on it, though this
> looks uncontroversial.

No strong opinion.

Acked-by: Nicolas Pitre <nico@fluxnic.net>


Nicolas

