Return-Path: <linux-kernel+bounces-388289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1744E9B5D3C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 08:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48EBF1C20E8A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 07:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD051DFE3F;
	Wed, 30 Oct 2024 07:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zvlUhmHy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k3jE8dKD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AA51D6194
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 07:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730274836; cv=none; b=TV7iagShwswovqKlRA8KYO6KVJOOYnxHsMGCforO9pV1j0r6hgjz2DEMEO7MdG+p/UgnddOjeJGqMfRpzegExF43e9Gs37xaYDuUGMy2ceUtexPSF3tNoShHWVxVJabWpz7mo9UOVz4Muw+cIVVkAQ3+1ZbSYfVJmrD/l7h/AIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730274836; c=relaxed/simple;
	bh=8P7ZCe1IEzzHbjJkryj6fiDJvxxL2p5Se3zfdO1sF2k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bmlG6iPgrJEmCE0/dxJcKA/YaZhEJwoJ7R1sHu3LkjnwLPdcZhb92ENq6hGry20e6zYtxKGc/CHnptkJHL7ftaDCOip1aUfZrwnvofbnR/D0AwR4S99Dv8hoa/P5FdTURue+g5bftF91WN7CVuwgK7DdF87ZhdCcgOoFyVnDVzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zvlUhmHy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k3jE8dKD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730274832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dp2kidU3DMg9NIXYa3nRFRS2kQiKFScOIofbBFZfLzU=;
	b=zvlUhmHyrOadULkRxRZ9T6kLuWzZTTwa9PDx+Y75D8SZR2SXsBauf45HWu7YN/pZnQX92U
	AuF6abPiXZCiBVGX3Uv4VLD1X0AKiA9ZLdl7NQcXP61FWy+9mY83QOfz0pMkzjoHgQ3Iv7
	GwyohjC8LGPz4BbWN3C7ubYF1vJt0b6ziB557fCpVtfHzsme67nRO/1cBinTJShackbaSk
	MxA8PtcdRSRjE04+zdLcrfC78YdwwWW+MCa0dbRNIcDtvNWPb/cMAOlt8ciFCSy6qMc4e3
	NV2pBwhnusRdDvqwdhGA3EOxRpz6Soqg1L49qVvYHrAkvHiah/6Z5KyV16kjEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730274832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dp2kidU3DMg9NIXYa3nRFRS2kQiKFScOIofbBFZfLzU=;
	b=k3jE8dKDnRlQzGzs+/8kvb8/4yAMVBdh5VsAyQMgOaGe2ClJUIeECNp3hYWSZQHYDdmqey
	4IlZfSG7vMIwFBBw==
To: kernel test robot <oliver.sang@intel.com>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Frederic Weisbecker <frederic@kernel.org>, oliver.sang@intel.com
Subject: timers: Add missing READ_ONCE() in __run_timer_base()
In-Reply-To: <202410301205.ef8e9743-lkp@intel.com>
References: <202410301205.ef8e9743-lkp@intel.com>
Date: Wed, 30 Oct 2024 08:53:51 +0100
Message-ID: <87a5emyqk0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

__run_timer_base() checks base::next_expiry without holding
base::lock. That can race with a remote CPU updating next_expiry under the
lock. This is an intentional and harmless data race, but lacks a
READ_ONCE(), so KCSAN complains about this.

Add the missing READ_ONCE(). All other places are covered already.

Fixes: 79f8b28e85f8 ("timers: Annotate possible non critical data race of next_expiry")
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Closes: https://lore.kernel.org/oe-lkp/202410301205.ef8e9743-lkp@intel.com
---
 kernel/time/timer.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2422,7 +2422,8 @@ static inline void __run_timers(struct t
 
 static void __run_timer_base(struct timer_base *base)
 {
-	if (time_before(jiffies, base->next_expiry))
+	/* Can race against a remote CPU updating next_expiry under the lock */
+	if (time_before(jiffies, READ_ONCE(base->next_expiry)))
 		return;
 
 	timer_base_lock_expiry(base);

