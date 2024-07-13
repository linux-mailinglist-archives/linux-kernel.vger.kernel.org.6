Return-Path: <linux-kernel+bounces-251567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AD7930676
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 18:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 034901C21605
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 16:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B260D13DDDD;
	Sat, 13 Jul 2024 16:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nMLb6kpz"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCFF13B2A5;
	Sat, 13 Jul 2024 16:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720889770; cv=none; b=g+zHEdXrISAYhtmWPqaLkaNxZVj3jb6YoLFxW2ThsxlESmn4EE6eQEbVNTsdfNmztW3wCoUZWd6SJfUSQ56CPc0UOl9S8X0HifNLfpCzB33jaAicDmYgtEBivN9B3lAD8GQsWr1FqnKXYHGHppizSQ7J3OIZ+3eOsDf1POIfwYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720889770; c=relaxed/simple;
	bh=qwB6uK58UQUqn5Kq4WMFaqB1p0YB9Eg+nSdMG+3FnW0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UVsSwgt37+K3N86/L7dVlkpxFL1RYXvLIBHV5kwD/6BS5vWfA3U1e0YHY02ecAYYxmEaKvNBOg17Zo4V+fUwWyyipKaXTnkmIfbiW3H/d5awrnw9mHw3jcljkUIvsmyIbM0sFMM7jprRSyWEexW+IWjExRVxw9HX5blMxMEV0aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nMLb6kpz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46DFvwXK014070;
	Sat, 13 Jul 2024 16:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=1QkskZTbdRvhn
	p2MD0R0LEE4ukOfx3h9/vfG8+TP2SU=; b=nMLb6kpzonn8YayiEuRLCuhL2sVYS
	hF4feVkllcob3PZUPXofhhedqfgrydLF2fQUHpDWHRwRbh/eviQfZtMW/1HENRcd
	Dm7Yu1EJcOSu1T/NG5/gxuxpLR5ousOBQqPH+z0/J0v67BC/3QT58LBJR7lnofxi
	uDtw9EfL+4kTfMrlEN8c5BBGib4okjm/Bn99yh0nhr4vxyHnFXUWQn2dXAwHR+GA
	e2bOkx1iBUzNHN3SIromBqJb+UtXJmk5gRs55Oz7Yq7WMK4ug4AXBmyJQUXdNgF4
	QuDVWq4ii69clsgTLE64+aVMR1knAs1+lqgaFj1XbBWOpLKGcMFGyCAjg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40bv8gg3wf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jul 2024 16:55:56 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46DGtukN029727;
	Sat, 13 Jul 2024 16:55:56 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40bv8gg3w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jul 2024 16:55:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46DFTjk6013931;
	Sat, 13 Jul 2024 16:55:54 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 407gn1cfy4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jul 2024 16:55:54 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46DGtmmW48955674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Jul 2024 16:55:50 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1A6920040;
	Sat, 13 Jul 2024 16:55:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E80C620043;
	Sat, 13 Jul 2024 16:55:45 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.49.134])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 13 Jul 2024 16:55:45 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org, segher@kernel.crashing.org,
        christophe.leroy@csgroup.eu
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH V7 04/18] tools/perf: Add disasm_line__parse to parse raw instruction for powerpc
Date: Sat, 13 Jul 2024 22:25:15 +0530
Message-Id: <20240713165529.59298-5-atrajeev@linux.vnet.ibm.com>
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
X-Proofpoint-GUID: Tbq_firha9Pt94Ki8BejmPnBz2RrAVPE
X-Proofpoint-ORIG-GUID: 5XXsSq_9HXxEQN5SeNXc6QYY9UG0Skd9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-13_13,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407130127

Currently, the perf tool infrastructure disasm_line__parse function to
parse disassembled line.

Example snippet from objdump:
objdump  --start-address=<address> --stop-address=<address>  -d --no-show-raw-insn -C <vmlinux>

c0000000010224b4:	lwz     r10,0(r9)

This line "lwz r10,0(r9)" is parsed to extract instruction name,
registers names and offset. In powerpc, the approach for data type
profiling uses raw instruction instead of result from objdump to identify
the instruction category and extract the source/target registers.

Example: 38 01 81 e8     ld      r4,312(r1)

Here "38 01 81 e8" is the raw instruction representation. Add function
"disasm_line__parse_powerpc" to handle parsing of raw instruction.
Also update "struct disasm_line" to save the binary code/
With the change, function captures:

line -> "38 01 81 e8     ld      r4,312(r1)"
raw instruction "38 01 81 e8"

Raw instruction is used later to extract the reg/offset fields. Macros
are added to extract opcode and register fields. "struct disasm_line"
is updated to carry union of "bytes" and "raw_insn" of 32 bit to carry raw
code (raw). Function "disasm_line__parse_powerpc fills the raw
instruction hex value and can use macros to get opcode. There is no
changes in existing code paths, which parses the disassembled code.
The size of raw instruction depends on architecture. In case of powerpc,
the parsing the disasm line needs to handle cases for reading binary code
directly from DSO as well as parsing the objdump result. Hence adding
the logic into separate function instead of updating "disasm_line__parse".
The architecture using the instruction name and present approach is
not altered. Since this approach targets powerpc, the macro
implementation is added for powerpc as of now.

Since the disasm_line__parse is used in other cases (perf annotate) and
not only data tye profiling, the powerpc callback includes changes to
work with binary code as well as mneumonic representation. Also in case
if the DSO read fails and libcapstone is not supported, the approach
fallback to use objdump as option. Hence as option, patch has changes to
ensure objdump option also works well.

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/include/linux/string.h                  |  2 +
 tools/lib/string.c                            | 13 +++++
 .../perf/arch/powerpc/annotate/instructions.c |  1 +
 tools/perf/arch/powerpc/util/dwarf-regs.c     |  9 ++++
 tools/perf/util/annotate.h                    |  5 +-
 tools/perf/util/disasm.c                      | 48 ++++++++++++++++++-
 6 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/tools/include/linux/string.h b/tools/include/linux/string.h
index db5c99318c79..0acb1fc14e19 100644
--- a/tools/include/linux/string.h
+++ b/tools/include/linux/string.h
@@ -46,5 +46,7 @@ extern char * __must_check skip_spaces(const char *);
 
 extern char *strim(char *);
 
+extern void remove_spaces(char *s);
+
 extern void *memchr_inv(const void *start, int c, size_t bytes);
 #endif /* _TOOLS_LINUX_STRING_H_ */
diff --git a/tools/lib/string.c b/tools/lib/string.c
index 8b6892f959ab..3126d2cff716 100644
--- a/tools/lib/string.c
+++ b/tools/lib/string.c
@@ -153,6 +153,19 @@ char *strim(char *s)
 	return skip_spaces(s);
 }
 
+/*
+ * remove_spaces - Removes whitespaces from @s
+ */
+void remove_spaces(char *s)
+{
+	char *d = s;
+
+	do {
+		while (*d == ' ')
+			++d;
+	} while ((*s++ = *d++));
+}
+
 /**
  * strreplace - Replace all occurrences of character in string.
  * @s: The string to operate on.
diff --git a/tools/perf/arch/powerpc/annotate/instructions.c b/tools/perf/arch/powerpc/annotate/instructions.c
index a3f423c27cae..d57fd023ef9c 100644
--- a/tools/perf/arch/powerpc/annotate/instructions.c
+++ b/tools/perf/arch/powerpc/annotate/instructions.c
@@ -55,6 +55,7 @@ static int powerpc__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 		arch->initialized = true;
 		arch->associate_instruction_ops = powerpc__associate_instruction_ops;
 		arch->objdump.comment_char      = '#';
+		annotate_opts.show_asm_raw = true;
 	}
 
 	return 0;
diff --git a/tools/perf/arch/powerpc/util/dwarf-regs.c b/tools/perf/arch/powerpc/util/dwarf-regs.c
index 0c4f4caf53ac..430623ca5612 100644
--- a/tools/perf/arch/powerpc/util/dwarf-regs.c
+++ b/tools/perf/arch/powerpc/util/dwarf-regs.c
@@ -98,3 +98,12 @@ int regs_query_register_offset(const char *name)
 			return roff->ptregs_offset;
 	return -EINVAL;
 }
+
+#define PPC_OP(op)	(((op) >> 26) & 0x3F)
+#define PPC_RA(a)	(((a) >> 16) & 0x1f)
+#define PPC_RT(t)	(((t) >> 21) & 0x1f)
+#define PPC_RB(b)	(((b) >> 11) & 0x1f)
+#define PPC_D(D)	((D) & 0xfffe)
+#define PPC_DS(DS)	((DS) & 0xfffc)
+#define OP_LD	58
+#define OP_STD	62
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index d5c821c22f79..9ba772f46270 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -113,7 +113,10 @@ struct annotation_line {
 struct disasm_line {
 	struct ins		 ins;
 	struct ins_operands	 ops;
-
+	union {
+		u8 bytes[4];
+		u32 raw_insn;
+	} raw;
 	/* This needs to be at the end. */
 	struct annotation_line	 al;
 };
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index d2723ba024bf..a53591a6111e 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -44,6 +44,7 @@ static int call__scnprintf(struct ins *ins, char *bf, size_t size,
 
 static void ins__sort(struct arch *arch);
 static int disasm_line__parse(char *line, const char **namep, char **rawp);
+static int disasm_line__parse_powerpc(struct disasm_line *dl);
 
 static __attribute__((constructor)) void symbol__init_regexpr(void)
 {
@@ -845,6 +846,48 @@ static int disasm_line__parse(char *line, const char **namep, char **rawp)
 	return -1;
 }
 
+/*
+ * Parses the result captured from symbol__disassemble_*
+ * Example, line read from DSO file in powerpc:
+ * line:    38 01 81 e8
+ * opcode: fetched from arch specific get_opcode_insn
+ * rawp_insn: e8810138
+ *
+ * rawp_insn is used later to extract the reg/offset fields
+ */
+#define	PPC_OP(op)	(((op) >> 26) & 0x3F)
+#define	RAW_BYTES	11
+
+static int disasm_line__parse_powerpc(struct disasm_line *dl)
+{
+	char *line = dl->al.line;
+	const char **namep = &dl->ins.name;
+	char **rawp = &dl->ops.raw;
+	char *tmp_raw_insn, *name_raw_insn = skip_spaces(line);
+	char *name = skip_spaces(name_raw_insn + RAW_BYTES);
+	int objdump = 0;
+
+	if (strlen(line) > RAW_BYTES)
+		objdump = 1;
+
+	if (name_raw_insn[0] == '\0')
+		return -1;
+
+	if (objdump) {
+		disasm_line__parse(name, namep, rawp);
+	} else
+		*namep = "";
+
+	tmp_raw_insn = strndup(name_raw_insn, 11);
+	remove_spaces(tmp_raw_insn);
+
+	sscanf(tmp_raw_insn, "%x", &dl->raw.raw_insn);
+	if (objdump)
+		dl->raw.raw_insn = be32_to_cpu(dl->raw.raw_insn);
+
+	return 0;
+}
+
 static void annotation_line__init(struct annotation_line *al,
 				  struct annotate_args *args,
 				  int nr)
@@ -898,7 +941,10 @@ struct disasm_line *disasm_line__new(struct annotate_args *args)
 		goto out_delete;
 
 	if (args->offset != -1) {
-		if (disasm_line__parse(dl->al.line, &dl->ins.name, &dl->ops.raw) < 0)
+		if (arch__is(args->arch, "powerpc")) {
+			if (disasm_line__parse_powerpc(dl) < 0)
+				goto out_free_line;
+		} else if (disasm_line__parse(dl->al.line, &dl->ins.name, &dl->ops.raw) < 0)
 			goto out_free_line;
 
 		disasm_line__init_ins(dl, args->arch, &args->ms);
-- 
2.43.0


