Return-Path: <linux-kernel+bounces-235582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1D591D70C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 06:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A87928316E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 04:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2827D095;
	Mon,  1 Jul 2024 04:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KEIJT3gl"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D54757E0;
	Mon,  1 Jul 2024 04:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719808515; cv=none; b=E222hP/2K9tUCINKHRtPj7o6lXj7Mh1kqbo2nJOKUtC/GX3Ehb8jMkUO242GKhVdb5nLVCli8o9wNcer8gedVSaDYA1NbZT2Dfe/NEYk9IK7SGXAu2gmh/w5mVYIeWody4RYBSJ5Mj7q/g99+CxfHdCp1QJ5UBxkZH49I8aotf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719808515; c=relaxed/simple;
	bh=qYMTWS7usPBUSPyWrURYKWqhigY07rP9Tv++JOj99XA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YIbtAmZPnNt4vSNeERe5CwS/Sub2FDwPEA7Xn1EziF4Zo+EYXZ4rEe2nUgi3Jz+0aw+VJx4U6gZuZPKQ5AO/a2lxH5x8OjF46m1BpZYYy9GTc0Bipg8WCWqxyG6C69kCax/1WaKQXLxnx0M6WJu6k35ejqM9rjoj6uWtQfMzr0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KEIJT3gl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4614TKTe024339;
	Mon, 1 Jul 2024 04:35:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=+xaCmcJGDguVb
	l1W/wIYlgpqTq3FfMVWW8zbE7mXAcI=; b=KEIJT3glXuAZ+vZOxxnNV0Y+ebwjQ
	/5f+//D2Q2lPrbZqEb4Gy/j5lDhejyejQMKi7VtlwgC2ai+f8C9eMvaiLzzgFb/s
	dsdPEgck+tWMDBXEdSHimEeAJ/x9Ug6MpUsLQaN60Ihei+Sf59xv6CVxddq3EDwg
	p5Jx4LRYj/Th72JS2sYqPT4H1ws1RutGk20CWw0l7To5uA7kCjz4UTnyPTDNi9aI
	VZYF4o2KeBFW4uEFSSHiYxKhggXrFvqTgV+btWn4jmhwCYepQSxjzpH/c2nm9K+r
	do18mnSMY5RyTZ5To2lIoN66n4YQV+Cr/tw8LFtxF+zN7I5/Z393o3ixw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 403nfc00mq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 04:35:05 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4614Z5IN002643;
	Mon, 1 Jul 2024 04:35:05 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 403nfc00mm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 04:35:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46120K7o024077;
	Mon, 1 Jul 2024 04:35:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 402ya34ybq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 04:35:04 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4614Ywg120709690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jul 2024 04:35:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA97C20043;
	Mon,  1 Jul 2024 04:34:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F296120040;
	Mon,  1 Jul 2024 04:34:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.21.126])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jul 2024 04:34:55 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org, segher@kernel.crashing.org,
        christophe.leroy@csgroup.eu
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH V5 07/17] tools/perf: Add parse function for memory instructions in powerpc
Date: Mon,  1 Jul 2024 10:04:20 +0530
Message-Id: <20240701043430.66666-8-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240701043430.66666-1-atrajeev@linux.vnet.ibm.com>
References: <20240701043430.66666-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qYa_LE6fzo66nCI6mMz5Jt-0iKSjCfM5
X-Proofpoint-GUID: JfkEPuR3zdTXsY2e1hb2iEmcRIGZUBud
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_03,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010030

Use the raw instruction code and macros to identify memory instructions,
extract register fields and also offset. The implementation addresses
the D-form, X-form, DS-form instructions. Two main functions are added.
New parse function "load_store__parse" as instruction ops parser for
memory instructions. Unlink other parser (like mov__parse), this parser
fills in the "multi_regs" field for source/target and new added "mem_ref"
field. No other fields are set because, here there is no need to parse the
disassembled code and arch specific macros will take care of extracting
offset and regs which is easier and will be precise.

In powerpc, all instructions with a primary opcode from 32 to 63
are memory instructions. Update "ins__find" function to have "raw_insn"
also as a parameter.

Signed-off-by: Athira Rajeev<atrajeev@linux.vnet.ibm.com>
---
 .../perf/arch/powerpc/annotate/instructions.c | 16 ++++++
 tools/perf/util/disasm.c                      | 54 +++++++++++++++++--
 tools/perf/util/disasm.h                      |  2 +-
 3 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/tools/perf/arch/powerpc/annotate/instructions.c b/tools/perf/arch/powerpc/annotate/instructions.c
index d57fd023ef9c..b084423d8477 100644
--- a/tools/perf/arch/powerpc/annotate/instructions.c
+++ b/tools/perf/arch/powerpc/annotate/instructions.c
@@ -49,6 +49,22 @@ static struct ins_ops *powerpc__associate_instruction_ops(struct arch *arch, con
 	return ops;
 }
 
+#define PPC_OP(op)      (((op) >> 26) & 0x3F)
+
+static struct ins_ops *check_ppc_insn(u32 raw_insn)
+{
+	int opcode = PPC_OP(raw_insn);
+
+	/*
+	 * Instructions with opcode 32 to 63 are memory
+	 * instructions in powerpc
+	 */
+	if ((opcode & 0x20))
+		return &load_store_ops;
+
+	return NULL;
+}
+
 static int powerpc__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 {
 	if (!arch->initialized) {
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index d012ea9b0dfb..1396df1b138a 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -37,6 +37,7 @@ static struct ins_ops mov_ops;
 static struct ins_ops nop_ops;
 static struct ins_ops lock_ops;
 static struct ins_ops ret_ops;
+static struct ins_ops load_store_ops;
 
 static int jump__scnprintf(struct ins *ins, char *bf, size_t size,
 			   struct ins_operands *ops, int max_ins_name);
@@ -522,7 +523,7 @@ static int lock__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 	if (disasm_line__parse(ops->raw, &ops->locked.ins.name, &ops->locked.ops->raw) < 0)
 		goto out_free_ops;
 
-	ops->locked.ins.ops = ins__find(arch, ops->locked.ins.name);
+	ops->locked.ins.ops = ins__find(arch, ops->locked.ins.name, 0);
 
 	if (ops->locked.ins.ops == NULL)
 		goto out_free_ops;
@@ -678,6 +679,37 @@ static struct ins_ops mov_ops = {
 	.scnprintf = mov__scnprintf,
 };
 
+static int load_store__scnprintf(struct ins *ins, char *bf, size_t size,
+		struct ins_operands *ops, int max_ins_name)
+{
+	return scnprintf(bf, size, "%-*s %s", max_ins_name, ins->name,
+			ops->raw);
+}
+
+/*
+ * Sets the fields: multi_regs and "mem_ref".
+ * "mem_ref" is set for ops->source which is later used to
+ * fill the objdump->memory_ref-char field. This ops is currently
+ * used by powerpc and since binary instruction code is used to
+ * extract opcode, regs and offset, no other parsing is needed here
+ */
+static int load_store__parse(struct arch *arch __maybe_unused, struct ins_operands *ops,
+		struct map_symbol *ms __maybe_unused, struct disasm_line *dl __maybe_unused)
+{
+	ops->source.mem_ref = true;
+	ops->source.multi_regs = false;
+
+	ops->target.mem_ref = false;
+	ops->target.multi_regs = false;
+
+	return 0;
+}
+
+static struct ins_ops load_store_ops = {
+	.parse     = load_store__parse,
+	.scnprintf = load_store__scnprintf,
+};
+
 static int dec__parse(struct arch *arch __maybe_unused, struct ins_operands *ops, struct map_symbol *ms __maybe_unused,
 		struct disasm_line *dl __maybe_unused)
 {
@@ -769,11 +801,23 @@ static void ins__sort(struct arch *arch)
 	qsort(arch->instructions, nmemb, sizeof(struct ins), ins__cmp);
 }
 
-static struct ins_ops *__ins__find(struct arch *arch, const char *name)
+static struct ins_ops *__ins__find(struct arch *arch, const char *name, u32 raw_insn)
 {
 	struct ins *ins;
 	const int nmemb = arch->nr_instructions;
 
+	if (arch__is(arch, "powerpc")) {
+		/*
+		 * For powerpc, identify the instruction ops
+		 * from the opcode using raw_insn.
+		 */
+		struct ins_ops *ops;
+
+		ops = check_ppc_insn(raw_insn);
+		if (ops)
+			return ops;
+	}
+
 	if (!arch->sorted_instructions) {
 		ins__sort(arch);
 		arch->sorted_instructions = true;
@@ -803,9 +847,9 @@ static struct ins_ops *__ins__find(struct arch *arch, const char *name)
 	return ins ? ins->ops : NULL;
 }
 
-struct ins_ops *ins__find(struct arch *arch, const char *name)
+struct ins_ops *ins__find(struct arch *arch, const char *name, u32 raw_insn)
 {
-	struct ins_ops *ops = __ins__find(arch, name);
+	struct ins_ops *ops = __ins__find(arch, name, raw_insn);
 
 	if (!ops && arch->associate_instruction_ops)
 		ops = arch->associate_instruction_ops(arch, name);
@@ -815,7 +859,7 @@ struct ins_ops *ins__find(struct arch *arch, const char *name)
 
 static void disasm_line__init_ins(struct disasm_line *dl, struct arch *arch, struct map_symbol *ms)
 {
-	dl->ins.ops = ins__find(arch, dl->ins.name);
+	dl->ins.ops = ins__find(arch, dl->ins.name, dl->raw.raw_insn);
 
 	if (!dl->ins.ops)
 		return;
diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
index 30be0a94ea04..c1bb1e484bfb 100644
--- a/tools/perf/util/disasm.h
+++ b/tools/perf/util/disasm.h
@@ -105,7 +105,7 @@ struct annotate_args {
 struct arch *arch__find(const char *name);
 bool arch__is(struct arch *arch, const char *name);
 
-struct ins_ops *ins__find(struct arch *arch, const char *name);
+struct ins_ops *ins__find(struct arch *arch, const char *name, u32 raw_insn);
 int ins__scnprintf(struct ins *ins, char *bf, size_t size,
 		   struct ins_operands *ops, int max_ins_name);
 
-- 
2.43.0


