Return-Path: <linux-kernel+bounces-394995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C6D9BB6E9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8959E282787
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82501C07FB;
	Mon,  4 Nov 2024 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UAHqTMAv"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEE41AA7BE
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730728616; cv=none; b=BgKhgVpKWyE7g532MkS/jbqJrWCZwDUScOq/Pm9gz1NfeMwtP33H6B5RjS1EYyYWpanMHS9slUmO75O/BitsXBqLtyEuV/B61M2ySCTzW2xV3xPqkDxSPNVGk2L7MMl5OlHO6XqafpfSu1kr1eKdhThI0m14PCuZU8LPGFQRo1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730728616; c=relaxed/simple;
	bh=Jg3DcZIhGCn3B8tSKU0kR0jjs+dSxc6oENL0fGQxZLo=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Tv/exq1j5XouQ1UsEg9TM383BFzpWf8ciZ31RzIGfvyL6N0jZ3oI2KphdbN/Sw93aLcV+0i1+hdtMiNNCV31MtRzb0MhkMc7/ZFgS7Tu5cqfwkV/Kiaw0+UfYPl30RUQMZ9E8y0Bu8dYT1uWEjLApkqtRij9AczAXcdcuErtGZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UAHqTMAv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=kUhiJD3P7IjdGIOXdpnyhytdNUFcJ2ex83g8P9LcqBc=; b=UAHqTMAvUg1J5cdfzP8O5O0bL0
	HsyE/bwac0WK92PNoQxte0Wo55SESCWgrcq3zgHFYCWqdh0hqsejozQY+80MGN7q38ZOj2ls3xriP
	uE9UeE9+0TjkmNhKlbuB3hDCjgv+VoSP6KzPi4suLdZRnyCa8pWNL0kL9gmzrrrhNl2T2o6AGoESt
	X2rAdPJis1oKgRr/4Kj1gwmUujVgpdkig3r0JieHXVYQulvHcie1usl28KoeCfrKHMVawh5UX7hW6
	F28Cbd7NI0avhz0wpr2Jostv6bkRec0VHtkqIlh0wK7ih0idVRXubmxUn0NwRZ+RQYhV9judjdQ4w
	RAR+TeFA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7xZX-00000001EDz-3Sh4;
	Mon, 04 Nov 2024 13:56:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 940F3308D9D; Mon,  4 Nov 2024 14:56:46 +0100 (CET)
Message-Id: <20241104135519.354909594@infradead.org>
User-Agent: quilt/0.65
Date: Mon, 04 Nov 2024 14:39:25 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org,
 lucas.demarchi@intel.com
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 willy@infradead.org,
 acme@kernel.org,
 namhyung@kernel.org,
 mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com,
 jolsa@kernel.org,
 irogers@google.com,
 adrian.hunter@intel.com,
 kan.liang@linux.intel.com
Subject: [PATCH 16/19] perf: Further simplify perf_mmap()
References: <20241104133909.669111662@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6644,9 +6644,18 @@ static int perf_mmap(struct file *file,
 		return ret;
 
 	vma_size = vma->vm_end - vma->vm_start;
+	nr_pages = vma_size / PAGE_SIZE;
+
+	if (nr_pages > INT_MAX)
+		return -ENOMEM;
+
+	if (vma_size != PAGE_SIZE * nr_pages)
+		return -EINVAL;
+
+	user_extra = nr_pages;
 
 	if (vma->vm_pgoff == 0) {
-		nr_pages = (vma_size / PAGE_SIZE) - 1;
+		nr_pages -= 1;
 
 		/*
 		 * If we have rb pages ensure they're a power-of-two number, so we
@@ -6655,9 +6664,6 @@ static int perf_mmap(struct file *file,
 		if (nr_pages != 0 && !is_power_of_2(nr_pages))
 			return -EINVAL;
 
-		if (vma_size != PAGE_SIZE * (1 + nr_pages))
-			return -EINVAL;
-
 		WARN_ON_ONCE(event->ctx->parent_ctx);
 again:
 		mutex_lock(&event->mmap_mutex);
@@ -6679,8 +6685,6 @@ static int perf_mmap(struct file *file,
 
 			goto unlock;
 		}
-
-		user_extra = nr_pages + 1;
 	} else {
 		/*
 		 * AUX area mapping: if rb->aux_nr_pages != 0, it's already
@@ -6692,10 +6696,6 @@ static int perf_mmap(struct file *file,
 		if (!event->rb)
 			return -EINVAL;
 
-		nr_pages = vma_size / PAGE_SIZE;
-		if (nr_pages > INT_MAX)
-			return -ENOMEM;
-
 		mutex_lock(&event->mmap_mutex);
 		ret = -EINVAL;
 
@@ -6739,7 +6739,6 @@ static int perf_mmap(struct file *file,
 		}
 
 		atomic_set(&rb->aux_mmap_count, 1);
-		user_extra = nr_pages;
 	}
 
 	user_lock_limit = sysctl_perf_event_mlock >> (PAGE_SHIFT - 10);



