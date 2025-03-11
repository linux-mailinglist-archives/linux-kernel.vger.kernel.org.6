Return-Path: <linux-kernel+bounces-555891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97ABCA5BDEE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE4AF167F60
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5871ABA34;
	Tue, 11 Mar 2025 10:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rsScHTqU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LHgr+oik"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCA42206BD
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741689228; cv=none; b=djH7lANYmeVZ4NL5pi1HWsZg2UID9PMokVTdggsH2aEaQyVw5Fdk2/WBNY55b6tAqDlcsTLv9OQOl86satIJZQMCvo3upKh8S7NzzfFvRG5lUogrtonA6frY4CHISTP4qcxUFLaAEnWOwnZZIP03J+PP4w6Zapsy7gYPbaYlaAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741689228; c=relaxed/simple;
	bh=6iaKIcDcLtBUnfZj2ssz1Js32CswNScfI7rteqtVNFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHtsaIXiElMN7YI1ZWcRUoprzVQ7dHcRRjNVoEENn3szLHDrwqXwJDb7wzP1pi+/mBaANOihYcOqjhgto8kKyG3nLeUbT0Qw22JT1T58HdaWgJXUu/fqFlHlYLKSpzuRGoz3pZIjCDcmAQP3RD22a3KgJzFVvk/h2Xdd5XuoKRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rsScHTqU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LHgr+oik; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Mar 2025 11:33:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741689224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4W141gGFDKRnvx/vpB6B0h5KnkN4GxkpTzCHnQ55P/o=;
	b=rsScHTqUol5pxURgpdql1VNW5WgOyOcYtqJtJIa7Zh2K5CHLRJd5BKhptpjv2y4g5bPxIk
	h+siEFiVTSNbBZRTLc4PToEjoJl6O+ZED5u5dEc1NeQAoLmPR/CKx/KT2aY570cbrqufNm
	Sj2RiiPUWapr+NRuG1LCFkAs90hjRk73Wd9pyPpiWLbgW5lqB5i0yO1bzqin1HwKPc/nyF
	UxGYEgNwHpdkCD6S1/mmk9IhVVE4ZDX3MmEVNtiswuXBdIRgH0xqYmsRQ/hfo2AxYvUHZw
	0wUkC5D10FzcklguUgy3GTUO11M16y+iwxVHgI1ak1YW2EW2IVAFJ9qVJk29/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741689224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4W141gGFDKRnvx/vpB6B0h5KnkN4GxkpTzCHnQ55P/o=;
	b=LHgr+oikYoChRaIeyP99LgfXxN7fYELHK68tfVTcAphjOKL7r8KIbmA3Qs2Y4f5XX+eP8B
	x42dQ40jVhA40WDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v9 00/11] futex: Add support task local hash maps.
Message-ID: <20250311103343.zCFqALMD@linutronix.de>
References: <20250225170914.289358-1-bigeasy@linutronix.de>
 <20250303105416.GY11590@noisy.programming.kicks-ass.net>
 <20250303141753.tF-FoCm1@linutronix.de>
 <20250303164015.HHfy1Ibj@linutronix.de>
 <20250304145837.a8g07J-k@linutronix.de>
 <20250305090237.2Q9GwRA1@linutronix.de>
 <20250310160102.GG19344@noisy.programming.kicks-ass.net>
 <20250310162710.K9WY5tzN@linutronix.de>
 <20250311101714.GC19424@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250311101714.GC19424@noisy.programming.kicks-ass.net>

On 2025-03-11 11:17:14 [+0100], Peter Zijlstra wrote:
> Right, so I failed to understand initially. When DEAD it stays 0, but
> there is indeed the one case where it isn't yet DEAD but still returns
> 0.
> 
> Making the DEAD return -1 seems like a good solution.

The patch below is what I have/ tglx asked for. I intend to use it the
series and repost it once I fixed it up.

-------------->8--------------

Subject: [PATCH] rcuref: Provide rcuref_is_dead().

rcuref_read() returns the number of references that are currently held.
If 0 is returned then it is not safe to assume that the object ca be
scheduled for deconstruction because it is marked DEAD. This happens if
the return value of rcuref_put() is ignored and assumptions are made.

If 0 is returned then the counter transitioned from 0 to RCUREF_NOREF.
If rcuref_put() did not return to the caller then the counter did not
yet transition from RCUREF_NOREF to RCUREF_DEAD. This means that there
is still a chance that the counter counter will transition from
RCUREF_NOREF to 0 meaning it is still valid and must not be
deconstructed. In this brief window rcuref_read() will return 0.

Provide rcuref_is_dead() to determine if the counter is marked as
RCUREF_DEAD.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/rcuref.h | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/linux/rcuref.h b/include/linux/rcuref.h
index 6322d8c1c6b42..2fb2af6d98249 100644
--- a/include/linux/rcuref.h
+++ b/include/linux/rcuref.h
@@ -30,7 +30,11 @@ static inline void rcuref_init(rcuref_t *ref, unsigned int cnt)
  * rcuref_read - Read the number of held reference counts of a rcuref
  * @ref:	Pointer to the reference count
  *
- * Return: The number of held references (0 ... N)
+ * Return: The number of held references (0 ... N). The value 0 does not
+ * indicate that it is safe to schedule the object, protected by this reference
+ * counter, for deconstruction.
+ * If you want to know if the reference counter has been marked DEAD (as
+ * signaled by rcuref_put()) please use rcuread_is_dead().
  */
 static inline unsigned int rcuref_read(rcuref_t *ref)
 {
@@ -40,6 +44,22 @@ static inline unsigned int rcuref_read(rcuref_t *ref)
 	return c >= RCUREF_RELEASED ? 0 : c + 1;
 }
 
+/**
+ * rcuref_is_dead -	Check if the rcuref has been already marked dead
+ * @ref:		Pointer to the reference count
+ *
+ * Return: True if the object has been marked DEAD. This signals that a previous
+ * invocation of rcuref_put() returned true on this reference counter meaning
+ * the protected object can safely be scheduled for deconstruction.
+ * Otherwise, returns false.
+ */
+static inline bool rcuref_is_dead(rcuref_t *ref)
+{
+	unsigned int c = atomic_read(&ref->refcnt);
+
+	return (c >= RCUREF_RELEASED) && (c < RCUREF_NOREF);
+}
+
 extern __must_check bool rcuref_get_slowpath(rcuref_t *ref);
 
 /**
-- 
2.47.2


