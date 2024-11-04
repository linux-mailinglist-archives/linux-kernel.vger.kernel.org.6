Return-Path: <linux-kernel+bounces-394999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AEE9BB6ED
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF4A281002
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F7B1C2DDE;
	Mon,  4 Nov 2024 13:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZvXzkVXp"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCF81C3040
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730728625; cv=none; b=EVXLyzNSF+syKpDY8vbtPpdKYkpUI3XE5CaS4YeXLitCRMrB5J5rcME4iFNJooBkcivuc6ZXjGBFtv8Gu9cO2Ps+Zw89DQy7rpIQETyXAvXeT8N0pQ+IOA2S7Ri1PrHxbOwFbDXKUF0DWbKuqg2huWLI6rIiH4kB1BEmVlVgylc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730728625; c=relaxed/simple;
	bh=df+dmCSsmASCCiX4RF6jpMjhrZXTUexNtYFlX8/8iKU=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=hq6zl0XRfBRfiYMGaUPsbeOjHNtxLbZn2ryXQXdiDbFHh0bxHI25lBRv5qxzehbOd/3mcYlKceuVU2Jq1H47Uf5aL0KGPwbYgzePxlDsoFkYlsx+fLSWZ6N0mczGrjpoOmfUjGsyruwXb9/rZhXDD16s4DPjadlzlfb5V69xjkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZvXzkVXp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=uAPyRz8wmmRRgcA95aFkKu3NgvNM9+1q89aOk8NMoAk=; b=ZvXzkVXpD8Quqfxo/LxDKc7unB
	+BSuLOudOdKQfFiHEGn2yFz+9C64h3uo8n56dKNoUW9/Ky2O7ywM9G5i/XC6bd91/fLsbrGQ4qfho
	FpZZjXFsxWkecUe7rMfomp7WSP25aEmr3qqtIRqlBtDQyKN1KCVg6ey/CruHKWhiRKEMld2dSdZkJ
	2oF87eAXVOyMQUtlu9EIJKbbFhpZtGdK1jssAXw7/7EHQd69hY/iGNp8AtnzZi7tmNQpOoLRR9o+d
	SsoYjs2+s4JJlfPiHWsIg66cqnehjRu2YQu5wdOtH1aH9oU0RklB/vtkM388q/pUATtB3A7iF5WYd
	lv24ajLQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7xZX-00000001EDw-2HD9;
	Mon, 04 Nov 2024 13:56:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 88552308CCA; Mon,  4 Nov 2024 14:56:46 +0100 (CET)
Message-Id: <20241104135519.095904637@infradead.org>
User-Agent: quilt/0.65
Date: Mon, 04 Nov 2024 14:39:23 +0100
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
Subject: [PATCH 14/19] perf: Simplify perf_mmap() control flow
References: <20241104133909.669111662@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

  if (c) {
    X1;
  } else {
    Y;
    goto l;
  }

  X2;
l:

into:

  if (c) {
    X1;
    X2;
  } else {
    Y;
  }

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   71 ++++++++++++++++++++++++---------------------------
 1 file changed, 34 insertions(+), 37 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6647,6 +6647,40 @@ static int perf_mmap(struct file *file,
 
 	if (vma->vm_pgoff == 0) {
 		nr_pages = (vma_size / PAGE_SIZE) - 1;
+
+		/*
+		 * If we have rb pages ensure they're a power-of-two number, so we
+		 * can do bitmasks instead of modulo.
+		 */
+		if (nr_pages != 0 && !is_power_of_2(nr_pages))
+			return -EINVAL;
+
+		if (vma_size != PAGE_SIZE * (1 + nr_pages))
+			return -EINVAL;
+
+		WARN_ON_ONCE(event->ctx->parent_ctx);
+again:
+		mutex_lock(&event->mmap_mutex);
+		if (event->rb) {
+			if (data_page_nr(event->rb) != nr_pages) {
+				ret = -EINVAL;
+				goto unlock;
+			}
+
+			if (!atomic_inc_not_zero(&event->rb->mmap_count)) {
+				/*
+				 * Raced against perf_mmap_close(); remove the
+				 * event and try again.
+				 */
+				ring_buffer_attach(event, NULL);
+				mutex_unlock(&event->mmap_mutex);
+				goto again;
+			}
+
+			goto unlock;
+		}
+
+		user_extra = nr_pages + 1;
 	} else {
 		/*
 		 * AUX area mapping: if rb->aux_nr_pages != 0, it's already
@@ -6706,45 +6740,8 @@ static int perf_mmap(struct file *file,
 
 		atomic_set(&rb->aux_mmap_count, 1);
 		user_extra = nr_pages;
-
-		goto accounting;
 	}
 
-	/*
-	 * If we have rb pages ensure they're a power-of-two number, so we
-	 * can do bitmasks instead of modulo.
-	 */
-	if (nr_pages != 0 && !is_power_of_2(nr_pages))
-		return -EINVAL;
-
-	if (vma_size != PAGE_SIZE * (1 + nr_pages))
-		return -EINVAL;
-
-	WARN_ON_ONCE(event->ctx->parent_ctx);
-again:
-	mutex_lock(&event->mmap_mutex);
-	if (event->rb) {
-		if (data_page_nr(event->rb) != nr_pages) {
-			ret = -EINVAL;
-			goto unlock;
-		}
-
-		if (!atomic_inc_not_zero(&event->rb->mmap_count)) {
-			/*
-			 * Raced against perf_mmap_close(); remove the
-			 * event and try again.
-			 */
-			ring_buffer_attach(event, NULL);
-			mutex_unlock(&event->mmap_mutex);
-			goto again;
-		}
-
-		goto unlock;
-	}
-
-	user_extra = nr_pages + 1;
-
-accounting:
 	user_lock_limit = sysctl_perf_event_mlock >> (PAGE_SHIFT - 10);
 
 	/*



