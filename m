Return-Path: <linux-kernel+bounces-354895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F568994433
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C5B1C21B8F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 09:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D714616EBEC;
	Tue,  8 Oct 2024 09:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v2BI2hzE"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ECB16BE2A
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 09:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728379574; cv=none; b=j0P67WE+5SlWgqOwxid1IKqLZdsp3D80T3Kg1VFsI6+Hyz0H2+iVm517pv3JfewkjN6cJtr9cy5dx55oF79D1yiayA4eJjULPKauj3M3MZwqLjYPUkgnSGNX1KCbuRxp5pSI7cfqHk5XbbVuJOMV3fhQvKURxXzLIEE/3nUpyX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728379574; c=relaxed/simple;
	bh=UCiAyBJELT0/hOHzEbMOQejm4e62cbaoJSURzDpcuEI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=onSdJz+gpJt1UF3bQwThXeGSxUkeCmZKfaNE9XtWNu9Abm3OdYxyntFaTrnBnFHHmjTf+N1+3RJ3c6kzXblcqDCEFiWRqgZP0T6H67TXzzhqo1ICZzEkNSevr2OdrdJh2TXEQyjzv0p6PhjDKhRQTBN6wmKBaSTviI8WRRbOPnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=v2BI2hzE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=ZLtA41tPhpwhR+RltyLrklxFfAyNO1T5q6wvq7nrnMc=; b=v2BI2hzEgYj7QdNZRxK502BtTs
	s4c+OjGcM+pRiy6P0XknzUfC7vhvHAYehaKXbe5JX9U8XvBh3OrFpu1RoTGmTc2suN0UCV/tJxHXy
	1rwLc9ShRgd3jdC/edCFdE71HR15cctOLTReew4QcNoBVPTM+YOgs4HL/ilvbvisjQvqyF4fXBEk1
	WERFHcJEXH9aluiGgD/DIJj7HeLET+p6x3LCvrnvIUVxbj80s4/Q624/jtwrF5onjtCIAoqkDd8E+
	k5vgPpFpqOmGk0qevHrAOrDl+4gCu4b5dxpjAFJi5IIcIcY4lJKLX+tMSIZeCS2u4MCJav3COXUoW
	hY5PiQng==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sy6Tm-00000001zPU-3hir;
	Tue, 08 Oct 2024 09:26:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8856A300294; Tue,  8 Oct 2024 11:26:06 +0200 (CEST)
Date: Tue, 8 Oct 2024 11:26:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, will@kernel.org,
	longman@redhat.com, boqun.feng@gmail.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] locking/rtmutex: Fix misleading comment
Message-ID: <20241008092606.GJ33184@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Going through the RCU-boost and rtmutex code, I ran into this utterly
confusing comment. Fix it to avoid confusing future readers.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index a6974d044593..587ede8073c0 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -175,7 +175,7 @@ bool __sched __rt_mutex_futex_unlock(struct rt_mutex_base *lock,
 	}
 
 	/*
-	 * We've already deboosted, mark_wakeup_next_waiter() will
+	 * This will deboost, mark_wakeup_next_waiter() will
 	 * retain preempt_disabled when we drop the wait_lock, to
 	 * avoid inversion prior to the wakeup.  preempt_disable()
 	 * therein pairs with rt_mutex_postunlock().

