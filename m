Return-Path: <linux-kernel+bounces-554109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0CFA59316
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A3EF3A7F99
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669FA215F49;
	Mon, 10 Mar 2025 11:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p4lIxj2I"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5253622172D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 11:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741607600; cv=none; b=hjtbqa+6T6G9220iyHIvSis34hbTCs5xJRL4sD9P0H4RkYKg6roUd7rFfNl3U/K650t/ZogyT5ToZ4q1NNo9QXPQGta788MaNv3J5hwBQCZpCsEXu8r13YKhSLsd+iw62vSYh6lNhxJ/AVyE+VKbA8CEoSb/9IUe0yDKfe3zKUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741607600; c=relaxed/simple;
	bh=OHYSRGsBe6yycbgWkB1upTjtV9JWYTCM78i71mN536w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e8QcFu7Z7tX4uEwq5ItiZ+IU6CRto9xtZ29IwuKxnt3hF+IQn0jYBuWeRWsojXzTm8jhF3Emvj/pOKKacvkn3sFVJLNDZ9rFvGuWnnEKSym6wRhcnlXR95ArnhukJhjWCHKV1OxASnzufGEI9vrbQf9asZa/Ez69WZN+t2zPiZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p4lIxj2I; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52A8rjX1009554;
	Mon, 10 Mar 2025 11:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=OpXNX3hvZdguE0nhlydY/fRBk/zv6lY2jwMAlaUhs
	yY=; b=p4lIxj2IdjbRjEgmadcP3CG086NqiaMPx75urxnSb6DgohGGn+jBnC/gR
	wRjpGxDrgPr5o6usJeTInBN3mRdm2pMK/tgZ/StreX4kDl6Pxc42eI58ycGV2VSw
	fp+yG8JJhhh2FrkYoBrjylPEhd0ktDu2lrbnUh38zAaUAr1ckoEr6Mhu/slx0Mdl
	45KRah/DUsCIoHye1JAUsFL5emQ05/56X6IPhdxbWVBQeD32hrVJrat8OmrwyZVR
	XmgT+be0jl0SnIdMUkIKnC5NV0DJ46vVWe1zXLEfgzRnUCL+N5pqyLAt25+8xRNm
	uSyLj8+bFnEyeMZrbeXlR2dQoU3eA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 459b16mc7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 11:53:13 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52ABX09F008188;
	Mon, 10 Mar 2025 11:53:13 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 459b16mc77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 11:53:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52ABj9ew014487;
	Mon, 10 Mar 2025 11:53:12 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4592ek64mg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 11:53:11 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52ABrAtH45678890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 11:53:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50E932004B;
	Mon, 10 Mar 2025 11:53:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D7AC20043;
	Mon, 10 Mar 2025 11:53:09 +0000 (GMT)
Received: from ltczz402-lp1.aus.stglabs.ibm.com (unknown [9.40.194.31])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Mar 2025 11:53:08 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Donet Tom <donettom@linux.ibm.com>
Subject: [PATCH] driver/base/node.c: Fix softlockups during the initialization of large systems with interleaved memory blocks
Date: Mon, 10 Mar 2025 06:53:05 -0500
Message-ID: <20250310115305.13599-1-donettom@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yUdMoshFtqgEYmmOnZ4TdXOxe2EskEuA
X-Proofpoint-GUID: doqSbjUAPhPdYxb3VBHKmoon8mVcLT3V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_04,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=801 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503100091

On large systems with more than 64TB of DRAM, if the memory blocks
are interleaved, node initialization (node_dev_init()) could take
a long time since it iterates over each memory block. If the memory
block belongs to the current iterating node, the first pfn_to_nid
will provide the correct value. Otherwise, it will iterate over all
PFNs and check the nid. On non-preemptive kernels, this can result
in a watchdog softlockup warning. Even though CONFIG_PREEMPT_LAZY
is enabled in kernels now [1], we may still need to fix older
stable kernels to avoid encountering these kernel warnings during
boot.

This patch adds a cond_resched() call in node_dev_init() to avoid
this warning.

node_dev_init()
    register_one_node
        register_memory_blocks_under_node
            walk_memory_blocks()
                register_mem_block_under_node_early
                    get_nid_for_pfn
                        early_pfn_to_nid

In my system node4 has a memory block ranging from memory30351
to memory38524, and memory128433. The memory blocks between
memory38524 and memory128433 do not belong to this node.

In  walk_memory_blocks() we iterate over all memblocks starting
from memory38524 to memory128433.
In register_mem_block_under_node_early(), up to memory38524, the
first pfn correctly returns the corresponding nid and the function
returns from there. But after memory38524 and until memory128433,
the loop iterates through each pfn and checks the nid. Since the nid
does not match the required nid, the loop continues. This causes
the soft lockups.

[1]: https://lore.kernel.org/linuxppc-dev/20241116192306.88217-1-sshegde@linux.ibm.com/
Fixes: 2848a28b0a60 ("drivers/base/node: consolidate node device subsystem initialization in node_dev_init()")
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 drivers/base/node.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 0ea653fa3433..107eb508e28e 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -975,5 +975,6 @@ void __init node_dev_init(void)
 		ret = register_one_node(i);
 		if (ret)
 			panic("%s() failed to add node: %d\n", __func__, ret);
+		cond_resched();
 	}
 }
-- 
2.43.5


