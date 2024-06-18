Return-Path: <linux-kernel+bounces-218481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEC390C06C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFC811C21973
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A464F2D047;
	Tue, 18 Jun 2024 00:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j44UerGw"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ED02AC17
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 00:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718670984; cv=none; b=gTADbesFlQ7r1XCjLPu3cRIhI008GjFIDsTX4ow1mHx4m0T6MzVjFDChHMDbZv/rCSrNDDnXO6RCZ0TOfq29CW4BtM6IFlImV918wFIHxLZA1zVxFOKxBXXqh1HOLDuRXdRpugV+fpVM2YsHFD4bif6NwPrA77JsT3RvFOa0Mcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718670984; c=relaxed/simple;
	bh=GzKjrmPoaOGIYKdY1FU4/JkYXj3Io1DSQNGDw3f/H5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZDW4Afq4kK0v5JPlh+CfyEWrV2kHMzc1NTKI/Bfd9yg84Gz3vSXFNv+arkr6pbbJrMZY+Cafyg5uoFp7pA67eYHSDzgXylOqrjiUZPyTnKOVy3zqTQqhr6BrY+nqDFMVJg2jF+t4YlqPZL7CM3ylo/uzPgy/t6XZ2QDA0Ufr+2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j44UerGw; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-705c0115192so4199937b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 17:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718670983; x=1719275783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sujWDpCzra7eIXbOVVbr0PMepNxb1U/8UIoM+bv67a4=;
        b=j44UerGwTXzvKgLBTnXOtVMLbBqz8xwJJeRRoNPDk8BoPQu7TVEVebblWSO6nhEA1S
         D7PU8hTtX/EH9NP3fkSEomFeBqkI2Y7eQb/Z59Ah4yg2guVRHkNd39r3LwS91Aaz7Mqg
         vlEhymEFfnWLGXKCpPlGWahSmIUyWx8675qmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718670983; x=1719275783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sujWDpCzra7eIXbOVVbr0PMepNxb1U/8UIoM+bv67a4=;
        b=BLZqe/icDlA7S6TUjnMBdGDMiVJlsCbMWsmtPTnDcGDHFVNh6I0hD+G2plq5QY618x
         f+61Z0RobtAce1ddaYZobMhTSsIGVA+BoLC9MgD/Mz+JSOf7CRgB4cSkOAgw7BmglU+D
         mT3Nuz5DJhiY0sakx0McORSEtTDOiLGMOj+5EMpKr/UrN/7DKq8ysxaxJrCRUDTYbsPE
         JbWIQqdklTfhHUOes+AfbJJm2LlSzrSc/NMldEchZePs7T0vWiPVyqB1NipjWMddRQff
         3IzG23jV98bjxfR/8B6Tz+30pNWqg3vIXZWg6BjEJ3HrP1W8ArxKBXo34E3oawz9sJI7
         7EmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdLvZf1kPe9vrL1ECsd8Jrjefc7EiImRgh5yRQFEs09z2AA/N9eOVvmZCw1nMV923z9juVZUl9aM2TQpWk/kIE0pbB973G74TDmhQT
X-Gm-Message-State: AOJu0YzAneUzcjzN/jBIBp+BAUOnLGFPw1u0QNGCwNDRHz6lVJ72XzYY
	pLAosvz9aAj2pxRl3u3Av5TSh6xMV1IyE9YWNANnm/feDAMMLdMnPYIqKNF70Q==
X-Google-Smtp-Source: AGHT+IEpLA4qgnpA8ZWxX9YCGcU2lRZ/Y4MNvcbNAa0jXwRiQQf5WO3er5XcyvNMnCp+sB+SFmxdkg==
X-Received: by 2002:a62:b50c:0:b0:705:94ac:4ab7 with SMTP id d2e1a72fcca58-705d71bd511mr12541879b3a.23.1718670982803;
        Mon, 17 Jun 2024 17:36:22 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:1798:e71b:11ad:8b94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb99f4dsm7905917b3a.216.2024.06.17.17.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 17:36:21 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: kgdb-bugreport@lists.sourceforge.net,
	Douglas Anderson <dianders@chromium.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jason Wessel <jason.wessel@windriver.com>,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/13] kdb: In kdb_md() make `repeat` and `mdcount` calculations more obvious
Date: Mon, 17 Jun 2024 17:34:42 -0700
Message-ID: <20240617173426.8.I542e6a7facc29bb6c13e1c39e002b92b643d6d42@changeid>
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

In kdb_md(), the `mdcount` variable is the number of lines that the
"md" command will output.

In kdb_md(), the `repeat` variable is the number of "words" that the
"md" command will output.

The relationship between these two variables and how they are
specified is a bit convoluted.

You can adjust `mdcount` via the MDCOUNT environment variable. You can
then override the MDCOUNT environment variable by passing a number of
<lines> as an argument to the command.

You can adjust `repeat` using the `mdWcN` variant of the command where
"N" is the number of words to output.

The rules for how these get applied right now:
* By default, we'll the MDCOUNT environment variable.
* If `mdWcN` is used, the repeat will override.
* If <lines> is specified, the mdcount will override.
* When we're "repeating" a previous command (AKA argc is 0) then we'll
  load in the last_repeat.

If you've specified `repeat` then the `mdcount` can be calculated as:
  mdcount = DIV_ROUND_UP(repeat * bytes_per_word, bytes_per_line)

In other words, if you want to display 9 words, each word is 2 bytes,
and you want 16 bytes per line then you'll take up 2 lines. This would
look like:
  [1]kdb> md2c9 0xffffff80e000c340
  0xffffff80e000c340 0204 0000 0000 0000 e000 8235 0000 0000
  0xffffff80e000c350 0003

If you've specified `mdcount` then `repeat` is simply:
  repeat = mdcount * bytes_per_line / bytes_per_word

Let's make all this logic more obvious by initializing `repeat` to 0
and then setting it to non-zero when it should override. Then we can
do all the math at once.

While changing this, use the proper DIV_ROUND_UP() macro and introcue
a constant for KDB_MD_BYTES_PER_LINE. We'll also make and "if else"
more obvious so we know things always get initialized.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/debug/kdb/kdb_main.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 3c6fffa8509a..fcd5292351a7 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -1589,11 +1589,13 @@ static void kdb_md_line(const char *fmtstr, unsigned long addr,
 		   " ", cbuf);
 }
 
+#define KDB_MD_BYTES_PER_LINE	16
+
 static int kdb_md(int argc, const char **argv)
 {
 	static unsigned long last_addr;
 	static int last_radix, last_bytesperword, last_repeat;
-	int radix = 16, mdcount = 8, bytesperword = KDB_WORD_SIZE, repeat;
+	int radix = 16, mdcount = 8, bytesperword = KDB_WORD_SIZE, repeat = 0;
 	char fmtchar, fmtstr[64];
 	unsigned long addr;
 	unsigned long word;
@@ -1606,18 +1608,13 @@ static int kdb_md(int argc, const char **argv)
 	kdbgetintenv("RADIX", &radix);
 	kdbgetintenv("BYTESPERWORD", &bytesperword);
 
-	/* Assume 'md <addr>' and start with environment values */
-	repeat = mdcount * 16 / bytesperword;
-
 	if (isdigit(argv[0][2])) {
 		bytesperword = (int)(argv[0][2] - '0');
-		repeat = mdcount * 16 / bytesperword;
 		if (!argv[0][3])
 			valid = true;
 		else if (argv[0][3] == 'c' && argv[0][4]) {
 			char *p;
 			repeat = simple_strtoul(argv[0] + 4, &p, 10);
-			mdcount = ((repeat * bytesperword) + 15) / 16;
 			valid = !*p;
 		}
 	} else if (strcmp(argv[0], "md") == 0)
@@ -1637,10 +1634,7 @@ static int kdb_md(int argc, const char **argv)
 		radix = last_radix;
 		bytesperword = last_bytesperword;
 		repeat = last_repeat;
-		mdcount = ((repeat * bytesperword) + 15) / 16;
-	}
-
-	if (argc) {
+	} else {
 		unsigned long val;
 		int diag, nextarg = 1;
 		diag = kdbgetaddrarg(argc, argv, &nextarg, &addr);
@@ -1652,8 +1646,9 @@ static int kdb_md(int argc, const char **argv)
 		if (argc >= nextarg) {
 			diag = kdbgetularg(argv[nextarg], &val);
 			if (!diag) {
-				mdcount = (int) val;
-				repeat = mdcount * 16 / bytesperword;
+				mdcount = val;
+				/* Specifying <lines> overrides repeat count. */
+				repeat = 0;
 			}
 		}
 		if (argc >= nextarg+1) {
@@ -1699,6 +1694,13 @@ static int kdb_md(int argc, const char **argv)
 		return KDB_BADWIDTH;
 	}
 
+	/* If repeat is non-zero then it overrides */
+	if (repeat)
+		mdcount = DIV_ROUND_UP(repeat * bytesperword, KDB_MD_BYTES_PER_LINE);
+	else
+		repeat = mdcount * 16 / bytesperword;
+
+	/* Always just save `repeat` since `mdcount` can be calculated from it */
 	last_repeat = repeat;
 	last_bytesperword = bytesperword;
 
-- 
2.45.2.627.g7a2c4fd464-goog


