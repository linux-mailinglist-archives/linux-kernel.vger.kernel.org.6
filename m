Return-Path: <linux-kernel+bounces-522790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBB8A3CE8B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE0D57A7237
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 01:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C76C41C7F;
	Thu, 20 Feb 2025 01:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tD9ic9Vy"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191BD22F19
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740014453; cv=none; b=LuXEg/ZsGMvKM0ZW6zqqIDyL07xJj1nChplUrLy4Eyljlde1PDJGe9+liZs0V+8TJUIRCB+zr0/QwndWgorI59NDsxII2YL6AHVh4gfFaBnlFrOps9Ues5hOn8RdltBVDoUkZeAbCg1vSp9paso80PG0n/qT0PlV73OORCPwz+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740014453; c=relaxed/simple;
	bh=8BEtdyFL+la1SWhGjdvnuHQmk94dfd7pWP8oR4rmWzA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T5fgwqP4Xy5eysyNpQRKQjVde7i+6Uv/YFE7CdBTS87TChOZgAkLzO0YXAHNCQLPE1BzWJdD/hkU5OF2ebDC2J6nu/3Do8osdpZ/8qgag4W34yumvRqhKrn1tswScZuTTXeapqI05FdrH0jkw3fv/yr94RQFAA9OjcI8SzHVsNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tD9ic9Vy; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220c1f88eb4so5434975ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 17:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740014451; x=1740619251; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AVw9FAeQI7lCZwFZLEeeKDcfx7NZFxNIup/gnaKUq1Q=;
        b=tD9ic9VyzQSbZsr3+usJdbzn6jBeZGgu62yH2EqklfdWkTkPsRPQvU9WJ0GnUuaU/t
         YIJZrjSlHixsEPcaqMkZ7PdmVcy5n1aWH/H5byfayecgwZhnpU8YlLcH/IJYAlk32Cve
         LcaYSBdZszb4PEMuMKSPf7IcSPVQu64siQEe6uyZhwQN6aT+850cHyJfpfb4cQ9IeLBz
         R19/ZcEBiLje0LrbIm1s6bOTngS3AJuWVhunr9mHFCDiggzNarqt4Xx2oGuQqdavTRzp
         /K//8E8KmaIER3D35J5ZWAx7jsh7b2B52/Drja7uy1iB5X00d+yDYTmmsmbXgmlwkP/j
         LG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740014451; x=1740619251;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVw9FAeQI7lCZwFZLEeeKDcfx7NZFxNIup/gnaKUq1Q=;
        b=EvaQtWWWEUX+UFJpKEStVK5ykZazJLvE9hOaEmYNgIbaSVk/04xahAtQVRW8zYhAfu
         QXfsc0r2Gil9wRkuKiRMRymWfEwhsjdv83SXSNHF+B2AzJhRztKi5IsjLxoYGC8nm7Jl
         RsMUsYk+Xoex5QGihsURwGzgNl521VX3r/4VDV8R9ePV/34Dnu0K5X3NnMj019c3IWtS
         eruCdWe2cyVPOGvzcnc+jl8VoC/EijHFVRUWDSyZJXMEEv6vbjLE79BhO3t1gogDM0LF
         tJM3RdngDGw5I5ZkEyfHt+nJPE+dahb6ffvIC5IZ8OSQugU6sZqAm/8a3xae4vHhallJ
         PLsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/YfNFzznFwoGGVvBeWYBlPkPHYOKrf0xcMfeA401pV2/3QVeJmXCAgGsOeREK22iGddOasbT6Zo6e0hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLIC9rPgDxKITpb683WMKHqYlT8ZgmWMrj2vmoVSkJS7QZ7nGE
	0qsKLMMivCcSfI9pBgloMGxVo/FuS9hCpcIaUbhZKXM9sNzDdSTmsTGNKqgt+hfMJODvyZc77/2
	tht+pywoYEA==
X-Google-Smtp-Source: AGHT+IELkZhp3dnu1j1hrZyZSNzylf6/SsN58EX3cCnB9zawb1C1aTd09ns9uhXgPWFn3IcwfNEV46XMOLhkTw==
X-Received: from plbbj7.prod.google.com ([2002:a17:902:8507:b0:221:7c80:aeff])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:41c3:b0:220:ef79:aca9 with SMTP id d9443c01a7336-221711c8dd8mr102260065ad.53.1740014451316;
 Wed, 19 Feb 2025 17:20:51 -0800 (PST)
Date: Thu, 20 Feb 2025 01:20:41 +0000
In-Reply-To: <cover.1740009184.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1740009184.git.yepeilin@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <91e99076cf23e75e4831c75b38f8cfa84d7da34b.1740009184.git.yepeilin@google.com>
Subject: [PATCH bpf-next v3 2/9] bpf/verifier: Factor out check_atomic_rmw()
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

Currently, check_atomic() only handles atomic read-modify-write (RMW)
instructions.  Since we are planning to introduce other types of atomic
instructions (i.e., atomic load/store), extract the existing RMW
handling logic into its own function named check_atomic_rmw().

Remove the @insn_idx parameter as it is not really necessary.  Use
'env->insn_idx' instead, as in other places in verifier.c.

Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 kernel/bpf/verifier.c | 53 +++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 21658bd5e6d8..63d810bbc26e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7615,28 +7615,12 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_type type,
 			     bool allow_trust_mismatch);
 
-static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_insn *insn)
+static int check_atomic_rmw(struct bpf_verifier_env *env,
+			    struct bpf_insn *insn)
 {
 	int load_reg;
 	int err;
 
-	switch (insn->imm) {
-	case BPF_ADD:
-	case BPF_ADD | BPF_FETCH:
-	case BPF_AND:
-	case BPF_AND | BPF_FETCH:
-	case BPF_OR:
-	case BPF_OR | BPF_FETCH:
-	case BPF_XOR:
-	case BPF_XOR | BPF_FETCH:
-	case BPF_XCHG:
-	case BPF_CMPXCHG:
-		break;
-	default:
-		verbose(env, "BPF_ATOMIC uses invalid atomic opcode %02x\n", insn->imm);
-		return -EINVAL;
-	}
-
 	if (BPF_SIZE(insn->code) != BPF_W && BPF_SIZE(insn->code) != BPF_DW) {
 		verbose(env, "invalid atomic operand size\n");
 		return -EINVAL;
@@ -7698,12 +7682,12 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 	/* Check whether we can read the memory, with second call for fetch
 	 * case to simulate the register fill.
 	 */
-	err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
+	err = check_mem_access(env, env->insn_idx, insn->dst_reg, insn->off,
 			       BPF_SIZE(insn->code), BPF_READ, -1, true, false);
 	if (!err && load_reg >= 0)
-		err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
-				       BPF_SIZE(insn->code), BPF_READ, load_reg,
-				       true, false);
+		err = check_mem_access(env, env->insn_idx, insn->dst_reg,
+				       insn->off, BPF_SIZE(insn->code),
+				       BPF_READ, load_reg, true, false);
 	if (err)
 		return err;
 
@@ -7713,13 +7697,34 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 			return err;
 	}
 	/* Check whether we can write into the same memory. */
-	err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
+	err = check_mem_access(env, env->insn_idx, insn->dst_reg, insn->off,
 			       BPF_SIZE(insn->code), BPF_WRITE, -1, true, false);
 	if (err)
 		return err;
 	return 0;
 }
 
+static int check_atomic(struct bpf_verifier_env *env, struct bpf_insn *insn)
+{
+	switch (insn->imm) {
+	case BPF_ADD:
+	case BPF_ADD | BPF_FETCH:
+	case BPF_AND:
+	case BPF_AND | BPF_FETCH:
+	case BPF_OR:
+	case BPF_OR | BPF_FETCH:
+	case BPF_XOR:
+	case BPF_XOR | BPF_FETCH:
+	case BPF_XCHG:
+	case BPF_CMPXCHG:
+		return check_atomic_rmw(env, insn);
+	default:
+		verbose(env, "BPF_ATOMIC uses invalid atomic opcode %02x\n",
+			insn->imm);
+		return -EINVAL;
+	}
+}
+
 /* When register 'regno' is used to read the stack (either directly or through
  * a helper function) make sure that it's within stack boundary and, depending
  * on the access type and privileges, that all elements of the stack are
@@ -19187,7 +19192,7 @@ static int do_check(struct bpf_verifier_env *env)
 			enum bpf_reg_type dst_reg_type;
 
 			if (BPF_MODE(insn->code) == BPF_ATOMIC) {
-				err = check_atomic(env, env->insn_idx, insn);
+				err = check_atomic(env, insn);
 				if (err)
 					return err;
 				env->insn_idx++;
-- 
2.48.1.601.g30ceb7b040-goog


