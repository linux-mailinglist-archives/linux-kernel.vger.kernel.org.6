Return-Path: <linux-kernel+bounces-550168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CD2A55C22
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57F7A16FA89
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 00:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B407D3F4;
	Fri,  7 Mar 2025 00:45:28 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DDA22EE5
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 00:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741308327; cv=none; b=euntDVejEXsn1Gp9aOcNAXj97CQ+4lhZpeAxrMxQoMDYPWUYY6wXHxwyBpTLJwnrpdB+p+olIX4vwbPOthU9jjBdXz5DPLWK9DquwkXhxTBxEK8iAnwJhAhjB3715cisMm4kMONPjGq36xYL6FJPtnPYg9uM54U3UiHYaePEpIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741308327; c=relaxed/simple;
	bh=BaQAgxmEv9Sd8KLIofC6TGUbLP6DkIopi/ET07h/27I=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=hlhKVtE/iHCIE5my6MdfGl9AqD61TsJs9RMP6faL02rwomXiBiYEC7S3AIXMkuv/GLYn41wcfcHppS/gryumpac/4+oOQxCR/6ymIBObrTm4YdrTBIcRqdDHT4QcYSYSga+sUcqKNHoBkL46ZKscUHiL/1LEclrFup26FEz8HM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D093C4CEE8;
	Fri,  7 Mar 2025 00:45:27 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tqLqA-0000000059i-3E8h;
	Thu, 06 Mar 2025 19:45:26 -0500
Message-ID: <20250307004526.618551003@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 06 Mar 2025 19:45:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: [for-next][PATCH 1/3] tracing/user_events: Dont use %pK through printk
References: <20250307004511.688485107@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>

Restricted pointers ("%pK") are not meant to be used through printk().
It can unintentionally expose security sensitive, raw pointer values.

Use regular pointer formatting instead.

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20250217-restricted-pointers-trace-v1-1-bbe9ea279848@linutronix.de
Link: https://lore.kernel.org/lkml/20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023@linutronix.de/
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 97325fbd6283..3effc6fce20e 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -455,7 +455,7 @@ static void user_event_enabler_fault_fixup(struct work_struct *work)
 	if (ret && ret != -ENOENT) {
 		struct user_event *user = enabler->event;
 
-		pr_warn("user_events: Fault for mm: 0x%pK @ 0x%llx event: %s\n",
+		pr_warn("user_events: Fault for mm: 0x%p @ 0x%llx event: %s\n",
 			mm->mm, (unsigned long long)uaddr, EVENT_NAME(user));
 	}
 
-- 
2.47.2



