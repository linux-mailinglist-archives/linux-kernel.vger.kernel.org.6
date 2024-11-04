Return-Path: <linux-kernel+bounces-394986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 674F49BB6E0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0A81F22B14
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073FB1BBBD3;
	Mon,  4 Nov 2024 13:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZSlsxv6h"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A21F1339A4
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730728613; cv=none; b=nVudgaCVexbAio9bjmtklWf/SW+t9LPoHwd4gUmVPV/Zc7w6TGVZJSl1Hf3X1P8uydMHto5wDfyBCAn5V6ApZ7dXlPX1guqWnRs2UszqsIJ0UcA3et3Yy3bg9ILUbWkhJpZlN8zwPd8/kvy+wAp8AjLxBtzG/MhddOfZEHAdRZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730728613; c=relaxed/simple;
	bh=xzWSR31AIiAml0fn32Q7dpMiSKPkqnY4G5VFRR+Dl6Q=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=DiTUapf4K8LqUEAoqs3zJAdUZKfRC5TWwHzOscQLgw0Fkj0bf5P128lAXGqEJBM381eHHtYE+e1G2ZjE79euVxJM9kRsv+LjL8srzxt38k33I/qTSL2k1SPvy2kEPJ8ZQz29hRxAJCMGtaC/wos87d71ksT9Jtifl2SLfHPUCWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZSlsxv6h; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=m/vZ10zVaPFj9kV439XlZMxrMZ3FtNMr8jY+1YDzNww=; b=ZSlsxv6hNMlu80w1q+QuS3TzzI
	ezULrgq5B1dUEN9OOVLdhdWGOddORiyimDkl3tjxBazHXGvAV+yKTJ3aIiMrt+sxWo2tAD9swKpUt
	eMiuyd90mLobEpu0ZS0VEJeFzEup3FkX/L9IX6F9GNCBbFEu24CVYDIlTdB7q5zvu7vLJiJOYNTwX
	Uk3qRgsB6TzZtZ9AYknd+nkYm8bNKhcHdWzrMe6UiJZwL6fyvijV5iJ/RPOm+XqRWR/ich/NCVoB7
	TjGoKXezOX3XT5T5VHwAg7ebOpPCK/j2udlgc6Q99nfM2k0a7j2ZvLmraSRqLqFfwfBp7kxsmZK9V
	PF5nWejQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7xZY-00000001EE1-00Lo;
	Mon, 04 Nov 2024 13:56:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 9A026308D9E; Mon,  4 Nov 2024 14:56:46 +0100 (CET)
Message-Id: <20241104135519.463607258@infradead.org>
User-Agent: quilt/0.65
Date: Mon, 04 Nov 2024 14:39:26 +0100
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
Subject: [PATCH 17/19] perf: Remove retry loop from perf_mmap()
References: <20241104133909.669111662@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

AFAICT there is no actual benefit from the mutex drop on re-try. The
'worst' case scenario is that we instantly re-gain the mutex without
perf_mmap_close() getting it. So might as well make that the normal
case.

Reflow the code to make the ring buffer detach case naturally flow
into the no ring buffer case.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6665,26 +6665,31 @@ static int perf_mmap(struct file *file,
 			return -EINVAL;
 
 		WARN_ON_ONCE(event->ctx->parent_ctx);
-again:
 		mutex_lock(&event->mmap_mutex);
+
 		if (event->rb) {
 			if (data_page_nr(event->rb) != nr_pages) {
 				ret = -EINVAL;
 				goto unlock;
 			}
 
-			if (!atomic_inc_not_zero(&event->rb->mmap_count)) {
+			if (atomic_inc_not_zero(&event->rb->mmap_count)) {
 				/*
-				 * Raced against perf_mmap_close(); remove the
-				 * event and try again.
+				 * Success -- managed to mmap() the same buffer
+				 * multiple times.
 				 */
-				ring_buffer_attach(event, NULL);
-				mutex_unlock(&event->mmap_mutex);
-				goto again;
+				ret = 0;
+				goto unlock;
 			}
 
-			goto unlock;
+			/*
+			 * Raced against perf_mmap_close()'s
+			 * atomic_dec_and_mutex_lock() remove the
+			 * event and continue as if !event->rb
+			 */
+			ring_buffer_attach(event, NULL);
 		}
+
 	} else {
 		/*
 		 * AUX area mapping: if rb->aux_nr_pages != 0, it's already



