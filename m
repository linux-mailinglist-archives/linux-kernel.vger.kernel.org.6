Return-Path: <linux-kernel+bounces-560642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF1AA607A7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 04:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41B023BD694
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 03:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3295135949;
	Fri, 14 Mar 2025 03:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fNp/Onr+"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1913DF510
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741921273; cv=none; b=YmVuEeTd931Qp98bbfDgrOmhASC0um/J/gofmqLQEAFKU1b3srGxF3IzKBY6ebTYxSpudIw6DFEFkwTX2i8npHE/0GhdEW0/KxNp9r000xRxxLL5fzJBRchrYML9ulJqeQs4KIAtj/V66ZXS73fgghh1P7QY8NKAV/B5mjtV4DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741921273; c=relaxed/simple;
	bh=OVSXdn/stpqtpu4N4hx38/r4z7BrOycAmkDikymqOv0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s/NXyP1DhJrxjmHgzaz6iILlD5SUhV/6/kuK1VHt+lkqbLeiLuI8No19zoto9CRpHaQwKsWC0Jkb+OPZaCaHpoCIXrIYu1YB6Ql2SlymJa3agSnF7NGZrU8Q2sY6j4MMGHPB6XcNGR9B4dZE1JRApYDatpD0DmWje4loUGXJEhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fNp/Onr+; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741921268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ddR8PbHunJyeTeHkWYEZbpc6P3czHJwK0VLQdq1QbFQ=;
	b=fNp/Onr+uFnhbtZEwrh/PT51whjc6k3oCPRsPIjAvLsXyeyYhyeGR9hE2ogBh+poixemQl
	ve4UoO496/8n7CajD90O3h1vlSCKATtliR80xeEe8ivx+hqQQNavQE6luQ/7/FMlBMy0/x
	P+Ytho8tSYNKgySaQM7mCFdFJcVO3fQ=
From: Tao Chen <chen.dylane@linux.dev>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	fweisbec@gmail.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH linux-next v2] perf/ring_buffer: Add EPOLLRDNORM flag for poll
Date: Fri, 14 Mar 2025 11:00:36 +0800
Message-Id: <20250314030036.2543180-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The poll man page says POLLRDNORM is equivalent to POLLIN. For poll,
it seems that if user sets pollfd with POLLRDNORM in userspace, perf_poll
will not return until timeout even if perf_output_wakeup called, whereas POLLIN
returns.

Fixes: 76369139ceb9 ("perf: Split up buffer handling from core code")
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/events/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Change list:
- v1 -> v2:
    - add changelog
- v1
  https://lore.kernel.org/all/20250313051047.2436098-1-chen.dylane@linux.dev

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 59a52b1a1..5130b119d 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -19,7 +19,7 @@
 
 static void perf_output_wakeup(struct perf_output_handle *handle)
 {
-	atomic_set(&handle->rb->poll, EPOLLIN);
+	atomic_set(&handle->rb->poll, EPOLLIN | EPOLLRDNORM);
 
 	handle->event->pending_wakeup = 1;
 
-- 
2.43.0


