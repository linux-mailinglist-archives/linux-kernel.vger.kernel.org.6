Return-Path: <linux-kernel+bounces-187575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B62E38CD48C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4299C1F22728
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6108A14AD2C;
	Thu, 23 May 2024 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8We9XTv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CC713BAE2
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470734; cv=none; b=h6RyNfva8vM1ZBrOkO16ptM/zykg2I0U3o+rNS3TenBnNjM6oyb53JCHu628cGst4gxVW/879/XmvrgH637zpwoL551qxcm5KV836RSsRR9ZqiycdXRjQIv30RphbhmT8qPEScU3R1xwGLFvR2K/LDpMrTCG/oCB4deJ18gcGZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470734; c=relaxed/simple;
	bh=p6xEboA4juve6QH4jxo+Pk4DmhsXMjwBg2oQJLkI1jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWW/spWZ480XHR6FK6SirCyP7pVTsBBS3iA8MCwmaN/yZEBdQjMBXMuWrVxzXnpin6BIDx2BxACURFpNosay2rAubEAyFTB7ZEhdOkyzlYGBDraL/HIOB7QS2jc+1/5yTR0SIcte2Dgf6xCTZRawnk/U64Dth5/CknXD36sFOfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T8We9XTv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716470732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5NqJdtUQ+TL9F/j4u/bCfZrmv1CaqcNgn4wLGAF0cI8=;
	b=T8We9XTvz3CzCS1m2iluxPcfs6LaZPmnEkCWGf/HUpfrNtyv5VE4xdnfzDFWjoZI9/rsBD
	kZYMO8Eh99kNGmcaABLWXF6Eu0W+vLXoIW89dFSOrZbk1Gu3gJBPdEjsLs4WLbYtT2YE60
	q7oTBUOck3Yg2NM8aRMOYBMXsWR5mQ4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-376-V317WFQ9PCK_bhfAEj22LA-1; Thu,
 23 May 2024 09:25:28 -0400
X-MC-Unique: V317WFQ9PCK_bhfAEj22LA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DA28A3801EC4;
	Thu, 23 May 2024 13:25:27 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.7])
	by smtp.corp.redhat.com (Postfix) with SMTP id E5084491034;
	Thu, 23 May 2024 13:25:25 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 23 May 2024 15:24:00 +0200 (CEST)
Date: Thu, 23 May 2024 15:23:58 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Chris von Recklinghausen <crecklin@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: sched/isolation: tick_take_do_timer_from_boot() calls
 smp_call_function_single() with irqs disabled
Message-ID: <20240523132358.GA1965@redhat.com>
References: <20240522151742.GA10400@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522151742.GA10400@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 05/22, Oleg Nesterov wrote:
>
> After the recent comment 5097cbcb38e6 ("sched/isolation: Prevent boot crash
> when the boot CPU is nohz_full") the kernel no longer crashes, but there is
> another problem.
>
> In this case tick_setup_device() does tick_take_do_timer_from_boot() to
> update tick_do_timer_cpu and this triggers WARN_ON_ONCE(irqs_disabled())
> in smp_call_function_single().
>
> I don't understand this code even remotely, I failed to find the fix.
>
> Perhaps we can use smp_call_function_single_async() as a workaround ?
>
> But I don't even understand why exactly we need smp_call_function()...

..

> Race with tick_nohz_stop_tick() on boot CPU which can set
> tick_do_timer_cpu = TICK_DO_TIMER_NONE? Is it really bad?

And is it supposed to happen if tick_nohz_full_running ?

tick_sched_do_timer() and can_stop_idle_tick() claim that
TICK_DO_TIMER_NONE is not possible in this case...

So, once again, could you explain why the patch below is wrong?

Oleg.
---

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index d88b13076b79..907b44d8cf1f 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -178,26 +178,6 @@ void tick_setup_periodic(struct clock_event_device *dev, int broadcast)
 	}
 }
 
-#ifdef CONFIG_NO_HZ_FULL
-static void giveup_do_timer(void *info)
-{
-	int cpu = *(unsigned int *)info;
-
-	WARN_ON(tick_do_timer_cpu != smp_processor_id());
-
-	tick_do_timer_cpu = cpu;
-}
-
-static void tick_take_do_timer_from_boot(void)
-{
-	int cpu = smp_processor_id();
-	int from = tick_do_timer_boot_cpu;
-
-	if (from >= 0 && from != cpu)
-		smp_call_function_single(from, giveup_do_timer, &cpu, 1);
-}
-#endif
-
 /*
  * Setup the tick device
  */
@@ -231,9 +211,8 @@ static void tick_setup_device(struct tick_device *td,
 
 		} else if (tick_do_timer_boot_cpu != -1 &&
 						!tick_nohz_full_cpu(cpu)) {
-			tick_take_do_timer_from_boot();
 			tick_do_timer_boot_cpu = -1;
-			WARN_ON(READ_ONCE(tick_do_timer_cpu) != cpu);
+			WRITE_ONCE(tick_do_timer_cpu, cpu);
 #endif
 		}
 
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 71a792cd8936..3b1d011d45e1 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1014,6 +1014,9 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	 */
 	tick_cpu = READ_ONCE(tick_do_timer_cpu);
 	if (tick_cpu == cpu) {
+#ifdef CONFIG_NO_HZ_FULL
+		WARN_ON_ONCE(tick_nohz_full_running);
+#endif
 		WRITE_ONCE(tick_do_timer_cpu, TICK_DO_TIMER_NONE);
 		tick_sched_flag_set(ts, TS_FLAG_DO_TIMER_LAST);
 	} else if (tick_cpu != TICK_DO_TIMER_NONE) {


