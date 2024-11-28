Return-Path: <linux-kernel+bounces-425117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E648E9DBD9A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 23:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA58B280A24
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 22:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6360A1C4A39;
	Thu, 28 Nov 2024 22:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BZm6Mnww";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G0yjPTMs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC2D1CB310
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 22:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732833047; cv=none; b=plZW/uFOLdH0G60s1dxxRH+G4IBQfYcE2HY8mUdF6PRQ819ezgcWwW5g+n8NRLb0kiOw6gcvCH21IF90weDBll1en+AiA/ksarcJ73eHCGtrlzkBzfmEANFtqnwyp+QRRWfMy6/QjgdaCGmXMSto5exLYSNRqYvs9uQ3lzo7BD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732833047; c=relaxed/simple;
	bh=hwGAJMLIEMvhV5pONSw35zuE2YThvMX9dCmE6oHPmiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/uLUVNNF8JbhU6EEpmqh8vuarJ/4/aq9qyh9aBWu6ulOfg2wOMTNb3qAfgJr1WmaSTvw6Dk4W1Lrg/FvoyAE+Yzb/DygMZKzVf7jxbhk18+lBPGlPwcdEYr5RuzAsu8Ozj6YugfWmWdfUJPDfo7I6eOA9zPTcxshqXJpXoRBno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BZm6Mnww; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G0yjPTMs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732833045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qjNTHolP58a0KrsdLGdWmYpxO/AhmCfcO4oFNjtSLVU=;
	b=BZm6MnwwdYq7Gt54czS3v4JIP2iAXdkdPLxsYHFUKSlrANTEtIteC34v8TvEsoW0o3WdmN
	yFvd8sxgUxIMe2rcxEtpZL5J/1X/tABbn4hXeeOw4clOyrqVIpFrn7Rn7xtXX3V7hHnu6y
	IQk6V7Rrj0X4/UaXLNqjk7Sh2fZv5ymCCaHKnrXAkI3Ect/E9xbASDLwGzEpluMRBXw3au
	LSVoUUJx3dr1SppL7mHZhATAxBrSfxODSUsgH12lQeem89EbYOGWJHwbJvjXO1XmmCgd6G
	W9pu44NhOrum/dvblTnqK9D3Z1JtZ4JWnBDLoymK6+enmPAfVLfIDmaV3J6Oqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732833045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qjNTHolP58a0KrsdLGdWmYpxO/AhmCfcO4oFNjtSLVU=;
	b=G0yjPTMsBROFGgLh3ctXtNQmsovETZiI130rwsmhFkXXYQUiQyKz4OCCQebza2OpNUhJcO
	/088PW+JgnB/lfDQ==
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 06/13] tools/x86/kcpuid: Simplify usage() handling
Date: Thu, 28 Nov 2024 23:29:41 +0100
Message-ID: <20241128222948.579920-7-darwi@linutronix.de>
In-Reply-To: <20241128222948.579920-1-darwi@linutronix.de>
References: <20241128222948.579920-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify usage() to take a process exit_code parameter and directly call
exit() after printing the usage string.  This simplifies the callers'
code paths.

Remove the manual "Invalid option" error message at option parsing,
since getopt_long(3) already prints sensible error messages by default.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index ac8fdfdc4844..c0f2eae0d694 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -11,6 +11,7 @@
 
 #define ARRAY_SIZE(x)	(sizeof(x) / sizeof((x)[0]))
 #define min(a, b)	(((a) < (b)) ? (a) : (b))
+#define __noreturn	__attribute__((__noreturn__))
 
 typedef unsigned int u32;
 typedef unsigned long long u64;
@@ -608,9 +609,9 @@ static void setup_platform_cpuid(void)
 	leafs_ext = setup_cpuid_range(0x80000000);
 }
 
-static void usage(void)
+static void __noreturn usage(int exit_code)
 {
-	pr_err("kcpuid [-abdfhr] [-l leaf] [-s subleaf]\n"
+	pr_err_exit(exit_code, "kcpuid [-abdfhr] [-l leaf] [-s subleaf]\n"
 		"\t-a|--all             Show both bit flags and complex bit fields info\n"
 		"\t-b|--bitflags        Show boolean flags only\n"
 		"\t-d|--detail          Show details of the flag/fields (default)\n"
@@ -634,7 +635,7 @@ static struct option opts[] = {
 	{ NULL, 0, NULL, 0 }
 };
 
-static int parse_options(int argc, char *argv[])
+static void parse_options(int argc, char *argv[])
 {
 	int c;
 
@@ -654,9 +655,7 @@ static int parse_options(int argc, char *argv[])
 			user_csv = optarg;
 			break;
 		case 'h':
-			usage();
-			exit(1);
-			break;
+			usage(EXIT_SUCCESS);
 		case 'l':
 			/* main leaf */
 			user_index = strtoul(optarg, NULL, 0);
@@ -669,11 +668,8 @@ static int parse_options(int argc, char *argv[])
 			user_sub = strtoul(optarg, NULL, 0);
 			break;
 		default:
-			pr_err("%s: Invalid option '%c'\n", argv[0], optopt);
-			return -1;
-	}
-
-	return 0;
+			usage(EXIT_FAILURE);
+		}
 }
 
 /*
@@ -686,8 +682,7 @@ static int parse_options(int argc, char *argv[])
  */
 int main(int argc, char *argv[])
 {
-	if (parse_options(argc, argv))
-		return -1;
+	parse_options(argc, argv);
 
 	/* Setup the cpuid leafs of current platform */
 	setup_platform_cpuid();
-- 
2.46.2


