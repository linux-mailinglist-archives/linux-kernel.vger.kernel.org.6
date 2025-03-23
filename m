Return-Path: <linux-kernel+bounces-572830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 288E3A6CF33
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 13:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3897D189A1F5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 12:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0648321D3F4;
	Sun, 23 Mar 2025 12:29:13 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ADE205E09
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742732951; cv=none; b=OTGtjDKS3A7XeekpjVpL+QGFaNqfnQCs9UVaKePJbaGfi6oeXlOJcmSQaFzKQq/xruFbs5dNTnDtPo7c+PFKjSPO+UWdFsg9tMLZCPWRfSG3udlFIiXgnGw9mj4EHu134Hum4k70suHJK+JJJg05/Y7U4z/cBsOMEc+kC8KRiL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742732951; c=relaxed/simple;
	bh=/yXhofCAGEzzJEbCcqOQZFRFpTHBKM2oi283WB+2IM4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=rN847L0oW0mafvlh63z6dAWj20wnX0CxdpEqc5IVLbhXdNP2lyl8GqlHIbqnMQCOGFq5yJeW30kOiqgSfWLhpv0OB3ScxfCwYBqUm45HQf5Ll3qMnugQOPQTIDtLNseGlzcAZd5KDBHfk/Sp9eZOHGwPWyr+OHD0/7IeI1Ulg14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2427C4CEF3;
	Sun, 23 Mar 2025 12:29:10 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1twKSc-00000001ygC-0rMX;
	Sun, 23 Mar 2025 08:29:50 -0400
Message-ID: <20250323122950.059768296@goodmis.org>
User-Agent: quilt/0.68
Date: Sun, 23 Mar 2025 08:29:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Douglas Raillard <douglas.raillard@arm.com>
Subject: [for-next][PATCH 06/10] tracing: Align synth event print fmt
References: <20250323122933.407277911@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Douglas Raillard <douglas.raillard@arm.com>

The vast majority of ftrace event print fmt consist of a space-separated
field=value pair. Synthetic event currently use a comma-separated
field=value pair, which sticks out from events created via more
classical means.

Align the format of synth events so they look just like any other event,
for better consistency and less headache when doing crude text-based
data processing.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20250319215028.1680278-1-douglas.raillard@arm.com
Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_synth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index e3f7d09e5512..07ff8be8267e 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -612,7 +612,7 @@ static int __set_synth_event_print_fmt(struct synth_event *event,
 		fmt = synth_field_fmt(event->fields[i]->type);
 		pos += snprintf(buf + pos, LEN_OR_ZERO, "%s=%s%s",
 				event->fields[i]->name, fmt,
-				i == event->n_fields - 1 ? "" : ", ");
+				i == event->n_fields - 1 ? "" : " ");
 	}
 	pos += snprintf(buf + pos, LEN_OR_ZERO, "\"");
 
-- 
2.47.2



