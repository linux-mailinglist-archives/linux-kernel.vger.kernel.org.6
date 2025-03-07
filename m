Return-Path: <linux-kernel+bounces-551856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFE3A57226
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 20:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F33188D417
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348CF2561D4;
	Fri,  7 Mar 2025 19:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vWfcn+4q"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F765254858
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 19:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376301; cv=none; b=kJ2G6qnfS4zm57+kkxcJqwCAGZb/i0pO+G3PiNTn+6LSTof5y91ZwyMx9ARpDsBHj2pVYuzCmW0ITErqCtC3GxE3K4I+8XdOzdUJIobwKnLugGtsPG11NgpIXRG9R8nZ+1utw97voGFC/XKWgXe2lSsk0ImSMns41RfcTO220Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376301; c=relaxed/simple;
	bh=TrICi+isOBGGRKsfgqcPVSNpn0NACYzEFgWZCgPRMR0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=PooaNuoEXFNn4kDsRldyag4xYZzpoNqO3Sn6PwYugY04pLALh1lmkrdUsSfImQBkBo4rWkkqCfU8YyFqqpy+E0iur4n7D1PSlCIqERj8L9EE3nm2USbXamFBwlEe5vNPTVvhx2T76uyBb+2dH6ZeteuD0LjcDrnH2pOhkrsIHG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vWfcn+4q; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=UQmPsELNCK6nA5UcqNGR072lhiJXyTi8/Mos2B9S288=; b=vWfcn+4q7TBJYUDc//EasjRHCV
	bAuW337sdeHZwPmbsioYNx/JOEaoy2iMFHtKmlObwuXVxxZ725DA6Pg8BtQrRA8JB3+SrAMG8UNNM
	iBBpNcSXlPq8hwqqckzno4IWOz+g+jYDg9ULWv+qlTY0N6xxtmVfHTSFdKBJPp6audmcQtg78MCNf
	ki1L094bY8o7KWLDwv0mIPLo1IADd+E6u3eNsV57gZwpkSfvdWhqzyPTiRm7I0P/uMA49q+/n/U+U
	w0lN0kj2+iOUK5ge1Cid+YDdzn4sJn2HUMrW+MZ4d0TcFBcV5Hjs0UoSInp3p11IhR7/2sPAMQB+d
	WN/4udeQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tqdWP-0000000EKgK-351Z;
	Fri, 07 Mar 2025 19:38:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 14FEB30088D; Fri,  7 Mar 2025 20:38:13 +0100 (CET)
Message-ID: <20250307193723.151721102@infradead.org>
User-Agent: quilt/0.66
Date: Fri, 07 Mar 2025 20:33:09 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org,
 ravi.bangoria@amd.com,
 lucas.demarchi@intel.com
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 acme@kernel.org,
 namhyung@kernel.org,
 mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com,
 jolsa@kernel.org,
 irogers@google.com,
 adrian.hunter@intel.com,
 kan.liang@linux.intel.com
Subject: [PATCH v3 4/7] perf: Simplify perf_event_release_kernel()
References: <20250307193305.486326750@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

There is no good reason to have the free list anymore. It is possible
to call free_event() after the locks have been dropped in the main
loop.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5462,7 +5462,6 @@ int perf_event_release_kernel(struct per
 {
 	struct perf_event_context *ctx = event->ctx;
 	struct perf_event *child, *tmp;
-	LIST_HEAD(free_list);
 
 	/*
 	 * If we got here through err_alloc: free_event(event); we will not
@@ -5531,27 +5530,26 @@ int perf_event_release_kernel(struct per
 					       struct perf_event, child_list);
 		if (tmp == child) {
 			perf_remove_from_context(child, DETACH_GROUP | DETACH_CHILD);
-			list_add(&child->child_list, &free_list);
 			/*
 			 * This matches the refcount bump in inherit_event();
 			 * this can't be the last reference.
 			 */
 			put_event(event);
+		} else {
+			child = NULL;
 		}
 
 		mutex_unlock(&event->child_mutex);
 		mutex_unlock(&ctx->mutex);
+
+		if (child)
+			free_event(child);
 		put_ctx(ctx);
 
 		goto again;
 	}
 	mutex_unlock(&event->child_mutex);
 
-	list_for_each_entry_safe(child, tmp, &free_list, child_list) {
-		list_del(&child->child_list);
-		free_event(child);
-	}
-
 no_ctx:
 	put_event(event); /* Must be the 'last' reference */
 	return 0;



