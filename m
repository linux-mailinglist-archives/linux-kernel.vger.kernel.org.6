Return-Path: <linux-kernel+bounces-208574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D64A89026ED
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEF951C20DF2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55060150987;
	Mon, 10 Jun 2024 16:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZhmZdNtx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B6jHuOpJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC2A14D2A4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037742; cv=none; b=A3yfTy2m8aeYl4OBHwFsOHgTDOI5CncuABUfux6tC40/b9QJC8Vg5NnwFr8YLylacdXdssFvQ29BQ4Kb1wSHX5R4RTmOE7r+V34sLrjRTptJkHuiEQp5W7nioiybHtb84lY1CsxLQVjXk9RqIp/3SavRQ+QQesZtDsZkkbmHqdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037742; c=relaxed/simple;
	bh=ELAaPaGkJq6p3gTMdWaH/+B64HkzxUph4WcIXAbdkUg=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=YbawPJEinHRkZkkthFT3c1mtOSDIFdlrVri0JQcqVLXqw3tJbnyzEDE75Fqt0bpofbrqkSSq40fnz0fU3gIVSMwEY6a4c30FnUsfCb8e2EcjJhYbIpDZgDf0OaHQVkc5x+tKdXQ6TZOjTfo44GCWtwfwx1K07pgZIGoPxNLO/pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZhmZdNtx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B6jHuOpJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610164026.162380808@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718037739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=amj9rEI4omA2o9SPkzdGtXDAK0TjsBjy30f0aomhQz0=;
	b=ZhmZdNtxWOeWwb4bYVD9mSeApzqUSLS/lZMFRYxuuTSBI8Ar0hnpKrXGeO4unxkPqvbjvh
	DYn/CrATrpN4owrrdaSNYrbQCRCxGVsOQcceldYhMApeB7dHEh1yz+F85Slx9Q3h4CsAFP
	aRrYiJ3v/XPm6mrJ0/KAnnA3pxXXvRLmkCPyYoKFfoLBt2bkBBbNooT2yTUYCcrVDekCpI
	4j06j77AFLybsVZr5q9/ei/XQoEyk7CgWu522rYxtfMV/CkHK+mre2rUc0j3+6AC8tzKSr
	NOGAPXBXzoGzNL+9TbmR+jkibHy41jPzIiaBUmRSosLkjkHNxUL/GBbHD/bhnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718037739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=amj9rEI4omA2o9SPkzdGtXDAK0TjsBjy30f0aomhQz0=;
	b=B6jHuOpJ2E/ua/aVOWaFbruYSDrCjKOdCi8mGwb3vrBRYUAp3xaEmeoGVjfRsCB/mAn9cc
	ucPHt1oe4aEAjjCg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 John Stultz <jstultz@google.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Oleg Nesterov <oleg@redhat.com>
Subject: [patch V3 11/51] posix-cpu-timers: Handle SIGEV_NONE timers correctly
 in timer_set()
References: <20240610163452.591699700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 18:42:18 +0200 (CEST)

Expired SIGEV_NONE oneshot timers must return 0 nsec for the expiry time in
timer_get(), but the posix CPU timer implementation returns 1 nsec.

Add the missing conditional.

This will be cleaned up in a follow up patch.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Split out into new patch to make review simpler - Frederic
---
 kernel/time/posix-cpu-timers.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -706,7 +706,16 @@ static int posix_cpu_timer_set(struct k_
 				old_expires = exp - val;
 				old->it_value = ns_to_timespec64(old_expires);
 			} else {
-				old->it_value.tv_nsec = 1;
+				/*
+				 * A single shot SIGEV_NONE timer must return 0, when it is
+				 * expired! Timers which have a real signal delivery mode
+				 * must return a remaining time greater than 0 because the
+				 * signal has not yet been delivered.
+				 */
+				if (sigev_none)
+					old->it_value.tv_nsec = 0;
+				else
+					old->it_value.tv_nsec = 1;
 				old->it_value.tv_sec = 0;
 			}
 		}


