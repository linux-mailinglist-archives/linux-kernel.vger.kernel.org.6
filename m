Return-Path: <linux-kernel+bounces-425171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2459DBE79
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 02:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 472FB164B5E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 01:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA42D1BDDF;
	Fri, 29 Nov 2024 01:52:21 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38461F92A
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 01:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732845141; cv=none; b=jD7UE56XoIBSKmXvzLXGGxg8YzwH/anOOUXH5fkZds58OxIBxtpIIScJkeGZrrAwnMuUBQ/dQpY4XJ9dLCj4X1VVIzOWCUzO1dIHlTp+e8V2rnXfY9auzAp2W6bzRc+upv5RGLDUn4FvIv8k3bUCA8CwklKPIBnCgq9R03zyzV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732845141; c=relaxed/simple;
	bh=TMh3CIcQN2WYbKqGaBmhhlQhFXCl0pIw2GsKAVr0EtE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M1U/846ad38lFl6hO6pcTxJYMl+om79yE6Q5H361Spi9NvVQhDUja/hPWr8jp/tFvDhYlJiRz5U05UU7y1yLF8pRBELJOXJx4WzsPa5dFPHy+IT1ATlwqc9x26+RPxeIxvN3sUHjMGRuxoaNQgY7ecwmJP4oGOLvLirM7yjCtlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AT1ptD3023424;
	Fri, 29 Nov 2024 01:51:55 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43671asmpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 29 Nov 2024 01:51:54 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Thu, 28 Nov 2024 17:51:53 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Thu, 28 Nov 2024 17:51:52 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+99491d74a9931659cf48@syzkaller.appspotmail.com>
CC: <jfs-discussion@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <shaggy@kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in dtSplitRoot (2)
Date: Fri, 29 Nov 2024 09:51:51 +0800
Message-ID: <20241129015151.595085-1-lizhi.xu@windriver.com>
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
X-Proofpoint-ORIG-GUID: 4QdDx8t6nd9agFYw3vw9XzV8y3REYqTI
X-Authority-Analysis: v=2.4 cv=TIS/S0la c=1 sm=1 tr=0 ts=67491e3a cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=VlfZXiiP6vEA:10 a=DYonKS4zpEWGQCKFvHwA:9
X-Proofpoint-GUID: 4QdDx8t6nd9agFYw3vw9XzV8y3REYqTI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-28_20,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=717 adultscore=0 clxscore=1011
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2411290013

The index of the slot maybe out of bound, add a check for it.

#syz test

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

