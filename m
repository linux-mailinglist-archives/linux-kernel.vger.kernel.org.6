Return-Path: <linux-kernel+bounces-205288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E89EB8FFA79
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A0671F22C95
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E1E13DDA0;
	Fri,  7 Jun 2024 04:26:43 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EE9433B6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734400; cv=none; b=NgXswpPOijIIDP9i13EfN8vCt6W6WR9v8Lh1PMHJfn03aDZjK14Phhha+mQ6h4gZncS+HyPjgnjnZAtaiQwu9e6mJoYDvOdIb5CYEyN8Wc42D6WYcJEqK2R7LBrMOTrfykmmRhkX6E/M9KH4E42VAupcvxuOL+7y809WjXD0kIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734400; c=relaxed/simple;
	bh=+7fz2mgX3i/I5bRIYAJSDx7yf+VkAMQ/EQBUE6+hVsc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dO27QWAeXC+NNBX6jRVorUZsSKbo7hFkNlPKTMYHcEfeQNAbMlct0xwZ4csPBErbk4kv5E/UaT572b5+oByVC7OCurqJYSlZqAdxiH8UG57uIGsHkWU6K4d2UqGIiSUbVjNSn48D1HX7aSyhdaTrshgUYXwujb8qRkGgNvXNOTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwSly2c5wzdZh7;
	Fri,  7 Jun 2024 12:25:02 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 3EF2318007B;
	Fri,  7 Jun 2024 12:26:27 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:26:26 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 000/110] Add fsck.ubifs support
Date: Fri, 7 Jun 2024 12:24:25 +0800
Message-ID: <20240607042615.2069840-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
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

Introduction
============

The fsck.ubifs provides a way to fix inconsistent UBIFS image(which is
corrupted by hardware exceptions or UBIFS realization bugs) and makes
filesystem become consistent, just like fsck tools(eg. fsck.ext4,
fsck.f2fs, fsck.fat, etc.) do.

Why do we need fsck.ubifs?
--------------------------

The inconsistent UBIFS image is produced by mainly two aspects:
 - *Hardware exceptions*: Some of them are ecc uncorrectable errors(eg.
   [1][2]), some of them are caused by intermittent writing protection
   (unstable voltage).
 - *UBIFS realization bugs*: Some of them are known bugs which are
   fixable (eg. [3][4][5][6][7][8][9][10][11][12][13], etc.), some of
   them are unknown bugs(eg. [14]), some of them are hard to fix(eg. [15]).
Once the UBIFS image becomes inconsistent, userspace applications won't
work properly, as we all know, UBIFS is mainly applied in embedded
system, which could affect many domains(eg. communications, IoT, family
network, etc.). The only way to rescue device is formating UBI device
and mkfs, which will lost all userdata, and it could be intolerable for
some important situations.
So, the fsck.ubifs is urgent for UBIFS, even it has been born for 15
years, and it's not too late to do it for there will be more embedded
devices in the future IOT world.

Manuals
=======

There are four modes for fsck.ubifs:
 1. normal mode(no options): Check the filesystem, ask user whether to
    fix the problem as long as inconsistent data is found during fs
    checking.
 2. safe mode(-a option): Check and automatic safely repair the
    filesystem, if there are any data dropping operations needed by
    fixing, fsck will fail.
 3. danger mode(-y option): Answer 'yes' to all questions. There are two
    sub modes:
    a) Default submode(no options): Check and automatic repair the
       filesystem according to TNC, data dropping will be reported. If
       TNC/master/log is corrupted, fsck will fail.
    b) rebuild submode(-b option): Check and automatic forcibly repair
       the filesystem, turns to rebuild filesystem if TNC/master/log is
       corrupted. Always make fsck successful.
 4. check mode(-n option): Make no changes to the filesystem, only check
    the filesystem. This mode doesn't check space, because unclean LEBs
    cannot be rewritten in read-only mode.

The exit code returned by fsck.ubifs is compatible with FSCK(8), which
is the sum of the following conditions:
 0      - No errors
 1      - File system errors corrected
 2      - System should be rebooted
 4      - File system errors left uncorrected
 8      - Operational error
 16     - Usage or syntax error
 32     - Fsck canceled by user request
 128    - Shared library error

Designment
==========

There are 2 working modes for fsck: rebuild mode and non-rebuild mode.
The main idea is that construct all files by scanning the entire
filesystem, then check the consistency of metadata(file meta information,
space statistics, etc.) according to the files. The file(xattr is treated
as a file) is organized as:
   file tree(rbtree, inum indexed)
            /      \
         file1   file2
	 /   \
      file3 file4
 file {
     inode node // each file has 1 inode node
     dentry (sub rb_tree, sqnum indexed)
     // '/' has no dentries, otherwise at least 1 dentry is required.
     trun node // the newest one truncation node
     data (sub rb_tree, block number indexed)
     // Each file may have 0 or many data nodes
     xattrs (sub rb_tree, inum indexed)
     // Each file may have 0 or many xattr files
 }

 Step 0. Both two modes need to read the superblock firstly, fsck fails if
         superblock is corrupted, because fsck has no idea about the location
	 of each area(master, log, main, etc.) when the layout is lost.

 A. Rebuild mode(Similar to [16]):
 Step 1. Scan nodes(inode node/dentry node/data node/truncation node) from all
         LEBs.
	 a) Corrupted LEBs(eg. garbage data, corrupted empty space) are dropped
	    during scanning.
	 b) Corrupted nodes(eg. incorrect crc, bad inode size, bad dentry name
	    length, etc.) are dropped during scanning.
         c) Valid inode nodes(nlink > 0) and dentry nodes(inum != 0) are put
	    into two valid trees(valid_inos & valid_dents) separately.
	 d) Deleted inode nodes (nlink is 0) and deleted dentry nodes(inum is 0)
	    are put into two deleted trees(del_inos & del_dents) separately.
	 e) Other nodes(data nodes/truncation node) are put into corresponding
	    file, if the file doesn't exist, insert a new file into the file
	    tree.
 Step 2. Traverse nodes from deleted trees, remove inode nodes and dentry nodes
         with smaller sqnum from valid trees. valid_inos - del_inos = left_inos,
	 valid_dents - del_dents = left_dents.
	 This step handles the deleting case, for example, file A is deleted,
	 deleted inode node and deleted dentry node are written, if we ignore
	 the deleted nodes, file A can be recovered after rebuilding because
	 undeleted inode node and undeleted dentry node can be scanned. There's
	 an exception, if deleted inode node and deleted dentry node are
	 reclaimed(by gc) after deletion, file A is recovered. So deleted data
	 or files could be recovered by rebuild mode.
 Step 3. Traverse left_inos and left_dents, insert inode node and dentry nodes
         into the corresponding file.
 Step 4. Traverse all files, drop invalid files, move xattr files into the
         corresponding host file's subtree. Invalid files such as:
	 a) File has no inode node or inode nlink is zero
	 b) Non-consistent file types between inode node and dentry nodes
	 c) File has no dentry nodes(excepts '/')
	 d) Encrypted file has no xattr information
	 e) Non regular file has data nodes
	 f) Directory/xattr file has more than one dentries
	 g) Xattr file has no host inode, or the host inode is a xattr
	 h) Non-xattr file's parent is not a directory
	 i) etc.
 Step 5. Extract reachable directory entries tree. Make sure that all files can
         be searched from '/', unreachable file is deleted. Since all xattr
	 files are attached to the corresponding host file, only non-xattr
	 files should be checked. Luckily, directory file only has one dentry,
	 the reachable checking of a dentry becomes easy. Traverse all
	 dentries for each file, check whether the dentry is reachable, if not,
	 remove dentry from the file. If the file has no dentries, the file is
	 unreachable.
 Step 6. Correct the file information. Traverse all files and calculate
         information(nlink, size, xattr_cnt, etc.) for each file just like
	 check_leaf(in linux kernel) does, correct the inode node based on the
	 calculated information.
 Step 7. Record used LEBs. Traverse all files'(including effective nodes from
	 deletion trees in step 2) position, after this step fsck knows which
         LEB is empty.
 Step 8. Re-write data. Read data from LEB and write back data, make sure that
         all LEB is ended with empty data(0xFF). It will prevent failed gc
	 scanning in the next mounting.
 Step 9. Build TNC. Construct TNC according to all files' nodes, just like mkfs
         does(refer to add_to_index in mkfs), then write TNC(refer to
	 write_index in mkfs) on flash. (If there are no files, create a new
	 root dir file.)
 Step 10.Build LPT. Construct LPT according to all nodes' position and length,
         just like mkfs does, then write LPT(refer to write_lpt) on flash.
 Step 11.Clean up log area and orphan area. Log area and orphan area can be
         erased.
 Step 12.Write master node. Since all meta areas are ready, master node can be
         updated.

 B. Non-rebuild mode:
 Step 1. Read master & init lpt.
         a) Scan master nodes failed or master node is invalid (which is not
            caused by invalid space statistics), danger mode with rebuild_fs and
	    normal mode with 'yes' answer will turn to rebuild mode, other modes
	    will exit. Fsck cannot find the right TNC/LPT if the master node is
	    invalid, which affects subsequent steps, so this problem must be
	    fixed.
	 b) Invalid space statistics in master node, set %FR_LPT_INCORRECT for
	    for lpt status and ignore the error.
	 c) LPT node is corrupted, set %FR_LPT_CORRUPTED for lpt status and
	    ignore the error.
 Step 2. Replay journal.
         I. Scan log LEBs to get all buds.
	    a) Nodes in log LEBs are invalid/corrupted, danger mode with
               rebuild_fs and normal mode with 'yes' answer will turn to rebuild
               mode, other modes will exit. Corrupted log LEB could fail
               ubifs_consolidate_log, which may lead to commit failure by out of
	       space in the log area, so this problem must be fixed.
	 II. Scan bud LEBs to get all nodes.
	     a) Nodes in bud LEBs are invalid/corrupted, danger mode and normal
	        mode with 'yes' answer will drop bud LEB and set
		%FR_LPT_INCORRECT for lpt status, other modes will exit.
		Corrupted LEB will make gc failed, so this problem must be
		fixed.
	 III. Record isize into size tree according to data/truncation/inode
	      nodes.
	 IV. Apply nodes to TNC & LPT, update property for bud LEBs.
	     a) Corrupted/Invalid node searched from TNC, skip node and set
	        %FR_LPT_INCORRECT in lpt status for danger mode and normal mode
		with 'yes' answer, other modes will exit. The space statistics
		depend on a valid TNC, so this problem must be fixed.
	     b) Corrupted/Invalid index node read from TNC, danger mode with
	        rebuild_fs and normal mode with 'yes' answer will turn to
		rebuild filesystem, other modes will exit. The space statistics
		depend on a valid TNC, so this problem must be fixed.
	     c) Corrupted/Invalid lpt node, Set %FR_LPT_CORRUPTED for lpt status
	        and ignore the error.
	     d) Incorrect LEB property: Set %FR_LPT_INCORRECT for lpt status and
	        ignore the error.
	     e) If lpt status is not empty, skip updating lpt, because incorrect
	        LEB property could trigger assertion failure in ubifs_change_lp.
 Step 3. Handle orphan nodes.
	 I. Scan orphan LEB to get all orphan nodes.
	    a) Corrupted/Invalid orphan node: danger mode and normal mode with
	       'yes' answer will drop orphan LEB, other modes will exit.
	        Corrupted orphan area could lead to mounting/committing failure,
		so this problem must be fixed.
	 II. Parse orphan node, find the original inode for each inum.
	     a) Corrupted/Invalid node searched from TNC, skip node for danger
	        mode and normal mode with 'yes' answer, other modes will exit.
	     b) Corrupted/Invalid index node read from TNC, danger mode with
	        rebuild_fs and normal mode with 'yes' answer will turn to
		rebuild filesystem, other modes will exit. The space statistics
		depend on a valid TNC, so this problem must be fixed.
	 III. Remove inode for each inum, update TNC & LPT.
	      a) Corrupted/Invalid node searched from TNC, skip node for danger
	         mode and normal mode with 'yes' answer, other modes will exit.
	      b) Corrupted/Invalid index node read from TNC, danger mode with
	         rebuild_fs and normal mode with 'yes' answer will turn to
		 rebuild filesystem, other modes will exit. The space statistics
		 depend on a valid TNC, so this problem must be fixed.
	      c) Corrupted/Invalid lpt node, Set %FR_LPT_CORRUPTED for lpt
	         status and ignore the error.
	      d) Incorrect LEB property: Set %FR_LPT_INCORRECT for lpt status
	         and ignore the error.
	      e) If lpt status is not empty, skip updating lpt, because
	         incorrect LEB property could trigger assertion failure in
		 ubifs_change_lp.
 Step 4. Consolidate log area.
	 a) Corrupted data in log LEBs, danger mode with rebuild_fs and normal
	    mode with 'yes' answer will turn to rebuild filesystem, other modes
	    will exit. It could make commit failed by out of space in log area,
	    so this problem must be fixed.
 Step 5. Recover isize.
	 I. Traverse size tree, lookup corresponding inode from TNC.
	    a) Corrupted/Invalid node searched from TNC, skip node for danger
	       mode and normal mode with 'yes' answer, other modes will exit.
	    b) Corrupted/Invalid index node read from TNC, danger mode with
	       rebuild_fs and normal mode with 'yes' answer will turn to
	       rebuild filesystem, other modes will exit. The space statistics
	       depend on a valid TNC, so this problem must be fixed.
	 II. Update isize for inode. Keep <inum, isize> in size tree for check
	     mode, remove <inum, isize> from the size tree and update inode
	     node in place for other modes.
 Step 6. Traverse TNC and construct files.
	 I. Traverse TNC, check whether the leaf node is valid, remove invalid
	    nodes, construct file for valid node and insert the file into the
	    file tree.
	    a) Corrupted/Invalid node searched from TNC, remove corresponding
	       TNC branch for danger mode and normal mode with 'yes' answer,
	       other modes will exit. The space statistics depend on a valid
	       TNC, so this problem must be fixed.
	    b) Corrupted/Invalid index node read from TNC, danger mode with
	       rebuild_fs and normal mode with 'yes' answer will turn to
	       rebuild filesystem, other modes will exit. The space statistics
	       depend on a valid TNC, so this problem must be fixed.
	 II. Scan all LEBs(contain TNC) for non check mode(unclean LEBs cannot
	     be fixed in read-only mode, so scanning may fail in check mode,
	     then space statistics won't be checked in check mode), remove TNC
	     branch which points to corrupted LEB.
	     a) Corrupted data is found by scanning. If the current node is
	        index node, danger mode with rebuild_fs and normal mode with
		'yes' answer will turn to rebuild filesystem, other modes will
		exit; If the current node is non-index node, danger mode and
		normal mode with 'yes' answer will remove all TNC branches which
		point to the corrupted LEB, other modes will exit. The space
		statistics depend on valid LEB scanning, so this problem must
		be fixed.
	     b) LEB contains both index and non-index nodes, danger mode with
	        rebuild_fs and normal mode with 'yes' answer will turn to
		rebuild filesystem, other modes will exit. Invalid LEB will make
		gc failed, so this problem must be fixed.
 Step 7. Update files' size for check mode. Update files' size according to the
	 size tree for check mode.
 Step 8. Check and handle invalid files. Similar to rebuild mode, but the
	 methods of handling are different:
	 a) Move unattached(file has no dentries) regular file into disconnected
	    list for safe mode, danger mode and normal mode with 'yes' answer,
	    let subsequent steps to handle them with lost+found. Other modes
	    will exit. Disconnected file affects the result of calculated
	    information(which will be used in subsequent steps) for its' parent
	    file(eg. nlink, size), so this problem must be fixed.
	 b) Make file type be consistent between inode, detries and data nodes
	    by deleting dentries or data nodes, for danger mode and normal mode
	    with 'yes' answer, other modes will exit.
	 c) Delete file for other invalid cases(eg. file has no inode) in
	    danger mode and normal mode with 'yes' answer, other modes will
	    exit.
 Step 9. Extract reachable directory entries tree. Similar to rebuild mode, but
	 the methods of handling are different:
	 a) Remove unreachable dentry for danger mode and normal mode with 'yes'
	    answer, other modes will exit. Unreachable dentry affects the
	    calculated information(which will be used in subsequent steps) for
	    its' file(eg. nlink), so this problem must be fixed.
	 b) Delete unreachable non-regular file for danger mode and normal mode
	    with 'yes' answer, other modes will exit. Unreachable file affects
	    the calculated information(which will be used in subsequent steps)
	    for its' parent file(eg. nlink, size), so this problem must be
	    fixed.
	 c) Move unreachable regular file into disconnected list for safe mode,
	    danger mode and normal mode with 'yes' answer, let subsequent steps
	    to handle them with lost+found. Other modes will exit. Disconnected
	    file affects the calculated information(which will be used in
	    subsequent steps) for its' parent file(eg. nlink, size), so this
	    problem must be fixed.
 Step 10.Correct the file information. Similar to rebuild mode, but the methods
	 of handling are different:
	 a) Correct the file information for safe mode, danger mode and normal
	    mode with 'yes' answer, other modes will exit. Incorrect file
	    information affects the new creations(which will be used in handling
	    lost+found), so this problem must be fixed.
 Step 11.Check whether the TNC is empty. Empty TNC is equal to corrupted TNC,
	 which means that zero child count for root znode. If TNC is empty(All
	 nodes are invalid and are deleted from TNC), turn to rebuild mode for
	 danger mode with rebuild_fs and normal mode with 'yes' answer, other
	 modes will exit.
 Step 12.Check and correct the space statistics.
	 I. Exit for check mode, if %FR_LPT_CORRUPTED or %FR_LPT_INCORRECT is
	    set in lpt status, the exit code should have %FSCK_UNCORRECTED.
	 II. Check lpt status, if %FR_LPT_CORRUPTED is set in lpt status, normal
	     mode with 'no' answer will exit, other modes will rebuild lpt. New
	     creations could be done in subsequent steps, which depends on
	     correct space statistics, so this problem must be fixed.
	 III. Traverse LPT nodes, check the correctness of nnode and pnode,
	      compare LEB scanning result with LEB properties.
	      a) LPT node is corrupted, normal mode with 'no' answer will exit,
		 rebuild lpt for other modes. New creations could be done in
		 subsequent steps, which depends on the correct space
		 statistics, so this problem must be fixed.
	      b) Incorrect nnode/pnode, normal mode with 'no' answer will exit,
	         other other modes will correct the nnode/pnode. New creations
		 could be done in subsequent steps, which depends on correct
		 space statistics, so this problem must be fixed.
	      c) Inconsistent comparing result, normal mode with 'no' answer
	         will exit, other modes will correct the space statistics. New
		 creations could be done in subsequent steps, which depends on
		 correct space statistics, so this problem must be fixed.
	 IV. Compare LPT area scanning result with lprops table information.
	     a) LPT area is corrupted, normal mode with 'no' answer will exit,
	        rebuild lpt for other modes. Commit could fail in doing LPT gc
		caused by scanning corrupted data, so this problem must be
		fixed.
	     b) Inconsistent comparing result, normal mode with 'no' answer
	        will exit, other modes will correct the lprops table
		information. Commit could fail in writing LPT with %ENOSPC
		return code caused by incorrect space statistics in the LPT
		area, so this problem must be fixed.
 Step 13.Do commit, commit problem fixing modifications to disk. The index size
         checking depends on this step.
 Step 14.Check and correct the index size. Check and correct the index size by
	 traversing TNC just like dbg_check_idx_size does. This step should be
	 executed after first committing, because 'c->calc_idx_sz' can be
	 changed in 'ubifs_tnc_start_commit' and the initial value of
	 'c->calc_idx_sz' read from the disk is untrusted. Correct the index
	 size for safe mode, danger mode and normal mode with 'yes' answer,
	 other modes will exit. New creations could be done in subsequent steps,
	 which depends on the correct index size, so this problem must be fixed.
 Step 15.Check and create the root dir. Check whether the root dir exists,
	 create a new one if it is not found, for safe mode, danger mode and
	 normal mode with 'yes' answer, other modes will exit. Mounting depends
	 on the root dir, so this problem must be fixed.
 Step 16.Check and create the lost+found.
	 I. If the root dir is encrypted, set lost+found as invalid. Because it
	    is impossible to check whether the lost+found exists in an encrypted
	    directory.
	 II. Search the lost+found under root dir.
	     a) Found a lost+found, lost+found is a non-encrypted directory, set
		lost+found as valid, otherwise set lost+found as invalid.
	     b) Not found the lost+found, create a new one. If creation is
	        failed by %ENOSPC, set lost+found as invalid.
 Step 17.Handle each file from the disconnected list.
	 I. If lost+found is invalid, delete file for danger mode and normal
	    mode with 'yes' answer, other modes will skip and set the exit code
	    with %FSCK_UNCORRECTED.
	 II. If lost+found is valid, link disconnected file under lost+found
	     directory with the name of the corresponding inode number
	     (INO_<inum>_<index>, index(starts from 0) is used to handle the
	      conflicted names).
	     a) Fails in handling conflicted file names, delete file for danger
		mode and normal mode with 'yes' answer, other modes will skip
		and set the exit code with %FSCK_UNCORRECTED.
	     b) Fails in linking caused by %ENOSPC, delete file for danger mode
	        and normal mode with 'yes' answer, other modes will skip and set
		the exit code with %FSCK_UNCORRECTED.
 Step 18.Do final commit, commit problem fixing modifications to disk and clear
         %UBIFS_MST_DIRTY flag for master node.


Advantages
==========
 1. Can be used for any UBIFS image, fsck has nothing to do with kernel version.
 2. Fsck is tolerant with power-cut, fsck will always succeed in a certain mode
    without changing mode even power-cut happens in checking and repairing. In
    other words, fsck won't let UBIFS image become worse in abnormal situations.
 3. It is compatible with FSCK(8), the exit code returned by fsck.ubifs is same
    as FSCK, the command options used by fsck are supported in fsck.ubifs too.
 4. The UBIFS image can be fixed as long as the super block is not corrupted.
 5. Encrypted UBIFS image is supported, because dentry name and data content of
    file are not necessary for fsck.


Limitations
===========
 1. UBIFS image file is not supported(Not like ext4). The UBIFS image file is
    not equal to UBI volume, empty LEBs are not included in image file, so UBIFS
    cannot allocate empty space when file recovering is needed. Another reason
    is that atomic LEB changing is not supported by image file.
 2. Authenticated UBIFS image is not supported, UBIFS metadata(TNC/LPT) parsing
    depends on the authentication key which is not supported in fsck options.


Testing
=======

We have seven testcases for fsck.ubifs on encryption/non-encryption
situations(See details in tests/ubifs_tools-tests/README.txt):
 1) authentication_refuse: Currently authenticated UBIFS image is not
    supported for fsck.ubifs.
 2) random_corrupted_fsck: Inject random corruption on UBIFS image
    by writting random data on kinds of mtd devices (eg. nand, nor),
    check the consistency of UBIFS after fsck.
    This testcase simulate random bad UBIFS image caused by hardware
    exceptions(eg. ecc uncorrectable, unwritten), and makes sure that
    fsck.ubifs could make UBIFS be consistent after repairing UBIFS
    image.
 3) cycle_corrupted_fsck_fault_inject: Inject memory/io fault while
    doing fsck for corrupted UBIFS images.
    This testcase mainly checks whether fsck.ubifs has problems (eg.
    UAF, null-ptr-def, etc.) in random error paths. Besides, it
    provides a similar way to simulate powercut during fsck, and
    checks whether the fsck.ubifs can fix an UBIFS image after many
    rounds interrupted by kinds of errors.
    I have run this case with valgrind[17] in my local machine to
    check kinds of memory errors(eg. rw OOB, null-ptr-def).
 4) cycle_powercut_mount_fsck: Inject powercut while doing fsstress
    on mounted UBIFS, check the consistency of UBIFS after fsck.
    This testscase mainly makes sure that fsck.ubifs can make UBIFS
    image be consistent in common stress cases and powercut cases.
 5) powercut_fsck_mount: Inject powercut while doing fsstress on
    mounted UBIFS for kinds of flashes (eg. nand, nor).
    This testcase mainly makes sure that fsck.ubifs can make UBIFS
    image be consistent on different flashes (eg. nand, nor). Because
    the min_io_size of nor flash is 1, the UBIFS image on nor flash
    will be different from nand flash after doing powercut, so we need
    make sure fsck.ubifs can handle these two types of flash.
 6) cycle_mount_fsck_check: Do fsstress and fsck ubifs image, make
    sure all files(and their data) are not lost after fsck.
    This testcase mainly checks whether fsck.ubifs could corrupt the
    filesystem content in common case.
 7) fsck_bad_image: For kinds of inconsistent UBIFS images(which
    can simulate corruptions caused by some potentional UBIFS bug),
    check the result of fsck.
    This testcase mainly checks whether the behavior is in expected
    after repairing specific inconsistent UBIFS image.

There is one testcase for mkfs.ubifs on encryption/non-encryption
situations:
 1) build_fs_from_dir: Initialize UBIFS image from a given directory,
    then check whether the fs content in mounted UBIFS is consistent
    with the original directory. Both UBI volume and file are chosen as
    storage mediums to test. This testcase mainly ensures that
    mkfs.ubifs can format an UBIFS image as user expected.

Besides, I fix all corrupted UBIFS images(history problems in our
product line) by fsck.ubifs.

Environment: qemu, -smp 4, -m 16384/32768, nandsim/mtdram
Code coverage[18]:
 fsck - Line 87.4%, functions 98.0%
 libubifs - Line 78.4%, functions 89.1%
 mkfs - Line 71.6%, functions 97.8%

Notice
------

Before running testcases, please make sure that your linux kernel is
updated to the latest version(v6.9), and following patches shoule be
applied, otherwise some of testcases may fail.
P1: https://lore.kernel.org/linux-mtd/20240604113207.244643-1-chengzhihao1@huawei.com/
P2: https://lore.kernel.org/linux-mtd/20240410073751.2522830-1-chengzhihao1@huawei.com/
P3: https://lore.kernel.org/linux-mtd/20240411031903.3050278-1-chengzhihao1@huawei.com/


Patches
=======
1~15:  Some bugfixes and cleanups for mkfs.ubifs, split common libs into
       'common' directory.
16:    Import linux kernel implementations into ubifs-utils/libubifs.
       Prepare to replace implementations of UBIFS with linux kernel.
17~32: Add some basic libs(bitops, mutex, rwsem, etc.) which will be used
       by libubifs.
33:    Add README for common directory to describe where these basic
       libs come from.
34~56: Adapt libubifs to userspace, delete codes which won't be used by
       fsck/mkfs.
57~60: Add basic framework fsck.
61~75: Implement rebuild mode for fsck.
76~97: Implement other modes(normal, danger, check) for fsck.
98:    Add docs for fsck.
99~110:Add testcases for fsck/mkfs.


Links
=====

[1] https://lore.kernel.org/linux-mtd/1582293853-136727-1-git-send-email-chengzhihao1@huawei.com/
[2] https://lore.kernel.org/linux-mtd/CAMxq0fNSWrUFMmmTs8Ri9gFOvS+KQJvZN3-_KuiqXi9bbmCB0Q@mail.gmail.com/
[3] https://lore.kernel.org/linux-mtd/20211227032246.2886878-6-chengzhihao1@huawei.com/
[4] https://lore.kernel.org/linux-mtd/1638777819.2925845.1695222544742.JavaMail.zimbra@robart.cc/T/#u
[5] https://lore.kernel.org/linux-mtd/20190515203113.19398-1-richard@nod.at/
[6] https://lore.kernel.org/linux-mtd/20190404223438.29408-1-richard@nod.at/
[7] https://lore.kernel.org/linux-mtd/20210316085214.25024-1-guochun.mao@mediatek.com/
[8] https://lore.kernel.org/linux-mtd/20180611225228.28931-1-richard@nod.at/
[9] https://lore.kernel.org/linux-mtd/20180611214109.14424-1-richard@nod.at/
[10] https://lore.kernel.org/linux-mtd/1476823591-6137-1-git-send-email-richard@nod.at/
[11] https://lore.kernel.org/linux-mtd/1474495050-13529-1-git-send-email-pascal.eberhard@gmail.com/
[12] https://lore.kernel.org/linux-mtd/1342340237-29656-1-git-send-email-dedekind1@gmail.com/
[13] https://lore.kernel.org/linux-mtd/20240410073751.2522830-1-chengzhihao1@huawei.com/
[14] https://linux-mtd.infradead.narkive.com/bfcHzD0j/ubi-ubifs-corruptions-during-random-power-cuts
[15] https://lore.kernel.org/linux-mtd/97ca7fe4-4ad4-edd1-e97a-1d540aeabe2d@huawei.com/T/#u
[16] https://lore.kernel.org/linux-mtd/20231228014112.2836317-1-chengzhihao1@huawei.com/
[17] https://valgrind.org/
[18] https://bugzilla.kernel.org/show_bug.cgi?id=218924


Huang Xiaojia (1):
  fsck.ubifs: Check and create the lost+found

Xiang Yang (1):
  fsck.ubifs: Check and correct files' information

Zhihao Cheng (108):
  mkfs.ubifs: Clear direct_write property when closing target
  mkfs.ubifs: Initialize 'cipher_name' as NULL
  ubifs-utils: Split common source files from mkfs.ubifs
  ubifs-utils: Decouple mkfs.ubifs.h out of other modules
  ubifs-utils: Define PROGRAM_NAME as variable
  ubifs-utils: Clean up error message printing functions
  ubifs-utils: Move 'debug_level' into ubifs_info structure
  mkfs.ubifs: Fix wrong xattr entry type
  mkfs.ubifs: Fix incorrect dir size calculation in encryption scenario
  mkfs.ubifs: Close libubi in error handling paths
  mkfs.ubifs: Fix missed closing out_fd
  mkfs.ubifs: Fix memleak for 'output' in error paths
  ubifs-utils: Add 'dev_name' into 'ubifs_info' structure
  ubifs-utils: Add 'dev_fd' and 'libubi' into 'ubifs_info' structure
  ubifs-utils: Extract UBI opening/closing/volume_check_empty functions
    into a new source file
  ubifs-utils: Import UBIFS libs from linux kernel
  mtd-utils: Extract list implementation to common lib and add list_sort
    support
  mtd-utils: Extract rbtree implementation to common lib
  ubifs-utils: Add compiler attributes implementations
  ubifs-utils: Add linux type definitions
  ubifs-utils: Add linux kernel error conversion definitions
  ubifs-utils: Add linux kernel memory allocation implementations
  ubifs-utils: Add atomic implementations
  ubifs-utils: Add bit operations implementations
  ubifs-utils: Add spinlock implementations
  ubifs-utils: Add mutexlock implementations
  ubifs-utils: Add rwsem implementations
  ubifs-utils: Add sorting implementations
  ubifs-utils: Add implementations for linux kernel printing functions
  ubifs-utils: Add linux hexdump implementations lib
  libubi: Add new interface ubi_leb_map()
  ubifs-utils: Add common definitions in linux kernel
  ubifs-utils: Add descriptions for new lib files in common/README
  ubifs-utils: Adapt ubifs header file in libubifs
  ubifs-utils: Adapt super.c in libubifs
  ubifs-utils: Adapt io.c in libubifs
  ubifs-utils: Adapt lpt subsystem in libubifs
  ubifs-utils: Adapt tnc subsystem in libubifs
  ubifs-utils: Adapt log.c in libubifs
  ubifs-utils: Adapt recovery subsystem in libubifs
  ubifs-utils: Adapt sb.c in libubifs
  ubifs-utils: Adapt auth.c in libubifs
  ubifs-utils: Adapt dir.c in libubifs
  ubifs-utils: Adapt journal.c in libubifs
  ubifs-utils: Adapt budget.c in libubifs
  ubifs-utils: Adapt commit.c in libubifs
  ubifs-utils: Adapt debug subsystem in libubifs
  ubifs-utils: Adapt key.h in libubifs
  ubifs-utils: Adapt master.c in libubifs
  ubifs-utils: Adapt misc.h in libubifs
  ubifs-utils: Adapt orphan.c in libubifs
  ubifs-utils: Adapt gc subsystem in libubifs
  ubifs-utils: Move ubifs-media.h in libubifs
  ubifs-utils: Add descriptions for new lib files in libubifs/README
  ubifs-utils: Replace ubifs related source code with linux kernel
    implementation
  ubifs-utils: open_ubi: Set errno if the target is not char device
  fsck.ubifs: Add fsck support
  fsck.ubifs: Add inconsistent problem handling asking function
  fsck.ubifs: Distinguish reasons when certain failures happen
  fsck.ubifs: Load filesystem information from UBI volume
  fsck.ubifs: Add node parsing functions
  fsck.ubifs: Add file organization realization
  fsck.ubifs: Add rebuilding filesystem support
  fsck.ubifs: rebuild_fs: Remove deleted nodes from valid node tree
  fsck.ubifs: rebuild_fs: Add valid nodes into file
  fsck.ubifs: rebuild_fs: Filter invalid files
  fsck.ubifs: rebuild_fs: Extract reachable directory entries tree
  fsck.ubifs: rebuild_fs: Check and correct files' information
  fsck.ubifs: rebuild_fs: Record used LEBs
  fsck.ubifs: rebuild_fs: Re-write data
  fsck.ubifs: rebuild_fs: Create new root dir if there are no scanned
    files
  fsck.ubifs: rebuild_fs: Build TNC
  fsck.ubifs: rebuild_fs: Build LPT
  fsck.ubifs: rebuild_fs: Clean up log and orphan area
  fsck.ubifs: rebuild_fs: Write master node
  fsck.ubifs: Read master node & init lpt
  fsck.ubifs: Replay journal
  fsck.ubifs: Handle orphan nodes
  fsck.ubifs: Consolidate log
  fsck.ubifs: Recover isize
  fsck.ubifs: Move common functions and data structures into
    fsck.ubifs.c
  fsck.ubifs: Traverse TNC and construct files
  fsck.ubifs: Ensure that TNC LEB can be scanned successful
  fsck.ubifs: Update files' size for check mode
  fsck.ubifs: Check and handle invalid files
  fsck.ubifs: Check and handle unreachable files
  fsck.ubifs: Check whether the TNC is empty
  fsck.ubifs: Move common functions and data structures into
    check_space.c
  fsck.ubifs: check and correct the space statistics
  fsck.ubifs: Commit problem fixing modifications to disk
  fsck.ubifs: Check and correct the index size
  ubifs-utils: libubifs: Support some file operations
  fsck.ubifs: Check and create the root dir
  fsck.ubifs: Handle disconnected files
  fsck.ubifs: Do final committing
  fsck.ubifs: Add README to describe fsck
  tests: Add common libs for testing fsck.ubifs/mkfs.ubifs
  tests: ubifs_tools: fsck_tests: Add authentication refusing test
  tests: ubifs_tools: fsck_tests: Add cycle mount+fsck test
  tests: ubifs_tools: fsck_tests: Add powercut+fsck+mount test
  tests: ubifs_tools: fsck_tests: Add corrupt+fsck+fault_inject test
  tests: ubifs_tools: fsck_tests: Add cycle_powercut+fsck test
  tests: ubifs_tools: fsck_tests: Add random_corrupt+fsck test
  tests: ubifs_tools: fsck_tests: Add corrupted images
  tests: ubifs_tools: fsck_tests: Add bad images fixing test
  tests: ubifs_tools: mkfs_tests: Add fs content check test
  tests: ubifs_tools: Add run_all script
  tests: ubifs_tools: Add README

 .gitignore                                         |   11 +
 Makefile.am                                        |    2 +
 configure.ac                                       |   12 +-
 include/crc32.h                                    |    5 +
 include/libubi.h                                   |   15 +
 include/list.h                                     |  263 ++
 {jffsX-utils => include}/rbtree.h                  |   32 +
 jffsX-utils/Makemodule.am                          |    7 +-
 jffsX-utils/compr.c                                |   49 -
 jffsX-utils/compr.h                                |    5 +-
 lib/Makemodule.am                                  |    4 +
 lib/libubi.c                                       |   10 +
 lib/list_sort.c                                    |  246 ++
 {jffsX-utils => lib}/rbtree.c                      |   38 +
 tests/ubifs_tools-tests/Makemodule.am              |   66 +
 tests/ubifs_tools-tests/README.txt                 |  303 ++
 .../fsck_tests/authentication_refuse.sh.in         |   66 +
 .../cycle_corrupted_fsck_fault_inject.sh.in        |  225 ++
 .../fsck_tests/cycle_mount_fsck_check.sh.in        |  144 +
 .../fsck_tests/cycle_powercut_mount_fsck.sh.in     |  144 +
 .../fsck_tests/fsck_bad_image.sh.in                |  355 +++
 .../fsck_tests/powercut_fsck_mount.sh.in           |  144 +
 .../fsck_tests/random_corrupted_fsck.sh.in         |  206 ++
 .../ubifs_tools-tests/images/corrupted_data_leb.gz |  Bin 0 -> 9536 bytes
 .../ubifs_tools-tests/images/corrupted_idx_leb.gz  |  Bin 0 -> 5082 bytes
 tests/ubifs_tools-tests/images/dentry_key.gz       |  Bin 0 -> 5088 bytes
 tests/ubifs_tools-tests/images/dentry_nlen.gz      |  Bin 0 -> 5113 bytes
 tests/ubifs_tools-tests/images/dentry_type.gz      |  Bin 0 -> 5115 bytes
 tests/ubifs_tools-tests/images/dir_lost.gz         |  Bin 0 -> 5088 bytes
 .../images/dir_lost_duplicated.gz                  |  Bin 0 -> 5347 bytes
 .../images/dir_lost_not_recover.gz                 |  Bin 0 -> 5396 bytes
 tests/ubifs_tools-tests/images/dir_many_dentry.gz  |  Bin 0 -> 5114 bytes
 tests/ubifs_tools-tests/images/empty_tnc.gz        |  Bin 0 -> 4954 bytes
 tests/ubifs_tools-tests/images/good.gz             |  Bin 0 -> 4960 bytes
 tests/ubifs_tools-tests/images/index_size.gz       |  Bin 0 -> 5070 bytes
 tests/ubifs_tools-tests/images/inode_data.gz       |  Bin 0 -> 5015 bytes
 tests/ubifs_tools-tests/images/inode_mode.gz       |  Bin 0 -> 5109 bytes
 tests/ubifs_tools-tests/images/inode_nlink.gz      |  Bin 0 -> 5110 bytes
 tests/ubifs_tools-tests/images/inode_size.gz       |  Bin 0 -> 5113 bytes
 tests/ubifs_tools-tests/images/inode_xcnt.gz       |  Bin 0 -> 5115 bytes
 tests/ubifs_tools-tests/images/journal_bud.gz      |  Bin 0 -> 5015 bytes
 tests/ubifs_tools-tests/images/journal_log.gz      |  Bin 0 -> 4927 bytes
 tests/ubifs_tools-tests/images/lpt_dirty.gz        |  Bin 0 -> 5056 bytes
 tests/ubifs_tools-tests/images/lpt_flags.gz        |  Bin 0 -> 5060 bytes
 tests/ubifs_tools-tests/images/lpt_free.gz         |  Bin 0 -> 5046 bytes
 tests/ubifs_tools-tests/images/lpt_pos.gz          |  Bin 0 -> 5070 bytes
 tests/ubifs_tools-tests/images/ltab_dirty.gz       |  Bin 0 -> 5104 bytes
 tests/ubifs_tools-tests/images/ltab_free.gz        |  Bin 0 -> 5072 bytes
 .../images/master_highest_inum.gz                  |  Bin 0 -> 4813 bytes
 tests/ubifs_tools-tests/images/master_lpt.gz       |  Bin 0 -> 4808 bytes
 tests/ubifs_tools-tests/images/master_tnc.gz       |  Bin 0 -> 4805 bytes
 .../ubifs_tools-tests/images/master_total_dead.gz  |  Bin 0 -> 4817 bytes
 .../ubifs_tools-tests/images/master_total_dirty.gz |  Bin 0 -> 4814 bytes
 .../ubifs_tools-tests/images/master_total_free.gz  |  Bin 0 -> 4813 bytes
 tests/ubifs_tools-tests/images/orphan_node.gz      |  Bin 0 -> 5379 bytes
 tests/ubifs_tools-tests/images/root_dir.gz         |  Bin 0 -> 5058 bytes
 tests/ubifs_tools-tests/images/sb_fanout.gz        |  Bin 0 -> 5031 bytes
 tests/ubifs_tools-tests/images/sb_fmt_version.gz   |  Bin 0 -> 5032 bytes
 tests/ubifs_tools-tests/images/sb_leb_size.gz      |  Bin 0 -> 5033 bytes
 tests/ubifs_tools-tests/images/sb_log_lebs.gz      |  Bin 0 -> 5031 bytes
 tests/ubifs_tools-tests/images/sb_min_io_size.gz   |  Bin 0 -> 5035 bytes
 .../ubifs_tools-tests/images/soft_link_data_len.gz |  Bin 0 -> 5112 bytes
 .../images/soft_link_inode_mode.gz                 |  Bin 0 -> 5121 bytes
 tests/ubifs_tools-tests/images/tnc_lv0_key.gz      |  Bin 0 -> 5118 bytes
 tests/ubifs_tools-tests/images/tnc_lv0_len.gz      |  Bin 0 -> 5130 bytes
 tests/ubifs_tools-tests/images/tnc_lv0_pos.gz      |  Bin 0 -> 5118 bytes
 tests/ubifs_tools-tests/images/tnc_noleaf_key.gz   |  Bin 0 -> 5140 bytes
 tests/ubifs_tools-tests/images/tnc_noleaf_len.gz   |  Bin 0 -> 5145 bytes
 tests/ubifs_tools-tests/images/tnc_noleaf_pos.gz   |  Bin 0 -> 5125 bytes
 tests/ubifs_tools-tests/images/xent_host.gz        |  Bin 0 -> 5108 bytes
 tests/ubifs_tools-tests/images/xentry_key.gz       |  Bin 0 -> 5085 bytes
 tests/ubifs_tools-tests/images/xentry_nlen.gz      |  Bin 0 -> 5115 bytes
 tests/ubifs_tools-tests/images/xentry_type.gz      |  Bin 0 -> 5113 bytes
 tests/ubifs_tools-tests/images/xinode_flags.gz     |  Bin 0 -> 5112 bytes
 tests/ubifs_tools-tests/images/xinode_key.gz       |  Bin 0 -> 5110 bytes
 tests/ubifs_tools-tests/images/xinode_mode.gz      |  Bin 0 -> 5112 bytes
 tests/ubifs_tools-tests/lib/common.sh.in           |  359 +++
 .../mkfs_tests/build_fs_from_dir.sh.in             |  174 ++
 tests/ubifs_tools-tests/ubifs_tools_run_all.sh.in  |   65 +
 ubifs-utils/Makemodule.am                          |  121 +-
 ubifs-utils/common/README                          |   14 +
 ubifs-utils/common/atomic.h                        |  133 +
 ubifs-utils/common/bitops.c                        |   37 +
 ubifs-utils/common/bitops.h                        |  152 +
 ubifs-utils/common/compiler_attributes.h           |   79 +
 ubifs-utils/{mkfs.ubifs => common}/compr.c         |   19 +-
 ubifs-utils/{mkfs.ubifs => common}/compr.h         |    8 -
 ubifs-utils/{mkfs.ubifs => common}/crc16.c         |    0
 ubifs-utils/{mkfs.ubifs => common}/crc16.h         |    0
 ubifs-utils/{mkfs.ubifs => common}/crypto.c        |    6 +-
 ubifs-utils/{mkfs.ubifs => common}/crypto.h        |    0
 ubifs-utils/common/defs.h                          |  123 +
 ubifs-utils/{mkfs.ubifs => common}/devtable.c      |   94 +-
 .../{mkfs.ubifs/mkfs.ubifs.h => common/devtable.h} |   85 +-
 ubifs-utils/{mkfs.ubifs => common}/fscrypt.c       |   29 +-
 ubifs-utils/{mkfs.ubifs => common}/fscrypt.h       |   19 +-
 .../{mkfs.ubifs => common}/hashtable/hashtable.c   |   10 +-
 .../{mkfs.ubifs => common}/hashtable/hashtable.h   |    0
 .../hashtable/hashtable_itr.c                      |    0
 .../hashtable/hashtable_itr.h                      |    0
 .../hashtable/hashtable_private.h                  |    0
 ubifs-utils/common/hexdump.c                       |  218 ++
 ubifs-utils/common/kmem.c                          |   64 +
 ubifs-utils/common/kmem.h                          |   56 +
 ubifs-utils/common/linux_err.h                     |   62 +
 ubifs-utils/common/linux_types.h                   |   92 +
 ubifs-utils/common/mutex.h                         |   18 +
 ubifs-utils/common/rwsem.h                         |   19 +
 ubifs-utils/{mkfs.ubifs => common}/sign.c          |  177 +-
 ubifs-utils/common/sign.h                          |   39 +
 ubifs-utils/common/sort.c                          |  274 ++
 ubifs-utils/common/sort.h                          |   20 +
 ubifs-utils/common/spinlock.h                      |   14 +
 ubifs-utils/fsck.ubifs/.gitignore                  |    1 +
 ubifs-utils/fsck.ubifs/README.txt                  |  388 +++
 ubifs-utils/fsck.ubifs/check_files.c               |  555 ++++
 ubifs-utils/fsck.ubifs/check_space.c               |  686 +++++
 ubifs-utils/fsck.ubifs/extract_files.c             | 1574 ++++++++++
 ubifs-utils/fsck.ubifs/fsck.ubifs.c                |  636 ++++
 ubifs-utils/fsck.ubifs/fsck.ubifs.h                |  393 +++
 ubifs-utils/fsck.ubifs/handle_disconnected.c       |  196 ++
 ubifs-utils/fsck.ubifs/load_fs.c                   |  261 ++
 ubifs-utils/fsck.ubifs/problem.c                   |  377 +++
 ubifs-utils/fsck.ubifs/rebuild_fs.c                | 1453 +++++++++
 ubifs-utils/libubifs/README                        |   30 +
 ubifs-utils/libubifs/auth.c                        |  175 ++
 ubifs-utils/libubifs/budget.c                      |  595 ++++
 ubifs-utils/libubifs/commit.c                      |  383 +++
 ubifs-utils/libubifs/debug.c                       | 1033 +++++++
 ubifs-utils/libubifs/debug.h                       |  173 ++
 ubifs-utils/libubifs/dir.c                         |  390 +++
 ubifs-utils/libubifs/find.c                        |  970 +++++++
 ubifs-utils/libubifs/gc.c                          | 1021 +++++++
 ubifs-utils/libubifs/io.c                          | 1088 +++++++
 ubifs-utils/libubifs/journal.c                     |  633 ++++
 ubifs-utils/libubifs/key.h                         |  492 ++++
 ubifs-utils/libubifs/log.c                         |  750 +++++
 ubifs-utils/libubifs/lprops.c                      |  864 ++++++
 ubifs-utils/libubifs/lpt.c                         | 2337 +++++++++++++++
 ubifs-utils/libubifs/lpt_commit.c                  | 1812 ++++++++++++
 ubifs-utils/libubifs/master.c                      |  489 ++++
 ubifs-utils/libubifs/misc.h                        |  225 ++
 ubifs-utils/libubifs/orphan.c                      |  644 ++++
 ubifs-utils/libubifs/recovery.c                    | 1404 +++++++++
 ubifs-utils/libubifs/replay.c                      | 1229 ++++++++
 ubifs-utils/libubifs/sb.c                          |  512 ++++
 ubifs-utils/libubifs/scan.c                        |  372 +++
 ubifs-utils/libubifs/super.c                       |  702 +++++
 ubifs-utils/libubifs/tnc.c                         | 3070 ++++++++++++++++++++
 ubifs-utils/libubifs/tnc_commit.c                  | 1117 +++++++
 ubifs-utils/libubifs/tnc_misc.c                    |  452 +++
 .../mtd => ubifs-utils/libubifs}/ubifs-media.h     |    0
 ubifs-utils/libubifs/ubifs.h                       | 1924 ++++++++++++
 ubifs-utils/mkfs.ubifs/README                      |    9 -
 ubifs-utils/mkfs.ubifs/defs.h                      |   90 -
 ubifs-utils/mkfs.ubifs/key.h                       |  222 --
 ubifs-utils/mkfs.ubifs/lpt.c                       |  590 ----
 ubifs-utils/mkfs.ubifs/lpt.h                       |   28 -
 ubifs-utils/mkfs.ubifs/mkfs.ubifs.c                |  643 ++--
 ubifs-utils/mkfs.ubifs/sign.h                      |   80 -
 ubifs-utils/mkfs.ubifs/ubifs.h                     |  471 ---
 161 files changed, 36227 insertions(+), 2244 deletions(-)
 create mode 100644 include/list.h
 rename {jffsX-utils => include}/rbtree.h (79%)
 create mode 100644 lib/list_sort.c
 rename {jffsX-utils => lib}/rbtree.c (90%)
 create mode 100644 tests/ubifs_tools-tests/Makemodule.am
 create mode 100644 tests/ubifs_tools-tests/README.txt
 create mode 100755 tests/ubifs_tools-tests/fsck_tests/authentication_refuse.sh.in
 create mode 100755 tests/ubifs_tools-tests/fsck_tests/cycle_corrupted_fsck_fault_inject.sh.in
 create mode 100755 tests/ubifs_tools-tests/fsck_tests/cycle_mount_fsck_check.sh.in
 create mode 100755 tests/ubifs_tools-tests/fsck_tests/cycle_powercut_mount_fsck.sh.in
 create mode 100755 tests/ubifs_tools-tests/fsck_tests/fsck_bad_image.sh.in
 create mode 100755 tests/ubifs_tools-tests/fsck_tests/powercut_fsck_mount.sh.in
 create mode 100755 tests/ubifs_tools-tests/fsck_tests/random_corrupted_fsck.sh.in
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
 create mode 100755 tests/ubifs_tools-tests/lib/common.sh.in
 create mode 100755 tests/ubifs_tools-tests/mkfs_tests/build_fs_from_dir.sh.in
 create mode 100755 tests/ubifs_tools-tests/ubifs_tools_run_all.sh.in
 create mode 100644 ubifs-utils/common/README
 create mode 100644 ubifs-utils/common/atomic.h
 create mode 100644 ubifs-utils/common/bitops.c
 create mode 100644 ubifs-utils/common/bitops.h
 create mode 100644 ubifs-utils/common/compiler_attributes.h
 rename ubifs-utils/{mkfs.ubifs => common}/compr.c (95%)
 rename ubifs-utils/{mkfs.ubifs => common}/compr.h (91%)
 rename ubifs-utils/{mkfs.ubifs => common}/crc16.c (100%)
 rename ubifs-utils/{mkfs.ubifs => common}/crc16.h (100%)
 rename ubifs-utils/{mkfs.ubifs => common}/crypto.c (98%)
 rename ubifs-utils/{mkfs.ubifs => common}/crypto.h (100%)
 create mode 100644 ubifs-utils/common/defs.h
 rename ubifs-utils/{mkfs.ubifs => common}/devtable.c (84%)
 rename ubifs-utils/{mkfs.ubifs/mkfs.ubifs.h => common/devtable.h} (53%)
 rename ubifs-utils/{mkfs.ubifs => common}/fscrypt.c (90%)
 rename ubifs-utils/{mkfs.ubifs => common}/fscrypt.h (91%)
 rename ubifs-utils/{mkfs.ubifs => common}/hashtable/hashtable.c (99%)
 rename ubifs-utils/{mkfs.ubifs => common}/hashtable/hashtable.h (100%)
 rename ubifs-utils/{mkfs.ubifs => common}/hashtable/hashtable_itr.c (100%)
 rename ubifs-utils/{mkfs.ubifs => common}/hashtable/hashtable_itr.h (100%)
 rename ubifs-utils/{mkfs.ubifs => common}/hashtable/hashtable_private.h (100%)
 create mode 100644 ubifs-utils/common/hexdump.c
 create mode 100644 ubifs-utils/common/kmem.c
 create mode 100644 ubifs-utils/common/kmem.h
 create mode 100644 ubifs-utils/common/linux_err.h
 create mode 100644 ubifs-utils/common/linux_types.h
 create mode 100644 ubifs-utils/common/mutex.h
 create mode 100644 ubifs-utils/common/rwsem.h
 rename ubifs-utils/{mkfs.ubifs => common}/sign.c (66%)
 create mode 100644 ubifs-utils/common/sign.h
 create mode 100644 ubifs-utils/common/sort.c
 create mode 100644 ubifs-utils/common/sort.h
 create mode 100644 ubifs-utils/common/spinlock.h
 create mode 100644 ubifs-utils/fsck.ubifs/.gitignore
 create mode 100644 ubifs-utils/fsck.ubifs/README.txt
 create mode 100644 ubifs-utils/fsck.ubifs/check_files.c
 create mode 100644 ubifs-utils/fsck.ubifs/check_space.c
 create mode 100644 ubifs-utils/fsck.ubifs/extract_files.c
 create mode 100644 ubifs-utils/fsck.ubifs/fsck.ubifs.c
 create mode 100644 ubifs-utils/fsck.ubifs/fsck.ubifs.h
 create mode 100644 ubifs-utils/fsck.ubifs/handle_disconnected.c
 create mode 100644 ubifs-utils/fsck.ubifs/load_fs.c
 create mode 100644 ubifs-utils/fsck.ubifs/problem.c
 create mode 100644 ubifs-utils/fsck.ubifs/rebuild_fs.c
 create mode 100644 ubifs-utils/libubifs/README
 create mode 100644 ubifs-utils/libubifs/auth.c
 create mode 100644 ubifs-utils/libubifs/budget.c
 create mode 100644 ubifs-utils/libubifs/commit.c
 create mode 100644 ubifs-utils/libubifs/debug.c
 create mode 100644 ubifs-utils/libubifs/debug.h
 create mode 100644 ubifs-utils/libubifs/dir.c
 create mode 100644 ubifs-utils/libubifs/find.c
 create mode 100644 ubifs-utils/libubifs/gc.c
 create mode 100644 ubifs-utils/libubifs/io.c
 create mode 100644 ubifs-utils/libubifs/journal.c
 create mode 100644 ubifs-utils/libubifs/key.h
 create mode 100644 ubifs-utils/libubifs/log.c
 create mode 100644 ubifs-utils/libubifs/lprops.c
 create mode 100644 ubifs-utils/libubifs/lpt.c
 create mode 100644 ubifs-utils/libubifs/lpt_commit.c
 create mode 100644 ubifs-utils/libubifs/master.c
 create mode 100644 ubifs-utils/libubifs/misc.h
 create mode 100644 ubifs-utils/libubifs/orphan.c
 create mode 100644 ubifs-utils/libubifs/recovery.c
 create mode 100644 ubifs-utils/libubifs/replay.c
 create mode 100644 ubifs-utils/libubifs/sb.c
 create mode 100644 ubifs-utils/libubifs/scan.c
 create mode 100644 ubifs-utils/libubifs/super.c
 create mode 100644 ubifs-utils/libubifs/tnc.c
 create mode 100644 ubifs-utils/libubifs/tnc_commit.c
 create mode 100644 ubifs-utils/libubifs/tnc_misc.c
 rename {include/mtd => ubifs-utils/libubifs}/ubifs-media.h (100%)
 create mode 100644 ubifs-utils/libubifs/ubifs.h
 delete mode 100644 ubifs-utils/mkfs.ubifs/README
 delete mode 100644 ubifs-utils/mkfs.ubifs/defs.h
 delete mode 100644 ubifs-utils/mkfs.ubifs/key.h
 delete mode 100644 ubifs-utils/mkfs.ubifs/lpt.c
 delete mode 100644 ubifs-utils/mkfs.ubifs/lpt.h
 delete mode 100644 ubifs-utils/mkfs.ubifs/sign.h
 delete mode 100644 ubifs-utils/mkfs.ubifs/ubifs.h

-- 
2.13.6


