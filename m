Return-Path: <linux-kernel+bounces-205389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA6A8FFAF2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E701C240AC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7765A1514F9;
	Fri,  7 Jun 2024 04:31:58 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E89F14EC4F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734700; cv=none; b=EZvyyvhumptpVL6ZSk9/zms5A+njU+ZAGjfezUsliHuNrXeyK4s9fBzpQGF/8W3wi3sPN72KFZdx6N2cgwaEexy28utuFTZx4SGUe3SaDLJAWhONxu+zAbHQwszWC201mZ7pZazTT2jJHsSdVRCREYQTUDj3r2nU4XxRwqSzIFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734700; c=relaxed/simple;
	bh=5VIoFPg7zwa4uQ5rFlrz/+c2lhITv92Ff3kLL84iQBs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ASXwvz1ilTK7PN0aSs9AFcjeAgwYSFPOXueMu78txZ4oxfS4xgF7oHjSEROVmUJhP+v+gTeLCcswGvQxYqOMpKxBUBYQjAITLbnzo35upkiIma9+K7P8jpVK7YE3mSIC4u38PiDXqxxTIdN1OBj4/CxCeL+D8vUAr0VhPMJ0+hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwSsZ6W0WzdZLv;
	Fri,  7 Jun 2024 12:29:54 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id A8D4C140336;
	Fri,  7 Jun 2024 12:31:04 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:45 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 106/110] tests: ubifs_tools: fsck_tests: Add corrupted images
Date: Fri, 7 Jun 2024 12:26:11 +0800
Message-ID: <20240607042615.2069840-107-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607042615.2069840-1-chengzhihao1@huawei.com>
References: <20240607042615.2069840-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)

This is a preparation for adding bad images fsck testcase. There is
no debugfs tools (for example: debugfs[ext4], xfs_db) for UBIFS, so
there is no way to inject precise corruption into UBIFS image, we have
to prepare inconsistent UBIFS images in advance like e2fsprogs[1] does.
(Goto [2] to see how to generate inconsistent UBIFS images).
Original UBIFS image content:
 /
 ├── corrupt_file (xattr - user.corrupt:123, 2K data)
 ├── dir
 │   ├── block_dev
 │   ├── char_dev
 │   ├── dir
 │   └── file (content: '123')
 ├── hardl_corrupt_file => corrupt_file
 └── softl_corrupt_file -> corrupt_file

Here's a descriptons of the various testing images:
=========================================================================
      image         |     Description     |          expectancy
-------------------------------------------------------------------------
good                | good image contains | fsck success, fs content is
                    | kinds of files.     | not changed.
-------------------------------------------------------------------------
sb_fanout           | invalid fanout in   | fsck failed.
                    | superblock.         |
-------------------------------------------------------------------------
sb_fmt_version      | invalid fmt_version | fsck failed.
                    | in superblock.      |
-------------------------------------------------------------------------
sb_leb_size         | invalid leb_size in | fsck failed.
                    | superblock.         |
-------------------------------------------------------------------------
sb_log_lebs         | invalid log lebs in | fsck failed.
                    | superblock.         |
-------------------------------------------------------------------------
sb_min_io_size      | invalid min_io_size | fsck failed.
                    | in superblock.      |
-------------------------------------------------------------------------
master_highest_inum | invalid highest_inum| fsck success, fs content is
                    | in master nodes.    | not changed.
-------------------------------------------------------------------------
master_lpt          | bad lpt pos in      | fsck success, fs content is
                    | master nodes.       | not changed.
-------------------------------------------------------------------------
master_tnc          | bad tnc pos in      | fsck success, fs content is
                    | master nodes.       | not changed.
-------------------------------------------------------------------------
master_total_dead   | bad total_dead in   | fsck success, fs content is
                    | master nodes.       | not changed.
-------------------------------------------------------------------------
master_total_dirty  | bad total_dirty in  | fsck success, fs content is
                    | master nodes.       | not changed.
-------------------------------------------------------------------------
master_total_free   | bad total_free in   | fsck success, fs content is
                    | master nodes.       | not changed.
-------------------------------------------------------------------------
journal_log         | corrupted log area. | fsck success, fs content is
                    |                     | not changed.
-------------------------------------------------------------------------
journal_bud         | corrupted bud area. | fsck success, file data is
                    |                     | lost.
-------------------------------------------------------------------------
orphan_node         | bad orphan node.    | fsck success, file is
                    |                     | deleted as expected.
-------------------------------------------------------------------------
lpt_dirty           | bad dirty in pnode. | fsck success, fs content is
                    |                     | not changed.
-------------------------------------------------------------------------
lpt_flags           | bad flags in pnode  | fsck success, fs content is
                    | (eg. index).        | not changed.
-------------------------------------------------------------------------
lpt_free            | bad free in pnode.  | fsck success, fs content is
                    |                     | not changed.
-------------------------------------------------------------------------
lpt_pos             | bad pos in nnode.   | fsck success, fs content is
                    |                     | not changed.
-------------------------------------------------------------------------
ltab_dirty          | bad dirty in lprops | fsck success, fs content is
                    | table.              | not changed.
-------------------------------------------------------------------------
ltab_free           | bad free in lprops  | fsck success, fs content is
                    | table.              | not changed.
-------------------------------------------------------------------------
index_size          | bad index size in   | fsck success, fs content is
                    | master nodes.       | not changed.
-------------------------------------------------------------------------
tnc_lv0_key         | bad key in lv0      | fsck success, fs content is
                    | znode.              | not changed.
-------------------------------------------------------------------------
tnc_lv0_len         | bad len in lv0      | fsck success, fs content is
                    | znode.              | not changed.
-------------------------------------------------------------------------
tnc_lv0_pos         | bad pos in lv0      | fsck success, fs content is
                    | znode.              | not changed.
-------------------------------------------------------------------------
tnc_noleaf_key      | bad key in non-leaf | fsck success, fs content is
                    | znode.              | not changed.
-------------------------------------------------------------------------
tnc_noleaf_len      | bad len in non-leaf | fsck success, fs content is
                    | znode.              | not changed.
-------------------------------------------------------------------------
tnc_noleaf_pos      | bad pos in non-leaf | fsck success, fs content is
                    | znode.              | not changed.
-------------------------------------------------------------------------
corrupted_data_leb  | corrupted data leb. | fsck success, partial data of
                    |                     | file is lost.
-------------------------------------------------------------------------
corrupted_idx_leb   | corrupted index leb.| fsck success, fs content is
                    |                     | not changed.
-------------------------------------------------------------------------
inode_data          | bad data node.      | fsck success, file content
                    |                     | is changed, other files are
                    |                     | not changed.
-------------------------------------------------------------------------
inode_mode          | bad inode mode for  | fsck success, file is
                    | file.               | dropped, other files are not
                    |                     | changed.
-------------------------------------------------------------------------
inode_nlink         | wrong nlink for     | fsck success, nlink is
                    | file.               | corrected, fs content is not
                    |                     | changed.
-------------------------------------------------------------------------
inode_size          | wrong inode size    | fsck success, inode size is
                    | for file.           | corrected, fs content is not
                    |                     | changed.
-------------------------------------------------------------------------
inode_xcnt          | wrong inode         | fsck success, xattr_cnt is
                    | xattr_cnt for file. | corrected, fs content is not
                    |                     | changed.
-------------------------------------------------------------------------
soft_link_inode_mode| bad inode mode for  | fsck success, soft link
                    | solf link file.     | file is dropped, other files
                    |                     | are not changed.
-------------------------------------------------------------------------
soft_link_data_len  | bad inode data_len  | fsck success, soft link
                    | for solt link file. | file is dropped, other files
                    |                     | are not changed.
-------------------------------------------------------------------------
dentry_key          | bad dentry key for  | fsck success, dentry is
                    | file.               | removed, other files are
                    |                     | not changed.
-------------------------------------------------------------------------
dentry_nlen         | inconsistent nlen   | fsck success, dentry is
                    | and name in dentry  | removed, other files are
                    | for file.           | not changed.
-------------------------------------------------------------------------
dentry_type         | inconsistent type   | fsck success, dentry is
                    | between dentry and  | removed, other files are
                    | inode for file.     | not changed.
-------------------------------------------------------------------------
xinode_flags        | lost UBIFS_XATTR_FL | fsck success, xattr is
                    | in xattr inode      | removed, other files are
                    | flags for file.     | not changed.
-------------------------------------------------------------------------
xinode_key          | bad xattr inode key | fsck success, xattr is
                    | for file.           | removed, other files are
                    |                     | not changed.
-------------------------------------------------------------------------
xinode_mode         | bad xattr inode     | fsck success, xattr is
                    | mode for file.      | removed, other files are
                    |                     | not changed.
-------------------------------------------------------------------------
xentry_key          | bad xattr entry key | fsck success, xattr is
                    | for file.           | removed, other files are
                    |                     | not changed.
-------------------------------------------------------------------------
xentry_nlen         | inconsistent nlen   | fsck success, xattr is
                    | and name in xattr   | removed, other files are
                    | entry for file.     | not changed.
-------------------------------------------------------------------------
xentry_type         | inconsistent type   | fsck success, xattr is
                    | between xattr entry | removed, other files are
                    | and xattr inode for | not changed.
                    | file.               |
-------------------------------------------------------------------------
xent_host           | the xattr's host    | fsck success, file, hard
                    | is a xattr too, the | link and soft link are
                    | flag of corrupt_file| dropped, other files are
                    | inode is modified.  | not changed.
-------------------------------------------------------------------------
dir_many_dentry     | dir has too many    | fsck success, hard link is
                    | dentries, the dentry| dropped, other files are not
                    | of hard link is     | changed.
                    | modified.           |
-------------------------------------------------------------------------
dir_lost            | bad dentry for dir. | fsck success, the 'file' is
                    |                     | recovered under lost+found,
                    |                     | left files under dir are
                    |                     | removed, other files are not
                    |                     | changed.
-------------------------------------------------------------------------
dir_lost_duplicated | bad inode for dir,  | fsck success, the 'file' is
                    | there is a file     | recovered with INO_<inum>_1
                    | under lost+found,   | under lost+found, left files
                    | which named with the| under dir are removed, other
                    | inum of the 'file'. | files are not changed.
-------------------------------------------------------------------------
dir_lost_not_recover| bad inode for dir,  | fsck success, all files
                    | lost+found is a     | under dir are removed,
                    | regular file and    | other files are not changed.
                    | exists under root   |
                    | dir.                |
-------------------------------------------------------------------------
root_dir            | bad '/'.            | fsck success, create new
                    |                     | root dir('/'). All regular
                    |                     | files are reocovered under
                    |                     | lost+found, other files are
                    |                     | removed.
-------------------------------------------------------------------------
empty_tnc           | all files have bad  | fsck success, fs content
                    | inode.              | becomes empty.
=========================================================================

[1] https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/tree/tests/README
[2] https://bugzilla.kernel.org/show_bug.cgi?id=218924

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 Makefile.am                                        |   1 +
 tests/ubifs_tools-tests/Makemodule.am              |  55 +++++++++++++++++++++
 .../ubifs_tools-tests/images/corrupted_data_leb.gz | Bin 0 -> 9536 bytes
 .../ubifs_tools-tests/images/corrupted_idx_leb.gz  | Bin 0 -> 5082 bytes
 tests/ubifs_tools-tests/images/dentry_key.gz       | Bin 0 -> 5088 bytes
 tests/ubifs_tools-tests/images/dentry_nlen.gz      | Bin 0 -> 5113 bytes
 tests/ubifs_tools-tests/images/dentry_type.gz      | Bin 0 -> 5115 bytes
 tests/ubifs_tools-tests/images/dir_lost.gz         | Bin 0 -> 5088 bytes
 .../images/dir_lost_duplicated.gz                  | Bin 0 -> 5347 bytes
 .../images/dir_lost_not_recover.gz                 | Bin 0 -> 5396 bytes
 tests/ubifs_tools-tests/images/dir_many_dentry.gz  | Bin 0 -> 5114 bytes
 tests/ubifs_tools-tests/images/empty_tnc.gz        | Bin 0 -> 4954 bytes
 tests/ubifs_tools-tests/images/good.gz             | Bin 0 -> 4960 bytes
 tests/ubifs_tools-tests/images/index_size.gz       | Bin 0 -> 5070 bytes
 tests/ubifs_tools-tests/images/inode_data.gz       | Bin 0 -> 5015 bytes
 tests/ubifs_tools-tests/images/inode_mode.gz       | Bin 0 -> 5109 bytes
 tests/ubifs_tools-tests/images/inode_nlink.gz      | Bin 0 -> 5110 bytes
 tests/ubifs_tools-tests/images/inode_size.gz       | Bin 0 -> 5113 bytes
 tests/ubifs_tools-tests/images/inode_xcnt.gz       | Bin 0 -> 5115 bytes
 tests/ubifs_tools-tests/images/journal_bud.gz      | Bin 0 -> 5015 bytes
 tests/ubifs_tools-tests/images/journal_log.gz      | Bin 0 -> 4927 bytes
 tests/ubifs_tools-tests/images/lpt_dirty.gz        | Bin 0 -> 5056 bytes
 tests/ubifs_tools-tests/images/lpt_flags.gz        | Bin 0 -> 5060 bytes
 tests/ubifs_tools-tests/images/lpt_free.gz         | Bin 0 -> 5046 bytes
 tests/ubifs_tools-tests/images/lpt_pos.gz          | Bin 0 -> 5070 bytes
 tests/ubifs_tools-tests/images/ltab_dirty.gz       | Bin 0 -> 5104 bytes
 tests/ubifs_tools-tests/images/ltab_free.gz        | Bin 0 -> 5072 bytes
 .../images/master_highest_inum.gz                  | Bin 0 -> 4813 bytes
 tests/ubifs_tools-tests/images/master_lpt.gz       | Bin 0 -> 4808 bytes
 tests/ubifs_tools-tests/images/master_tnc.gz       | Bin 0 -> 4805 bytes
 .../ubifs_tools-tests/images/master_total_dead.gz  | Bin 0 -> 4817 bytes
 .../ubifs_tools-tests/images/master_total_dirty.gz | Bin 0 -> 4814 bytes
 .../ubifs_tools-tests/images/master_total_free.gz  | Bin 0 -> 4813 bytes
 tests/ubifs_tools-tests/images/orphan_node.gz      | Bin 0 -> 5379 bytes
 tests/ubifs_tools-tests/images/root_dir.gz         | Bin 0 -> 5058 bytes
 tests/ubifs_tools-tests/images/sb_fanout.gz        | Bin 0 -> 5031 bytes
 tests/ubifs_tools-tests/images/sb_fmt_version.gz   | Bin 0 -> 5032 bytes
 tests/ubifs_tools-tests/images/sb_leb_size.gz      | Bin 0 -> 5033 bytes
 tests/ubifs_tools-tests/images/sb_log_lebs.gz      | Bin 0 -> 5031 bytes
 tests/ubifs_tools-tests/images/sb_min_io_size.gz   | Bin 0 -> 5035 bytes
 .../ubifs_tools-tests/images/soft_link_data_len.gz | Bin 0 -> 5112 bytes
 .../images/soft_link_inode_mode.gz                 | Bin 0 -> 5121 bytes
 tests/ubifs_tools-tests/images/tnc_lv0_key.gz      | Bin 0 -> 5118 bytes
 tests/ubifs_tools-tests/images/tnc_lv0_len.gz      | Bin 0 -> 5130 bytes
 tests/ubifs_tools-tests/images/tnc_lv0_pos.gz      | Bin 0 -> 5118 bytes
 tests/ubifs_tools-tests/images/tnc_noleaf_key.gz   | Bin 0 -> 5140 bytes
 tests/ubifs_tools-tests/images/tnc_noleaf_len.gz   | Bin 0 -> 5145 bytes
 tests/ubifs_tools-tests/images/tnc_noleaf_pos.gz   | Bin 0 -> 5125 bytes
 tests/ubifs_tools-tests/images/xent_host.gz        | Bin 0 -> 5108 bytes
 tests/ubifs_tools-tests/images/xentry_key.gz       | Bin 0 -> 5085 bytes
 tests/ubifs_tools-tests/images/xentry_nlen.gz      | Bin 0 -> 5115 bytes
 tests/ubifs_tools-tests/images/xentry_type.gz      | Bin 0 -> 5113 bytes
 tests/ubifs_tools-tests/images/xinode_flags.gz     | Bin 0 -> 5112 bytes
 tests/ubifs_tools-tests/images/xinode_key.gz       | Bin 0 -> 5110 bytes
 tests/ubifs_tools-tests/images/xinode_mode.gz      | Bin 0 -> 5112 bytes
 55 files changed, 56 insertions(+)
 create mode 100644 tests/ubifs_tools-tests/images/corrupted_data_leb.gz
 create mode 100644 tests/ubifs_tools-tests/images/corrupted_idx_leb.gz
 create mode 100644 tests/ubifs_tools-tests/images/dentry_key.gz
 create mode 100644 tests/ubifs_tools-tests/images/dentry_nlen.gz
 create mode 100644 tests/ubifs_tools-tests/images/dentry_type.gz
 create mode 100644 tests/ubifs_tools-tests/images/dir_lost.gz
 create mode 100644 tests/ubifs_tools-tests/images/dir_lost_duplicated.gz
 create mode 100644 tests/ubifs_tools-tests/images/dir_lost_not_recover.gz
 create mode 100644 tests/ubifs_tools-tests/images/dir_many_dentry.gz
 create mode 100644 tests/ubifs_tools-tests/images/empty_tnc.gz
 create mode 100644 tests/ubifs_tools-tests/images/good.gz
 create mode 100644 tests/ubifs_tools-tests/images/index_size.gz
 create mode 100644 tests/ubifs_tools-tests/images/inode_data.gz
 create mode 100644 tests/ubifs_tools-tests/images/inode_mode.gz
 create mode 100644 tests/ubifs_tools-tests/images/inode_nlink.gz
 create mode 100644 tests/ubifs_tools-tests/images/inode_size.gz
 create mode 100644 tests/ubifs_tools-tests/images/inode_xcnt.gz
 create mode 100644 tests/ubifs_tools-tests/images/journal_bud.gz
 create mode 100644 tests/ubifs_tools-tests/images/journal_log.gz
 create mode 100644 tests/ubifs_tools-tests/images/lpt_dirty.gz
 create mode 100644 tests/ubifs_tools-tests/images/lpt_flags.gz
 create mode 100644 tests/ubifs_tools-tests/images/lpt_free.gz
 create mode 100644 tests/ubifs_tools-tests/images/lpt_pos.gz
 create mode 100644 tests/ubifs_tools-tests/images/ltab_dirty.gz
 create mode 100644 tests/ubifs_tools-tests/images/ltab_free.gz
 create mode 100644 tests/ubifs_tools-tests/images/master_highest_inum.gz
 create mode 100644 tests/ubifs_tools-tests/images/master_lpt.gz
 create mode 100644 tests/ubifs_tools-tests/images/master_tnc.gz
 create mode 100644 tests/ubifs_tools-tests/images/master_total_dead.gz
 create mode 100644 tests/ubifs_tools-tests/images/master_total_dirty.gz
 create mode 100644 tests/ubifs_tools-tests/images/master_total_free.gz
 create mode 100644 tests/ubifs_tools-tests/images/orphan_node.gz
 create mode 100644 tests/ubifs_tools-tests/images/root_dir.gz
 create mode 100644 tests/ubifs_tools-tests/images/sb_fanout.gz
 create mode 100644 tests/ubifs_tools-tests/images/sb_fmt_version.gz
 create mode 100644 tests/ubifs_tools-tests/images/sb_leb_size.gz
 create mode 100644 tests/ubifs_tools-tests/images/sb_log_lebs.gz
 create mode 100644 tests/ubifs_tools-tests/images/sb_min_io_size.gz
 create mode 100644 tests/ubifs_tools-tests/images/soft_link_data_len.gz
 create mode 100644 tests/ubifs_tools-tests/images/soft_link_inode_mode.gz
 create mode 100644 tests/ubifs_tools-tests/images/tnc_lv0_key.gz
 create mode 100644 tests/ubifs_tools-tests/images/tnc_lv0_len.gz
 create mode 100644 tests/ubifs_tools-tests/images/tnc_lv0_pos.gz
 create mode 100644 tests/ubifs_tools-tests/images/tnc_noleaf_key.gz
 create mode 100644 tests/ubifs_tools-tests/images/tnc_noleaf_len.gz
 create mode 100644 tests/ubifs_tools-tests/images/tnc_noleaf_pos.gz
 create mode 100644 tests/ubifs_tools-tests/images/xent_host.gz
 create mode 100644 tests/ubifs_tools-tests/images/xentry_key.gz
 create mode 100644 tests/ubifs_tools-tests/images/xentry_nlen.gz
 create mode 100644 tests/ubifs_tools-tests/images/xentry_type.gz
 create mode 100644 tests/ubifs_tools-tests/images/xinode_flags.gz
 create mode 100644 tests/ubifs_tools-tests/images/xinode_key.gz
 create mode 100644 tests/ubifs_tools-tests/images/xinode_mode.gz

diff --git a/Makefile.am b/Makefile.am
index 0ebd45bb..c7561272 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -39,6 +39,7 @@ dist_man8_MANS =
 testdir = @TESTBINDIR@
 test_PROGRAMS =
 test_SCRIPTS =
+test_DATA =
 
 TESTS =
 EXTRA_DIST = COPYING CHANGELOG.md README.txt
diff --git a/tests/ubifs_tools-tests/Makemodule.am b/tests/ubifs_tools-tests/Makemodule.am
index 9881ebbe..7ef873ce 100644
--- a/tests/ubifs_tools-tests/Makemodule.am
+++ b/tests/ubifs_tools-tests/Makemodule.am
@@ -6,3 +6,58 @@ test_SCRIPTS += \
 	tests/ubifs_tools-tests/fsck_tests/cycle_corrupted_fsck_fault_inject.sh \
 	tests/ubifs_tools-tests/fsck_tests/cycle_powercut_mount_fsck.sh \
 	tests/ubifs_tools-tests/fsck_tests/random_corrupted_fsck.sh
+
+test_DATA += \
+	tests/ubifs_tools-tests/images/good.gz \
+	tests/ubifs_tools-tests/images/sb_fanout.gz \
+	tests/ubifs_tools-tests/images/sb_fmt_version.gz \
+	tests/ubifs_tools-tests/images/sb_leb_size.gz \
+	tests/ubifs_tools-tests/images/sb_log_lebs.gz \
+	tests/ubifs_tools-tests/images/sb_min_io_size.gz \
+	tests/ubifs_tools-tests/images/master_highest_inum.gz \
+	tests/ubifs_tools-tests/images/master_lpt.gz \
+	tests/ubifs_tools-tests/images/master_tnc.gz \
+	tests/ubifs_tools-tests/images/master_total_dead.gz \
+	tests/ubifs_tools-tests/images/master_total_dirty.gz \
+	tests/ubifs_tools-tests/images/master_total_free.gz \
+	tests/ubifs_tools-tests/images/journal_log.gz \
+	tests/ubifs_tools-tests/images/journal_bud.gz \
+	tests/ubifs_tools-tests/images/orphan_node.gz \
+	tests/ubifs_tools-tests/images/lpt_dirty.gz \
+	tests/ubifs_tools-tests/images/lpt_flags.gz \
+	tests/ubifs_tools-tests/images/lpt_free.gz \
+	tests/ubifs_tools-tests/images/lpt_pos.gz \
+	tests/ubifs_tools-tests/images/ltab_dirty.gz \
+	tests/ubifs_tools-tests/images/ltab_free.gz \
+	tests/ubifs_tools-tests/images/index_size.gz \
+	tests/ubifs_tools-tests/images/tnc_lv0_key.gz \
+	tests/ubifs_tools-tests/images/tnc_lv0_len.gz \
+	tests/ubifs_tools-tests/images/tnc_lv0_pos.gz \
+	tests/ubifs_tools-tests/images/tnc_noleaf_key.gz \
+	tests/ubifs_tools-tests/images/tnc_noleaf_len.gz \
+	tests/ubifs_tools-tests/images/tnc_noleaf_pos.gz \
+	tests/ubifs_tools-tests/images/corrupted_data_leb.gz \
+	tests/ubifs_tools-tests/images/corrupted_idx_leb.gz \
+	tests/ubifs_tools-tests/images/inode_data.gz \
+	tests/ubifs_tools-tests/images/inode_mode.gz \
+	tests/ubifs_tools-tests/images/inode_nlink.gz \
+	tests/ubifs_tools-tests/images/inode_size.gz \
+	tests/ubifs_tools-tests/images/inode_xcnt.gz \
+	tests/ubifs_tools-tests/images/soft_link_inode_mode.gz \
+	tests/ubifs_tools-tests/images/soft_link_data_len.gz \
+	tests/ubifs_tools-tests/images/dentry_key.gz \
+	tests/ubifs_tools-tests/images/dentry_nlen.gz \
+	tests/ubifs_tools-tests/images/dentry_type.gz \
+	tests/ubifs_tools-tests/images/xinode_flags.gz \
+	tests/ubifs_tools-tests/images/xinode_key.gz \
+	tests/ubifs_tools-tests/images/xinode_mode.gz \
+	tests/ubifs_tools-tests/images/xentry_key.gz \
+	tests/ubifs_tools-tests/images/xentry_nlen.gz \
+	tests/ubifs_tools-tests/images/xentry_type.gz \
+	tests/ubifs_tools-tests/images/xent_host.gz \
+	tests/ubifs_tools-tests/images/dir_many_dentry.gz \
+	tests/ubifs_tools-tests/images/dir_lost.gz \
+	tests/ubifs_tools-tests/images/dir_lost_duplicated.gz \
+	tests/ubifs_tools-tests/images/dir_lost_not_recover.gz \
+	tests/ubifs_tools-tests/images/root_dir.gz \
+	tests/ubifs_tools-tests/images/empty_tnc.gz
diff --git a/tests/ubifs_tools-tests/images/corrupted_data_leb.gz b/tests/ubifs_tools-tests/images/corrupted_data_leb.gz
new file mode 100644
index 0000000000000000000000000000000000000000..ebb98a4fefb664a2505fece1c12ab1faf104632d
GIT binary patch
literal 9536
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/corrupted_idx_leb.gz b/tests/ubifs_tools-tests/images/corrupted_idx_leb.gz
new file mode 100644
index 0000000000000000000000000000000000000000..446f8118af32366765ded1f51c6070348171ce64
GIT binary patch
literal 5082
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
B1>XPw

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/dentry_key.gz b/tests/ubifs_tools-tests/images/dentry_key.gz
new file mode 100644
index 0000000000000000000000000000000000000000..bc313b5cddc698648b1ad29abc3deb711083c5a0
GIT binary patch
literal 5088
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/dentry_nlen.gz b/tests/ubifs_tools-tests/images/dentry_nlen.gz
new file mode 100644
index 0000000000000000000000000000000000000000..4e5c826e78bc9dd526312337f6573badf15d139c
GIT binary patch
literal 5113
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
U|NG{sgaI>HCO+G<=ir`y0q^GjmH+?%

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/dentry_type.gz b/tests/ubifs_tools-tests/images/dentry_type.gz
new file mode 100644
index 0000000000000000000000000000000000000000..e67348da01f38aceab7e7ab952a8433a8671b542
GIT binary patch
literal 5115
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/dir_lost.gz b/tests/ubifs_tools-tests/images/dir_lost.gz
new file mode 100644
index 0000000000000000000000000000000000000000..fd42040d2e23a4c8f65146ea1b9d81a1eb1732c1
GIT binary patch
literal 5088
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
B0pkDw

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/dir_lost_duplicated.gz b/tests/ubifs_tools-tests/images/dir_lost_duplicated.gz
new file mode 100644
index 0000000000000000000000000000000000000000..09def92c3cf51b942c0c52f4023e5f1c9fc9a04a
GIT binary patch
literal 5347
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/dir_lost_not_recover.gz b/tests/ubifs_tools-tests/images/dir_lost_not_recover.gz
new file mode 100644
index 0000000000000000000000000000000000000000..6fe82bb449fb91a14c169121554cd4defa5dc905
GIT binary patch
literal 5396
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
J`+n!y_kX|gY;*ts

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/dir_many_dentry.gz b/tests/ubifs_tools-tests/images/dir_many_dentry.gz
new file mode 100644
index 0000000000000000000000000000000000000000..f027bfc4c7b8125fff294deb0a31b3371a891188
GIT binary patch
literal 5114
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
Wu?l7h{skIlTv4XUkd7T=KlXo(m?DY*

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/empty_tnc.gz b/tests/ubifs_tools-tests/images/empty_tnc.gz
new file mode 100644
index 0000000000000000000000000000000000000000..7e85a8c977d7998f39fc594d5dd867bfb5b6820e
GIT binary patch
literal 4954
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/good.gz b/tests/ubifs_tools-tests/images/good.gz
new file mode 100644
index 0000000000000000000000000000000000000000..686e949f4eaca715e5edcd24c2453c9e3fdfda5e
GIT binary patch
literal 4960
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/index_size.gz b/tests/ubifs_tools-tests/images/index_size.gz
new file mode 100644
index 0000000000000000000000000000000000000000..0ebcf59bee8ef0eef7d61d78dbe111fa827c0569
GIT binary patch
literal 5070
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
Gk^cbA$Ono5

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/inode_data.gz b/tests/ubifs_tools-tests/images/inode_data.gz
new file mode 100644
index 0000000000000000000000000000000000000000..f8135dcab14fe393e78083d762e1b873eb8982fe
GIT binary patch
literal 5015
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
L&e*YI&yIfqs$s`9

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/inode_mode.gz b/tests/ubifs_tools-tests/images/inode_mode.gz
new file mode 100644
index 0000000000000000000000000000000000000000..1bdbb264c2d29e538abcb0c5380ac9e0fad79508
GIT binary patch
literal 5109
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/inode_nlink.gz b/tests/ubifs_tools-tests/images/inode_nlink.gz
new file mode 100644
index 0000000000000000000000000000000000000000..19461d944818cb8849c372624d9f13d43b8105a5
GIT binary patch
literal 5110
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
V?*iYk-n845L`FQ^x9`xt{{SFD9tZ#c

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/inode_size.gz b/tests/ubifs_tools-tests/images/inode_size.gz
new file mode 100644
index 0000000000000000000000000000000000000000..aa7574cbf40a7ad1b6b536b438122926ccf6d398
GIT binary patch
literal 5113
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
N;gbB)zI_Mx{R?;16*vF@

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/inode_xcnt.gz b/tests/ubifs_tools-tests/images/inode_xcnt.gz
new file mode 100644
index 0000000000000000000000000000000000000000..4bc5ac23fc822d93fad2510f157b86e57756e5b9
GIT binary patch
literal 5115
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
OI%CGDKXmAiL;nYjAQ_4P

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/journal_bud.gz b/tests/ubifs_tools-tests/images/journal_bud.gz
new file mode 100644
index 0000000000000000000000000000000000000000..37cf4538471f7f5c7a78df3137e67aad842e1afb
GIT binary patch
literal 5015
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/journal_log.gz b/tests/ubifs_tools-tests/images/journal_log.gz
new file mode 100644
index 0000000000000000000000000000000000000000..e1ddc88745d15a9801cde30a907c1211267ad2e6
GIT binary patch
literal 4927
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
LbHRZFM-KcqiU!At

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/lpt_dirty.gz b/tests/ubifs_tools-tests/images/lpt_dirty.gz
new file mode 100644
index 0000000000000000000000000000000000000000..b7381c35a72e62564e4dc8f9f6c0f234929d9216
GIT binary patch
literal 5056
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/lpt_flags.gz b/tests/ubifs_tools-tests/images/lpt_flags.gz
new file mode 100644
index 0000000000000000000000000000000000000000..baf60973814dcea453a007a3529f53fcc2143a2a
GIT binary patch
literal 5060
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/lpt_free.gz b/tests/ubifs_tools-tests/images/lpt_free.gz
new file mode 100644
index 0000000000000000000000000000000000000000..abc46fd241a9ca0ed4d1404d6e4a8c75540733ef
GIT binary patch
literal 5046
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/lpt_pos.gz b/tests/ubifs_tools-tests/images/lpt_pos.gz
new file mode 100644
index 0000000000000000000000000000000000000000..d050f18edb9d037a387ed78838f8da51cb8c2cd0
GIT binary patch
literal 5070
zcmb_gXHe5w_jVT%%OXk@A>>slA|NYGfeq*?O+};&0U}86NQsmXR|NzWlp-}m&<F%V
z=$%AlDbhj-L<|sEq$NNg0U@OP-rfJq|HHO#@BQ@5Ip?0|nLB6hJafR$4j!bnUGn~3
zC@?ev78(-1Z*^M4PSQs%ac){z_4^dxgHctFQXWc4t$Z(S_x#a*sVkT5PM<v<c=oPl
zwM5k;r4*&=U#?Ug5ROegA#S2nZTjMaSPBXq2@jhxC;RFw5QZiPhBgKVv}uN&%KA%Q
z+|TezP3f#xnS{U_uvgN-T`k3qmulvnV-D^6=kp){u?&d(b8hyrEgg^{S^&WG(@Svg
zWB*+Bu+a=K{^!&_umT_WmsH$?5Gnv`A-=lf67}RT3xo6MoWTD)xWCoz*gA4B^vR|B
z(2x5^qyk0=EyYuP#qrj~$;IaR*_D<-XQfTBPsySt#c%dmylUA}DHhMD9}#90wu{zi
zgYm4UAk^rHlR<GuQ1RB+w`f<Nk-HX!wRa3E<8M$s_^#d#n0c*;YZRNe{)c+J@XrVc
zzS2B4m}VT^a993cv@%CqR{)vz^SX0=xie@|-H*fe{g;l>m8=8F2qW{Wg7m0)MzSZq
z7gB?^_^MgW!<@3x<O>O%dlbG}u7(Wvv=BjLwf(>ip4J-uK3!&8X8XK2Uo<oG>HpE~
zQs#jVe<R-TXEp&awp45B5yyt${+82gfHB?Ot$2CT>e&9{;%a=Ch5THBCiJkyekQV(
z%fA3i(xHV|tU%TJD25hkYOg`%BZQpbl&~nTSl?%hu<V?phZXei+x0HZe0TK`PpXHr
z*-_u={E>0&$WF${ZD%BkA?ZfRD`nwr7o;fBrNL-YeF8^ufil-EQrfwEz0fUdf8^~~
zB-)t7o{-f1s&HiKojVb+cBMe?BFp1!>X`etv4TF9b@_sf7e2xWgwc;3Gsw)G=%^~t
z2RaSve4V1&4bPcqknOQOuxO%rHpi=Wht6H7oX?B2|H^O`CYdnxlYWW^T$Yp79g%d|
zW$jVTUMOefC5U+kU?*)09xYvErB?2EE|Y}H35#rZ)p&r^v*_f56f7%kf6fPOBzqKG
zowV4#)}JU!7e6V#5gomK>BMqji6)p}5g&H+`Vvk#hiJTAP?3oXAkJ+QR(Hy8SP@OZ
zL~q1<<iouaBx}l#52lx#=J_<5&n>!%-b+06&^lT*Pc%?!UcO)1#)P~|9Xi8He6CKV
zU5pvf6wNAxnPJ#u;30bcQ)~Bx|5n~kPtnCDW4jq^Lb3BoSod`{vs4E_?Pn9a!WT+D
za)2VwJw*u&hxsm|up1mIU{|Is)2{gm`df|fn=p}r#;B=)k((RMm>eK2g^!Y)@0%(0
ze_D7RrW1U7MI^5gjm+7&B%IKmn0v0!EE-ghIYhAw%Q5CQ2Pr}w5uFUlBljz3g71y+
zbQ$iv?+TL|ma^eGGQ3z+u|lmSK1Q`$KO1Fdt5XM!lcT+vz0$c~_?3dnIrW=^KbI*C
zU0>3UrN->?nq$m=C50z;t@Q_P=4~J3?Au<(ED$hRaqVy4C_pF9t8-6;t5UDpXXcMQ
zDBob~zjwTtHgTPZcF7zXV+jd%(pE-$PX)P!3mW4da=^Nt&yY||+`=H59$RQEusZy=
zQAeWSQviN5#no*$nlYo?k3on^1yt(VZK>t-15Y2`+349Xp1JqB!eKhC><mmSJ<T>t
z)0ONdk5{D;GnS)Cg4!@CPe@IQ;Lb{eWY!W@5;8E#p2k*Du$8<AuUPjSUTTK)l1h9Z
zT5s*-2V@3mXQpbu?$tWGH;$qHtXLxmkG(R{bhyS1D$=n{kCB<ulH7v%8wK!>8Ry>&
z=g2=5mMHiSsjOFVP!n?NL$a$zMPGC3<rg#(H6qdpTwE-&6|~55Lf#K^PD@=NuelDr
z^_W>?f{Z`36tGoE>{<p+v48gL=l4ab`9fwL@{07{J+x%IRUV72ak9+$lPMvjI1U-v
zRjt;irM7nnL;a!7D_05<L|U|AbL7>u3b1Dx&~WiUxl#@4qWWiV7pDgNv%5zzYzm#D
zchzs`V79bvAo8MS4OjKHdh5j}J7c2Nfd#0$P*`$c{^PsUQ^~6>36Kn4qVV4y{*Qng
z?T@d`G3QRYBa5e^mx8aBax$r>y3RNrEHrO{vR0pUEUa~7fYM{q@?Y1^>~W)qRpD=!
z!Nr%25ht8JU3aKS&#LfLQu|-QZTzP_u@xX2jGYo7?dJq7!Al{@%fOPp;{S}||MgBF
zZ%+{60C0p09JicH>1mKnkUr4jKR!rLbi5sy`Sco{b*#_sI_xBCXAy%>VMT^>7?a<s
z(`CL{+%_=%`FWr!1SY{5bsz+4oG3Ykw9quSdO}R86U>cEpiA3}1s-$&k3)WQ;(jx|
zz74;<mv9=_j%`y;#K?h!x5d<58#BcQK&Q)*gp@!&!GW{QRD&Hjye{O<A1?!9%YfCo
z4a2D4FGdrb9gtmYu+5&b`E6iobbEyL3rEN^B)Au89XO&v6ue?B{M3QC%%>swH%ymA
z4BCnX;(t&B<4PGs_*V`<njlu0n4yLi$gl+^G{D3Pl389Uvqo<OOviul1%hG2bs)RV
zBRl0|RxLGK`8pR_G1w{=V-H;91Hg;`U(`5%n7jh~-q#o~A79*F{sSWC^GwCoRsjC*
za4d=zjHd(d0e}VtxE&TUhMPRVhk^DwY1e*)4{QNKf1AZwc;+6U6fz1RJ$vdS{@rVo
zkO9s33<1!3JZv4ql}kp0FEgZCeTf@8LMJ0#PVogKy79Yle9^8TO4R9~;UsqM2&`9?
zuP}^WQgD5_h<Eatr<C&{NroW&=$kKaj(aD(N1-vF%Ir~<driBv%h}6-E%M0mGq^L6
z=@)&E!nM|5kn+bX{1EP9sR2J!;M-&kUy6*%E$=CfdSOl~MNqcgg?jAu%7Szh{Eili
z-_|*cqYvaqS&kYfM@=om=|k_Ab$#G^1!M<!&xITKDtCyA6|t@8!+c}9#GY7tx7(o!
zmm=-4(b!Gl40^uA;W4nuOljCXm;5~alVGp+x^64d`1%M&-ve~;FK4Ds)=j+y)q5k>
zWDAuurfL)xbCJNWp$|zqRAH=@a)em!rMZTQ&3CVC?|EySAk5wA^sH|Q>$F<)3)tIE
zzV#MT$5yy_)WDdc8$fYG#jMX*ipIcmB^LaO;=O9-GDIC~<<`;fT;Iu}H{Pshv{u9(
zfg&KMAS7k~&<1>$844e_YM{-S-Q7Nrt}LT$K(PRU^4Gk6T)PaNe(KjHF;ogian_!6
z25HgJwa~!46ZSSuv-jshECY7*y+en35x)+*-m~mXKb>;ZCQnXh+I<;PnY*_9bvICr
zTXY4CDy*8z&r}b3Y+4AC(YZtn>*!$WfqrPwu5r#9RQ5^LSNN<K+cA|O21#s{os7hv
ztZl*ABdGId4Cowg(;%trIJerY!oT*Mh?#Pi3%Tvx1*0CNbEKetd~$bcq@Cu?39Iwf
zqN&gGO5Dz1{0AB)G<<xz{F@j2+*)F&bl*2=9Rl_6wH2Rf+aZt^Pgyx~H{-ETd(vXv
zA=Zy*#6`etES!4_mK*ZA*r4u>!^?QSY?&bfM>^0N6N!pcR-N9Ss;fXXD|f?N_IuxK
z+hrtLthARXMfIUZ-v^uS;?<a9du_$mIh2=msTO6myyvf1;=-xk0t>j$yaC*&bjRiX
zM9G9KH@WPa?esY)NIvF*`|S5Ur!tT@UVrDhNZq_uQUm_De`pge`-`JWi$lsG%jDQ8
zM1pJH{JeB9TR{O*`(`CMSgwSLYQsib;6GMUth@^;$D<=;u~8m#G5knN>{n#7;^aMB
zx3vva`rL(VwV=EUO{7Fx3@CC#8?HB4OOJEk9^BG<jkq=5wrgR+SK+&;oGfuW3Uv;;
zne>cs^2`^dxWz9<5zfT0t06(^pL(~zw6@Bz93$yi<JLf%D-;_T<dbUCn81omN9a$l
zEY3Z*Zxu@munV}!8V999?Jhz;Z!z2_0E-2Dexa>y2z;%V4=UkyB?hRZ;KX*u#WsGD
zy!{|7_`~U>HdC(Hi?FG7AKT3jP{wnx<>ZK>SEaW{hHTPAtRq3*Grg|%!A<k31<<&4
zvs1&mvS_W5pniC6@nYi=rTn+z@vxoOu^!`G+SWn02EXLURAv()?3YNU<v7E=g2r)t
zkt0jDGW_Z0zz|(^Z{^xU_vM_IkEF%hd1dp@HS2(=IFo$3{#?mXMbaSgTr<-ax`j$L
zb9c^GY8iYU9`P;V8(~T{4o-`B%U7B!Sv|elXs_9JU;o10B^h?P|D{P>Fetx0ICSeF
zWJ0?@v6=BrQc{v^L>(Y>S=Q!pcM5Xa+oG1d=~)e66l8WKi<b<+X^)ocw!G$s?@8}u
zbRMA&^0$&&bA{*vUs)iFCivzvaL#w>K(iV68BX^a@3M;Fx$r$yFyD?GSBFz9nzJ1g
zPm&^W-5V*-^{V@O4(u2OWjbM)Ic&&1La2+L>P|t(lyEqEt@^hF1vp;t6+%c5O!dI_
zyOxfTk>rKa$^fjJZw!%@`9wch0SrYe$P@coIFmU7BT(WsI7%a4GB4B%TDyyDxp6+m
zAw)`>JZzxa!r9NAoa4NfquSL4r{ioW6|=nnFD@0j=e?71U#(#a@F*;&R2fh~^A+b_
zjGPD$9~_8=>~W7yMPSn#IwJYMbsg#qz^v8J=mztO3Q&#83*LzFq40=8lSjT3EQWxF
zl;U6uw`?>i#p#feY?w1~?35=xm8qhSgSdQcF7+H7zRU<ZE@ZFN`Z__6K!NuOzAJ&^
zV57`ip_f1Xig*!Yl?rZMT;f|A_*>|_e}XOul%o-d4YjmS)?A%Nri<o`A)EVR5^nl#
z4dMKDx2I<)-c&bWOXpd2TABEguHw7#39sWlmZrPAsZ{m73jZ%yg(F}uaBjRVyZ5n>
ztxNzWssZh+xe>2X-k^^Q%3jY)$4a2cS83K{A9MbV#?f+5&EWx;=q-mUw@8U<>4T7B
z%kBYt-NR1u;+wm1Zshetay{6(7@NAfs0|ZXk1uMr>4&r*<WM@a-6++fXbm$BEI4=U
ze0fy+vefaUN^t+p=sYdYEeDnD%?{nA$y?5mgOyQBvX;EV-!s#uYro7dMnIl53AH;s
z|5jcdy7KW*u7$f8L<SK!LU}NpAUCcFIp6C7_wDJG?P5a>l5{^4A?l1+)D0hUhFFV{
zymx#^w+ZvAE<+chx3_GvR$kkZQ)!8FUvEd`_5+m(Opf_l$LEn#BhK#U<rwQ}%?kMD
z=IVALW3qTaA&h+*uiM^qmC|9(d}YSQQ{~hTtptzJcMb9t5buGr$<seY-|gqN+pT)U
zhshR-6TC)!aAqqB70vY(&R0;&uAP>Npa?>d*92i=Pcq5Pr^L-|U2Ar<6CIzso7|-|
z{aNlev(&K^30}yQQ_$3KEgVbvP53A@7&Nu@>(Al8wd0Im^ghkG*HGnai=*luEqSoz
z;)cAB>{N%tNy85xhfBlO=JSjQUsm;uPvB(V;kcpLUF2)sg7~A;@OYp4m(nU^590IT
znRq`NZ6aAknmZ~Kf9T}9MecabakM?mFaSGb+Bzn(l~KQE=;#MCG#qBFfBY)4euPzy
zBTn%onD({OU(5@)1Q9Mh27_%8rv<bbe(TRCdcyW0c>}1qA62`YL|OUgwdq<j&A*sr
z=SV8O>iE_FRm}!Cr&rlV>+=tK86Clk`a3QW&mtBq+TFHgjY#Y`GywwX^ocemO>KH&
zfyi>cw>z&{ZHJtJnm)hkrI$o9I6R${aMRDN7v+stDXzY&c+%M$yO_}32XrMRW{922
zQ23MS0xawWM8QQ4z-4F4S^agl<F5jU{i%H4zRmJJfWlV>fQIl)G0M&aV*1Tyl2RFS
z(1f*lx2hJ$(X(zUNJ+(XUQZl9wvA!4-*UDh$k}=nafj0tt#;9!YBv~Hs%yCKyXrlv
zMjZWaFlgPk8ho%5jfwSBHiFrXbpe;#=l}lFhTo4Ta+?l63gpCu9Q=z2WYGkVsPfln
xea2r`SPyqU{ncb%=6wae`*XYh#Iydoo;qgCLH@aD-&2~%jWe}c`}Q5!_g^+n1}y*p

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/ltab_dirty.gz b/tests/ubifs_tools-tests/images/ltab_dirty.gz
new file mode 100644
index 0000000000000000000000000000000000000000..56dabee0f44e1323090fd5af8fb30f6de493ed8d
GIT binary patch
literal 5104
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/ltab_free.gz b/tests/ubifs_tools-tests/images/ltab_free.gz
new file mode 100644
index 0000000000000000000000000000000000000000..985e275e7b7060475c4bf8a3eea0a9345adbfdaa
GIT binary patch
literal 5072
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
F{{?aH3D^Jt

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/master_highest_inum.gz b/tests/ubifs_tools-tests/images/master_highest_inum.gz
new file mode 100644
index 0000000000000000000000000000000000000000..08ed04450cc762d26e4aef53c748bad64a57f1d1
GIT binary patch
literal 4813
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/master_lpt.gz b/tests/ubifs_tools-tests/images/master_lpt.gz
new file mode 100644
index 0000000000000000000000000000000000000000..4b205a2654599764122614cba6a16ca902e06702
GIT binary patch
literal 4808
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
b;va_1e$L-bpubLf&;FI~LO65g{F(m&^O9K&

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/master_tnc.gz b/tests/ubifs_tools-tests/images/master_tnc.gz
new file mode 100644
index 0000000000000000000000000000000000000000..4219a5e0f7dee8d331cc3800aefe14743597ab99
GIT binary patch
literal 4805
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/master_total_dead.gz b/tests/ubifs_tools-tests/images/master_total_dead.gz
new file mode 100644
index 0000000000000000000000000000000000000000..165d78789b54ec4646de14be7b32087b0b7d5bbd
GIT binary patch
literal 4817
zcmb`LX*3(^*2mjAsyHZ)wx~MVW1efM8ry0qO3h<YHO7>hiU>I!wZ@vKqNsTYf*>SR
z(HLtCB~n9^N<<J-M3Q^o_kQc?{dS*Ed+q;TYwxx9UeEJek9gvlGq^4-pHpl>9%13$
zq3+?paF0NDFK-X86B}602j(=^;C2iUU}YuYR9fd<TPG1@?R2Y3U7}o|^tHe(36i7f
zkaKnuUrByuMCr!xYXu3<oV2*hF$Nt6__4z6L6s>WGZjPKZV%HT#EoC4P-#U|-K*P&
z;e|n+v*)>nUN7m@E$LO{YYPQ%=`TAD6($Ls`1RSEdAH8u__g+a5xvLaMtxwh0FLjt
zg?{^W)Hl)ui|^Oc4O$sX{MXXoI|r={7NzalS+3!I%bPoalCDjw@qc>enah0+h8ROy
z9uvo2pr5&%d&U;Q9-YO`_L1G@HycG(xNLKYrHb9n_jSr=59tXBnP%?%nHTC)Wfr%X
z#*lyv6E5h&O!PHv7ekenp!PPeT{=}kL{6^pe0EALZm7o5H?@g|2+0$9rUO`R^&UL=
z>*_2oA<bE+Z(*`%rFW!jPg1HIDy;D(e@3Q-m*eAa%B33vFvzwW$GM&NkMr;DoHe~9
zm%dvLd3fU{{sITlG)}9nt}Nx&%?k6>OL^-^bRq}Wkq{@7BQx{N|ED{Iq(YwlBlEW@
zWC#mIl-9J$cAaZdquT>mtPqC`0l;|NvwLTqZgpUU+D5l&Fkh$3dBqSIb5-BK7=Xm3
zUwvYmsSqiPg<5t&jW`~G?hZQT1eGW`hC57y@Al-XuAUkM9r98S(l!Yzi8{tJUgL%`
zh{D{2#T~-C%8lrHZq{M69C$@Hbvoiwty01L-R<ah2VSZQGQA*1GB4Wl?KFifTi81p
zqIs2SxotAh7jjeI)A_EHVP|m)bqQ~uo#ZTkT~@SX74Ugx!;Da}hSmK6`G98;bXx-L
zo*-qjK9*^G$FEYl+)RtbbL=Qnm|>fR2+@|mhOyq8iE-4_cIGzn%emZo#@Oh1SP~o+
ze~gt_!o7LwkmAqcIf(xuT1Z)cFZ#R|jAwXA9TO<2<gjsE)xI>f$zTu;4Szsre(uk0
zpLAhTQKlzyV-UaESZww*#p}=>jgH9H3AW2SVwBUpTBDp8+~Wu1aVYKG{a{;$8o}58
z`bg?B*jorY-d$|Rq><>00CF|YU&HvTnDO6dPTNn0w0Xa@J*!TyCizi3Jcrs263#GM
zOBNXc@{#Y3z8~rrb@|>R8x=>#UZg!E87_-{m#-=0_my#gxO5yvrd2~q7l;%u5~Rdy
zR{hHVd2}pRL+c>D*a^0R&oeAfjB(MoVkj%cf^J@b?gE;S-0SBCEwmdpIPM7bE@UN2
z^F|-M!Y`8r6%fTArDKiMbCy!mqZ>1H+-%l^nM8Wq(<rBH?r|HLj4-m2+0?n>>*BAz
zKQ?GVG&g6w86jw|gGU157F@N*kQ?u7o-OOGEP!YnzY9yKNtDw$`FQQGW)<+obgT+P
z$lxeuEA1?&!P@UBI&Wuo)CgA^FXGEm^UWRwphKneXm=loyY6e^E!$p}{;3Sx=AAzv
z<m&4^Soq9{3w^6&Q5$;9D#j02@&?fJ_U<dhAEk<B|Cq8+!VMBD5BV^u5R-pyJB6A|
zXW8jDp($>_sc}DVfV*M8Gik4!!6lV$aQV+nn&&Cb&{#8kK+)iIngZQyK-RQKEHlo)
z&8|82d~bXa<6u?pb&OXzqp6%^Eu>$Uv9FSINg4Gqj@p^dFwfe6JzJv{twl|qz5sxr
z-k8p7GbTe`T@E=7K!MgfZ=|)e7LB9=9<YZ%gM9O-GrKY)n4EQ#Z7l9c0_=WI(1hp3
zRd$QFYneWBqwbyJIGY&fe8`&au`SaP?liQbe;dH}12er73keMYK`q4d;6Nv10QMZY
zSpD<LmB9=sl}@eyYwV#s%;JvS12&gDk-+J*2L>iF#kP`zF1kid>E&Jv$?4>*a(aWz
zm;zZ^!L_nh>E8w*#@%d&Pb1q$%f@OE?jsEgZtRRI>>knX8(Ikx^YV9eM$L-PuIJ!?
z5A(a;N92p(cfTKZYr9n<Mh`2PFz7T~M^YAmk`!Q@ukV7Fn)Nb{U$Ou4iqprz*IDQ7
zbFHl{cb0|B)-iKjBYg`L#+<{MB2$p_4l}V=k~~0R+DK^i;QDN~P=q@<U5d{jZ*CPP
z@q0<iJE2YOo71!E{#WKKN}BZVm&U!hHg%sRKNJjI50`Ym!7@0I_+MwTZ)PSoGYuK6
z%f07!S>k3L8CIu$*`gCCkRlA$e~~f`j#&R#>i@*bKtdU;kIL&Th{!p@PH+s{a=cho
z>?6TF9E0(<QK5Yv(O+(+{jD3S!mIF2g4T=HC@WN8W5S`y^1!oIt9AXFh_>VQ*}<Sp
ztV#W8J4oC`U4P()35lIeX>6`*XKA^qz(N__J?-JaY|=&-*cs1jh&x_Ecv1-ld*gO3
zh{xZfUf;Y==b3d1Fcd<>dwUV}BEa)KPm;ZzU9uc%41EvJ@t8ob5}rn6Bq90RT)M_}
zzlt<%9&f&y`U<FcrxM0@X(HyRuAqS16(WDVoH`l%vHrx2ok-Y-Znm37O_ScT$v|!O
zf&Ws$T$_D^X=~l?KyBg5Og6<)j56N`Y_WN6PoM6?1Wgu@ebh%~>E2J#%D`QY=&_ar
zYp_~}@3%}e-;9M+@|&bQQ4N3Un^$Plh*hJ)c}xQ>wX!oQ(oQ)FJI5M2HMpTi*C2L8
zsn3uxL2>N`)jRd;M?g*77$E9#J}Au}{4ueDHakCF>cY~xUe<FJ?3a=QXl;Pk=!~KD
zbpaU-Rp=Sn{fNndL3}%DOn2HsEzoCsEo=x&I98|mEsPxH)aPj8F1YRdMZ{;|@`=}r
zzjOzFy9zoi;v9XR@i8IE+U19)`NTo)+=xFo6r9pA`k3YKD-B%A&aZD+_*`#e`&{0o
zl$X`D*T^bUwQFq?E!6Rd@gsCqu}>(w8ebQ7Jg5_ZwPi)e)@GFH0O(QLibM6nE?5ow
zro7o@RTEW=EwuLDP{bMK$EIDVi7#y_D>LibXi58%Hht&iF!$;OU@-IA==mmp3-%fe
z&_LZ_lTaO_vT!?gHacf|*mxJ-{~;L^7S%Yowb;gNkfIjpBj=8Hp2Fbgge&EEmFvh*
z8_1Kd!ODr$lPQ~6LXp|f<1Ssbn8>2E<+9+oJevkAPFJxEH<IkS<I_@KARG$Wqe^(n
zi~NS*Goxf?YGM{1z8q+a&rY;J%!$rMYrAwDG*gRO$LH^vz}|${1ja=jw!Y}KYU``O
zL61qpMe)<C<EJC4gg?ZD_XzAQ*j$wF|E+wWd$VIm8@nH2R{2snwK&lqR5O_EM6ZMb
ztR@L22Z%~ogWs742p$J*p>7jjL&5q%vusI3u;Lf)c|{SSFxcemykX%r)+`~)7br-_
zv*TT%4Y6-0W=ClE>H}isiCx0qwE9)ZK3h9AC1TL%>ZIUemB}W<FC!-f;|V}n^vF)$
zbZLWY6>OcEb}d=XFMnM|dY(P}`kX`cQo7R<z7(H^`IzuWWnW9saGO9uA$Wl^?+<U?
zE%Wc<1#b5000?1@nh9fjWH^0|OEG01vmK$cLSOrO3fEuAEh45X;E#yJ&93y)M1OZ5
zy$eY1yb<A<F>kCHZHrt7X0{--)Kz*m(pK8L0_D$_y_%n)7_1*ZT<E*A*K%=Mn`{o2
zvIQgS9eNV#hZRD*rS?;)wR8n*L{5nXhAyWH%fdYYcc@Au;NK=?-5Kw{^nA>|Odd=V
z<bggp1X$l07U_`i<&{*90=w)k+T7oQy&`4o1`n$j2;==Po*_oU%swwMg->&s-5PU@
zpWmq4UYi|FMj}w|ws-o+KtTm_?|2NaoF>C^gQSNR8ljDimK3mBK{j7ffY@TB|B`8U
z!)T^FSz90YWx*x2a<}dCNY&RL7E8%Vw{xb-idx*aurDi}o)g{F6Is3Vhw)(pLetb^
z*UJ{4W-m#BOVR|3G)PvdC%H_Ei1^a?Z||-qUr9LcHb>G&1Z@m)o@9)PcmekKx+it;
zF$+RdJ4!MAt{STILh?yZVnOuu!4KKm+-?vGq}9TvIOJL%0$Ll|x=tNZ6Ts_q*u%AS
z)Z>!xBvMt`^mKR=f9T&ol#^MW9rM}NQO|J=tDVsHX-D3%zMY8Hq~5wz5Cm|UC^bpB
z<+}ROleN9C3&3YhNiSB<jS%QBQ#P*<H=2{xpnuc|96iLod)a*&#IppdNblTqEnF$*
zEc36Vz~|ILCes$Nw5gqDh#y50*`t25(RVZynx?!P-f~HDFGN9ZKJv-;J#&N(hf&4x
z)zM(a#ASHDB<U61Y2$a%I+?Gq%T?PjrW!A=_5x_C`DE%Tuvx`LziA-o_(jAuUd{Cn
zQr3C=p`cDXaQsu^{!-<jm?gF~CgU;doqOAwu1F!06*Rh%2qky(_|I$vUGx+z6C&s<
zH14Gcc}OQ4#emEgl`c3*#+pNaI9wm}!H#L~uUM{Gx3)BBrtKXUVKjj`3j_YNB4L0C
zze#s^Ap2M!(S3aU%g`I^QRi4)lnOku&kilsz;9H-{RhvfoYSwmk=AFCkvrL(T=lp=
z6fxZGcyG}X{<Asj`GD%QO(C4VM%DY7_Wr#}eB1bJ?fE9Tjn7y?r)r>0d@|0XQdjo<
z?5$crz@{T9q7eHD@r6Qr5gXttJ~FA9tTXL96Gh3N7%r3cm1IYSyF9?QpqAg(9{4|i
zxaPJl-yO=G?@x4|=eVZTF0VyDpG+cTX7K4CFM8|*?rWr8X(ejtsWJ~W_7=hr8t%pR
zQ=dFBT=A?$&Upv(_5K&zPx<|Od0mK?k~&18o!w2zsjIZoI=2w+$|V3u@eU03bYC8G
z&fv)x*K>1I&3kB`?Cy8Iu7C6g7wfmrQ1!WHRZ-eWraUI^G@D1Y$UPA>`I>XHZ|2m7
z{62ZmWBdoi{DG$AMFMzjG>i9n1FCD6l!>gsXn0aM-RH*?EVeoh{OUan;c<XXvodXI
zy!g`5fNjJOOf1L9_togN6s51ubdS-p>V|HI*<yW5gN6Qn#m@&@$K~)sF*PZ>Ld^cN
z-cAW(zVelqEY(^-<dq*iSy($Zmm=!~SAhy7>8QnL2>`su=XJ;=8r(*c;)TkLXB`c$
zS$ih#%^PZ?{n^N^+CRP@=IJF{#4QW#wG%4}6pui4d7?qGpeYLCO(9V|409&THQ24A
z|2e0#Fx$fSnNXxH9I^U|siu<z%&Nko#?qN$rUuGd&`l;RZ_V>&06P90N5?pKLb~r%
zcD-B?DE>a^7i9D|M6iPinaKGMSKVa)FNAam`X?dDfFEU;Hgn6$D<#V^^l`l<X%%F4
zab(W{ii}k?WxM&u>2H#kop>&6om%Q)%XQQH+pp=N^oP410BL*v+h=>1mIj8@9Ai$k
z3IuH^WC;6C%lIYShHudy=Ej=1T@`HpZjd+5!QaJ%0HfkqQOiD(n2-?f3t=7);8V{a
z0`&W}h#G1+O2`O)uQ=?n)&($za{ebO>~YTxWkMcYMCmzq1qLY%f|)bc1iw9UuaT8{
zUklR;DXyTB0iz?9OLN9KU+)D~9qe!y!>9TU^N7P;iS)v7^<J7&jqj=y6`W4k{QUJ%
zj2h6d=^MPA?WZoK%Mw_kp3eH+zI(PopN?7mp0y|`mh#V^EL*AO`K$w;pQ~J3`<YAM
i$L;(~v6coj$WP;|Dn2&&$u$i;13lR<f8xaH6aNA%2UaEk

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/master_total_dirty.gz b/tests/ubifs_tools-tests/images/master_total_dirty.gz
new file mode 100644
index 0000000000000000000000000000000000000000..9416bbd6cf7afba06e16b2c73a2ce0c6134336f2
GIT binary patch
literal 4814
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/master_total_free.gz b/tests/ubifs_tools-tests/images/master_total_free.gz
new file mode 100644
index 0000000000000000000000000000000000000000..e6e942ffb48ef2e99c04bfa1de4dd6bbed8de5cb
GIT binary patch
literal 4813
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/orphan_node.gz b/tests/ubifs_tools-tests/images/orphan_node.gz
new file mode 100644
index 0000000000000000000000000000000000000000..901d75d4a40a530c27eb025501e6bc5a54ae31da
GIT binary patch
literal 5379
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/root_dir.gz b/tests/ubifs_tools-tests/images/root_dir.gz
new file mode 100644
index 0000000000000000000000000000000000000000..d45e4dcc1ac09b33081ee65b175e469c6ee39a25
GIT binary patch
literal 5058
zcmb_gXH?Vq(stJ?s0ipPsI-89t`wuvi=d*QLO|)Ai+~uafb@i{D+*GAC`CYsA|M0^
zEp(D73XvLWfCPdVI))ZP8sYzX-!Jbyd)+VZxxY_y=6TL}=FFV=otXh8@81uxHNW@k
z-q7IShaTS0&^_O$4mkF4<%k<$me9dx?Mmi(f!+2_FR?dITy0o(KBZJtsGy*pc>eJV
z@A8j_FEoVOG@Q;*m&y^ksgZTXRLVSlseryizmHjo>CI>0JxENpF=3i3*j-=(0x?pw
zA&LE30g1~?x?Xj|I|287zpCh~BT6yC;!t;(@}8eR&Oc2`0pXuxU&S3NcRhBDSO9Ip
zptwT*=d3*-BoFa7&~DTSu=nTKI*~uXLrlPq)^J88{Pz3u(a0$ep<Go+*;_-PWaC)K
zc)@4A!j*<XMbpA>l){;r!rOOVO%VdGYadT;x4pL9c`CiCarSM?&dEE)6Z46+>R=F0
z-?7&|nl^D;Ti?S)6K@kG>$%m#hv~XoQ*6{gV^|!#nf6PV^h6V#Qkb_ilbT8V<!@p$
z;{+}P*8z2{xlZm!)VbP`u{#E?UhXYLXqyF=yy(nx2gcZuv&d?bqy?pR1xYbc1>BB^
zkZp!LJu!X#>+CY-$P5o&@QklM={s#vw^E0?cpdR;X6C8?mD}CsfKL2}Fs;&AK$wLu
z1DA@TH~v1?m>(?84;HR2@|F)1^0^B9W&?RP*l;?edP3hEE?b|Qsx4i95H4A3Vza;S
z?3VJuKs|0$o~YGb(I*X6=Pm7Y+19aPZ6)Uk2?Jx_ZUjtc)BO^!!Q=6t_R${C!l5cv
zd?7>u-JTVrtR+T0abQg3D8|V|cltMX(v>Lp@?|4Uch<=sV$Q8&CuiY=+2zz1?0sK&
z+TH!gTTTvL=i1yNRxu9=`UO79omZ(hPn=0F9yv_zaafAeisy^kbSsg-1Z3puqX_Nb
zW^queM-}yIc={L9#k{JC-dz*2^)An#M}rp`+k+QmtvJ>P^@x+?p!}?{a(q8{tugD=
z<CoT`rzLkqUuTfzZ@MTgpWb3nWaw|sw$YNx(DmQrn{T$mSZMz-Tkk9qw-oleuFc8=
z{Y7ofWoW*$I@`aD8<Sdo@%78TDJ25~RaWW?6<&-AD~D{~%P7V^-DIt-w~!nQG>RNr
zx!VNi;~o4ivx=zT-wCLoXA*Ro4Bn)25`Og-T<^CIxWkkpVeP<wl<{AVHq>;<u7|54
zwidg|(ugRrOABakm9fn&EHpIMnM;RR=A%QsCO}#xe0~g4QouE2+<C3WOa6VhC-<6t
z?TgF`Z)H`du3P^tQ!wo<NFD)1vSa)O1oS3McC1JF)H1-0z46~t_`h%wZz~Y1JV0k2
zIFs8g+IZ=XxEd>bMCz6FzR}X<jKpipR}+_Qy%V0Uk6(=#IYyCe->5~D%%<u+8^xrb
zDA(=rs49NYaJ*kOvlF^MVdv>`;yU5fH1I~~CU}Ha1KiyPf?I)o$7L!ZXa<7q2fX>h
zcDEZp>gDwQ<<Ktw3&p<u!?y!T0zy^cedECx{%)&?FQ}OPXmhu`4j}aGg1h#&EZhzR
zVsSxu3V<d6ztjrjZ}C0U{7Hv}XrQvF2j-lFyV?Czwy}jS*d_*44G^ks{jA38s)Udq
z?J8^Ir=oN2yW2~pDgax*s59@znjQfF_zL0-&CRaFQUCyq-DzW|#=xV?01(VJj<!iY
zXtoTL{rt-X+m!>^ZB_z8f+n~?;vYW~-m~ZHrys22gdeQPZOgI%{4)+~AC`9EI(kxf
zqL3QHT{G6<XupGgLQe;e-Hv~7TQhZ<bLAd4_%ed9W&5yG7xHOVR+<>i(L)Ue+OMtf
zhXrDt`5}(_JFQ$Qc}jnKiCm{D0(J(g>Oo(%K!!=peThO`H>x4`ee7E_voYIhU(VJ_
zbB98#SG6DNc?Df4%~d5=FR<Ett!Tp{YzMZM;B|5NTnl~RqW|r9o6Yesc7s_!OErNz
z*{{#HbP>%nf_`XwGS-mUEU?WfceoHRACBl_QIabR=~b_^#&bCGD^BB;PaE%r``MOm
z+==KUdNiHBUpXPT-oA)8vT@C;H&zmz#*WH&e+t0($6YV$&;h5IA>IE8s^s0ZB>XX;
z7g^t5WRaTUCc|iCJY?Exy|as35DO2gQ*0z2(t$29)8Jrmc$e`5$JVafBzxXtW3J)k
zCu;%EkbayRbWD@<S`}WJ^PGdVduFmre<fxx@103`k_KL{-6>_Wc;}Kg)B0#=Ff>{j
z``(k6()6b%PXrl3KHzlQXrV0zbscyeRye#-k}dO%s`SLcC=tK?^}W52iRFsN#gqCz
z-yY=zmb{NQ)HL@mpY}u5EL4!UHLQ;w43Ig)i_6gQr8+>l)&fbnslq%rOQg{@YugLY
zE+G$3K_hmt!-JR13$r_Io4C!nx?APatu;7^4PV2iW%Q&DB|O^mQxh*J1YH@P27x?N
zA8JEiXsvdLDqF!&Z<bg-MLWzd728wz2~WT_!LRIfBCLqp=9_e^tGQMct;s*E+ZP*m
z5C7!h%#*j!?9dcK5`-Na5|FX*x!n>UBxx=;1z`G$6{E+p^WK+Ps`-B}AJbHU6S5im
z5ZRt^Nt9JrXfswGfvCw@!dbzP36fJZZ5{vhKa1o#m<A_h#ajd&FE60TnmI-RS4|r;
zwmQ5ZWIsgsSP*yO?InmP=z5vBBi!>Lor!$AgiOcO2O=SAw`3$3nw~TU#n^VsKn3ze
z1RHds6mgexYbo`1wsXxRXn6tKW$pRQR$Kl`ZIaExJD0g_h<j8N?P){iUeFeIBVgMn
zFr9kl=xC@{!*U?BEEX}hY}?2v7P`V$j;k5-3rv$T_NH3xwF(FM57t4-AZx19Yu@3t
zQlXeTgKu(Uz)xG_b4xt(@FngK#!i7#&$|6~rqxmS+zBK9yEjAUHok|{QKj^R#cK==
zxw%fFvZ|L@$9w^~oW~=%6|Rf0h0hzJ!dAV0gSxt`PNVm3XajY|Q??Fhqi`E(pKYt&
zGHJ;5_Mojd$wOa^Z^yS5G@2pVj|+=wsx8?KUwRKj=ttd;<(9rsFCopZ`R6p)YLxld
z_S=&vW3WE!?QCITj?0uyzWwW9<B^K!I003>WtzLZx_P<<hi#FaWI0ywX3KYX{Tr(q
z)VFfy@ZH445bylmk{DdD|7X)OV5t67nLOf;#k-iskbge7>|}5=pPyc5QRN7PML=4G
zo?KZ#mYl;OOg6o-j~4v{8--7zD#*}4=Tf-RgY|m3E5cKC78g|?_v^*$u0q$p^6Hh=
z1Ss{Y@|o||HD0bCvo?+>icgs8nI|>MsHm!HG!0N{rev9>ISHZJ6&j0E&Nwp7#@uu_
zR1mkghe~&1IZvwX8u^b6)WwOns0oOTX|-ljaNo@Jxp9jX=Db!>2i`={lBiW6ABT23
zT!345pPo_idsnRe;=`L8%%YofJ@`wyYG|9umYm(kOpDs^smEaPL_sf<G5O8hy&U7{
z_&xO~vFTDv$Y5B60j`*2%*5Rt_nXA}&%m`uaYM^D8Qf>6)|S!6K510-#|Fle@gwhA
zEfW{(uI;Fu-{2LH5448cACJ~tJZvyHuB}|ikRd8xVOPE|7{vxUy}9e{9<jMl^N!>g
zEpg~jq<W(id*WiY=gUKE{mR-hiHajI-{C?Zfmu{4B@UBi3z*?HIoAlCCldn2dvo(`
znh4%OA-mabhW9d@PbY~5IMTJaWseG0aT$-!iK~jwRkpT-BiMg@flv2_(_r7;5|g?i
zN8thN_!R3*8AoZ(h8LTgqsY_`aJ#fqK#25NOqYDTpxisT1;5u5<osJI_lobr#2Lr5
z=i4%|5tJi+IDTW2IGA_3`713W<r6_u4OopP)tpY15<8z3o-*pD6>#-(!j!*B|0~Ez
zhL->P`=L`Qq5`i1iPx@Ciu~E(cj+6>OE_7@JdPnWV7R&ZogjBFbGTm7nzy3&?5V~5
zn0h7iMtNrqezJ|S&y&5mRaW&6lFy5{qy2t63_85I6AI;g)a%l)({GDv>ij_X(sTAI
z6)_spNRObLbU)xW^s715%4JZqqS_pP<z*sELC?6L-;%E!*q$=gzg#DfR<A>~&Xhd9
zvR0bq)dMT&HN*}w`rGxh%8_EO#$ExRUTIwjtF<X{h^i<JUJBBm@2(VbKxO*`cTMPM
zp<&Vdg5f-$)%*e=b$gV#Tt;+NIqhVKRN3r>juee9oqV5Eq$7zKx)&B>B0|FX#|mH?
zivwnUR=)lF69;l>suRC!Y!m;{mk%;PhBdFBZw1gko;ofPjNzpq>xCQ_sw|mTzLz%<
zu3OiE0iHjZzWFVpUwU-6>#{_`I4Fi&ypNG<&`ihb|B`o$OjgxM(f#VHz2r!8ah@lq
zHkO2gq7*hME$)g{_O3e$51-H3<u|!}^R*P|K1!TwX&l5h6TfbGZVXOEX39`^+pRUW
zHdd2ukO{CLIp%{{daI~aQM0Jy*hAWW`p#REOTXgM;BpABM04`@7;}BNe=Rh{_WddA
zojN;{g|)qDt~3wu8#j#eWcT4ET6vgD8U*1Pt<=L8p1$Dc?t#g_*!*$6Bc0ME7H!6|
zt~cEpsn`B}y(Z?^OWwo#TY?yus(RVkX3vn6{MnALh~DLU<1w!y5~)&ol)$y#kv^%x
z=BB~t$)<4Ed(GhLg26Zk*~m|stK?0RhzWj?S)aLH^XBpT+hT`$k_fteqSlR{+k6o=
z^s}{bC)4)-IUw26E)-{ldQDT3ZRQ9I1}eHkwaJStaSr(yKJn|^8oRqdTu?#QAzyWo
zvowjg-;I1tN%{ahgT-}EzWIz9o%in&1Er2tF*^??MjX>R(%)wC^Wkg{A>qgD4~$A^
zN}Oq}MkAvVPzgU)+Db!2i3vF<8jkmKuMHYKF07=IJ>vlGafrcFzZ%hi)e4K|2H;FW
zB*NhX6>t1O!F{^EWMEZ+fN>0|lr+1`w@(d=(lSv=suQ)8r5lGYWB;(agge7QmbX|6
z2A-$YXRMi27+PI<=gcQGTg~w)$9A{*w$Vg5nz(?;QdxM}1_uQRe&JW^sGGje8Zs)~
zzrr@h&`QxE$XopL%D$u|=p%YbgM{|GWqlWj7T+FsMCYK+oFjvUEw7y5ubTKYeQQ;-
zrA2}$^@wo7M-gBYkBc8a(ecY3!q{Yo1>|m97hj9EM*P#_kf~JK;q($uQ#r*=mF|Og
zUZtvK?2A^rmLYLgB(KZ#mYUlA_}>*2)Xw(_FjXXr)k*((>P}o<tX2M+!2%y30R^$a
z`FP>hYny`wE5%DJlhZMPJJ`Gdqd%=R<t~Fx&SZ&}1DNC&pLwba1%VivosEM;C32oG
zVW=+cG$h6vTr$2C{EhjD7vw}H_IeY?h^-06DzVt-X{}b;mHT;pJ%^lMjGu?{1ycsv
z45&J2FCpJ>SYt}y$D5hI-pP<l@~{jK#W%Z6b}j@iF<FarlqjyYmsE3Nli9NVy__~d
z4)Y{dt({x5-#L*LL^@cBQoR1D`_H(!oXe6*VjjFE{JkDbFKf&?wd0c_%SG;_@BI`$
zXO7q-m+~bPu8H-8AH$v}c#AO&aPzifLpOGM6gN<yBw%Rhcx3y=S{;G9eJ7nmN=wnW
z*vSz`$Hj&{RNAeqOj~%i^9|Lrqhe$a2T4;J|KzYa&aLu`+0idmEMQU>qxw3hrJd~{
z4E#F$9-_H1()D)QlA&5+iq7dK2!_A?bv^=}O3FFZR~JO-@TJ%Fnn7#n%$mSe^7W%8
z(<^_%UY}rxx(x(--Ww>qwxH+23oND9gt+{!0AZI+3R>7jH;g1rJM*3g8==E`%-+wU
zqG?jqK_jzj%o>fSu<wNPivuI_MsH!0O)!<ZR6B3X4dpCCS+g7sHD(kO>hC<uEIW0v
zKjQ=f(A-{&d>E6pK{#Tv6HEYw!A!m5Dm%cVA2*m*2mh_FuqYS_NS6OM&%exB68Ep?
srbHAI_zUZ>@dEId>yCU}|6h+$mv>(Obrbu8BluNiuMca_9-%$|0}saf<p2Nx

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/sb_fanout.gz b/tests/ubifs_tools-tests/images/sb_fanout.gz
new file mode 100644
index 0000000000000000000000000000000000000000..520fd09055ca671969093bd07bbb200746742d06
GIT binary patch
literal 5031
zcmb_gcU05K+E%e*i472>EYd`pfPkT86$GVAFG5g?v{0lIATEk7i-4klv>+f-66ug2
zgox6SUIHW}vh+X*EkF{I-?w|uz2|(_<NkN&pLynepEL75GiTZ>mU#3irRloo0iNIo
zP|y4R0ihxLR;G^Gn=-{Z*5LtnOK;!auI9IN7=G{Uam>N!oaGhqKMXvMc|hBd)#)C7
zf;UaNHO1K~myA2dGwyN}JZR8W9C+0PapEh&lU%XT5KISi`oMXcY~(O*KC*dAw4O%&
z{Z^Y~JZSk#$91a=ZG}O&@I<U!-M)V)(bb|`0ME~zYooGTKqBM=0NjaqA*Xuu=d91g
zg@D-4U5_hLxQL&-_BA(~(*Pxs3shc_tS38BQy1MfFBX?{DErM>e}r*BNdze!t6Xp~
zy#QCI?=Yv2yQJ@SYX;2?^tRNg^2$lQeal>uckQ*dtt=~{<a1!C`)Zbk5|5vWfgH}y
zrY11t(}xm7&r#UKqQ(Lfi<czcy?3qLOm$g1H@BTXe&&?VAO2E?)&j}@p!~b9#UhXq
zZ2|zVXc)`P8~>m|H}@uh-*saFc~3jA{Qeb6v5h=+JAMV1?u|D|ah{cy+b$LQOCK_-
z4h@R?<>rI<JULj-JlnAU=Gm5IieD_gA9VK(9n(6}>*3x5OWc-AUqx}rCCM8>>TOP5
zzt5A>FEEY^tNTR^gd<~l4n)tf!NAJc{m|*i-{XmQO0UQxIwN`eeQor+7D~5}o7&c>
zj&Pwb(W$A+feUgY;%IcEp~DT4H}0D|tfyvB=5?nVBHh|id#(|c^h)XK2c0{cy)Ouv
zbMA$<-Dcgk(-B#`!P`}#moKBAxEu@SLY4<=9oCutN*9&Qjq^nja}3L^94l=&9q)o1
zuW+<-sVChCgoflrcG7ls;_Ey8<}j;Vm#@(WwE5_#mbl4`<`8?f5*8wvw-jxD7`p5<
z%|i#Nu4mvO>ZTC*$04y1H}hvu4d(U6KcDy{rk|h^bgvK48&j!4pDAiihU(EzR%Tbu
zCp+D}ia=0x9Tc6%b~`sYg_H_2=V+=O_cP0c$;(iFTUt=Y&flq_X5gFqb4En%?CSl*
zv9Z!+qjl*iHA=|aQg>(aCQmX1uc9O1^v*N*F)J*B#+PihAlIA{Km=DuaX?MFr(#+e
z`CFMAI^{?qw|7^8ZQf0a?N#8|Y7d^T4`_&!ojJ)jkN@~3NGQ6E+25>F8?G16R9a$n
zo{eELDJ0JnZ?_h9dNfyVj;Yz%!H2i7<-@sXBCPRWG_IM8QBF_CJ`xKRahJr4d4vX9
zTz8RR`g2#<_01s;Oo@Ig`Obz%s5I}_AoTMVJFJ+av*TpD{#t{XONyX@hR*Daa3ZKo
zT4-Fkz9{@xSNx5*xbrlbOOo$vOK<83^CdsrD`l*)f*CJ=r_7&7n8+U6;#oek#YY{q
znNrJd@M}nVCwdIEz=ux)^9AI~cWaKj)~s>BWxj?OeqMZD&iUlw6*(@u!)qP8UjY)x
zJ=gqY4<z>TJJCoSdS|nEFMc5fczxi<4e%Mdpt=K~njgLnk0lp0P7f6{KT{dCUG8G@
znYbhLf0f^LI}pShW6UqNQRvg1&f`Aw#-rb?h$2!UO>F+S2<zu&2Nk{7sovm@7lht1
z3LtdB-zFx9<3~gj9jiG>uW2=JR+z~v5gUguL?ZABKI@vef}q1^y$?s?qXs|yl28kf
zY+tH<cvDLlGYf2XL^kX&4stSl0vsW&0n)?z>PH^59PH?N)UC=lr!<*DNys%-FuD#x
zj8giE=lQ(F3Yv~=S<P>lA|AOIEvQS4(1QC4qsj9tf>RyUPiJKNHnTSs<a%9|?2F5!
zb9vw`!syXA+mJ4J-iUigHpHX>o#scZtESn^vK1wI<>@l=j>RbPzkoMf^{*fn?2*&f
zg5H#@C$7%WlS`V0Et*dr4Z(5`2HRgl^is-)<+=q|M?wl1^!Zy+I?Ti(!n3ugPZH_L
zHD}PvvaiZ(&Y`s=Um-D-4^t_XKhFHW+Ml1ZwK>3_mTt$ZkCVBrMqIV}ONqaaH5##a
zTh1kz^OB>LvFIu68l>pv0Um9fK7c^h_5LBiF`cEpKXpmYq07j&IyDXLF7>~HTr~$k
zngdijr;P&@@+6m@xuKXd9Dwxve>cQ`;$>-cvw$f8=-UPovjSUSJtKx6J~<YlE)aMX
zq@c2A60F_D&&%@ZT6<KO@{0X+vPxHXWHThB=ziylD^swSmx2e^g}RX+J^B?6&RBb-
z6r3C4pRTa91_rM9LepZ+Ic+0=m=o}#rhcBq%fMLe##>s$JseE8c<m;SQ|VBwpY+AI
zYQH)H!ct3*nxncHbXoYez`Y}1SSSlX$r2Eh%?H8GQ|Vh_Raou@8&a}%>+w6TLwwKu
z>fgXI@0C_NWA93OrQHL9suw2WmLIbaOqRgYxm_Zzn0uBAq<jQ=Z=H*+THpe9SAMei
z76ttzKq<0c+T-c*hZsc{rxC!zd#IGcX5p6rU|}0L8GZUS>Lvi->$zaVE7wX*{{`1k
zR0yUB*nv6$C!KIw%@sg47eM%PHhIof)Xs5>e|Cj`);iAuq{M~+ggg7Awdd)dMDv&F
zv3c<Tpu~O41!Sg`%j1d5iImk}IXc;1O`AJBRE&e|7N^3duV|$73cwAs@jiNSser5n
z?R4A{sU&!c<YxbgvQ_1Fq&2VV2`6V%IIS<_ycBONNFjcshQ|KMDhfXpjai+I`*wW3
zhAvjx0K-k5K2k`w8Nw@f1Emi?RDW$SHq>Kify=AzIDv0A=tWRlgv@jD2zAi=X(UTV
zyd#hho5C)#ejC>R;l2;%HajBE3Z$W5uGv^f-nDfkresDwJwa8u-_2k&_~ZF<1|nCL
zHw@lQs`Pq$B9ALww4FG=bD7bG)v}?#@NrPEs<U)7dNQY2MNQODN?}kJAtOcpHB&-o
zP-CNSss7i=Qk=;8E~SbsR)lFi61C@JQv9yUO|(SJTv%P!heZ-!P8lWIezN`c(yGx(
zkP}e=dz)>r-E(+<h9|g~PAYUDj@G>L-`Q4`Aeq|un+(9~xSj^Mm>D%uR9m}_ZwN)2
zv(z*XNxsut|Hoq9G|aJdDyh3~cnI{urC828A`<P^J6pMU0yNddcJhul@4FamQ1rDn
zuU*(bva;`1cD#YF1g~f>j=P94P>T{C#+A@DL%#RDG7wLgPC5BHYf*i&d;wfm6*^u&
ze&RUsxBY2mDGqpLS!X>=Gd#N?RH?0BXKnKt&wkKz8+m-!+Bao3$I0_st{T08cv>JP
z+l;TkR=uXgEhgIQA`GgO0nW53lxw^tr=f^&wSO?eSBEMqRL#9q?R<8%T&=RAG&(Y_
zul~UD=b$q+Hf7Q_zfTSoOuX3g3eE7VLurWF3o~|xrZW5sl;_aCLv4Cd7YkFLH)#$K
zf?Yj(_G!EpG=J20(U}BiwF}Qk&i&Rf$`e90F(psKBGm^b3cqftCY1IG$Q08%Rjx&h
zlY#H!a^Zv&bDC}>jEGK9@D(|MYt+V5!acV1v=6_py<>u0EyU{w&+wqYGR`6=eRMO+
zhCBuxDyR?rI;4qak7OSPxqeT>HV4y=m|&e&2@AQ~zOBep>J>t0IF@iADcdc#$Ka4m
zThmJIH|aL6hgHTze+n{_xTxQ;D+`xKdsz-J?mj2V3@dv7L7D`~$2=fw=Bl0SS&+A{
z?S<)uB@KwAir*#l_`jXRcd#g*MC&${gRXVgdxb~N;YQLub<AuUhd#dOL%H<1olLEG
zE?<8A&ulqznVwU}$uM;glH@z`nZ17K$Z)iwM(Nzug6B)f7Q#tm@64qVNzH@xQ-qHp
zv_n?Ht0KDC2ZZUn3{=W^Sa4%Z+=jFj$|W}mj=!?wR+!i={V_nKixT_EE~KR0v1)D_
zsTsTad{5Llb54Vz*vM_xlUNC-kzW#axI#|^&S5l6vWn{Kr$_XbwR@aFS4~K-G%j5p
zSjpd5Lx=d<eT`a5qw7{TV%A%7Cg*ZTh$}`BS8V$z<KV!qXSdQb$%RqvyM!psJB>BJ
znKd?+-L<lDL2O3D459=E<IlxLwMfK0$~LMEmQGT^`f-OBRcvik^vr1#b-9HPk`&al
z#fPRCLs^=Dx0-tA2<ak;6Ga?w*0Eyj@I6IVAHz&p&J89l`*OmfA;ocJPkOug2L*ju
zhT9V`@aT=yI?r%_fB&SKBv>|CwY)xHCqdBIx7HVJ8MZtq7~?|e6ePB7xcaoQFxBNn
z(paSMMhOEQ(64i6*=o7TVFjei{?>mXW2loiFiD%=Ip*<hrl*1a<eTRraM`r&p~{yB
zpPQ+;Xk8B2Zg3X0axzd75gg~##yT>Q5{jV-EOKnuE;^B{oMCEGZ;-gqpwkf95*%Wc
z>!5@OVei$vqOUEV5wW$wk}l&(t=LRO|1<^jofPN$6SIES0Tls<^~2tZ$DR=mcQc+D
z?{!Qp$J%*|s#)}_C|7q~APVM#J=Ya_?A5<nlzHU9XCb;S9lcGepA4|Gnao%Sal*}_
z_v5xQzlUK-G8W@AxzdNjvHh>x*y`=nn~}d@#Ye5S?N^1>SQhii?3tP&gcnUT9VR3*
z+3=uh=lesokZy>{3Uv?by0cVdN1#<6&#L8Qte--GAYpmXN}qT5x%9Q>?$li4xQp5}
za1b<axR;<nWn3Moa9ts@res=^?}fskU)8B+M-%d8Wb8Y#cE$p?z~JbL$uW`TR`>_b
z*}U~YuWls4X0s0;vNc#?TbCI024>B?kh1?quZGewi2wDG9{7m#;CEhGIn93ft04F8
z-dc(NZF9#GB&jdV5(ey1`9G>S*(;I3$_}b3RW-@Dl8(okcJ$)({<o;~`n^RC>6;=W
z9i|$TcuiQ@*a6~o-(t7Nc;ZZBduxid50|?Br_gV9O*9EL9=B7UL~4gj){|km=X0j~
zcK0-ARGf+lB_a*-djm8#?>iN*4?l&4SqO^Q!|EBkd>B8U+U&^z83F_`yPD>|^T8{-
zeTDu>{#!A%scp0Uz0@=9@I2^5ZSf6!Pk7nAn9S_@`GM{GR-5zJf=`q-2Ke4)DP`I9
zm-uOY--~|PHC$?^4YEN^E!vL{$_Z%{V>BFd?~S$wFP|+2NW4?drCT+x?%#Mt6*pV2
z+rBlGY(pIRJVs!y%+&TN*K|zzgm^Tj=QeL2$4Eo6mKAxa?xTCVLa08S4>=k70a*hW
zhgdtQ>=J11Gs$@A7h<Fb*sy^zw(*tuu@@w8Yv92C4lQc?{3t<cB2-6fiDg-=YnKPz
z4fWF)MmY|Kw<@j3EVMDnk=UVkNcfI>N_;Tw?5f!KTDLW9Ww=-1ndpf;Z*BVeGb*S|
z)a=o6b#32Ma@10J`D#n-5l_XYiLc<$kTyYu{-p|PaXuqDbr<4kBT{~dj;k$vU@?5I
zs8HakuOCjcxypP)ZWvb@i$A<2N8@}=&3}SIBX#enlIOQ#b754RNKZDQb4>%T5<pZX
zG=TXC&H+Qc!EIZSwyAbgc#+W$o^GJtKujC|To&n~gKk|o3hkq#I70odUAEx9S?PIf
zQpZ<u(c5J!GQVTv6ePP#m;YKuj8~B5Zqqw?AeQ-|w>#%@tBlTn9zu_S`tXkO)6as0
zKU0DS^H;lF(^MQ^TzGTiaG|`VbS6xrQ?{!>^2u!8)ym7Vp-bx3ovp5QS6vo#=uY9d
zw$R+B#m!QvPC!2!PQhTpqn6p)|L%EDDq#;{r^N)iCpObGeoVaN8qWf%v{`^M1`_zf
zoi>>{Fu||DoPSa?!>(h+HutpAs@C6C{T2XiI^EL2#ZB+E`*XuC>6Sz8DWb`h<;Mqk
z5JhA>eiwT^bCC}6RTG$c7+h@2MpFcS_~(5#-$m{rRN^UKF`tN9-dUHg<=F`1P-C0S
z8jyyQs_93a^{WDQ-dBzujw>+|7`$h9FB4lPG5Aia>S)WHg?5Rs=_yZW_i%9V+-BPF
zlOk8H+U_A;Xyo4_xgdn=zs3Gty{j|Z1jxVqKg-`R#Eko6W@$(U0R6yPdJP=;Z`0$g
ct{-z+zp`e5{r}DSC5E2XFVntn-{F1#2lcMuO#lD@

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/sb_fmt_version.gz b/tests/ubifs_tools-tests/images/sb_fmt_version.gz
new file mode 100644
index 0000000000000000000000000000000000000000..c6309e18c593a96a001ad332c967faf968d01431
GIT binary patch
literal 5032
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/sb_leb_size.gz b/tests/ubifs_tools-tests/images/sb_leb_size.gz
new file mode 100644
index 0000000000000000000000000000000000000000..a04ed7b630895e0a89890d5b589bcf4f39e540b5
GIT binary patch
literal 5033
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
b{$$nu5;*XGMfZNh?h+R5*x9vf|E~W5uHV*!

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/sb_log_lebs.gz b/tests/ubifs_tools-tests/images/sb_log_lebs.gz
new file mode 100644
index 0000000000000000000000000000000000000000..9113fe4d2407d31f40ca9ee6363ff36c56b7f937
GIT binary patch
literal 5031
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/sb_min_io_size.gz b/tests/ubifs_tools-tests/images/sb_min_io_size.gz
new file mode 100644
index 0000000000000000000000000000000000000000..788096deeed7a1959ab322bba3ec186e1a158d5c
GIT binary patch
literal 5035
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/soft_link_data_len.gz b/tests/ubifs_tools-tests/images/soft_link_data_len.gz
new file mode 100644
index 0000000000000000000000000000000000000000..10414a7710ab27242eeb479a4da393cd3189f4dc
GIT binary patch
literal 5112
zcmb_gXH=8f)^@BTRZ(yN0db@VA~;AFA|Nut03uQYM1&COB25TMbPy0RLFq+_bg7{u
zB}7FGEkvn8fQW%mLJttqc(330{h52m`SY!Ne(m+_z0R}O+H3E#pCgy}^Uu^aUGKg7
zLV~<QA^tvreh@E@P!EVdG;q(-<Y6ZgTb8&UV(pW3ZqVx*G^f^n<V=8A+>!CX5oP%&
zagXXxy%#zSt$cSx(ogFw;|jDly<05XIQ?m;+R<V-hM80VpR6KII8$+RY%Ug9<sktk
z8$ix&z92HA$<)sF2)mkj;e^n-v_KDfKU6>8_oR(lPsN^pIC7*|4(cC#$O!vIpi}M!
z0Gv6~pC-Bg$6;S-wt(o5U2j*D{`qp092iiS2|6P|&@&bG2m+5)GjcB5#mZ|PC!UbB
z7K>lD&QxgeQPcN2rBb0FC3apwJa&vnEa;-&w#`ibefavB4d(Mp4rzwJmT8O~w{2l>
znSu=JvMkgMbkeu`2PM!8$KB26`5b+@r01!d$9p+i0YTv6R`QU=xVk0yW~%Je?=^Bi
zPJ0g_9#XOk*(BVsy`&4;NjyN0(pPad-)pFlhSm=<C_S80;Y+~$-X1IS45V~ayQaGI
z@B$R1@v3l5DqiT(A);g0u)Rum?J7k_wL=NYzW(_uF(35ciNMkSr9(yXM1}rFJY0SQ
zP-j2m0JKuGtiDr!^Zy?phqK@lc1#xm?4u9O7DVX;YVPIAZ28qo)ZprFmk>i4adcdc
zP+F|E=0frL{kA8@#U6P|I-|<B$hV~giAWO=)Prg{JGr~~en-{>oM?Ih0b!NPi)|ep
z7ol^7k{gQ7;sd04_89OiLwr>C4)oLu^*?lB!X7B|`-TS7k)$5Rb@-sSG6Qz*IqX>j
zKe^n%WJKar0OiyqMb!(Pl6yZVl<GDe6&9BvAuT`@F##o9EXvk^AO%Lt6<vceO%$Dx
zW0BGKSPgYi<glGGKDUkJD4tO9sIhsG<PY*b55*A*&K01VSQQkUUQ!yfar0}R$H;0V
zzKqG^MEUh->MGZlmiErQHTDn@YcR_XG@<lc^)3y?j)IMxn~TvJ+P1&oTp|O7BfZBm
zZF<^dpaD@X8-2BnW&web?YWj)O(CvX(@#T}t}aa3<^?=TZ>uaZ$q80te{mNGQO+TV
z1W|;bdZtkgIey$A=4lj&{bY7kxRW&~Q`3fhX_C`=WopDNPtE)^VWr1!W;geTWqKRW
z4*T9WS|+L%DpN+Dp04aJm9}1Fth~h&T1X1E>*G-AIi2)fJI^u#b?tdRD0j|KAms{5
ztf(c6)@|WXo19kRrJ(BkUo!!01uB_?n!dSO2{<~O#L=RQoUZUeSkwPHlNbLOl<zqT
z5HxoQwvLzXQe?KeTy4yY+DnbEqkFC<{9dT?=(WYQmeRvXq{5uIyZ(y)I7*4-lw`{F
z*^`GaY~Yu+Tm;}?52|e*HoLm}{A<k5fO_qgXc>0Lq9}XoMBOfGY>P~|736ah%5QaK
z$D9Vkp&nL3MQ9NL#;U4e;}LxcOd1X_Rba1cl2|xGYc<RMzMOIuL4^V2Q~>!;UmXg!
zA0doVI&>HiHe2+W(VCqTV6w1&F^|^av2iHk5$L!<*c4&c<2^FrJ@>&Duslk*J#I=}
z8Ll8a+5&p3fJ*z2e!Vp|051DM@z>l5_xOauY<a0ChfZu)Sf>u7oO8CM?cMk~TL5a3
zLkMQkEbL1GfKml?(84I%dAmSR>+Usaa4N+P;5NAd0q{1CgCk(Y2OtrAEL#b}csGar
z;SgPY{r{a9b=mSR-`|bPiGd6+7OE03y*hX>jTPjW5?`GnC)FNe>M&+_3*{PpTE7E~
z4<2ZeZZlNW&n=s*m|}^RSWn2odji*=C5ALr;X^hP)k++XyVknih;9q+ao9@01jLPy
z8RPV^h?N697?7*pQLiD~oOkPz@Vg#_$!~R=Slu+85T~G&scXxzoXlpUBy;GH+g)-M
zl>X}H_`=UHS^vZ@_dSA`V=u#Q*tp!cmI2-B=ShPtCy`ZM!)mM-$Uz9=<@VmhX;obI
z5cT<*GSlqK%YzZ#p}tP9wy%YMgh335epORjVZ5&P_LLVn4WL)z?ZJu2)c9`yxwZ|l
zx)7XDJo*Jpx{~MXKzQ)UnWbf;V1s$;{EJ~QqnmzK<zVnJ^2zxLI%Pt3aH8JA9Z8RX
z*4Rz8$BbLK#y1T}^Vp8lvh*^YxnJ7Hqf`m(=`ok2VcN0WCY8oscuPe`Q{8Wt{_lx1
z@GR5-mtJBmxPj@P$XD`-)T)QkHhpT?xlv3^=*ZzLM{P!%FZKYHq(5@Dd;!{;79iH4
zDr-i)zZs&6$ViFGK)WiTDLQ!4(9AQUqEEn<OOcca_VakSi$!#M8ef-S)89YdVyI?g
ziHkLFn)h~0&QC%TmS0n2y0?5+HS|ye(_JfOpA$3ETCGC0YZ;C@-lp*K;>HriuyUH=
zK%|dx%om%<+iBoYBYizRdNwDlA?pDCz2%FDDXWX&cPgU8Fo71al_;kjvEhS0VV>a;
z{sd)phr#A6d`>0TK`GjNQKnyWFdOwwYxy2#dOLG70f)i-VpR1i1)DRLuOzD8*c?5-
zL@Fxw>7iLjvlq0{7E}fl@s8SEM}E)j&a%#!n_X7BcmcWA9ON+H&<cjZL~=8}6x<C|
zim7<j3IR!P#m0TUNv@HcOddRe(RL}o^V>-SgH?uTX;8uqnd-&&U03IpO$V2Med*^c
zBNL(KaizZFi(Z5u|K`-{V+Y>Y<=%r2qlj@8pIXEhZ)z%PsI5Q=Vd0V@>J&Zov!Gz3
z7W+VIA^Xr=MG*MHnk|-6Qir>fIAJ7LlHBT_xI#~FkgIY^`_@=_1#}1Jb-NFpP09cG
z#-AVgHDRTI6xDdPW)TtAf$y`HI1iI@moCiX`aZUM9n3+OmNO1S;ORx$rIzpaEA_sO
zH1&R}YF*aVvz<FO^7g`)PTto?(u!K4=R)mMWccutvV{X)ozX-%v36t?q+MWE@HG`&
zDq@fpkx3C+2-4rQuM7gaIcPI(gz}sh$K-2_T@r3HJXczbWc7@as?@ffr|^ZH(=Tqt
z^A9zqp_QlndA9?7d+R$F6VwXsH45RvI>=`tgPiX^Aaw4VJsTU@Sfxl}8sWLGx%g#P
zhIZ+sWgTVrrA=oKxsk<!)CHu4JscHc=|W;ko`-Ry8QbmU632=-mZKXVcx^xBTQ(cT
zJ$(05(ejxv*{l5;?Y`{EKZJ8Q2aI8u!gI*`mK*+s?ep+}CUZ$FZontN^%X+-?iyOw
zm^-P77IEDFvPQ6m>IQr!NhcV=39c@Vq|bq-#4kLO=jk|^YRtXV<AFxkU0ljgc@2nG
zc(JgkT$fwD10lk1I2&$#PHMZC6rZ=RqV6|FgR%<mLP!Z?At9;d+%8enrZ!&Ewf-^S
zz3I`*EY_+Q;Jf~6{ZU&=6<PICF4qt+rpjBW{Mt})=ArTP;sjc6I<K0lS!TC1zOWlZ
zmV%Cki?;uEif$RNRVSzp?{w4Bq#RRqr*F@U6isVV7S1EtMbzPsm2D*xKd;u+tPDGl
zeMwe3J!8vuj5^P6qu?g|5zSDq(VC+Oi3G@g#fgbYePl*|nV;;I!H1`s_12g>2E9nz
zPo{~5)>0#C%rv1tER%qc%`Q6$clN%Hm%ZoO2(I5|^xD^D<8{lk-}$~{X`go*K)oJ)
z902q6U6>qE17~T}*nTu-AT+({$CuP{-7;BLCz5;==!f$W3`e-t{VE)oYrJu}geZQf
zzY5<D4Prg$8VaeC(UE~K)wJEF=|UKj^1r4ka7Xqdw}%ib(;hGbe`l?khXfn5`8<i3
zxeqqf9olsI<V6MFkQi%n4Z7)M*>K3_!rAyC*3#r@qc>k&Z|ufglRSj-xgNd_C4asu
zEG?vgu1PADnbXsL)lsD-U-E|{dNaGm^kQD%N6v1q`-~hGrOMr5{`y>1YY<K`*Iq}A
zbd`k|n^T6l^kP5rGpy0DBh60(qVT$P;mG=^?NOyCmVyT_LNadCB|OC1oW_)IK`(dp
zswzx#VG34`i))MPz6ik2UF7KaZm@Hpv-Y^8`?}k}UdwSC=c$VouPk$sDUZYC^_pzF
zOZds!;p6AchqHEtGrsh@L%d3;24%DJH>j{dQUANGIs{DQ#Pf%YVsv1&|5mN@ShroT
zVLHlpCGgVX;!DmbB;7lx|Juuw_Ko!jaw$n<H7h&9n#+kCPA#yWrIB*4x=H5_R$nVm
z8MJmCY-w0yYUd0{X9`p6ibp|-e~LusZ$xwIAN))z#U~4i5GOE>)b%WU(_k!dj898{
zB;L@HUN$)Sx?ixVk?OKoDKHNkoF4Md**(uxx40eAC;54I?6N{@CN|3I55aLgxC!xW
z*j{Z3T&d%@?rrLoly!6X)aQ#0{`Cr#+_!?ybw;+O!tuNTo4lAl9OJ{(QNrC!$Mmm=
zxpxO?blI3eL&vKTROjeWifYK#r;^t5Ry_jjp3pH`0D477H=VA1D`4=u5@Wi$8SX`3
zkPRE@iFWk9s6>7Kt@_~9bnD2%9jt`#NtDo~P-qbTL3p!DjjBogwkvirDwLzjG|e&s
zvC%iyIo_ng!&^FPPlv2)4d7RF%tG#v$J06Nb_tvGqDv8Iq*G8Yx-ljW2YJ(Xb;EZJ
z<Q?iaF>Yt@A)vv&vXNCh+JADqxjL^`A;!pBb7Icf+K*6&fz!lS(rZ@*&qG-3DU%(S
zPsTd~1LZxe1G7Ec-X=fXbJb2A!yoKpZ?V_XIH>OUAwcfC2=+So(+^_4Lp%5XB6RKb
zr+(*c@3$BhDlNVLtc5<{HO7xN-*28BaTJe#h>Ke@-H%(Psv?Xwd$Z@x#d<pHYJC@5
zllOeP_W?S!>z{K$QQ?)px!bj{%eo;-(MYpS?nkD`KQQwokS{ra4(xiys{eZx=_;ew
zAz+W+)jHRWI_OSai%gq0S@t(~?_U1X<cQff6|!mo<SQS${p5^55~{I$w`uPbi~AEu
z3AQqD1OxBtS53#3cjje&Uk;Y0o_-Qj!>jpd_MkRq&i(`uVo5UQ+#+)m$%z;r758|j
z;1@4k(rCb}zBta$bBBwwE6rx~UAW6OvAlqt;WO^eML5O#Xc=DeQ>lna)<6+v7BR1v
zV7O`#sU%q{R&3s|xw86~w7CTiE__AdVwtMYp0yAA(T~kM?cCm+9nW+rK#vgLUoVYh
zJEbZ=k*J}|qYr<8U2eS~VXWbmC$Tr+NW%QpyI1^m{`~Wm#QqccZu2IBMZGGGp>v6S
zcz5e#FU}}NFcCRfg0K}78Ni~f#dH^t>&h;V`OVi5;vaIPX8hlT-5=9hBb*b62gi3>
zeq--$7>{=Q7#n`Phi{8SNWoSo8MD;Iy1A0Ms!;{bZBOzt30O@`?t8LZ32vv<G&LjO
zUu5>NTI-glgA_bJ$sL;-j9y)VZ!AB(#Pu|Lx5FZK(pcD3ksC>Vgw=^7Xt2y7wQk<T
zNPRej*v~f|E(l-1ACsGngLGL1h8<ybT-m)kqy)RFO?}r6VGsh(=VZYUn4;_0jofRU
zbsNib-_{{i)=K)x+?-bTEGLk;64^~0U5+{CoawyA$TlQZ!f9k3S-l;ik}=?LD41UO
zCJE9Ubtl|8mqFXs7%`uQN42B8sq<>08xWZpg5q;vDP0qs!bYuad=bSSWaAEh>$AK7
zpnwJ#g?9=ttxO_jt&@SGGQTuIF|I=@FaWst76h;7<bUf+Y`3H8;HN${>NJHat}>S*
zO~GbENzM902iJ`f12qQ_T-rlMzDIxEsr4893_^u#Cd{zMZa#iilv`$G!*e|`T+sTB
z9F!j%7W}C@%Z*{9?&rUH$Jg@s3<=SqZ=mFGaO<_;H#MmM!|<mSvd09bj9{?UEpQ^U
zg1B;g@v{chZaZ-z%syXsEJTSGP+_!t#g@KKip)snGLwWEI_kph*u@xK%Nsm?$+wb@
z%HEAWly)pn?hdK(oM>*)Yo0hdWS6IK;4kg`vHuPk=soop<bTYkxlG_cpl3#Nz<+e(
lDMUZ8@882Nb6x<4{vCR-srR>!t_Apk6p=p#_Ut*h=U;2A^2z`J

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/soft_link_inode_mode.gz b/tests/ubifs_tools-tests/images/soft_link_inode_mode.gz
new file mode 100644
index 0000000000000000000000000000000000000000..e333611964870cd1a888ad434a6178da4c60a644
GIT binary patch
literal 5121
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
YWBWDmw_5Y(I#1B%`Gb&My99Rq1JGgqEC2ui

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/tnc_lv0_key.gz b/tests/ubifs_tools-tests/images/tnc_lv0_key.gz
new file mode 100644
index 0000000000000000000000000000000000000000..bcc8ca2af6f9700762cbda165501d19e0608933a
GIT binary patch
literal 5118
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/tnc_lv0_len.gz b/tests/ubifs_tools-tests/images/tnc_lv0_len.gz
new file mode 100644
index 0000000000000000000000000000000000000000..1c64d794aaf2169d164a742b8124b306e2e83d2c
GIT binary patch
literal 5130
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
J=+Mza{{u^rD>488

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/tnc_lv0_pos.gz b/tests/ubifs_tools-tests/images/tnc_lv0_pos.gz
new file mode 100644
index 0000000000000000000000000000000000000000..5816123fa32543f3150c18927940a72c754e522a
GIT binary patch
literal 5118
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
BDR2M)

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/tnc_noleaf_key.gz b/tests/ubifs_tools-tests/images/tnc_noleaf_key.gz
new file mode 100644
index 0000000000000000000000000000000000000000..fc7c0edc87f66590d568b4c0a13edc83acaca369
GIT binary patch
literal 5140
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
Z_`d<>?EkD(Kdp*6h6>dmI3RG~{{VImH@pA<

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/tnc_noleaf_len.gz b/tests/ubifs_tools-tests/images/tnc_noleaf_len.gz
new file mode 100644
index 0000000000000000000000000000000000000000..2d0f80d3f8f142fd6b787fc3cabf71ee4e83df7b
GIT binary patch
literal 5145
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/tnc_noleaf_pos.gz b/tests/ubifs_tools-tests/images/tnc_noleaf_pos.gz
new file mode 100644
index 0000000000000000000000000000000000000000..1a05959b9773f9daf19199bad97d784a0664c2e8
GIT binary patch
literal 5125
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/xent_host.gz b/tests/ubifs_tools-tests/images/xent_host.gz
new file mode 100644
index 0000000000000000000000000000000000000000..b2aef46b86914b66d3511b15b60542bcb0a9a18a
GIT binary patch
literal 5108
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
O1Sotn#||ChKlFbHa1pTp

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/xentry_key.gz b/tests/ubifs_tools-tests/images/xentry_key.gz
new file mode 100644
index 0000000000000000000000000000000000000000..b4fa6d53e6fc471e3fbc7a40825555707b164990
GIT binary patch
literal 5085
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/xentry_nlen.gz b/tests/ubifs_tools-tests/images/xentry_nlen.gz
new file mode 100644
index 0000000000000000000000000000000000000000..e351280373c12a3d64c93992ca13686aaa397d6f
GIT binary patch
literal 5115
zcmb_gXH=8f*4A+p9R)@aLAnJM1fn9nWCT$<qI3vIF99MY^dvKbh=2%4CqSfkkd6e1
ziby9?0|^A_C4>ke1OmzX&As2B@6LGtedpI%&)#Q0&suw(z4qSXaVJmCwkf;)bS%Wx
zH_$)S!Pnc>_sGV~DXYPKvF@z^V^7m0*DP<@CMjE2qmgTlC-b@ng(M5}FI|#-c`H)a
z8hY#g7aOBKRnw_D*ShC!UnQ<U&RVywC<Dr^1Zvno4uc(*iv#w7AsQ2m0cgR-_)v8`
z^Du|Xy2}?wPSjNrUc2D6Y*s8={v{^m)2m;O{P=ty&MpJEer)>|Y+1x{IK0FF5+a=;
z8TWqdbwpE)0sI%!A*b}e24^yB8NkTa3#To#{MfI%imBXK+^Jipf{(TRBJw`E_^syd
zP37BK<ae_2|0L!+I_CdsTFOAF$9i145G5UB#(n>?I7qLoeB+{N)YkI%H?lS2tjVmQ
z$6>=dCPXz$gS*uMR**a<g(4$*U20P@jRBqbSZwHyiz#YwC{8QAC0kkR1pY6wk-Ru#
zHf|MFlppfUu}9$aU|^&9orDuD2GYWfvq6vf6s^aRkfeyy8aGhJm%W`FpYV<JBcJ}J
zH>bcuIn8TaxmjFbmhDNXad2z3+>V{gzf_bD{yp}Wv;U?;g&y*r`3LcM#bW@ppU49E
zq@pekNc_Y8zkqm+J{z~Ey$*<Tb+_tv3&+mp{#KQBiKag5`EpBD9^#Xl6|X3K<Frrl
zh!NyuzFb4s>FzsqoHXIw2b5FYnp$92$64E@8P58ry<9EZ{?1{xJ+tD{IR-zGXDO6B
zt+7bD-A8!aya~EQ;U8CaDFbDL%#_`^9Z?TMG;HTW<NGL&!bjaCDDGF2+!Gty`-U${
zLh0#EJ}H~j^L1bJP1+!>w7h5S#484|XP!HU=V9(=JvPb!iAPb)`Kp!7E+xz0Hq`A^
z4oJ2gE2?ed90d77Y3%(pEs{E8Sy5a*y^b(zou>KrAbf&K$nNe7wGHx^I9b7LvmXyd
zBH9}lFK+M?$HtZdp4QyrI%RX&G&s+Pu)Nf?{)tkRk#E;;BZ!uGWm%;jY!vD?m0{AS
zF6!dbnzcPp*VN?$!{Txc7|j88nRAta8`svz_wsyFircEvwa}(M`;+8f0&bvjuVJJ!
zE-I1X%@}t&jD8sf4vkx)ad$CCMQhtIRa$8Dee#5Mo~-R<+-4tik(2wwG<}HPhpz)&
z3R=>!H_4jLK4$wpcPc4Iqb}*kE(E+0>;E!VC8LzadE%Uf!S@X3gLB<APM_03os(3(
z$k(fHQTHab(na#7_5a%yz*M5%uuyYmv?{>TLZpTo*r<D-4aR8yzcab8`CQq~1OO+`
z!I@gBKbzs(?=iHrE&3w{`82-oL5yyp^z%}Ez1Ff*2}VV>Mst&9llIN{#5VbB9epbE
z1xw*ml*V(rik~`?wZICF$&g2ovm6H(iuk0&T#>#41?0vC>L{4t;h|6O`dG};Z7!Xr
z-M&v*g1W*~{)t)JFmJg)89|T(5UszxP$EQgKq)!Ws=jMJvO}3q07}+C*V-Sv-W8Q7
zT5~jP0=G@4fe_yc-f@nPEUamDM_*aw-8_l95#)(Ov9+VvkE57JDFCSk)wL5%)+o0|
zouUBg5P(#%lH0sO2b#@}{xkdE+L22vl%9gNm$aDOH1^s(3&7Qth%$sTX2$>kP64h>
zC&-!>aR3;W!)r1IC8V$b9F=w5*UQ@XA)7WE#BQcBRxKfHB?f?+VW8I21KY1-Q0u@C
zxY`Q-ss)RG)dG{k^KQ2y|0(9*NJN`71DNM615hF&l*^*98_4jV;=NvYbkGlu%3^EM
zXMo0!ylaC(7Gxa6NbHjZ(&PIOx3w$tceY<|Z)u<jy!|swDU62!SB8{?vT5SRbd6sF
zh(W#Y4CqZ&*no|=DtC)zhbAkVKrK)xy0u1|G{^0aZA7qgY&+^Yc`Z#&2<_4uyA+|$
ziT<<SUJYDJ5bZ~kVDF46mAiI`Y4w_s+iQ#q<a(df+sf0Lej8I<q)sKsG{MPOfSU4T
zd2{p{Pd4`3a??42gS3BO-;De8_7jJi#;*~J<<KwOL0`aqA!1=Ab2*tg!b=s1H>sQ{
zg0Y_vGzcZC)QVxclq`$#c)jo;60iD~Zi$pkZ##|BLEH~s<-+)i4*i2rK;jfr!T7pS
z%uD<8OIWH|oC`nOYPOyW+rU;VSqZcpoEO0C+d<|tut1{4lk}u2cyt8EeDaa}xNQKp
zy)QP0FyA9G_?XeM=Ux@(9e|Oc?NK*gIZ@vEg^IahcHT3}7Cuco*Eg-}+dxjQ6{Ra`
zT*E_xIm2?qkMw>wheuTGckEQRn!6&_30v-?Wz|(sicUa!&V1fa+2q$w@8#RYd#K4u
zwTvk@=J-<1M<&UWCJjwq_t!U|ztMZ&PmzKOm%Y}TM2H&Y`{SQWoo8X-W%^TnwyIh@
zD7y~a>h3r8W@)Lq!}vuLo1z2Tcsez(ytB9o*LbKV+Yb|@mqB0oqgA_$uj)8h;_?)4
z;)1PeN2{@?9_)to5ti4lT2Agoy^uBc$*=*1nUwIv1vuZ$jva?hcfdkN!W%Y|?4ArB
z7l1sjaS`5lX-r3idXM#-+Rs7Q83}-qA!XFm&J|x-c|G&oM<bIDORQapn!FWp$k&?)
z0f=tjv$i|nV23|yha>Ur^4it2Gm6)pdk&xH9;d5P+)t3%thEe~mymIQIEJht<uh#6
z*=VD-X$w+Y80pug`4z5z7#Db`)bUi{jhn!n8EJd+Ic2LLf1?}UZhKI&&3UM>Fm&AN
z?wPL|n%+gr)L*-8hL4ujf><@pM$M>UvZv>M?`hMj0G6bj^4(x<Z0x-R7AN8wr97>N
zK|dv}(%-!9?P<O;*Eil<O^QSRyqUcBV79VR!#|te<ZvQq<Mu>@CCRB@lb}fMU-jOM
zXc}gGRDj#_1f038k5%z8V!!nzXpCJ8j>jx|oV|sb95|&D!=GuLTTfh5`&k7oniV+O
z@}lYeYp*wv4)`mP=2_Kt-=5JzmR}s}c5m_)Nr_PFLZ)vU%TpYW8NR?(vVABw`-&l_
zP1KE4lw__wlE3E-pEl}-dNdIVC<bj7J2!koud4NMK76FQ7Q{9QYGBewq~S4PS`|GT
zRac<1JGYIAmKPRj?wsF3z3x@V$N9xgo6t1Z{b1c}S0l>K#47SBfv<LZRP@;4gs+27
zD(&{D?1U|#cYo&S169Okxz5A#j&+ON#B{Ysfhyho5)wVQ!uG<=&X<`F2r?aL^U>CO
z$Zt~xy#`|BG<DIL`#bGvl!6_+CA9f=A3;^*)}kB!!!h5BFCI$&geRULQ9Zw}P7MBB
zgK&_mC|Q1rt$kuhPV<|)!egVOs{2cmh>Vn!r+;lc<RJW7{A-Z`>$Yk=jAD7?ZmymB
z{CHLLrDIih<ky>JWcF@5r}tl+eF#ZET!`+rzOn<#>_*7%zU(@lER=OzQ*N%rNhm=8
zJlc1<-{$+<*;|sS!&zx>e*bVX`FV`10ZRFs*p!Of%o*IJl{5A0Eyp3Eg6twTQRTR$
zx>HSN)@J-!P%t9mV7tef3Qud>8(GP+hvLhWI$6Hu!Bvb=B7Gj`@6R4vpKfX4wxG&A
z;1!?oi3pkPnqN7()x6sfL#k?LvA&)VEx0adB^lL>_GwoBo)_x0l4Vh~ow8%3Z+sZA
zu{yde78>~}yKg`PXScqpX$q@BRJvA4G`<Z-Uyu{MHSIjMTi<vWj+&6N<)@L9*@@$v
z%=$VylYdaEhh0qhy4K~kmCqKQ2r&$sxL-09S$OYt5kD8c3R??z;00c$&;vvi#X+L2
z`A(xh!zwgB7NkfX5Kctwe)b_Jon2A&g=lR2fw9!-nM>1N{xUeZvyfylqj1%W{u6$n
zF{WOydJ4LcSr$Fc+$2eBHhhn8B1iVFMcXULV0ZEfR-F&Hxw7t)bO<qUaoVgOllX1)
zOY+0;foZ8MGZ3Ql_a!{tSf(WhK0h`5(p<<Bv2i&o4D91QC5cNO%wp3=8a^eTSe=Z^
z?pDH@rkGv_>1$9Z$vTqz$80N26ye-TJU02>tGGV!Uf1~iyJPiy?l<5O)~&@cvvA&n
zXR^3SLxLf+Dlnm?y6k9|XmPd2g{)bHX1&qxjE_@bOrJg?RTatd<r=p}#-|YnrXG2a
z3Qb%pY9+}g?jqBxVX%9U`pJUG2@`SBv;C~4`uaD;sl1S_vP|@F1~gb`I>hu%qokUv
zzROe{PkXTfxGvacGqg%rz$`gICC%h6;#?@gC8(gd%ESm93Zd`j<4L~8P!Cmq8j%dh
zoKfG4>8rmu%I;JsW*Cow&#?otSwr{@bx}~78~00ykj*43EH;R@vlR~^A)t9!A`S=d
z9<{CHQU<kLjhRvjHj6HaOz|#2ty9rLEzqGt<0ljrOxng4cOMjitJ(VO+`j3NVRe_B
zMRfk!^%6}9OK34g?w2HfbW>_@-h7E6;X!fCHu}>7)3`kCk!edE#-w?m_kn>tBk?*G
zWHNMy)8`Vpw)=%CEM@{1ZK<A`o;&egPEPw++iOJQdQ-jgmr7Qg8t}Bm^Hp(B=<_|y
zGPfx5jB*6r0Ril)NZ-C0slX&>jJkOf4eC2D+JpCBnQra5Q5W^N6+y9I^&2#T&8}NJ
zht#NEFxqY#6bG3gm(MZYaVF5z6A9DrJl;1hE+wJ{HmV6<AU7xB@vhV$rrTJrAi3ym
z65W;E@mhXn+18NuuA&-E)>k?`#XP=JbAW`&MaZt+i11v4EFJvmzr<c51(#-C=~B}8
zK?n2!qnFA;^+t~Y7+tA>rzd{UM*Zv6UWoZ$4ZHYb08mz*&`~8nI^6wPfBZ~YQAlFl
z?)Ld9cErQuIvH^O_VzzuMsv|8?Pqb8tcafU#v$92-F45r{u;JgT?uJi9GJ^O!89t6
zX5rfQB9Ly8j5D76Gd7kPzask657hmOS@uws0l<dd%FS9wTPPa(W!73b>QaNf=v?k+
z-i)tc0u`!C59fXliIRx@Y@TaLto=#{Q~CAIivdoyY}oNO8uJ)ZuWu6aM0rz6t;Pyj
zofchiV7^<Akk@+Bu;H#px{Z8NY{&qd3JD?N_&&N_m_>-4_Ll1B*oDQhauEPTC<}q0
zKao*6`r~%)O&xTBtl0glG>2$4T&Jpw6mK@fz)>{i`F?n6fqZ!#W(Iv$&sRY_m5dSk
zrc#viPB3+4-%>4Dz{d3=*O5bSwZ%eS{~~xTx@TI((kJZ~g;&|WYjQ3zbzK>)^|dOF
zM$kty-Z8hHg*gB5=v-YX`h$F7>#6gX!4i{ERsunJ_d?1Z&*!9Vw820ouZN}x;q-%<
zZ2E@)@(O|jte|oOc+^)Kx3D;!(|-B4%9J9v#JHU-yu>!+je&F>ow865D`7kn+x;Lx
zLu}Fc5}}{njoy;x01SWZT7OMCKaq3}Uc0aw1p%t!$_HM=yx#55;POAfep=7yAmei^
z<t$`>L!{tGBT9JeN$mScjM_Z!Ey}`JQa>RLEFtcWq$1STo2A4Wr0M&=F()D;+i8O-
z2^dxo*~)a4W8~<M{?iX*_!(va_xEpQ>&DO#Uk{-DyVK<*u>*LkU-rv1S_`+=oG9=8
zw+PIlvht+Vs9j17BOqk0PbnX1<R@|S4zvRWy+J@pAlc*u@E-g9TjXCcbB+AOf!%1{
z3QPX?nsO=cG^Ll<IGl3MR*289K(Pb|&9{Yb#%$<*0n)>rqb<0$W<_2-Np?Df*@>@5
zXubptDGOe1TMOW+kYc2f(`@WK?$8*YR_btg)i(2e_<V9gD=_u7)nB8tmom+&_jxN<
z-mN9p^z%aduMoGUgI)Pis&@=s#$bBo^IALubRjc=cz)fHoyr#vx~@sk*%z!iSjZ`L
z2vA=g8R(b*O;BgRlNyP-J#5M=9$v7S_+o*IAg$>AvNL{T+thxShTstghj--lM6{u`
zG>Ky5OjOZVU&F;Kz<6zlFf_&?Y0yr?Qa*DU1NMQ=FucBV#?HN}SL~vJ;h6ZHnwxhx
z`{(BYB&x$5@eC#31;X}h(GC9ZdP^qzeJ&vI_ia^%+RERjC<(+6aO^+-<!`L)zb~wQ
e-%$a0|I_QpS^!7<Z_o%+>FTp9QAduPIPyP|9R?!+

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/xentry_type.gz b/tests/ubifs_tools-tests/images/xentry_type.gz
new file mode 100644
index 0000000000000000000000000000000000000000..e0c57634415150394b01e80f7f109086e5b4b5ce
GIT binary patch
literal 5113
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
Ue;bBf3Py9;&m8{);`p)u0|Lz*e*gdg

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/xinode_flags.gz b/tests/ubifs_tools-tests/images/xinode_flags.gz
new file mode 100644
index 0000000000000000000000000000000000000000..34d3ff71387f393c0814da352e03f36358e2df5a
GIT binary patch
literal 5112
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
VX&3dks2kG+8|8bs`}PU#`w!t_8?FEV

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/xinode_key.gz b/tests/ubifs_tools-tests/images/xinode_key.gz
new file mode 100644
index 0000000000000000000000000000000000000000..c92956cde911a84c6c192973c5e7f3e1fe02b06e
GIT binary patch
literal 5110
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_tools-tests/images/xinode_mode.gz b/tests/ubifs_tools-tests/images/xinode_mode.gz
new file mode 100644
index 0000000000000000000000000000000000000000..0e5264815fd83f6c6aecaf1b7110ee69a0d16fee
GIT binary patch
literal 5112
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
a|H(f&x&LfxJ=x;&zwT`S?b~-?-@gEKt`qhE

literal 0
HcmV?d00001

-- 
2.13.6


