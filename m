Return-Path: <linux-kernel+bounces-241294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C58927974
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C6511F23046
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4471AED53;
	Thu,  4 Jul 2024 15:02:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512581B1208;
	Thu,  4 Jul 2024 15:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720105357; cv=none; b=uzKrkyH2QEYj8eh1gFKepXh5Qp2Ay4iWj0nyg/OmKjyq/f6Jj0dwajnrIWzXID729VItqeDYwp6tCeFAMDVX2IapbtgonqgNHyrsrqCAhi6hAGy/0qimYb/hn2jQ6k2u1O9YXNxSQh7UL8bP+cEzsSyrbly5uTHuNf2ziO4mUY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720105357; c=relaxed/simple;
	bh=F3KOP0jmIqBH4qhe1aeFrzNKJPq7V8S3w8a/aBZYg5U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oMwJiP6uCbiukJcxJmn7ivkiUAukdrxHRx3WH7H0ZOknVvHe5hyJKh9uGu6OjGtUaeKpp85VsLX52waPtLC3/od6DecAmzAwlVtO015V1hnc+o32IWPmLdGfZtwCPq75gO3bb+5/TEd/S4vksSibZ1MqDOTKSLLdQvEpB6GdZLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F288367;
	Thu,  4 Jul 2024 08:02:59 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A0A5F3F766;
	Thu,  4 Jul 2024 08:02:33 -0700 (PDT)
From: Levi Yun <yeoreum.yun@arm.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	"levi.yun" <yeoreum.yun@arm.com>
Subject: [PATCH v2] trace/pid_list: Change gfp flags in pid_list_fill_irq()
Date: Thu,  4 Jul 2024 16:02:26 +0100
Message-Id: <20240704150226.1359936-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "levi.yun" <yeoreum.yun@arm.com>

pid_list_fill_irq() runs via irq_work.
When CONFIG_PREEMPT_RT is disabled, it would run in irq_context.
so it shouldn't sleep while memory allocation.

Change gfp flags from GFP_KERNEL to GFP_NOWAIT to prevent sleep in
irq_work.

This change wouldn't impact functionality in practice because the worst-size
is 2K.

Signed-off-by: levi.yun <yeoreum.yun@arm.com>
---
 kernel/trace/pid_list.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/pid_list.c b/kernel/trace/pid_list.c
index 95106d02b32d..85de221c0b6f 100644
--- a/kernel/trace/pid_list.c
+++ b/kernel/trace/pid_list.c
@@ -354,7 +354,7 @@ static void pid_list_refill_irq(struct irq_work *iwork)
 	while (upper_count-- > 0) {
 		union upper_chunk *chunk;

-		chunk = kzalloc(sizeof(*chunk), GFP_KERNEL);
+		chunk = kzalloc(sizeof(*chunk), GFP_NOWAIT);
 		if (!chunk)
 			break;
 		*upper_next = chunk;
@@ -365,7 +365,7 @@ static void pid_list_refill_irq(struct irq_work *iwork)
 	while (lower_count-- > 0) {
 		union lower_chunk *chunk;

-		chunk = kzalloc(sizeof(*chunk), GFP_KERNEL);
+		chunk = kzalloc(sizeof(*chunk), GFP_NOWAIT);
 		if (!chunk)
 			break;
 		*lower_next = chunk;
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


