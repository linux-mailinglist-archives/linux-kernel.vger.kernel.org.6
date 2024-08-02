Return-Path: <linux-kernel+bounces-272773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6384B9460C7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20994282E5E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F67C1537C0;
	Fri,  2 Aug 2024 15:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4fkwL1R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD43E175D5F
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 15:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722613580; cv=none; b=HsNGVWTR6ThPTjWAz+zkZTy/0PaROoAFdvL+Thyuot6gKm14lO+5FjeCjA26aFlQx06Om+O1p4Y3EEYXR7iV38j/Ur/efike6KyQsH/+P3LTh+ZB/FgZV44FrsAmnkCvxIzZRFTgNrC2NDrnAFeHF3PYqcvZTj1ii2CBYSmCXXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722613580; c=relaxed/simple;
	bh=NkGy99ttE/WMalc6vpGUP6nwyw6xu1BMaI7NQioFehE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=se4OLwhEwhL9lKawDDZ+eWD7wUSH9XfADY6NYfUhmxnEPLo4YS8GjcDQ+6Q2ql0qqkSM+Gv9XemDQqgdxSkm4OoYz0SoK5knwwVT9n2Ri/h8NxKIPHTOiNterUiZypRzZZ7VsiaPeeJ+LiJ0VQqDmjTegyzpmwEzTCDmRM/OIXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4fkwL1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7ADC4AF11;
	Fri,  2 Aug 2024 15:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722613580;
	bh=NkGy99ttE/WMalc6vpGUP6nwyw6xu1BMaI7NQioFehE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V4fkwL1RLmMlC64WHE687M63QdWRYiVvJmzkbNELlaoQawaPeu8WwTVG2glAnHmI3
	 bZWRqn4scSiLorZhZwEWds1hSKImMyBWzimcsvcvno7BbhXJgrstvXGGAhEod+ZJ7F
	 BeHRIiSutFe/ZLmqzjReBzvvWsc0haORn4illGdnYtl7RY6vnFn6Rc370p3vi66tOl
	 bKCBeucmYHZBXN+/f+tzRJwDxbb6VN6ITaH1uNXS3MoYRRhH88yFWs+NDOTu6VNj9Y
	 IZIpbVB6wjLqyDV61RAExyTCpaFnSQU7+xjsHxJE2oj8+7hVYx3Es71j5v0hcmDYCk
	 IuoSkEebB1cqA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 05EEBCE0E5A; Fri,  2 Aug 2024 08:46:20 -0700 (PDT)
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
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 TSC and clocksource-watchdog updates for v6.12 3/5]  clocksource: Fix comments on WATCHDOG_THRESHOLD & WATCHDOG_MAX_SKEW
Date: Fri,  2 Aug 2024 08:46:16 -0700
Message-Id: <20240802154618.4149953-3-paulmck@kernel.org>
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

The WATCHDOG_THRESHOLD macro is no longer used to supply a default value
for ->uncertainty_margin, but WATCHDOG_MAX_SKEW now is.  Therefore,
update the comments to reflect this change.

Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 kernel/time/clocksource.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 581cdbb538448..ee0ad5e4d5170 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -113,7 +113,6 @@ static u64 suspend_start;
 
 /*
  * Threshold: 0.0312s, when doubled: 0.0625s.
- * Also a default for cs->uncertainty_margin when registering clocks.
  */
 #define WATCHDOG_THRESHOLD (NSEC_PER_SEC >> 5)
 
@@ -139,6 +138,13 @@ static u64 suspend_start;
 #define MAX_SKEW_USEC	(125 * WATCHDOG_INTERVAL / HZ)
 #endif
 
+/*
+ * Default for maximum permissible skew when cs->uncertainty_margin is
+ * not specified, and the lower bound even when cs->uncertainty_margin
+ * is specified.  This is also the default that is used when registering
+ * clocks with unspecifed cs->uncertainty_margin, so this macro is used
+ * even in CONFIG_CLOCKSOURCE_WATCHDOG=n kernels.
+ */
 #define WATCHDOG_MAX_SKEW (MAX_SKEW_USEC * NSEC_PER_USEC)
 
 #ifdef CONFIG_CLOCKSOURCE_WATCHDOG
-- 
2.40.1


