Return-Path: <linux-kernel+bounces-543013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CD4A4D07F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F5DE3AC979
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A510C132111;
	Tue,  4 Mar 2025 01:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W/HVFVc4"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBB578F59
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 01:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741050385; cv=none; b=gVEPumQyimDdd0tz3+7KuDtf1iyu6TwEHz35HWlsI0XiDeQSx9QdUTKkDp3qBi04l89DCBBIUX7smdgjkp/IfVa8eIsFI/K9NHd17eAGozO+7SJriN4Hv0+GVOMA+v8VROJN9WXXFhAA5NZf+MiJO94yRHk9LKkZR3r8U1jzqAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741050385; c=relaxed/simple;
	bh=WaoyZuEwsQ2p34OHEBdLIzMV0xIL1iFyXsJfdPLGXbA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QPMWrJGL/b92lNC3kjxR9JGlQgXKZhAlr+ph0W0yVKagqneQFCjGvX1plXX2BSkYCrN3O9u+OdqNFp2o2jq5X+BshZjuofjflmy3kPPFVodq4nmg1YfHoex5o1SJRJaIrW1kHkidZDBY2FFiK0BJ1RugMHidbkybuO8gK95N63Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W/HVFVc4; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fea1685337so9026185a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 17:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741050383; x=1741655183; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xDRlPmyHtUNZ0yOQY1bkQ2kEbwvsRJ/+HMV3GdLKk6A=;
        b=W/HVFVc4OiDjMlqYsaYWETGSPZoxtNMKPvtESSCUvuxtUrQZDteBbbHYKbGYYfLUV0
         dvmfNd94nY6gm7oEl/MLdA5x/Qm9fcXvKYWwFj61pcPeCaWUENjHHT3br2v4t37Btbnb
         XDo98D4UaLGZ2Y7RWun7RfPOFDU7VLSZmkqxEXl88d0Qz66eg36/s7WRYNtF20tvYfFS
         znsERmxoUqCmMphTKxx3jVczY/THqVV38PMNVyOxXbyB3BAA5RKmvGA4wxJ2OxFe/oR8
         9hm7Yd5Ki7z7m0Iuj/sIcD3M+bxhlPfZEfemMCGmhHhnEmg5XvzhIw1GhXdPs6advAdv
         7EYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741050383; x=1741655183;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xDRlPmyHtUNZ0yOQY1bkQ2kEbwvsRJ/+HMV3GdLKk6A=;
        b=ECtKgRk3QoXyXg8c2+pAwpCcv1XwkbHe3e62YUqF23ftaioy7I2xH+PGO2CSe21udP
         oRy8pcVCVYniYBdeCcTJbApQLatg3vbUswGC++Xdv85mGJaJ+/stUgetl78wZL37wHPN
         W0E1UeMmRoOzQIhuJjTnWk7PGC07/L3+iqo9c90kezhdljXvSMH4VnvjQZxkLdNF1xCg
         uB7b9x6gJbdatN8a9LGJEILnsZ0tGGJLrxh+KAwqsyjzbQwdjm1AfG7XEUCQt1e+26sg
         R7cXQNURW2Ube++UGsG8fRMEqoWUJj279aL1jUKrjgS0UA/tFUqrXxxTQ4KB63WUbnca
         oGuQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7hzirE9lMXIHysBg+LdbIPUmLEa1yWdDOLNkOj9jnUjpJ6vJYuG+dzYLHRpiT1YDMNnz9iLWuAIxKgBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzbvYOgl4pZHTDlZjb1EboUHSQMFddLTSknuOBm2IWTUyBsWpl
	Zxv9+m+pmQzcFmjaIo/J/v9T40++VCXZpR5BDBFymBmwgEN2ffNY8s8F3CnYQpRVjeRFZhxKZH1
	2ogcL0+JFxQ==
X-Google-Smtp-Source: AGHT+IE/HHlRwMe209CIsa1KC/8Ic0b8hg5Keco1IR+qIcNxW9u+r/PDsuoGYYvMBQpxrGmOC6gLsHe+b7OQUQ==
X-Received: from pgc20.prod.google.com ([2002:a05:6a02:2f94:b0:af2:45cb:9881])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:d8b:b0:1f0:e2b9:d163 with SMTP id adf61e73a8af0-1f339156896mr2073126637.12.1741050382873;
 Mon, 03 Mar 2025 17:06:22 -0800 (PST)
Date: Tue,  4 Mar 2025 01:06:19 +0000
In-Reply-To: <cover.1741049567.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1741049567.git.yepeilin@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <5a4d2a52b2cc022bf86d0b572789f0b3bc3d5162.1741049567.git.yepeilin@google.com>
Subject: [PATCH bpf-next v6 2/6] arm64: insn: Add BIT(23) to {load,store}_ex's mask
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

We are planning to add load-acquire (LDAR{,B,H}) and store-release
(STLR{,B,H}) instructions to insn.{c,h}; add BIT(23) to mask of load_ex
and store_ex to prevent aarch64_insn_is_{load,store}_ex() from returning
false-positives for load-acquire and store-release instructions.

Reference: Arm Architecture Reference Manual (ARM DDI 0487K.a,
           ID032224),

  * C6.2.228 LDXR
  * C6.2.165 LDAXR
  * C6.2.161 LDAR
  * C6.2.393 STXR
  * C6.2.360 STLXR
  * C6.2.353 STLR

Acked-by: Xu Kuohai <xukuohai@huawei.com>
Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 arch/arm64/include/asm/insn.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index e390c432f546..2d8316b3abaf 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -351,8 +351,8 @@ __AARCH64_INSN_FUNCS(ldr_imm,	0x3FC00000, 0x39400000)
 __AARCH64_INSN_FUNCS(ldr_lit,	0xBF000000, 0x18000000)
 __AARCH64_INSN_FUNCS(ldrsw_lit,	0xFF000000, 0x98000000)
 __AARCH64_INSN_FUNCS(exclusive,	0x3F800000, 0x08000000)
-__AARCH64_INSN_FUNCS(load_ex,	0x3F400000, 0x08400000)
-__AARCH64_INSN_FUNCS(store_ex,	0x3F400000, 0x08000000)
+__AARCH64_INSN_FUNCS(load_ex,	0x3FC00000, 0x08400000)
+__AARCH64_INSN_FUNCS(store_ex,	0x3FC00000, 0x08000000)
 __AARCH64_INSN_FUNCS(mops,	0x3B200C00, 0x19000400)
 __AARCH64_INSN_FUNCS(stp,	0x7FC00000, 0x29000000)
 __AARCH64_INSN_FUNCS(ldp,	0x7FC00000, 0x29400000)
-- 
2.48.1.711.g2feabab25a-goog


