Return-Path: <linux-kernel+bounces-218477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AD490C066
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 165341C20E6E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5761CD3C;
	Tue, 18 Jun 2024 00:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SKhJKzOW"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D88817740
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 00:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718670976; cv=none; b=MBBWREsYMNL4mpZJbM7zyP4OF47lErVQ3LQ9oTk0ZSGiDTzKZMFGkVdxpcmkbSDUyUvha6i2UoB2YJ9+1aciElspQo0n3s29uQ2WE7BPkPCrCl60DgVeTc1MQXq/b/SYxYRhAAgdjNTOscn3s8Ltk5Cm+/7Yd9gV/Xw+/88hA/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718670976; c=relaxed/simple;
	bh=/SSjdDVqQyNT/TV3r0qmTYxjOdxHSoIZQX5aOSOSlPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtMpgIMIW+rt+S/FtRmD2H1iZ9maS+uANOu0TzASmhZu+EiBHw00NEPAyX5c9TI0X0DcT7XsZddOSFgnaNZSIqit6wsc45MXWReE8x9jFeztr+lCNDLTJG5rP9bqrWt5i9mo9cSPQuDLWO26g1PYWgY+m5gJx7VdYV3HJmEPPQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SKhJKzOW; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70436048c25so3768592b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 17:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718670974; x=1719275774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQYuSB3bJKGmbINp6Hrk5oG47YXbeJRhUUPAWV3K+Mo=;
        b=SKhJKzOWx030ch0VS4NeoRJ+zHLJ6SUqRnK3U7Or46zRGfjnPC6DHmHHJq3YM5q21y
         E1tA+x1ctAl2pwVQA5CeGTyiHEcYBWiIZg0qydN4Lq0IRBgvvpi70vMacz4fnOZMyPtb
         f99tYZWh1/Zerz/0VKuPHSuz6Byzw5jqBlmPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718670974; x=1719275774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQYuSB3bJKGmbINp6Hrk5oG47YXbeJRhUUPAWV3K+Mo=;
        b=NSzu03+O2glPE+VIn2i6LcAxqLQ7QvfOqWKSylLgIJyvuwjsS/mDxvuj77qmZkjHt/
         /r9jGMcovNGrH1ejXlfhvs0DFW1Hcu9cHphWu1Qf/vYRs68pjOk/d2XrfJF6Rt8mXvXV
         q7FyXTuzGTcMVg/K3p2Z+vc5YPgslu0JMsbrd3xtS1k4x2f/Y+G12GWn33YNQUjl7YQH
         V2S/c8yERBHK8lwdSe+IMd2U2n04gN+ewprWwU6BVAFaoWqZPlBNMZ34hpATrjwsdOCf
         Q07dGhTbTfkZgU4w755ukfFz2/2ULOdsVdsbaNrc1f8aJBUO1/bG/daBuCCHojOHBKqs
         mzSA==
X-Forwarded-Encrypted: i=1; AJvYcCXXLGQ2ye//io0R/GW9iJh+MvSsGrm10C3Vgdd676M/xSUxc9jAMEN4qjPtNgeBz2X26qAfV/iFCUj63RFenAE1o8NAmJaQyb8ZnffA
X-Gm-Message-State: AOJu0YyTXW8BC8aWEctP2+NlsL3qZn/d/oEay5/9MkoIqGYtqBOhwu0g
	PpHpbTyq08tPeAs2rnFusYRKF5yEbOAVGBYxLWBL82ndLIo0dwy/VCdm+D2PbQ==
X-Google-Smtp-Source: AGHT+IEeFrChFFKl6KwDuaajAmeP4HwLauX0HfkUNOPVlvxpRkkIIlBcTlhqDr0oERw4GC7UM86DHw==
X-Received: by 2002:a05:6a21:339f:b0:1b6:3fc5:d08b with SMTP id adf61e73a8af0-1bae823dbb8mr11068909637.40.1718670973958;
        Mon, 17 Jun 2024 17:36:13 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:1798:e71b:11ad:8b94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb99f4dsm7905917b3a.216.2024.06.17.17.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 17:36:12 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: kgdb-bugreport@lists.sourceforge.net,
	Douglas Anderson <dianders@chromium.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jason Wessel <jason.wessel@windriver.com>,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/13] kdb: Drop "offset" and "name" args to kdbgetaddrarg()
Date: Mon, 17 Jun 2024 17:34:38 -0700
Message-ID: <20240617173426.4.Ie746acb6e0908f2f3328878e4aba7661d3daad7c@changeid>
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

Every caller to kdbgetaddrarg() didn't care about the "offset" and
"name" returned by the function. Some passed NULL and some passed the
address of a bogus local variable that was never looked at. Drop the
arguments.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/debug/kdb/kdb_bp.c      |  5 +----
 kernel/debug/kdb/kdb_bt.c      |  4 +---
 kernel/debug/kdb/kdb_main.c    | 37 ++++++++--------------------------
 kernel/debug/kdb/kdb_private.h |  4 ++--
 4 files changed, 12 insertions(+), 38 deletions(-)

diff --git a/kernel/debug/kdb/kdb_bp.c b/kernel/debug/kdb/kdb_bp.c
index 372025cf1ca3..98659f7dd744 100644
--- a/kernel/debug/kdb/kdb_bp.c
+++ b/kernel/debug/kdb/kdb_bp.c
@@ -279,8 +279,6 @@ static int kdb_bp(int argc, const char **argv)
 	int i, bpno;
 	kdb_bp_t *bp, *bp_check;
 	int diag;
-	char *symname = NULL;
-	long offset = 0ul;
 	int nextarg;
 	kdb_bp_t template = {0};
 
@@ -299,8 +297,7 @@ static int kdb_bp(int argc, const char **argv)
 	}
 
 	nextarg = 1;
-	diag = kdbgetaddrarg(argc, argv, &nextarg, &template.bp_addr,
-			     &offset, &symname);
+	diag = kdbgetaddrarg(argc, argv, &nextarg, &template.bp_addr);
 	if (diag)
 		return diag;
 	if (!template.bp_addr)
diff --git a/kernel/debug/kdb/kdb_bt.c b/kernel/debug/kdb/kdb_bt.c
index 10b454554ab0..af86744c1e2f 100644
--- a/kernel/debug/kdb/kdb_bt.c
+++ b/kernel/debug/kdb/kdb_bt.c
@@ -130,7 +130,6 @@ kdb_bt(int argc, const char **argv)
 	int btaprompt = 1;
 	int nextarg;
 	unsigned long addr;
-	long offset;
 
 	/* Prompt after each proc in bta */
 	kdbgetintenv("BTAPROMPT", &btaprompt);
@@ -205,8 +204,7 @@ kdb_bt(int argc, const char **argv)
 	} else {
 		if (argc) {
 			nextarg = 1;
-			diag = kdbgetaddrarg(argc, argv, &nextarg, &addr,
-					     &offset, NULL);
+			diag = kdbgetaddrarg(argc, argv, &nextarg, &addr);
 			if (diag)
 				return diag;
 			kdb_show_stack(kdb_current_task, (void *)addr);
diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 88121334d189..74db5c0cc5ad 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -532,16 +532,12 @@ static int kdb_check_regs(void)
  *	regs	- Register state at time of KDB entry
  * Outputs:
  *	*value	- receives the value of the address-expression
- *	*offset - receives the offset specified, if any
- *	*name   - receives the symbol name, if any
  *	*nextarg - index to next unparsed argument in argv[]
  * Returns:
  *	zero is returned on success, a kdb diagnostic code is
  *      returned on error.
  */
-int kdbgetaddrarg(int argc, const char **argv, int *nextarg,
-		  unsigned long *value,  long *offset,
-		  char **name)
+int kdbgetaddrarg(int argc, const char **argv, int *nextarg, unsigned long *value)
 {
 	unsigned long addr;
 	unsigned long off = 0;
@@ -615,12 +611,8 @@ int kdbgetaddrarg(int argc, const char **argv, int *nextarg,
 
 	(*nextarg)++;
 
-	if (name)
-		*name = symname;
 	if (value)
 		*value = addr;
-	if (offset && name && *name)
-		*offset = addr - symtab.sym_start;
 
 	if ((*nextarg > argc)
 	 && (symbol == '\0'))
@@ -664,9 +656,6 @@ int kdbgetaddrarg(int argc, const char **argv, int *nextarg,
 	if (!positive)
 		off = -off;
 
-	if (offset)
-		*offset += off;
-
 	if (value)
 		*value += off;
 
@@ -1116,14 +1105,10 @@ int kdb_parse(const char *cmdstr)
 	 */
 	{
 		unsigned long value;
-		char *name = NULL;
-		long offset;
 		int nextarg = 0;
 
-		if (kdbgetaddrarg(0, (const char **)argv, &nextarg,
-				  &value, &offset, &name)) {
+		if (kdbgetaddrarg(0, (const char **)argv, &nextarg, &value))
 			return KDB_NOTFOUND;
-		}
 
 		kdb_printf("%s = ", argv[0]);
 		kdb_symbol_print(value, NULL, KDB_SP_DEFAULT);
@@ -1593,7 +1578,6 @@ static int kdb_md(int argc, const char **argv)
 	char fmtchar, fmtstr[64];
 	unsigned long addr;
 	unsigned long word;
-	long offset = 0;
 	bool nosect = false;
 	bool symbolic = false;
 	bool valid = false;
@@ -1656,8 +1640,7 @@ static int kdb_md(int argc, const char **argv)
 	if (argc) {
 		unsigned long val;
 		int diag, nextarg = 1;
-		diag = kdbgetaddrarg(argc, argv, &nextarg, &addr,
-				     &offset, NULL);
+		diag = kdbgetaddrarg(argc, argv, &nextarg, &addr);
 		if (diag)
 			return diag;
 		if (argc > nextarg+2)
@@ -1793,7 +1776,6 @@ static int kdb_mm(int argc, const char **argv)
 {
 	int diag;
 	unsigned long addr;
-	long offset = 0;
 	unsigned long contents;
 	int nextarg;
 	int width;
@@ -1805,13 +1787,13 @@ static int kdb_mm(int argc, const char **argv)
 		return KDB_ARGCOUNT;
 
 	nextarg = 1;
-	diag = kdbgetaddrarg(argc, argv, &nextarg, &addr, &offset, NULL);
+	diag = kdbgetaddrarg(argc, argv, &nextarg, &addr);
 	if (diag)
 		return diag;
 
 	if (nextarg > argc)
 		return KDB_ARGCOUNT;
-	diag = kdbgetaddrarg(argc, argv, &nextarg, &contents, NULL, NULL);
+	diag = kdbgetaddrarg(argc, argv, &nextarg, &contents);
 	if (diag)
 		return diag;
 
@@ -1837,7 +1819,6 @@ static int kdb_go(int argc, const char **argv)
 	unsigned long addr;
 	int diag;
 	int nextarg;
-	long offset;
 
 	if (raw_smp_processor_id() != kdb_initial_cpu) {
 		kdb_printf("go must execute on the entry cpu, "
@@ -1847,8 +1828,7 @@ static int kdb_go(int argc, const char **argv)
 	}
 	if (argc == 1) {
 		nextarg = 1;
-		diag = kdbgetaddrarg(argc, argv, &nextarg,
-				     &addr, &offset, NULL);
+		diag = kdbgetaddrarg(argc, argv, &nextarg, &addr);
 		if (diag)
 			return diag;
 	} else if (argc) {
@@ -2043,14 +2023,13 @@ static int kdb_ef(int argc, const char **argv)
 {
 	int diag;
 	unsigned long addr;
-	long offset;
 	int nextarg;
 
 	if (argc != 1)
 		return KDB_ARGCOUNT;
 
 	nextarg = 1;
-	diag = kdbgetaddrarg(argc, argv, &nextarg, &addr, &offset, NULL);
+	diag = kdbgetaddrarg(argc, argv, &nextarg, &addr);
 	if (diag)
 		return diag;
 	show_regs((struct pt_regs *)addr);
@@ -2547,7 +2526,7 @@ static int kdb_per_cpu(int argc, const char **argv)
 	if (argc < 1 || argc > 3)
 		return KDB_ARGCOUNT;
 
-	diag = kdbgetaddrarg(argc, argv, &nextarg, &symaddr, NULL, NULL);
+	diag = kdbgetaddrarg(argc, argv, &nextarg, &symaddr);
 	if (diag)
 		return diag;
 
diff --git a/kernel/debug/kdb/kdb_private.h b/kernel/debug/kdb/kdb_private.h
index 548fd4059bf9..1f685d9f16f9 100644
--- a/kernel/debug/kdb/kdb_private.h
+++ b/kernel/debug/kdb/kdb_private.h
@@ -105,8 +105,8 @@ extern int kdb_putword(unsigned long, unsigned long, size_t);
 extern int kdbgetularg(const char *, unsigned long *);
 extern int kdbgetu64arg(const char *, u64 *);
 extern char *kdbgetenv(const char *);
-extern int kdbgetaddrarg(int, const char **, int*, unsigned long *,
-			 long *, char **);
+extern int kdbgetaddrarg(int argc, const char **argv, int *nextarg,
+			 unsigned long *value);
 extern int kdbgetsymval(const char *, kdb_symtab_t *);
 extern int kdbnearsym(unsigned long, kdb_symtab_t *);
 extern char *kdb_strdup(const char *str, gfp_t type);
-- 
2.45.2.627.g7a2c4fd464-goog


