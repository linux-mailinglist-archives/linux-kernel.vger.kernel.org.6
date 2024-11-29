Return-Path: <linux-kernel+bounces-425479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 500359DC2A9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 12:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5506B2184E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 11:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B88199253;
	Fri, 29 Nov 2024 11:16:54 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8421586C8
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 11:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732879014; cv=none; b=WKNRy/irhTFYEkXx6LnNvVoO06li37CiZIrwx85a7QxQhOP/qpzHCBfndkE8nyMktxIGMuc4hAMxRcIMYdGHsemF9Ropuog0v1BsWaGFJWphoHXuNx7QqS7qbjoa+AcoVAmVuDt+/TPPlATN0SF2DQnBQbRGjhtr9NQAOIQSgiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732879014; c=relaxed/simple;
	bh=1N2P6P9/3ihhJcs223VrfvQtz5QrqXyablfImObPOPQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b9f44DQukvaw1zmrqnK3dGy+yX8fDtZDWXdENAwkRsIDeTT3O/0ByZeX86wOu6Ef+iAM3u6b9eeKi7nj+jKFr4TPWWDKK0YhOOsTTxwmHRKgq9aQKp84TBtZ5kfAc+520bqxzWxwVTiv8YfObcqGg1HWmLTpS7J0Q/NUZxlUV0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AT64xrE029754;
	Fri, 29 Nov 2024 11:16:33 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43671at1sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 29 Nov 2024 11:16:32 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Fri, 29 Nov 2024 03:16:31 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Fri, 29 Nov 2024 03:16:30 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+99491d74a9931659cf48@syzkaller.appspotmail.com>
CC: <jfs-discussion@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <shaggy@kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: [PATCH] jfs: fix a oob in dtSplitRoot
Date: Fri, 29 Nov 2024 19:16:29 +0800
Message-ID: <20241129111629.91992-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6748fb32.050a0220.253251.0098.GAE@google.com>
References: <6748fb32.050a0220.253251.0098.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: X_Is-F3dEeyAYzk0nFqROqXNvzz0EUOc
X-Authority-Analysis: v=2.4 cv=TIS/S0la c=1 sm=1 tr=0 ts=6749a290 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=VlfZXiiP6vEA:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=EcIOMTnjEzzh_necsvcA:9 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: X_Is-F3dEeyAYzk0nFqROqXNvzz0EUOc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-29_10,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=477 adultscore=0 clxscore=1011
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2411290092

syzbot report a array-index-out-of-bounds in dtSplitRoot. [1]

The second index value of the parent inode of the symbolic link is 4294967168.
When it is assigned to the stbl of type s8, an overflow value of -128 occurs,
which triggers oob.

To avoid this issue, add a check for the index of the slot before using it.

[1]
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_dtree.c:1997:37
index -128 is out of range for type 'struct dtslot[128]'
CPU: 1 UID: 0 PID: 5842 Comm: syz-executor268 Not tainted 6.12.0-syzkaller-09073-g9f16d5e6f220 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_out_of_bounds+0x121/0x150 lib/ubsan.c:429
 dtSplitRoot+0xc9c/0x1930 fs/jfs/jfs_dtree.c:1997
 dtSplitUp fs/jfs/jfs_dtree.c:992 [inline]
 dtInsert+0x12cd/0x6c10 fs/jfs/jfs_dtree.c:870
 jfs_symlink+0x827/0x10f0 fs/jfs/namei.c:1020
 vfs_symlink+0x137/0x2e0 fs/namei.c:4669
 do_symlinkat+0x222/0x3a0 fs/namei.c:4695
 __do_sys_symlink fs/namei.c:4716 [inline]
 __se_sys_symlink fs/namei.c:4714 [inline]
 __x64_sys_symlink+0x7a/0x90 fs/namei.c:4714
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Reported-and-tested-by: syzbot+99491d74a9931659cf48@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=99491d74a9931659cf48
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 fs/jfs/jfs_dtree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 8f85177f284b..71463ad751c2 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -1994,6 +1994,9 @@ static int dtSplitRoot(tid_t tid,
 
 		stbl = DT_GETSTBL(rp);
 		for (n = 0; n < rp->header.nextindex; n++) {
+			if (stbl[n] >= ARRAY_SIZE(rp->slot))
+				continue;
+
 			ldtentry = (struct ldtentry *) & rp->slot[stbl[n]];
 			modify_index(tid, ip, le32_to_cpu(ldtentry->index),
 				     rbn, n, &mp, &lblock);
-- 
2.43.0


