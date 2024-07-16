Return-Path: <linux-kernel+bounces-254165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3D4932FAD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC9A1F216D6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27391A01D2;
	Tue, 16 Jul 2024 18:06:34 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CC91A00EF
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 18:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721153194; cv=none; b=gzsrQoLXRP7tgHFagu2jKwD1f68fCFcC6dg7RqjTD1HGxhVOKErZd4Q1uKkehuUzJDheFxnIls/jUOBEWBTPoOYg0y3CoHGAdN7qO/278UTfDZ6HbD+hqihFIqereeZikyBjwm0UE7ctIbivUlGmDaSnljCrdGrhTcybaGQWY0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721153194; c=relaxed/simple;
	bh=xKJALhPhotyjNHTT0xF0nHf9y2M49HI4RDm2QuB74qQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=hh7FoNjKgT6m82+x0OJbpbpXfgvqLOYLqDtESES0npL/nK95iS/1VZkK4vazJ9hvXToi/h/2TA8a2dWRVTb3l7bKSJmUbHy6cDoIDuKcx0hpIe0I2HWciT9eNIELmdEl2U8hEL2Jn2EYhNs1Ew4VwkcILTFPbUBn0CC4plWTdh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D311C4AF12;
	Tue, 16 Jul 2024 18:06:34 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1sTmZP-0000000073V-0ked;
	Tue, 16 Jul 2024 14:06:35 -0400
Message-ID: <20240716180635.041988522@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 16 Jul 2024 14:06:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tio Zhang <tiozhang@didiglobal.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: [for-next][PATCH 2/3] tracing/sched: sched_switch: place prev_comm and next_comm in right
 order
References: <20240716180613.399475893@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tio Zhang <tiozhang@didiglobal.com>

Switch the order of prev_comm and next_comm in sched_switch's code to
align with its printing order.

Cc: <mhiramat@kernel.org>
Signed-off-by: Tio Zhang <tiozhang@didiglobal.com>
Link: https://lore.kernel.org/20240703033353.GA2833@didi-ThinkCentre-M930t-N000
Reviewed-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/events/sched.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 6df2b4685b08..9ea4c404bd4e 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -239,11 +239,11 @@ TRACE_EVENT(sched_switch,
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
+		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
 		__entry->prev_pid	= prev->pid;
 		__entry->prev_prio	= prev->prio;
 		__entry->prev_state	= __trace_sched_switch_state(preempt, prev_state, prev);
-		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
+		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
 		__entry->next_pid	= next->pid;
 		__entry->next_prio	= next->prio;
 		/* XXX SCHED_DEADLINE */
-- 
2.43.0



