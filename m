Return-Path: <linux-kernel+bounces-218478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7691E90C068
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2919B2295D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3684C208A0;
	Tue, 18 Jun 2024 00:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZM0MxyIP"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F8D1CD2D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 00:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718670978; cv=none; b=Sm93WGTt0obEjOgP6nfjZ0PRRX96DvnlfaG31is3l+7cmDi2NllEXMUtwOKL0YoO3wYBdYkAK4o0anbLraxb98OHtq46zjnWbXuBX/HuphIo5YK77HBtJrxED+DnNpMTuXu3Hqs2e7yR78gTD3dwcbJHZGXca2rhxb+BsjJ5Gb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718670978; c=relaxed/simple;
	bh=PvC8MJAkjfyVNSqDlr6ZTCW69VpT5LCALdZyMxYPxZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mTISA+VkNSwVny7qbnC/CL53VWm2yvajKe65ysOzzCWaxKLNBaKwHemgComk6+PhFEqj1+Xvys7nzpLpQBJJ4PnwlEbCH+dCEfV4nG9ECGxE82IDP6g8BtPkkiXMoiBZ62m27Rk2F4h9G4K9r3Y5f5cWQE7KCdGc2Ju/Rm+h85w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZM0MxyIP; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-703ed15b273so3694974b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 17:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718670976; x=1719275776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9UVS8jw65Qz1/+IKa1gxs23pkU4dvWn+yfPVR/mXAo=;
        b=ZM0MxyIP5ogiTpz3hrhlLxvGAjJiWcD9qS8R5Hx4JVDVwBsCQkmYTByTJjcrC8gqYY
         1X+NUJcAx1BpUsvpgfc20nW0yheaRDgM45uAnXt9dTKNH5Ll1wj4fVmkLHIMr24wEnol
         BICMYZUC6/n4o39SWFmEgoSBdbumwNuwLfY8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718670976; x=1719275776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9UVS8jw65Qz1/+IKa1gxs23pkU4dvWn+yfPVR/mXAo=;
        b=A/+O6W5WEy6lqIkHKQMMmEPZIoo2/HcLAdBlBoNpCaZXZyAyfqUkA2rfoqKzUAP1KT
         IMHbz/3vRvG5S6prQOxTNQnZi0bo5N8ae7yFL3r8x1LtTGMufotI5kWviyynaTLXELnh
         7DEsHTnGTwzAdDnHPraiYflul0x9qOQyJirzi9R9tpndsS2Voa55NyZnD3jscZuVM6CZ
         SzfOjEx6YeT8UuRbMwC4Sq7MWE8mN+ZLgogkaMoyxnQPP+dzq9eOQpjp1gmqw5OS1sju
         Wb1Pg6wpap/ZuFUamC7bu9e/JeNBUJqsvfKw/9rHFda1pr0QaZYDBDDTilL4wuohNlEF
         XctQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwCK4qoGc6Q8fRp4vjUHn0+IuhVOSfVv8d894VmJL/41W0cyl5C+HJolvMPQvF8H6aECT/8YToT3+qhzzSmlFRp8JL0XvZ2wbeB9of
X-Gm-Message-State: AOJu0YzGeszYM3z3+VY+7P+hnd2ApufZKtkvfqzgBiv00o+huyALXknZ
	vVQPQy76tMMVpWEg0gNinu7X9NrAfpuoPbFacxyzOVL2YlezZ/72Kcg6bmRib9kSPySkCMDjcSQ
	=
X-Google-Smtp-Source: AGHT+IFNSXKhTjNPopEgrBnDWo98qLA1DR2sonPJKag3KcUKtT0bl/mkZiZsBPqQEuWwT7WklHnpPA==
X-Received: by 2002:a05:6a20:3d84:b0:1b6:e885:1bb4 with SMTP id adf61e73a8af0-1bae7f30cd4mr12933946637.37.1718670976149;
        Mon, 17 Jun 2024 17:36:16 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:1798:e71b:11ad:8b94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb99f4dsm7905917b3a.216.2024.06.17.17.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 17:36:14 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: kgdb-bugreport@lists.sourceforge.net,
	Douglas Anderson <dianders@chromium.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jason Wessel <jason.wessel@windriver.com>,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/13] kdb: Separate out "mdr" handling
Date: Mon, 17 Jun 2024 17:34:39 -0700
Message-ID: <20240617173426.5.I2d17f61d496641d28c778be587b36d138a211e50@changeid>
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

Though the "mdr" has a similar purpose to the other "md" commands in
that they all display memory, the actual code to implement it has
almost nothing in common with the rest of the commands. Separate
things out.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/debug/kdb/kdb_main.c | 65 ++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 34 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 74db5c0cc5ad..c013b014a7d3 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -1480,23 +1480,42 @@ int kdb_main_loop(kdb_reason_t reason, kdb_reason_t reason2, int error,
 /*
  * kdb_mdr - This function implements the guts of the 'mdr', memory
  * read command.
- *	mdr  <addr arg>,<byte count>
- * Inputs:
- *	addr	Start address
- *	count	Number of bytes
- * Returns:
- *	Always 0.  Any errors are detected and printed by kdb_getarea.
+ *	mdr  <addr arg> <byte count>
  */
-static int kdb_mdr(unsigned long addr, unsigned int count)
+static int kdb_mdr(int argc, const char **argv)
 {
+	static unsigned long addr;
+	static unsigned long count;
 	unsigned char c;
-	while (count--) {
+	unsigned long i;
+	int diag;
+
+	/*
+	 * Parse args. The only valid options are argc == 2 (both address and
+	 * byte_count provided) and argc == 0 ("repeat" AKA continue previous
+	 * display).
+	 */
+	if (argc == 2) {
+		int nextarg = 1;
+
+		diag = kdbgetaddrarg(argc, argv, &nextarg, &addr);
+		if (diag)
+			return diag;
+		diag = kdbgetularg(argv[nextarg], &count);
+		if (diag)
+			return diag;
+	} else if (argc != 0) {
+		return KDB_ARGCOUNT;
+	}
+
+	for (i = 0; i < count; i++) {
 		if (kdb_getarea(c, addr))
 			return 0;
 		kdb_printf("%02x", c);
 		addr++;
 	}
 	kdb_printf("\n");
+
 	return 0;
 }
 
@@ -1582,7 +1601,6 @@ static int kdb_md(int argc, const char **argv)
 	bool symbolic = false;
 	bool valid = false;
 	bool phys = false;
-	bool raw = false;
 
 	kdbgetintenv("MDCOUNT", &mdcount);
 	kdbgetintenv("RADIX", &radix);
@@ -1591,12 +1609,7 @@ static int kdb_md(int argc, const char **argv)
 	/* Assume 'md <addr>' and start with environment values */
 	repeat = mdcount * 16 / bytesperword;
 
-	if (strcmp(argv[0], "mdr") == 0) {
-		if (argc == 2 || (argc == 0 && last_addr != 0))
-			valid = raw = true;
-		else
-			return KDB_ARGCOUNT;
-	} else if (isdigit(argv[0][2])) {
+	if (isdigit(argv[0][2])) {
 		bytesperword = (int)(argv[0][2] - '0');
 		if (bytesperword == 0) {
 			bytesperword = last_bytesperword;
@@ -1631,10 +1644,7 @@ static int kdb_md(int argc, const char **argv)
 		radix = last_radix;
 		bytesperword = last_bytesperword;
 		repeat = last_repeat;
-		if (raw)
-			mdcount = repeat;
-		else
-			mdcount = ((repeat * bytesperword) + 15) / 16;
+		mdcount = ((repeat * bytesperword) + 15) / 16;
 	}
 
 	if (argc) {
@@ -1650,10 +1660,7 @@ static int kdb_md(int argc, const char **argv)
 			diag = kdbgetularg(argv[nextarg], &val);
 			if (!diag) {
 				mdcount = (int) val;
-				if (raw)
-					repeat = mdcount;
-				else
-					repeat = mdcount * 16 / bytesperword;
+				repeat = mdcount * 16 / bytesperword;
 			}
 		}
 		if (argc >= nextarg+1) {
@@ -1663,16 +1670,6 @@ static int kdb_md(int argc, const char **argv)
 		}
 	}
 
-	if (strcmp(argv[0], "mdr") == 0) {
-		int ret;
-		last_addr = addr;
-		ret = kdb_mdr(addr, mdcount);
-		last_addr += mdcount;
-		last_repeat = mdcount;
-		last_bytesperword = bytesperword; // to make REPEAT happy
-		return ret;
-	}
-
 	switch (radix) {
 	case 10:
 		fmtchar = 'd';
@@ -2680,7 +2677,7 @@ static kdbtab_t maintab[] = {
 		.flags = KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS,
 	},
 	{	.name = "mdr",
-		.func = kdb_md,
+		.func = kdb_mdr,
 		.usage = "<vaddr> <bytes>",
 		.help = "Display RAM as a stream of raw bytes",
 		.flags = KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS,
-- 
2.45.2.627.g7a2c4fd464-goog


