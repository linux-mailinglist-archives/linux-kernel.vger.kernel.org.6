Return-Path: <linux-kernel+bounces-551858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91113A57229
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 20:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07E091899C6E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8601A3035;
	Fri,  7 Mar 2025 19:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZiCDQEuN"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94B8254868
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 19:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376302; cv=none; b=BqiGOJF4ZeBJhY2H4HCgy586eMV1UYT/Nkf/Ww5MRTcDgDWOuJ1lRh06Alym4c0siMv6RAFQOh36h42+XNaA29GO/MLmECt8zVZa3nlIpXAlc5sLe7SAW+v6nvF1WVEDdAfB8z9wFVaXCtYYW7085ai58ZFX0ICnkShS3LDnG8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376302; c=relaxed/simple;
	bh=h2Qfm5AD490nSk65qA0H8/AR7PVOmz7D7DXR+8aLOs4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=i9pBK7ETvrSj/YN8GOhJUnguzwCGFCGfTvZrmGiygVcBU+CJjl/HotJHz6YuTImFoA0vlyD4kZPad/zLjCJ2woPUN7FIoG6JuddmT8nDMgaaQdOcAp7OwSirNLWhkqqTTGikz+8lh1hBkjurLXFlBQ7SqdAudA9p3PwoLNC+wVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZiCDQEuN; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=tgWtq/8LZOPD9ofFzcDLs5SJ7dmiKAcTwTGhgjpQnRY=; b=ZiCDQEuN0V4azqR8NBlCLmKi3o
	+75qbdOkVorQhW/qulUAe2n8Sw1dj5dyG+VcoiWoqhf6fHdZA1a7xWVUJXtzdqjdpxX6+ZSYTEUJ1
	eNaXv/gGzzBKAlceM7JaK73jOHXfkMserlJ8yWPdDtKvRrCBrhO3aKWM5/W+Ei8FYIuJYbCkJiO0L
	GSdwspNpYgdHCF5uAVx15oavTvuX+r7vJPUQERcpr2ZNNeIcWqPT9ew/mwSxNqpByow+73s5AnVwe
	IZlsOZZFmeKR+DAz5KbprXF34wLT+R3iCya8x6B+cwubHxsvcxLa91kv726DRnizHkWOWG4A47V13
	BYa9V+PQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tqdWP-00000001PmK-2lWB;
	Fri, 07 Mar 2025 19:38:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 0DBEE300780; Fri,  7 Mar 2025 20:38:13 +0100 (CET)
Message-ID: <20250307193722.935929443@infradead.org>
User-Agent: quilt/0.66
Date: Fri, 07 Mar 2025 20:33:07 +0100
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
Subject: [PATCH v3 2/7] perf: Simplify child event tear-down
References: <20250307193305.486326750@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Currently perf_event_release_kernel() will iterate the child events and attempt
tear-down. However, it removes them from the child_list using list_move(),
notably skipping the state management done by perf_child_detach().

Crucially, it fails to clear PERF_ATTACH_CHILD, which opens the door for a
concurrent perf_remove_from_context() to race.

This way child_list management stays fully serialized using child_mutex.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2338,7 +2338,11 @@ static void perf_child_detach(struct per
 	if (WARN_ON_ONCE(!parent_event))
 		return;
 
+	/*
+	 * Can't check this from an IPI, the holder is likey another CPU.
+	 *
 	lockdep_assert_held(&parent_event->child_mutex);
+	 */
 
 	sync_child_event(event);
 	list_del_init(&event->child_list);
@@ -5611,8 +5615,8 @@ int perf_event_release_kernel(struct per
 		tmp = list_first_entry_or_null(&event->child_list,
 					       struct perf_event, child_list);
 		if (tmp == child) {
-			perf_remove_from_context(child, DETACH_GROUP);
-			list_move(&child->child_list, &free_list);
+			perf_remove_from_context(child, DETACH_GROUP | DETACH_CHILD);
+			list_add(&child->child_list, &free_list);
 			/*
 			 * This matches the refcount bump in inherit_event();
 			 * this can't be the last reference.



