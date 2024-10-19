Return-Path: <linux-kernel+bounces-372820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4729A4DC9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 14:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBF8D1F22868
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 12:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE9E1E0B8C;
	Sat, 19 Oct 2024 12:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U20d6OcS"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753101DE887
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729340788; cv=none; b=PmO9QKZXN1aqPNtk72TOxqUZdZeL//VJwEBDp+I/qV4HqgYQyBVyEvWSOkDCHlVCEugyI7GYAYiDHGls+T2e411g4JzZxkLKfCCF9LLsSnIAm2JbRKl5kLYdFrCefhKIWDAFc0nc8F7xUdSDgIr8+IjKqPaJUdlD9FVwq77x2w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729340788; c=relaxed/simple;
	bh=TPPqJ0NmPL4E/VoFBUo0djk7VWetDY3ISarvN6BlR/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gkf7nk/3RXMuiGbAoV7tlATQgCMtMoQcvC3CPlx78xrtTt5ArrNpbJyefzHvQH1OeZMbAf50Ra8EmE/F7F/D15pt8BNEUpkGTx3bDqk0EXf2f6LYvWCFpZv2K61ZbhzoBRZrc3XaRQq3I86r8GK9d7H0aLrBqHRNrxL9wpfbxNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U20d6OcS; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729340782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PLY+s3Nc2BlIMQaSEKQErw4KcQTV95CxN6tP27JoM10=;
	b=U20d6OcSxF0YqMeOWJy+13sewVbtnvy6F6RXAmgN3scdLVSDu5xPodxLCMPEsq/7kV+C4e
	441HEZRTqlAf3kV4y4B87BZy+phUsAmpvUKPlC7/cBS3Pnf7mDUqe7NFMeYVj7i8syp4NP
	7PgcGHLa7qV/ayh6xJ4+VhBQSL1ezmU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bcachefs: Use str_write_read() helper function
Date: Sat, 19 Oct 2024 14:25:27 +0200
Message-ID: <20241019122526.42563-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the helper function str_write_read().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/bcachefs/journal_io.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/bcachefs/journal_io.c b/fs/bcachefs/journal_io.c
index 954f6a96e0f4..325c39f90f65 100644
--- a/fs/bcachefs/journal_io.c
+++ b/fs/bcachefs/journal_io.c
@@ -17,6 +17,8 @@
 #include "sb-clean.h"
 #include "trace.h"
 
+#include <linux/string_choices.h>
+
 void bch2_journal_pos_from_member_info_set(struct bch_fs *c)
 {
 	lockdep_assert_held(&c->sb_lock);
@@ -665,7 +667,7 @@ static void journal_entry_clock_to_text(struct printbuf *out, struct bch_fs *c,
 	struct jset_entry_clock *clock =
 		container_of(entry, struct jset_entry_clock, entry);
 
-	prt_printf(out, "%s=%llu", clock->rw ? "write" : "read", le64_to_cpu(clock->time));
+	prt_printf(out, "%s=%llu", str_write_read(clock->rw), le64_to_cpu(clock->time));
 }
 
 static int journal_entry_dev_usage_validate(struct bch_fs *c,
-- 
2.47.0


