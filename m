Return-Path: <linux-kernel+bounces-358500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4555999802B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B181C21F83
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3F01BD516;
	Thu, 10 Oct 2024 08:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CoKgSTJx"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79981B86CF
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728547849; cv=none; b=lbRmhmPI7YEZm8o9wtcNbJMs0w/f6K7LHw/KuZCb7yQU+QClEHv1js/5Y+KiRQOupTBL1katdeFC0jWplkpA8/afWc/x5DejywBG2HNBtV1iSTBmoSYOySwNrJargZuaucHWTNN8O6Nwro8VhSaAjjQDiEdfark0N0NTbp4jIfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728547849; c=relaxed/simple;
	bh=9uK0qUSj+SrkDIni5kdzbhWm5uoWWLaDOx1sYcVMGaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MN0+0eRASsiyy6a18M+R68KFtJ3F6cDVId+JMYSeKawwARmEjMWih+Xp9acSLXF0d8uNLirBCfVKpUmUceemkonBSmDZlA+2Nbgk6DHQGaVfgIZxo+0XL/nCrAm0hc73Ug8p7CLQoIZ5l6m5xKL8gNNGQ1C6uq8Ec88NZ9h+P2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CoKgSTJx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=lo3l14xobuNzOWzefgd03VBScQt6h0Pq9HwDSpwFgIg=; b=CoKgSTJxP82KXt1LUmsdQJWTu4
	VT5asYSRlcY5Jrlb0N6/i2Jg9NSDwe4WHzwxLS1WGEbydmbDET/sxKwZUYjGPSlFJTkb+MwByRDBv
	F0q4+fsm4fPhGGqAgq5WFNPaE5YzWzQPvoKTN8XRAZidhqX8GNZcQsdDL2opxD61wWT0Kh5s4t98p
	TYljArCnCmeokCnX1/hIGxNBzAHxXQiwWKLQAe3I4Vkfs0PUH1jyJoAL+5VXPM4oJ1u/Yq6Vkeekm
	jyUL9x/ZIrxuhHWFVqKBLvlqweRyW/sfSJiDv/rTmI6HVMzoawNtulRLaodDE/icx4WlEoEg0Aanx
	sI9LUkJQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1syoFl-000000077Vn-08Dl;
	Thu, 10 Oct 2024 08:10:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1372430088D; Thu, 10 Oct 2024 10:10:33 +0200 (CEST)
Date: Thu, 10 Oct 2024 10:10:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, frederic@kernel.org,
	efault@gmx.de
Subject: Re: [PATCH 2/7] rcu: limit PREEMPT_RCU configurations
Message-ID: <20241010081032.GA17263@noisy.programming.kicks-ass.net>
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-3-ankur.a.arora@oracle.com>
 <20241009180117.GS17263@noisy.programming.kicks-ass.net>
 <37af80bd-a54f-4ee4-9175-6f0f27b685a0@paulmck-laptop>
 <20241010063207.xIrynIqO@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241010063207.xIrynIqO@linutronix.de>

On Thu, Oct 10, 2024 at 08:32:07AM +0200, Sebastian Andrzej Siewior wrote:
> On 2024-10-09 11:24:09 [-0700], Paul E. McKenney wrote:
> > In order to support systems that currently run CONFIG_PREEMPT=n that
> …
> > Or am I once again missing your point?
> 
> The change is:
> | config PREEMPT_RCU
> |        bool
> |-       default y if PREEMPTION
> |+       default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
> 
> Now:
> - CONFIG_PREEMPT select PREEMPT_BUILD
> - PREEMPT_RT select CONFIG_PREEMPTION
> - PREEMPT_DYNAMIC selects PREEMPT_BUILD
> 
> and PREEMPT_BUILD select CONFIG_PREEMPTION
> 
> so in the end, this change is a nop, right?

PREEMPT_RT selects PREEMPTION *and* has one of PREEMPT / PREEMPT_LAZY /
PREEMPT_DYNAMIC, all of which in turn select PREEMPT_BUILD, which
selects PREEMPTION.

(arguably we can remove the select PREEMPTION from PREEMPT_RT)

The proposed change is not a nop because the config: PREEMPT_LAZY=y
PREEMPT_DYNAMIC=n will result in false, while it will have PREEMPTION.

That said, I really do not agree with the change, it makes the condition
complicated for no reason.

