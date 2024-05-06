Return-Path: <linux-kernel+bounces-170353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D618BD58D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 21:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED29E1C20CB2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5CE15B0E4;
	Mon,  6 May 2024 19:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="mUSsGcAp"
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9274158873;
	Mon,  6 May 2024 19:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715024576; cv=none; b=XfD1ZyQY7kJSErWiKSPxqRTjF3YdkH5qdxv5crSSi4n9nHoUnsV0uPH82OrIH+LNg4/cBBkn8L8b7TDj3fMlcQ5Rh7ojnmF+8RYHAf57WkKe8jjWAe+F9tD91vmA2ADJh4BM/8dnNffjH9ign7LShETaprPxwklObDyCtyiuCIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715024576; c=relaxed/simple;
	bh=aSozFxS5LbgNSQ6h1GkeG3vjP/XR4gK6Qeg4TmIXR3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s12PB6Ujcl9LZDHMGj5ENX/47tgUWSgUuPRf1rpaQmFA5dsUwZ1J/2LcxBC4DVS1SgwXJvkQZJBJciHerWvPIS2jZoxzzxFj/H0biPmYlJQKVCIswKMpN9+3RQUcptwkdSX8z+XMrzMAWBhGvdembzYh83hFLXX5srTb4esqilE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=mUSsGcAp; arc=none smtp.client-ip=80.12.242.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 445oszmYtR8o9445os7zWU; Mon, 06 May 2024 21:33:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1715024025;
	bh=6Hx+nWx8Jayud7dD31s9JZH7LTHEVeGkErZx2PAlqvI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=mUSsGcApRI0TG5SS3UlUyJbC8N+/yGrojRnDC718QSdW+Ibp33bFtxX4F9x9j6heZ
	 tqG5HvFDs0wDMTobvvxFgIRr7pbUVOZQ80/fVfMC3NBpIzt5/lz7uCXbsf5E0UMubQ
	 d3/xoAld68Q2L9N61zCg4AzC+PLMdCahbbSrCC0/QLHFzaYRCg9P+y8JnLKb+zOpxr
	 sICvqdzxrGENOQOs8R/kwH3dINQA79rLgCznLN8BeHKFPyJz8mJkzf6obr1KEH0Zha
	 /XRXsjG/eBxtpM3fHaBRlrBVSKghMAGPpW7BqZs64ynAUBIsB1+qMNnNXjT5ejHWqR
	 vSLmtlluxWV3Q==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 06 May 2024 21:33:45 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v1] regmap: Reorder fields in 'struct regmap_config' to save some memory
Date: Mon,  6 May 2024 21:33:33 +0200
Message-ID: <5e039cd8fe415dd7ab3169948c08a5311db9fb9a.1715024007.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On x86_64 and allmodconfig, this shrinks the size of 'struct regmap_config'
from 328 to 312 bytes.

This is usually a win, because this structure is used as a static global
variable.

When moving the kerneldoc fields, I've tried to keep the layout as
consistent as possible, which is not really easy!

Before:
	/* size: 328, cachelines: 6, members: 55 */
	/* sum members: 296, holes: 6, sum holes: 25 */
	/* padding: 7 */
	/* last cacheline: 8 bytes */

After:
	/* size: 312, cachelines: 5, members: 55 */
	/* sum members: 296, holes: 5, sum holes: 16 */
	/* last cacheline: 56 bytes */

For the records, this is also widely used:
	$git grep static.*regmap_config | wc -l
	1327

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Built-tested only on several dozens of modified files.

Example of size reduction on drivers/clk/clk-si544.o (randomly chosen)

Before:
   text	   data	    bss	    dec	    hex	filename
   9917	    700	     16	  10633	   2989	drivers/clk/clk-si544.o

After:
   text	   data	    bss	    dec	    hex	filename
   9885	    700	     16	  10601	   2969	drivers/clk/clk-si544.o
---
 include/linux/regmap.h | 62 +++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index d470303b1bbb..a6bc2980a98b 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -297,15 +297,6 @@ typedef void (*regmap_unlock)(void *);
  *			performed on such table (a register is no increment
  *			readable if it belongs to one of the ranges specified
  *			by rd_noinc_table).
- * @disable_locking: This regmap is either protected by external means or
- *                   is guaranteed not to be accessed from multiple threads.
- *                   Don't use any locking mechanisms.
- * @lock:	  Optional lock callback (overrides regmap's default lock
- *		  function, based on spinlock or mutex).
- * @unlock:	  As above for unlocking.
- * @lock_arg:	  this field is passed as the only argument of lock/unlock
- *		  functions (ignored in case regular lock/unlock functions
- *		  are not overridden).
  * @reg_read:	  Optional callback that if filled will be used to perform
  *           	  all the reads from the registers. Should only be provided for
  *		  devices whose read operation cannot be represented as a simple
@@ -323,6 +314,7 @@ typedef void (*regmap_unlock)(void *);
  * @write: Same as above for writing.
  * @max_raw_read: Max raw read size that can be used on the device.
  * @max_raw_write: Max raw write size that can be used on the device.
+ * @can_sleep:	  Optional, specifies whether regmap operations can sleep.
  * @fast_io:	  Register IO is fast. Use a spinlock instead of a mutex
  *	     	  to perform locking. This field is ignored if custom lock/unlock
  *	     	  functions are used (see fields lock/unlock of struct regmap_config).
@@ -331,6 +323,15 @@ typedef void (*regmap_unlock)(void *);
  *		   Use it only for "no-bus" cases.
  * @io_port:	  Support IO port accessors. Makes sense only when MMIO vs. IO port
  *		  access can be distinguished.
+ * @disable_locking: This regmap is either protected by external means or
+ *		     is guaranteed not to be accessed from multiple threads.
+ *		     Don't use any locking mechanisms.
+ * @lock:	  Optional lock callback (overrides regmap's default lock
+ *		  function, based on spinlock or mutex).
+ * @unlock:	  As above for unlocking.
+ * @lock_arg:	  This field is passed as the only argument of lock/unlock
+ *		  functions (ignored in case regular lock/unlock functions
+ *		  are not overridden).
  * @max_register: Optional, specifies the maximum valid register address.
  * @max_register_is_0: Optional, specifies that zero value in @max_register
  *                     should be taken into account. This is a workaround to
@@ -373,21 +374,20 @@ typedef void (*regmap_unlock)(void *);
  * @reg_defaults_raw: Power on reset values for registers (for use with
  *                    register cache support).
  * @num_reg_defaults_raw: Number of elements in reg_defaults_raw.
- * @reg_format_endian: Endianness for formatted register addresses. If this is
- *                     DEFAULT, the @reg_format_endian_default value from the
- *                     regmap bus is used.
- * @val_format_endian: Endianness for formatted register values. If this is
- *                     DEFAULT, the @reg_format_endian_default value from the
- *                     regmap bus is used.
- *
- * @ranges: Array of configuration entries for virtual address ranges.
- * @num_ranges: Number of range configuration entries.
  * @use_hwlock: Indicate if a hardware spinlock should be used.
  * @use_raw_spinlock: Indicate if a raw spinlock should be used.
  * @hwlock_id: Specify the hardware spinlock id.
  * @hwlock_mode: The hardware spinlock mode, should be HWLOCK_IRQSTATE,
  *		 HWLOCK_IRQ or 0.
- * @can_sleep: Optional, specifies whether regmap operations can sleep.
+ * @reg_format_endian: Endianness for formatted register addresses. If this is
+ *		       DEFAULT, the @reg_format_endian_default value from the
+ *		       regmap bus is used.
+ * @val_format_endian: Endianness for formatted register values. If this is
+ *		       DEFAULT, the @reg_format_endian_default value from the
+ *		       regmap bus is used.
+ *
+ * @ranges: Array of configuration entries for virtual address ranges.
+ * @num_ranges: Number of range configuration entries.
  */
 struct regmap_config {
 	const char *name;
@@ -406,11 +406,6 @@ struct regmap_config {
 	bool (*writeable_noinc_reg)(struct device *dev, unsigned int reg);
 	bool (*readable_noinc_reg)(struct device *dev, unsigned int reg);
 
-	bool disable_locking;
-	regmap_lock lock;
-	regmap_unlock unlock;
-	void *lock_arg;
-
 	int (*reg_read)(void *context, unsigned int reg, unsigned int *val);
 	int (*reg_write)(void *context, unsigned int reg, unsigned int val);
 	int (*reg_update_bits)(void *context, unsigned int reg,
@@ -422,9 +417,16 @@ struct regmap_config {
 	size_t max_raw_read;
 	size_t max_raw_write;
 
+	bool can_sleep;
+
 	bool fast_io;
 	bool io_port;
 
+	bool disable_locking;
+	regmap_lock lock;
+	regmap_unlock unlock;
+	void *lock_arg;
+
 	unsigned int max_register;
 	bool max_register_is_0;
 	const struct regmap_access_table *wr_table;
@@ -448,18 +450,16 @@ struct regmap_config {
 	bool use_relaxed_mmio;
 	bool can_multi_write;
 
-	enum regmap_endian reg_format_endian;
-	enum regmap_endian val_format_endian;
-
-	const struct regmap_range_cfg *ranges;
-	unsigned int num_ranges;
-
 	bool use_hwlock;
 	bool use_raw_spinlock;
 	unsigned int hwlock_id;
 	unsigned int hwlock_mode;
 
-	bool can_sleep;
+	enum regmap_endian reg_format_endian;
+	enum regmap_endian val_format_endian;
+
+	const struct regmap_range_cfg *ranges;
+	unsigned int num_ranges;
 };
 
 /**
-- 
2.45.0


