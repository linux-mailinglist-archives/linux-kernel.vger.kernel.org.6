Return-Path: <linux-kernel+bounces-197712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B517E8D6E4E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 08:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21A461F2558B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 06:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5879414A96;
	Sat,  1 Jun 2024 06:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QHtxLEts"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA035731B;
	Sat,  1 Jun 2024 06:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717222242; cv=none; b=eG+5b+X9ERn3kIkZh99X+6VDzcisDuscj3c6MK4W4JmFav6mDLC2a07cV7uma3nHFA9L8Zp+C7IwjzgBn8c3NAHjsuR6lSvOgimnUHeXsH3NrO/sUvT/WEWCCvWpOs+jJMCUq+aYrATdh+dBocPfgKp09RNmFGh95nLBlC44iHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717222242; c=relaxed/simple;
	bh=gWzmi3+Gk8BiDAK6Z6ioDuVRHJmNUMh2nvgBLa6trIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=abN/jC1tUME/Sn+nTpe0U0PprryyC3kmU8WKvZ2Ut/xK1ueTZzEVhC8H3DfLZMNTzYaZrL8Gifw2bM+MQlhviBfFz8fXGfTaBDOrr3F/a8weSRwMmOG9/DMuPkOxXXZy/rbcwuizga0bU5qmPiuhyNmGrGVeTvW0Zc4mhCY65/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QHtxLEts; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4515ug4C032731;
	Sat, 1 Jun 2024 06:10:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : date : from : in-reply-to : message-id :
 mime-version : references : subject : to; s=pp1;
 bh=ZnEp/PqDCFahEmOwvpOVk+u+6JEKsxRT4H0U54ElBdw=;
 b=QHtxLEtsJywr4/bf2CJ3yTlkx/HVLM88BHn/Fden+If+Iy/6url7XMhOexpRBy/iOi9w
 VItG8wd8ErGn12Ye8bcyC+RQrPfbouJtJuSEzyDoiXrsyUdBdqMhrm7z8z/XkhSLfVHz
 E+lff1PgUh3SIF3NxOSJfHZwqgpkrE1tVeeBzsoXQZO44BDfZOxJQV1E9yvgZhg87qSs
 XpWp3XjfY5LWj1PpLsC6bKNLRQkRG3hQLprc/suQU+0ehGAF8dBBltMi/PUrmvZUjbND
 nZ6m2mVRsXEIJU60JCf4wbg9SnnYygfJIw+o6SlhdSR7ECh24qZTGKmm1dex645j7gcz TA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yfvq0g63e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Jun 2024 06:10:32 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4516AWY1025323;
	Sat, 1 Jun 2024 06:10:32 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yfvq0g63c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Jun 2024 06:10:32 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4514JPd7003178;
	Sat, 1 Jun 2024 06:10:31 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yfv3j0j6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Jun 2024 06:10:30 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4516APAK33620678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 1 Jun 2024 06:10:27 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D5FE20043;
	Sat,  1 Jun 2024 06:10:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 227EC20040;
	Sat,  1 Jun 2024 06:10:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.41.43])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  1 Jun 2024 06:10:21 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org, segher@kernel.crashing.org,
        christophe.leroy@csgroup.eu
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH V3 10/14] tools/perf: Update instruction tracking for powerpc
Date: Sat,  1 Jun 2024 11:39:37 +0530
Message-Id: <20240601060941.13692-11-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240601060941.13692-1-atrajeev@linux.vnet.ibm.com>
References: <20240601060941.13692-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HNaCubovooNC5VjHC_ik1-HSBoJyaQlO
X-Proofpoint-GUID: 8WBfUpjLaDMKeWreF6OKDAB48pYRZsAC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-01_01,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2405010000 definitions=main-2406010045

Add instruction tracking function "update_insn_state_powerpc" for
powerpc. Example sequence in powerpc:

ld      r10,264(r3)
mr      r31,r3
<<after some sequence>
ld      r9,312(r31)

Consider ithe sample is pointing to: "ld r9,312(r31)".
Here the memory reference is hit at "312(r31)" where 312 is the offset
and r31 is the source register. Previous instruction sequence shows that
register state of r3 is moved to r31. So to identify the data type for r31
access, the previous instruction ("mr") needs to be tracked and the
state type entry has to be updated. Current instruction tracking support
in perf tools infrastructure is specific to x86. Patch adds this support
for powerpc as well.

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 .../perf/arch/powerpc/annotate/instructions.c | 65 +++++++++++++++++++
 tools/perf/util/annotate-data.c               |  9 ++-
 tools/perf/util/disasm.c                      |  1 +
 3 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/powerpc/annotate/instructions.c b/tools/perf/arch/powerpc/annotate/instructions.c
index db72148eb857..3ecf5a986037 100644
--- a/tools/perf/arch/powerpc/annotate/instructions.c
+++ b/tools/perf/arch/powerpc/annotate/instructions.c
@@ -231,6 +231,71 @@ static struct ins_ops *check_ppc_insn(int raw_insn)
 	return NULL;
 }
 
+/*
+ * Instruction tracking function to track register state moves.
+ * Example sequence:
+ *    ld      r10,264(r3)
+ *    mr      r31,r3
+ *    <<after some sequence>
+ *    ld      r9,312(r31)
+ *
+ * Previous instruction sequence shows that register state of r3
+ * is moved to r31. update_insn_state_powerpc tracks these state
+ * changes
+ */
+#ifdef HAVE_DWARF_SUPPORT
+static void update_insn_state_powerpc(struct type_state *state,
+		struct data_loc_info *dloc, Dwarf_Die * cu_die __maybe_unused,
+		struct disasm_line *dl)
+{
+	struct annotated_insn_loc loc;
+	struct annotated_op_loc *src = &loc.ops[INSN_OP_SOURCE];
+	struct annotated_op_loc *dst = &loc.ops[INSN_OP_TARGET];
+	struct type_state_reg *tsr;
+	u32 insn_offset = dl->al.offset;
+
+	if (annotate_get_insn_location(dloc->arch, dl, &loc) < 0)
+		return;
+
+	/*
+	 * Value 444 for bits 21:30 is for "mr"
+	 * instruction. "mr" is extended OR. So set the
+	 * source and destination reg correctly
+	 */
+	if (PPC_21_30(dl->ops.raw_insn) == 444) {
+		int src_reg = src->reg1;
+
+		src->reg1 = dst->reg1;
+		dst->reg1 = src_reg;
+	}
+
+	if (!has_reg_type(state, dst->reg1))
+		return;
+
+	tsr = &state->regs[dst->reg1];
+
+	if (!has_reg_type(state, src->reg1) ||
+			!state->regs[src->reg1].ok) {
+		tsr->ok = false;
+		return;
+	}
+
+	tsr->type = state->regs[src->reg1].type;
+	tsr->kind = state->regs[src->reg1].kind;
+	tsr->ok = true;
+
+	pr_debug("mov [%x] reg%d -> reg%d",
+			insn_offset, src->reg1, dst->reg1);
+	pr_debug_type_name(&tsr->type, tsr->kind);
+}
+#else /* HAVE_DWARF_SUPPORT */
+static void update_insn_state_powerpc(struct type_state *state __maybe_unused, struct data_loc_info *dloc __maybe_unused,
+		Dwarf_Die * cu_die __maybe_unused, struct disasm_line *dl __maybe_unused)
+{
+	return;
+}
+#endif /* HAVE_DWARF_SUPPORT */
+
 static int powerpc__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 {
 	if (!arch->initialized) {
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 7a48c3d72b89..734acdd8c4b7 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -1080,6 +1080,13 @@ static int find_data_type_insn(struct data_loc_info *dloc,
 	return ret;
 }
 
+static int arch_supports_insn_tracking(struct data_loc_info *dloc)
+{
+	if ((arch__is(dloc->arch, "x86")) || (arch__is(dloc->arch, "powerpc")))
+		return 1;
+	return 0;
+}
+
 /*
  * Construct a list of basic blocks for each scope with variables and try to find
  * the data type by updating a type state table through instructions.
@@ -1094,7 +1101,7 @@ static int find_data_type_block(struct data_loc_info *dloc,
 	int ret = -1;
 
 	/* TODO: other architecture support */
-	if (!arch__is(dloc->arch, "x86"))
+	if (!arch_supports_insn_tracking(dloc))
 		return -1;
 
 	prev_dst_ip = dst_ip = dloc->ip;
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 57af4dc42a58..d8b357055302 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -155,6 +155,7 @@ static struct arch architectures[] = {
 	{
 		.name = "powerpc",
 		.init = powerpc__annotate_init,
+		.update_insn_state = update_insn_state_powerpc,
 	},
 	{
 		.name = "riscv64",
-- 
2.43.0


