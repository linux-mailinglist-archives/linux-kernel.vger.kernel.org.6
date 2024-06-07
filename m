Return-Path: <linux-kernel+bounces-205323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3118C8FFA9C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8277A1F260D7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C686A1586C5;
	Fri,  7 Jun 2024 04:27:21 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EA21553BC
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734437; cv=none; b=OMCXYUj4/EJ/+iHOZ7GNyvdkmdaeKq88om80xzJjSs9Y5czkMa6uNcMj+6HgOl69um2uiVo4G2AzUzafa24yO4WsfBIKHyIT1FjEI4Tq4OV3lYWcLar3wS/3C7AuG2iIotqhx0HBhibtMUJXDZ3HntFI1KsiFKSJGwsVUi0qIOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734437; c=relaxed/simple;
	bh=nC5lkTcSLoZFeNqXx2/x4/5SdXU7IL+1iY50hwyGkWw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ksdXns2xc9HS1ON2q21/7iZTHvUDYQs5zU2wOj1pugWI5tAUH2IL2+IBI0J8CNc2eh0g55bBYGzHg4sNhoVao5WXosQBoGAzq3nHNqqG0mLU4ubKxh39/Du3r1QCHUNNPFhAGofsl3QbtedTDcpWHvOB0wIolPO0BKOifEmhSkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VwSjq6SdTzsTDr;
	Fri,  7 Jun 2024 12:23:11 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 816BD180085;
	Fri,  7 Jun 2024 12:27:10 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:26:52 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 034/110] ubifs-utils: Adapt ubifs header file in libubifs
Date: Fri, 7 Jun 2024 12:24:59 +0800
Message-ID: <20240607042615.2069840-35-chengzhihao1@huawei.com>
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

Adapt ubifs header file in libubifs, compared with linux kernel
implementations:
 1. New header file contains all definitions in common/ubifs.h
 2. Remove some structures(eg. ubifs_mount_opts, bu_info) and
    functions(eg. ubifs_sync_wbufs_by_inode, ubifs_jnl_XXX) which
    won't be used in fsck/mkfs.
 3. Modify some authentication related functions, keep functions
    that mkfs may need, other functions are defined as empty.
 4. Move ubifs message printing functions(ubifs_err/warn/msg) which
    are originally defined in misc.c into ubifs.h.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/libubifs/ubifs.h | 832 +++++++++++--------------------------------
 1 file changed, 201 insertions(+), 631 deletions(-)

diff --git a/ubifs-utils/libubifs/ubifs.h b/ubifs-utils/libubifs/ubifs.h
index 4226b21e..f32818dc 100644
--- a/ubifs-utils/libubifs/ubifs.h
+++ b/ubifs-utils/libubifs/ubifs.h
@@ -11,38 +11,18 @@
 #ifndef __UBIFS_H__
 #define __UBIFS_H__
 
-#include <asm/div64.h>
-#include <linux/statfs.h>
-#include <linux/fs.h>
-#include <linux/err.h>
-#include <linux/sched.h>
-#include <linux/slab.h>
-#include <linux/vmalloc.h>
-#include <linux/spinlock.h>
-#include <linux/mutex.h>
-#include <linux/rwsem.h>
-#include <linux/mtd/ubi.h>
-#include <linux/pagemap.h>
-#include <linux/backing-dev.h>
-#include <linux/security.h>
-#include <linux/xattr.h>
-#include <linux/random.h>
-#include <linux/sysfs.h>
-#include <linux/completion.h>
-#include <crypto/hash_info.h>
-#include <crypto/hash.h>
-#include <crypto/utils.h>
-
-#include <linux/fscrypt.h>
-
+#include <string.h>
+
+#include "linux_types.h"
+#include "list.h"
+#include "rbtree.h"
+#include "spinlock.h"
+#include "mutex.h"
+#include "rwsem.h"
+#include "atomic.h"
+#include "libubi.h"
 #include "ubifs-media.h"
 
-/* Version of this UBIFS implementation */
-#define UBIFS_VERSION 1
-
-/* UBIFS file system VFS magic number */
-#define UBIFS_SUPER_MAGIC 0x24051905
-
 /* Number of UBIFS blocks per VFS page */
 #define UBIFS_BLOCKS_PER_PAGE (PAGE_SIZE / UBIFS_BLOCK_SIZE)
 #define UBIFS_BLOCKS_PER_PAGE_SHIFT (PAGE_SHIFT - UBIFS_BLOCK_SHIFT)
@@ -59,6 +39,9 @@
  */
 #define MIN_INDEX_LEBS 2
 
+/* Maximum logical eraseblock size in bytes */
+#define UBIFS_MAX_LEB_SZ (2*1024*1024)
+
 /* Minimum amount of data UBIFS writes to the flash */
 #define MIN_WRITE_SZ (UBIFS_DATA_NODE_SZ + 8)
 
@@ -74,12 +57,6 @@
 /* Maximum number of entries in each LPT (LEB category) heap */
 #define LPT_HEAP_SZ 256
 
-/*
- * Background thread name pattern. The numbers are UBI device and volume
- * numbers.
- */
-#define BGT_NAME_PATTERN "ubifs_bgt%d_%d"
-
 /* Maximum possible inode number (only 32-bit inodes are supported now) */
 #define MAX_INUM 0xFFFFFFFF
 
@@ -115,64 +92,11 @@
 /* How much an extended attribute adds to the host inode */
 #define CALC_XATTR_BYTES(data_len) ALIGN(UBIFS_INO_NODE_SZ + (data_len) + 1, 8)
 
-/*
- * Znodes which were not touched for 'OLD_ZNODE_AGE' seconds are considered
- * "old", and znode which were touched last 'YOUNG_ZNODE_AGE' seconds ago are
- * considered "young". This is used by shrinker when selecting znode to trim
- * off.
- */
-#define OLD_ZNODE_AGE 20
-#define YOUNG_ZNODE_AGE 5
-
-/*
- * Some compressors, like LZO, may end up with more data then the input buffer.
- * So UBIFS always allocates larger output buffer, to be sure the compressor
- * will not corrupt memory in case of worst case compression.
- */
-#define WORST_COMPR_FACTOR 2
-
-#ifdef CONFIG_FS_ENCRYPTION
-#define UBIFS_CIPHER_BLOCK_SIZE FSCRYPT_CONTENTS_ALIGNMENT
-#else
-#define UBIFS_CIPHER_BLOCK_SIZE 0
-#endif
-
-/*
- * How much memory is needed for a buffer where we compress a data node.
- */
-#define COMPRESSED_DATA_NODE_BUF_SZ \
-	(UBIFS_DATA_NODE_SZ + UBIFS_BLOCK_SIZE * WORST_COMPR_FACTOR)
-
 /* Maximum expected tree height for use by bottom_up_buf */
 #define BOTTOM_UP_HEIGHT 64
 
-/* Maximum number of data nodes to bulk-read */
-#define UBIFS_MAX_BULK_READ 32
-
-#ifdef CONFIG_UBIFS_FS_AUTHENTICATION
 #define UBIFS_HASH_ARR_SZ UBIFS_MAX_HASH_LEN
 #define UBIFS_HMAC_ARR_SZ UBIFS_MAX_HMAC_LEN
-#else
-#define UBIFS_HASH_ARR_SZ 0
-#define UBIFS_HMAC_ARR_SZ 0
-#endif
-
-/*
- * The UBIFS sysfs directory name pattern and maximum name length (3 for "ubi"
- * + 1 for "_" and plus 2x2 for 2 UBI numbers and 1 for the trailing zero byte.
- */
-#define UBIFS_DFS_DIR_NAME "ubi%d_%d"
-#define UBIFS_DFS_DIR_LEN  (3 + 1 + 2*2 + 1)
-
-/*
- * Lockdep classes for UBIFS inode @ui_mutex.
- */
-enum {
-	WB_MUTEX_1 = 0,
-	WB_MUTEX_2 = 1,
-	WB_MUTEX_3 = 2,
-	WB_MUTEX_4 = 3,
-};
 
 /*
  * Znode flags (actually, bit numbers which store the flags).
@@ -265,18 +189,6 @@ enum {
 	LEB_RETAINED,
 };
 
-/*
- * Action taken upon a failed ubifs_assert().
- * @ASSACT_REPORT: just report the failed assertion
- * @ASSACT_RO: switch to read-only mode
- * @ASSACT_PANIC: call BUG() and possible panic the kernel
- */
-enum {
-	ASSACT_REPORT = 0,
-	ASSACT_RO,
-	ASSACT_PANIC,
-};
-
 /**
  * struct ubifs_old_idx - index node obsoleted since last commit start.
  * @rb: rb-tree node
@@ -351,81 +263,25 @@ struct ubifs_gced_idx_leb {
 
 /**
  * struct ubifs_inode - UBIFS in-memory inode description.
- * @vfs_inode: VFS inode description object
  * @creat_sqnum: sequence number at time of creation
- * @del_cmtno: commit number corresponding to the time the inode was deleted,
- *             protected by @c->commit_sem;
  * @xattr_size: summarized size of all extended attributes in bytes
  * @xattr_cnt: count of extended attributes this inode has
  * @xattr_names: sum of lengths of all extended attribute names belonging to
  *               this inode
- * @dirty: non-zero if the inode is dirty
- * @xattr: non-zero if this is an extended attribute inode
- * @bulk_read: non-zero if bulk-read should be used
- * @ui_mutex: serializes inode write-back with the rest of VFS operations,
- *            serializes "clean <-> dirty" state changes, serializes bulk-read,
- *            protects @dirty, @bulk_read, @ui_size, and @xattr_size
- * @xattr_sem: serilizes write operations (remove|set|create) on xattr
- * @ui_lock: protects @synced_i_size
- * @synced_i_size: synchronized size of inode, i.e. the value of inode size
- *                 currently stored on the flash; used only for regular file
- *                 inodes
  * @ui_size: inode size used by UBIFS when writing to flash
  * @flags: inode flags (@UBIFS_COMPR_FL, etc)
  * @compr_type: default compression type used for this inode
- * @last_page_read: page number of last page read (for bulk read)
- * @read_in_a_row: number of consecutive pages read in a row (for bulk read)
  * @data_len: length of the data attached to the inode
  * @data: inode's data
- *
- * @ui_mutex exists for two main reasons. At first it prevents inodes from
- * being written back while UBIFS changing them, being in the middle of an VFS
- * operation. This way UBIFS makes sure the inode fields are consistent. For
- * example, in 'ubifs_rename()' we change 4 inodes simultaneously, and
- * write-back must not write any of them before we have finished.
- *
- * The second reason is budgeting - UBIFS has to budget all operations. If an
- * operation is going to mark an inode dirty, it has to allocate budget for
- * this. It cannot just mark it dirty because there is no guarantee there will
- * be enough flash space to write the inode back later. This means UBIFS has
- * to have full control over inode "clean <-> dirty" transitions (and pages
- * actually). But unfortunately, VFS marks inodes dirty in many places, and it
- * does not ask the file-system if it is allowed to do so (there is a notifier,
- * but it is not enough), i.e., there is no mechanism to synchronize with this.
- * So UBIFS has its own inode dirty flag and its own mutex to serialize
- * "clean <-> dirty" transitions.
- *
- * The @synced_i_size field is used to make sure we never write pages which are
- * beyond last synchronized inode size. See 'ubifs_writepage()' for more
- * information.
- *
- * The @ui_size is a "shadow" variable for @inode->i_size and UBIFS uses
- * @ui_size instead of @inode->i_size. The reason for this is that UBIFS cannot
- * make sure @inode->i_size is always changed under @ui_mutex, because it
- * cannot call 'truncate_setsize()' with @ui_mutex locked, because it would
- * deadlock with 'ubifs_writepage()' (see file.c). All the other inode fields
- * are changed under @ui_mutex, so they do not need "shadow" fields. Note, one
- * could consider to rework locking and base it on "shadow" fields.
  */
 struct ubifs_inode {
-	struct inode vfs_inode;
 	unsigned long long creat_sqnum;
-	unsigned long long del_cmtno;
 	unsigned int xattr_size;
 	unsigned int xattr_cnt;
 	unsigned int xattr_names;
-	unsigned int dirty:1;
-	unsigned int xattr:1;
-	unsigned int bulk_read:1;
 	unsigned int compr_type:2;
-	struct mutex ui_mutex;
-	struct rw_semaphore xattr_sem;
-	spinlock_t ui_lock;
-	loff_t synced_i_size;
 	loff_t ui_size;
 	int flags;
-	pgoff_t last_page_read;
-	pgoff_t read_in_a_row;
 	int data_len;
 	void *data;
 };
@@ -673,9 +529,6 @@ typedef int (*ubifs_lpt_scan_callback)(struct ubifs_info *c,
  * @io_mutex: serializes write-buffer I/O
  * @lock: serializes @buf, @lnum, @offs, @avail, @used, @next_ino and @inodes
  *        fields
- * @timer: write-buffer timer
- * @no_timer: non-zero if this write-buffer does not have a timer
- * @need_sync: non-zero if the timer expired and the wbuf needs sync'ing
  * @next_ino: points to the next position of the following inode number
  * @inodes: stores the inode numbers of the nodes which are in wbuf
  *
@@ -701,9 +554,6 @@ struct ubifs_wbuf {
 	int (*sync_callback)(struct ubifs_info *c, int lnum, int free, int pad);
 	struct mutex io_mutex;
 	spinlock_t lock;
-	struct hrtimer timer;
-	unsigned int no_timer:1;
-	unsigned int need_sync:1;
 	int next_ino;
 	ino_t *inodes;
 };
@@ -801,28 +651,6 @@ struct ubifs_znode {
 };
 
 /**
- * struct bu_info - bulk-read information.
- * @key: first data node key
- * @zbranch: zbranches of data nodes to bulk read
- * @buf: buffer to read into
- * @buf_len: buffer length
- * @gc_seq: GC sequence number to detect races with GC
- * @cnt: number of data nodes for bulk read
- * @blk_cnt: number of data blocks including holes
- * @oef: end of file reached
- */
-struct bu_info {
-	union ubifs_key key;
-	struct ubifs_zbranch zbranch[UBIFS_MAX_BULK_READ];
-	void *buf;
-	int buf_len;
-	int gc_seq;
-	int cnt;
-	int blk_cnt;
-	int eof;
-};
-
-/**
  * struct ubifs_node_range - node length range description data structure.
  * @len: fixed node length
  * @min_len: minimum possible node length
@@ -839,24 +667,6 @@ struct ubifs_node_range {
 };
 
 /**
- * struct ubifs_compressor - UBIFS compressor description structure.
- * @compr_type: compressor type (%UBIFS_COMPR_LZO, etc)
- * @cc: cryptoapi compressor handle
- * @comp_mutex: mutex used during compression
- * @decomp_mutex: mutex used during decompression
- * @name: compressor name
- * @capi_name: cryptoapi compressor name
- */
-struct ubifs_compressor {
-	int compr_type;
-	struct crypto_comp *cc;
-	struct mutex *comp_mutex;
-	struct mutex *decomp_mutex;
-	const char *name;
-	const char *capi_name;
-};
-
-/**
  * struct ubifs_budget_req - budget requirements of an operation.
  *
  * @fast: non-zero if the budgeting should try to acquire budget quickly and
@@ -943,26 +753,6 @@ struct ubifs_orphan {
 };
 
 /**
- * struct ubifs_mount_opts - UBIFS-specific mount options information.
- * @unmount_mode: selected unmount mode (%0 default, %1 normal, %2 fast)
- * @bulk_read: enable/disable bulk-reads (%0 default, %1 disable, %2 enable)
- * @chk_data_crc: enable/disable CRC data checking when reading data nodes
- *                (%0 default, %1 disable, %2 enable)
- * @override_compr: override default compressor (%0 - do not override and use
- *                  superblock compressor, %1 - override and use compressor
- *                  specified in @compr_type)
- * @compr_type: compressor type to override the superblock compressor with
- *              (%UBIFS_COMPR_NONE, etc)
- */
-struct ubifs_mount_opts {
-	unsigned int unmount_mode:2;
-	unsigned int bulk_read:2;
-	unsigned int chk_data_crc:2;
-	unsigned int override_compr:1;
-	unsigned int compr_type:2;
-};
-
-/**
  * struct ubifs_budg_info - UBIFS budgeting information.
  * @idx_growth: amount of bytes budgeted for index growth
  * @data_growth: amount of bytes budgeted for cached data
@@ -996,24 +786,12 @@ struct ubifs_budg_info {
 	int dent_budget;
 };
 
-/**
- * ubifs_stats_info - per-FS statistics information.
- * @magic_errors: number of bad magic numbers (will be reset with a new mount).
- * @node_errors: number of bad nodes (will be reset with a new mount).
- * @crc_errors: number of bad crcs (will be reset with a new mount).
- */
-struct ubifs_stats_info {
-	unsigned int magic_errors;
-	unsigned int node_errors;
-	unsigned int crc_errors;
-};
-
 struct ubifs_debug_info;
 
 /**
  * struct ubifs_info - UBIFS file-system description data structure
  * (per-superblock).
- * @vfs_sb: VFS @struct super_block object
+ *
  * @sup_node: The super block node as read from the device
  *
  * @highest_inum: highest used inode number
@@ -1023,7 +801,14 @@ struct ubifs_debug_info;
  * @cnt_lock: protects @highest_inum and @max_sqnum counters
  * @fmt_version: UBIFS on-flash format version
  * @ro_compat_version: R/O compatibility version
- * @uuid: UUID from super block
+ *
+ * @debug_level: level of debug messages, 0 - none, 1 - error message,
+ *		 2 - warning message, 3 - notice message, 4 - debug message
+ * @program_type: used to identify the type of current program
+ * @program_name: program name
+ * @dev_name: device name
+ * @dev_fd: opening handler for an UBI volume or an image file
+ * @libubi: opening handler for libubi
  *
  * @lhead_lnum: log head logical eraseblock number
  * @lhead_offs: log head offset
@@ -1048,7 +833,6 @@ struct ubifs_debug_info;
  * @commit_sem: synchronizes committer with other processes
  * @cmt_state: commit state
  * @cs_lock: commit state lock
- * @cmt_wq: wait queue to sleep on if the log is full and a commit is running
  *
  * @big_lpt: flag that LPT is too big to write whole during commit
  * @space_fixup: flag indicating that free space in LEBs needs to be cleaned up
@@ -1056,11 +840,8 @@ struct ubifs_debug_info;
  * @encrypted: flag indicating that this file system contains encrypted files
  * @no_chk_data_crc: do not check CRCs when reading data nodes (except during
  *                   recovery)
- * @bulk_read: enable bulk-reads
- * @default_compr: default compression algorithm (%UBIFS_COMPR_LZO, etc)
- * @rw_incompat: the media is not R/W compatible
- * @assert_action: action to take when a ubifs_assert() fails
  * @authenticated: flag indigating the FS is mounted in authenticated mode
+ * @superblock_need_write: flag indicating that we need to write superblock node
  *
  * @tnc_mutex: protects the Tree Node Cache (TNC), @zroot, @cnext, @enext, and
  *             @calc_idx_sz
@@ -1082,15 +863,6 @@ struct ubifs_debug_info;
  * @mst_node: master node
  * @mst_offs: offset of valid master node
  *
- * @max_bu_buf_len: maximum bulk-read buffer length
- * @bu_mutex: protects the pre-allocated bulk-read buffer and @c->bu
- * @bu: pre-allocated bulk-read information
- *
- * @write_reserve_mutex: protects @write_reserve_buf
- * @write_reserve_buf: on the write path we allocate memory, which might
- *                     sometimes be unavailable, in which case we use this
- *                     write reserve buffer
- *
  * @log_lebs: number of logical eraseblocks in the log
  * @log_bytes: log size in bytes
  * @log_last: last LEB of the log
@@ -1103,12 +875,14 @@ struct ubifs_debug_info;
  * @main_lebs: count of LEBs in the main area
  * @main_first: first LEB of the main area
  * @main_bytes: main area size in bytes
+ * @default_compr: default compression type
+ * @favor_lzo: favor LZO compression method
+ * @favor_percent: lzo vs. zlib threshold used in case favor LZO
  *
  * @key_hash_type: type of the key hash
  * @key_hash: direntry key hash function
  * @key_fmt: key format
  * @key_len: key length
- * @hash_len: The length of the index node hashes
  * @fanout: fanout of the index tree (number of links per indexing node)
  *
  * @min_io_size: minimal input/output unit size
@@ -1117,8 +891,6 @@ struct ubifs_debug_info;
  *                  time (MTD write buffer size)
  * @max_write_shift: number of bits in @max_write_size minus one
  * @leb_size: logical eraseblock size in bytes
- * @leb_start: starting offset of logical eraseblocks within physical
- *             eraseblocks
  * @half_leb_size: half LEB size
  * @idx_leb_size: how many bytes of an LEB are effectively available when it is
  *                used to store indexing nodes (@leb_size - @max_idx_node_sz)
@@ -1150,10 +922,8 @@ struct ubifs_debug_info;
  *                data nodes of maximum size - used in free space reporting
  * @dead_wm: LEB dead space watermark
  * @dark_wm: LEB dark space watermark
- * @block_cnt: count of 4KiB blocks on the FS
  *
  * @ranges: UBIFS node length ranges
- * @ubi: UBI volume descriptor
  * @di: UBI device information
  * @vi: UBI volume information
  *
@@ -1172,11 +942,6 @@ struct ubifs_debug_info;
  * @ohead_offs: orphan head offset
  * @no_orphs: non-zero if there are no orphans
  *
- * @bgt: UBIFS background thread
- * @bgt_name: background thread name
- * @need_bgt: if background thread should run
- * @need_wbuf_sync: if write-buffers have to be synchronized
- *
  * @gc_lnum: LEB number used for garbage collection
  * @sbuf: a buffer of LEB size used by GC and replay for scanning
  * @idx_gc: list of index LEBs that have been garbage collected
@@ -1184,10 +949,6 @@ struct ubifs_debug_info;
  * @gc_seq: incremented for every non-index LEB garbage collected
  * @gced_lnum: last non-index LEB that was garbage collected
  *
- * @infos_list: links all 'ubifs_info' objects
- * @umount_mutex: serializes shrinker and un-mount
- * @shrinker_run_no: shrinker run number
- *
  * @space_bits: number of bits needed to record free or dirty space
  * @lpt_lnum_bits: number of bits needed to record a LEB number in the LPT
  * @lpt_offs_bits: number of bits needed to record an offset in the LPT
@@ -1230,6 +991,7 @@ struct ubifs_debug_info;
  *
  * @ltab_lnum: LEB number of LPT's own lprops table
  * @ltab_offs: offset of LPT's own lprops table
+ * @lpt: lprops table
  * @ltab: LPT's own lprops table
  * @ltab_cmt: LPT's own lprops table (commit copy)
  * @lsave_cnt: number of LEB numbers in LPT's save table
@@ -1238,25 +1000,22 @@ struct ubifs_debug_info;
  * @lsave: LPT's save table
  * @lscan_lnum: LEB number of last LPT scan
  *
- * @rp_size: size of the reserved pool in bytes
- * @report_rp_size: size of the reserved pool reported to user-space
- * @rp_uid: reserved pool user ID
- * @rp_gid: reserved pool group ID
+ * @rp_size: reserved pool size
  *
- * @hash_tfm: the hash transformation used for hashing nodes
- * @hmac_tfm: the HMAC transformation for this filesystem
- * @hmac_desc_len: length of the HMAC used for authentication
- * @auth_key_name: the authentication key name
- * @auth_hash_name: the name of the hash algorithm used for authentication
- * @auth_hash_algo: the authentication hash used for this fs
+ * @hash_algo_name: the name of the hashing algorithm to use
+ * @hash_algo: The hash algo number (from include/linux/hash_info.h)
+ * @auth_key_filename: authentication key file name
+ * @x509_filename: x509 certificate file name for authentication
+ * @hash_len: the length of the hash
+ * @root_idx_hash: The hash of the root index node
+ * @lpt_hash: The hash of the LPT
+ * @mst_hash: The hash of the master node
  * @log_hash: the log hash from the commit start node up to the latest reference
  *            node.
  *
- * @empty: %1 if the UBI device is empty
  * @need_recovery: %1 if the file-system needs recovery
  * @replaying: %1 during journal replay
  * @mounting: %1 while mounting
- * @probing: %1 while attempting to mount if SB_SILENT mount flag is set
  * @remounting_rw: %1 while re-mounting from R/O mode to R/W mode
  * @replay_list: temporary list used during journal replay
  * @replay_buds: list of buds to replay
@@ -1266,16 +1025,11 @@ struct ubifs_debug_info;
  * @rcvrd_mst_node: recovered master node to write when re-mounting R/O mounted
  *                  FS to R/W mode
  * @size_tree: inode size information for recovery
- * @mount_opts: UBIFS-specific mount options
- *
- * @dbg: debugging-related information
- * @stats: statistics exported over sysfs
  *
- * @kobj: kobject for /sys/fs/ubifs/
- * @kobj_unregister: completion to unregister sysfs kobject
+ * @new_ihead_lnum: used by debugging to check @c->ihead_lnum
+ * @new_ihead_offs: used by debugging to check @c->ihead_offs
  */
 struct ubifs_info {
-	struct super_block *vfs_sb;
 	struct ubifs_sb_node *sup_node;
 
 	ino_t highest_inum;
@@ -1284,7 +1038,13 @@ struct ubifs_info {
 	spinlock_t cnt_lock;
 	int fmt_version;
 	int ro_compat_version;
-	unsigned char uuid[16];
+
+	int debug_level;
+	int program_type;
+	const char *program_name;
+	char *dev_name;
+	int dev_fd;
+	libubi_t libubi;
 
 	int lhead_lnum;
 	int lhead_offs;
@@ -1306,20 +1066,12 @@ struct ubifs_info {
 	struct rw_semaphore commit_sem;
 	int cmt_state;
 	spinlock_t cs_lock;
-	wait_queue_head_t cmt_wq;
-
-	struct kobject kobj;
-	struct completion kobj_unregister;
 
 	unsigned int big_lpt:1;
 	unsigned int space_fixup:1;
 	unsigned int double_hash:1;
 	unsigned int encrypted:1;
 	unsigned int no_chk_data_crc:1;
-	unsigned int bulk_read:1;
-	unsigned int default_compr:2;
-	unsigned int rw_incompat:1;
-	unsigned int assert_action:2;
 	unsigned int authenticated:1;
 	unsigned int superblock_need_write:1;
 
@@ -1342,13 +1094,6 @@ struct ubifs_info {
 	struct ubifs_mst_node *mst_node;
 	int mst_offs;
 
-	int max_bu_buf_len;
-	struct mutex bu_mutex;
-	struct bu_info bu;
-
-	struct mutex write_reserve_mutex;
-	void *write_reserve_buf;
-
 	int log_lebs;
 	long long log_bytes;
 	int log_last;
@@ -1361,12 +1106,14 @@ struct ubifs_info {
 	int main_lebs;
 	int main_first;
 	long long main_bytes;
+	int default_compr;
+	int favor_lzo;
+	int favor_percent;
 
 	uint8_t key_hash_type;
 	uint32_t (*key_hash)(const char *str, int len);
 	int key_fmt;
 	int key_len;
-	int hash_len;
 	int fanout;
 
 	int min_io_size;
@@ -1374,7 +1121,6 @@ struct ubifs_info {
 	int max_write_size;
 	int max_write_shift;
 	int leb_size;
-	int leb_start;
 	int half_leb_size;
 	int idx_leb_size;
 	int leb_cnt;
@@ -1402,12 +1148,10 @@ struct ubifs_info {
 	int leb_overhead;
 	int dead_wm;
 	int dark_wm;
-	int block_cnt;
 
 	struct ubifs_node_range ranges[UBIFS_NODE_TYPES_CNT];
-	struct ubi_volume_desc *ubi;
-	struct ubi_device_info di;
-	struct ubi_volume_info vi;
+	struct ubi_dev_info di;
+	struct ubi_vol_info vi;
 
 	struct rb_root orph_tree;
 	struct list_head orph_list;
@@ -1424,11 +1168,6 @@ struct ubifs_info {
 	int ohead_offs;
 	int no_orphs;
 
-	struct task_struct *bgt;
-	char bgt_name[sizeof(BGT_NAME_PATTERN) + 9];
-	int need_bgt;
-	int need_wbuf_sync;
-
 	int gc_lnum;
 	void *sbuf;
 	struct list_head idx_gc;
@@ -1436,10 +1175,6 @@ struct ubifs_info {
 	int gc_seq;
 	int gced_lnum;
 
-	struct list_head infos_list;
-	struct mutex umount_mutex;
-	unsigned int shrinker_run_no;
-
 	int space_bits;
 	int lpt_lnum_bits;
 	int lpt_offs_bits;
@@ -1480,6 +1215,7 @@ struct ubifs_info {
 
 	int ltab_lnum;
 	int ltab_offs;
+	struct ubifs_lprops *lpt;
 	struct ubifs_lpt_lprops *ltab;
 	struct ubifs_lpt_lprops *ltab_cmt;
 	int lsave_cnt;
@@ -1489,97 +1225,99 @@ struct ubifs_info {
 	int lscan_lnum;
 
 	long long rp_size;
-	long long report_rp_size;
-	kuid_t rp_uid;
-	kgid_t rp_gid;
 
-	struct crypto_shash *hash_tfm;
-	struct crypto_shash *hmac_tfm;
-	int hmac_desc_len;
-	char *auth_key_name;
-	char *auth_hash_name;
-	enum hash_algo auth_hash_algo;
+	char *hash_algo_name;
+	int hash_algo;
+	char *auth_key_filename;
+	char *auth_cert_filename;
+	int hash_len;
+	uint8_t root_idx_hash[UBIFS_MAX_HASH_LEN];
+	uint8_t lpt_hash[UBIFS_MAX_HASH_LEN];
+	uint8_t mst_hash[UBIFS_MAX_HASH_LEN];
 
 	struct shash_desc *log_hash;
 
-	/* The below fields are used only during mounting and re-mounting */
-	unsigned int empty:1;
 	unsigned int need_recovery:1;
 	unsigned int replaying:1;
 	unsigned int mounting:1;
 	unsigned int remounting_rw:1;
-	unsigned int probing:1;
 	struct list_head replay_list;
 	struct list_head replay_buds;
 	unsigned long long cs_sqnum;
 	struct list_head unclean_leb_list;
 	struct ubifs_mst_node *rcvrd_mst_node;
 	struct rb_root size_tree;
-	struct ubifs_mount_opts mount_opts;
 
-	struct ubifs_debug_info *dbg;
-	struct ubifs_stats_info *stats;
+	int new_ihead_lnum;
+	int new_ihead_offs;
 };
 
-extern struct list_head ubifs_infos;
-extern spinlock_t ubifs_infos_lock;
 extern atomic_long_t ubifs_clean_zn_cnt;
-extern const struct super_operations ubifs_super_operations;
-extern const struct address_space_operations ubifs_file_address_operations;
-extern const struct file_operations ubifs_file_operations;
-extern const struct inode_operations ubifs_file_inode_operations;
-extern const struct file_operations ubifs_dir_operations;
-extern const struct inode_operations ubifs_dir_inode_operations;
-extern const struct inode_operations ubifs_symlink_inode_operations;
-extern struct ubifs_compressor *ubifs_compressors[UBIFS_COMPR_TYPES_CNT];
-extern int ubifs_default_version;
 
 /* auth.c */
 static inline int ubifs_authenticated(const struct ubifs_info *c)
 {
-	return (IS_ENABLED(CONFIG_UBIFS_FS_AUTHENTICATION)) && c->authenticated;
+	return c->authenticated;
 }
 
-struct shash_desc *__ubifs_hash_get_desc(const struct ubifs_info *c);
-static inline struct shash_desc *ubifs_hash_get_desc(const struct ubifs_info *c)
-{
-	return ubifs_authenticated(c) ? __ubifs_hash_get_desc(c) : NULL;
-}
-
-static inline int ubifs_shash_init(const struct ubifs_info *c,
-				   struct shash_desc *desc)
-{
-	if (ubifs_authenticated(c))
-		return crypto_shash_init(desc);
-	else
-		return 0;
-}
+#ifdef WITH_CRYPTO
+int ubifs_init_authentication(struct ubifs_info *c);
+int ubifs_shash_init(const struct ubifs_info *c, struct shash_desc *desc);
+int ubifs_shash_update(const struct ubifs_info *c, struct shash_desc *desc,
+		       const void *buf, unsigned int len);
+int ubifs_shash_final(const struct ubifs_info *c, struct shash_desc *desc,
+		      u8 *out);
+struct shash_desc *ubifs_hash_get_desc(const struct ubifs_info *c);
+int __ubifs_node_calc_hash(const struct ubifs_info *c, const void *buf,
+			   u8 *hash);
+int ubifs_master_node_calc_hash(const struct ubifs_info *c, const void *node,
+				uint8_t *hash);
+int ubifs_sign_superblock_node(struct ubifs_info *c, void *node);
+void ubifs_bad_hash(const struct ubifs_info *c, const void *node,
+		    const u8 *hash, int lnum, int offs);
+void __ubifs_exit_authentication(struct ubifs_info *c);
+#else
+static inline int ubifs_init_authentication(__unused struct ubifs_info *c)
+{ return 0; }
+static inline int ubifs_shash_init(__unused const struct ubifs_info *c,
+				   __unused struct shash_desc *desc)
+{ return 0; }
+static inline int ubifs_shash_update(__unused const struct ubifs_info *c,
+				     __unused struct shash_desc *desc,
+				     __unused const void *buf,
+				     __unused unsigned int len) { return 0; }
+static inline int ubifs_shash_final(__unused const struct ubifs_info *c,
+				    __unused struct shash_desc *desc,
+				    __unused u8 *out) { return 0; }
+static inline struct shash_desc *
+ubifs_hash_get_desc(__unused const struct ubifs_info *c) { return NULL; }
+static inline int __ubifs_node_calc_hash(__unused const struct ubifs_info *c,
+					 __unused const void *buf,
+					 __unused u8 *hash) { return 0; }
+static inline int
+ubifs_master_node_calc_hash(__unused const struct ubifs_info *c,
+			    __unused const void *node, __unused uint8_t *hash)
+{ return 0; }
+static inline int ubifs_sign_superblock_node(__unused struct ubifs_info *c,
+					     __unused void *node)
+{ return 0; }
+static inline void ubifs_bad_hash(__unused const struct ubifs_info *c,
+				  __unused const void *node,
+				  __unused const u8 *hash, __unused int lnum,
+				  __unused int offs) {}
+static inline void __ubifs_exit_authentication(__unused struct ubifs_info *c) {}
+#endif
 
-static inline int ubifs_shash_update(const struct ubifs_info *c,
-				      struct shash_desc *desc, const void *buf,
-				      unsigned int len)
+static inline int ubifs_prepare_auth_node(__unused struct ubifs_info *c,
+					  __unused void *node,
+					  __unused struct shash_desc *inhash)
 {
-	int err = 0;
-
-	if (ubifs_authenticated(c)) {
-		err = crypto_shash_update(desc, buf, len);
-		if (err < 0)
-			return err;
-	}
-
+	// To be implemented
 	return 0;
 }
 
-static inline int ubifs_shash_final(const struct ubifs_info *c,
-				    struct shash_desc *desc, u8 *out)
-{
-	return ubifs_authenticated(c) ? crypto_shash_final(desc, out) : 0;
-}
-
-int __ubifs_node_calc_hash(const struct ubifs_info *c, const void *buf,
-			  u8 *hash);
-static inline int ubifs_node_calc_hash(const struct ubifs_info *c,
-					const void *buf, u8 *hash)
+static inline int
+ubifs_node_calc_hash(const struct ubifs_info *c, const void *buf, u8 *hash)
 {
 	if (ubifs_authenticated(c))
 		return __ubifs_node_calc_hash(c, buf, hash);
@@ -1587,8 +1325,13 @@ static inline int ubifs_node_calc_hash(const struct ubifs_info *c,
 		return 0;
 }
 
-int ubifs_prepare_auth_node(struct ubifs_info *c, void *node,
-			     struct shash_desc *inhash);
+static inline int
+ubifs_node_check_hash(__unused const struct ubifs_info *c,
+		      __unused const void *buf, __unused const u8 *expected)
+{
+	// To be implemented
+	return 0;
+}
 
 /**
  * ubifs_check_hash - compare two hashes
@@ -1599,10 +1342,12 @@ int ubifs_prepare_auth_node(struct ubifs_info *c, void *node,
  * Compare two hashes @expected and @got. Returns 0 when they are equal, a
  * negative error code otherwise.
  */
-static inline int ubifs_check_hash(const struct ubifs_info *c,
-				   const u8 *expected, const u8 *got)
+static inline int
+ubifs_check_hash(__unused const struct ubifs_info *c,
+		 __unused const u8 *expected, __unused const u8 *got)
 {
-	return crypto_memneq(expected, got, c->hash_len);
+	// To be implemented
+	return 0;
 }
 
 /**
@@ -1614,37 +1359,12 @@ static inline int ubifs_check_hash(const struct ubifs_info *c,
  * Compare two hashes @expected and @got. Returns 0 when they are equal, a
  * negative error code otherwise.
  */
-static inline int ubifs_check_hmac(const struct ubifs_info *c,
-				   const u8 *expected, const u8 *got)
-{
-	return crypto_memneq(expected, got, c->hmac_desc_len);
-}
-
-#ifdef CONFIG_UBIFS_FS_AUTHENTICATION
-void ubifs_bad_hash(const struct ubifs_info *c, const void *node,
-		    const u8 *hash, int lnum, int offs);
-#else
-static inline void ubifs_bad_hash(const struct ubifs_info *c, const void *node,
-				  const u8 *hash, int lnum, int offs) {};
-#endif
-
-int __ubifs_node_check_hash(const struct ubifs_info *c, const void *buf,
-			  const u8 *expected);
-static inline int ubifs_node_check_hash(const struct ubifs_info *c,
-					const void *buf, const u8 *expected)
+static inline int
+ubifs_check_hmac(__unused const struct ubifs_info *c,
+		 __unused const u8 *expected, __unused const u8 *got)
 {
-	if (ubifs_authenticated(c))
-		return __ubifs_node_check_hash(c, buf, expected);
-	else
-		return 0;
-}
-
-int ubifs_init_authentication(struct ubifs_info *c);
-void __ubifs_exit_authentication(struct ubifs_info *c);
-static inline void ubifs_exit_authentication(struct ubifs_info *c)
-{
-	if (ubifs_authenticated(c))
-		__ubifs_exit_authentication(c);
+	// To be implemented
+	return 0;
 }
 
 /**
@@ -1655,8 +1375,8 @@ static inline void ubifs_exit_authentication(struct ubifs_info *c)
  * This returns a pointer to the hash of a branch. Since the key already is a
  * dynamically sized object we cannot use a struct member here.
  */
-static inline u8 *ubifs_branch_hash(struct ubifs_info *c,
-				    struct ubifs_branch *br)
+static inline u8 *
+ubifs_branch_hash(struct ubifs_info *c, struct ubifs_branch *br)
 {
 	return (void *)br + sizeof(*br) + c->key_len;
 }
@@ -1669,33 +1389,28 @@ static inline u8 *ubifs_branch_hash(struct ubifs_info *c,
  *
  * With authentication this copies a hash, otherwise does nothing.
  */
-static inline void ubifs_copy_hash(const struct ubifs_info *c, const u8 *from,
-				   u8 *to)
+static inline void
+ubifs_copy_hash(const struct ubifs_info *c, const u8 *from, u8 *to)
 {
 	if (ubifs_authenticated(c))
 		memcpy(to, from, c->hash_len);
 }
 
-int __ubifs_node_insert_hmac(const struct ubifs_info *c, void *buf,
-			      int len, int ofs_hmac);
-static inline int ubifs_node_insert_hmac(const struct ubifs_info *c, void *buf,
-					  int len, int ofs_hmac)
+static inline int
+ubifs_node_insert_hmac(__unused const struct ubifs_info *c, __unused void *buf,
+		       __unused int len, __unused int ofs_hmac)
 {
-	if (ubifs_authenticated(c))
-		return __ubifs_node_insert_hmac(c, buf, len, ofs_hmac);
-	else
-		return 0;
+	// To be implemented
+	return 0;
 }
 
-int __ubifs_node_verify_hmac(const struct ubifs_info *c, const void *buf,
-			     int len, int ofs_hmac);
-static inline int ubifs_node_verify_hmac(const struct ubifs_info *c,
-					 const void *buf, int len, int ofs_hmac)
+static inline int
+ubifs_node_verify_hmac(__unused const struct ubifs_info *c,
+		       __unused const void *buf, __unused int len,
+		       __unused int ofs_hmac)
 {
-	if (ubifs_authenticated(c))
-		return __ubifs_node_verify_hmac(c, buf, len, ofs_hmac);
-	else
-		return 0;
+	// To be implemented
+	return 0;
 }
 
 /**
@@ -1706,29 +1421,33 @@ static inline int ubifs_node_verify_hmac(const struct ubifs_info *c,
  * be 0 for unauthenticated filesystems or the real size of an auth node
  * authentication is enabled.
  */
-static inline int ubifs_auth_node_sz(const struct ubifs_info *c)
+static inline int
+ubifs_auth_node_sz(__unused const struct ubifs_info *c)
 {
-	if (ubifs_authenticated(c))
-		return sizeof(struct ubifs_auth_node) + c->hmac_desc_len;
-	else
-		return 0;
+	// To be implemented
+	return 0;
 }
-int ubifs_sb_verify_signature(struct ubifs_info *c,
-			      const struct ubifs_sb_node *sup);
-bool ubifs_hmac_zero(struct ubifs_info *c, const u8 *hmac);
 
-int ubifs_hmac_wkm(struct ubifs_info *c, u8 *hmac);
+static inline bool
+ubifs_hmac_zero(__unused struct ubifs_info *c, __unused const u8 *hmac)
+{
+	// To be implemented
+	return true;
+}
 
-int __ubifs_shash_copy_state(const struct ubifs_info *c, struct shash_desc *src,
-			     struct shash_desc *target);
-static inline int ubifs_shash_copy_state(const struct ubifs_info *c,
-					   struct shash_desc *src,
-					   struct shash_desc *target)
+static inline int
+ubifs_shash_copy_state(__unused const struct ubifs_info *c,
+		       __unused struct shash_desc *src,
+		       __unused struct shash_desc *target)
+{
+	// To be implemented
+	return 0;
+}
+
+static inline void ubifs_exit_authentication(struct ubifs_info *c)
 {
 	if (ubifs_authenticated(c))
-		return __ubifs_shash_copy_state(c, src, target);
-	else
-		return 0;
+		__ubifs_exit_authentication(c);
 }
 
 /* io.c */
@@ -1763,9 +1482,6 @@ void ubifs_prep_grp_node(struct ubifs_info *c, void *node, int len, int last);
 int ubifs_io_init(struct ubifs_info *c);
 void ubifs_pad(const struct ubifs_info *c, void *buf, int pad);
 int ubifs_wbuf_sync_nolock(struct ubifs_wbuf *wbuf);
-int ubifs_bg_wbufs_sync(struct ubifs_info *c);
-void ubifs_wbuf_add_ino_nolock(struct ubifs_wbuf *wbuf, ino_t inum);
-int ubifs_sync_wbufs_by_inode(struct ubifs_info *c, struct inode *inode);
 
 /* scan.c */
 struct ubifs_scan_leb *ubifs_scan(const struct ubifs_info *c, int lnum,
@@ -1793,49 +1509,11 @@ int ubifs_log_end_commit(struct ubifs_info *c, int new_ltail_lnum);
 int ubifs_log_post_commit(struct ubifs_info *c, int old_ltail_lnum);
 int ubifs_consolidate_log(struct ubifs_info *c);
 
-/* journal.c */
-int ubifs_jnl_update(struct ubifs_info *c, const struct inode *dir,
-		     const struct fscrypt_name *nm, const struct inode *inode,
-		     int deletion, int xent);
-int ubifs_jnl_write_data(struct ubifs_info *c, const struct inode *inode,
-			 const union ubifs_key *key, const void *buf, int len);
-int ubifs_jnl_write_inode(struct ubifs_info *c, const struct inode *inode);
-int ubifs_jnl_delete_inode(struct ubifs_info *c, const struct inode *inode);
-int ubifs_jnl_xrename(struct ubifs_info *c, const struct inode *fst_dir,
-		      const struct inode *fst_inode,
-		      const struct fscrypt_name *fst_nm,
-		      const struct inode *snd_dir,
-		      const struct inode *snd_inode,
-		      const struct fscrypt_name *snd_nm, int sync);
-int ubifs_jnl_rename(struct ubifs_info *c, const struct inode *old_dir,
-		     const struct inode *old_inode,
-		     const struct fscrypt_name *old_nm,
-		     const struct inode *new_dir,
-		     const struct inode *new_inode,
-		     const struct fscrypt_name *new_nm,
-		     const struct inode *whiteout, int sync);
-int ubifs_jnl_truncate(struct ubifs_info *c, const struct inode *inode,
-		       loff_t old_size, loff_t new_size);
-int ubifs_jnl_delete_xattr(struct ubifs_info *c, const struct inode *host,
-			   const struct inode *inode, const struct fscrypt_name *nm);
-int ubifs_jnl_change_xattr(struct ubifs_info *c, const struct inode *inode1,
-			   const struct inode *inode2);
-
 /* budget.c */
 int ubifs_budget_space(struct ubifs_info *c, struct ubifs_budget_req *req);
 void ubifs_release_budget(struct ubifs_info *c, struct ubifs_budget_req *req);
-void ubifs_release_dirty_inode_budget(struct ubifs_info *c,
-				      struct ubifs_inode *ui);
-int ubifs_budget_inode_op(struct ubifs_info *c, struct inode *inode,
-			  struct ubifs_budget_req *req);
-void ubifs_release_ino_dirty(struct ubifs_info *c, struct inode *inode,
-				struct ubifs_budget_req *req);
-void ubifs_cancel_ino_op(struct ubifs_info *c, struct inode *inode,
-			 struct ubifs_budget_req *req);
-long long ubifs_get_free_space(struct ubifs_info *c);
 long long ubifs_get_free_space_nolock(struct ubifs_info *c);
 int ubifs_calc_min_idx_lebs(struct ubifs_info *c);
-void ubifs_convert_page_budget(struct ubifs_info *c);
 long long ubifs_reported_space(const struct ubifs_info *c, long long free);
 long long ubifs_calc_available(const struct ubifs_info *c, int min_idx_lebs);
 
@@ -1853,8 +1531,6 @@ int ubifs_lookup_level0(struct ubifs_info *c, const union ubifs_key *key,
 			struct ubifs_znode **zn, int *n);
 int ubifs_tnc_lookup_nm(struct ubifs_info *c, const union ubifs_key *key,
 			void *node, const struct fscrypt_name *nm);
-int ubifs_tnc_lookup_dh(struct ubifs_info *c, const union ubifs_key *key,
-			void *node, uint32_t secondary_hash);
 int ubifs_tnc_locate(struct ubifs_info *c, const union ubifs_key *key,
 		     void *node, int *lnum, int *offs);
 int ubifs_tnc_add(struct ubifs_info *c, const union ubifs_key *key, int lnum,
@@ -1867,8 +1543,6 @@ int ubifs_tnc_add_nm(struct ubifs_info *c, const union ubifs_key *key,
 int ubifs_tnc_remove(struct ubifs_info *c, const union ubifs_key *key);
 int ubifs_tnc_remove_nm(struct ubifs_info *c, const union ubifs_key *key,
 			const struct fscrypt_name *nm);
-int ubifs_tnc_remove_dh(struct ubifs_info *c, const union ubifs_key *key,
-			uint32_t cookie);
 int ubifs_tnc_remove_range(struct ubifs_info *c, union ubifs_key *from_key,
 			   union ubifs_key *to_key);
 int ubifs_tnc_remove_ino(struct ubifs_info *c, ino_t inum);
@@ -1885,13 +1559,8 @@ void destroy_old_idx(struct ubifs_info *c);
 int is_idx_node_in_tnc(struct ubifs_info *c, union ubifs_key *key, int level,
 		       int lnum, int offs);
 int insert_old_idx_znode(struct ubifs_info *c, struct ubifs_znode *znode);
-int ubifs_tnc_get_bu_keys(struct ubifs_info *c, struct bu_info *bu);
-int ubifs_tnc_bulk_read(struct ubifs_info *c, struct bu_info *bu);
 
 /* tnc_misc.c */
-struct ubifs_znode *ubifs_tnc_levelorder_next(const struct ubifs_info *c,
-					      struct ubifs_znode *zr,
-					      struct ubifs_znode *znode);
 int ubifs_search_zbranch(const struct ubifs_info *c,
 			 const struct ubifs_znode *znode,
 			 const union ubifs_key *key, int *n);
@@ -1911,14 +1580,7 @@ int ubifs_tnc_read_node(struct ubifs_info *c, struct ubifs_zbranch *zbr,
 int ubifs_tnc_start_commit(struct ubifs_info *c, struct ubifs_zbranch *zroot);
 int ubifs_tnc_end_commit(struct ubifs_info *c);
 
-/* shrinker.c */
-unsigned long ubifs_shrink_scan(struct shrinker *shrink,
-				struct shrink_control *sc);
-unsigned long ubifs_shrink_count(struct shrinker *shrink,
-				 struct shrink_control *sc);
-
 /* commit.c */
-int ubifs_bg_thread(void *info);
 void ubifs_commit_required(struct ubifs_info *c);
 void ubifs_request_bg_commit(struct ubifs_info *c);
 int ubifs_run_commit(struct ubifs_info *c);
@@ -1935,7 +1597,6 @@ int ubifs_write_master(struct ubifs_info *c);
 int ubifs_read_superblock(struct ubifs_info *c);
 int ubifs_write_sb_node(struct ubifs_info *c, struct ubifs_sb_node *sup);
 int ubifs_fixup_free_space(struct ubifs_info *c);
-int ubifs_enable_encryption(struct ubifs_info *c);
 
 /* replay.c */
 int ubifs_validate_entry(struct ubifs_info *c,
@@ -1951,19 +1612,16 @@ int ubifs_get_idx_gc_leb(struct ubifs_info *c);
 int ubifs_garbage_collect_leb(struct ubifs_info *c, struct ubifs_lprops *lp);
 
 /* orphan.c */
-int ubifs_add_orphan(struct ubifs_info *c, ino_t inum);
-void ubifs_delete_orphan(struct ubifs_info *c, ino_t inum);
 int ubifs_orphan_start_commit(struct ubifs_info *c);
 int ubifs_orphan_end_commit(struct ubifs_info *c);
 int ubifs_mount_orphans(struct ubifs_info *c, int unclean, int read_only);
 int ubifs_clear_orphans(struct ubifs_info *c);
 
 /* lpt.c */
+int ubifs_calc_dflt_lpt_geom(struct ubifs_info *c, int *main_lebs, int *big_lpt);
 int ubifs_calc_lpt_geom(struct ubifs_info *c);
 int ubifs_create_lpt(struct ubifs_info *c, struct ubifs_lprops *lps, int lp_cnt,
 		     u8 *hash);
-int ubifs_create_dflt_lpt(struct ubifs_info *c, int *main_lebs, int lpt_first,
-			  int *lpt_lebs, int *big_lpt, u8 *hash);
 int ubifs_lpt_init(struct ubifs_info *c, int rd, int wr);
 struct ubifs_lprops *ubifs_lpt_lookup(struct ubifs_info *c, int lnum);
 struct ubifs_lprops *ubifs_lpt_lookup_dirty(struct ubifs_info *c, int lnum);
@@ -2023,142 +1681,54 @@ const struct ubifs_lprops *ubifs_fast_find_freeable(struct ubifs_info *c);
 const struct ubifs_lprops *ubifs_fast_find_frdi_idx(struct ubifs_info *c);
 int ubifs_calc_dark(const struct ubifs_info *c, int spc);
 
-/* file.c */
-int ubifs_fsync(struct file *file, loff_t start, loff_t end, int datasync);
-int ubifs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
-		  struct iattr *attr);
-int ubifs_update_time(struct inode *inode, int flags);
-
-/* dir.c */
-struct inode *ubifs_new_inode(struct ubifs_info *c, struct inode *dir,
-			      umode_t mode, bool is_xattr);
-int ubifs_getattr(struct mnt_idmap *idmap, const struct path *path,
-		  struct kstat *stat, u32 request_mask, unsigned int flags);
-int ubifs_check_dir_empty(struct inode *dir);
-
-/* xattr.c */
-int ubifs_xattr_set(struct inode *host, const char *name, const void *value,
-		    size_t size, int flags, bool check_lock);
-ssize_t ubifs_xattr_get(struct inode *host, const char *name, void *buf,
-			size_t size);
-
-#ifdef CONFIG_UBIFS_FS_XATTR
-extern const struct xattr_handler * const ubifs_xattr_handlers[];
-ssize_t ubifs_listxattr(struct dentry *dentry, char *buffer, size_t size);
-void ubifs_evict_xattr_inode(struct ubifs_info *c, ino_t xattr_inum);
-int ubifs_purge_xattrs(struct inode *host);
-#else
-#define ubifs_listxattr NULL
-#define ubifs_xattr_handlers NULL
-static inline void ubifs_evict_xattr_inode(struct ubifs_info *c,
-					   ino_t xattr_inum) { }
-static inline int ubifs_purge_xattrs(struct inode *host)
-{
-	return 0;
-}
-#endif
-
-#ifdef CONFIG_UBIFS_FS_SECURITY
-extern int ubifs_init_security(struct inode *dentry, struct inode *inode,
-			const struct qstr *qstr);
-#else
-static inline int ubifs_init_security(struct inode *dentry,
-			struct inode *inode, const struct qstr *qstr)
-{
-	return 0;
-}
-#endif
-
-
 /* super.c */
-struct inode *ubifs_iget(struct super_block *sb, unsigned long inum);
+int open_ubi(struct ubifs_info *c, const char *node);
+void close_ubi(struct ubifs_info *c);
+int open_target(struct ubifs_info *c);
+int close_target(struct ubifs_info *c);
+int check_volume_empty(struct ubifs_info *c);
+void init_ubifs_info(struct ubifs_info *c, int program_type);
+int init_constants_early(struct ubifs_info *c);
+int init_constants_sb(struct ubifs_info *c);
+void init_constants_master(struct ubifs_info *c);
+int take_gc_lnum(struct ubifs_info *c);
+int alloc_wbufs(struct ubifs_info *c);
+void free_wbufs(struct ubifs_info *c);
+void free_orphans(struct ubifs_info *c);
+void destroy_journal(struct ubifs_info *c);
 
 /* recovery.c */
 int ubifs_recover_master_node(struct ubifs_info *c);
-int ubifs_write_rcvrd_mst_node(struct ubifs_info *c);
 struct ubifs_scan_leb *ubifs_recover_leb(struct ubifs_info *c, int lnum,
 					 int offs, void *sbuf, int jhead);
 struct ubifs_scan_leb *ubifs_recover_log_leb(struct ubifs_info *c, int lnum,
 					     int offs, void *sbuf);
 int ubifs_recover_inl_heads(struct ubifs_info *c, void *sbuf);
-int ubifs_clean_lebs(struct ubifs_info *c, void *sbuf);
 int ubifs_rcvry_gc_commit(struct ubifs_info *c);
 int ubifs_recover_size_accum(struct ubifs_info *c, union ubifs_key *key,
 			     int deletion, loff_t new_size);
 int ubifs_recover_size(struct ubifs_info *c, bool in_place);
 void ubifs_destroy_size_tree(struct ubifs_info *c);
 
-/* ioctl.c */
-int ubifs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
-int ubifs_fileattr_set(struct mnt_idmap *idmap,
-		       struct dentry *dentry, struct fileattr *fa);
-long ubifs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
-void ubifs_set_inode_flags(struct inode *inode);
-#ifdef CONFIG_COMPAT
-long ubifs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
-#endif
-
-/* compressor.c */
-int __init ubifs_compressors_init(void);
-void ubifs_compressors_exit(void);
-void ubifs_compress(const struct ubifs_info *c, const void *in_buf, int in_len,
-		    void *out_buf, int *out_len, int *compr_type);
-int ubifs_decompress(const struct ubifs_info *c, const void *buf, int len,
-		     void *out, int *out_len, int compr_type);
-
-/* sysfs.c */
-int ubifs_sysfs_init(void);
-void ubifs_sysfs_exit(void);
-int ubifs_sysfs_register(struct ubifs_info *c);
-void ubifs_sysfs_unregister(struct ubifs_info *c);
-
-#include "debug.h"
-#include "misc.h"
-#include "key.h"
-
-#ifndef CONFIG_FS_ENCRYPTION
-static inline int ubifs_encrypt(const struct inode *inode,
-				struct ubifs_data_node *dn,
-				unsigned int in_len, unsigned int *out_len,
-				int block)
-{
-	struct ubifs_info *c = inode->i_sb->s_fs_info;
-	ubifs_assert(c, 0);
-	return -EOPNOTSUPP;
-}
-static inline int ubifs_decrypt(const struct inode *inode,
-				struct ubifs_data_node *dn,
-				unsigned int *out_len, int block)
-{
-	struct ubifs_info *c = inode->i_sb->s_fs_info;
-	ubifs_assert(c, 0);
-	return -EOPNOTSUPP;
-}
-#else
-/* crypto.c */
-int ubifs_encrypt(const struct inode *inode, struct ubifs_data_node *dn,
-		  unsigned int in_len, unsigned int *out_len, int block);
-int ubifs_decrypt(const struct inode *inode, struct ubifs_data_node *dn,
-		  unsigned int *out_len, int block);
-#endif
-
-extern const struct fscrypt_operations ubifs_crypt_operations;
-
 /* Normal UBIFS messages */
-__printf(2, 3)
-void ubifs_msg(const struct ubifs_info *c, const char *fmt, ...);
-__printf(2, 3)
-void ubifs_err(const struct ubifs_info *c, const char *fmt, ...);
-__printf(2, 3)
-void ubifs_warn(const struct ubifs_info *c, const char *fmt, ...);
-/*
- * A conditional variant of 'ubifs_err()' which doesn't output anything
- * if probing (ie. SB_SILENT set).
- */
-#define ubifs_errc(c, fmt, ...)						\
-do {									\
-	if (!(c)->probing)						\
-		ubifs_err(c, fmt, ##__VA_ARGS__);			\
+enum { ERR_LEVEL = 1, WARN_LEVEL, INFO_LEVEL, DEBUG_LEVEL };
+#define ubifs_msg(c, fmt, ...) do {					\
+	if (c->debug_level >= INFO_LEVEL)				\
+		printf("<INFO> %s[%d] (%s): %s: " fmt "\n",		\
+		       c->program_name, getpid(),			\
+		       c->dev_name, __FUNCTION__, ##__VA_ARGS__);	\
+} while (0)
+#define ubifs_warn(c, fmt, ...) do {					\
+	if (c->debug_level >= WARN_LEVEL)				\
+		printf("<WARN> %s[%d] (%s): %s: " fmt "\n",		\
+		       c->program_name, getpid(),			\
+		       c->dev_name, __FUNCTION__, ##__VA_ARGS__);	\
+} while (0)
+#define ubifs_err(c, fmt, ...) do {					\
+	if (c->debug_level >= ERR_LEVEL)				\
+		printf("<ERROR> %s[%d] (%s): %s: " fmt "\n",		\
+		       c->program_name, getpid(),			\
+		       c->dev_name, __FUNCTION__, ##__VA_ARGS__);	\
 } while (0)
 
 #endif /* !__UBIFS_H__ */
-- 
2.13.6


