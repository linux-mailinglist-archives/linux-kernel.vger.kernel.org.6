Return-Path: <linux-kernel+bounces-205306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CDC8FFA8C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 978B31F25D3C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47573154422;
	Fri,  7 Jun 2024 04:27:00 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFB4140E47
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734418; cv=none; b=grrzfa164zT1oOnKMqzSUqILC3qN51gANQR4o1mgIonQ9bX5PmxGTkrDmUCIMUxBx2f6B8KEufVAG7BrdMSr0q6ZFaZUx4kFtqP+JjqQgnT5ryd/7bYF7KJZsHLDztsj8LyuoWdyMJAAw9dBgDafdP2n4nQPEoxlF5EMNCoCFks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734418; c=relaxed/simple;
	bh=dc/LrlHJAc2ddrxUkGdfuC2nEGaAS6RogYjoPARLD+w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NvWQhNJMf+P7c2gwFvcRZ5iKNuvowU1GvEIKSiIcYPfJXXxWFa37WJHt4v8oVwDlh3szc4xPgwgnzv9IoJcwo+0RcVy3f7W6w9Ya5FIrv7tMqyXE3x3uWzenYDv78aZ2x4vjtagQyz49B6TkIMw1nctO2eg6D5K0Oy/7CHjyyuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VwSkD55lPzPpnM;
	Fri,  7 Jun 2024 12:23:32 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 06BFD14038F;
	Fri,  7 Jun 2024 12:26:52 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:26:48 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 029/110] ubifs-utils: Add implementations for linux kernel printing functions
Date: Fri, 7 Jun 2024 12:24:54 +0800
Message-ID: <20240607042615.2069840-30-chengzhihao1@huawei.com>
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

Add implementations for linux kernel printing functions, because these
functions(eg. pr_debug, pr_err, etc.) are widely used in UBIFS linux
kernel libs. No need to define multiple levels in dbg_msg for debuging,
just replace dbg_msg with pr_debug. Now, there are five levels of
printing messages:
 0 - none
 1 - error message
 2 - warning message [default]
 3 - notice message
 4 - debug message

This is a preparation for replacing implementation of UBIFS utils with
linux kernel libs.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/Makemodule.am           |  2 +-
 ubifs-utils/common/defs.h           | 48 ++++++++++++++++++++++++++--
 ubifs-utils/common/devtable.c       | 26 +++++++--------
 ubifs-utils/common/lpt.c            | 40 +++++++++++------------
 ubifs-utils/mkfs.ubifs/mkfs.ubifs.c | 64 ++++++++++++++++++-------------------
 5 files changed, 112 insertions(+), 68 deletions(-)

diff --git a/ubifs-utils/Makemodule.am b/ubifs-utils/Makemodule.am
index 3329b6f9..c14ba028 100644
--- a/ubifs-utils/Makemodule.am
+++ b/ubifs-utils/Makemodule.am
@@ -46,7 +46,7 @@ mkfs_ubifs_SOURCES = \
 
 mkfs_ubifs_LDADD = libmtd.a libubi.a $(ZLIB_LIBS) $(LZO_LIBS) $(ZSTD_LIBS) $(UUID_LIBS) $(LIBSELINUX_LIBS) $(OPENSSL_LIBS) -lm -lpthread
 mkfs_ubifs_CPPFLAGS = $(AM_CPPFLAGS) $(ZLIB_CFLAGS) $(LZO_CFLAGS) $(ZSTD_CFLAGS) $(UUID_CFLAGS) $(LIBSELINUX_CFLAGS) \
-	-I$(top_srcdir)/ubi-utils/include -I$(top_srcdir)/ubifs-utils/common
+	-I$(top_srcdir)/ubi-utils/include -I$(top_srcdir)/ubifs-utils/common -rdynamic
 
 EXTRA_DIST += ubifs-utils/common/README
 
diff --git a/ubifs-utils/common/defs.h b/ubifs-utils/common/defs.h
index 485c50c0..6d99a2fd 100644
--- a/ubifs-utils/common/defs.h
+++ b/ubifs-utils/common/defs.h
@@ -8,8 +8,10 @@
 
 #include <stdlib.h>
 #include <stdio.h>
+#include <unistd.h>
 #include <limits.h>
 #include <errno.h>
+#include <execinfo.h>
 
 #include "ubifs.h"
 
@@ -22,10 +24,52 @@ extern struct ubifs_info info_;
 
 enum { MKFS_PROGRAM_TYPE = 0 };
 
-#define dbg_msg(lvl, fmt, ...) do {if (info_.debug_level >= lvl)	\
-	printf("%s: %s: " fmt "\n", PROGRAM_NAME, __FUNCTION__, ##__VA_ARGS__); \
+enum { ERR_LEVEL = 1, WARN_LEVEL, INFO_LEVEL, DEBUG_LEVEL };
+
+#define pr_debug(fmt, ...) do { if (info_.debug_level >= DEBUG_LEVEL)	\
+	printf("<DEBUG> %s[%d] (%s): %s: " fmt, PROGRAM_NAME, getpid(),	\
+	       info_.dev_name, __FUNCTION__, ##__VA_ARGS__);		\
+} while(0)
+
+#define pr_notice(fmt, ...) do { if (info_.debug_level >= INFO_LEVEL)	\
+	printf("<INFO> %s[%d] (%s): %s: " fmt, PROGRAM_NAME, getpid(),	\
+	       info_.dev_name, __FUNCTION__, ##__VA_ARGS__);		\
+} while(0)
+
+#define pr_warn(fmt, ...) do { if (info_.debug_level >= WARN_LEVEL)	\
+	printf("<WARN> %s[%d] (%s): %s: " fmt, PROGRAM_NAME, getpid(),	\
+	       info_.dev_name, __FUNCTION__, ##__VA_ARGS__);		\
+} while(0)
+
+#define pr_err(fmt, ...) do { if (info_.debug_level >= ERR_LEVEL)	\
+	printf("<ERROR> %s[%d] (%s): %s: " fmt, PROGRAM_NAME, getpid(),	\
+	       info_.dev_name, __FUNCTION__, ##__VA_ARGS__);		\
 } while(0)
 
+#define pr_cont(fmt, ...) do { if (info_.debug_level >= ERR_LEVEL)	\
+	printf(fmt, ##__VA_ARGS__);					\
+} while(0)
+
+static inline void dump_stack(void)
+{
+#define STACK_SIZE 512
+	int j, nptrs;
+	void *buffer[STACK_SIZE];
+	char **strings;
+
+	if (info_.debug_level < ERR_LEVEL)
+		return;
+
+	nptrs = backtrace(buffer, STACK_SIZE);
+	strings = backtrace_symbols(buffer, nptrs);
+
+	printf("dump_stack:\n");
+	for (j = 0; j < nptrs; j++)
+		printf("%s\n", strings[j]);
+
+	free(strings);
+}
+
 #define unlikely(x) (x)
 
 #define do_div(n,base) ({ \
diff --git a/ubifs-utils/common/devtable.c b/ubifs-utils/common/devtable.c
index 39032646..7347f092 100644
--- a/ubifs-utils/common/devtable.c
+++ b/ubifs-utils/common/devtable.c
@@ -148,10 +148,10 @@ static int interpret_table_entry(const char *line)
 		   &start, &increment, &count) < 0)
 		return sys_errmsg("sscanf failed");
 
-	dbg_msg(3, "name %s, type %c, mode %o, uid %u, gid %u, major %u, "
-		"minor %u, start %u, inc %u, cnt %u",
-		buf, type, mode, uid, gid, major, minor, start,
-		increment, count);
+	pr_debug("name %s, type %c, mode %o, uid %u, gid %u, major %u, "
+		 "minor %u, start %u, inc %u, cnt %u\n",
+		 buf, type, mode, uid, gid, major, minor, start,
+		 increment, count);
 
 	len = strnlen(buf, 1024);
 	if (len == 0)
@@ -204,7 +204,7 @@ static int interpret_table_entry(const char *line)
 	 */
 	ph_elt = hashtable_search(path_htbl, path);
 	if (!ph_elt) {
-		dbg_msg(3, "inserting '%s' into path hash table", path);
+		pr_debug("inserting '%s' into path hash table\n", path);
 		ph_elt = malloc(sizeof(struct path_htbl_element));
 		if (!ph_elt) {
 			errmsg("cannot allocate %zd bytes of memory",
@@ -252,8 +252,8 @@ static int interpret_table_entry(const char *line)
 		nh_elt->gid = gid;
 		nh_elt->dev = makedev(major, minor);
 
-		dbg_msg(3, "inserting '%s' into name hash table (major %d, minor %d)",
-			name, major(nh_elt->dev), minor(nh_elt->dev));
+		pr_debug("inserting '%s' into name hash table (major %d, minor %d)\n",
+			 name, major(nh_elt->dev), minor(nh_elt->dev));
 
 		if (hashtable_search(ph_elt->name_htbl, name)) {
 			errmsg("'%s' is referred twice", buf);
@@ -291,8 +291,8 @@ static int interpret_table_entry(const char *line)
 			sprintf(nm, "%s%d", name, i);
 			nh_elt->name = nm;
 
-			dbg_msg(3, "inserting '%s' into name hash table (major %d, minor %d)",
-			        nm, major(nh_elt->dev), minor(nh_elt->dev));
+			pr_debug("inserting '%s' into name hash table (major %d, minor %d)\n",
+				 nm, major(nh_elt->dev), minor(nh_elt->dev));
 
 			if (hashtable_search(ph_elt->name_htbl, nm)) {
 				errmsg("'%s' is referred twice", buf);
@@ -336,7 +336,7 @@ int parse_devtable(const char *tbl_file)
 	struct stat st;
 	size_t len;
 
-	dbg_msg(1, "parsing device table file '%s'", tbl_file);
+	pr_debug("parsing device table file '%s'\n", tbl_file);
 
 	path_htbl = create_hashtable(128, &r5_hash, &is_equivalent);
 	if (!path_htbl)
@@ -386,7 +386,7 @@ int parse_devtable(const char *tbl_file)
 		line = NULL;
 	}
 
-	dbg_msg(1, "finished parsing");
+	pr_debug("finished parsing\n");
 	fclose(f);
 	return 0;
 
@@ -460,8 +460,8 @@ int override_attributes(struct stat *st, struct path_htbl_element *ph_elt,
 			       "different", strcmp(ph_elt->path, "/") ? ph_elt->path : "",
 			       nh_elt->name);
 
-	dbg_msg(3, "set UID %d, GID %d, mode %o for %s/%s as device table says",
-		nh_elt->uid, nh_elt->gid, nh_elt->mode, ph_elt->path, nh_elt->name);
+	pr_debug("set UID %d, GID %d, mode %o for %s/%s as device table says\n",
+		 nh_elt->uid, nh_elt->gid, nh_elt->mode, ph_elt->path, nh_elt->name);
 
 	st->st_uid = nh_elt->uid;
 	st->st_gid = nh_elt->gid;
diff --git a/ubifs-utils/common/lpt.c b/ubifs-utils/common/lpt.c
index 3c55f91b..0723698d 100644
--- a/ubifs-utils/common/lpt.c
+++ b/ubifs-utils/common/lpt.c
@@ -337,7 +337,7 @@ static void pack_lsave(struct ubifs_info *c, void *buf, int *lsave)
  */
 static void set_ltab(struct ubifs_info *c, int lnum, int free, int dirty)
 {
-	dbg_msg(3, "LEB %d free %d dirty %d to %d %d",
+	pr_debug("LEB %d free %d dirty %d to %d %d\n",
 		lnum, c->ltab[lnum - c->lpt_first].free,
 		c->ltab[lnum - c->lpt_first].dirty, free, dirty);
 	c->ltab[lnum - c->lpt_first].free = free;
@@ -566,26 +566,26 @@ int create_lpt(struct ubifs_info *c)
 	c->nhead_lnum = lnum;
 	c->nhead_offs = ALIGN(len, c->min_io_size);
 
-	dbg_msg(1, "lpt_sz:         %lld", c->lpt_sz);
-	dbg_msg(1, "space_bits:     %d", c->space_bits);
-	dbg_msg(1, "lpt_lnum_bits:  %d", c->lpt_lnum_bits);
-	dbg_msg(1, "lpt_offs_bits:  %d", c->lpt_offs_bits);
-	dbg_msg(1, "lpt_spc_bits:   %d", c->lpt_spc_bits);
-	dbg_msg(1, "pcnt_bits:      %d", c->pcnt_bits);
-	dbg_msg(1, "lnum_bits:      %d", c->lnum_bits);
-	dbg_msg(1, "pnode_sz:       %d", c->pnode_sz);
-	dbg_msg(1, "nnode_sz:       %d", c->nnode_sz);
-	dbg_msg(1, "ltab_sz:        %d", c->ltab_sz);
-	dbg_msg(1, "lsave_sz:       %d", c->lsave_sz);
-	dbg_msg(1, "lsave_cnt:      %d", c->lsave_cnt);
-	dbg_msg(1, "lpt_hght:       %d", c->lpt_hght);
-	dbg_msg(1, "big_lpt:        %d", c->big_lpt);
-	dbg_msg(1, "LPT root is at  %d:%d", c->lpt_lnum, c->lpt_offs);
-	dbg_msg(1, "LPT head is at  %d:%d", c->nhead_lnum, c->nhead_offs);
-	dbg_msg(1, "LPT ltab is at  %d:%d", c->ltab_lnum, c->ltab_offs);
+	pr_debug("lpt_sz:         %lld\n", c->lpt_sz);
+	pr_debug("space_bits:     %d\n", c->space_bits);
+	pr_debug("lpt_lnum_bits:  %d\n", c->lpt_lnum_bits);
+	pr_debug("lpt_offs_bits:  %d\n", c->lpt_offs_bits);
+	pr_debug("lpt_spc_bits:   %d\n", c->lpt_spc_bits);
+	pr_debug("pcnt_bits:      %d\n", c->pcnt_bits);
+	pr_debug("lnum_bits:      %d\n", c->lnum_bits);
+	pr_debug("pnode_sz:       %d\n", c->pnode_sz);
+	pr_debug("nnode_sz:       %d\n", c->nnode_sz);
+	pr_debug("ltab_sz:        %d\n", c->ltab_sz);
+	pr_debug("lsave_sz:       %d\n", c->lsave_sz);
+	pr_debug("lsave_cnt:      %d\n", c->lsave_cnt);
+	pr_debug("lpt_hght:       %d\n", c->lpt_hght);
+	pr_debug("big_lpt:        %d\n", c->big_lpt);
+	pr_debug("LPT root is at  %d:%d\n", c->lpt_lnum, c->lpt_offs);
+	pr_debug("LPT head is at  %d:%d\n", c->nhead_lnum, c->nhead_offs);
+	pr_debug("LPT ltab is at  %d:%d\n", c->ltab_lnum, c->ltab_offs);
 	if (c->big_lpt)
-		dbg_msg(1, "LPT lsave is at %d:%d",
-		        c->lsave_lnum, c->lsave_offs);
+		pr_debug("LPT lsave is at %d:%d\n",
+			 c->lsave_lnum, c->lsave_offs);
 out:
 	free(lsave);
 	free(buf);
diff --git a/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c b/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
index c2f5a29d..fb99222a 100644
--- a/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
+++ b/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
@@ -249,8 +249,8 @@ static const char *helptext =
 "-y, --yes                assume the answer is \"yes\" for all questions\n"
 "-v, --verbose            verbose operation\n"
 "-V, --version            display version information\n"
-"-g, --debug=LEVEL        display debug information (0 - none, 1 - statistics,\n"
-"                         2 - files, 3 - more details)\n"
+"-g, --debug=LEVEL        display printing information (0 - none, 1 - error message, \n"
+"                         2 - warning message[default], 3 - notice message, 4 - debug message)\n"
 "-a, --set-inum-attr      create user.image-inode-number extended attribute on files\n"
 "                         added to the image. The attribute will contain the inode\n"
 "                         number the file has in the generated image.\n"
@@ -632,7 +632,7 @@ static int get_options(int argc, char**argv)
 		case 'g':
 			c->debug_level = strtol(optarg, &endp, 0);
 			if (*endp != '\0' || endp == optarg ||
-			    c->debug_level < 0 || c->debug_level > 3)
+			    c->debug_level < 0 || c->debug_level > DEBUG_LEVEL)
 				return errmsg("bad debugging level '%s'",
 					       optarg);
 			break;
@@ -943,7 +943,7 @@ int write_leb(struct ubifs_info *c, int lnum, int len, void *buf)
 {
 	off_t pos = (off_t)lnum * c->leb_size;
 
-	dbg_msg(3, "LEB %d len %d", lnum, len);
+	pr_debug("LEB %d len %d\n", lnum, len);
 	memset(buf + len, 0xff, c->leb_size - len);
 	if (c->libubi)
 		if (ubi_leb_change_start(c->libubi, c->dev_fd, lnum, c->leb_size))
@@ -980,7 +980,7 @@ static int do_pad(void *buf, int len)
 
 	memset(buf + len, 0xff, alen - len);
 	pad_len = wlen - alen;
-	dbg_msg(3, "len %d pad_len %d", len, pad_len);
+	pr_debug("len %d pad_len %d\n", len, pad_len);
 	buf += alen;
 	if (pad_len >= (int)UBIFS_PAD_NODE_SZ) {
 		struct ubifs_ch *ch = buf;
@@ -1068,8 +1068,7 @@ static void set_lprops(int lnum, int offs, int flags)
 
 	free = c->leb_size - ALIGN(offs, a);
 	dirty = c->leb_size - free - ALIGN(offs, 8);
-	dbg_msg(3, "LEB %d free %d dirty %d flags %d", lnum, free, dirty,
-		flags);
+	pr_debug("LEB %d free %d dirty %d flags %d\n", lnum, free, dirty, flags);
 	if (i < c->main_lebs) {
 		c->lpt[i].free = free;
 		c->lpt[i].dirty = dirty;
@@ -1104,7 +1103,7 @@ static int add_to_index(union ubifs_key *key, char *name, int name_len,
 {
 	struct idx_entry *e;
 
-	dbg_msg(3, "LEB %d offs %d len %d", lnum, offs, len);
+	pr_debug("LEB %d offs %d len %d\n", lnum, offs, len);
 	e = xmalloc(sizeof(struct idx_entry));
 	e->next = NULL;
 	e->prev = idx_list_last;
@@ -1434,19 +1433,19 @@ static int inode_add_selinux_xattr(struct ubifs_ino_node *host_ino,
 	if (selabel_lookup(sehnd, &secontext, sepath, st->st_mode) < 0) {
 		/* Failed to lookup context, assume unlabeled */
 		secontext = strdup("system_u:object_r:unlabeled_t:s0");
-		dbg_msg(2, "missing context: %s\t%s\t%d\n", secontext, sepath,
-				st->st_mode);
+		pr_debug("missing context: %s\t%s\t%d\n", secontext, sepath,
+			 st->st_mode);
 	}
 
-	dbg_msg(2, "appling selinux context on sepath=%s, secontext=%s\n",
-			sepath, secontext);
+	pr_debug("appling selinux context on sepath=%s, secontext=%s\n",
+		 sepath, secontext);
 	free(sepath);
 	con_size = strlen(secontext) + 1;
 	name = strdup(XATTR_NAME_SELINUX);
 
 	ret = add_xattr(host_ino, st, inum, name, secontext, con_size);
 	if (ret < 0)
-		dbg_msg(2, "add_xattr failed %d\n", ret);
+		pr_debug("add_xattr failed %d\n", ret);
 	return ret;
 }
 
@@ -1714,8 +1713,8 @@ static int add_dent_node(ino_t dir_inum, const char *name, ino_t inum,
 	char *kname;
 	int len;
 
-	dbg_msg(3, "%s ino %lu type %u dir ino %lu", name, (unsigned long)inum,
-		(unsigned int)type, (unsigned long)dir_inum);
+	pr_debug("%s ino %lu type %u dir ino %lu\n", name, (unsigned long)inum,
+		 (unsigned int)type, (unsigned long)dir_inum);
 	memset(dent, 0, UBIFS_DENT_NODE_SZ);
 
 	dname.name = (void *)name;
@@ -1916,7 +1915,7 @@ static int add_non_dir(const char *path_name, ino_t *inum, unsigned int nlink,
 {
 	int fd, flags = 0;
 
-	dbg_msg(2, "%s", path_name);
+	pr_debug("%s\n", path_name);
 
 	if (S_ISREG(st->st_mode)) {
 		fd = open(path_name, O_RDONLY);
@@ -2017,7 +2016,7 @@ static int add_directory(const char *dir_name, ino_t dir_inum, struct stat *st,
 	unsigned char type;
 	unsigned long long dir_creat_sqnum = ++c->max_sqnum;
 
-	dbg_msg(2, "%s", dir_name);
+	pr_debug("%s\n", dir_name);
 	if (existing) {
 		dir = opendir(dir_name);
 		if (dir == NULL)
@@ -2237,7 +2236,7 @@ static int add_multi_linked_files(void)
 		unsigned char type = 0;
 
 		for (im = hash_table[i]; im; im = im->next) {
-			dbg_msg(2, "%s", im->path_name);
+			pr_debug("%s\n", im->path_name);
 			err = add_non_dir(im->path_name, &im->use_inum,
 					  im->use_nlink, &type, &im->st, NULL);
 			if (err)
@@ -2342,8 +2341,8 @@ static int add_idx_node(void *node, int child_cnt)
 
 	c->old_idx_sz += ALIGN(len, 8);
 
-	dbg_msg(3, "at %d:%d len %d index size %llu", lnum, offs, len,
-		c->old_idx_sz);
+	pr_debug("at %d:%d len %d index size %llu\n", lnum, offs, len,
+		 c->old_idx_sz);
 
 	/* The last index node written will be the root */
 	c->zroot.lnum = lnum;
@@ -2365,7 +2364,7 @@ static int write_index(void)
 	int child_cnt = 0, j, level, blnum, boffs, blen, blast_len, err;
 	uint8_t *hashes;
 
-	dbg_msg(1, "leaf node count: %zd", idx_cnt);
+	pr_debug("leaf node count: %zd\n", idx_cnt);
 
 	/* Reset the head for the index */
 	head_flags = LPROPS_INDEX;
@@ -2515,13 +2514,13 @@ static int write_index(void)
 	free(idx_ptr);
 	free(idx);
 
-	dbg_msg(1, "zroot is at %d:%d len %d", c->zroot.lnum, c->zroot.offs,
-		c->zroot.len);
+	pr_debug("zroot is at %d:%d len %d\n", c->zroot.lnum, c->zroot.offs,
+		 c->zroot.len);
 
 	/* Set the index head */
 	c->ihead_lnum = head_lnum;
 	c->ihead_offs = ALIGN(head_offs, c->min_io_size);
-	dbg_msg(1, "ihead is at %d:%d", c->ihead_lnum, c->ihead_offs);
+	pr_debug("ihead is at %d:%d\n", c->ihead_lnum, c->ihead_offs);
 
 	/* Flush the last index LEB */
 	err = flush_nodes();
@@ -2567,13 +2566,13 @@ static int finalize_leb_cnt(void)
 		printf("\tindex lebs:   %d\n", c->lst.idx_lebs);
 		printf("\tleb_cnt:      %d\n", c->leb_cnt);
 	}
-	dbg_msg(1, "total_free:  %llu", c->lst.total_free);
-	dbg_msg(1, "total_dirty: %llu", c->lst.total_dirty);
-	dbg_msg(1, "total_used:  %llu", c->lst.total_used);
-	dbg_msg(1, "total_dead:  %llu", c->lst.total_dead);
-	dbg_msg(1, "total_dark:  %llu", c->lst.total_dark);
-	dbg_msg(1, "index size:  %llu", c->old_idx_sz);
-	dbg_msg(1, "empty_lebs:  %d", c->lst.empty_lebs);
+	pr_debug("total_free:  %llu\n", c->lst.total_free);
+	pr_debug("total_dirty: %llu\n", c->lst.total_dirty);
+	pr_debug("total_used:  %llu\n", c->lst.total_used);
+	pr_debug("total_dead:  %llu\n", c->lst.total_dead);
+	pr_debug("total_dark:  %llu\n", c->lst.total_dark);
+	pr_debug("index size:  %llu\n", c->old_idx_sz);
+	pr_debug("empty_lebs:  %d\n", c->lst.empty_lebs);
 	return 0;
 }
 
@@ -2822,7 +2821,7 @@ static int init(void)
 
 	c->dead_wm = ALIGN(MIN_WRITE_SZ, c->min_io_size);
 	c->dark_wm = ALIGN(UBIFS_MAX_NODE_SZ, c->min_io_size);
-	dbg_msg(1, "dead_wm %d  dark_wm %d", c->dead_wm, c->dark_wm);
+	pr_debug("dead_wm %d  dark_wm %d\n", c->dead_wm, c->dark_wm);
 
 	leb_buf = xmalloc(c->leb_size);
 	node_buf = xmalloc(NODE_BUFFER_SIZE);
@@ -2954,6 +2953,7 @@ int main(int argc, char *argv[])
 
 	info_.program_name = MKFS_PROGRAM_NAME;
 	info_.program_type = MKFS_PROGRAM_TYPE;
+	info_.debug_level = WARN_LEVEL;
 
 	if (crypto_init())
 		return -1;
-- 
2.13.6


