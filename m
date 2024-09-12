Return-Path: <linux-kernel+bounces-326018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77383976147
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EAFB1F220A2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 06:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA89D18BB82;
	Thu, 12 Sep 2024 06:17:16 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3212D7B8
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 06:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726121836; cv=none; b=A1QcV6T7tAXQrZ0GiW/EbB3CQIwEtbYIM9h5a+CfsMJn69kozcsLr0Rz2K9K/PnqW+QowFaQSIQEFtJE1TaoQylX8eGRdvYEBpPNgn/RoQAeZcuThoFjuYDdqqBXfBCQRycNTC5o/zcNsdLogkrFR2O8heD5dm79hRKOnCwpKf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726121836; c=relaxed/simple;
	bh=duHnK5RYV1yUWqZgAW97ya6hTIbY6obaSDBWx/IwYJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SQf1CGrFRgkI4PBN5eSHG3cv2DKzJYdsBS5qc51JC9qI0Z9IH5qJVgzcq4gPmDqPXOiRGG0DnKgoJVdE8iUoZ3LwuOWKoRViJwcmXagebwCpReplngcZT9yCJCsHgUKL8RQKHPet3F+Wn6qr1USFMYIfFB9/P1ilq1bGhI/qLi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a0402ee870ce11efa216b1d71e6e1362-20240912
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:c8ceb9bd-ac5c-4bfc-8809-01bfcc939b2d,IP:20,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:40
X-CID-INFO: VERSION:1.1.38,REQID:c8ceb9bd-ac5c-4bfc-8809-01bfcc939b2d,IP:20,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:40
X-CID-META: VersionHash:82c5f88,CLOUDID:4941cee16439ebb511a0d559275aaef4,BulkI
	D:240912141052OPBA8B50,BulkQuantity:1,Recheck:0,SF:66|38|25|17|19|43|74|20
	0|102,TC:nil,Content:0,EDM:5,IP:-2,URL:11|1,File:nil,RT:nil,Bulk:40,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,
	TF_CID_SPAM_FAS
X-UUID: a0402ee870ce11efa216b1d71e6e1362-20240912
X-User: zhaomengmeng@kylinos.cn
Received: from localhost.localdomain [(123.149.251.227)] by mailgw.kylinos.cn
	(envelope-from <zhaomengmeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 133137105; Thu, 12 Sep 2024 14:17:02 +0800
From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
To: jack@suse.com,
	zhaomzhao@126.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v1] udf: return EIO when ftrunctate access beyond end of device
Date: Thu, 12 Sep 2024 14:16:52 +0800
Message-ID: <20240912061652.980443-1-zhaomengmeng@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reports a udf slab-out-of-bounds as blow:

loop0: rw=0, sector=117, nr_sectors = 1 limit=0
syz-executor135: attempt to access beyond end of device
loop0: rw=0, sector=117, nr_sectors = 1 limit=0
==================================================================
BUG: KASAN: slab-out-of-bounds in udf_get_filelongad+0x167/0x1b0 fs/udf/directory.c:526
Read of size 4 at addr ffff888012113f30 by task syz-executor135/5106

CPU: 0 UID: 0 PID: 5106 Comm: syz-executor135 Not tainted 6.11.0-rc6-syzkaller-00019-g67784a74e258 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 udf_get_filelongad+0x167/0x1b0 fs/udf/directory.c:526
 udf_current_aext+0x435/0x9e0 fs/udf/inode.c:2235
 udf_next_aext+0x8c/0x4a0 fs/udf/inode.c:2171
 udf_extend_file fs/udf/inode.c:677 [inline]
 udf_setsize+0xa8a/0x1280 fs/udf/inode.c:1265
 udf_setattr+0x3c7/0x5d0 fs/udf/file.c:236
 notify_change+0xbca/0xe90 fs/attr.c:503
 do_truncate fs/open.c:65 [inline]
 do_ftruncate+0x46b/0x590 fs/open.c:181
 do_sys_ftruncate fs/open.c:199 [inline]
 __do_sys_ftruncate fs/open.c:207 [inline]
 __se_sys_ftruncate fs/open.c:205 [inline]
 __x64_sys_ftruncate+0x95/0xf0 fs/open.c:205
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f13639ac249
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff0302d508 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f13639ac249
RDX: 00007f13639ac249 RSI: 0000008002007ffb RDI: 0000000000000005
RBP: 00000000000013f1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff0302d550
R13: 00007fff0302d630 R14: 431bde82d7b634db R15: 00007f13639f501d

The root cause is:
  udf_extend_file
    ->inode_bmap       --> etype == -1 and epos.bh == NULL
     -> udf_next_aext  --> return -1 because reading block failed
       -> sb_read --> return NULL because access beyond end of device

Under this, etype == -1, epos.bh == NULL, epos.offset is 24, which is
less than sizeof(struct extentedFileEntry), aka 216. As a result,
it skipped the epos.bh check and goes into udf_next_aext(). Since the
epos.offset is illegal, udf_get_filelongad's first argument ptr,
	ptr = iinfo->i_data + epos->offset -
		udf_file_entry_alloc_offset(inode) +
		iinfo->i_lenEAttr;
points to some buffer before iinfo->i_data, which triggeres KASAN's
warnning.

The fix is to add addition check on etype, epos.bh and epos.offset,
when ftruncate accesses beyound end of device, just return EIO and failed.

Reported-by: syzbot+7a4842f0b1801230a989@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7a4842f0b1801230a989
Tested-by: syzbot+7a4842f0b1801230a989@syzkaller.appspotmail.com
Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
---
 fs/udf/inode.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 4726a4d014b6..66f73f728dae 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -660,6 +660,16 @@ static int udf_extend_file(struct inode *inode, loff_t newsize)
 	udf_discard_prealloc(inode);
 
 	etype = inode_bmap(inode, first_block, &epos, &eloc, &elen, &offset);
+
+	/*
+	 * when ftruncate attempt to access beyond end of device, sb_read will
+	 * fail with epos.bh be null and return etype be -1, just return EIO.
+	 */
+	if (etype == -1 && !epos.bh && epos.offset == sizeof(struct allocExtDesc)) {
+		err = -EIO;
+		goto out;
+	}
+
 	within_last_ext = (etype != -1);
 	/* We don't expect extents past EOF... */
 	WARN_ON_ONCE(within_last_ext &&
-- 
2.43.0


