Return-Path: <linux-kernel+bounces-204250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE198FE63F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E6551F2283E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98663198837;
	Thu,  6 Jun 2024 12:11:03 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3A3195FD9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 12:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717675861; cv=none; b=b7GijvImqRRsC221s/LHHd8VzashDopQ7blopQ4wrS/vUbVVzjLHqUjsF6j49s2Wp4CxargN8wsPEe1cbZIh5NmLZJcdk+ilml03PTHFXEWt/TcQeRAcuP9gxjyUbTcHg18dLLZ765UpoU9cjI+AitDX0UimESGuIABcayA2obw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717675861; c=relaxed/simple;
	bh=HjlzeB6C1CgYsE+B087pV2CKhW5luo4DRzutqhcqgpk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=i369FUzWJdJUIFCVzBpPjdTgTr+FKlsXqq68NrTA03xBhLu/GpZfnCU9ARRvMJO89RYGWo8bAAtkaLNHCsSGuocV83iIOkfI7IrPePu72/+mXmgLJBg5Yr3/fwL2AL2TbbiwEGxl/6tX1U9sk9ylR/UcAWzqalMqjzsEL6Tfivg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9486EC4AF5F;
	Thu,  6 Jun 2024 12:11:01 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sFBxS-00000000nNK-0Vu2;
	Thu, 06 Jun 2024 08:11:06 -0400
Message-ID: <20240606121105.987880939@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 06 Jun 2024 08:10:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 10/15] ftrace: Assign RCU list variable with rcu_assign_ptr()
References: <20240606121004.857581251@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Use rcu_assign_ptr() to assign the list pointer as it is marked as RCU,
and this quiets the sparse warning:

   kernel/trace/ftrace.c:313:23: warning: incorrect type in assignment (different address spaces)
   kernel/trace/ftrace.c:313:23:    expected struct ftrace_ops [noderef] __rcu *
   kernel/trace/ftrace.c:313:23:    got struct ftrace_ops *

Link: https://lore.kernel.org/linux-trace-kernel/20240605202708.613471310@goodmis.org

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 034242675e7b..4aeb1183ea9f 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -311,7 +311,7 @@ static int remove_ftrace_ops(struct ftrace_ops __rcu **list,
 			lockdep_is_held(&ftrace_lock)) == ops &&
 	    rcu_dereference_protected(ops->next,
 			lockdep_is_held(&ftrace_lock)) == &ftrace_list_end) {
-		*list = &ftrace_list_end;
+		rcu_assign_pointer(*list, &ftrace_list_end);
 		return 0;
 	}
 
-- 
2.43.0



