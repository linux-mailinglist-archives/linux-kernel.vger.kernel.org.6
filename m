Return-Path: <linux-kernel+bounces-362787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DF099B94A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 13:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC81E1C20ADA
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 11:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5027013E03E;
	Sun, 13 Oct 2024 11:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ceZweWE/"
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E972AF1E;
	Sun, 13 Oct 2024 11:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728820652; cv=none; b=YVAJ4Vzkjy2GxRkrDrcqI+To/DgIyIf9h/KxWF2eQEdiw3gXmOMAVm2Vj+CKJPDfaA+Q2vs+RuwBU+mrK2CqLwJd6/VflCAzprHUyQHCyULBxcGdzGgX+GLxy5FrbHd70qqfhbvDiWPukJVHb1m3POYv0c+qmxo/DuMd9E8Gqlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728820652; c=relaxed/simple;
	bh=RjjpgpDzstpv1aZGOAoVd9qAVce88N9yuC9mocAB2YA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rlO1RWZBYx6MxbDvx7SVQZofFTXPfTlbLkfthUlaH6fRVVH6wpr1NWEuh88cANGNGDM6yJfWIQYki23j715NMCIxq7fO6sdgZfdFlYssinWDYJhCr2saum52nH5vJS2mOYeoly9V+LrPCp7GbubADWOEIyRdXnPSxvWQKrtG5co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ceZweWE/; arc=none smtp.client-ip=80.12.242.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id zx57stZS2B0YBzx57s7gGf; Sun, 13 Oct 2024 13:48:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1728820098;
	bh=9Lc6fX0KKpmtZvNPSaPJ34kiPy3v/0X/tDjiDGWF2dY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ceZweWE/EuyErM1E+TVSsUx4hOQ85BsRXFCl1lED2WNLp/k/StctaCYT9Ws/QuBUk
	 64PLvuXLYJlNYzU5ZIHr/m5bD4x9OM9NubRlKKgMoxsX6RnXpgg6eCs8SMU3u4pmbb
	 uHMpbTNyxnJgUOiznuUNLJTAXawxEIvAak599o/2aYoeHsOnVocd9d/TkLCxB92HiX
	 5kt/CVISv6hcEl4nbt/mHq4+cpwFsa2T7g2hE09+kRKEhTQI0haOuXbRM+hglltmrQ
	 k1XWq92lnYYmRKm/iu6oNg+4Xsf5VKWj6qmr47ICTPLbvP/zb2W1QbwpO7HLKVs9R7
	 pDCizGssFtvJQ==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 13 Oct 2024 13:48:18 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Helge Deller <deller@gmx.de>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] fbdev: Constify struct sbus_mmap_map
Date: Sun, 13 Oct 2024 13:48:01 +0200
Message-ID: <67883bfad5c2c395438bfcef7a319394caca4155.1728820047.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct sbus_mmap_map' are not modified in these drivers.

Constifying this structure moves some data to a read-only section, so
increases overall security.

Update sbusfb_mmap_helper() accordingly.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
   2452	    536	     16	   3004	    bbc	drivers/video/fbdev/bw2.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   2500	    483	     16	   2999	    bb7	drivers/video/fbdev/bw2.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only with a cross compiler for sparc.
---
 drivers/video/fbdev/bw2.c     | 2 +-
 drivers/video/fbdev/cg14.c    | 2 +-
 drivers/video/fbdev/cg3.c     | 2 +-
 drivers/video/fbdev/cg6.c     | 2 +-
 drivers/video/fbdev/ffb.c     | 2 +-
 drivers/video/fbdev/leo.c     | 2 +-
 drivers/video/fbdev/p9100.c   | 2 +-
 drivers/video/fbdev/sbuslib.c | 2 +-
 drivers/video/fbdev/sbuslib.h | 2 +-
 drivers/video/fbdev/tcx.c     | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/video/fbdev/bw2.c b/drivers/video/fbdev/bw2.c
index 4a64940e0c00..e757462af0a6 100644
--- a/drivers/video/fbdev/bw2.c
+++ b/drivers/video/fbdev/bw2.c
@@ -147,7 +147,7 @@ bw2_blank(int blank, struct fb_info *info)
 	return 0;
 }
 
-static struct sbus_mmap_map bw2_mmap_map[] = {
+static const struct sbus_mmap_map bw2_mmap_map[] = {
 	{
 		.size = SBUS_MMAP_FBSIZE(1)
 	},
diff --git a/drivers/video/fbdev/cg14.c b/drivers/video/fbdev/cg14.c
index 430e1a7b352b..5389f8f07346 100644
--- a/drivers/video/fbdev/cg14.c
+++ b/drivers/video/fbdev/cg14.c
@@ -360,7 +360,7 @@ static void cg14_init_fix(struct fb_info *info, int linebytes,
 	info->fix.accel = FB_ACCEL_SUN_CG14;
 }
 
-static struct sbus_mmap_map __cg14_mmap_map[CG14_MMAP_ENTRIES] = {
+static const struct sbus_mmap_map __cg14_mmap_map[CG14_MMAP_ENTRIES] = {
 	{
 		.voff	= CG14_REGS,
 		.poff	= 0x80000000,
diff --git a/drivers/video/fbdev/cg3.c b/drivers/video/fbdev/cg3.c
index e4c53c6632ba..a58a483014e6 100644
--- a/drivers/video/fbdev/cg3.c
+++ b/drivers/video/fbdev/cg3.c
@@ -209,7 +209,7 @@ static int cg3_blank(int blank, struct fb_info *info)
 	return 0;
 }
 
-static struct sbus_mmap_map cg3_mmap_map[] = {
+static const struct sbus_mmap_map cg3_mmap_map[] = {
 	{
 		.voff	= CG3_MMAP_OFFSET,
 		.poff	= CG3_RAM_OFFSET,
diff --git a/drivers/video/fbdev/cg6.c b/drivers/video/fbdev/cg6.c
index 0b60df51e7bc..56d74468040a 100644
--- a/drivers/video/fbdev/cg6.c
+++ b/drivers/video/fbdev/cg6.c
@@ -545,7 +545,7 @@ static int cg6_blank(int blank, struct fb_info *info)
 	return 0;
 }
 
-static struct sbus_mmap_map cg6_mmap_map[] = {
+static const struct sbus_mmap_map cg6_mmap_map[] = {
 	{
 		.voff	= CG6_FBC,
 		.poff	= CG6_FBC_OFFSET,
diff --git a/drivers/video/fbdev/ffb.c b/drivers/video/fbdev/ffb.c
index 0b7e7b38c05a..34b6abff9493 100644
--- a/drivers/video/fbdev/ffb.c
+++ b/drivers/video/fbdev/ffb.c
@@ -710,7 +710,7 @@ static int ffb_blank(int blank, struct fb_info *info)
 	return 0;
 }
 
-static struct sbus_mmap_map ffb_mmap_map[] = {
+static const struct sbus_mmap_map ffb_mmap_map[] = {
 	{
 		.voff	= FFB_SFB8R_VOFF,
 		.poff	= FFB_SFB8R_POFF,
diff --git a/drivers/video/fbdev/leo.c b/drivers/video/fbdev/leo.c
index 271e2e8c6a84..b9fb059df2c7 100644
--- a/drivers/video/fbdev/leo.c
+++ b/drivers/video/fbdev/leo.c
@@ -338,7 +338,7 @@ static int leo_blank(int blank, struct fb_info *info)
 	return 0;
 }
 
-static struct sbus_mmap_map leo_mmap_map[] = {
+static const struct sbus_mmap_map leo_mmap_map[] = {
 	{
 		.voff	= LEO_SS0_MAP,
 		.poff	= LEO_OFF_SS0,
diff --git a/drivers/video/fbdev/p9100.c b/drivers/video/fbdev/p9100.c
index 124468f0e9ef..0bc0f78fe4b9 100644
--- a/drivers/video/fbdev/p9100.c
+++ b/drivers/video/fbdev/p9100.c
@@ -206,7 +206,7 @@ p9100_blank(int blank, struct fb_info *info)
 	return 0;
 }
 
-static struct sbus_mmap_map p9100_mmap_map[] = {
+static const struct sbus_mmap_map p9100_mmap_map[] = {
 	{ CG3_MMAP_OFFSET,	0,		SBUS_MMAP_FBSIZE(1) },
 	{ 0,			0,		0		    }
 };
diff --git a/drivers/video/fbdev/sbuslib.c b/drivers/video/fbdev/sbuslib.c
index 634e3d159452..4c79654bda30 100644
--- a/drivers/video/fbdev/sbuslib.c
+++ b/drivers/video/fbdev/sbuslib.c
@@ -38,7 +38,7 @@ static unsigned long sbusfb_mmapsize(long size, unsigned long fbsize)
 	return fbsize * (-size);
 }
 
-int sbusfb_mmap_helper(struct sbus_mmap_map *map,
+int sbusfb_mmap_helper(const struct sbus_mmap_map *map,
 		       unsigned long physbase,
 		       unsigned long fbsize,
 		       unsigned long iospace,
diff --git a/drivers/video/fbdev/sbuslib.h b/drivers/video/fbdev/sbuslib.h
index 6466b4cbcd7b..e9af2dc93f94 100644
--- a/drivers/video/fbdev/sbuslib.h
+++ b/drivers/video/fbdev/sbuslib.h
@@ -19,7 +19,7 @@ struct sbus_mmap_map {
 
 extern void sbusfb_fill_var(struct fb_var_screeninfo *var,
 			    struct device_node *dp, int bpp);
-extern int sbusfb_mmap_helper(struct sbus_mmap_map *map,
+extern int sbusfb_mmap_helper(const struct sbus_mmap_map *map,
 			      unsigned long physbase, unsigned long fbsize,
 			      unsigned long iospace,
 			      struct vm_area_struct *vma);
diff --git a/drivers/video/fbdev/tcx.c b/drivers/video/fbdev/tcx.c
index 6eb8bb2e3501..f9a0085ad72b 100644
--- a/drivers/video/fbdev/tcx.c
+++ b/drivers/video/fbdev/tcx.c
@@ -236,7 +236,7 @@ tcx_blank(int blank, struct fb_info *info)
 	return 0;
 }
 
-static struct sbus_mmap_map __tcx_mmap_map[TCX_MMAP_ENTRIES] = {
+static const struct sbus_mmap_map __tcx_mmap_map[TCX_MMAP_ENTRIES] = {
 	{
 		.voff	= TCX_RAM8BIT,
 		.size	= SBUS_MMAP_FBSIZE(1)
-- 
2.47.0


