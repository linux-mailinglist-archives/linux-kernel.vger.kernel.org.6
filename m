Return-Path: <linux-kernel+bounces-187421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE75A8CD18B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CF60B21E56
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CCB13BC15;
	Thu, 23 May 2024 11:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ldRzBvOO"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0ED13BC0C
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 11:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716465100; cv=none; b=ldt3TZuu0bImD+4TKiNacDmbO7GdTkKjNT+7ni1tBQXhK9mCQn3Nbh50cl5IpOz1OqjuD+hXIgjZp2mUuCUfLBOjwViOxiuLhl9+pTQpYyV8EXp7Os8xCOlmwO0+6UJR57gsPI2O9UaVPSYPpomOHcWrJXJxi9Ie/MeVzc9vWzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716465100; c=relaxed/simple;
	bh=g8C5XN3fHUDfWkVvbozC29jrfrsP8txwTiSzj5n44vQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=dw8sxahudX7B5fAdWOAOHoffp9AFbGa9jBmKbJ2SCDTJmQBrk4ujQjc/yVpFsiJ1Pk4nSLlAHYkae7nX01jp/lD024XvYNPfsnJNE5iqh/ipDJXQpS2Q8rWq9nilu40p95rWy1rb0ZBNtzWCMgYBqvj5g0Tr4YaMNlPMqWY4CF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ldRzBvOO; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-354f69934feso490995f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 04:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716465096; x=1717069896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tomuose927MUcTT3sGm0eYQ4ZHc9XHuBgI6ykSWqNcI=;
        b=ldRzBvOOyhLWZB5cN+Mc1fYrzAAfcIFBtYE8H2WURHrSTqL/fGzKNajnh9DiGfO/JL
         H+Tyau9BrFjNv1zc2gKrUCsLAqk3t1cMg1KN0+7vdssta0qAC6i3yP1N+RVwxU3hEHVX
         zsIpL1pTEYWywVQNjJ2liCN/TPSor/yMFpODh25/k8HOIqKKVfn4m8WAK5vVPbwmnEA8
         RO3ACFuuOljt2SYpSdRlm+sSqWuST1v27Xs/g936TkKJDNJi7WENH0Q8NzS19TF1Uboe
         PQF1J/dsxnEzl4upJ1mgCa8jiO9U4I3JxS9W2IPFv9X1K//R/VMhRb8C6pKMJN1rtoqJ
         xAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716465096; x=1717069896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tomuose927MUcTT3sGm0eYQ4ZHc9XHuBgI6ykSWqNcI=;
        b=USexjasS/m76grH7Yuzjw3UBKIq0Pv2bjqTQFsIeEzCRNyxMV0Wb+ITy6PDfvYKz7i
         3nwEmpVOqGqmmCvlh4YrrVoQ/UwolD7+7QY1qUXIA9LcgmTVxH6GDvhgPtSrE/6MwnEk
         A3df3Z1x0ExEM71OYJBoizCkWzqlkqpI6yoC9lyVThVJED/QPvTPAwNV8qdVFLU3ge8D
         Jug9Jo+BlNyr7tIrv/gAjajF78XAzQ4E1IORockfF2zm6A/hVIGxaW0qOc6g4AlJus92
         vK4Ea/CGm0++OZz2gfd4Nxhn8s9y3g4q5SNwu1FQY/5JGRIEa9zWlMBLtOfYkmLQa+9c
         2Ibg==
X-Forwarded-Encrypted: i=1; AJvYcCX3HS+bbhjJ69UWTJM8ane5KNYB7SBP2KpglB8K5ijhRdUgBXdOQCUlB4KT56uqm8XuSgbT04faic8bQbjD1Yz8YEKMuzA8gIsFWJht
X-Gm-Message-State: AOJu0Yx2fYgKevB98mbCYhjCP5mi5jZSza9hDi8EnQEXOsbuW2rFz/wz
	dvmtcSsTRv9JAEcdz9V0KA5elpcpaPAHpEsHrm6fnXAmZU2QRE3ukWvtlDAbQXY=
X-Google-Smtp-Source: AGHT+IFe90bcCCk3DsNh1uSEukvSAXaPs6XHlXPOkfTOcX5gFcR6LlB//XRU3ng08XrqXVcAz3+1YQ==
X-Received: by 2002:adf:fd04:0:b0:34d:ce05:29ef with SMTP id ffacd0b85a97d-354f75216eamr2192712f8f.17.1716465096610;
        Thu, 23 May 2024 04:51:36 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-354e03420b4sm3414511f8f.24.2024.05.23.04.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 04:51:36 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrea Parri <parri.andrea@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] riscv: Fix early ftrace nop patching
Date: Thu, 23 May 2024 13:51:34 +0200
Message-Id: <20240523115134.70380-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit c97bf629963e ("riscv: Fix text patching when IPI are used")
converted ftrace_make_nop() to use patch_insn_write() which does not
emit any icache flush relying entirely on __ftrace_modify_code() to do
that.

But we missed that ftrace_make_nop() was called very early directly when
converting mcount calls into nops (actually on riscv it converts 2B nops
emitted by the compiler into 4B nops).

This caused crashes on multiple HW as reported by Conor and Björn since
the booting core could have half-patched instructions in its icache
which would trigger an illegal instruction trap: fix this by emitting a
local flush icache when early patching nops.

Fixes: c97bf629963e ("riscv: Fix text patching when IPI are used")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/cacheflush.h | 6 ++++++
 arch/riscv/kernel/ftrace.c          | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
index dd8d07146116..ce79c558a4c8 100644
--- a/arch/riscv/include/asm/cacheflush.h
+++ b/arch/riscv/include/asm/cacheflush.h
@@ -13,6 +13,12 @@ static inline void local_flush_icache_all(void)
 	asm volatile ("fence.i" ::: "memory");
 }
 
+static inline void local_flush_icache_range(unsigned long start,
+					    unsigned long end)
+{
+	local_flush_icache_all();
+}
+
 #define PG_dcache_clean PG_arch_1
 
 static inline void flush_dcache_folio(struct folio *folio)
diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 4f4987a6d83d..32e7c401dfb4 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -120,6 +120,9 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
 	out = ftrace_make_nop(mod, rec, MCOUNT_ADDR);
 	mutex_unlock(&text_mutex);
 
+	if (!mod)
+		local_flush_icache_range(rec->ip, rec->ip + MCOUNT_INSN_SIZE);
+
 	return out;
 }
 
-- 
2.39.2


