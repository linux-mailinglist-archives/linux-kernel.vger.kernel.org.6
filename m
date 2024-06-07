Return-Path: <linux-kernel+bounces-205350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B860E8FFAB7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB7DEB20EBB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DF915EFAF;
	Fri,  7 Jun 2024 04:27:41 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E4B15AACA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734455; cv=none; b=jWZWaLDr41NDKsE5//DhniYUIovt7oun9xT7z4EPJIIdH2x/bfFTdSGodBDn+9mo3Stm72j7+qIEs/ILHKrPw2fO0LJWYLA9VaP8Uzencs/17vfkl9jDUHGRmTaThtbJkkXx+lCKWR5a9SSfraON0z9/jky8QoPLzISYHHzi9Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734455; c=relaxed/simple;
	bh=uHEid7Jpa9sOuwWhl0Mqaw4bgeds4SdY76XDiZTob6A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FidLY/Vbn5ih9+WkBop4vN2KbULyt2Qa3kw7weqnHIaq23W7hOIq0qVNjgx0D7e0gPePoelXmXJtRVpednI/HOE8akhdXOrJ1q5pBjCdf7Ltv/pFR5Jv9HGnOaV8bMgKXARuALI1mO0BoCNwMiXQOK2hQT2g/oC+cqjHncP3usE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwSjP71JGzmYSL;
	Fri,  7 Jun 2024 12:22:49 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id C828C180AA6;
	Fri,  7 Jun 2024 12:27:25 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:10 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 059/110] fsck.ubifs: Distinguish reasons when certain failures happen
Date: Fri, 7 Jun 2024 12:25:24 +0800
Message-ID: <20240607042615.2069840-60-chengzhihao1@huawei.com>
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

Read failure caused by scanning corrupted data or invalid data members
should be identified, beacuse fsck can handle it. Updating lp failure
caused by bad space statistics should be identified too, beacuse fsck
can handle it.
Add eight callback functions to implement it for fsck:
1. set_failure_reason_callback: Record failure reasons when reading or
   parsing node failed, there are four reasons:
   a. FR_DATA_CORRUPTED: scanning corrupted data or invalid nodes found
   b. FR_TNC_CORRUPTED: invalid index nodes
   c. FR_LPT_CORRUPTED: invalid pnode/nnode
   d. FR_LPT_INCORRECT: invalid space statistics or invalid LEB properties
2. get_failure_reason_callback: get failure reasons
3. clear_failure_reason_callback: Clear the error which is caused by
   above reasons.
4. test_and_clear_failure_reason_callback: Check and clear the error
   which is caused by above reasons, if so, fsck will handle it
   according to specific situation.
   For example, fsck will drop data node rather than fails to return
   when reading failure is caused by DATA_CORRUPTED.
   For another example, journal replaying will continue rather than
   fails to return if updating lpt failure is caused by LPT_CORRUPTED.
5. set_lpt_invalid_callback: Set the invalid lpt status
6. test_lpt_valid_callback: Check whether the lpt is corrupted/incorrect,
   it should be invoked before updating lp, if lpt status is invalid,
   returns false (which means that caller should skip updating lp, because
   updating lp could trigger assertion failed in ubifs_change_lp).
7. can_ignore_failure_callback: Check whether the failure can be
   ignored, some inconsistent errors won't affect the fsck process,
   for example wrong space statistics can be fixed after traversing
   TNC, so failures caused by incorrect space statistics can be ignored.
8. handle_failure_callback: Check whether the failure can be handled,
   some inconsistent errors could be fixed by fsck, we have fix_problem
   to do that, but UBIFS needs a callback function to invoke it in common
   libs.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/fsck.ubifs/fsck.ubifs.c | 174 ++++++++++++++++++++++++++++++++++++
 ubifs-utils/fsck.ubifs/fsck.ubifs.h |   5 ++
 ubifs-utils/libubifs/io.c           |   4 +
 ubifs-utils/libubifs/lpt.c          |  66 ++++++++++----
 ubifs-utils/libubifs/lpt_commit.c   |   5 +-
 ubifs-utils/libubifs/master.c       |  18 +++-
 ubifs-utils/libubifs/orphan.c       |   4 +-
 ubifs-utils/libubifs/recovery.c     |   4 +
 ubifs-utils/libubifs/replay.c       |   1 +
 ubifs-utils/libubifs/sb.c           |   2 +
 ubifs-utils/libubifs/scan.c         |   1 +
 ubifs-utils/libubifs/tnc_misc.c     |   4 +
 ubifs-utils/libubifs/ubifs.h        |  98 ++++++++++++++++++++
 13 files changed, 366 insertions(+), 20 deletions(-)

diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.c b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
index b1286150..36a8e061 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.c
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
@@ -168,6 +168,172 @@ static void fsck_assert_failed(__unused const struct ubifs_info *c)
 	exit(exit_code);
 }
 
+static void fsck_set_failure_reason(const struct ubifs_info *c,
+				    unsigned int reason)
+{
+	if (FSCK(c)->mode == REBUILD_MODE)
+		return;
+
+	FSCK(c)->failure_reason = reason;
+	if (reason & FR_LPT_CORRUPTED) {
+		log_out(c, "Found corrupted pnode/nnode, set lpt corrupted");
+		FSCK(c)->lpt_status |= FR_LPT_CORRUPTED;
+	}
+	if (reason & FR_LPT_INCORRECT) {
+		log_out(c, "Bad space statistics, set lpt incorrect");
+		FSCK(c)->lpt_status |= FR_LPT_INCORRECT;
+	}
+}
+
+static unsigned int fsck_get_failure_reason(const struct ubifs_info *c)
+{
+	ubifs_assert(c, FSCK(c)->mode != REBUILD_MODE);
+
+	return FSCK(c)->failure_reason;
+}
+
+static void fsck_clear_failure_reason(const struct ubifs_info *c)
+{
+	ubifs_assert(c, FSCK(c)->mode != REBUILD_MODE);
+
+	FSCK(c)->failure_reason = 0;
+}
+
+static bool fsck_test_and_clear_failure_reason(const struct ubifs_info *c,
+					       unsigned int reason)
+{
+	bool res = (FSCK(c)->failure_reason & reason) != 0;
+
+	ubifs_assert(c, FSCK(c)->mode != REBUILD_MODE);
+	ubifs_assert(c, !(FSCK(c)->failure_reason & (~reason)));
+
+	FSCK(c)->failure_reason = 0;
+
+	return res;
+}
+
+static void fsck_set_lpt_invalid(const struct ubifs_info *c,
+				 unsigned int reason)
+{
+	ubifs_assert(c, FSCK(c)->mode != REBUILD_MODE);
+
+	if (reason & FR_LPT_CORRUPTED) {
+		log_out(c, "Found corrupted pnode/nnode, set lpt corrupted");
+		FSCK(c)->lpt_status |= FR_LPT_CORRUPTED;
+	}
+	if (reason & FR_LPT_INCORRECT) {
+		log_out(c, "Bad space statistics, set lpt incorrect");
+		FSCK(c)->lpt_status |= FR_LPT_INCORRECT;
+	}
+}
+
+static bool fsck_test_lpt_valid(const struct ubifs_info *c, int lnum,
+				int old_free, int old_dirty,
+				int free, int dirty)
+{
+	ubifs_assert(c, FSCK(c)->mode != REBUILD_MODE);
+
+	if (c->cmt_state != COMMIT_RESTING)
+		/* Don't skip updating lpt when do commit. */
+		goto out;
+
+	if (FSCK(c)->lpt_status)
+		return false;
+
+	if (c->lst.empty_lebs < 0 || c->lst.empty_lebs > c->main_lebs) {
+		log_out(c, "Bad empty_lebs %d(main_lebs %d), set lpt incorrect",
+			c->lst.empty_lebs, c->main_lebs);
+		goto out_invalid;
+	}
+	if (c->freeable_cnt < 0 || c->freeable_cnt > c->main_lebs) {
+		log_out(c, "Bad freeable_cnt %d(main_lebs %d), set lpt incorrect",
+			c->freeable_cnt, c->main_lebs);
+		goto out_invalid;
+	}
+	if (c->lst.taken_empty_lebs < 0 ||
+	    c->lst.taken_empty_lebs > c->lst.empty_lebs) {
+		log_out(c, "Bad taken_empty_lebs %d(empty_lebs %d), set lpt incorrect",
+			c->lst.taken_empty_lebs, c->lst.empty_lebs);
+		goto out_invalid;
+	}
+	if (c->lst.total_free & 7) {
+		log_out(c, "total_free(%lld) is not 8 bytes aligned, set lpt incorrect",
+			c->lst.total_free);
+		goto out_invalid;
+	}
+	if (c->lst.total_dirty & 7) {
+		log_out(c, "total_dirty(%lld) is not 8 bytes aligned, set lpt incorrect",
+			c->lst.total_dirty);
+		goto out_invalid;
+	}
+	if (c->lst.total_dead & 7) {
+		log_out(c, "total_dead(%lld) is not 8 bytes aligned, set lpt incorrect",
+			c->lst.total_dead);
+		goto out_invalid;
+	}
+	if (c->lst.total_dark & 7) {
+		log_out(c, "total_dark(%lld) is not 8 bytes aligned, set lpt incorrect",
+			c->lst.total_dark);
+		goto out_invalid;
+	}
+	if (c->lst.total_used & 7) {
+		log_out(c, "total_used(%lld) is not 8 bytes aligned, set lpt incorrect",
+			c->lst.total_used);
+		goto out_invalid;
+	}
+	if (old_free != LPROPS_NC && (old_free & 7)) {
+		log_out(c, "LEB %d old_free(%d) is not 8 bytes aligned, set lpt incorrect",
+			lnum, old_free);
+		goto out_invalid;
+	}
+	if (old_dirty != LPROPS_NC && (old_dirty & 7)) {
+		log_out(c, "LEB %d old_dirty(%d) is not 8 bytes aligned, set lpt incorrect",
+			lnum, old_dirty);
+		goto out_invalid;
+	}
+	if (free != LPROPS_NC && (free < 0 || free > c->leb_size)) {
+		log_out(c, "LEB %d bad free %d(leb_size %d), set lpt incorrect",
+			lnum, free, c->leb_size);
+		goto out_invalid;
+	}
+	if (dirty != LPROPS_NC && dirty < 0) {
+		/* Dirty may be more than c->leb_size before set_bud_lprops. */
+		log_out(c, "LEB %d bad dirty %d(leb_size %d), set lpt incorrect",
+			lnum, dirty, c->leb_size);
+		goto out_invalid;
+	}
+
+out:
+	return true;
+
+out_invalid:
+	FSCK(c)->lpt_status |= FR_LPT_INCORRECT;
+	return false;
+}
+
+static bool fsck_can_ignore_failure(const struct ubifs_info *c,
+				    unsigned int reason)
+{
+	ubifs_assert(c, FSCK(c)->mode != REBUILD_MODE);
+
+	if (c->cmt_state != COMMIT_RESTING)
+		/* Don't ignore failure when do commit. */
+		return false;
+	if (reason & (FR_LPT_CORRUPTED | FR_LPT_INCORRECT))
+		return true;
+
+	return false;
+}
+
+static const unsigned int reason_mapping_table[] = {};
+
+static bool fsck_handle_failure(const struct ubifs_info *c, unsigned int reason)
+{
+	ubifs_assert(c, FSCK(c)->mode != REBUILD_MODE);
+
+	return fix_problem(c, reason_mapping_table[reason]);
+}
+
 static void signal_cancel(int sig)
 {
 	ubifs_warn(c, "killed by signo %d", sig);
@@ -199,6 +365,14 @@ static int init_fsck_info(struct ubifs_info *c, int argc, char *argv[])
 	c->private = fsck;
 	FSCK(c)->mode = mode;
 	c->assert_failed_cb = fsck_assert_failed;
+	c->set_failure_reason_cb = fsck_set_failure_reason;
+	c->get_failure_reason_cb = fsck_get_failure_reason;
+	c->clear_failure_reason_cb = fsck_clear_failure_reason;
+	c->test_and_clear_failure_reason_cb = fsck_test_and_clear_failure_reason;
+	c->set_lpt_invalid_cb = fsck_set_lpt_invalid;
+	c->test_lpt_valid_cb = fsck_test_lpt_valid;
+	c->can_ignore_failure_cb = fsck_can_ignore_failure;
+	c->handle_failure_cb = fsck_handle_failure;
 
 	memset(&sa, 0, sizeof(struct sigaction));
 	sa.sa_handler = signal_cancel;
diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.h b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
index b9783c15..53dc5ff0 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.h
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
@@ -39,9 +39,14 @@ enum { NORMAL_MODE = 0, SAFE_MODE, DANGER_MODE0,
 /**
  * struct ubifs_fsck_info - UBIFS fsck information.
  * @mode: working mode
+ * @failure_reason: reasons for failed operations
+ * @lpt_status: the status of lpt, could be: %0(OK), %FR_LPT_CORRUPTED or
+ *		%FR_LPT_INCORRECT
  */
 struct ubifs_fsck_info {
 	int mode;
+	unsigned int failure_reason;
+	unsigned int lpt_status;
 };
 
 #define FSCK(c) ((struct ubifs_fsck_info*)c->private)
diff --git a/ubifs-utils/libubifs/io.c b/ubifs-utils/libubifs/io.c
index 6f170172..b6fb331b 100644
--- a/ubifs-utils/libubifs/io.c
+++ b/ubifs-utils/libubifs/io.c
@@ -964,6 +964,7 @@ int ubifs_read_node_wbuf(struct ubifs_wbuf *wbuf, void *buf, int type, int len,
 
 	err = ubifs_check_node(c, buf, len, lnum, offs, 0, 0);
 	if (err) {
+		set_failure_reason_callback(c, FR_DATA_CORRUPTED);
 		ubifs_err(c, "expected node type %d", type);
 		return err;
 	}
@@ -977,6 +978,7 @@ int ubifs_read_node_wbuf(struct ubifs_wbuf *wbuf, void *buf, int type, int len,
 	return 0;
 
 out:
+	set_failure_reason_callback(c, FR_DATA_CORRUPTED);
 	ubifs_err(c, "bad node at LEB %d:%d", lnum, offs);
 	ubifs_dump_node(c, buf, len);
 	dump_stack();
@@ -1020,6 +1022,7 @@ int ubifs_read_node(const struct ubifs_info *c, void *buf, int type, int len,
 
 	err = ubifs_check_node(c, buf, len, lnum, offs, 0, 0);
 	if (err) {
+		set_failure_reason_callback(c, FR_DATA_CORRUPTED);
 		ubifs_err(c, "expected node type %d", type);
 		return err;
 	}
@@ -1033,6 +1036,7 @@ int ubifs_read_node(const struct ubifs_info *c, void *buf, int type, int len,
 	return 0;
 
 out:
+	set_failure_reason_callback(c, FR_DATA_CORRUPTED);
 	ubifs_err(c, "bad node at LEB %d:%d, LEB mapping status %d", lnum,
 		  offs, ubi_is_mapped(c->dev_fd, lnum));
 	ubifs_dump_node(c, buf, len);
diff --git a/ubifs-utils/libubifs/lpt.c b/ubifs-utils/libubifs/lpt.c
index 92b3fec8..c0df7c7d 100644
--- a/ubifs-utils/libubifs/lpt.c
+++ b/ubifs-utils/libubifs/lpt.c
@@ -983,6 +983,7 @@ static int check_lpt_crc(const struct ubifs_info *c, void *buf, int len)
 	calc_crc = crc16(-1, buf + UBIFS_LPT_CRC_BYTES,
 			 len - UBIFS_LPT_CRC_BYTES);
 	if (crc != calc_crc) {
+		set_failure_reason_callback(c, FR_LPT_CORRUPTED);
 		ubifs_err(c, "invalid crc in LPT node: crc %hx calc %hx",
 			  crc, calc_crc);
 		dump_stack();
@@ -1007,6 +1008,7 @@ static int check_lpt_type(const struct ubifs_info *c, uint8_t **addr,
 
 	node_type = ubifs_unpack_bits(c, addr, pos, UBIFS_LPT_TYPE_BITS);
 	if (node_type != type) {
+		set_failure_reason_callback(c, FR_LPT_CORRUPTED);
 		ubifs_err(c, "invalid type (%d) in LPT node type %d",
 			  node_type, type);
 		dump_stack();
@@ -1106,8 +1108,10 @@ static int unpack_ltab(const struct ubifs_info *c, void *buf)
 		int dirty = ubifs_unpack_bits(c, &addr, &pos, c->lpt_spc_bits);
 
 		if (free < 0 || free > c->leb_size || dirty < 0 ||
-		    dirty > c->leb_size || free + dirty > c->leb_size)
+		    dirty > c->leb_size || free + dirty > c->leb_size) {
+			set_failure_reason_callback(c, FR_LPT_CORRUPTED);
 			return -EINVAL;
+		}
 
 		c->ltab[i].free = free;
 		c->ltab[i].dirty = dirty;
@@ -1136,8 +1140,10 @@ static int unpack_lsave(const struct ubifs_info *c, void *buf)
 	for (i = 0; i < c->lsave_cnt; i++) {
 		int lnum = ubifs_unpack_bits(c, &addr, &pos, c->lnum_bits);
 
-		if (lnum < c->main_first || lnum >= c->leb_cnt)
+		if (lnum < c->main_first || lnum >= c->leb_cnt) {
+			set_failure_reason_callback(c, FR_LPT_CORRUPTED);
 			return -EINVAL;
+		}
 		c->lsave[i] = lnum;
 	}
 	err = check_lpt_crc(c, buf, c->lsave_sz);
@@ -1162,11 +1168,11 @@ static int validate_nnode(const struct ubifs_info *c, struct ubifs_nnode *nnode,
 		int num = calc_nnode_num_from_parent(c, parent, iip);
 
 		if (nnode->num != num)
-			return -EINVAL;
+			goto out_invalid;
 	}
 	lvl = parent ? parent->level - 1 : c->lpt_hght;
 	if (lvl < 1)
-		return -EINVAL;
+		goto out_invalid;
 	if (lvl == 1)
 		max_offs = c->leb_size - c->pnode_sz;
 	else
@@ -1177,15 +1183,19 @@ static int validate_nnode(const struct ubifs_info *c, struct ubifs_nnode *nnode,
 
 		if (lnum == 0) {
 			if (offs != 0)
-				return -EINVAL;
+				goto out_invalid;
 			continue;
 		}
 		if (lnum < c->lpt_first || lnum > c->lpt_last)
-			return -EINVAL;
+			goto out_invalid;
 		if (offs < 0 || offs > max_offs)
-			return -EINVAL;
+			goto out_invalid;
 	}
 	return 0;
+
+out_invalid:
+	set_failure_reason_callback(c, FR_LPT_CORRUPTED);
+	return -EINVAL;
 }
 
 /**
@@ -1206,7 +1216,7 @@ static int validate_pnode(const struct ubifs_info *c, struct ubifs_pnode *pnode,
 		int num = calc_pnode_num_from_parent(c, parent, iip);
 
 		if (pnode->num != num)
-			return -EINVAL;
+			goto out_invalid;
 	}
 	for (i = 0; i < UBIFS_LPT_FANOUT; i++) {
 		int free = pnode->lprops[i].free;
@@ -1214,13 +1224,17 @@ static int validate_pnode(const struct ubifs_info *c, struct ubifs_pnode *pnode,
 
 		if (free < 0 || free > c->leb_size || free % c->min_io_size ||
 		    (free & 7))
-			return -EINVAL;
+			goto out_invalid;
 		if (dirty < 0 || dirty > c->leb_size || (dirty & 7))
-			return -EINVAL;
+			goto out_invalid;
 		if (dirty + free > c->leb_size)
-			return -EINVAL;
+			goto out_invalid;
 	}
 	return 0;
+
+out_invalid:
+	set_failure_reason_callback(c, FR_LPT_CORRUPTED);
+	return -EINVAL;
 }
 
 /**
@@ -1283,8 +1297,11 @@ int ubifs_read_nnode(struct ubifs_info *c, struct ubifs_nnode *parent, int iip)
 			nnode->num = calc_nnode_num_from_parent(c, parent, iip);
 	} else {
 		err = ubifs_leb_read(c, lnum, buf, offs, c->nnode_sz, 1);
-		if (err)
+		if (err) {
+			if (err == -EBADMSG)
+				set_failure_reason_callback(c, FR_LPT_CORRUPTED);
 			goto out;
+		}
 		err = ubifs_unpack_nnode(c, buf, nnode);
 		if (err)
 			goto out;
@@ -1352,8 +1369,11 @@ static int read_pnode(struct ubifs_info *c, struct ubifs_nnode *parent, int iip)
 		}
 	} else {
 		err = ubifs_leb_read(c, lnum, buf, offs, c->pnode_sz, 1);
-		if (err)
+		if (err) {
+			if (err == -EBADMSG)
+				set_failure_reason_callback(c, FR_LPT_CORRUPTED);
 			goto out;
+		}
 		err = unpack_pnode(c, buf, pnode);
 		if (err)
 			goto out;
@@ -1394,8 +1414,11 @@ static int read_ltab(struct ubifs_info *c)
 	if (!buf)
 		return -ENOMEM;
 	err = ubifs_leb_read(c, c->ltab_lnum, buf, c->ltab_offs, c->ltab_sz, 1);
-	if (err)
+	if (err) {
+		if (err == -EBADMSG)
+			set_failure_reason_callback(c, FR_LPT_CORRUPTED);
 		goto out;
+	}
 	err = unpack_ltab(c, buf);
 out:
 	vfree(buf);
@@ -1418,8 +1441,11 @@ static int read_lsave(struct ubifs_info *c)
 		return -ENOMEM;
 	err = ubifs_leb_read(c, c->lsave_lnum, buf, c->lsave_offs,
 			     c->lsave_sz, 1);
-	if (err)
+	if (err) {
+		if (err == -EBADMSG)
+			set_failure_reason_callback(c, FR_LPT_CORRUPTED);
 		goto out;
+	}
 	err = unpack_lsave(c, buf);
 	if (err)
 		goto out;
@@ -2031,8 +2057,11 @@ static struct ubifs_nnode *scan_get_nnode(struct ubifs_info *c,
 	} else {
 		err = ubifs_leb_read(c, branch->lnum, buf, branch->offs,
 				     c->nnode_sz, 1);
-		if (err)
+		if (err) {
+			if (err == -EBADMSG)
+				set_failure_reason_callback(c, FR_LPT_CORRUPTED);
 			return ERR_PTR(err);
+		}
 		err = ubifs_unpack_nnode(c, buf, nnode);
 		if (err)
 			return ERR_PTR(err);
@@ -2100,8 +2129,11 @@ static struct ubifs_pnode *scan_get_pnode(struct ubifs_info *c,
 		ubifs_assert(c, branch->offs >= 0 && branch->offs < c->leb_size);
 		err = ubifs_leb_read(c, branch->lnum, buf, branch->offs,
 				     c->pnode_sz, 1);
-		if (err)
+		if (err) {
+			if (err == -EBADMSG)
+				set_failure_reason_callback(c, FR_LPT_CORRUPTED);
 			return ERR_PTR(err);
+		}
 		err = unpack_pnode(c, buf, pnode);
 		if (err)
 			return ERR_PTR(err);
diff --git a/ubifs-utils/libubifs/lpt_commit.c b/ubifs-utils/libubifs/lpt_commit.c
index b00f75f0..43eb7a6a 100644
--- a/ubifs-utils/libubifs/lpt_commit.c
+++ b/ubifs-utils/libubifs/lpt_commit.c
@@ -1607,8 +1607,11 @@ static int dbg_check_ltab_lnum(struct ubifs_info *c, int lnum)
 	dbg_lp("LEB %d", lnum);
 
 	err = ubifs_leb_read(c, lnum, buf, 0, c->leb_size, 1);
-	if (err)
+	if (err) {
+		if (err == -EBADMSG)
+			set_failure_reason_callback(c, FR_LPT_CORRUPTED);
 		goto out;
+	}
 
 	while (1) {
 		if (!is_a_node(c, p, len)) {
diff --git a/ubifs-utils/libubifs/master.c b/ubifs-utils/libubifs/master.c
index cce1a415..61ff4cec 100644
--- a/ubifs-utils/libubifs/master.c
+++ b/ubifs-utils/libubifs/master.c
@@ -146,10 +146,12 @@ static int scan_for_master(struct ubifs_info *c)
 	return 0;
 
 out:
+	set_failure_reason_callback(c, FR_DATA_CORRUPTED);
 	ubifs_scan_destroy(sleb);
 	return -EUCLEAN;
 
 out_dump:
+	set_failure_reason_callback(c, FR_DATA_CORRUPTED);
 	ubifs_err(c, "unexpected node type %d master LEB %d:%d",
 		  snod->type, lnum, snod->offs);
 	ubifs_scan_destroy(sleb);
@@ -165,6 +167,7 @@ out_dump:
  */
 static int validate_master(const struct ubifs_info *c)
 {
+	unsigned int reason = FR_DATA_CORRUPTED;
 	long long main_sz;
 	int err;
 
@@ -254,39 +257,46 @@ static int validate_master(const struct ubifs_info *c)
 	}
 
 	if (c->lst.empty_lebs < 0 || c->lst.empty_lebs > c->main_lebs - 2) {
+		reason = FR_LPT_INCORRECT;
 		err = 15;
 		goto out;
 	}
 
 	if (c->lst.idx_lebs < 0 || c->lst.idx_lebs > c->main_lebs - 1) {
+		reason = FR_LPT_INCORRECT;
 		err = 16;
 		goto out;
 	}
 
 	if (c->lst.total_free < 0 || c->lst.total_free > main_sz ||
 	    c->lst.total_free & 7) {
+		reason = FR_LPT_INCORRECT;
 		err = 17;
 		goto out;
 	}
 
 	if (c->lst.total_dirty < 0 || (c->lst.total_dirty & 7)) {
+		reason = FR_LPT_INCORRECT;
 		err = 18;
 		goto out;
 	}
 
 	if (c->lst.total_used < 0 || (c->lst.total_used & 7)) {
+		reason = FR_LPT_INCORRECT;
 		err = 19;
 		goto out;
 	}
 
 	if (c->lst.total_free + c->lst.total_dirty +
 	    c->lst.total_used > main_sz) {
+		reason = FR_LPT_INCORRECT;
 		err = 20;
 		goto out;
 	}
 
 	if (c->lst.total_dead + c->lst.total_dark +
 	    c->lst.total_used + c->bi.old_idx_sz > main_sz) {
+		reason = FR_LPT_INCORRECT;
 		err = 21;
 		goto out;
 	}
@@ -294,6 +304,7 @@ static int validate_master(const struct ubifs_info *c)
 	if (c->lst.total_dead < 0 ||
 	    c->lst.total_dead > c->lst.total_free + c->lst.total_dirty ||
 	    c->lst.total_dead & 7) {
+		reason = FR_LPT_INCORRECT;
 		err = 22;
 		goto out;
 	}
@@ -301,6 +312,7 @@ static int validate_master(const struct ubifs_info *c)
 	if (c->lst.total_dark < 0 ||
 	    c->lst.total_dark > c->lst.total_free + c->lst.total_dirty ||
 	    c->lst.total_dark & 7) {
+		reason = FR_LPT_INCORRECT;
 		err = 23;
 		goto out;
 	}
@@ -308,6 +320,7 @@ static int validate_master(const struct ubifs_info *c)
 	return 0;
 
 out:
+	set_failure_reason_callback(c, reason);
 	ubifs_err(c, "bad master node at offset %d error %d", c->mst_offs, err);
 	ubifs_dump_node(c, c->mst_node, c->mst_node_alsz);
 	return -EINVAL;
@@ -331,8 +344,10 @@ int ubifs_read_master(struct ubifs_info *c)
 
 	err = scan_for_master(c);
 	if (err) {
-		if (err == -EUCLEAN)
+		if (err == -EUCLEAN) {
+			clear_failure_reason_callback(c);
 			err = ubifs_recover_master_node(c);
+		}
 		if (err)
 			/*
 			 * Note, we do not free 'c->mst_node' here because the
@@ -386,6 +401,7 @@ int ubifs_read_master(struct ubifs_info *c)
 
 		if (c->leb_cnt < old_leb_cnt ||
 		    c->leb_cnt < UBIFS_MIN_LEB_CNT) {
+			set_failure_reason_callback(c, FR_DATA_CORRUPTED);
 			ubifs_err(c, "bad leb_cnt on master node");
 			ubifs_dump_node(c, c->mst_node, c->mst_node_alsz);
 			return -EINVAL;
diff --git a/ubifs-utils/libubifs/orphan.c b/ubifs-utils/libubifs/orphan.c
index 2f318748..26668cbd 100644
--- a/ubifs-utils/libubifs/orphan.c
+++ b/ubifs-utils/libubifs/orphan.c
@@ -547,9 +547,11 @@ static int kill_orphans(struct ubifs_info *c)
 		dbg_rcvry("LEB %d", lnum);
 		sleb = ubifs_scan(c, lnum, 0, c->sbuf, 1);
 		if (IS_ERR(sleb)) {
-			if (PTR_ERR(sleb) == -EUCLEAN)
+			if (PTR_ERR(sleb) == -EUCLEAN) {
+				clear_failure_reason_callback(c);
 				sleb = ubifs_recover_leb(c, lnum, 0,
 							 c->sbuf, -1);
+			}
 			if (IS_ERR(sleb)) {
 				err = PTR_ERR(sleb);
 				break;
diff --git a/ubifs-utils/libubifs/recovery.c b/ubifs-utils/libubifs/recovery.c
index 910414cb..9115b17a 100644
--- a/ubifs-utils/libubifs/recovery.c
+++ b/ubifs-utils/libubifs/recovery.c
@@ -182,6 +182,7 @@ static int get_master_node(const struct ubifs_info *c, int lnum, void **pbuf,
 	return 0;
 
 out_err:
+	set_failure_reason_callback(c, FR_DATA_CORRUPTED);
 	err = -EINVAL;
 out_free:
 	vfree(sbuf);
@@ -355,6 +356,7 @@ int ubifs_recover_master_node(struct ubifs_info *c)
 	return 0;
 
 out_err:
+	set_failure_reason_callback(c, FR_DATA_CORRUPTED);
 	err = -EINVAL;
 out_free:
 	ubifs_err(c, "failed to recover master node");
@@ -762,6 +764,7 @@ corrupted_rescan:
 	ubifs_err(c, "corruption %d", ret);
 	ubifs_scan_a_node(c, buf, len, lnum, offs, 0);
 corrupted:
+	set_failure_reason_callback(c, FR_DATA_CORRUPTED);
 	ubifs_scanned_corruption(c, lnum, offs, buf);
 	err = -EUCLEAN;
 error:
@@ -817,6 +820,7 @@ static int get_cs_sqnum(struct ubifs_info *c, int lnum, int offs,
 
 out_err:
 	err = -EINVAL;
+	set_failure_reason_callback(c, FR_DATA_CORRUPTED);
 out_free:
 	ubifs_err(c, "failed to get CS sqnum");
 	kfree(cs_node);
diff --git a/ubifs-utils/libubifs/replay.c b/ubifs-utils/libubifs/replay.c
index ff9efaac..0ed12e3a 100644
--- a/ubifs-utils/libubifs/replay.c
+++ b/ubifs-utils/libubifs/replay.c
@@ -928,6 +928,7 @@ static int replay_log_leb(struct ubifs_info *c, int lnum, int offs, void *sbuf)
 	if (IS_ERR(sleb)) {
 		if (PTR_ERR(sleb) != -EUCLEAN || !c->need_recovery)
 			return PTR_ERR(sleb);
+		clear_failure_reason_callback(c);
 		/*
 		 * Note, the below function will recover this log LEB only if
 		 * it is the last, because unclean reboots can possibly corrupt
diff --git a/ubifs-utils/libubifs/sb.c b/ubifs-utils/libubifs/sb.c
index 312661d6..2147280e 100644
--- a/ubifs-utils/libubifs/sb.c
+++ b/ubifs-utils/libubifs/sb.c
@@ -360,6 +360,8 @@ int ubifs_read_superblock(struct ubifs_info *c)
 
 	err = validate_sb(c, sup);
 out:
+	if (err)
+		set_failure_reason_callback(c, FR_DATA_CORRUPTED);
 	return err;
 }
 
diff --git a/ubifs-utils/libubifs/scan.c b/ubifs-utils/libubifs/scan.c
index 74509fd0..e9581a62 100644
--- a/ubifs-utils/libubifs/scan.c
+++ b/ubifs-utils/libubifs/scan.c
@@ -344,6 +344,7 @@ corrupted:
 	}
 	err = -EUCLEAN;
 	ubifs_scan_destroy(sleb);
+	set_failure_reason_callback(c, FR_DATA_CORRUPTED);
 	return ERR_PTR(err);
 
 error:
diff --git a/ubifs-utils/libubifs/tnc_misc.c b/ubifs-utils/libubifs/tnc_misc.c
index 8c38f153..0ffb4342 100644
--- a/ubifs-utils/libubifs/tnc_misc.c
+++ b/ubifs-utils/libubifs/tnc_misc.c
@@ -222,6 +222,8 @@ static int read_znode(struct ubifs_info *c, struct ubifs_zbranch *zzbr,
 
 	err = ubifs_read_node(c, idx, UBIFS_IDX_NODE, len, lnum, offs);
 	if (err < 0) {
+		if (test_and_clear_failure_reason_callback(c, FR_DATA_CORRUPTED))
+			set_failure_reason_callback(c, FR_TNC_CORRUPTED);
 		kfree(idx);
 		return err;
 	}
@@ -335,6 +337,7 @@ static int read_znode(struct ubifs_info *c, struct ubifs_zbranch *zzbr,
 	return 0;
 
 out_dump:
+	set_failure_reason_callback(c, FR_TNC_CORRUPTED);
 	ubifs_err(c, "bad indexing node at LEB %d:%d, error %d", lnum, offs, err);
 	ubifs_dump_node(c, idx, c->max_idx_node_sz);
 	kfree(idx);
@@ -430,6 +433,7 @@ int ubifs_tnc_read_node(struct ubifs_info *c, struct ubifs_zbranch *zbr,
 	/* Make sure the key of the read node is correct */
 	key_read(c, node + UBIFS_KEY_OFFSET, &key1);
 	if (!keys_eq(c, key, &key1)) {
+		set_failure_reason_callback(c, FR_DATA_CORRUPTED);
 		ubifs_err(c, "bad key in node at LEB %d:%d",
 			  zbr->lnum, zbr->offs);
 		dbg_tnck(key, "looked for key ");
diff --git a/ubifs-utils/libubifs/ubifs.h b/ubifs-utils/libubifs/ubifs.h
index babaae8f..21b0ce0a 100644
--- a/ubifs-utils/libubifs/ubifs.h
+++ b/ubifs-utils/libubifs/ubifs.h
@@ -1029,6 +1029,20 @@ struct ubifs_budg_info {
  *
  * @private: private information related to specific situation, eg. fsck.
  * @assert_failed_cb: callback function to handle assertion failure
+ * @set_failure_reason_cb: record reasons while certain failure happens
+ * @get_failure_reason_cb: get failure reasons
+ * @clear_failure_reason_cb: callback function to clear the error which is
+ *			     caused by reading corrupted data or invalid lpt
+ * @test_and_clear_failure_reason_cb: callback function to check and clear the
+ *				      error which is caused by reading corrupted
+ *				      data or invalid lpt
+ * @set_lpt_invalid_cb: callback function to set the invalid lpt status
+ * @test_lpt_valid_cb: callback function to check whether lpt is corrupted or
+ *		       incorrect, should be called before updating lpt
+ * @can_ignore_failure_cb: callback function to decide whether the failure
+ *			   can be ignored
+ * @handle_failure_cb: callback function to decide whether the failure can be
+ *		       handled
  */
 struct ubifs_info {
 	struct ubifs_sb_node *sup_node;
@@ -1254,6 +1268,21 @@ struct ubifs_info {
 
 	void *private;
 	void (*assert_failed_cb)(const struct ubifs_info *c);
+	void (*set_failure_reason_cb)(const struct ubifs_info *c,
+				      unsigned int reason);
+	unsigned int (*get_failure_reason_cb)(const struct ubifs_info *c);
+	void (*clear_failure_reason_cb)(const struct ubifs_info *c);
+	bool (*test_and_clear_failure_reason_cb)(const struct ubifs_info *c,
+						 unsigned int reason);
+	void (*set_lpt_invalid_cb)(const struct ubifs_info *c,
+				   unsigned int reason);
+	bool (*test_lpt_valid_cb)(const struct ubifs_info *c, int lnum,
+				  int old_free, int old_dirty,
+				  int free, int dirty);
+	bool (*can_ignore_failure_cb)(const struct ubifs_info *c,
+				      unsigned int reason);
+	bool (*handle_failure_cb)(const struct ubifs_info *c,
+				  unsigned int reason);
 };
 
 extern atomic_long_t ubifs_clean_zn_cnt;
@@ -1502,6 +1531,75 @@ int ubifs_add_snod(const struct ubifs_info *c, struct ubifs_scan_leb *sleb,
 void ubifs_scanned_corruption(const struct ubifs_info *c, int lnum, int offs,
 			      void *buf);
 
+/* Failure reasons which are checked by fsck. */
+enum {
+	FR_DATA_CORRUPTED = 1,	/* Data is corrupted(master/log/orphan/main) */
+	FR_TNC_CORRUPTED = 2,	/* TNC is corrupted */
+	FR_LPT_CORRUPTED = 4,	/* LPT is corrupted */
+	FR_LPT_INCORRECT = 8	/* Space statistics are wrong */
+};
+/* Callback functions for failure(which can be handled by fsck) happens. */
+static inline void set_failure_reason_callback(const struct ubifs_info *c,
+					       unsigned int reason)
+{
+	if (c->set_failure_reason_cb)
+		c->set_failure_reason_cb(c, reason);
+}
+static inline unsigned int get_failure_reason_callback(
+						const struct ubifs_info *c)
+{
+	if (c->get_failure_reason_cb)
+		return c->get_failure_reason_cb(c);
+
+	return 0;
+}
+static inline void clear_failure_reason_callback(const struct ubifs_info *c)
+{
+	if (c->clear_failure_reason_cb)
+		c->clear_failure_reason_cb(c);
+}
+static inline bool test_and_clear_failure_reason_callback(
+						const struct ubifs_info *c,
+						unsigned int reason)
+{
+	if (c->test_and_clear_failure_reason_cb)
+		return c->test_and_clear_failure_reason_cb(c, reason);
+
+	return false;
+}
+static inline void set_lpt_invalid_callback(const struct ubifs_info *c,
+					    unsigned int reason)
+{
+	if (c->set_lpt_invalid_cb)
+		c->set_lpt_invalid_cb(c, reason);
+}
+static inline bool test_lpt_valid_callback(const struct ubifs_info *c, int lnum,
+					   int old_free, int old_dirty,
+					   int free, int dirty)
+{
+	if (c->test_lpt_valid_cb)
+		return c->test_lpt_valid_cb(c, lnum,
+					    old_free, old_dirty, free, dirty);
+
+	return false;
+}
+static inline bool can_ignore_failure_callback(const struct ubifs_info *c,
+					       unsigned int reason)
+{
+	if (c->can_ignore_failure_cb)
+		return c->can_ignore_failure_cb(c, reason);
+
+	return false;
+}
+static inline bool handle_failure_callback(const struct ubifs_info *c,
+					   unsigned int reason)
+{
+	if (c->handle_failure_cb)
+		return c->handle_failure_cb(c, reason);
+
+	return false;
+}
+
 /* log.c */
 void ubifs_add_bud(struct ubifs_info *c, struct ubifs_bud *bud);
 void ubifs_create_buds_lists(struct ubifs_info *c);
-- 
2.13.6


