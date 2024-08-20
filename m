Return-Path: <linux-kernel+bounces-293460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A91ED957FF7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36D7C281864
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 07:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E1818990F;
	Tue, 20 Aug 2024 07:38:10 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2B9188CCB
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 07:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724139489; cv=none; b=I2Mvj5Dbg0bN/bATkfKHZpk2MWwPCbJS4dnFLRwEzFJAVmBTQK0hESQc0DVta/Xdt4skr+Z/r/jirCbXZt4AjX5YemSOSMB1Dd2tqjDJDx0TbYHRVLi9HC77J8QxeWYCG2h1NWo8X/LeAZ/IXdwAg9KCBRfYWCsgYoBi8drpX5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724139489; c=relaxed/simple;
	bh=7SL4D1YiAegxzV6YQeyoI2zwQg1UX5e6ZkgK91ISTm8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fyhwvVsGKHdswZWNaxrNq6eeaMLC3MVGdPYEVxvyqR2pD6UpTUN2dp5wHgl/ATBWWIZgpWNgWlEN/IhDvRPHqfal4JivFiaD50sqXXMdwRD2GHhWnB/T88gxcAJVpD6acYGI8e6+vvqhO4Qgpc18GfMCksyY66aJQ3nQenLz4PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47K5sQlq007093;
	Tue, 20 Aug 2024 07:37:50 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 412j0xjp82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 20 Aug 2024 07:37:49 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 00:37:42 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 00:37:39 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <heming.zhao@suse.com>
CC: <jlbec@evilplan.org>, <joseph.qi@linux.alibaba.com>,
        <linux-kernel@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <mark@fasheh.com>, <ocfs2-devel@lists.linux.dev>,
        <syzbot+ab134185af9ef88dfed5@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: [PATCH V3] ocfs2: Fix uaf in ocfs2_set_buffer_uptodate
Date: Tue, 20 Aug 2024 15:37:39 +0800
Message-ID: <20240820073739.1289567-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2d6499d6-fd03-43d8-9595-5babfd82481d@suse.com>
References: <2d6499d6-fd03-43d8-9595-5babfd82481d@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=PszBbBM3 c=1 sm=1 tr=0 ts=66c447ce cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=yoJbH4e0A30A:10 a=iox4zFpeAAAA:8 a=t7CeM3EgAAAA:8 a=PhkAcTI6xfMDmhtK1YkA:9 a=zZCYzV9kfG8A:10 a=WzC6qhA0u3u7Ye7llzcV:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: aOGk_9rjrcZ9CmgHDQ7yM5qIVK2V9WMc
X-Proofpoint-GUID: aOGk_9rjrcZ9CmgHDQ7yM5qIVK2V9WMc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=820 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2407110000 definitions=main-2408200055

In the for-loop after the 'read_failure' label, the condition
'(bh == NULL) && flags includes OCFS2_BH_READAHEAD' is missing.
When this contidion is true, this for-loop will call ocfs2_set_buffer
_uptodate(ci, bh), which then triggers a NULL pointer access error.

Reported-and-suggested-by: Heming Zhao <heming.zhao@suse.com>
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
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


