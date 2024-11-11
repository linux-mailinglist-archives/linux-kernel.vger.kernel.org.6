Return-Path: <linux-kernel+bounces-403892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 706649C3C50
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291761F2005B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1857C19B3EC;
	Mon, 11 Nov 2024 10:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JkNOwoBS"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B15D184542
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 10:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321672; cv=none; b=lZKInsRdvPPoTY6dq82yeJJeoImII723T9koZGKpF+gLdLwh+yrfUSLHwYwql86c4PEPs3M5GdoxkPDbU0bBBPJUNeCxYSrXd4DESE8KvILcyfsbKX1X6eXrPXAjUyAgCJ80kVqIXySjuYexW8uTD8yVZbAA/Q3bdyQtIHY289o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321672; c=relaxed/simple;
	bh=AP448Kh5rjJc2aFRfJLoFCa/mUi89HUU9V9a1PEeBFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0qgvWALTMo76U1hVcmqmoQkfQN3igNbBYqpNeUxibSwFHotXW4rsEiNzSXbDYiXLAYZskBlpEN81IFunglOdQ/TwbYNZpDtKEE6I2AJBjUUU2UM6c1HPyuJYxCRpXjXYZBIsMl2g+0SMOJWBuEQt/YMMDj8aDLATxS3jtQQ1bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JkNOwoBS; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lUejKkW9pp8R44KCZaOjxFTyeeEMPBTsZM+tDfiEZtY=; b=JkNOwoBSEXApZOSK0ukQNWiHtR
	Io2+gBQuk3KruODBCbrTgzHeszU3ZlGwAc4O+F3pgwu3BcTKa1AHEbsE/TZojUSuO6PMyH0dToHkP
	RNfbL2iNznXPNDTm5iv/SmjjfmAa0YGyuJ6tUPxZvHWsFNeMauahz0pHsVxlcS+kpkI+YCm5HahiA
	E+A/++nl8AVcc1GBYAo26FWISeRVMCyP+wrVsTMJIzJgR+wEpekeoGaEknfQCi2jE6UY9Vg+4UABg
	PklGaXvSWf2TzYjiwi2ibAMPMyXvyMCVxgBhJebtkodxS4btIqs/8s8NFTm+3ceP+cn2bOME6JJMM
	gUQY0fTw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tARqp-0000000CpbE-3eoF;
	Mon, 11 Nov 2024 10:40:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C7844300472; Mon, 11 Nov 2024 11:40:54 +0100 (CET)
Date: Mon, 11 Nov 2024 11:40:54 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Saravana Kannan <saravanak@google.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Benjamin Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, Thomas Gleixner <tglx@linutronix.de>,
	efault@gmx.de, John Stultz <jstultz@google.com>,
	Vincent Palomares <paillon@google.com>,
	Tobias Huschle <huschle@linux.ibm.com>
Subject: Re: Very high scheduling delay with plenty of idle CPUs
Message-ID: <20241111104054.GE22801@noisy.programming.kicks-ass.net>
References: <CAGETcx830PZyr_oZAkghR=CLsThLUX1hZRxrNK_FNSLuF2TBAw@mail.gmail.com>
 <20241108083133.GD38786@noisy.programming.kicks-ass.net>
 <CAGETcx-CvWVc=TP5OmUL_iF7fSb1awJB1G8NghM1q_6dYKXkQQ@mail.gmail.com>
 <cc8831c7-8ea2-0ee7-061f-73352d7832ad@amd.com>
 <CAGETcx9qDK+QUiP8z1iNYXwjHz39oZzOZmhj4p=icU1BuVtcug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx9qDK+QUiP8z1iNYXwjHz39oZzOZmhj4p=icU1BuVtcug@mail.gmail.com>

On Sun, Nov 10, 2024 at 10:15:07PM -0800, Saravana Kannan wrote:

> I actually quickly hacked up the cpu_overutilized() function to return
> true during suspend/resume and the threads are nicely spread out and
> running in parallel. That actually reduces the total of the
> dpm_resume*() phases from 90ms to 75ms on my Pixel 6.

Right, so that kills EAS and makes it fall through to the regular
select_idle_sibling() thing.

> Peter,
> 
> Would you be open to the scheduler being aware of
> dpm_suspend*()/dpm_resume*() phases and triggering the CPU
> overutilized behavior during these phases? I know it's a very use case
> specific behavior but how often do we NOT want to speed up
> suspend/resume? We can make this a CONFIG or a kernel command line
> option -- say, fast_suspend or something like that.

Well, I don't mind if Vincent doesn't. It seems like a very
specific/targeted thing and should not affect much else, so it is a
relatively safe thing to do.

Perhaps a more direct hack in is_rd_overutilized() would be even less
invasive, changing cpu_overutilized() relies on that getting propagated
to rd->overutilized, might as well skip that step, no?

