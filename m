Return-Path: <linux-kernel+bounces-205299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE93D8FFA82
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E97D7B23229
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1882414D28B;
	Fri,  7 Jun 2024 04:26:57 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA4613E05F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734415; cv=none; b=lxNJ+iE3OfVSrApt83fw+PflUV9P+4qWZv5lh+COojVcmN0bdWZIZh8rQlpkeOQNpnqSCYv/sZQog6oLB/nrlwmOHdjHbetIcxZtGjxbOlpEo8OgWHq0KNfUEk7lKD90MHIzMolvWnkuAw/I7GL9UEWStGqvyx1eXTOwICo7vO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734415; c=relaxed/simple;
	bh=ObvfwTjhDbMioYXijcqbFWqaFGJW5k1txhkSnfrInQ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HPDTa003qprbFjs7gEANp4VFgAJ5SxfDbGXyKgDNO6jur7O6KMhyf94HX5EZXQiOMZY62iAmF25IPxlyWeesaX12Wl4on84T4P55ePbHkf7DrorZqvVbaKhBYQWx6iRhL05zctINf6eTPPFqjPvRTizd3clmCHJS66PR23Vk7pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VwSjR5PpSz1SB2c;
	Fri,  7 Jun 2024 12:22:51 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 7DBE01400D5;
	Fri,  7 Jun 2024 12:26:50 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:26:36 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 014/110] ubifs-utils: Add 'dev_fd' and 'libubi' into 'ubifs_info' structure
Date: Fri, 7 Jun 2024 12:24:39 +0800
Message-ID: <20240607042615.2069840-15-chengzhihao1@huawei.com>
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

Embed new members 'dev_fd' and 'libubi' into ubifs_info structure, so
that global variable 'ubi', 'out_fd' and 'out_ubi' could be removed
from mkfs.ubifs.c. Besides, add parameter in check_volume_empty().
Next patch will extract UBI opening/closing/check_volume_empty functions
into a new source file, these functions will be used in fsck.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/common/lpt.c            |  10 ++--
 ubifs-utils/common/ubifs.h          |  13 ++++-
 ubifs-utils/mkfs.ubifs/mkfs.ubifs.c | 112 +++++++++++++++++++-----------------
 3 files changed, 75 insertions(+), 60 deletions(-)

diff --git a/ubifs-utils/common/lpt.c b/ubifs-utils/common/lpt.c
index 9c1143f6..d07f569f 100644
--- a/ubifs-utils/common/lpt.c
+++ b/ubifs-utils/common/lpt.c
@@ -421,7 +421,7 @@ int create_lpt(struct ubifs_info *c)
 			alen = ALIGN(len, c->min_io_size);
 			set_ltab(c, lnum, c->leb_size - alen, alen - len);
 			memset(p, 0xff, alen - len);
-			err = write_leb(lnum++, alen, buf);
+			err = write_leb(c, lnum++, alen, buf);
 			if (err)
 				goto out;
 			p = buf;
@@ -468,7 +468,7 @@ int create_lpt(struct ubifs_info *c)
 				set_ltab(c, lnum, c->leb_size - alen,
 					    alen - len);
 				memset(p, 0xff, alen - len);
-				err = write_leb(lnum++, alen, buf);
+				err = write_leb(c, lnum++, alen, buf);
 				if (err)
 					goto out;
 				p = buf;
@@ -515,7 +515,7 @@ int create_lpt(struct ubifs_info *c)
 			alen = ALIGN(len, c->min_io_size);
 			set_ltab(c, lnum, c->leb_size - alen, alen - len);
 			memset(p, 0xff, alen - len);
-			err = write_leb(lnum++, alen, buf);
+			err = write_leb(c, lnum++, alen, buf);
 			if (err)
 				goto out;
 			p = buf;
@@ -538,7 +538,7 @@ int create_lpt(struct ubifs_info *c)
 		alen = ALIGN(len, c->min_io_size);
 		set_ltab(c, lnum, c->leb_size - alen, alen - len);
 		memset(p, 0xff, alen - len);
-		err = write_leb(lnum++, alen, buf);
+		err = write_leb(c, lnum++, alen, buf);
 		if (err)
 			goto out;
 		p = buf;
@@ -558,7 +558,7 @@ int create_lpt(struct ubifs_info *c)
 
 	/* Write remaining buffer */
 	memset(p, 0xff, alen - len);
-	err = write_leb(lnum, alen, buf);
+	err = write_leb(c, lnum, alen, buf);
 	if (err)
 		goto out;
 
diff --git a/ubifs-utils/common/ubifs.h b/ubifs-utils/common/ubifs.h
index 502a39ae..5a909f63 100644
--- a/ubifs-utils/common/ubifs.h
+++ b/ubifs-utils/common/ubifs.h
@@ -278,6 +278,8 @@ struct ubifs_znode
  * @program_type: used to identify the type of current program
  * @program_name: program name
  * @dev_name: device name
+ * @dev_fd: opening handler for an UBI volume or an image file
+ * @libubi: opening handler for libubi
  *
  * @jhead_cnt: count of journal heads
  * @max_bud_bytes: maximum number of bytes allowed in buds
@@ -370,6 +372,8 @@ struct ubifs_info
 	int program_type;
 	const char *program_name;
 	char *dev_name;
+	int dev_fd;
+	libubi_t libubi;
 
 	int jhead_cnt;
 	long long max_bud_bytes;
@@ -482,6 +486,13 @@ struct ubifs_branch *ubifs_idx_branch(const struct ubifs_info *c,
 				       (UBIFS_BRANCH_SZ + c->key_len + c->hash_len) * bnum);
 }
 
-int write_leb(int lnum, int len, void *buf);
+int write_leb(struct ubifs_info *c, int lnum, int len, void *buf);
+
+/* super.c */
+int open_ubi(struct ubifs_info *c, const char *node);
+void close_ubi(struct ubifs_info *c);
+int open_target(struct ubifs_info *c);
+int close_target(struct ubifs_info *c);
+int check_volume_empty(struct ubifs_info *c);
 
 #endif /* __UBIFS_H__ */
diff --git a/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c b/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
index 1cafbf3e..8bff44b2 100644
--- a/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
+++ b/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
@@ -136,7 +136,6 @@ struct inum_mapping {
  */
 struct ubifs_info info_;
 static struct ubifs_info *c = &info_;
-static libubi_t ubi;
 
 int verbose;
 int yes;
@@ -145,8 +144,6 @@ static char *root;
 static int root_len;
 static struct fscrypt_context *root_fctx;
 static struct stat root_st;
-static int out_fd;
-static int out_ubi;
 static int squash_owner;
 static int do_create_inum_attr;
 static char *context;
@@ -521,40 +518,42 @@ static long long get_bytes(const char *str)
 	return bytes;
 }
 
-static void close_ubi(void)
+void close_ubi(struct ubifs_info *c)
 {
-	if (ubi) {
-		libubi_close(ubi);
-		ubi = NULL;
+	if (c->libubi) {
+		libubi_close(c->libubi);
+		c->libubi = NULL;
 	}
 }
 
 /**
  * open_ubi - open the libubi.
+ * @c: the UBIFS file-system description object
  * @node: name of the UBI volume character device to fetch information about
  *
  * This function opens libubi, and initialize device & volume information
  * according to @node. Returns %0 in case of success and %-1 in case of failure.
  */
-static int open_ubi(const char *node)
+int open_ubi(struct ubifs_info *c, const char *node)
 {
 	struct stat st;
 
 	if (stat(node, &st) || !S_ISCHR(st.st_mode))
 		return -1;
 
-	ubi = libubi_open();
-	if (!ubi)
-		return -1;
-	if (ubi_get_vol_info(ubi, node, &c->vi)) {
-		close_ubi();
+	c->libubi = libubi_open();
+	if (!c->libubi)
 		return -1;
-	}
-	if (ubi_get_dev_info1(ubi, c->vi.dev_num, &c->di)) {
-		close_ubi();
-		return -1;
-	}
+	if (ubi_get_vol_info(c->libubi, node, &c->vi))
+		goto out_err;
+	if (ubi_get_dev_info1(c->libubi, c->vi.dev_num, &c->di))
+		goto out_err;
+
 	return 0;
+
+out_err:
+	close_ubi(c);
+	return -1;
 }
 
 static void select_default_compr(void)
@@ -840,9 +839,9 @@ static int get_options(int argc, char**argv)
 	if (!c->dev_name)
 		return errmsg("not output device or file specified");
 
-	out_ubi = !open_ubi(c->dev_name);
+	open_ubi(c, c->dev_name);
 
-	if (out_ubi) {
+	if (c->libubi) {
 		c->min_io_size = c->di.min_io_size;
 		c->leb_size = c->vi.leb_size;
 		if (c->max_leb_cnt == -1)
@@ -972,24 +971,25 @@ static void prepare_node(void *node, int len)
 
 /**
  * write_leb - copy the image of a LEB to the output target.
+ * @c: the UBIFS file-system description object
  * @lnum: LEB number
  * @len: length of data in the buffer
  * @buf: buffer (must be at least c->leb_size bytes)
  */
-int write_leb(int lnum, int len, void *buf)
+int write_leb(struct ubifs_info *c, int lnum, int len, void *buf)
 {
 	off_t pos = (off_t)lnum * c->leb_size;
 
 	dbg_msg(3, "LEB %d len %d", lnum, len);
 	memset(buf + len, 0xff, c->leb_size - len);
-	if (out_ubi)
-		if (ubi_leb_change_start(ubi, out_fd, lnum, c->leb_size))
+	if (c->libubi)
+		if (ubi_leb_change_start(c->libubi, c->dev_fd, lnum, c->leb_size))
 			return sys_errmsg("ubi_leb_change_start failed");
 
-	if (lseek(out_fd, pos, SEEK_SET) != pos)
+	if (lseek(c->dev_fd, pos, SEEK_SET) != pos)
 		return sys_errmsg("lseek failed seeking %lld", (long long)pos);
 
-	if (write(out_fd, buf, c->leb_size) != c->leb_size)
+	if (write(c->dev_fd, buf, c->leb_size) != c->leb_size)
 		return sys_errmsg("write failed writing %d bytes at pos %lld",
 				   c->leb_size, (long long)pos);
 
@@ -1002,7 +1002,7 @@ int write_leb(int lnum, int len, void *buf)
  */
 static int write_empty_leb(int lnum)
 {
-	return write_leb(lnum, 0, leb_buf);
+	return write_leb(c, lnum, 0, leb_buf);
 }
 
 /**
@@ -1058,7 +1058,7 @@ static int write_node(void *node, int len, int lnum)
 
 	len = do_pad(leb_buf, len);
 
-	return write_leb(lnum, len, leb_buf);
+	return write_leb(c, lnum, len, leb_buf);
 }
 
 /**
@@ -1172,7 +1172,7 @@ static int flush_nodes(void)
 	if (!head_offs)
 		return 0;
 	len = do_pad(leb_buf, head_offs);
-	err = write_leb(head_lnum, len, leb_buf);
+	err = write_leb(c, head_lnum, len, leb_buf);
 	if (err)
 		return err;
 	set_lprops(head_lnum, head_offs, head_flags);
@@ -2686,7 +2686,7 @@ static int write_super(void)
 
 	len = do_pad(sig, UBIFS_SIG_NODE_SZ + le32_to_cpu(sig->len));
 
-	err = write_leb(UBIFS_SB_LNUM, UBIFS_SB_NODE_SZ + len, sup);
+	err = write_leb(c, UBIFS_SB_LNUM, UBIFS_SB_NODE_SZ + len, sup);
 	if (err)
 		goto out;
 
@@ -2822,6 +2822,7 @@ static int write_orphan_area(void)
 
 /**
  * check_volume_empty - check if the UBI volume is empty.
+ * @c: the UBIFS file-system description object
  *
  * This function checks if the UBI volume is empty by looking if its LEBs are
  * mapped or not.
@@ -2829,12 +2830,12 @@ static int write_orphan_area(void)
  * Returns %0 in case of success, %1 is the volume is not empty,
  * and a negative error code in case of failure.
  */
-static int check_volume_empty(void)
+int check_volume_empty(struct ubifs_info *c)
 {
 	int lnum, err;
 
 	for (lnum = 0; lnum < c->vi.rsvd_lebs; lnum++) {
-		err = ubi_is_mapped(out_fd, lnum);
+		err = ubi_is_mapped(c->dev_fd, lnum);
 		if (err < 0)
 			return err;
 		if (err == 1)
@@ -2845,35 +2846,29 @@ static int check_volume_empty(void)
 
 /**
  * open_target - open the output target.
+ * @c: the UBIFS file-system description object
  *
  * Open the output target. The target can be an UBI volume
  * or a file.
  *
  * Returns %0 in case of success and %-1 in case of failure.
  */
-static int open_target(void)
+int open_target(struct ubifs_info *c)
 {
-	if (out_ubi) {
-		out_fd = open(c->dev_name, O_RDWR | O_EXCL);
+	if (c->libubi) {
+		c->dev_fd = open(c->dev_name, O_RDWR | O_EXCL);
 
-		if (out_fd == -1)
+		if (c->dev_fd == -1)
 			return sys_errmsg("cannot open the UBI volume '%s'",
 					   c->dev_name);
-		if (ubi_set_property(out_fd, UBI_VOL_PROP_DIRECT_WRITE, 1)) {
-			close(out_fd);
+		if (ubi_set_property(c->dev_fd, UBI_VOL_PROP_DIRECT_WRITE, 1)) {
+			close(c->dev_fd);
 			return sys_errmsg("ubi_set_property(set direct_write) failed");
 		}
-
-		if (!yes && check_volume_empty()) {
-			if (!prompt("UBI volume is not empty.  Format anyways?", false)) {
-				close(out_fd);
-				return errmsg("UBI volume is not empty");
-			}
-		}
 	} else {
-		out_fd = open(c->dev_name, O_CREAT | O_RDWR | O_TRUNC,
+		c->dev_fd = open(c->dev_name, O_CREAT | O_RDWR | O_TRUNC,
 			      S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH);
-		if (out_fd == -1)
+		if (c->dev_fd == -1)
 			return sys_errmsg("cannot create output file '%s'",
 					   c->dev_name);
 	}
@@ -2883,18 +2878,19 @@ static int open_target(void)
 
 /**
  * close_target - close the output target.
+ * @c: the UBIFS file-system description object
  *
  * Close the output target. If the target was an UBI
  * volume, also close libubi.
  *
  * Returns %0 in case of success and %-1 in case of failure.
  */
-static int close_target(void)
+int close_target(struct ubifs_info *c)
 {
-	if (out_fd >= 0) {
-		if (ubi && ubi_set_property(out_fd, UBI_VOL_PROP_DIRECT_WRITE, 0))
+	if (c->dev_fd >= 0) {
+		if (c->libubi && ubi_set_property(c->dev_fd, UBI_VOL_PROP_DIRECT_WRITE, 0))
 			return sys_errmsg("ubi_set_property(clear direct_write) failed");
-		if (close(out_fd) == -1)
+		if (close(c->dev_fd) == -1)
 			return sys_errmsg("cannot close the target '%s'", c->dev_name);
 	}
 	return 0;
@@ -3077,24 +3073,32 @@ int main(int argc, char *argv[])
 	if (err)
 		goto out;
 
-	err = open_target();
+	err = open_target(c);
 	if (err)
 		goto out;
 
+	if (!yes && check_volume_empty(c)) {
+		if (!prompt("UBI volume is not empty.  Format anyways?", false)) {
+			close_target(c);
+			err = errmsg("UBI volume is not empty");
+			goto out;
+		}
+	}
+
 	err = mkfs();
 	if (err) {
-		close_target();
+		close_target(c);
 		goto out;
 	}
 
-	err = close_target();
+	err = close_target(c);
 
 	if (verbose && !err)
 		printf("Success!\n");
 
 out:
 	free(c->dev_name);
-	close_ubi();
+	close_ubi(c);
 	crypto_cleanup();
 	return err;
 }
-- 
2.13.6


