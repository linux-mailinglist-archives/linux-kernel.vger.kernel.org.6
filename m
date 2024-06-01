Return-Path: <linux-kernel+bounces-197899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BAB8D7080
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 16:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6FE31F22135
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 14:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E01415252E;
	Sat,  1 Jun 2024 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DJjml7BO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658E3152517
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717253910; cv=none; b=mNgMSa59Y8uuXwVTFSTRXFW/VBCvJuWkBtfvATAS6lObSQ3gFAJY1ohSKca9OW6QEjeLrZvNu/7IwKPVMXGC3fGQgBpFGLVLN6g6Y6LalwkgcOmCrUnulF3+M6HAjcOUigywGJ9cbkxUc1HHuV7o4TMl2UYktVQMAsYZKiz3IP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717253910; c=relaxed/simple;
	bh=Bb+TRFM7V8s/HL0NSgEhXURHtI7QGhUiMMx/7RiChD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0nqC4jpOdnoRE8cmPfgBVxluyhSwPRQW/YKoqtECFVr2/jI4iIJ9FXNv//1Txbj2XwBT3P/3E2X4LorAyDcmmqkHHQVtCaoGs31/P8VB/mLBKftszlvDZ/4TIPE20OewByA4SeD4xA/l6nNrHC3AgrNsX9I8/Lwijb7ltjpnIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DJjml7BO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717253907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/5kPiW5A07zbRtUDxOb8oJ5nBRjGlAJMVIjdfIyLL80=;
	b=DJjml7BOiZfJzufViOXBKi/GWCsFUMGDkID7FohphhZxzcChhJUpuFjXdQ1Q717c4d+GO0
	J5kbhA8Mcrpqe9pofe/IfZNcTAr0oBXpxTp+BZjI05xPonvJ156p5L6kY/xlhXHksWxGeq
	/+A1em05RPL9au8NTMu5ZHnKtF7unWA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-aggDs1gsMgOO7qcp2lduvw-1; Sat, 01 Jun 2024 10:58:22 -0400
X-MC-Unique: aggDs1gsMgOO7qcp2lduvw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A1F1181227E;
	Sat,  1 Jun 2024 14:58:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.19])
	by smtp.corp.redhat.com (Postfix) with SMTP id 4B67640004D;
	Sat,  1 Jun 2024 14:58:20 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat,  1 Jun 2024 16:56:54 +0200 (CEST)
Date: Sat, 1 Jun 2024 16:56:52 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tick: shift tick_nohz_switch_to_nohz() from
 tick_check_oneshot_change() to hrtimer_run_queues()
Message-ID: <20240601145651.GB3758@redhat.com>
References: <20240530124203.GA26990@redhat.com>
 <ZliaSISeFxx_FQ6O@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZliaSISeFxx_FQ6O@localhost.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 05/30, Frederic Weisbecker wrote:
>
> tick_nohz_switch_to_nohz() is only built with CONFIG_NO_HZ_COMMON
>
> You will have a build issue with CONFIG_HIGH_RES_TIMER && !CONFIG_NO_HZ_COMMON

Thanks again.

At first glance this patch needs a simple fixup below. I'll recheck and
send V2.

NO_HZ_COMMON selects TICK_ONESHOT. But even if it didn't,
tick_check_oneshot_change() is dummy inline "return 0" without
CONFIG_TICK_ONESHOT, hrtimer_run_queues() will never try to
call tick_nohz_switch_to_nohz().

Oleg.


--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -112,7 +112,6 @@ static inline bool tick_oneshot_possible(void) { return true; }
 extern int tick_oneshot_mode_active(void);
 extern void tick_clock_notify(void);
 extern int tick_check_oneshot_change(void);
-extern void tick_nohz_switch_to_nohz(void);
 extern int tick_init_highres(void);
 #else /* !CONFIG_TICK_ONESHOT: */
 static inline
@@ -126,7 +125,6 @@ static inline bool tick_oneshot_possible(void) { return false; }
 static inline int tick_oneshot_mode_active(void) { return 0; }
 static inline void tick_clock_notify(void) { }
 static inline int tick_check_oneshot_change(void) { return 0; }
-static inline void tick_nohz_switch_to_nohz(void) { }
 #endif /* !CONFIG_TICK_ONESHOT */
 
 /* Functions related to oneshot broadcasting */
@@ -159,6 +157,7 @@ static inline void tick_nohz_init(void) { }
 #endif
 
 #ifdef CONFIG_NO_HZ_COMMON
+extern void tick_nohz_switch_to_nohz(void);
 extern unsigned long tick_nohz_active;
 extern void timers_update_nohz(void);
 extern u64 get_jiffies_update(unsigned long *basej);
@@ -173,6 +172,7 @@ extern bool timer_base_is_idle(void);
 extern void timer_expire_remote(unsigned int cpu);
 # endif
 #else /* CONFIG_NO_HZ_COMMON */
+static inline void tick_nohz_switch_to_nohz(void) { }
 static inline void timers_update_nohz(void) { }
 #define tick_nohz_active (0)
 #endif


