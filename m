Return-Path: <linux-kernel+bounces-203173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 211CB8FD77B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9645B2868C8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6517715ECF8;
	Wed,  5 Jun 2024 20:27:06 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1EF15ECCD;
	Wed,  5 Jun 2024 20:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717619226; cv=none; b=AhOpfdDWj8nEPMwwQDB52UiWrU4RBvV477b6MNorzBMmv8q8/iZ/7UmKIzGm3WL+tYONXp1UhGXS8GSdYb+D8OY+T/LgsDRropWPMSGTnhuUZlRMv3kHY+yuzciSYjSK3H2mEWWTkQ9vf9j903dFPII/90Kaa/s/ZTupYZW6hcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717619226; c=relaxed/simple;
	bh=jnHREzsc8tpTaQNkMJMt6pd9c2rlI6DKzyKGBlZBgRM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=rUAJA+XzHHNLkPvVSTtT4FX7MFnNZQ7n4I8WS1Xnd8jaNpLQYpMG6t+pxGb4NBZUeb9DXbUkXeywfIxDQHwBcukkmKrki1Oy7kw3Hj82GBAuvqzCoYHonFiEU6EjZx1dDCp8uYUumu2YL03AeYZ8xjRdNSEd+f9q7Ww3tJHv3Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B290AC4AF0A;
	Wed,  5 Jun 2024 20:27:05 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sExDw-00000000i7u-39u8;
	Wed, 05 Jun 2024 16:27:08 -0400
Message-ID: <20240605202708.613471310@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 05 Jun 2024 16:26:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/6] ftrace: Assign RCU list variable with rcu_assign_ptr()
References: <20240605202644.293295925@goodmis.org>
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

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 3af0b1feb873..a39842a53444 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -310,7 +310,7 @@ static int remove_ftrace_ops(struct ftrace_ops __rcu **list,
 			lockdep_is_held(&ftrace_lock)) == ops &&
 	    rcu_dereference_protected(ops->next,
 			lockdep_is_held(&ftrace_lock)) == &ftrace_list_end) {
-		*list = &ftrace_list_end;
+		rcu_assign_pointer(*list, &ftrace_list_end);
 		return 0;
 	}
 
-- 
2.43.0



