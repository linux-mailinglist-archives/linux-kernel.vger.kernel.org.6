Return-Path: <linux-kernel+bounces-541029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2891A4B7A4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 06:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F8F53AF912
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 05:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC3B1E501C;
	Mon,  3 Mar 2025 05:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rXOcv6a2"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32251E3DEB
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 05:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740980252; cv=none; b=o8Ncvhuy+fF5u6QRJRrX0EMNtZsXmCmZWEmXNR0FfUHsu0LpthxxAiTPDwv6884BzBRAS4Mr/W2srWS9ODhjIlf/frnyrgwn+iMeDOtzvrbE5yJ1pDhnz58WTjNsulV6oyEcNEngAscxKTY4g6GriH5SI8ctR+eDzYnlveB0Afw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740980252; c=relaxed/simple;
	bh=2pUxXz0akFFxs2mApNxz+YR/0wzJxt2EpT0EmaU7eKw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fbLVHf6eJBjPzrvYe8liZTqHeIcYLn6bVw4FoiBabOdhsuKm9qXqF/AInw9vGdMI9pVxNoABl3Pv3DqJUuR9lAw/YraG8WxVMlb5JUF+pTg6S7Guc5VX9ehgGQEsHMpyIMAsgTFAPrgO+TgMp8nq745eKRvbGGplKu5Gkl0naBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rXOcv6a2; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22328fb6cbfso72619905ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 21:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740980250; x=1741585050; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xPM/d8ucU/aCvkPtTtqBYkvS0mdPeqTCnB8f7vkTZfc=;
        b=rXOcv6a2j/dOy5VcjbbrIjoM8Exp0gbzIPHFN6YZ0egQZDNjJdIQRLxtNXH/u2KehL
         bNdvvnOswMwdgWHDybfTuEqwO3XCkWv/kzOy09UONGSIG/gg7jTElp9dFKGXDRw5uYJR
         0zLuGun4/evLyPM47ICKAnohoIv8yd5XbqfRxHusBQmcQmIfLizp0MEyGKFU5H7u0qVE
         /wHL06xHsk/AMDu5BileIcikr6runlBHtrjMYBkAoyo50Qa7G23TMxbWrnZP/gzqbrcD
         UZiy3tfhclQqY5a4BneNAVGaZJ42ax2I6k3nQ+ysCuoWjD+rjVNnM77e4Lvs7jTvsn/G
         yVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740980250; x=1741585050;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xPM/d8ucU/aCvkPtTtqBYkvS0mdPeqTCnB8f7vkTZfc=;
        b=g+4cPqvnSlZtQgfXzOcsA9656L8Y2dWhC2LbuHF1caZw3a42PjA6ywVcBQx9Cmy1LJ
         gIjmkJvuTVLU4CrnsmtSRwELhk+NPdWdQG9k2VVzs6JdgVTaRfQbS9IM0lGGp9gcpEhG
         hgFXJzGXKXKmTrcPKd1Q559yjabl8AYrNXCZyX34h1mo34JLs3cmxSovPO6Kdjgljh30
         CiolyzD8bortsV0XRA7JDWanNoaw5404k5UClisKX47inNAzDmtyNNIXhh8kMr1VqCBc
         nW2LGQWy/PpVOi7khS8IA6E0ld+xmqBsIwiQbtL3QWY8GcSoTr43o98NFAzbZ2WS8S1m
         IU9g==
X-Forwarded-Encrypted: i=1; AJvYcCULewonSMhBAuSNwrkx9Lchg4pgdKKgRb8YFc1kRZQP+PQozPjIHSqpT0X59Oli2stnObPPUaZsGxk1v3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNnObfMA1JQr/7HRbWV7XKLbDm33RAFVyDfUmqBtZj3lWNes7W
	IuSb9HwW5X2hHzctcpXfevwOPmNtPk8LCTmUlfVBczCB4cOX1hMFFPZcVGrjm4giAnNm0qiD20y
	YDFl1ZURodQ==
X-Google-Smtp-Source: AGHT+IFd0bRzT6Rf6GCL8yvgeLbmofEZHIi8D+gz8MXJG3yNYxhrfMMp8T7aKzxnwK4iYpxZh2FJ3rZewRiYoA==
X-Received: from pjur6.prod.google.com ([2002:a17:90a:d406:b0:2fc:2959:b397])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:244d:b0:216:6901:d588 with SMTP id d9443c01a7336-22368f75980mr157873115ad.15.1740980250225;
 Sun, 02 Mar 2025 21:37:30 -0800 (PST)
Date: Mon,  3 Mar 2025 05:37:25 +0000
In-Reply-To: <cover.1740978603.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1740978603.git.yepeilin@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <8b39c94eac2bb7389ff12392ca666f939124ec4f.1740978603.git.yepeilin@google.com>
Subject: [PATCH bpf-next v4 03/10] bpf/verifier: Factor out check_load_mem()
 and check_store_reg()
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

Extract BPF_LDX and most non-ATOMIC BPF_STX instruction handling logic
in do_check() into helper functions to be used later.  While we are
here, make that comment about "reserved fields" more specific.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 kernel/bpf/verifier.c | 110 +++++++++++++++++++++++++-----------------
 1 file changed, 67 insertions(+), 43 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e3991ac72029..22c4edc8695c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7616,6 +7616,67 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_type type,
 			     bool allow_trust_mismatch);
 
+static int check_load_mem(struct bpf_verifier_env *env, struct bpf_insn *insn,
+			  bool strict_alignment_once, bool is_ldsx,
+			  bool allow_trust_mismatch, const char *ctx)
+{
+	struct bpf_reg_state *regs = cur_regs(env);
+	enum bpf_reg_type src_reg_type;
+	int err;
+
+	/* check src operand */
+	err = check_reg_arg(env, insn->src_reg, SRC_OP);
+	if (err)
+		return err;
+
+	/* check dst operand */
+	err = check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);
+	if (err)
+		return err;
+
+	src_reg_type = regs[insn->src_reg].type;
+
+	/* Check if (src_reg + off) is readable. The state of dst_reg will be
+	 * updated by this call.
+	 */
+	err = check_mem_access(env, env->insn_idx, insn->src_reg, insn->off,
+			       BPF_SIZE(insn->code), BPF_READ, insn->dst_reg,
+			       strict_alignment_once, is_ldsx);
+	err = err ?: save_aux_ptr_type(env, src_reg_type,
+				       allow_trust_mismatch);
+	err = err ?: reg_bounds_sanity_check(env, &regs[insn->dst_reg], ctx);
+
+	return err;
+}
+
+static int check_store_reg(struct bpf_verifier_env *env, struct bpf_insn *insn,
+			   bool strict_alignment_once)
+{
+	struct bpf_reg_state *regs = cur_regs(env);
+	enum bpf_reg_type dst_reg_type;
+	int err;
+
+	/* check src1 operand */
+	err = check_reg_arg(env, insn->src_reg, SRC_OP);
+	if (err)
+		return err;
+
+	/* check src2 operand */
+	err = check_reg_arg(env, insn->dst_reg, SRC_OP);
+	if (err)
+		return err;
+
+	dst_reg_type = regs[insn->dst_reg].type;
+
+	/* Check if (dst_reg + off) is writeable. */
+	err = check_mem_access(env, env->insn_idx, insn->dst_reg, insn->off,
+			       BPF_SIZE(insn->code), BPF_WRITE, insn->src_reg,
+			       strict_alignment_once, false);
+	err = err ?: save_aux_ptr_type(env, dst_reg_type, false);
+
+	return err;
+}
+
 static int check_atomic_rmw(struct bpf_verifier_env *env,
 			    struct bpf_insn *insn)
 {
@@ -19199,35 +19260,16 @@ static int do_check(struct bpf_verifier_env *env)
 				return err;
 
 		} else if (class == BPF_LDX) {
-			enum bpf_reg_type src_reg_type;
-
-			/* check for reserved fields is already done */
-
-			/* check src operand */
-			err = check_reg_arg(env, insn->src_reg, SRC_OP);
-			if (err)
-				return err;
+			bool is_ldsx = BPF_MODE(insn->code) == BPF_MEMSX;
 
-			err = check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);
-			if (err)
-				return err;
-
-			src_reg_type = regs[insn->src_reg].type;
-
-			/* check that memory (src_reg + off) is readable,
-			 * the state of dst_reg will be updated by this func
+			/* Check for reserved fields is already done in
+			 * resolve_pseudo_ldimm64().
 			 */
-			err = check_mem_access(env, env->insn_idx, insn->src_reg,
-					       insn->off, BPF_SIZE(insn->code),
-					       BPF_READ, insn->dst_reg, false,
-					       BPF_MODE(insn->code) == BPF_MEMSX);
-			err = err ?: save_aux_ptr_type(env, src_reg_type, true);
-			err = err ?: reg_bounds_sanity_check(env, &regs[insn->dst_reg], "ldx");
+			err = check_load_mem(env, insn, false, is_ldsx, true,
+					     "ldx");
 			if (err)
 				return err;
 		} else if (class == BPF_STX) {
-			enum bpf_reg_type dst_reg_type;
-
 			if (BPF_MODE(insn->code) == BPF_ATOMIC) {
 				err = check_atomic(env, insn);
 				if (err)
@@ -19241,25 +19283,7 @@ static int do_check(struct bpf_verifier_env *env)
 				return -EINVAL;
 			}
 
-			/* check src1 operand */
-			err = check_reg_arg(env, insn->src_reg, SRC_OP);
-			if (err)
-				return err;
-			/* check src2 operand */
-			err = check_reg_arg(env, insn->dst_reg, SRC_OP);
-			if (err)
-				return err;
-
-			dst_reg_type = regs[insn->dst_reg].type;
-
-			/* check that memory (dst_reg + off) is writeable */
-			err = check_mem_access(env, env->insn_idx, insn->dst_reg,
-					       insn->off, BPF_SIZE(insn->code),
-					       BPF_WRITE, insn->src_reg, false, false);
-			if (err)
-				return err;
-
-			err = save_aux_ptr_type(env, dst_reg_type, false);
+			err = check_store_reg(env, insn, false);
 			if (err)
 				return err;
 		} else if (class == BPF_ST) {
-- 
2.48.1.711.g2feabab25a-goog


