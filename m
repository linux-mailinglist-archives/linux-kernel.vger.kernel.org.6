Return-Path: <linux-kernel+bounces-557596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A033A5DB59
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D62B33A849C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009F423F407;
	Wed, 12 Mar 2025 11:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i9MesHfa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C7YRj9pd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BEC23F289
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 11:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778698; cv=none; b=gHzBE9xcm5oNTjasfsnUw1iOQPC2c1eY2G13FevcgEKTh7bEeshrNyi/uRS6qSRS1/R3gyd4aL0LbhTa2Orv3ZbsCYcTZA84oaFb1DkR/RjSYTSib1Yb1IrlDN28XZrAJb6p7EoqqLEWPHY28dtpZLF2yCB8NH6ZoNT6ZBH5pyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778698; c=relaxed/simple;
	bh=jvVvf9lmAWqqcfy/yoPzj0oQxMDvWeUK94f+pQiwKyk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o4Ot4VPBAyIz3qsTZh1A8IQQZNV+JAVzzdJlj3S+P24mPB+tkoUGUJdx3dyk4WmIUDBvt4g7zp5jL5TyCoz/JgAtHhcqZOb6vu8+6P1lGzmeKf8eIJACI98g/yZBuqB1naB4V3LupEYNQD0M7RqBrtfqMtXr8wR4XFBzdsCRCmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i9MesHfa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C7YRj9pd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741778695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sWKpskQPjhCZutWc6OXz/+ZuVriZFdt1mzefqC2FGQ8=;
	b=i9MesHfasV9uOwZ/EYOQqMxOhmxeA6bb3e+v2lF7ESGROwBQ6CrHObp0mLJyheoY3Y1x7Q
	0dYxPWBysEQehXfwNX3WkCYpSmCfcSuglT2K+lFxrLtOH4iN911K5h/7UwFRX3MeP8sdVs
	JVqO3H0Czs9ixJgqWib+ZROPFneKDirG4Th6MlpYKQnAUwgI4hmEV13AUKVXHSWOAmyrkY
	gz/zoQA3j88hse0xG1vIPPg01f3KJrCZeksqaNr6IJhuOQNeNaZhWabNYA/M+IqoEVrrhY
	sUECE/assyYJpIcb7PWLwp93Zq5e53XzF7dn3a85S3P3RXeK0YoYzCabaJcBbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741778695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sWKpskQPjhCZutWc6OXz/+ZuVriZFdt1mzefqC2FGQ8=;
	b=C7YRj9pddMG4KvXqv1k7nFwBNZpKAdYe0Qz9LHxgYcj90XgAaov+R4hvxgmkJgp/8f3+OC
	XEZH5jnEf+REKfDw==
To: Cyrill Gorcunov <gorcunov@gmail.com>, Frederic Weisbecker
 <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Benjamin Segall <bsegall@google.com>, Eric
 Dumazet <edumazet@google.com>, Andrey Vagin <avagin@openvz.org>, Pavel
 Tikhomirov <ptikhomirov@virtuozzo.com>, Peter Zijlstra
 <peterz@infradead.org>
Subject: Re: [patch V3a 17/18] posix-timers: Provide a mechanism to allocate
 a given timer ID
In-Reply-To: <Z9E-L1pvl1j_4E3f@grain>
References: <20250308155501.391430556@linutronix.de>
 <20250308155624.526740902@linutronix.de> <Z9CsstMf-EVZpsiH@pavilion.home>
 <87msdrz0i9.ffs@tglx> <87jz8vz0en.ffs@tglx>
 <Z9C6GpaB9WvNzvJS@pavilion.home> <Z9E-L1pvl1j_4E3f@grain>
Date: Wed, 12 Mar 2025 12:24:54 +0100
Message-ID: <87bju6ze2h.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Mar 12 2025 at 10:56, Cyrill Gorcunov wrote:
> On Tue, Mar 11, 2025 at 11:32:58PM +0100, Frederic Weisbecker wrote:
> ...
>> > 
>> > Recreating two timers with IDs 1000000 and 2000000 takes 1.5 seconds with
>> > the create/delete method. With the prctl() it takes 3 microseconds.
>> > 
>> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> 
>> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
>
> One thing which just popped up in my head -- this interface may be used not
> only by criu but any application which wants to create timer with specified
> id (hell know why, but whatever). As far as I understand we don't provide

Sure. Application developers are creative :)

> an interface to _read_ this property, don't we? Thus criu will restore such
> application which already has this bit set incorrectly.

Delta patch below.

Thanks,

        tglx
---
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -362,5 +362,6 @@ struct prctl_mm_map {
 #define PR_TIMER_CREATE_RESTORE_IDS		77
 # define PR_TIMER_CREATE_RESTORE_IDS_OFF	0
 # define PR_TIMER_CREATE_RESTORE_IDS_ON		1
+# define PR_TIMER_CREATE_RESTORE_IDS_GET	2
 
 #endif /* _LINUX_PRCTL_H */
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -391,11 +391,17 @@ static enum hrtimer_restart posix_timer_
 
 long posixtimer_create_prctl(unsigned long ctrl)
 {
-	if (ctrl > PR_TIMER_CREATE_RESTORE_IDS_ON)
-		return -EINVAL;
-
-	current->signal->timer_create_restore_ids = ctrl == PR_TIMER_CREATE_RESTORE_IDS_ON;
-	return 0;
+	switch (ctrl) {
+	case PR_TIMER_CREATE_RESTORE_IDS_OFF:
+		current->signal->timer_create_restore_ids = 0;
+		return 0;
+	case PR_TIMER_CREATE_RESTORE_IDS_ON:
+		current->signal->timer_create_restore_ids = 0;
+		return 0;
+	case PR_TIMER_CREATE_RESTORE_IDS_GET:
+		return current->signal->timer_create_restore_ids;
+	}
+	return -EINVAL;
 }
 
 static struct pid *good_sigevent(sigevent_t * event)

