Return-Path: <linux-kernel+bounces-571699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8310BA6C0E5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7B081893F05
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B84422D7BB;
	Fri, 21 Mar 2025 17:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="beFeK2Oy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8A522D7B0
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742576919; cv=none; b=VA8HO6f7LAO/r11RLBWuQxPxRI01YHuBk7r2qhk/+WVAkWQA9hy9uKJDfVvp/2Bh+6RhN4Kj3qj0pf8/Ba27NxmbIO0mIy1vhDQIbNX3GOu129JblmdN75g0jHSgQcMORitKSl1oHwe4btbNs8DmkOHVdDmT59YVgWpnhTY41S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742576919; c=relaxed/simple;
	bh=9S4qEH3PVlnFOGK2lxW2awQ9ZZN4/6rIeDszBH+aXZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f4NCSRWnsAKS7eGUYyUfwu9X/5rr/YS/T6Gd/mEINzI6yqiQBF49WmoHjrlhdRJHwFHsXizDQtvdVxEKtolXd4stxU6/U8HCVNnfwpWHRF4c4vL3xZWs7yn21WsdU4RUkWCmh/3UWcy1pynPeMc9y7T0Q+T0BkyuPhqFBvRc/rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=beFeK2Oy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742576916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N0hYg2vhPmp2fQhhtWVW+roP5z+OtzA4zuLIcnrampE=;
	b=beFeK2OytNxMDLg/FDhgVVQMNJfDQzHOu88tbvBn4zGALLCP0j0lmy0a+9XAKiXA47Y07E
	GyDXpOds5tsm3Jo8w0gMcixGny7dop29QCSAG7OGH0DuqRORAxKO2x7EVzOLvvVswivGA7
	/JddhOsy2+J/i3XdV3i5Fxtw5vg/AL0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-oDYfgOSTOdmU9Lb4PFJx2A-1; Fri,
 21 Mar 2025 13:08:33 -0400
X-MC-Unique: oDYfgOSTOdmU9Lb4PFJx2A-1
X-Mimecast-MFC-AGG-ID: oDYfgOSTOdmU9Lb4PFJx2A_1742576911
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E3EA195E92A;
	Fri, 21 Mar 2025 17:08:31 +0000 (UTC)
Received: from fedora.. (unknown [10.44.33.245])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A81E3001D16;
	Fri, 21 Mar 2025 17:08:27 +0000 (UTC)
From: Gabriele Paoloni <gpaoloni@redhat.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Paoloni <gpaoloni@redhat.com>
Subject: [PATCH v2] tracing: fix return value in __ftrace_event_enable_disable for TRACE_REG_UNREGISTER
Date: Fri, 21 Mar 2025 18:08:21 +0100
Message-ID: <20250321170821.101403-1-gpaoloni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

When __ftrace_event_enable_disable invokes the class callback to
unregister the event, the return value is not reported up to the
caller, hence leading to event unregister failures being silently
ignored.

This patch assigns the ret variable to the invocation of the
event unregister callback, so that its return value is stored
and reported to the caller, and it raises a warning in case
of error.

Signed-off-by: Gabriele Paoloni <gpaoloni@redhat.com>
---
Changes from v1:
     Added WARN_ON_ONCE(ret) according to the feedbacks from
     v1 RFC [1]

[1] https://lore.kernel.org/linux-trace-kernel/20250314125725.6425-1-gpaoloni@redhat.com/T/#u
---
 kernel/trace/trace_events.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 513de9ceb80e..8e7603acca21 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -790,7 +790,9 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 				clear_bit(EVENT_FILE_FL_RECORDED_TGID_BIT, &file->flags);
 			}
 
-			call->class->reg(call, TRACE_REG_UNREGISTER, file);
+			ret = call->class->reg(call, TRACE_REG_UNREGISTER, file);
+
+			WARN_ON_ONCE(ret);
 		}
 		/* If in SOFT_MODE, just set the SOFT_DISABLE_BIT, else clear it */
 		if (file->flags & EVENT_FILE_FL_SOFT_MODE)
-- 
2.48.1


