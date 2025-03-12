Return-Path: <linux-kernel+bounces-557617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CC0A5DB9A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731341759F9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCA023BCE3;
	Wed, 12 Mar 2025 11:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JRG1JFYr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+yix1T5x"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2E523F388
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 11:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741779087; cv=none; b=pta2q1Afvp3xb7RGNzIsA5Mcee4d7mOQ2epnKqqBGEep/IiiIlOEtRxXwNXnuXROaEX+Cyq61//Pto5ux4/pf4QVwvKIXJ5eVRsq1KvY0TVRo9064MO/+6d/QftyInZyq+HA0GwBGs2/MJJPS2fKBqnUj2MmyuKfF0LZIeNM+GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741779087; c=relaxed/simple;
	bh=3W5zLrokTuNQWbuE6+GbPwOzO+pJOJsiXUtk+9ZI988=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qh8iZ7me31wZS0CDNRlY4Vg4nZihKEpY5Y7c8EsumpfDhgzM9VL+3g/pJb4DWuRBdezCpnz7Nk5ccDYKo26Ru4oIRBowzmLzo5//m5YF2UTXDXLRlTVvIJodF66h9O1lESnFoJ8aZwrcMsQGTPJkN5ZbjhHeIO7DJR1bAx7qsmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JRG1JFYr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+yix1T5x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741779083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W5VWvV9fT1z29V/8mY2DQjdSa2dKKjrvKSnEzIb0JHI=;
	b=JRG1JFYrgwingmPakbX+fv8JYq+rxJK0U9ne5e01xpoQiNTYO0oDuWYEdJJkP7i7ITKdOS
	Obsa0BQYadLjF64gA0+ebuC8oxULQMr2EB/Thf22F250s5DJFjZjRvErnhZahGwmttzmZF
	liNqpQbQS90esIuVWjLjjJFtRg+udp4s0oG/LAmFwNvcCxcsTa8NbQfi0nevUWcnPMmhf5
	boUieloVdMt78VmoY8C/kFklATtoF/nvr4XyKSgZvUn3+bciAYV7I/wuTV8N8uzEJObSHO
	q23xE06sUXciJsj9c/dwwq9h/0gkz5JOARhdHex0Lw2fbeImOR5AZpD06xE2og==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741779083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W5VWvV9fT1z29V/8mY2DQjdSa2dKKjrvKSnEzIb0JHI=;
	b=+yix1T5xTQxEQys5iIQXGuaWj3xaDczXCRQJSucYQ4HY4tvIrQmgFLc2/fe+3MuSs7x1fz
	rcMLcv3Nf9LR+MDw==
To: Cyrill Gorcunov <gorcunov@gmail.com>, Frederic Weisbecker
 <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Benjamin Segall <bsegall@google.com>, Eric
 Dumazet <edumazet@google.com>, Andrey Vagin <avagin@openvz.org>, Pavel
 Tikhomirov <ptikhomirov@virtuozzo.com>, Peter Zijlstra
 <peterz@infradead.org>
Subject: Re: [patch V3a 17/18] posix-timers: Provide a mechanism to allocate
 a given timer ID
In-Reply-To: <87bju6ze2h.ffs@tglx>
References: <20250308155501.391430556@linutronix.de>
 <20250308155624.526740902@linutronix.de> <Z9CsstMf-EVZpsiH@pavilion.home>
 <87msdrz0i9.ffs@tglx> <87jz8vz0en.ffs@tglx>
 <Z9C6GpaB9WvNzvJS@pavilion.home> <Z9E-L1pvl1j_4E3f@grain>
 <87bju6ze2h.ffs@tglx>
Date: Wed, 12 Mar 2025 12:31:23 +0100
Message-ID: <878qpazdro.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Mar 12 2025 at 12:24, Thomas Gleixner wrote:
> On Wed, Mar 12 2025 at 10:56, Cyrill Gorcunov wrote:
>> an interface to _read_ this property, don't we? Thus criu will restore such
>> application which already has this bit set incorrectly.
>
> Delta patch below.

That want's a fixup for the selftest too.

---
diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index 158138211f51..f0eceb0faf34 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -616,6 +616,7 @@ static int do_timer_delete(int id)
 # define PR_TIMER_CREATE_RESTORE_IDS		77
 # define PR_TIMER_CREATE_RESTORE_IDS_OFF	 0
 # define PR_TIMER_CREATE_RESTORE_IDS_ON		 1
+# define PR_TIMER_CREATE_RESTORE_IDS_GET	 2
 #endif
 
 static void check_timer_create_exact(void)
@@ -633,6 +634,9 @@ static void check_timer_create_exact(void)
 		}
 	}
 
+	if (prctl(PR_TIMER_CREATE_RESTORE_IDS, PR_TIMER_CREATE_RESTORE_IDS_GET, 0, 0, 0) != 1)
+		fatal_error(NULL, "prctl(GET) failed\n");
+
 	id = 8;
 	if (do_timer_create(&id) < 0)
 		fatal_error(NULL, "timer_create()");
@@ -641,7 +645,10 @@ static void check_timer_create_exact(void)
 		fatal_error(NULL, "timer_delete()");
 
 	if (prctl(PR_TIMER_CREATE_RESTORE_IDS, PR_TIMER_CREATE_RESTORE_IDS_OFF, 0, 0, 0))
-		fatal_error(NULL, "prctl()");
+		fatal_error(NULL, "prctl(OFF)");
+
+	if (prctl(PR_TIMER_CREATE_RESTORE_IDS, PR_TIMER_CREATE_RESTORE_IDS_GET, 0, 0, 0) != 0)
+		fatal_error(NULL, "prctl(GET) failed\n");
 
 	if (id != 8) {
 		ksft_test_result_fail("check timer create exact %d != 8\n", id);

