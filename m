Return-Path: <linux-kernel+bounces-392073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEBC9B8F64
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96FCC1F2347A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 10:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EF11714D3;
	Fri,  1 Nov 2024 10:36:11 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB37D19CC0A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 10:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730457369; cv=none; b=mMz6H/O8VG6ns/oNlzmUMh772rvOMRZlu4deOW305lzxmzV9vs0EwpC3qHEeSPP4eU+6zgHj7eN7+yWzrvYFeN35yFUwWEp41DozH9pDu7j6nss1qXV+tyzauEjx3mFKsIVQIZ+cFPU6Zh6SPJImPPaJHk+Gr88e/N4SZwmP2bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730457369; c=relaxed/simple;
	bh=Ez/a3amP2ErzSlOSsur8sWuIM/pilTzGoEhqFsAiIHY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=NkEeYMkOxEW0lw1H4RLrC9BgXavHcNgD/1lzUs/iDr1Ty4CB326+bmPsjOkKYHbEJW8al3m1voWOTn5iWmxBIlHsNCgw2WCHT6XixsLz4a3Wtk2zzrTuheU5ms9NCXUXyt4yAu9Cg82pzESuic9C2Vc3W9+teIj7DFcKLneqK5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84BBFC4CEF7;
	Fri,  1 Nov 2024 10:36:09 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t6p1f-00000005S6Z-38bq;
	Fri, 01 Nov 2024 06:37:07 -0400
Message-ID: <20241101103707.606872077@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 01 Nov 2024 06:36:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Douglas Anderson <dianders@chromium.org>,
 Nir Lichtman <nir@lichtman.org>
Subject: [for-next][PATCH 05/11] kdb: Remove fallback interpretation of arbitrary numbers as hex
References: <20241101103647.011707614@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Nir Lichtman <nir@lichtman.org>

Remove logic that enables a fallback of interpreting numbers supplied in KDB CLI
to be interpreted as hex without explicit "0x" prefix as this can be confusing
for the end users.

Link: https://lore.kernel.org/20241028192228.GC918454@lichtman.org
Suggested-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Nir Lichtman <nir@lichtman.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/debug/kdb/kdb_main.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index f8703ab760d9..5f4be507d79f 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -402,23 +402,15 @@ static void kdb_printenv(void)
  */
 int kdbgetularg(const char *arg, unsigned long *value)
 {
-	/*
-	 * If the first fails, also try base 16, for us
-	 * folks too lazy to type the leading 0x...
-	 */
-	if (kstrtoul(arg, 0, value)) {
-		if (kstrtoul(arg, 16, value))
-			return KDB_BADINT;
-	}
+	if (kstrtoul(arg, 0, value))
+		return KDB_BADINT;
 	return 0;
 }
 
 int kdbgetu64arg(const char *arg, u64 *value)
 {
-	if (kstrtou64(arg, 0, value)) {
-		if (kstrtou64(arg, 16, value))
-			return KDB_BADINT;
-	}
+	if (kstrtou64(arg, 0, value))
+		return KDB_BADINT;
 	return 0;
 }
 
-- 
2.45.2



