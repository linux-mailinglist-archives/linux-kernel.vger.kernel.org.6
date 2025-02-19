Return-Path: <linux-kernel+bounces-522009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7935A3C4DB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF7C73A77EB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC061FDE12;
	Wed, 19 Feb 2025 16:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DLTpdiiQ"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368B91FDE26
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739982124; cv=none; b=RCkSoIsxhK5KUOtYKQRm5cWat+D9tV4WvIsG61mcafJgGbgqADT0clRlMZekm29tPtSXVdokFH0m4TYZq4qS6L3PCKytE9AFaap+33nnybhVNJOlx9kBw8pL8v3xCMZn3fWNNxywfsvRaUMP0LElsyYmkL6wbSJFR53o8pigDRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739982124; c=relaxed/simple;
	bh=NC55d8UKmYSyTtYh7FciGxWwAStqqPsErmpYqmhgHxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I5/Vx96xGJHgVeMW9T/RjyhFWzSPj+dNy3HAE47BgPb5mS9P4chdH3a5fuoe3FwQaVe6zXiD1K6CDdl4bFTvme92EszgU82YyE6mbCHdVVTgXLkHGrfG7gQqzfV5RnAOfeiF+bCzjp8ZDD/Y+8f0qTzYk/ODiXDpw7F5061J3Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DLTpdiiQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JFv3cq022138;
	Wed, 19 Feb 2025 16:21:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=sI0uUTF74a9oWRxqSrmo4ISZh1Osp1/CDwnWs/YQ0
	zM=; b=DLTpdiiQpwwp3xjUKSlN677fA0avcR0Qs5hD+YYfcGKOAwyXjHygGYHxj
	sIFv9O8nB4e+QBgIImwQFkYNMxfwCKcV6sHy0mtok7PpCgu3LPuaNj8H4UnKKtw6
	yhTcTGMv72LmnVMwaBn+ABwOGL7q5g10H1wxwQOkNUe27H7P00wHGVUXxMVM6RTI
	F3Shu8qV9cElhml5KmAz+7K8TWf1lGBeoQlCivqSvdjizr/+7e4CftyL2h8G9oBH
	xn9TiIt2RREOtkOVn/afN3S5xFs32Jn6O3KtKhhEZVU6c8UPYrfUju4RwHKQGfr9
	xMUxWzJdD4w/tNTo0+8vGRNnkcJ5w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wahjtsj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 16:21:48 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51JG3ltR006774;
	Wed, 19 Feb 2025 16:21:47 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wahjtshx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 16:21:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51JE8Go4009721;
	Wed, 19 Feb 2025 16:21:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w03y50fc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 16:21:46 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51JGLh2l46203154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 16:21:43 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3176520043;
	Wed, 19 Feb 2025 16:21:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46C8B20040;
	Wed, 19 Feb 2025 16:21:40 +0000 (GMT)
Received: from li-2fa77bcc-2701-11b2-a85c-cd621c23b6bd.ibm.com (unknown [9.39.30.196])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Feb 2025 16:21:40 +0000 (GMT)
From: Sathvika Vasireddy <sv@linux.ibm.com>
To: jpoimboe@kernel.org, peterz@infradead.org, christophe.leroy@csgroup.eu,
        npiggin@gmail.com, maddy@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        llvm@lists.linux.dev, sv@linux.ibm.com
Subject: [RFC PATCH] objtool: Skip unannotated intra-function call warning for bl+mflr pattern
Date: Wed, 19 Feb 2025 21:50:14 +0530
Message-ID: <20250219162014.10334-1-sv@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -0nfzOLk-iSmRiDMV3cAGQnVUQrMFrCG
X-Proofpoint-ORIG-GUID: lsAzIwV9z7swoBTplC0ojbBe2RyPnvvE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_07,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 spamscore=0 clxscore=1011 priorityscore=1501 mlxlogscore=944
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190124

Architectures like PowerPC use a pattern where the compiler generates a
branch-and-link (bl) instruction that targets the very next instruction,
followed by loading the link register (mflr) later. This pattern appears
in the code like:

 bl .+4
 li r5,0
 mflr r30

Objtool currently warns about this as an "unannotated intra-function
call" because find_call_destination() fails to find any symbol at the
target offset. Add a check to skip the warning when a branch targets
the immediate next instruction in the same function.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502180818.XnFdv8I8-lkp@intel.com/
Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
---
 tools/objtool/check.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 753dbc4f8198..3f7cf2c917b5 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1613,6 +1613,7 @@ static struct symbol *find_call_destination(struct section *sec, unsigned long o
  */
 static int add_call_destinations(struct objtool_file *file)
 {
+	struct instruction *next_insn;
 	struct instruction *insn;
 	unsigned long dest_off;
 	struct symbol *dest;
@@ -1625,6 +1626,11 @@ static int add_call_destinations(struct objtool_file *file)
 		reloc = insn_reloc(file, insn);
 		if (!reloc) {
 			dest_off = arch_jump_destination(insn);
+
+			next_insn = next_insn_same_func(file, insn);
+			if (next_insn && dest_off == next_insn->offset)
+				continue;
+
 			dest = find_call_destination(insn->sec, dest_off);
 
 			add_call_dest(file, insn, dest, false);
-- 
2.39.3


