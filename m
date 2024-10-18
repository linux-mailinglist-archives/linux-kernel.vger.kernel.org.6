Return-Path: <linux-kernel+bounces-371584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433189A3CE7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005A0281141
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437CE2038A8;
	Fri, 18 Oct 2024 11:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jd4YnoDK"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD62D2010EC
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 11:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729249851; cv=none; b=ZvjZEEvcoTIYZn6NEptSdYHJe9/wFmuue0mBUOPl3OSIt0MJQqvWTf74UCs48BaLEdeNnFX9YOyBWMJmYqukVF3thsVMA6xtw+YeEjt5XECkHy13zn83xEzyn4+CVd2uAC/EKlt2pcMAy1CJWwE/lz87k51+jbEJ8uWhwwcFYUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729249851; c=relaxed/simple;
	bh=luN+UoqCh/vX6oY5x7h75I7yJbY7uMwLjRqMHdy1lD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NTopiDd5C8/BLIft1Xc0b4LhJ1H1xO7Z52LJpIgQahEiUZnHi4UShu7sx1uEU4ZSuFnYlRMXjnZ6z1q/4Hr7wHvhJLWAIrDkqlYf6sGb/VOpDVdHHfHbFHzrQDwKB7Yy3iAmBWGvMWfmIkz2zuNqcNBbfBQsjZJQgyhKYKcGp58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jd4YnoDK; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729249848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=V3P7W3c46gj6LyyAime8jmUBVj4RSCtAx4uFWRU5pec=;
	b=jd4YnoDKfC+EVzspFys8gPR5wobLSWxXZfldhtCmtULkl1B+GnMHyA8FU9/nJYpyehgO5J
	rRvodNAYZtgkpyusUZ7XxqFT9c8k4vC4lsLPPRjIXjj4tcrlKcmy9N86y1yed8DjWHfufF
	MldyR4HeVuwXlcs1E6RjN9+R7OcjgD8=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] audit: Use str_yes_no() helper function
Date: Fri, 18 Oct 2024 13:09:46 +0200
Message-ID: <20241018110945.111842-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the helper function str_yes_no().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 kernel/auditsc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index cd57053b4a69..0627e74585ce 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1653,8 +1653,8 @@ static void audit_log_uring(struct audit_context *ctx)
 	audit_log_format(ab, "uring_op=%d", ctx->uring_op);
 	if (ctx->return_valid != AUDITSC_INVALID)
 		audit_log_format(ab, " success=%s exit=%ld",
-				 (ctx->return_valid == AUDITSC_SUCCESS ?
-				  "yes" : "no"),
+				 str_yes_no(ctx->return_valid ==
+					    AUDITSC_SUCCESS),
 				 ctx->return_code);
 	audit_log_format(ab,
 			 " items=%d"
@@ -1696,8 +1696,8 @@ static void audit_log_exit(void)
 			audit_log_format(ab, " per=%lx", context->personality);
 		if (context->return_valid != AUDITSC_INVALID)
 			audit_log_format(ab, " success=%s exit=%ld",
-					 (context->return_valid == AUDITSC_SUCCESS ?
-					  "yes" : "no"),
+					 str_yes_no(context->return_valid ==
+						    AUDITSC_SUCCESS),
 					 context->return_code);
 		audit_log_format(ab,
 				 " a0=%lx a1=%lx a2=%lx a3=%lx items=%d",
-- 
2.47.0


