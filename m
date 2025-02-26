Return-Path: <linux-kernel+bounces-533092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F76EA455AA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94A0F3AA55B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDD4268FE3;
	Wed, 26 Feb 2025 06:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iU0yd9Wj"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AFA1E502
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740551556; cv=none; b=lE+/0pa+W1UwtU7wqU1u7fcMmOdV3nnvQpTS/oflAOJRdX83G58fDLCiawIhMnG7pXCHgq+YeyZOBFkLlWhtjcSQeHzT3EY6ftWIqx7m39gzCYZd2GhYfMsGtxJuKK1iG01OreAU/l4jG/ph1WG2g22IH8HzccmO5C1ESJSq38k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740551556; c=relaxed/simple;
	bh=lgZ8JylI1sS39qvmCo0egec9M/xBN/1P8DIeRTMPV1s=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PiC48xffy9iIOWsF1vw05Z7xCnKCkCW9RP3B/zNbQNw3z+qpgeucLVyfVHU0vOVe/Eqo+U+kCCnXczbGY82HTgCO771hKNuEqBqThR/nmIWDNeqbrOUhDFGRw2ogt6ah1Fy8TYpOGJ1CGx/PxjuuxQh3EbrmWXInL7kcdJmH06Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=iU0yd9Wj; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fe82414cf7so675081a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740551554; x=1741156354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T2XeNxbHPPMmfxCJjw+vu4vYKA8Lsa9L2O6TiyKPYYk=;
        b=iU0yd9WjPYOFGUiwfc8FcZRkiqP1GN6SkcoNFCCrnfHLTXIOOKTmeTknWwLdW9PemE
         rg8JYaQb7TJvw3IsNtG7dcKQ6twTewv1igqdNce67lS/Znw0Zx2Fm73byN4j/SaNV+M6
         hSLKy2ekMBUac/THi+XZYYQwjgSE+WsXvktk37eHe6WF4evJu570dEmODC/yBZCujJh1
         P6ofFi1nH+jq5C7ataZHociV9DW7jYF9gFxfDvzZAaTMIeDNTu0BT+Il/Fj5LT/Vz2I0
         d828Laf/atsiwTUoYnWtoolDtjmfnGLACetCVThA6Ian8XHSpc3cR5Fjz3FmZDv/ltp+
         510Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740551554; x=1741156354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T2XeNxbHPPMmfxCJjw+vu4vYKA8Lsa9L2O6TiyKPYYk=;
        b=SSKyP/qOrA2LokTO7DGkXNhSkHz4VxLxVj8Tt/Pvj7eB6q4ua21jqu1vfAq194mG/A
         euL9Vn1/WzTm7n8lYYo1j8EVa834Pgh11sSpSgTi7+yM5wZgBkGdPquBeHHe9BfKXpgI
         RnevdkUH9aU1PlK3Xzh2AsY0TED53TbtfCiCHl3/oCXN33FEm/2sq/PODCkkEDVX92YL
         TV/GaYX9P4fhCcKDidsGpFuq3uqNV037fi+i1dj+VZl6lQNdvCGElrcpXBfJ95HoCuEU
         ikl11oFxWW5/BJ5d/nHLUUzL6dVqqvZ5jsbbXU0S8TcTHhkrWmxMr+6etaezLHZUKb2x
         niRg==
X-Forwarded-Encrypted: i=1; AJvYcCW6teLbjcEHGfCgDO1mti44NhFhBuJHXitAQYO2q48kIBjBTtR0cJDQ2D88j6lJwh5WZE4hRTHXnJi6eik=@vger.kernel.org
X-Gm-Message-State: AOJu0YweBtJIDjPjxed4IeNEuLH9TW5uJ7TP9MsoAA5cLgGSmQpe6For
	xVcUEdgmbj6rGuONSyVec1HAC2cj3ziQIIGdYqBZwt0Z9nBQAzdIuesSy/2pb/w=
X-Gm-Gg: ASbGnctCw1rPIgtUSgc+M+Xh6I9aBdbuca8OTS1Iq52eVyEDE0wd7NrUWtICr8WvQnT
	cayWgEr6G8VuhSEObU0QU9Oywrhgbz3tv4HKCwhIxK6B++g/P3OPA5irJaZrohkIzlwx0uMoQRE
	CqMgvUkh7LFcYi1RGl3R1vhvn0OLab1TyhvFONop2p7OW4oXWFsLepbHo9wgGpXKmyMe9wOSmu5
	1R0HUTcSAwI3PtCBYbOM/V3/MOgwmmjU7RBe497kENvuhvsBN1iic62tWmVh+C02P95oqdGqFpV
	nvI2FLHBOI93PQPnzZVBoUD6o8LEu29fRzIE6T2HoQdKMf/76A+EmN6wk534
X-Google-Smtp-Source: AGHT+IHwvV7I7NlJ9jqPsn3374kntVoW/0IqCvSXn/+vGzdzMVefrgZflgML33Q88VI8BAdqqvkLhA==
X-Received: by 2002:a17:90b:2e08:b0:2f5:88bb:12f with SMTP id 98e67ed59e1d1-2fe68ae74ebmr8882080a91.21.1740551554107;
        Tue, 25 Feb 2025 22:32:34 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe8284f152sm682599a91.46.2025.02.25.22.32.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Feb 2025 22:32:33 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: ajones@ventanamicro.com,
	alexghiti@rivosinc.com,
	andybnac@gmail.com,
	aou@eecs.berkeley.edu,
	charlie@rivosinc.com,
	cleger@rivosinc.com,
	conor.dooley@microchip.com,
	conor@kernel.org,
	corbet@lwn.net,
	cuiyunhui@bytedance.com,
	evan@rivosinc.com,
	jesse@rivosinc.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	samuel.holland@sifive.com,
	shuah@kernel.org
Subject: [PATCH v7 2/3] RISC-V: hwprobe: Expose Zicbom extension and its block size
Date: Wed, 26 Feb 2025 14:32:05 +0800
Message-Id: <20250226063206.71216-3-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250226063206.71216-1-cuiyunhui@bytedance.com>
References: <20250226063206.71216-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose Zicbom through hwprobe and also provide a key to extract its
respective block size.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 Documentation/arch/riscv/hwprobe.rst  | 6 ++++++
 arch/riscv/include/asm/hwprobe.h      | 2 +-
 arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
 arch/riscv/kernel/sys_hwprobe.c       | 8 +++++++-
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index f273ea15a8e8..d91e39e19ea0 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -242,6 +242,9 @@ The following keys are defined:
   * :c:macro:`RISCV_HWPROBE_EXT_SUPM`: The Supm extension is supported as
        defined in version 1.0 of the RISC-V Pointer Masking extensions.
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZICBOM`: The Zicbom extension is supported, as
+       ratified in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
+
 * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: Deprecated.  Returns similar values to
      :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_SCALAR_PERF`, but the key was
      mistakenly classified as a bitmask rather than a value.
@@ -303,3 +306,6 @@ The following keys are defined:
     * :c:macro:`RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR`: The xtheadvector vendor
         extension is supported in the T-Head ISA extensions spec starting from
 	commit a18c801634 ("Add T-Head VECTOR vendor extension. ").
+
+* :c:macro:`RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE`: An unsigned int which
+  represents the size of the Zicbom block in bytes.
diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
index dd624523981c..1f690fea0e03 100644
--- a/arch/riscv/include/asm/hwprobe.h
+++ b/arch/riscv/include/asm/hwprobe.h
@@ -8,7 +8,7 @@
 
 #include <uapi/asm/hwprobe.h>
 
-#define RISCV_HWPROBE_MAX_KEY 11
+#define RISCV_HWPROBE_MAX_KEY 12
 
 static inline bool riscv_hwprobe_key_is_valid(__s64 key)
 {
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index c3c1cc951cb9..8c706cde3777 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -73,6 +73,7 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 47)
 #define		RISCV_HWPROBE_EXT_ZAWRS		(1ULL << 48)
 #define		RISCV_HWPROBE_EXT_SUPM		(1ULL << 49)
+#define		RISCV_HWPROBE_EXT_ZICBOM	(1ULL << 50)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
@@ -95,6 +96,7 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_MISALIGNED_VECTOR_FAST		3
 #define		RISCV_HWPROBE_MISALIGNED_VECTOR_UNSUPPORTED	4
 #define RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0	11
+#define RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE	12
 /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
 
 /* Flags */
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 04a4e5495512..69fe9da320dc 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -107,6 +107,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZCA);
 		EXT_KEY(ZCB);
 		EXT_KEY(ZCMOP);
+		EXT_KEY(ZICBOM);
 		EXT_KEY(ZICBOZ);
 		EXT_KEY(ZICOND);
 		EXT_KEY(ZIHINTNTL);
@@ -161,7 +162,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 	pair->value &= ~missing;
 }
 
-static bool hwprobe_ext0_has(const struct cpumask *cpus, unsigned long ext)
+static bool hwprobe_ext0_has(const struct cpumask *cpus, u64 ext)
 {
 	struct riscv_hwprobe pair;
 
@@ -279,6 +280,11 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
 		if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOZ))
 			pair->value = riscv_cboz_block_size;
 		break;
+	case RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE:
+		pair->value = 0;
+		if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOM))
+			pair->value = riscv_cbom_block_size;
+		break;
 	case RISCV_HWPROBE_KEY_HIGHEST_VIRT_ADDRESS:
 		pair->value = user_max_virt_addr();
 		break;
-- 
2.39.2


