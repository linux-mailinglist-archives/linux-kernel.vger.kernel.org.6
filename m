Return-Path: <linux-kernel+bounces-205317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 716D88FFA98
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5B81B23DDD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF06156C77;
	Fri,  7 Jun 2024 04:27:19 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D82155723
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734436; cv=none; b=bItKfOM9VDAYZQDvALL5WAy6vI9LzstbNtVYB8E+lely5bR8IkR0MmzowtFYiT8tXdIiYhlV6C7mSN/tjM+W6WE2Nzdk+V6cbwVzsSRo2ztegnWFOI6xmJDhLeZQyVUGhwivWCyqKspeXEDDsuU3GsNKMIPp0Az9sXOJ9pl93lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734436; c=relaxed/simple;
	bh=yWFiJH5PnxTyFSe1MPhO821/Rm4CSvzWSwraraPKJzQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SaD5b0yif4l4RxGfcrtbXkr4l72VfjE3mL7AW5fqi5ooDEVVRB/0+Z7uHlVlSxUQvME7mcHO2uNGYL+6znPbkt65qa0saWrLUmAsYyB3bNShuu2r9CnpfO3JCsgjMrr1IN1cYKnn3PpH6Shiv6eSjCMJShuY7VpiSno5LVOkQU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwSmn6RVrzdZhN;
	Fri,  7 Jun 2024 12:25:45 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id C2C80180085;
	Fri,  7 Jun 2024 12:27:10 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:26:53 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 036/110] ubifs-utils: Adapt io.c in libubifs
Date: Fri, 7 Jun 2024 12:25:01 +0800
Message-ID: <20240607042615.2069840-37-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607042615.2069840-1-chengzhihao1@huawei.com>
References: <20240607042615.2069840-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)

Adapt io.c in libubifs, compared with linux kernel implementations:
 1. Modify io related functions(eg. ubifs_leb_read/ubifs_leb_write,
    etc.), adapt them with userspace io functions lseek/read/write.
 2. Remove some functions(eg. record_magic_error, ubifs_bg_wbufs_sync)
    which won't be used in fsck/mkfs.
 3. Replce ubifs_errc with ubifs_err, because there will be no SB_SILENT
    options in mkfs/fsck.
 4. Initiate wbuf->size as c->max_write_size.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 include/crc32.h           |   5 +
 ubifs-utils/libubifs/io.c | 364 ++++++++++++----------------------------------
 2 files changed, 95 insertions(+), 274 deletions(-)

diff --git a/include/crc32.h b/include/crc32.h
index 9c1f742c..f5271f37 100644
--- a/include/crc32.h
+++ b/include/crc32.h
@@ -10,4 +10,9 @@
 /* Return a 32-bit CRC of the contents of the buffer */
 extern uint32_t mtd_crc32(uint32_t val, const void *ss, int len);
 
+static inline uint32_t crc32(uint32_t val, const void *ss, int len)
+{
+	return mtd_crc32(val, ss, len);
+}
+
 #endif /* __CRC32_H__ */
diff --git a/ubifs-utils/libubifs/io.c b/ubifs-utils/libubifs/io.c
index 01d8eb17..6f170172 100644
--- a/ubifs-utils/libubifs/io.c
+++ b/ubifs-utils/libubifs/io.c
@@ -58,9 +58,11 @@
  * they are read from the flash media.
  */
 
-#include <linux/crc32.h>
-#include <linux/slab.h>
+#include "kmem.h"
+#include "crc32.h"
 #include "ubifs.h"
+#include "defs.h"
+#include "debug.h"
 
 /**
  * ubifs_ro_mode - switch UBIFS to read read-only mode.
@@ -72,7 +74,6 @@ void ubifs_ro_mode(struct ubifs_info *c, int err)
 	if (!c->ro_error) {
 		c->ro_error = 1;
 		c->no_chk_data_crc = 0;
-		c->vfs_sb->s_flags |= SB_RDONLY;
 		ubifs_warn(c, "switched to read-only mode, error %d", err);
 		dump_stack();
 	}
@@ -87,9 +88,26 @@ void ubifs_ro_mode(struct ubifs_info *c, int err)
 int ubifs_leb_read(const struct ubifs_info *c, int lnum, void *buf, int offs,
 		   int len, int even_ebadmsg)
 {
-	int err;
+	int err = 0;
+	off_t pos = (off_t)lnum * c->leb_size + offs;
+
+	if (!len)
+		return 0;
 
-	err = ubi_read(c->ubi, lnum, buf, offs, len);
+	/*
+	 * The %-EBADMSG may be ignored in some case, the buf may not be filled
+	 * with data in some buggy mtd drivers. So we'd better to reset the buf
+	 * content before reading.
+	 */
+	memset(buf, 0, len);
+	if (lseek(c->dev_fd, pos, SEEK_SET) != pos) {
+		err = -errno;
+		goto out;
+	}
+
+	if (read(c->dev_fd, buf, len) != len)
+		err = -errno;
+out:
 	/*
 	 * In case of %-EBADMSG print the error message only if the
 	 * @even_ebadmsg is true.
@@ -105,15 +123,27 @@ int ubifs_leb_read(const struct ubifs_info *c, int lnum, void *buf, int offs,
 int ubifs_leb_write(struct ubifs_info *c, int lnum, const void *buf, int offs,
 		    int len)
 {
-	int err;
+	int err = 0;
+	off_t pos = (off_t)lnum * c->leb_size + offs;
 
 	ubifs_assert(c, !c->ro_media && !c->ro_mount);
 	if (c->ro_error)
 		return -EROFS;
-	if (!dbg_is_tst_rcvry(c))
-		err = ubi_leb_write(c->ubi, lnum, buf, offs, len);
-	else
-		err = dbg_leb_write(c, lnum, buf, offs, len);
+	if (!c->libubi) {
+		err = -ENODEV;
+		goto out;
+	}
+
+	if (!len)
+		return 0;
+
+	if (lseek(c->dev_fd, pos, SEEK_SET) != pos) {
+		err = -errno;
+		goto out;
+	}
+	if (write(c->dev_fd, buf, len) != len)
+		err = -errno;
+out:
 	if (err) {
 		ubifs_err(c, "writing %d bytes to LEB %d:%d failed, error %d",
 			  len, lnum, offs, err);
@@ -125,15 +155,31 @@ int ubifs_leb_write(struct ubifs_info *c, int lnum, const void *buf, int offs,
 
 int ubifs_leb_change(struct ubifs_info *c, int lnum, const void *buf, int len)
 {
-	int err;
+	int err = 0;
+	off_t pos = (off_t)lnum * c->leb_size;
 
 	ubifs_assert(c, !c->ro_media && !c->ro_mount);
 	if (c->ro_error)
 		return -EROFS;
-	if (!dbg_is_tst_rcvry(c))
-		err = ubi_leb_change(c->ubi, lnum, buf, len);
-	else
-		err = dbg_leb_change(c, lnum, buf, len);
+	if (c->libubi) {
+		err = ubi_leb_change_start(c->libubi, c->dev_fd, lnum, len);
+		if (err) {
+			ubifs_err(c, "ubi_leb_change_start failed");
+			err = -errno;
+			goto out;
+		}
+	}
+
+	if (!len)
+		return 0;
+
+	if (lseek(c->dev_fd, pos, SEEK_SET) != pos) {
+		err = -errno;
+		goto out;
+	}
+	if (write(c->dev_fd, buf, len) != len)
+		err = -errno;
+out:
 	if (err) {
 		ubifs_err(c, "changing %d bytes in LEB %d failed, error %d",
 			  len, lnum, err);
@@ -145,15 +191,15 @@ int ubifs_leb_change(struct ubifs_info *c, int lnum, const void *buf, int len)
 
 int ubifs_leb_unmap(struct ubifs_info *c, int lnum)
 {
-	int err;
+	int err = 0;
 
 	ubifs_assert(c, !c->ro_media && !c->ro_mount);
 	if (c->ro_error)
 		return -EROFS;
-	if (!dbg_is_tst_rcvry(c))
-		err = ubi_leb_unmap(c->ubi, lnum);
-	else
-		err = dbg_leb_unmap(c, lnum);
+	if (!c->libubi)
+		return -ENODEV;
+	if (ubi_leb_unmap(c->dev_fd, lnum))
+		err = -errno;
 	if (err) {
 		ubifs_err(c, "unmap LEB %d failed, error %d", lnum, err);
 		ubifs_ro_mode(c, err);
@@ -164,15 +210,15 @@ int ubifs_leb_unmap(struct ubifs_info *c, int lnum)
 
 int ubifs_leb_map(struct ubifs_info *c, int lnum)
 {
-	int err;
+	int err = 0;
 
 	ubifs_assert(c, !c->ro_media && !c->ro_mount);
 	if (c->ro_error)
 		return -EROFS;
-	if (!dbg_is_tst_rcvry(c))
-		err = ubi_leb_map(c->ubi, lnum);
-	else
-		err = dbg_leb_map(c, lnum);
+	if (!c->libubi)
+		return -ENODEV;
+	if (ubi_leb_map(c->dev_fd, lnum))
+		err = -errno;
 	if (err) {
 		ubifs_err(c, "mapping LEB %d failed, error %d", lnum, err);
 		ubifs_ro_mode(c, err);
@@ -183,9 +229,12 @@ int ubifs_leb_map(struct ubifs_info *c, int lnum)
 
 int ubifs_is_mapped(const struct ubifs_info *c, int lnum)
 {
-	int err;
+	int err = 0;
 
-	err = ubi_is_mapped(c->ubi, lnum);
+	if (!c->libubi)
+		return -ENODEV;
+	if (ubi_is_mapped(c->dev_fd, lnum))
+		err = -errno;
 	if (err < 0) {
 		ubifs_err(c, "ubi_is_mapped failed for LEB %d, error %d",
 			  lnum, err);
@@ -194,24 +243,6 @@ int ubifs_is_mapped(const struct ubifs_info *c, int lnum)
 	return err;
 }
 
-static void record_magic_error(struct ubifs_stats_info *stats)
-{
-	if (stats)
-		stats->magic_errors++;
-}
-
-static void record_node_error(struct ubifs_stats_info *stats)
-{
-	if (stats)
-		stats->node_errors++;
-}
-
-static void record_crc_error(struct ubifs_stats_info *stats)
-{
-	if (stats)
-		stats->crc_errors++;
-}
-
 /**
  * ubifs_check_node - check node.
  * @c: UBIFS file-system description object
@@ -256,7 +287,6 @@ int ubifs_check_node(const struct ubifs_info *c, const void *buf, int len,
 		if (!quiet)
 			ubifs_err(c, "bad magic %#08x, expected %#08x",
 				  magic, UBIFS_NODE_MAGIC);
-		record_magic_error(c->stats);
 		err = -EUCLEAN;
 		goto out;
 	}
@@ -265,7 +295,6 @@ int ubifs_check_node(const struct ubifs_info *c, const void *buf, int len,
 	if (type < 0 || type >= UBIFS_NODE_TYPES_CNT) {
 		if (!quiet)
 			ubifs_err(c, "bad node type %d", type);
-		record_node_error(c->stats);
 		goto out;
 	}
 
@@ -290,7 +319,6 @@ int ubifs_check_node(const struct ubifs_info *c, const void *buf, int len,
 		if (!quiet)
 			ubifs_err(c, "bad CRC: calculated %#08x, read %#08x",
 				  crc, node_crc);
-		record_crc_error(c->stats);
 		err = -EUCLEAN;
 		goto out;
 	}
@@ -395,7 +423,7 @@ void ubifs_init_node(struct ubifs_info *c, void *node, int len, int pad)
 	}
 }
 
-void ubifs_crc_node(struct ubifs_info *c, void *node, int len)
+void ubifs_crc_node(__unused struct ubifs_info *c, void *node, int len)
 {
 	struct ubifs_ch *ch = node;
 	uint32_t crc;
@@ -488,61 +516,6 @@ void ubifs_prep_grp_node(struct ubifs_info *c, void *node, int len, int last)
 }
 
 /**
- * wbuf_timer_callback_nolock - write-buffer timer callback function.
- * @timer: timer data (write-buffer descriptor)
- *
- * This function is called when the write-buffer timer expires.
- */
-static enum hrtimer_restart wbuf_timer_callback_nolock(struct hrtimer *timer)
-{
-	struct ubifs_wbuf *wbuf = container_of(timer, struct ubifs_wbuf, timer);
-
-	dbg_io("jhead %s", dbg_jhead(wbuf->jhead));
-	wbuf->need_sync = 1;
-	wbuf->c->need_wbuf_sync = 1;
-	ubifs_wake_up_bgt(wbuf->c);
-	return HRTIMER_NORESTART;
-}
-
-/**
- * new_wbuf_timer_nolock - start new write-buffer timer.
- * @c: UBIFS file-system description object
- * @wbuf: write-buffer descriptor
- */
-static void new_wbuf_timer_nolock(struct ubifs_info *c, struct ubifs_wbuf *wbuf)
-{
-	ktime_t softlimit = ms_to_ktime(dirty_writeback_interval * 10);
-	unsigned long long delta = dirty_writeback_interval;
-
-	/* centi to milli, milli to nano, then 10% */
-	delta *= 10ULL * NSEC_PER_MSEC / 10ULL;
-
-	ubifs_assert(c, !hrtimer_active(&wbuf->timer));
-	ubifs_assert(c, delta <= ULONG_MAX);
-
-	if (wbuf->no_timer)
-		return;
-	dbg_io("set timer for jhead %s, %llu-%llu millisecs",
-	       dbg_jhead(wbuf->jhead),
-	       div_u64(ktime_to_ns(softlimit), USEC_PER_SEC),
-	       div_u64(ktime_to_ns(softlimit) + delta, USEC_PER_SEC));
-	hrtimer_start_range_ns(&wbuf->timer, softlimit, delta,
-			       HRTIMER_MODE_REL);
-}
-
-/**
- * cancel_wbuf_timer_nolock - cancel write-buffer timer.
- * @wbuf: write-buffer descriptor
- */
-static void cancel_wbuf_timer_nolock(struct ubifs_wbuf *wbuf)
-{
-	if (wbuf->no_timer)
-		return;
-	wbuf->need_sync = 0;
-	hrtimer_cancel(&wbuf->timer);
-}
-
-/**
  * ubifs_wbuf_sync_nolock - synchronize write-buffer.
  * @wbuf: write-buffer to synchronize
  *
@@ -560,7 +533,6 @@ int ubifs_wbuf_sync_nolock(struct ubifs_wbuf *wbuf)
 	struct ubifs_info *c = wbuf->c;
 	int err, dirt, sync_len;
 
-	cancel_wbuf_timer_nolock(wbuf);
 	if (!wbuf->used || wbuf->lnum == -1)
 		/* Write-buffer is empty or not seeked */
 		return 0;
@@ -658,70 +630,6 @@ int ubifs_wbuf_seek_nolock(struct ubifs_wbuf *wbuf, int lnum, int offs)
 }
 
 /**
- * ubifs_bg_wbufs_sync - synchronize write-buffers.
- * @c: UBIFS file-system description object
- *
- * This function is called by background thread to synchronize write-buffers.
- * Returns zero in case of success and a negative error code in case of
- * failure.
- */
-int ubifs_bg_wbufs_sync(struct ubifs_info *c)
-{
-	int err, i;
-
-	ubifs_assert(c, !c->ro_media && !c->ro_mount);
-	if (!c->need_wbuf_sync)
-		return 0;
-	c->need_wbuf_sync = 0;
-
-	if (c->ro_error) {
-		err = -EROFS;
-		goto out_timers;
-	}
-
-	dbg_io("synchronize");
-	for (i = 0; i < c->jhead_cnt; i++) {
-		struct ubifs_wbuf *wbuf = &c->jheads[i].wbuf;
-
-		cond_resched();
-
-		/*
-		 * If the mutex is locked then wbuf is being changed, so
-		 * synchronization is not necessary.
-		 */
-		if (mutex_is_locked(&wbuf->io_mutex))
-			continue;
-
-		mutex_lock_nested(&wbuf->io_mutex, wbuf->jhead);
-		if (!wbuf->need_sync) {
-			mutex_unlock(&wbuf->io_mutex);
-			continue;
-		}
-
-		err = ubifs_wbuf_sync_nolock(wbuf);
-		mutex_unlock(&wbuf->io_mutex);
-		if (err) {
-			ubifs_err(c, "cannot sync write-buffer, error %d", err);
-			ubifs_ro_mode(c, err);
-			goto out_timers;
-		}
-	}
-
-	return 0;
-
-out_timers:
-	/* Cancel all timers to prevent repeated errors */
-	for (i = 0; i < c->jhead_cnt; i++) {
-		struct ubifs_wbuf *wbuf = &c->jheads[i].wbuf;
-
-		mutex_lock_nested(&wbuf->io_mutex, wbuf->jhead);
-		cancel_wbuf_timer_nolock(wbuf);
-		mutex_unlock(&wbuf->io_mutex);
-	}
-	return err;
-}
-
-/**
  * ubifs_wbuf_write_nolock - write data to flash via write-buffer.
  * @wbuf: write-buffer
  * @buf: node to write
@@ -763,8 +671,6 @@ int ubifs_wbuf_write_nolock(struct ubifs_wbuf *wbuf, void *buf, int len)
 		goto out;
 	}
 
-	cancel_wbuf_timer_nolock(wbuf);
-
 	if (c->ro_error)
 		return -EROFS;
 
@@ -925,9 +831,6 @@ exit:
 			goto out;
 	}
 
-	if (wbuf->used)
-		new_wbuf_timer_nolock(c, wbuf);
-
 	return 0;
 
 out:
@@ -1110,32 +1013,30 @@ int ubifs_read_node(const struct ubifs_info *c, void *buf, int type, int len,
 		return err;
 
 	if (type != ch->node_type) {
-		ubifs_errc(c, "bad node type (%d but expected %d)",
-			   ch->node_type, type);
+		ubifs_err(c, "bad node type (%d but expected %d)",
+			  ch->node_type, type);
 		goto out;
 	}
 
 	err = ubifs_check_node(c, buf, len, lnum, offs, 0, 0);
 	if (err) {
-		ubifs_errc(c, "expected node type %d", type);
+		ubifs_err(c, "expected node type %d", type);
 		return err;
 	}
 
 	l = le32_to_cpu(ch->len);
 	if (l != len) {
-		ubifs_errc(c, "bad node length %d, expected %d", l, len);
+		ubifs_err(c, "bad node length %d, expected %d", l, len);
 		goto out;
 	}
 
 	return 0;
 
 out:
-	ubifs_errc(c, "bad node at LEB %d:%d, LEB mapping status %d", lnum,
-		   offs, ubi_is_mapped(c->ubi, lnum));
-	if (!c->probing) {
-		ubifs_dump_node(c, buf, len);
-		dump_stack();
-	}
+	ubifs_err(c, "bad node at LEB %d:%d, LEB mapping status %d", lnum,
+		  offs, ubi_is_mapped(c->dev_fd, lnum));
+	ubifs_dump_node(c, buf, len);
+	dump_stack();
 	return -EINVAL;
 }
 
@@ -1166,12 +1067,12 @@ int ubifs_wbuf_init(struct ubifs_info *c, struct ubifs_wbuf *wbuf)
 	wbuf->used = 0;
 	wbuf->lnum = wbuf->offs = -1;
 	/*
-	 * If the LEB starts at the max. write size aligned address, then
-	 * write-buffer size has to be set to @c->max_write_size. Otherwise,
-	 * set it to something smaller so that it ends at the closest max.
-	 * write size boundary.
+	 * Different from linux kernel, there is no way to get leb_start in
+	 * userspace, set write-buffer size as @c->max_write_size directly.
+	 * Since wbuf->lnum is initialized as -1, wbuf->size will always be
+	 * reset in ubifs_wbuf_seek_nolock, it won't be any problems.
 	 */
-	size = c->max_write_size - (c->leb_start % c->max_write_size);
+	size = c->max_write_size;
 	wbuf->avail = wbuf->size = size;
 	wbuf->sync_callback = NULL;
 	mutex_init(&wbuf->io_mutex);
@@ -1179,90 +1080,5 @@ int ubifs_wbuf_init(struct ubifs_info *c, struct ubifs_wbuf *wbuf)
 	wbuf->c = c;
 	wbuf->next_ino = 0;
 
-	hrtimer_init(&wbuf->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	wbuf->timer.function = wbuf_timer_callback_nolock;
-	return 0;
-}
-
-/**
- * ubifs_wbuf_add_ino_nolock - add an inode number into the wbuf inode array.
- * @wbuf: the write-buffer where to add
- * @inum: the inode number
- *
- * This function adds an inode number to the inode array of the write-buffer.
- */
-void ubifs_wbuf_add_ino_nolock(struct ubifs_wbuf *wbuf, ino_t inum)
-{
-	if (!wbuf->buf)
-		/* NOR flash or something similar */
-		return;
-
-	spin_lock(&wbuf->lock);
-	if (wbuf->used)
-		wbuf->inodes[wbuf->next_ino++] = inum;
-	spin_unlock(&wbuf->lock);
-}
-
-/**
- * wbuf_has_ino - returns if the wbuf contains data from the inode.
- * @wbuf: the write-buffer
- * @inum: the inode number
- *
- * This function returns with %1 if the write-buffer contains some data from the
- * given inode otherwise it returns with %0.
- */
-static int wbuf_has_ino(struct ubifs_wbuf *wbuf, ino_t inum)
-{
-	int i, ret = 0;
-
-	spin_lock(&wbuf->lock);
-	for (i = 0; i < wbuf->next_ino; i++)
-		if (inum == wbuf->inodes[i]) {
-			ret = 1;
-			break;
-		}
-	spin_unlock(&wbuf->lock);
-
-	return ret;
-}
-
-/**
- * ubifs_sync_wbufs_by_inode - synchronize write-buffers for an inode.
- * @c: UBIFS file-system description object
- * @inode: inode to synchronize
- *
- * This function synchronizes write-buffers which contain nodes belonging to
- * @inode. Returns zero in case of success and a negative error code in case of
- * failure.
- */
-int ubifs_sync_wbufs_by_inode(struct ubifs_info *c, struct inode *inode)
-{
-	int i, err = 0;
-
-	for (i = 0; i < c->jhead_cnt; i++) {
-		struct ubifs_wbuf *wbuf = &c->jheads[i].wbuf;
-
-		if (i == GCHD)
-			/*
-			 * GC head is special, do not look at it. Even if the
-			 * head contains something related to this inode, it is
-			 * a _copy_ of corresponding on-flash node which sits
-			 * somewhere else.
-			 */
-			continue;
-
-		if (!wbuf_has_ino(wbuf, inode->i_ino))
-			continue;
-
-		mutex_lock_nested(&wbuf->io_mutex, wbuf->jhead);
-		if (wbuf_has_ino(wbuf, inode->i_ino))
-			err = ubifs_wbuf_sync_nolock(wbuf);
-		mutex_unlock(&wbuf->io_mutex);
-
-		if (err) {
-			ubifs_ro_mode(c, err);
-			return err;
-		}
-	}
 	return 0;
 }
-- 
2.13.6


