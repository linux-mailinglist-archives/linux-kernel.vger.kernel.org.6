Return-Path: <linux-kernel+bounces-358483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC6B997FE4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82A41F22677
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB01202F80;
	Thu, 10 Oct 2024 07:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qRCMnrSk"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870CF1C9ECA
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 07:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728547140; cv=none; b=NQx+iNfFgYXU4lYU2y8id1RJjKBD64jfhCXcTKPMI2ltooL/W2AMhRUfKHPLNsxIX3gpk6qxzsCVvhm0emQ0SRj8SHSvAclBJEYt4NyzqzOyU1luptX9eiKOu3eepoEpGq7s3ib2xWVXCo7mIKquc7UEZYCa5BQ8eWek8jgTMJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728547140; c=relaxed/simple;
	bh=ADMoqZ+Lq+yC0ScC7nQDVocebHDA8uXxzjW3BAki/ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWPMDcf5Ci3TNiDtL0KeDT24TWR+1Uh0jF7vwTKt9HxpjyJXfErhLQNJS+tgI+PfaYmwqxrRxo3SIKIDuEj5c40mL2Q0U81mtNhlSzxBgpMyfYiKWZ1SndAeMQNVtLgAjrwonTgXt2QT/RJozz13yqk/lJNyBgzlnP8Aj65HUW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qRCMnrSk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ADMoqZ+Lq+yC0ScC7nQDVocebHDA8uXxzjW3BAki/ec=; b=qRCMnrSkkBt8HCvHOOFSI79Ory
	HqUuRdGaA1PiDH/GaIX6oNusfRGGoP18xnTicz0MvcajMQtswjBvGrLgJ6tiEXX1v7joSfpnvObCe
	sjmO438ndCOf0iID0mjIaBT3T8GWNTwYW4GTwAGFjMYA57Ruz0PYgXghJSxnsQo7E0g2m2rE+UWXg
	GFvCdbTWjXeui2PfZAz4Ugu8p0vUCMpCI2JK4i0YvOKvXq2zvAS309dA12vFsGmrM7DWbELHcLEfb
	bNWXMnUoF8ixqigzdV4GVImpfgdm5Cqxrf85/p3mh0MoBTRw5kFPmRs9RlS0Dj45xRB6OlnUatvXu
	nuaGB65g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1syo4Q-000000076AX-03UW;
	Thu, 10 Oct 2024 07:58:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 437F330088D; Thu, 10 Oct 2024 09:58:50 +0200 (CEST)
Date: Thu, 10 Oct 2024 09:58:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, mingo@kernel.org, bigeasy@linutronix.de,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, frederic@kernel.org,
	efault@gmx.de
Subject: Re: [PATCH 2/7] rcu: limit PREEMPT_RCU configurations
Message-ID: <20241010075850.GZ17263@noisy.programming.kicks-ass.net>
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-3-ankur.a.arora@oracle.com>
 <20241009180117.GS17263@noisy.programming.kicks-ass.net>
 <37af80bd-a54f-4ee4-9175-6f0f27b685a0@paulmck-laptop>
 <20241009205218.GW17263@noisy.programming.kicks-ass.net>
 <28bcac6a-6aee-456a-8022-5eef9ec08eaa@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28bcac6a-6aee-456a-8022-5eef9ec08eaa@paulmck-laptop>

On Wed, Oct 09, 2024 at 02:16:43PM -0700, Paul E. McKenney wrote:

> Because we don't need a bunch of people surprised by this change in
> behavior.

I'm not sure what change in behaviour; Lazy is brand spanking new, it
will have new behaviour not in line with previous modes. Just put in the
help text that if you're looking for a reality closer to the old
Voluntary to use PREEMPT_RCU=n.

In reality very few people will care, because distros will be running
PREEMPT_DYNAMIC and the 3 people doing their own thing ought to be savvy
enough to deal with things, no?

