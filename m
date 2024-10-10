Return-Path: <linux-kernel+bounces-358225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A73997BA6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6816A283986
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 04:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4C3192D93;
	Thu, 10 Oct 2024 04:09:02 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11A31925A2
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728533342; cv=none; b=N+5H6Tw08JPLRWg7wLQT8LmMmuOfYynqDb8y4Ou6nEtpXz06b+QivG//wvQ36w+pWfv5lP+7JOrUqgEUAeRXIiDdrToZzxtP8inn0WUyLaN06P0PTPvCeHFxEt+gPqP4MyAyeHqRnauHkuJ7YHZooPozfpWZSu03pp9U9TNY880=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728533342; c=relaxed/simple;
	bh=N+pyFf78H/AqcS+gzEpmdQub5nK33PwlUOdXF1CpalM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=osa4f741rRe9wxtJTyIIDdV1kZ3PGaRnZyGiV4W+VDtNi2gdL+RI3HIqS4KXdXw1t7T65S/rAsCzEUI5ZP0YrrDVGLZMolJDlKuFh/IjpOe1Ymo4eYAet9HWUQW+i4nHoBT5a9kNlJmXL6p+HKo3W8h9pkIM+AYBTAzGHpr2u6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49A3jCgM012573;
	Thu, 10 Oct 2024 04:08:39 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 422tp45b1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 10 Oct 2024 04:08:39 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Oct 2024 21:08:38 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Wed, 9 Oct 2024 21:08:36 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+66c146268dc88f4341fd@syzkaller.appspotmail.com>
CC: <jlbec@evilplan.org>, <joseph.qi@linux.alibaba.com>,
        <linux-kernel@vger.kernel.org>, <mark@fasheh.com>,
        <ocfs2-devel@lists.linux.dev>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [ocfs2?] KASAN: use-after-free Read in __ocfs2_find_path
Date: Thu, 10 Oct 2024 12:08:35 +0800
Message-ID: <20241010040835.1648107-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6706e8cd.050a0220.67064.0053.GAE@google.com>
References: <6706e8cd.050a0220.67064.0053.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=XPtiShhE c=1 sm=1 tr=0 ts=67075347 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=DAUX931o1VcA:10 a=2ZFrcfy9enmZ0iwdtswA:9
X-Proofpoint-ORIG-GUID: 5S04E4MbfOFA_rkQYAifu3mSzYrn9a2E
X-Proofpoint-GUID: 5S04E4MbfOFA_rkQYAifu3mSzYrn9a2E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_23,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=671 malwarescore=0
 suspectscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2410100026

Extent tree depth is never bigger than 256, because the high 8 bits cannot be used.

#syz test

diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
index f7672472fa82..2ca546af9191 100644
--- a/fs/ocfs2/extent_map.c
+++ b/fs/ocfs2/extent_map.c
@@ -415,6 +415,15 @@ static int ocfs2_get_clusters_nocache(struct inode *inode,
 	tree_height = le16_to_cpu(el->l_tree_depth);
 
 	if (tree_height > 0) {
+		if (tree_height > 256) {
+			ocfs2_error(inode->i_sb,
+				    "Inode %lu has too big tree depth %d in leaf block %llu\n",
+				    inode->i_ino,
+				    tree_height,
+				    (unsigned long long)di_bh->b_blocknr);
+			ret = -EROFS;
+			goto out;
+		}
 		ret = ocfs2_find_leaf(INODE_CACHE(inode), el, v_cluster,
 				      &eb_bh);
 		if (ret) {

