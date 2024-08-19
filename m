Return-Path: <linux-kernel+bounces-291365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A9995613B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 04:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 532691C210A6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 02:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017F329D0C;
	Mon, 19 Aug 2024 02:51:40 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33271BDC8
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 02:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724035899; cv=none; b=IbCzSI4GFdwmtxaXzWefHFCDQfhPK5g39OwH0ndwztG4WRbtKNugAV/xtG/4/BiPe0a6mvHxGta4u7gjYf5KjAzCWXNTpnkGtUXGPnJilyV8vAcddJT6ldzK4q+ftzgVcp72W4RXx0tFs/QcbSp6zmZDG9IBD8uEman8rSaA4mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724035899; c=relaxed/simple;
	bh=MphJWY7xAAzYAOlHBN+3IDylWkzUrc1HBNy+kvyO6Gg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZnpENpkPvM8GorCQ/sk+gzJrCkaeZJ3PGw18zxVBc+opqrFEbsYvrwYNBPdFwUHSqot8RKjXFOKMOHj+cJdrad6+XKooke2q63LI8qQzxHLFofN7bmu0oQGIEQu06XeByJZ4Mg10tEcIMeOiExc1CIWaHNk596KTv23ZvbzRZ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47J2oG11005096;
	Sun, 18 Aug 2024 19:51:16 -0700
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 412q5415vc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 18 Aug 2024 19:51:15 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 18 Aug 2024 19:51:15 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Sun, 18 Aug 2024 19:51:13 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+ab134185af9ef88dfed5@syzkaller.appspotmail.com>
CC: <jlbec@evilplan.org>, <joseph.qi@linux.alibaba.com>,
        <linux-kernel@vger.kernel.org>, <mark@fasheh.com>,
        <ocfs2-devel@lists.linux.dev>, <syzkaller-bugs@googlegroups.com>
Subject: [PATCH] ocfs2: remove unreasonable unlock
Date: Mon, 19 Aug 2024 10:51:12 +0800
Message-ID: <20240819025112.2505463-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000007541d9061ff83615@google.com>
References: <0000000000007541d9061ff83615@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: jzCXM0XNVvJZ3nJtd9lJGbqoee7L3OYB
X-Proofpoint-ORIG-GUID: jzCXM0XNVvJZ3nJtd9lJGbqoee7L3OYB
X-Authority-Analysis: v=2.4 cv=b+3g4cGx c=1 sm=1 tr=0 ts=66c2b323 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=yoJbH4e0A30A:10 a=hSkVLCK3AAAA:8 a=edf1wS77AAAA:8 a=t7CeM3EgAAAA:8 a=HuAlKsfkTx2sNoB5ci0A:9 a=cQPPKAXgyycSBL8etih5:22
 a=DcSpbTIhAlouE1Uv7lRv:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-18_24,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 phishscore=0 mlxlogscore=933 lowpriorityscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2407110000 definitions=main-2408190019

There was a lock release before exiting, so remove the unreasonable unlock.

Reported-and-tested-by: syzbot+ab134185af9ef88dfed5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ab134185af9ef88dfed5
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 fs/ocfs2/buffer_head_io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ocfs2/buffer_head_io.c b/fs/ocfs2/buffer_head_io.c
index cdb9b9bdea1f..e62c7e1de4eb 100644
--- a/fs/ocfs2/buffer_head_io.c
+++ b/fs/ocfs2/buffer_head_io.c
@@ -235,7 +235,6 @@ int ocfs2_read_blocks(struct ocfs2_caching_info *ci, u64 block, int nr,
 		if (bhs[i] == NULL) {
 			bhs[i] = sb_getblk(sb, block++);
 			if (bhs[i] == NULL) {
-				ocfs2_metadata_cache_io_unlock(ci);
 				status = -ENOMEM;
 				mlog_errno(status);
 				/* Don't forget to put previous bh! */
-- 
2.43.0


