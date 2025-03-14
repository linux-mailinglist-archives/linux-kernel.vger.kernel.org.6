Return-Path: <linux-kernel+bounces-561564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45044A6137F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 360253BB803
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CEA200B96;
	Fri, 14 Mar 2025 14:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j1V5nDjX"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903251FDE0E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 14:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741961933; cv=none; b=niIskyZrvL/jo5RTfhszXgACTmfbSLESp7YLFRm7Q5/l8SMx9p54hJ6yDumFN8lorf7qfFelKAQtFr1YlAnKC4ZoDo2QvI45c4ky92gJBccEvvdj2srASY3FjB6QGp0UtS7XxEl8zp52YNE0No1El1UoJdboX7DmlmS4MgApkl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741961933; c=relaxed/simple;
	bh=NbmvMVH73/HsojklaKN/6D2WfSdy/UJIJceHWi3LG4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UG47aCyin262RRVCz9bytsjK1o2ztSuybEQGbhmTYsPEcLFDJul1E769Tbc2vz7OFbhAipPC3xx4pnp3+pC2rQmEFe18+Na0OkbmBMUfWrtJCf0iLAQ6PxB3FEmwK7AbZz6SJhiUMW+5+242LkIROam/aJLz8Cn5x/pN60DN6Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j1V5nDjX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZfIMHBLIMrMy8shT6/Th++FWefr5PpxqaRkAY4LgYHk=; b=j1V5nDjX0/MOyHGeTAdrRq/Sex
	KjygZjCzFdh2gLhgWoi4kYFbfKPWnBcL7UrwWbBurnEqMnBo/XXfhl7oXdL5BZGdoHe2DRf0barYe
	PjCtRGpIJqvMz+T1pwyvXeFrp/n6qJ/1meETSq66LIgqhb1xwRV52e9wKZ7/I/T9S6AlVmCjQaFfW
	hDBupNIK+/YGBlhmYfKobH6R6vADf/4IM5kJ4nc8HU56joSk6GtYknWPobQZnR8It3xveHmowvXG8
	D6PlcT0aluI81nIEvNJSud+i5cLhOIQjuhVggjrPICVTOHkr4tVoaNN6VPtqQvgGSBQHEzVsZ0v6j
	krfblfAg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tt5s3-00000000pvo-0vXW;
	Fri, 14 Mar 2025 14:18:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E15E5300599; Fri, 14 Mar 2025 15:18:41 +0100 (CET)
Date: Fri, 14 Mar 2025 15:18:41 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Paul McKenney <paulmck@kernel.org>
Subject: Re: [PATCH v10 00/21] futex: Add support task local hash maps,
 FUTEX2_NUMA and FUTEX2_MPOL
Message-ID: <20250314141841.GD36322@noisy.programming.kicks-ass.net>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
 <20250312151848.RlB_XuHA@linutronix.de>
 <20250314105856.GB36322@noisy.programming.kicks-ass.net>
 <20250314112808.-XVssA31@linutronix.de>
 <20250314114102.GY5880@noisy.programming.kicks-ass.net>
 <20250314120057.NcjcFp3K@linutronix.de>
 <20250314123058.GZ5880@noisy.programming.kicks-ass.net>
 <20250314133039.GYPBdpep@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314133039.GYPBdpep@linutronix.de>

On Fri, Mar 14, 2025 at 02:30:39PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-03-14 13:30:58 [+0100], Peter Zijlstra wrote:
> > > > Yeah, but sparse is stupid.
> > > 
> > > I though we like sparse.
> > 
> > I always ignore it, too much noise.
> 
> What do you suggest? Cleaning up that noise that noise or moving that
> RCU checking towards other tooling which is restricted to RCU only?
> Knowing you, you have already a plan in your cupboard but not the time :)

No real plan. Its been so long since I ran sparse I can't even remember
the shape of the noise, just that there was a _lot_ of it.

But IIRC the toolchains are starting to introduce address spaces:

  https://lkml.kernel.org/r/20250127160709.80604-1-ubizjak@gmail.com

so perhaps the __rcu thing can go that way.

