Return-Path: <linux-kernel+bounces-272772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8233B9460C6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CF1B283149
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3E21537AA;
	Fri,  2 Aug 2024 15:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WoSLA2up"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A70F175D3F
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 15:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722613580; cv=none; b=etv+WCT7gQSiGvPXMzy0n9gADAYamXvN8adPXB4aLHHuRjar3AzVkX27QnsHGS09ErNSiJcvuZ1StZ1MovVAp1808gRKf0IcHoawdCRlz1p2tnUXC9hhusnDAepF05+emNtV8TtkqSj0icDn8gbqWeFnO7XCNHf/RHJE8Oav8Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722613580; c=relaxed/simple;
	bh=Smm79O1AfPjUYfDBORGT1d4YEJu4ZIjrym+47QxNb4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V5GuDsycJCHWYz+suN1Hb9PIWSoi5N0kxgEveeZ4AO9VzONFTK+I7HshlKQnaxqM3Jd7KpUiNGDVEGuqT6JHdCEt2ISeM10mXOzFiT4rY737ICzpXEdbX/9DDA4H74MC3WabItkS0dtWOapvGaNYpBFVj/JmOZVTYUUlvGwCySk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WoSLA2up; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65629C4AF0E;
	Fri,  2 Aug 2024 15:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722613580;
	bh=Smm79O1AfPjUYfDBORGT1d4YEJu4ZIjrym+47QxNb4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WoSLA2upoFepc9wR2pYBMrnAumboYzGPqk87EgVZ2ugrUQPSrMBiL5VVO5nnWSShP
	 xK6+p3xCnlOWglxbLDwk/7MP4S5iu64GKfTqJNRx7aYnEybcLCsbGLMJyZAqnEjhs1
	 eABgQ+OHqMftKL21FvbJjgVZ69GItFXT/cZ2mqaUXslsmUAIYovr8m0CKEVn28/FkO
	 KXomM6FqS+8knXf+RX/dsNY1Pn/eLL5pckyGNmQrEKS08pU86Y10Nur7jterFRUImM
	 5HjYKU/AV7tPbXbfXQLhdz+3icVxojfP/A931dco05iogzVBmfFSTtyJ14ImgSZ6vv
	 UbF0rtxqIXUFQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0935ACE0F69; Fri,  2 Aug 2024 08:46:20 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Feng Tang <feng.tang@intel.com>,
	Waiman Long <longman@redhat.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	x86@kernel.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 TSC and clocksource-watchdog updates for v6.12 4/5]  clocksource: Set cs_watchdog_read() checks based on .uncertainty_margin
Date: Fri,  2 Aug 2024 08:46:17 -0700
Message-Id: <20240802154618.4149953-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <dac058b2-68c7-4b9a-a428-afb2b4b03ea0@paulmck-laptop>
References: <dac058b2-68c7-4b9a-a428-afb2b4b03ea0@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Right now, cs_watchdog_read() does clocksource sanity checks based
on WATCHDOG_MAX_SKEW, which sets a floor on any clocksource's
.uncertainty_margin.  These sanity checks can therefore act
inappropriately for clocksources with large uncertainty margins.

One reason for a clocksource to have a large .uncertainty_margin is when
that clocksource has long read-out latency, given that it does not make
sense for the .uncertainty_margin to be smaller than the read-out latency.
With the current checks, cs_watchdog_read() could reject all normal
reads from a clocksource with long read-out latencies, such as those
from legacy clocksources that are no longer implemented in hardware.

Therefore, recast the cs_watchdog_read() checks in terms of the
.uncertainty_margin values of the clocksources involved in the timespan
in question.  The first covers two watchdog reads and one cs read,
so use twice the watchdog .uncertainty_margin plus that of the cs.
The second covers only a pair of watchdog reads, so use twice the
watchdog .uncertainty_margin.

Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: <x86@kernel.org>
---
 kernel/time/clocksource.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index ee0ad5e4d5170..23336eecb4f43 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -244,6 +244,7 @@ enum wd_read_status {
 
 static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
 {
+	int64_t md = 2 * watchdog->uncertainty_margin;
 	unsigned int nretries, max_retries;
 	int64_t wd_delay, wd_seq_delay;
 	u64 wd_end, wd_end2;
@@ -258,7 +259,7 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
 		local_irq_enable();
 
 		wd_delay = cycles_to_nsec_safe(watchdog, *wdnow, wd_end);
-		if (wd_delay <= WATCHDOG_MAX_SKEW) {
+		if (wd_delay <= md + cs->uncertainty_margin) {
 			if (nretries > 1 && nretries >= max_retries) {
 				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
 					smp_processor_id(), watchdog->name, nretries);
@@ -271,12 +272,12 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
 		 * there is too much external interferences that cause
 		 * significant delay in reading both clocksource and watchdog.
 		 *
-		 * If consecutive WD read-back delay > WATCHDOG_MAX_SKEW/2,
-		 * report system busy, reinit the watchdog and skip the current
+		 * If consecutive WD read-back delay > md, report
+		 * system busy, reinit the watchdog and skip the current
 		 * watchdog test.
 		 */
 		wd_seq_delay = cycles_to_nsec_safe(watchdog, wd_end, wd_end2);
-		if (wd_seq_delay > WATCHDOG_MAX_SKEW/2)
+		if (wd_seq_delay > md)
 			goto skip_test;
 	}
 
-- 
2.40.1


