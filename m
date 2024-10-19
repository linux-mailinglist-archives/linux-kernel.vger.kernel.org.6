Return-Path: <linux-kernel+bounces-372508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C81B9A4994
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 00:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78CAD1C217F3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC7918FC9D;
	Fri, 18 Oct 2024 22:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t07qDKY/"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A8718D620
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 22:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729289820; cv=none; b=kTPxv1nELlBcLLBItblDc8ZS7velIzMUDV2PSkl/oPnGRKptpi7Ejj5X7Se/KG45640RpndvYxjnU+qo/lGK11iY1aCWPo5eQ6FrAjGey5Ayei7CxhLXJNTdN4XkcfHLvMArfVi8Jtp2dDbjhyW0PbVdTEXhwReXZQC0OzfgaWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729289820; c=relaxed/simple;
	bh=k3negLHR1r5xVSxRRbj5Yu6okyixeopjv4paYWc7B8Y=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=T4L76otc0NL+PYWh5a9pmBAhaJ64J8zrlmOnXPdc8stnvw4dIkH0d0CNk87lShPrMNHA9e+bfNYfe2d/7GwiyAZm4ddbdby+nHk+ALE77IPYwH7ZtT13W5cbpPyFsP644hp8YR5nI1mdNl913hhg2u6ZSvq4AA3UbbS8m/NvfuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t07qDKY/; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e29205f6063so3841945276.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 15:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729289818; x=1729894618; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=npXDHMSv/CnwNU6GVsVemHWtoPO/0w0MZGCZikvlWco=;
        b=t07qDKY/lMt2CGfeL42w3CXadqG6Jgbyt6IxrgRB1HIITcIoS/ERG5OTIhCmdw2Dq9
         pkQA1Lk3PUshIXunVdT9af0z7fQimsHkJnaWlRarCf4XQ5E1JwSsA+m+v1bFDJ458a/C
         MMn3lqRXJ8xMlWIxISUKrnus4KZGwa8g8pHw53F5qkVt5D/QhaOuOF/hQngR+bmF6x0I
         LupM74ik+3DV5Dx+WCPRBXje3o1NYwAMUciK7fcVzu8BS+3P7OJzlyStGZMknoXYYta9
         7WqGVLM6n9MPeV3HAYt//35Ib1J4rOM7SuJC87BqZbaWWxMmoYtSY0KO1bvevyvRD96w
         cvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729289818; x=1729894618;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=npXDHMSv/CnwNU6GVsVemHWtoPO/0w0MZGCZikvlWco=;
        b=s7Jn2dfxj8n2mAAbfq+2VIZzobPJ6dTWpVjaDGg+Tst+H2TJ8/qVHQJqZD+XZf6bej
         ZmNOe8L+hu5LKN+BIl/cv4L/eNsCIawkHJ8qjO1vko29fjhJYHuw/CjWpBCNW4F7rDbg
         ViliGe4qIAKOEdqFSDuS15eHU+64pPxxaIGhp+fvV8bU0iyugYSNbKQlKqmCccvsra/A
         Kb5BorG2ImDLOdXHZpBZvU5ufGDwm+PT087Jajo3AzsuPVZ81Pu6Xdkts0W7hwqfmpog
         p+rfRqenfo3oERs3hyWe8viSOLRfXJEIOg6Pi2dxjljN5mN1MCMQVT8I51AZYq9QRmeY
         Eghg==
X-Forwarded-Encrypted: i=1; AJvYcCWNPB2+zkAzc/dcGUQY22q4Xd1cZhaHlfk7yQLLwqkGUU0hqkBLfc0NrpokiDilwUnUVJIRkIaiZTy/Fa4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2yLZ34L52//cYltpv9YhM9jdCavcv2uz3U4Yq3MP1jFdcHuO0
	1kBm+XE8XhRLaW29kuSK4T2QlQr95dJBo3EmcRbQrMHAui9jIkQXZ4ETVv+6acZJCA==
X-Google-Smtp-Source: AGHT+IFHeCLo+UCtERsEqzbRLgjZenIz+8k2uno+X8uTWXAtOqF45NyQP3lRq9DEGuT5C41T1b8dP2k=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2d3:205:7e76:f201:fc01:a9c9])
 (user=pcc job=sendgmr) by 2002:a25:86cc:0:b0:e28:ee55:c3d with SMTP id
 3f1490d57ef6-e2bb11a8d59mr6530276.1.1729289817688; Fri, 18 Oct 2024 15:16:57
 -0700 (PDT)
Date: Fri, 18 Oct 2024 15:16:43 -0700
Message-Id: <20241018221644.3240898-1-pcc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH] bpf, arm64: Fix address emission with tag-based KASAN enabled
From: Peter Collingbourne <pcc@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay12@gmail.com>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Peter Collingbourne <pcc@google.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When BPF_TRAMP_F_CALL_ORIG is enabled, the address of a bpf_tramp_image
struct on the stack is passed during the size calculation pass and
an address on the heap is passed during code generation. This may
cause a heap buffer overflow if the heap address is tagged because
emit_a64_mov_i64() will emit longer code than it did during the size
calculation pass. The same problem could occur without tag-based
KASAN if one of the 16-bit words of the stack address happened to
be all-ones during the size calculation pass. Fix the problem by
assuming the worst case (4 instructions) when calculating the size
of the bpf_tramp_image address emission.

Fixes: 19d3c179a377 ("bpf, arm64: Fix trampoline for BPF_TRAMP_F_CALL_ORIG")
Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/I1496f2bc24fba7a1d492e16e2b94cf43714f2d3c
Cc: stable@vger.kernel.org
---
 arch/arm64/net/bpf_jit_comp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 8bbd0b20136a8..5db82bfc9dc11 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2220,7 +2220,11 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	emit(A64_STR64I(A64_R(20), A64_SP, regs_off + 8), ctx);
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		emit_a64_mov_i64(A64_R(0), (const u64)im, ctx);
+		/* for the first pass, assume the worst case */
+		if (!ctx->image)
+			ctx->idx += 4;
+		else
+			emit_a64_mov_i64(A64_R(0), (const u64)im, ctx);
 		emit_call((const u64)__bpf_tramp_enter, ctx);
 	}
 
@@ -2264,7 +2268,11 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		im->ip_epilogue = ctx->ro_image + ctx->idx;
-		emit_a64_mov_i64(A64_R(0), (const u64)im, ctx);
+		/* for the first pass, assume the worst case */
+		if (!ctx->image)
+			ctx->idx += 4;
+		else
+			emit_a64_mov_i64(A64_R(0), (const u64)im, ctx);
 		emit_call((const u64)__bpf_tramp_exit, ctx);
 	}
 
-- 
2.47.0.rc1.288.g06298d1525-goog


