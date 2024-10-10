Return-Path: <linux-kernel+bounces-358807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 897E5998413
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A2F2283B79
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F411C0DC2;
	Thu, 10 Oct 2024 10:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fsqfkYFi"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A2518C03D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 10:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728557089; cv=none; b=ECK0oNGHnprL0GkdP92xfYrokAoA4jbwA+pe1AsENgvCTC7VrHFar+lacZee0BLuIp9hpZA91U0mDWMcz/rm/IhLtUqGSM+HGuzSfpfm4v/+Izwi1CGiqGZpnDlOkSWGE/fuU+NOX0lAyT1kcl2EUmWQuLvAVSP1rfVOomvhym4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728557089; c=relaxed/simple;
	bh=HwXtcBfZ9skqTUUIvL6qjtFcMbgAVYIzdtNQEETd01c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyteEF/bXvQ8UqfKeAxbi/cXER7ZW1HS7IfkVF2obuY0P3c4tHLZUPUeD6V0nLqYc6A1CkdhCfAP6RhZekfmKPfBABzfzuDrsHMlhtZvLnzqgH2XAuy0Bq0Be1GCcymLY446A8q3jqRP87uyfG9s9gIoqTiWYtexvGw8e87Mka8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fsqfkYFi; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=wt3+UwGS92R+4Ox5ks/fZ0imxBx7Ykqt9KCdpyt4ijs=; b=fsqfkYFi3gwqCB6JIpMC5OY+hp
	dQ07ZLxCK7nJNO325BO9qC+wrd8Gj754eZB2Pfi5xjt/4B7dOY/AHxaqQT+xcDOPowG/sZ1U0dMVh
	5do7dDgErsY7ln6LD3OJSNE9cfWs4D5wdL/upgH3MbCrxjqxk87DlbkCqwrFDpXqcKGfh3Jtf6IAz
	GtZxlGV8AdFVulLMwEUiJxGapnWaKLW3/JQoC0IggJvc8lvfIg0NogXaCN8B3vnBrXPD5ayVEIO9w
	HfuSprPUSuYHI0YaZtY7VPlVdcxH/YlspMabBK+Q3YaurgtknePPZ02Vl5YU7610D0p00Ce+txH1W
	rNlCGeWA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1syqes-00000005Lbn-3or9;
	Thu, 10 Oct 2024 10:44:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8A92B30088D; Thu, 10 Oct 2024 12:44:38 +0200 (CEST)
Date: Thu, 10 Oct 2024 12:44:38 +0200
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
Message-ID: <20241010104438.GJ14587@noisy.programming.kicks-ass.net>
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-3-ankur.a.arora@oracle.com>
 <20241009180117.GS17263@noisy.programming.kicks-ass.net>
 <37af80bd-a54f-4ee4-9175-6f0f27b685a0@paulmck-laptop>
 <20241010063207.xIrynIqO@linutronix.de>
 <20241010081032.GA17263@noisy.programming.kicks-ass.net>
 <20241010091326.nK71dG4b@linutronix.de>
 <20241010100308.GE17263@noisy.programming.kicks-ass.net>
 <20241010102657.H7HpIbVp@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241010102657.H7HpIbVp@linutronix.de>

On Thu, Oct 10, 2024 at 12:26:57PM +0200, Sebastian Andrzej Siewior wrote:
> On 2024-10-10 12:03:08 [+0200], Peter Zijlstra wrote:
> > > 
> > > I can't deselect CONFIG_PREEMPT_RCU=y. This is because LAZY selects
> > > PREEMPT_BUILD and PREEMPT_RCU selects itself once PREEMPTION is on.
> > 
> > Oh, the entry isn't user selectable? Fix that perhaps?
> > 
> > -	bool
> > +	bool "Use preemptible RCU"
> > 
> > Or something along those lines -- I forever forget how Kconfig works.
> 
> Oh. Well, yes. If we do this then it becomes suddenly selectable and
> half of the series makes sense…
> But as you said, this complicates things. 

But then you leave it up to the user, instead of doing something quite
random. This would allow you to configure PREEMPT_RCU=n despite also
using PREEMPT_DYNAMIC if that is your thing.

I fundamentally hate the whole randomness of the earlier proposed
selection criteria. It only disables PREEMPT_RCU if you use LAZY and not
also have PREEMPT_RT or PREEMPT_DYNAMIC.

