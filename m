Return-Path: <linux-kernel+bounces-208581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3175E9026F6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40C531C20CCF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10910154430;
	Mon, 10 Jun 2024 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ldNp+pKS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2GLc07W/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1605A153578
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037750; cv=none; b=PJi2bOmCr8TZ69oRCe+awiJD4WfI850gKIre/iNHGOdvT8cSUZgJ+luoAkEQWXuoZDLIri4sGuk/NzEyasHvmaiV5h5QZwpvdmHrmdIPUBwWsCSMHM0RVdFIZDcqR9yrbyE3Qc+WKkfxhtecPGi7ACuWrjsA6xWtXTyctzTWt6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037750; c=relaxed/simple;
	bh=9JR/luG7t5T3jOUPOePLWiqmKbhtO9ZuNt63a7+o1js=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=maxbyeithGO6T3ENrBxmfARjxSQ1YgTRq+UtjYP21n1Up/68qXBy7YDOKAu7EmGcKMR1iywXNhUrQ/XCsXr6Ee4bi3Nv5R4S1hVhZMhpghQM2rjPLLM6LrfU60wqP4qO1XzK5twF3zflYBJUbrwNfZV/YbT5bGjbFDRJoOuXb7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ldNp+pKS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2GLc07W/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610164026.619295826@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718037747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=eV59jzwlnvMqC78q7RxRP7GMuITiFT7fNLVqSGWWbAc=;
	b=ldNp+pKSOjumUCc8JiN09WC9SCJGBNvPHmdVuJkrjKTZ205Vxbw9jINxVKQDaDo/DVLYyC
	tlRCWB/bmfjl0YG6fX00qwHpJNeiQ/aXfkFeGE7WxSJ5hMNmqQIRC+PWtL5fy3keHidbla
	W/r1wZoU9JeGQTrj0O7xHKLQZR6K4Xybi0p3pJdaRAkl0j7LNTacxEAcRgBJCW+C6BSsHn
	17VUiJ1j/U5o6BgjZYA/fPdAUftqKrn4njhYGbp7syh+7nBb2wa+mIfXf/Lb1xJti6gOLv
	w7mJpSwO6IbaNIRTpQ/dqqb/EHeTElfew0Uza6aD0RJrrpTg85UexqzwDRXcSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718037747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=eV59jzwlnvMqC78q7RxRP7GMuITiFT7fNLVqSGWWbAc=;
	b=2GLc07W/haNWaKkQr+LzbL5SFJJECVc4lWKuJ82Db0yOT9HZ2AWpQWHmqCwJ/codG8V0nv
	KJ8fz0cNiT+7/XCg==
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
Subject: [patch V3 18/51] posix-timers: Clear overrun in common_timer_set()
References: <20240610163452.591699700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 18:42:27 +0200 (CEST)

Keeping the overrun count of the previous setup around is just wrong. The
new setting has nothing to do with the previous one and has to start from a
clean slate.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/posix-timers.c |    1 +
 1 file changed, 1 insertion(+)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -881,6 +881,7 @@ int common_timer_set(struct k_itimer *ti
 	timr->it_requeue_pending = (timr->it_requeue_pending + 2) &
 		~REQUEUE_PENDING;
 	timr->it_overrun_last = 0;
+	timr->it_overrun = -1LL;
 
 	/* Switch off the timer when it_value is zero */
 	if (!new_setting->it_value.tv_sec && !new_setting->it_value.tv_nsec)


