Return-Path: <linux-kernel+bounces-294933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F8E959468
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 08:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 709562855BB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 06:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1268D16D4D6;
	Wed, 21 Aug 2024 06:15:21 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F78208A9
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 06:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724220920; cv=none; b=ZnSu3SlwjuSkmjv8T+xZ4FdiTr97LHV5gkxrLNTAORB+OfAur+LjPlYaMIjnV7dF+s8nhY2lVuW3id81VQUhPRFCP/lKY6jdDf41aRAjgA2Bpu0r0Qj+pqLldtYQMoKs2yg/R+KQPzGXtcClawLC0x3P/mGYd3FLmP3SoJsRr/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724220920; c=relaxed/simple;
	bh=l6RgAg+6ZeJEwjWHPBKA8qfgAIqhdCyu7/TRWnMMufU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SK+f8WhsCOwOUh++zWzIofmJ1dGS2TbSlYI1TX/TL9ctp1qKiwRj0eP6pgy8+yR7moP1mi8zhpFdYH2CJpn8radI2cHpuYILWgf2NIMQTXruY9N6+UYJsyW++FefMrHpivpt+KT47ezkIcvQreKEGEzF52Ki0P5N+YJIFfKB5ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47L4OTJR001709;
	Wed, 21 Aug 2024 06:14:55 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 412ju6usb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 21 Aug 2024 06:14:55 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 23:14:53 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 23:14:51 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <lizhi.xu@windriver.com>
CC: <heming.zhao@suse.com>, <jlbec@evilplan.org>,
        <joseph.qi@linux.alibaba.com>, <linux-kernel@vger.kernel.org>,
        <mark@fasheh.com>, <ocfs2-devel@lists.linux.dev>,
        <syzbot+ab134185af9ef88dfed5@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: [PATCH V4 2/2] ocfs2: Fix possible null-ptr-deref in ocfs2_set_buffer_uptodate
Date: Wed, 21 Aug 2024 14:14:50 +0800
Message-ID: <20240821061450.3478602-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240821055546.3254888-1-lizhi.xu@windriver.com>
References: <20240821055546.3254888-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: gjYC9SLvYHY8bYDyLcjO7DUYl5-NFTtO
X-Authority-Analysis: v=2.4 cv=VdWlP0p9 c=1 sm=1 tr=0 ts=66c585df cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=yoJbH4e0A30A:10 a=iox4zFpeAAAA:8 a=t7CeM3EgAAAA:8 a=2XkvJDdhvVXYFy9qs80A:9 a=WzC6qhA0u3u7Ye7llzcV:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: gjYC9SLvYHY8bYDyLcjO7DUYl5-NFTtO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_06,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 spamscore=0 malwarescore=0 impostorscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=912 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2407110000 definitions=main-2408210044

When doing cleanup, if flags without OCFS2_BH_READAHEAD, it may trigger
NULL pointer dereference in the following ocfs2_set_buffer_uptodate() if
bh is NULL.

Reported-and-suggested-by: Heming Zhao <heming.zhao@suse.com>
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
V3 -> V4: Update comments and subject

 fs/ocfs2/buffer_head_io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/buffer_head_io.c b/fs/ocfs2/buffer_head_io.c
index e62c7e1de4eb..8f714406528d 100644
--- a/fs/ocfs2/buffer_head_io.c
+++ b/fs/ocfs2/buffer_head_io.c
@@ -388,7 +388,8 @@ int ocfs2_read_blocks(struct ocfs2_caching_info *ci, u64 block, int nr,
 		/* Always set the buffer in the cache, even if it was
 		 * a forced read, or read-ahead which hasn't yet
 		 * completed. */
-		ocfs2_set_buffer_uptodate(ci, bh);
+		if (bh)
+			ocfs2_set_buffer_uptodate(ci, bh);
 	}
 	ocfs2_metadata_cache_io_unlock(ci);
 
-- 
2.43.0


