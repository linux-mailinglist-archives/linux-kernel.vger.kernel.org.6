Return-Path: <linux-kernel+bounces-228621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9048B91625A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA9B282A59
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7B0148315;
	Tue, 25 Jun 2024 09:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="AlBPowAz"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2D71465B7
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 09:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719307927; cv=none; b=Spkoh/CFix5CLjrW82rzleaGNSwLGVOzLUmgxPKki5sRdzQC63EZg12CTHRm68PgKublgcpvU+2bLzL69MCPkZaaS6dkw3+G6Q7l+yAqXdNoOwtLRKHq5tov4kHIFThR1D7j6V7C8+LI/C6ZqYGLs2GF6By3VIoU2gOJWZVjymo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719307927; c=relaxed/simple;
	bh=LSqxNwDsrLNWgKgFVbTYMOcq1Dny+GRxiLhfIf6KeVs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mbPg9R1kgEwp5FA9iyiGbPcnMYJNEe6cCD32qfxNGa7hHRWBb339TV1Jn1FKkYgtOzngU9nKztnUC8FMifjW3+G3aware6DI6jc8DMyIlzFh1/WYEChUGLfF3cYxf9MPeohS9OM26Iy2A4NYWPBSGy0hurwTDLCKSYkyq2xUt7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=AlBPowAz; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id E887DA0E06;
	Tue, 25 Jun 2024 11:31:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=jqOG5ysnLZOZ6WX79LN01rD+JfmYfnoYRxkCIH5M/Aw=; b=
	AlBPowAz5+JtwBhJZkFUllPXZpNCxGsgMFykypOPf7cEE2Mz9vni49vGSg+9dte3
	RUx3V/zabtxDXga67j6pmamPvvmcVeAsTR1GBVk5Vufq5IDWnohYAhtLqGisXVBP
	wAb5QqrEfMna8bhKOwL6c2xnudd2LxkRhLgJtaNsvS+U2nZd4MZvhYMknegLxCqt
	0g7D3Qki3f8s/j2YQcr/Ygl4KV/HTwN6VqEd++UQnjQKuMgHZ+kWGXzTz6YgNJLb
	n5kmcwbA8U9HsT2G//3tu+rBPmX3ydsu0SFd1YiwYksoRsOgesgmMkDgPdPQ/E2b
	GKi2no4IglckNUdjAl1OaATwRWT3eImHlzg8j38PW0/prmZ681Clx670radVnzPC
	ErxK26oMJ/UQ7Kyq8guVYaNCH35bbeEkkZ/8Hyq8UDE7/bN7XrDAhgEzleatbebY
	mFxKkea+Vu/dnxpH6wAU2UfDmUaNBlxDVOhMoU/yzk8Uicltv3Ccmdsb9pLGfaxi
	3PyVED9U1WdeZJxyNSdqs9qK2xUzFrNExuiMKFiVPJjT8D0HP8TnZOGgYvjyp86W
	S84OTOLNL14stO7iL+O0l/Y/qKX6NafkOZcoMC9AGdlEL9tffEy24dtR9Qvu7ltI
	lbEohxSMbNqOHDQ0h3L5OdoqMmyVXd3C63c1w45o59s=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Miquel
 Raynal" <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH] mtd: cmdlinepart: Replace `dbg()` macro with `pr_debug()`
Date: Tue, 25 Jun 2024 11:31:47 +0200
Message-ID: <20240625093148.3579660-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1719307913;VERSION=7972;MC=1585764846;ID=1416094;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29916D3B546C7167

This macro was left over from the dawn of Git history.
For some reason it was defined in such a way that
you needed double brackets around it. Replace it with
the now-standard `pr_debug()`.

Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 drivers/mtd/parsers/cmdlinepart.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/parsers/cmdlinepart.c b/drivers/mtd/parsers/cmdlinepart.c
index b34856def816..504e5fa2b45b 100644
--- a/drivers/mtd/parsers/cmdlinepart.c
+++ b/drivers/mtd/parsers/cmdlinepart.c
@@ -44,14 +44,6 @@
 #include <linux/module.h>
 #include <linux/err.h>
 
-/* debug macro */
-#if 0
-#define dbg(x) do { printk("DEBUG-CMDLINE-PART: "); printk x; } while(0)
-#else
-#define dbg(x)
-#endif
-
-
 /* special size referring to all the remaining space in a partition */
 #define SIZE_REMAINING ULLONG_MAX
 #define OFFSET_CONTINUOUS ULLONG_MAX
@@ -199,9 +191,9 @@ static struct mtd_partition * newpart(char *s,
 	parts[this_part].name = extra_mem;
 	extra_mem += name_len + 1;
 
-	dbg(("partition %d: name <%s>, offset %llx, size %llx, mask flags %x\n",
+	pr_debug("partition %d: name <%s>, offset %llx, size %llx, mask flags %x\n",
 	     this_part, parts[this_part].name, parts[this_part].offset,
-	     parts[this_part].size, parts[this_part].mask_flags));
+	     parts[this_part].size, parts[this_part].mask_flags);
 
 	/* return (updated) pointer to extra_mem memory */
 	if (extra_mem_ptr)
@@ -267,7 +259,7 @@ static int mtdpart_setup_real(char *s)
 		}
 		mtd_id_len = p - mtd_id;
 
-		dbg(("parsing <%s>\n", p+1));
+		pr_debug("parsing <%s>\n", p+1);
 
 		/*
 		 * parse one mtd. have it reserve memory for the
@@ -304,8 +296,8 @@ static int mtdpart_setup_real(char *s)
 		this_mtd->next = partitions;
 		partitions = this_mtd;
 
-		dbg(("mtdid=<%s> num_parts=<%d>\n",
-		     this_mtd->mtd_id, this_mtd->num_parts));
+		pr_debug("mtdid=<%s> num_parts=<%d>\n",
+		     this_mtd->mtd_id, this_mtd->num_parts);
 
 
 		/* EOS - we're done */
-- 
2.34.1



