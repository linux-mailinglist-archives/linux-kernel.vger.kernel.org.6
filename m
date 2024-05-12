Return-Path: <linux-kernel+bounces-176857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E63708C3628
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 13:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60F221F2136A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 11:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEB8208AD;
	Sun, 12 May 2024 11:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="IEvwEGKA"
Received: from msa.smtpout.orange.fr (smtp-80.smtpout.orange.fr [80.12.242.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD711CAAF;
	Sun, 12 May 2024 11:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715512372; cv=none; b=KVNbWTM1WOzBC7lpLkX5nfUgw1SRS0oU2/VYsdW9++D2IGi9K+ItfBbt6RW7qHMos9zrKd1ZY8+8d3+SHWrH/kgmEehUEkOjttt7uhFuI9c9xXlPpsdDHjsoNb9eTyONFJYuoXXjc36bIQLFtw/XKsqFrpXab/mLNTQpXyX+cHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715512372; c=relaxed/simple;
	bh=a0SHuP6qCCie92ITUzTLst/XaoPMKeSO9S3jgl5l1rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ho/YR3Mu+UPx7NJpIu95EK6vwNkaN0/kcPSLcePXo6hSt65TFiZoP/jeEp9m/QM6bb+FAmsyEyfZrNEY26jGFtrAAW0na9bZOEvfDaObuDgkPBmk5fjM/zWDZ7thdEPWfaOuTR1ur88X3YOeilIjxKxk8jswkAQ0KEMJJcTQV28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=IEvwEGKA; arc=none smtp.client-ip=80.12.242.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 6774sdNpdxEVb6774sbR5R; Sun, 12 May 2024 13:11:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1715512291;
	bh=ESHOboVimNxtbiSAZemdp0pLxtpUq4uYogx/byVem9I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=IEvwEGKA1WCt51777fRkDu7o3oWAuJexJHAMiwKCY5xIPde/u/h6+KAK3utF+40bs
	 GlzXAXpPN0wRr0eKzX2iK2LfVL19sGCTH1yzZ9kvMQzEHqCCMI6uy29HaJFusyjIv6
	 /3jE9N70cdKKH7zxMCOPAjswFuhj4q3rofK4Z+elz3y4zSGdpETzNY4JEXZRvZm7JL
	 zkthV7VmWMzQeVkRPoDIlxGwyG0sfm2/qTgb58+/Q4a1cMBIWSiiyRYr3MC1HpcxWk
	 kEmFatMhv5/AVd7h/na1hlISLCIxUaK/nlByqfKGLcasA1FnX/vsL2Jr0x4H1VUdSP
	 aDfHLkVEDZ6cQ==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 12 May 2024 13:11:31 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] regulator: consumer: Reorder fields in 'struct regulator_bulk_data'
Date: Sun, 12 May 2024 13:11:21 +0200
Message-ID: <35c4edf2dbc6d4f24fb771341ded2989ae32f779.1715512259.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on pahole, 2 holes can be combined in 'struct regulator_bulk_data'.

On x86_64 and allmodconfig, this shrinks the size of the structure from 32
to 24 bytes.

This is usually a win, because this structure is often used for static
global variables.

As an example:
Before:
   text	   data	    bss	    dec	    hex	filename
   3557	    162	      0	   3719	    e87	drivers/gpu/drm/msm/dsi/dsi_cfg.o

After:
   text	   data	    bss	    dec	    hex	filename
   3477	    162	      0	   3639	    e37	drivers/gpu/drm/msm/dsi/dsi_cfg.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Before:
======
struct regulator_bulk_data {
	const char  *              supply;               /*     0     8 */
	int                        init_load_uA;         /*     8     4 */

	/* XXX 4 bytes hole, try to pack */

	struct regulator *         consumer;             /*    16     8 */
	int                        ret;                  /*    24     4 */

	/* size: 32, cachelines: 1, members: 4 */
	/* sum members: 24, holes: 1, sum holes: 4 */
	/* padding: 4 */
	/* last cacheline: 32 bytes */
};

After:
=====
struct regulator_bulk_data {
	const char  *              supply;               /*     0     8 */
	struct regulator *         consumer;             /*     8     8 */
	int                        init_load_uA;         /*    16     4 */
	int                        ret;                  /*    20     4 */

	/* size: 24, cachelines: 1, members: 4 */
	/* last cacheline: 24 bytes */
};
---
 include/linux/regulator/consumer.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index 59d0b9a79e6e..e6f81fc1fb17 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -128,11 +128,11 @@ struct regulator;
  *
  * @supply:       The name of the supply.  Initialised by the user before
  *                using the bulk regulator APIs.
+ * @consumer:     The regulator consumer for the supply.  This will be managed
+ *                by the bulk API.
  * @init_load_uA: After getting the regulator, regulator_set_load() will be
  *                called with this load.  Initialised by the user before
  *                using the bulk regulator APIs.
- * @consumer:     The regulator consumer for the supply.  This will be managed
- *                by the bulk API.
  *
  * The regulator APIs provide a series of regulator_bulk_() API calls as
  * a convenience to consumers which require multiple supplies.  This
@@ -140,8 +140,8 @@ struct regulator;
  */
 struct regulator_bulk_data {
 	const char *supply;
-	int init_load_uA;
 	struct regulator *consumer;
+	int init_load_uA;
 
 	/* private: Internal use */
 	int ret;
-- 
2.45.0


