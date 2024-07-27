Return-Path: <linux-kernel+bounces-264109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C8F93DF09
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 475211F2299C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E4113AA39;
	Sat, 27 Jul 2024 11:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d0jYQhXm"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EF4762DF
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722078149; cv=none; b=VYZR6zSlCNSgxwRvwBCBYQ6sWWNchNUoqPz8Amf/zu51aS9SJUWwcTPSu10QKfcAqjcVsBCU90eMZRDncFfywSo9wANPZKnlH3lyblSWeehafU8gQaz/7UlYekfxyOzRYpQIRRdK0ZZ7t91ZnzGTByYnN0busb31s6qjCClVW0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722078149; c=relaxed/simple;
	bh=s8mTKQsmw/z8/8J66bDomFpsQb5u5znCZlPicxY6d+A=;
	h=Message-Id:Date:From:To:Cc:Subject; b=ljNFUzPDQA0QeQgki5yOWoVKeatfdUtYZcJbXTHowTnd/2uTM4CVoRgsnRaCQi4F5s5w+wEo7Sl6ff6c5IrGKdu2EAT7DXlc56qOrx1Kam08tGPCrypBkkmHy0jaxXx6dj0Mnu55g+MYmA8aQSRbFQgggqeeUwOjTEyNfow7X7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d0jYQhXm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-Id:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=s8mTKQsmw/z8/8J66bDomFpsQb5u5znCZlPicxY6d+A=; b=d0jYQhXmWCFhJI86I3K9Fy55Fi
	/iUDTYq4+CwWrI3ehMP6CXfonJPz/xTjVzJM5n1FKyLufWfcfzAFVoLV1YcmSs7Do1dFa1ES3Jmy6
	/BKs31VvYMEspPmIUbECNOG8Z/Uruigcsw4iVrd52x1UQ7IBJBxA9LeMYJON88+GdYE4s6E8zcJQb
	sGq1rggryMCh1gz8zli+vGqXgw5nMyEGDMWFp8wyEHnH08mtCyLDjG2uj+Vh4qp9sZtOApyfqKo8p
	lhaxCdXGHGHuj20zo7t6QqCE/HCmr6Pe6hPhDURVoaDfSnZggeCGyeyKMlUESkkdofh9EWLOhddnL
	va6JFYLg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXfBf-0000000BGJN-2XyN;
	Sat, 27 Jul 2024 11:02:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 8C97F30068B; Sat, 27 Jul 2024 13:02:06 +0200 (CEST)
Message-Id: <20240727102732.960974693@infradead.org>
User-Agent: quilt/0.65
Date: Sat, 27 Jul 2024 12:27:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@redhat.com,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com,
 youssefesmat@chromium.org,
 tglx@linutronix.de,
 efault@gmx.de
Subject: [PATCH 00/24] Complete EEVDF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi all,

So after much delay this is hopefully the final version of the EEVDF patches.
They've been sitting in my git tree for ever it seems, and people have been
testing it and sending fixes.

I've spend the last two days testing and fixing cfs-bandwidth, and as far
as I know that was the very last issue holding it back.

These patches apply on top of queue.git sched/dl-server, which I plan on merging
in tip/sched/core once -rc1 drops.

I'm hoping to then merge all this (+- the DVFS clock patch) right before -rc2.


Aside from a ton of bug fixes -- thanks all! -- new in this version is:

 - split up the huge delay-dequeue patch
 - tested/fixed cfs-bandwidth
 - PLACE_REL_DEADLINE -- preserve the relative deadline when migrating
 - SCHED_BATCH is equivalent to RESPECT_SLICE
 - propagate min_slice up cgroups
 - CLOCK_THREAD_DVFS_ID



