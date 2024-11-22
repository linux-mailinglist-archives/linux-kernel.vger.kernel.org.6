Return-Path: <linux-kernel+bounces-417641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF7D9D56FE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 02:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96E8E1F21D22
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 01:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD57C147;
	Fri, 22 Nov 2024 01:14:44 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473842594
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 01:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732238084; cv=none; b=ccFRN2ZZJIFjZKKW9kz8Q8IfXWosWlljbyJdqHdrH8G/qFICAE9UuqU5+zfEpP5O4warxz+il+tPcQsrgJtJJ3UYymRsG/9GEjMbU8PpqJS8hoa/asUZYWrfsY03Tlvy54qPkVtHZIwUFQO+EI1v98aEer9LB3Ti+2zDq6GoiqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732238084; c=relaxed/simple;
	bh=Xbs54TMZ0mmxv3WGxZpKChFIzaH1sl6YrUkhYZsJB0U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qyj7LJLKFE3oDbIoTTpPvHpXV+/FQwnpSpqhNw4snvIPeEvm8wmQlcut/hcLZL37R0+UDc2qko45TRKihBicsXT0MlUpcukNOkDyOvYWyxkecRnlnHasoR8Wkw8db43eMiGhTrZO3FelTzlzPytkfXPBxp7qNGZqQBLILYXVNUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM0BfnI028821;
	Fri, 22 Nov 2024 01:14:39 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xgm0pcu3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 22 Nov 2024 01:14:39 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Thu, 21 Nov 2024 17:14:37 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Thu, 21 Nov 2024 17:14:36 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+9a8500a45c2cabdf9577@syzkaller.appspotmail.com>
CC: <linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [io-uring?] KMSAN: uninit-value in io_nop
Date: Fri, 22 Nov 2024 09:14:36 +0800
Message-ID: <20241122011436.4005307-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <673f3ed9.050a0220.3c9d61.0173.GAE@google.com>
References: <673f3ed9.050a0220.3c9d61.0173.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0UCsAlwu88A648G1I82Pjdzc4KDbLLqh
X-Proofpoint-GUID: 0UCsAlwu88A648G1I82Pjdzc4KDbLLqh
X-Authority-Analysis: v=2.4 cv=E4efprdl c=1 sm=1 tr=0 ts=673fdaff cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=VlfZXiiP6vEA:10 a=87kk7cAV66zgBrEaejAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-21_17,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 mlxlogscore=783 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411220008

The fd of nop not inited when the flags of the nop comm is not IORING_NOP_FIXED_FILE in nop's prep.

#syz test

diff --git a/io_uring/nop.c b/io_uring/nop.c
index 6d470d4251ee..a10d0a0aef96 100644
--- a/io_uring/nop.c
+++ b/io_uring/nop.c
@@ -37,6 +37,9 @@ int io_nop_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		nop->result = 0;
 	if (nop->flags & IORING_NOP_FIXED_FILE)
 		nop->fd = READ_ONCE(sqe->fd);
+	else
+		nop->fd = 0;
+
 	if (nop->flags & IORING_NOP_FIXED_BUFFER)
 		nop->buffer = READ_ONCE(sqe->buf_index);
 	return 0;

