Return-Path: <linux-kernel+bounces-265552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B27A93F2C3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 494271C21245
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DB6142E60;
	Mon, 29 Jul 2024 10:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p9aNlXCf"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB70E74055
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 10:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722249187; cv=none; b=iiP0APBCubz0K8RWAVynbKJyHxW4Y7n8+7neS4yS1HdaH+W/btvpx31KiOs97VV8upGMmBG5Af8S9RSQ1HXWIxluvaSuALYeQ2L0ONllwdsnvEqpXT71fCT6nwy31QPBDm7gckL3eShPG3zVIAb2Y/QoABxxcJH7esqRc66RzpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722249187; c=relaxed/simple;
	bh=wrZ2Vrzz9UaSHBLjlv9LWdkH0ZoQqsXk4bH/+N/fASM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9LrthrUU53tcPAwdJSB6ybXJnaT5ICROwxSpgNRd6mfYOvASJCBKXopWvqLqub7WzK3pVmdHS6LHH5ViEGG8m9ftUcGL2oNfEG0DlGtfuboEac5iYCFcngJuGSIzokwJInCl8OXw+KPf28wruGrstyKFEgXwKUrwsiQdST8eBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p9aNlXCf; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QsRF1lugkwcacWv3RCI2XWI1S1pdEGwNH21atCqUwcg=; b=p9aNlXCf11wWeV7eKPkx1ECOz8
	9WtsdESnUUffZmW+bYRQJgLf+BT7IE9Y4JItNygx2Aq8ZGPMOwYcAK8V1ML4POwohyBu5kZDhHL5a
	m+YwfvI38F+DIERXvocI+5b4zqO28z5jkoay7et19ahffkXXZf2FJD/DrV+q7iZcUmhLmEoYCCITl
	GZcKhYuNFwwuQZL5nzg1z632fc7p51+cIUXXPOGaWtjC2ysCg/ulUMXYVpHU4VlmBlv6YlTJxnWs6
	Wiuzd4kUzyfLmPu5Tmopqa8/iJ64mq8NEnvw/hEKqOCazDLkbZ6kazDJblRvzQyf+jArpD7uGN8F1
	YITiF/Vw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYNgU-00000004ldT-3bIn;
	Mon, 29 Jul 2024 10:32:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 676C4300439; Mon, 29 Jul 2024 12:32:53 +0200 (CEST)
Date: Mon, 29 Jul 2024 12:32:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joel Fernandes <joel@joelfernandes.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Phil Auld <pauld@redhat.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Youssef Esmat <youssefesmat@google.com>
Subject: Re: [PATCH V7 0/9] SCHED_DEADLINE server infrastructure
Message-ID: <20240729103253.GE37996@noisy.programming.kicks-ass.net>
References: <cover.1716811043.git.bristot@kernel.org>
 <CAO7JXPhWvLaaGqCGUZ_YCuja2T1ciWZoUnsUDnNPQ2b4yDB2Jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO7JXPhWvLaaGqCGUZ_YCuja2T1ciWZoUnsUDnNPQ2b4yDB2Jw@mail.gmail.com>

On Fri, Jun 21, 2024 at 10:41:35AM -0400, Vineeth Remanan Pillai wrote:

> Sorry that I could not get to reviewing and testing this revision. In
> v6 we had experienced a minor bug where suspend/resume had issues with
> dlserver. Since suspend does not do dequeue, dlserver is not stopped
> and this causes the premature wakeups. I haven't looked at v7 in
> detail, but I think the issue might still be present.

It is not.

> We have a workaround patch for this in our 5.15 kernel 

That is the problem... your necro kernel doesn't yet have the freezer
rewrite I imagine:

  f5d39b020809 ("freezer,sched: Rewrite core freezer logic")

That would cause all frozen tasks to be dequeued, and once all tasks
are dequeued, the deadline server stops itself too.

Juri did some testing to double check and no suspend / resume issues
were found.

Anyway, I've merged the lot into tip/sched/core.

Thanks all!

