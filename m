Return-Path: <linux-kernel+bounces-251571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A7893067B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 18:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56B821C21D78
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 16:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3094D144D2F;
	Sat, 13 Jul 2024 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VlSagOHL"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC7E14386E;
	Sat, 13 Jul 2024 16:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720889777; cv=none; b=qyBA9KoIciR6OSYDHUPnRQPPD5pBh7LHil6EGm7oF2bK1ke99vmbZmL4yZDyo+SaYrkTr6/wZ3tJDcI8YDbUcewRZxZ3MxtkZcYDa6yWq2JYcUtB+6xHOgQx5BwWwUqnRuj70sIBqb2n+QMbmc9OvcKTd4/+DiX7lUj1/qR7PfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720889777; c=relaxed/simple;
	bh=OmNXuQEF6Dbf3+SMkRb6BsPVpueZJkB06ql0WnQzJnA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a4LFAxuE3nux+C8KMdiASqKtadSWqhqX3KtY8dKaNHpBX6EPKqu+upGLiy+8B/SPclrvCygLvC6y/fAt/VhzW/Yoz5pgu7bEsM55mz0zKwI9I7D9mtqAC590E/84kNo8+P++rKm+lrNIw1rLl5Y0AFXmHrLo+fnXSoaDa2nYXKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VlSagOHL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46DFvIOY013309;
	Sat, 13 Jul 2024 16:56:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=lcUCjwktAhFIA
	1O56PipgJnZSgAksv+CoiSR2v7NN4w=; b=VlSagOHLhForzyqYt6C1/2etkavs+
	IX8TqT75hQptOozBxpuz+pK75s612gLgYgtOs4JthPtEk0KgRFARXalraxBVJAQC
	uDX9GYCBKo6/MTR7gdP083nTTtTHQYe0fmqHfXBVMyNyXDZp7aThIj1P1s0NspG2
	P40JS5CGc6SjT8gfTWi5pS2GOB3q3lecpKjx9X3YwjDn3Fw9DOLtFBFWJEkcm++G
	yXxIsQk6ZbUl47K8XjwLHZijRgGXlwL5+l1p29VAoS4C0KO0UHnDc9FfLB9h4O69
	TPZeSZyKuIVdd+scrkNk8e4nhEN3lYxlYOz4rR+tXVQTwQSCQL2xR8MYw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40bv8gg3xp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jul 2024 16:56:05 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46DGu4Nk029885;
	Sat, 13 Jul 2024 16:56:04 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40bv8gg3xe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jul 2024 16:56:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46DDs7Qk011373;
	Sat, 13 Jul 2024 16:56:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40bpec1fnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jul 2024 16:56:03 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46DGtwkH41681376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Jul 2024 16:56:00 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E0CE20043;
	Sat, 13 Jul 2024 16:55:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B8BF20040;
	Sat, 13 Jul 2024 16:55:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.49.134])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 13 Jul 2024 16:55:55 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org, segher@kernel.crashing.org,
        christophe.leroy@csgroup.eu
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH V7 07/18] tools/perf: Add parse function for memory instructions in powerpc
Date: Sat, 13 Jul 2024 22:25:18 +0530
Message-Id: <20240713165529.59298-8-atrajeev@linux.vnet.ibm.com>
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
X-Proofpoint-GUID: G3_9R2B2BBrIYITDbljHCW6XGtuJCt9l
X-Proofpoint-ORIG-GUID: mXESMPlMmiMLkDtI-JLcWrTEfoYkR_zn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-13_13,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407130127

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
index 8e45f0874e03..b30277a930c0 100644
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


