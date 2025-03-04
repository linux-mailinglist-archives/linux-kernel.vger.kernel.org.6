Return-Path: <linux-kernel+bounces-542953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 785B7A4CFC8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79D0B188A05E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA2ACA4E;
	Tue,  4 Mar 2025 00:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qZ9zcQBF"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF53250EC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 00:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741047269; cv=none; b=OqO9ArmBjbnKYfqXKCoa+Sx39PJ0YRTNoiFqMNIKkkwBOvQRvYCoOQKT8AH4OUlHaSJnM6BwCXZAdS19mwUKM7osYpilujUhM+OMsm5y6EIxIpubgjXB6LIUvYPojn/r084RPNw/jSa/lHGi6xEUVNCn1N4yEzZdjxSojacYouQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741047269; c=relaxed/simple;
	bh=QPA0z4IkQ4stWUSFz7Vu1LHPkM1P0cuaG7fZq/w/Sls=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UO0T62vXdshgZadHFM7ntqrHVDXYOct3i9c3s766/nZO9BJxBEF/hp+0l6Foa+edA1lo8hGmr6TrpJvR7oQb/7tRy3RKOGQJNmf7SCGEK1BlRUiQs9RoLKoYB5BGgFQD+C0QfQHG0NJL66gwtFBwjPbcSDYxnTN1OCn/KsJR3xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qZ9zcQBF; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fe9527c041so9986410a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 16:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741047267; x=1741652067; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VycOpllnvSzKdjd9R3576qTHHYaFrsKy4wd3sa7AubQ=;
        b=qZ9zcQBFQtBZ0rdFEYXDiB1iDgnEoGKc8yYeIvjKFJscx01BjVyXJhZzKxlSukyzI4
         7TFix/dtZe8Jh3rOA7sSGyFzucdUjQKyDbcfQQAr2RN8ltCAkBXs4ME7a6UnhBb6gZup
         ynBrkFnBPkJ1IBLHxvz3qtiYi3uSV7zYi/OGDhr842ZaXflrTOlltTL56BKWr9VDeabT
         RQoAdWqiB8yRhtcqkEu3DygyWHGISvRX1DRKYSMGzGLCslsJajqddruR0t/syOlbcJo9
         RkpJpag/qiZg2cxJJHRbQStQ+pTVYtqGig8F9RewctWEs4s479S7rhHJQU0wyHXRJeMl
         gneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741047267; x=1741652067;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VycOpllnvSzKdjd9R3576qTHHYaFrsKy4wd3sa7AubQ=;
        b=a1QknlEjo283+jnanon8imURPwKOQylrX1foExT/o7JHaG4jnWDGQfv0iLOGLMjD0W
         efb8qehZC9AGyUAV7EE3C757/wgddg6gAdeXDXio+8mWOFCuBnOID8DOISkjQaq0zXCr
         sPLHOcpZVy285QYqJk6SXPQJHkC6XaO1k+oisJx1HGkN/qfebtKCV2ZJtPheCXJu0LUN
         iDzKd1g4PFJx4pElTIvNhrJGKvSYFKCqIQGeb+9qhkBccjvhdkTvII/WmO6uvfujRe3a
         h1gBB/ABn9hRb8EN+ISa6Wxu/Cu22hticin3bdegDYXf1DbEAYYjeh0AJ2o2XXASVqTr
         18Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVrAm0cc/ugNjqtfMBVGRpdKzyUqNzXnZGucKBJGorr72MkMmwTZbeOn1J/tOAJGaGmyUtslj48p16FFzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+VXQbLZtyQhjA7Wdm8Hy1zegGzRCFXTVHHpQ6wac8ebRgp3nP
	UPZEAk+jpkzgsbMHqwykgtGsW1JzGBNO+hE57pRFhcRKTVSHVKZ4mziCj7obBfVNn3rZmfh4d2f
	EgGLg0mtwSA==
X-Google-Smtp-Source: AGHT+IGlZNGqUmDxTly2qYsBgk0PptIg3lItr8uvTn+ohlGwkImKw4P0KNR+Inhl9r8cGtTP+KHApKcxMgVj4Q==
X-Received: from pjbqc14.prod.google.com ([2002:a17:90b:288e:b0:2f2:ea3f:34c3])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:278d:b0:2f8:34df:5652 with SMTP id 98e67ed59e1d1-2febab703femr20133867a91.21.1741047267046;
 Mon, 03 Mar 2025 16:14:27 -0800 (PST)
Date: Tue,  4 Mar 2025 00:14:22 +0000
In-Reply-To: <cover.1741046028.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1741046028.git.yepeilin@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <c4b2b97086e214ee24aafeb5f57cb1275a4469ef.1741046028.git.yepeilin@google.com>
Subject: [PATCH bpf-next v5 5/6] bpf, x86: Support load-acquire and
 store-release instructions
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Peilin Ye <yepeilin@google.com>, bpf@ietf.org, Alexei Starovoitov <ast@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	David Vernet <void@manifault.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Yingchi Long <longyingchi24s@ict.ac.cn>, 
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>, 
	Benjamin Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Recently we introduced BPF load-acquire (BPF_LOAD_ACQ) and store-release
(BPF_STORE_REL) instructions.  For x86-64, simply implement them as
regular BPF_LDX/BPF_STX loads and stores.  The verifier always rejects
misaligned load-acquires/store-releases (even if BPF_F_ANY_ALIGNMENT is
set), so emitted MOV* instructions are guaranteed to be atomic.

Arena accesses are supported.  8- and 16-bit load-acquires are
zero-extending (i.e., MOVZBQ, MOVZWQ).

Rename emit_atomic{,_index}() to emit_atomic_rmw{,_index}() to make it
clear that they only handle read-modify-write atomics, and extend their
@atomic_op parameter from u8 to u32, since we are starting to use more
than the lowest 8 bits of the 'imm' field.

Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 arch/x86/net/bpf_jit_comp.c | 99 ++++++++++++++++++++++++++++++-------
 1 file changed, 82 insertions(+), 17 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index f0c31c940fb8..0263d98d92b0 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1242,8 +1242,8 @@ static void emit_st_r12(u8 **pprog, u32 size, u32 dst_reg, int off, int imm)
 	emit_st_index(pprog, size, dst_reg, X86_REG_R12, off, imm);
 }
 
-static int emit_atomic(u8 **pprog, u8 atomic_op,
-		       u32 dst_reg, u32 src_reg, s16 off, u8 bpf_size)
+static int emit_atomic_rmw(u8 **pprog, u32 atomic_op,
+			   u32 dst_reg, u32 src_reg, s16 off, u8 bpf_size)
 {
 	u8 *prog = *pprog;
 
@@ -1283,8 +1283,9 @@ static int emit_atomic(u8 **pprog, u8 atomic_op,
 	return 0;
 }
 
-static int emit_atomic_index(u8 **pprog, u8 atomic_op, u32 size,
-			     u32 dst_reg, u32 src_reg, u32 index_reg, int off)
+static int emit_atomic_rmw_index(u8 **pprog, u32 atomic_op, u32 size,
+				 u32 dst_reg, u32 src_reg, u32 index_reg,
+				 int off)
 {
 	u8 *prog = *pprog;
 
@@ -1297,7 +1298,7 @@ static int emit_atomic_index(u8 **pprog, u8 atomic_op, u32 size,
 		EMIT1(add_3mod(0x48, dst_reg, src_reg, index_reg));
 		break;
 	default:
-		pr_err("bpf_jit: 1 and 2 byte atomics are not supported\n");
+		pr_err("bpf_jit: 1- and 2-byte RMW atomics are not supported\n");
 		return -EFAULT;
 	}
 
@@ -1331,6 +1332,49 @@ static int emit_atomic_index(u8 **pprog, u8 atomic_op, u32 size,
 	return 0;
 }
 
+static int emit_atomic_ld_st(u8 **pprog, u32 atomic_op, u32 dst_reg,
+			     u32 src_reg, s16 off, u8 bpf_size)
+{
+	switch (atomic_op) {
+	case BPF_LOAD_ACQ:
+		/* dst_reg = smp_load_acquire(src_reg + off16) */
+		emit_ldx(pprog, bpf_size, dst_reg, src_reg, off);
+		break;
+	case BPF_STORE_REL:
+		/* smp_store_release(dst_reg + off16, src_reg) */
+		emit_stx(pprog, bpf_size, dst_reg, src_reg, off);
+		break;
+	default:
+		pr_err("bpf_jit: unknown atomic load/store opcode %02x\n",
+		       atomic_op);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int emit_atomic_ld_st_index(u8 **pprog, u32 atomic_op, u32 size,
+				   u32 dst_reg, u32 src_reg, u32 index_reg,
+				   int off)
+{
+	switch (atomic_op) {
+	case BPF_LOAD_ACQ:
+		/* dst_reg = smp_load_acquire(src_reg + idx_reg + off16) */
+		emit_ldx_index(pprog, size, dst_reg, src_reg, index_reg, off);
+		break;
+	case BPF_STORE_REL:
+		/* smp_store_release(dst_reg + idx_reg + off16, src_reg) */
+		emit_stx_index(pprog, size, dst_reg, src_reg, index_reg, off);
+		break;
+	default:
+		pr_err("bpf_jit: unknown atomic load/store opcode %02x\n",
+		       atomic_op);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
 #define DONT_CLEAR 1
 
 bool ex_handler_bpf(const struct exception_table_entry *x, struct pt_regs *regs)
@@ -2113,6 +2157,13 @@ st:			if (is_imm8(insn->off))
 			}
 			break;
 
+		case BPF_STX | BPF_ATOMIC | BPF_B:
+		case BPF_STX | BPF_ATOMIC | BPF_H:
+			if (!bpf_atomic_is_load_store(insn)) {
+				pr_err("bpf_jit: 1- and 2-byte RMW atomics are not supported\n");
+				return -EFAULT;
+			}
+			fallthrough;
 		case BPF_STX | BPF_ATOMIC | BPF_W:
 		case BPF_STX | BPF_ATOMIC | BPF_DW:
 			if (insn->imm == (BPF_AND | BPF_FETCH) ||
@@ -2148,10 +2199,10 @@ st:			if (is_imm8(insn->off))
 				EMIT2(simple_alu_opcodes[BPF_OP(insn->imm)],
 				      add_2reg(0xC0, AUX_REG, real_src_reg));
 				/* Attempt to swap in new value */
-				err = emit_atomic(&prog, BPF_CMPXCHG,
-						  real_dst_reg, AUX_REG,
-						  insn->off,
-						  BPF_SIZE(insn->code));
+				err = emit_atomic_rmw(&prog, BPF_CMPXCHG,
+						      real_dst_reg, AUX_REG,
+						      insn->off,
+						      BPF_SIZE(insn->code));
 				if (WARN_ON(err))
 					return err;
 				/*
@@ -2166,17 +2217,35 @@ st:			if (is_imm8(insn->off))
 				break;
 			}
 
-			err = emit_atomic(&prog, insn->imm, dst_reg, src_reg,
-					  insn->off, BPF_SIZE(insn->code));
+			if (bpf_atomic_is_load_store(insn))
+				err = emit_atomic_ld_st(&prog, insn->imm, dst_reg, src_reg,
+							insn->off, BPF_SIZE(insn->code));
+			else
+				err = emit_atomic_rmw(&prog, insn->imm, dst_reg, src_reg,
+						      insn->off, BPF_SIZE(insn->code));
 			if (err)
 				return err;
 			break;
 
+		case BPF_STX | BPF_PROBE_ATOMIC | BPF_B:
+		case BPF_STX | BPF_PROBE_ATOMIC | BPF_H:
+			if (!bpf_atomic_is_load_store(insn)) {
+				pr_err("bpf_jit: 1- and 2-byte RMW atomics are not supported\n");
+				return -EFAULT;
+			}
+			fallthrough;
 		case BPF_STX | BPF_PROBE_ATOMIC | BPF_W:
 		case BPF_STX | BPF_PROBE_ATOMIC | BPF_DW:
 			start_of_ldx = prog;
-			err = emit_atomic_index(&prog, insn->imm, BPF_SIZE(insn->code),
-						dst_reg, src_reg, X86_REG_R12, insn->off);
+
+			if (bpf_atomic_is_load_store(insn))
+				err = emit_atomic_ld_st_index(&prog, insn->imm,
+							      BPF_SIZE(insn->code), dst_reg,
+							      src_reg, X86_REG_R12, insn->off);
+			else
+				err = emit_atomic_rmw_index(&prog, insn->imm, BPF_SIZE(insn->code),
+							    dst_reg, src_reg, X86_REG_R12,
+							    insn->off);
 			if (err)
 				return err;
 			goto populate_extable;
@@ -3771,12 +3840,8 @@ bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
 	if (!in_arena)
 		return true;
 	switch (insn->code) {
-	case BPF_STX | BPF_ATOMIC | BPF_B:
-	case BPF_STX | BPF_ATOMIC | BPF_H:
 	case BPF_STX | BPF_ATOMIC | BPF_W:
 	case BPF_STX | BPF_ATOMIC | BPF_DW:
-		if (bpf_atomic_is_load_store(insn))
-			return false;
 		if (insn->imm == (BPF_AND | BPF_FETCH) ||
 		    insn->imm == (BPF_OR | BPF_FETCH) ||
 		    insn->imm == (BPF_XOR | BPF_FETCH))
-- 
2.48.1.711.g2feabab25a-goog


