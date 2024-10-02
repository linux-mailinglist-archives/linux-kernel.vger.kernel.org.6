Return-Path: <linux-kernel+bounces-347571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A69CE98D54C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7BE1B21459
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80961D07A4;
	Wed,  2 Oct 2024 13:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiJtisTL"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDA71D079F
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 13:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875722; cv=none; b=cou0Kld1cSprMlYyCKz/V2JYs1plJv93TDGKN6T9o5FsSxeVwjbFpZhOp6AYBxBZWnmkwMj0Zfbq/qPV4kLtGtEhnmRTSRxzFOFcpjWUl1tVK4el5KVNL3ZPrqSI6Lzm5q/uJrM4KWNRiLFCCJsWg8F9KPwv4E/hSIcWcDyAN8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875722; c=relaxed/simple;
	bh=mhnKnU8rdMj0sW3SFgbHHVxiisiwu2M/aDnvEBSgBjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S96iCVOzTPoCUju87n0VtTIY3qUef+RNZWjCMn6TKoBHE9DjphclAlLnIEYQZYpab9/pS/Xz+9DU+EtlJ6HdX5zp6ket4ZvP5SdnZ7i5aXtWnpLHGLJk16HWQ4X5PpoTZeki8UVIvrMhRQTBfoC88WYv2C3ecIPVyGprNjVwWmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TiJtisTL; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e0b93157caso623752a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 06:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727875721; x=1728480521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kqV0hhMV4XU1vtj9qv793+75v5wEJntzm0L0TlA+3k=;
        b=TiJtisTL3/vaPJ766+5R5QYwKoGapq4E31ytDZNbKXcvJUoSLyiMJ3jCBt4LjmicK6
         VEdMTJwMF4tFofYwEhm8qeoYPX+GjMOn93eSQ/it0UNxurVDBNN0DgstHDLItbVBVjJw
         oiy8mLiP07DMKMaPKDF6jrYt72Ah6XTYJFa5uD1hJNYB49FitsgEHD7i+Mybwyeeobp5
         x3dqDhKRPJfSi11i+T0VF0sCYQlZR9+L7rEGI1dICqvx89m2GyRRxhmlNNIwikwlKpTv
         irFSIAnXAVBq8IXqF/uWjxPXD+piaonQxBBW1DBB75ZmoigNJAPfKTXaVMFMLv/1DhUC
         /VLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727875721; x=1728480521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7kqV0hhMV4XU1vtj9qv793+75v5wEJntzm0L0TlA+3k=;
        b=d77N1mjNyxh005p7VSYHebjfArfXZnlpeGKxk0E2Qt14cMReXKpyelHeU1xblQqRMK
         wv4T9QmndLvzoWjtkLqoUK+DJ3FaC277zv0tzP8aXS3RdLvRPdMCuxVR6b31ki/a+XKY
         SSrPwruwaWdVm2NupdDXlL7YP0vJcN+cRghDSBDzrkCqhINAXmp9AbSxqfsVslc+uoOd
         IwYDvXmYvlErY+e9h8PLaCmBHtfuMtDT7/uQhThm6KiVkX9l0ushNg8dcfJBisoo/pMq
         IiLyIl012E+ricdW8ZxLM8il2j2bnThFE80U44ipi8SUTtuL0eUCZTUP8XNahQsoBDjE
         ugUw==
X-Forwarded-Encrypted: i=1; AJvYcCVmgvBNHoNpIzmkYHlV8mKQVER5MIYnd+0T5Hz6FhID0NMvW77jL/PdYWONKca8q6H9fRG7d1VRPARQoGY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ypGroELbO64sUIzLuyTCplQKYUOOlswwwrrv8c5IorL1+pDu
	+WSZW6Br3ef1+PyRHn4kYCX3aD/4f5vxFbesdtY5hHAGoqPFCm3Y
X-Google-Smtp-Source: AGHT+IFk4CEfvducnh8DZ0alqr9jF7CHoxMZVrq7RrbLuA9DZBmGQqJoVex34/Xgof2lBJR7fADQFA==
X-Received: by 2002:a17:90b:1643:b0:2e0:89f2:f60c with SMTP id 98e67ed59e1d1-2e18522076bmr4844410a91.11.1727875720516;
        Wed, 02 Oct 2024 06:28:40 -0700 (PDT)
Received: from debian.tail629bbc.ts.net ([103.57.173.123])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f7734basm1528740a91.19.2024.10.02.06.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 06:28:40 -0700 (PDT)
From: Sayyad Abid <sayyad.abid16@gmail.com>
To: linux-m68k@lists.linux-m68k.org
Cc: fthain@linux-m68k.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	sayyad.abid16@gmail.com
Subject: [PATCH 3/3] drivers: nubus: Fix use of * in comment block in nubus.c
Date: Wed,  2 Oct 2024 18:58:20 +0530
Message-Id: <20241002132820.402583-4-sayyad.abid16@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241002132820.402583-1-sayyad.abid16@gmail.com>
References: <20241002132820.402583-1-sayyad.abid16@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change help make the comment blocks reader friendly
by adding * on each comment line indicating a continuous
block of comment

Signed-off-by: Sayyad Abid <sayyad.abid16@gmail.com>
---
 drivers/nubus/nubus.c | 87 ++++++++++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 38 deletions(-)

diff --git a/drivers/nubus/nubus.c b/drivers/nubus/nubus.c
index 77da1d14a1db..501c830c3c40 100644
--- a/drivers/nubus/nubus.c
+++ b/drivers/nubus/nubus.c
@@ -24,7 +24,8 @@
 /* Constants */

 /* This is, of course, the size in bytelanes, rather than the size in
-   actual bytes */
+ * actual bytes
+ */
 #define FORMAT_BLOCK_SIZE 20
 #define ROM_DIR_OFFSET 0x24

@@ -42,27 +43,27 @@ module_param_named(populate_procfs, nubus_populate_procfs, bool, 0);
 LIST_HEAD(nubus_func_rsrcs);

 /* Meaning of "bytelanes":
-
-   The card ROM may appear on any or all bytes of each long word in
-   NuBus memory.  The low 4 bits of the "map" value found in the
-   format block (at the top of the slot address space, as well as at
-   the top of the MacOS ROM) tells us which bytelanes, i.e. which byte
-   offsets within each longword, are valid.  Thus:
-
-   A map of 0x0f, as found in the MacOS ROM, means that all bytelanes
-   are valid.
-
-   A map of 0xf0 means that no bytelanes are valid (We pray that we
-   will never encounter this, but stranger things have happened)
-
-   A map of 0xe1 means that only the MSB of each long word is actually
-   part of the card ROM.  (We hope to never encounter NuBus on a
-   little-endian machine.  Again, stranger things have happened)
-
-   A map of 0x78 means that only the LSB of each long word is valid.
-
-   Etcetera, etcetera.  Hopefully this clears up some confusion over
-   what the following code actually does.  */
+ *
+ * The card ROM may appear on any or all bytes of each long word in
+ * NuBus memory.  The low 4 bits of the "map" value found in the
+ *format block (at the top of the slot address space, as well as at
+ *the top of the MacOS ROM) tells us which bytelanes, i.e. which byte
+ * offsets within each longword, are valid.  Thus:
+ *
+ * A map of 0x0f, as found in the MacOS ROM, means that all bytelanes
+ * are valid.
+ *
+ * A map of 0xf0 means that no bytelanes are valid (We pray that we
+ * will never encounter this, but stranger things have happened)
+ *
+ * A map of 0xe1 means that only the MSB of each long word is actually
+ * part of the card ROM.  (We hope to never encounter NuBus on a
+ * little-endian machine.  Again, stranger things have happened)
+ * A map of 0x78 means that only the LSB of each long word is valid.
+ *
+ * Etcetera, etcetera.  Hopefully this clears up some confusion over
+ * what the following code actually does.
+ */

 static inline int not_useful(void *p, int map)
 {
@@ -133,9 +134,10 @@ static void nubus_move(unsigned char **ptr, int len, int map)
 /* Now, functions to read the sResource tree */

 /* Each sResource entry consists of a 1-byte ID and a 3-byte data
-   field.  If that data field contains an offset, then obviously we
-   have to expand it from a 24-bit signed number to a 32-bit signed
-   number. */
+ * field.  If that data field contains an offset, then obviously we
+ * have to expand it from a 24-bit signed number to a 32-bit signed
+ * number.
+ */

 static inline long nubus_expand32(long foo)
 {
@@ -158,14 +160,16 @@ unsigned char *nubus_dirptr(const struct nubus_dirent *nd)
 	unsigned char *p = nd->base;

 	/* Essentially, just step over the bytelanes using whatever
-	   offset we might have found */
+	 * offset we might have found
+	 */
 	nubus_move(&p, nubus_expand32(nd->data), nd->mask);
 	/* And return the value */
 	return p;
 }

 /* These two are for pulling resource data blocks (i.e. stuff that's
-   pointed to with offsets) out of the card ROM. */
+ * pointed to with offsets) out of the card ROM.
+ */

 void nubus_get_rsrc_mem(void *dest, const struct nubus_dirent *dirent,
 			unsigned int len)
@@ -253,7 +257,8 @@ int nubus_get_board_dir(const struct nubus_board *board,
 	dir->mask = board->lanes;

 	/* Now dereference it (the first directory is always the board
-	   directory) */
+	 * directory)
+	 */
 	if (nubus_readdir(dir, &ent) == -1)
 		return -1;
 	if (nubus_get_subdir(&ent, dir) == -1)
@@ -339,8 +344,9 @@ nubus_find_rsrc(struct nubus_dir *dir, unsigned char rsrc_type,
 EXPORT_SYMBOL(nubus_find_rsrc);

 /* Initialization functions - decide which slots contain stuff worth
-   looking at, and print out lots and lots of information from the
-   resource blocks. */
+ * looking at, and print out lots and lots of information from the
+ * resource blocks.
+ */

 static int __init nubus_get_block_rsrc_dir(struct nubus_board *board,
 					   struct proc_dir_entry *procdir,
@@ -542,7 +548,8 @@ nubus_get_functional_resource(struct nubus_board *board, int slot,
 		case NUBUS_RESID_DRVRDIR:
 		{
 			/* MacOS driver.  If we were NetBSD we might
-			   use this :-) */
+			 *  use this :-)
+			 */
 			pr_debug("    driver directory offset: 0x%06x\n",
 				ent.data);
 			nubus_get_block_rsrc_dir(board, dir.procdir, &ent);
@@ -551,8 +558,9 @@ nubus_get_functional_resource(struct nubus_board *board, int slot,
 		case NUBUS_RESID_MINOR_BASEOS:
 		{
 			/* We will need this in order to support
-			   multiple framebuffers.  It might be handy
-			   for Ethernet as well */
+			 * multiple framebuffers.  It might be handy
+			 * for Ethernet as well
+			 */
 			u32 base_offset;

 			nubus_get_rsrc_mem(&base_offset, &ent, 4);
@@ -651,8 +659,9 @@ static int __init nubus_get_board_resource(struct nubus_board *board, int slot,
 		{
 			unsigned short nbtdata[4];
 			/* This type is always the same, and is not
-			   useful except insofar as it tells us that
-			   we really are looking at a board resource. */
+			 * useful except insofar as it tells us that
+			 * we really are looking at a board resource.
+			 */
 			nubus_get_rsrc_mem(nbtdata, &ent, 8);
 			pr_debug("    type: [cat 0x%x type 0x%x sw 0x%x hw 0x%x]\n",
 				nbtdata[0], nbtdata[1], nbtdata[2], nbtdata[3]);
@@ -849,12 +858,14 @@ static void __init nubus_probe_slot(int slot)
 		dp = *rp;

 		/* The last byte of the format block consists of two
-		   nybbles which are "mirror images" of each other.
-		   These show us the valid bytelanes */
+		 * nybbles which are "mirror images" of each other.
+		 * These show us the valid bytelanes
+		 */
 		if ((((dp >> 4) ^ dp) & 0x0F) != 0x0F)
 			continue;
 		/* Check that this value is actually *on* one of the
-		   bytelanes it claims are valid! */
+		 * bytelanes it claims are valid!
+		 */
 		if (not_useful(rp, dp))
 			continue;

--
2.39.5


