Return-Path: <linux-kernel+bounces-394984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 930E09BB6DE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C553E1C23467
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11B313BC0C;
	Mon,  4 Nov 2024 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YJFWUUN+"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871AC7E111
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730728613; cv=none; b=SXFV4qXVZRVBXIyl/xPlDW3mDzBCq3p6iOTzhhihrdpBklox3Xi7BNKCHsQRjL459N/ll2f9G8KFbvcwR7zwo6Jb9vHsRZ66k7KCCcAoN1+5bPp4SBKbal5vklnfSv+Qq31gfFld3zACrIk0HcWCqBJPS7sdc7bnnBySFRleoiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730728613; c=relaxed/simple;
	bh=axSv5kNHfFatY3qrMWazkxF0Xp0A0k5ornDlIv1p4P8=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=mWMgDhv9nhPgknU+QX5R85IW1KH6VyInKg9ISe1O2ExKao4n0ineyYJB7f7hktTsjG0kst3aUhjS1XLqZvZAsD4g2Xcy+5gUEqylkBAi/RMqV5Di6qrPoKVT6emAPtcJ2oyVOjJr38P7XquQh1VfKSi5NKO7aQlZVBxLLn0iE2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YJFWUUN+; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=Fgq+swJWnqWBfSBKjOMZU1+pyDensX+uKGeMorHPpsI=; b=YJFWUUN+YBrTeW3wFuvd+fqrAQ
	Ga+56Y66bWESazU6C4+9IIt5g9hw6z9v7/CfF1PBz2rJYozGlrEQDeDT0IBGOceD6chCyfHav+12X
	z2+GaEhkLFywo6LjHF7EBeMFYZjnq5RlE8SLMWMQiqc1XTjHjkoorO9zjoLIEjOLNxuXFdtTtMyMr
	Bdxf157MLbgoB0gzMlb0H5R9F3pB2XcJpyRQ/BFM9pFtY3/amnqMaD++MFC4ev9y78I/WcCkzS1EQ
	lbPf1/SJEtkYD06tDnnHI2Ec/fzD7wlKcpoakFN20Mgn8nST1Q9p3WGyftchzqf/2Xegk8TRP88Ei
	PVMh4I8A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7xZY-0000000BL8C-0TyF;
	Mon, 04 Nov 2024 13:56:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 7F29D308CC5; Mon,  4 Nov 2024 14:56:46 +0100 (CET)
Message-Id: <20241104135518.868460518@infradead.org>
User-Agent: quilt/0.65
Date: Mon, 04 Nov 2024 14:39:21 +0100
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
Subject: [PATCH 12/19] perf: Introduce perf_free_addr_filters()
References: <20241104133909.669111662@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Replace _free_event()'s use of perf_addr_filters_splice()s use with an
explicit perf_free_addr_filters() with the explicit propery that it is
able to be called a second time without ill effect.

Most notable, referencing event->pmu must be avoided when there are no
filters left (from eg a previous call).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5307,8 +5307,7 @@ static bool exclusive_event_installable(
 	return true;
 }
 
-static void perf_addr_filters_splice(struct perf_event *event,
-				       struct list_head *head);
+static void perf_free_addr_filters(struct perf_event *event);
 
 static void perf_pending_task_sync(struct perf_event *event)
 {
@@ -5407,7 +5406,7 @@ static void _free_event(struct perf_even
 	}
 
 	perf_event_free_bpf_prog(event);
-	perf_addr_filters_splice(event, NULL);
+	perf_free_addr_filters(event);
 
 	__free_event(event);
 }
@@ -10880,6 +10882,17 @@ static void perf_addr_filters_splice(str
 	free_filters_list(&list);
 }
 
+static void perf_free_addr_filters(struct perf_event *event)
+{
+	/*
+	 * Used during free paths, there is no concurrency.
+	 */
+	if (list_empty(&event->addr_filters.list))
+		return;
+
+	perf_addr_filters_splice(event, NULL);
+}
+
 /*
  * Scan through mm's vmas and see if one of them matches the
  * @filter; if so, adjust filter's address range.



