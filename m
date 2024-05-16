Return-Path: <linux-kernel+bounces-181273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2898C79CD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 142C01F22D65
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB541514D9;
	Thu, 16 May 2024 15:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fGkP5hdq"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF49D14E2F4
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715874613; cv=none; b=CIBOk+ppbmU2Wu/lXqY3vaOl1P8rTielnFYi0ATy+wPZQzrfgVBDa02S/uhEp34tl8puRjD4YHXmAHAOqQOAX5o+HkgRyQc0HPz2z9Pjx9Y5duPs4SDlGCMGFlgw+RxoUKxSaTS2T0V1k81Hna9PVfOP9PshJnuhAYJWMlws/Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715874613; c=relaxed/simple;
	bh=H+duG1DqueQNaiJfOJ95nAuqvRAmaRUvvu+Ramh+ZLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=oH8QxpGxyRjO2PYUnpmttLlQUbmbwni0ZoUxDLsTJ/UihVNNvssEdyAXmTM8wUPmXEDePh6M3AmCJs8mcGyhH5pKKBY3HKRdnxsZtE9s44Vm7v/bUa7OOiY5gHxoeYNyz4kM7evH+tNkKEMdK3CHw1U2LpD4zgAcvByDJvKEjXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fGkP5hdq; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44GEOaWp017939;
	Thu, 16 May 2024 15:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=2SJYwRvLgM1p+YuMewAtYH0X+LoPfzoPVQLGePMH2jw=;
 b=fGkP5hdq+qd7He736fxqmSqpcbmNzWZeu5w5ojNbP6O2qDZsVbCcxjk9rPntVUBM5aQB
 JWcYaP8PgAb94prS29FMneD3IJBSwjkxdKNiTM7MwM4CH3w9opTGHcLw3fYVC83aCSDJ
 GNV6gLOyJX6X0W6yzIm6rgBJZgwf5tDx3nHpLRg2n0qMbq8vwmdI77ZHDyzyaim/AxAU
 bo5HCVpa9yteGWaHdSbPb8LHZxR5SnVahKPZQSDi4TN1SHBZlzrKOJeCRU6dPYrzftmn
 KrQStvefzRnG/GNNoo8f7P3lZjRLBZMFAYy+FQouZbLnWNJiqh2KBFja7q54WR0SmQP8 rg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3t4ffryd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 May 2024 15:49:53 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44GF7l4C038472;
	Thu, 16 May 2024 15:44:53 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3y24q05rcf-1;
	Thu, 16 May 2024 15:44:52 +0000
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH] sched: Fix spelling error in comment
Date: Thu, 16 May 2024 17:44:49 +0200
Message-Id: <20240516154449.1154423-1-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=934 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405160111
X-Proofpoint-ORIG-GUID: 3CGYJ_gbo_9KH80SOPym7z_0FaUaA_gZ
X-Proofpoint-GUID: 3CGYJ_gbo_9KH80SOPym7z_0FaUaA_gZ

Fix minor spelling error in comment.

Fixes: cfb837e84331 ("mm: document memalloc_noreclaim_save() and memalloc_pin_save()")
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 include/linux/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3c2abbc587b49..61a6019de06c6 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1633,7 +1633,7 @@ extern struct pid *cad_pid;
 #define PF_NOFREEZE		0x00008000	/* This thread should not be frozen */
 #define PF__HOLE__00010000	0x00010000
 #define PF_KSWAPD		0x00020000	/* I am kswapd */
-#define PF_MEMALLOC_NOFS	0x00040000	/* All allocations inherit GFP_NOFS. See memalloc_nfs_save() */
+#define PF_MEMALLOC_NOFS	0x00040000	/* All allocations inherit GFP_NOFS. See memalloc_nofs_save() */
 #define PF_MEMALLOC_NOIO	0x00080000	/* All allocations inherit GFP_NOIO. See memalloc_noio_save() */
 #define PF_LOCAL_THROTTLE	0x00100000	/* Throttle writes only against the bdi I write to,
 						 * I am cleaning dirty pages from some other bdi. */
-- 
2.39.3


