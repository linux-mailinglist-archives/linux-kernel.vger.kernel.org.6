Return-Path: <linux-kernel+bounces-391158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D65F9B834C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D48112810B5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF911CB331;
	Thu, 31 Oct 2024 19:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="RVM72kHQ"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4D21CB30A
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 19:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730402640; cv=none; b=Z9t2UKqt1aCzRgMEYWDEbsBDpy49IBx3vhJYDIzLxz0K5BiWUC08HrtMrD6EJuQyKZ5D4lJfqk3S5XgzfMeCGNLE4mIvCXj62FdCWHc+b1H2jpGmi1c8G8Ka4mYVrZn/wnpOSFocCAFBg7CyQumhKlLVKVK5YlfvXWLj3YHkOqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730402640; c=relaxed/simple;
	bh=Z4KeyIcbprGtOTaec8vZfmbB4gJ4wGlEBAMEKl3A/k0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kiRm4bBy26J5NN+2d4WGT6wwh22893srr7aQKqTAlFpcLQx7zs0RU1mgQpvJfECbWD9WYcrsHKl/EjIljXoRimdBIGh23SlvGE8y5It1jNVt02TQht5F7MP/Y7jIJJMMW+uppAfPij00uHEXHz0hys7NoT6KnfMAISyZsdvNH9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=RVM72kHQ; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id D3F031770C0; Thu, 31 Oct 2024 19:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1730402630; bh=Z4KeyIcbprGtOTaec8vZfmbB4gJ4wGlEBAMEKl3A/k0=;
	h=Date:From:To:Subject:From;
	b=RVM72kHQtCjw/s/UWD1n8TY7K/40kvd4HkUoOcQ7KISSfp6p/c5UI+WTTsdqHykYg
	 Ge4yUPYxpEZexKQWT7q7/2Bfwk0xJViSwm7ZQWbT4TrKEjlnxgzPtIG/8QPrK0/7q8
	 c9jNH20c9jg+zVn7YL4LY6C4jDo+Ob1yqQLbY3Efvuxkp4fP7HOmFCwWX7zI6Sgs6W
	 71pJJNOH2cVsQwGMIgXUq2aVw2gdpewoHvsBxtgHX/txI9GIxwqydO+LPzMeYB4QuO
	 3p6twEEmgmO/4caLP6jxZZHq+tQlUNvIeAPuyOcfAEcD8YN4tDe/j8WzDfBrKNjWK9
	 oTeAh9DdA69zg==
Date: Thu, 31 Oct 2024 19:23:50 +0000
From: Nir Lichtman <nir@lichtman.org>
To: jason.wessel@windriver.com, daniel.thompson@linaro.org,
	dianders@chromium.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kdb: Fix incorrect naming of history arrow keys in code
Message-ID: <20241031192350.GA26688@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Problem: The kdb CLI code that handles the history up and down
navigation incorrectly names the up and down arrows as ctrl p and n.

Details: This could be some kind of left over legacy.
(maybe inspired by ddb which only reacts to ctrl p and n for history nav).
kdb doesn't react to ctrl p and n, and following the code flow with GDB
reveals that these values map to the up and down arrows.

Solution: Rename the macros accordingly and rename the function name
to reflect that it relates to arrows and not ctrl commands.

Signed-off-by: Nir Lichtman <nir@lichtman.org>
---
 kernel/debug/kdb/kdb_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index f5f7d7fb5936..d4b407afb888 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -1123,22 +1123,22 @@ int kdb_parse(const char *cmdstr)
 }
 
 
-static int handle_ctrl_cmd(char *cmd)
+static int handle_arrow_cmd(char *cmd)
 {
-#define CTRL_P	16
-#define CTRL_N	14
+#define ARROW_UP	16
+#define ARROW_DOWN	14
 
 	/* initial situation */
 	if (cmd_head == cmd_tail)
 		return 0;
 	switch (*cmd) {
-	case CTRL_P:
+	case ARROW_UP:
 		if (cmdptr != cmd_tail)
 			cmdptr = (cmdptr + KDB_CMD_HISTORY_COUNT - 1) %
 				 KDB_CMD_HISTORY_COUNT;
 		strscpy(cmd_cur, cmd_hist[cmdptr], CMD_BUFLEN);
 		return 1;
-	case CTRL_N:
+	case ARROW_DOWN:
 		if (cmdptr != cmd_head)
 			cmdptr = (cmdptr+1) % KDB_CMD_HISTORY_COUNT;
 		strscpy(cmd_cur, cmd_hist[cmdptr], CMD_BUFLEN);
@@ -1351,7 +1351,7 @@ static int kdb_local(kdb_reason_t reason, int error, struct pt_regs *regs,
 					*(cmd_hist[cmd_head] +
 					  strlen(cmd_hist[cmd_head])-1) = '\0';
 				}
-				if (!handle_ctrl_cmd(cmdbuf))
+				if (!handle_arrow_cmd(cmdbuf))
 					*(cmd_cur+strlen(cmd_cur)-1) = '\0';
 				cmdbuf = cmd_cur;
 				goto do_full_getstr;
-- 
2.39.2

