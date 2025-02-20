Return-Path: <linux-kernel+bounces-522789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44070A3CE86
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 813861896433
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 01:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C3C18E764;
	Thu, 20 Feb 2025 01:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YwYCmzhz"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23F622F19
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740014399; cv=none; b=gRw7VFxjrIOKB06hbaf8ejClc5OJKObKSlKWucvMOOmGIN6Zzqr9Rf705BF2ButIB0HhIxl5r8oysRRhuazhNyX3w5XYaaMoZB9VeecFhGgXxa2LuE+O3YzueU9nOKNHmKC8oeoc8lwV7GkhsrjgDwvY+2FU8G56/z1aqrz+QtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740014399; c=relaxed/simple;
	bh=y9TqtEwuxAM59+pRGkNPZtMDonN/O6t9RwUUNszlNTw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H9S4jrqtrpaYMf6L+Oz1oOPo+z63UZruKHJfnJBCIxlrX+cCooercHRQZ/QSBy4aQjwjGvqIRrkF8tWOhfQtiy3VLhWOiYUax4mzF8OcyG0n4aSH/vThWJlmX4fIwWiPkagZhxjQpVFfaupnctCccUQvcRJjQmSZn2E6Ui5M40g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YwYCmzhz; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-220e1593b85so7231145ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 17:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740014397; x=1740619197; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LUnHgSEounregn05uHGT75nqn32OY7tna6KiTBpIBWU=;
        b=YwYCmzhzZWgCqBpx3vZER5zzlcVQ7m7ocpnsxeGGcvSoX37Sso43YH/QEThOgxoJRZ
         gdnGmMTLgo+RzwcVTSDSb2+/iui9mlKQHpUj2kUdlrGFaUsHFHVWhLNdwy87YYVctg0d
         5Ghx5zxCLA9Z1sPknlH8proQNJPzIVwLBT7L3cVa5Du57h0Oda0IsuSpUgMfakOTq/rZ
         6phmWtnP2F1+1SxqWMgrhEr2pxL/as4dOhkmY48zPBO+kyjrAKZitAw7yC14udwx3RFr
         leJX6kKrw4Ze9seyrhd8bsnhj1ARgZlKPOqmDkApPL6NPGsvZuvBHpKvrsabvo2UU+r4
         oY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740014397; x=1740619197;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LUnHgSEounregn05uHGT75nqn32OY7tna6KiTBpIBWU=;
        b=lpGX9ZT6pvAU7HzJJvhzdAzH/SCCNgWkj/svHrG0vgQdM5xofHuNX+qTcGZ587Xp+V
         XcXcXBFwovR36jeG4MChvqDvRB1xobg2eSiEzYPyd4+N8QN7f2xaUANBc08sL6Vq2W0I
         yRB1bJfaVPNTgi1D7NrbMVBW+iz//kJa8PlZFy79Ki722E2dP0KgpKWOk6O90u0gzcPe
         MTtHw25i1ilE0HFmi2PLBXLId6UxCvbIUfPXAMgEwZZNNjJn0Dq5wuAbvHBAZYOahilC
         ejtujipnDPDX7yjRNzMYdQWf4qaFmRO8hGxXemg7ob55wBufZqt0KeR0ny7g42MWOe/l
         SFgw==
X-Forwarded-Encrypted: i=1; AJvYcCXUMW8rtmkVCi6HjSBowI8cczaRqnHVxUq/EVIzb05tctdbAk2G/FL6aGWmv40f9MVzaWf3Z//ifdw0ipY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2icaqSW05K0nkgp4kFAZ39Z8OGwOp7juuNR+Vxlb6MvhxE7UJ
	gLSswK1DcOiVoI+bGjisUTIKATye+hkjW5YEC+k9NjQ/wSYPbuMZZQYSVQ+nCJA0892GH3Ustya
	NcYlZlzYy/Q==
X-Google-Smtp-Source: AGHT+IGMFdx8KCQOyowQ5w7kdzLzapH1OG1g0TKzCE06XDnQiClJ/IBLT/uScVtfAiDmrUICsMmVFXpFWBIDzA==
X-Received: from plky4.prod.google.com ([2002:a17:902:7004:b0:220:d272:cfbe])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ec89:b0:215:6b4c:89fa with SMTP id d9443c01a7336-221040137ffmr260028595ad.8.1740014397157;
 Wed, 19 Feb 2025 17:19:57 -0800 (PST)
Date: Thu, 20 Feb 2025 01:19:53 +0000
In-Reply-To: <cover.1740009184.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1740009184.git.yepeilin@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <58c5d8d587948922f257ca4735b4eb9518a191cd.1740009184.git.yepeilin@google.com>
Subject: [PATCH bpf-next v3 1/9] bpf/verifier: Factor out atomic_ptr_type_ok()
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

Factor out atomic_ptr_type_ok() as a helper function to be used later.

Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 kernel/bpf/verifier.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e57b7c949860..21658bd5e6d8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6194,6 +6194,26 @@ static bool is_arena_reg(struct bpf_verifier_env *env, int regno)
 	return reg->type == PTR_TO_ARENA;
 }
 
+/* Return false if @regno contains a pointer whose type isn't supported for
+ * atomic instruction @insn.
+ */
+static bool atomic_ptr_type_ok(struct bpf_verifier_env *env, int regno,
+			       struct bpf_insn *insn)
+{
+	if (is_ctx_reg(env, regno))
+		return false;
+	if (is_pkt_reg(env, regno))
+		return false;
+	if (is_flow_key_reg(env, regno))
+		return false;
+	if (is_sk_reg(env, regno))
+		return false;
+	if (is_arena_reg(env, regno))
+		return bpf_jit_supports_insn(insn, true);
+
+	return true;
+}
+
 static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
 #ifdef CONFIG_NET
 	[PTR_TO_SOCKET] = &btf_sock_ids[BTF_SOCK_TYPE_SOCK],
@@ -7651,11 +7671,7 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 		return -EACCES;
 	}
 
-	if (is_ctx_reg(env, insn->dst_reg) ||
-	    is_pkt_reg(env, insn->dst_reg) ||
-	    is_flow_key_reg(env, insn->dst_reg) ||
-	    is_sk_reg(env, insn->dst_reg) ||
-	    (is_arena_reg(env, insn->dst_reg) && !bpf_jit_supports_insn(insn, true))) {
+	if (!atomic_ptr_type_ok(env, insn->dst_reg, insn)) {
 		verbose(env, "BPF_ATOMIC stores into R%d %s is not allowed\n",
 			insn->dst_reg,
 			reg_type_str(env, reg_state(env, insn->dst_reg)->type));
-- 
2.48.1.601.g30ceb7b040-goog


