Return-Path: <linux-kernel+bounces-192259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 881D58D1AC5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FEB51F24362
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130A516D4C9;
	Tue, 28 May 2024 12:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJSyZlHI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F4516D9AA
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 12:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716898319; cv=none; b=LM7qWwXylcay5GrbkcImJSEuUe2RX36V/Xu6UhUaveremVyc7b6OlhtBLbjpA/vmRRabpyZhoPayj3Nds+vAhar5Qy3mf/V2kkautAcL2AksioAwD0wuAih56dQZxCOdIwfUHz3t165z9mBtN5IAZaIqJanUskQgq6ypgr1NhnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716898319; c=relaxed/simple;
	bh=9oJf2W4YAfo1/U1RW70Nztdk9rsBysYzDxvEI53bdjs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kxaRpGux9ToQ97nL1Qlb+M/TfdJh5tCDICc1JRRyGnURa7RIpv2rEE+bqIdjsfbG6D2Lt5tXTEYqQuaMh2NQNd3HNNYnyUbRbTcZYMG6bNcfxNzOhLDdwoQrwcMpFob+tFkgHD+aCJ3DG3jf6SBpl9fT0XFhvsCdXdhIsEA41sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJSyZlHI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1A3C32782;
	Tue, 28 May 2024 12:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716898319;
	bh=9oJf2W4YAfo1/U1RW70Nztdk9rsBysYzDxvEI53bdjs=;
	h=From:To:Cc:Subject:Date:From;
	b=MJSyZlHI0WYHrLNyrRjCTzSWsdD2LVY3KA0gAIpOJg/d5RvdhncnoFz/WoXlKEf3+
	 Iko7OBFXWIla86aPmDZNNm3eRW86dPBME03RXXvWdyXMg1zMjHKml1ZKolsu0e96UE
	 d5a/zRh7Z0ljpIbY2JftU9WpIuwPmO0U7ZVQKk+dW9esXzBimvK4UnuaFSU6JGB6zk
	 0FWSNDLkuvwYRv2ETvdT997UOKhde/cH2G2hKEklOBLQV1xcsHiy7hHF2O5HZs61gj
	 9wg2gV1raSuOT6+nHFdbjDJhOn6Fti/sxsoug7tLBVbQ+1EHJh0c6a7lq7JFxhLULY
	 37SjnGU2nruNw==
From: Arnd Bergmann <arnd@kernel.org>
To: Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <daniel.thompson@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Douglas Anderson <dianders@chromium.org>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Justin Stitt <justinstitt@google.com>,
	John Ogness <john.ogness@linutronix.de>,
	kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kdb: address -Wformat-security warnings
Date: Tue, 28 May 2024 14:11:48 +0200
Message-Id: <20240528121154.3662553-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When -Wformat-security is not disabled, using a string pointer
as a format causes a warning:

kernel/debug/kdb/kdb_io.c: In function 'kdb_read':
kernel/debug/kdb/kdb_io.c:365:36: error: format not a string literal and no format arguments [-Werror=format-security]
  365 |                         kdb_printf(kdb_prompt_str);
      |                                    ^~~~~~~~~~~~~~
kernel/debug/kdb/kdb_io.c: In function 'kdb_getstr':
kernel/debug/kdb/kdb_io.c:456:20: error: format not a string literal and no format arguments [-Werror=format-security]
  456 |         kdb_printf(kdb_prompt_str);
      |                    ^~~~~~~~~~~~~~

Use an explcit "%s" format instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/debug/kdb/kdb_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 3131334d7a81..7da3fa7beffd 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -362,7 +362,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			if (i >= dtab_count)
 				kdb_printf("...");
 			kdb_printf("\n");
-			kdb_printf(kdb_prompt_str);
+			kdb_printf("%s",  kdb_prompt_str);
 			kdb_printf("%s", buffer);
 			if (cp != lastchar)
 				kdb_position_cursor(kdb_prompt_str, buffer, cp);
@@ -453,7 +453,7 @@ char *kdb_getstr(char *buffer, size_t bufsize, const char *prompt)
 {
 	if (prompt && kdb_prompt_str != prompt)
 		strscpy(kdb_prompt_str, prompt, CMD_BUFLEN);
-	kdb_printf(kdb_prompt_str);
+	kdb_printf("%s", kdb_prompt_str);
 	kdb_nextline = 1;	/* Prompt and input resets line number */
 	return kdb_read(buffer, bufsize);
 }
-- 
2.39.2


