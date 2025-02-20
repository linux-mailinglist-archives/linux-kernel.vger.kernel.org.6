Return-Path: <linux-kernel+bounces-522791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8762A3CE8D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC9D3B4135
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 01:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D181A8F94;
	Thu, 20 Feb 2025 01:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o1Xr7c59"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4492F41C7F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740014466; cv=none; b=TMZ18DLO2sphfOt8xzCgY4j3WgOFvskjBk/kxxlSKAFHSYKVKZsgz/IMkbdNtoij9j4UDqP80b8F2fgQNALvYFzgM/nydhNY6ztQo5G5o+n2bmi2GN+mmvdVxudLDV/upa8SJeezUPfL1ofjyUr93KKML/pPf5tEU50OMOyKYJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740014466; c=relaxed/simple;
	bh=gBOioH+MoGQo4UadYpQBkWbBwjDiFjFSK9/sF/gTzzc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I6fcs2+XlVizPxaRlsqiTJNzBi/ZY7NS/P/j8pdnoI5UzDOuwKeWz4Elv1gizyPLQJHHjz4m+HHhvuJX6EyqsvTyfcNGbLz4S0y9aweB2SLjX11YrfbT8nOe8cmfw+Wh1lOvUFbtKVbMPiYBDwCGkwADCBEERWNdfRHL+QMBxGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o1Xr7c59; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22112e86501so7269515ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 17:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740014464; x=1740619264; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1aLixsgG5yYd8/b4s02+ROe3IhMkQne3dzUxBtDOXqk=;
        b=o1Xr7c59NceGMNLAgVB4e4fNi5hX8dE8QxDs937IMLekcRJ4Q4M7T7NfWirEJE/cVe
         k3gIax0JZymRtGJKgnk/K5Cf/udvtEEkfh0q6FKAZaLwyzmjqG/xuR5oqrkE03+NOTta
         2k2gxjqVCb6FcdEGbM50fFtS6UZshaXD27mqNJZl5cxUpBhEeqK3aHbYXY49DsUVF90h
         EKlCfeVk+wL1Qw2uDmKt4mIrzDWflQuNzpuv9s+EIPt2+v+6o3YWILIqZajQKDku7H0k
         UcEtQ5WnIdSVXwfjxg/aQM3o1CYQoCpJyccoBsR6QOd9dQj5a1nl5L72QixcFnhdArsY
         U2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740014464; x=1740619264;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1aLixsgG5yYd8/b4s02+ROe3IhMkQne3dzUxBtDOXqk=;
        b=Bv2IGSn45hxZuLNcLrJPUg68xfAR1Cauz35jXi9KvB8ccj4QSIM1AGJo+X1d6iOIwd
         7LKCzA7vLRv2j/RTZwiiJVjYQwksbK1d1fqa+YObTVgnTCthB++f1bqaYlVTyAaGu7QH
         JSZUkXNJIZTGZO0XoBN7n9aloqT3vMV0s2e/uCVTorRyp14hgcsUUZeP4Pm7BSjlrBTQ
         HmtcIJfN41xvbXFp6D799pFP9O4XImc6b3HNvIfqkzj4BgJcndg+6NgOn3cXyM2a6wEn
         iKUCe+V1DjvtX42/62nEEUc/0+j0L3dj/wBRGKy3V4iFXKYsHRca+XAg+r+5bHx+hpUQ
         3GDA==
X-Forwarded-Encrypted: i=1; AJvYcCWPOWVJnnPFPgeR31mCMRC1RzWlYdzuW6Z2BLBYNshMJpPzLBcvYlHE5j5c/3eTQiN7NyWEHpxv0QzoHQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXikqn6q0jFLTcWAbp0ySggdlQV8ny7V1yFAjHFABx/twTfoWD
	8gR4i4hLUPDWSUHUX5Uy5oGdKnI2V/CqZhWr8tawbu0MD+EpCv1It1+vZXgEa4B1O7HfK3T00ii
	0GmKZ+GlAmA==
X-Google-Smtp-Source: AGHT+IHUV95CcKWgBO0qp2SNUvCYSkhL2FrtNC7aRQZUoxAiCMv56jdPPY4vmUXwTTy3kWwJ9QOGDtLY3sIc/w==
X-Received: from pgbfm14.prod.google.com ([2002:a05:6a02:498e:b0:ad5:4477:da5b])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:fc8f:b0:21a:8300:b9ce with SMTP id d9443c01a7336-221906a633cmr7766695ad.49.1740014464427;
 Wed, 19 Feb 2025 17:21:04 -0800 (PST)
Date: Thu, 20 Feb 2025 01:20:55 +0000
In-Reply-To: <cover.1740009184.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1740009184.git.yepeilin@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <18f624573f4d5cb42ee877655ea0a96248447d7b.1740009184.git.yepeilin@google.com>
Subject: [PATCH bpf-next v3 3/9] bpf/verifier: Factor out check_load_mem() and check_store_reg()
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Peilin Ye <yepeilin@google.com>, bpf@ietf.org, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, David Vernet <void@manifault.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
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
index 63d810bbc26e..3b20bff1c5eb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7615,6 +7615,67 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
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
@@ -19162,35 +19223,16 @@ static int do_check(struct bpf_verifier_env *env)
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
@@ -19204,25 +19246,7 @@ static int do_check(struct bpf_verifier_env *env)
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
2.48.1.601.g30ceb7b040-goog


