Return-Path: <linux-kernel+bounces-324221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA2597499B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02343B24D7B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 05:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124827DA9E;
	Wed, 11 Sep 2024 05:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UiR2NcsA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rnjh4EVK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFE613AA27
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 05:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726031640; cv=none; b=kHPj675uEqgBZDWzcMpI0fOU5PWW6oDPsz3pLOCibO947cvvI/pWMZAcTbuFh6omKvLiiKK+lAZezQoQHf6mQ9AoXXJIYy+S6LWylnqnhcFK/AJMU02kevI+uUV5Ni4JZDO6GnzGW/Fn2ZiX0R2LvUkHZuefT1QrUVdW6ppChEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726031640; c=relaxed/simple;
	bh=EpnYZjgt9MQ9cFJx0dkRuPLx78ce3vuzPvPVRnnX8nk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c28osNiS+/DJzQJndyaKGAv/Ht0Vo6z9cSv04tlZ+3b4qIC+xcUuGdTPj4jM7+ghTSfGnilgGmofm+YbfrkwJaYyGTAjvn4PAk36nja4RtnDaT3r23fgfGDd7XiqiwWrMayopfW5Or8RWQc76ECj0dcAYF05OrhYWVVD5NVwVEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UiR2NcsA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rnjh4EVK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726031635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYHTnWg90GO/Adzm/xlNmVzdNdsY7txrgGU6OMGh5ag=;
	b=UiR2NcsAC9i4ZW/0yyfeerjtAB84C6rxBP2AjJVghd8Zc693ibg0t0LPO124a/gcvvy1jT
	cyvc7nAZO/r7Q1P9n7Az6s9X3LcCho5bRI78pKX454ysg4y40GcE6ot9vfcAcFsOMUKWBu
	l+tyUqRBZhBr9fGWBpRQIWJh19Rt7e4+LdWtLn/E6nCOZPw0wHDnHIIXmwC5nPxMg4e04o
	QposPh3H05412DmD3/6zKTCN22un+RbJIB25KF3mojgSZtQsDn0SM4Y7asD3X7/6+27Qew
	r+IbqEd79alZ3uJPVvLLR08KqnBM1xAUWTkjNgWphUHgdrL9UqfYgktI0fVNmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726031635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYHTnWg90GO/Adzm/xlNmVzdNdsY7txrgGU6OMGh5ag=;
	b=Rnjh4EVKzBewiHVfpCXtDI+g14W3w20GvMd+olwoEufskS5lpV/SML3o+WmsePJPn74JmH
	aZ6OOfeBk4eyPSBw==
Date: Wed, 11 Sep 2024 07:13:39 +0200
Subject: [PATCH v2 13/15] powerpc/rtas: Use fsleep() to minimize additional
 sleep duration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-flseep-v2-13-b0d3f33ccfe0@linutronix.de>
References: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nathan Lynch <nathanl@linux.ibm.com>, 
 linuxppc-dev@lists.ozlabs.org

When commit 38f7b7067dae ("powerpc/rtas: rtas_busy_delay() improvements")
was introduced, documentation about proper usage of sleep realted functions
was outdated.

The commit message references the usage of a HZ=100 system. When using a
20ms sleep duration on such a system and therefore using msleep(), the
possible additional slack will be +10ms.

When the system is configured with HZ=100 the granularity of a jiffy and of
a bucket of the lowest timer wheel level is 10ms. To make sure a timer will
not expire early (when queueing of the timer races with an concurrent
update of jiffies), timers are always queued into the next bucket. This is
the reason for the maximal possible slack of 10ms.

fsleep() limits the maximal possible slack to 25% by making threshold
between usleep_range() and msleep() HZ dependent. As soon as the accuracy
of msleep() is sufficient, the less expensive timer list timer based
sleeping function is used instead of the more expensive hrtimer based
usleep_range() function. The udelay() will not be used in this specific
usecase as the lowest sleep length is larger than 1 microsecond.

Use fsleep() directly instead of using an own heuristic for the best
sleeping mechanism to use..

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nathan Lynch <nathanl@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
---
v2: fix typos
---
 arch/powerpc/kernel/rtas.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index f7e86e09c49f..d31c9799cab2 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -1390,21 +1390,14 @@ bool __ref rtas_busy_delay(int status)
 		 */
 		ms = clamp(ms, 1U, 1000U);
 		/*
-		 * The delay hint is an order-of-magnitude suggestion, not
-		 * a minimum. It is fine, possibly even advantageous, for
-		 * us to pause for less time than hinted. For small values,
-		 * use usleep_range() to ensure we don't sleep much longer
-		 * than actually needed.
-		 *
-		 * See Documentation/timers/timers-howto.rst for
-		 * explanation of the threshold used here. In effect we use
-		 * usleep_range() for 9900 and 9901, msleep() for
-		 * 9902-9905.
+		 * The delay hint is an order-of-magnitude suggestion, not a
+		 * minimum. It is fine, possibly even advantageous, for us to
+		 * pause for less time than hinted. To make sure pause time will
+		 * not be way longer than requested independent of HZ
+		 * configuration, use fsleep(). See fsleep() for details of
+		 * used sleeping functions.
 		 */
-		if (ms <= 20)
-			usleep_range(ms * 100, ms * 1000);
-		else
-			msleep(ms);
+		fsleep(ms * 1000);
 		break;
 	case RTAS_BUSY:
 		ret = true;

-- 
2.39.2


