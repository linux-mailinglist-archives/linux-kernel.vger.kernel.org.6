Return-Path: <linux-kernel+bounces-562025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F32DA61A9E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4B019C4F65
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A5220D514;
	Fri, 14 Mar 2025 19:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJEbcpWs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56003209674
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 19:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741980572; cv=none; b=r/xCrsCh/Khoj7zDAvVOSoOsEQZCJTFtoYXJtDpt89r/+huo6yKVdKt8WucILbantaseUGgYTRiXKPKv8TW7SeVPIa0YvPAqmoEZYWGvWnYS1IAgP6+PdXb8pY7fPB+vzk9tfnVKK0UvrZT0pAQB0NHCk/RmiH9S2eRvE0bDCzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741980572; c=relaxed/simple;
	bh=XlGdkelaaBYsB5r9HRmUpmRPjN8YbQPGBwNquGloP04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hOQVA74Vp6HVYIkerPltvDoNH0TMFLNTrwGEbADA2ajaxUnsSuO0IrWlNGAg7/fDIgrcwh91zTILbCugK/kgI29RAECrHEOIxffpCCEEkHMWrmV9/ROczwDdtTOepmYC+8AL0KGqg+J2NmVJo7+LbI6HdDUDZC6p+DHYhgDMJAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJEbcpWs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359AAC4CEE3;
	Fri, 14 Mar 2025 19:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741980571;
	bh=XlGdkelaaBYsB5r9HRmUpmRPjN8YbQPGBwNquGloP04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VJEbcpWsO3NlSviV4z3UIgPQKHCVoB3IaK5+Fkh3QspwxP6kngzZBH29rUKnqvd3s
	 3sQ7vRGVO93UgK78yQ2ZgNrcBRTcMAEcdwxp3UHjgY29TQV9GEcnY+nB8ZdyyTC+Bi
	 SPptX9LjB/7ICGnyl+uN+wdNL0YO78yQFKI7njBKsPKSnVijKPXHJlKxJNDmKdk67Z
	 WGkAxK+6ay4mTVXJP6zqJsXeanN8sYLaxUXPVqsgzWXn7yrVzkRpE2q8EtLLEIucDX
	 fm+pTqlsQf4X3ISV2bjFTr0Ffo5rrMa025C+lnZb3l7qhCYEhWurhp5IgcyEHKJh6b
	 48cvIxUu459kw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 07/13] objtool: Consolidate option validation
Date: Fri, 14 Mar 2025 12:29:05 -0700
Message-ID: <8f886502fda1d15f39d7351b70d4ebe5903da627.1741975349.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741975349.git.jpoimboe@kernel.org>
References: <cover.1741975349.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The option validations are a bit scattered, consolidate them.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/builtin-check.c | 68 +++++++++++++----------------------
 1 file changed, 24 insertions(+), 44 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index c7275cf7641b..36d81a455b01 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -131,6 +131,26 @@ int cmd_parse_options(int argc, const char **argv, const char * const usage[])
 
 static bool opts_valid(void)
 {
+	if (opts.mnop && !opts.mcount) {
+		ERROR("--mnop requires --mcount");
+		return false;
+	}
+
+	if (opts.noinstr && !opts.link) {
+		ERROR("--noinstr requires --link");
+		return false;
+	}
+
+	if (opts.ibt && !opts.link) {
+		ERROR("--ibt requires --link");
+		return false;
+	}
+
+	if (opts.unret && !opts.link) {
+		ERROR("--unret requires --link");
+		return false;
+	}
+
 	if (opts.hack_jump_label	||
 	    opts.hack_noinstr		||
 	    opts.ibt			||
@@ -158,45 +178,6 @@ static bool opts_valid(void)
 	return false;
 }
 
-static bool mnop_opts_valid(void)
-{
-	if (opts.mnop && !opts.mcount) {
-		ERROR("--mnop requires --mcount");
-		return false;
-	}
-
-	return true;
-}
-
-static bool link_opts_valid(struct objtool_file *file)
-{
-	if (opts.link)
-		return true;
-
-	if (has_multiple_files(file->elf)) {
-		ERROR("Linked object detected, forcing --link");
-		opts.link = true;
-		return true;
-	}
-
-	if (opts.noinstr) {
-		ERROR("--noinstr requires --link");
-		return false;
-	}
-
-	if (opts.ibt) {
-		ERROR("--ibt requires --link");
-		return false;
-	}
-
-	if (opts.unret) {
-		ERROR("--unret requires --link");
-		return false;
-	}
-
-	return true;
-}
-
 int objtool_run(int argc, const char **argv)
 {
 	const char *objname;
@@ -216,11 +197,10 @@ int objtool_run(int argc, const char **argv)
 	if (!file)
 		return 1;
 
-	if (!mnop_opts_valid())
-		return 1;
-
-	if (!link_opts_valid(file))
-		return 1;
+	if (!opts.link && has_multiple_files(file->elf)) {
+		ERROR("Linked object detected, forcing --link");
+		opts.link = true;
+	}
 
 	ret = check(file);
 	if (ret)
-- 
2.48.1


