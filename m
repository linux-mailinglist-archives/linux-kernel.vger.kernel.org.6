Return-Path: <linux-kernel+bounces-560932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FA9A60B28
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAD8919C23D5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291041CD1E4;
	Fri, 14 Mar 2025 08:20:48 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62461624FC;
	Fri, 14 Mar 2025 08:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940447; cv=none; b=YIi3FfYBpvbr4QwUIHPRptaRRO7oGi71pA4wpeRmGT2R4ac7LjPM0nPufr/NQ1wOViF860xNXKIUH4d+RAa1n3Ysg8R+yj2GoPgn8ZRdVGxc5YJmEgnhQAwxV8dM8OLpI9Oca22d4wFaN1cSKJ8wHOfZOUXdHcX7krtrbKJ+cI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940447; c=relaxed/simple;
	bh=wE9SWS1JbvsNO/jWauT1b7kaE9hGVKSk7FUnsshtdTo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JRz4r7uG7S7KJ6h+HGxuRHBVr7Lzasj2GFUmn4k4VyP6ssXYuSdQJqAuOnnDJYbp1TQJpeUTjfxIqpF2B5TTTTUGMi9YqGkMCHZ8uL71W+AmTyo3nMK4q/ULn/32D3nS7utH6tf0WoPoRPkBntAud6i+poJCkw+rdxY8E45OBzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZDcfC6PFrzvWsF;
	Fri, 14 Mar 2025 16:16:51 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 42B101401F3;
	Fri, 14 Mar 2025 16:20:43 +0800 (CST)
Received: from lihuafei.huawei.com (10.90.53.74) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 14 Mar 2025 16:20:42 +0800
From: Li Huafei <lihuafei1@huawei.com>
To: <namhyung@kernel.org>, <acme@kernel.org>, <leo.yan@linux.dev>,
	<james.clark@linaro.org>, <mark.rutland@arm.com>, <john.g.garry@oracle.com>,
	<will@kernel.org>, <irogers@google.com>
CC: <mike.leach@linaro.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<kjain@linux.ibm.com>, <mhiramat@kernel.org>, <atrajeev@linux.vnet.ibm.com>,
	<sesse@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <lihuafei1@huawei.com>
Subject: [PATCH 7/7] perf annotate-data: Handle the access to the 'current' pointer on arm64
Date: Sat, 15 Mar 2025 00:21:37 +0800
Message-ID: <20250314162137.528204-8-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250314162137.528204-1-lihuafei1@huawei.com>
References: <20250314162137.528204-1-lihuafei1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf500004.china.huawei.com (7.202.181.242)

According to the implementation of the 'current' macro on ARM64, the
sp_el0 register stores the pointer to the current task's task_struct.
For example:

 mrs x1, sp_el0
 ldr x2, [x1, #1896]

We can infer that the ldr instruction is accessing a member of the
task_struct structure at an offset of 1896. The key is to construct the
data type for x1. The instruction 'mrs x1, sp_el0' belongs to the inline
function get_current(). By finding the DIE of the inline function
through its instruction address, and then obtaining the DIE for its
return type, which should be 'struct task_struct *'. Then, we update the
register state of x1 with this type information.

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 tools/perf/arch/arm64/annotate/instructions.c | 71 +++++++++++++++----
 1 file changed, 57 insertions(+), 14 deletions(-)

diff --git a/tools/perf/arch/arm64/annotate/instructions.c b/tools/perf/arch/arm64/annotate/instructions.c
index f2053e7f60a8..c5a0a6381547 100644
--- a/tools/perf/arch/arm64/annotate/instructions.c
+++ b/tools/perf/arch/arm64/annotate/instructions.c
@@ -263,6 +263,20 @@ update_insn_state_arm64(struct type_state *state, struct data_loc_info *dloc,
 	Dwarf_Die type_die;
 	int sreg, dreg;
 	u32 insn_offset = dl->al.offset;
+	static regex_t add_regex, mrs_regex;
+	static bool regex_compiled;
+
+	if (!regex_compiled) {
+		/*
+		 * Matching the operand assembly syntax of the add instruction:
+		 *
+		 *  <Xd|SP>, <Xn|SP>, #<imm>
+		 */
+		regcomp(&add_regex, "^([xw][0-9]{1,2}|sp), ([xw][0-9]{1,2}|sp), #(0x[0-9a-f]+)",
+			REG_EXTENDED);
+		regcomp(&mrs_regex, "^(x[0-9]{1,2}), sp_el0", REG_EXTENDED);
+		regex_compiled = true;
+	}
 
 	/* Access global variables via PC relative addressing, for example:
 	 *
@@ -296,20 +310,6 @@ update_insn_state_arm64(struct type_state *state, struct data_loc_info *dloc,
 		regmatch_t match[4];
 		char *ops = strdup(dl->ops.raw);
 		u64 offset;
-		static regex_t add_regex;
-		static bool regex_compiled;
-
-		/*
-		 * Matching the operand assembly syntax of the add instruction:
-		 *
-		 *  <Xd|SP>, <Xn|SP>, #<imm>
-		 */
-		if (!regex_compiled) {
-			regcomp(&add_regex,
-				"^([xw][0-9]{1,2}|sp), ([xw][0-9]{1,2}|sp), #(0x[0-9a-f]+)",
-				REG_EXTENDED);
-			regex_compiled = true;
-		}
 
 		if (!ops)
 			return;
@@ -351,6 +351,49 @@ update_insn_state_arm64(struct type_state *state, struct data_loc_info *dloc,
 		return;
 	}
 
+	if (!strncmp(dl->ins.name, "mrs", 3)) {
+		regmatch_t match[2];
+		char *ops = strdup(dl->ops.raw);
+		Dwarf_Die func_die;
+		Dwarf_Attribute attr;
+		u64 ip = dloc->ms->sym->start + dl->al.offset;
+		u64 pc = map__rip_2objdump(dloc->ms->map, ip);
+
+		if (!ops)
+			return;
+
+		if (regexec(&mrs_regex, dl->ops.raw, 2, match, 0))
+			return;
+
+		ops[match[1].rm_eo] = '\0';
+		sreg = get_arm64_regnum(ops + match[1].rm_so);
+		if (sreg < 0 || !has_reg_type(state, sreg)) {
+			free(ops);
+			return;
+		}
+
+		/*
+		 * Find the inline function 'get_current()' Dwarf_Die and
+		 * obtain its return value data type, which should be
+		 * 'struct task_struct *'.
+		 */
+		if (!die_find_inlinefunc(cu_die, pc, &func_die) ||
+		    !dwarf_attr_integrate(&func_die, DW_AT_type, &attr) ||
+		    !dwarf_formref_die(&attr, &type_die)) {
+			free(ops);
+			return;
+		}
+
+		tsr = &state->regs[sreg];
+		tsr->type = type_die;
+		tsr->kind = TSR_KIND_TYPE;
+		tsr->ok = true;
+
+		pr_debug_dtp("mrs sp_el0 [%x] -> reg%d", insn_offset, sreg);
+		free(ops);
+		return;
+	}
+
 	if (strncmp(dl->ins.name, "ld", 2))
 		return;
 
-- 
2.25.1


