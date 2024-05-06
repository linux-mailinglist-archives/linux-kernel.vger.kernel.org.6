Return-Path: <linux-kernel+bounces-169791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0AB8BCDAA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19DB21F249F8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945FF144D0C;
	Mon,  6 May 2024 12:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LzuSjMJk"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837191448D3;
	Mon,  6 May 2024 12:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714997991; cv=none; b=iW48vOkbWle+yrwl0t8v3Sznimn5xGVRzi81PWF2TwY6+BaaZeS+PszknZ/B186Ael+hfJfoTXekjMH2QVuY5ysY10rRLA0flod6QmTryjl1osOOxSnVt9PWcs5lcErWkjoka0oZfoSEnMAGioLGUrQmzPTod+2jz7MDz8osu/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714997991; c=relaxed/simple;
	bh=T7+NJh+d+hef/6vA4ZLswN/q3/VYQ3gghMmi3gO54XA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tTt9ANWuEiU4zXoJL/Ip56aFvNUiPy+4agQrq/8waISzkxteA6PGk4woWGBXvWisvKZG5t7XjMPeIBhCS74QRJi1txsYzzXnc/jn20AB+a9fYEWnPi96HByIPRcWguoztyHJQuq/gdDGEblgPBvymCfXUjA7cV1SsAA1swnAEV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LzuSjMJk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446Arb4r020821;
	Mon, 6 May 2024 12:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wDpktLVm5+ku46M9E50BOWbv1+PB4Wh7qCErtPDV/RQ=;
 b=LzuSjMJkKl9r4IgFLliTiaZQWPaBr+4M1F27htEdLs5zNDtW4NxoeUk/jO5ciW2Yt1tg
 eEq5vkZNJVdXEafvIovBoV4zksRIbQxf/nUIviJl7ROdYFTsXhL49KSW/IWV5uajZcdB
 l7JNgYxXOIOZLOOXER1E06+5cGz698eVljyqhGoTEw5IuhnP4rO0qBudVqNiU/pi6ski
 IjuZduk/Gqdj8GpD/6/UvOQ4N8sJq42DodJA0AgendO2NXudIcBdAbWC0wXG88F/4LBh
 Mow2wtmrzrNEhqM+Quz4jjq7J1Wghv4HtFNy3Z+pFVb3zL/Jq11nGCj9XBJeA7N5VKQC HA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xxwu5r68e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 12:19:41 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 446CJeRI022518;
	Mon, 6 May 2024 12:19:40 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xxwu5r689-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 12:19:40 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44696kFx010581;
	Mon, 6 May 2024 12:19:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xx0bnytsc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 12:19:39 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 446CJXf350856266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 May 2024 12:19:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D5202004E;
	Mon,  6 May 2024 12:19:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC6DA2004B;
	Mon,  6 May 2024 12:19:30 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.103.211])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 May 2024 12:19:30 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org, segher@kernel.crashing.org,
        christophe.leroy@csgroup.eu
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        akanksha@linux.ibm.com
Subject: [PATCH V2 5/9] tools/perf: Update parameters for reg extract functions to use raw instruction on powerpc
Date: Mon,  6 May 2024 17:49:02 +0530
Message-Id: <20240506121906.76639-6-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240506121906.76639-1-atrajeev@linux.vnet.ibm.com>
References: <20240506121906.76639-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9rrM4wwGdWiNNomvsN4LeBRlWqsHd3ts
X-Proofpoint-ORIG-GUID: laSiEzdi6pM48hzDLlmc54HOt8WzG1xQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_07,2024-05-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405060085

Use the raw instruction code and macros to identify memory instructions,
extract register fields and also offset. The implementation addresses
the D-form, X-form, DS-form instructions. Two main functions are added.
New parse function "load_store__parse" as instruction ops parser for
memory instructions. Unlink other parser (like mov__parse), this parser
fills in only the "raw" field for source/target and new added "mem_ref"
field. This is because, here there is no need to parse the disassembled
code and arch specific macros will take care of extracting offset and
regs which is easier and will be precise.

In powerpc, all instructions with a primary opcode from 32 to 63
are memory instructions. Update "ins__find" function to have "opcode"
also as a parameter. Don't use the "extract_reg_offset", instead use
newly added function "get_arch_regs" which will set these fields: reg1,
reg2, offset depending of where it is source or target ops.

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/arch/powerpc/util/dwarf-regs.c | 33 +++++++++++++
 tools/perf/util/annotate.c                | 22 ++++++++-
 tools/perf/util/disasm.c                  | 59 +++++++++++++++++++++--
 tools/perf/util/disasm.h                  |  4 +-
 tools/perf/util/include/dwarf-regs.h      |  4 +-
 5 files changed, 114 insertions(+), 8 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/dwarf-regs.c b/tools/perf/arch/powerpc/util/dwarf-regs.c
index e60a71fd846e..3121c70dc0d3 100644
--- a/tools/perf/arch/powerpc/util/dwarf-regs.c
+++ b/tools/perf/arch/powerpc/util/dwarf-regs.c
@@ -102,6 +102,9 @@ int regs_query_register_offset(const char *name)
 #define	PPC_OP(op)	(((op) >> 26) & 0x3F)
 #define PPC_RA(a)	(((a) >> 16) & 0x1f)
 #define PPC_RT(t)	(((t) >> 21) & 0x1f)
+#define PPC_RB(b)	(((b) >> 11) & 0x1f)
+#define PPC_D(D)	((D) & 0xfffe)
+#define PPC_DS(DS)	((DS) & 0xfffc)
 
 int get_opcode_insn(unsigned int raw_insn)
 {
@@ -117,3 +120,33 @@ int get_target_reg(unsigned int raw_insn)
 {
 	return PPC_RT(raw_insn);
 }
+
+int get_offset_opcode(int raw_insn __maybe_unused)
+{
+	int opcode = PPC_OP(raw_insn);
+
+	/* DS- form */
+	if ((opcode == 58) || (opcode == 62))
+		return PPC_DS(raw_insn);
+	else
+		return PPC_D(raw_insn);
+}
+
+/*
+ * Fills the required fields for op_loc depending on if it
+ * is a source of target.
+ * D form: ins RT,D(RA) -> src_reg1 = RA, offset = D, dst_reg1 = RT
+ * DS form: ins RT,DS(RA) -> src_reg1 = RA, offset = DS, dst_reg1 = RT
+ * X form: ins RT,RA,RB -> src_reg1 = RA, src_reg2 = RB, dst_reg1 = RT
+ */
+void get_arch_regs(int raw_insn __maybe_unused, int is_source __maybe_unused, struct annotated_op_loc *op_loc __maybe_unused)
+{
+	if (is_source)
+		op_loc->reg1 = get_source_reg(raw_insn);
+	else
+		op_loc->reg1 = get_target_reg(raw_insn);
+	if (op_loc->multi_regs)
+		op_loc->reg2 = PPC_RB(raw_insn);
+	if (op_loc->mem_ref)
+		op_loc->offset = get_offset_opcode(raw_insn);
+}
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 0f5e10654d09..48739c7ffdc7 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2073,6 +2073,12 @@ static int extract_reg_offset(struct arch *arch, const char *str,
 	return 0;
 }
 
+__weak void get_arch_regs(int raw_insn __maybe_unused, int is_source __maybe_unused,
+		struct annotated_op_loc *op_loc __maybe_unused)
+{
+	return;
+}
+
 /**
  * annotate_get_insn_location - Get location of instruction
  * @arch: the architecture info
@@ -2117,10 +2123,12 @@ int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
 	for_each_insn_op_loc(loc, i, op_loc) {
 		const char *insn_str = ops->source.raw;
 		bool multi_regs = ops->source.multi_regs;
+		bool mem_ref = ops->source.mem_ref;
 
 		if (i == INSN_OP_TARGET) {
 			insn_str = ops->target.raw;
 			multi_regs = ops->target.multi_regs;
+			mem_ref = ops->target.mem_ref;
 		}
 
 		/* Invalidate the register by default */
@@ -2130,7 +2138,19 @@ int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
 		if (insn_str == NULL)
 			continue;
 
-		if (strchr(insn_str, arch->objdump.memory_ref_char)) {
+		/*
+		 * For powerpc, call get_arch_regs function which extracts the
+		 * required fields for op_loc, ie reg1, reg2, offset from the
+		 * raw instruction.
+		 */
+		if (arch__is(arch, "powerpc")) {
+			op_loc->mem_ref = mem_ref;
+			if ((!strchr(insn_str, '(')) && (i == INSN_OP_SOURCE))
+				op_loc->multi_regs = true;
+			get_arch_regs(ops->raw_insn, !i, op_loc);
+			if (op_loc->multi_regs)
+				op_loc->offset = 0;
+		} else if (strchr(insn_str, arch->objdump.memory_ref_char)) {
 			op_loc->mem_ref = true;
 			op_loc->multi_regs = multi_regs;
 			extract_reg_offset(arch, insn_str, op_loc);
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 85692f73e78f..f41a0fadeab4 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -515,7 +515,7 @@ static int lock__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 	if (disasm_line__parse(ops->raw, &ops->locked.ins.name, &ops->locked.ops->raw, &ops->locked.ins.opcode, &ops->locked.ops->raw_insn) < 0)
 		goto out_free_ops;
 
-	ops->locked.ins.ops = ins__find(arch, ops->locked.ins.name);
+	ops->locked.ins.ops = ins__find(arch, ops->locked.ins.name, 0);
 
 	if (ops->locked.ins.ops == NULL)
 		goto out_free_ops;
@@ -670,6 +670,46 @@ static struct ins_ops mov_ops = {
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
+ * Sets only two fields "raw" and "mem_ref".
+ * "mem_ref" is set for ops->source which is later used to
+ * fill the objdump->memory_ref-char field. This ops is currently
+ * used by powerpc and since binary instruction code is used to
+ * extract opcode, regs and offset, no other parsing is needed here
+ */
+static int load_store__parse(struct arch *arch __maybe_unused, struct ins_operands *ops, struct map_symbol *ms __maybe_unused)
+{
+	ops->source.raw = strdup(ops->raw);
+	ops->source.mem_ref = true;
+
+	if (ops->source.raw == NULL)
+		return -1;
+
+	ops->target.raw = strdup(ops->raw);
+	ops->target.mem_ref = false;
+
+	if (ops->target.raw == NULL)
+		goto out_free_source;
+
+	return 0;
+
+out_free_source:
+	zfree(&ops->source.raw);
+	return -1;
+}
+
+static struct ins_ops load_store_ops = {
+	.parse     = load_store__parse,
+	.scnprintf = load_store__scnprintf,
+};
+
 static int dec__parse(struct arch *arch __maybe_unused, struct ins_operands *ops, struct map_symbol *ms __maybe_unused)
 {
 	char *target, *comment, *s, prev;
@@ -760,11 +800,20 @@ static void ins__sort(struct arch *arch)
 	qsort(arch->instructions, nmemb, sizeof(struct ins), ins__cmp);
 }
 
-static struct ins_ops *__ins__find(struct arch *arch, const char *name)
+static struct ins_ops *__ins__find(struct arch *arch, const char *name, int opcode)
 {
 	struct ins *ins;
 	const int nmemb = arch->nr_instructions;
 
+	if (arch__is(arch, "powerpc")) {
+		/*
+		 * Instructions with a primary opcode from 32 to 63
+		 * are memory instructions in powerpc.
+		 */
+		if ((opcode >= 31) && (opcode <= 63))
+			return &load_store_ops;
+	}
+
 	if (!arch->sorted_instructions) {
 		ins__sort(arch);
 		arch->sorted_instructions = true;
@@ -794,9 +843,9 @@ static struct ins_ops *__ins__find(struct arch *arch, const char *name)
 	return ins ? ins->ops : NULL;
 }
 
-struct ins_ops *ins__find(struct arch *arch, const char *name)
+struct ins_ops *ins__find(struct arch *arch, const char *name, int opcode)
 {
-	struct ins_ops *ops = __ins__find(arch, name);
+	struct ins_ops *ops = __ins__find(arch, name, opcode);
 
 	if (!ops && arch->associate_instruction_ops)
 		ops = arch->associate_instruction_ops(arch, name);
@@ -806,7 +855,7 @@ struct ins_ops *ins__find(struct arch *arch, const char *name)
 
 static void disasm_line__init_ins(struct disasm_line *dl, struct arch *arch, struct map_symbol *ms)
 {
-	dl->ins.ops = ins__find(arch, dl->ins.name);
+	dl->ins.ops = ins__find(arch, dl->ins.name, dl->ins.opcode);
 
 	if (!dl->ins.ops)
 		return;
diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
index 5c1520010ca7..ed8875b35bfe 100644
--- a/tools/perf/util/disasm.h
+++ b/tools/perf/util/disasm.h
@@ -61,6 +61,7 @@ struct ins_operands {
 		bool	offset_avail;
 		bool	outside;
 		bool	multi_regs;
+		bool	mem_ref;
 	} target;
 	union {
 		struct {
@@ -70,6 +71,7 @@ struct ins_operands {
 			int	raw_insn;
 			u64	addr;
 			bool	multi_regs;
+			bool	mem_ref;
 		} source;
 		struct {
 			struct ins	    ins;
@@ -103,7 +105,7 @@ struct annotate_args {
 struct arch *arch__find(const char *name);
 bool arch__is(struct arch *arch, const char *name);
 
-struct ins_ops *ins__find(struct arch *arch, const char *name);
+struct ins_ops *ins__find(struct arch *arch, const char *name, int opcode);
 int ins__scnprintf(struct ins *ins, char *bf, size_t size,
 		   struct ins_operands *ops, int max_ins_name);
 
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index 2a4e1e16e52c..d691245dd703 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _PERF_DWARF_REGS_H_
 #define _PERF_DWARF_REGS_H_
+#include "annotate.h"
 
 #define DWARF_REG_PC  0xd3af9c /* random number */
 #define DWARF_REG_FB  0xd3affb /* random number */
@@ -39,7 +40,8 @@ static inline int get_dwarf_regnum(const char *name __maybe_unused,
 int get_opcode_insn(unsigned int raw_insn);
 int get_source_reg(unsigned int raw_insn);
 int get_target_reg(unsigned int raw_insn);
-
+int get_offset_opcode(int raw_insn);
+void get_arch_regs(int raw_insn, int is_source, struct annotated_op_loc *op_loc);
 #ifdef HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET
 /*
  * Arch should support fetching the offset of a register in pt_regs
-- 
2.43.0


