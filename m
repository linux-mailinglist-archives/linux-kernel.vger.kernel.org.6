Return-Path: <linux-kernel+bounces-272775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9A69460C9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AD79282BDC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740301537C4;
	Fri,  2 Aug 2024 15:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wm9Rd7kE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4BA136327
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 15:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722613580; cv=none; b=hX1nHDgKRHd0UEBdjUJFcARj8GFeLQNTC8sgS8zKVmtRUIEN96/cT+qkaFbkxTAJF0RdBK8+7EZhxGwJtLihfhP4wEyr+HyGCIBYKwn64/j3GuCHso+xoSsbx0Y2Ae0+IudnWV9JcgVz1cZe6X6XnaSQftNTOBdZIi6U931ZPx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722613580; c=relaxed/simple;
	bh=gTzPjXYIttOOUwONwdIqZuA0ctMD+wdU/R7cWk5x6w0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NzHfmDDa8oHgxTV0y9zUUDK8Gx4nOr4rOJAaCuhOzooRG1VTzv0UAAGT5o5e2Ch/YCo3GgMVpucHAYdtto8v/YRg/+EV1JPJQ9Urh+ODOoUb9d3hXXTjXE+7TisUhnt/lvXMuEp3NOEjJ4UMygZT14YdkQZ8hSfnSgcVXgyFqR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wm9Rd7kE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38937C32782;
	Fri,  2 Aug 2024 15:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722613580;
	bh=gTzPjXYIttOOUwONwdIqZuA0ctMD+wdU/R7cWk5x6w0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wm9Rd7kERaYGURrfBPZ8OhDAbkUdcdWnvGV9YMNmTTphNstqN7VFAg4uExtLIumyZ
	 3bFczXVh5Aiz8BWsvF6hnhMy0TPTcv/bYK3uucyWS5vpkbykLdwdImCEe1Khdyy52B
	 AetjL+IYFfUywPRGnZ+Y+1ss2AF5wITPyeRAcY4LpROHi8sUmfjh3oWe9vLEAIeJJ+
	 1LbLYU8oJPejzy88zBwgjImR3R7EbEDUnj3BldR7NAz1wchnNylp9BnlSDWnlRBEa6
	 d0n8ajG+lBPiA5hiBsjlY70iYCdOgB3EvRihgvxomHtqEQNHMPwWWzTIkwseuyUsr0
	 kaO/NS4aEhUrA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id F4178CE09DB; Fri,  2 Aug 2024 08:46:19 -0700 (PDT)
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
	"Paul E . McKenney" <paulmck@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 TSC and clocksource-watchdog updates for v6.12 1/5]  clocksource: Improve comments for watchdog skew bounds
Date: Fri,  2 Aug 2024 08:46:14 -0700
Message-Id: <20240802154618.4149953-1-paulmck@kernel.org>
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

From: Borislav Petkov <bp@alien8.de>

Add more detail on the rationale for bounding the clocksource
->uncertainty_margin below at about 500ppm.

Signed-off-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Feng Tang <feng.tang@intel.com>
---
 kernel/time/clocksource.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index d25ba49e313cc..9ca4e8d2a70f8 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -125,6 +125,13 @@ static u64 suspend_start;
  *
  * The default of 500 parts per million is based on NTP's limits.
  * If a clocksource is good enough for NTP, it is good enough for us!
+ *
+ * In other words, by default, even if a clocksource is extremely
+ * precise (for example, with a sub-nanosecond period), the maximum
+ * permissible skew between the clocksource watchdog and the clocksource
+ * under test is not permitted to go below the 500ppm minimum defined
+ * by MAX_SKEW_USEC.  This 500ppm minimum may be overridden using the
+ * CLOCKSOURCE_WATCHDOG_MAX_SKEW_US Kconfig option.
  */
 #ifdef CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
 #define MAX_SKEW_USEC	CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
@@ -1146,14 +1153,19 @@ void __clocksource_update_freq_scale(struct clocksource *cs, u32 scale, u32 freq
 	}
 
 	/*
-	 * If the uncertainty margin is not specified, calculate it.
-	 * If both scale and freq are non-zero, calculate the clock
-	 * period, but bound below at 2*WATCHDOG_MAX_SKEW.  However,
-	 * if either of scale or freq is zero, be very conservative and
-	 * take the tens-of-milliseconds WATCHDOG_THRESHOLD value for the
-	 * uncertainty margin.  Allow stupidly small uncertainty margins
-	 * to be specified by the caller for testing purposes, but warn
-	 * to discourage production use of this capability.
+	 * If the uncertainty margin is not specified, calculate it.  If
+	 * both scale and freq are non-zero, calculate the clock period, but
+	 * bound below at 2*WATCHDOG_MAX_SKEW, that is, 500ppm by default.
+	 * However, if either of scale or freq is zero, be very conservative
+	 * and take the tens-of-milliseconds WATCHDOG_THRESHOLD value
+	 * for the uncertainty margin.  Allow stupidly small uncertainty
+	 * margins to be specified by the caller for testing purposes,
+	 * but warn to discourage production use of this capability.
+	 *
+	 * Bottom line:  The sum of the uncertainty margins of the
+	 * watchdog clocksource and the clocksource under test will be at
+	 * least 500ppm by default.  For more information, please see the
+	 * comment preceding CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US above.
 	 */
 	if (scale && freq && !cs->uncertainty_margin) {
 		cs->uncertainty_margin = NSEC_PER_SEC / (scale * freq);
-- 
2.40.1


