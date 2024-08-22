Return-Path: <linux-kernel+bounces-296252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 221F895A82D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 01:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73189B21927
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 23:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F334D17E01C;
	Wed, 21 Aug 2024 23:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLgekLp8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED90117DFEC;
	Wed, 21 Aug 2024 23:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724282792; cv=none; b=pnx/diQ05KaiYE/AOwSeSGY0eOALFLoc/Mxm4q/S/lgI7pqjpZflQBSKdmK2wX3yq8GqP1K5u9jMbl3xkTmiZQjMUrmWH6WVqVvT/OMpHl+RxTdkaALw0arAFQ782YRMQ2ZrXaQ2xglUQg4VUb4VyQIzAp1N7fjbKyAr6GMkyDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724282792; c=relaxed/simple;
	bh=YetaJCsMe1jW2DeFg6AkdVEOqTo94MXBhxk32FnOM8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kvf7x87k1xJuMPyyMsZ7ZdcVjKSkUZ3Pd3VoHClsNs5+c+zOe6Pt/QkY/BauCVGa8zbf01zFG/2+XZ0OMmagJgl2NxU3vavIuxXAAqRlV4HXTwIoKUNoeoz5TsPkKry5e/mcVhSsurGs0VWXSYN6cpT920gDixPIUU/sHsGxUSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLgekLp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DA7C32782;
	Wed, 21 Aug 2024 23:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724282791;
	bh=YetaJCsMe1jW2DeFg6AkdVEOqTo94MXBhxk32FnOM8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sLgekLp8NYawdzslIQeQm+3resmqR2T6RqOX7gXDnaWiIRmF5/VLWbE6P5DpkXF93
	 DKK0T6HWZWawcVkXIprbwMtjK3I01vlSylzYCa44Wh1ZSy5Ojm+CJOz8xLfzY7Ebpz
	 LFcl1o3BpZT6pealC9D/C5fk7BEiEm/5qz7svCT6BbMnzbd8b3nVCyUpo8A24SJxDc
	 IUQF3umGli6Oz46G3fqpdEsrDcLHQgMOr58Hrpnx7Xz1qetn9ZcYyGJ8bGU4MZ4oSC
	 l1Xg+y6cJ0/yaKsxXmbbKp0RGvOl3FcVllZw0ljFrzQVsc8ZRw29MIZwjmBIDSFn0l
	 e3HvfJxWkHgBA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH 4/4] perf annotate-data: Copy back variable types after move
Date: Wed, 21 Aug 2024 16:26:28 -0700
Message-ID: <20240821232628.353177-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
In-Reply-To: <20240821232628.353177-1-namhyung@kernel.org>
References: <20240821232628.353177-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some cases, compilers don't set the location expression in DWARF
precisely.  For instance, it may assign a variable to a register after
copying it from a different register.  Then it should use the register
for the new type but still uses the old register.  This makes hard to
track the type information properly.

This is an example I found in __tcp_transmit_skb().  The first argument
(sk) of this function is a pointer to sock and there's a variable (tp)
for tcp_sock.

  static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
  				int clone_it, gfp_t gfp_mask, u32 rcv_nxt)
  {
  	...
  	struct tcp_sock *tp;

  	BUG_ON(!skb || !tcp_skb_pcount(skb));
  	tp = tcp_sk(sk);
  	prior_wstamp = tp->tcp_wstamp_ns;
  	tp->tcp_wstamp_ns = max(tp->tcp_wstamp_ns, tp->tcp_clock_cache);
  	...

So it basically calls tcp_sk(sk) to get the tcp_sock pointer from sk.
But it turned out to be the same value because tcp_sock embeds sock as
the first member.  The sk is located in reg5 (RDI) and tp is in reg3
(RBX).  The offset of tcp_wstamp_ns is 0x748 and tcp_clock_cache is
0x750.  So you need to use RBX (reg3) to access the fields in the
tcp_sock.  But the code used RDI (reg5) as it has the same value.

  $ pahole --hex -C tcp_sock vmlinux | grep -e 748 -e 750
	u64                tcp_wstamp_ns;        /* 0x748   0x8 */
	u64                tcp_clock_cache;      /* 0x750   0x8 */

And this is the disassembly of the part of the function.

  <__tcp_transmit_skb>:
  ...
  44:  mov    %rdi, %rbx
  47:  mov    0x748(%rdi), %rsi
  4e:  mov    0x750(%rdi), %rax
  55:  cmp    %rax, %rsi

Because compiler put the debug info to RBX, it only knows RDI is a
pointer to sock and accessing those two fields resulted in error
due to offset being beyond the type size.

  -----------------------------------------------------------
  find data type for 0x748(reg5) at __tcp_transmit_skb+0x63
  CU for net/ipv4/tcp_output.c (die:0x817f543)
  frame base: cfa=0 fbreg=6
  scope: [1/1] (die:81aac3e)
  bb: [0 - 30]
  var [0] -0x98(stack) type='struct tcp_out_options' size=0x28 (die:0x81af3df)
  var [5] reg8 type='unsigned int' size=0x4 (die:0x8180ed6)
  var [5] reg2 type='unsigned int' size=0x4 (die:0x8180ed6)
  var [5] reg1 type='int' size=0x4 (die:0x818059e)
  var [5] reg4 type='struct sk_buff*' size=0x8 (die:0x8181360)
  var [5] reg5 type='struct sock*' size=0x8 (die:0x8181a0c)                   <<<--- the first argument ('sk' at %RDI)
  mov [19] reg8 -> -0xa8(stack) type='unsigned int' size=0x4 (die:0x8180ed6)
  mov [20] stack canary -> reg0
  mov [29] reg0 -> -0x30(stack) stack canary
  bb: [36 - 3e]
  mov [36] reg4 -> reg15 type='struct sk_buff*' size=0x8 (die:0x8181360)
  bb: [44 - 63]
  mov [44] reg5 -> reg3 type='struct sock*' size=0x8 (die:0x8181a0c)          <<<--- calling tcp_sk()
  var [47] reg3 type='struct tcp_sock*' size=0x8 (die:0x819eead)              <<<--- new variable ('tp' at %RBX)
  var [4e] reg4 type='unsigned long long' size=0x8 (die:0x8180edd)
  mov [58] reg4 -> -0xc0(stack) type='unsigned long long' size=0x8 (die:0x8180edd)
  chk [63] reg5 offset=0x748 ok=1 kind=1 (struct sock*) : offset bigger than size    <<<--- access with old variable
  final result: offset bigger than size

While it's a fault in the compiler, we could work around this issue by
using the type of new variable when it's copied directly.  So I've added
copied_from field in the register state to track those direct register
to register copies.  After that new register gets a new type and the old
register still has the same type, it'll update (copy it back) the type
of the old register.

For example, if we can update type of reg5 at __tcp_transmit_skb+0x47,
we can find the target type of the instruction at 0x63 like below:

  -----------------------------------------------------------
  find data type for 0x748(reg5) at __tcp_transmit_skb+0x63
  ...
  bb: [44 - 63]
  mov [44] reg5 -> reg3 type='struct sock*' size=0x8 (die:0x8181a0c)
  var [47] reg3 type='struct tcp_sock*' size=0x8 (die:0x819eead)
  var [47] copyback reg5 type='struct tcp_sock*' size=0x8 (die:0x819eead)     <<<--- here
  mov [47] 0x748(reg5) -> reg4 type='unsigned long long' size=0x8 (die:0x8180edd)
  mov [4e] 0x750(reg5) -> reg0 type='unsigned long long' size=0x8 (die:0x8180edd)
  mov [58] reg4 -> -0xc0(stack) type='unsigned long long' size=0x8 (die:0x8180edd)
  chk [63] reg5 offset=0x748 ok=1 kind=1 (struct tcp_sock*) : Good!           <<<--- new type
  found by insn track: 0x748(reg5) type-offset=0x748
  final result:  type='struct tcp_sock' size=0xa98 (die:0x819eeb2)

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/arch/x86/annotate/instructions.c |  8 ++++++
 tools/perf/util/annotate-data.c             | 31 +++++++++++++++++++++
 tools/perf/util/annotate-data.h             |  1 +
 3 files changed, 40 insertions(+)

diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
index 15dfc2988e24..5caf5a17f03d 100644
--- a/tools/perf/arch/x86/annotate/instructions.c
+++ b/tools/perf/arch/x86/annotate/instructions.c
@@ -267,6 +267,7 @@ static void update_insn_state_x86(struct type_state *state,
 			return;
 
 		tsr = &state->regs[dst->reg1];
+		tsr->copied_from = -1;
 
 		if (src->imm)
 			imm_value = src->offset;
@@ -326,6 +327,8 @@ static void update_insn_state_x86(struct type_state *state,
 			return;
 
 		tsr = &state->regs[dst->reg1];
+		tsr->copied_from = -1;
+
 		if (dso__kernel(map__dso(dloc->ms->map)) &&
 		    src->segment == INSN_SEG_X86_GS && src->imm) {
 			u64 ip = dloc->ms->sym->start + dl->al.offset;
@@ -386,6 +389,10 @@ static void update_insn_state_x86(struct type_state *state,
 		tsr->imm_value = state->regs[src->reg1].imm_value;
 		tsr->ok = true;
 
+		/* To copy back the variable type later (hopefully) */
+		if (tsr->kind == TSR_KIND_TYPE)
+			tsr->copied_from = src->reg1;
+
 		pr_debug_dtp("mov [%x] reg%d -> reg%d",
 			     insn_offset, src->reg1, dst->reg1);
 		pr_debug_type_name(&tsr->type, tsr->kind);
@@ -398,6 +405,7 @@ static void update_insn_state_x86(struct type_state *state,
 			return;
 
 		tsr = &state->regs[dst->reg1];
+		tsr->copied_from = -1;
 
 retry:
 		/* Check stack variables with offset */
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index b33089caccbc..81efd5bdb93b 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -774,6 +774,11 @@ bool get_global_var_type(Dwarf_Die *cu_die, struct data_loc_info *dloc,
 	return true;
 }
 
+static bool die_is_same(Dwarf_Die *die_a, Dwarf_Die *die_b)
+{
+	return (die_a->cu == die_b->cu) && (die_a->addr == die_b->addr);
+}
+
 /**
  * update_var_state - Update type state using given variables
  * @state: type state table
@@ -825,6 +830,7 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
 			pr_debug_type_name(&mem_die, TSR_KIND_TYPE);
 		} else if (has_reg_type(state, var->reg) && var->offset == 0) {
 			struct type_state_reg *reg;
+			Dwarf_Die orig_type;
 
 			reg = &state->regs[var->reg];
 
@@ -832,6 +838,8 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
 			    !is_better_type(&reg->type, &mem_die))
 				continue;
 
+			orig_type = reg->type;
+
 			reg->type = mem_die;
 			reg->kind = TSR_KIND_TYPE;
 			reg->ok = true;
@@ -839,6 +847,29 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
 			pr_debug_dtp("var [%"PRIx64"] reg%d",
 				     insn_offset, var->reg);
 			pr_debug_type_name(&mem_die, TSR_KIND_TYPE);
+
+			/*
+			 * If this register is directly copied from another and it gets a
+			 * better type, also update the type of the source register.  This
+			 * is usually the case of container_of() macro with offset of 0.
+			 */
+			if (has_reg_type(state, reg->copied_from)) {
+				struct type_state_reg *copy_reg;
+
+				copy_reg = &state->regs[reg->copied_from];
+
+				/* TODO: check if type is compatible or embedded */
+				if (!copy_reg->ok || (copy_reg->kind != TSR_KIND_TYPE) ||
+				    !die_is_same(&copy_reg->type, &orig_type) ||
+				    !is_better_type(&copy_reg->type, &mem_die))
+					continue;
+
+				copy_reg->type = mem_die;
+
+				pr_debug_dtp("var [%"PRIx64"] copyback reg%d",
+					     insn_offset, reg->copied_from);
+				pr_debug_type_name(&mem_die, TSR_KIND_TYPE);
+			}
 		}
 	}
 }
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 37a1a3b68e0b..8ac0fd94a0ba 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -176,6 +176,7 @@ struct type_state_reg {
 	bool ok;
 	bool caller_saved;
 	u8 kind;
+	u8 copied_from;
 };
 
 /* Type information in a stack location, dynamically allocated */
-- 
2.46.0.184.g6999bdac58-goog


