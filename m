Return-Path: <linux-kernel+bounces-361578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6328399AA04
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 788F31C23C4A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4873A1CEE97;
	Fri, 11 Oct 2024 17:30:20 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D3F1C32FF
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728667818; cv=none; b=gV6q7S040dUob+drBPthpXySvqn1TLo9m87mBfqAWeO8S5uEkq7x/aRcadL2zoEBjuMFGa5y2t6NiSfs58LED9J53ONfgWos/SBwDz/43QFhrliMng9Q2WFTr9JV116BkaFn1JGPwV39g40hPe3yu73cTIFdGWSRvFUyXcBYlr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728667818; c=relaxed/simple;
	bh=LPb8vhx1hirgUydNin6ofHBo/hHyNae4VbV6wc/CH9k=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=czCiEJQHeb/1nHk1qGSFjnrTvpW4NKpYEDgA0fKNNWyVx0phGSPBy0zNSHp5rjZUR8zRVdQvUrQr1s0G1btCZ3/uncz+NGHRSNYx6NgYyxHqIlIdNFk2IPSnJh0pgywoAhU7kb6CqNmRXr42UHrEJYUa28Vp2OApHWLCLf9itgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DDFC4CECE;
	Fri, 11 Oct 2024 17:30:18 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1szJTA-00000001U0n-3Zd2;
	Fri, 11 Oct 2024 13:30:28 -0400
Message-ID: <20241011173028.712953047@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 11 Oct 2024 13:30:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Jan Stancek <jstancek@redhat.com>
Subject: [for-next][PATCH 6/9] tools/rtla: drop __NR_sched_getattr
References: <20241011173010.441043942@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Jan Stancek <jstancek@redhat.com>

It's not used since commit 084ce16df0f0 ("tools/rtla:
Remove unused sched_getattr() function").

Link: https://lore.kernel.org/c355dc9ad23470098d6a8d0f31fbd702551c9ea8.1728552769.git.jstancek@redhat.com
Signed-off-by: Jan Stancek <jstancek@redhat.com>
Reviewed-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/utils.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index 9ac71a66840c..05b2b3fc005e 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -211,24 +211,20 @@ long parse_ns_duration(char *val)
 /*
  * This is a set of helper functions to use SCHED_DEADLINE.
  */
-#ifdef __x86_64__
-# define __NR_sched_setattr	314
-# define __NR_sched_getattr	315
-#elif __i386__
-# define __NR_sched_setattr	351
-# define __NR_sched_getattr	352
-#elif __arm__
-# define __NR_sched_setattr	380
-# define __NR_sched_getattr	381
-#elif __aarch64__ || __riscv
-# define __NR_sched_setattr	274
-# define __NR_sched_getattr	275
-#elif __powerpc__
-# define __NR_sched_setattr	355
-# define __NR_sched_getattr	356
-#elif __s390x__
-# define __NR_sched_setattr	345
-# define __NR_sched_getattr	346
+#ifndef __NR_sched_setattr
+# ifdef __x86_64__
+#  define __NR_sched_setattr	314
+# elif __i386__
+#  define __NR_sched_setattr	351
+# elif __arm__
+#  define __NR_sched_setattr	380
+# elif __aarch64__ || __riscv
+#  define __NR_sched_setattr	274
+# elif __powerpc__
+#  define __NR_sched_setattr	355
+# elif __s390x__
+#  define __NR_sched_setattr	345
+# endif
 #endif
 
 #define SCHED_DEADLINE		6
-- 
2.45.2



