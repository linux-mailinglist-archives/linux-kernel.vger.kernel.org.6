Return-Path: <linux-kernel+bounces-218475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BA690C05E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F15001F22957
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1BB17997;
	Tue, 18 Jun 2024 00:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZZCuaBPc"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C3CFBE8
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 00:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718670974; cv=none; b=DvUN2kYqtxQKV82jB0SxY/aeaoZeS8TF3xsAINuMDwWi/Q1zx0dr29FKBIh2gwLTx1ltnQXK6T0FfE8tZjlsXc8VwTpdGs/2fCdzP40cuXe3UkKk5iYh8UO71/z60MHosVtZhN0UymhdMitLfCffEmNEeUGgUaxiq95hvbdncac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718670974; c=relaxed/simple;
	bh=z8PTkL/kHUxYspzF2WwpvHuPdKmUNBbnhlaKNQDhBCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BNYWok/DRvyZzSuFfcrdTBI9ypsGwySOvSTLn2Q8r8k+5/wyN7SGPL6lzU2e+KtRccqvr2S8KJhlXNlXK1qs5bGRrmtQxasRMafyHLIt+gB4Xs6ZfCEF6wPoFqBH2Xnsd/4u+D/SMEEw37JlOAEYGmA1LGEir1YCUgV1PHSlqGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZZCuaBPc; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7061365d2f3so746223b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 17:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718670972; x=1719275772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgDlsk7tZBNWPt6L0xmtq7VcgKRlSUrj1CtdhLHj6YQ=;
        b=ZZCuaBPcJeeXxLYZXUaE/34cGn+9gKHiT1v94Y9BQeYcUp8yBO+iTnAOBSuUd+KHGH
         de5NxBXFAt882Vt/ntZ/2MRRKUpC+Nfp3anfWmZ7jZcUvHR+uyt0mKnYkIm2YZxcnEzF
         HA/p/f2WW1HKhJhfZVksEf+Ua511Tq3Zu7fMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718670972; x=1719275772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgDlsk7tZBNWPt6L0xmtq7VcgKRlSUrj1CtdhLHj6YQ=;
        b=rEu8+mGGRVFxxMjVx848fpvOEDapGs4UwcyJ/+NGxZXQNdidnP0GIEnOxApD3IXfJa
         JZjdR8U9M+mII+2kDXcPzgU6krdea4Y3eQdyO+M1+XV86qU376fAL7IsNA9HLpsi15gW
         /FnHAO0homHn90DpHClXsfBtgYy8epN+So2uoJeUNYMZVOR5F4sueeGqu8JLdwht1xjh
         HCH/f8kKgQ9tKR+TeNcrHwMxkcqeFuYWa8bg5Pis7KXuqEWTWPGYmvDIuF3QIP4mzKeD
         VHqqW7uJNzlPyHizU3rpkuT3qR+393fK84ad9mJLJOCfRz+QzxNncAHTi3OmV28qWpB0
         m3EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhBpvtcBX+HzBMPQE4QgVKNBFXUmYutXU0P+Haex5sXeJtr1JkkcvSRYGbv3MdVIV9Fzvji26cdQYq/d5jjPojhY6wGa4J9OYy1iQ9
X-Gm-Message-State: AOJu0YzvW0V/njDxVz5NTlLny/bD0bqKV/b2ig7df4gJmJ9uf7HQiAgI
	HFDssaVdJvjfrMwLBaZjCaZYQoKn16+L/JGTMejh7m7JXq4Bfe/t/n4GlEJRgA==
X-Google-Smtp-Source: AGHT+IHBWxdBBjKCENzeRWXMjIsVcQL3bPswzu6BTKXdBeNDJvIgqbkofEcyTd0R0111Lvl3ltUAiw==
X-Received: by 2002:a05:6a20:a123:b0:1b1:f7a1:df91 with SMTP id adf61e73a8af0-1bae8353db0mr11922437637.61.1718670971664;
        Mon, 17 Jun 2024 17:36:11 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:1798:e71b:11ad:8b94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb99f4dsm7905917b3a.216.2024.06.17.17.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 17:36:10 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: kgdb-bugreport@lists.sourceforge.net,
	Douglas Anderson <dianders@chromium.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jason Wessel <jason.wessel@windriver.com>,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/13] kdb: Use "bool" in "md" implementation where appropriate
Date: Mon, 17 Jun 2024 17:34:37 -0700
Message-ID: <20240617173426.3.I0ca82391856da1ee8c1c10b7ecf62b4dc0405aa0@changeid>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
In-Reply-To: <20240618003546.4144638-1-dianders@chromium.org>
References: <20240618003546.4144638-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like much of kdb, the "md" implementation used the "int" type to store
boolean values and used 0 for false and 1 for true. While this worked
(and used to be the only way to do things back in the day), we've had
"bool" for a lot of years now. Move the "md" functions to use "bool".

While touching this, we touch a line next to a comment using a style
that's nonstandard for the kdb codebase. Update it in passing.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/debug/kdb/kdb_main.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 47e037c3c002..88121334d189 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -1521,8 +1521,8 @@ static int kdb_mdr(unsigned long addr, unsigned int count)
  * See the kdb help for syntax.
  */
 static void kdb_md_line(const char *fmtstr, unsigned long addr,
-			int symbolic, int nosect, int bytesperword,
-			int num, int repeat, int phys)
+			bool symbolic, bool nosect, int bytesperword,
+			int num, int repeat, bool phys)
 {
 	/* print just one line of data */
 	kdb_symtab_t symtab;
@@ -1590,15 +1590,15 @@ static int kdb_md(int argc, const char **argv)
 	static unsigned long last_addr;
 	static int last_radix, last_bytesperword, last_repeat;
 	int radix = 16, mdcount = 8, bytesperword = KDB_WORD_SIZE, repeat;
-	int nosect = 0;
 	char fmtchar, fmtstr[64];
 	unsigned long addr;
 	unsigned long word;
 	long offset = 0;
-	int symbolic = 0;
-	int valid = 0;
-	int phys = 0;
-	int raw = 0;
+	bool nosect = false;
+	bool symbolic = false;
+	bool valid = false;
+	bool phys = false;
+	bool raw = false;
 
 	kdbgetintenv("MDCOUNT", &mdcount);
 	kdbgetintenv("RADIX", &radix);
@@ -1609,7 +1609,7 @@ static int kdb_md(int argc, const char **argv)
 
 	if (strcmp(argv[0], "mdr") == 0) {
 		if (argc == 2 || (argc == 0 && last_addr != 0))
-			valid = raw = 1;
+			valid = raw = true;
 		else
 			return KDB_ARGCOUNT;
 	} else if (isdigit(argv[0][2])) {
@@ -1622,7 +1622,7 @@ static int kdb_md(int argc, const char **argv)
 		last_bytesperword = bytesperword;
 		repeat = mdcount * 16 / bytesperword;
 		if (!argv[0][3])
-			valid = 1;
+			valid = true;
 		else if (argv[0][3] == 'c' && argv[0][4]) {
 			char *p;
 			repeat = simple_strtoul(argv[0] + 4, &p, 10);
@@ -1631,11 +1631,11 @@ static int kdb_md(int argc, const char **argv)
 		}
 		last_repeat = repeat;
 	} else if (strcmp(argv[0], "md") == 0)
-		valid = 1;
+		valid = true;
 	else if (strcmp(argv[0], "mds") == 0)
-		valid = 1;
+		valid = true;
 	else if (strcmp(argv[0], "mdp") == 0) {
-		phys = valid = 1;
+		phys = valid = true;
 	}
 	if (!valid)
 		return KDB_NOTFOUND;
@@ -1730,13 +1730,19 @@ static int kdb_md(int argc, const char **argv)
 	last_bytesperword = bytesperword;
 
 	if (strcmp(argv[0], "mds") == 0) {
-		symbolic = 1;
-		/* Do not save these changes as last_*, they are temporary mds
+		int tmp;
+
+		symbolic = true;
+
+		/*
+		 * Do not save these changes as last_*, they are temporary mds
 		 * overrides.
 		 */
 		bytesperword = KDB_WORD_SIZE;
 		repeat = mdcount;
-		kdbgetintenv("NOSECT", &nosect);
+
+		if (!kdbgetintenv("NOSECT", &tmp))
+			nosect = tmp;
 	}
 
 	/* Round address down modulo BYTESPERWORD */
-- 
2.45.2.627.g7a2c4fd464-goog


