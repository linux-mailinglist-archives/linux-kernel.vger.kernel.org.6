Return-Path: <linux-kernel+bounces-401269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF0E9C17FD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3BF328458B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEE41DE8A8;
	Fri,  8 Nov 2024 08:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eHsfqcZC"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467891DDC26
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 08:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731054707; cv=none; b=Kvt4netJevJiziqbG9ceqxJ16kf00ql/sXwqBsR+fcgkhx7UvEMv/62UibVvVxt/XGe1FpB+/XowVftJO20cDyPg84VQKOoYRM1ZW+wQO7DaLEfKoCG4Zst5WQA4sYMcVoXyXfUH4UlS/Q+0p1DeADViKLuGOXgFRjLKbj3/ojI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731054707; c=relaxed/simple;
	bh=Af+ibQAcn9VYqAgUjp/SlyL+YVC9zLwX1LqXg3dG/+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0ngOXBMN5VtwtugTKuvza73zYSVtPpYCbkau6PgMfXCkLTIRowcKFeuLvNx3xAD/9Dfe0/5NLU9Y7jOmEOa9dAeAKEkbJExUbBHfQsd1KQtpFOt9LPqjETi6Wf8xFsUXQjbZdJDTjUHyk8gMiq4eqpPGkyiyEMQBQKexRIGx1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eHsfqcZC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=U5iXxYbAfJjSDxBL5j4rJye+EBOI58DLKjlS8UohSOU=; b=eHsfqcZC9y9l0uyhJnHfEV+lg6
	XhnQo0+5QPoEgvUehPXlppWxbOckzZTbUSDqJifW4fI2q9BO6Ov5hLp0X3T3g9UargZrsho5E4+U9
	mQRJrYg4VlQD/7/K4LGiuoGhNDa0oZ99MUkr92pw4V7mLWxXPEzz3OWm2HXygHiYYH8Muh7VN4V96
	H6qKuhoYk5o2j8CTyUNhTIpp/05vzcQKpWygt73YN76Hhjan+ZbMc1V2Jv0NVJ1Xu2G7X5NmrT1eD
	fugsEc/yB74Qsq6zmcd2JYfjjKXN26/IR/cLgWiEeUB8g7NfLPKBiaQAJSxyKRZMZ3QAjnyvgyUD0
	Ve35pb0w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t9KOz-00000008Yx9-3PHV;
	Fri, 08 Nov 2024 08:31:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7A3D830049D; Fri,  8 Nov 2024 09:31:33 +0100 (CET)
Date: Fri, 8 Nov 2024 09:31:33 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Saravana Kannan <saravanak@google.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Benjamin Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, Thomas Gleixner <tglx@linutronix.de>,
	efault@gmx.de, K Prateek Nayak <kprateek.nayak@amd.com>,
	John Stultz <jstultz@google.com>,
	Vincent Palomares <paillon@google.com>
Subject: Re: Very high scheduling delay with plenty of idle CPUs
Message-ID: <20241108083133.GD38786@noisy.programming.kicks-ass.net>
References: <CAGETcx830PZyr_oZAkghR=CLsThLUX1hZRxrNK_FNSLuF2TBAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx830PZyr_oZAkghR=CLsThLUX1hZRxrNK_FNSLuF2TBAw@mail.gmail.com>

On Thu, Nov 07, 2024 at 11:28:07PM -0800, Saravana Kannan wrote:
> Hi scheduler folks,
> 
> I'm running into some weird scheduling issues when testing non-sched
> changes on a Pixel 6 that's running close to 6.12-rc5. I'm not sure if
> this is an issue in earlier kernel versions or not.
> 

It's a bit unfortunate you don't have a known good kernel there. Anyway,
one thing that recently came up is that DELAY_DEQUEUE can cause some
delays, specifically it can inhibit wakeup migration.

You can either test with that feature turned off, or apply something
like the following patch:

  https://lkml.kernel.org/r/20241106135346.GL24862@noisy.programming.kicks-ass.net

