Return-Path: <linux-kernel+bounces-357658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 477879973DA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E9228898D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5E21DEFCE;
	Wed,  9 Oct 2024 17:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lV7w1d+d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D091C152E1C
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 17:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496647; cv=none; b=GNUjPOYDm2tusb4EHgEfwN370cf8It8xrnZtGqo1mUcwJu30dZlJEQ7lGWKgBPXwf6wRzBxs+fB+y5Uho9sA5D9VvRmia7hB6pn1qefPqUEOEx711Q7SyrNC6yBck73PBZkIddrVT9ikYVBxm67Hrw6/FIIetS76DvFZHMcTx8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496647; c=relaxed/simple;
	bh=U7iewgHEaxOLrNu4r6hb7UCoJAfha3rL3M6HOuOd2qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=R8NOIEBml5DcwiroDn/iA+zh9jzEMILdEXw8OA732dBiRvHqybkxhqxcnx+QEB1BNoZfdrUoYMzLNksod1FnSh3UrofuW8cMb05P6Kw3/bOSDkLV7UxNLuy4rQN5vVTh21SIpw66bCoaoAyaYAuvk9i4hUqcJL1BohCZyDU/nww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lV7w1d+d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40040C4CEC3;
	Wed,  9 Oct 2024 17:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728496645;
	bh=U7iewgHEaxOLrNu4r6hb7UCoJAfha3rL3M6HOuOd2qQ=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=lV7w1d+dqUXWOPu5AQwXhOk+Ai7VZ7fLEQEhhk/PZBZ5i84S7MgGQ/fk7TyOePkde
	 uNHwRDg8YBGM4bpSrWuiD/0WZ+yzIt7pojGwy8bExbMjRfpUXEy4xY82QuGR9Vmkrx
	 kpsXHWYV9It56W3Ds9/dVw3DJ3ll3FqqiixttvyAiZjYJH6mQA+JBogY8l+rt1eBNU
	 g+GnyhbPm74jYRNNaywgoXuhj7bp47ZC+i+cPPtlwBahYwTP66Wp8+f/bBXjrWoLCI
	 NePhs1lUPLoyl5lEzx4neF1DvRgJ0Y3Oz1Ulu0JPZsN0AAXR7sG9k4xj3dXtuRwG7s
	 zF9heWf65ksMQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E5103CE08E5; Wed,  9 Oct 2024 10:57:24 -0700 (PDT)
Date: Wed, 9 Oct 2024 10:57:24 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: neeraj.upadhyay@kernel.org, riel@surriel.com, leobras@redhat.com,
	tglx@linutronix.de, peterz@infradead.org, qiyuzhu2@amd.com
Subject: locking/csd-lock: Switch from sched_clock() to
 ktime_get_mono_fast_ns()
Message-ID: <da9e8bee-71c2-4a59-a865-3dd6c5c9f092@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Currently, the CONFIG_CSD_LOCK_WAIT_DEBUG code uses sched_clock()
to check for excessive CSD-lock wait times.  This works, but does not
guarantee monotonic timestamps.  Therefore, switch from sched_clock()
to ktime_get_mono_fast_ns(), which does guarantee monotonic timestamps,
at least in the absence of calls from NMI handlers, which are not involved
in this code path.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Leonardo Bras <leobras@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>

diff --git a/kernel/smp.c b/kernel/smp.c
index f25e20617b7eb..27dc31a146a35 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -246,7 +246,7 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
 		return true;
 	}
 
-	ts2 = sched_clock();
+	ts2 = ktime_get_mono_fast_ns();
 	/* How long since we last checked for a stuck CSD lock.*/
 	ts_delta = ts2 - *ts1;
 	if (likely(ts_delta <= csd_lock_timeout_ns * (*nmessages + 1) *
@@ -321,7 +321,7 @@ static void __csd_lock_wait(call_single_data_t *csd)
 	int bug_id = 0;
 	u64 ts0, ts1;
 
-	ts1 = ts0 = sched_clock();
+	ts1 = ts0 = ktime_get_mono_fast_ns();
 	for (;;) {
 		if (csd_lock_wait_toolong(csd, ts0, &ts1, &bug_id, &nmessages))
 			break;

