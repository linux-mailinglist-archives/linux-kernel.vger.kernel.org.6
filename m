Return-Path: <linux-kernel+bounces-251572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 909EF93067D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 18:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54D8D283A02
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 16:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD7F1428EF;
	Sat, 13 Jul 2024 16:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ay0AQf6y"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1125B145FE9;
	Sat, 13 Jul 2024 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720889780; cv=none; b=me5RP58swzvkhMY5Iy89Fa+rDczmsgSIOIMmAN5ZcaOR7wtsfBqwHb0Jnk3nGFuxvVGVjexce3aJKDtzAERfupzfdfm+hJ1q0v92NyOjt/eyHA7FAYBAMTbi8GXdLufivhB0YTk/TyOjXQAZuyEN4sPScuOcTo27Z4HSpfF7gRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720889780; c=relaxed/simple;
	bh=BEmkGPUdp55a6PGj3rhVD/vsRgF8khu1meqgj7lb1SE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ScmO5NqbknA48tlru8hnLAsGrs4njwyn3zXFcj+Ry90VZG31oqiiTn/MpNX8sIzhDsEZagBnT7tb7TunuYSLGSlvRZ0zFRPHq5l2ApwCyQv0JvhYYjWSX5blY7sxtnd3VrpBfAVXRsKJrqafsU+WGDbD3UWlyR+5OFcmiRgykms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ay0AQf6y; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46DG8En3029149;
	Sat, 13 Jul 2024 16:56:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=vM4SrkCWbdDY1
	0kghF/18JVoejoDL1rtzusM+LbfNAA=; b=Ay0AQf6yOwS++q/afFXld8a7iG2f5
	bz7VQUAi44CUq0z1e9cSYwchZbiu/47/qfCgRDMKGyOxNjCtP1KTFZfbeM+6KJ1g
	TdIbVlCbD4PJ8zLx17cYhPheyTxj9jVDNbEFEEQ1ZPOJpQp8koaRCko0ysHwQI8r
	Gr+k1HSeAAi5gKmYJfFdiJvp7EZ6W2rIikysYfkolT1f8NPHT957VGBhbVmqR/14
	+lrS9oXmrZKEe8rQwkp/WX7O867cSJ082V1auIVv1jwG/DmyXeV3Ml6LntROE8lE
	MxWHclKSYINQevpm7H2z8Gb0yzhFSYtwfXun7bHhT1jfIS4YRiLibTXdA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40bv8gg3y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jul 2024 16:56:09 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46DGu8EP029933;
	Sat, 13 Jul 2024 16:56:08 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40bv8gg3xy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jul 2024 16:56:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46DGC0Z7024575;
	Sat, 13 Jul 2024 16:56:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 407hrnc7ua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jul 2024 16:56:07 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46DGu1hr16515336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Jul 2024 16:56:03 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C91320043;
	Sat, 13 Jul 2024 16:56:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CCDC20040;
	Sat, 13 Jul 2024 16:55:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.49.134])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 13 Jul 2024 16:55:58 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org, segher@kernel.crashing.org,
        christophe.leroy@csgroup.eu
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH V7 08/18] tools/perf: Add support to identify memory instructions of opcode 31 in powerpc
Date: Sat, 13 Jul 2024 22:25:19 +0530
Message-Id: <20240713165529.59298-9-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240713165529.59298-1-atrajeev@linux.vnet.ibm.com>
References: <20240713165529.59298-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YkXp1sobcFnVxZEfDgR23SVqXp4lN3jV
X-Proofpoint-ORIG-GUID: Hasqq83AaqNGTcJCYh5Kf6IUUxVybUZq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-13_13,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 mlxlogscore=954 priorityscore=1501 suspectscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407130127

There are memory instructions in powerpc with opcode as 31.
Example: "ldx RT,RA,RB" , Its X form is as below:

  ______________________________________
  | 31 |  RT  |  RA |  RB |   21     |/|
  --------------------------------------
  0    6     11    16    21         30 31

The opcode for "ldx" is 31. There are other instructions also with
opcode 31 which are memory insn like ldux, stbx, lwzx, lhaux
But all instructions with opcode 31 are not memory. Example is add
instruction: "add RT,RA,RB"

The value in bit 21-30 [ 21 for ldx ] is different for these
instructions. Patch uses this value to assign instruction ops for these
cases. The naming convention and value to identify these are picked from
defines in "arch/powerpc/include/asm/ppc-opcode.h"

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 .../perf/arch/powerpc/annotate/instructions.c | 107 +++++++++++++++++-
 tools/perf/util/disasm.c                      |   3 +
 2 files changed, 108 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/powerpc/annotate/instructions.c b/tools/perf/arch/powerpc/annotate/instructions.c
index b084423d8477..1ffb64c6bd0d 100644
--- a/tools/perf/arch/powerpc/annotate/instructions.c
+++ b/tools/perf/arch/powerpc/annotate/instructions.c
@@ -49,18 +49,121 @@ static struct ins_ops *powerpc__associate_instruction_ops(struct arch *arch, con
 	return ops;
 }
 
-#define PPC_OP(op)      (((op) >> 26) & 0x3F)
+#define PPC_OP(op)	(((op) >> 26) & 0x3F)
+#define PPC_21_30(R)	(((R) >> 1) & 0x3ff)
+
+struct insn_offset {
+	const char	*name;
+	int		value;
+};
+
+/*
+ * There are memory instructions with opcode 31 which are
+ * of X Form, Example:
+ * ldx RT,RA,RB
+ * ______________________________________
+ * | 31 |  RT  |  RA |  RB |   21     |/|
+ * --------------------------------------
+ * 0    6     11    16    21         30 31
+ *
+ * But all instructions with opcode 31 are not memory.
+ * Example: add RT,RA,RB
+ *
+ * Use bits 21 to 30 to check memory insns with 31 as opcode.
+ * In ins_array below, for ldx instruction:
+ * name => OP_31_XOP_LDX
+ * value => 21
+ */
+
+static struct insn_offset ins_array[] = {
+	{ .name = "OP_31_XOP_LXSIWZX",  .value = 12, },
+	{ .name = "OP_31_XOP_LWARX",	.value = 20, },
+	{ .name = "OP_31_XOP_LDX",	.value = 21, },
+	{ .name = "OP_31_XOP_LWZX",	.value = 23, },
+	{ .name = "OP_31_XOP_LDUX",	.value = 53, },
+	{ .name = "OP_31_XOP_LWZUX",	.value = 55, },
+	{ .name = "OP_31_XOP_LXSIWAX",  .value = 76, },
+	{ .name = "OP_31_XOP_LDARX",    .value = 84, },
+	{ .name = "OP_31_XOP_LBZX",	.value = 87, },
+	{ .name = "OP_31_XOP_LVX",      .value = 103, },
+	{ .name = "OP_31_XOP_LBZUX",    .value = 119, },
+	{ .name = "OP_31_XOP_STXSIWX",  .value = 140, },
+	{ .name = "OP_31_XOP_STDX",	.value = 149, },
+	{ .name = "OP_31_XOP_STWX",	.value = 151, },
+	{ .name = "OP_31_XOP_STDUX",	.value = 181, },
+	{ .name = "OP_31_XOP_STWUX",	.value = 183, },
+	{ .name = "OP_31_XOP_STBX",	.value = 215, },
+	{ .name = "OP_31_XOP_STVX",     .value = 231, },
+	{ .name = "OP_31_XOP_STBUX",	.value = 247, },
+	{ .name = "OP_31_XOP_LHZX",	.value = 279, },
+	{ .name = "OP_31_XOP_LHZUX",	.value = 311, },
+	{ .name = "OP_31_XOP_LXVDSX",   .value = 332, },
+	{ .name = "OP_31_XOP_LWAX",	.value = 341, },
+	{ .name = "OP_31_XOP_LHAX",	.value = 343, },
+	{ .name = "OP_31_XOP_LWAUX",	.value = 373, },
+	{ .name = "OP_31_XOP_LHAUX",	.value = 375, },
+	{ .name = "OP_31_XOP_STHX",	.value = 407, },
+	{ .name = "OP_31_XOP_STHUX",	.value = 439, },
+	{ .name = "OP_31_XOP_LXSSPX",   .value = 524, },
+	{ .name = "OP_31_XOP_LDBRX",	.value = 532, },
+	{ .name = "OP_31_XOP_LSWX",	.value = 533, },
+	{ .name = "OP_31_XOP_LWBRX",	.value = 534, },
+	{ .name = "OP_31_XOP_LFSUX",    .value = 567, },
+	{ .name = "OP_31_XOP_LXSDX",    .value = 588, },
+	{ .name = "OP_31_XOP_LSWI",	.value = 597, },
+	{ .name = "OP_31_XOP_LFDX",     .value = 599, },
+	{ .name = "OP_31_XOP_LFDUX",    .value = 631, },
+	{ .name = "OP_31_XOP_STXSSPX",  .value = 652, },
+	{ .name = "OP_31_XOP_STDBRX",	.value = 660, },
+	{ .name = "OP_31_XOP_STXWX",	.value = 661, },
+	{ .name = "OP_31_XOP_STWBRX",	.value = 662, },
+	{ .name = "OP_31_XOP_STFSX",	.value = 663, },
+	{ .name = "OP_31_XOP_STFSUX",	.value = 695, },
+	{ .name = "OP_31_XOP_STXSDX",   .value = 716, },
+	{ .name = "OP_31_XOP_STSWI",	.value = 725, },
+	{ .name = "OP_31_XOP_STFDX",	.value = 727, },
+	{ .name = "OP_31_XOP_STFDUX",	.value = 759, },
+	{ .name = "OP_31_XOP_LXVW4X",   .value = 780, },
+	{ .name = "OP_31_XOP_LHBRX",	.value = 790, },
+	{ .name = "OP_31_XOP_LXVD2X",   .value = 844, },
+	{ .name = "OP_31_XOP_LFIWAX",	.value = 855, },
+	{ .name = "OP_31_XOP_LFIWZX",	.value = 887, },
+	{ .name = "OP_31_XOP_STXVW4X",  .value = 908, },
+	{ .name = "OP_31_XOP_STHBRX",	.value = 918, },
+	{ .name = "OP_31_XOP_STXVD2X",  .value = 972, },
+	{ .name = "OP_31_XOP_STFIWX",	.value = 983, },
+};
+
+static int cmp_offset(const void *a, const void *b)
+{
+	const struct insn_offset *val1 = a;
+	const struct insn_offset *val2 = b;
+
+	return (val1->value - val2->value);
+}
 
 static struct ins_ops *check_ppc_insn(u32 raw_insn)
 {
 	int opcode = PPC_OP(raw_insn);
+	int mem_insn_31 = PPC_21_30(raw_insn);
+	struct insn_offset *ret;
+	struct insn_offset mem_insns_31_opcode = {
+		"OP_31_INSN",
+		mem_insn_31
+	};
 
 	/*
 	 * Instructions with opcode 32 to 63 are memory
 	 * instructions in powerpc
 	 */
-	if ((opcode & 0x20))
+	if ((opcode & 0x20)) {
 		return &load_store_ops;
+	} else if (opcode == 31) {
+		/* Check for memory instructions with opcode 31 */
+		ret = bsearch(&mem_insns_31_opcode, ins_array, ARRAY_SIZE(ins_array), sizeof(ins_array[0]), cmp_offset);
+		if (ret != NULL)
+			return &load_store_ops;
+	}
 
 	return NULL;
 }
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index b30277a930c0..d39ff19ea081 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -698,6 +698,9 @@ static int load_store__parse(struct arch *arch __maybe_unused, struct ins_operan
 {
 	ops->source.mem_ref = true;
 	ops->source.multi_regs = false;
+	/* opcode 31 is of X form */
+	if (PPC_OP(dl->raw.raw_insn) == 31)
+		ops->source.multi_regs = true;
 
 	ops->target.mem_ref = false;
 	ops->target.multi_regs = false;
-- 
2.43.0


