Return-Path: <linux-kernel+bounces-437859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA069E99A2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 292551653E4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DC61E9B19;
	Mon,  9 Dec 2024 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="Lj1/f999"
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1D01E9B02
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733756162; cv=none; b=Oh1uDNE+1i5boO3O2Eivf0xBsQHXQamxviQZk1cL8wZ0uMALcHQhRRFNMI0Sbjq8zRFd+GCKtnJV67r8V8NwmCPkv0jdsVeLYBNLclgkBE+vBSwv4AtCuaHd2E3zqpkBDPDkEex/SN4NpDpkn8eyIxSaIYSsCeAGEaMDP6AgBkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733756162; c=relaxed/simple;
	bh=I3FRB0f3Ul3o80Y1tGfQekLxwdiVRfZRtCGeLUbFp/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=el//6QcRz/YWq4cAzOCrsbJES1rhkvLSBechmonaM+QHxfQx3q+V09rf2Dxkv0qshwZcjRQD+qD3XuDL/xFlk7DG+c+OaJ+LDnrIQ8o1+6czQxuvG4vF8k+CU2yKQ+LVQ8wx6M8aqxUEH48szErKCqXeC20l5MXvjY4XNbsiIDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=Lj1/f999; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-aa67333f7d2so231481366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 06:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1733756159; x=1734360959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWLBKwMeMVsEMRzTUljA6Xs3Jk0dHNqB1xAY0nLaWgU=;
        b=Lj1/f9991LKhLe7Yo3xMa8GUWncZqgua3DZ/sdy/I8HNaPN8NRksNOdsOfVq5+lDrI
         Fyflgu7F3jswdUp8Ol3U7tPF8kaXJFKYTeXBfi7QJ6Brb/YttLnfprj8EKUPzMkQ0pvr
         OzjdMyCA8qsfNwfW67b/6sBp0rC/Y4fNHXjhsb02LMmN1qffkmW8W2LbQssMVvmYbNjq
         W8bXHyBvZARgzRphNvyk9Pp4q+4XauKZdVyqbflIphGhS91/TcuZNSQc0u0fG8u+zpJf
         CAPjm1Wq1M+l8xw3tAxPunZg3QDmVTBeEnlNDcGTOWfXkJibQehWNHwey/j/agQAwi5V
         1GCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733756159; x=1734360959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWLBKwMeMVsEMRzTUljA6Xs3Jk0dHNqB1xAY0nLaWgU=;
        b=BWsiScGpwahQl8jXpF/NHF6zQQeAbYjMP1Cdo/qPpln6B5AukX9Yj07ikt2y3XO0xr
         nAJmTQ3aUPFqimoLDq3h3dwpKn0SmHtbNfzO0Nk5mUsolUP6x7VSXXuZSr0pCOLkLiQT
         fkRJVq5/OmXYH9X0qt1gag2t/42HMbUzBgsZlFnatloEaUqRc0SsUpNcxYFzIchG70f0
         l+sGFSYpzb/OhwDqHqBNBUvcve6QmavgTBqIZmXTY4nybREQvoHEXHeaVfCfeqh1HUM+
         21jmOwbR55VDf33w32l5i1bOBjSpN3qltj2wTjcMXsna+PV7VaPD5wBWEjyDJWoVcFzG
         YI8A==
X-Forwarded-Encrypted: i=1; AJvYcCWzGz4SKEQYFIsbw/BwBZJbSSKwPQKH9QF5WM3kvmmzJoJYRtGM4KKE/YIYujZgCidRuRKkOOKLA8ayUxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzG2phVFYaStcTY960ub844jw1MWNPOBzUS7B+hbTfxKIPq5+D
	l9onAOBbDkz2wUiRPwJbTFH6TVkJy8yJSriZKKPJ5WlzfP/ygBudarBYrC3B898=
X-Gm-Gg: ASbGncvSDqGcFOThyXWI/s+ezz2OD8ZoSwYn44XlZ0IONOv/B/n1w3+THxVFs62quAC
	ebhInTe2iBfiUMDIhezTNPcA9Hq8jpiRlvEHy0WyM8poNGqR5jGwXuOIG7iZG9b9/JPobltVZi3
	SJxUDtwMYxM+LNCu4qqdMt4lneVd8CDFKRVxy6yTl6lfO5c4IV2Y7S4o/LGBk67Q7c+bkoj56mS
	LvBc0N7fw+WQsCnGVeHgQSAK8ayHeIGiMJxHcapAfrqUjvAujM/vVx/c4sk2+3mi0/A3+NTPtpQ
	af3EP72lu9X7YyCoeQ==
X-Google-Smtp-Source: AGHT+IFcYzEYQutvhbdZHzyuCMrgWxtpReGZHH7Ct+6xnOHVpZt1OZMpqrNXjXhY0+D17GYLNEX+wg==
X-Received: by 2002:a17:907:b98:b0:aa5:1a1c:d0a2 with SMTP id a640c23a62f3a-aa69cda476emr63848566b.34.1733756158636;
        Mon, 09 Dec 2024 06:55:58 -0800 (PST)
Received: from simagnan-ThinkPad-X1-Carbon-Gen-10.. ([87.13.127.164])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aa6845ab4absm189281266b.73.2024.12.09.06.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:55:58 -0800 (PST)
From: Simone Magnani <simone.magnani@isovalent.com>
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	simone.magnani@isovalent.com,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH bpf-next v2] bpftool: Probe for ISA v4 instruction set extension
Date: Mon,  9 Dec 2024 15:54:39 +0100
Message-ID: <20241209145439.336362-1-simone.magnani@isovalent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241209102644.29880-1-simone.magnani@isovalent.com>
References: <20241209102644.29880-1-simone.magnani@isovalent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces a new probe to check whether the kernel supports
instruction set extensions v4. The v4 extension comprises several new
instructions: BPF_{SDIV,SMOD} (signed div and mod), BPF_{LD,LDX,ST,STX,MOV}
(sign-extended load/store/move), 32-bit BPF_JA (unconditional jump),
target-independent BPF_ALU64 BSWAP (byte-swapping 16/32/64). These have
been introduced in the following commits respectively:

* ec0e2da ("bpf: Support new signed div/mod instructions.")
* 1f9a1ea ("bpf: Support new sign-extension load insns")
* 8100928 ("bpf: Support new sign-extension mov insns")
* 4cd58e9 ("bpf: Support new 32bit offset jmp instruction")
* 0845c3d ("bpf: Support new unconditional bswap instruction")

Support in bpftool for previous ISA extensions were added in commit
0fd800b2 ("bpftool: Probe for instruction set extensions"). These probes
are useful for userspace BPF projects that want to use newer
instruction set extensions on newer kernels, to reduce the programs'
sizes or their complexity. LLVM provides the mcpu=v4 option since commit
"[BPF] support for BPF_ST instruction in codegen"
(https://github.com/llvm/llvm-project/commit/8f28e8069c4ba1110daee8bddc4d5049b6d4646e).

Changelog:

- v2:
  - moved BPF_JMP32_A macro after BPF_JMP_A in filter.h for consistency
    with include/linux/filter.h, noted by Quentin Monnet <qmo@kernel.org>

Signed-off-by: Simone Magnani <simone.magnani@isovalent.com>
---
 tools/bpf/bpftool/feature.c  | 23 +++++++++++++++++++++++
 tools/include/linux/filter.h | 10 ++++++++++
 2 files changed, 33 insertions(+)

diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index 4dbc4fcdf473..24fecdf8e430 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -885,6 +885,28 @@ probe_v3_isa_extension(const char *define_prefix, __u32 ifindex)
 			   "V3_ISA_EXTENSION");
 }

+/*
+ * Probe for the v4 instruction set extension introduced in commit 1f9a1ea821ff
+ * ("bpf: Support new sign-extension load insns").
+ */
+static void
+probe_v4_isa_extension(const char *define_prefix, __u32 ifindex)
+{
+	struct bpf_insn insns[5] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_JMP32_IMM(BPF_JEQ, BPF_REG_0, 1, 1),
+		BPF_JMP32_A(1),
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_EXIT_INSN()
+	};
+
+	probe_misc_feature(insns, ARRAY_SIZE(insns),
+			   define_prefix, ifindex,
+			   "have_v4_isa_extension",
+			   "ISA extension v4",
+			   "V4_ISA_EXTENSION");
+}
+
 static void
 section_system_config(enum probe_component target, const char *define_prefix)
 {
@@ -1029,6 +1051,7 @@ static void section_misc(const char *define_prefix, __u32 ifindex)
 	probe_bounded_loops(define_prefix, ifindex);
 	probe_v2_isa_extension(define_prefix, ifindex);
 	probe_v3_isa_extension(define_prefix, ifindex);
+	probe_v4_isa_extension(define_prefix, ifindex);
 	print_end_section();
 }

diff --git a/tools/include/linux/filter.h b/tools/include/linux/filter.h
index 65aa8ce142e5..bcc6df79301a 100644
--- a/tools/include/linux/filter.h
+++ b/tools/include/linux/filter.h
@@ -273,6 +273,16 @@
 		.off   = OFF,					\
 		.imm   = 0 })

+/* Unconditional jumps, gotol pc + imm32 */
+
+#define BPF_JMP32_A(IMM)					\
+	((struct bpf_insn) {					\
+		.code  = BPF_JMP32 | BPF_JA,			\
+		.dst_reg = 0,					\
+		.src_reg = 0,					\
+		.off   = 0,					\
+		.imm   = IMM })
+
 /* Function call */

 #define BPF_EMIT_CALL(FUNC)					\
--
2.43.0

Many thanks Quentin for the feedback!
Updated changelog in the commit message with v2, moving the macro after BPF_JMP_A.
Also, adding in cc other maintainers as you suggested.

