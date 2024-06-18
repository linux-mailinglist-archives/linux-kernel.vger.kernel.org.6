Return-Path: <linux-kernel+bounces-218484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D4E90C06F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12A69B22DF8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D481D299;
	Tue, 18 Jun 2024 00:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JoiYWpgU"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329023FB96
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 00:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718670990; cv=none; b=DtZOfY8Jwxm2Zx6Wwr4rDu/nyea9X2r9hz0A6w7vJLKt2SpRWs7hVsCuhpnIg4vE2RIhTLwDpx2d/sAKDhw6exNHMYBP618WcStQlkWZc7y2oXf4hIoJ6bM3BIJV09hQZm/1yNeI2A0EDE1F2uZrLbyz8jRn4/NOt/9yhr5MH4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718670990; c=relaxed/simple;
	bh=xeaxzZwcmvj0e9diTUSi85O1pBL58FtSMNoK0X8ywpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MjweoAa7OKNFsNFi4Cfrlb8ArvgiV+a2oXIERJ7p4hcA81ZKrdp98fo+IeK1GoIa0fvolTQHmcEIHVZTsv8kqKW6Ru/1+QZp8K/Oc0u3R28hX/X3Wrh3Wv8juiYlgCuz4D0WE25bCEi6k2ZD7lMx8YZZYiaJwonZ02yytXTZeLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JoiYWpgU; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7061d37dc9bso237580b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 17:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718670988; x=1719275788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEWmDPoMo12cykcHwih1ojhthH/uwWR5UXgthNb4I/w=;
        b=JoiYWpgUqYhOpePZI9U0Iz+Sf9qDyZC+NVMTQQNwCDILD12P4xVotSf3zGAz+UNMWa
         QAlqLmeoHtbH3qzo0GX3Ulw8ej/uh+Oht5lnvNS2MfWxtBXTq+/ts8e7qI7xVUwDuiId
         vI5QbuKy2K66RK4b/G+8KqWKcKR6NpFHxW6vI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718670988; x=1719275788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VEWmDPoMo12cykcHwih1ojhthH/uwWR5UXgthNb4I/w=;
        b=qt9jqqYcsKTHlFaWkd3A6N1OLGxvb79yyf8zkPqrBCE4Ac4VXQhMQwSZp46PYvnN5j
         DcbMhcFr9kIFPoA/+7Vzek49NSPCTIftVUjC6eAnEGpMbQGoRnuOH84xYfTwZQc5sp97
         ePoXAx3HIE2Vgkog0VnwEulXzrvvC/eR5eqvB2BHQOj+7XUFdfE2O09JX4f70kOmtbsc
         dQFGK4emhAPh84u0uE0P8dJzpjp5nNRyjpBo0YAYDNJOn8EKCrtEboxjuep2NjPEHyGw
         D9B56ym8T+TAWgVoDmKopQB/sxowJFNTEfJUsW0lbhoIvmQvZsTMGLRJfW/yZ/WS5epE
         cLqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWylXkMXewo8rCDUcfr9Souw1a4TmkBF9viVD1Wa7j8h8o7d6WXOoiUdjEwiph0n6j4tMANkhtQBLI8cMvW0pYLtSkk5ELeBAijNgsm
X-Gm-Message-State: AOJu0YxQ8ZW9pOivwfRg5DsuZ3VH9BV0jWHpSOdNdGh8FqBFGS0KH93d
	UvXfau6/aWVdRpf57qan+1lRLjSb+BFGMjchniNz9PN6cdmv0QB4C/pVkmdlPw==
X-Google-Smtp-Source: AGHT+IHcS+Hse/fJJg1O9IV26jv3bMpCYWdJyd26Kg1l0YGDItSyEj7040XhsBUs2Hwl7q8TAGgYhg==
X-Received: by 2002:a62:e70c:0:b0:704:3aca:7833 with SMTP id d2e1a72fcca58-705d71d26bemr13591059b3a.31.1718670988500;
        Mon, 17 Jun 2024 17:36:28 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:1798:e71b:11ad:8b94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb99f4dsm7905917b3a.216.2024.06.17.17.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 17:36:27 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: kgdb-bugreport@lists.sourceforge.net,
	Douglas Anderson <dianders@chromium.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jason Wessel <jason.wessel@windriver.com>,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/13] kdb: Abstract out parsing for mdWcN
Date: Mon, 17 Jun 2024 17:34:45 -0700
Message-ID: <20240617173426.11.I899d035485269f5110a3323fbb1680fbba718e4c@changeid>
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

We'd like to use the "WcN" parsing for some other "md"
variants. Abstract it out.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/debug/kdb/kdb_main.c | 55 +++++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 9 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 6dcbf4ea4bcd..1a37c9bb505c 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -1591,6 +1591,49 @@ static void kdb_md_line(const char *fmtstr, unsigned long addr,
 
 #define KDB_MD_BYTES_PER_LINE	16
 
+/**
+ * kdb_md_parse_arg0() - Parse argv[0] for "md" command
+ *
+ * @cmd:         The name of the command, like "md"
+ * @arg0:        The value of argv[0].
+ * @repeat:      If argv0 modifies repeat count we'll adjust here.
+ * @bytesperword Ifargv0 modifies bytesperword we'll adjust here.
+ *
+ * Return: true if this was a valid cmd; false otherwise.
+ */
+static bool kdb_md_parse_arg0(const char *cmd, const char *arg0,
+			      int *repeat, int *bytesperword)
+{
+	int cmdlen = strlen(cmd);
+
+	/* arg0 must _start_ with the command string or it's a no-go. */
+	if (strncmp(cmd, arg0, cmdlen) != 0)
+		return false;
+
+	/* If it's just the base command, we're done and it's good. */
+	if (arg0[cmdlen] == '\0')
+		return true;
+
+	/*
+	 * The first byte after the base command must be bytes per word, a
+	 * digit. The actual value of bytesperword will be validated later.
+	 */
+	if (!isdigit(arg0[cmdlen]))
+		return false;
+	*bytesperword = (int)(arg0[cmdlen] - '0');
+	cmdlen++;
+
+	/* After the bytes per word must be end of string or a 'c'. */
+	if (arg0[cmdlen] == '\0')
+		return true;
+	if (arg0[cmdlen] != 'c')
+		return false;
+	cmdlen++;
+
+	/* After the "c" is the repeat. */
+	return kstrtouint(arg0 + cmdlen, 10, repeat) == 0;
+}
+
 static int kdb_md(int argc, const char **argv)
 {
 	static unsigned long last_addr;
@@ -1608,19 +1651,13 @@ static int kdb_md(int argc, const char **argv)
 	kdbgetintenv("RADIX", &radix);
 	kdbgetintenv("BYTESPERWORD", &bytesperword);
 
-	if (isdigit(argv[0][2])) {
-		bytesperword = (int)(argv[0][2] - '0');
-		if (!argv[0][3])
-			valid = true;
-		else if (argv[0][3] == 'c' && argv[0][4])
-			valid = kstrtouint(argv[0] + 4, 10, &repeat) == 0;
-	} else if (strcmp(argv[0], "md") == 0)
+	if (kdb_md_parse_arg0("md", argv[0], &repeat, &bytesperword))
 		valid = true;
 	else if (strcmp(argv[0], "mds") == 0)
 		valid = true;
-	else if (strcmp(argv[0], "mdp") == 0) {
+	else if (strcmp(argv[0], "mdp") == 0)
 		phys = valid = true;
-	}
+
 	if (!valid)
 		return KDB_NOTFOUND;
 
-- 
2.45.2.627.g7a2c4fd464-goog


